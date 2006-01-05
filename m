Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWAEAyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWAEAyG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWAEAx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:53:56 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:4243 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751062AbWAEAxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:53:36 -0500
Date: Wed, 4 Jan 2006 19:57:31 -0500
From: Latchesar Ionkov <lucho@ionkov.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: [PATCH 3/3] v9fs: zero copy implementation
Message-ID: <20060105005731.GC27375@ionkov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Performance enhancement reducing the number of copies in the data and
stat paths.

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>

---

 fs/9p/9p.c         |  302 ++++++++++--------
 fs/9p/9p.h         |   75 +++-
 fs/9p/Makefile     |   10 -
 fs/9p/conv.c       |  895 ++++++++++++++++++++++++++++++----------------------
 fs/9p/conv.h       |   30 +-
 fs/9p/debug.h      |   23 +
 fs/9p/error.c      |   10 -
 fs/9p/error.h      |    3 
 fs/9p/fid.c        |    3 
 fs/9p/mux.c        |  157 +++++----
 fs/9p/trans_sock.c |    1 
 fs/9p/v9fs.c       |    3 
 fs/9p/v9fs_vfs.h   |    5 
 fs/9p/vfs_dentry.c |    4 
 fs/9p/vfs_dir.c    |   31 +-
 fs/9p/vfs_file.c   |   25 -
 fs/9p/vfs_inode.c  |  545 ++++++++++----------------------
 fs/9p/vfs_super.c  |   10 -
 18 files changed, 1084 insertions(+), 1048 deletions(-)

af748019fb2545d38422bd4338c96677769abab9
diff --git a/fs/9p/9p.c b/fs/9p/9p.c
index 7831b9b..27db734 100644
--- a/fs/9p/9p.c
+++ b/fs/9p/9p.c
@@ -1,8 +1,9 @@
 /*
  *  linux/fs/9p/9p.c
  *
- *  This file contains functions 9P2000 functions
+ *  This file contains functions to perform synchronous 9P calls
  *
+ *  Copyright (C) 2004 by Latchesar Ionkov <lucho@ionkov.net>
  *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
  *
@@ -33,6 +34,7 @@
 #include "debug.h"
 #include "v9fs.h"
 #include "9p.h"
+#include "conv.h"
 #include "mux.h"
 
 /**
@@ -46,17 +48,21 @@
 
 int
 v9fs_t_version(struct v9fs_session_info *v9ses, u32 msize,
-	       char *version, struct v9fs_fcall **fcall)
+	       char *version, struct v9fs_fcall **rcp)
 {
-	struct v9fs_fcall msg;
+	int ret;
+	struct v9fs_fcall *tc;
 
 	dprintk(DEBUG_9P, "msize: %d version: %s\n", msize, version);
-	msg.id = TVERSION;
-	msg.tag = ~0;
-	msg.params.tversion.msize = msize;
-	msg.params.tversion.version = version;
+	tc = v9fs_create_tversion(msize, version);
 
-	return v9fs_mux_rpc(v9ses->mux, &msg, fcall);
+	if (!IS_ERR(tc)) {
+		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
+		kfree(tc);
+	} else
+		ret = PTR_ERR(tc);
+
+	return ret;
 }
 
 /**
@@ -72,19 +78,23 @@ v9fs_t_version(struct v9fs_session_info 
 
 int
 v9fs_t_attach(struct v9fs_session_info *v9ses, char *uname, char *aname,
-	      u32 fid, u32 afid, struct v9fs_fcall **fcall)
+	      u32 fid, u32 afid, struct v9fs_fcall **rcp)
 {
-	struct v9fs_fcall msg;
+	int ret;
+	struct v9fs_fcall* tc;
 
 	dprintk(DEBUG_9P, "uname '%s' aname '%s' fid %d afid %d\n", uname,
 		aname, fid, afid);
-	msg.id = TATTACH;
-	msg.params.tattach.fid = fid;
-	msg.params.tattach.afid = afid;
-	msg.params.tattach.uname = uname;
-	msg.params.tattach.aname = aname;
 
-	return v9fs_mux_rpc(v9ses->mux, &msg, fcall);
+	ret = -ENOMEM;
+	tc = v9fs_create_tattach(fid, afid, uname, aname);
+	if (!IS_ERR(tc)) {
+		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
+		kfree(tc);
+	} else
+		ret = PTR_ERR(tc);
+
+	return ret;
 }
 
 static void v9fs_t_clunk_cb(void *a, struct v9fs_fcall *tc, 
@@ -117,24 +127,28 @@ static void v9fs_t_clunk_cb(void *a, str
  * @fcall: pointer to response fcall pointer
  *
  */
+
 int
 v9fs_t_clunk(struct v9fs_session_info *v9ses, u32 fid)
 {
-	int err;
+	int ret;
 	struct v9fs_fcall *tc, *rc;
 
-	tc = kmalloc(sizeof(struct v9fs_fcall), GFP_KERNEL);
-
 	dprintk(DEBUG_9P, "fid %d\n", fid);
-	tc->id = TCLUNK;
-	tc->params.tclunk.fid = fid;
 
-	err = v9fs_mux_rpc(v9ses->mux, tc, &rc);
-	if (err >= 0) {
-		v9fs_t_clunk_cb(v9ses, tc, rc, 0);
-	}
+	ret = -ENOMEM;
+	rc = NULL;
+	tc = v9fs_create_tclunk(fid);
+	if (!IS_ERR(tc))
+		ret = v9fs_mux_rpc(v9ses->mux, tc, &rc);
+	else
+		ret = PTR_ERR(tc);
+
+	if (ret)
+		dprintk(DEBUG_ERROR, "failed fid %d err %d\n", fid, ret);
 
-	return err;
+	v9fs_t_clunk_cb(v9ses, tc, rc, ret);
+	return ret;
 }
 
 /**
@@ -144,14 +158,22 @@ v9fs_t_clunk(struct v9fs_session_info *v
  *
  */
 
-int v9fs_t_flush(struct v9fs_session_info *v9ses, u16 tag)
+int v9fs_t_flush(struct v9fs_session_info *v9ses, u16 oldtag)
 {
-	struct v9fs_fcall msg;
+	int ret;
+	struct v9fs_fcall *tc;
 
-	dprintk(DEBUG_9P, "oldtag %d\n", tag);
-	msg.id = TFLUSH;
-	msg.params.tflush.oldtag = tag;
-	return v9fs_mux_rpc(v9ses->mux, &msg, NULL);
+	dprintk(DEBUG_9P, "oldtag %d\n", oldtag);
+
+	ret = -ENOMEM;
+	tc = v9fs_create_tflush(oldtag);
+	if (!IS_ERR(tc)) {
+		ret = v9fs_mux_rpc(v9ses->mux, tc, NULL);
+		kfree(tc);
+	} else
+		ret = PTR_ERR(tc);
+
+	return ret;
 }
 
 /**
@@ -163,17 +185,22 @@ int v9fs_t_flush(struct v9fs_session_inf
  */
 
 int
-v9fs_t_stat(struct v9fs_session_info *v9ses, u32 fid, struct v9fs_fcall **fcall)
+v9fs_t_stat(struct v9fs_session_info *v9ses, u32 fid, struct v9fs_fcall **rcp)
 {
-	struct v9fs_fcall msg;
+	int ret;
+	struct v9fs_fcall *tc;
 
 	dprintk(DEBUG_9P, "fid %d\n", fid);
-	if (fcall)
-		*fcall = NULL;
 
-	msg.id = TSTAT;
-	msg.params.tstat.fid = fid;
-	return v9fs_mux_rpc(v9ses->mux, &msg, fcall);
+	ret = -ENOMEM;
+	tc = v9fs_create_tstat(fid);
+	if (!IS_ERR(tc)) {
+		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
+		kfree(tc);
+	} else
+		ret = PTR_ERR(tc);
+
+	return ret;
 }
 
 /**
@@ -187,16 +214,22 @@ v9fs_t_stat(struct v9fs_session_info *v9
 
 int
 v9fs_t_wstat(struct v9fs_session_info *v9ses, u32 fid,
-	     struct v9fs_stat *stat, struct v9fs_fcall **fcall)
+	     struct v9fs_wstat *wstat, struct v9fs_fcall **rcp)
 {
-	struct v9fs_fcall msg;
+	int ret;
+	struct v9fs_fcall *tc;
 
-	dprintk(DEBUG_9P, "fid %d length %d\n", fid, (int)stat->length);
-	msg.id = TWSTAT;
-	msg.params.twstat.fid = fid;
-	msg.params.twstat.stat = stat;
+	dprintk(DEBUG_9P, "fid %d\n", fid);
+
+	ret = -ENOMEM;
+	tc = v9fs_create_twstat(fid, wstat, v9ses->extended);
+	if (!IS_ERR(tc)) {
+		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
+		kfree(tc);
+	} else
+		ret = PTR_ERR(tc);
 
-	return v9fs_mux_rpc(v9ses->mux, &msg, fcall);
+	return ret;
 }
 
 /**
@@ -213,23 +246,28 @@ v9fs_t_wstat(struct v9fs_session_info *v
 
 int
 v9fs_t_walk(struct v9fs_session_info *v9ses, u32 fid, u32 newfid,
-	    char *name, struct v9fs_fcall **fcall)
+	    char *name, struct v9fs_fcall **rcp)
 {
-	struct v9fs_fcall msg;
+	int ret;
+	struct v9fs_fcall *tc;
+	int nwname;
 
 	dprintk(DEBUG_9P, "fid %d newfid %d wname '%s'\n", fid, newfid, name);
-	msg.id = TWALK;
-	msg.params.twalk.fid = fid;
-	msg.params.twalk.newfid = newfid;
-
-	if (name) {
-		msg.params.twalk.nwname = 1;
-		msg.params.twalk.wnames = &name;
-	} else {
-		msg.params.twalk.nwname = 0;
-	}
 
-	return v9fs_mux_rpc(v9ses->mux, &msg, fcall);
+	if (name)
+		nwname = 1;
+	else
+		nwname = 0;
+
+	ret = -ENOMEM;
+	tc = v9fs_create_twalk(fid, newfid, nwname, &name);
+	if (!IS_ERR(tc)) {
+		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
+		kfree(tc);
+	} else
+		ret = PTR_ERR(tc);
+
+	return ret;
 }
 
 /**
@@ -244,19 +282,22 @@ v9fs_t_walk(struct v9fs_session_info *v9
 
 int
 v9fs_t_open(struct v9fs_session_info *v9ses, u32 fid, u8 mode,
-	    struct v9fs_fcall **fcall)
+	    struct v9fs_fcall **rcp)
 {
-	struct v9fs_fcall msg;
-	int errorno = -1;
+	int ret;
+	struct v9fs_fcall *tc;
 
 	dprintk(DEBUG_9P, "fid %d mode %d\n", fid, mode);
-	msg.id = TOPEN;
-	msg.params.topen.fid = fid;
-	msg.params.topen.mode = mode;
 
-	errorno = v9fs_mux_rpc(v9ses->mux, &msg, fcall);
+	ret = -ENOMEM;
+	tc = v9fs_create_topen(fid, mode);
+	if (!IS_ERR(tc)) {
+		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
+		kfree(tc);
+	} else
+		ret = PTR_ERR(tc);
 
-	return errorno;
+	return ret;
 }
 
 /**
@@ -269,14 +310,22 @@ v9fs_t_open(struct v9fs_session_info *v9
 
 int
 v9fs_t_remove(struct v9fs_session_info *v9ses, u32 fid,
-	      struct v9fs_fcall **fcall)
+	      struct v9fs_fcall **rcp)
 {
-	struct v9fs_fcall msg;
+	int ret;
+	struct v9fs_fcall *tc;
 
 	dprintk(DEBUG_9P, "fid %d\n", fid);
-	msg.id = TREMOVE;
-	msg.params.tremove.fid = fid;
-	return v9fs_mux_rpc(v9ses->mux, &msg, fcall);
+
+	ret = -ENOMEM;
+	tc = v9fs_create_tremove(fid);
+	if (!IS_ERR(tc)) {
+		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
+		kfree(tc);
+	} else
+		ret = PTR_ERR(tc);
+
+	return ret;
 }
 
 /**
@@ -292,20 +341,23 @@ v9fs_t_remove(struct v9fs_session_info *
 
 int
 v9fs_t_create(struct v9fs_session_info *v9ses, u32 fid, char *name,
-	      u32 perm, u8 mode, struct v9fs_fcall **fcall)
+	      u32 perm, u8 mode, struct v9fs_fcall **rcp)
 {
-	struct v9fs_fcall msg;
+	int ret;
+	struct v9fs_fcall *tc;
 
 	dprintk(DEBUG_9P, "fid %d name '%s' perm %x mode %d\n",
 		fid, name, perm, mode);
 
-	msg.id = TCREATE;
-	msg.params.tcreate.fid = fid;
-	msg.params.tcreate.name = name;
-	msg.params.tcreate.perm = perm;
-	msg.params.tcreate.mode = mode;
+	ret = -ENOMEM;
+	tc = v9fs_create_tcreate(fid, name, perm, mode);
+	if (!IS_ERR(tc)) {
+		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
+		kfree(tc);
+	} else
+		ret = PTR_ERR(tc);
 
-	return v9fs_mux_rpc(v9ses->mux, &msg, fcall);
+	return ret;
 }
 
 /**
@@ -320,31 +372,30 @@ v9fs_t_create(struct v9fs_session_info *
 
 int
 v9fs_t_read(struct v9fs_session_info *v9ses, u32 fid, u64 offset,
-	    u32 count, struct v9fs_fcall **fcall)
+	    u32 count, struct v9fs_fcall **rcp)
 {
-	struct v9fs_fcall msg;
-	struct v9fs_fcall *rc = NULL;
-	long errorno = -1;
-
-	dprintk(DEBUG_9P, "fid %d offset 0x%lx count 0x%x\n", fid,
-		(long unsigned int)offset, count);
-	msg.id = TREAD;
-	msg.params.tread.fid = fid;
-	msg.params.tread.offset = offset;
-	msg.params.tread.count = count;
-	errorno = v9fs_mux_rpc(v9ses->mux, &msg, &rc);
-
-	if (!errorno) {
-		errorno = rc->params.rread.count;
-		dump_data(rc->params.rread.data, rc->params.rread.count);
-	}
+	int ret;
+	struct v9fs_fcall *tc, *rc;
 
-	if (fcall)
-		*fcall = rc;
-	else
-		kfree(rc);
+	dprintk(DEBUG_9P, "fid %d offset 0x%llux count 0x%x\n", fid,
+		(long long unsigned) offset, count);
 
-	return errorno;
+	ret = -ENOMEM;
+	tc = v9fs_create_tread(fid, offset, count);
+	if (!IS_ERR(tc)) {
+		ret = v9fs_mux_rpc(v9ses->mux, tc, &rc);
+		if (!ret)
+			ret = rc->params.rread.count;
+		if (rcp)
+			*rcp = rc;
+		else
+			kfree(rc);
+
+		kfree(tc);
+	} else
+		ret = PTR_ERR(tc);
+
+	return ret;
 }
 
 /**
@@ -358,32 +409,31 @@ v9fs_t_read(struct v9fs_session_info *v9
  */
 
 int
-v9fs_t_write(struct v9fs_session_info *v9ses, u32 fid,
-	     u64 offset, u32 count, void *data, struct v9fs_fcall **fcall)
+v9fs_t_write(struct v9fs_session_info *v9ses, u32 fid, u64 offset, u32 count, 
+	const char __user *data, struct v9fs_fcall **rcp)
 {
-	struct v9fs_fcall msg;
-	struct v9fs_fcall *rc = NULL;
-	long errorno = -1;
-
-	dprintk(DEBUG_9P, "fid %d offset 0x%llx count 0x%x\n", fid,
-		(unsigned long long)offset, count);
-	dump_data(data, count);
-
-	msg.id = TWRITE;
-	msg.params.twrite.fid = fid;
-	msg.params.twrite.offset = offset;
-	msg.params.twrite.count = count;
-	msg.params.twrite.data = data;
+	int ret;
+	struct v9fs_fcall *tc, *rc;
 
-	errorno = v9fs_mux_rpc(v9ses->mux, &msg, &rc);
+	dprintk(DEBUG_9P, "fid %d offset 0x%llux count 0x%x\n", fid,
+		(long long unsigned) offset, count);
 
-	if (!errorno)
-		errorno = rc->params.rwrite.count;
+	ret = -ENOMEM;
+	tc = v9fs_create_twrite(fid, offset, count, data);
+	if (!IS_ERR(tc)) {
+		ret = v9fs_mux_rpc(v9ses->mux, tc, &rc);
+
+		if (!ret)
+			ret = rc->params.rwrite.count;
+		if (rcp)
+			*rcp = rc;
+		else
+			kfree(rc);
+
+		kfree(tc);
+	} else
+		ret = PTR_ERR(tc);
 
-	if (fcall)
-		*fcall = rc;
-	else
-		kfree(rc);
-
-	return errorno;
+	return ret;
 }
+
diff --git a/fs/9p/9p.h b/fs/9p/9p.h
index 6355392..58ccd2c 100644
--- a/fs/9p/9p.h
+++ b/fs/9p/9p.h
@@ -3,6 +3,7 @@
  *
  * 9P protocol definitions.
  *
+ *  Copyright (C) 2005 by Latchesar Ionkov <lucho@ionkov.net>
  *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
  *
@@ -102,10 +103,16 @@ enum {
 
 #define V9FS_NOTAG	(u16)(~0)
 #define V9FS_NOFID	(u32)(~0)
+#define V9FS_MAXWELEM	16
 
 /* ample room for Twrite/Rread header (iounit) */
 #define V9FS_IOHDRSZ	24
 
+struct v9fs_str {
+	u16 len;
+	char *str;
+};
+
 /* qids are the unique ID for a file (like an inode */
 struct v9fs_qid {
 	u8 type;
@@ -123,6 +130,29 @@ struct v9fs_stat {
 	u32 atime;
 	u32 mtime;
 	u64 length;
+	struct v9fs_str name;
+	struct v9fs_str uid;
+	struct v9fs_str gid;
+	struct v9fs_str muid;
+	struct v9fs_str extension;	/* 9p2000.u extensions */
+	u32 n_uid;		/* 9p2000.u extensions */
+	u32 n_gid;		/* 9p2000.u extensions */
+	u32 n_muid;		/* 9p2000.u extensions */
+};
+
+/* file metadata (stat) structure used to create Twstat message
+   The is similar to v9fs_stat, but the strings don't point to 
+   the same memory block and should be freed separately
+*/
+struct v9fs_wstat {
+	u16 size;
+	u16 type;
+	u32 dev;
+	struct v9fs_qid qid;
+	u32 mode;
+	u32 atime;
+	u32 mtime;
+	u64 length;
 	char *name;
 	char *uid;
 	char *gid;
@@ -131,25 +161,24 @@ struct v9fs_stat {
 	u32 n_uid;		/* 9p2000.u extensions */
 	u32 n_gid;		/* 9p2000.u extensions */
 	u32 n_muid;		/* 9p2000.u extensions */
-	char data[0];
 };
 
 /* Structures for Protocol Operations */
 
 struct Tversion {
 	u32 msize;
-	char *version;
+	struct v9fs_str version;
 };
 
 struct Rversion {
 	u32 msize;
-	char *version;
+	struct v9fs_str version;
 };
 
 struct Tauth {
 	u32 afid;
-	char *uname;
-	char *aname;
+	struct v9fs_str uname;
+	struct v9fs_str aname;
 };
 
 struct Rauth {
@@ -157,12 +186,12 @@ struct Rauth {
 };
 
 struct Rerror {
-	char *error;
+	struct v9fs_str error;
 	u32 errno;		/* 9p2000.u extension */
 };
 
 struct Tflush {
-	u32 oldtag;
+	u16 oldtag;
 };
 
 struct Rflush {
@@ -171,8 +200,8 @@ struct Rflush {
 struct Tattach {
 	u32 fid;
 	u32 afid;
-	char *uname;
-	char *aname;
+	struct v9fs_str uname;
+	struct v9fs_str aname;
 };
 
 struct Rattach {
@@ -182,13 +211,13 @@ struct Rattach {
 struct Twalk {
 	u32 fid;
 	u32 newfid;
-	u32 nwname;
-	char **wnames;
+	u16 nwname;
+	struct v9fs_str wnames[16];
 };
 
 struct Rwalk {
-	u32 nwqid;
-	struct v9fs_qid *wqids;
+	u16 nwqid;
+	struct v9fs_qid wqids[16];
 };
 
 struct Topen {
@@ -203,7 +232,7 @@ struct Ropen {
 
 struct Tcreate {
 	u32 fid;
-	char *name;
+	struct v9fs_str name;
 	u32 perm;
 	u8 mode;
 };
@@ -254,12 +283,12 @@ struct Tstat {
 };
 
 struct Rstat {
-	struct v9fs_stat *stat;
+	struct v9fs_stat stat;
 };
 
 struct Twstat {
 	u32 fid;
-	struct v9fs_stat *stat;
+	struct v9fs_stat stat;
 };
 
 struct Rwstat {
@@ -274,6 +303,7 @@ struct v9fs_fcall {
 	u32 size;
 	u8 id;
 	u16 tag;
+	void *sdata;
 
 	union {
 		struct Tversion tversion;
@@ -306,10 +336,12 @@ struct v9fs_fcall {
 	} params;
 };
 
-#define V9FS_FCALLHDRSZ (sizeof(struct v9fs_fcall) + \
-	sizeof(struct v9fs_stat) + 16*sizeof(struct v9fs_qid) + 16)
+#define PRINT_FCALL_ERROR(s, fcall) dprintk(DEBUG_ERROR, "%s: %.*s\n", s, \
+	fcall?fcall->params.rerror.error.len:0, \
+	fcall?fcall->params.rerror.error.str:"");
 
-#define FCALL_ERROR(fcall) (fcall ? fcall->params.rerror.error : "")
+char *v9fs_str_copy(char *buf, int buflen, struct v9fs_str *str);
+int v9fs_str_compare(char *buf, struct v9fs_str *str);
 
 int v9fs_t_version(struct v9fs_session_info *v9ses, u32 msize,
 		   char *version, struct v9fs_fcall **rcall);
@@ -325,7 +357,7 @@ int v9fs_t_stat(struct v9fs_session_info
 		struct v9fs_fcall **rcall);
 
 int v9fs_t_wstat(struct v9fs_session_info *v9ses, u32 fid,
-		 struct v9fs_stat *stat, struct v9fs_fcall **rcall);
+		 struct v9fs_wstat *wstat, struct v9fs_fcall **rcall);
 
 int v9fs_t_walk(struct v9fs_session_info *v9ses, u32 fid, u32 newfid,
 		char *name, struct v9fs_fcall **rcall);
@@ -343,4 +375,5 @@ int v9fs_t_read(struct v9fs_session_info
 		u64 offset, u32 count, struct v9fs_fcall **rcall);
 
 int v9fs_t_write(struct v9fs_session_info *v9ses, u32 fid, u64 offset,
-		 u32 count, void *data, struct v9fs_fcall **rcall);
+		 u32 count, const char __user * data,
+		 struct v9fs_fcall **rcall);
diff --git a/fs/9p/Makefile b/fs/9p/Makefile
index e4e4ffe..3d02308 100644
--- a/fs/9p/Makefile
+++ b/fs/9p/Makefile
@@ -1,17 +1,17 @@
 obj-$(CONFIG_9P_FS) := 9p2000.o
 
 9p2000-objs := \
+	trans_fd.o \
+	trans_sock.o \
+	mux.o \
+	9p.o \
+	conv.o \
 	vfs_super.o \
 	vfs_inode.o \
 	vfs_file.o \
 	vfs_dir.o \
 	vfs_dentry.o \
 	error.o \
-	mux.o \
-	trans_fd.o \
-	trans_sock.o \
-	9p.o \
-	conv.o \
 	v9fs.o \
 	fid.o
 
diff --git a/fs/9p/conv.c b/fs/9p/conv.c
index 1b9b15d..838f969 100644
--- a/fs/9p/conv.c
+++ b/fs/9p/conv.c
@@ -30,7 +30,7 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/idr.h>
-
+#include <asm/uaccess.h>
 #include "debug.h"
 #include "v9fs.h"
 #include "9p.h"
@@ -45,6 +45,37 @@ struct cbuf {
 	unsigned char *ep;
 };
 
+char *v9fs_str_copy(char *buf, int buflen, struct v9fs_str *str)
+{
+	int n;
+
+	if (buflen < str->len)
+		n = buflen;
+	else
+		n = str->len;
+
+	memmove(buf, str->str, n - 1);
+
+	return buf;
+}
+
+int v9fs_str_compare(char *buf, struct v9fs_str *str)
+{
+	int n, ret;
+
+	ret = strncmp(buf, str->str, str->len);
+
+	if (!ret) {
+		n = strlen(buf);
+		if (n < str->len)
+			ret = -1;
+		else if (n > str->len)
+			ret = 1;
+	}
+
+	return ret;
+}
+
 static inline void buf_init(struct cbuf *buf, void *data, int datalen)
 {
 	buf->sp = buf->p = data;
@@ -58,12 +89,12 @@ static inline int buf_check_overflow(str
 
 static inline int buf_check_size(struct cbuf *buf, int len)
 {
-	if (buf->p+len > buf->ep) {
-		if (buf->p < buf->ep) {
-			eprintk(KERN_ERR, "buffer overflow\n");
-			buf->p = buf->ep + 1;
-			return 0;
-		}
+	if (buf->p + len > buf->ep && buf->p < buf->ep) {
+		eprintk(KERN_ERR, "buffer overflow: want %d has %d\n",
+			len, (int)(buf->ep - buf->p));
+		dump_stack();
+		buf->p = buf->ep + 1;
+		return 0;
 	}
 
 	return 1;
@@ -127,14 +158,6 @@ static inline void buf_put_string(struct
 	buf_put_stringn(buf, s, strlen(s));
 }
 
-static inline void buf_put_data(struct cbuf *buf, void *data, u32 datalen)
-{
-	if (buf_check_size(buf, datalen)) {
-		memcpy(buf->p, data, datalen);
-		buf->p += datalen;
-	}
-}
-
 static inline u8 buf_get_int8(struct cbuf *buf)
 {
 	u8 ret = 0;
@@ -183,85 +206,37 @@ static inline u64 buf_get_int64(struct c
 	return ret;
 }
 
-static inline int
-buf_get_string(struct cbuf *buf, char *data, unsigned int datalen)
+static inline void buf_get_str(struct cbuf *buf, struct v9fs_str *vstr)
 {
-	u16 len = 0;
-
-	len = buf_get_int16(buf);
-	if (!buf_check_overflow(buf) && buf_check_size(buf, len) && len+1>datalen) {
-		memcpy(data, buf->p, len);
-		data[len] = 0;
-		buf->p += len;
-		len++;
+	vstr->len = buf_get_int16(buf);
+	if (!buf_check_overflow(buf) && buf_check_size(buf, vstr->len)) {
+		vstr->str = buf->p;
+		buf->p += vstr->len;
+	} else {
+		vstr->len = 0;
+		vstr->str = NULL;
 	}
-
-	return len;
 }
 
-static inline char *buf_get_stringb(struct cbuf *buf, struct cbuf *sbuf)
+static inline void buf_get_qid(struct cbuf *bufp, struct v9fs_qid *qid)
 {
-	char *ret;
-	u16 len;
-
-	ret = NULL;
-	len = buf_get_int16(buf);
-
-	if (!buf_check_overflow(buf) && buf_check_size(buf, len) &&
-		buf_check_size(sbuf, len + 1)) {
-
-		memcpy(sbuf->p, buf->p, len);
-		sbuf->p[len] = 0;
-		ret = sbuf->p;
-		buf->p += len;
-		sbuf->p += len + 1;
-	}
-
-	return ret;
-}
-
-static inline int buf_get_data(struct cbuf *buf, void *data, int datalen)
-{
-	int ret = 0;
-
-	if (buf_check_size(buf, datalen)) {
-		memcpy(data, buf->p, datalen);
-		buf->p += datalen;
-		ret = datalen;
-	}
-
-	return ret;
-}
-
-static inline void *buf_get_datab(struct cbuf *buf, struct cbuf *dbuf,
-				  int datalen)
-{
-	char *ret = NULL;
-	int n = 0;
-
-	if (buf_check_size(dbuf, datalen)) {
-		n = buf_get_data(buf, dbuf->p, datalen);
-		if (n > 0) {
-			ret = dbuf->p;
-			dbuf->p += n;
-		}
-	}
-
-	return ret;
+	qid->type = buf_get_int8(bufp);
+	qid->version = buf_get_int32(bufp);
+	qid->path = buf_get_int64(bufp);
 }
 
 /**
- * v9fs_size_stat - calculate the size of a variable length stat struct
+ * v9fs_size_wstat - calculate the size of a variable length stat struct
  * @stat: metadata (stat) structure
  * @extended: non-zero if 9P2000.u
  *
  */
 
-static int v9fs_size_stat(struct v9fs_stat *stat, int extended)
+static int v9fs_size_wstat(struct v9fs_wstat *wstat, int extended)
 {
 	int size = 0;
 
-	if (stat == NULL) {
+	if (wstat == NULL) {
 		eprintk(KERN_ERR, "v9fs_size_stat: got a NULL stat pointer\n");
 		return 0;
 	}
@@ -278,81 +253,38 @@ static int v9fs_size_stat(struct v9fs_st
 	    8 +			/* length[8] */
 	    8;			/* minimum sum of string lengths */
 
-	if (stat->name)
-		size += strlen(stat->name);
-	if (stat->uid)
-		size += strlen(stat->uid);
-	if (stat->gid)
-		size += strlen(stat->gid);
-	if (stat->muid)
-		size += strlen(stat->muid);
+	if (wstat->name)
+		size += strlen(wstat->name);
+	if (wstat->uid)
+		size += strlen(wstat->uid);
+	if (wstat->gid)
+		size += strlen(wstat->gid);
+	if (wstat->muid)
+		size += strlen(wstat->muid);
 
 	if (extended) {
 		size += 4 +	/* n_uid[4] */
 		    4 +		/* n_gid[4] */
 		    4 +		/* n_muid[4] */
 		    2;		/* string length of extension[4] */
-		if (stat->extension)
-			size += strlen(stat->extension);
+		if (wstat->extension)
+			size += strlen(wstat->extension);
 	}
 
 	return size;
 }
 
 /**
- * serialize_stat - safely format a stat structure for transmission
- * @stat: metadata (stat) structure
- * @bufp: buffer to serialize structure into
- * @extended: non-zero if 9P2000.u
- *
- */
-
-static int
-serialize_stat(struct v9fs_stat *stat, struct cbuf *bufp, int extended)
-{
-	buf_put_int16(bufp, stat->size);
-	buf_put_int16(bufp, stat->type);
-	buf_put_int32(bufp, stat->dev);
-	buf_put_int8(bufp, stat->qid.type);
-	buf_put_int32(bufp, stat->qid.version);
-	buf_put_int64(bufp, stat->qid.path);
-	buf_put_int32(bufp, stat->mode);
-	buf_put_int32(bufp, stat->atime);
-	buf_put_int32(bufp, stat->mtime);
-	buf_put_int64(bufp, stat->length);
-
-	buf_put_string(bufp, stat->name);
-	buf_put_string(bufp, stat->uid);
-	buf_put_string(bufp, stat->gid);
-	buf_put_string(bufp, stat->muid);
-
-	if (extended) {
-		buf_put_string(bufp, stat->extension);
-		buf_put_int32(bufp, stat->n_uid);
-		buf_put_int32(bufp, stat->n_gid);
-		buf_put_int32(bufp, stat->n_muid);
-	}
-
-	if (buf_check_overflow(bufp))
-		return 0;
-
-	return stat->size;
-}
-
-/**
- * deserialize_stat - safely decode a recieved metadata (stat) structure
+ * buf_get_stat - safely decode a recieved metadata (stat) structure
  * @bufp: buffer to deserialize
  * @stat: metadata (stat) structure
- * @dbufp: buffer to deserialize variable strings into
  * @extended: non-zero if 9P2000.u
  *
  */
 
-static inline int
-deserialize_stat(struct cbuf *bufp, struct v9fs_stat *stat,
-		 struct cbuf *dbufp, int extended)
+static inline void
+buf_get_stat(struct cbuf *bufp, struct v9fs_stat *stat, int extended)
 {
-
 	stat->size = buf_get_int16(bufp);
 	stat->type = buf_get_int16(bufp);
 	stat->dev = buf_get_int32(bufp);
@@ -363,45 +295,17 @@ deserialize_stat(struct cbuf *bufp, stru
 	stat->atime = buf_get_int32(bufp);
 	stat->mtime = buf_get_int32(bufp);
 	stat->length = buf_get_int64(bufp);
-	stat->name = buf_get_stringb(bufp, dbufp);
-	stat->uid = buf_get_stringb(bufp, dbufp);
-	stat->gid = buf_get_stringb(bufp, dbufp);
-	stat->muid = buf_get_stringb(bufp, dbufp);
+	buf_get_str(bufp, &stat->name);
+	buf_get_str(bufp, &stat->uid);
+	buf_get_str(bufp, &stat->gid);
+	buf_get_str(bufp, &stat->muid);
 
 	if (extended) {
-		stat->extension = buf_get_stringb(bufp, dbufp);
+		buf_get_str(bufp, &stat->extension);
 		stat->n_uid = buf_get_int32(bufp);
 		stat->n_gid = buf_get_int32(bufp);
 		stat->n_muid = buf_get_int32(bufp);
 	}
-
-	if (buf_check_overflow(bufp) || buf_check_overflow(dbufp))
-		return 0;
-
-	return stat->size + 2;
-}
-
-/**
- * deserialize_statb - wrapper for decoding a received metadata structure
- * @bufp: buffer to deserialize
- * @dbufp: buffer to deserialize variable strings into
- * @extended: non-zero if 9P2000.u
- *
- */
-
-static inline struct v9fs_stat *deserialize_statb(struct cbuf *bufp,
-						  struct cbuf *dbufp,
-						  int extended)
-{
-	struct v9fs_stat *ret = buf_alloc(dbufp, sizeof(struct v9fs_stat));
-
-	if (ret) {
-		int n = deserialize_stat(bufp, ret, dbufp, extended);
-		if (n <= 0)
-			return NULL;
-	}
-
-	return ret;
 }
 
 /**
@@ -409,194 +313,27 @@ static inline struct v9fs_stat *deserial
  * @buf: buffer to deserialize
  * @buflen: length of received buffer
  * @stat: metadata structure to decode into
- * @statlen: length of destination metadata structure
  * @extended: non-zero if 9P2000.u
  *
+ * Note: stat will point to the buf region.
  */
 
-int v9fs_deserialize_stat(void *buf, u32 buflen, struct v9fs_stat *stat,
-			  u32 statlen, int extended)
+int 
+v9fs_deserialize_stat(void *buf, u32 buflen, struct v9fs_stat *stat, 
+		int extended)
 {
 	struct cbuf buffer;
 	struct cbuf *bufp = &buffer;
-	struct cbuf dbuffer;
-	struct cbuf *dbufp = &dbuffer;
+	unsigned char *p;
 
 	buf_init(bufp, buf, buflen);
-	buf_init(dbufp, (char *)stat + sizeof(struct v9fs_stat),
-		 statlen - sizeof(struct v9fs_stat));
-
-	return deserialize_stat(bufp, stat, dbufp, extended);
-}
-
-static inline int v9fs_size_fcall(struct v9fs_fcall *fcall, int extended)
-{
-	int size = 4 + 1 + 2;	/* size[4] msg[1] tag[2] */
-	int i = 0;
+	p = bufp->p;
+	buf_get_stat(bufp, stat, extended);
 
-	switch (fcall->id) {
-	default:
-		eprintk(KERN_ERR, "bad msg type %d\n", fcall->id);
+	if (buf_check_overflow(bufp))
 		return 0;
-	case TVERSION:		/* msize[4] version[s] */
-		size += 4 + 2 + strlen(fcall->params.tversion.version);
-		break;
-	case TAUTH:		/* afid[4] uname[s] aname[s] */
-		size += 4 + 2 + strlen(fcall->params.tauth.uname) +
-		    2 + strlen(fcall->params.tauth.aname);
-		break;
-	case TFLUSH:		/* oldtag[2] */
-		size += 2;
-		break;
-	case TATTACH:		/* fid[4] afid[4] uname[s] aname[s] */
-		size += 4 + 4 + 2 + strlen(fcall->params.tattach.uname) +
-		    2 + strlen(fcall->params.tattach.aname);
-		break;
-	case TWALK:		/* fid[4] newfid[4] nwname[2] nwname*(wname[s]) */
-		size += 4 + 4 + 2;
-		/* now compute total for the array of names */
-		for (i = 0; i < fcall->params.twalk.nwname; i++)
-			size += 2 + strlen(fcall->params.twalk.wnames[i]);
-		break;
-	case TOPEN:		/* fid[4] mode[1] */
-		size += 4 + 1;
-		break;
-	case TCREATE:		/* fid[4] name[s] perm[4] mode[1] */
-		size += 4 + 2 + strlen(fcall->params.tcreate.name) + 4 + 1;
-		break;
-	case TREAD:		/* fid[4] offset[8] count[4] */
-		size += 4 + 8 + 4;
-		break;
-	case TWRITE:		/* fid[4] offset[8] count[4] data[count] */
-		size += 4 + 8 + 4 + fcall->params.twrite.count;
-		break;
-	case TCLUNK:		/* fid[4] */
-		size += 4;
-		break;
-	case TREMOVE:		/* fid[4] */
-		size += 4;
-		break;
-	case TSTAT:		/* fid[4] */
-		size += 4;
-		break;
-	case TWSTAT:		/* fid[4] stat[n] */
-		fcall->params.twstat.stat->size =
-		    v9fs_size_stat(fcall->params.twstat.stat, extended);
-		size += 4 + 2 + 2 + fcall->params.twstat.stat->size;
-	}
-	return size;
-}
-
-/*
- * v9fs_serialize_fcall - marshall fcall struct into a packet
- * @fcall: structure to convert
- * @data: buffer to serialize fcall into
- * @datalen: length of buffer to serialize fcall into
- * @extended: non-zero if 9P2000.u
- *
- */
-
-int
-v9fs_serialize_fcall(struct v9fs_fcall *fcall, void *data, u32 datalen,
-		     int extended)
-{
-	int i = 0;
-	struct v9fs_stat *stat = NULL;
-	struct cbuf buffer;
-	struct cbuf *bufp = &buffer;
-
-	buf_init(bufp, data, datalen);
-
-	if (!fcall) {
-		eprintk(KERN_ERR, "no fcall\n");
-		return -EINVAL;
-	}
-
-	fcall->size = v9fs_size_fcall(fcall, extended);
-
-	buf_put_int32(bufp, fcall->size);
-	buf_put_int8(bufp, fcall->id);
-	buf_put_int16(bufp, fcall->tag);
-
-	dprintk(DEBUG_CONV, "size %d id %d tag %d\n", fcall->size, fcall->id,
-		fcall->tag);
-
-	/* now encode it */
-	switch (fcall->id) {
-	default:
-		eprintk(KERN_ERR, "bad msg type: %d\n", fcall->id);
-		return -EPROTO;
-	case TVERSION:
-		buf_put_int32(bufp, fcall->params.tversion.msize);
-		buf_put_string(bufp, fcall->params.tversion.version);
-		break;
-	case TAUTH:
-		buf_put_int32(bufp, fcall->params.tauth.afid);
-		buf_put_string(bufp, fcall->params.tauth.uname);
-		buf_put_string(bufp, fcall->params.tauth.aname);
-		break;
-	case TFLUSH:
-		buf_put_int16(bufp, fcall->params.tflush.oldtag);
-		break;
-	case TATTACH:
-		buf_put_int32(bufp, fcall->params.tattach.fid);
-		buf_put_int32(bufp, fcall->params.tattach.afid);
-		buf_put_string(bufp, fcall->params.tattach.uname);
-		buf_put_string(bufp, fcall->params.tattach.aname);
-		break;
-	case TWALK:
-		buf_put_int32(bufp, fcall->params.twalk.fid);
-		buf_put_int32(bufp, fcall->params.twalk.newfid);
-		buf_put_int16(bufp, fcall->params.twalk.nwname);
-		for (i = 0; i < fcall->params.twalk.nwname; i++)
-			buf_put_string(bufp, fcall->params.twalk.wnames[i]);
-		break;
-	case TOPEN:
-		buf_put_int32(bufp, fcall->params.topen.fid);
-		buf_put_int8(bufp, fcall->params.topen.mode);
-		break;
-	case TCREATE:
-		buf_put_int32(bufp, fcall->params.tcreate.fid);
-		buf_put_string(bufp, fcall->params.tcreate.name);
-		buf_put_int32(bufp, fcall->params.tcreate.perm);
-		buf_put_int8(bufp, fcall->params.tcreate.mode);
-		break;
-	case TREAD:
-		buf_put_int32(bufp, fcall->params.tread.fid);
-		buf_put_int64(bufp, fcall->params.tread.offset);
-		buf_put_int32(bufp, fcall->params.tread.count);
-		break;
-	case TWRITE:
-		buf_put_int32(bufp, fcall->params.twrite.fid);
-		buf_put_int64(bufp, fcall->params.twrite.offset);
-		buf_put_int32(bufp, fcall->params.twrite.count);
-		buf_put_data(bufp, fcall->params.twrite.data,
-			     fcall->params.twrite.count);
-		break;
-	case TCLUNK:
-		buf_put_int32(bufp, fcall->params.tclunk.fid);
-		break;
-	case TREMOVE:
-		buf_put_int32(bufp, fcall->params.tremove.fid);
-		break;
-	case TSTAT:
-		buf_put_int32(bufp, fcall->params.tstat.fid);
-		break;
-	case TWSTAT:
-		buf_put_int32(bufp, fcall->params.twstat.fid);
-		stat = fcall->params.twstat.stat;
-
-		buf_put_int16(bufp, stat->size + 2);
-		serialize_stat(stat, bufp, extended);
-		break;
-	}
-
-	if (buf_check_overflow(bufp)) {
-		dprintk(DEBUG_ERROR, "buffer overflow\n");
-		return -EIO;
-	}
-
-	return fcall->size;
+	else
+		return bufp->p - p;
 }
 
 /**
@@ -611,18 +348,14 @@ v9fs_serialize_fcall(struct v9fs_fcall *
 
 int
 v9fs_deserialize_fcall(void *buf, u32 buflen, struct v9fs_fcall *rcall,
-		       int rcalllen, int extended)
+		       int extended)
 {
 
 	struct cbuf buffer;
 	struct cbuf *bufp = &buffer;
-	struct cbuf dbuffer;
-	struct cbuf *dbufp = &dbuffer;
 	int i = 0;
 
 	buf_init(bufp, buf, buflen);
-	buf_init(dbufp, (char *)rcall + sizeof(struct v9fs_fcall),
-		 rcalllen - sizeof(struct v9fs_fcall));
 
 	rcall->size = buf_get_int32(bufp);
 	rcall->id = buf_get_int8(bufp);
@@ -630,13 +363,14 @@ v9fs_deserialize_fcall(void *buf, u32 bu
 
 	dprintk(DEBUG_CONV, "size %d id %d tag %d\n", rcall->size, rcall->id,
 		rcall->tag);
+
 	switch (rcall->id) {
 	default:
 		eprintk(KERN_ERR, "unknown message type: %d\n", rcall->id);
 		return -EPROTO;
 	case RVERSION:
 		rcall->params.rversion.msize = buf_get_int32(bufp);
-		rcall->params.rversion.version = buf_get_stringb(bufp, dbufp);
+		buf_get_str(bufp, &rcall->params.rversion.version);
 		break;
 	case RFLUSH:
 		break;
@@ -647,40 +381,27 @@ v9fs_deserialize_fcall(void *buf, u32 bu
 		break;
 	case RWALK:
 		rcall->params.rwalk.nwqid = buf_get_int16(bufp);
-		if (rcall->params.rwalk.nwqid > 16) {
-			eprintk(KERN_ERR, "Rwalk with more than 16 qids: %d\n",
-				rcall->params.rwalk.nwqid);
+		if (rcall->params.rwalk.nwqid > V9FS_MAXWELEM) {
+			eprintk(KERN_ERR, "Rwalk with more than %d qids: %d\n",
+				V9FS_MAXWELEM, rcall->params.rwalk.nwqid);
 			return -EPROTO;
 		}
 
-		rcall->params.rwalk.wqids = buf_alloc(dbufp,
-		      rcall->params.rwalk.nwqid * sizeof(struct v9fs_qid));
-		if (rcall->params.rwalk.wqids)
-			for (i = 0; i < rcall->params.rwalk.nwqid; i++) {
-				rcall->params.rwalk.wqids[i].type =
-				    buf_get_int8(bufp);
-				rcall->params.rwalk.wqids[i].version =
-				    buf_get_int16(bufp);
-				rcall->params.rwalk.wqids[i].path =
-				    buf_get_int64(bufp);
-			}
+		for (i = 0; i < rcall->params.rwalk.nwqid; i++)
+			buf_get_qid(bufp, &rcall->params.rwalk.wqids[i]);
 		break;
 	case ROPEN:
-		rcall->params.ropen.qid.type = buf_get_int8(bufp);
-		rcall->params.ropen.qid.version = buf_get_int32(bufp);
-		rcall->params.ropen.qid.path = buf_get_int64(bufp);
+		buf_get_qid(bufp, &rcall->params.ropen.qid);
 		rcall->params.ropen.iounit = buf_get_int32(bufp);
 		break;
 	case RCREATE:
-		rcall->params.rcreate.qid.type = buf_get_int8(bufp);
-		rcall->params.rcreate.qid.version = buf_get_int32(bufp);
-		rcall->params.rcreate.qid.path = buf_get_int64(bufp);
+		buf_get_qid(bufp, &rcall->params.rcreate.qid);
 		rcall->params.rcreate.iounit = buf_get_int32(bufp);
 		break;
 	case RREAD:
 		rcall->params.rread.count = buf_get_int32(bufp);
-		rcall->params.rread.data = buf_get_datab(bufp, dbufp,
-			rcall->params.rread.count);
+		rcall->params.rread.data = bufp->p;
+		buf_check_size(bufp, rcall->params.rread.count);
 		break;
 	case RWRITE:
 		rcall->params.rwrite.count = buf_get_int32(bufp);
@@ -691,22 +412,442 @@ v9fs_deserialize_fcall(void *buf, u32 bu
 		break;
 	case RSTAT:
 		buf_get_int16(bufp);
-		rcall->params.rstat.stat =
-		    deserialize_statb(bufp, dbufp, extended);
+		buf_get_stat(bufp, &rcall->params.rstat.stat, extended);
 		break;
 	case RWSTAT:
 		break;
 	case RERROR:
-		rcall->params.rerror.error = buf_get_stringb(bufp, dbufp);
+		buf_get_str(bufp, &rcall->params.rerror.error);
 		if (extended)
 			rcall->params.rerror.errno = buf_get_int16(bufp);
 		break;
 	}
 
-	if (buf_check_overflow(bufp) || buf_check_overflow(dbufp)) {
+	if (buf_check_overflow(bufp)) {
 		dprintk(DEBUG_ERROR, "buffer overflow\n");
 		return -EIO;
 	}
 
-	return rcall->size;
+	return bufp->p - bufp->sp;
+}
+
+static inline void v9fs_put_int8(struct cbuf *bufp, u8 val, u8 * p)
+{
+	*p = val;
+	buf_put_int8(bufp, val);
+}
+
+static inline void v9fs_put_int16(struct cbuf *bufp, u16 val, u16 * p)
+{
+	*p = val;
+	buf_put_int16(bufp, val);
+}
+
+static inline void v9fs_put_int32(struct cbuf *bufp, u32 val, u32 * p)
+{
+	*p = val;
+	buf_put_int32(bufp, val);
+}
+
+static inline void v9fs_put_int64(struct cbuf *bufp, u64 val, u64 * p)
+{
+	*p = val;
+	buf_put_int64(bufp, val);
+}
+
+static inline void
+v9fs_put_str(struct cbuf *bufp, char *data, struct v9fs_str *str)
+{
+	if (data) {
+		str->len = strlen(data);
+		str->str = bufp->p;
+	} else {
+		str->len = 0;
+		str->str = NULL;
+	}
+
+	buf_put_stringn(bufp, data, str->len);
+}
+
+static inline int
+v9fs_put_user_data(struct cbuf *bufp, const char __user * data, int count,
+		   unsigned char **pdata)
+{
+	*pdata = buf_alloc(bufp, count);
+	return copy_from_user(*pdata, data, count);
+}
+
+static void
+v9fs_put_wstat(struct cbuf *bufp, struct v9fs_wstat *wstat,
+	       struct v9fs_stat *stat, int statsz, int extended)
+{
+	v9fs_put_int16(bufp, statsz, &stat->size);
+	v9fs_put_int16(bufp, wstat->type, &stat->type);
+	v9fs_put_int32(bufp, wstat->dev, &stat->dev);
+	v9fs_put_int8(bufp, wstat->qid.type, &stat->qid.type);
+	v9fs_put_int32(bufp, wstat->qid.version, &stat->qid.version);
+	v9fs_put_int64(bufp, wstat->qid.path, &stat->qid.path);
+	v9fs_put_int32(bufp, wstat->mode, &stat->mode);
+	v9fs_put_int32(bufp, wstat->atime, &stat->atime);
+	v9fs_put_int32(bufp, wstat->mtime, &stat->mtime);
+	v9fs_put_int64(bufp, wstat->length, &stat->length);
+
+	v9fs_put_str(bufp, wstat->name, &stat->name);
+	v9fs_put_str(bufp, wstat->uid, &stat->uid);
+	v9fs_put_str(bufp, wstat->gid, &stat->gid);
+	v9fs_put_str(bufp, wstat->muid, &stat->muid);
+
+	if (extended) {
+		v9fs_put_str(bufp, wstat->extension, &stat->extension);
+		v9fs_put_int32(bufp, wstat->n_uid, &stat->n_uid);
+		v9fs_put_int32(bufp, wstat->n_gid, &stat->n_gid);
+		v9fs_put_int32(bufp, wstat->n_muid, &stat->n_muid);
+	}
+}
+
+static struct v9fs_fcall *
+v9fs_create_common(struct cbuf *bufp, u32 size, u8 id)
+{
+	struct v9fs_fcall *fc;
+
+	size += 4 + 1 + 2;	/* size[4] id[1] tag[2] */
+	fc = kmalloc(sizeof(struct v9fs_fcall) + size, GFP_KERNEL);
+	if (!fc)
+		return ERR_PTR(-ENOMEM);
+
+	fc->sdata = (char *)fc + sizeof(*fc);
+
+	buf_init(bufp, (char *)fc->sdata, size);
+	v9fs_put_int32(bufp, size, &fc->size);
+	v9fs_put_int8(bufp, id, &fc->id);
+	v9fs_put_int16(bufp, V9FS_NOTAG, &fc->tag);
+
+	return fc;
+}
+
+void v9fs_set_tag(struct v9fs_fcall *fc, u16 tag)
+{
+	*(__le16 *) (fc->sdata + 5) = cpu_to_le16(tag);
+}
+
+struct v9fs_fcall *v9fs_create_tversion(u32 msize, char *version)
+{
+	int size;
+	struct v9fs_fcall *fc;
+	struct cbuf buffer;
+	struct cbuf *bufp = &buffer;
+
+	size = 4 + 2 + strlen(version);	/* msize[4] version[s] */
+	fc = v9fs_create_common(bufp, size, TVERSION);
+	if (IS_ERR(fc))
+		goto error;
+
+	v9fs_put_int32(bufp, msize, &fc->params.tversion.msize);
+	v9fs_put_str(bufp, version, &fc->params.tversion.version);
+
+	if (buf_check_overflow(bufp)) {
+		kfree(fc);
+		fc = ERR_PTR(-ENOMEM);
+	}
+      error:
+	return fc;
+}
+
+struct v9fs_fcall *v9fs_create_tauth(u32 afid, char *uname, char *aname)
+{
+	int size;
+	struct v9fs_fcall *fc;
+	struct cbuf buffer;
+	struct cbuf *bufp = &buffer;
+
+	size = 4 + 2 + strlen(uname) + 2 + strlen(aname);	/* afid[4] uname[s] aname[s] */
+	fc = v9fs_create_common(bufp, size, TAUTH);
+	if (IS_ERR(fc))
+		goto error;
+
+	v9fs_put_int32(bufp, afid, &fc->params.tauth.afid);
+	v9fs_put_str(bufp, uname, &fc->params.tauth.uname);
+	v9fs_put_str(bufp, aname, &fc->params.tauth.aname);
+
+	if (buf_check_overflow(bufp)) {
+		kfree(fc);
+		fc = ERR_PTR(-ENOMEM);
+	}
+      error:
+	return fc;
+}
+
+struct v9fs_fcall *
+v9fs_create_tattach(u32 fid, u32 afid, char *uname, char *aname)
+{
+	int size;
+	struct v9fs_fcall *fc;
+	struct cbuf buffer;
+	struct cbuf *bufp = &buffer;
+
+	size = 4 + 4 + 2 + strlen(uname) + 2 + strlen(aname);	/* fid[4] afid[4] uname[s] aname[s] */
+	fc = v9fs_create_common(bufp, size, TATTACH);
+	if (IS_ERR(fc))
+		goto error;
+
+	v9fs_put_int32(bufp, fid, &fc->params.tattach.fid);
+	v9fs_put_int32(bufp, afid, &fc->params.tattach.afid);
+	v9fs_put_str(bufp, uname, &fc->params.tattach.uname);
+	v9fs_put_str(bufp, aname, &fc->params.tattach.aname);
+
+      error:
+	return fc;
+}
+
+struct v9fs_fcall *v9fs_create_tflush(u16 oldtag)
+{
+	int size;
+	struct v9fs_fcall *fc;
+	struct cbuf buffer;
+	struct cbuf *bufp = &buffer;
+
+	size = 2;		/* oldtag[2] */
+	fc = v9fs_create_common(bufp, size, TFLUSH);
+	if (IS_ERR(fc))
+		goto error;
+
+	v9fs_put_int16(bufp, oldtag, &fc->params.tflush.oldtag);
+
+	if (buf_check_overflow(bufp)) {
+		kfree(fc);
+		fc = ERR_PTR(-ENOMEM);
+	}
+      error:
+	return fc;
+}
+
+struct v9fs_fcall *v9fs_create_twalk(u32 fid, u32 newfid, u16 nwname,
+				     char **wnames)
+{
+	int i, size;
+	struct v9fs_fcall *fc;
+	struct cbuf buffer;
+	struct cbuf *bufp = &buffer;
+
+	if (nwname > V9FS_MAXWELEM) {
+		dprintk(DEBUG_ERROR, "nwname > %d\n", V9FS_MAXWELEM);
+		return NULL;
+	}
+
+	size = 4 + 4 + 2;	/* fid[4] newfid[4] nwname[2] ... */
+	for (i = 0; i < nwname; i++) {
+		size += 2 + strlen(wnames[i]);	/* wname[s] */
+	}
+
+	fc = v9fs_create_common(bufp, size, TWALK);
+	if (IS_ERR(fc))
+		goto error;
+
+	v9fs_put_int32(bufp, fid, &fc->params.twalk.fid);
+	v9fs_put_int32(bufp, newfid, &fc->params.twalk.newfid);
+	v9fs_put_int16(bufp, nwname, &fc->params.twalk.nwname);
+	for (i = 0; i < nwname; i++) {
+		v9fs_put_str(bufp, wnames[i], &fc->params.twalk.wnames[i]);
+	}
+
+	if (buf_check_overflow(bufp)) {
+		kfree(fc);
+		fc = ERR_PTR(-ENOMEM);
+	}
+      error:
+	return fc;
+}
+
+struct v9fs_fcall *v9fs_create_topen(u32 fid, u8 mode)
+{
+	int size;
+	struct v9fs_fcall *fc;
+	struct cbuf buffer;
+	struct cbuf *bufp = &buffer;
+
+	size = 4 + 1;		/* fid[4] mode[1] */
+	fc = v9fs_create_common(bufp, size, TOPEN);
+	if (IS_ERR(fc))
+		goto error;
+
+	v9fs_put_int32(bufp, fid, &fc->params.topen.fid);
+	v9fs_put_int8(bufp, mode, &fc->params.topen.mode);
+
+	if (buf_check_overflow(bufp)) {
+		kfree(fc);
+		fc = ERR_PTR(-ENOMEM);
+	}
+      error:
+	return fc;
+}
+
+struct v9fs_fcall *v9fs_create_tcreate(u32 fid, char *name, u32 perm, u8 mode)
+{
+	int size;
+	struct v9fs_fcall *fc;
+	struct cbuf buffer;
+	struct cbuf *bufp = &buffer;
+
+	size = 4 + 2 + strlen(name) + 4 + 1;	/* fid[4] name[s] perm[4] mode[1] */
+	fc = v9fs_create_common(bufp, size, TCREATE);
+	if (IS_ERR(fc))
+		goto error;
+
+	v9fs_put_int32(bufp, fid, &fc->params.tcreate.fid);
+	v9fs_put_str(bufp, name, &fc->params.tcreate.name);
+	v9fs_put_int32(bufp, perm, &fc->params.tcreate.perm);
+	v9fs_put_int8(bufp, mode, &fc->params.tcreate.mode);
+
+	if (buf_check_overflow(bufp)) {
+		kfree(fc);
+		fc = ERR_PTR(-ENOMEM);
+	}
+      error:
+	return fc;
+}
+
+struct v9fs_fcall *v9fs_create_tread(u32 fid, u64 offset, u32 count)
+{
+	int size;
+	struct v9fs_fcall *fc;
+	struct cbuf buffer;
+	struct cbuf *bufp = &buffer;
+
+	size = 4 + 8 + 4;	/* fid[4] offset[8] count[4] */
+	fc = v9fs_create_common(bufp, size, TREAD);
+	if (IS_ERR(fc))
+		goto error;
+
+	v9fs_put_int32(bufp, fid, &fc->params.tread.fid);
+	v9fs_put_int64(bufp, offset, &fc->params.tread.offset);
+	v9fs_put_int32(bufp, count, &fc->params.tread.count);
+
+	if (buf_check_overflow(bufp)) {
+		kfree(fc);
+		fc = ERR_PTR(-ENOMEM);
+	}
+      error:
+	return fc;
+}
+
+struct v9fs_fcall *v9fs_create_twrite(u32 fid, u64 offset, u32 count,
+				      const char __user * data)
+{
+	int size, err;
+	struct v9fs_fcall *fc;
+	struct cbuf buffer;
+	struct cbuf *bufp = &buffer;
+
+	size = 4 + 8 + 4 + count;	/* fid[4] offset[8] count[4] data[count] */
+	fc = v9fs_create_common(bufp, size, TWRITE);
+	if (IS_ERR(fc))
+		goto error;
+
+	v9fs_put_int32(bufp, fid, &fc->params.twrite.fid);
+	v9fs_put_int64(bufp, offset, &fc->params.twrite.offset);
+	v9fs_put_int32(bufp, count, &fc->params.twrite.count);
+	err = v9fs_put_user_data(bufp, data, count, &fc->params.twrite.data);
+	if (err) {
+		kfree(fc);
+		fc = ERR_PTR(err);
+	}
+
+	if (buf_check_overflow(bufp)) {
+		kfree(fc);
+		fc = ERR_PTR(-ENOMEM);
+	}
+      error:
+	return fc;
+}
+
+struct v9fs_fcall *v9fs_create_tclunk(u32 fid)
+{
+	int size;
+	struct v9fs_fcall *fc;
+	struct cbuf buffer;
+	struct cbuf *bufp = &buffer;
+
+	size = 4;		/* fid[4] */
+	fc = v9fs_create_common(bufp, size, TCLUNK);
+	if (IS_ERR(fc))
+		goto error;
+
+	v9fs_put_int32(bufp, fid, &fc->params.tclunk.fid);
+
+	if (buf_check_overflow(bufp)) {
+		kfree(fc);
+		fc = ERR_PTR(-ENOMEM);
+	}
+      error:
+	return fc;
+}
+
+struct v9fs_fcall *v9fs_create_tremove(u32 fid)
+{
+	int size;
+	struct v9fs_fcall *fc;
+	struct cbuf buffer;
+	struct cbuf *bufp = &buffer;
+
+	size = 4;		/* fid[4] */
+	fc = v9fs_create_common(bufp, size, TREMOVE);
+	if (IS_ERR(fc))
+		goto error;
+
+	v9fs_put_int32(bufp, fid, &fc->params.tremove.fid);
+
+	if (buf_check_overflow(bufp)) {
+		kfree(fc);
+		fc = ERR_PTR(-ENOMEM);
+	}
+      error:
+	return fc;
+}
+
+struct v9fs_fcall *v9fs_create_tstat(u32 fid)
+{
+	int size;
+	struct v9fs_fcall *fc;
+	struct cbuf buffer;
+	struct cbuf *bufp = &buffer;
+
+	size = 4;		/* fid[4] */
+	fc = v9fs_create_common(bufp, size, TSTAT);
+	if (IS_ERR(fc))
+		goto error;
+
+	v9fs_put_int32(bufp, fid, &fc->params.tstat.fid);
+
+	if (buf_check_overflow(bufp)) {
+		kfree(fc);
+		fc = ERR_PTR(-ENOMEM);
+	}
+      error:
+	return fc;
+}
+
+struct v9fs_fcall *v9fs_create_twstat(u32 fid, struct v9fs_wstat *wstat,
+				      int extended)
+{
+	int size, statsz;
+	struct v9fs_fcall *fc;
+	struct cbuf buffer;
+	struct cbuf *bufp = &buffer;
+
+	statsz = v9fs_size_wstat(wstat, extended);
+	size = 4 + 2 + 2 + statsz;	/* fid[4] stat[n] */
+	fc = v9fs_create_common(bufp, size, TWSTAT);
+	if (IS_ERR(fc))
+		goto error;
+
+	v9fs_put_int32(bufp, fid, &fc->params.twstat.fid);
+	buf_put_int16(bufp, statsz + 2);
+	v9fs_put_wstat(bufp, wstat, &fc->params.twstat.stat, statsz, extended);
+
+	if (buf_check_overflow(bufp)) {
+		kfree(fc);
+		fc = ERR_PTR(-ENOMEM);
+	}
+      error:
+	return fc;
 }
diff --git a/fs/9p/conv.h b/fs/9p/conv.h
index ad928b7..38040f7 100644
--- a/fs/9p/conv.h
+++ b/fs/9p/conv.h
@@ -1,8 +1,9 @@
 /*
  * linux/fs/9p/conv.h
  *
- * 9P protocol conversion definitions
+ * 9P protocol conversion definitions.
  *
+ *  Copyright (C) 2005 by Latchesar Ionkov <lucho@ionkov.net>
  *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
  *
@@ -25,11 +26,26 @@
  */
 
 int v9fs_deserialize_stat(void *buf, u32 buflen, struct v9fs_stat *stat, 
-	u32 statlen, int extended);
-int v9fs_serialize_fcall(struct v9fs_fcall *tcall, void *buf, u32 buflen, 
 	int extended);
-int v9fs_deserialize_fcall(void *buf, u32 buflen, struct v9fs_fcall *rcall,
-	int rcalllen, int extended);
+int v9fs_deserialize_fcall(void *buf, u32 buflen, struct v9fs_fcall *rcall, 
+	int extended);
+
+void v9fs_set_tag(struct v9fs_fcall *fc, u16 tag);
 
-/* this one is actually in error.c right now */
-int v9fs_errstr2errno(char *errstr);
+struct v9fs_fcall *v9fs_create_tversion(u32 msize, char *version);
+struct v9fs_fcall *v9fs_create_tauth(u32 afid, char *uname, char *aname);
+struct v9fs_fcall *v9fs_create_tattach(u32 fid, u32 afid, char *uname, 
+	char *aname);
+struct v9fs_fcall *v9fs_create_tflush(u16 oldtag);
+struct v9fs_fcall *v9fs_create_twalk(u32 fid, u32 newfid, u16 nwname, 
+	char **wnames);
+struct v9fs_fcall *v9fs_create_topen(u32 fid, u8 mode);
+struct v9fs_fcall *v9fs_create_tcreate(u32 fid, char *name, u32 perm, u8 mode);
+struct v9fs_fcall *v9fs_create_tread(u32 fid, u64 offset, u32 count);
+struct v9fs_fcall *v9fs_create_twrite(u32 fid, u64 offset, u32 count,
+	const char __user *data);
+struct v9fs_fcall *v9fs_create_tclunk(u32 fid);
+struct v9fs_fcall *v9fs_create_tremove(u32 fid);
+struct v9fs_fcall *v9fs_create_tstat(u32 fid);
+struct v9fs_fcall *v9fs_create_twstat(u32 fid, struct v9fs_wstat *wstat, 
+	int extended);
diff --git a/fs/9p/debug.h b/fs/9p/debug.h
index 4445f06..fe55103 100644
--- a/fs/9p/debug.h
+++ b/fs/9p/debug.h
@@ -51,16 +51,23 @@ do { \
 #if DEBUG_DUMP_PKT
 static inline void dump_data(const unsigned char *data, unsigned int datalen)
 {
-	int i, j;
-	int len = datalen;
+	int i, n;
+	char buf[5*8];
 
-	printk(KERN_DEBUG "data ");
-	for (i = 0; i < len; i += 4) {
-		for (j = 0; (j < 4) && (i + j < len); j++)
-			printk(KERN_DEBUG "%02x", data[i + j]);
-		printk(KERN_DEBUG " ");
+	n = 0;
+	i = 0;
+	while (i < datalen) {
+		n += snprintf(buf+n, sizeof(buf)-n, "%02x", data[i++]);
+		if (i%4 == 0)
+			n += snprintf(buf+n, sizeof(buf)-n, " ");
+
+		if (i%16 == 0) {
+			dprintk(DEBUG_ERROR, "%s\n", buf);
+			n = 0;
+		}
 	}
-	printk(KERN_DEBUG "\n");
+
+	dprintk(DEBUG_ERROR, "%s\n", buf);
 }
 #else				/* DEBUG_DUMP_PKT */
 static inline void dump_data(const unsigned char *data, unsigned int datalen)
diff --git a/fs/9p/error.c b/fs/9p/error.c
index 834cb17..e4b6f8f 100644
--- a/fs/9p/error.c
+++ b/fs/9p/error.c
@@ -33,7 +33,6 @@
 
 #include <linux/list.h>
 #include <linux/jhash.h>
-#include <linux/string.h>
 
 #include "debug.h"
 #include "error.h"
@@ -55,7 +54,8 @@ int v9fs_error_init(void)
 
 	/* load initial error map into hash table */
 	for (c = errmap; c->name != NULL; c++) {
-		bucket = jhash(c->name, strlen(c->name), 0) % ERRHASHSZ;
+		c->namelen = strlen(c->name);
+		bucket = jhash(c->name, c->namelen, 0) % ERRHASHSZ;
 		INIT_HLIST_NODE(&c->list);
 		hlist_add_head(&c->list, &hash_errmap[bucket]);
 	}
@@ -69,15 +69,15 @@ int v9fs_error_init(void)
  *
  */
 
-int v9fs_errstr2errno(char *errstr)
+int v9fs_errstr2errno(char *errstr, int len)
 {
 	int errno = 0;
 	struct hlist_node *p = NULL;
 	struct errormap *c = NULL;
-	int bucket = jhash(errstr, strlen(errstr), 0) % ERRHASHSZ;
+	int bucket = jhash(errstr, len, 0) % ERRHASHSZ;
 
 	hlist_for_each_entry(c, p, &hash_errmap[bucket], list) {
-		if (!strcmp(c->name, errstr)) {
+		if (c->namelen==len && !memcmp(c->name, errstr, len)) {
 			errno = c->val;
 			break;
 		}
diff --git a/fs/9p/error.h b/fs/9p/error.h
index 78f89ac..8b3176b 100644
--- a/fs/9p/error.h
+++ b/fs/9p/error.h
@@ -36,6 +36,7 @@ struct errormap {
 	char *name;
 	int val;
 
+	int namelen;
 	struct hlist_node list;
 };
 
@@ -175,4 +176,4 @@ static struct errormap errmap[] = {
 };
 
 extern int v9fs_error_init(void);
-extern int v9fs_errstr2errno(char *errstr);
+extern int v9fs_errstr2errno(char *errstr, int len);
diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index 60ef8ab..eda4497 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -31,9 +31,6 @@
 #include "v9fs.h"
 #include "9p.h"
 #include "v9fs_vfs.h"
-#include "transport.h"
-#include "mux.h"
-#include "conv.h"
 #include "fid.h"
 
 /**
diff --git a/fs/9p/mux.c b/fs/9p/mux.c
index 884fa75..e58c6ed 100644
--- a/fs/9p/mux.c
+++ b/fs/9p/mux.c
@@ -35,8 +35,8 @@
 #include "debug.h"
 #include "v9fs.h"
 #include "9p.h"
-#include "transport.h"
 #include "conv.h"
+#include "transport.h"
 #include "mux.h"
 
 #define NELEM(x) (sizeof(x) / sizeof((x)[0]))
@@ -76,6 +76,7 @@ struct v9fs_mux_data {
 	wait_queue_head_t equeue;
 	struct list_head req_list;
 	struct list_head unsent_req_list;
+	struct v9fs_fcall *rcall;
 	int rpos;
 	char *rbuf;
 	int wpos;
@@ -103,11 +104,15 @@ struct v9fs_mux_rpc {
 	wait_queue_head_t wqueue;
 };
 
+extern int v9fs_errstr2errno(char *str, int len);
+
 static int v9fs_poll_proc(void *);
 static void v9fs_read_work(void *);
 static void v9fs_write_work(void *);
 static void v9fs_pollwait(struct file *filp, wait_queue_head_t * wait_address,
 			  poll_table * p);
+static u16 v9fs_mux_get_tag(struct v9fs_mux_data *);
+static void v9fs_mux_put_tag(struct v9fs_mux_data *, u16);
 
 static DECLARE_MUTEX(v9fs_mux_task_lock);
 static struct workqueue_struct *v9fs_mux_wq;
@@ -168,8 +173,9 @@ static void v9fs_mux_poll_start(struct v
 			if (v9fs_mux_poll_tasks[i].task == NULL) {
 				vpt = &v9fs_mux_poll_tasks[i];
 				dprintk(DEBUG_MUX, "create proc %p\n", vpt);
-				vpt->task = kthread_create(v9fs_poll_proc, 
-					vpt, "v9fs-poll");
+				vpt->task =
+				    kthread_create(v9fs_poll_proc, vpt,
+						   "v9fs-poll");
 				INIT_LIST_HEAD(&vpt->mux_list);
 				vpt->muxnum = 0;
 				v9fs_mux_poll_task_num++;
@@ -255,7 +261,7 @@ struct v9fs_mux_data *v9fs_mux_init(stru
 	struct v9fs_mux_data *m, *mtmp;
 
 	dprintk(DEBUG_MUX, "transport %p msize %d\n", trans, msize);
-	m = kmalloc(sizeof(struct v9fs_mux_data) + 2 * msize, GFP_KERNEL);
+	m = kmalloc(sizeof(struct v9fs_mux_data), GFP_KERNEL);
 	if (!m)
 		return ERR_PTR(-ENOMEM);
 
@@ -270,10 +276,11 @@ struct v9fs_mux_data *v9fs_mux_init(stru
 	init_waitqueue_head(&m->equeue);
 	INIT_LIST_HEAD(&m->req_list);
 	INIT_LIST_HEAD(&m->unsent_req_list);
+	m->rcall = NULL;
 	m->rpos = 0;
-	m->rbuf = (char *)m + sizeof(struct v9fs_mux_data);
+	m->rbuf = NULL;
 	m->wpos = m->wsize = 0;
-	m->wbuf = m->rbuf + msize;
+	m->wbuf = NULL;
 	INIT_WORK(&m->rq, v9fs_read_work, m);
 	INIT_WORK(&m->wq, v9fs_write_work, m);
 	m->wsched = 0;
@@ -429,29 +436,6 @@ static int v9fs_poll_proc(void *a)
 	return 0;
 }
 
-static inline int v9fs_write_req(struct v9fs_mux_data *m, struct v9fs_req *req)
-{
-	int n;
-
-	list_move_tail(&req->req_list, &m->req_list);
-	n = v9fs_serialize_fcall(req->tcall, m->wbuf, m->msize, *m->extended);
-	if (n < 0) {
-		req->err = n;
-		list_del(&req->req_list);
-		if (req->cb) {
-			spin_unlock(&m->lock);
-			(*req->cb) (req->cba, req->tcall, req->rcall, req->err);
-			req->cb = NULL;
-			spin_lock(&m->lock);
-		} else
-			kfree(req->rcall);
-
-		kfree(req);
-	}
-
-	return n;
-}
-
 /**
  * v9fs_write_work - called when a transport can send some data
  */
@@ -459,7 +443,7 @@ static void v9fs_write_work(void *a)
 {
 	int n, err;
 	struct v9fs_mux_data *m;
-	struct v9fs_req *req, *rtmp;
+	struct v9fs_req *req;
 
 	m = a;
 
@@ -474,17 +458,15 @@ static void v9fs_write_work(void *a)
 			return;
 		}
 
-		err = 0;
 		spin_lock(&m->lock);
-		list_for_each_entry_safe(req, rtmp, &m->unsent_req_list,
-					 req_list) {
-			err = v9fs_write_req(m, req);
-			if (err > 0)
-				break;
-		}
-
-		m->wsize = err;
+		req =
+		    list_entry(m->unsent_req_list.next, struct v9fs_req,
+			       req_list);
+		list_move_tail(&req->req_list, &m->req_list);
+		m->wbuf = req->tcall->sdata;
+		m->wsize = req->tcall->size;
 		m->wpos = 0;
+		dump_data(m->wbuf, m->wsize);
 		spin_unlock(&m->lock);
 	}
 
@@ -528,24 +510,23 @@ static void v9fs_write_work(void *a)
 static void process_request(struct v9fs_mux_data *m, struct v9fs_req *req)
 {
 	int ecode, tag;
-	char *ename;
+	struct v9fs_str *ename;
 
 	tag = req->tag;
 	if (req->rcall->id == RERROR && !req->err) {
 		ecode = req->rcall->params.rerror.errno;
-		ename = req->rcall->params.rerror.error;
+		ename = &req->rcall->params.rerror.error;
 
-		dprintk(DEBUG_MUX, "Rerror %s\n", ename);
+		dprintk(DEBUG_MUX, "Rerror %.*s\n", ename->len, ename->str);
 
 		if (*m->extended)
 			req->err = -ecode;
 
 		if (!req->err) {
-			req->err = v9fs_errstr2errno(ename);
+			req->err = v9fs_errstr2errno(ename->str, ename->len);
 
 			if (!req->err) {	/* string match failed */
-				dprintk(DEBUG_ERROR, "unknown error: %s\n",
-					ename);
+				PRINT_FCALL_ERROR("unknown error", req->rcall);
 			}
 
 			if (!req->err)
@@ -567,8 +548,7 @@ static void process_request(struct v9fs_
 	} else
 		kfree(req->rcall);
 
-	if (tag != V9FS_NOTAG)
-		v9fs_put_idpool(tag, &m->tidpool);
+	v9fs_mux_put_tag(m, tag);
 
 	wake_up(&m->equeue);
 	kfree(req);
@@ -579,10 +559,11 @@ static void process_request(struct v9fs_
  */
 static void v9fs_read_work(void *a)
 {
-	int n, err, rcallen;
+	int n, err;
 	struct v9fs_mux_data *m;
 	struct v9fs_req *req, *rptr, *rreq;
 	struct v9fs_fcall *rcall;
+	char *rbuf;
 
 	m = a;
 
@@ -591,6 +572,19 @@ static void v9fs_read_work(void *a)
 
 	rcall = NULL;
 	dprintk(DEBUG_MUX, "start mux %p pos %d\n", m, m->rpos);
+
+	if (!m->rcall) {
+		m->rcall =
+		    kmalloc(sizeof(struct v9fs_fcall) + m->msize, GFP_KERNEL);
+		if (!m->rcall) {
+			err = -ENOMEM;
+			goto error;
+		}
+
+		m->rbuf = (char *)m->rcall + sizeof(struct v9fs_fcall);
+		m->rpos = 0;
+	}
+
 	clear_bit(Rpending, &m->wsched);
 	err = m->trans->read(m->trans, m->rbuf + m->rpos, m->msize - m->rpos);
 	dprintk(DEBUG_MUX, "mux %p got %d bytes\n", m, err);
@@ -615,21 +609,32 @@ static void v9fs_read_work(void *a)
 		if (m->rpos < n)
 			break;
 
-		rcallen = n + V9FS_FCALLHDRSZ;
-		rcall = kmalloc(rcallen, GFP_KERNEL);
-		if (!rcall) {
-			err = -ENOMEM;
-			goto error;
-		}
-
 		dump_data(m->rbuf, n);
-		err = v9fs_deserialize_fcall(m->rbuf, n, rcall, rcallen,
-					     *m->extended);
+		err =
+		    v9fs_deserialize_fcall(m->rbuf, n, m->rcall, *m->extended);
 		if (err < 0) {
-			kfree(rcall);
 			goto error;
 		}
 
+		rcall = m->rcall;
+		rbuf = m->rbuf;
+		if (m->rpos > n) {
+			m->rcall = kmalloc(sizeof(struct v9fs_fcall) + m->msize,
+					   GFP_KERNEL);
+			if (!m->rcall) {
+				err = -ENOMEM;
+				goto error;
+			}
+
+			m->rbuf = (char *)m->rcall + sizeof(struct v9fs_fcall);
+			memmove(m->rbuf, rbuf + n, m->rpos - n);
+			m->rpos -= n;
+		} else {
+			m->rcall = NULL;
+			m->rbuf = NULL;
+			m->rpos = 0;
+		}
+
 		dprintk(DEBUG_MUX, "mux %p fcall id %d tag %d\n", m, rcall->id,
 			rcall->tag);
 
@@ -644,6 +649,7 @@ static void v9fs_read_work(void *a)
 				process_request(m, req);
 				break;
 			}
+
 		}
 
 		if (!req) {
@@ -654,10 +660,6 @@ static void v9fs_read_work(void *a)
 					m, rcall->id, rcall->tag);
 			kfree(rcall);
 		}
-
-		if (m->rpos > n)
-			memmove(m->rbuf, m->rbuf + n, m->rpos - n);
-		m->rpos -= n;
 	}
 
 	if (!list_empty(&m->req_list)) {
@@ -712,12 +714,13 @@ static struct v9fs_req *v9fs_send_reques
 	if (tc->id == TVERSION)
 		n = V9FS_NOTAG;
 	else
-		n = v9fs_get_idpool(&m->tidpool);
+		n = v9fs_mux_get_tag(m);
 
 	if (n < 0)
 		return ERR_PTR(-ENOMEM);
 
-	tc->tag = n;
+	v9fs_set_tag(tc, n);
+
 	req->tag = n;
 	req->tcall = tc;
 	req->rcall = NULL;
@@ -775,9 +778,7 @@ v9fs_mux_flush_cb(void *a, struct v9fs_f
 	if (!cb)
 		spin_unlock(&m->lock);
 
-	if (v9fs_check_idpool(tag, &m->tidpool))
-		v9fs_put_idpool(tag, &m->tidpool);
-
+	v9fs_mux_put_tag(m, tag);
 	kfree(tc);
 	kfree(rc);
 }
@@ -789,10 +790,7 @@ v9fs_mux_flush_request(struct v9fs_mux_d
 
 	dprintk(DEBUG_MUX, "mux %p req %p tag %d\n", m, req, req->tag);
 
-	fc = kmalloc(sizeof(struct v9fs_fcall), GFP_KERNEL);
-	fc->id = TFLUSH;
-	fc->params.tflush.oldtag = req->tag;
-
+	fc = v9fs_create_tflush(req->tag);
 	v9fs_send_request(m, fc, v9fs_mux_flush_cb, m);
 }
 
@@ -941,3 +939,20 @@ void v9fs_mux_cancel(struct v9fs_mux_dat
 
 	wake_up(&m->equeue);
 }
+
+static u16 v9fs_mux_get_tag(struct v9fs_mux_data *m)
+{
+	int tag;
+
+	tag = v9fs_get_idpool(&m->tidpool);
+	if (tag < 0)
+		return V9FS_NOTAG;
+	else
+		return (u16) tag;
+}
+
+static void v9fs_mux_put_tag(struct v9fs_mux_data *m, u16 tag)
+{
+	if (tag != V9FS_NOTAG && v9fs_check_idpool(tag, &m->tidpool))
+		v9fs_put_idpool(tag, &m->tidpool);
+}
diff --git a/fs/9p/trans_sock.c b/fs/9p/trans_sock.c
index 24dd078..9baf679 100644
--- a/fs/9p/trans_sock.c
+++ b/fs/9p/trans_sock.c
@@ -109,7 +109,6 @@ static int v9fs_sock_send(struct v9fs_tr
 	if (!(ts->filp->f_flags & O_NONBLOCK))
 		dprintk(DEBUG_ERROR, "blocking write ...\n");
 
-	dump_data(v, len);
 	oldfs = get_fs();
 	set_fs(get_ds());
 	ret = vfs_write(ts->filp, (void __user *)v, len, &ts->filp->f_pos);
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 5e0f793..519b21d 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -37,7 +37,6 @@
 #include "v9fs_vfs.h"
 #include "transport.h"
 #include "mux.h"
-#include "conv.h"
 
 /* TODO: sysfs or debugfs interface */
 int v9fs_debug_level = 0;	/* feature-rific global debug level  */
@@ -353,7 +352,7 @@ v9fs_session_init(struct v9fs_session_in
 		}
 
 		/* Really should check for 9P1 and report error */
-		if (!strcmp(fcall->params.rversion.version, "9P2000.u")) {
+		if (!v9fs_str_compare("9P2000.u", &fcall->params.rversion.version)) {
 			dprintk(DEBUG_9P, "9P2000 UNIX extensions enabled\n");
 			v9ses->extended = 1;
 		} else {
diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index 2f2cea7..c78502a 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -45,9 +45,8 @@ extern struct dentry_operations v9fs_den
 
 struct inode *v9fs_get_inode(struct super_block *sb, int mode);
 ino_t v9fs_qid2ino(struct v9fs_qid *qid);
-void v9fs_mistat2inode(struct v9fs_stat *, struct inode *,
-		       struct super_block *);
+void v9fs_stat2inode(struct v9fs_stat *, struct inode *, struct super_block *);
 int v9fs_dir_release(struct inode *inode, struct file *filp);
 int v9fs_file_open(struct inode *inode, struct file *file);
-void v9fs_inode2mistat(struct inode *inode, struct v9fs_stat *mistat);
+void v9fs_inode2stat(struct inode *inode, struct v9fs_stat *stat);
 void v9fs_dentry_release(struct dentry *);
diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index 4887df7..428d6bf 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -40,7 +40,6 @@
 #include "v9fs.h"
 #include "9p.h"
 #include "v9fs_vfs.h"
-#include "conv.h"
 #include "fid.h"
 
 /**
@@ -108,7 +107,8 @@ void v9fs_dentry_release(struct dentry *
 			err = v9fs_t_clunk(current_fid->v9ses, current_fid->fid);
 
 			if (err < 0)
-				dprintk(DEBUG_ERROR, "clunk failed: %d\n", err);
+				dprintk(DEBUG_ERROR, "clunk failed: %d name %s\n", 
+					err, dentry->d_iname);
 
 			v9fs_fid_destroy(current_fid);
 		}
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index e9c05ff..3898216 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -37,8 +37,8 @@
 #include "debug.h"
 #include "v9fs.h"
 #include "9p.h"
-#include "v9fs_vfs.h"
 #include "conv.h"
+#include "v9fs_vfs.h"
 #include "fid.h"
 
 /**
@@ -77,17 +77,13 @@ static int v9fs_dir_readdir(struct file 
 	unsigned int i, n, s;
 	int fid = -1;
 	int ret = 0;
-	struct v9fs_stat *mi = NULL;
+	struct v9fs_stat stat;
 	int over = 0;
 
 	dprintk(DEBUG_VFS, "name %s\n", filp->f_dentry->d_name.name);
 
 	fid = file->fid;
 
-	mi = kmalloc(v9ses->maxdata, GFP_KERNEL);
-	if (!mi)
-		return -ENOMEM;
-
 	if (file->rdir_fcall && (filp->f_pos != file->rdir_pos)) {
 		kfree(file->rdir_fcall);
 		file->rdir_fcall = NULL;
@@ -99,18 +95,18 @@ static int v9fs_dir_readdir(struct file 
 		while (i < n) {
 			s = v9fs_deserialize_stat(
 				file->rdir_fcall->params.rread.data + i,
-				n - i, mi, v9ses->maxdata, v9ses->extended);
+				n - i, &stat, v9ses->extended);
 
 			if (s == 0) {
 				dprintk(DEBUG_ERROR,
-					"error while deserializing mistat\n");
+					"error while deserializing stat\n");
 				ret = -EIO;
 				goto FreeStructs;
 			}
 
-			over = filldir(dirent, mi->name, strlen(mi->name),
-				    filp->f_pos, v9fs_qid2ino(&mi->qid),
-				    dt_type(mi));
+			over = filldir(dirent, stat.name.str, stat.name.len,
+				    filp->f_pos, v9fs_qid2ino(&stat.qid),
+				    dt_type(&stat));
 
 			if (over) {
 				file->rdir_fpos = i;
@@ -130,7 +126,7 @@ static int v9fs_dir_readdir(struct file 
 
 	while (!over) {
 		ret = v9fs_t_read(v9ses, fid, filp->f_pos,
-					    v9ses->maxdata-V9FS_IOHDRSZ, &fcall);
+			v9ses->maxdata-V9FS_IOHDRSZ, &fcall);
 		if (ret < 0) {
 			dprintk(DEBUG_ERROR, "error while reading: %d: %p\n",
 				ret, fcall);
@@ -142,17 +138,17 @@ static int v9fs_dir_readdir(struct file 
 		i = 0;
 		while (i < n) {
 			s = v9fs_deserialize_stat(fcall->params.rread.data + i, 
-				n - i, mi, v9ses->maxdata, v9ses->extended);
+				n - i, &stat, v9ses->extended);
 
 			if (s == 0) {
 				dprintk(DEBUG_ERROR,
-					"error while deserializing mistat\n");
+					"error while deserializing stat\n");
 				return -EIO;
 			}
 
-			over = filldir(dirent, mi->name, strlen(mi->name),
-				    filp->f_pos, v9fs_qid2ino(&mi->qid),
-				    dt_type(mi));
+			over = filldir(dirent, stat.name.str, stat.name.len,
+				    filp->f_pos, v9fs_qid2ino(&stat.qid),
+				    dt_type(&stat));
 
 			if (over) {
 				file->rdir_fcall = fcall;
@@ -171,7 +167,6 @@ static int v9fs_dir_readdir(struct file 
 
       FreeStructs:
 	kfree(fcall);
-	kfree(mi);
 	return ret;
 }
 
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 89c849d..c2243b4 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -32,6 +32,7 @@
 #include <linux/string.h>
 #include <linux/smp_lock.h>
 #include <linux/inet.h>
+#include <linux/version.h>
 #include <linux/list.h>
 #include <asm/uaccess.h>
 #include <linux/idr.h>
@@ -117,9 +118,7 @@ int v9fs_file_open(struct inode *inode, 
 
 		result = v9fs_t_open(v9ses, newfid, open_mode, &fcall);
 		if (result < 0) {
-			dprintk(DEBUG_ERROR,
-				"open failed, open_mode 0x%x: %s\n", open_mode,
-				FCALL_ERROR(fcall));
+			PRINT_FCALL_ERROR("open failed", fcall);
 			kfree(fcall);
 			return result;
 		}
@@ -257,7 +256,6 @@ v9fs_file_write(struct file *filp, const
 	int result = -EIO;
 	int rsize = 0;
 	int total = 0;
-	char *buf;
 
 	dprintk(DEBUG_VFS, "data %p count %d offset %x\n", data, (int)count,
 		(int)*offset);
@@ -265,28 +263,14 @@ v9fs_file_write(struct file *filp, const
 	if (v9fid->iounit != 0 && rsize > v9fid->iounit)
 		rsize = v9fid->iounit;
 
-	buf = kmalloc(v9ses->maxdata - V9FS_IOHDRSZ, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
 	do {
 		if (count < rsize)
 			rsize = count;
 
-		result = copy_from_user(buf, data, rsize);
-		if (result) {
-			dprintk(DEBUG_ERROR, "Problem copying from user\n");
-			kfree(buf);
-			return -EFAULT;
-		}
-
-		dump_data(buf, rsize);
-		result = v9fs_t_write(v9ses, fid, *offset, rsize, buf, &fcall);
+		result = v9fs_t_write(v9ses, fid, *offset, rsize, data, &fcall);
 		if (result < 0) {
-			eprintk(KERN_ERR, "error while writing: %s(%d)\n",
-				FCALL_ERROR(fcall), result);
+			PRINT_FCALL_ERROR("error while writing", fcall);
 			kfree(fcall);
-			kfree(buf);
 			return result;
 		} else
 			*offset += result;
@@ -306,7 +290,6 @@ v9fs_file_write(struct file *filp, const
 		total += result;
 	} while (count);
 
-	kfree(buf);
 	return total;
 }
 
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index f11edde..8597a31 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -40,7 +40,6 @@
 #include "v9fs.h"
 #include "9p.h"
 #include "v9fs_vfs.h"
-#include "conv.h"
 #include "fid.h"
 
 static struct inode_operations v9fs_dir_inode_operations;
@@ -127,100 +126,32 @@ static int p9mode2unixmode(struct v9fs_s
 }
 
 /**
- * v9fs_blank_mistat - helper function to setup a 9P stat structure
+ * v9fs_blank_wstat - helper function to setup a 9P stat structure
  * @v9ses: 9P session info (for determining extended mode)
- * @mistat: structure to initialize
+ * @wstat: structure to initialize
  *
  */
 
 static void
-v9fs_blank_mistat(struct v9fs_session_info *v9ses, struct v9fs_stat *mistat)
+v9fs_blank_wstat(struct v9fs_wstat *wstat)
 {
-	mistat->type = ~0;
-	mistat->dev = ~0;
-	mistat->qid.type = ~0;
-	mistat->qid.version = ~0;
-	*((long long *)&mistat->qid.path) = ~0;
-	mistat->mode = ~0;
-	mistat->atime = ~0;
-	mistat->mtime = ~0;
-	mistat->length = ~0;
-	mistat->name = mistat->data;
-	mistat->uid = mistat->data;
-	mistat->gid = mistat->data;
-	mistat->muid = mistat->data;
-	if (v9ses->extended) {
-		mistat->n_uid = ~0;
-		mistat->n_gid = ~0;
-		mistat->n_muid = ~0;
-		mistat->extension = mistat->data;
-	}
-	*mistat->data = 0;
-}
-
-/**
- * v9fs_mistat2unix - convert mistat to unix stat
- * @mistat: Plan 9 metadata (mistat) structure
- * @buf: unix metadata (stat) structure to populate
- * @sb: superblock
- *
- */
-
-static void
-v9fs_mistat2unix(struct v9fs_stat *mistat, struct stat *buf,
-		 struct super_block *sb)
-{
-	struct v9fs_session_info *v9ses = sb ? sb->s_fs_info : NULL;
-
-	buf->st_nlink = 1;
-
-	buf->st_atime = mistat->atime;
-	buf->st_mtime = mistat->mtime;
-	buf->st_ctime = mistat->mtime;
-
-	buf->st_uid = (unsigned short)-1;
-	buf->st_gid = (unsigned short)-1;
-
-	if (v9ses && v9ses->extended) {
-		/* TODO: string to uid mapping via user-space daemon */
-		if (mistat->n_uid != -1)
-			sscanf(mistat->uid, "%x", (unsigned int *)&buf->st_uid);
-
-		if (mistat->n_gid != -1)
-			sscanf(mistat->gid, "%x", (unsigned int *)&buf->st_gid);
-	}
-
-	if (buf->st_uid == (unsigned short)-1)
-		buf->st_uid = v9ses->uid;
-	if (buf->st_gid == (unsigned short)-1)
-		buf->st_gid = v9ses->gid;
-
-	buf->st_mode = p9mode2unixmode(v9ses, mistat->mode);
-	if ((S_ISBLK(buf->st_mode)) || (S_ISCHR(buf->st_mode))) {
-		char type = 0;
-		int major = -1;
-		int minor = -1;
-		sscanf(mistat->extension, "%c %u %u", &type, &major, &minor);
-		switch (type) {
-		case 'c':
-			buf->st_mode &= ~S_IFBLK;
-			buf->st_mode |= S_IFCHR;
-			break;
-		case 'b':
-			break;
-		default:
-			dprintk(DEBUG_ERROR, "Unknown special type %c (%s)\n",
-				type, mistat->extension);
-		};
-		buf->st_rdev = MKDEV(major, minor);
-	} else
-		buf->st_rdev = 0;
-
-	buf->st_size = mistat->length;
-
-	buf->st_blksize = sb->s_blocksize;
-	buf->st_blocks =
-	    (buf->st_size + buf->st_blksize - 1) >> sb->s_blocksize_bits;
+	wstat->type = ~0;
+	wstat->dev = ~0;
+	wstat->qid.type = ~0;
+	wstat->qid.version = ~0;
+	*((long long *)&wstat->qid.path) = ~0;
+	wstat->mode = ~0;
+	wstat->atime = ~0;
+	wstat->mtime = ~0;
+	wstat->length = ~0;
+	wstat->name = NULL;
+	wstat->uid = NULL;
+	wstat->gid = NULL;
+	wstat->muid = NULL;
+	wstat->n_uid = ~0;
+	wstat->n_gid = ~0;
+	wstat->n_muid = ~0;
+	wstat->extension = NULL;
 }
 
 /**
@@ -312,7 +243,6 @@ v9fs_create(struct inode *dir,
 	struct inode *file_inode = NULL;
 	struct v9fs_fcall *fcall = NULL;
 	struct v9fs_qid qid;
-	struct stat newstat;
 	int dirfidnum = -1;
 	long newfid = -1;
 	int result = 0;
@@ -350,7 +280,7 @@ v9fs_create(struct inode *dir,
 
 	result = v9fs_t_walk(v9ses, dirfidnum, newfid, NULL, &fcall);
 	if (result < 0) {
-		dprintk(DEBUG_ERROR, "clone error: %s\n", FCALL_ERROR(fcall));
+		PRINT_FCALL_ERROR("clone error", fcall);
 		v9fs_put_idpool(newfid, &v9ses->fidpool);
 		newfid = -1;
 		goto CleanUpFid;
@@ -362,9 +292,7 @@ v9fs_create(struct inode *dir,
 	result = v9fs_t_create(v9ses, newfid, (char *)file_dentry->d_name.name,
 			       perm, open_mode, &fcall);
 	if (result < 0) {
-		dprintk(DEBUG_ERROR, "create fails: %s(%d)\n",
-			FCALL_ERROR(fcall), result);
-
+		PRINT_FCALL_ERROR("create fails", fcall);
 		goto CleanUpFid;
 	}
 
@@ -400,7 +328,7 @@ v9fs_create(struct inode *dir,
 	result = v9fs_t_walk(v9ses, dirfidnum, wfidno,
 		(char *) file_dentry->d_name.name, &fcall);
 	if (result < 0) {
-		dprintk(DEBUG_ERROR, "clone error: %s\n", FCALL_ERROR(fcall));
+		PRINT_FCALL_ERROR("clone error", fcall);
 		v9fs_put_idpool(wfidno, &v9ses->fidpool);
 		wfidno = -1;
 		goto CleanUpFid;
@@ -421,21 +349,21 @@ v9fs_create(struct inode *dir,
 
 	result = v9fs_t_stat(v9ses, wfidno, &fcall);
 	if (result < 0) {
-		dprintk(DEBUG_ERROR, "stat error: %s(%d)\n", FCALL_ERROR(fcall),
-			result);
+		PRINT_FCALL_ERROR("stat error", fcall);
 		goto CleanUpFid;
 	}
 
-	v9fs_mistat2unix(fcall->params.rstat.stat, &newstat, sb);
+	
+	file_inode = v9fs_get_inode(sb, 
+		p9mode2unixmode(v9ses, fcall->params.rstat.stat.mode));
 
-	file_inode = v9fs_get_inode(sb, newstat.st_mode);
 	if ((!file_inode) || IS_ERR(file_inode)) {
 		dprintk(DEBUG_ERROR, "create inode failed\n");
 		result = -EBADF;
 		goto CleanUpFid;
 	}
 
-	v9fs_mistat2inode(fcall->params.rstat.stat, file_inode, sb);
+	v9fs_stat2inode(&fcall->params.rstat.stat, file_inode, sb);
 	kfree(fcall);
 	fcall = NULL;
 	file_dentry->d_op = &v9fs_dentry_operations;
@@ -500,10 +428,9 @@ static int v9fs_remove(struct inode *dir
 	}
 
 	result = v9fs_t_remove(v9ses, fid, &fcall);
-	if (result < 0)
-		dprintk(DEBUG_ERROR, "remove of file fails: %s(%d)\n",
-			FCALL_ERROR(fcall), result);
-	else {
+	if (result < 0) {
+		PRINT_FCALL_ERROR("remove fails", fcall);
+	} else {
 		v9fs_put_idpool(fid, &v9ses->fidpool);
 		v9fs_fid_destroy(v9fid);
 	}
@@ -558,7 +485,6 @@ static struct dentry *v9fs_vfs_lookup(st
 	struct v9fs_fid *fid;
 	struct inode *inode;
 	struct v9fs_fcall *fcall = NULL;
-	struct stat newstat;
 	int dirfidnum = -1;
 	int newfid = -1;
 	int result = 0;
@@ -611,8 +537,8 @@ static struct dentry *v9fs_vfs_lookup(st
 		goto FreeFcall;
 	}
 
-	v9fs_mistat2unix(fcall->params.rstat.stat, &newstat, sb);
-	inode = v9fs_get_inode(sb, newstat.st_mode);
+	inode = v9fs_get_inode(sb, p9mode2unixmode(v9ses, 
+		fcall->params.rstat.stat.mode));
 
 	if (IS_ERR(inode) && (PTR_ERR(inode) == -ENOSPC)) {
 		eprintk(KERN_WARNING, "inode alloc failes, returns %ld\n",
@@ -622,7 +548,7 @@ static struct dentry *v9fs_vfs_lookup(st
 		goto FreeFcall;
 	}
 
-	inode->i_ino = v9fs_qid2ino(&fcall->params.rstat.stat->qid);
+	inode->i_ino = v9fs_qid2ino(&fcall->params.rstat.stat.qid);
 
 	fid = v9fs_fid_create(dentry, v9ses, newfid, 0);
 	if (fid == NULL) {
@@ -631,10 +557,10 @@ static struct dentry *v9fs_vfs_lookup(st
 		goto FreeFcall;
 	}
 
-	fid->qid = fcall->params.rstat.stat->qid;
+	fid->qid = fcall->params.rstat.stat.qid;
 
 	dentry->d_op = &v9fs_dentry_operations;
-	v9fs_mistat2inode(fcall->params.rstat.stat, inode, inode->i_sb);
+	v9fs_stat2inode(&fcall->params.rstat.stat, inode, inode->i_sb);
 
 	d_add(dentry, inode);
 	kfree(fcall);
@@ -690,7 +616,7 @@ v9fs_vfs_rename(struct inode *old_dir, s
 	    v9fs_fid_lookup(old_dentry->d_parent);
 	struct v9fs_fid *newdirfid =
 	    v9fs_fid_lookup(new_dentry->d_parent);
-	struct v9fs_stat *mistat = kmalloc(v9ses->maxdata, GFP_KERNEL);
+	struct v9fs_wstat wstat;
 	struct v9fs_fcall *fcall = NULL;
 	int fid = -1;
 	int olddirfidnum = -1;
@@ -699,9 +625,6 @@ v9fs_vfs_rename(struct inode *old_dir, s
 
 	dprintk(DEBUG_VFS, "\n");
 
-	if (!mistat)
-		return -ENOMEM;
-
 	if ((!oldfid) || (!olddirfid) || (!newdirfid)) {
 		dprintk(DEBUG_ERROR, "problem with arguments\n");
 		return -EBADF;
@@ -725,26 +648,15 @@ v9fs_vfs_rename(struct inode *old_dir, s
 		goto FreeFcallnBail;
 	}
 
-	v9fs_blank_mistat(v9ses, mistat);
-
-	strcpy(mistat->data + 1, v9ses->name);
-	mistat->name = mistat->data + 1 + strlen(v9ses->name);
-
-	if (new_dentry->d_name.len >
-	    (v9ses->maxdata - strlen(v9ses->name) - sizeof(struct v9fs_stat))) {
-		dprintk(DEBUG_ERROR, "new name too long\n");
-		goto FreeFcallnBail;
-	}
+	v9fs_blank_wstat(&wstat);
+	wstat.muid = v9ses->name;
+	wstat.name = (char *) new_dentry->d_name.name;
 
-	strcpy(mistat->name, new_dentry->d_name.name);
-	retval = v9fs_t_wstat(v9ses, fid, mistat, &fcall);
+	retval = v9fs_t_wstat(v9ses, fid, &wstat, &fcall);
 
       FreeFcallnBail:
-	kfree(mistat);
-
 	if (retval < 0)
-		dprintk(DEBUG_ERROR, "v9fs_t_wstat error: %s\n",
-			FCALL_ERROR(fcall));
+		PRINT_FCALL_ERROR("wstat error", fcall);
 
 	kfree(fcall);
 	return retval;
@@ -779,7 +691,7 @@ v9fs_vfs_getattr(struct vfsmount *mnt, s
 	if (err < 0)
 		dprintk(DEBUG_ERROR, "stat error\n");
 	else {
-		v9fs_mistat2inode(fcall->params.rstat.stat, dentry->d_inode,
+		v9fs_stat2inode(&fcall->params.rstat.stat, dentry->d_inode,
 				  dentry->d_inode->i_sb);
 		generic_fillattr(dentry->d_inode, stat);
 	}
@@ -800,57 +712,44 @@ static int v9fs_vfs_setattr(struct dentr
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dentry->d_inode);
 	struct v9fs_fid *fid = v9fs_fid_lookup(dentry);
 	struct v9fs_fcall *fcall = NULL;
-	struct v9fs_stat *mistat = kmalloc(v9ses->maxdata, GFP_KERNEL);
+	struct v9fs_wstat wstat;
 	int res = -EPERM;
 
 	dprintk(DEBUG_VFS, "\n");
 
-	if (!mistat)
-		return -ENOMEM;
-
 	if (!fid) {
 		dprintk(DEBUG_ERROR,
 			"Couldn't find fid associated with dentry\n");
 		return -EBADF;
 	}
 
-	v9fs_blank_mistat(v9ses, mistat);
+	v9fs_blank_wstat(&wstat);
 	if (iattr->ia_valid & ATTR_MODE)
-		mistat->mode = unixmode2p9mode(v9ses, iattr->ia_mode);
+		wstat.mode = unixmode2p9mode(v9ses, iattr->ia_mode);
 
 	if (iattr->ia_valid & ATTR_MTIME)
-		mistat->mtime = iattr->ia_mtime.tv_sec;
+		wstat.mtime = iattr->ia_mtime.tv_sec;
 
 	if (iattr->ia_valid & ATTR_ATIME)
-		mistat->atime = iattr->ia_atime.tv_sec;
+		wstat.atime = iattr->ia_atime.tv_sec;
 
 	if (iattr->ia_valid & ATTR_SIZE)
-		mistat->length = iattr->ia_size;
+		wstat.length = iattr->ia_size;
 
 	if (v9ses->extended) {
-		char *ptr = mistat->data+1;
+		if (iattr->ia_valid & ATTR_UID)
+			wstat.n_uid = iattr->ia_uid;
 
-		if (iattr->ia_valid & ATTR_UID) {
-			mistat->uid = ptr;
-			ptr += 1+sprintf(ptr, "%08x", iattr->ia_uid);
-			mistat->n_uid = iattr->ia_uid;
-		}
-
-		if (iattr->ia_valid & ATTR_GID) {
-			mistat->gid = ptr;
-			ptr += 1+sprintf(ptr, "%08x", iattr->ia_gid);
-			mistat->n_gid = iattr->ia_gid;
-		}
+		if (iattr->ia_valid & ATTR_GID)
+			wstat.n_gid = iattr->ia_gid;
 	}
 
-	res = v9fs_t_wstat(v9ses, fid->fid, mistat, &fcall);
+	res = v9fs_t_wstat(v9ses, fid->fid, &wstat, &fcall);
 
 	if (res < 0)
-		dprintk(DEBUG_ERROR, "wstat error: %s\n", FCALL_ERROR(fcall));
+		PRINT_FCALL_ERROR("wstat error", fcall);
 
-	kfree(mistat);
 	kfree(fcall);
-
 	if (res >= 0)
 		res = inode_setattr(dentry->d_inode, iattr);
 
@@ -858,51 +757,42 @@ static int v9fs_vfs_setattr(struct dentr
 }
 
 /**
- * v9fs_mistat2inode - populate an inode structure with mistat info
- * @mistat: Plan 9 metadata (mistat) structure
+ * v9fs_stat2inode - populate an inode structure with mistat info
+ * @stat: Plan 9 metadata (mistat) structure
  * @inode: inode to populate
  * @sb: superblock of filesystem
  *
  */
 
 void
-v9fs_mistat2inode(struct v9fs_stat *mistat, struct inode *inode,
-		  struct super_block *sb)
+v9fs_stat2inode(struct v9fs_stat *stat, struct inode *inode, 
+	struct super_block *sb)
 {
+	char ext[32];
 	struct v9fs_session_info *v9ses = sb->s_fs_info;
 
 	inode->i_nlink = 1;
 
-	inode->i_atime.tv_sec = mistat->atime;
-	inode->i_mtime.tv_sec = mistat->mtime;
-	inode->i_ctime.tv_sec = mistat->mtime;
+	inode->i_atime.tv_sec = stat->atime;
+	inode->i_mtime.tv_sec = stat->mtime;
+	inode->i_ctime.tv_sec = stat->mtime;
 
-	inode->i_uid = -1;
-	inode->i_gid = -1;
+	inode->i_uid = v9ses->uid;
+	inode->i_gid = v9ses->gid;
 
 	if (v9ses->extended) {
-		/* TODO: string to uid mapping via user-space daemon */
-		inode->i_uid = mistat->n_uid;
-		inode->i_gid = mistat->n_gid;
-
-		if (mistat->n_uid == -1)
-			sscanf(mistat->uid, "%x", &inode->i_uid);
-
-		if (mistat->n_gid == -1)
-			sscanf(mistat->gid, "%x", &inode->i_gid);
+		inode->i_uid = stat->n_uid;
+		inode->i_gid = stat->n_gid;
 	}
 
-	if (inode->i_uid == -1)
-		inode->i_uid = v9ses->uid;
-	if (inode->i_gid == -1)
-		inode->i_gid = v9ses->gid;
-
-	inode->i_mode = p9mode2unixmode(v9ses, mistat->mode);
+	inode->i_mode = p9mode2unixmode(v9ses, stat->mode);
 	if ((S_ISBLK(inode->i_mode)) || (S_ISCHR(inode->i_mode))) {
 		char type = 0;
 		int major = -1;
 		int minor = -1;
-		sscanf(mistat->extension, "%c %u %u", &type, &major, &minor);
+
+		v9fs_str_copy(ext, sizeof(ext), &stat->extension);
+		sscanf(ext, "%c %u %u", &type, &major, &minor);
 		switch (type) {
 		case 'c':
 			inode->i_mode &= ~S_IFBLK;
@@ -911,14 +801,14 @@ v9fs_mistat2inode(struct v9fs_stat *mist
 		case 'b':
 			break;
 		default:
-			dprintk(DEBUG_ERROR, "Unknown special type %c (%s)\n",
-				type, mistat->extension);
+			dprintk(DEBUG_ERROR, "Unknown special type %c (%.*s)\n",
+				type, stat->extension.len, stat->extension.str);
 		};
 		inode->i_rdev = MKDEV(major, minor);
 	} else
 		inode->i_rdev = 0;
 
-	inode->i_size = mistat->length;
+	inode->i_size = stat->length;
 
 	inode->i_blksize = sb->s_blocksize;
 	inode->i_blocks =
@@ -946,72 +836,6 @@ ino_t v9fs_qid2ino(struct v9fs_qid *qid)
 }
 
 /**
- * v9fs_vfs_symlink - helper function to create symlinks
- * @dir: directory inode containing symlink
- * @dentry: dentry for symlink
- * @symname: symlink data
- *
- * See 9P2000.u RFC for more information
- *
- */
-
-static int
-v9fs_vfs_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
-{
-	int retval = -EPERM;
-	struct v9fs_fid *newfid;
-	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
-	struct v9fs_fcall *fcall = NULL;
-	struct v9fs_stat *mistat = kmalloc(v9ses->maxdata, GFP_KERNEL);
-	int err;
-
-	dprintk(DEBUG_VFS, " %lu,%s,%s\n", dir->i_ino, dentry->d_name.name,
-		symname);
-
-	if (!mistat)
-		return -ENOMEM;
-
-	if (!v9ses->extended) {
-		dprintk(DEBUG_ERROR, "not extended\n");
-		goto FreeFcall;
-	}
-
-	/* issue a create */
-	retval = v9fs_create(dir, dentry, S_IFLNK, 0);
-	if (retval != 0)
-		goto FreeFcall;
-
-	newfid = v9fs_fid_lookup(dentry);
-
-	/* issue a twstat */
-	v9fs_blank_mistat(v9ses, mistat);
-	strcpy(mistat->data + 1, symname);
-	mistat->extension = mistat->data + 1;
-	retval = v9fs_t_wstat(v9ses, newfid->fid, mistat, &fcall);
-	if (retval < 0) {
-		dprintk(DEBUG_ERROR, "v9fs_t_wstat error: %s\n",
-			FCALL_ERROR(fcall));
-		goto FreeFcall;
-	}
-
-	kfree(fcall);
-
-	err = v9fs_t_clunk(v9ses, newfid->fid);
-	if (err < 0) {
-		dprintk(DEBUG_ERROR, "clunk for symlink failed: %d\n", err);
-		goto FreeFcall;
-	}
-
-	d_drop(dentry);		/* FID - will this also clunk? */
-
-      FreeFcall:
-	kfree(mistat);
-	kfree(fcall);
-
-	return retval;
-}
-
-/**
  * v9fs_readlink - read a symlink's location (internal version)
  * @dentry: dentry for symlink
  * @buffer: buffer to load symlink location into
@@ -1050,16 +874,17 @@ static int v9fs_readlink(struct dentry *
 	if (!fcall)
 		return -EIO;
 
-	if (!(fcall->params.rstat.stat->mode & V9FS_DMSYMLINK)) {
+	if (!(fcall->params.rstat.stat.mode & V9FS_DMSYMLINK)) {
 		retval = -EINVAL;
 		goto FreeFcall;
 	}
 
 	/* copy extension buffer into buffer */
-	if (strlen(fcall->params.rstat.stat->extension) < buflen)
-		buflen = strlen(fcall->params.rstat.stat->extension);
+	if (fcall->params.rstat.stat.extension.len < buflen)
+		buflen = fcall->params.rstat.stat.extension.len;
 
-	memcpy(buffer, fcall->params.rstat.stat->extension, buflen + 1);
+	memcpy(buffer, fcall->params.rstat.stat.extension.str, buflen - 1);
+	buffer[buflen-1] = 0;
 
 	retval = buflen;
 
@@ -1149,6 +974,77 @@ static void v9fs_vfs_put_link(struct den
 		__putname(s);
 }
 
+static int v9fs_vfs_mkspecial(struct inode *dir, struct dentry *dentry, 
+	int mode, const char *extension)
+{
+	int err, retval;
+	struct v9fs_session_info *v9ses;
+	struct v9fs_fcall *fcall;
+	struct v9fs_fid *fid;
+	struct v9fs_wstat wstat;
+	
+	v9ses = v9fs_inode2v9ses(dir);
+	retval = -EPERM;
+	fcall = NULL;
+
+	if (!v9ses->extended) {
+		dprintk(DEBUG_ERROR, "not extended\n");
+		goto free_mem;
+	}
+
+	/* issue a create */
+	retval = v9fs_create(dir, dentry, mode, 0);
+	if (retval != 0)
+		goto free_mem;
+
+	fid = v9fs_fid_get_created(dentry);
+	if (!fid) {
+		dprintk(DEBUG_ERROR, "couldn't resolve fid from dentry\n");
+		goto free_mem;
+	}
+
+	/* issue a Twstat */
+	v9fs_blank_wstat(&wstat);
+	wstat.muid = v9ses->name;
+	wstat.extension = (char *) extension;
+	retval = v9fs_t_wstat(v9ses, fid->fid, &wstat, &fcall);
+	if (retval < 0) {
+		PRINT_FCALL_ERROR("wstat error", fcall);
+		goto free_mem;
+	}
+
+	err = v9fs_t_clunk(v9ses, fid->fid);
+	if (err < 0) {
+		dprintk(DEBUG_ERROR, "clunk failed: %d\n", err);
+		goto free_mem;
+	}
+
+	d_drop(dentry);		/* FID - will this also clunk? */
+
+free_mem:
+	kfree(fcall);
+	return retval;
+}
+
+/**
+ * v9fs_vfs_symlink - helper function to create symlinks
+ * @dir: directory inode containing symlink
+ * @dentry: dentry for symlink
+ * @symname: symlink data
+ *
+ * See 9P2000.u RFC for more information
+ *
+ */
+
+static int
+v9fs_vfs_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
+{
+	dprintk(DEBUG_VFS, " %lu,%s,%s\n", dir->i_ino, dentry->d_name.name,
+		symname);
+
+	return v9fs_vfs_mkspecial(dir, dentry, S_IFLNK, symname);
+}
+
 /**
  * v9fs_vfs_link - create a hardlink
  * @old_dentry: dentry for file to link to
@@ -1165,66 +1061,24 @@ static int
 v9fs_vfs_link(struct dentry *old_dentry, struct inode *dir,
 	      struct dentry *dentry)
 {
-	int retval = -EPERM;
-	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
-	struct v9fs_fcall *fcall = NULL;
-	struct v9fs_stat *mistat = kmalloc(v9ses->maxdata, GFP_KERNEL);
-	struct v9fs_fid *oldfid = v9fs_fid_lookup(old_dentry);
-	struct v9fs_fid *newfid = NULL;
-	char *symname = __getname();
-	int err;
+	int retval;
+	struct v9fs_fid *oldfid;
+	char *name;
 
 	dprintk(DEBUG_VFS, " %lu,%s,%s\n", dir->i_ino, dentry->d_name.name,
 		old_dentry->d_name.name);
 
-	if (!v9ses->extended) {
-		dprintk(DEBUG_ERROR, "not extended\n");
-		goto FreeMem;
+	oldfid = v9fs_fid_lookup(old_dentry);
+	if (!oldfid) {
+		dprintk(DEBUG_ERROR, "can't find oldfid\n");
+		return -EPERM;
 	}
 
-	/* get fid of old_dentry */
-	sprintf(symname, "hardlink(%d)\n", oldfid->fid);
+	name = __getname();
+	sprintf(name, "hardlink(%d)\n", oldfid->fid);
+	retval = v9fs_vfs_mkspecial(dir, dentry, V9FS_DMLINK, name);
+	__putname(name);
 
-	/* issue a create */
-	retval = v9fs_create(dir, dentry, V9FS_DMLINK, 0);
-	if (retval != 0)
-		goto FreeMem;
-
-	newfid = v9fs_fid_lookup(dentry);
-	if (!newfid) {
-		dprintk(DEBUG_ERROR, "couldn't resolve fid from dentry\n");
-		goto FreeMem;
-	}
-
-	/* issue a twstat */
-	v9fs_blank_mistat(v9ses, mistat);
-	strcpy(mistat->data + 1, symname);
-	mistat->extension = mistat->data + 1;
-	retval = v9fs_t_wstat(v9ses, newfid->fid, mistat, &fcall);
-	if (retval < 0) {
-		dprintk(DEBUG_ERROR, "v9fs_t_wstat error: %s\n",
-			FCALL_ERROR(fcall));
-		goto FreeMem;
-	}
-
-	kfree(fcall);
-
-	err = v9fs_t_clunk(v9ses, newfid->fid);
-
-	if (err < 0) {
-		dprintk(DEBUG_ERROR, "clunk for symlink failed: %d\n", err);
-		goto FreeMem;
-	}
-
-	d_drop(dentry);		/* FID - will this also clunk? */
-
-	kfree(fcall);
-	fcall = NULL;
-
-      FreeMem:
-	kfree(mistat);
-	kfree(fcall);
-	__putname(symname);
 	return retval;
 }
 
@@ -1240,83 +1094,30 @@ v9fs_vfs_link(struct dentry *old_dentry,
 static int
 v9fs_vfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t rdev)
 {
-	int retval = -EPERM;
-	struct v9fs_fid *newfid;
-	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
-	struct v9fs_fcall *fcall = NULL;
-	struct v9fs_stat *mistat = kmalloc(v9ses->maxdata, GFP_KERNEL);
-	char *symname = __getname();
-	int err;
+	int retval;
+	char *name;
 
 	dprintk(DEBUG_VFS, " %lu,%s mode: %x MAJOR: %u MINOR: %u\n", dir->i_ino,
 		dentry->d_name.name, mode, MAJOR(rdev), MINOR(rdev));
 
-	if (!mistat)
-		return -ENOMEM;
-
-	if (!new_valid_dev(rdev)) {
-		retval = -EINVAL;
-		goto FreeMem;
-	}
-
-	if (!v9ses->extended) {
-		dprintk(DEBUG_ERROR, "not extended\n");
-		goto FreeMem;
-	}
-
-	/* issue a create */
-	retval = v9fs_create(dir, dentry, mode, 0);
-
-	if (retval != 0)
-		goto FreeMem;
-
-	newfid = v9fs_fid_lookup(dentry);
-	if (!newfid) {
-		dprintk(DEBUG_ERROR, "coudn't resove fid from dentry\n");
-		retval = -EINVAL;
-		goto FreeMem;
-	}
+	if (!new_valid_dev(rdev))
+		return -EINVAL;
 
+	name = __getname();
 	/* build extension */
 	if (S_ISBLK(mode))
-		sprintf(symname, "b %u %u", MAJOR(rdev), MINOR(rdev));
+		sprintf(name, "b %u %u", MAJOR(rdev), MINOR(rdev));
 	else if (S_ISCHR(mode))
-		sprintf(symname, "c %u %u", MAJOR(rdev), MINOR(rdev));
+		sprintf(name, "c %u %u", MAJOR(rdev), MINOR(rdev));
 	else if (S_ISFIFO(mode))
-		;	/* DO NOTHING */
+		*name = 0;
 	else {
-		retval = -EINVAL;
-		goto FreeMem;
+		__putname(name);
+		return -EINVAL;
 	}
 
-	if (!S_ISFIFO(mode)) {
-		/* issue a twstat */
-		v9fs_blank_mistat(v9ses, mistat);
-		strcpy(mistat->data + 1, symname);
-		mistat->extension = mistat->data + 1;
-		retval = v9fs_t_wstat(v9ses, newfid->fid, mistat, &fcall);
-		if (retval < 0) {
-			dprintk(DEBUG_ERROR, "v9fs_t_wstat error: %s\n",
-				FCALL_ERROR(fcall));
-			goto FreeMem;
-		}
-	}
-
-	/* need to update dcache so we show up */
-	kfree(fcall);
-
-	err = v9fs_t_clunk(v9ses, newfid->fid);
-	if (err < 0) {
-		dprintk(DEBUG_ERROR, "clunk for symlink failed: %d\n", err);
-		goto FreeMem;
-	}
-
-	d_drop(dentry);		/* FID - will this also clunk? */
-
-      FreeMem:
-	kfree(mistat);
-	kfree(fcall);
-	__putname(symname);
+	retval = v9fs_vfs_mkspecial(dir, dentry, mode, name);
+	__putname(name);
 
 	return retval;
 }
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 83b6edd..d4d71a9 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -44,7 +44,6 @@
 #include "v9fs.h"
 #include "9p.h"
 #include "v9fs_vfs.h"
-#include "conv.h"
 #include "fid.h"
 
 static void v9fs_clear_inode(struct inode *);
@@ -123,10 +122,11 @@ static struct super_block *v9fs_get_sb(s
 
 	dprintk(DEBUG_VFS, " \n");
 
-	v9ses = kcalloc(1, sizeof(struct v9fs_session_info), GFP_KERNEL);
+	v9ses = kmalloc(sizeof(struct v9fs_session_info), GFP_KERNEL);
 	if (!v9ses)
 		return ERR_PTR(-ENOMEM);
 
+	memset(v9ses, 0, sizeof(struct v9fs_session_info));
 	if ((newfid = v9fs_session_init(v9ses, dev_name, data)) < 0) {
 		dprintk(DEBUG_ERROR, "problem initiating session\n");
 		kfree(v9ses);
@@ -168,10 +168,10 @@ static struct super_block *v9fs_get_sb(s
 			goto put_back_sb;
 		}
 
-		root_fid->qid = fcall->params.rstat.stat->qid;
+		root_fid->qid = fcall->params.rstat.stat.qid;
 		root->d_inode->i_ino =
-		    v9fs_qid2ino(&fcall->params.rstat.stat->qid);
-		v9fs_mistat2inode(fcall->params.rstat.stat, root->d_inode, sb);
+		    v9fs_qid2ino(&fcall->params.rstat.stat.qid);
+		v9fs_stat2inode(&fcall->params.rstat.stat, root->d_inode, sb);
 	}
 
 	kfree(fcall);
-- 
1.0.6
