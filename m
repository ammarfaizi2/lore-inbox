Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVC2TYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVC2TYx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 14:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVC2TYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 14:24:34 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38033 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261320AbVC2TXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 14:23:21 -0500
Date: Tue, 29 Mar 2005 21:20:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: benh@kernel.crashing.org, kernel list <linux-kernel@vger.kernel.org>
Subject: u32 vs. pm_message_t in ppc and radeon
Message-ID: <20050329192016.GA8323@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes pm_message_t vs. u32 confusion in ppc and aty (I *hope*
that's basically radeon code...). I was not able to test most of
these, but I'm not really changing anything, so it should be
okay. Please apply,

									Pavel

--- clean/arch/ppc64/kernel/of_device.c	2004-02-20 12:29:16.000000000 +0100
+++ linux/arch/ppc64/kernel/of_device.c	2005-03-27 23:33:56.000000000 +0200
@@ -104,7 +104,7 @@
 	return 0;
 }
 
-static int of_device_suspend(struct device *dev, u32 state)
+static int of_device_suspend(struct device *dev, pm_message_t state)
 {
 	struct of_device * of_dev = to_of_device(dev);
 	struct of_platform_driver * drv = to_of_platform_driver(dev->driver);
--- clean/include/asm-ppc/macio.h	2004-02-20 12:29:48.000000000 +0100
+++ linux/include/asm-ppc/macio.h	2005-03-29 11:15:51.000000000 +0200
@@ -126,7 +126,7 @@
 	int	(*probe)(struct macio_dev* dev, const struct of_match *match);
 	int	(*remove)(struct macio_dev* dev);
 
-	int	(*suspend)(struct macio_dev* dev, u32 state);
+	int	(*suspend)(struct macio_dev* dev, pm_message_t state);
 	int	(*resume)(struct macio_dev* dev);
 	int	(*shutdown)(struct macio_dev* dev);
 
--- clean/include/asm-ppc/ocp.h	2004-08-15 19:15:05.000000000 +0200
+++ linux/include/asm-ppc/ocp.h	2005-03-29 11:16:03.000000000 +0200
@@ -119,7 +119,7 @@
 	const struct ocp_device_id *id_table;	/* NULL if wants all devices */
 	int  (*probe)  (struct ocp_device *dev);	/* New device inserted */
 	void (*remove) (struct ocp_device *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
-	int  (*suspend) (struct ocp_device *dev, u32 state);	/* Device suspended */
+	int  (*suspend) (struct ocp_device *dev, pm_message_t state);	/* Device suspended */
 	int  (*resume) (struct ocp_device *dev);	                /* Device woken up */
 	struct device_driver driver;
 };
--- clean/include/asm-ppc/of_device.h	2003-09-28 22:06:38.000000000 +0200
+++ linux/include/asm-ppc/of_device.h	2005-03-29 11:16:14.000000000 +0200
@@ -55,7 +55,7 @@
 	int	(*probe)(struct of_device* dev, const struct of_match *match);
 	int	(*remove)(struct of_device* dev);
 
-	int	(*suspend)(struct of_device* dev, u32 state);
+	int	(*suspend)(struct of_device* dev, pm_message_t state);
 	int	(*resume)(struct of_device* dev);
 	int	(*shutdown)(struct of_device* dev);


--- clean/drivers/video/aty/aty128fb.c	2005-03-19 00:31:59.000000000 +0100
+++ linux/drivers/video/aty/aty128fb.c	2005-03-22 12:20:53.000000000 +0100
@@ -166,7 +166,7 @@
 static int aty128_probe(struct pci_dev *pdev,
                                const struct pci_device_id *ent);
 static void aty128_remove(struct pci_dev *pdev);
-static int aty128_pci_suspend(struct pci_dev *pdev, u32 state);
+static int aty128_pci_suspend(struct pci_dev *pdev, pm_message_t state);
 static int aty128_pci_resume(struct pci_dev *pdev);
 static int aty128_do_resume(struct pci_dev *pdev);
 
@@ -2327,7 +2327,7 @@
 	}
 }
 
-static int aty128_pci_suspend(struct pci_dev *pdev, u32 state)
+static int aty128_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct aty128fb_par *par = info->par;
@@ -2432,7 +2432,7 @@
 	par->lock_blank = 0;
 	aty128fb_blank(0, info);
 
-	pdev->dev.power.power_state = 0;
+	pdev->dev.power.power_state = PMSG_ON;
 
 	printk(KERN_DEBUG "aty128fb: resumed !\n");
 
--- clean/drivers/video/aty/atyfb_base.c	2005-03-19 00:31:59.000000000 +0100
+++ linux/drivers/video/aty/atyfb_base.c	2005-03-22 12:20:53.000000000 +0100
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
--- clean/drivers/video/aty/radeonfb.h	2005-03-19 00:31:59.000000000 +0100
+++ linux/drivers/video/aty/radeonfb.h	2005-03-22 12:20:53.000000000 +0100
@@ -608,7 +608,7 @@
 extern int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn, u8 **out_edid);
 
 /* PM Functions */
-extern int radeonfb_pci_suspend(struct pci_dev *pdev, u32 state);
+extern int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t state);
 extern int radeonfb_pci_resume(struct pci_dev *pdev);
 extern void radeonfb_pm_init(struct radeonfb_info *rinfo, int dynclk);
 extern void radeonfb_pm_exit(struct radeonfb_info *rinfo);
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
