Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbTEFUIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 16:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbTEFUIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 16:08:53 -0400
Received: from ns.suse.de ([213.95.15.193]:34311 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261438AbTEFUIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 16:08:41 -0400
Subject: Re: ioctl cleanups: move SG_IO translation where it belongs
From: Andi Kleen <ak@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030506200311.GA5520@elf.ucw.cz>
References: <20030506200311.GA5520@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 06 May 2003 22:21:11 +0200
Message-Id: <1052252472.23104.11.camel@averell>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-06 at 22:03, Pavel Machek wrote:
> Hi!
> 
> This enables sharing of 200 lines of SG_IO support by all 64-bit
> architectures. If it looks okay, more such patches will follow.


I currently have some patches for this function pending. When an
unchanged data buffer is passed it is ok to just verify_area it, no need
to kmalloc and copy. This simplifies this handler vastly.

Here is the part from the 2.4 patch; haven't tried it with 2.5 yet,
but should apply there too.

Also adds some boundary checking.

-Andi

Index: linux-work/arch/x86_64/ia32/ia32_ioctl.c
===================================================================
RCS file: /home/cvs/Repository/linux/arch/x86_64/ia32/ia32_ioctl.c,v
retrieving revision 1.31
diff -u -u -r1.31 ia32_ioctl.c
--- linux-work/arch/x86_64/ia32/ia32_ioctl.c	2003/03/21 07:50:07	1.31
+++ linux-work/arch/x86_64/ia32/ia32_ioctl.c	2003/04/26 16:38:39
@@ -1373,12 +1381,16 @@
 	u32 iov_len;
 } sg_iovec32_t;
 
+#define EMU_SG_MAX 128
+
 static int alloc_sg_iovec(sg_io_hdr_t *sgp, u32 uptr32)
 {
 	sg_iovec32_t *uiov = (sg_iovec32_t *) A(uptr32);
 	sg_iovec_t *kiov;
 	int i;
 
+	if (sgp->iovec_count > EMU_SG_MAX)
+		return -EINVAL;
 	sgp->dxferp = kmalloc(sgp->iovec_count *
 			      sizeof(sg_iovec_t), GFP_KERNEL);
 	if (!sgp->dxferp)
@@ -1391,40 +1403,10 @@
 		u32 iov_base32;
 		if (__get_user(iov_base32, &uiov->iov_base) ||
 		    __get_user(kiov->iov_len, &uiov->iov_len))
-			return -EFAULT;
-
-		kiov->iov_base = kmalloc(kiov->iov_len, GFP_KERNEL);
-		if (!kiov->iov_base)
-			return -ENOMEM;
-		if (copy_from_user(kiov->iov_base,
-				   (void *) A(iov_base32),
-				   kiov->iov_len))
-			return -EFAULT;
-
-		uiov++;
-		kiov++;
-	}
-
-	return 0;
-}
-
-static int copy_back_sg_iovec(sg_io_hdr_t *sgp, u32 uptr32)
-{
-	sg_iovec32_t *uiov = (sg_iovec32_t *) A(uptr32);
-	sg_iovec_t *kiov = (sg_iovec_t *) sgp->dxferp;
-	int i;
-
-	for (i = 0; i < sgp->iovec_count; i++) {
-		u32 iov_base32;
-
-		if (__get_user(iov_base32, &uiov->iov_base))
 			return -EFAULT;
-
-		if (copy_to_user((void *) A(iov_base32),
-				 kiov->iov_base,
-				 kiov->iov_len))
+		if (verify_area(VERIFY_WRITE, (void *)A(iov_base32), kiov->iov_len))
 			return -EFAULT;
-
+		kiov->iov_base = (void *)A(iov_base32);
 		uiov++;
 		kiov++;
 	}
@@ -1434,16 +1416,6 @@
 
 static void free_sg_iovec(sg_io_hdr_t *sgp)
 {
-	sg_iovec_t *kiov = (sg_iovec_t *) sgp->dxferp;
-	int i;
-
-	for (i = 0; i < sgp->iovec_count; i++) {
-		if (kiov->iov_base) {
-			kfree(kiov->iov_base);
-			kiov->iov_base = NULL;
-		}
-		kiov++;
-	}
 	kfree(sgp->dxferp);
 	sgp->dxferp = NULL;
 }
@@ -1506,6 +1483,11 @@
 			goto out;
 		}
 	} else {
+		if (sg_io64.dxfer_len > 4*PAGE_SIZE) { 
+			err = -EINVAL;
+			goto out;
+		}
+
 		sg_io64.dxferp = kmalloc(sg_io64.dxfer_len, GFP_KERNEL);
 		if (!sg_io64.dxferp) {
 			err = -ENOMEM;
@@ -1546,7 +1528,7 @@
 	err |= copy_to_user((void *)A(sbp32), sg_io64.sbp, sg_io64.mx_sb_len);
 	if (sg_io64.dxferp) {
 		if (sg_io64.iovec_count)
-			err |= copy_back_sg_iovec(&sg_io64, dxferp32);
+			;
 		else
 			err |= copy_to_user((void *)A(dxferp32),
 					    sg_io64.dxferp,









