Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbVKWU1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbVKWU1K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVKWUYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:24:12 -0500
Received: from digitalimplant.org ([64.62.235.95]:63369 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S932312AbVKWUXk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:23:40 -0500
Date: Wed, 23 Nov 2005 12:23:33 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org, "" <linux-pm@lists.osdl.org>,
       "" <linux-sound@vger.kernel.org>
cc: akpm@osdl.org
Subject: [Patch 3/6] [OSS] Remove deprecated PM interface from cs46xx driver.
Message-ID: <Pine.LNX.4.50.0511231219180.16769-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff-tree 879a82d748d397be6dce2d4cafaa98c06a71acf2 (from aa92446260fcefe1a74c849e55f19d219f78f563)
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Wed Nov 23 11:51:41 2005 -0800

    [OSS] Remove deprecated PM interface from cs46xx driver.

    This change removes the old, deprecated interface from the
    cs46xx driver, including the pm_{,un}register() calls, the
    local storage of the pmdev object and the reference to the
    old header files. This change is done to assist in eradicating
    the users of the legacy interface so as to help facilitate
    the removal of the interface itself.

    Note this driver has PCI PM hooks which are set properly.
    It also has the ability to trigger suspend/resume from an
    ioctl. This functionality was not touched, though it could
    use a serious review if this driver continues to persist
    in the mainline tree..

    Note that this driver has been obsoleted by an ALSA equivalent.

    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

:040000 040000 a8246728e19c02094c7d8150836f7c0f7b9a1d02 6820ab87e68259b3602ecd3290fad6d7960b12bc M	sound

diffstat:

 sound/oss/cs46xx.c      |   60 ------------------------------------------------
 sound/oss/cs46xxpm-24.h |    4 ---
 2 files changed, 64 deletions(-)

---

879a82d748d397be6dce2d4cafaa98c06a71acf2
diff --git a/sound/oss/cs46xx.c b/sound/oss/cs46xx.c
index cb998e8..0da4d93 100644
--- a/sound/oss/cs46xx.c
+++ b/sound/oss/cs46xx.c
@@ -391,10 +391,6 @@ static void cs461x_clear_serial_FIFOs(st
 static int cs46xx_suspend_tbl(struct pci_dev *pcidev, pm_message_t state);
 static int cs46xx_resume_tbl(struct pci_dev *pcidev);

-#ifndef CS46XX_ACPI_SUPPORT
-static int cs46xx_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data);
-#endif
-
 #if CSDEBUG

 /* DEBUG ROUTINES */
@@ -5320,7 +5316,6 @@ static const char fndmsg[] = KERN_INFO "
 static int __devinit cs46xx_probe(struct pci_dev *pci_dev,
 				  const struct pci_device_id *pciid)
 {
-	struct pm_dev *pmdev;
 	int i,j;
 	u16 ss_card, ss_vendor;
 	struct cs_card *card;
@@ -5530,22 +5525,6 @@ static int __devinit cs46xx_probe(struct
 	PCI_SET_DMA_MASK(pci_dev, dma_mask);
 	list_add(&card->list, &cs46xx_devs);

-	pmdev = cs_pm_register(PM_PCI_DEV, PM_PCI_ID(pci_dev), cs46xx_pm_callback);
-	if (pmdev)
-	{
-		CS_DBGOUT(CS_INIT | CS_PM, 4, printk(KERN_INFO
-			 "cs46xx: probe() pm_register() succeeded (%p).\n",
-				pmdev));
-		pmdev->data = card;
-	}
-	else
-	{
-		CS_DBGOUT(CS_INIT | CS_PM | CS_ERROR, 2, printk(KERN_INFO
-			 "cs46xx: probe() pm_register() failed (%p).\n",
-				pmdev));
-		card->pm.flags |= CS46XX_PM_NOT_REGISTERED;
-	}
-
 	CS_DBGOUT(CS_PM, 9, printk(KERN_INFO "cs46xx: pm.flags=0x%x card=%p\n",
 		(unsigned)card->pm.flags,card));

@@ -5727,7 +5706,6 @@ static int __init cs46xx_init_module(voi
 static void __exit cs46xx_cleanup_module(void)
 {
 	pci_unregister_driver(&cs46xx_pci_driver);
-	cs_pm_unregister_all(cs46xx_pm_callback);
 	CS_DBGOUT(CS_INIT | CS_FUNCTION, 2,
 		  printk(KERN_INFO "cs46xx: cleanup_cs46xx() finished\n"));
 }
@@ -5735,44 +5713,6 @@ static void __exit cs46xx_cleanup_module
 module_init(cs46xx_init_module);
 module_exit(cs46xx_cleanup_module);

-#ifndef CS46XX_ACPI_SUPPORT
-static int cs46xx_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
-{
-	struct cs_card *card;
-
-	CS_DBGOUT(CS_PM, 2, printk(KERN_INFO
-		"cs46xx: cs46xx_pm_callback dev=%p rqst=0x%x card=%p\n",
-			dev,(unsigned)rqst,data));
-	card = (struct cs_card *) dev->data;
-	if (card) {
-		switch(rqst) {
-			case PM_SUSPEND:
-				CS_DBGOUT(CS_PM, 2, printk(KERN_INFO
-					"cs46xx: PM suspend request\n"));
-				if(cs46xx_suspend(card, PMSG_SUSPEND))
-				{
-				    CS_DBGOUT(CS_ERROR, 2, printk(KERN_INFO
-					"cs46xx: PM suspend request refused\n"));
-					return 1;
-				}
-				break;
-			case PM_RESUME:
-				CS_DBGOUT(CS_PM, 2, printk(KERN_INFO
-					"cs46xx: PM resume request\n"));
-				if(cs46xx_resume(card))
-				{
-				    CS_DBGOUT(CS_ERROR, 2, printk(KERN_INFO
-					"cs46xx: PM resume request refused\n"));
-					return 1;
-				}
-				break;
-		}
-	}
-
-	return 0;
-}
-#endif
-
 #if CS46XX_ACPI_SUPPORT
 static int cs46xx_suspend_tbl(struct pci_dev *pcidev, pm_message_t state)
 {
diff --git a/sound/oss/cs46xxpm-24.h b/sound/oss/cs46xxpm-24.h
index e220bd7..ad82db8 100644
--- a/sound/oss/cs46xxpm-24.h
+++ b/sound/oss/cs46xxpm-24.h
@@ -38,13 +38,9 @@
 */
 static int cs46xx_suspend_tbl(struct pci_dev *pcidev, pm_message_t state);
 static int cs46xx_resume_tbl(struct pci_dev *pcidev);
-#define cs_pm_register(a, b, c)  NULL
-#define cs_pm_unregister_all(a)
 #define CS46XX_SUSPEND_TBL cs46xx_suspend_tbl
 #define CS46XX_RESUME_TBL cs46xx_resume_tbl
 #else
-#define cs_pm_register(a, b, c) pm_register((a), (b), (c));
-#define cs_pm_unregister_all(a) pm_unregister_all((a));
 #define CS46XX_SUSPEND_TBL cs46xx_null
 #define CS46XX_RESUME_TBL cs46xx_null
 #endif
