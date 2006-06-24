Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932742AbWFXAga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932742AbWFXAga (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 20:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbWFXAga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 20:36:30 -0400
Received: from gw.goop.org ([64.81.55.164]:59371 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932634AbWFXAg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 20:36:29 -0400
Message-ID: <449C891E.6010405@goop.org>
Date: Fri, 23 Jun 2006 17:36:46 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: airlied@linux.ie
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Hourihane <alanh@fairlite.demon.co.uk>,
       dri-devel@lists.sourceforge.net
Subject: i915 vsync interrupt fix
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need this patch from Alan Hourihane 
<mailto:alanh@fairlite.demon.co.uk> to make direct rendering work 
properly on my 945GM-based laptop. It comes from 
https://bugs.freedesktop.org/show_bug.cgi?id=7233.  This change is 
immediately useful to me now, but I don't know if the development DRM is 
going to be merged with the kernel any time soon (I notice CVS has a 
variant of this patch).

    J
/

/

From: Alan Hourihane <alanh@fairlite.demon.co.uk>

Look at vsync interrupts from pipe B as well as A.
https://bugs.freedesktop.org/show_bug.cgi?id=7233


diff -r 91a715ea44db drivers/char/drm/i915_irq.c
--- a/drivers/char/drm/i915_irq.c	Thu Jun 22 19:09:11 2006 -0700
+++ b/drivers/char/drm/i915_irq.c	Fri Jun 23 14:08:08 2006 -0700
@@ -44,7 +44,7 @@ irqreturn_t i915_driver_irq_handler(DRM_
 	u16 temp;
 
 	temp = I915_READ16(I915REG_INT_IDENTITY_R);
-	temp &= (USER_INT_FLAG | VSYNC_PIPEA_FLAG);
+	temp &= (USER_INT_FLAG | VSYNC_PIPEA_FLAG | VSYNC_PIPEB_FLAG);
 
 	DRM_DEBUG("%s flag=%08x\n", __FUNCTION__, temp);
 
@@ -58,7 +58,7 @@ irqreturn_t i915_driver_irq_handler(DRM_
 	if (temp & USER_INT_FLAG)
 		DRM_WAKEUP(&dev_priv->irq_queue);
 
-	if (temp & VSYNC_PIPEA_FLAG) {
+	if (temp & (VSYNC_PIPEA_FLAG | VSYNC_PIPEB_FLAG)) {
 		atomic_inc(&dev->vbl_received);
 		DRM_WAKEUP(&dev->vbl_queue);
 		drm_vbl_send_signals(dev);
@@ -197,7 +197,7 @@ void i915_driver_irq_postinstall(drm_dev
 {
 	drm_i915_private_t *dev_priv = (drm_i915_private_t *) dev->dev_private;
 
-	I915_WRITE16(I915REG_INT_ENABLE_R, USER_INT_FLAG | VSYNC_PIPEA_FLAG);
+	I915_WRITE16(I915REG_INT_ENABLE_R, USER_INT_FLAG | VSYNC_PIPEA_FLAG | VSYNC_PIPEB_FLAG);
 	DRM_INIT_WAITQUEUE(&dev_priv->irq_queue);
 }
 


