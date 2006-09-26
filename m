Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbWIZFjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWIZFjx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWIZFj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:39:28 -0400
Received: from cantor.suse.de ([195.135.220.2]:52961 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751364AbWIZFiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:38:50 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 15/47] PM: video drivers and PM_EVENT_PRETHAW
Date: Mon, 25 Sep 2006 22:37:35 -0700
Message-Id: <11592491303012-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592491274168-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

Video drivers which explicitly test for messages reporting PM_EVENT_FREEZE
will now handle PM_EVENT_PRETHAW the same way.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/video/aty/radeon_pm.c          |   15 +++++++++------
 drivers/video/i810/i810_main.c         |   12 +++++++-----
 drivers/video/nvidia/nvidia.c          |   13 +++++++------
 drivers/video/savage/savagefb_driver.c |   14 +++++++-------
 4 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
index e308ed2..365de5d 100644
--- a/drivers/video/aty/radeon_pm.c
+++ b/drivers/video/aty/radeon_pm.c
@@ -2621,25 +2621,28 @@ static int radeon_restore_pci_cfg(struct
 }
 
 
-int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
+int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
 	int i;
 
-	if (state.event == pdev->dev.power.power_state.event)
+	if (mesg.event == pdev->dev.power.power_state.event)
 		return 0;
 
-	printk(KERN_DEBUG "radeonfb (%s): suspending to state: %d...\n",
-	       pci_name(pdev), state.event);
+	printk(KERN_DEBUG "radeonfb (%s): suspending for event: %d...\n",
+	       pci_name(pdev), mesg.event);
 
 	/* For suspend-to-disk, we cheat here. We don't suspend anything and
 	 * let fbcon continue drawing until we are all set. That shouldn't
 	 * really cause any problem at this point, provided that the wakeup
 	 * code knows that any state in memory may not match the HW
 	 */
-	if (state.event == PM_EVENT_FREEZE)
+	switch (mesg.event) {
+	case PM_EVENT_FREEZE:		/* about to take snapshot */
+	case PM_EVENT_PRETHAW:		/* before restoring snapshot */
 		goto done;
+	}
 
 	acquire_console_sem();
 
@@ -2706,7 +2709,7 @@ #endif /* CONFIG_PPC_PMAC */
 	release_console_sem();
 
  done:
-	pdev->dev.power.power_state = state;
+	pdev->dev.power.power_state = mesg;
 
 	return 0;
 }
diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index a6ca02f..d42edac 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -1554,15 +1554,17 @@ static struct fb_ops i810fb_ops __devini
 /***********************************************************************
  *                         Power Management                            *
  ***********************************************************************/
-static int i810fb_suspend(struct pci_dev *dev, pm_message_t state)
+static int i810fb_suspend(struct pci_dev *dev, pm_message_t mesg)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct i810fb_par *par = info->par;
 
-	par->cur_state = state.event;
+	par->cur_state = mesg.event;
 
-	if (state.event == PM_EVENT_FREEZE) {
-		dev->dev.power.power_state = state;
+	switch (mesg.event) {
+	case PM_EVENT_FREEZE:
+	case PM_EVENT_PRETHAW:
+		dev->dev.power.power_state = mesg;
 		return 0;
 	}
 
@@ -1578,7 +1580,7 @@ static int i810fb_suspend(struct pci_dev
 
 	pci_save_state(dev);
 	pci_disable_device(dev);
-	pci_set_power_state(dev, pci_choose_state(dev, state));
+	pci_set_power_state(dev, pci_choose_state(dev, mesg));
 	release_console_sem();
 
 	return 0;
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index d4f8501..f8cd4c5 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -950,24 +950,25 @@ static struct fb_ops nvidia_fb_ops = {
 };
 
 #ifdef CONFIG_PM
-static int nvidiafb_suspend(struct pci_dev *dev, pm_message_t state)
+static int nvidiafb_suspend(struct pci_dev *dev, pm_message_t mesg)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct nvidia_par *par = info->par;
 
+	if (mesg.event == PM_EVENT_PRETHAW)
+		mesg.event = PM_EVENT_FREEZE;
 	acquire_console_sem();
-	par->pm_state = state.event;
+	par->pm_state = mesg.event;
 
-	if (state.event == PM_EVENT_FREEZE) {
-		dev->dev.power.power_state = state;
-	} else {
+	if (mesg.event == PM_EVENT_SUSPEND) {
 		fb_set_suspend(info, 1);
 		nvidiafb_blank(FB_BLANK_POWERDOWN, info);
 		nvidia_write_regs(par, &par->SavedReg);
 		pci_save_state(dev);
 		pci_disable_device(dev);
-		pci_set_power_state(dev, pci_choose_state(dev, state));
+		pci_set_power_state(dev, pci_choose_state(dev, mesg));
 	}
+	dev->dev.power.power_state = mesg;
 
 	release_console_sem();
 	return 0;
diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index 461e094..82b3dea 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -2323,24 +2323,24 @@ #endif
 	}
 }
 
-static int savagefb_suspend(struct pci_dev* dev, pm_message_t state)
+static int savagefb_suspend(struct pci_dev *dev, pm_message_t mesg)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct savagefb_par *par = info->par;
 
 	DBG("savagefb_suspend");
 
-
-	par->pm_state = state.event;
+	if (mesg.event == PM_EVENT_PRETHAW)
+		mesg.event = PM_EVENT_FREEZE;
+	par->pm_state = mesg.event;
+	dev->dev.power.power_state = mesg;
 
 	/*
 	 * For PM_EVENT_FREEZE, do not power down so the console
 	 * can remain active.
 	 */
-	if (state.event == PM_EVENT_FREEZE) {
-		dev->dev.power.power_state = state;
+	if (mesg.event == PM_EVENT_FREEZE)
 		return 0;
-	}
 
 	acquire_console_sem();
 	fb_set_suspend(info, 1);
@@ -2353,7 +2353,7 @@ static int savagefb_suspend(struct pci_d
 	savage_disable_mmio(par);
 	pci_save_state(dev);
 	pci_disable_device(dev);
-	pci_set_power_state(dev, pci_choose_state(dev, state));
+	pci_set_power_state(dev, pci_choose_state(dev, mesg));
 	release_console_sem();
 
 	return 0;
-- 
1.4.2.1

