Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbVJTWtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVJTWtM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 18:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbVJTWtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 18:49:11 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:44696 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932204AbVJTWtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 18:49:10 -0400
Date: Thu, 20 Oct 2005 23:49:00 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] before 2.6.14: another mga bug
Message-ID: <Pine.LNX.4.58.0510202346120.17964@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay the test cycles on this bug were slightly longer than usual, and none
of the DRI people have a G550 handy, so code inspection turned up two more
major issues and one not so bad... I'd really appreciate these getting in
before the final 2.6.14...

The wrong state emission routines were being called for G550, and
consistent maps weren't correctly mmaped...

Signed-off-by: Dave Airlie <airlied@linux.ie>

diff --git a/drivers/char/drm/drm_vm.c b/drivers/char/drm/drm_vm.c
--- a/drivers/char/drm/drm_vm.c
+++ b/drivers/char/drm/drm_vm.c
@@ -148,7 +148,8 @@ static __inline__ struct page *drm_do_vm

 	offset	 = address - vma->vm_start;
 	i = (unsigned long)map->handle + offset;
-	page = vmalloc_to_page((void *)i);
+	page = (map->type == _DRM_CONSISTENT) ?
+		virt_to_page((void *)i) : vmalloc_to_page((void *)i);
 	if (!page)
 		return NOPAGE_OOM;
 	get_page(page);
diff --git a/drivers/char/drm/mga_drv.h b/drivers/char/drm/mga_drv.h
--- a/drivers/char/drm/mga_drv.h
+++ b/drivers/char/drm/mga_drv.h
@@ -227,7 +227,7 @@ static inline u32 _MGA_READ(u32 *addr)
 #define MGA_EMIT_STATE( dev_priv, dirty )				\
 do {									\
 	if ( (dirty) & ~MGA_UPLOAD_CLIPRECTS ) {			\
-		if ( dev_priv->chipset == MGA_CARD_TYPE_G400 ) {	\
+		if ( dev_priv->chipset >= MGA_CARD_TYPE_G400 ) {	\
 			mga_g400_emit_state( dev_priv );		\
 		} else {						\
 			mga_g200_emit_state( dev_priv );		\
diff --git a/drivers/char/drm/mga_state.c b/drivers/char/drm/mga_state.c
--- a/drivers/char/drm/mga_state.c
+++ b/drivers/char/drm/mga_state.c
@@ -53,7 +53,7 @@ static void mga_emit_clip_rect( drm_mga_

 	/* Force reset of DWGCTL on G400 (eliminates clip disable bit).
 	 */
-	if (dev_priv->chipset == MGA_CARD_TYPE_G400) {
+	if (dev_priv->chipset >= MGA_CARD_TYPE_G400) {
 		DMA_BLOCK(MGA_DWGCTL, ctx->dwgctl,
 			  MGA_LEN + MGA_EXEC, 0x80000000,
 			  MGA_DWGCTL, ctx->dwgctl,

