Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUHTB60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUHTB60 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 21:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbUHTB60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 21:58:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18834 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262605AbUHTB6U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 21:58:20 -0400
Date: Thu, 19 Aug 2004 21:56:54 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: remove dentry_open::file_ra_init_state() duplicated memset was Re: kernbench on 512p
Message-ID: <20040820005654.GC6374@logos.cnet>
References: <200408191216.33667.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408191216.33667.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 12:16:33PM -0400, Jesse Barnes wrote:

> Here's the kernel profile.  It would be nice if the patch to show which lock 
> is contended got included.  I think it was discussed awhile back, but I don't 
> have one against the newly merged profiling code.
> 
> [root@ascender root]# readprofile -m System.map | sort -nr | head -30
> 208218076 total                                     30.1677
> 90036167 ia64_pal_call_static                     468938.3698
> 88140492 default_idle                             229532.5312
> 10312592 ia64_save_scratch_fpregs                 161134.2500
> 10306777 ia64_load_scratch_fpregs                 161043.3906
> 8723555 ia64_spinlock_contention                 90870.3646
> 121385 rcu_check_quiescent_state                316.1068
>  40464 file_move                                180.6429
>  32374 file_kill                                144.5268
>  25316 atomic_dec_and_lock                       98.8906
>  24814 clear_page                               155.0875
>  17709 file_ra_state_init                       110.6813

This is pretty high. Andi says its probably not due to this function 
itself, but for some other reason, like cache trashing caused, accidentally, 
by it.

But anyway, investigation of file_ra_state_init() shows that its called 
from dentry_open()... it does a memset(ra, 0, sizeof(*ra)), which is not needed, 
because get_empty_filp() already memset's the whole "struct file" to 0.

So this patch creates a __file_ra_state_init() function, which initializes
the file_ra_state fields, without the memset. 

file_ra_state_init() does the memset + its __ counterpart. 

Pretty straightforward and simple.

Against 2.6.8.1-mm2, Andrew, please apply.

Jesse, if you could give it a shot and rerun the profile.

diff -Nur --exclude='*.orig' linux-2.6.8.orig/fs/open.c linux-2.6.8/fs/open.c
--- linux-2.6.8.orig/fs/open.c	2004-08-14 02:36:13.000000000 -0300
+++ linux-2.6.8/fs/open.c	2004-08-19 22:38:48.000000000 -0300
@@ -803,7 +803,7 @@
 	}
 	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 
-	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
+	__file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
 
 	/* NB: we're sure to have correct a_ops only after f_op->open */
 	if (f->f_flags & O_DIRECT) {
diff -Nur --exclude='*.orig' linux-2.6.8.orig/include/linux/fs.h linux-2.6.8/include/linux/fs.h
--- linux-2.6.8.orig/include/linux/fs.h	2004-08-19 22:35:49.000000000 -0300
+++ linux-2.6.8/include/linux/fs.h	2004-08-19 22:39:55.000000000 -0300
@@ -1520,7 +1520,10 @@
 				    struct file_ra_state *, struct file *,
 				    loff_t *, read_descriptor_t *, read_actor_t);
 extern void
+__file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping);
+extern void
 file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping);
+
 extern ssize_t generic_file_direct_IO(int rw, struct kiocb *iocb,
 	const struct iovec *iov, loff_t offset, unsigned long nr_segs);
 extern ssize_t generic_file_readv(struct file *filp, const struct iovec *iov, 
diff -Nur --exclude='*.orig' linux-2.6.8.orig/mm/readahead.c linux-2.6.8/mm/readahead.c
--- linux-2.6.8.orig/mm/readahead.c	2004-08-19 22:35:50.000000000 -0300
+++ linux-2.6.8/mm/readahead.c	2004-08-19 22:37:49.000000000 -0300
@@ -30,13 +30,22 @@
 /*
  * Initialise a struct file's readahead state
  */
+
 void
-file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
+__file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
 {
-	memset(ra, 0, sizeof(*ra));
 	ra->ra_pages = mapping->backing_dev_info->ra_pages;
 	ra->average = ra->ra_pages / 2;
 }
+
+void
+file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
+{
+	memset(ra, 0, sizeof(*ra));
+	__file_ra_state_init(ra, mapping);
+}
+
+EXPORT_SYMBOL(__file_ra_state_init);
 EXPORT_SYMBOL(file_ra_state_init);
 
 /*




