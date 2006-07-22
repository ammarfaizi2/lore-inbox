Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWGVQ2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWGVQ2k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 12:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWGVQ2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 12:28:39 -0400
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:31700 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S1750871AbWGVQ2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 12:28:38 -0400
Date: Sat, 22 Jul 2006 18:28:21 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: adaplas@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch] rivafb/nvidiafb: race between register_framebuffer and *_bl_init
Message-ID: <20060722162821.GA4791@bogon.ms20.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Since we now use the generic backlight infrastructure, I think we need
to call rivafb_bl_init before calling register_framebuffer since
otherwise rivafb_bl_init might race with the framebuffer layer already
opening the device and setting up the video mode. In this case we might
end up with a not yet fully intialized backlight (info->bl_dev still
NULL) when calling riva_bl_set_power via
rivafb_set_par/rivafb_load_video_mode and the kernel dies without any
further notice during boot.
This fixes booting current git on a PB 6,1, please apply if it looks
correct - in this case radeonfb/atyfb would be affected too - I can fix
that too but don't have any hardware to test this on.
Cheers,
 -- Guido

diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index 9f2066f..eae291e 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -1303,20 +1303,19 @@ #endif				/* CONFIG_MTRR */
 
 	nvidia_save_vga(par, &par->SavedReg);
 
+	pci_set_drvdata(pd, info);
+	nvidia_bl_init(par);
 	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR PFX "error registering nVidia framebuffer\n");
 		goto err_out_iounmap_fb;
 	}
 
-	pci_set_drvdata(pd, info);
 
 	printk(KERN_INFO PFX
 	       "PCI nVidia %s framebuffer (%dMB @ 0x%lX)\n",
 	       info->fix.id,
 	       par->FbMapSize / (1024 * 1024), info->fix.smem_start);
 
-	nvidia_bl_init(par);
-
 	NVTRACE_LEAVE();
 	return 0;
 
@@ -2132,15 +2132,17 @@ #endif /* CONFIG_MTRR */
 
 	fb_destroy_modedb(info->monspecs.modedb);
 	info->monspecs.modedb = NULL;
+
+	pci_set_drvdata(pd, info);
+	riva_bl_init(info->par);
 	ret = register_framebuffer(info);
+
 	if (ret < 0) {
 		printk(KERN_ERR PFX
 			"error registering riva framebuffer\n");
 		goto err_iounmap_screen_base;
 	}
 
-	pci_set_drvdata(pd, info);
-
 	printk(KERN_INFO PFX
 		"PCI nVidia %s framebuffer ver %s (%dMB @ 0x%lX)\n",
 		info->fix.id,
@@ -2148,8 +2150,6 @@ #endif /* CONFIG_MTRR */
 		info->fix.smem_len / (1024 * 1024),
 		info->fix.smem_start);
 
-	riva_bl_init(info->par);
-
 	NVTRACE_LEAVE();
 	return 0;
 


Signed-Off-By: Guido Guenther <agx@sigxcpu.org>
