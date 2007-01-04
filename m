Return-Path: <linux-kernel-owner+w=401wt.eu-S964825AbXADMt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbXADMt4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 07:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbXADMt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 07:49:56 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40199 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964825AbXADMtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 07:49:55 -0500
Message-ID: <459CF7F7.90507@drzeus.cx>
Date: Thu, 04 Jan 2007 13:49:59 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MMC updates
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

        git://git.kernel.org/pub/scm/linux/kernel/git/drzeus/mmc.git for-linus

to receive the following updates:

 drivers/mmc/at91_mci.c |   11 +++++------
 drivers/mmc/omap.c     |    6 +++---
 2 files changed, 8 insertions(+), 9 deletions(-)

David Brownell (1):
      MMC: at91 mmc linkage updates

Kyungmin Park (1):
      ARM: OMAP: fix MMC workqueue changes

diff --git a/drivers/mmc/at91_mci.c b/drivers/mmc/at91_mci.c
index 08a33c3..aa152f3 100644
--- a/drivers/mmc/at91_mci.c
+++ b/drivers/mmc/at91_mci.c
@@ -768,7 +768,7 @@ static irqreturn_t at91_mmc_det_irq(int irq, void *_host)
        return IRQ_HANDLED;
 }

-int at91_mci_get_ro(struct mmc_host *mmc)
+static int at91_mci_get_ro(struct mmc_host *mmc)
 {
        int read_only = 0;
        struct at91mci_host *host = mmc_priv(mmc);
@@ -794,7 +794,7 @@ static const struct mmc_host_ops at91_mci_ops = {
 /*
  * Probe for the device
  */
-static int at91_mci_probe(struct platform_device *pdev)
+static int __init at91_mci_probe(struct platform_device *pdev)
 {
        struct mmc_host *mmc;
        struct at91mci_host *host;
@@ -910,7 +910,7 @@ static int at91_mci_probe(struct platform_device *pdev)
 /*
  * Remove a device
  */
-static int at91_mci_remove(struct platform_device *pdev)
+static int __exit at91_mci_remove(struct platform_device *pdev)
 {
        struct mmc_host *mmc = platform_get_drvdata(pdev);
        struct at91mci_host *host;
@@ -972,8 +972,7 @@ static int at91_mci_resume(struct platform_device *pdev)
 #endif

 static struct platform_driver at91_mci_driver = {
-       .probe          = at91_mci_probe,
-       .remove         = at91_mci_remove,
+       .remove         = __exit_p(at91_mci_remove),
        .suspend        = at91_mci_suspend,
        .resume         = at91_mci_resume,
        .driver         = {
@@ -984,7 +983,7 @@ static struct platform_driver at91_mci_driver = {

 static int __init at91_mci_init(void)
 {
-       return platform_driver_register(&at91_mci_driver);
+       return platform_driver_probe(&at91_mci_driver, at91_mci_probe);
 }

 static void __exit at91_mci_exit(void)
diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
index 435d331..9488408 100644
--- a/drivers/mmc/omap.c
+++ b/drivers/mmc/omap.c
@@ -581,9 +581,9 @@ static void mmc_omap_switch_timer(unsigned long arg)
        schedule_work(&host->switch_work);
 }

-static void mmc_omap_switch_handler(void *data)
+static void mmc_omap_switch_handler(struct work_struct *work)
 {
-       struct mmc_omap_host *host = (struct mmc_omap_host *) data;
+       struct mmc_omap_host *host = container_of(work, struct mmc_omap_host, switch_work);
        struct mmc_card *card;
        static int complained = 0;
        int cards = 0, cover_open;
@@ -1116,7 +1116,7 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
        platform_set_drvdata(pdev, host);

        if (host->switch_pin >= 0) {
-               INIT_WORK(&host->switch_work, mmc_omap_switch_handler, host);
+               INIT_WORK(&host->switch_work, mmc_omap_switch_handler);
                init_timer(&host->switch_timer);
                host->switch_timer.function = mmc_omap_switch_timer;
                host->switch_timer.data = (unsigned long) host;

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
