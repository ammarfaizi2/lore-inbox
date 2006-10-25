Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423093AbWJYHrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423093AbWJYHrH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 03:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423094AbWJYHrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 03:47:07 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:8628 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1423093AbWJYHrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 03:47:04 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Wed, 25 Oct 2006 09:46:55 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [rfc patch linux1394-2.6.git 2/2] ieee1394: ohci1394: proper log
 messages in suspend and resume
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <tkrat.08bb7d87c85b2fe5@s5r6.in-berlin.de>
Message-ID: <tkrat.bd2773f6d2e1ec66@s5r6.in-berlin.de>
References: <1161672898.10524.596.camel@localhost.localdomain>
 <1161675611.10524.598.camel@localhost.localdomain>
 <tkrat.1b479115136413cf@s5r6.in-berlin.de>
 <453F08A0.9040506@s5r6.in-berlin.de> <453F095E.4060106@s5r6.in-berlin.de>
 <tkrat.08bb7d87c85b2fe5@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - correct thinko in one of my last commits: cannot use PRINT macro with
   ohci == NULL
 - add log messages on ohci == NULL and on pci_enable_device != 0
 - update log macros from patch "revert fail on error in suspend" to use
   PRINT and DBGMSG where possible

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/ohci1394.c
===================================================================
--- linux.orig/drivers/ieee1394/ohci1394.c	2006-10-25 09:25:36.000000000 +0200
+++ linux/drivers/ieee1394/ohci1394.c	2006-10-25 09:33:42.000000000 +0200
@@ -3537,9 +3537,12 @@ static int ohci1394_pci_suspend(struct p
 	printk(KERN_INFO "%s does not fully support suspend yet\n",
 	       OHCI1394_DRIVER_NAME);
 
-	PRINT(KERN_DEBUG, "suspend called");
-	if (!ohci)
+	if (!ohci) {
+		printk(KERN_ERR "%s: tried to suspend nonexisting host\n",
+		       OHCI1394_DRIVER_NAME);
 		return -ENXIO;
+	}
+	DBGMSG("suspend called");
 
 	/* Clear the async DMA contexts and stop using the controller */
 	hpsb_bus_reset(ohci->host);
@@ -3562,16 +3565,12 @@ static int ohci1394_pci_suspend(struct p
 
 	err = pci_save_state(pdev);
 	if (err) {
-		printk(KERN_ERR "%s: pci_save_state failed with %d\n",
-		       OHCI1394_DRIVER_NAME, err);
+		PRINT(KERN_ERR, "pci_save_state failed with %d", err);
 		return err;
 	}
 	err = pci_set_power_state(pdev, pci_choose_state(pdev, state));
-#ifdef OHCI1394_DEBUG
 	if (err)
-		printk(KERN_DEBUG "%s: pci_set_power_state failed with %d\n",
-		       OHCI1394_DRIVER_NAME, err);
-#endif /* OHCI1394_DEBUG */
+		DBGMSG("pci_set_power_state failed with %d", err);
 
 /* PowerMac suspend code comes last */
 #ifdef CONFIG_PPC_PMAC
@@ -3593,9 +3592,12 @@ static int ohci1394_pci_resume(struct pc
 	int err;
 	struct ti_ohci *ohci = pci_get_drvdata(pdev);
 
-	PRINT(KERN_DEBUG, "resume called");
-	if (!ohci)
+	if (!ohci) {
+		printk(KERN_ERR "%s: tried to resume nonexisting host\n",
+		       OHCI1394_DRIVER_NAME);
 		return -ENXIO;
+	}
+	DBGMSG("resume called");
 
 /* PowerMac resume code comes first */
 #ifdef CONFIG_PPC_PMAC
@@ -3612,8 +3614,10 @@ static int ohci1394_pci_resume(struct pc
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 	err = pci_enable_device(pdev);
-	if (err)
+	if (err) {
+		PRINT(KERN_ERR, "pci_enable_device failed with %d", err);
 		return err;
+	}
 
 	/* See ohci1394_pci_probe() for comments on this sequence */
 	ohci_soft_reset(ohci);


