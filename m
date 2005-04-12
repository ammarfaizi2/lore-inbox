Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262978AbVDMAFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262978AbVDMAFC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 20:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbVDLUaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:30:00 -0400
Received: from fire.osdl.org ([65.172.181.4]:9416 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262123AbVDLKbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:13 -0400
Message-Id: <200504121031.j3CAV8D9005245@shell0.pdx.osdl.net>
Subject: [patch 031/198] ppc32: Fix AGP and sleep again
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, benh@kernel.crashing.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

My previous patch that added sleep support for uninorth-agp and some AGP
"off" stuff in radeonfb and aty128fb is breaking some configs.  More
specifically, it has problems with rage128 setups since the DRI code for
these in X doesn't properly re-enable AGP on wakeup or console switch
(unlike the radeon DRM).

This patch fixes the problem for pmac once for all by using a different
approach.  The AGP driver "registers" special suspend/resume callbacks with
some arch code that the fbdev's can later on call to suspend and resume
AGP, making sure it's resumed back in the same state it was when suspended.
 This is platform specific for now.  It would be too complicated to try to
do a generic implementation of this at this point due to all sort of weird
things going on with AGP on other architectures.  We'll re-work that whole
problem cleanly once we finally merge fbdev's and DRI.

In the meantime, please apply this patch which brings back some r128 based
laptops into working condition as far as system sleep is concerned.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc/platforms/pmac_feature.c |   45 +++++++++++++++++++++
 25-akpm/arch/ppc64/kernel/pmac_feature.c  |   64 ++++++++++++++++++++++++++++++
 25-akpm/drivers/char/agp/uninorth-agp.c   |   52 ++++++++++++++++++++----
 25-akpm/drivers/video/aty/aty128fb.c      |   34 ++++++---------
 25-akpm/drivers/video/aty/radeon_pm.c     |   43 +++++++-------------
 25-akpm/include/asm-ppc/pmac_feature.h    |   11 +++++
 6 files changed, 193 insertions(+), 56 deletions(-)

diff -puN arch/ppc64/kernel/pmac_feature.c~ppc32-fix-agp-and-sleep-again arch/ppc64/kernel/pmac_feature.c
--- 25/arch/ppc64/kernel/pmac_feature.c~ppc32-fix-agp-and-sleep-again	2005-04-12 03:21:10.862485552 -0700
+++ 25-akpm/arch/ppc64/kernel/pmac_feature.c	2005-04-12 03:21:10.874483728 -0700
@@ -674,3 +674,67 @@ void __init pmac_check_ht_link(void)
 	dump_HT_speeds("PCI-X HT Downlink", cfg, freq);
 #endif
 }
+
+/*
+ * Early video resume hook
+ */
+
+static void (*pmac_early_vresume_proc)(void *data) __pmacdata;
+static void *pmac_early_vresume_data __pmacdata;
+
+void pmac_set_early_video_resume(void (*proc)(void *data), void *data)
+{
+	if (_machine != _MACH_Pmac)
+		return;
+	preempt_disable();
+	pmac_early_vresume_proc = proc;
+	pmac_early_vresume_data = data;
+	preempt_enable();
+}
+EXPORT_SYMBOL(pmac_set_early_video_resume);
+
+
+/*
+ * AGP related suspend/resume code
+ */
+
+static struct pci_dev *pmac_agp_bridge __pmacdata;
+static int (*pmac_agp_suspend)(struct pci_dev *bridge) __pmacdata;
+static int (*pmac_agp_resume)(struct pci_dev *bridge) __pmacdata;
+
+void __pmac pmac_register_agp_pm(struct pci_dev *bridge,
+				 int (*suspend)(struct pci_dev *bridge),
+				 int (*resume)(struct pci_dev *bridge))
+{
+	if (suspend || resume) {
+		pmac_agp_bridge = bridge;
+		pmac_agp_suspend = suspend;
+		pmac_agp_resume = resume;
+		return;
+	}
+	if (bridge != pmac_agp_bridge)
+		return;
+	pmac_agp_suspend = pmac_agp_resume = NULL;
+	return;
+}
+EXPORT_SYMBOL(pmac_register_agp_pm);
+
+void __pmac pmac_suspend_agp_for_card(struct pci_dev *dev)
+{
+	if (pmac_agp_bridge == NULL || pmac_agp_suspend == NULL)
+		return;
+	if (pmac_agp_bridge->bus != dev->bus)
+		return;
+	pmac_agp_suspend(pmac_agp_bridge);
+}
+EXPORT_SYMBOL(pmac_suspend_agp_for_card);
+
+void __pmac pmac_resume_agp_for_card(struct pci_dev *dev)
+{
+	if (pmac_agp_bridge == NULL || pmac_agp_resume == NULL)
+		return;
+	if (pmac_agp_bridge->bus != dev->bus)
+		return;
+	pmac_agp_resume(pmac_agp_bridge);
+}
+EXPORT_SYMBOL(pmac_resume_agp_for_card);
diff -puN arch/ppc/platforms/pmac_feature.c~ppc32-fix-agp-and-sleep-again arch/ppc/platforms/pmac_feature.c
--- 25/arch/ppc/platforms/pmac_feature.c~ppc32-fix-agp-and-sleep-again	2005-04-12 03:21:10.864485248 -0700
+++ 25-akpm/arch/ppc/platforms/pmac_feature.c	2005-04-12 03:21:10.876483424 -0700
@@ -2944,3 +2944,48 @@ void __pmac pmac_call_early_video_resume
 	if (pmac_early_vresume_proc)
 		pmac_early_vresume_proc(pmac_early_vresume_data);
 }
+
+/*
+ * AGP related suspend/resume code
+ */
+
+static struct pci_dev *pmac_agp_bridge __pmacdata;
+static int (*pmac_agp_suspend)(struct pci_dev *bridge) __pmacdata;
+static int (*pmac_agp_resume)(struct pci_dev *bridge) __pmacdata;
+
+void __pmac pmac_register_agp_pm(struct pci_dev *bridge,
+				 int (*suspend)(struct pci_dev *bridge),
+				 int (*resume)(struct pci_dev *bridge))
+{
+	if (suspend || resume) {
+		pmac_agp_bridge = bridge;
+		pmac_agp_suspend = suspend;
+		pmac_agp_resume = resume;
+		return;
+	}
+	if (bridge != pmac_agp_bridge)
+		return;
+	pmac_agp_suspend = pmac_agp_resume = NULL;
+	return;
+}
+EXPORT_SYMBOL(pmac_register_agp_pm);
+
+void __pmac pmac_suspend_agp_for_card(struct pci_dev *dev)
+{
+	if (pmac_agp_bridge == NULL || pmac_agp_suspend == NULL)
+		return;
+	if (pmac_agp_bridge->bus != dev->bus)
+		return;
+	pmac_agp_suspend(pmac_agp_bridge);
+}
+EXPORT_SYMBOL(pmac_suspend_agp_for_card);
+
+void __pmac pmac_resume_agp_for_card(struct pci_dev *dev)
+{
+	if (pmac_agp_bridge == NULL || pmac_agp_resume == NULL)
+		return;
+	if (pmac_agp_bridge->bus != dev->bus)
+		return;
+	pmac_agp_resume(pmac_agp_bridge);
+}
+EXPORT_SYMBOL(pmac_resume_agp_for_card);
diff -puN drivers/char/agp/uninorth-agp.c~ppc32-fix-agp-and-sleep-again drivers/char/agp/uninorth-agp.c
--- 25/drivers/char/agp/uninorth-agp.c~ppc32-fix-agp-and-sleep-again	2005-04-12 03:21:10.865485096 -0700
+++ 25-akpm/drivers/char/agp/uninorth-agp.c	2005-04-12 03:21:10.878483120 -0700
@@ -10,6 +10,7 @@
 #include <asm/uninorth.h>
 #include <asm/pci-bridge.h>
 #include <asm/prom.h>
+#include <asm/pmac_feature.h>
 #include "agp.h"
 
 /*
@@ -26,6 +27,7 @@
 static int uninorth_rev;
 static int is_u3;
 
+
 static int uninorth_fetch_size(void)
 {
 	int i;
@@ -264,7 +266,8 @@ static void uninorth_agp_enable(struct a
 				       &scratch);
 	} while ((scratch & PCI_AGP_COMMAND_AGP) == 0 && ++timeout < 1000);
 	if ((scratch & PCI_AGP_COMMAND_AGP) == 0)
-		printk(KERN_ERR PFX "failed to write UniNorth AGP command reg\n");
+		printk(KERN_ERR PFX "failed to write UniNorth AGP"
+		       " command register\n");
 
 	if (uninorth_rev >= 0x30) {
 		/* This is an AGP V3 */
@@ -278,13 +281,24 @@ static void uninorth_agp_enable(struct a
 }
 
 #ifdef CONFIG_PM
-static int agp_uninorth_suspend(struct pci_dev *pdev, pm_message_t state)
+/*
+ * These Power Management routines are _not_ called by the normal PCI PM layer,
+ * but directly by the video driver through function pointers in the device
+ * tree.
+ */
+static int agp_uninorth_suspend(struct pci_dev *pdev)
 {
+	struct agp_bridge_data *bridge;
 	u32 cmd;
 	u8 agp;
 	struct pci_dev *device = NULL;
 
-	if (state != PMSG_SUSPEND)
+	bridge = agp_find_bridge(pdev);
+	if (bridge == NULL)
+		return -ENODEV;
+
+	/* Only one suspend supported */
+	if (bridge->dev_private_data)
 		return 0;
 
 	/* turn off AGP on the video chip, if it was enabled */
@@ -315,6 +329,7 @@ static int agp_uninorth_suspend(struct p
 	/* turn off AGP on the bridge */
 	agp = pci_find_capability(pdev, PCI_CAP_ID_AGP);
 	pci_read_config_dword(pdev, agp + PCI_AGP_COMMAND, &cmd);
+	bridge->dev_private_data = (void *)cmd;
 	if (cmd & PCI_AGP_COMMAND_AGP) {
 		printk("uninorth-agp: disabling AGP on bridge %s\n",
 				pci_name(pdev));
@@ -329,9 +344,23 @@ static int agp_uninorth_suspend(struct p
 
 static int agp_uninorth_resume(struct pci_dev *pdev)
 {
+	struct agp_bridge_data *bridge;
+	u32 command;
+
+	bridge = agp_find_bridge(pdev);
+	if (bridge == NULL)
+		return -ENODEV;
+
+	command = (u32)bridge->dev_private_data;
+	bridge->dev_private_data = NULL;
+	if (!(command & PCI_AGP_COMMAND_AGP))
+		return 0;
+
+	uninorth_agp_enable(bridge, command);
+
 	return 0;
 }
-#endif
+#endif /* CONFIG_PM */
 
 static int uninorth_create_gatt_table(struct agp_bridge_data *bridge)
 {
@@ -575,6 +604,12 @@ static int __devinit agp_uninorth_probe(
 		of_node_put(uninorth_node);
 	}
 
+#ifdef CONFIG_PM
+	/* Inform platform of our suspend/resume caps */
+	pmac_register_agp_pm(pdev, agp_uninorth_suspend, agp_uninorth_resume);
+#endif
+
+	/* Allocate & setup our driver */
 	bridge = agp_alloc_bridge();
 	if (!bridge)
 		return -ENOMEM;
@@ -599,6 +634,11 @@ static void __devexit agp_uninorth_remov
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
+#ifdef CONFIG_PM
+	/* Inform platform of our suspend/resume caps */
+	pmac_register_agp_pm(pdev, NULL, NULL);
+#endif
+
 	agp_remove_bridge(bridge);
 	agp_put_bridge(bridge);
 }
@@ -622,10 +662,6 @@ static struct pci_driver agp_uninorth_pc
 	.id_table	= agp_uninorth_pci_table,
 	.probe		= agp_uninorth_probe,
 	.remove		= agp_uninorth_remove,
-#ifdef CONFIG_PM
-	.suspend	= agp_uninorth_suspend,
-	.resume		= agp_uninorth_resume,
-#endif
 };
 
 static int __init agp_uninorth_init(void)
diff -puN drivers/video/aty/aty128fb.c~ppc32-fix-agp-and-sleep-again drivers/video/aty/aty128fb.c
--- 25/drivers/video/aty/aty128fb.c~ppc32-fix-agp-and-sleep-again	2005-04-12 03:21:10.867484792 -0700
+++ 25-akpm/drivers/video/aty/aty128fb.c	2005-04-12 03:21:10.880482816 -0700
@@ -2331,7 +2331,6 @@ static int aty128_pci_suspend(struct pci
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct aty128fb_par *par = info->par;
-	u8 agp;
 
 	/* We don't do anything but D2, for now we return 0, but
 	 * we may want to change that. How do we know if the BIOS
@@ -2369,26 +2368,13 @@ static int aty128_pci_suspend(struct pci
 	par->asleep = 1;
 	par->lock_blank = 1;
 
-	/* Disable AGP. The AGP host should have done it, but since ordering
-	 * isn't always properly guaranteed in this specific case, let's make
-	 * sure it's disabled on card side now. Ultimately, when merging fbdev
-	 * and dri into some common infrastructure, this will be handled
-	 * more nicely. The host bridge side will (or will not) be dealt with
-	 * by the bridge AGP driver, we don't attempt to touch it here.
+#ifdef CONFIG_PPC_PMAC
+	/* On powermac, we have hooks to properly suspend/resume AGP now,
+	 * use them here. We'll ultimately need some generic support here,
+	 * but the generic code isn't quite ready for that yet
 	 */
-	agp = pci_find_capability(pdev, PCI_CAP_ID_AGP);
-	if (agp) {
-		u32 cmd;
-
-		pci_read_config_dword(pdev, agp + PCI_AGP_COMMAND, &cmd);
-		if (cmd & PCI_AGP_COMMAND_AGP) {
-			printk(KERN_INFO "aty128fb: AGP was enabled, "
-			       "disabling ...\n");
-			cmd &= ~PCI_AGP_COMMAND_AGP;
-			pci_write_config_dword(pdev, agp + PCI_AGP_COMMAND,
-					       cmd);
-		}
-	}
+	pmac_suspend_agp_for_card(pdev);
+#endif /* CONFIG_PPC_PMAC */
 
 	/* We need a way to make sure the fbdev layer will _not_ touch the
 	 * framebuffer before we put the chip to suspend state. On 2.4, I
@@ -2432,6 +2418,14 @@ static int aty128_do_resume(struct pci_d
 	par->lock_blank = 0;
 	aty128fb_blank(0, info);
 
+#ifdef CONFIG_PPC_PMAC
+	/* On powermac, we have hooks to properly suspend/resume AGP now,
+	 * use them here. We'll ultimately need some generic support here,
+	 * but the generic code isn't quite ready for that yet
+	 */
+	pmac_resume_agp_for_card(pdev);
+#endif /* CONFIG_PPC_PMAC */
+
 	pdev->dev.power.power_state = PMSG_ON;
 
 	printk(KERN_DEBUG "aty128fb: resumed !\n");
diff -puN drivers/video/aty/radeon_pm.c~ppc32-fix-agp-and-sleep-again drivers/video/aty/radeon_pm.c
--- 25/drivers/video/aty/radeon_pm.c~ppc32-fix-agp-and-sleep-again	2005-04-12 03:21:10.868484640 -0700
+++ 25-akpm/drivers/video/aty/radeon_pm.c	2005-04-12 03:21:10.882482512 -0700
@@ -2520,13 +2520,10 @@ static int radeon_restore_pci_cfg(struct
 }
 
 
-static/*extern*/ int susdisking = 0;
-
 int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
-	u8 agp;
 	int i;
 
 	if (state == pdev->dev.power.power_state)
@@ -2542,11 +2539,6 @@ int radeonfb_pci_suspend(struct pci_dev 
 	 */
 	if (state != PM_SUSPEND_MEM)
 		goto done;
-	if (susdisking) {
-		printk("radeonfb (%s): suspending to disk but state = %d\n",
-		       pci_name(pdev), state);
-		goto done;
-	}
 
 	acquire_console_sem();
 
@@ -2567,27 +2559,13 @@ int radeonfb_pci_suspend(struct pci_dev 
 	rinfo->lock_blank = 1;
 	del_timer_sync(&rinfo->lvds_timer);
 
-	/* Disable AGP. The AGP host should have done it, but since ordering
-	 * isn't always properly guaranteed in this specific case, let's make
-	 * sure it's disabled on card side now. Ultimately, when merging fbdev
-	 * and dri into some common infrastructure, this will be handled
-	 * more nicely. The host bridge side will (or will not) be dealt with
-	 * by the bridge AGP driver, we don't attempt to touch it here.
+#ifdef CONFIG_PPC_PMAC
+	/* On powermac, we have hooks to properly suspend/resume AGP now,
+	 * use them here. We'll ultimately need some generic support here,
+	 * but the generic code isn't quite ready for that yet
 	 */
-	agp = pci_find_capability(pdev, PCI_CAP_ID_AGP);
-	if (agp) {
-		u32 cmd;
-
-		pci_read_config_dword(pdev, agp + PCI_AGP_COMMAND, &cmd);
-		if (cmd & PCI_AGP_COMMAND_AGP) {
-			printk(KERN_INFO "radeonfb (%s): AGP was enabled, "
-			       "disabling ...\n",
-			       pci_name(pdev));
-			cmd &= ~PCI_AGP_COMMAND_AGP;
-			pci_write_config_dword(pdev, agp + PCI_AGP_COMMAND,
-					       cmd);
-		}
-	}
+	pmac_suspend_agp_for_card(pdev);
+#endif /* CONFIG_PPC_PMAC */
 
 	/* If we support wakeup from poweroff, we save all regs we can including cfg
 	 * space
@@ -2699,6 +2677,15 @@ int radeonfb_pci_resume(struct pci_dev *
 	rinfo->lock_blank = 0;
 	radeon_screen_blank(rinfo, FB_BLANK_UNBLANK, 1);
 
+#ifdef CONFIG_PPC_PMAC
+	/* On powermac, we have hooks to properly suspend/resume AGP now,
+	 * use them here. We'll ultimately need some generic support here,
+	 * but the generic code isn't quite ready for that yet
+	 */
+	pmac_resume_agp_for_card(pdev);
+#endif /* CONFIG_PPC_PMAC */
+
+
 	/* Check status of dynclk */
 	if (rinfo->dynclk == 1)
 		radeon_pm_enable_dynamic_mode(rinfo);
diff -puN include/asm-ppc/pmac_feature.h~ppc32-fix-agp-and-sleep-again include/asm-ppc/pmac_feature.h
--- 25/include/asm-ppc/pmac_feature.h~ppc32-fix-agp-and-sleep-again	2005-04-12 03:21:10.870484336 -0700
+++ 25-akpm/include/asm-ppc/pmac_feature.h	2005-04-12 03:21:10.883482360 -0700
@@ -305,6 +305,17 @@ extern void pmac_call_early_video_resume
 
 #define PMAC_FTR_DEF(x) ((_MACH_Pmac << 16) | (x))
 
+/* The AGP driver registers itself here */
+extern void pmac_register_agp_pm(struct pci_dev *bridge,
+				 int (*suspend)(struct pci_dev *bridge),
+				 int (*resume)(struct pci_dev *bridge));
+
+/* Those are meant to be used by video drivers to deal with AGP
+ * suspend resume properly
+ */
+extern void pmac_suspend_agp_for_card(struct pci_dev *dev);
+extern void pmac_resume_agp_for_card(struct pci_dev *dev);
+
 
 /*
  * The part below is for use by macio_asic.c only, do not rely
_
