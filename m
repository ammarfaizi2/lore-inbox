Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267059AbTBHRQl>; Sat, 8 Feb 2003 12:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267065AbTBHRQl>; Sat, 8 Feb 2003 12:16:41 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:38615 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S267059AbTBHRQi>; Sat, 8 Feb 2003 12:16:38 -0500
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] fix 3c509.c for MCA drivers
References: <1044241767.3924.14.camel@mulgrave>
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 08 Feb 2003 18:25:59 +0100
Message-ID: <wrpznp6wuoo.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <1044241767.3924.14.camel@mulgrave>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

>>>>> "James" == James Bottomley <James.Bottomley@steeleye.com> writes:

James> I've put the el3_probe back into Space.c for ISA only otherwise
James> the driver won't work for ISA (could someone with an ISA card
James> test this).

I've managed to finally get it to compile/work for ISA/ISA-PNP. I
checked the stuff was working properly *without* el3_probe in Space.c.
I also restored the 'ether=' functionality.

Anyway, this part of the code (ISA/ISA-PNP) is a real mess, and I wish
somebody who knows what he's doing would clean it up.

        M.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=3c509.patch

===== drivers/net/3c509.c 1.25.1.5 vs 1.34 =====
--- 1.25.1.5/drivers/net/3c509.c	Mon Feb  3 08:35:11 2003
+++ 1.34/drivers/net/3c509.c	Sat Feb  8 17:17:14 2003
@@ -338,16 +338,6 @@
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
 
@@ -417,6 +407,13 @@
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
@@ -497,24 +494,29 @@
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
@@ -524,19 +526,15 @@
 
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
@@ -545,6 +543,16 @@
 	lp = dev->priv;
 #ifdef __ISAPNP__
 	lp->dev = &idev->dev;
+#endif
+
+#ifdef CONFIG_PM
+	/* register power management */
+	lp->pmdev = pm_register(PM_ISA_DEV, card_idx, el3_pm_callback);
+	if (lp->pmdev) {
+		struct pm_dev *p;
+		p = lp->pmdev;
+		p->data = (struct net_device *)dev;
+	}
 #endif
 
 	return el3_common_init (dev);
===== drivers/net/Space.c 1.11.1.5 vs 1.19 =====
--- 1.11.1.5/drivers/net/Space.c	Mon Feb  3 08:35:11 2003
+++ 1.19/drivers/net/Space.c	Sat Feb  8 17:18:21 2003
@@ -224,9 +224,6 @@
 #ifdef CONFIG_EL2 		/* 3c503 */
 	{el2_probe, 0},
 #endif
-#ifdef CONFIG_EL3
-	{el3_probe, 0},
-#endif
 #ifdef CONFIG_HPLAN
 	{hp_probe, 0},
 #endif

--=-=-=


-- 
Places change, faces change. Life is so very strange.

--=-=-=--
