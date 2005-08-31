Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbVHaX6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbVHaX6i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 19:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVHaX6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 19:58:38 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:2961 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S932145AbVHaX6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 19:58:37 -0400
Subject: [PATCH] v9fs: Support to force umount
From: Eric Van Hensbergen <ericvh@gmail.com>
To: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
       V9FS Developers <v9fs-developer@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 31 Aug 2005 18:58:18 -0500
Message-Id: <1125532698.3789.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] v9fs: Support to force umount

Support for force umount

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>
Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---
commit 3f92b2539fe581ee9011d687fbd43cebb641465e
tree cd34696129c3b636b85578f659f260100196dee1
parent 83f1fe3d2adc3746d719e430d0a794de1f151c40
author Eric Van Hensbergen <ericvh@gmail.com> Wed, 31 Aug 2005 15:53:14
-0500
committer Eric Van Hensbergen <ericvh@gmail.com> Wed, 31 Aug 2005
15:53:14 -0500

 fs/9p/mux.c       |   20 ++++++++++++++++++++
 fs/9p/mux.h       |    1 +
 fs/9p/v9fs.c      |    9 +++++++++
 fs/9p/v9fs.h      |    4 +---
 fs/9p/vfs_super.c |    9 +++++++++
 5 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/fs/9p/mux.c b/fs/9p/mux.c
--- a/fs/9p/mux.c
+++ b/fs/9p/mux.c
@@ -331,6 +331,26 @@ v9fs_mux_rpc(struct v9fs_session_info *v
 }
 
 /**
+ * v9fs_mux_cancel_requests - cancels all pending requests
+ *
+ * @v9ses: session info structure
+ * @err: error code to return to the requests
+ */
+void v9fs_mux_cancel_requests(struct v9fs_session_info *v9ses, int err)
+{
+	struct v9fs_rpcreq *rptr;
+	struct v9fs_rpcreq *rreq;
+
+	dprintk(DEBUG_MUX, " %d\n", err);
+	spin_lock(&v9ses->muxlock);
+	list_for_each_entry_safe(rreq, rptr, &v9ses->mux_fcalls, next) {
+		rreq->err = err;
+	}
+	spin_unlock(&v9ses->muxlock);
+	wake_up_all(&v9ses->read_wait);
+}
+
+/**
  * v9fs_recvproc - kproc to handle demultiplexing responses
  * @data: session info structure
  *
diff --git a/fs/9p/mux.h b/fs/9p/mux.h
--- a/fs/9p/mux.h
+++ b/fs/9p/mux.h
@@ -38,3 +38,4 @@ struct v9fs_rpcreq {
 int v9fs_mux_init(struct v9fs_session_info *v9ses, const char
*dev_name);
 long v9fs_mux_rpc(struct v9fs_session_info *v9ses,
 		  struct v9fs_fcall *tcall, struct v9fs_fcall **rcall);
+void v9fs_mux_cancel_requests(struct v9fs_session_info *v9ses, int
err);
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -414,6 +414,15 @@ void v9fs_session_close(struct v9fs_sess
 	putname(v9ses->remotename);
 }
 
+/**
+ * v9fs_session_cancel - mark transport as disconnected 
+ * 	and cancel all pending requests.
+ */
+void v9fs_session_cancel(struct v9fs_session_info *v9ses) {
+	v9ses->transport->status = Disconnected;
+	v9fs_mux_cancel_requests(v9ses, -EIO);
+}
+
 extern int v9fs_error_init(void);
 
 /**
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -89,9 +89,7 @@ struct v9fs_session_info *v9fs_inode2v9s
 void v9fs_session_close(struct v9fs_session_info *v9ses);
 int v9fs_get_idpool(struct v9fs_idpool *p);
 void v9fs_put_idpool(int id, struct v9fs_idpool *p);
-int v9fs_get_option(char *opts, char *name, char *buf, int buflen);
-long long v9fs_get_int_option(char *opts, char *name, long long dflt);
-int v9fs_parse_tcp_devname(const char *devname, char **addr, char
**remotename);
+void v9fs_session_cancel(struct v9fs_session_info *v9ses);
 
 #define V9FS_MAGIC 0x01021997
 
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -257,10 +257,19 @@ static int v9fs_show_options(struct seq_
 	return 0;
 }
 
+static void
+v9fs_umount_begin(struct super_block *sb)
+{
+	struct v9fs_session_info *v9ses = sb->s_fs_info;
+
+	v9fs_session_cancel(v9ses);
+}
+
 static struct super_operations v9fs_super_ops = {
 	.statfs = simple_statfs,
 	.clear_inode = v9fs_clear_inode,
 	.show_options = v9fs_show_options,
+	.umount_begin = v9fs_umount_begin,
 };
 
 struct file_system_type v9fs_fs_type = {


