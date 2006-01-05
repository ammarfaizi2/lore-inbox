Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWAEAvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWAEAvu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWAEAvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:51:48 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:61603 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751022AbWAEAvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:51:38 -0500
Date: Wed, 4 Jan 2006 19:55:28 -0500
From: Latchesar Ionkov <lucho@ionkov.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: [PATCH 1/3] v9fs: new multiplexer implementation
Message-ID: <20060105005528.GA27375@ionkov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New multiplexer implementation. Decreases the number of kernel threads
required. Better handling when the user process receives a signal.

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>

---

 fs/9p/9p.c         |   68 ++-
 fs/9p/9p.h         |    9 
 fs/9p/conv.c       |   86 ++--
 fs/9p/conv.h       |   13 -
 fs/9p/fid.c        |    2 
 fs/9p/mux.c        | 1136 +++++++++++++++++++++++++++++++++++++---------------
 fs/9p/mux.h        |   46 +-
 fs/9p/trans_fd.c   |   49 ++
 fs/9p/trans_sock.c |  163 +++++--
 fs/9p/transport.h  |    4 
 fs/9p/v9fs.c       |   41 +-
 fs/9p/v9fs.h       |   17 -
 fs/9p/vfs_dentry.c |   13 -
 fs/9p/vfs_dir.c    |   17 -
 fs/9p/vfs_inode.c  |   89 ++--
 fs/9p/vfs_super.c  |    3 
 16 files changed, 1184 insertions(+), 572 deletions(-)

9dbba8fb15d40900ef639a85b5c1e8ade604917e
diff --git a/fs/9p/9p.c b/fs/9p/9p.c
index e847f50..7831b9b 100644
--- a/fs/9p/9p.c
+++ b/fs/9p/9p.c
@@ -52,10 +52,11 @@ v9fs_t_version(struct v9fs_session_info 
 
 	dprintk(DEBUG_9P, "msize: %d version: %s\n", msize, version);
 	msg.id = TVERSION;
+	msg.tag = ~0;
 	msg.params.tversion.msize = msize;
 	msg.params.tversion.version = version;
 
-	return v9fs_mux_rpc(v9ses, &msg, fcall);
+	return v9fs_mux_rpc(v9ses->mux, &msg, fcall);
 }
 
 /**
@@ -83,7 +84,30 @@ v9fs_t_attach(struct v9fs_session_info *
 	msg.params.tattach.uname = uname;
 	msg.params.tattach.aname = aname;
 
-	return v9fs_mux_rpc(v9ses, &msg, fcall);
+	return v9fs_mux_rpc(v9ses->mux, &msg, fcall);
+}
+
+static void v9fs_t_clunk_cb(void *a, struct v9fs_fcall *tc, 
+	struct v9fs_fcall *rc, int err)
+{
+	int fid;
+	struct v9fs_session_info *v9ses;
+
+	if (err)
+		return;
+
+	fid = tc->params.tclunk.fid;
+	kfree(tc);
+
+	if (!rc)
+		return;
+
+	dprintk(DEBUG_9P, "tcall id %d rcall id %d\n", tc->id, rc->id);
+	v9ses = a;
+	if (rc->id == RCLUNK)
+		v9fs_put_idpool(fid, &v9ses->fidpool);
+
+	kfree(rc);
 }
 
 /**
@@ -93,18 +117,24 @@ v9fs_t_attach(struct v9fs_session_info *
  * @fcall: pointer to response fcall pointer
  *
  */
-
 int
-v9fs_t_clunk(struct v9fs_session_info *v9ses, u32 fid,
-	     struct v9fs_fcall **fcall)
+v9fs_t_clunk(struct v9fs_session_info *v9ses, u32 fid)
 {
-	struct v9fs_fcall msg;
+	int err;
+	struct v9fs_fcall *tc, *rc;
+
+	tc = kmalloc(sizeof(struct v9fs_fcall), GFP_KERNEL);
 
 	dprintk(DEBUG_9P, "fid %d\n", fid);
-	msg.id = TCLUNK;
-	msg.params.tclunk.fid = fid;
+	tc->id = TCLUNK;
+	tc->params.tclunk.fid = fid;
 
-	return v9fs_mux_rpc(v9ses, &msg, fcall);
+	err = v9fs_mux_rpc(v9ses->mux, tc, &rc);
+	if (err >= 0) {
+		v9fs_t_clunk_cb(v9ses, tc, rc, 0);
+	}
+
+	return err;
 }
 
 /**
@@ -121,7 +151,7 @@ int v9fs_t_flush(struct v9fs_session_inf
 	dprintk(DEBUG_9P, "oldtag %d\n", tag);
 	msg.id = TFLUSH;
 	msg.params.tflush.oldtag = tag;
-	return v9fs_mux_rpc(v9ses, &msg, NULL);
+	return v9fs_mux_rpc(v9ses->mux, &msg, NULL);
 }
 
 /**
@@ -143,7 +173,7 @@ v9fs_t_stat(struct v9fs_session_info *v9
 
 	msg.id = TSTAT;
 	msg.params.tstat.fid = fid;
-	return v9fs_mux_rpc(v9ses, &msg, fcall);
+	return v9fs_mux_rpc(v9ses->mux, &msg, fcall);
 }
 
 /**
@@ -166,7 +196,7 @@ v9fs_t_wstat(struct v9fs_session_info *v
 	msg.params.twstat.fid = fid;
 	msg.params.twstat.stat = stat;
 
-	return v9fs_mux_rpc(v9ses, &msg, fcall);
+	return v9fs_mux_rpc(v9ses->mux, &msg, fcall);
 }
 
 /**
@@ -199,7 +229,7 @@ v9fs_t_walk(struct v9fs_session_info *v9
 		msg.params.twalk.nwname = 0;
 	}
 
-	return v9fs_mux_rpc(v9ses, &msg, fcall);
+	return v9fs_mux_rpc(v9ses->mux, &msg, fcall);
 }
 
 /**
@@ -217,14 +247,14 @@ v9fs_t_open(struct v9fs_session_info *v9
 	    struct v9fs_fcall **fcall)
 {
 	struct v9fs_fcall msg;
-	long errorno = -1;
+	int errorno = -1;
 
 	dprintk(DEBUG_9P, "fid %d mode %d\n", fid, mode);
 	msg.id = TOPEN;
 	msg.params.topen.fid = fid;
 	msg.params.topen.mode = mode;
 
-	errorno = v9fs_mux_rpc(v9ses, &msg, fcall);
+	errorno = v9fs_mux_rpc(v9ses->mux, &msg, fcall);
 
 	return errorno;
 }
@@ -246,7 +276,7 @@ v9fs_t_remove(struct v9fs_session_info *
 	dprintk(DEBUG_9P, "fid %d\n", fid);
 	msg.id = TREMOVE;
 	msg.params.tremove.fid = fid;
-	return v9fs_mux_rpc(v9ses, &msg, fcall);
+	return v9fs_mux_rpc(v9ses->mux, &msg, fcall);
 }
 
 /**
@@ -275,7 +305,7 @@ v9fs_t_create(struct v9fs_session_info *
 	msg.params.tcreate.perm = perm;
 	msg.params.tcreate.mode = mode;
 
-	return v9fs_mux_rpc(v9ses, &msg, fcall);
+	return v9fs_mux_rpc(v9ses->mux, &msg, fcall);
 }
 
 /**
@@ -302,7 +332,7 @@ v9fs_t_read(struct v9fs_session_info *v9
 	msg.params.tread.fid = fid;
 	msg.params.tread.offset = offset;
 	msg.params.tread.count = count;
-	errorno = v9fs_mux_rpc(v9ses, &msg, &rc);
+	errorno = v9fs_mux_rpc(v9ses->mux, &msg, &rc);
 
 	if (!errorno) {
 		errorno = rc->params.rread.count;
@@ -345,7 +375,7 @@ v9fs_t_write(struct v9fs_session_info *v
 	msg.params.twrite.count = count;
 	msg.params.twrite.data = data;
 
-	errorno = v9fs_mux_rpc(v9ses, &msg, &rc);
+	errorno = v9fs_mux_rpc(v9ses->mux, &msg, &rc);
 
 	if (!errorno)
 		errorno = rc->params.rwrite.count;
diff --git a/fs/9p/9p.h b/fs/9p/9p.h
index f554242..6355392 100644
--- a/fs/9p/9p.h
+++ b/fs/9p/9p.h
@@ -100,6 +100,9 @@ enum {
 	V9FS_QTFILE = 0x00,
 };
 
+#define V9FS_NOTAG	(u16)(~0)
+#define V9FS_NOFID	(u32)(~0)
+
 /* ample room for Twrite/Rread header (iounit) */
 #define V9FS_IOHDRSZ	24
 
@@ -303,6 +306,9 @@ struct v9fs_fcall {
 	} params;
 };
 
+#define V9FS_FCALLHDRSZ (sizeof(struct v9fs_fcall) + \
+	sizeof(struct v9fs_stat) + 16*sizeof(struct v9fs_qid) + 16)
+
 #define FCALL_ERROR(fcall) (fcall ? fcall->params.rerror.error : "")
 
 int v9fs_t_version(struct v9fs_session_info *v9ses, u32 msize,
@@ -311,8 +317,7 @@ int v9fs_t_version(struct v9fs_session_i
 int v9fs_t_attach(struct v9fs_session_info *v9ses, char *uname, char *aname,
 		  u32 fid, u32 afid, struct v9fs_fcall **rcall);
 
-int v9fs_t_clunk(struct v9fs_session_info *v9ses, u32 fid,
-		 struct v9fs_fcall **rcall);
+int v9fs_t_clunk(struct v9fs_session_info *v9ses, u32 fid);
 
 int v9fs_t_flush(struct v9fs_session_info *v9ses, u16 oldtag);
 
diff --git a/fs/9p/conv.c b/fs/9p/conv.c
index 18121af..1b9b15d 100644
--- a/fs/9p/conv.c
+++ b/fs/9p/conv.c
@@ -208,7 +208,7 @@ static inline char *buf_get_stringb(stru
 	len = buf_get_int16(buf);
 
 	if (!buf_check_overflow(buf) && buf_check_size(buf, len) &&
-		buf_check_size(sbuf, len+1)) {
+		buf_check_size(sbuf, len + 1)) {
 
 		memcpy(sbuf->p, buf->p, len);
 		sbuf->p[len] = 0;
@@ -252,13 +252,12 @@ static inline void *buf_get_datab(struct
 
 /**
  * v9fs_size_stat - calculate the size of a variable length stat struct
- * @v9ses: session information
  * @stat: metadata (stat) structure
+ * @extended: non-zero if 9P2000.u
  *
  */
 
-static int v9fs_size_stat(struct v9fs_session_info *v9ses,
-			  struct v9fs_stat *stat)
+static int v9fs_size_stat(struct v9fs_stat *stat, int extended)
 {
 	int size = 0;
 
@@ -288,7 +287,7 @@ static int v9fs_size_stat(struct v9fs_se
 	if (stat->muid)
 		size += strlen(stat->muid);
 
-	if (v9ses->extended) {
+	if (extended) {
 		size += 4 +	/* n_uid[4] */
 		    4 +		/* n_gid[4] */
 		    4 +		/* n_muid[4] */
@@ -302,15 +301,14 @@ static int v9fs_size_stat(struct v9fs_se
 
 /**
  * serialize_stat - safely format a stat structure for transmission
- * @v9ses: session info
  * @stat: metadata (stat) structure
  * @bufp: buffer to serialize structure into
+ * @extended: non-zero if 9P2000.u
  *
  */
 
 static int
-serialize_stat(struct v9fs_session_info *v9ses, struct v9fs_stat *stat,
-	       struct cbuf *bufp)
+serialize_stat(struct v9fs_stat *stat, struct cbuf *bufp, int extended)
 {
 	buf_put_int16(bufp, stat->size);
 	buf_put_int16(bufp, stat->type);
@@ -328,7 +326,7 @@ serialize_stat(struct v9fs_session_info 
 	buf_put_string(bufp, stat->gid);
 	buf_put_string(bufp, stat->muid);
 
-	if (v9ses->extended) {
+	if (extended) {
 		buf_put_string(bufp, stat->extension);
 		buf_put_int32(bufp, stat->n_uid);
 		buf_put_int32(bufp, stat->n_gid);
@@ -343,16 +341,16 @@ serialize_stat(struct v9fs_session_info 
 
 /**
  * deserialize_stat - safely decode a recieved metadata (stat) structure
- * @v9ses: session info
  * @bufp: buffer to deserialize
  * @stat: metadata (stat) structure
  * @dbufp: buffer to deserialize variable strings into
+ * @extended: non-zero if 9P2000.u
  *
  */
 
 static inline int
-deserialize_stat(struct v9fs_session_info *v9ses, struct cbuf *bufp,
-		 struct v9fs_stat *stat, struct cbuf *dbufp)
+deserialize_stat(struct cbuf *bufp, struct v9fs_stat *stat,
+		 struct cbuf *dbufp, int extended)
 {
 
 	stat->size = buf_get_int16(bufp);
@@ -370,7 +368,7 @@ deserialize_stat(struct v9fs_session_inf
 	stat->gid = buf_get_stringb(bufp, dbufp);
 	stat->muid = buf_get_stringb(bufp, dbufp);
 
-	if (v9ses->extended) {
+	if (extended) {
 		stat->extension = buf_get_stringb(bufp, dbufp);
 		stat->n_uid = buf_get_int32(bufp);
 		stat->n_gid = buf_get_int32(bufp);
@@ -385,20 +383,20 @@ deserialize_stat(struct v9fs_session_inf
 
 /**
  * deserialize_statb - wrapper for decoding a received metadata structure
- * @v9ses: session info
  * @bufp: buffer to deserialize
  * @dbufp: buffer to deserialize variable strings into
+ * @extended: non-zero if 9P2000.u
  *
  */
 
-static inline struct v9fs_stat *deserialize_statb(struct v9fs_session_info
-						  *v9ses, struct cbuf *bufp,
-						  struct cbuf *dbufp)
+static inline struct v9fs_stat *deserialize_statb(struct cbuf *bufp,
+						  struct cbuf *dbufp,
+						  int extended)
 {
 	struct v9fs_stat *ret = buf_alloc(dbufp, sizeof(struct v9fs_stat));
 
 	if (ret) {
-		int n = deserialize_stat(v9ses, bufp, ret, dbufp);
+		int n = deserialize_stat(bufp, ret, dbufp, extended);
 		if (n <= 0)
 			return NULL;
 	}
@@ -408,17 +406,16 @@ static inline struct v9fs_stat *deserial
 
 /**
  * v9fs_deserialize_stat - decode a received metadata structure
- * @v9ses: session info
  * @buf: buffer to deserialize
  * @buflen: length of received buffer
  * @stat: metadata structure to decode into
  * @statlen: length of destination metadata structure
+ * @extended: non-zero if 9P2000.u
  *
  */
 
-int
-v9fs_deserialize_stat(struct v9fs_session_info *v9ses, void *buf,
-		      u32 buflen, struct v9fs_stat *stat, u32 statlen)
+int v9fs_deserialize_stat(void *buf, u32 buflen, struct v9fs_stat *stat,
+			  u32 statlen, int extended)
 {
 	struct cbuf buffer;
 	struct cbuf *bufp = &buffer;
@@ -429,11 +426,10 @@ v9fs_deserialize_stat(struct v9fs_sessio
 	buf_init(dbufp, (char *)stat + sizeof(struct v9fs_stat),
 		 statlen - sizeof(struct v9fs_stat));
 
-	return deserialize_stat(v9ses, bufp, stat, dbufp);
+	return deserialize_stat(bufp, stat, dbufp, extended);
 }
 
-static inline int
-v9fs_size_fcall(struct v9fs_session_info *v9ses, struct v9fs_fcall *fcall)
+static inline int v9fs_size_fcall(struct v9fs_fcall *fcall, int extended)
 {
 	int size = 4 + 1 + 2;	/* size[4] msg[1] tag[2] */
 	int i = 0;
@@ -485,7 +481,7 @@ v9fs_size_fcall(struct v9fs_session_info
 		break;
 	case TWSTAT:		/* fid[4] stat[n] */
 		fcall->params.twstat.stat->size =
-		    v9fs_size_stat(v9ses, fcall->params.twstat.stat);
+		    v9fs_size_stat(fcall->params.twstat.stat, extended);
 		size += 4 + 2 + 2 + fcall->params.twstat.stat->size;
 	}
 	return size;
@@ -493,16 +489,16 @@ v9fs_size_fcall(struct v9fs_session_info
 
 /*
  * v9fs_serialize_fcall - marshall fcall struct into a packet
- * @v9ses: session information
  * @fcall: structure to convert
  * @data: buffer to serialize fcall into
  * @datalen: length of buffer to serialize fcall into
+ * @extended: non-zero if 9P2000.u
  *
  */
 
 int
-v9fs_serialize_fcall(struct v9fs_session_info *v9ses, struct v9fs_fcall *fcall,
-		     void *data, u32 datalen)
+v9fs_serialize_fcall(struct v9fs_fcall *fcall, void *data, u32 datalen,
+		     int extended)
 {
 	int i = 0;
 	struct v9fs_stat *stat = NULL;
@@ -516,7 +512,7 @@ v9fs_serialize_fcall(struct v9fs_session
 		return -EINVAL;
 	}
 
-	fcall->size = v9fs_size_fcall(v9ses, fcall);
+	fcall->size = v9fs_size_fcall(fcall, extended);
 
 	buf_put_int32(bufp, fcall->size);
 	buf_put_int8(bufp, fcall->id);
@@ -591,31 +587,31 @@ v9fs_serialize_fcall(struct v9fs_session
 		stat = fcall->params.twstat.stat;
 
 		buf_put_int16(bufp, stat->size + 2);
-		serialize_stat(v9ses, stat, bufp);
+		serialize_stat(stat, bufp, extended);
 		break;
 	}
 
-	if (buf_check_overflow(bufp))
+	if (buf_check_overflow(bufp)) {
+		dprintk(DEBUG_ERROR, "buffer overflow\n");
 		return -EIO;
+	}
 
 	return fcall->size;
 }
 
 /**
  * deserialize_fcall - unmarshal a response
- * @v9ses: session information
- * @msgsize: size of rcall message
  * @buf: recieved buffer
  * @buflen: length of received buffer
  * @rcall: fcall structure to populate
  * @rcalllen: length of fcall structure to populate
+ * @extended: non-zero if 9P2000.u
  *
  */
 
 int
-v9fs_deserialize_fcall(struct v9fs_session_info *v9ses, u32 msgsize,
-		       void *buf, u32 buflen, struct v9fs_fcall *rcall,
-		       int rcalllen)
+v9fs_deserialize_fcall(void *buf, u32 buflen, struct v9fs_fcall *rcall,
+		       int rcalllen, int extended)
 {
 
 	struct cbuf buffer;
@@ -628,7 +624,7 @@ v9fs_deserialize_fcall(struct v9fs_sessi
 	buf_init(dbufp, (char *)rcall + sizeof(struct v9fs_fcall),
 		 rcalllen - sizeof(struct v9fs_fcall));
 
-	rcall->size = msgsize;
+	rcall->size = buf_get_int32(bufp);
 	rcall->id = buf_get_int8(bufp);
 	rcall->tag = buf_get_int16(bufp);
 
@@ -651,6 +647,12 @@ v9fs_deserialize_fcall(struct v9fs_sessi
 		break;
 	case RWALK:
 		rcall->params.rwalk.nwqid = buf_get_int16(bufp);
+		if (rcall->params.rwalk.nwqid > 16) {
+			eprintk(KERN_ERR, "Rwalk with more than 16 qids: %d\n",
+				rcall->params.rwalk.nwqid);
+			return -EPROTO;
+		}
+
 		rcall->params.rwalk.wqids = buf_alloc(dbufp,
 		      rcall->params.rwalk.nwqid * sizeof(struct v9fs_qid));
 		if (rcall->params.rwalk.wqids)
@@ -690,19 +692,21 @@ v9fs_deserialize_fcall(struct v9fs_sessi
 	case RSTAT:
 		buf_get_int16(bufp);
 		rcall->params.rstat.stat =
-		    deserialize_statb(v9ses, bufp, dbufp);
+		    deserialize_statb(bufp, dbufp, extended);
 		break;
 	case RWSTAT:
 		break;
 	case RERROR:
 		rcall->params.rerror.error = buf_get_stringb(bufp, dbufp);
-		if (v9ses->extended)
+		if (extended)
 			rcall->params.rerror.errno = buf_get_int16(bufp);
 		break;
 	}
 
-	if (buf_check_overflow(bufp) || buf_check_overflow(dbufp))
+	if (buf_check_overflow(bufp) || buf_check_overflow(dbufp)) {
+		dprintk(DEBUG_ERROR, "buffer overflow\n");
 		return -EIO;
+	}
 
 	return rcall->size;
 }
diff --git a/fs/9p/conv.h b/fs/9p/conv.h
index ee84961..ad928b7 100644
--- a/fs/9p/conv.h
+++ b/fs/9p/conv.h
@@ -24,13 +24,12 @@
  *
  */
 
-int v9fs_deserialize_stat(struct v9fs_session_info *, void *buf,
-			  u32 buflen, struct v9fs_stat *stat, u32 statlen);
-int v9fs_serialize_fcall(struct v9fs_session_info *, struct v9fs_fcall *tcall,
-			 void *buf, u32 buflen);
-int v9fs_deserialize_fcall(struct v9fs_session_info *, u32 msglen,
-			   void *buf, u32 buflen, struct v9fs_fcall *rcall,
-			   int rcalllen);
+int v9fs_deserialize_stat(void *buf, u32 buflen, struct v9fs_stat *stat, 
+	u32 statlen, int extended);
+int v9fs_serialize_fcall(struct v9fs_fcall *tcall, void *buf, u32 buflen, 
+	int extended);
+int v9fs_deserialize_fcall(void *buf, u32 buflen, struct v9fs_fcall *rcall,
+	int rcalllen, int extended);
 
 /* this one is actually in error.c right now */
 int v9fs_errstr2errno(char *errstr);
diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index d95f862..60ef8ab 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -164,7 +164,7 @@ static struct v9fs_fid *v9fs_fid_walk_up
 	return v9fs_fid_create(dentry, v9ses, fidnum, 0);
 
 clunk_fid:
-	v9fs_t_clunk(v9ses, fidnum, NULL);
+	v9fs_t_clunk(v9ses, fidnum);
 	return ERR_PTR(err);
 }
 
diff --git a/fs/9p/mux.c b/fs/9p/mux.c
index 8835b57..884fa75 100644
--- a/fs/9p/mux.c
+++ b/fs/9p/mux.c
@@ -4,7 +4,7 @@
  * Protocol Multiplexer
  *
  *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
- *  Copyright (C) 2004 by Latchesar Ionkov <lucho@ionkov.net>
+ *  Copyright (C) 2004-2005 by Latchesar Ionkov <lucho@ionkov.net>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -28,6 +28,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/poll.h>
 #include <linux/kthread.h>
 #include <linux/idr.h>
 
@@ -38,438 +39,905 @@
 #include "conv.h"
 #include "mux.h"
 
-/**
- * dprintcond - print condition of session info
- * @v9ses: session info structure
- * @req: RPC request structure
- *
- */
+#define NELEM(x) (sizeof(x) / sizeof((x)[0]))
 
-static inline int
-dprintcond(struct v9fs_session_info *v9ses, struct v9fs_rpcreq *req)
+#define ERREQFLUSH	1
+#define SCHED_TIMEOUT	10
+#define MAXPOLLWADDR	2
+
+enum {
+	Rworksched = 1,		/* read work scheduled or running */
+	Rpending = 2,		/* can read */
+	Wworksched = 4,		/* write work scheduled or running */
+	Wpending = 8,		/* can write */
+};
+
+struct v9fs_mux_poll_task;
+
+struct v9fs_req {
+	int tag;
+	struct v9fs_fcall *tcall;
+	struct v9fs_fcall *rcall;
+	int err;
+	v9fs_mux_req_callback cb;
+	void *cba;
+	struct list_head req_list;
+};
+
+struct v9fs_mux_data {
+	spinlock_t lock;
+	struct list_head mux_list;
+	struct v9fs_mux_poll_task *poll_task;
+	int msize;
+	unsigned char *extended;
+	struct v9fs_transport *trans;
+	struct v9fs_idpool tidpool;
+	int err;
+	wait_queue_head_t equeue;
+	struct list_head req_list;
+	struct list_head unsent_req_list;
+	int rpos;
+	char *rbuf;
+	int wpos;
+	int wsize;
+	char *wbuf;
+	wait_queue_t poll_wait[MAXPOLLWADDR];
+	wait_queue_head_t *poll_waddr[MAXPOLLWADDR];
+	poll_table pt;
+	struct work_struct rq;
+	struct work_struct wq;
+	unsigned long wsched;
+};
+
+struct v9fs_mux_poll_task {
+	struct task_struct *task;
+	struct list_head mux_list;
+	int muxnum;
+};
+
+struct v9fs_mux_rpc {
+	struct v9fs_mux_data *m;
+	struct v9fs_req *req;
+	int err;
+	struct v9fs_fcall *rcall;
+	wait_queue_head_t wqueue;
+};
+
+static int v9fs_poll_proc(void *);
+static void v9fs_read_work(void *);
+static void v9fs_write_work(void *);
+static void v9fs_pollwait(struct file *filp, wait_queue_head_t * wait_address,
+			  poll_table * p);
+
+static DECLARE_MUTEX(v9fs_mux_task_lock);
+static struct workqueue_struct *v9fs_mux_wq;
+
+static int v9fs_mux_num;
+static int v9fs_mux_poll_task_num;
+static struct v9fs_mux_poll_task v9fs_mux_poll_tasks[100];
+
+void v9fs_mux_global_init(void)
 {
-	dprintk(DEBUG_MUX, "condition: %d, %p\n", v9ses->transport->status,
-		req->rcall);
-	return 0;
+	int i;
+
+	for (i = 0; i < NELEM(v9fs_mux_poll_tasks); i++)
+		v9fs_mux_poll_tasks[i].task = NULL;
+
+	v9fs_mux_wq = create_workqueue("v9fs");
+}
+
+void v9fs_mux_global_exit(void)
+{
+	destroy_workqueue(v9fs_mux_wq);
 }
 
 /**
- * xread - force read of a certain number of bytes
- * @v9ses: session info structure
- * @ptr: pointer to buffer
- * @sz: number of bytes to read
+ * v9fs_mux_calc_poll_procs - calculates the number of polling procs
+ * based on the number of mounted v9fs filesystems.
  *
- * Chuck Cranor CS-533 project1
+ * The current implementation returns sqrt of the number of mounts.
  */
+inline int v9fs_mux_calc_poll_procs(int muxnum)
+{
+	int n;
+
+	if (v9fs_mux_poll_task_num)
+		n = muxnum / v9fs_mux_poll_task_num +
+		    (muxnum % v9fs_mux_poll_task_num ? 1 : 0);
+	else
+		n = 1;
+
+	if (n > NELEM(v9fs_mux_poll_tasks))
+		n = NELEM(v9fs_mux_poll_tasks);
+
+	return n;
+}
+
+static void v9fs_mux_poll_start(struct v9fs_mux_data *m)
+{
+	int i, n;
+	struct v9fs_mux_poll_task *vpt, *vptlast;
+
+	dprintk(DEBUG_MUX, "mux %p muxnum %d procnum %d\n", m, v9fs_mux_num,
+		v9fs_mux_poll_task_num);
+	up(&v9fs_mux_task_lock);
+
+	n = v9fs_mux_calc_poll_procs(v9fs_mux_num + 1);
+	if (n > v9fs_mux_poll_task_num) {
+		for (i = 0; i < NELEM(v9fs_mux_poll_tasks); i++) {
+			if (v9fs_mux_poll_tasks[i].task == NULL) {
+				vpt = &v9fs_mux_poll_tasks[i];
+				dprintk(DEBUG_MUX, "create proc %p\n", vpt);
+				vpt->task = kthread_create(v9fs_poll_proc, 
+					vpt, "v9fs-poll");
+				INIT_LIST_HEAD(&vpt->mux_list);
+				vpt->muxnum = 0;
+				v9fs_mux_poll_task_num++;
+				wake_up_process(vpt->task);
+				break;
+			}
+		}
 
-static int xread(struct v9fs_session_info *v9ses, void *ptr, unsigned long sz)
+		if (i >= NELEM(v9fs_mux_poll_tasks))
+			dprintk(DEBUG_ERROR, "warning: no free poll slots\n");
+	}
+
+	n = (v9fs_mux_num + 1) / v9fs_mux_poll_task_num +
+	    ((v9fs_mux_num + 1) % v9fs_mux_poll_task_num ? 1 : 0);
+
+	vptlast = NULL;
+	for (i = 0; i < NELEM(v9fs_mux_poll_tasks); i++) {
+		vpt = &v9fs_mux_poll_tasks[i];
+		if (vpt->task != NULL) {
+			vptlast = vpt;
+			if (vpt->muxnum < n) {
+				dprintk(DEBUG_MUX, "put in proc %d\n", i);
+				list_add(&m->mux_list, &vpt->mux_list);
+				vpt->muxnum++;
+				m->poll_task = vpt;
+				memset(&m->poll_waddr, 0, sizeof(m->poll_waddr));
+				init_poll_funcptr(&m->pt, v9fs_pollwait);
+				break;
+			}
+		}
+	}
+
+	if (i >= NELEM(v9fs_mux_poll_tasks)) {
+		dprintk(DEBUG_MUX, "put in proc %d\n", i);
+		list_add(&m->mux_list, &vptlast->mux_list);
+		vptlast->muxnum++;
+		m->poll_task = vpt;
+		memset(&m->poll_waddr, 0, sizeof(m->poll_waddr));
+		init_poll_funcptr(&m->pt, v9fs_pollwait);
+	}
+
+	v9fs_mux_num++;
+	down(&v9fs_mux_task_lock);
+}
+
+static void v9fs_mux_poll_stop(struct v9fs_mux_data *m)
 {
-	int rd = 0;
-	int ret = 0;
-	while (rd < sz) {
-		ret = v9ses->transport->read(v9ses->transport, ptr, sz - rd);
-		if (ret <= 0) {
-			dprintk(DEBUG_ERROR, "xread errno %d\n", ret);
-			return ret;
+	int i;
+	struct v9fs_mux_poll_task *vpt;
+
+	up(&v9fs_mux_task_lock);
+	vpt = m->poll_task;
+	list_del(&m->mux_list);
+	for(i = 0; i < NELEM(m->poll_waddr); i++) {
+		if (m->poll_waddr[i] != NULL) {
+			remove_wait_queue(m->poll_waddr[i], &m->poll_wait[i]);
+			m->poll_waddr[i] = NULL;
 		}
-		rd += ret;
-		ptr += ret;
 	}
-	return (rd);
+	vpt->muxnum--;
+	if (!vpt->muxnum) {
+		dprintk(DEBUG_MUX, "destroy proc %p\n", vpt);
+		send_sig(SIGKILL, vpt->task, 1);
+		vpt->task = NULL;
+		v9fs_mux_poll_task_num--;
+	}
+	v9fs_mux_num--;
+	down(&v9fs_mux_task_lock);
 }
 
 /**
- * read_message - read a full 9P2000 fcall packet
- * @v9ses: session info structure
- * @rcall: fcall structure to read into
- * @rcalllen: size of fcall buffer
+ * v9fs_mux_init - allocate and initialize the per-session mux data
+ * Creates the polling task if this is the first session.
  *
+ * @trans - transport structure
+ * @msize - maximum message size
+ * @extended - pointer to the extended flag
  */
-
-static int
-read_message(struct v9fs_session_info *v9ses,
-	     struct v9fs_fcall *rcall, int rcalllen)
+struct v9fs_mux_data *v9fs_mux_init(struct v9fs_transport *trans, int msize,
+				    unsigned char *extended)
 {
-	unsigned char buf[4];
-	void *data;
-	int size = 0;
-	int res = 0;
+	int i, n;
+	struct v9fs_mux_data *m, *mtmp;
 
-	res = xread(v9ses, buf, sizeof(buf));
-	if (res < 0) {
-		dprintk(DEBUG_ERROR,
-			"Reading of count field failed returned: %d\n", res);
-		return res;
+	dprintk(DEBUG_MUX, "transport %p msize %d\n", trans, msize);
+	m = kmalloc(sizeof(struct v9fs_mux_data) + 2 * msize, GFP_KERNEL);
+	if (!m)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock_init(&m->lock);
+	INIT_LIST_HEAD(&m->mux_list);
+	m->msize = msize;
+	m->extended = extended;
+	m->trans = trans;
+	idr_init(&m->tidpool.pool);
+	init_MUTEX(&m->tidpool.lock);
+	m->err = 0;
+	init_waitqueue_head(&m->equeue);
+	INIT_LIST_HEAD(&m->req_list);
+	INIT_LIST_HEAD(&m->unsent_req_list);
+	m->rpos = 0;
+	m->rbuf = (char *)m + sizeof(struct v9fs_mux_data);
+	m->wpos = m->wsize = 0;
+	m->wbuf = m->rbuf + msize;
+	INIT_WORK(&m->rq, v9fs_read_work, m);
+	INIT_WORK(&m->wq, v9fs_write_work, m);
+	m->wsched = 0;
+	memset(&m->poll_waddr, 0, sizeof(m->poll_waddr));
+	v9fs_mux_poll_start(m);
+
+	n = trans->poll(trans, &m->pt);
+	if (n & POLLIN) {
+		dprintk(DEBUG_MUX, "mux %p can read\n", m);
+		set_bit(Rpending, &m->wsched);
+	}
+
+	if (n & POLLOUT) {
+		dprintk(DEBUG_MUX, "mux %p can write\n", m);
+		set_bit(Wpending, &m->wsched);
+	}
+
+	for(i = 0; i < NELEM(m->poll_waddr); i++) {
+		if (IS_ERR(m->poll_waddr[i])) {
+			v9fs_mux_poll_stop(m);
+			mtmp = (void *)m->poll_waddr;	/* the error code */
+			kfree(m);
+			m = mtmp;
+			break;
+		}
 	}
 
-	if (res < 4) {
-		dprintk(DEBUG_ERROR,
-			"Reading of count field failed returned: %d\n", res);
-		return -EIO;
+	return m;
+}
+
+/**
+ * v9fs_mux_destroy - cancels all pending requests and frees mux resources
+ */
+void v9fs_mux_destroy(struct v9fs_mux_data *m)
+{
+	dprintk(DEBUG_MUX, "mux %p prev %p next %p\n", m,
+		m->mux_list.prev, m->mux_list.next);
+	v9fs_mux_cancel(m, -ECONNRESET);
+
+	if (!list_empty(&m->req_list)) {
+		/* wait until all processes waiting on this session exit */
+		dprintk(DEBUG_MUX, "mux %p waiting for empty request queue\n",
+			m);
+		wait_event_timeout(m->equeue, (list_empty(&m->req_list)), 5000);
+		dprintk(DEBUG_MUX, "mux %p request queue empty: %d\n", m,
+			list_empty(&m->req_list));
 	}
 
-	size = buf[0] | (buf[1] << 8) | (buf[2] << 16) | (buf[3] << 24);
-	dprintk(DEBUG_MUX, "got a packet count: %d\n", size);
+	v9fs_mux_poll_stop(m);
+	m->trans = NULL;
 
-	/* adjust for the four bytes of size */
-	size -= 4;
+	kfree(m);
+}
 
-	if (size > v9ses->maxdata) {
-		dprintk(DEBUG_ERROR, "packet too big: %d\n", size);
-		return -E2BIG;
-	}
+/**
+ * v9fs_pollwait - called by files poll operation to add v9fs-poll task
+ * 	to files wait queue
+ */
+static void
+v9fs_pollwait(struct file *filp, wait_queue_head_t * wait_address,
+	      poll_table * p)
+{
+	int i;
+	struct v9fs_mux_data *m;
 
-	data = kmalloc(size, GFP_KERNEL);
-	if (!data) {
-		eprintk(KERN_WARNING, "out of memory\n");
-		return -ENOMEM;
+	m = container_of(p, struct v9fs_mux_data, pt);
+	for(i = 0; i < NELEM(m->poll_waddr); i++)
+		if (m->poll_waddr[i] == NULL)
+			break;
+
+	if (i >= NELEM(m->poll_waddr)) {
+		dprintk(DEBUG_ERROR, "not enough wait_address slots\n");
+		return;
 	}
 
-	res = xread(v9ses, data, size);
-	if (res < size) {
-		dprintk(DEBUG_ERROR, "Reading of fcall failed returned: %d\n",
-			res);
-		kfree(data);
-		return res;
+	m->poll_waddr[i] = wait_address;
+
+	if (!wait_address) {
+		dprintk(DEBUG_ERROR, "no wait_address\n");
+		m->poll_waddr[i] = ERR_PTR(-EIO);
+		return;
 	}
 
-	/* we now have an in-memory string that is the reply.
-	 * deserialize it. There is very little to go wrong at this point
-	 * save for v9fs_alloc errors.
-	 */
-	res = v9fs_deserialize_fcall(v9ses, size, data, v9ses->maxdata,
-				     rcall, rcalllen);
+	init_waitqueue_entry(&m->poll_wait[i], m->poll_task->task);
+	add_wait_queue(wait_address, &m->poll_wait[i]);
+}
 
-	kfree(data);
+/**
+ * v9fs_poll_mux - polls a mux and schedules read or write works if necessary
+ */
+static inline void v9fs_poll_mux(struct v9fs_mux_data *m)
+{
+	int n;
 
-	if (res < 0)
-		return res;
+	if (m->err < 0)
+		return;
 
-	return 0;
+	n = m->trans->poll(m->trans, NULL);
+	if (n < 0 || n & (POLLERR | POLLHUP | POLLNVAL)) {
+		dprintk(DEBUG_MUX, "error mux %p err %d\n", m, n);
+		if (n >= 0)
+			n = -ECONNRESET;
+		v9fs_mux_cancel(m, n);
+	}
+
+	if (n & POLLIN) {
+		set_bit(Rpending, &m->wsched);
+		dprintk(DEBUG_MUX, "mux %p can read\n", m);
+		if (!test_and_set_bit(Rworksched, &m->wsched)) {
+			dprintk(DEBUG_MUX, "schedule read work mux %p\n", m);
+			queue_work(v9fs_mux_wq, &m->rq);
+		}
+	}
+
+	if (n & POLLOUT) {
+		set_bit(Wpending, &m->wsched);
+		dprintk(DEBUG_MUX, "mux %p can write\n", m);
+		if ((m->wsize || !list_empty(&m->unsent_req_list))
+		    && !test_and_set_bit(Wworksched, &m->wsched)) {
+			dprintk(DEBUG_MUX, "schedule write work mux %p\n", m);
+			queue_work(v9fs_mux_wq, &m->wq);
+		}
+	}
 }
 
 /**
- * v9fs_recv - receive an RPC response for a particular tag
- * @v9ses: session info structure
- * @req: RPC request structure
- *
+ * v9fs_poll_proc - polls all v9fs transports for new events and queues
+ * 	the appropriate work to the work queue
  */
-
-static int v9fs_recv(struct v9fs_session_info *v9ses, struct v9fs_rpcreq *req)
+static int v9fs_poll_proc(void *a)
 {
-	int ret = 0;
+	struct v9fs_mux_data *m, *mtmp;
+	struct v9fs_mux_poll_task *vpt;
+
+	vpt = a;
+	dprintk(DEBUG_MUX, "start %p %p\n", current, vpt);
+	allow_signal(SIGKILL);
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (signal_pending(current))
+			break;
 
-	dprintk(DEBUG_MUX, "waiting for response: %d\n", req->tcall->tag);
-	ret = wait_event_interruptible(v9ses->read_wait,
-		       ((v9ses->transport->status != Connected) ||
-			(req->rcall != 0) || (req->err < 0) ||
-			dprintcond(v9ses, req)));
+		list_for_each_entry_safe(m, mtmp, &vpt->mux_list, mux_list) {
+			v9fs_poll_mux(m);
+		}
 
-	dprintk(DEBUG_MUX, "got it: rcall %p\n", req->rcall);
+		dprintk(DEBUG_MUX, "sleeping...\n");
+		schedule_timeout(SCHED_TIMEOUT * HZ);
+	}
 
-	spin_lock(&v9ses->muxlock);
-	list_del(&req->next);
-	spin_unlock(&v9ses->muxlock);
+	__set_current_state(TASK_RUNNING);
+	dprintk(DEBUG_MUX, "finish\n");
+	return 0;
+}
 
-	if (req->err < 0)
-		return req->err;
+static inline int v9fs_write_req(struct v9fs_mux_data *m, struct v9fs_req *req)
+{
+	int n;
 
-	if (v9ses->transport->status == Disconnected)
-		return -ECONNRESET;
+	list_move_tail(&req->req_list, &m->req_list);
+	n = v9fs_serialize_fcall(req->tcall, m->wbuf, m->msize, *m->extended);
+	if (n < 0) {
+		req->err = n;
+		list_del(&req->req_list);
+		if (req->cb) {
+			spin_unlock(&m->lock);
+			(*req->cb) (req->cba, req->tcall, req->rcall, req->err);
+			req->cb = NULL;
+			spin_lock(&m->lock);
+		} else
+			kfree(req->rcall);
 
-	return ret;
+		kfree(req);
+	}
+
+	return n;
 }
 
 /**
- * v9fs_send - send a 9P request
- * @v9ses: session info structure
- * @req: RPC request to send
- *
+ * v9fs_write_work - called when a transport can send some data
  */
-
-static int v9fs_send(struct v9fs_session_info *v9ses, struct v9fs_rpcreq *req)
+static void v9fs_write_work(void *a)
 {
-	int ret = -1;
-	void *data = NULL;
-	struct v9fs_fcall *tcall = req->tcall;
-
-	data = kmalloc(v9ses->maxdata + V9FS_IOHDRSZ, GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	tcall->size = 0;	/* enforce size recalculation */
-	ret =
-	    v9fs_serialize_fcall(v9ses, tcall, data,
-				 v9ses->maxdata + V9FS_IOHDRSZ);
-	if (ret < 0)
-		goto free_data;
-
-	spin_lock(&v9ses->muxlock);
-	list_add(&req->next, &v9ses->mux_fcalls);
-	spin_unlock(&v9ses->muxlock);
-
-	dprintk(DEBUG_MUX, "sending message: tag %d size %d\n", tcall->tag,
-		tcall->size);
-	ret = v9ses->transport->write(v9ses->transport, data, tcall->size);
-
-	if (ret != tcall->size) {
-		spin_lock(&v9ses->muxlock);
-		list_del(&req->next);
-		kfree(req->rcall);
+	int n, err;
+	struct v9fs_mux_data *m;
+	struct v9fs_req *req, *rtmp;
+
+	m = a;
+
+	if (m->err < 0) {
+		clear_bit(Wworksched, &m->wsched);
+		return;
+	}
 
-		spin_unlock(&v9ses->muxlock);
-		if (ret >= 0)
-			ret = -EREMOTEIO;
+	if (!m->wsize) {
+		if (list_empty(&m->unsent_req_list)) {
+			clear_bit(Wworksched, &m->wsched);
+			return;
+		}
+
+		err = 0;
+		spin_lock(&m->lock);
+		list_for_each_entry_safe(req, rtmp, &m->unsent_req_list,
+					 req_list) {
+			err = v9fs_write_req(m, req);
+			if (err > 0)
+				break;
+		}
+
+		m->wsize = err;
+		m->wpos = 0;
+		spin_unlock(&m->lock);
+	}
+
+	dprintk(DEBUG_MUX, "mux %p pos %d size %d\n", m, m->wpos, m->wsize);
+	clear_bit(Wpending, &m->wsched);
+	err = m->trans->write(m->trans, m->wbuf + m->wpos, m->wsize - m->wpos);
+	dprintk(DEBUG_MUX, "mux %p sent %d bytes\n", m, err);
+	if (err == -EAGAIN) {
+		clear_bit(Wworksched, &m->wsched);
+		return;
+	}
+
+	if (err <= 0)
+		goto error;
+
+	m->wpos += err;
+	if (m->wpos == m->wsize)
+		m->wpos = m->wsize = 0;
+
+	if (m->wsize == 0 && !list_empty(&m->unsent_req_list)) {
+		if (test_and_clear_bit(Wpending, &m->wsched))
+			n = POLLOUT;
+		else
+			n = m->trans->poll(m->trans, NULL);
+
+		if (n & POLLOUT) {
+			dprintk(DEBUG_MUX, "schedule write work mux %p\n", m);
+			queue_work(v9fs_mux_wq, &m->wq);
+		} else
+			clear_bit(Wworksched, &m->wsched);
 	} else
-		ret = 0;
+		clear_bit(Wworksched, &m->wsched);
+
+	return;
 
-      free_data:
-	kfree(data);
-	return ret;
+      error:
+	v9fs_mux_cancel(m, err);
+	clear_bit(Wworksched, &m->wsched);
 }
 
-/**
- * v9fs_mux_rpc - send a request, receive a response
- * @v9ses: session info structure
- * @tcall: fcall to send
- * @rcall: buffer to place response into
- *
- */
+static void process_request(struct v9fs_mux_data *m, struct v9fs_req *req)
+{
+	int ecode, tag;
+	char *ename;
+
+	tag = req->tag;
+	if (req->rcall->id == RERROR && !req->err) {
+		ecode = req->rcall->params.rerror.errno;
+		ename = req->rcall->params.rerror.error;
+
+		dprintk(DEBUG_MUX, "Rerror %s\n", ename);
 
-long
-v9fs_mux_rpc(struct v9fs_session_info *v9ses, struct v9fs_fcall *tcall,
-	     struct v9fs_fcall **rcall)
-{
-	int tid = -1;
-	struct v9fs_fcall *fcall = NULL;
-	struct v9fs_rpcreq req;
-	int ret = -1;
-
-	if (!v9ses)
-		return -EINVAL;
-
-	if (!v9ses->transport || v9ses->transport->status != Connected)
-		return -EIO;
-
-	if (rcall)
-		*rcall = NULL;
-
-	if (tcall->id != TVERSION) {
-		tid = v9fs_get_idpool(&v9ses->tidpool);
-		if (tid < 0)
-			return -ENOMEM;
-	}
-
-	tcall->tag = tid;
-
-	req.tcall = tcall;
-	req.err = 0;
-	req.rcall = NULL;
-
-	ret = v9fs_send(v9ses, &req);
-
-	if (ret < 0) {
-		if (tcall->id != TVERSION)
-			v9fs_put_idpool(tid, &v9ses->tidpool);
-		dprintk(DEBUG_MUX, "error %d\n", ret);
-		return ret;
-	}
-
-	ret = v9fs_recv(v9ses, &req);
-
-	fcall = req.rcall;
-
-	dprintk(DEBUG_MUX, "received: tag=%x, ret=%d\n", tcall->tag, ret);
-	if (ret == -ERESTARTSYS) {
-		if (v9ses->transport->status != Disconnected
-		    && tcall->id != TFLUSH) {
-			unsigned long flags;
-
-			dprintk(DEBUG_MUX, "flushing the tag: %d\n",
-				tcall->tag);
-			clear_thread_flag(TIF_SIGPENDING);
-			v9fs_t_flush(v9ses, tcall->tag);
-			spin_lock_irqsave(&current->sighand->siglock, flags);
-			recalc_sigpending();
-			spin_unlock_irqrestore(&current->sighand->siglock,
-					       flags);
-			dprintk(DEBUG_MUX, "flushing done\n");
-		}
-
-		goto release_req;
-	} else if (ret < 0)
-		goto release_req;
-
-	if (!fcall)
-		ret = -EIO;
-	else {
-		if (fcall->id == RERROR) {
-			ret = v9fs_errstr2errno(fcall->params.rerror.error);
-			if (ret == 0) {	/* string match failed */
-				if (fcall->params.rerror.errno)
-					ret = -(fcall->params.rerror.errno);
-				else
-					ret = -ESERVERFAULT;
+		if (*m->extended)
+			req->err = -ecode;
+
+		if (!req->err) {
+			req->err = v9fs_errstr2errno(ename);
+
+			if (!req->err) {	/* string match failed */
+				dprintk(DEBUG_ERROR, "unknown error: %s\n",
+					ename);
 			}
-		} else if (fcall->id != tcall->id + 1) {
-			dprintk(DEBUG_ERROR,
-				"fcall mismatch: expected %d, got %d\n",
-				tcall->id + 1, fcall->id);
-			ret = -EIO;
+
+			if (!req->err)
+				req->err = -ESERVERFAULT;
 		}
+	} else if (req->tcall && req->rcall->id != req->tcall->id + 1) {
+		dprintk(DEBUG_ERROR, "fcall mismatch: expected %d, got %d\n",
+			req->tcall->id + 1, req->rcall->id);
+		if (!req->err)
+			req->err = -EIO;
 	}
 
-      release_req:
-	if (tcall->id != TVERSION)
-		v9fs_put_idpool(tid, &v9ses->tidpool);
-	if (rcall)
-		*rcall = fcall;
-	else
-		kfree(fcall);
+	if (req->cb && req->err != ERREQFLUSH) {
+		dprintk(DEBUG_MUX, "calling callback tcall %p rcall %p\n",
+			req->tcall, req->rcall);
 
-	return ret;
-}
+		(*req->cb) (req->cba, req->tcall, req->rcall, req->err);
+		req->cb = NULL;
+	} else
+		kfree(req->rcall);
 
-/**
- * v9fs_mux_cancel_requests - cancels all pending requests
- *
- * @v9ses: session info structure
- * @err: error code to return to the requests
- */
-void v9fs_mux_cancel_requests(struct v9fs_session_info *v9ses, int err)
-{
-	struct v9fs_rpcreq *rptr;
-	struct v9fs_rpcreq *rreq;
+	if (tag != V9FS_NOTAG)
+		v9fs_put_idpool(tag, &m->tidpool);
 
-	dprintk(DEBUG_MUX, " %d\n", err);
-	spin_lock(&v9ses->muxlock);
-	list_for_each_entry_safe(rreq, rptr, &v9ses->mux_fcalls, next) {
-		rreq->err = err;
-	}
-	spin_unlock(&v9ses->muxlock);
-	wake_up_all(&v9ses->read_wait);
+	wake_up(&m->equeue);
+	kfree(req);
 }
 
 /**
- * v9fs_recvproc - kproc to handle demultiplexing responses
- * @data: session info structure
- *
+ * v9fs_read_work - called when there is some data to be read from a transport
  */
-
-static int v9fs_recvproc(void *data)
+static void v9fs_read_work(void *a)
 {
-	struct v9fs_session_info *v9ses = (struct v9fs_session_info *)data;
-	struct v9fs_fcall *rcall = NULL;
-	struct v9fs_rpcreq *rptr;
-	struct v9fs_rpcreq *req;
-	struct v9fs_rpcreq *rreq;
-	int err = 0;
+	int n, err, rcallen;
+	struct v9fs_mux_data *m;
+	struct v9fs_req *req, *rptr, *rreq;
+	struct v9fs_fcall *rcall;
+
+	m = a;
+
+	if (m->err < 0)
+		return;
+
+	rcall = NULL;
+	dprintk(DEBUG_MUX, "start mux %p pos %d\n", m, m->rpos);
+	clear_bit(Rpending, &m->wsched);
+	err = m->trans->read(m->trans, m->rbuf + m->rpos, m->msize - m->rpos);
+	dprintk(DEBUG_MUX, "mux %p got %d bytes\n", m, err);
+	if (err == -EAGAIN) {
+		clear_bit(Rworksched, &m->wsched);
+		return;
+	}
+
+	if (err <= 0)
+		goto error;
+
+	m->rpos += err;
+	while (m->rpos > 4) {
+		n = le32_to_cpu(*(__le32 *) m->rbuf);
+		if (n >= m->msize) {
+			dprintk(DEBUG_ERROR,
+				"requested packet size too big: %d\n", n);
+			err = -EIO;
+			goto error;
+		}
 
-	allow_signal(SIGKILL);
-	set_current_state(TASK_INTERRUPTIBLE);
-	complete(&v9ses->proccmpl);
-	while (!kthread_should_stop() && err >= 0) {
-		req = rptr = rreq = NULL;
+		if (m->rpos < n)
+			break;
 
-		rcall = kmalloc(v9ses->maxdata + V9FS_IOHDRSZ, GFP_KERNEL);
+		rcallen = n + V9FS_FCALLHDRSZ;
+		rcall = kmalloc(rcallen, GFP_KERNEL);
 		if (!rcall) {
-			eprintk(KERN_ERR, "no memory for buffers\n");
-			break;
+			err = -ENOMEM;
+			goto error;
 		}
 
-		err = read_message(v9ses, rcall, v9ses->maxdata + V9FS_IOHDRSZ);
-		spin_lock(&v9ses->muxlock);
+		dump_data(m->rbuf, n);
+		err = v9fs_deserialize_fcall(m->rbuf, n, rcall, rcallen,
+					     *m->extended);
 		if (err < 0) {
-			list_for_each_entry_safe(rreq, rptr, &v9ses->mux_fcalls, next) {
-				rreq->err = err;
-			}
-			if(err != -ERESTARTSYS)
-				eprintk(KERN_ERR,
-					"Transport error while reading message %d\n", err);
-		} else {
-			list_for_each_entry_safe(rreq, rptr, &v9ses->mux_fcalls, next) {
-				if (rreq->tcall->tag == rcall->tag) {
-					req = rreq;
-					req->rcall = rcall;
-					break;
-				}
-			}
+			kfree(rcall);
+			goto error;
 		}
 
-		if (req && (req->tcall->id == TFLUSH)) {
-			struct v9fs_rpcreq *treq = NULL;
-			list_for_each_entry_safe(treq, rptr, &v9ses->mux_fcalls, next) {
-				if (treq->tcall->tag ==
-				    req->tcall->params.tflush.oldtag) {
-					list_del(&rptr->next);
-					kfree(treq->rcall);
-					break;
-				}
+		dprintk(DEBUG_MUX, "mux %p fcall id %d tag %d\n", m, rcall->id,
+			rcall->tag);
+
+		req = NULL;
+		spin_lock(&m->lock);
+		list_for_each_entry_safe(rreq, rptr, &m->req_list, req_list) {
+			if (rreq->tag == rcall->tag) {
+				req = rreq;
+				req->rcall = rcall;
+				list_del(&req->req_list);
+				spin_unlock(&m->lock);
+				process_request(m, req);
+				break;
 			}
 		}
 
-		spin_unlock(&v9ses->muxlock);
-
 		if (!req) {
-			if (err >= 0)
+			spin_unlock(&m->lock);
+			if (err >= 0 && rcall->id != RFLUSH)
 				dprintk(DEBUG_ERROR,
-					"unexpected response: id %d tag %d\n",
-					rcall->id, rcall->tag);
-
+					"unexpected response mux %p id %d tag %d\n",
+					m, rcall->id, rcall->tag);
 			kfree(rcall);
 		}
 
-		wake_up_all(&v9ses->read_wait);
-		set_current_state(TASK_INTERRUPTIBLE);
+		if (m->rpos > n)
+			memmove(m->rbuf, m->rbuf + n, m->rpos - n);
+		m->rpos -= n;
+	}
+
+	if (!list_empty(&m->req_list)) {
+		if (test_and_clear_bit(Rpending, &m->wsched))
+			n = POLLIN;
+		else
+			n = m->trans->poll(m->trans, NULL);
+
+		if (n & POLLIN) {
+			dprintk(DEBUG_MUX, "schedule read work mux %p\n", m);
+			queue_work(v9fs_mux_wq, &m->rq);
+		} else
+			clear_bit(Rworksched, &m->wsched);
+	} else
+		clear_bit(Rworksched, &m->wsched);
+
+	return;
+
+      error:
+	v9fs_mux_cancel(m, err);
+	clear_bit(Rworksched, &m->wsched);
+}
+
+/**
+ * v9fs_send_request - send 9P request
+ * The function can sleep until the request is scheduled for sending.
+ * The function can be interrupted. Return from the function is not
+ * a guarantee that the request is sent succesfully. Can return errors
+ * that can be retrieved by PTR_ERR macros.
+ *
+ * @m: mux data
+ * @tc: request to be sent
+ * @cb: callback function to call when response is received
+ * @cba: parameter to pass to the callback function
+ */
+static struct v9fs_req *v9fs_send_request(struct v9fs_mux_data *m,
+					  struct v9fs_fcall *tc,
+					  v9fs_mux_req_callback cb, void *cba)
+{
+	int n;
+	struct v9fs_req *req;
+
+	dprintk(DEBUG_MUX, "mux %p task %p tcall %p id %d\n", m, current,
+		tc, tc->id);
+	if (m->err < 0)
+		return ERR_PTR(m->err);
+
+	req = kmalloc(sizeof(struct v9fs_req), GFP_KERNEL);
+	if (!req)
+		return ERR_PTR(-ENOMEM);
+
+	if (tc->id == TVERSION)
+		n = V9FS_NOTAG;
+	else
+		n = v9fs_get_idpool(&m->tidpool);
+
+	if (n < 0)
+		return ERR_PTR(-ENOMEM);
+
+	tc->tag = n;
+	req->tag = n;
+	req->tcall = tc;
+	req->rcall = NULL;
+	req->err = 0;
+	req->cb = cb;
+	req->cba = cba;
+
+	spin_lock(&m->lock);
+	list_add_tail(&req->req_list, &m->unsent_req_list);
+	spin_unlock(&m->lock);
+
+	if (test_and_clear_bit(Wpending, &m->wsched))
+		n = POLLOUT;
+	else
+		n = m->trans->poll(m->trans, NULL);
+
+	if (n & POLLOUT && !test_and_set_bit(Wworksched, &m->wsched))
+		queue_work(v9fs_mux_wq, &m->wq);
+
+	return req;
+}
+
+static inline void
+v9fs_mux_flush_cb(void *a, struct v9fs_fcall *tc, struct v9fs_fcall *rc,
+		  int err)
+{
+	v9fs_mux_req_callback cb;
+	int tag;
+	struct v9fs_mux_data *m;
+	struct v9fs_req *req, *rptr;
+
+	m = a;
+	dprintk(DEBUG_MUX, "mux %p tc %p rc %p err %d oldtag %d\n", m, tc,
+		rc, err, tc->params.tflush.oldtag);
+
+	spin_lock(&m->lock);
+	cb = NULL;
+	tag = tc->params.tflush.oldtag;
+	list_for_each_entry_safe(req, rptr, &m->req_list, req_list) {
+		if (req->tag == tag) {
+			list_del(&req->req_list);
+			if (req->cb) {
+				cb = req->cb;
+				req->cb = NULL;
+				spin_unlock(&m->lock);
+				(*cb) (req->cba, req->tcall, req->rcall,
+				       req->err);
+			}
+			kfree(req);
+			wake_up(&m->equeue);
+			break;
+		}
 	}
 
-	v9ses->transport->close(v9ses->transport);
+	if (!cb)
+		spin_unlock(&m->lock);
+
+	if (v9fs_check_idpool(tag, &m->tidpool))
+		v9fs_put_idpool(tag, &m->tidpool);
+
+	kfree(tc);
+	kfree(rc);
+}
 
-	/* Inform all pending processes about the failure */
-	wake_up_all(&v9ses->read_wait);
+static void
+v9fs_mux_flush_request(struct v9fs_mux_data *m, struct v9fs_req *req)
+{
+	struct v9fs_fcall *fc;
 
-	if (signal_pending(current))
-		complete(&v9ses->proccmpl);
+	dprintk(DEBUG_MUX, "mux %p req %p tag %d\n", m, req, req->tag);
 
-	dprintk(DEBUG_MUX, "recvproc: end\n");
-	v9ses->recvproc = NULL;
+	fc = kmalloc(sizeof(struct v9fs_fcall), GFP_KERNEL);
+	fc->id = TFLUSH;
+	fc->params.tflush.oldtag = req->tag;
 
-	return err >= 0;
+	v9fs_send_request(m, fc, v9fs_mux_flush_cb, m);
+}
+
+static void
+v9fs_mux_rpc_cb(void *a, struct v9fs_fcall *tc, struct v9fs_fcall *rc, int err)
+{
+	struct v9fs_mux_rpc *r;
+
+	if (err == ERREQFLUSH) {
+		dprintk(DEBUG_MUX, "err req flush\n");
+		return;
+	}
+
+	r = a;
+	dprintk(DEBUG_MUX, "mux %p req %p tc %p rc %p err %d\n", r->m, r->req,
+		tc, rc, err);
+	r->rcall = rc;
+	r->err = err;
+	wake_up(&r->wqueue);
 }
 
 /**
- * v9fs_mux_init - initialize multiplexer (spawn kproc)
- * @v9ses: session info structure
- * @dev_name: mount device information (to create unique kproc)
- *
+ * v9fs_mux_rpc - sends 9P request and waits until a response is available.
+ *	The function can be interrupted.
+ * @m: mux data
+ * @tc: request to be sent
+ * @rc: pointer where a pointer to the response is stored
  */
+int
+v9fs_mux_rpc(struct v9fs_mux_data *m, struct v9fs_fcall *tc,
+	     struct v9fs_fcall **rc)
+{
+	int err;
+	unsigned long flags;
+	struct v9fs_req *req;
+	struct v9fs_mux_rpc r;
+
+	r.err = 0;
+	r.rcall = NULL;
+	r.m = m;
+	init_waitqueue_head(&r.wqueue);
+
+	if (rc)
+		*rc = NULL;
+
+	req = v9fs_send_request(m, tc, v9fs_mux_rpc_cb, &r);
+	if (IS_ERR(req)) {
+		err = PTR_ERR(req);
+		dprintk(DEBUG_MUX, "error %d\n", err);
+		return PTR_ERR(req);
+	}
+
+	r.req = req;
+	dprintk(DEBUG_MUX, "mux %p tc %p tag %d rpc %p req %p\n", m, tc,
+		req->tag, &r, req);
+	err = wait_event_interruptible(r.wqueue, r.rcall != NULL || r.err < 0);
+	if (r.err < 0)
+		err = r.err;
+
+	if (err == -ERESTARTSYS && m->trans->status == Connected && m->err == 0) {
+		spin_lock(&m->lock);
+		req->tcall = NULL;
+		req->err = ERREQFLUSH;
+		spin_unlock(&m->lock);
+
+		clear_thread_flag(TIF_SIGPENDING);
+		v9fs_mux_flush_request(m, req);
+		spin_lock_irqsave(&current->sighand->siglock, flags);
+		recalc_sigpending();
+		spin_unlock_irqrestore(&current->sighand->siglock, flags);
+	}
+
+	if (!err) {
+		if (r.rcall)
+			dprintk(DEBUG_MUX, "got response id %d tag %d\n",
+				r.rcall->id, r.rcall->tag);
+
+		if (rc)
+			*rc = r.rcall;
+		else
+			kfree(r.rcall);
+	} else {
+		kfree(r.rcall);
+		dprintk(DEBUG_MUX, "got error %d\n", err);
+		if (err > 0)
+			err = -EIO;
+	}
+
+	return err;
+}
 
-int v9fs_mux_init(struct v9fs_session_info *v9ses, const char *dev_name)
+/**
+ * v9fs_mux_rpcnb - sends 9P request without waiting for response.
+ * @m: mux data
+ * @tc: request to be sent
+ * @cb: callback function to be called when response arrives
+ * @cba: value to pass to the callback function
+ */
+int v9fs_mux_rpcnb(struct v9fs_mux_data *m, struct v9fs_fcall *tc,
+		   v9fs_mux_req_callback cb, void *a)
 {
-	char procname[60];
+	int err;
+	struct v9fs_req *req;
 
-	strncpy(procname, dev_name, sizeof(procname));
-	procname[sizeof(procname) - 1] = 0;
+	req = v9fs_send_request(m, tc, cb, a);
+	if (IS_ERR(req)) {
+		err = PTR_ERR(req);
+		dprintk(DEBUG_MUX, "error %d\n", err);
+		return PTR_ERR(req);
+	}
 
-	init_waitqueue_head(&v9ses->read_wait);
-	init_completion(&v9ses->fcread);
-	init_completion(&v9ses->proccmpl);
-	spin_lock_init(&v9ses->muxlock);
-	INIT_LIST_HEAD(&v9ses->mux_fcalls);
-	v9ses->recvproc = NULL;
-	v9ses->curfcall = NULL;
+	dprintk(DEBUG_MUX, "mux %p tc %p tag %d\n", m, tc, req->tag);
+	return 0;
+}
 
-	v9ses->recvproc = kthread_create(v9fs_recvproc, v9ses,
-					 "v9fs_recvproc %s", procname);
+/**
+ * v9fs_mux_cancel - cancel all pending requests with error 
+ * @m: mux data
+ * @err: error code
+ */
+void v9fs_mux_cancel(struct v9fs_mux_data *m, int err)
+{
+	struct v9fs_req *req, *rtmp;
+	LIST_HEAD(cancel_list);
 
-	if (IS_ERR(v9ses->recvproc)) {
-		eprintk(KERN_ERR, "cannot create receiving thread\n");
-		v9fs_session_close(v9ses);
-		return -ECONNABORTED;
+	dprintk(DEBUG_MUX, "mux %p err %d\n", m, err);
+	m->err = err;
+	spin_lock(&m->lock);
+	list_for_each_entry_safe(req, rtmp, &m->req_list, req_list) {
+		list_move(&req->req_list, &cancel_list);
 	}
+	spin_unlock(&m->lock);
 
-	wake_up_process(v9ses->recvproc);
-	wait_for_completion(&v9ses->proccmpl);
+	list_for_each_entry_safe(req, rtmp, &cancel_list, req_list) {
+		list_del(&req->req_list);
+		if (!req->err)
+			req->err = err;
 
-	return 0;
+		if (req->cb)
+			(*req->cb) (req->cba, req->tcall, req->rcall, req->err);
+		else
+			kfree(req->rcall);
+
+		kfree(req);
+	}
+
+	wake_up(&m->equeue);
 }
diff --git a/fs/9p/mux.h b/fs/9p/mux.h
index 4994cb1..a7a1e19 100644
--- a/fs/9p/mux.h
+++ b/fs/9p/mux.h
@@ -3,6 +3,7 @@
  *
  * Multiplexer Definitions
  *
+ *  Copyright (C) 2005 by Latchesar Ionkov <lucho@ionkov.net>
  *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -23,19 +24,34 @@
  *
  */
 
-/* structure to manage each RPC transaction */
+struct v9fs_mux_data;
 
-struct v9fs_rpcreq {
-	struct v9fs_fcall *tcall;
-	struct v9fs_fcall *rcall;
-	int err;	/* error code if response failed */
-
-	/* XXX - could we put scatter/gather buffers here? */
-
-	struct list_head next;
-};
-
-int v9fs_mux_init(struct v9fs_session_info *v9ses, const char *dev_name);
-long v9fs_mux_rpc(struct v9fs_session_info *v9ses,
-		  struct v9fs_fcall *tcall, struct v9fs_fcall **rcall);
-void v9fs_mux_cancel_requests(struct v9fs_session_info *v9ses, int err);
+/**
+ * v9fs_mux_req_callback - callback function that is called when the
+ * response of a request is received. The callback is called from
+ * a workqueue and shouldn't block.
+ *
+ * @a - the pointer that was specified when the request was send to be
+ *      passed to the callback
+ * @tc - request call
+ * @rc - response call
+ * @err - error code (non-zero if error occured)
+ */
+typedef void (*v9fs_mux_req_callback)(void *a, struct v9fs_fcall *tc, 
+	struct v9fs_fcall *rc, int err);
+
+void v9fs_mux_global_init(void);
+void v9fs_mux_global_exit(void);
+
+struct v9fs_mux_data *v9fs_mux_init(struct v9fs_transport *trans, int msize, 
+	unsigned char *extended);
+void v9fs_mux_destroy(struct v9fs_mux_data *);
+
+int v9fs_mux_send(struct v9fs_mux_data *m, struct v9fs_fcall *tc);
+struct v9fs_fcall *v9fs_mux_recv(struct v9fs_mux_data *m);
+int v9fs_mux_rpc(struct v9fs_mux_data *m, struct v9fs_fcall *tc, struct v9fs_fcall **rc);
+int v9fs_mux_rpcnb(struct v9fs_mux_data *m, struct v9fs_fcall *tc, 
+	v9fs_mux_req_callback cb, void *a);
+
+void v9fs_mux_flush(struct v9fs_mux_data *m, int sendflush);
+void v9fs_mux_cancel(struct v9fs_mux_data *m, int err);
diff --git a/fs/9p/trans_fd.c b/fs/9p/trans_fd.c
index 63b58ce..4b33f24 100644
--- a/fs/9p/trans_fd.c
+++ b/fs/9p/trans_fd.c
@@ -3,6 +3,7 @@
  *
  * File Descriptor Transport Layer
  *
+ *  Copyright (C) 2005 by Latchesar Ionkov <lucho@ionkov.net>
  *  Copyright (C) 2005 by Eric Van Hensbergen <ericvh@gmail.com>
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -106,9 +107,6 @@ v9fs_fd_init(struct v9fs_session_info *v
 		return -ENOPROTOOPT;
 	}
 
-	sema_init(&trans->writelock, 1);
-	sema_init(&trans->readlock, 1);
-
 	ts = kmalloc(sizeof(struct v9fs_trans_fd), GFP_KERNEL);
 
 	if (!ts)
@@ -163,10 +161,55 @@ static void v9fs_fd_close(struct v9fs_tr
 	kfree(ts);
 }
 
+static unsigned int 
+v9fs_fd_poll(struct v9fs_transport *trans, struct poll_table_struct *pt) 
+{
+	int ret, n;
+	struct v9fs_trans_fd *ts;
+	mm_segment_t oldfs;
+
+	if (!trans)
+		return -EIO;
+
+	ts = trans->priv;
+	if (trans->status != Connected || !ts)
+		return -EIO;
+
+	oldfs = get_fs();
+	set_fs(get_ds());
+
+	if (!ts->in_file->f_op || !ts->in_file->f_op->poll) {
+		ret = -EIO;
+		goto end;
+	}
+
+	ret = ts->in_file->f_op->poll(ts->in_file, pt);
+
+	if (ts->out_file != ts->in_file) {
+		if (!ts->out_file->f_op || !ts->out_file->f_op->poll) {
+			ret = -EIO;
+			goto end;
+		}
+
+		n = ts->out_file->f_op->poll(ts->out_file, pt);
+
+		ret &= ~POLLOUT;
+		n &= ~POLLIN;
+
+		ret |= n;
+	}
+
+end:
+	set_fs(oldfs);
+	return ret;
+}
+
+
 struct v9fs_transport v9fs_trans_fd = {
 	.init = v9fs_fd_init,
 	.write = v9fs_fd_send,
 	.read = v9fs_fd_recv,
 	.close = v9fs_fd_close,
+	.poll = v9fs_fd_poll,
 };
 
diff --git a/fs/9p/trans_sock.c b/fs/9p/trans_sock.c
index a93c2bf..24dd078 100644
--- a/fs/9p/trans_sock.c
+++ b/fs/9p/trans_sock.c
@@ -3,6 +3,7 @@
  *
  * Socket Transport Layer
  *
+ *  Copyright (C) 2004-2005 by Latchesar Ionkov <lucho@ionkov.net>
  *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
  *  Copyright (C) 1997-2002 by Ron Minnich <rminnich@sarnoff.com>
  *  Copyright (C) 1995, 1996 by Olaf Kirch <okir@monad.swb.de>
@@ -35,6 +36,7 @@
 #include <asm/uaccess.h>
 #include <linux/inet.h>
 #include <linux/idr.h>
+#include <linux/file.h>
 
 #include "debug.h"
 #include "v9fs.h"
@@ -44,6 +46,7 @@
 
 struct v9fs_trans_sock {
 	struct socket *s;
+	struct file *filp;
 };
 
 /**
@@ -56,41 +59,26 @@ struct v9fs_trans_sock {
 
 static int v9fs_sock_recv(struct v9fs_transport *trans, void *v, int len)
 {
-	struct msghdr msg;
-	struct kvec iov;
-	int result;
-	mm_segment_t oldfs;
-	struct v9fs_trans_sock *ts = trans ? trans->priv : NULL;
+	int ret;
+	struct v9fs_trans_sock *ts;
 
-	if (trans->status == Disconnected)
+	if (!trans || trans->status == Disconnected) {
+		dprintk(DEBUG_ERROR, "disconnected ...\n");
 		return -EREMOTEIO;
+	}
 
-	result = -EINVAL;
-
-	oldfs = get_fs();
-	set_fs(get_ds());
-
-	iov.iov_base = v;
-	iov.iov_len = len;
-	msg.msg_name = NULL;
-	msg.msg_namelen = 0;
-	msg.msg_iovlen = 1;
-	msg.msg_control = NULL;
-	msg.msg_controllen = 0;
-	msg.msg_namelen = 0;
-	msg.msg_flags = MSG_NOSIGNAL;
-
-	result = kernel_recvmsg(ts->s, &msg, &iov, 1, len, 0);
+	ts = trans->priv;
 
-	dprintk(DEBUG_TRANS, "socket state %d\n", ts->s->state);
-	set_fs(oldfs);
+	if (!(ts->filp->f_flags & O_NONBLOCK))
+		dprintk(DEBUG_ERROR, "blocking read ...\n");
 
-	if (result <= 0) {
-		if (result != -ERESTARTSYS)
+	ret = kernel_read(ts->filp, ts->filp->f_pos, v, len);
+	if (ret <= 0) {
+		if (ret != -ERESTARTSYS && ret != -EAGAIN)
 			trans->status = Disconnected;
 	}
 
-	return result;
+	return ret;
 }
 
 /**
@@ -103,40 +91,73 @@ static int v9fs_sock_recv(struct v9fs_tr
 
 static int v9fs_sock_send(struct v9fs_transport *trans, void *v, int len)
 {
-	struct kvec iov;
-	struct msghdr msg;
-	int result = -1;
+	int ret;
 	mm_segment_t oldfs;
-	struct v9fs_trans_sock *ts = trans ? trans->priv : NULL;
+	struct v9fs_trans_sock *ts;
 
-	dprintk(DEBUG_TRANS, "Sending packet size %d (%x)\n", len, len);
-	dump_data(v, len);
+	if (!trans || trans->status == Disconnected) {
+		dprintk(DEBUG_ERROR, "disconnected ...\n");
+		return -EREMOTEIO;
+	}
+
+	ts = trans->priv;
+	if (!ts) {
+		dprintk(DEBUG_ERROR, "no transport ...\n");
+		return -EREMOTEIO;
+	}
 
-	down(&trans->writelock);
+	if (!(ts->filp->f_flags & O_NONBLOCK))
+		dprintk(DEBUG_ERROR, "blocking write ...\n");
 
+	dump_data(v, len);
 	oldfs = get_fs();
 	set_fs(get_ds());
-	iov.iov_base = v;
-	iov.iov_len = len;
-	msg.msg_name = NULL;
-	msg.msg_namelen = 0;
-	msg.msg_iovlen = 1;
-	msg.msg_control = NULL;
-	msg.msg_controllen = 0;
-	msg.msg_namelen = 0;
-	msg.msg_flags = MSG_NOSIGNAL;
-	result = kernel_sendmsg(ts->s, &msg, &iov, 1, len);
+	ret = vfs_write(ts->filp, (void __user *)v, len, &ts->filp->f_pos);
 	set_fs(oldfs);
 
-	if (result < 0) {
-		if (result != -ERESTARTSYS)
+	if (ret < 0) {
+		if (ret != -ERESTARTSYS)
 			trans->status = Disconnected;
 	}
 
-	up(&trans->writelock);
-	return result;
+	return ret;
+}
+
+static unsigned int v9fs_sock_poll(struct v9fs_transport *trans, 
+	struct poll_table_struct *pt) {
+
+	int ret;
+	struct v9fs_trans_sock *ts;
+	mm_segment_t oldfs;
+
+	if (!trans) {
+		dprintk(DEBUG_ERROR, "no transport\n");
+		return -EIO;
+	}
+
+	ts = trans->priv;
+	if (trans->status != Connected || !ts) {
+		dprintk(DEBUG_ERROR, "transport disconnected: %d\n", trans->status);
+		return -EIO;
+	}
+
+	oldfs = get_fs();
+	set_fs(get_ds());
+
+	if (!ts->filp->f_op || !ts->filp->f_op->poll) {
+		dprintk(DEBUG_ERROR, "no poll operation\n");
+		ret = -EIO;
+		goto end;
+	}
+
+	ret = ts->filp->f_op->poll(ts->filp, pt);
+
+end:
+	set_fs(oldfs);
+	return ret;
 }
 
+
 /**
  * v9fs_tcp_init - initialize TCP socket
  * @v9ses: session information
@@ -153,9 +174,9 @@ v9fs_tcp_init(struct v9fs_session_info *
 	int rc = 0;
 	struct v9fs_trans_sock *ts = NULL;
 	struct v9fs_transport *trans = v9ses->transport;
+	int fd;
 
-	sema_init(&trans->writelock, 1);
-	sema_init(&trans->readlock, 1);
+	trans->status = Disconnected;
 
 	ts = kmalloc(sizeof(struct v9fs_trans_sock), GFP_KERNEL);
 
@@ -164,6 +185,7 @@ v9fs_tcp_init(struct v9fs_session_info *
 
 	trans->priv = ts;
 	ts->s = NULL;
+	ts->filp = NULL;
 
 	if (!addr)
 		return -EINVAL;
@@ -184,7 +206,18 @@ v9fs_tcp_init(struct v9fs_session_info *
 		return rc;
 	}
 	csocket->sk->sk_allocation = GFP_NOIO;
+
+	fd = sock_map_fd(csocket);
+	if (fd < 0) {
+		sock_release(csocket);
+		kfree(ts);
+		trans->priv = NULL;
+		return fd;
+	}
+
 	ts->s = csocket;
+	ts->filp = fget(fd);
+	ts->filp->f_flags |= O_NONBLOCK;
 	trans->status = Connected;
 
 	return 0;
@@ -202,7 +235,7 @@ static int
 v9fs_unix_init(struct v9fs_session_info *v9ses, const char *dev_name,
 	       char *data)
 {
-	int rc;
+	int rc, fd;
 	struct socket *csocket;
 	struct sockaddr_un sun_server;
 	struct v9fs_transport *trans;
@@ -212,6 +245,8 @@ v9fs_unix_init(struct v9fs_session_info 
 	csocket = NULL;
 	trans = v9ses->transport;
 
+	trans->status = Disconnected;
+
 	if (strlen(dev_name) > UNIX_PATH_MAX) {
 		eprintk(KERN_ERR, "v9fs_trans_unix: address too long: %s\n",
 			dev_name);
@@ -224,14 +259,12 @@ v9fs_unix_init(struct v9fs_session_info 
 
 	trans->priv = ts;
 	ts->s = NULL;
-
-	sema_init(&trans->writelock, 1);
-	sema_init(&trans->readlock, 1);
+	ts->filp = NULL;
 
 	sun_server.sun_family = PF_UNIX;
 	strcpy(sun_server.sun_path, dev_name);
 	sock_create_kern(PF_UNIX, SOCK_STREAM, 0, &csocket);
-	rc = csocket->ops->connect(csocket, (struct sockaddr *)&sun_server,
+	rc = csocket->ops->connect(csocket, (struct sockaddr *)&sun_server, 
 		sizeof(struct sockaddr_un) - 1, 0);	/* -1 *is* important */
 	if (rc < 0) {
 		eprintk(KERN_ERR,
@@ -240,7 +273,18 @@ v9fs_unix_init(struct v9fs_session_info 
 		return rc;
 	}
 	csocket->sk->sk_allocation = GFP_NOIO;
+
+	fd = sock_map_fd(csocket);
+	if (fd < 0) {
+		sock_release(csocket);
+		kfree(ts);
+		trans->priv = NULL;
+		return fd;
+	}
+
 	ts->s = csocket;
+	ts->filp = fget(fd);
+	ts->filp->f_flags |= O_NONBLOCK;
 	trans->status = Connected;
 
 	return 0;
@@ -261,12 +305,11 @@ static void v9fs_sock_close(struct v9fs_
 
 	ts = trans->priv;
 
-	if ((ts) && (ts->s)) {
-		dprintk(DEBUG_TRANS, "closing the socket %p\n", ts->s);
-		sock_release(ts->s);
+	if ((ts) && (ts->filp)) {
+		fput(ts->filp);
+		ts->filp = NULL;
 		ts->s = NULL;
 		trans->status = Disconnected;
-		dprintk(DEBUG_TRANS, "socket closed\n");
 	}
 
 	kfree(ts);
@@ -279,6 +322,7 @@ struct v9fs_transport v9fs_trans_tcp = {
 	.write = v9fs_sock_send,
 	.read = v9fs_sock_recv,
 	.close = v9fs_sock_close,
+	.poll = v9fs_sock_poll,
 };
 
 struct v9fs_transport v9fs_trans_unix = {
@@ -286,4 +330,5 @@ struct v9fs_transport v9fs_trans_unix = 
 	.write = v9fs_sock_send,
 	.read = v9fs_sock_recv,
 	.close = v9fs_sock_close,
+	.poll = v9fs_sock_poll,
 };
diff --git a/fs/9p/transport.h b/fs/9p/transport.h
index 9e9cd41..91fcdb9 100644
--- a/fs/9p/transport.h
+++ b/fs/9p/transport.h
@@ -3,6 +3,7 @@
  *
  * Transport Definition
  *
+ *  Copyright (C) 2005 by Latchesar Ionkov <lucho@ionkov.net>
  *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -31,14 +32,13 @@ enum v9fs_transport_status {
 
 struct v9fs_transport {
 	enum v9fs_transport_status status;
-	struct semaphore writelock;
-	struct semaphore readlock;
 	void *priv;
 
 	int (*init) (struct v9fs_session_info *, const char *, char *);
 	int (*write) (struct v9fs_transport *, void *, int);
 	int (*read) (struct v9fs_transport *, void *, int);
 	void (*close) (struct v9fs_transport *);
+	unsigned int (*poll)(struct v9fs_transport *, struct poll_table_struct *);
 };
 
 extern struct v9fs_transport v9fs_trans_tcp;
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 418c374..5e0f793 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -213,7 +213,8 @@ retry:
 		return -1;
 	}
 
-	error = idr_get_new(&p->pool, NULL, &i);
+	/* no need to store exactly p, we just need something non-null */
+	error = idr_get_new(&p->pool, p, &i);
 	up(&p->lock);
 
 	if (error == -EAGAIN)
@@ -243,6 +244,16 @@ void v9fs_put_idpool(int id, struct v9fs
 }
 
 /**
+ * v9fs_check_idpool - check if the specified id is available
+ * @id - id to check
+ * @p - pool
+ */
+int v9fs_check_idpool(int id, struct v9fs_idpool *p)
+{
+	return idr_find(&p->pool, id) != NULL;
+}
+
+/**
  * v9fs_session_init - initialize session
  * @v9ses: session information structure
  * @dev_name: device being mounted
@@ -281,9 +292,6 @@ v9fs_session_init(struct v9fs_session_in
 	/* id pools that are session-dependent: FIDs and TIDs */
 	idr_init(&v9ses->fidpool.pool);
 	init_MUTEX(&v9ses->fidpool.lock);
-	idr_init(&v9ses->tidpool.pool);
-	init_MUTEX(&v9ses->tidpool.lock);
-
 
 	switch (v9ses->proto) {
 	case PROTO_TCP:
@@ -320,7 +328,12 @@ v9fs_session_init(struct v9fs_session_in
 	v9ses->shutdown = 0;
 	v9ses->session_hung = 0;
 
-	if ((retval = v9fs_mux_init(v9ses, dev_name)) < 0) {
+	v9ses->mux = v9fs_mux_init(v9ses->transport, v9ses->maxdata + V9FS_IOHDRSZ,
+		&v9ses->extended);
+
+	if (IS_ERR(v9ses->mux)) {
+		retval = PTR_ERR(v9ses->mux);
+		v9ses->mux = NULL;
 		dprintk(DEBUG_ERROR, "problem initializing mux\n");
 		goto SessCleanUp;
 	}
@@ -381,7 +394,7 @@ v9fs_session_init(struct v9fs_session_in
 	}
 
 	if (v9ses->afid != ~0) {
-		if (v9fs_t_clunk(v9ses, v9ses->afid, NULL))
+		if (v9fs_t_clunk(v9ses, v9ses->afid))
 			dprintk(DEBUG_ERROR, "clunk failed\n");
 	}
 
@@ -403,13 +416,16 @@ v9fs_session_init(struct v9fs_session_in
 
 void v9fs_session_close(struct v9fs_session_info *v9ses)
 {
-	if (v9ses->recvproc) {
-		send_sig(SIGKILL, v9ses->recvproc, 1);
-		wait_for_completion(&v9ses->proccmpl);
+	if (v9ses->mux) {
+		v9fs_mux_destroy(v9ses->mux);
+		v9ses->mux = NULL;
 	}
 
-	if (v9ses->transport)
+	if (v9ses->transport) {
 		v9ses->transport->close(v9ses->transport);
+		kfree(v9ses->transport);
+		v9ses->transport = NULL;
+	}
 
 	__putname(v9ses->name);
 	__putname(v9ses->remotename);
@@ -420,8 +436,9 @@ void v9fs_session_close(struct v9fs_sess
  * 	and cancel all pending requests.
  */
 void v9fs_session_cancel(struct v9fs_session_info *v9ses) {
+	dprintk(DEBUG_ERROR, "cancel session %p\n", v9ses);
 	v9ses->transport->status = Disconnected;
-	v9fs_mux_cancel_requests(v9ses, -EIO);
+	v9fs_mux_cancel(v9ses->mux, -EIO);
 }
 
 extern int v9fs_error_init(void);
@@ -437,6 +454,7 @@ static int __init init_v9fs(void)
 
 	printk(KERN_INFO "Installing v9fs 9P2000 file system support\n");
 
+	v9fs_mux_global_init();
 	return register_filesystem(&v9fs_fs_type);
 }
 
@@ -447,6 +465,7 @@ static int __init init_v9fs(void)
 
 static void __exit exit_v9fs(void)
 {
+	v9fs_mux_global_exit();
 	unregister_filesystem(&v9fs_fs_type);
 }
 
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 45dcef4..f337da7 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -57,24 +57,14 @@ struct v9fs_session_info {
 
 	/* book keeping */
 	struct v9fs_idpool fidpool;	/* The FID pool for file descriptors */
-	struct v9fs_idpool tidpool;	/* The TID pool for transactions ids */
 
-	/* transport information */
 	struct v9fs_transport *transport;
+	struct v9fs_mux_data *mux;
 
 	int inprogress;		/* session in progress => true */
 	int shutdown;		/* session shutting down. no more attaches. */
 	unsigned char session_hung;
-
-	/* mux private data */
-	struct v9fs_fcall *curfcall;
-	wait_queue_head_t read_wait;
-	struct completion fcread;
-	struct completion proccmpl;
-	struct task_struct *recvproc;
-
-	spinlock_t muxlock;
-	struct list_head mux_fcalls;
+	struct dentry *debugfs_dir;
 };
 
 /* possible values of ->proto */
@@ -84,11 +74,14 @@ enum {
 	PROTO_FD,
 };
 
+extern struct dentry *v9fs_debugfs_root;
+
 int v9fs_session_init(struct v9fs_session_info *, const char *, char *);
 struct v9fs_session_info *v9fs_inode2v9ses(struct inode *);
 void v9fs_session_close(struct v9fs_session_info *v9ses);
 int v9fs_get_idpool(struct v9fs_idpool *p);
 void v9fs_put_idpool(int id, struct v9fs_idpool *p);
+int v9fs_check_idpool(int id, struct v9fs_idpool *p);
 void v9fs_session_cancel(struct v9fs_session_info *v9ses);
 
 #define V9FS_MAGIC 0x01021997
diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index a6aa947..4887df7 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -95,24 +95,21 @@ static int v9fs_dentry_validate(struct d
 
 void v9fs_dentry_release(struct dentry *dentry)
 {
+	int err;
+
 	dprintk(DEBUG_VFS, " dentry: %s (%p)\n", dentry->d_iname, dentry);
 
 	if (dentry->d_fsdata != NULL) {
 		struct list_head *fid_list = dentry->d_fsdata;
 		struct v9fs_fid *temp = NULL;
 		struct v9fs_fid *current_fid = NULL;
-		struct v9fs_fcall *fcall = NULL;
 
 		list_for_each_entry_safe(current_fid, temp, fid_list, list) {
-			if (v9fs_t_clunk
-			    (current_fid->v9ses, current_fid->fid, &fcall))
-				dprintk(DEBUG_ERROR, "clunk failed: %s\n",
-					FCALL_ERROR(fcall));
+			err = v9fs_t_clunk(current_fid->v9ses, current_fid->fid);
 
-			v9fs_put_idpool(current_fid->fid,
-					&current_fid->v9ses->fidpool);
+			if (err < 0)
+				dprintk(DEBUG_ERROR, "clunk failed: %d\n", err);
 
-			kfree(fcall);
 			v9fs_fid_destroy(current_fid);
 		}
 
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index 57a43b8..e9c05ff 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -74,7 +74,7 @@ static int v9fs_dir_readdir(struct file 
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
 	struct v9fs_fid *file = filp->private_data;
-	unsigned int i, n;
+	unsigned int i, n, s;
 	int fid = -1;
 	int ret = 0;
 	struct v9fs_stat *mi = NULL;
@@ -97,9 +97,9 @@ static int v9fs_dir_readdir(struct file 
 		n = file->rdir_fcall->params.rread.count;
 		i = file->rdir_fpos;
 		while (i < n) {
-			int s = v9fs_deserialize_stat(v9ses,
-				  file->rdir_fcall->params.rread.data + i,
-			          n - i, mi, v9ses->maxdata);
+			s = v9fs_deserialize_stat(
+				file->rdir_fcall->params.rread.data + i,
+				n - i, mi, v9ses->maxdata, v9ses->extended);
 
 			if (s == 0) {
 				dprintk(DEBUG_ERROR,
@@ -141,9 +141,8 @@ static int v9fs_dir_readdir(struct file 
 		n = ret;
 		i = 0;
 		while (i < n) {
-			int s = v9fs_deserialize_stat(v9ses,
-			          fcall->params.rread.data + i, n - i, mi,
-			          v9ses->maxdata);
+			s = v9fs_deserialize_stat(fcall->params.rread.data + i, 
+				n - i, mi, v9ses->maxdata, v9ses->extended);
 
 			if (s == 0) {
 				dprintk(DEBUG_ERROR,
@@ -200,11 +199,9 @@ int v9fs_dir_release(struct inode *inode
 		dprintk(DEBUG_VFS, "fidopen: %d v9f->fid: %d\n", fid->fidopen,
 			fid->fid);
 
-		if (v9fs_t_clunk(v9ses, fidnum, NULL))
+		if (v9fs_t_clunk(v9ses, fidnum))
 			dprintk(DEBUG_ERROR, "clunk failed\n");
 
-		v9fs_put_idpool(fid->fid, &v9ses->fidpool);
-
 		kfree(fid->rdir_fcall);
 		kfree(fid);
 
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 0ea965c..466002a 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -318,6 +318,7 @@ v9fs_create(struct inode *dir,
 	int result = 0;
 	unsigned int iounit = 0;
 	int wfidno = -1;
+	int err;
 
 	perm = unixmode2p9mode(v9ses, perm);
 
@@ -356,6 +357,7 @@ v9fs_create(struct inode *dir,
 	}
 
 	kfree(fcall);
+	fcall = NULL;
 
 	result = v9fs_t_create(v9ses, newfid, (char *)file_dentry->d_name.name,
 			       perm, open_mode, &fcall);
@@ -369,16 +371,23 @@ v9fs_create(struct inode *dir,
 	iounit = fcall->params.rcreate.iounit;
 	qid = fcall->params.rcreate.qid;
 	kfree(fcall);
+	fcall = NULL;
 
-	fid = v9fs_fid_create(file_dentry, v9ses, newfid, 1);
-	dprintk(DEBUG_VFS, "fid %p %d\n", fid, fid->fidcreate);
-	if (!fid) {
-		result = -ENOMEM;
-		goto CleanUpFid;
-	}
+	if (!(perm&V9FS_DMDIR)) {
+		fid = v9fs_fid_create(file_dentry, v9ses, newfid, 1);
+		dprintk(DEBUG_VFS, "fid %p %d\n", fid, fid->fidcreate);
+		if (!fid) {
+			result = -ENOMEM;
+			goto CleanUpFid;
+		}
 
-	fid->qid = qid;
-	fid->iounit = iounit;
+		fid->qid = qid;
+		fid->iounit = iounit;
+	} else {
+		err = v9fs_t_clunk(v9ses, newfid);
+		if (err < 0)
+			dprintk(DEBUG_ERROR, "clunk for mkdir failed: %d\n", err);
+	}
 
 	/* walk to the newly created file and put the fid in the dentry */
 	wfidno = v9fs_get_idpool(&v9ses->fidpool);
@@ -388,18 +397,19 @@ v9fs_create(struct inode *dir,
 	}
 
 	result = v9fs_t_walk(v9ses, dirfidnum, wfidno,
-		(char *) file_dentry->d_name.name, NULL);
+		(char *) file_dentry->d_name.name, &fcall);
 	if (result < 0) {
 		dprintk(DEBUG_ERROR, "clone error: %s\n", FCALL_ERROR(fcall));
 		v9fs_put_idpool(wfidno, &v9ses->fidpool);
 		wfidno = -1;
 		goto CleanUpFid;
 	}
+	kfree(fcall);
+	fcall = NULL;
 
 	if (!v9fs_fid_create(file_dentry, v9ses, wfidno, 0)) {
-		if (!v9fs_t_clunk(v9ses, newfid, &fcall)) {
-			v9fs_put_idpool(wfidno, &v9ses->fidpool);
-		}
+		v9fs_t_clunk(v9ses, newfid);
+		v9fs_put_idpool(wfidno, &v9ses->fidpool);
 
 		goto CleanUpFid;
 	}
@@ -431,40 +441,21 @@ v9fs_create(struct inode *dir,
 	file_dentry->d_op = &v9fs_dentry_operations;
 	d_instantiate(file_dentry, file_inode);
 
-	if (perm & V9FS_DMDIR) {
-		if (!v9fs_t_clunk(v9ses, newfid, &fcall))
-			v9fs_put_idpool(newfid, &v9ses->fidpool);
-		else
-			dprintk(DEBUG_ERROR, "clunk for mkdir failed: %s\n",
-				FCALL_ERROR(fcall));
-		kfree(fcall);
-		fid->fidopen = 0;
-		fid->fidcreate = 0;
-		d_drop(file_dentry);
-	}
-
 	return 0;
 
       CleanUpFid:
 	kfree(fcall);
+	fcall = NULL;
 
 	if (newfid >= 0) {
-		if (!v9fs_t_clunk(v9ses, newfid, &fcall))
-			v9fs_put_idpool(newfid, &v9ses->fidpool);
-		else
-			dprintk(DEBUG_ERROR, "clunk failed: %s\n",
-				FCALL_ERROR(fcall));
-
-		kfree(fcall);
+ 		err = v9fs_t_clunk(v9ses, newfid);
+ 		if (err < 0)
+ 			dprintk(DEBUG_ERROR, "clunk failed: %d\n", err);
 	}
 	if (wfidno >= 0) {
-		if (!v9fs_t_clunk(v9ses, wfidno, &fcall))
-			v9fs_put_idpool(wfidno, &v9ses->fidpool);
-		else
-			dprintk(DEBUG_ERROR, "clunk failed: %s\n",
-				FCALL_ERROR(fcall));
-
-		kfree(fcall);
+ 		err = v9fs_t_clunk(v9ses, wfidno);
+ 		if (err < 0)
+ 			dprintk(DEBUG_ERROR, "clunk failed: %d\n", err);
 	}
 	return result;
 }
@@ -972,6 +963,7 @@ v9fs_vfs_symlink(struct inode *dir, stru
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
 	struct v9fs_fcall *fcall = NULL;
 	struct v9fs_stat *mistat = kmalloc(v9ses->maxdata, GFP_KERNEL);
+	int err;
 
 	dprintk(DEBUG_VFS, " %lu,%s,%s\n", dir->i_ino, dentry->d_name.name,
 		symname);
@@ -1004,9 +996,9 @@ v9fs_vfs_symlink(struct inode *dir, stru
 
 	kfree(fcall);
 
-	if (v9fs_t_clunk(v9ses, newfid->fid, &fcall)) {
-		dprintk(DEBUG_ERROR, "clunk for symlink failed: %s\n",
-			FCALL_ERROR(fcall));
+	err = v9fs_t_clunk(v9ses, newfid->fid);
+	if (err < 0) {
+		dprintk(DEBUG_ERROR, "clunk for symlink failed: %d\n", err);
 		goto FreeFcall;
 	}
 
@@ -1180,6 +1172,7 @@ v9fs_vfs_link(struct dentry *old_dentry,
 	struct v9fs_fid *oldfid = v9fs_fid_lookup(old_dentry);
 	struct v9fs_fid *newfid = NULL;
 	char *symname = __getname();
+	int err;
 
 	dprintk(DEBUG_VFS, " %lu,%s,%s\n", dir->i_ino, dentry->d_name.name,
 		old_dentry->d_name.name);
@@ -1216,9 +1209,10 @@ v9fs_vfs_link(struct dentry *old_dentry,
 
 	kfree(fcall);
 
-	if (v9fs_t_clunk(v9ses, newfid->fid, &fcall)) {
-		dprintk(DEBUG_ERROR, "clunk for symlink failed: %s\n",
-			FCALL_ERROR(fcall));
+	err = v9fs_t_clunk(v9ses, newfid->fid);
+
+	if (err < 0) {
+		dprintk(DEBUG_ERROR, "clunk for symlink failed: %d\n", err);
 		goto FreeMem;
 	}
 
@@ -1252,6 +1246,7 @@ v9fs_vfs_mknod(struct inode *dir, struct
 	struct v9fs_fcall *fcall = NULL;
 	struct v9fs_stat *mistat = kmalloc(v9ses->maxdata, GFP_KERNEL);
 	char *symname = __getname();
+	int err;
 
 	dprintk(DEBUG_VFS, " %lu,%s mode: %x MAJOR: %u MINOR: %u\n", dir->i_ino,
 		dentry->d_name.name, mode, MAJOR(rdev), MINOR(rdev));
@@ -1310,9 +1305,9 @@ v9fs_vfs_mknod(struct inode *dir, struct
 	/* need to update dcache so we show up */
 	kfree(fcall);
 
-	if (v9fs_t_clunk(v9ses, newfid->fid, &fcall)) {
-		dprintk(DEBUG_ERROR, "clunk for symlink failed: %s\n",
-			FCALL_ERROR(fcall));
+	err = v9fs_t_clunk(v9ses, newfid->fid);
+	if (err < 0) {
+		dprintk(DEBUG_ERROR, "clunk for symlink failed: %d\n", err);
 		goto FreeMem;
 	}
 
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 82c5b00..83b6edd 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -129,6 +129,7 @@ static struct super_block *v9fs_get_sb(s
 
 	if ((newfid = v9fs_session_init(v9ses, dev_name, data)) < 0) {
 		dprintk(DEBUG_ERROR, "problem initiating session\n");
+		kfree(v9ses);
 		return ERR_PTR(newfid);
 	}
 
@@ -157,7 +158,7 @@ static struct super_block *v9fs_get_sb(s
 	stat_result = v9fs_t_stat(v9ses, newfid, &fcall);
 	if (stat_result < 0) {
 		dprintk(DEBUG_ERROR, "stat error\n");
-		v9fs_t_clunk(v9ses, newfid, NULL);
+		v9fs_t_clunk(v9ses, newfid);
 		v9fs_put_idpool(newfid, &v9ses->fidpool);
 	} else {
 		/* Setup the Root Inode */
-- 
1.0.6
