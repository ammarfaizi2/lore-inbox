Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWFFLKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWFFLKw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 07:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWFFLKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 07:10:52 -0400
Received: from wx-out-0102.google.com ([66.249.82.198]:53140 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751227AbWFFLKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 07:10:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=Sob7s1HG1DGUMEmwJQIWhnPgCEO65dgavZk+JX7yvWnyoRzbaEFQeB49EfboNP8iOQREOr4DvPfro/onIUD0+xTIY8dMpf4uF1DSrVP8M1kEdgHY97BL4E4lYhIJKltd+cwkenG4+tEdGltZNF9IF8TCKhNSuOO8TlywjkpiXpY=
Message-ID: <44856238.6030100@gmail.com>
Date: Tue, 06 Jun 2006 19:08:40 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] Detaching fbcon: Remove calls to pci_disable_device()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Detaching fbcon allows individual drivers to be unloaded. However several
drivers call pci_disable_device() upon exit. This function will disable the
BAR's which will kill VGA text mode and/or affect X/DRM.

To prevent this, remove calls to pci_disable_device() from several drivers.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/aty/radeon_base.c  |    2 --
 drivers/video/cirrusfb.c         |    2 --
 drivers/video/geode/gx1fb_core.c |    3 ---
 drivers/video/geode/gxfb_core.c  |    3 ---
 drivers/video/i810/i810_main.c   |    3 ---
 drivers/video/nvidia/nvidia.c    |    7 ++-----
 drivers/video/riva/fbdev.c       |    2 --
 7 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index 18a5d9d..c8f9eca 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -2382,7 +2382,6 @@ err_release_pci0:
 err_release_fb:
         framebuffer_release(info);
 err_disable:
-	pci_disable_device(pdev);
 err_out:
 	return ret;
 }
@@ -2439,7 +2438,6 @@ #ifdef CONFIG_FB_RADEON_I2C
 #endif        
 	fb_dealloc_cmap(&info->cmap);
         framebuffer_release(info);
-	pci_disable_device(pdev);
 }
 
 
diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 1103010..dda240e 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -2227,7 +2227,6 @@ #endif
 		release_region(0x3C0, 32);
 	pci_release_regions(pdev);
 	framebuffer_release(cinfo->info);
-	pci_disable_device(pdev);
 }
 #endif /* CONFIG_PCI */
 
@@ -2458,7 +2457,6 @@ #endif
 err_release_fb:
 	framebuffer_release(info);
 err_disable:
-	pci_disable_device(pdev);
 err_out:
 	return ret;
 }
diff --git a/drivers/video/geode/gx1fb_core.c b/drivers/video/geode/gx1fb_core.c
index 20e6915..4d3a887 100644
--- a/drivers/video/geode/gx1fb_core.c
+++ b/drivers/video/geode/gx1fb_core.c
@@ -376,8 +376,6 @@ static int __init gx1fb_probe(struct pci
 		release_mem_region(gx1_gx_base() + 0x8300, 0x100);
 	}
 
-	pci_disable_device(pdev);
-
 	if (info)
 		framebuffer_release(info);
 	return ret;
@@ -399,7 +397,6 @@ static void gx1fb_remove(struct pci_dev 
 	iounmap(par->dc_regs);
 	release_mem_region(gx1_gx_base() + 0x8300, 0x100);
 
-	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
 
 	framebuffer_release(info);
diff --git a/drivers/video/geode/gxfb_core.c b/drivers/video/geode/gxfb_core.c
index 89c34b1..5ef12a3 100644
--- a/drivers/video/geode/gxfb_core.c
+++ b/drivers/video/geode/gxfb_core.c
@@ -354,8 +354,6 @@ static int __init gxfb_probe(struct pci_
 		pci_release_region(pdev, 2);
 	}
 
-	pci_disable_device(pdev);
-
 	if (info)
 		framebuffer_release(info);
 	return ret;
@@ -377,7 +375,6 @@ static void gxfb_remove(struct pci_dev *
 	iounmap(par->dc_regs);
 	pci_release_region(pdev, 2);
 
-	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
 
 	framebuffer_release(info);
diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index 44aa2ff..a1f7d80 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -2110,9 +2110,6 @@ static void i810fb_release_resource(stru
 	if (par->res_flags & MMIO_REQ)
 		release_mem_region(par->mmio_start_phys, MMIO_SIZE);
 
-	if (par->res_flags & PCI_DEVICE_ENABLED)
-		pci_disable_device(par->dev);
-
 	framebuffer_release(info);
 
 }
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index 65733e8..7b5cffb 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -1219,7 +1219,7 @@ static int __devinit nvidiafb_probe(stru
 
 	if (pci_request_regions(pd, "nvidiafb")) {
 		printk(KERN_ERR PFX "cannot request PCI regions\n");
-		goto err_out_request;
+		goto err_out_enable;
 	}
 
 	par->FlatPanel = flatpanel;
@@ -1338,10 +1338,8 @@ err_out_free_base1:
 	nvidia_delete_i2c_busses(par);
 err_out_arch:
 	iounmap(par->REGS);
-err_out_free_base0:
+ err_out_free_base0:
 	pci_release_regions(pd);
-err_out_request:
-	pci_disable_device(pd);
 err_out_enable:
 	kfree(info->pixmap.addr);
 err_out_kfree:
@@ -1371,7 +1369,6 @@ #endif				/* CONFIG_MTRR */
 	nvidia_delete_i2c_busses(par);
 	iounmap(par->REGS);
 	pci_release_regions(pd);
-	pci_disable_device(pd);
 	kfree(info->pixmap.addr);
 	framebuffer_release(info);
 	pci_set_drvdata(pd, NULL);
diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index d4384ab..12af58c 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -2152,7 +2152,6 @@ err_iounmap_ctrl_base:
 err_release_region:
 	pci_release_regions(pd);
 err_disable_device:
-	pci_disable_device(pd);
 err_free_pixmap:
 	kfree(info->pixmap.addr);
 err_framebuffer_release:
@@ -2187,7 +2186,6 @@ #endif /* CONFIG_MTRR */
 	if (par->riva.Architecture == NV_ARCH_03)
 		iounmap(par->riva.PRAMIN);
 	pci_release_regions(pd);
-	pci_disable_device(pd);
 	kfree(info->pixmap.addr);
 	framebuffer_release(info);
 	pci_set_drvdata(pd, NULL);





