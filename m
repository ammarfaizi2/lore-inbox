Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbTBKCQU>; Mon, 10 Feb 2003 21:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbTBKCQT>; Mon, 10 Feb 2003 21:16:19 -0500
Received: from packet.digeo.com ([12.110.80.53]:57226 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265736AbTBKCQR>;
	Mon, 10 Feb 2003 21:16:17 -0500
Date: Mon, 10 Feb 2003 18:26:19 -0800
From: Andrew Morton <akpm@digeo.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: james.bottomley@steeleye.com, clem@clem.clem-digital.net,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.60 3c509 & net/Space.c problem
Message-Id: <20030210182619.3b6791cc.akpm@digeo.com>
In-Reply-To: <200302110144.CAA15199@kim.it.uu.se>
References: <200302110144.CAA15199@kim.it.uu.se>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Feb 2003 02:25:56.0858 (UTC) FILETIME=[E8997DA0:01C2D174]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
> >From Linus' 2.5.60 announcement:
> 
> >James Bottomley <james.bottomley@steeleye.com>:
> >  o 3c509 fixes: correct MCA probing, add back ISA probe to Space.c
> 
> This is somewhat broken. patch-2.5.60 has
> 
>

I'm looking for someone to pump some bytes through this fix.



Patch from Marc Zyngier <mzyngier@freesurf.fr>


 drivers/net/3c509.c |   66 +++++++++++++++++++++++++++++-----------------------
 drivers/net/Space.c |    3 --
 2 files changed, 37 insertions(+), 32 deletions(-)

diff -puN drivers/net/3c509.c~3c509 drivers/net/3c509.c
--- 25/drivers/net/3c509.c~3c509	Mon Feb 10 17:34:37 2003
+++ 25-akpm/drivers/net/3c509.c	Mon Feb 10 17:34:37 2003
@@ -338,16 +338,6 @@ static int __init el3_common_init (struc
 	dev->watchdog_timeo = TX_TIMEOUT;
 	dev->do_ioctl = netdev_ioctl;
 
-#ifdef CONFIG_PM
-	/* register power management */
-	lp->pmdev = pm_register(PM_ISA_DEV, card_idx, el3_pm_callback);
-	if (lp->pmdev) {
-		struct pm_dev *p;
-		p = lp->pmdev;
-		p->data = (struct net_device *)dev;
-	}
-#endif
-
 	return 0;
 }
 
@@ -417,6 +407,13 @@ static int __init el3_probe(int card_idx
 					phys_addr[j] =
 						htons(read_eeprom(ioaddr, j));
 			if_port = read_eeprom(ioaddr, 8) >> 14;
+			if (!(dev = init_etherdev(NULL, sizeof(struct el3_private)))) {
+					release_region(ioaddr, EL3_IO_EXTENT);
+					pnp_device_detach(idev);
+					return -ENOMEM;
+			}
+
+			SET_MODULE_OWNER(dev);
 			pnp_cards++;
 			goto found;
 		}
@@ -497,24 +494,29 @@ no_pnp:
 	}
 	irq = id_read_eeprom(9) >> 12;
 
-#if 0							/* Huh ?
-								   Can someone explain what is this for ? */
-	if (dev) {					/* Set passed-in IRQ or I/O Addr. */
-		if (dev->irq > 1  &&  dev->irq < 16)
+	if (!(dev = init_etherdev(NULL, sizeof(struct el3_private))))
+			return -ENOMEM;
+
+	SET_MODULE_OWNER(dev);
+	
+	/* Set passed-in IRQ or I/O Addr. */
+	if (dev->irq > 1  &&  dev->irq < 16)
 			irq = dev->irq;
 
-		if (dev->base_addr) {
+	if (dev->base_addr) {
 			if (dev->mem_end == 0x3c509 			/* Magic key */
 				&& dev->base_addr >= 0x200  &&  dev->base_addr <= 0x3e0)
-				ioaddr = dev->base_addr & 0x3f0;
-			else if (dev->base_addr != ioaddr)
-				return -ENODEV;
-		}
+					ioaddr = dev->base_addr & 0x3f0;
+			else if (dev->base_addr != ioaddr) {
+					unregister_netdev (dev);
+					return -ENODEV;
+			}
 	}
-#endif
 
-	if (!request_region(ioaddr, EL3_IO_EXTENT, "3c509"))
-		return -EBUSY;
+	if (!request_region(ioaddr, EL3_IO_EXTENT, "3c509")) {
+			unregister_netdev (dev);
+			return -EBUSY;
+	}
 
 	/* Set the adaptor tag so that the next card can be found. */
 	outb(0xd0 + ++current_tag, id_port);
@@ -524,19 +526,15 @@ no_pnp:
 
 	EL3WINDOW(0);
 	if (inw(ioaddr) != 0x6d50) {
+		unregister_netdev (dev);
 		release_region(ioaddr, EL3_IO_EXTENT);
 		return -ENODEV;
 	}
 
 	/* Free the interrupt so that some other card can use it. */
 	outw(0x0f00, ioaddr + WN0_IRQ);
-
-	dev = init_etherdev(NULL, sizeof(struct el3_private));
-	if (dev == NULL) {
-	    release_region(ioaddr, EL3_IO_EXTENT);
-		return -ENOMEM;
-	}
-	SET_MODULE_OWNER(dev);
+	
+ found:							/* PNP jumps here... */
 
 	memcpy(dev->dev_addr, phys_addr, sizeof(phys_addr));
 	dev->base_addr = ioaddr;
@@ -547,6 +545,16 @@ no_pnp:
 	lp->dev = &idev->dev;
 #endif
 
+#ifdef CONFIG_PM
+	/* register power management */
+	lp->pmdev = pm_register(PM_ISA_DEV, card_idx, el3_pm_callback);
+	if (lp->pmdev) {
+		struct pm_dev *p;
+		p = lp->pmdev;
+		p->data = (struct net_device *)dev;
+	}
+#endif
+
 	return el3_common_init (dev);
 }
 
diff -puN drivers/net/Space.c~3c509 drivers/net/Space.c
--- 25/drivers/net/Space.c~3c509	Mon Feb 10 17:34:37 2003
+++ 25-akpm/drivers/net/Space.c	Mon Feb 10 17:34:37 2003
@@ -224,9 +224,6 @@ static struct devprobe isa_probes[] __in
 #ifdef CONFIG_EL2 		/* 3c503 */
 	{el2_probe, 0},
 #endif
-#ifdef CONFIG_EL3
-	{el3_probe, 0},
-#endif
 #ifdef CONFIG_HPLAN
 	{hp_probe, 0},
 #endif

_

