Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263588AbUDZFuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263588AbUDZFuI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 01:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264441AbUDZFuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 01:50:07 -0400
Received: from mini.brewt.org ([64.180.111.212]:19466 "HELO mini.brewt.org")
	by vger.kernel.org with SMTP id S263588AbUDZFuC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 01:50:02 -0400
Date: Sun, 25 Apr 2004 22:49:59 -0700
From: "Adrian Yee" <brewt-linux-kernel@brewt.org>
Subject: [PATCH] 8139too not running s3 suspend/resume pci fix
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <GMail.1082958599.119234554.04321010111@brewt.org>
Mime-Version: 1.0
X-Gmail-Account: brewt@brewt.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having an 8139 based device in my notebook, I often switch between it and wireless.  The problem is that the 8139too driver does not save/restore the pci configuration of the card if the device isn't running.  This simple patch moves the save/restore code so that the code runs regardless of whether or not the device is running.

I looked at other drivers and they all seem to do the same thing.  Is there a reason why this isn't done like in the patch?

Adrian

--- drivers/net/8139too.c.orig	2004-04-25 21:56:21.000000000 -0700
+++ drivers/net/8139too.c	2004-04-25 22:02:14.000000000 -0700
@@ -2554,6 +2554,9 @@ static int rtl8139_suspend (struct pci_d
 	void *ioaddr = tp->mmio_addr;
 	unsigned long flags;
 
+	pci_set_power_state (pdev, 3);
+	pci_save_state (pdev, tp->pci_state);
+
 	if (!netif_running (dev))
 		return 0;
 
@@ -2571,9 +2574,6 @@ static int rtl8139_suspend (struct pci_d
 
 	spin_unlock_irqrestore (&tp->lock, flags);
 
-	pci_set_power_state (pdev, 3);
-	pci_save_state (pdev, tp->pci_state);
-
 	return 0;
 }
 
@@ -2583,10 +2583,10 @@ static int rtl8139_resume (struct pci_de
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct rtl8139_private *tp = dev->priv;
 
-	if (!netif_running (dev))
-		return 0;
 	pci_restore_state (pdev, tp->pci_state);
 	pci_set_power_state (pdev, 0);
+	if (!netif_running (dev))
+		return 0;
 	rtl8139_init_ring (dev);
 	rtl8139_hw_start (dev);
 	netif_device_attach (dev);
