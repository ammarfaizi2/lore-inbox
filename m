Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265849AbUA1FWP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 00:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265860AbUA1FWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 00:22:14 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:9659 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265849AbUA1FVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 00:21:41 -0500
Subject: [PATCH] locks on pcnet32 watchdog timer
From: chinmay albal <albal@in.ibm.com>
To: linux-net <linux-net@vger.kernel.org>
Cc: tsbogend <tsbogend@alpha.franken.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1075267496.4113.11.camel@gprix.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 28 Jan 2004 10:54:56 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We sometimes receive a "Bus master arbitration failure, status ffff" 
error on pcnet32 drivers while running a huge network load on a 2.6.x 
kernel. Applying spinlocks on the watchdog timer routine helps getting 
across the problem. A patch for the same is given below.

This patch has been created on 2.6.2-rc1 and tested on an SMP system on
IA32 platform.

Please cc me.

-------------------------------8<--------------------------------------

--- pcnet32-orig.c	2004-01-28 10:43:04.000000000 +0530
+++ pcnet32.c	2004-01-28 10:45:00.000000000 +0530
@@ -1695,12 +1695,14 @@
 static void pcnet32_watchdog(struct net_device *dev)
 {
     struct pcnet32_private *lp = dev->priv;
-
+    unsigned long flags;
+    spin_lock_irqsave(&lp->lock, flags);
     /* Print the link status if it has changed */
     if (lp->mii)
 	mii_check_media (&lp->mii_if, 1, 0);
 
     mod_timer (&(lp->watchdog_timer), PCNET32_WATCHDOG_TIMEOUT);
+    spin_unlock_irqrestore(&lp->lock, flags);
 }
 
 static struct pci_driver pcnet32_driver = {

---------------------------------8<--------------------------------------

Regards,

Chinmay Albal
Linux Technology Centre,
IBM Software Labs, Bangalore,
mail - albal@in.ibm.com


