Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVCFXrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVCFXrB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 18:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVCFXrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 18:47:00 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36882 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261530AbVCFWlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:41:21 -0500
Date: Sun, 6 Mar 2005 22:41:13 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hendrik Hoeth <hendrik.hoeth@cern.ch>
Cc: linux-kernel@vger.kernel.org, linux@brodo.de
Subject: Re: serial CardBus card does not wake up after sleep
Message-ID: <20050306224112.C3834@flint.arm.linux.org.uk>
Mail-Followup-To: Hendrik Hoeth <hendrik.hoeth@cern.ch>,
	linux-kernel@vger.kernel.org, linux@brodo.de
References: <20050306200946.GD3101@mail.physik.uni-wuppertal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050306200946.GD3101@mail.physik.uni-wuppertal.de>; from hendrik.hoeth@cern.ch on Sun, Mar 06, 2005 at 02:09:46PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 02:09:46PM -0600, Hendrik Hoeth wrote:
> I'm using a serial CardBus card (Sony Ericsson GC79 -- combined GPRS and
> WiFi, I'm talking about the GPRS modem part of it) in a Samsung P35
> laptop, kernel version 2.6.11. If I put the laptop in S3 leaving the
> card in the laptop, the card does not wake up on resume. I need to
> remove and reinsert the card.

Looks like the card wasn't resumed properly.  Please try this patch:

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/drivers/serial/8250_pci.c linux/drivers/serial/8250_pci.c
--- orig/drivers/serial/8250_pci.c	Wed Mar  2 14:40:16 2005
+++ linux/drivers/serial/8250_pci.c	Sun Mar  6 22:38:46 2005
@@ -1759,7 +1759,7 @@ static void __devexit pciserial_remove_o
 	}
 }
 
-static int pciserial_suspend_one(struct pci_dev *dev, u32 state)
+static int pciserial_suspend_one(struct pci_dev *dev, pm_message_t state)
 {
 	struct serial_private *priv = pci_get_drvdata(dev);
 
@@ -1769,6 +1769,8 @@ static int pciserial_suspend_one(struct 
 		for (i = 0; i < priv->nr; i++)
 			serial8250_suspend_port(priv->line[i]);
 	}
+	pci_save_state(dev);
+	pci_set_power_state(dev, pci_choose_state(dev, state));
 	return 0;
 }
 
@@ -1776,10 +1778,18 @@ static int pciserial_resume_one(struct p
 {
 	struct serial_private *priv = pci_get_drvdata(dev);
 
+	pci_set_power_state(dev, PCI_D0);
+	pci_restore_state(dev);
+
 	if (priv) {
 		int i;
 
 		/*
+		 * The device may have been disabled.  Re-enable it.
+		 */
+		pci_enable_device(dev);
+
+		/*
 		 * Ensure that the board is correctly configured.
 		 */
 		if (priv->quirk->init)


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
