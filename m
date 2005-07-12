Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbVGLXL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVGLXL4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 19:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbVGLXLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 19:11:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58817 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262491AbVGLXLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 19:11:18 -0400
Date: Wed, 13 Jul 2005 01:10:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: [patch] more u32 vs. pm_message_t fixes
Message-ID: <20050712231042.GE2184@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nigel Cunningham <ncunningham@cyclades.com>

More fixes for u32 vs. pm_message_t confusion. These are simple
cleanups, should not break anything.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit b3fd9d8ecd37793e8b31300f6e718d1ca3354c07
tree 45bd7eacd8a341a819bd75b75bcdc2179e987201
parent 3e58f282f71020798aa5139059c9902adb03bb19
author <pavel@amd.(none)> Wed, 13 Jul 2005 01:09:55 +0200
committer <pavel@amd.(none)> Wed, 13 Jul 2005 01:09:55 +0200

 arch/ppc/platforms/pmac_pic.c |    2 +-
 arch/ppc/syslib/open_pic.c    |    2 +-
 drivers/ide/ppc/pmac.c        |    8 ++++----
 sound/pci/atiixp.c            |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/ppc/platforms/pmac_pic.c b/arch/ppc/platforms/pmac_pic.c
--- a/arch/ppc/platforms/pmac_pic.c
+++ b/arch/ppc/platforms/pmac_pic.c
@@ -619,7 +619,7 @@ not_found:
 	return viaint;
 }
 
-static int pmacpic_suspend(struct sys_device *sysdev, u32 state)
+static int pmacpic_suspend(struct sys_device *sysdev, pm_message_t state)
 {
 	int viaint = pmacpic_find_viaint();
 
diff --git a/arch/ppc/syslib/open_pic.c b/arch/ppc/syslib/open_pic.c
--- a/arch/ppc/syslib/open_pic.c
+++ b/arch/ppc/syslib/open_pic.c
@@ -948,7 +948,7 @@ static void openpic_cached_disable_irq(u
  * we need something better to deal with that... Maybe switch to S1 for
  * cpufreq changes
  */
-int openpic_suspend(struct sys_device *sysdev, u32 state)
+int openpic_suspend(struct sys_device *sysdev, pm_message_t state)
 {
 	int	i;
 	unsigned long flags;
diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1504,7 +1504,7 @@ pmac_ide_macio_attach(struct macio_dev *
 }
 
 static int
-pmac_ide_macio_suspend(struct macio_dev *mdev, u32 state)
+pmac_ide_macio_suspend(struct macio_dev *mdev, pm_message_t state)
 {
 	ide_hwif_t	*hwif = (ide_hwif_t *)dev_get_drvdata(&mdev->ofdev.dev);
 	int		rc = 0;
@@ -1527,7 +1527,7 @@ pmac_ide_macio_resume(struct macio_dev *
 	if (mdev->ofdev.dev.power.power_state != 0) {
 		rc = pmac_ide_do_resume(hwif);
 		if (rc == 0)
-			mdev->ofdev.dev.power.power_state = 0;
+			mdev->ofdev.dev.power.power_state = PMSG_ON;
 	}
 
 	return rc;
@@ -1608,7 +1608,7 @@ pmac_ide_pci_attach(struct pci_dev *pdev
 }
 
 static int
-pmac_ide_pci_suspend(struct pci_dev *pdev, u32 state)
+pmac_ide_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	ide_hwif_t	*hwif = (ide_hwif_t *)pci_get_drvdata(pdev);
 	int		rc = 0;
@@ -1631,7 +1631,7 @@ pmac_ide_pci_resume(struct pci_dev *pdev
 	if (pdev->dev.power.power_state != 0) {
 		rc = pmac_ide_do_resume(hwif);
 		if (rc == 0)
-			pdev->dev.power.power_state = 0;
+			pdev->dev.power.power_state = PMSG_ON;
 	}
 
 	return rc;
diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -1419,7 +1419,7 @@ static int snd_atiixp_suspend(snd_card_t
 	snd_atiixp_aclink_down(chip);
 	snd_atiixp_chip_stop(chip);
 
-	pci_set_power_state(chip->pci, 3);
+	pci_set_power_state(chip->pci, PCI_D3hot);
 	pci_disable_device(chip->pci);
 	return 0;
 }
@@ -1430,7 +1430,7 @@ static int snd_atiixp_resume(snd_card_t 
 	int i;
 
 	pci_enable_device(chip->pci);
-	pci_set_power_state(chip->pci, 0);
+	pci_set_power_state(chip->pci, PCI_D0);
 	pci_set_master(chip->pci);
 
 	snd_atiixp_aclink_reset(chip);

-- 
teflon -- maybe it is a trademark, but it should not be.
