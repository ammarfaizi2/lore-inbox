Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVFGPHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVFGPHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 11:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVFGPHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 11:07:24 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:60405 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261895AbVFGOvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 10:51:06 -0400
Message-Id: <200506071450.j57Eo1RZ029796@ms-smtp-03-eri0.texas.rr.com>
From: ericvh@gmail.com
Date: Tue,  7 Jun 2005 09:49:40 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] v9fs: 9P protocol implementation (2.0)
Cc: v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part [5/7] of the v9fs-2.0 patch against Linux 2.6.

This part of the patch contains the 9P protocol functions.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>


 ----------

 9p.c   |  357 ++++++++++++++++++++++++++++++++
 9p.h   |  339 ++++++++++++++++++++++++++++++
 conv.c |  725 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 conv.h |   34 +++
 4 files changed, 1455 insertions(+)

 ----------

--- /dev/null
+++ b/fs/9p/9p.h
@@ -0,0 +1,339 @@
+/*
+ * linux/fs/9p/9p.h
+ *
+ * 9P protocol definitions.
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
+/* Message Types */
+enum {
+	TVERSION = 100,
+	RVERSION,
+	TAUTH = 102,
+	RAUTH,
+	TATTACH = 104,
+	RATTACH,
+	TERROR = 106,
+	RERROR,
+	TFLUSH = 108,
+	RFLUSH,
+	TWALK = 110,
+	RWALK,
+	TOPEN = 112,
+	ROPEN,
+	TCREATE = 114,
+	RCREATE,
+	TREAD = 116,
+	RREAD,
+	TWRITE = 118,
+	RWRITE,
+	TCLUNK = 120,
+	RCLUNK,
+	TREMOVE = 122,
+	RREMOVE,
+	TSTAT = 124,
+	RSTAT,
+	TWSTAT = 126,
+	RWSTAT,
+};
+
+/* modes */
+enum {
+	V9FS_OREAD = 0x00,
+	V9FS_OWRITE = 0x01,
+	V9FS_ORDWR = 0x02,
+	V9FS_OEXEC = 0x03,
+	V9FS_OEXCL = 0x04,
+	V9FS_OTRUNC = 0x10,
+	V9FS_OREXEC = 0x20,
+	V9FS_ORCLOSE = 0x40,
+	V9FS_OAPPEND = 0x80,
+};
+
+/* permissions */
+enum {
+	V9FS_DMDIR = 0x80000000,
+	V9FS_DMAPPEND = 0x40000000,
+	V9FS_DMEXCL = 0x20000000,
+	V9FS_DMMOUNT = 0x10000000,
+	V9FS_DMAUTH = 0x08000000,
+	V9FS_DMTMP = 0x04000000,
+	V9FS_DMSYMLINK = 0x02000000,
+	V9FS_DMLINK = 0x01000000,
+	/* 9P2000.u extensions */
+	V9FS_DMDEVICE = 0x00800000,
+	V9FS_DMNAMEDPIPE = 0x00200000,
+	V9FS_DMSOCKET = 0x00100000,
+	V9FS_DMSETUID = 0x00080000,
+	V9FS_DMSETGID = 0x00040000,
+};
+
+/* qid.types */
+enum {
+	V9FS_QTDIR = 0x80,
+	V9FS_QTAPPEND = 0x40,
+	V9FS_QTEXCL = 0x20,
+	V9FS_QTMOUNT = 0x10,
+	V9FS_QTAUTH = 0x08,
+	V9FS_QTTMP = 0x04,
+	V9FS_QTSYMLINK = 0x02,
+	V9FS_QTLINK = 0x01,
+	V9FS_QTFILE = 0x00,
+};
+
+/* ample room for Twrite/Rread header (iounit) */
+#define V9FS_IOHDRSZ	24
+
+/* qids are the unique ID for a file (like an inode */
+struct v9fs_qid {
+	u8 type;
+	u32 version;
+	u64 path;
+};
+
+/* Plan 9 file metadata (stat) structure */
+struct v9fs_stat {
+	u16 size;
+	u16 type;
+	u32 dev;
+	struct v9fs_qid qid;
+	u32 mode;
+	u32 atime;
+	u32 mtime;
+	u64 length;
+	char *name;
+	char *uid;
+	char *gid;
+	char *muid;
+	char *extension;	/* 9p2000.u extensions */
+	u32 n_uid;		/* 9p2000.u extensions */
+	u32 n_gid;		/* 9p2000.u extensions */
+	u32 n_muid;		/* 9p2000.u extensions */
+	char data[0];
+};
+
+/* Structures for Protocol Operations */
+
+struct Tversion {
+	u32 msize;
+	char *version;
+};
+
+struct Rversion {
+	u32 msize;
+	char *version;
+};
+
+struct Tauth {
+	u32 afid;
+	char *uname;
+	char *aname;
+};
+
+struct Rauth {
+	struct v9fs_qid qid;
+};
+
+struct Rerror {
+	char *error;
+	u32 errno;		/* 9p2000.u extension */
+};
+
+struct Tflush {
+	u32 oldtag;
+};
+
+struct Rflush {
+};
+
+struct Tattach {
+	u32 fid;
+	u32 afid;
+	char *uname;
+	char *aname;
+};
+
+struct Rattach {
+	struct v9fs_qid qid;
+};
+
+struct Twalk {
+	u32 fid;
+	u32 newfid;
+	u32 nwname;
+	char **wnames;
+};
+
+struct Rwalk {
+	u32 nwqid;
+	struct v9fs_qid *wqids;
+};
+
+struct Topen {
+	u32 fid;
+	u8 mode;
+};
+
+struct Ropen {
+	struct v9fs_qid qid;
+	u32 iounit;
+};
+
+struct Tcreate {
+	u32 fid;
+	char *name;
+	u32 perm;
+	u8 mode;
+};
+
+struct Rcreate {
+	struct v9fs_qid qid;
+	u32 iounit;
+};
+
+struct Tread {
+	u32 fid;
+	u64 offset;
+	u32 count;
+};
+
+struct Rread {
+	u32 count;
+	u8 *data;
+};
+
+struct Twrite {
+	u32 fid;
+	u64 offset;
+	u32 count;
+	u8 *data;
+};
+
+struct Rwrite {
+	u32 count;
+};
+
+struct Tclunk {
+	u32 fid;
+};
+
+struct Rclunk {
+};
+
+struct Tremove {
+	u32 fid;
+};
+
+struct Rremove {
+};
+
+struct Tstat {
+	u32 fid;
+};
+
+struct Rstat {
+	struct v9fs_stat *stat;
+};
+
+struct Twstat {
+	u32 fid;
+	struct v9fs_stat *stat;
+};
+
+struct Rwstat {
+};
+
+/*
+  * fcall is the primary packet structure
+  *
+  */
+
+struct v9fs_fcall {
+	u32 size;
+	u8 id;
+	u16 tag;
+
+	union {
+		struct Tversion tversion;
+		struct Rversion rversion;
+		struct Tauth tauth;
+		struct Rauth rauth;
+		struct Rerror rerror;
+		struct Tflush tflush;
+		struct Rflush rflush;
+		struct Tattach tattach;
+		struct Rattach rattach;
+		struct Twalk twalk;
+		struct Rwalk rwalk;
+		struct Topen topen;
+		struct Ropen ropen;
+		struct Tcreate tcreate;
+		struct Rcreate rcreate;
+		struct Tread tread;
+		struct Rread rread;
+		struct Twrite twrite;
+		struct Rwrite rwrite;
+		struct Tclunk tclunk;
+		struct Rclunk rclunk;
+		struct Tremove tremove;
+		struct Rremove rremove;
+		struct Tstat tstat;
+		struct Rstat rstat;
+		struct Twstat twstat;
+		struct Rwstat rwstat;
+	} params;
+};
+
+#define FCALL_ERROR(fcall) (fcall ? fcall->params.rerror.error : "")
+
+int v9fs_t_version(struct v9fs_session_info *v9ses, u32 msize,
+		   char *version, struct v9fs_fcall **rcall);
+
+int v9fs_t_attach(struct v9fs_session_info *v9ses, char *uname, char *aname,
+		  u32 fid, u32 afid, struct v9fs_fcall **rcall);
+
+int v9fs_t_clunk(struct v9fs_session_info *v9ses, u32 fid,
+		 struct v9fs_fcall **rcall);
+
+int v9fs_t_flush(struct v9fs_session_info *v9ses, u16 oldtag);
+
+int v9fs_t_stat(struct v9fs_session_info *v9ses, u32 fid,
+		struct v9fs_fcall **rcall);
+
+int v9fs_t_wstat(struct v9fs_session_info *v9ses, u32 fid,
+		 struct v9fs_stat *stat, struct v9fs_fcall **rcall);
+
+int v9fs_t_walk(struct v9fs_session_info *v9ses, u32 fid, u32 newfid,
+		char *name, struct v9fs_fcall **rcall);
+
+int v9fs_t_open(struct v9fs_session_info *v9ses, u32 fid, u8 mode,
+		struct v9fs_fcall **rcall);
+
+int v9fs_t_remove(struct v9fs_session_info *v9ses, u32 fid,
+		  struct v9fs_fcall **rcall);
+
+int v9fs_t_create(struct v9fs_session_info *v9ses, u32 fid, char *name,
+		  u32 perm, u8 mode, struct v9fs_fcall **rcall);
+
+int v9fs_t_read(struct v9fs_session_info *v9ses, u32 fid,
+		u64 offset, u32 count, struct v9fs_fcall **rcall);
+
+int v9fs_t_write(struct v9fs_session_info *v9ses, u32 fid, u64 offset,
+		 u32 count, void *data, struct v9fs_fcall **rcall);
diff --git a/fs/9p/Makefile b/fs/9p/Makefile
new file mode 100644
--- /dev/null
+++ b/fs/9p/9p.c
@@ -0,0 +1,357 @@
+/*
+ *  linux/fs/9p/9p.c
+ *
+ *  This file contains functions 9P2000 functions
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
+
+#include "debug.h"
+#include "idpool.h"
+#include "v9fs.h"
+#include "9p.h"
+#include "mux.h"
+
+/**
+ * v9fs_t_version - negotiate protocol parameters with sever
+ * @v9ses: 9P2000 session information
+ * @msize: requested max size packet
+ * @version: requested version.extension string
+ * @fcall: pointer to response fcall pointer
+ *
+ */
+
+int
+v9fs_t_version(struct v9fs_session_info *v9ses, u32 msize,
+	       char *version, struct v9fs_fcall **fcall)
+{
+	struct v9fs_fcall msg;
+
+	dprintk(DEBUG_9P, "msize: %d version: %s\n", msize, version);
+	msg.id = TVERSION;
+	msg.params.tversion.msize = msize;
+	msg.params.tversion.version = version;
+
+	return v9fs_mux_rpc(v9ses, &msg, fcall);
+}
+
+/**
+ * v9fs_t_attach - mount the server
+ * @v9ses: 9P2000 session information
+ * @uname: user name doing the attach
+ * @aname: remote name being attached to
+ * @fid: mount fid to attatch to root node
+ * @afid: authentication fid (in this case result key)
+ * @fcall: pointer to response fcall pointer
+ *
+ */
+
+int
+v9fs_t_attach(struct v9fs_session_info *v9ses, char *uname, char *aname,
+	      u32 fid, u32 afid, struct v9fs_fcall **fcall)
+{
+	struct v9fs_fcall msg;
+
+	dprintk(DEBUG_9P, "uname '%s' aname '%s' fid %d afid %d\n", uname,
+		aname, fid, afid);
+	msg.id = TATTACH;
+	msg.params.tattach.fid = fid;
+	msg.params.tattach.afid = afid;
+	msg.params.tattach.uname = uname;
+	msg.params.tattach.aname = aname;
+
+	return v9fs_mux_rpc(v9ses, &msg, fcall);
+}
+
+/**
+ * v9fs_t_clunk - release a fid (finish a transaction)
+ * @v9ses: 9P2000 session information
+ * @fid: fid to release
+ * @fcall: pointer to response fcall pointer
+ *
+ */
+
+int
+v9fs_t_clunk(struct v9fs_session_info *v9ses, u32 fid,
+	     struct v9fs_fcall **fcall)
+{
+	struct v9fs_fcall msg;
+
+	dprintk(DEBUG_9P, "fid %d\n", fid);
+	msg.id = TCLUNK;
+	msg.params.tclunk.fid = fid;
+
+	return v9fs_mux_rpc(v9ses, &msg, fcall);
+}
+
+/**
+ * v9fs_v9fs_t_flush - flush a pending transaction
+ * @v9ses: 9P2000 session information
+ * @tag: tid to release
+ *
+ */
+
+int v9fs_t_flush(struct v9fs_session_info *v9ses, u16 tag)
+{
+	struct v9fs_fcall msg;
+
+	dprintk(DEBUG_9P, "oldtag %d\n", tag);
+	msg.id = TFLUSH;
+	msg.params.tflush.oldtag = tag;
+	return v9fs_mux_rpc(v9ses, &msg, NULL);
+}
+
+/**
+ * v9fs_t_stat - read a file's meta-data
+ * @v9ses: 9P2000 session information
+ * @fid: fid pointing to file or directory to get info about
+ * @fcall: pointer to response fcall
+ *
+ */
+
+int
+v9fs_t_stat(struct v9fs_session_info *v9ses, u32 fid, struct v9fs_fcall **fcall)
+{
+	struct v9fs_fcall msg;
+
+	dprintk(DEBUG_9P, "fid %d\n", fid);
+	if (fcall)
+		*fcall = NULL;
+
+	msg.id = TSTAT;
+	msg.params.tstat.fid = fid;
+	return v9fs_mux_rpc(v9ses, &msg, fcall);
+}
+
+/**
+ * v9fs_t_wstat - write a file's meta-data
+ * @v9ses: 9P2000 session information
+ * @fid: fid pointing to file or directory to write info about
+ * @stat: metadata
+ * @fcall: pointer to response fcall
+ *
+ */
+
+int
+v9fs_t_wstat(struct v9fs_session_info *v9ses, u32 fid,
+	     struct v9fs_stat *stat, struct v9fs_fcall **fcall)
+{
+	struct v9fs_fcall msg;
+
+	dprintk(DEBUG_9P, "fid %d length %d\n", fid, (int)stat->length);
+	msg.id = TWSTAT;
+	msg.params.twstat.fid = fid;
+	msg.params.twstat.stat = stat;
+
+	return v9fs_mux_rpc(v9ses, &msg, fcall);
+}
+
+/**
+ * v9fs_t_walk - walk a fid to a new file or directory
+ * @v9ses: 9P2000 session information
+ * @fid: fid to walk
+ * @newfid: new fid (for clone operations)
+ * @name: path to walk fid to
+ * @fcall: pointer to response fcall
+ *
+ */
+
+/* TODO: support multiple walk */
+
+int
+v9fs_t_walk(struct v9fs_session_info *v9ses, u32 fid, u32 newfid,
+	    char *name, struct v9fs_fcall **fcall)
+{
+	struct v9fs_fcall msg;
+
+	dprintk(DEBUG_9P, "fid %d newfid %d wname '%s'\n", fid, newfid, name);
+	msg.id = TWALK;
+	msg.params.twalk.fid = fid;
+	msg.params.twalk.newfid = newfid;
+
+	if (name) {
+		msg.params.twalk.nwname = 1;
+		msg.params.twalk.wnames = &name;
+	} else {
+		msg.params.twalk.nwname = 0;
+	}
+
+	return v9fs_mux_rpc(v9ses, &msg, fcall);
+}
+
+/**
+ * v9fs_t_open - open a file
+ *
+ * @v9ses - 9P2000 session information
+ * @fid - fid to open
+ * @mode - mode to open file (R, RW, etc)
+ * @fcall - pointer to response fcall
+ *
+ */
+
+int
+v9fs_t_open(struct v9fs_session_info *v9ses, u32 fid, u8 mode,
+	    struct v9fs_fcall **fcall)
+{
+	struct v9fs_fcall msg;
+	long errorno = -1;
+
+	dprintk(DEBUG_9P, "fid %d mode %d\n", fid, mode);
+	msg.id = TOPEN;
+	msg.params.topen.fid = fid;
+	msg.params.topen.mode = mode;
+
+	errorno = v9fs_mux_rpc(v9ses, &msg, fcall);
+
+	return errorno;
+}
+
+/**
+ * v9fs_t_remove - remove a file or directory
+ * @v9ses: 9P2000 session information
+ * @fid: fid to remove
+ * @fcall: pointer to response fcall
+ *
+ */
+
+int
+v9fs_t_remove(struct v9fs_session_info *v9ses, u32 fid,
+	      struct v9fs_fcall **fcall)
+{
+	struct v9fs_fcall msg;
+
+	dprintk(DEBUG_9P, "fid %d\n", fid);
+	msg.id = TREMOVE;
+	msg.params.tremove.fid = fid;
+	return v9fs_mux_rpc(v9ses, &msg, fcall);
+}
+
+/**
+ * v9fs_t_create - create a file or directory
+ * @v9ses: 9P2000 session information
+ * @fid: fid to create
+ * @name: name of the file or directory to create
+ * @perm: permissions to create with
+ * @mode: mode to open file (R, RW, etc)
+ * @fcall: pointer to response fcall
+ *
+ */
+
+int
+v9fs_t_create(struct v9fs_session_info *v9ses, u32 fid, char *name,
+	      u32 perm, u8 mode, struct v9fs_fcall **fcall)
+{
+	struct v9fs_fcall msg;
+
+	dprintk(DEBUG_9P, "fid %d name '%s' perm %x mode %d\n",
+		fid, name, perm, mode);
+
+	msg.id = TCREATE;
+	msg.params.tcreate.fid = fid;
+	msg.params.tcreate.name = name;
+	msg.params.tcreate.perm = perm;
+	msg.params.tcreate.mode = mode;
+
+	return v9fs_mux_rpc(v9ses, &msg, fcall);
+}
+
+/**
+ * v9fs_t_read - read data
+ * @v9ses: 9P2000 session information
+ * @fid: fid to read from
+ * @offset: offset to start read at
+ * @count: how many bytes to read
+ * @fcall: pointer to response fcall (with data)
+ *
+ */
+
+int
+v9fs_t_read(struct v9fs_session_info *v9ses, u32 fid, u64 offset,
+	    u32 count, struct v9fs_fcall **fcall)
+{
+	struct v9fs_fcall msg;
+	struct v9fs_fcall *rc = NULL;
+	long errorno = -1;
+
+	dprintk(DEBUG_9P, "fid %d offset 0x%lx count 0x%x\n", fid,
+		(long unsigned int)offset, count);
+	msg.id = TREAD;
+	msg.params.tread.fid = fid;
+	msg.params.tread.offset = offset;
+	msg.params.tread.count = count;
+	errorno = v9fs_mux_rpc(v9ses, &msg, &rc);
+
+	if (!errorno) {
+		errorno = rc->params.rread.count;
+		dump_data(rc->params.rread.data, rc->params.rread.count);
+	}
+
+	if (fcall)
+		*fcall = rc;
+	else
+		kfree(rc);
+
+	return errorno;
+}
+
+/**
+ * v9fs_t_write - write data
+ * @v9ses: 9P2000 session information
+ * @fid: fid to write to
+ * @offset: offset to start write at
+ * @count: how many bytes to write
+ * @fcall: pointer to response fcall
+ *
+ */
+
+int
+v9fs_t_write(struct v9fs_session_info *v9ses, u32 fid,
+	     u64 offset, u32 count, void *data, struct v9fs_fcall **fcall)
+{
+	struct v9fs_fcall msg;
+	struct v9fs_fcall *rc = NULL;
+	long errorno = -1;
+
+	dprintk(DEBUG_9P, "fid %d offset 0x%llx count 0x%x\n", fid,
+		(unsigned long long)offset, count);
+	dump_data(data, count);
+
+	msg.id = TWRITE;
+	msg.params.twrite.fid = fid;
+	msg.params.twrite.offset = offset;
+	msg.params.twrite.count = count;
+	msg.params.twrite.data = data;
+
+	errorno = v9fs_mux_rpc(v9ses, &msg, &rc);
+
+	if (!errorno)
+		errorno = rc->params.rwrite.count;
+
+	if (fcall)
+		*fcall = rc;
+	else
+		kfree(rc);
+
+	return errorno;
+}
diff --git a/fs/9p/9p.h b/fs/9p/9p.h
new file mode 100644
--- /dev/null
+++ b/fs/9p/conv.h
@@ -0,0 +1,34 @@
+/*
+ * linux/fs/9p/conv.h
+ *
+ * 9P protocol conversion definitions
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
+int v9fs_deserialize_stat(struct v9fs_session_info *, void *buf,
+			  u32 buflen, struct v9fs_stat *stat, u32 statlen);
+int v9fs_serialize_fcall(struct v9fs_session_info *, struct v9fs_fcall *tcall,
+			 void *buf, u32 buflen);
+int v9fs_deserialize_fcall(struct v9fs_session_info *, u32 msglen,
+			   void *buf, u32 buflen, struct v9fs_fcall *rcall,
+			   int rcalllen);
+
+/* this one is actually in error.c right now */
+int v9fs_errstr2errno(char *errstr);
diff --git a/fs/9p/debug.h b/fs/9p/debug.h
new file mode 100644
--- /dev/null
+++ b/fs/9p/conv.c
@@ -0,0 +1,725 @@
+/*
+ * linux/fs/9p/conv.c
+ *
+ * 9P protocol conversion functions
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
+
+#include "debug.h"
+#include "idpool.h"
+#include "v9fs.h"
+#include "9p.h"
+#include "conv.h"
+
+/*
+ * Buffer to help with string parsing 
+ */
+struct cbuf {
+	unsigned char *sp;
+	unsigned char *p;
+	unsigned char *ep;
+};
+
+static inline void buf_init(struct cbuf *buf, void *data, int datalen)
+{
+	buf->sp = buf->p = data;
+	buf->ep = data + datalen;
+}
+
+static inline int buf_check_overflow(struct cbuf *buf)
+{
+	return buf->p > buf->ep;
+}
+
+#define buf_check_sizep(buf, len) \
+	if (buf->p+len > buf->ep) { \
+		if (buf->p < buf->ep) { \
+			eprintk(KERN_ERR, "buffer overflow\n"); \
+			buf->p = buf->ep + 1; \
+		} \
+		return NULL; \
+	} \
+
+
+#define buf_check_size(buf, len) \
+	if (buf->p+len > buf->ep) { \
+		if (buf->p < buf->ep) { \
+			eprintk(KERN_ERR, "buffer overflow\n"); \
+			buf->p = buf->ep + 1; \
+		} \
+		return 0; \
+	} \
+
+#define buf_check_sizev(buf, len) \
+	if (buf->p+len > buf->ep) { \
+		if (buf->p < buf->ep) { \
+			eprintk(KERN_ERR, "buffer overflow\n"); \
+			buf->p = buf->ep + 1; \
+		} \
+		return; \
+	} \
+
+static inline void *buf_alloc(struct cbuf *buf, int len)
+{
+	void *ret = NULL;
+
+	buf_check_sizep(buf, len);
+	ret = buf->p;
+	buf->p += len;
+
+	return ret;
+}
+
+static inline void buf_put_int8(struct cbuf *buf, u8 val)
+{
+	buf_check_sizev(buf, 1);
+
+	buf->p[0] = val;
+	buf->p++;
+}
+
+static inline void buf_put_int16(struct cbuf *buf, u16 val)
+{
+	buf_check_sizev(buf, 2);
+
+	buf->p[0] = val;
+	buf->p[1] = val >> 8;
+	buf->p += 2;
+}
+
+static inline void buf_put_int32(struct cbuf *buf, u32 val)
+{
+	buf_check_sizev(buf, 4);
+
+	buf->p[0] = val;
+	buf->p[1] = val >> 8;
+	buf->p[2] = val >> 16;
+	buf->p[3] = val >> 24;
+	buf->p += 4;
+}
+
+static inline void buf_put_int64(struct cbuf *buf, u64 val)
+{
+	buf_check_sizev(buf, 8);
+
+	buf->p[0] = val;
+	buf->p[1] = val >> 8;
+	buf->p[2] = val >> 16;
+	buf->p[3] = val >> 24;
+	buf->p[4] = val >> 32;
+	buf->p[5] = val >> 40;
+	buf->p[6] = val >> 48;
+	buf->p[7] = val >> 56;
+	buf->p += 8;
+}
+
+static inline void buf_put_stringn(struct cbuf *buf, const char *s, u16 slen)
+{
+	buf_check_sizev(buf, slen + 2);
+
+	buf_put_int16(buf, slen);
+	memcpy(buf->p, s, slen);
+	buf->p += slen;
+}
+
+static inline void buf_put_string(struct cbuf *buf, const char *s)
+{
+	buf_put_stringn(buf, s, strlen(s));
+}
+
+static inline void buf_put_data(struct cbuf *buf, void *data, u32 datalen)
+{
+	buf_check_sizev(buf, datalen);
+
+	memcpy(buf->p, data, datalen);
+	buf->p += datalen;
+}
+
+static inline u8 buf_get_int8(struct cbuf *buf)
+{
+	u8 ret = 0;
+
+	buf_check_size(buf, 1);
+	ret = buf->p[0];
+
+	buf->p++;
+
+	return ret;
+}
+
+static inline u16 buf_get_int16(struct cbuf *buf)
+{
+	u16 ret = 0;
+
+	buf_check_size(buf, 2);
+	ret = buf->p[0] | (buf->p[1] << 8);
+
+	buf->p += 2;
+
+	return ret;
+}
+
+static inline u32 buf_get_int32(struct cbuf *buf)
+{
+	u32 ret = 0;
+
+	buf_check_size(buf, 4);
+	ret =
+	    buf->p[0] | (buf->p[1] << 8) | (buf->p[2] << 16) | (buf->
+								p[3] << 24);
+
+	buf->p += 4;
+
+	return ret;
+}
+
+static inline u64 buf_get_int64(struct cbuf *buf)
+{
+	u64 ret = 0;
+
+	buf_check_size(buf, 8);
+	ret = (u64) buf->p[0] | ((u64) buf->p[1] << 8) |
+	    ((u64) buf->p[2] << 16) | ((u64) buf->p[3] << 24) |
+	    ((u64) buf->p[4] << 32) | ((u64) buf->p[5] << 40) |
+	    ((u64) buf->p[6] << 48) | ((u64) buf->p[7] << 56);
+
+	buf->p += 8;
+
+	return ret;
+}
+
+static inline int
+buf_get_string(struct cbuf *buf, char *data, unsigned int datalen)
+{
+
+	u16 len = buf_get_int16(buf);
+	buf_check_size(buf, len);
+	if (len + 1 > datalen)
+		return 0;
+
+	memcpy(data, buf->p, len);
+	data[len] = 0;
+	buf->p += len;
+
+	return len + 1;
+}
+
+static inline char *buf_get_stringb(struct cbuf *buf, struct cbuf *sbuf)
+{
+	char *ret = NULL;
+	int n = buf_get_string(buf, sbuf->p, sbuf->ep - sbuf->p);
+
+	if (n > 0) {
+		ret = sbuf->p;
+		sbuf->p += n;
+	}
+
+	return ret;
+}
+
+static inline int buf_get_data(struct cbuf *buf, void *data, int datalen)
+{
+	buf_check_size(buf, datalen);
+
+	memcpy(data, buf->p, datalen);
+	buf->p += datalen;
+
+	return datalen;
+}
+
+static inline void *buf_get_datab(struct cbuf *buf, struct cbuf *dbuf,
+				  int datalen)
+{
+	char *ret = NULL;
+	int n = 0;
+
+	buf_check_sizep(dbuf, datalen);
+
+	n = buf_get_data(buf, dbuf->p, datalen);
+
+	if (n > 0) {
+		ret = dbuf->p;
+		dbuf->p += n;
+	}
+
+	return ret;
+}
+
+/**
+ * v9fs_size_stat - calculate the size of a variable length stat struct
+ * @v9ses: session information
+ * @stat: metadata (stat) structure
+ *
+ */
+
+static int v9fs_size_stat(struct v9fs_session_info *v9ses,
+			  struct v9fs_stat *stat)
+{
+	int size = 0;
+
+	if (stat == NULL) {
+		eprintk(KERN_ERR, "v9fs_size_stat: got a NULL stat pointer\n");
+		return 0;
+	}
+
+	size =			/* 2 + *//* size[2] */
+	    2 +			/* type[2] */
+	    4 +			/* dev[4] */
+	    1 +			/* qid.type[1] */
+	    4 +			/* qid.vers[4] */
+	    8 +			/* qid.path[8] */
+	    4 +			/* mode[4] */
+	    4 +			/* atime[4] */
+	    4 +			/* mtime[4] */
+	    8 +			/* length[8] */
+	    8;			/* minimum sum of string lengths */
+
+	if (stat->name)
+		size += strlen(stat->name);
+	if (stat->uid)
+		size += strlen(stat->uid);
+	if (stat->gid)
+		size += strlen(stat->gid);
+	if (stat->muid)
+		size += strlen(stat->muid);
+
+	if (v9ses->extended) {
+		size += 4 +	/* n_uid[4] */
+		    4 +		/* n_gid[4] */
+		    4 +		/* n_muid[4] */
+		    2;		/* string length of extension[4] */
+		if (stat->extension)
+			size += strlen(stat->extension);
+	}
+
+	return size;
+}
+
+/**
+ * serialize_stat - safely format a stat structure for transmission
+ * @v9ses: session info
+ * @stat: metadata (stat) structure
+ * @bufp: buffer to serialize structure into
+ *
+ */
+
+static int
+serialize_stat(struct v9fs_session_info *v9ses, struct v9fs_stat *stat,
+	       struct cbuf *bufp)
+{
+	buf_put_int16(bufp, stat->size);
+	buf_put_int16(bufp, stat->type);
+	buf_put_int32(bufp, stat->dev);
+	buf_put_int8(bufp, stat->qid.type);
+	buf_put_int32(bufp, stat->qid.version);
+	buf_put_int64(bufp, stat->qid.path);
+	buf_put_int32(bufp, stat->mode);
+	buf_put_int32(bufp, stat->atime);
+	buf_put_int32(bufp, stat->mtime);
+	buf_put_int64(bufp, stat->length);
+
+	buf_put_string(bufp, stat->name);
+	buf_put_string(bufp, stat->uid);
+	buf_put_string(bufp, stat->gid);
+	buf_put_string(bufp, stat->muid);
+
+	if (v9ses->extended) {
+		buf_put_string(bufp, stat->extension);
+		buf_put_int32(bufp, stat->n_uid);
+		buf_put_int32(bufp, stat->n_gid);
+		buf_put_int32(bufp, stat->n_muid);
+	}
+
+	if (buf_check_overflow(bufp))
+		return 0;
+
+	return stat->size;
+}
+
+/**
+ * deserialize_stat - safely decode a recieved metadata (stat) structure
+ * @v9ses: session info
+ * @bufp: buffer to deserialize 
+ * @stat: metadata (stat) structure
+ * @dbufp: buffer to deserialize variable strings into
+ *
+ */
+
+static inline int
+deserialize_stat(struct v9fs_session_info *v9ses, struct cbuf *bufp,
+		 struct v9fs_stat *stat, struct cbuf *dbufp)
+{
+
+	stat->size = buf_get_int16(bufp);
+	stat->type = buf_get_int16(bufp);
+	stat->dev = buf_get_int32(bufp);
+	stat->qid.type = buf_get_int8(bufp);
+	stat->qid.version = buf_get_int32(bufp);
+	stat->qid.path = buf_get_int64(bufp);
+	stat->mode = buf_get_int32(bufp);
+	stat->atime = buf_get_int32(bufp);
+	stat->mtime = buf_get_int32(bufp);
+	stat->length = buf_get_int64(bufp);
+	stat->name = buf_get_stringb(bufp, dbufp);
+	stat->uid = buf_get_stringb(bufp, dbufp);
+	stat->gid = buf_get_stringb(bufp, dbufp);
+	stat->muid = buf_get_stringb(bufp, dbufp);
+
+	if (v9ses->extended) {
+		stat->extension = buf_get_stringb(bufp, dbufp);
+		stat->n_uid = buf_get_int32(bufp);
+		stat->n_gid = buf_get_int32(bufp);
+		stat->n_muid = buf_get_int32(bufp);
+	}
+
+	if (buf_check_overflow(bufp) || buf_check_overflow(dbufp))
+		return 0;
+
+	return stat->size + 2;
+}
+
+/**
+ * deserialize_statb - wrapper for decoding a received metadata structure
+ * @v9ses: session info
+ * @bufp: buffer to deserialize 
+ * @dbufp: buffer to deserialize variable strings into
+ *
+ */
+
+static inline struct v9fs_stat *deserialize_statb(struct v9fs_session_info
+						  *v9ses, struct cbuf *bufp,
+						  struct cbuf *dbufp)
+{
+	struct v9fs_stat *ret = buf_alloc(dbufp, sizeof(struct v9fs_stat));
+
+	if (ret) {
+		int n = deserialize_stat(v9ses, bufp, ret, dbufp);
+		if (n <= 0)
+			return NULL;
+	}
+
+	return ret;
+}
+
+/**
+ * v9fs_deserialize_stat - decode a received metadata structure
+ * @v9ses: session info
+ * @buf: buffer to deserialize 
+ * @buflen: length of received buffer
+ * @stat: metadata structure to decode into
+ * @statlen: length of destination metadata structure 
+ *
+ */
+
+int
+v9fs_deserialize_stat(struct v9fs_session_info *v9ses, void *buf,
+		      u32 buflen, struct v9fs_stat *stat, u32 statlen)
+{
+	struct cbuf buffer;
+	struct cbuf *bufp = &buffer;
+	struct cbuf dbuffer;
+	struct cbuf *dbufp = &dbuffer;
+
+	buf_init(bufp, buf, buflen);
+	buf_init(dbufp, (char *)stat + sizeof(struct v9fs_stat),
+		 statlen - sizeof(struct v9fs_stat));
+
+	return deserialize_stat(v9ses, bufp, stat, dbufp);
+}
+
+static inline int
+v9fs_size_fcall(struct v9fs_session_info *v9ses, struct v9fs_fcall *fcall)
+{
+	int size = 4 + 1 + 2;	/* size[4] msg[1] tag[2] */
+	int i = 0;
+
+	switch (fcall->id) {
+	default:
+		eprintk(KERN_ERR, "bad msg type %d\n", fcall->id);
+		return 0;
+	case TVERSION:		/* msize[4] version[s] */
+		size += 4 + 2 + strlen(fcall->params.tversion.version);
+		break;
+	case TAUTH:		/* afid[4] uname[s] aname[s] */
+		size += 4 + 2 + strlen(fcall->params.tauth.uname) +
+		    2 + strlen(fcall->params.tauth.aname);
+		break;
+	case TFLUSH:		/* oldtag[2] */
+		size += 2;
+		break;
+	case TATTACH:		/* fid[4] afid[4] uname[s] aname[s] */
+		size += 4 + 4 + 2 + strlen(fcall->params.tattach.uname) +
+		    2 + strlen(fcall->params.tattach.aname);
+		break;
+	case TWALK:		/* fid[4] newfid[4] nwname[2] nwname*(wname[s]) */
+		size += 4 + 4 + 2;
+		/* now compute total for the array of names */
+		for (i = 0; i < fcall->params.twalk.nwname; i++)
+			size += 2 + strlen(fcall->params.twalk.wnames[i]);
+		break;
+	case TOPEN:		/* fid[4] mode[1] */
+		size += 4 + 1;
+		break;
+	case TCREATE:		/* fid[4] name[s] perm[4] mode[1] */
+		size += 4 + 2 + strlen(fcall->params.tcreate.name) + 4 + 1;
+		break;
+	case TREAD:		/* fid[4] offset[8] count[4] */
+		size += 4 + 8 + 4;
+		break;
+	case TWRITE:		/* fid[4] offset[8] count[4] data[count] */
+		size += 4 + 8 + 4 + fcall->params.twrite.count;
+		break;
+	case TCLUNK:		/* fid[4] */
+		size += 4;
+		break;
+	case TREMOVE:		/* fid[4] */
+		size += 4;
+		break;
+	case TSTAT:		/* fid[4] */
+		size += 4;
+		break;
+	case TWSTAT:		/* fid[4] stat[n] */
+		fcall->params.twstat.stat->size =
+		    v9fs_size_stat(v9ses, fcall->params.twstat.stat);
+		size += 4 + 2 + 2 + fcall->params.twstat.stat->size;
+	}
+	return size;
+}
+
+/*
+ * v9fs_serialize_fcall - marshall fcall struct into a packet
+ * @v9ses: session information
+ * @fcall: structure to convert
+ * @data: buffer to serialize fcall into 
+ * @datalen: length of buffer to serialize fcall into
+ *
+ */
+
+int
+v9fs_serialize_fcall(struct v9fs_session_info *v9ses, struct v9fs_fcall *fcall,
+		     void *data, u32 datalen)
+{
+	int i = 0;
+	struct v9fs_stat *stat = NULL;
+	struct cbuf buffer;
+	struct cbuf *bufp = &buffer;
+
+	buf_init(bufp, data, datalen);
+
+	if (!fcall) {
+		eprintk(KERN_ERR, "no fcall\n");
+		return -EINVAL;
+	}
+
+	fcall->size = v9fs_size_fcall(v9ses, fcall);
+
+	buf_put_int32(bufp, fcall->size);
+	buf_put_int8(bufp, fcall->id);
+	buf_put_int16(bufp, fcall->tag);
+
+	dprintk(DEBUG_CONV, "size %d id %d tag %d\n", fcall->size, fcall->id,
+		fcall->tag);
+
+	/* now encode it */
+	switch (fcall->id) {
+	default:
+		eprintk(KERN_ERR, "bad msg type: %d\n", fcall->id);
+		return -EPROTO;
+	case TVERSION:
+		buf_put_int32(bufp, fcall->params.tversion.msize);
+		buf_put_string(bufp, fcall->params.tversion.version);
+		break;
+	case TAUTH:
+		buf_put_int32(bufp, fcall->params.tauth.afid);
+		buf_put_string(bufp, fcall->params.tauth.uname);
+		buf_put_string(bufp, fcall->params.tauth.aname);
+		break;
+	case TFLUSH:
+		buf_put_int16(bufp, fcall->params.tflush.oldtag);
+		break;
+	case TATTACH:
+		buf_put_int32(bufp, fcall->params.tattach.fid);
+		buf_put_int32(bufp, fcall->params.tattach.afid);
+		buf_put_string(bufp, fcall->params.tattach.uname);
+		buf_put_string(bufp, fcall->params.tattach.aname);
+		break;
+	case TWALK:
+		buf_put_int32(bufp, fcall->params.twalk.fid);
+		buf_put_int32(bufp, fcall->params.twalk.newfid);
+		buf_put_int16(bufp, fcall->params.twalk.nwname);
+		for (i = 0; i < fcall->params.twalk.nwname; i++)
+			buf_put_string(bufp, fcall->params.twalk.wnames[i]);
+		break;
+	case TOPEN:
+		buf_put_int32(bufp, fcall->params.topen.fid);
+		buf_put_int8(bufp, fcall->params.topen.mode);
+		break;
+	case TCREATE:
+		buf_put_int32(bufp, fcall->params.tcreate.fid);
+		buf_put_string(bufp, fcall->params.tcreate.name);
+		buf_put_int32(bufp, fcall->params.tcreate.perm);
+		buf_put_int8(bufp, fcall->params.tcreate.mode);
+		break;
+	case TREAD:
+		buf_put_int32(bufp, fcall->params.tread.fid);
+		buf_put_int64(bufp, fcall->params.tread.offset);
+		buf_put_int32(bufp, fcall->params.tread.count);
+		break;
+	case TWRITE:
+		buf_put_int32(bufp, fcall->params.twrite.fid);
+		buf_put_int64(bufp, fcall->params.twrite.offset);
+		buf_put_int32(bufp, fcall->params.twrite.count);
+		buf_put_data(bufp, fcall->params.twrite.data,
+			     fcall->params.twrite.count);
+		break;
+	case TCLUNK:
+		buf_put_int32(bufp, fcall->params.tclunk.fid);
+		break;
+	case TREMOVE:
+		buf_put_int32(bufp, fcall->params.tremove.fid);
+		break;
+	case TSTAT:
+		buf_put_int32(bufp, fcall->params.tstat.fid);
+		break;
+	case TWSTAT:
+		buf_put_int32(bufp, fcall->params.twstat.fid);
+		stat = fcall->params.twstat.stat;
+
+		buf_put_int16(bufp, stat->size + 2);
+		serialize_stat(v9ses, stat, bufp);
+		break;
+	}
+
+	if (buf_check_overflow(bufp))
+		return -EIO;
+
+	return fcall->size;
+}
+
+/**
+ * deserialize_fcall - unmarshal a response
+ * @v9ses: session information
+ * @msgsize: size of rcall message
+ * @buf: recieved buffer
+ * @buflen: length of received buffer
+ * @rcall: fcall structure to populate
+ * @rcalllen: length of fcall structure to populate
+ *
+ */
+
+int
+v9fs_deserialize_fcall(struct v9fs_session_info *v9ses, u32 msgsize,
+		       void *buf, u32 buflen, struct v9fs_fcall *rcall,
+		       int rcalllen)
+{
+
+	struct cbuf buffer;
+	struct cbuf *bufp = &buffer;
+	struct cbuf dbuffer;
+	struct cbuf *dbufp = &dbuffer;
+	int i = 0;
+
+	buf_init(bufp, buf, buflen);
+	buf_init(dbufp, (char *)rcall + sizeof(struct v9fs_fcall),
+		 rcalllen - sizeof(struct v9fs_fcall));
+
+	rcall->size = msgsize;
+	rcall->id = buf_get_int8(bufp);
+	rcall->tag = buf_get_int16(bufp);
+
+	dprintk(DEBUG_CONV, "size %d id %d tag %d\n", rcall->size, rcall->id,
+		rcall->tag);
+	switch (rcall->id) {
+	default:
+		eprintk(KERN_ERR, "unknown message type: %d\n", rcall->id);
+		return -EPROTO;
+	case RVERSION:
+		rcall->params.rversion.msize = buf_get_int32(bufp);
+		rcall->params.rversion.version = buf_get_stringb(bufp, dbufp);
+		break;
+	case RFLUSH:
+		break;
+	case RATTACH:
+		rcall->params.rattach.qid.type = buf_get_int8(bufp);
+		rcall->params.rattach.qid.version = buf_get_int32(bufp);
+		rcall->params.rattach.qid.path = buf_get_int64(bufp);
+		break;
+	case RWALK:
+		rcall->params.rwalk.nwqid = buf_get_int16(bufp);
+		rcall->params.rwalk.wqids = buf_alloc(bufp,
+		      rcall->params.rwalk.nwqid * sizeof(struct v9fs_qid));
+		if (rcall->params.rwalk.wqids)
+			for (i = 0; i < rcall->params.rwalk.nwqid; i++) {
+				rcall->params.rwalk.wqids[i].type =
+				    buf_get_int8(bufp);
+				rcall->params.rwalk.wqids[i].version =
+				    buf_get_int16(bufp);
+				rcall->params.rwalk.wqids[i].path =
+				    buf_get_int64(bufp);
+			}
+		break;
+	case ROPEN:
+		rcall->params.ropen.qid.type = buf_get_int8(bufp);
+		rcall->params.ropen.qid.version = buf_get_int32(bufp);
+		rcall->params.ropen.qid.path = buf_get_int64(bufp);
+		rcall->params.ropen.iounit = buf_get_int32(bufp);
+		break;
+	case RCREATE:
+		rcall->params.rcreate.qid.type = buf_get_int8(bufp);
+		rcall->params.rcreate.qid.version = buf_get_int32(bufp);
+		rcall->params.rcreate.qid.path = buf_get_int64(bufp);
+		rcall->params.rcreate.iounit = buf_get_int32(bufp);
+		break;
+	case RREAD:
+		rcall->params.rread.count = buf_get_int32(bufp);
+		rcall->params.rread.data = buf_get_datab(bufp, dbufp,
+			rcall->params.rread.count);
+		break;
+	case RWRITE:
+		rcall->params.rwrite.count = buf_get_int32(bufp);
+		break;
+	case RCLUNK:
+		break;
+	case RREMOVE:
+		break;
+	case RSTAT:
+		buf_get_int16(bufp);
+		rcall->params.rstat.stat =
+		    deserialize_statb(v9ses, bufp, dbufp);
+		break;
+	case RWSTAT:
+		break;
+	case RERROR:
+		rcall->params.rerror.error = buf_get_stringb(bufp, dbufp);
+		if (v9ses->extended)
+			rcall->params.rerror.errno = buf_get_int16(bufp);
+		break;
+	}
+
+	if (buf_check_overflow(bufp) || buf_check_overflow(dbufp))
+		return -EIO;
+
+	return rcall->size;
+}
