Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266005AbUGEKom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266005AbUGEKom (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 06:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266010AbUGEKom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 06:44:42 -0400
Received: from [213.146.154.40] ([213.146.154.40]:40410 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266005AbUGEKoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 06:44:09 -0400
Date: Mon, 5 Jul 2004 11:44:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, neilb@cse.unsw.edu.au,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm6
Message-ID: <20040705104405.GA15293@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, neilb@cse.unsw.edu.au,
	linux-kernel@vger.kernel.org
References: <20040705023120.34f7772b.akpm@osdl.org> <20040705101804.GA14866@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040705101804.GA14866@infradead.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2004 at 11:18:04AM +0100, Christoph Hellwig wrote:
> > +use-llseek-instead-of-f_pos=-for-directory-seeking.patch
> > 
> >  Fix an nfsd problem when the client sends an insane directory offset.
> 
> Please either use llseek() directly or renamed the thing to vfs_llseek()
> everywhere.  Two names for exactly the same thing are a bad idea.
> 
> (The latter sounds like the better idea to me)

Updated patch implementing my suggestion below:


--- 1.84/fs/nfsd/vfs.c	2004-06-01 11:27:57 +02:00
+++ edited/fs/nfsd/vfs.c	2004-07-05 14:37:24 +02:00
@@ -1477,10 +1477,12 @@
 	err = nfsd_open(rqstp, fhp, S_IFDIR, MAY_READ, &file);
 	if (err)
 		goto out;
-	if (offset > ~(u32) 0)
-		goto out_close;
 
-	file.f_pos = offset;
+	offset = vfs_llseek(&file, offset, 0);
+	if (offset < 0) {
+		err = nfserrno((int)offset);
+		goto out_close;
+	}
 
 	/*
 	 * Read the directory entries. This silly loop is necessary because
@@ -1496,7 +1498,7 @@
 		err = nfserrno(err);
 	else
 		err = cdp->err;
-	*offsetp = file.f_pos;
+	*offsetp = vfs_llseek(&file, 0LL, 1);
 
 	if (err == nfserr_eof || err == nfserr_toosmall)
 		err = nfs_ok; /* can still be found in ->err */
--- 1.39/fs/read_write.c	2004-05-22 10:23:18 +02:00
+++ edited/fs/read_write.c	2004-07-05 14:38:14 +02:00
@@ -112,7 +112,7 @@
 
 EXPORT_SYMBOL(default_llseek);
 
-static inline loff_t llseek(struct file *file, loff_t offset, int origin)
+inline loff_t vfs_llseek(struct file *file, loff_t offset, int origin)
 {
 	loff_t (*fn)(struct file *, loff_t, int);
 
@@ -122,6 +122,8 @@
 	return fn(file, offset, origin);
 }
 
+EXPORT_SYMBOL(vfs_llseek);
+
 asmlinkage off_t sys_lseek(unsigned int fd, off_t offset, unsigned int origin)
 {
 	off_t retval;
@@ -135,7 +137,7 @@
 
 	retval = -EINVAL;
 	if (origin <= 2) {
-		loff_t res = llseek(file, offset, origin);
+		loff_t res = vfs_llseek(file, offset, origin);
 		retval = res;
 		if (res != (loff_t)retval)
 			retval = -EOVERFLOW;	/* LFS: should only happen on 32 bit platforms */
@@ -165,7 +167,7 @@
 	if (origin > 2)
 		goto out_putf;
 
-	offset = llseek(file, ((loff_t) offset_high << 32) | offset_low,
+	offset = vfs_llseek(file, ((loff_t) offset_high << 32) | offset_low,
 			origin);
 
 	retval = (int)offset;
--- 1.332/include/linux/fs.h	2004-07-02 07:23:47 +02:00
+++ edited/include/linux/fs.h	2004-07-05 14:41:03 +02:00
@@ -923,6 +923,7 @@
 		unsigned long, loff_t *);
 extern ssize_t vfs_writev(struct file *, const struct iovec __user *,
 		unsigned long, loff_t *);
+extern loff_t vfs_llseek(struct file *file, loff_t offset, int origin);
 
 /*
  * NOTE: write_inode, delete_inode, clear_inode, put_inode can be called
