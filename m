Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318251AbSG3Muy>; Tue, 30 Jul 2002 08:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318252AbSG3Muy>; Tue, 30 Jul 2002 08:50:54 -0400
Received: from 4-249.ctame701-3.telepar.net.br ([200.193.150.249]:22771 "EHLO
	matthew.cathedral.com") by vger.kernel.org with ESMTP
	id <S318251AbSG3Muv>; Tue, 30 Jul 2002 08:50:51 -0400
Date: Tue, 30 Jul 2002 09:56:01 -0300
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Michael Westermann <mw@microdata-pos.de>
Subject: [PATCH] eepro 0.13a
Message-ID: <20020730125601.GT16077@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

these changes was sent by Michael Westermann.

changelog:

* in memory shortage, drop the packet also in board
* remove KERN_ macros in printk calls that doesn't start a new line

-- 
aris

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="eepro-2.2-0.13a.diff"

--- linux-2.2.21/drivers/net/eepro.c.old	Tue Jul 30 09:27:55 2002
+++ linux-2.2.21/drivers/net/eepro.c	Tue Jul 30 09:32:48 2002
@@ -23,6 +23,8 @@
 	This is a compatibility hardware problem.
 
 	Versions:
+	0.13a	in memory shortage, drop packets also in board
+		(Michael Westermann <mw@microdata-pos.de>, 07/30/2002)
 	0.13	irq sharing, rewrote probe function, fixed a nasty bug in
 		hardware_send_packet and a major cleanup (aris, 11/08/2001)
 	0.12d	tottaly isolated old code to new code (blue cards).
@@ -633,37 +633,37 @@
 
 	i = inb(dev->base_addr + ID_REG);
 	printk(KERN_DEBUG " id: %#x ",i);
-	printk(KERN_DEBUG " io: %#x ", (unsigned)dev->base_addr);
+	printk(" io: %#x ", (unsigned)dev->base_addr);
 
 	switch (lp->eepro) {
 		case LAN595FX_10ISA:
-			printk(KERN_INFO "%s: Intel EtherExpress 10 ISA\n at %#x,",
+			printk("%s: Intel EtherExpress 10 ISA\n at %#x,",
 					dev->name, (unsigned)dev->base_addr);
 			break;
 		case LAN595FX:
-			printk(KERN_INFO "%s: Intel EtherExpress Pro/10+ ISA\n at %#x,", 
+			printk("%s: Intel EtherExpress Pro/10+ ISA\n at %#x,", 
 					dev->name, (unsigned)dev->base_addr);
 			break;
 		case LAN595TX:
-			printk(KERN_INFO "%s: Intel EtherExpress Pro/10 ISA at %#x,",
+			printk("%s: Intel EtherExpress Pro/10 ISA at %#x,",
 					dev->name, (unsigned)dev->base_addr);
 			break;
 		case LAN595:
-			printk(KERN_INFO "%s: Intel 82595-based lan card at %#x,", 
+			printk("%s: Intel 82595-based lan card at %#x,", 
 					dev->name, (unsigned)dev->base_addr);
 	}
 
 	for (i=0; i < 6; i++)
-		printk(KERN_INFO "%c%02x", i ? ':' : ' ', dev->dev_addr[i]);
+		printk("%c%02x", i ? ':' : ' ', dev->dev_addr[i]);
 
 	if (net_debug > 3)
 		printk(KERN_DEBUG ", %dK RCV buffer",
 				(int)(lp->rcv_ram)/1024);
 
 	if (dev->irq > 2)
-		printk(KERN_INFO ", IRQ %d, %s.\n", dev->irq, ifmap[dev->if_port]);
+		printk(", IRQ %d, %s.\n", dev->irq, ifmap[dev->if_port]);
 	else 
-		printk(KERN_INFO ", %s.\n", ifmap[dev->if_port]);
+		printk(", %s.\n", ifmap[dev->if_port]);
 
 	if (net_debug > 3) {
 		i = read_eeprom(dev->base_addr, 5, dev);
@@ -1548,6 +1550,10 @@
 			if (skb == NULL) {
 				printk(KERN_NOTICE "%s: Memory squeeze, dropping packet.\n", dev->name);
 				lp->stats.rx_dropped++;
+				rcv_car = lp->rx_start + RCV_HEADER + rcv_size;
+				lp->rx_start = rcv_next_frame;
+				outw(rcv_next_frame, ioaddr + HOST_ADDRESS_REG);
+
 				break;
 			}
 			skb->dev = dev;

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="eepro-2.4-0.13a.diff"

--- linux-2.4.19-pre/drivers/net/eepro.c.old	Tue Jul 30 09:36:08 2002
+++ linux-2.4.19-pre/drivers/net/eepro.c	Tue Jul 30 09:34:54 2002
@@ -23,6 +23,8 @@
 	This is a compatibility hardware problem.
 
 	Versions:
+ 	0.13a	in memory shortage, drop packets also in board
+ 		(Michael Westermann <mw@microdata-pos.de>, 07/30/2002)
 	0.13    irq sharing, rewrote probe function, fixed a nasty bug in
 		hardware_send_packet and a major cleanup (aris, 11/08/2001)
 	0.12d	fixing a problem with single card detected as eight eth devices
@@ -633,37 +633,37 @@
 
 	i = inb(dev->base_addr + ID_REG);
 	printk(KERN_DEBUG " id: %#x ",i);
-	printk(KERN_DEBUG " io: %#x ", (unsigned)dev->base_addr);
+	printk(" io: %#x ", (unsigned)dev->base_addr);
 
 	switch (lp->eepro) {
 		case LAN595FX_10ISA:
-			printk(KERN_INFO "%s: Intel EtherExpress 10 ISA\n at %#x,",
+			printk("%s: Intel EtherExpress 10 ISA\n at %#x,",
 					dev->name, (unsigned)dev->base_addr);
 			break;
 		case LAN595FX:
-			printk(KERN_INFO "%s: Intel EtherExpress Pro/10+ ISA\n at %#x,", 
+			printk("%s: Intel EtherExpress Pro/10+ ISA\n at %#x,", 
 					dev->name, (unsigned)dev->base_addr);
 			break;
 		case LAN595TX:
-			printk(KERN_INFO "%s: Intel EtherExpress Pro/10 ISA at %#x,",
+			printk("%s: Intel EtherExpress Pro/10 ISA at %#x,",
 					dev->name, (unsigned)dev->base_addr);
 			break;
 		case LAN595:
-			printk(KERN_INFO "%s: Intel 82595-based lan card at %#x,", 
+			printk("%s: Intel 82595-based lan card at %#x,", 
 					dev->name, (unsigned)dev->base_addr);
 	}
 
 	for (i=0; i < 6; i++)
-		printk(KERN_INFO "%c%02x", i ? ':' : ' ', dev->dev_addr[i]);
+		printk("%c%02x", i ? ':' : ' ', dev->dev_addr[i]);
 
 	if (net_debug > 3)
 		printk(KERN_DEBUG ", %dK RCV buffer",
 				(int)(lp->rcv_ram)/1024);
 
 	if (dev->irq > 2)
-		printk(KERN_INFO ", IRQ %d, %s.\n", dev->irq, ifmap[dev->if_port]);
+		printk(", IRQ %d, %s.\n", dev->irq, ifmap[dev->if_port]);
 	else 
-		printk(KERN_INFO ", %s.\n", ifmap[dev->if_port]);
+		printk(", %s.\n", ifmap[dev->if_port]);
 
 	if (net_debug > 3) {
 		i = read_eeprom(dev->base_addr, 5, dev);
@@ -1578,6 +1580,10 @@
 			if (skb == NULL) {
 				printk(KERN_NOTICE "%s: Memory squeeze, dropping packet.\n", dev->name);
 				lp->stats.rx_dropped++;
+				rcv_car = lp->rx_start + RCV_HEADER + rcv_size;
+				lp->rx_start = rcv_next_frame;
+				outw(rcv_next_frame, ioaddr + HOST_ADDRESS_REG);
+
 				break;
 			}
 			skb->dev = dev;

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="eepro-2.5-0.13a.diff"

--- linux-2.5.26/drivers/net/eepro.c.orig	Tue Jul 16 20:49:36 2002
+++ linux-2.5.26/drivers/net/eepro.c	Tue Jul 30 09:37:00 2002
@@ -23,6 +23,8 @@
 	This is a compatibility hardware problem.
 
 	Versions:
+ 	0.13a	in memory shortage, drop packets also in board
+ 		(Michael Westermann <mw@microdata-pos.de>, 07/30/2002)
 	0.13    irq sharing, rewrote probe function, fixed a nasty bug in
 		hardware_send_packet and a major cleanup (aris, 11/08/2001)
 	0.12d	fixing a problem with single card detected as eight eth devices
@@ -633,37 +633,37 @@
 
 	i = inb(dev->base_addr + ID_REG);
 	printk(KERN_DEBUG " id: %#x ",i);
-	printk(KERN_DEBUG " io: %#x ", (unsigned)dev->base_addr);
+	printk(" io: %#x ", (unsigned)dev->base_addr);
 
 	switch (lp->eepro) {
 		case LAN595FX_10ISA:
-			printk(KERN_INFO "%s: Intel EtherExpress 10 ISA\n at %#x,",
+			printk("%s: Intel EtherExpress 10 ISA\n at %#x,",
 					dev->name, (unsigned)dev->base_addr);
 			break;
 		case LAN595FX:
-			printk(KERN_INFO "%s: Intel EtherExpress Pro/10+ ISA\n at %#x,", 
+			printk("%s: Intel EtherExpress Pro/10+ ISA\n at %#x,", 
 					dev->name, (unsigned)dev->base_addr);
 			break;
 		case LAN595TX:
-			printk(KERN_INFO "%s: Intel EtherExpress Pro/10 ISA at %#x,",
+			printk("%s: Intel EtherExpress Pro/10 ISA at %#x,",
 					dev->name, (unsigned)dev->base_addr);
 			break;
 		case LAN595:
-			printk(KERN_INFO "%s: Intel 82595-based lan card at %#x,", 
+			printk("%s: Intel 82595-based lan card at %#x,", 
 					dev->name, (unsigned)dev->base_addr);
 	}
 
 	for (i=0; i < 6; i++)
-		printk(KERN_INFO "%c%02x", i ? ':' : ' ', dev->dev_addr[i]);
+		printk("%c%02x", i ? ':' : ' ', dev->dev_addr[i]);
 
 	if (net_debug > 3)
 		printk(KERN_DEBUG ", %dK RCV buffer",
 				(int)(lp->rcv_ram)/1024);
 
 	if (dev->irq > 2)
-		printk(KERN_INFO ", IRQ %d, %s.\n", dev->irq, ifmap[dev->if_port]);
+		printk(", IRQ %d, %s.\n", dev->irq, ifmap[dev->if_port]);
 	else 
-		printk(KERN_INFO ", %s.\n", ifmap[dev->if_port]);
+		printk(", %s.\n", ifmap[dev->if_port]);
 
 	if (net_debug > 3) {
 		i = read_eeprom(dev->base_addr, 5, dev);
@@ -1584,6 +1586,10 @@
 			if (skb == NULL) {
 				printk(KERN_NOTICE "%s: Memory squeeze, dropping packet.\n", dev->name);
 				lp->stats.rx_dropped++;
+				rcv_car = lp->rx_start + RCV_HEADER + rcv_size;
+				lp->rx_start = rcv_next_frame;
+				outw(rcv_next_frame, ioaddr + HOST_ADDRESS_REG);
+
 				break;
 			}
 			skb->dev = dev;

--Nq2Wo0NMKNjxTN9z--
