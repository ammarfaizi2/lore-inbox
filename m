Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422783AbWHSVQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422783AbWHSVQi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 17:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422784AbWHSVQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 17:16:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:23858 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422783AbWHSVQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 17:16:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=OtbcHhLc/AA2di0Ljd+ceH0roeAx40fWyZOG8flQQZMpxhUAcYbcsq+5q9uv7fZZzvWd5LEJ2iuMEZxWEqe3AOvMvN+RjkkhhRxV4ctatpc9hIJVRpCwL3HLfT5g8k1ErZSpwoTT6JDZUC80/Fi2W/Ip48fa5gXVyfjoDoF3BMQ=
Date: Sat, 19 Aug 2006 23:16:21 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, airlied@linux.ie
Subject: [mm patch] drm, minor fixes
Message-ID: <20060819231621.GF720@slug>
References: <20060813012454.f1d52189.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
> 
Hi Andrew,

The following patch adds minor fixes to the drm code:
- fix return values that are wrong (return E* instead of return -E*)
- replaces an argument to a sizeof in drm_setversion to match the actual
variable name
- handle drm_set_busid() return value in drm_setversion

Regards,
Frederik

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>
diff --git a/drivers/char/drm/i915_dma.c b/drivers/char/drm/i915_dma.c
index d932f80..f9615b5 100644
--- a/drivers/char/drm/i915_dma.c
+++ b/drivers/char/drm/i915_dma.c
@@ -391,7 +391,7 @@ static int i915_emit_box(drm_device_t * 
 	RING_LOCALS;
 
 	if (DRM_COPY_FROM_USER_UNCHECKED(&box, &boxes[i], sizeof(box))) {
-		return EFAULT;
+		return DRM_ERR(EFAULT);
 	}
 
 	if (box.y2 <= box.y1 || box.x2 <= box.x1 || box.y2 <= 0 || box.x2 <= 0) {
diff --git a/drivers/char/drm/drm_ioctl.c b/drivers/char/drm/drm_ioctl.c
index e158998..a93832f 100644
--- a/drivers/char/drm/drm_ioctl.c
+++ b/drivers/char/drm/drm_ioctl.c
@@ -141,12 +141,12 @@ static int drm_set_busid(drm_device_t * 
 	int len;
 
 	if (dev->unique != NULL)
-		return EBUSY;
+		return -EBUSY;
 
 	dev->unique_len = 40;
 	dev->unique = drm_alloc(dev->unique_len + 1, DRM_MEM_DRIVER);
 	if (dev->unique == NULL)
-		return ENOMEM;
+		return -ENOMEM;
 
 	len = snprintf(dev->unique, dev->unique_len, "pci:%04x:%02x:%02x.%d",
 		       drm_get_pci_domain(dev), dev->pdev->bus->number,
@@ -160,7 +160,7 @@ static int drm_set_busid(drm_device_t * 
 	    drm_alloc(strlen(dev->driver->pci_driver.name) + dev->unique_len +
 		      2, DRM_MEM_DRIVER);
 	if (dev->devname == NULL)
-		return ENOMEM;
+		return -ENOMEM;
 
 	sprintf(dev->devname, "%s@%s", dev->driver->pci_driver.name,
 		dev->unique);
@@ -342,20 +342,22 @@ int drm_setversion(DRM_IOCTL_ARGS)
 	retv.drm_dd_major = dev->driver->major;
 	retv.drm_dd_minor = dev->driver->minor;
 
-	if (copy_to_user(argp, &retv, sizeof(sv)))
+	if (copy_to_user(argp, &retv, sizeof(retv)))
 		return -EFAULT;
 
 	if (sv.drm_di_major != -1) {
 		if (sv.drm_di_major != DRM_IF_MAJOR ||
 		    sv.drm_di_minor < 0 || sv.drm_di_minor > DRM_IF_MINOR)
-			return EINVAL;
+			return -EINVAL;
 		if_version = DRM_IF_VERSION(sv.drm_di_major, sv.drm_di_minor);
 		dev->if_version = max(if_version, dev->if_version);
 		if (sv.drm_di_minor >= 1) {
 			/*
 			 * Version 1.1 includes tying of DRM to specific device
 			 */
-			drm_set_busid(dev);
+			int ret = drm_set_busid(dev);
+			if (ret)
+				return ret;
 		}
 	}
 
@@ -363,7 +365,7 @@ int drm_setversion(DRM_IOCTL_ARGS)
 		if (sv.drm_dd_major != dev->driver->major ||
 		    sv.drm_dd_minor < 0
 		    || sv.drm_dd_minor > dev->driver->minor)
-			return EINVAL;
+			return -EINVAL;
 
 		if (dev->driver->set_version)
 			dev->driver->set_version(dev, &sv);
