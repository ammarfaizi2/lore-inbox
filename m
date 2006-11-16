Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162237AbWKPCw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162237AbWKPCw5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162240AbWKPCoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:44:00 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:12943 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162237AbWKPCnl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:43:41 -0500
Message-Id: <20061116024450.158521000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:37 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Jens Axboe <jens.axboe@oracle.com>
Subject: [patch 05/30] splice: fix problem introduced with inode diet
Content-Disposition: inline; filename=splice-fix-problem-introduced-with-inode-diet.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Jens Axboe <jens.axboe@oracle.com>

After the inode slimming patch that unionised i_pipe/i_bdev/i_cdev, it's
no longer enough to check for existance of ->i_pipe to verify that this
is a pipe.

Original patch from Eric Dumazet <dada1@cosmosbay.com>
Final solution suggested by Linus.

Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 fs/splice.c |   26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

--- linux-2.6.18.2.orig/fs/splice.c
+++ linux-2.6.18.2/fs/splice.c
@@ -1042,6 +1042,19 @@ out_release:
 EXPORT_SYMBOL(do_splice_direct);
 
 /*
+ * After the inode slimming patch, i_pipe/i_bdev/i_cdev share the same
+ * location, so checking ->i_pipe is not enough to verify that this is a
+ * pipe.
+ */
+static inline struct pipe_inode_info *pipe_info(struct inode *inode)
+{
+	if (S_ISFIFO(inode->i_mode))
+		return inode->i_pipe;
+
+	return NULL;
+}
+
+/*
  * Determine where to splice to/from.
  */
 static long do_splice(struct file *in, loff_t __user *off_in,
@@ -1052,7 +1065,7 @@ static long do_splice(struct file *in, l
 	loff_t offset, *off;
 	long ret;
 
-	pipe = in->f_dentry->d_inode->i_pipe;
+	pipe = pipe_info(in->f_dentry->d_inode);
 	if (pipe) {
 		if (off_in)
 			return -ESPIPE;
@@ -1073,7 +1086,7 @@ static long do_splice(struct file *in, l
 		return ret;
 	}
 
-	pipe = out->f_dentry->d_inode->i_pipe;
+	pipe = pipe_info(out->f_dentry->d_inode);
 	if (pipe) {
 		if (off_out)
 			return -ESPIPE;
@@ -1231,7 +1244,7 @@ static int get_iovec_page_array(const st
 static long do_vmsplice(struct file *file, const struct iovec __user *iov,
 			unsigned long nr_segs, unsigned int flags)
 {
-	struct pipe_inode_info *pipe = file->f_dentry->d_inode->i_pipe;
+	struct pipe_inode_info *pipe;
 	struct page *pages[PIPE_BUFFERS];
 	struct partial_page partial[PIPE_BUFFERS];
 	struct splice_pipe_desc spd = {
@@ -1241,7 +1254,8 @@ static long do_vmsplice(struct file *fil
 		.ops = &user_page_pipe_buf_ops,
 	};
 
-	if (unlikely(!pipe))
+	pipe = pipe_info(file->f_dentry->d_inode);
+	if (!pipe)
 		return -EBADF;
 	if (unlikely(nr_segs > UIO_MAXIOV))
 		return -EINVAL;
@@ -1475,8 +1489,8 @@ static int link_pipe(struct pipe_inode_i
 static long do_tee(struct file *in, struct file *out, size_t len,
 		   unsigned int flags)
 {
-	struct pipe_inode_info *ipipe = in->f_dentry->d_inode->i_pipe;
-	struct pipe_inode_info *opipe = out->f_dentry->d_inode->i_pipe;
+	struct pipe_inode_info *ipipe = pipe_info(in->f_dentry->d_inode);
+	struct pipe_inode_info *opipe = pipe_info(out->f_dentry->d_inode);
 	int ret = -EINVAL;
 
 	/*

--
