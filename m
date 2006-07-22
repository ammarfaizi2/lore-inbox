Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWGVQhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWGVQhR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 12:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWGVQhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 12:37:17 -0400
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:36564 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S1750891AbWGVQhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 12:37:15 -0400
Date: Sat, 22 Jul 2006 18:36:57 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: adaplas@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] rivafb/nvidiafb: race between register_framebuffer and *_bl_init
Message-ID: <20060722163657.GA5699@bogon.ms20.nix>
References: <20060722162821.GA4791@bogon.ms20.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060722162821.GA4791@bogon.ms20.nix>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Sat, Jul 22, 2006 at 06:28:21PM +0200, Guido Guenther wrote:
> This fixes booting current git on a PB 6,1, please apply if it looks
> correct - in this case radeonfb/atyfb would be affected too - I can fix
> that too but don't have any hardware to test this on.
...no it doesn't because the patch doesn't apply. This one does, sorry
for the noise.
 -- Guido

diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
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
 
diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index 33dddba..43aa8be 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -2132,6 +2132,9 @@ #endif /* CONFIG_MTRR */
 
 	fb_destroy_modedb(info->monspecs.modedb);
 	info->monspecs.modedb = NULL;
+
+	pci_set_drvdata(pd, info);
+	riva_bl_init(info->par);
 	ret = register_framebuffer(info);
 	if (ret < 0) {
 		printk(KERN_ERR PFX
@@ -2139,8 +2142,6 @@ #endif /* CONFIG_MTRR */
 		goto err_iounmap_screen_base;
 	}
 
-	pci_set_drvdata(pd, info);
-
 	printk(KERN_INFO PFX
 		"PCI nVidia %s framebuffer ver %s (%dMB @ 0x%lX)\n",
 		info->fix.id,
@@ -2148,8 +2149,6 @@ #endif /* CONFIG_MTRR */
 		info->fix.smem_len / (1024 * 1024),
 		info->fix.smem_start);
 
-	riva_bl_init(info->par);
-
 	NVTRACE_LEAVE();
 	return 0;
 


Signed-Off-By: Guido Guenther <agx@sigxcpu.org>
