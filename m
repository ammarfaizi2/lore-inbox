Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbTANSg3>; Tue, 14 Jan 2003 13:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264944AbTANSg3>; Tue, 14 Jan 2003 13:36:29 -0500
Received: from adsl-173-18.barak.net.il ([62.90.173.18]:10368 "EHLO
	laptop.slamail.org") by vger.kernel.org with ESMTP
	id <S264940AbTANSg2>; Tue, 14 Jan 2003 13:36:28 -0500
Message-ID: <3E24595A.7040801@slamail.org>
Date: Tue, 14 Jan 2003 20:39:22 +0200
From: Yaacov Akiba Slama <ya@slamail.org>
Reply-To: Yaacov Akiba Slama <ya@slamail.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en, fr, he
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Re : [BUG] cardbus/hotplugging still broken in 2.5.56
Content-Type: multipart/mixed;
 boundary="------------000807030805010305030608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000807030805010305030608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello all !

I have a xircom (RBEM56G-100) lan+modem, and it seems that the following 
patch solves the problem of ressources collisions.
Now, I can use 2.5.58mm1 in my laptop and I am happy.

Yaacov Akiba Slama

--------------000807030805010305030608
Content-Type: text/plain;
 name="cardbus.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cardbus.patch"

--- a/drivers/pcmcia/cardbus.c	2003-01-14 19:38:49.000000000 +0200
+++ b/drivers/pcmcia/cardbus.c	2003-01-14 19:57:13.000000000 +0200
@@ -285,18 +285,19 @@
 		dev->dev.dma_mask = &dev->dma_mask;
 
 		pci_setup_device(dev);
-		if (pci_enable_device(dev))
-			continue;
 
 		strcpy(dev->dev.bus_id, dev->slot_name);
 
 		/* FIXME: Do we need to enable the expansion ROM? */
 		for (r = 0; r < 7; r++) {
 			struct resource *res = dev->resource + r;
-			if (res->flags)
+			if (!res->start && res->end)
 				pci_assign_resource(dev, r);
 		}
 
+		if (pci_enable_device(dev))
+			continue;
+
 		/* Does this function have an interrupt at all? */
 		pci_readb(dev, PCI_INTERRUPT_PIN, &irq_pin);
 		if (irq_pin) {

--------------000807030805010305030608--

