Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752332AbWKCIsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbWKCIsn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 03:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752331AbWKCIsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 03:48:43 -0500
Received: from brick.kernel.dk ([62.242.22.158]:45602 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1752362AbWKCIsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 03:48:42 -0500
Date: Fri, 3 Nov 2006 09:50:36 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>, tytso@mit.edu
Subject: Re: [PATCH] splice : Must fully check for fifos
Message-ID: <20061103085035.GY13555@kernel.dk>
References: <1162199005.24143.169.camel@taijtu> <200610311151.33104.dada1@cosmosbay.com> <200611021802.28519.dada1@cosmosbay.com> <200611021805.07962.dada1@cosmosbay.com> <20061102190700.GQ13555@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061102190700.GQ13555@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02 2006, Jens Axboe wrote:
> On Thu, Nov 02 2006, Eric Dumazet wrote:
> > With the patch this time :( Sorry guys
> > 
> > Hi Andrew
> > 
> > I think this patch is necessary. It's quite easy to crash a 2.6.19-rc4 box :(
> > 
> > AFAIK the problem come from inode-diet (by Theodore Ts'o, (2006/Sep/27))
> > 
> > Thank you
> > 
> > [PATCH] splice : Must fully check for FIFO
> > 
> > It appears that i_pipe, i_cdev and i_bdev share the same memory location 
> > (anonymous union in struct inode) since commits 
> > 577c4eb09d1034d0739e3135fd2cff50588024be
> > eaf796e7ef6014f208c409b2b14fddcfaafe7e3a
> > 
> > Because of that, testing i_pipe being NULL is not anymore sufficient
> > to tell if an inode is a FIFO or not.
> > 
> > Therefore, we must use the S_ISFIFO(inode->i_mode) test before
> > assuming i_pipe pointer is pointing to a struct pipe_inode_info.
> 
> Indeed, the inode slimming introduced this bug. I'll queue up a test run
> of things and send it upstream, thanks for catching this.

This is the version I tested and merged.

diff --git a/fs/splice.c b/fs/splice.c
index 8d70595..87694de 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1109,6 +1109,19 @@ out_release:
 EXPORT_SYMBOL(do_splice_direct);
 
 /*
+ * After the inode slimming patch, i_pipe/i_bdev/i_cdev share the same
+ * location, so checking ->i_pipe is not enough to verify that this is a
+ * pipe.
+ */
+static inline int is_pipe(struct inode *inode)
+{
+	if (inode->i_pipe && S_ISFIFO(inode->i_mode))
+		return 1;
+
+	return 0;
+}
+
+/*
  * Determine where to splice to/from.
  */
 static long do_splice(struct file *in, loff_t __user *off_in,
@@ -1119,8 +1132,8 @@ static long do_splice(struct file *in, l
 	loff_t offset, *off;
 	long ret;
 
-	pipe = in->f_dentry->d_inode->i_pipe;
-	if (pipe) {
+	if (is_pipe(in->f_dentry->d_inode)) {
+		pipe = in->f_dentry->d_inode->i_pipe;
 		if (off_in)
 			return -ESPIPE;
 		if (off_out) {
@@ -1140,8 +1153,8 @@ static long do_splice(struct file *in, l
 		return ret;
 	}
 
-	pipe = out->f_dentry->d_inode->i_pipe;
-	if (pipe) {
+	if (is_pipe(out->f_dentry->d_inode)) {
+		pipe = out->f_dentry->d_inode->i_pipe;
 		if (off_out)
 			return -ESPIPE;
 		if (off_in) {
@@ -1298,7 +1311,7 @@ static int get_iovec_page_array(const st
 static long do_vmsplice(struct file *file, const struct iovec __user *iov,
 			unsigned long nr_segs, unsigned int flags)
 {
-	struct pipe_inode_info *pipe = file->f_dentry->d_inode->i_pipe;
+	struct pipe_inode_info *pipe;
 	struct page *pages[PIPE_BUFFERS];
 	struct partial_page partial[PIPE_BUFFERS];
 	struct splice_pipe_desc spd = {
@@ -1308,7 +1321,7 @@ static long do_vmsplice(struct file *fil
 		.ops = &user_page_pipe_buf_ops,
 	};
 
-	if (unlikely(!pipe))
+	if (!is_pipe(file->f_dentry->d_inode))
 		return -EBADF;
 	if (unlikely(nr_segs > UIO_MAXIOV))
 		return -EINVAL;
@@ -1320,6 +1333,7 @@ static long do_vmsplice(struct file *fil
 	if (spd.nr_pages <= 0)
 		return spd.nr_pages;
 
+	pipe = file->f_dentry->d_inode->i_pipe;
 	return splice_to_pipe(pipe, &spd);
 }
 
@@ -1535,15 +1549,20 @@ static int link_pipe(struct pipe_inode_i
 static long do_tee(struct file *in, struct file *out, size_t len,
 		   unsigned int flags)
 {
-	struct pipe_inode_info *ipipe = in->f_dentry->d_inode->i_pipe;
-	struct pipe_inode_info *opipe = out->f_dentry->d_inode->i_pipe;
+	struct pipe_inode_info *ipipe;
+	struct pipe_inode_info *opipe;
 	int ret = -EINVAL;
 
+	if (!is_pipe(in->f_dentry->d_inode) || !is_pipe(out->f_dentry->d_inode))
+		return ret;
+
 	/*
 	 * Duplicate the contents of ipipe to opipe without actually
 	 * copying the data.
 	 */
-	if (ipipe && opipe && ipipe != opipe) {
+	ipipe = in->f_dentry->d_inode->i_pipe;
+	opipe = out->f_dentry->d_inode->i_pipe;
+	if (ipipe != opipe) {
 		/*
 		 * Keep going, unless we encounter an error. The ipipe/opipe
 		 * ordering doesn't really matter.

-- 
Jens Axboe

