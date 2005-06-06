Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVFFXxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVFFXxI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 19:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVFFXQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:16:56 -0400
Received: from cantor2.suse.de ([195.135.220.15]:22498 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261696AbVFFWqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 18:46:47 -0400
Date: Tue, 7 Jun 2005 00:46:45 +0200
From: Karsten Keil <kkeil@suse.de>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix tulip suspend/resume
Message-ID: <20050606224645.GA23989@pingi3.kke.suse.de>
Mail-Followup-To: akpm@osdl.org, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.8-24.10-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

following patch fix the suspend/resume for tulip based
cards, so suspend on disk work now for me and tulip based
cardbus cards.


Signed-off-by: Karsten Keil <kkeil@suse.de>

--- linux/drivers/net/tulip/tulip_core.c.orig	2005-03-23 23:54:43.000000000 +0100
+++ linux/drivers/net/tulip/tulip_core.c	2005-05-26 17:29:14.000000000 +0200
@@ -1755,12 +1755,16 @@
 static int tulip_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
+	int err;
 
+	pci_save_state(pdev);
 	if (dev && netif_running (dev) && netif_device_present (dev)) {
 		netif_device_detach (dev);
 		tulip_down (dev);
 		/* pci_power_off(pdev, -1); */
 	}
+	if ((err = pci_set_power_state(pdev, PCI_D3hot)))
+		printk(KERN_ERR "%s: pci_set_power_state D3hot return %d\n", dev->name, err);
 	return 0;
 }
 
@@ -1768,7 +1772,11 @@
 static int tulip_resume(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
+	int err;
 
+	if ((err = pci_set_power_state(pdev, PCI_D0)))
+		printk(KERN_ERR "%s: pci_set_power_state D0 return %d\n", dev->name, err);
+	pci_restore_state(pdev);
 	if (dev && netif_running (dev) && !netif_device_present (dev)) {
 #if 1
 		pci_enable_device (pdev);

-- 
Karsten Keil
SuSE Labs
ISDN development
