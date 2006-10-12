Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWJLWTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWJLWTs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 18:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWJLWTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 18:19:48 -0400
Received: from twin.jikos.cz ([213.151.79.26]:7119 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751201AbWJLWTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 18:19:47 -0400
Date: Fri, 13 Oct 2006 00:17:50 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: mlindner@syskonnect.de, rroesler@syskonnect.de,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>
cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] sk98lin: handle pci_enable_device() return value in
 skge_resume() properly
Message-ID: <Pine.LNX.4.64.0610130002320.29022@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] sk98lin: handle pci_enable_device() return value in skge_resume() properly

Fix missing handling of pci_enable_device() return value in skge_resume() 

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

--- 

 drivers/net/sk98lin/skge.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/net/sk98lin/skge.c b/drivers/net/sk98lin/skge.c
index 99e9262..e12fb62 100644
--- a/drivers/net/sk98lin/skge.c
+++ b/drivers/net/sk98lin/skge.c
@@ -5070,7 +5070,11 @@ static int skge_resume(struct pci_dev *p
 
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
-	pci_enable_device(pdev);
+	if ((ret = pci_enable_device(pdev))) {
+		printk(KERN_ERR "sk98lin: Cannot enable PCI device during resume\n");
+		unregister_netdev(dev);
+		return ret;
+	}
 	pci_set_master(pdev);
 	if (pAC->GIni.GIMacsFound == 2)
 		ret = request_irq(dev->irq, SkGeIsr, IRQF_SHARED, "sk98lin", dev);

-- 
Jiri Kosina
