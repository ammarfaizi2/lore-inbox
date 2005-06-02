Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVFBTpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVFBTpX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 15:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVFBTpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 15:45:23 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:5527 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261263AbVFBTgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 15:36:49 -0400
Message-Id: <200506021936.j52Ja1e1017579@ms-smtp-02-eri0.texas.rr.com>
From: ericvh@gmail.com
Date: Thu,  2 Jun 2005 14:35:57 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 4/7] v9fs: VFS superblock operations and glue (2.0-rc7)
Cc: v9fs-developer@lists.sourceforge.net,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part [4/7] of the v9fs-2.0-rc7 patch against Linux 2.6.

This part of the patch contains VFS superblock and mapping code.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

 ----------

 v9fs.c      |  412 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 v9fs.h      |   84 ++++++++++++
 v9fs_vfs.h  |   51 +++++++
 vfs_super.c |  257 +++++++++++++++++++++++++++++++++++++
 4 files changed, 804 insertions(+)

 ----------

Index: fs/9p/v9fs.h
===================================================================
--- /dev/null  (tree:3c5e9440c6a37c3355b50608836a23c8fa4eec99)
+++ 7d6ca5270f0ecf9306a944a3d39897a97dc9f67f/fs/9p/v9fs.h  (mode:100644)
@@ -0,0 +1,84 @@
+/*
+ * V9FS definitions.
+ *
+ *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
+ *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+/*
+  * Session structure provides information for an opened session
+  *
+  */
+
+struct v9fs_session_info {
+	/* options */
+	unsigned int maxdata;
+	unsigned char extended;	/* set to 1 if we are using UNIX extensions */
+	unsigned char nodev;	/* set to 1 if no disable device mapping */
+	unsigned short port;	/* port to connect to */
+	unsigned short debug;	/* debug level */
+	unsigned short proto;	/* protocol to use */
+	unsigned int afid;	/* authentication fid */
+
+	char *name;		/* user name to mount as */
+	char *remotename;	/* name of remote hierarchy being mounted */
+	unsigned int uid;	/* default uid/muid for legacy support */
+	unsigned int gid;	/* default gid for legacy support */
+
+	/* book keeping */
+	struct idpool fidpool;	/* The FID pool for file descriptors */
+	struct idpool tidpool;	/* The TID pool for transactions ids */
+
+	/* transport information */
+	struct v9fs_transport *transport;
+
+	int inprogress;		/* session in progress => true */
+	int shutdown;		/* session shutting down. no more attaches. */
+	unsigned long session_hung;
+
+	/* mux private data */
+	struct v9fs_fcall *curfcall;
+	wait_queue_head_t read_wait;
+	struct completion fcread;
+	struct completion proccmpl;
+	struct task_struct *recvproc;
+
+	spinlock_t muxlock;
+	struct list_head mux_fcalls;
+};
+
+int v9fs_session_init(struct v9fs_session_info *, const char *, char *);
+struct v9fs_session_info *v9fs_inode2v9ses(struct inode *);
+void v9fs_session_close(struct v9fs_session_info *v9ses);
+
+int v9fs_get_option(char *opts, char *name, char *buf, int buflen);
+long long v9fs_get_int_option(char *opts, char *name, long long dflt);
+int v9fs_parse_tcp_devname(const char *devname, char **addr, char **remotename);
+
+#define V9FS_MAGIC 0x01021997
+
+/* other default globals */
+#define V9FS_PORT		564
+#define V9FS_DEFUSER	"nobody"
+#define V9FS_DEFANAME	""
+
+/* inital pool sizes for fids and tags */
+#define V9FS_START_FIDS 8192
+#define V9FS_START_TIDS 256
+
+#define safe_cache_free(x, y) { if(y) kmem_cache_free(x, y); }
Index: fs/9p/v9fs.c
===================================================================
--- /dev/null  (tree:3c5e9440c6a37c3355b50608836a23c8fa4eec99)
+++ 7d6ca5270f0ecf9306a944a3d39897a97dc9f67f/fs/9p/v9fs.c  (mode:100644)
@@ -0,0 +1,412 @@
+/*
+ *  linux/fs/9p/v9fs.c
+ *
+ *  This file contains functions assisting in mapping VFS to 9P2000
+ *
+ *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
+ *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/parser.h>
+
+#include "debug.h"
+#include "idpool.h"
+#include "v9fs.h"
+#include "9p.h"
+#include "v9fs_vfs.h"
+#include "transport.h"
+#include "mux.h"
+#include "conv.h"
+
+/* TODO: sysfs or debugfs interface */
+int v9fs_debug_level = 0;	/* feature-rific global debug level  */
+
+/*
+  * Option Parsing (code inspired by NFS code)
+  *
+  */
+
+enum {
+	PROTO_TCP,
+	PROTO_UNIX,
+};
+
+enum {
+	/* Options that take integer arguments */
+	Opt_port, Opt_msize, Opt_uid, Opt_gid, Opt_afid, Opt_debug,
+	/* String options */
+	Opt_name, Opt_remotename,
+	/* Options that take no arguments */
+	Opt_legacy, Opt_nodevmap, Opt_unix, Opt_tcp,
+	/* Error token */
+	Opt_err
+};
+
+static match_table_t tokens = {
+	{Opt_port, "port=%u"},
+	{Opt_msize, "msize=%u"},
+	{Opt_uid, "uid=%u"},
+	{Opt_gid, "gid=%u"},
+	{Opt_afid, "afid=%u"},
+	{Opt_debug, "debug=%u"},
+	{Opt_name, "name=%s"},
+	{Opt_remotename, "aname=%s"},
+	{Opt_unix, "proto=unix"},
+	{Opt_tcp, "proto=tcp"},
+	{Opt_tcp, "tcp"},
+	{Opt_unix, "unix"},
+	{Opt_legacy, "noextend"},
+	{Opt_nodevmap, "nodevmap"},
+	{Opt_err, NULL}
+};
+
+/*
+ *  Parse option string.
+ */
+
+/**
+ * v9fs_parse_options - parse mount options into session structure
+ * @options: options string passed from mount
+ * @v9ses: existing v9fs session information
+ *
+ */
+
+static void v9fs_parse_options(char *options, struct v9fs_session_info *v9ses)
+{
+	char *p;
+	substring_t args[MAX_OPT_ARGS];
+	int option;
+	int ret;
+
+	/* setup defaults */
+	v9ses->port = V9FS_PORT;
+	v9ses->maxdata = 9000;
+	v9ses->proto = PROTO_TCP;
+	v9ses->extended = 1;
+	v9ses->afid = ~0;
+	v9ses->debug = 0;
+
+	if (!options)
+		return;
+
+	while ((p = strsep(&options, ",")) != NULL) {
+		int token;
+		if (!*p)
+			continue;
+		token = match_token(p, tokens, args);
+		if (token < Opt_name) {
+			if ((ret = match_int(&args[0], &option)) < 0) {
+				dprintk(DEBUG_ERROR,
+					"integer field, but no integer?\n");
+				continue;
+			}
+
+		}
+		switch (token) {
+		case Opt_port:
+			v9ses->port = option;
+			break;
+		case Opt_msize:
+			v9ses->maxdata = option;
+			break;
+		case Opt_uid:
+			v9ses->uid = option;
+			break;
+		case Opt_gid:
+			v9ses->gid = option;
+			break;
+		case Opt_afid:
+			v9ses->afid = option;
+			break;
+		case Opt_debug:
+			v9ses->debug = option;
+			break;
+		case Opt_tcp:
+			v9ses->proto = PROTO_TCP;
+			break;
+		case Opt_unix:
+			v9ses->proto = PROTO_UNIX;
+			break;
+		case Opt_name:
+			match_strcpy(v9ses->name,&args[0]);
+			break;
+		case Opt_remotename:
+			match_strcpy(v9ses->remotename,&args[0]);
+			break;
+		case Opt_legacy:
+			v9ses->extended = 0;
+			break;
+		case Opt_nodevmap:
+			v9ses->nodev = 1;
+			break;
+		default:
+			continue;
+		}
+	}
+
+	dprintk(DEBUG_9P, "options=\n");
+	dprintk(DEBUG_9P, "	debug: %x\n", v9ses->debug);
+	dprintk(DEBUG_9P, "	port: %u\n", v9ses->port);
+	dprintk(DEBUG_9P, "	msize: %u\n", v9ses->maxdata);
+	dprintk(DEBUG_9P, "	uid: %u\n", v9ses->uid);
+	dprintk(DEBUG_9P, "	gid: %u\n", v9ses->gid);
+	dprintk(DEBUG_9P, "	afid: %d\n", v9ses->afid);
+	dprintk(DEBUG_9P, "	proto: %u\n", v9ses->proto);
+	dprintk(DEBUG_9P, "	extended: %u\n", v9ses->extended);
+	dprintk(DEBUG_9P, "	nomapdev: %u\n", v9ses->nodev);
+	dprintk(DEBUG_9P, "	name: %s\n", v9ses->name);
+	dprintk(DEBUG_9P, "	remotename: %s\n", v9ses->remotename);
+}
+
+/**
+ * v9fs_inode2v9ses - safely extract v9fs session info from super block
+ * @inode: inode to extract information from
+ *
+ * Paranoid function to extract v9ses information from superblock,
+ * if anything is missing it will report an error.
+ *
+ */
+
+struct v9fs_session_info *v9fs_inode2v9ses(struct inode *inode)
+{
+	if (inode) {
+		if (inode->i_sb) {
+			if (inode->i_sb->s_fs_info)
+				return (inode->i_sb->s_fs_info);
+			else {
+				dprintk(DEBUG_ERROR, "no s_fs_info\n");
+				return NULL;
+			}
+		} else {
+			dprintk(DEBUG_ERROR, "no superblock\n");
+			return NULL;
+		}
+	}
+	dprintk(DEBUG_ERROR, "no inode\n");
+	return NULL;
+}
+
+/**
+ * v9fs_session_init - initialize session
+ * @v9ses: session information structure
+ * @dev_name: device being mounted
+ * @data: options
+ *
+ */
+
+int
+v9fs_session_init(struct v9fs_session_info *v9ses,
+		  const char *dev_name, char *data)
+{
+	struct v9fs_fcall *fcall = NULL;
+	struct v9fs_transport *trans_proto;
+	int n = 0;
+	int newfid = -1;
+	int retval = -EINVAL;
+
+	v9ses->name = __getname();
+	if(!v9ses->name)
+		return -ENOMEM;
+
+	v9ses->remotename = __getname();
+	if(!v9ses->remotename) {
+		putname(v9ses->name);
+		return -ENOMEM;
+	}
+
+	strcpy(v9ses->name, V9FS_DEFUSER);
+	strcpy(v9ses->remotename, V9FS_DEFANAME);
+
+	v9fs_parse_options(data, v9ses);
+
+	/* set global debug level */
+	v9fs_debug_level = v9ses->debug;
+
+	/* id pools that are session-dependent: FIDs and TIDs */
+	v9fs_alloc_idpool(&v9ses->fidpool, V9FS_START_FIDS);
+	v9fs_alloc_idpool(&v9ses->tidpool, V9FS_START_TIDS);
+
+	switch (v9ses->proto) {
+	case PROTO_TCP:
+		trans_proto = &v9fs_trans_tcp;
+		break;
+	case PROTO_UNIX:
+		trans_proto = &v9fs_trans_unix;
+		*v9ses->remotename = 0;
+		break;
+	default:
+		printk(KERN_ERR "v9fs: Bad mount protocol %d\n", v9ses->proto);
+		retval = -ENOPROTOOPT;
+		goto SessCleanUp;
+	};
+
+	v9ses->transport = kmalloc(sizeof(struct v9fs_transport), GFP_KERNEL);
+	if (!v9ses->transport) {
+		eprintk(KERN_WARNING,
+			"Couldn't allocate string for transport struct\n");
+		retval = -ENOMEM;
+		goto SessCleanUp;
+	}
+
+	memcpy(v9ses->transport, trans_proto, sizeof(struct v9fs_transport));
+
+	if ((retval = v9ses->transport->init(v9ses, dev_name, data)) < 0) {
+		eprintk(KERN_ERR, "problem initializing transport\n");
+		goto SessCleanUp;
+	}
+
+	v9ses->inprogress = 0;
+	v9ses->shutdown = 0;
+	v9ses->session_hung = 0;
+
+	if ((retval = v9fs_mux_init(v9ses, dev_name)) < 0) {
+		dprintk(DEBUG_ERROR, "problem initializing mux\n");
+		goto SessCleanUp;
+	}
+
+	if (v9ses->afid == ~0) {
+		if (v9ses->extended)
+			retval =
+			    v9fs_t_version(v9ses, v9ses->maxdata, "9P2000.u",
+					   &fcall);
+		else
+			retval = v9fs_t_version(v9ses, v9ses->maxdata, "9P2000",
+						&fcall);
+
+		if (retval < 0) {
+			dprintk(DEBUG_ERROR, "v9fs_t_version failed\n");
+			goto FreeFcall;
+		}
+
+		/* Really should check for 9P1 and report error */
+		if (!strcmp(fcall->params.rversion.version, "9P2000.u")) {
+			dprintk(DEBUG_9P, "9P2000 UNIX extensions enabled\n");
+			v9ses->extended = 1;
+		} else {
+			dprintk(DEBUG_9P, "9P2000 legacy mode enabled\n");
+			v9ses->extended = 0;
+		}
+
+		n = fcall->params.rversion.msize;
+		kfree( fcall);
+
+		if (n < v9ses->maxdata) 
+			v9ses->maxdata = n;
+	}
+
+	newfid = v9fs_get_idpool(&v9ses->fidpool);
+	if (newfid < 0) {
+		eprintk(KERN_WARNING, "couldn't allocate FID\n");
+		retval = -ENOMEM;
+		goto SessCleanUp;
+	}
+	/* it is a little bit ugly, but we have to prevent newfid */
+	/* being the same as afid, so if it is, get a new fid     */
+	if (v9ses->afid != ~0 && newfid == v9ses->afid) {
+		newfid = v9fs_get_idpool(&v9ses->fidpool);
+		if (newfid < 0) {
+			eprintk(KERN_WARNING, "couldn't allocate FID\n");
+			retval = -ENOMEM;
+			goto SessCleanUp;
+		}
+	}
+
+	if ((retval =
+	     v9fs_t_attach(v9ses, v9ses->name, v9ses->remotename, newfid,
+			   v9ses->afid, NULL))
+	    < 0) {
+		dprintk(DEBUG_ERROR, "cannot attach\n");
+		goto SessCleanUp;
+	}
+
+	if (v9ses->afid != ~0) {
+		if (v9fs_t_clunk(v9ses, v9ses->afid, NULL))
+			dprintk(DEBUG_ERROR, "clunk failed\n");
+	}
+
+	return newfid;
+
+      FreeFcall:
+	kfree( fcall);
+
+      SessCleanUp:
+	v9fs_session_close(v9ses);
+	return retval;
+}
+
+/**
+ * v9fs_session_close - shutdown a session
+ * @v9ses: session information structure
+ *
+ */
+
+void v9fs_session_close(struct v9fs_session_info *v9ses)
+{
+	if (v9ses->recvproc) {
+		send_sig(SIGKILL, v9ses->recvproc, 1);
+		wait_for_completion(&v9ses->proccmpl);
+	}
+
+	if (v9ses->transport) {
+		v9ses->transport->close(v9ses->transport);
+		kfree(v9ses->transport);
+	}
+
+	putname(v9ses->name);
+	putname(v9ses->remotename);
+
+	v9fs_free_idpool(&v9ses->fidpool);
+	v9fs_free_idpool(&v9ses->tidpool);
+}
+
+extern int v9fs_error_init(void);
+
+/**
+ * v9fs_init - Initialize module
+ *
+ */
+
+static int __init init_v9fs(void)
+{
+	v9fs_error_init();
+
+	printk(KERN_INFO "Installing v9fs 9P2000 file system support\n");
+
+	return register_filesystem(&v9fs_fs_type);
+}
+
+/**
+ * v9fs_init - shutdown module
+ *
+ */
+
+static void __exit exit_v9fs(void)
+{
+	unregister_filesystem(&v9fs_fs_type);
+}
+
+module_init(init_v9fs)
+module_exit(exit_v9fs)
+
+MODULE_AUTHOR("Eric Van Hensbergen <ericvh@gmail.com>");
+MODULE_AUTHOR("Ron Minnich <rminnich@lanl.gov>");
+MODULE_LICENSE("GPL");
Index: fs/9p/v9fs_vfs.h
===================================================================
--- /dev/null  (tree:3c5e9440c6a37c3355b50608836a23c8fa4eec99)
+++ 7d6ca5270f0ecf9306a944a3d39897a97dc9f67f/fs/9p/v9fs_vfs.h  (mode:100644)
@@ -0,0 +1,51 @@
+/*
+ * V9FS VFS extensions.
+ *
+ *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
+ *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+/* plan9 semantics are that created files are implicitly opened.
+ * But linux semantics are that you call create, then open.
+ * the plan9 approach is superior as it provides an atomic 
+ * open. 
+ * we track the create fid here. When the file is opened, if fidopen is
+ * non-zero, we use the fid and can skip some steps. 
+ * there may be a better way to do this, but I don't know it. 
+ * one BAD way is to clunk the fid on create, then open it again:
+ * you lose the atomicity of file open
+ */
+
+/* special case: 
+ * unlink calls remove, which is an implicit clunk. So we have to track
+ * that kind of thing so that we don't try to clunk a dead fid. 
+ */
+
+extern struct file_system_type v9fs_fs_type;
+extern struct file_operations v9fs_file_operations;
+extern struct file_operations v9fs_dir_operations;
+extern struct dentry_operations v9fs_dentry_operations;
+
+struct inode *v9fs_get_inode(struct super_block *sb, int mode);
+ino_t v9fs_qid2ino(struct v9fs_qid *qid);
+void v9fs_mistat2inode(struct v9fs_stat *, struct inode *,
+		       struct super_block *);
+int v9fs_dir_release(struct inode *inode, struct file *filp);
+int v9fs_file_open(struct inode *inode, struct file *file);
+void v9fs_inode2mistat(struct inode *inode, struct v9fs_stat *mistat);
+void v9fs_dentry_release(struct dentry *);
Index: fs/9p/vfs_super.c
===================================================================
--- /dev/null  (tree:3c5e9440c6a37c3355b50608836a23c8fa4eec99)
+++ 7d6ca5270f0ecf9306a944a3d39897a97dc9f67f/fs/9p/vfs_super.c  (mode:100644)
@@ -0,0 +1,257 @@
+/*
+ *  linux/fs/9p/vfs_super.c
+ *
+ * This file contians superblock ops for 9P2000. It is intended that 
+ * you mount this file system on directories.
+ *
+ *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
+ *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/stat.h>
+#include <linux/string.h>
+#include <linux/smp_lock.h>
+#include <linux/inet.h>
+#include <linux/pagemap.h>
+
+#include "debug.h"
+#include "idpool.h"
+#include "v9fs.h"
+#include "9p.h"
+#include "v9fs_vfs.h"
+#include "conv.h"
+#include "fid.h"
+
+static void v9fs_clear_inode(struct inode *);
+static struct super_operations v9fs_super_ops;
+
+/**
+ * v9fs_clear_inode - release an inode
+ * @inode: inode to release
+ *
+ */
+
+static void v9fs_clear_inode(struct inode *inode)
+{
+	filemap_fdatawrite(inode->i_mapping);
+}
+
+/**
+ * v9fs_set_super - set the superblock
+ * @s: super block
+ * @data: file system specific data
+ * 
+ */
+
+static int v9fs_set_super(struct super_block *s, void *data)
+{
+	s->s_fs_info = data;
+	return set_anon_super(s, data);
+}
+
+/**
+ * v9fs_block_bits - Determine bits in blocksize (from NFS Code)
+ * @bsize: blocksize
+ * @nrbitsp: number of bits
+ * 
+ * this bit from linux/fs/nfs/inode.c
+ * Copyright (C) 1992  Rick Sladkey
+ * XXX - shouldn't there be a global linux function for this?
+ * 
+ */
+
+static inline unsigned long
+v9fs_block_bits(unsigned long bsize, unsigned char *nrbitsp)
+{
+	/* make sure blocksize is a power of two */
+	if ((bsize & (bsize - 1)) || nrbitsp) {
+		unsigned char nrbits;
+
+		for (nrbits = 31; nrbits && !(bsize & (1 << nrbits));
+		     nrbits--) ;
+		bsize = 1 << nrbits;
+		if (nrbitsp)
+			*nrbitsp = nrbits;
+	}
+
+	return bsize;
+}
+
+/**
+ * v9fs_fill_super - populate superblock with info
+ * @sb: superblock
+ * @v9ses: session information
+ * 
+ */
+
+static void 
+v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses, int flags)
+{
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_blocksize =
+	    v9fs_block_bits(v9ses->maxdata, &sb->s_blocksize_bits);
+	sb->s_magic = V9FS_MAGIC;
+	sb->s_op = &v9fs_super_ops;
+
+	sb->s_flags = flags | MS_ACTIVE | MS_SYNCHRONOUS | MS_DIRSYNC | 
+					MS_NODIRATIME | MS_NOATIME;
+}
+
+/**
+ * v9fs_get_sb - mount a superblock
+ * @fs_type: file system type
+ * @flags: mount flags
+ * @dev_name: device name that was mounted
+ * @data: mount options
+ * 
+ */
+
+static struct super_block *v9fs_get_sb(struct file_system_type
+				       *fs_type, int flags,
+				       const char *dev_name, void *data)
+{
+	struct super_block *sb = NULL;
+	struct v9fs_fcall *fcall = NULL;
+	struct inode *inode = NULL;
+	struct dentry *root = NULL;
+	struct v9fs_session_info *v9ses = NULL;
+	struct v9fs_fid *root_fid = NULL;
+	int mode = S_IRWXUGO | S_ISVTX;
+	uid_t uid = current->fsuid;
+	gid_t gid = current->fsgid;
+	int stat_result = 0;
+	int newfid = 0;
+	int retval = 0;
+
+	dprintk(DEBUG_VFS, " \n");
+
+	v9ses = kcalloc(1, sizeof(struct v9fs_session_info), GFP_KERNEL);
+	if (!v9ses)
+		return ERR_PTR(-ENOMEM);
+
+	if ((newfid = v9fs_session_init(v9ses, dev_name, data)) < 0) {
+		dprintk(DEBUG_ERROR, "problem initiating session\n");
+		retval = newfid;
+		goto free_session;
+	}
+
+	sb = sget(fs_type, NULL, v9fs_set_super, v9ses);
+
+	v9fs_fill_super( sb, v9ses, flags );
+
+	inode = v9fs_get_inode(sb, S_IFDIR | mode);
+	if (IS_ERR(inode)) {
+		retval = PTR_ERR(inode);
+		goto put_back_sb;
+	}
+
+	inode->i_uid = uid;
+	inode->i_gid = gid;
+
+	root = d_alloc_root(inode);
+
+	if (!root) {
+		retval = -ENOMEM;
+		goto release_inode;
+	}
+
+	sb->s_root = root;
+
+	/* Setup the Root Inode */
+	root_fid = v9fs_fid_create(root);
+	if (root_fid == NULL) {
+		retval = -ENOMEM;
+		goto release_inode;
+	}
+
+	root_fid->fidopen = 0;
+	root_fid->v9ses = v9ses;
+
+	stat_result = v9fs_t_stat(v9ses, newfid, &fcall);
+	if (stat_result < 0) {
+		dprintk(DEBUG_ERROR, "stat error\n");
+		v9fs_t_clunk(v9ses, newfid, NULL);
+		v9fs_put_idpool(newfid, &v9ses->fidpool);
+	} else {
+		root_fid->fid = newfid;
+		root_fid->qid = fcall->params.rstat.stat->qid;
+		root->d_inode->i_ino =
+		    v9fs_qid2ino(&fcall->params.rstat.stat->qid);
+		v9fs_mistat2inode(fcall->params.rstat.stat, root->d_inode, sb);
+	}
+	kfree( fcall);
+
+	if (stat_result < 0) {
+		retval = stat_result;
+		goto release_inode;
+	}
+
+	return sb;
+
+      release_inode:
+	iput(inode);
+
+      put_back_sb:
+	up_write(&sb->s_umount);
+	deactivate_super(sb);
+
+	v9fs_session_close(v9ses);
+
+      free_session:
+	kfree(v9ses);
+
+	return ERR_PTR(retval);
+}
+
+/**
+ * v9fs_kill_super - Kill Superblock
+ * @s: superblock
+ * 
+ */
+
+static void v9fs_kill_super(struct super_block *s)
+{
+	struct v9fs_session_info *v9ses = s->s_fs_info;
+
+	dprintk(DEBUG_VFS, " %p\n", s);
+
+	v9fs_dentry_release(s->s_root);	/* clunk root */
+
+	kill_anon_super(s);
+
+	v9fs_session_close(v9ses);
+	kfree(v9ses);
+	dprintk(DEBUG_VFS, "exiting kill_super\n");
+}
+
+static struct super_operations v9fs_super_ops = {
+	.statfs = simple_statfs,
+	.clear_inode = v9fs_clear_inode,
+};
+
+struct file_system_type v9fs_fs_type = {
+	.name = "9P",
+	.get_sb = v9fs_get_sb,
+	.kill_sb = v9fs_kill_super,
+	.owner = THIS_MODULE,
+};
