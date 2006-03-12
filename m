Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWCLVVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWCLVVt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 16:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWCLVVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 16:21:48 -0500
Received: from cassiel.sirena.org.uk ([80.68.93.111]:29450 "EHLO
	cassiel.sirena.org.uk") by vger.kernel.org with ESMTP
	id S1750893AbWCLVVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 16:21:47 -0500
Message-Id: <20060312205304.558799000@mercator.sirena.org.uk>
References: <20060312192259.929734000@mercator.sirena.org.uk>
Date: Sun, 12 Mar 2006 19:23:01 +0000
From: Mark Brown <broonie@sirena.org.uk>
To: Tim Hockin <thockin@hockin.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 2/4] natsemi: Support oversized EEPROMs
Content-Disposition: inline; filename=natsemi-variable-eeprom-size.patch
X-Spam-Score: -2.5 (--)
X-Spam-Report: Spam detection software, running on the system "cassiel.sirena.org.uk", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  The natsemi chip can have a larger EEPROM attached than
	it itself uses for configuration. This patch adds support for user
	space access to such an EEPROM. Signed-off-by: Mark Brown
	<broonie@sirena.org.uk> [...] 
	Content analysis details:   (-2.5 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The natsemi chip can have a larger EEPROM attached than it itself uses
for configuration.  This patch adds support for user space access
to such an EEPROM.

Signed-off-by: Mark Brown <broonie@sirena.org.uk>

Index: natsemi-queue/drivers/net/natsemi.c
===================================================================
--- natsemi-queue.orig/drivers/net/natsemi.c	2006-02-25 17:40:15.000000000 +0000
+++ natsemi-queue/drivers/net/natsemi.c	2006-02-25 17:40:39.000000000 +0000
@@ -226,7 +226,7 @@ static int full_duplex[MAX_UNITS];
 				 NATSEMI_PG1_NREGS)
 #define NATSEMI_REGS_VER	1 /* v1 added RFDR registers */
 #define NATSEMI_REGS_SIZE	(NATSEMI_NREGS * sizeof(u32))
-#define NATSEMI_EEPROM_SIZE	24 /* 12 16-bit values */
+#define NATSEMI_DEF_EEPROM_SIZE	24 /* 12 16-bit values */
 
 /* Buffer sizes:
  * The nic writes 32-bit values, even if the upper bytes of
@@ -716,6 +716,8 @@ struct netdev_private {
 	unsigned int iosize;
 	spinlock_t lock;
 	u32 msg_enable;
+	/* EEPROM data */
+	int eeprom_size;
 };
 
 static void move_int_phy(struct net_device *dev, int addr);
@@ -892,6 +894,7 @@ static int __devinit natsemi_probe1 (str
 	np->msg_enable = (debug >= 0) ? (1<<debug)-1 : NATSEMI_DEF_MSG;
 	np->hands_off = 0;
 	np->intr_status = 0;
+	np->eeprom_size = NATSEMI_DEF_EEPROM_SIZE;
 
 	option = find_cnt < MAX_UNITS ? options[find_cnt] : 0;
 	if (dev->mem_start)
@@ -2601,7 +2604,8 @@ static int get_regs_len(struct net_devic
 
 static int get_eeprom_len(struct net_device *dev)
 {
-	return NATSEMI_EEPROM_SIZE;
+	struct netdev_private *np = netdev_priv(dev);
+	return np->eeprom_size;
 }
 
 static int get_settings(struct net_device *dev, struct ethtool_cmd *ecmd)
@@ -2688,15 +2692,20 @@ static u32 get_link(struct net_device *d
 static int get_eeprom(struct net_device *dev, struct ethtool_eeprom *eeprom, u8 *data)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	u8 eebuf[NATSEMI_EEPROM_SIZE];
+	u8 *eebuf;
 	int res;
 
+	eebuf = kmalloc(np->eeprom_size, GFP_KERNEL);
+	if (!eebuf)
+		return -ENOMEM;
+
 	eeprom->magic = PCI_VENDOR_ID_NS | (PCI_DEVICE_ID_NS_83815<<16);
 	spin_lock_irq(&np->lock);
 	res = netdev_get_eeprom(dev, eebuf);
 	spin_unlock_irq(&np->lock);
 	if (!res)
 		memcpy(data, eebuf+eeprom->offset, eeprom->len);
+	kfree(eebuf);
 	return res;
 }
 
@@ -3062,9 +3071,10 @@ static int netdev_get_eeprom(struct net_
 	int i;
 	u16 *ebuf = (u16 *)buf;
 	void __iomem * ioaddr = ns_ioaddr(dev);
+	struct netdev_private *np = netdev_priv(dev);
 
 	/* eeprom_read reads 16 bits, and indexes by 16 bits */
-	for (i = 0; i < NATSEMI_EEPROM_SIZE/2; i++) {
+	for (i = 0; i < np->eeprom_size/2; i++) {
 		ebuf[i] = eeprom_read(ioaddr, i);
 		/* The EEPROM itself stores data bit-swapped, but eeprom_read
 		 * reads it back "sanely". So we swap it back here in order to

--
"You grabbed my hand and we fell into it, like a daydream - or a fever."
