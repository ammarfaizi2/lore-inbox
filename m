Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751827AbWJ2UFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbWJ2UFh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 15:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbWJ2UFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 15:05:37 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:1450 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751827AbWJ2UFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 15:05:36 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 29 Oct 2006 21:05:18 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [GIT PULL] ieee1394 update
To: Linus Torvalds <torvalds@osdl.org>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-ID: <tkrat.d9b5fcaacce06b28@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from the for-linus branch at

    git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394-2.6.git for-linus

to receive the following patch...

Stefan Richter (1):
      ieee1394: ohci1394: revert fail on error in suspend

 drivers/ieee1394/ohci1394.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

...or just apply it from this mail.  This fixes a regression since -rc1:
Some machines, esp. PPC_PMAC, cannot suspend if ohci1394 is loaded.



Date: Sun, 29 Oct 2006 19:52:49 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: ieee1394: ohci1394: revert fail on error in suspend

Some errors during preparation for suspended state can be skipped with a
warning instead of a failure of the whole suspend transition, notably an
error in pci_set_power_state.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/ohci1394.c
===================================================================
--- linux.orig/drivers/ieee1394/ohci1394.c
+++ linux/drivers/ieee1394/ohci1394.c
@@ -3552,12 +3552,21 @@ static int ohci1394_pci_suspend (struct
 {
 	int err;
 
+	printk(KERN_INFO "%s does not fully support suspend and resume yet\n",
+	       OHCI1394_DRIVER_NAME);
+
 	err = pci_save_state(pdev);
-	if (err)
-		goto out;
+	if (err) {
+		printk(KERN_ERR "%s: pci_save_state failed with %d\n",
+		       OHCI1394_DRIVER_NAME, err);
+		return err;
+	}
 	err = pci_set_power_state(pdev, pci_choose_state(pdev, state));
+#ifdef OHCI1394_DEBUG
 	if (err)
-		goto out;
+		printk(KERN_DEBUG "%s: pci_set_power_state failed with %d\n",
+		       OHCI1394_DRIVER_NAME, err);
+#endif /* OHCI1394_DEBUG */
 
 /* PowerMac suspend code comes last */
 #ifdef CONFIG_PPC_PMAC
@@ -3570,8 +3579,8 @@ #ifdef CONFIG_PPC_PMAC
 			pmac_call_feature(PMAC_FTR_1394_ENABLE, of_node, 0, 0);
 	}
 #endif /* CONFIG_PPC_PMAC */
-out:
-	return err;
+
+	return 0;
 }
 #endif /* CONFIG_PM */
 


