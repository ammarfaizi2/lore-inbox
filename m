Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbUDZV5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUDZV5V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 17:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263599AbUDZV5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 17:57:21 -0400
Received: from mini.brewt.org ([64.180.111.212]:21770 "HELO mini.brewt.org")
	by vger.kernel.org with SMTP id S261396AbUDZV5U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 17:57:20 -0400
Date: Mon, 26 Apr 2004 14:57:17 -0700
From: "Adrian Yee" <adrian@gossamer-threads.com>
Subject: Re: [PATCH] 8139too not running s3 suspend/resume pci fix
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <GMail.1083016637.119257660.12741365653@brewt.org>
In-Reply-To: <408D5E59.1090009@terra.com.br>
Mime-Version: 1.0
References: <408D5E59.1090009@terra.com.br>
X-Gmail-Account: brewt@brewt.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

> 	IMHO, there's no problem in doing "pci_save_state (pdev, 
> tp->pci_state)" before the suspend code..but I'm more confortable with 
> leaving the set_power_state at the end of that path, since if the 
> interface is down, we don't want to leave it in cold state.

That makes sense.  So something more like this:

--- drivers/net/8139too.c.orig  2004-04-26 14:53:04.715985134 -0700
+++ drivers/net/8139too.c       2004-04-26 14:53:50.373431714 -0700
@@ -2550,6 +2550,8 @@ static int rtl8139_suspend (struct pci_d
        void *ioaddr = tp->mmio_addr;
        unsigned long flags;
 
+       pci_save_state (pdev, tp->pci_state);
+
        if (!netif_running (dev))
                return 0;
 
@@ -2568,7 +2570,6 @@ static int rtl8139_suspend (struct pci_d
        spin_unlock_irqrestore (&tp->lock, flags);
 
        pci_set_power_state (pdev, 3);
-       pci_save_state (pdev, tp->pci_state);
 
        return 0;
 }
@@ -2579,9 +2580,9 @@ static int rtl8139_resume (struct pci_de
        struct net_device *dev = pci_get_drvdata (pdev);
        struct rtl8139_private *tp = dev->priv;
 
+       pci_restore_state (pdev, tp->pci_state);
        if (!netif_running (dev))
                return 0;
-       pci_restore_state (pdev, tp->pci_state);
        pci_set_power_state (pdev, 0);
        rtl8139_init_ring (dev);
        rtl8139_hw_start (dev);
