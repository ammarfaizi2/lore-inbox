Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264999AbVBDWv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264999AbVBDWv6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 17:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265441AbVBDWue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:50:34 -0500
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:7441 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id S265156AbVBDWQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 17:16:54 -0500
Message-ID: <4203F51A.10302@cs.man.ac.uk>
Date: Fri, 04 Feb 2005 22:20:10 +0000
From: Daniel Drake <dsd@cs.man.ac.uk>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-pm@osdl.org
Subject: [-mm PATCH] driver model: PM type checking in drivers/video
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060200020402040002070300"
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CxBks-000NYE-OR*9a3M0TwWVCc*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060200020402040002070300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This fixes PM driver model type checking for drivers/video.
Acked by Pavel Machek.

Signed-off-by: Daniel Drake <dsd@gentoo.org>


--------------060200020402040002070300
Content-Type: text/x-patch;
 name="video-pm-type-safety.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="video-pm-type-safety.patch"

diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/video/aty/radeon_pm.c linux-dsd/drivers/video/aty/radeon_pm.c
--- linux-2.6.11-rc2-mm2/drivers/video/aty/radeon_pm.c	2005-02-02 21:55:28.000000000 +0000
+++ linux-dsd/drivers/video/aty/radeon_pm.c	2005-02-02 21:58:53.000000000 +0000
@@ -2596,7 +2596,7 @@ int radeonfb_pci_resume(struct pci_dev *
         struct radeonfb_info *rinfo = info->par;
 	int rc = 0;
 
-	if (pdev->dev.power.power_state == 0)
+	if (pdev->dev.power.power_state == PMSG_ON)
 		return 0;
 
 	if (rinfo->no_schedule) {
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/video/backlight/corgi_bl.c linux-dsd/drivers/video/backlight/corgi_bl.c
--- linux-2.6.11-rc2-mm2/drivers/video/backlight/corgi_bl.c	2005-02-02 21:55:28.000000000 +0000
+++ linux-dsd/drivers/video/backlight/corgi_bl.c	2005-02-02 20:08:15.000000000 +0000
@@ -81,7 +81,7 @@ static void corgibl_blank(int blank)
 }
 
 #ifdef CONFIG_PM
-static int corgibl_suspend(struct device *dev, u32 state, u32 level)
+static int corgibl_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	if (level == SUSPEND_POWER_DOWN)
 		corgibl_blank(FB_BLANK_POWERDOWN);
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/video/i810/i810_main.c linux-dsd/drivers/video/i810/i810_main.c
--- linux-2.6.11-rc2-mm2/drivers/video/i810/i810_main.c	2005-02-02 21:55:28.000000000 +0000
+++ linux-dsd/drivers/video/i810/i810_main.c	2005-02-02 20:13:21.000000000 +0000
@@ -1492,7 +1492,7 @@ static struct fb_ops i810fb_ops __devini
 /***********************************************************************
  *                         Power Management                            *
  ***********************************************************************/
-static int i810fb_suspend(struct pci_dev *dev, u32 state)
+static int i810fb_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
@@ -1538,7 +1538,7 @@ static int i810fb_resume(struct pci_dev 
 		return 0;
 
 	pci_restore_state(dev);
-	pci_set_power_state(dev, 0);
+	pci_set_power_state(dev, PCI_D0);
 	pci_enable_device(dev);
 	agp_bind_memory(par->i810_gtt.i810_fb_memory,
 			par->fb.offset);
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/video/pxafb.c linux-dsd/drivers/video/pxafb.c
--- linux-2.6.11-rc2-mm2/drivers/video/pxafb.c	2005-02-02 21:54:21.000000000 +0000
+++ linux-dsd/drivers/video/pxafb.c	2005-02-02 20:01:56.000000000 +0000
@@ -942,7 +942,7 @@ pxafb_freq_policy(struct notifier_block 
  * Power management hooks.  Note that we won't be called from IRQ context,
  * unlike the blank functions above, so we may sleep.
  */
-static int pxafb_suspend(struct device *dev, u32 state, u32 level)
+static int pxafb_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct pxafb_info *fbi = dev_get_drvdata(dev);
 
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/video/sa1100fb.c linux-dsd/drivers/video/sa1100fb.c
--- linux-2.6.11-rc2-mm2/drivers/video/sa1100fb.c	2005-02-02 21:54:21.000000000 +0000
+++ linux-dsd/drivers/video/sa1100fb.c	2005-02-02 20:02:48.000000000 +0000
@@ -1307,7 +1307,7 @@ sa1100fb_freq_policy(struct notifier_blo
  * Power management hooks.  Note that we won't be called from IRQ context,
  * unlike the blank functions above, so we may sleep.
  */
-static int sa1100fb_suspend(struct device *dev, u32 state, u32 level)
+static int sa1100fb_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct sa1100fb_info *fbi = dev_get_drvdata(dev);
 
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/video/savage/savagefb.c linux-dsd/drivers/video/savage/savagefb.c
--- linux-2.6.11-rc2-mm2/drivers/video/savage/savagefb.c	2004-12-24 21:34:45.000000000 +0000
+++ linux-dsd/drivers/video/savage/savagefb.c	2005-02-02 20:14:38.000000000 +0000
@@ -2100,7 +2100,7 @@ static void __devexit savagefb_remove (s
 	}
 }
 
-static int savagefb_suspend (struct pci_dev* dev, u32 state)
+static int savagefb_suspend (struct pci_dev* dev, pm_message_t state)
 {
 	struct fb_info *info =
 		(struct fb_info *)pci_get_drvdata(dev);
@@ -2115,7 +2115,7 @@ static int savagefb_suspend (struct pci_
 	release_console_sem();
 
 	pci_disable_device(dev);
-	pci_set_power_state(dev, state);
+	pci_set_power_state(dev, pci_choose_state(dev, state));
 
 	return 0;
 }
@@ -2128,7 +2128,7 @@ static int savagefb_resume (struct pci_d
 
 	DBG("savage_resume");
 
-	pci_set_power_state(dev, 0);
+	pci_set_power_state(dev, PCI_D0);
 	pci_restore_state(dev);
 	if(pci_enable_device(dev))
 		DBG("err");
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/video/w100fb.c linux-dsd/drivers/video/w100fb.c
--- linux-2.6.11-rc2-mm2/drivers/video/w100fb.c	2005-02-02 21:54:21.000000000 +0000
+++ linux-dsd/drivers/video/w100fb.c	2005-02-02 20:04:16.000000000 +0000
@@ -535,7 +535,7 @@ static void w100fb_clear_buffer(void)
 
 
 #ifdef CONFIG_PM
-static int w100fb_suspend(struct device *dev, u32 state, u32 level)
+static int w100fb_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	if (level == SUSPEND_POWER_DOWN) {
 		struct fb_info *info = dev_get_drvdata(dev);

--------------060200020402040002070300--
