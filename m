Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVBOAzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVBOAzV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 19:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVBOAzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 19:55:21 -0500
Received: from gprs215-140.eurotel.cz ([160.218.215.140]:31686 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261477AbVBOAyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 19:54:52 -0500
Date: Tue, 15 Feb 2005 01:54:33 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, adaplas@pol.net,
       linux-fbdev-devel@lists.sourceforge.net
Cc: ncunningham@cyclades.com, bernard@blackham.com.au, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Fix u32 vs. pm_message_t confusion in framebuffers
Message-ID: <20050215005433.GG5415@elf.ucw.cz>
References: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au> <20050214213400.GF12235@elf.ucw.cz> <20050214134658.324076c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214134658.324076c9.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This should fix u32 vs pm_message_t confusion in framebuffers, and do
no code changes. Please apply,

Signed-off-by: Pavel Machek <pavel@suse.cz>
								Pavel

--- clean-mm/drivers/video/aty/aty128fb.c	2005-02-15 00:46:41.000000000 +0100
+++ linux-mm/drivers/video/aty/aty128fb.c	2005-02-15 01:04:11.000000000 +0100
@@ -166,7 +166,7 @@
 static int aty128_probe(struct pci_dev *pdev,
                                const struct pci_device_id *ent);
 static void aty128_remove(struct pci_dev *pdev);
-static int aty128_pci_suspend(struct pci_dev *pdev, u32 state);
+static int aty128_pci_suspend(struct pci_dev *pdev, pm_message_t state);
 static int aty128_pci_resume(struct pci_dev *pdev);
 static int aty128_do_resume(struct pci_dev *pdev);
 
@@ -2330,7 +2330,7 @@
 	}
 }
 
-static int aty128_pci_suspend(struct pci_dev *pdev, u32 state)
+static int aty128_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct aty128fb_par *par = info->par;
@@ -2413,7 +2413,7 @@
 	par->lock_blank = 0;
 	aty128fb_blank(0, info);
 
-	pdev->dev.power.power_state = 0;
+	pdev->dev.power.power_state = PMSG_ON;
 
 	printk(KERN_DEBUG "aty128fb: resumed !\n");
 
--- clean-mm/drivers/video/aty/atyfb_base.c	2005-02-15 00:34:40.000000000 +0100
+++ linux-mm/drivers/video/aty/atyfb_base.c	2005-02-15 01:04:11.000000000 +0100
@@ -2016,7 +2016,7 @@
 	return timeout ? 0 : -EIO;
 }
 
-static int atyfb_pci_suspend(struct pci_dev *pdev, u32 state)
+static int atyfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
@@ -2091,7 +2091,7 @@
 
 	release_console_sem();
 
-	pdev->dev.power.power_state = 0;
+	pdev->dev.power.power_state = PMSG_ON;
 
 	return 0;
 }
--- clean-mm/drivers/video/aty/radeon_pm.c	2005-02-15 00:46:41.000000000 +0100
+++ linux-mm/drivers/video/aty/radeon_pm.c	2005-02-15 01:04:11.000000000 +0100
@@ -2663,7 +2663,7 @@
 	else if (rinfo->dynclk == 0)
 		radeon_pm_disable_dynamic_mode(rinfo);
 
-	pdev->dev.power.power_state = 0;
+	pdev->dev.power.power_state = PMSG_ON;
 
  bail:
 	release_console_sem();
--- clean-mm/drivers/video/aty/radeonfb.h	2005-02-15 00:46:41.000000000 +0100
+++ linux-mm/drivers/video/aty/radeonfb.h	2005-02-15 01:04:11.000000000 +0100
@@ -624,7 +624,7 @@
 extern int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn, u8 **out_edid);
 
 /* PM Functions */
-extern int radeonfb_pci_suspend(struct pci_dev *pdev, u32 state);
+extern int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t state);
 extern int radeonfb_pci_resume(struct pci_dev *pdev);
 extern void radeonfb_pm_init(struct radeonfb_info *rinfo, int dynclk);
 extern void radeonfb_pm_exit(struct radeonfb_info *rinfo);
--- clean-mm/drivers/video/cyber2000fb.c	2005-02-15 00:34:40.000000000 +0100
+++ linux-mm/drivers/video/cyber2000fb.c	2005-02-15 01:04:11.000000000 +0100
@@ -1665,7 +1665,7 @@
 	}
 }
 
-static int cyberpro_pci_suspend(struct pci_dev *dev, u32 state)
+static int cyberpro_pci_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	return 0;
 }
--- clean-mm/drivers/video/i810/i810_main.c	2005-02-15 00:46:41.000000000 +0100
+++ linux-mm/drivers/video/i810/i810_main.c	2005-02-15 01:04:11.000000000 +0100
@@ -1524,7 +1524,7 @@
 		pci_disable_device(dev);
 	}
 	pci_save_state(dev);
-	pci_set_power_state(dev, state);
+	pci_set_power_state(dev, pci_choose_state(dev, state));
 
 	return 0;
 }
--- clean-mm/drivers/video/i810/i810_main.h	2004-04-05 10:45:24.000000000 +0200
+++ linux-mm/drivers/video/i810/i810_main.h	2005-02-15 01:04:11.000000000 +0100
@@ -18,7 +18,7 @@
 				       const struct pci_device_id *entry);
 static void __exit i810fb_remove_pci(struct pci_dev *dev);
 static int i810fb_resume(struct pci_dev *dev);
-static int i810fb_suspend(struct pci_dev *dev, u32 state);
+static int i810fb_suspend(struct pci_dev *dev, pm_message_t state);
 
 /*
  * voffset - framebuffer offset in MiB from aperture start address.  In order for

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
