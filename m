Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbVFGO4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbVFGO4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 10:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVFGO4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 10:56:45 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:16794 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261897AbVFGOvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 10:51:10 -0400
Message-Id: <200506071450.j57EoDe1010866@ms-smtp-02-eri0.texas.rr.com>
From: ericvh@gmail.com
Date: Tue,  7 Jun 2005 09:49:51 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] v9fs: debug and support routines (2.0)
Cc: v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part [7/7] of the v9fs-2.0 patch against Linux 2.6.

This part of the patch contains debug and other misc routines.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>


 ----------

 debug.h  |   68 ++++++++++++++++++
 error.c  |   92 ++++++++++++++++++++++++
 error.h  |  176 +++++++++++++++++++++++++++++++++++++++++++++++
 fid.c    |  233 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fid.h    |   55 ++++++++++++++
 idpool.c |  150 ++++++++++++++++++++++++++++++++++++++++
 idpool.h |   40 ++++++++++
 7 files changed, 814 insertions(+)

 ----------

--- /dev/null
+++ b/fs/9p/debug.h
@@ -0,0 +1,68 @@
+/*
+ *  linux/fs/9p/debug.h - V9FS Debug Definitions
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
+#define DEBUG_ERROR		(1<<0)
+#define DEBUG_CURRENT		(1<<1)
+#define DEBUG_9P	        (1<<2)
+#define DEBUG_VFS	        (1<<3)
+#define DEBUG_CONV		(1<<4)
+#define DEBUG_MUX		(1<<5)
+#define DEBUG_TRANS		(1<<6)
+#define DEBUG_SLABS	      	(1<<7)
+
+#define DEBUG_DUMP_PKT		0
+
+extern int v9fs_debug_level;
+
+#define dprintk(level, format, arg...) \
+do {  \
+	if((v9fs_debug_level & level)==level) \
+		printk(KERN_NOTICE "-- %s (%d): " \
+		format , __FUNCTION__, current->pid , ## arg); \
+} while(0)
+
+#define eprintk(level, format, arg...) \
+do { \
+	printk(level "v9fs: %s (%d): " \
+		format , __FUNCTION__, current->pid, ## arg); \
+} while(0)
+
+#if DEBUG_DUMP_PKT
+static inline void dump_data(const unsigned char *data, unsigned int datalen)
+{
+	int i, j;
+	int len = datalen;
+
+	printk(KERN_DEBUG "data ");
+	for (i = 0; i < len; i += 4) {
+		for (j = 0; (j < 4) && (i + j < len); j++)
+			printk(KERN_DEBUG "%02x", data[i + j]);
+		printk(KERN_DEBUG " ");
+	}
+	printk(KERN_DEBUG "\n");
+}
+#else				/* DEBUG_DUMP_PKT */
+static inline void dump_data(const unsigned char *data, unsigned int datalen)
+{
+
+}
+#endif				/* DEBUG_DUMP_PKT */
diff --git a/fs/9p/error.c b/fs/9p/error.c
new file mode 100644
--- /dev/null
+++ b/fs/9p/error.h
@@ -0,0 +1,176 @@
+/*
+ * linux/fs/9p/error.h
+ *
+ * Huge Nasty Error Table
+ *
+ * Plan 9 uses error strings, Unix uses error numbers.  This table tries to
+ * match UNIX strings and Plan 9 strings to unix error numbers.  It is used
+ * to preload the dynamic error table which can also track user-specific error
+ * strings.
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
+#include <linux/errno.h>
+
+struct errormap {
+	char *name;
+	int val;
+
+	struct hlist_node list;
+};
+
+#define ERRHASHSZ		32
+static struct hlist_head hash_errmap[ERRHASHSZ];
+
+/* FixMe - reduce to a reasonable size */
+static struct errormap errmap[] = {
+	{"Operation not permitted", 1},
+	{"wstat prohibited", 1},
+	{"No such file or directory", 2},
+	{"file not found", 2},
+	{"Interrupted system call", 4},
+	{"Input/output error", 5},
+	{"No such device or address", 6},
+	{"Argument list too long", 7},
+	{"Bad file descriptor", 9},
+	{"Resource temporarily unavailable", 11},
+	{"Cannot allocate memory", 12},
+	{"Permission denied", 13},
+	{"Bad address", 14},
+	{"Block device required", 15},
+	{"Device or resource busy", 16},
+	{"File exists", 17},
+	{"Invalid cross-device link", 18},
+	{"No such device", 19},
+	{"Not a directory", 20},
+	{"Is a directory", 21},
+	{"Invalid argument", 22},
+	{"Too many open files in system", 23},
+	{"Too many open files", 24},
+	{"Text file busy", 26},
+	{"File too large", 27},
+	{"No space left on device", 28},
+	{"Illegal seek", 29},
+	{"Read-only file system", 30},
+	{"Too many links", 31},
+	{"Broken pipe", 32},
+	{"Numerical argument out of domain", 33},
+	{"Numerical result out of range", 34},
+	{"Resource deadlock avoided", 35},
+	{"File name too long", 36},
+	{"No locks available", 37},
+	{"Function not implemented", 38},
+	{"Directory not empty", 39},
+	{"Too many levels of symbolic links", 40},
+	{"Unknown error 41", 41},
+	{"No message of desired type", 42},
+	{"Identifier removed", 43},
+	{"File locking deadlock error", 58},
+	{"No data available", 61},
+	{"Machine is not on the network", 64},
+	{"Package not installed", 65},
+	{"Object is remote", 66},
+	{"Link has been severed", 67},
+	{"Communication error on send", 70},
+	{"Protocol error", 71},
+	{"Bad message", 74},
+	{"File descriptor in bad state", 77},
+	{"Streams pipe error", 86},
+	{"Too many users", 87},
+	{"Socket operation on non-socket", 88},
+	{"Message too long", 90},
+	{"Protocol not available", 92},
+	{"Protocol not supported", 93},
+	{"Socket type not supported", 94},
+	{"Operation not supported", 95},
+	{"Protocol family not supported", 96},
+	{"Network is down", 100},
+	{"Network is unreachable", 101},
+	{"Network dropped connection on reset", 102},
+	{"Software caused connection abort", 103},
+	{"Connection reset by peer", 104},
+	{"No buffer space available", 105},
+	{"Transport endpoint is already connected", 106},
+	{"Transport endpoint is not connected", 107},
+	{"Cannot send after transport endpoint shutdown", 108},
+	{"Connection timed out", 110},
+	{"Connection refused", 111},
+	{"Host is down", 112},
+	{"No route to host", 113},
+	{"Operation already in progress", 114},
+	{"Operation now in progress", 115},
+	{"Is a named type file", 120},
+	{"Remote I/O error", 121},
+	{"Disk quota exceeded", 122},
+	{"Operation canceled", 125},
+	{"Unknown error 126", 126},
+	{"Unknown error 127", 127},
+/* errors from fossil, vacfs, and u9fs */
+	{"fid unknown or out of range", EBADF},
+	{"permission denied", EACCES},
+	{"file does not exist", ENOENT},
+	{"authentication failed", ECONNREFUSED},
+	{"bad offset in directory read", ESPIPE},
+	{"bad use of fid", EBADF},
+	{"wstat can't convert between files and directories", EPERM},
+	{"directory is not empty", ENOTEMPTY},
+	{"file exists", EEXIST},
+	{"file already exists", EEXIST},
+	{"file or directory already exists", EEXIST},
+	{"fid already in use", EBADF},
+	{"file in use", ETXTBSY},
+	{"i/o error", EIO},
+	{"file already open for I/O", ETXTBSY},
+	{"illegal mode", EINVAL},
+	{"illegal name", ENAMETOOLONG},
+	{"not a directory", ENOTDIR},
+	{"not a member of proposed group", EINVAL},
+	{"not owner", EACCES},
+	{"only owner can change group in wstat", EACCES},
+	{"read only file system", EROFS},
+	{"no access to special file", EPERM},
+	{"i/o count too large", EIO},
+	{"unknown group", EINVAL},
+	{"unknown user", EINVAL},
+	{"bogus wstat buffer", EPROTO},
+	{"exclusive use file already open", EAGAIN},
+	{"corrupted directory entry", EIO},
+	{"corrupted file entry", EIO},
+	{"corrupted block label", EIO},
+	{"corrupted meta data", EIO},
+	{"illegal offset", EINVAL},
+	{"illegal path element", ENOENT},
+	{"root of file system is corrupted", EIO},
+	{"corrupted super block", EIO},
+	{"protocol botch", EPROTO},
+	{"file system is full", ENOSPC},
+	{"file is in use", EAGAIN},
+	{"directory entry is not allocated", ENOENT},
+	{"file is read only", EROFS},
+	{"file has been removed", EIDRM},
+	{"only support truncation to zero length", EPERM},
+	{"cannot remove root", EPERM},
+	{"file too big", EFBIG},
+	{"venti i/o error", EIO},
+	/* these are not errors */
+	{"u9fs rhostsauth: no authentication required", 0},
+	{"u9fs authnone: no authentication required", 0},
+	{NULL, -1}
+};
diff --git a/fs/9p/fid.c b/fs/9p/fid.c
new file mode 100644
--- /dev/null
+++ b/fs/9p/error.c
@@ -0,0 +1,92 @@
+/*
+ * linux/fs/9p/error.c
+ *
+ * Error string handling
+ *
+ * Plan 9 uses error strings, Unix uses error numbers.  These functions
+ * try to help manage that and provide for dynamically adding error
+ * mappings.
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
+
+#include <linux/list.h>
+#include <linux/jhash.h>
+
+#include "debug.h"
+#include "error.h"
+
+/**
+ * v9fs_error_init - preload 
+ * @errstr: error string
+ *
+ */
+
+int v9fs_error_init(void)
+{
+	struct errormap *c;
+	int bucket;
+
+	/* initialize hash table */
+	for (bucket = 0; bucket < ERRHASHSZ; bucket++)
+		INIT_HLIST_HEAD(&hash_errmap[bucket]);
+
+	/* load initial error map into hash table */
+	for (c = errmap; c->name != NULL; c++) {
+		bucket = jhash(c->name, strlen(c->name), 0) % ERRHASHSZ;
+		INIT_HLIST_NODE(&c->list);
+		hlist_add_head(&c->list, &hash_errmap[bucket]);
+	}
+
+	return 1;
+}
+
+/**
+ * errstr2errno - convert error string to error number
+ * @errstr: error string
+ *
+ */
+
+int v9fs_errstr2errno(char *errstr)
+{
+	int errno = 0;
+	struct hlist_node *p = NULL;
+	struct errormap *c = NULL;
+	int bucket = jhash(errstr, strlen(errstr), 0) % ERRHASHSZ;
+
+	hlist_for_each(p, &hash_errmap[bucket]) {
+		c = hlist_entry(p, struct errormap, list);
+		if (!strcmp(c->name, errstr)) {
+			errno = c->val;
+			break;
+		}
+	}
+
+	if (errno == 0) {
+		/* TODO: if error isn't found, add it dynamically */
+		printk(KERN_ERR "%s: errstr :%s: not found\n", __FUNCTION__,
+		       errstr);
+		errno = 1;
+	}
+
+	return -errno;
+}
diff --git a/fs/9p/error.h b/fs/9p/error.h
new file mode 100644
--- /dev/null
+++ b/fs/9p/fid.h
@@ -0,0 +1,55 @@
+/*
+ * V9FS FID Management
+ *
+ *  Copyright (C) 2005 by Eric Van Hensbergen <ericvh@gmail.com>
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
+#include <linux/list.h>
+
+#define FID_OP   0
+#define FID_WALK 1
+
+struct v9fs_fid {
+	struct list_head list;	 /* list of fids associated with a dentry */
+	struct list_head active; /* XXX - debug */
+
+	u32 fid;
+	unsigned char fidopen;	  /* set when fid is opened */
+	unsigned char fidcreate;  /* set when fid was just created */
+	unsigned char fidclunked; /* set when fid has already been clunked */
+
+	struct v9fs_qid qid;
+	u32 iounit;
+
+	/* readdir stuff */
+	int rdir_fpos;
+	loff_t rdir_pos;
+	struct v9fs_fcall *rdir_fcall;
+
+	/* management stuff */
+	pid_t pid;		/* thread associated with this fid */
+	uid_t uid;		/* user associated with this fid */
+
+	/* private data */
+	struct file *filp;	/* backpointer to File struct for open files */
+	struct v9fs_session_info *v9ses;	/* session info for this FID */
+};
+
+struct v9fs_fid *v9fs_fid_lookup(struct dentry *dentry, int type);
+void v9fs_fid_destroy(struct v9fs_fid *fid);
+struct v9fs_fid *v9fs_fid_create(struct dentry *);
diff --git a/fs/9p/idpool.c b/fs/9p/idpool.c
new file mode 100644
--- /dev/null
+++ b/fs/9p/fid.c
@@ -0,0 +1,233 @@
+/*
+ * V9FS FID Management
+ *
+ *  Copyright (C) 2005 by Eric Van Hensbergen <ericvh@gmail.com>
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
+
+#include "debug.h"
+#include "idpool.h"
+#include "v9fs.h"
+#include "9p.h"
+#include "v9fs_vfs.h"
+#include "transport.h"
+#include "mux.h"
+#include "conv.h"
+#include "fid.h"
+
+/**
+ * v9fs_fid_insert - add a fid to a dentry
+ * @fid: fid to add
+ * @dentry: dentry that it is being added to
+ *
+ */
+
+static int v9fs_fid_insert(struct v9fs_fid *fid, struct dentry *dentry)
+{
+	struct list_head *fid_list = (struct list_head *)dentry->d_fsdata;
+	dprintk(DEBUG_9P, "fid %d (%p) dentry %s (%p)\n", fid->fid, fid,
+		dentry->d_iname, dentry);
+	if (dentry->d_fsdata == NULL) {
+		dentry->d_fsdata =
+		    kmalloc(sizeof(struct list_head), GFP_KERNEL);
+		if (dentry->d_fsdata == NULL) {
+			dprintk(DEBUG_ERROR, "Out of memory\n");
+			return -ENOMEM;
+		}
+		fid_list = (struct list_head *)dentry->d_fsdata;
+		INIT_LIST_HEAD(fid_list);	/* Initialize list head */
+	}
+
+	fid->uid = current->uid;
+	fid->pid = current->pid;
+	list_add(&fid->list, fid_list);
+	return 0;
+}
+
+/**
+ * v9fs_fid_create - allocate a FID structure
+ * @dentry - dentry to link newly created fid to
+ *
+ */
+
+struct v9fs_fid *v9fs_fid_create(struct dentry *dentry)
+{
+	struct v9fs_fid *new;
+
+	new = kmalloc(sizeof(struct v9fs_fid), GFP_KERNEL);
+	if (new == NULL) {
+		dprintk(DEBUG_ERROR, "Out of Memory\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	new->fid = -1;
+	new->fidopen = 0;
+	new->fidcreate = 0;
+	new->fidclunked = 0;
+	new->iounit = 0;
+
+	if (v9fs_fid_insert(new, dentry) == 0)
+		return new;
+	else {
+		dprintk(DEBUG_ERROR, "Problems inserting to dentry\n");
+		kfree(new);
+		return NULL;
+	}
+}
+
+/**
+ * v9fs_fid_destroy - deallocate a FID structure
+ * @fid: fid to destroy
+ * 
+ */
+
+void v9fs_fid_destroy(struct v9fs_fid *fid)
+{
+	list_del(&fid->list);
+	kfree(fid);
+}
+
+/**
+ * v9fs_fid_lookup - retrieve the right fid from a  particular dentry
+ * @dentry: dentry to look for fid in
+ * @type: intent of lookup (operation or traversal)
+ *
+ * search list of fids associated with a dentry for a fid with a matching
+ * thread id or uid.  If that fails, look up the dentry's parents to see if you
+ * can find a matching fid.
+ *
+ */
+
+struct v9fs_fid *v9fs_fid_lookup(struct dentry *dentry, int type)
+{
+	struct list_head *fid_list = (struct list_head *)dentry->d_fsdata;
+	struct v9fs_fid *current_fid = NULL;
+	struct list_head *p, *temp;
+	struct v9fs_fid *return_fid = NULL;
+	int found_parent = 0;
+	int found_user = 0;
+
+	dprintk(DEBUG_9P, " dentry: %s (%p) type %d\n", dentry->d_iname, dentry,
+		type);
+
+	if (fid_list && !list_empty(fid_list)) {
+		list_for_each_safe(p, temp, fid_list) {
+			current_fid = list_entry(p, struct v9fs_fid, list);
+			if (current_fid->uid == current->uid) {
+				if (return_fid == NULL) {
+					if ((type == FID_OP)
+					    || (!current_fid->fidopen)) {
+						return_fid = current_fid;
+						found_user = 1;
+					}
+				}
+			}
+			if (current_fid->pid == current->real_parent->pid) {
+				if ((return_fid == NULL) || (found_parent)
+				    || (found_user)) {
+					if ((type == FID_OP)
+					    || (!current_fid->fidopen)) {
+						return_fid = current_fid;
+						found_parent = 1;
+						found_user = 0;
+					}
+				}
+			}
+			if (current_fid->pid == current->pid) {
+				if ((type == FID_OP) || 
+				    (!current_fid->fidopen)) {
+					return_fid = current_fid;
+					found_parent = 0;
+					found_user = 0;
+				}
+			}
+		}
+	}
+
+	/* we are at the root but didn't match */
+	if ((!return_fid) && (dentry->d_parent == dentry)) {
+		/* TODO: clone attach with new uid */
+		return_fid = current_fid;
+	}
+
+	if (!return_fid) {
+		struct dentry *par = current->fs->pwd->d_parent;
+		int count = 1;
+		while (par != NULL) {
+			if (par == dentry)
+				break;
+			count++;
+			if (par == par->d_parent) {
+				dprintk(DEBUG_ERROR,
+					"got to root without finding dentry\n");
+				break;
+			}
+			par = par->d_parent;
+		}
+
+/* XXX - there may be some duplication we can get rid of */
+		if (par == dentry) {
+			/* we need to fid_lookup the starting point */
+			int fidnum = -1;
+			int oldfid = -1;
+			int result = -1;
+			struct v9fs_session_info *v9ses =
+			    v9fs_inode2v9ses(current->fs->pwd->d_inode);
+
+			current_fid =
+			    v9fs_fid_lookup(current->fs->pwd, FID_WALK);
+			if (current_fid == NULL) {
+				dprintk(DEBUG_ERROR,
+					"process cwd doesn't have a fid\n");
+				return return_fid;
+			}
+			oldfid = current_fid->fid;
+			par = current->fs->pwd;
+			/* TODO: take advantage of multiwalk */
+			fidnum = v9fs_get_idpool(&v9ses->fidpool);
+			while (par != dentry) {
+				result =
+				    v9fs_t_walk(v9ses, oldfid, fidnum, "..",
+						NULL);
+				if (result < 0) {
+					dprintk(DEBUG_ERROR,
+						"problem walking to parent\n");
+
+					break;
+				}
+				oldfid = fidnum;
+				if (par == par->d_parent) {
+					dprintk(DEBUG_ERROR,
+						"can't find dentry\n");
+					break;
+				}
+				par = par->d_parent;
+			}
+			if (par == dentry) {
+				return_fid = v9fs_fid_create(dentry);
+				return_fid->fid = fidnum;
+			}
+		}
+	}
+
+	return return_fid;
+}
diff --git a/fs/9p/fid.h b/fs/9p/fid.h
new file mode 100644
--- /dev/null
+++ b/fs/9p/idpool.h
@@ -0,0 +1,40 @@
+/*
+ *  linux/fs/9p/idpool.h
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
+ * This is for getting unique IDs. 
+ * 0 means free, non-zero means used. 
+ * 
+ */
+
+struct idpool {
+	struct semaphore sem;
+	int maxalloc;
+	int numalloc;
+	int lastfree;
+	unsigned long *idlist;
+};
+
+int v9fs_alloc_idpool(struct idpool *, int);
+void v9fs_free_idpool(struct idpool *);
+int v9fs_get_idpool(struct idpool *i);
+void v9fs_put_idpool(int which, struct idpool *i);
diff --git a/fs/9p/mux.c b/fs/9p/mux.c
new file mode 100644
--- /dev/null
+++ b/fs/9p/idpool.c
@@ -0,0 +1,150 @@
+/*
+ *  linux/fs/9p/idpool.c
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
+#include <asm/semaphore.h>
+#include <linux/config.h>
+#include "idpool.h"
+#include "debug.h"
+
+/**
+ * grow_idpool - increase the size of an id pool
+ * @i: pointer to idpool to initialize
+ * @size: size (in bits) of idpool
+ *
+ */
+
+static int grow_idpool(struct idpool *i, int newsize)
+{
+	unsigned long *newpool;
+
+	newpool = kmalloc((newsize / 8), GFP_KERNEL);
+	if (!newpool) {
+		eprintk(KERN_WARNING,
+			"Couldn't allocate memory to grow idpool\n");
+		return 0;
+	}
+
+	memset(newpool, 0, newsize / 8);
+	if (i->idlist) {
+		memcpy(newpool, i->idlist, (i->maxalloc) / 8);
+		kfree(i->idlist);
+	}
+
+	i->idlist = newpool;
+	i->maxalloc = newsize;
+
+	return newsize;
+}
+
+/**
+ * v9fs_alloc_idpool - allocate an id pool
+ * @i: pointer to idpool to initialize
+ * @size: size of idpool
+ *
+ */
+
+int v9fs_alloc_idpool(struct idpool *i, int size)
+{
+	int newsize;
+
+	init_MUTEX(&i->sem);
+	i->maxalloc = 0;
+	i->numalloc = 0;
+	i->lastfree = 0;
+	i->idlist = NULL;
+	newsize = grow_idpool(i, size);
+	return newsize;
+}
+
+/**
+ * v9fs_free_idpool - deallocate an id pool
+ * @i: pointer to idpool to free
+ *
+ */
+
+void v9fs_free_idpool(struct idpool *i)
+{
+	kfree(i->idlist);
+}
+
+/**
+ * v9fs_get_idpool - get a new id from the pool
+ * @i: pointer to idpool
+ *
+ */
+
+int v9fs_get_idpool(struct idpool *i)
+{
+	int nextbit;
+
+	if (down_interruptible(&i->sem) == -EINTR) {
+		eprintk(KERN_WARNING, "Interrupted while locking\n");
+		return -1;
+	}
+
+	nextbit = find_next_zero_bit(i->idlist, i->maxalloc, i->lastfree);
+	if (nextbit > i->maxalloc) {
+		if (grow_idpool(i, i->maxalloc * 2) == 0) {
+			up(&i->sem);
+			return -1;
+		} else {
+			nextbit =
+			    find_next_zero_bit(i->idlist, i->maxalloc,
+					       i->lastfree);
+		}
+	}
+
+	set_bit(nextbit, i->idlist);
+	if (i->lastfree == nextbit)
+		i->lastfree = nextbit + 1;
+
+	up(&i->sem);
+	return nextbit;
+}
+
+/**
+ * v9fs_put_idpool - get a new id from the pool
+ * @which: which id to put
+ * @i: pointer to idpool
+ *
+ */
+
+void v9fs_put_idpool(int which, struct idpool *i)
+{
+	if ((which < 0) || (which > i->maxalloc)) {
+		return;
+	}
+
+	if (down_interruptible(&i->sem) == -EINTR) {
+		eprintk(KERN_WARNING, "Interrupted while locking\n");
+		return;
+	}
+
+	clear_bit(which, i->idlist);
+	if (which < i->lastfree)
+		i->lastfree = which;
+
+	up(&i->sem);
+}
