Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751621AbWIZFwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbWIZFwt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWIZFwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:52:21 -0400
Received: from ns.suse.de ([195.135.220.2]:49377 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751285AbWIZFik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:38:40 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 12/47] fix broken/dubious driver suspend() methods
Date: Mon, 25 Sep 2006 22:37:32 -0700
Message-Id: <11592491211162-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <115924911859-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

Small driver suspend() fixes in preparation for the PRETHAW events:

 - Only compare message events for equality against PM_EVENT_* codes;
   not against integers, or using greater/less-than comparisons.
   (PM_EVENT_* should really become a __bitwise thing.)

 - Explicitly test for SUSPEND events (rather than not-something-else)
   before suspending devices.

 - Removes more of the confusion between a pm_message_t (wraps event code)
   and a "state" ... suspend() originally took a target system state.

These updates are correct and appropriate even without new PM_EVENT codes.

benh: "I think in the Mesh case, we should handle the freeze case as well or
we might get wild DMA."

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Acked-by: Pavel Machek <pavel@ucw.cz>
Cc: Greg KH <greg@kroah.com>
Cc: Paul Mackerras <paulus@samba.org>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/ide/ppc/pmac.c                  |   14 ++++++++------
 drivers/media/dvb/cinergyT2/cinergyT2.c |    2 +-
 drivers/scsi/mesh.c                     |   15 +++++++++++----
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
index 996c694..31ad79f 100644
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1369,15 +1369,16 @@ #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
 }
 
 static int
-pmac_ide_macio_suspend(struct macio_dev *mdev, pm_message_t state)
+pmac_ide_macio_suspend(struct macio_dev *mdev, pm_message_t mesg)
 {
 	ide_hwif_t	*hwif = (ide_hwif_t *)dev_get_drvdata(&mdev->ofdev.dev);
 	int		rc = 0;
 
-	if (state.event != mdev->ofdev.dev.power.power_state.event && state.event >= PM_EVENT_SUSPEND) {
+	if (mesg.event != mdev->ofdev.dev.power.power_state.event
+			&& mesg.event == PM_EVENT_SUSPEND) {
 		rc = pmac_ide_do_suspend(hwif);
 		if (rc == 0)
-			mdev->ofdev.dev.power.power_state = state;
+			mdev->ofdev.dev.power.power_state = mesg;
 	}
 
 	return rc;
@@ -1473,15 +1474,16 @@ #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
 }
 
 static int
-pmac_ide_pci_suspend(struct pci_dev *pdev, pm_message_t state)
+pmac_ide_pci_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
 	ide_hwif_t	*hwif = (ide_hwif_t *)pci_get_drvdata(pdev);
 	int		rc = 0;
 	
-	if (state.event != pdev->dev.power.power_state.event && state.event >= 2) {
+	if (mesg.event != pdev->dev.power.power_state.event
+			&& mesg.event == PM_EVENT_SUSPEND) {
 		rc = pmac_ide_do_suspend(hwif);
 		if (rc == 0)
-			pdev->dev.power.power_state = state;
+			pdev->dev.power.power_state = mesg;
 	}
 
 	return rc;
diff --git a/drivers/media/dvb/cinergyT2/cinergyT2.c b/drivers/media/dvb/cinergyT2/cinergyT2.c
index 001c71b..410fa6d 100644
--- a/drivers/media/dvb/cinergyT2/cinergyT2.c
+++ b/drivers/media/dvb/cinergyT2/cinergyT2.c
@@ -981,7 +981,7 @@ static int cinergyt2_suspend (struct usb
 	if (cinergyt2->disconnect_pending || mutex_lock_interruptible(&cinergyt2->sem))
 		return -ERESTARTSYS;
 
-	if (state.event > PM_EVENT_ON) {
+	if (1) {
 		struct cinergyt2 *cinergyt2 = usb_get_intfdata (intf);
 
 		cinergyt2_suspend_rc(cinergyt2);
diff --git a/drivers/scsi/mesh.c b/drivers/scsi/mesh.c
index 592b52a..683fc7a 100644
--- a/drivers/scsi/mesh.c
+++ b/drivers/scsi/mesh.c
@@ -1756,16 +1756,23 @@ static void set_mesh_power(struct mesh_s
 		pmac_call_feature(PMAC_FTR_MESH_ENABLE, macio_get_of_node(ms->mdev), 0, 0);
 		msleep(10);
 	}
-}			
+}
 
 
 #ifdef CONFIG_PM
-static int mesh_suspend(struct macio_dev *mdev, pm_message_t state)
+static int mesh_suspend(struct macio_dev *mdev, pm_message_t mesg)
 {
 	struct mesh_state *ms = (struct mesh_state *)macio_get_drvdata(mdev);
 	unsigned long flags;
 
-	if (state.event == mdev->ofdev.dev.power.power_state.event || state.event < 2)
+	switch (mesg.event) {
+	case PM_EVENT_SUSPEND:
+	case PM_EVENT_FREEZE:
+		break;
+	default:
+		return 0;
+	}
+	if (mesg.event == mdev->ofdev.dev.power.power_state.event)
 		return 0;
 
 	scsi_block_requests(ms->host);
@@ -1780,7 +1787,7 @@ static int mesh_suspend(struct macio_dev
 	disable_irq(ms->meshintr);
 	set_mesh_power(ms, 0);
 
-	mdev->ofdev.dev.power.power_state = state;
+	mdev->ofdev.dev.power.power_state = mesg;
 
 	return 0;
 }
-- 
1.4.2.1

