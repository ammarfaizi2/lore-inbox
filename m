Return-Path: <linux-kernel-owner+w=401wt.eu-S964969AbXAJRNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbXAJRNr (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 12:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbXAJRNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 12:13:47 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:3489 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964969AbXAJRNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 12:13:46 -0500
To: linux-kernel@vger.kernel.org
CC: netdev@vger.kernel.org, jeff@garzik.org,
       Gary Zambrano <zambrano@broadcom.com>,
       Francois Romieu <romieu@fr.zoreil.com>
Subject: [PATCH] Broadcom 4400 resume small fix (v2)
From: Dmitriy Monakhov <dmonakhov@openvz.org>
Date: Wed, 10 Jan 2007 20:13:37 +0300
Message-ID: <87bql6ztxa.fsf@sw.ru>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Changes from v1:
- Fix according to Francois Romieu comments.

LOG:
Some issues in b44_resume().
- Return value of pci_enable_device() was ignored.
- If request_irq() has failed we have to just disable device and exit.

Signed-off-by: Dmitriy Monakhov <dmonakhov@openvz.org>
-------

--=-=-=
Content-Disposition: inline; filename=diff-ms-net-b44-resume-fix

diff --git a/drivers/net/b44.c b/drivers/net/b44.c
index 5eb2ec6..42c57bf 100644
--- a/drivers/net/b44.c
+++ b/drivers/net/b44.c
@@ -2315,16 +2315,27 @@ static int b44_resume(struct pci_dev *pd
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct b44 *bp = netdev_priv(dev);
+	int rc = 0;
 
 	pci_restore_state(pdev);
-	pci_enable_device(pdev);
+	rc = pci_enable_device(pdev);
+	if (rc) {
+		printk(KERN_ERR PFX "%s: pci_enable_device failed\n",
+			dev->name);
+		return rc;
+	}
+
 	pci_set_master(pdev);
 
 	if (!netif_running(dev))
 		return 0;
 
-	if (request_irq(dev->irq, b44_interrupt, IRQF_SHARED, dev->name, dev))
+	rc = request_irq(dev->irq, b44_interrupt, IRQF_SHARED, dev->name, dev);
+	if (rc) {
 		printk(KERN_ERR PFX "%s: request_irq failed\n", dev->name);
+		pci_disable_device(pdev);
+		return rc;
+	}
 
 	spin_lock_irq(&bp->lock);
 

--=-=-=--

