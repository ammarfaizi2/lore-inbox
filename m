Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318206AbSHDTLM>; Sun, 4 Aug 2002 15:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318208AbSHDTLM>; Sun, 4 Aug 2002 15:11:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40199 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318206AbSHDTLK>; Sun, 4 Aug 2002 15:11:10 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 2: 2.5.30-pcnet_cs
Message-Id: <E17bQpv-0001qH-00@flint.arm.linux.org.uk>
Date: Sun, 04 Aug 2002 20:14:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has been verified to apply cleanly to 2.5.30

This patch fixes a bug in handling the timeout in pcnet_cs.c, where
it uses the following test to determine whether the timeout has
expired:

        if (jiffies - dma_start > PCNET_RDC_TIMEOUT) {

Unfortunately, PCNET_RDC_TIMEOUT is defined to be "0x02", so the
length of the timeout is only two jiffy ticks, rather than being
the expected 20ms.  This patch fixes this.

Also, the above (and one other place) should be converted to
time_after().

 drivers/net/pcmcia/pcnet_cs.c |    6 +++---
 1 files changed, 3 insertions, 3 deletions

diff -ur orig/drivers/net/pcmcia/pcnet_cs.c linux/drivers/net/pcmcia/pcnet_cs.c
--- orig/drivers/net/pcmcia/pcnet_cs.c	Mon Apr 15 00:05:03 2002
+++ linux/drivers/net/pcmcia/pcnet_cs.c	Sun Aug  4 19:48:18 2002
@@ -64,7 +64,7 @@
 #define SOCKET_START_PG	0x01
 #define SOCKET_STOP_PG	0xff
 
-#define PCNET_RDC_TIMEOUT 0x02	/* Max wait in jiffies for Tx RDC */
+#define PCNET_RDC_TIMEOUT (2*HZ/100)	/* Max wait in jiffies for Tx RDC */
 
 static char *if_names[] = { "auto", "10baseT", "10base2"};
 
@@ -1183,7 +1183,7 @@
 	}
 	info->link_status = link;
     }
-    if (info->pna_phy && (jiffies - info->mii_reset > 6*HZ)) {
+    if (info->pna_phy && time_after(jiffies, info->mii_reset + 6*HZ)) {
 	link = mdio_read(mii_addr, info->eth_phy, 1) & 0x0004;
 	if (((info->phy_id == info->pna_phy) && link) ||
 	    ((info->phy_id != info->pna_phy) && !link)) {
@@ -1385,7 +1385,7 @@
 #endif
 
     while ((inb_p(nic_base + EN0_ISR) & ENISR_RDC) == 0)
-	if (jiffies - dma_start > PCNET_RDC_TIMEOUT) {
+	if (time_after(jiffies, dma_start + PCNET_RDC_TIMEOUT)) {
 	    printk(KERN_NOTICE "%s: timeout waiting for Tx RDC.\n",
 		   dev->name);
 	    pcnet_reset_8390(dev);
