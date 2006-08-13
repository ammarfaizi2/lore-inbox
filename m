Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWHMMan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWHMMan (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 08:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWHMMan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 08:30:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:59985 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751158AbWHMMal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 08:30:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:message-id;
        b=Zu0lenlwg3rkbHLiAUfSFbaEI4LN374492bMtXPAkliKC6Q+gH/Y8xEOja+Gf6ISFpFGw3qDxSCfbDFtPkmC7iehgeK12SJT2ynQIGI18u15YQGzVcHZCeO+l5Q1/8lWA+adMpW2Li7KMgwlI6GDRNXbdjpYA15oM1+Xqowwqfs=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Rik Faith <faith@valinux.com>, Jeff Hartmann <jhartmann@valinux.com>,
       Keith Whitwell <keith@tungstengraphics.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] i810_dma.c: fix pointer arithmetic for 64-bit target
Date: Sun, 13 Aug 2006 14:30:32 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_otx3Emkmn81bGyz"
Message-Id: <200608131430.32877.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_otx3Emkmn81bGyz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

CC [M]  drivers/char/drm/i810_dma.o
drivers/char/drm/i810_dma.c: In function 'i810_map_buffer':
drivers/char/drm/i810_dma.c:147: warning: cast from pointer to integer of different size
drivers/char/drm/i810_dma.c: In function 'i810_dma_dispatch_vertex':
drivers/char/drm/i810_dma.c:811: warning: cast from pointer to integer of different size
drivers/char/drm/i810_dma.c:811: warning: cast to pointer from integer of different size
drivers/char/drm/i810_dma.c: In function 'i810_dma_dispatch_mc':
drivers/char/drm/i810_dma.c:1169: warning: cast from pointer to integer of different size
drivers/char/drm/i810_dma.c:1169: warning: cast to pointer from integer of different size

First warning result from open-coded PTR_ERR,
the rest is caused by code like this:

*(u32 *) ((u32) buf_priv->kernel_virtual + used)

Patch fixes this. Please apply.
--
vda

--Boundary-00=_otx3Emkmn81bGyz
Content-Type: text/x-diff;
  charset="us-ascii";
  name="i810_dma.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="i810_dma.c.diff"

CC [M]  drivers/char/drm/i810_dma.o
drivers/char/drm/i810_dma.c: In function 'i810_map_buffer':
drivers/char/drm/i810_dma.c:147: warning: cast from pointer to integer of different size
drivers/char/drm/i810_dma.c: In function 'i810_dma_dispatch_vertex':
drivers/char/drm/i810_dma.c:811: warning: cast from pointer to integer of different size
drivers/char/drm/i810_dma.c:811: warning: cast to pointer from integer of different size
drivers/char/drm/i810_dma.c: In function 'i810_dma_dispatch_mc':
drivers/char/drm/i810_dma.c:1169: warning: cast from pointer to integer of different size
drivers/char/drm/i810_dma.c:1169: warning: cast to pointer from integer of different size

--- linux-2.6.17.8.src/drivers/char/drm/i810_dma.c.org	2006-08-07 06:18:54.000000000 +0200
+++ linux-2.6.17.8.src/drivers/char/drm/i810_dma.c	2006-08-12 20:56:10.000000000 +0200
@@ -141,10 +141,10 @@ static int i810_map_buffer(drm_buf_t * b
 					    MAP_SHARED, buf->bus_address);
 	dev_priv->mmap_buffer = NULL;
 	filp->f_op = old_fops;
-	if ((unsigned long)buf_priv->virtual > -1024UL) {
+	if (IS_ERR(buf_priv->virtual)) {
 		/* Real error */
 		DRM_ERROR("mmap error\n");
-		retcode = (signed int)buf_priv->virtual;
+		retcode = PTR_ERR(buf_priv->virtual);
 		buf_priv->virtual = NULL;
 	}
 	up_write(&current->mm->mmap_sem);
@@ -808,7 +808,7 @@ static void i810_dma_dispatch_vertex(drm
 		    ((GFX_OP_PRIMITIVE | prim | ((used / 4) - 2)));
 
 		if (used & 4) {
-			*(u32 *) ((u32) buf_priv->kernel_virtual + used) = 0;
+			*(u32 *) ((char *) buf_priv->kernel_virtual + used) = 0;
 			used += 4;
 		}
 
@@ -1166,7 +1166,7 @@ static void i810_dma_dispatch_mc(drm_dev
 
 	if (buf_priv->currently_mapped == I810_BUF_MAPPED) {
 		if (used & 4) {
-			*(u32 *) ((u32) buf_priv->virtual + used) = 0;
+			*(u32 *) ((char *) buf_priv->virtual + used) = 0;
 			used += 4;
 		}
 

--Boundary-00=_otx3Emkmn81bGyz--
