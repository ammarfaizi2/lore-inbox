Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWKBRFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWKBRFJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 12:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWKBRFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 12:05:08 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:7386 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1750855AbWKBRFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 12:05:06 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] splice : Must fully check for fifos
Date: Thu, 2 Nov 2006 18:05:07 +0100
User-Agent: KMail/1.9.5
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jens Axboe <jens.axboe@oracle.com>, tytso@mit.edu
References: <1162199005.24143.169.camel@taijtu> <200610311151.33104.dada1@cosmosbay.com> <200611021802.28519.dada1@cosmosbay.com>
In-Reply-To: <200611021802.28519.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DViSFtTtzh+Nv4S"
Message-Id: <200611021805.07962.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_DViSFtTtzh+Nv4S
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

With the patch this time :( Sorry guys

Hi Andrew

I think this patch is necessary. It's quite easy to crash a 2.6.19-rc4 box :(

AFAIK the problem come from inode-diet (by Theodore Ts'o, (2006/Sep/27))

Thank you

[PATCH] splice : Must fully check for FIFO

It appears that i_pipe, i_cdev and i_bdev share the same memory location 
(anonymous union in struct inode) since commits 
577c4eb09d1034d0739e3135fd2cff50588024be
eaf796e7ef6014f208c409b2b14fddcfaafe7e3a

Because of that, testing i_pipe being NULL is not anymore sufficient to tell 
if an inode is a FIFO or not.

Therefore, we must use the S_ISFIFO(inode->i_mode) test before assuming i_pipe 
pointer is pointing to a struct pipe_inode_info.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary-00=_DViSFtTtzh+Nv4S
Content-Type: text/plain;
  charset="iso-8859-1";
  name="splice_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="splice_fix.patch"

--- linux-2.6.19-rc4/fs/splice.c	2006-11-02 17:14:55.000000000 +0100
+++ linux-2.6.19-rc4-ed/fs/splice.c	2006-11-02 17:38:29.000000000 +0100
@@ -1115,12 +1115,14 @@
 		      struct file *out, loff_t __user *off_out,
 		      size_t len, unsigned int flags)
 {
+	struct inode *inode;
 	struct pipe_inode_info *pipe;
 	loff_t offset, *off;
 	long ret;
 
-	pipe = in->f_dentry->d_inode->i_pipe;
-	if (pipe) {
+	inode = in->f_dentry->d_inode;
+	pipe = inode->i_pipe;
+	if (pipe && S_ISFIFO(inode->i_mode)) {
 		if (off_in)
 			return -ESPIPE;
 		if (off_out) {
@@ -1140,8 +1142,9 @@
 		return ret;
 	}
 
-	pipe = out->f_dentry->d_inode->i_pipe;
-	if (pipe) {
+	inode = out->f_dentry->d_inode;
+	pipe = inode->i_pipe;
+	if (pipe && S_ISFIFO(inode->i_mode)) {
 		if (off_out)
 			return -ESPIPE;
 		if (off_in) {
@@ -1298,7 +1301,8 @@
 static long do_vmsplice(struct file *file, const struct iovec __user *iov,
 			unsigned long nr_segs, unsigned int flags)
 {
-	struct pipe_inode_info *pipe = file->f_dentry->d_inode->i_pipe;
+	struct inode *inode = file->f_dentry->d_inode;
+	struct pipe_inode_info *pipe = inode->i_pipe;
 	struct page *pages[PIPE_BUFFERS];
 	struct partial_page partial[PIPE_BUFFERS];
 	struct splice_pipe_desc spd = {
@@ -1308,7 +1312,7 @@
 		.ops = &user_page_pipe_buf_ops,
 	};
 
-	if (unlikely(!pipe))
+	if (unlikely(!pipe || !S_ISFIFO(inode->i_mode)))
 		return -EBADF;
 	if (unlikely(nr_segs > UIO_MAXIOV))
 		return -EINVAL;
@@ -1535,11 +1539,21 @@
 static long do_tee(struct file *in, struct file *out, size_t len,
 		   unsigned int flags)
 {
-	struct pipe_inode_info *ipipe = in->f_dentry->d_inode->i_pipe;
-	struct pipe_inode_info *opipe = out->f_dentry->d_inode->i_pipe;
+	struct inode *in_inode = in->f_dentry->d_inode;
+	struct inode *out_inode = out->f_dentry->d_inode;
+	struct pipe_inode_info *ipipe;
+	struct pipe_inode_info *opipe;
 	int ret = -EINVAL;
 
 	/*
+	 * CAUTION : As i_pipe/i_bdev/i_cdev share the same location,
+	 * we must check we deal with fifos/pipes, not cdev or bdev.
+	 */
+	if (!S_ISFIFO(in_inode->i_mode) || !S_ISFIFO(out_inode->i_mode))
+		return ret;
+	ipipe = in_inode->i_pipe;
+	opipe = out_inode->i_pipe;
+	/*
 	 * Duplicate the contents of ipipe to opipe without actually
 	 * copying the data.
 	 */

--Boundary-00=_DViSFtTtzh+Nv4S--
