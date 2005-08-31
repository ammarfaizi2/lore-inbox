Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbVHaX7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbVHaX7k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 19:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVHaX7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 19:59:40 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:29130 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S932145AbVHaX7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 19:59:39 -0400
Subject: [-mm PATCH] v9fs: cleanup fd transport
From: Eric Van Hensbergen <ericvh@gmail.com>
To: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
       V9FS Developers <v9fs-developer@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 31 Aug 2005 18:59:24 -0500
Message-Id: <1125532764.3789.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] v9fs: cleanup fd transport

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>
Signed-off-by: Eric Van Hensbegren <ericvh@gmail.com>

---
commit a1949213f1723a7b8bba8edfa118985460d31604
tree 40224cafbfb68543c60a8e0f04ae669cba2cedf7
parent 3f92b2539fe581ee9011d687fbd43cebb641465e
author Eric Van Hensbergen <ericvh@gmail.com> Wed, 31 Aug 2005 16:02:42
-0500
committer Eric Van Hensbergen <ericvh@gmail.com> Wed, 31 Aug 2005
16:02:42 -0500

 fs/9p/trans_fd.c |   42 +++++++++++++++++++++++++++++++++++++++---
 fs/9p/v9fs.c     |    5 -----
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/fs/9p/trans_fd.c b/fs/9p/trans_fd.c
--- a/fs/9p/trans_fd.c
+++ b/fs/9p/trans_fd.c
@@ -56,6 +56,9 @@ static int v9fs_fd_recv(struct v9fs_tran
 {
 	struct v9fs_trans_fd *ts = trans ? trans->priv : NULL;
 
+	if (!trans || trans->status != Connected || !ts)
+		return -EIO;
+
 	return kernel_read(ts->in_file, ts->in_file->f_pos, v, len);
 }
 
@@ -73,6 +76,9 @@ static int v9fs_fd_send(struct v9fs_tran
 	mm_segment_t oldfs = get_fs();
 	int ret = 0;
 
+	if (!trans || trans->status != Connected || !ts)
+		return -EIO;
+
 	set_fs(get_ds());
 	/* The cast to a user pointer is valid due to the set_fs() */
 	ret = vfs_write(ts->out_file, (void __user *)v, len,
&ts->out_file->f_pos);
@@ -95,6 +101,11 @@ v9fs_fd_init(struct v9fs_session_info *v
 	struct v9fs_trans_fd *ts = NULL;
 	struct v9fs_transport *trans = v9ses->transport;
 
+	if((v9ses->wfdno == ~0) || (v9ses->rfdno == ~0)) {
+		printk(KERN_ERR "v9fs: Insufficient options for proto=fd\n");
+		return -ENOPROTOOPT;
+	}
+
 	sema_init(&trans->writelock, 1);
 	sema_init(&trans->readlock, 1);
 
@@ -103,11 +114,21 @@ v9fs_fd_init(struct v9fs_session_info *v
 	if (!ts)
 		return -ENOMEM;
 
-	trans->priv = ts;
-
 	ts->in_file = fget( v9ses->rfdno );
 	ts->out_file = fget( v9ses->wfdno );
 
+	if (!ts->in_file || !ts->out_file) {
+		if (ts->in_file)
+			fput(ts->in_file);
+
+		if (ts->out_file)
+			fput(ts->out_file);
+
+		kfree(ts);
+		return -EIO;
+	}
+
+	trans->priv = ts;
 	trans->status = Connected;
 
 	return 0;
@@ -122,7 +143,22 @@ v9fs_fd_init(struct v9fs_session_info *v
 
 static void v9fs_fd_close(struct v9fs_transport *trans)
 {
-	struct v9fs_trans_fd *ts = trans ? trans->priv : NULL;
+	struct v9fs_trans_fd *ts;
+
+	if (!trans) 
+		return;
+
+	trans->status = Disconnected;
+	ts = trans->priv;
+
+	if (!ts)
+		return;
+
+	if (ts->in_file)
+		fput(ts->in_file);
+
+	if (ts->out_file)
+		fput(ts->out_file);
 
 	kfree(ts);
 }
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -296,11 +296,6 @@ v9fs_session_init(struct v9fs_session_in
 	case PROTO_FD:
 		trans_proto = &v9fs_trans_fd;
 		*v9ses->remotename = 0;
-		if((v9ses->wfdno == ~0) || (v9ses->rfdno == ~0)) {
-			printk(KERN_ERR "v9fs: Insufficient options for proto=fd\n");
-			retval = -ENOPROTOOPT;
-			goto SessCleanUp;
-		}
 		break;
 	default:
 		printk(KERN_ERR "v9fs: Bad mount protocol %d\n", v9ses->proto);


