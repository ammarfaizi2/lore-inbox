Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbTBOLI5>; Sat, 15 Feb 2003 06:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbTBOLI5>; Sat, 15 Feb 2003 06:08:57 -0500
Received: from mail5.bluewin.ch ([195.186.1.207]:21419 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id <S261599AbTBOLIr>;
	Sat, 15 Feb 2003 06:08:47 -0500
Date: Sat, 15 Feb 2003 12:18:25 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: [3/4][via-rhine][PATCH] Various duplex related fixes
Message-ID: <20030215111825.GA11541@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <20030215111705.GA11127@k3.hellgate.ch>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.60 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix the following bugs:
- after a watchdog timeout (still a common thing with the Rhine), the
  driver will fall back to half-duplex, ignoring the auto-negotiation
  results, killing performance completely until the driver is reloaded;
  fixed by clearing full_duplex in init_registers()
- driver considers only 0x200 for full-duplex option; now 0x220
- duplex code used dev->name before it's initialized; code section moved

The full_duplex and force_media related code is quite a mess, but this
minimal fix will make the most annoying problems go away. Looking at some
other code (e.g. mii.c) it seems to me the interaction between user force,
autoneg results and full_duplex/force_media is amazingly complex, so I'll
leave it at this for now.


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine-1.16rc-03_duplex.diff"

--- 02_underrun/drivers/net/via-rhine.c	Fri Feb 14 19:05:54 2003
+++ 03_duplex/drivers/net/via-rhine.c	Fri Feb 14 19:07:17 2003
@@ -726,21 +726,6 @@ static int __devinit via_rhine_init_one 
 	if (dev->mem_start)
 		option = dev->mem_start;
 
-	/* The lower four bits are the media type. */
-	if (option > 0) {
-		if (option & 0x200)
-			np->mii_if.full_duplex = 1;
-		np->default_port = option & 15;
-	}
-	if (card_idx < MAX_UNITS  &&  full_duplex[card_idx] > 0)
-		np->mii_if.full_duplex = 1;
-
-	if (np->mii_if.full_duplex) {
-		printk(KERN_INFO "%s: Set to forced full duplex, autonegotiation"
-			   " disabled.\n", dev->name);
-		np->mii_if.force_media = 1;
-	}
-
 	/* The chip-specific entries in the device structure. */
 	dev->open = via_rhine_open;
 	dev->hard_start_xmit = via_rhine_start_tx;
@@ -752,11 +737,27 @@ static int __devinit via_rhine_init_one 
 	dev->watchdog_timeo = TX_TIMEOUT;
 	if (np->drv_flags & ReqTxAlign)
 		dev->features |= NETIF_F_SG|NETIF_F_HW_CSUM;
-	
+
+	/* dev->name not defined before register_netdev()! */
 	i = register_netdev(dev);
 	if (i)
 		goto err_out_unmap;
 
+	/* The lower four bits are the media type. */
+	if (option > 0) {
+		if (option & 0x220)
+			np->mii_if.full_duplex = 1;
+		np->default_port = option & 15;
+	}
+	if (card_idx < MAX_UNITS  &&  full_duplex[card_idx] > 0)
+		np->mii_if.full_duplex = 1;
+
+	if (np->mii_if.full_duplex) {
+		printk(KERN_INFO "%s: Set to forced full duplex, autonegotiation"
+			   " disabled.\n", dev->name);
+		np->mii_if.force_media = 1;
+	}
+
 	printk(KERN_INFO "%s: %s at 0x%lx, ",
 		   dev->name, via_rhine_chip_info[chip_id].name,
 		   (pci_flags & PCI_USES_IO) ? ioaddr : memaddr);
@@ -992,6 +993,7 @@ static void init_registers(struct net_de
 	writeb(0x20, ioaddr + TxConfig);
 	np->tx_thresh = 0x20;
 	np->rx_thresh = 0x60;			/* Written in via_rhine_set_rx_mode(). */
+	np->mii_if.full_duplex = 0;
 
 	if (dev->if_port == 0)
 		dev->if_port = np->default_port;

--SUOF0GtieIMvvwua--
