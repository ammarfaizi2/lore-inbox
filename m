Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUH0OOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUH0OOV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 10:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUH0OOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 10:14:21 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:9909 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S265144AbUH0ON5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 10:13:57 -0400
Date: Fri, 27 Aug 2004 15:13:54 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: drm fixup 2/2 - optimise i8x0 accesses..
Message-ID: <Pine.LNX.4.58.0408271512330.32411@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   the patch below optimises the drm code to not do put_user() on memory the
   kernel allocated and then mmap-installed to userspace, but instead makes it
   use the kernel virtual address directly instead.

   From: Arjan van de Ven <arjanv@redhat.com>
   Signed-off-by: Dave Airlie <airlied@linux.ie>


diff -Nru a/drivers/char/drm/i810_dma.c b/drivers/char/drm/i810_dma.c
--- a/drivers/char/drm/i810_dma.c	Sat Aug 28 00:01:57 2004
+++ b/drivers/char/drm/i810_dma.c	Sat Aug 28 00:01:57 2004
@@ -844,13 +844,10 @@
 	if (buf_priv->currently_mapped == I810_BUF_MAPPED) {
 		unsigned int prim = (sarea_priv->vertex_prim & PR_MASK);

-		put_user((GFX_OP_PRIMITIVE | prim |
-					     ((used/4)-2)),
-		(u32 __user *)buf_priv->virtual);
+		*(u32 *)buf_priv->kernel_virtual = ((GFX_OP_PRIMITIVE | prim | ((used/4)-2)));

 		if (used & 4) {
-			put_user(0,
-			(u32 __user *)((u32)buf_priv->virtual + used));
+			*(u32 *)((u32)buf_priv->kernel_virtual + used) = 0;
 			used += 4;
 		}

diff -Nru a/drivers/char/drm/i830_dma.c b/drivers/char/drm/i830_dma.c
--- a/drivers/char/drm/i830_dma.c	Sat Aug 28 00:01:57 2004
+++ b/drivers/char/drm/i830_dma.c	Sat Aug 28 00:01:57 2004
@@ -1166,19 +1166,19 @@
    	DRM_DEBUG(  "start + used - 4 : %ld\n", start + used - 4);

 	if (buf_priv->currently_mapped == I830_BUF_MAPPED) {
-		u32  __user *vp = buf_priv->virtual;
+		u32 *vp = buf_priv->kernel_virtual;

-		put_user( (GFX_OP_PRIMITIVE |
-			 sarea_priv->vertex_prim |
-			  ((used/4)-2)), &vp[0]);
+		vp[0] = (GFX_OP_PRIMITIVE |
+			sarea_priv->vertex_prim |
+			((used/4)-2));

 		if (dev_priv->use_mi_batchbuffer_start) {
-			put_user(MI_BATCH_BUFFER_END, &vp[used/4]);
+			vp[used/4] = MI_BATCH_BUFFER_END;
 			used += 4;
 		}

 		if (used & 4) {
-			put_user(0, &vp[used/4]);
+			vp[used/4] = 0;
 			used += 4;
 		}

