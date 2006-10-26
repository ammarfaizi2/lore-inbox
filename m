Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423478AbWJZNCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423478AbWJZNCZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 09:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423479AbWJZNCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 09:02:25 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:25194 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1423478AbWJZNCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 09:02:23 -0400
Date: Thu, 26 Oct 2006 15:02:17 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch 2/5] compat: fix uaccess handling
Message-ID: <20061026130217.GC7127@osiris.boeblingen.de.ibm.com>
References: <20061026130010.GA7127@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026130010.GA7127@osiris.boeblingen.de.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 fs/compat.c       |   35 +++++++++++++++++++----------------
 fs/compat_ioctl.c |   33 ++++++++++++++++++++-------------
 2 files changed, 39 insertions(+), 29 deletions(-)

Index: linux-2.6/fs/compat.c
===================================================================
--- linux-2.6.orig/fs/compat.c	2006-10-26 14:40:56.000000000 +0200
+++ linux-2.6/fs/compat.c	2006-10-26 14:42:09.000000000 +0200
@@ -1142,7 +1142,9 @@
 	lastdirent = buf.previous;
 	if (lastdirent) {
 		typeof(lastdirent->d_off) d_off = file->f_pos;
-		__put_user_unaligned(d_off, &lastdirent->d_off);
+		error = -EFAULT;
+		if (__put_user_unaligned(d_off, &lastdirent->d_off))
+			goto out_putf;
 		error = count - buf.count;
 	}
 
@@ -1609,14 +1611,14 @@
 		nr &= ~1UL;
 		while (nr) {
 			unsigned long h, l;
-			__get_user(l, ufdset);
-			__get_user(h, ufdset+1);
+			if (__get_user(l, ufdset) || __get_user(h, ufdset+1))
+				return -EFAULT;
 			ufdset += 2;
 			*fdset++ = h << 32 | l;
 			nr -= 2;
 		}
-		if (odd)
-			__get_user(*fdset, ufdset);
+		if (odd && __get_user(*fdset, ufdset))
+			return -EFAULT;
 	} else {
 		/* Tricky, must clear full unsigned long in the
 		 * kernel fdset at the end, this makes sure that
@@ -1628,14 +1630,14 @@
 }
 
 static
-void compat_set_fd_set(unsigned long nr, compat_ulong_t __user *ufdset,
-			unsigned long *fdset)
+int compat_set_fd_set(unsigned long nr, compat_ulong_t __user *ufdset,
+		      unsigned long *fdset)
 {
 	unsigned long odd;
 	nr = ROUND_UP(nr, __COMPAT_NFDBITS);
 
 	if (!ufdset)
-		return;
+		return 0;
 
 	odd = nr & 1UL;
 	nr &= ~1UL;
@@ -1643,13 +1645,14 @@
 		unsigned long h, l;
 		l = *fdset++;
 		h = l >> 32;
-		__put_user(l, ufdset);
-		__put_user(h, ufdset+1);
+		if (__put_user(l, ufdset) || __put_user(h, ufdset+1))
+			return -EFAULT;
 		ufdset += 2;
 		nr -= 2;
 	}
-	if (odd)
-		__put_user(*fdset, ufdset);
+	if (odd && __put_user(*fdset, ufdset))
+		return -EFAULT;
+	return 0;
 }
 
 
@@ -1724,10 +1727,10 @@
 		ret = 0;
 	}
 
-	compat_set_fd_set(n, inp, fds.res_in);
-	compat_set_fd_set(n, outp, fds.res_out);
-	compat_set_fd_set(n, exp, fds.res_ex);
-
+	if (compat_set_fd_set(n, inp, fds.res_in) ||
+	    compat_set_fd_set(n, outp, fds.res_out) ||
+	    compat_set_fd_set(n, exp, fds.res_ex))
+		ret = -EFAULT;
 out:
 	kfree(bits);
 out_nofds:
Index: linux-2.6/fs/compat_ioctl.c
===================================================================
--- linux-2.6.orig/fs/compat_ioctl.c	2006-10-26 14:40:56.000000000 +0200
+++ linux-2.6/fs/compat_ioctl.c	2006-10-26 14:42:09.000000000 +0200
@@ -211,8 +211,10 @@
 	up_native =
 		compat_alloc_user_space(sizeof(struct video_still_picture));
 
-	put_user(compat_ptr(fp), &up_native->iFrame);
-	put_user(size, &up_native->size);
+	err =  put_user(compat_ptr(fp), &up_native->iFrame);
+	err |= put_user(size, &up_native->size);
+	if (err)
+		return -EFAULT;
 
 	err = sys_ioctl(fd, cmd, (unsigned long) up_native);
 
@@ -236,8 +238,10 @@
 	err |= get_user(length, &up->length);
 
 	up_native = compat_alloc_user_space(sizeof(struct video_spu_palette));
-	put_user(compat_ptr(palp), &up_native->palette);
-	put_user(length, &up_native->length);
+	err  = put_user(compat_ptr(palp), &up_native->palette);
+	err |= put_user(length, &up_native->length);
+	if (err)
+		return -EFAULT;
 
 	err = sys_ioctl(fd, cmd, (unsigned long) up_native);
 
@@ -2043,16 +2047,19 @@
         struct serial_struct ss;
         mm_segment_t oldseg = get_fs();
         __u32 udata;
+	unsigned int base;
 
         if (cmd == TIOCSSERIAL) {
                 if (!access_ok(VERIFY_READ, ss32, sizeof(SS32)))
                         return -EFAULT;
                 if (__copy_from_user(&ss, ss32, offsetof(SS32, iomem_base)))
 			return -EFAULT;
-                __get_user(udata, &ss32->iomem_base);
+                if (__get_user(udata, &ss32->iomem_base))
+			return -EFAULT;
                 ss.iomem_base = compat_ptr(udata);
-                __get_user(ss.iomem_reg_shift, &ss32->iomem_reg_shift);
-                __get_user(ss.port_high, &ss32->port_high);
+                if (__get_user(ss.iomem_reg_shift, &ss32->iomem_reg_shift) ||
+		    __get_user(ss.port_high, &ss32->port_high))
+			return -EFAULT;
                 ss.iomap_base = 0UL;
         }
         set_fs(KERNEL_DS);
@@ -2063,12 +2070,12 @@
                         return -EFAULT;
                 if (__copy_to_user(ss32,&ss,offsetof(SS32,iomem_base)))
 			return -EFAULT;
-                __put_user((unsigned long)ss.iomem_base  >> 32 ?
-                            0xffffffff : (unsigned)(unsigned long)ss.iomem_base,
-                            &ss32->iomem_base);
-                __put_user(ss.iomem_reg_shift, &ss32->iomem_reg_shift);
-                __put_user(ss.port_high, &ss32->port_high);
-
+		base = (unsigned long)ss.iomem_base  >> 32 ?
+			0xffffffff : (unsigned)(unsigned long)ss.iomem_base;
+		if (__put_user(base, &ss32->iomem_base) ||
+		    __put_user(ss.iomem_reg_shift, &ss32->iomem_reg_shift) ||
+		    __put_user(ss.port_high, &ss32->port_high))
+			return -EFAULT;
         }
         return err;
 }
