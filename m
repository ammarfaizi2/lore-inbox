Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262898AbVCXSLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbVCXSLr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 13:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbVCXSLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 13:11:47 -0500
Received: from rev.193.226.232.24.euroweb.hu ([193.226.232.24]:61849 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262898AbVCXSLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 13:11:33 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: trivial cleanups
Message-Id: <E1DEWnd-0007JC-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 24 Mar 2005 19:11:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes check for non-null inode before calling iput(), and uses
iov_length() to calculate number of bytes in iovec.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

 dev.c |   30 +++++++++---------------------
 1 files changed, 9 insertions(+), 21 deletions(-)

diff -ru linux-2.6.12-rc1-mm2/fs/fuse/dev.c linux-fuse/fs/fuse/dev.c
--- linux-2.6.12-rc1-mm2/fs/fuse/dev.c	2005-03-24 18:46:37.000000000 +0100
+++ linux-fuse/fs/fuse/dev.c	2005-03-24 18:49:04.000000000 +0100
@@ -142,10 +142,8 @@
 
 void fuse_release_background(struct fuse_req *req)
 {
-	if (req->inode)
-		iput(req->inode);
-	if (req->inode2)
-		iput(req->inode2);
+	iput(req->inode);
+	iput(req->inode2);
 	if (req->file)
 		fput(req->file);
 	spin_lock(&fuse_lock);
@@ -397,24 +395,15 @@
 	unsigned len;
 };
 
-static unsigned fuse_copy_init(struct fuse_copy_state *cs, int write,
-			       struct fuse_req *req, const struct iovec *iov,
-			       unsigned long nr_segs)
+static void fuse_copy_init(struct fuse_copy_state *cs, int write,
+			   struct fuse_req *req, const struct iovec *iov,
+			   unsigned long nr_segs)
 {
-	unsigned i;
-	unsigned nbytes;
-
 	memset(cs, 0, sizeof(*cs));
 	cs->write = write;
 	cs->req = req;
 	cs->iov = iov;
 	cs->nr_segs = nr_segs;
-
-	nbytes = 0;
-	for (i = 0; i < nr_segs; i++)
-		nbytes += iov[i].iov_len;
-
-	return nbytes;
 }
 
 static inline void fuse_copy_finish(struct fuse_copy_state *cs)
@@ -578,7 +567,6 @@
 	struct fuse_req *req;
 	struct fuse_in *in;
 	struct fuse_copy_state cs;
-	unsigned nbytes;
 	unsigned reqsize;
 
 	spin_lock(&fuse_lock);
@@ -600,9 +588,9 @@
 
 	in = &req->in;
 	reqsize = req->in.h.len;
-	nbytes = fuse_copy_init(&cs, 1, req, iov, nr_segs);
+	fuse_copy_init(&cs, 1, req, iov, nr_segs);
 	err = -EINVAL;
-	if (nbytes >= reqsize) {
+	if (iov_length(iov, nr_segs) >= reqsize) {
 		err = fuse_copy_one(&cs, &in->h, sizeof(in->h));
 		if (!err)
 			err = fuse_copy_args(&cs, in->numargs, in->argpages,
@@ -683,7 +671,7 @@
 			       unsigned long nr_segs, loff_t *off)
 {
 	int err;
-	unsigned nbytes;
+	unsigned nbytes = iov_length(iov, nr_segs);
 	struct fuse_req *req;
 	struct fuse_out_header oh;
 	struct fuse_copy_state cs;
@@ -691,7 +679,7 @@
 	if (!fc)
 		return -ENODEV;
 
-	nbytes = fuse_copy_init(&cs, 0, NULL, iov, nr_segs);
+	fuse_copy_init(&cs, 0, NULL, iov, nr_segs);
 	if (nbytes < sizeof(struct fuse_out_header))
 		return -EINVAL;
 
