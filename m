Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317324AbSFGTCM>; Fri, 7 Jun 2002 15:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317326AbSFGTCL>; Fri, 7 Jun 2002 15:02:11 -0400
Received: from p50886B5E.dip.t-dialin.net ([80.136.107.94]:23957 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317324AbSFGTCH>; Fri, 7 Jun 2002 15:02:07 -0400
Date: Fri, 7 Jun 2002 13:01:59 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] tulip: devicenames patch (updated)
Message-ID: <Pine.LNX.4.44.0206071258480.18120-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This, again, removes the situation when printk outputs "eth%d" in tulip 
driver.

diff -Nur linux-2.5.20/drivers/net/tulip/eeprom.c thunder-2.5.20/drivers/net/tulip/eeprom.c
--- linux-2.5.20/drivers/net/tulip/eeprom.c	Sun Jun  2 19:44:53 2002
+++ thunder-2.5.20/drivers/net/tulip/eeprom.c	Fri Jun  7 12:52:19 2002
@@ -95,15 +95,14 @@
 		if (ee_data[0] == 0xff) {
 			if (last_mediatable) {
 				controller_index++;
-				printk(KERN_INFO "%s:  Controller %d of multiport board.\n",
-					   dev->name, controller_index);
+				printk(KERN_INFO "tulip%d:  Controller %d of multiport board.\n",
+					   tp->board_idx, controller_index);
 				tp->mtable = last_mediatable;
 				ee_data = last_ee_data;
 				goto subsequent_board;
 			} else
-				printk(KERN_INFO "%s:  Missing EEPROM, this interface may "
-					   "not work correctly!\n",
-			   dev->name);
+				printk(KERN_INFO "tulip%d:  Missing EEPROM, this interface may "
+					   "not work correctly!\n", tp->board_idx);
 			return;
 		}
 	  /* Do a fix-up based on the vendor half of the station address prefix. */
@@ -115,16 +114,15 @@
 			  i++;			/* An Accton EN1207, not an outlaw Maxtech. */
 		  memcpy(ee_data + 26, eeprom_fixups[i].newtable,
 				 sizeof(eeprom_fixups[i].newtable));
-		  printk(KERN_INFO "%s: Old format EEPROM on '%s' board.  Using"
+		  printk(KERN_INFO "tulip%d: Old format EEPROM on '%s' board.  Using"
 				 " substitute media control info.\n",
-				 dev->name, eeprom_fixups[i].name);
+				 tp->board_idx, eeprom_fixups[i].name);
 		  break;
 		}
 	  }
 	  if (eeprom_fixups[i].name == NULL) { /* No fixup found. */
-		  printk(KERN_INFO "%s: Old style EEPROM with no media selection "
-				 "information.\n",
-			   dev->name);
+		  printk(KERN_INFO "tulip%d: Old style EEPROM with no media selection "
+				 "information.\n", tp->board_idx);
 		return;
 	  }
 	}
@@ -151,7 +149,7 @@
 	        /* there is no phy information, don't even try to build mtable */
 	        if (count == 0) {
 			if (tulip_debug > 0)
-				printk(KERN_WARNING "%s: no phy info, aborting mtable build\n", dev->name);
+				printk(KERN_WARNING "tulip%d: no phy info, aborting mtable build\n", tp->board_idx);
 		        return;
 		}
 
@@ -167,7 +165,7 @@
 		mtable->has_nonmii = mtable->has_mii = mtable->has_reset = 0;
 		mtable->csr15dir = mtable->csr15val = 0;
 
-		printk(KERN_INFO "%s:  EEPROM default media type %s.\n", dev->name,
+		printk(KERN_INFO "tulip%d:  EEPROM default media type %s.\n", tp->board_idx,
 			   media & 0x0800 ? "Autosense" : medianame[media & MEDIA_MASK]);
 		for (i = 0; i < count; i++) {
 			struct medialeaf *leaf = &mtable->mleaf[i];
@@ -231,14 +229,14 @@
 			}
 			if (tulip_debug > 1  &&  leaf->media == 11) {
 				unsigned char *bp = leaf->leafdata;
-				printk(KERN_INFO "%s:  MII interface PHY %d, setup/reset "
+				printk(KERN_INFO "tulip%d:  MII interface PHY %d, setup/reset "
 					   "sequences %d/%d long, capabilities %2.2x %2.2x.\n",
-					   dev->name, bp[0], bp[1], bp[2 + bp[1]*2],
+					   tp->board_idx, bp[0], bp[1], bp[2 + bp[1]*2],
 					   bp[5 + bp[2 + bp[1]*2]*2], bp[4 + bp[2 + bp[1]*2]*2]);
 			}
-			printk(KERN_INFO "%s:  Index #%d - Media %s (#%d) described "
+			printk(KERN_INFO "tulip%d:  Index #%d - Media %s (#%d) described "
 				   "by a %s (%d) block.\n",
-				   dev->name, i, medianame[leaf->media & 15], leaf->media,
+				   tp->board_idx, i, medianame[leaf->media & 15], leaf->media,
 				   leaf->type < ARRAY_SIZE(block_name) ? block_name[leaf->type] : "<unknown>",
 				   leaf->type);
 		}
diff -Nur linux-2.5.20/drivers/net/tulip/media.c thunder-2.5.20/drivers/net/tulip/media.c
--- linux-2.5.20/drivers/net/tulip/media.c	Sun Jun  2 19:44:44 2002
+++ thunder-2.5.20/drivers/net/tulip/media.c	Fri Jun  7 12:48:35 2002
@@ -182,9 +182,9 @@
 		switch (mleaf->type) {
 		case 0:					/* 21140 non-MII xcvr. */
 			if (tulip_debug > 1)
-				printk(KERN_DEBUG "%s: Using a 21140 non-MII transceiver"
+				printk(KERN_DEBUG "tulip%d: Using a 21140 non-MII transceiver"
 					   " with control setting %2.2x.\n",
-					   dev->name, p[1]);
+					   tp->board_idx, p[1]);
 			dev->if_port = p[0];
 			if (startup)
 				outl(mtable->csr12dir | 0x100, ioaddr + CSR12);
@@ -205,15 +205,15 @@
 				struct medialeaf *rleaf = &mtable->mleaf[mtable->has_reset];
 				unsigned char *rst = rleaf->leafdata;
 				if (tulip_debug > 1)
-					printk(KERN_DEBUG "%s: Resetting the transceiver.\n",
-						   dev->name);
+					printk(KERN_DEBUG "tulip%d: Resetting the transceiver.\n",
+						   tp->board_idx);
 				for (i = 0; i < rst[0]; i++)
 					outl(get_u16(rst + 1 + (i<<1)) << 16, ioaddr + CSR15);
 			}
 			if (tulip_debug > 1)
-				printk(KERN_DEBUG "%s: 21143 non-MII %s transceiver control "
+				printk(KERN_DEBUG "tulip%d: 21143 non-MII %s transceiver control "
 					   "%4.4x/%4.4x.\n",
-					   dev->name, medianame[dev->if_port], setup[0], setup[1]);
+					   tp->board_idx, medianame[dev->if_port], setup[0], setup[1]);
 			if (p[0] & 0x40) {	/* SIA (CSR13-15) setup values are provided. */
 				csr13val = setup[0];
 				csr14val = setup[1];
@@ -240,8 +240,8 @@
 				if (startup) outl(csr13val, ioaddr + CSR13);
 			}
 			if (tulip_debug > 1)
-				printk(KERN_DEBUG "%s:  Setting CSR15 to %8.8x/%8.8x.\n",
-					   dev->name, csr15dir, csr15val);
+				printk(KERN_DEBUG "tulip%d:  Setting CSR15 to %8.8x/%8.8x.\n",
+					   tp->board_idx, csr15dir, csr15val);
 			if (mleaf->type == 4)
 				new_csr6 = 0x82020000 | ((setup[2] & 0x71) << 18);
 			else
@@ -285,8 +285,8 @@
 				if (tp->mii_advertise == 0)
 					tp->mii_advertise = tp->advertising[phy_num];
 				if (tulip_debug > 1)
-					printk(KERN_DEBUG "%s:  Advertising %4.4x on MII %d.\n",
-					       dev->name, tp->mii_advertise, tp->phys[phy_num]);
+					printk(KERN_DEBUG "tulip%d:  Advertising %4.4x on MII %d.\n",
+					       tp->board_idx, tp->mii_advertise, tp->phys[phy_num]);
 				tulip_mdio_write(dev, tp->phys[phy_num], 4, tp->mii_advertise);
 			}
 			break;
@@ -303,8 +303,8 @@
 				struct medialeaf *rleaf = &mtable->mleaf[mtable->has_reset];
 				unsigned char *rst = rleaf->leafdata;
 				if (tulip_debug > 1)
-					printk(KERN_DEBUG "%s: Resetting the transceiver.\n",
-						   dev->name);
+					printk(KERN_DEBUG "tulip%d: Resetting the transceiver.\n",
+						   tp->board_idx);
 				for (i = 0; i < rst[0]; i++)
 					outl(get_u16(rst + 1 + (i<<1)) << 16, ioaddr + CSR15);
 			}
@@ -312,20 +312,20 @@
 			break;
 		}
 		default:
-			printk(KERN_DEBUG "%s:  Invalid media table selection %d.\n",
-					   dev->name, mleaf->type);
+			printk(KERN_DEBUG "tulip%d:  Invalid media table selection %d.\n",
+					   tp->board_idx, mleaf->type);
 			new_csr6 = 0x020E0000;
 		}
 		if (tulip_debug > 1)
-			printk(KERN_DEBUG "%s: Using media type %s, CSR12 is %2.2x.\n",
-				   dev->name, medianame[dev->if_port],
+			printk(KERN_DEBUG "tulip%d: Using media type %s, CSR12 is %2.2x.\n",
+				   tp->board_idx, medianame[dev->if_port],
 				   inl(ioaddr + CSR12) & 0xff);
 	} else if (tp->chip_id == LC82C168) {
 		if (startup && ! tp->medialock)
 			dev->if_port = tp->mii_cnt ? 11 : 0;
 		if (tulip_debug > 1)
-			printk(KERN_DEBUG "%s: PNIC PHY status is %3.3x, media %s.\n",
-				   dev->name, inl(ioaddr + 0xB8), medianame[dev->if_port]);
+			printk(KERN_DEBUG "tulip%d: PNIC PHY status is %3.3x, media %s.\n",
+				   tp->board_idx, inl(ioaddr + 0xB8), medianame[dev->if_port]);
 		if (tp->mii_cnt) {
 			new_csr6 = 0x810C0000;
 			outl(0x0001, ioaddr + CSR15);
@@ -358,7 +358,7 @@
 		if (tulip_debug > 1)
 			printk(KERN_DEBUG "%s: No media description table, assuming "
 				   "%s transceiver, CSR12 %2.2x.\n",
-				   dev->name, medianame[dev->if_port],
+				   tp->board_idx, medianame[dev->if_port],
 				   inl(ioaddr + CSR12));
 	}
 
@@ -418,7 +418,7 @@
 	return 0;
 }
 
-void __devinit tulip_find_mii (struct net_device *dev, int board_idx)
+void __devinit tulip_find_mii (struct net_device *dev)
 {
 	struct tulip_private *tp = dev->priv;
 	int phyn, phy_idx = 0;
@@ -468,13 +468,13 @@
 
 		printk (KERN_INFO "tulip%d:  MII transceiver #%d "
 			"config %4.4x status %4.4x advertising %4.4x.\n",
-			board_idx, phy, mii_reg0, mii_status, mii_advert);
+			tp->board_idx, phy, mii_reg0, mii_status, mii_advert);
 
 		/* Fixup for DLink with miswired PHY. */
 		if (mii_advert != to_advert) {
 			printk (KERN_DEBUG "tulip%d:  Advertising %4.4x on PHY %d,"
 				" previously advertising %4.4x.\n",
-				board_idx, to_advert, phy, mii_advert);
+				tp->board_idx, to_advert, phy, mii_advert);
 			tulip_mdio_write (dev, phy, 4, to_advert);
 		}
 
@@ -520,7 +520,7 @@
 	tp->mii_cnt = phy_idx;
 	if (tp->mtable && tp->mtable->has_mii && phy_idx == 0) {
 		printk (KERN_INFO "tulip%d: ***WARNING***: No MII transceiver found!\n",
-			board_idx);
+			tp->board_idx);
 		tp->phys[0] = 1;
 	}
 }
diff -Nur linux-2.5.20/drivers/net/tulip/tulip.h thunder-2.5.20/drivers/net/tulip/tulip.h
--- linux-2.5.20/drivers/net/tulip/tulip.h	Sun Jun  2 19:44:47 2002
+++ thunder-2.5.20/drivers/net/tulip/tulip.h	Fri Jun  7 12:34:19 2002
@@ -389,6 +389,7 @@
 	unsigned long nir;
 	unsigned long base_addr;
 	int pad0, pad1;		/* Used for 8-byte alignment */
+	int board_idx;		/* The board number of the Tulip card */
 };
 
 
diff -Nur linux-2.5.20/drivers/net/tulip/tulip_core.c thunder-2.5.20/drivers/net/tulip/tulip_core.c
--- linux-2.5.20/drivers/net/tulip/tulip_core.c	Sun Jun  2 19:44:51 2002
+++ thunder-2.5.20/drivers/net/tulip/tulip_core.c	Fri Jun  7 12:53:00 2002
@@ -1346,6 +1346,8 @@
 		return i;
 	}
 
+	tp->board_idx = board_idx;
+
 	ioaddr = pci_resource_start (pdev, 0);
 	irq = pdev->irq;
 
@@ -1560,9 +1562,7 @@
 	}
 
 	if (tp->flags & HAS_MEDIA_TABLE) {
-		sprintf(dev->name, "tulip%d", board_idx);	/* hack */
 		tulip_parse_eeprom(dev);
-		strcpy(dev->name, "eth%d");			/* un-hack */
 	}
 
 	if ((tp->flags & ALWAYS_CHECK_MII) ||
@@ -1582,7 +1582,7 @@
 		/* Find the connected MII xcvrs.
 		   Doing this in open() would allow detecting external xcvrs
 		   later, but takes much time. */
-		tulip_find_mii (dev, board_idx);
+		tulip_find_mii (dev);
 	}
 
 	/* The Tulip-specific entries in the device structure. */

-- 
Lightweight patch manager using pine. If you have any objections, tell me.


