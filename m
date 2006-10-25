Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423087AbWJYHpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423087AbWJYHpJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 03:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423093AbWJYHpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 03:45:09 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:58803 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1423087AbWJYHpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 03:45:06 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Wed, 25 Oct 2006 09:44:49 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [rfc patch linux1394-2.6.git 1/2] ieee1394: ohci1394: revert fail on
 error in suspend
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <453F095E.4060106@s5r6.in-berlin.de>
Message-ID: <tkrat.08bb7d87c85b2fe5@s5r6.in-berlin.de>
References: <1161672898.10524.596.camel@localhost.localdomain>
 <1161675611.10524.598.camel@localhost.localdomain>
 <tkrat.1b479115136413cf@s5r6.in-berlin.de>
 <453F08A0.9040506@s5r6.in-berlin.de> <453F095E.4060106@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The error checks in the suspend code were too harsh and broke
suspend on some PPC_PMACs again which have extra platform code.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/ohci1394.c
===================================================================
--- linux.orig/drivers/ieee1394/ohci1394.c	2006-10-25 09:22:05.000000000 +0200
+++ linux/drivers/ieee1394/ohci1394.c	2006-10-25 09:25:36.000000000 +0200
@@ -3534,6 +3534,9 @@ static int ohci1394_pci_suspend(struct p
 	int err;
 	struct ti_ohci *ohci = pci_get_drvdata(pdev);
 
+	printk(KERN_INFO "%s does not fully support suspend yet\n",
+	       OHCI1394_DRIVER_NAME);
+
 	PRINT(KERN_DEBUG, "suspend called");
 	if (!ohci)
 		return -ENXIO;
@@ -3558,11 +3561,17 @@ static int ohci1394_pci_suspend(struct p
 	ohci_soft_reset(ohci);
 
 	err = pci_save_state(pdev);
-	if (err)
+	if (err) {
+		printk(KERN_ERR "%s: pci_save_state failed with %d\n",
+		       OHCI1394_DRIVER_NAME, err);
 		return err;
+	}
 	err = pci_set_power_state(pdev, pci_choose_state(pdev, state));
+#ifdef OHCI1394_DEBUG
 	if (err)
-		return err;
+		printk(KERN_DEBUG "%s: pci_set_power_state failed with %d\n",
+		       OHCI1394_DRIVER_NAME, err);
+#endif /* OHCI1394_DEBUG */
 
 /* PowerMac suspend code comes last */
 #ifdef CONFIG_PPC_PMAC


