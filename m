Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144005AbRAHOfG>; Mon, 8 Jan 2001 09:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143994AbRAHOe4>; Mon, 8 Jan 2001 09:34:56 -0500
Received: from open.your.mind.be ([195.162.205.66]:31479 "HELO
	portablue.intern.mind.be") by vger.kernel.org with SMTP
	id <S143752AbRAHOem>; Mon, 8 Jan 2001 09:34:42 -0500
Date: Mon, 8 Jan 2001 15:33:36 +0100
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tulip
Message-ID: <20010108153336.G1831@mind.be>
Mail-Followup-To: p2@mind.be,
	Matti Aarnio <matti.aarnio@zmailer.org>, jgarzik@mandrakesoft.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010108150108.F1831@mind.be> <20010108161119.F25659@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010108161119.F25659@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Mon, Jan 08, 2001 at 04:11:19PM +0200
X-Answer: 42
X-Operating-system: Debian GNU/Linux
From: p2@mind.be (Peter De Schrijver)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


HYA

Peter.


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-tulip2

diff -ur linux.orig/drivers/net/tulip/21142.c linux/drivers/net/tulip/21142.c
--- linux.orig/drivers/net/tulip/21142.c	Tue Nov  7 20:08:09 2000
+++ linux/drivers/net/tulip/21142.c	Sun Jan  7 18:29:03 2001
@@ -99,8 +99,8 @@
 {
 	struct tulip_private *tp = (struct tulip_private *)dev->priv;
 	long ioaddr = dev->base_addr;
-	int csr14 = ((tp->to_advertise & 0x0780) << 9)  |
-		((tp->to_advertise&0x0020)<<1) | 0xffbf;
+	int csr14 = ((tp->sym_advertise & 0x0780) << 9)  |
+		((tp->sym_advertise&0x0020)<<1) | 0xffbf;
 
 	DPRINTK("ENTER\n");
 
@@ -114,9 +114,9 @@
 	udelay(100);
 	outl(csr14, ioaddr + CSR14);
 	if (tp->chip_id == PNIC2)
-	  tp->csr6 = 0x01a80000 | (tp->to_advertise & 0x0040 ? 0x0200 : 0);
+	  tp->csr6 = 0x01a80000 | (tp->sym_advertise & 0x0040 ? 0x0200 : 0);
 	else
-	  tp->csr6 = 0x82420000 | (tp->to_advertise & 0x0040 ? 0x0200 : 0);
+	  tp->csr6 = 0x82420000 | (tp->sym_advertise & 0x0040 ? 0x0200 : 0);
 	tulip_outl_csr(tp, tp->csr6, CSR6);
 	if (tp->mtable  &&  tp->mtable->csr15dir) {
 		outl(tp->mtable->csr15dir, ioaddr + CSR15);
@@ -140,7 +140,7 @@
 	/* If NWay finished and we have a negotiated partner capability. */
 	if (tp->nway  &&  !tp->nwayset  &&  (csr12 & 0x7000) == 0x5000) {
 		int setup_done = 0;
-		int negotiated = tp->to_advertise & (csr12 >> 16);
+		int negotiated = tp->sym_advertise & (csr12 >> 16);
 		tp->lpar = csr12 >> 16;
 		tp->nwayset = 1;
 		if (negotiated & 0x0100)		dev->if_port = 5;
@@ -149,7 +149,7 @@
 		else if (negotiated & 0x0020)	dev->if_port = 0;
 		else {
 			tp->nwayset = 0;
-			if ((csr12 & 2) == 0  &&  (tp->to_advertise & 0x0180))
+			if ((csr12 & 2) == 0  &&  (tp->sym_advertise & 0x0180))
 				dev->if_port = 3;
 		}
 		tp->full_duplex = (tulip_media_cap[dev->if_port] & MediaAlwaysFD) ? 1:0;
@@ -158,7 +158,7 @@
 			if (tp->nwayset)
 				printk(KERN_INFO "%s: Switching to %s based on link "
 					   "negotiation %4.4x & %4.4x = %4.4x.\n",
-					   dev->name, medianame[dev->if_port], tp->to_advertise,
+					   dev->name, medianame[dev->if_port], tp->sym_advertise,
 					   tp->lpar, negotiated);
 			else
 				printk(KERN_INFO "%s: Autonegotiation failed, using %s,"
diff -ur linux.orig/drivers/net/tulip/eeprom.c linux/drivers/net/tulip/eeprom.c
--- linux.orig/drivers/net/tulip/eeprom.c	Sat Dec 30 20:23:14 2000
+++ linux/drivers/net/tulip/eeprom.c	Sun Jan  7 17:38:45 2001
@@ -207,8 +207,15 @@
 					p += (p[0] & 0x3f) + 1;
 					continue;
 				} else if (p[1] & 1) {
+					int gpr_len, reset_len;
+
 					mtable->has_mii = 1;
 					leaf->media = 11;
+#if 0
+					gpr_len=p[3]*2;
+					reset_len=p[4+gpr_len]*2;
+					new_advertise |= get_u16(&p[7+gpr_len+reset_len]);
+#endif
 				} else {
 					mtable->has_nonmii = 1;
 					leaf->media = p[2] & 0x0f;
@@ -252,7 +259,7 @@
 				   block_name[leaf->type], leaf->type);
 		}
 		if (new_advertise)
-			tp->to_advertise = new_advertise;
+			tp->sym_advertise = new_advertise;
 	}
 }
 /* Reading a serial EEPROM is a "bit" grungy, but we work our way through:->.*/
diff -ur linux.orig/drivers/net/tulip/media.c linux/drivers/net/tulip/media.c
--- linux.orig/drivers/net/tulip/media.c	Mon Jan  1 18:54:07 2001
+++ linux/drivers/net/tulip/media.c	Sun Jan  7 17:51:16 2001
@@ -227,7 +227,6 @@
 			int phy_num = p[0];
 			int init_length = p[1];
 			u16 *misc_info;
-			u16 to_advertise;
 
 			dev->if_port = 11;
 			new_csr6 = 0x020E0000;
@@ -254,13 +253,17 @@
 				for (i = 0; i < init_length; i++)
 					outl(init_sequence[i], ioaddr + CSR12);
 			}
-			to_advertise = (get_u16(&misc_info[1]) & tp->to_advertise) | 1;
-			tp->advertising[phy_num] = to_advertise;
-			if (tulip_debug > 1)
-				printk(KERN_DEBUG "%s:  Advertising %4.4x on PHY %d (%d).\n",
-					   dev->name, to_advertise, phy_num, tp->phys[phy_num]);
-			/* Bogus: put in by a committee?  */
-			tulip_mdio_write(dev, tp->phys[phy_num], 4, to_advertise);
+			tp->advertising[phy_num] = get_u16(&misc_info[1]) | 1;;
+			if(startup < 2) {
+				if (tp->mii_advertise == 0)
+					tp->mii_advertise = tp->advertising[phy_num];
+				if (tulip_debug > 1)
+					printk(KERN_DEBUG "%s:  Advertising %4.4x on PHY %d (%d).\n",
+					   		dev->name, tp->mii_advertise, phy_num, 
+							tp->phys[phy_num]);
+				/* Bogus: put in by a committee?  */
+				tulip_mdio_write(dev, tp->phys[phy_num], 4, tp->mii_advertise);
+			}
 			break;
 		}
 		case 5: case 6: {
diff -ur linux.orig/drivers/net/tulip/tulip.h linux/drivers/net/tulip/tulip.h
--- linux.orig/drivers/net/tulip/tulip.h	Sat Dec 30 20:23:14 2000
+++ linux/drivers/net/tulip/tulip.h	Sun Jan  7 17:41:47 2001
@@ -22,7 +22,7 @@
 
 
 /* undefine, or define to various debugging levels (>4 == obscene levels) */
-#undef TULIP_DEBUG
+#undef TULIP_DEBUG 
 
 
 #ifdef TULIP_DEBUG
@@ -353,7 +353,7 @@
 	unsigned int csr6;	/* Current CSR6 control settings. */
 	unsigned char eeprom[EEPROM_SIZE];	/* Serial EEPROM contents. */
 	void (*link_change) (struct net_device * dev, int csr5);
-	u16 to_advertise;	/* NWay capabilities advertised.  */
+	u16 sym_advertise, mii_advertise;	/* NWay capabilities advertised.  */
 	u16 lpar;		/* 21143 Link partner ability. */
 	u16 advertising[4];
 	signed char phys[4], mii_cnt;	/* MII device addresses. */
diff -ur linux.orig/drivers/net/tulip/tulip_core.c linux/drivers/net/tulip/tulip_core.c
--- linux.orig/drivers/net/tulip/tulip_core.c	Thu Jan  4 21:50:17 2001
+++ linux/drivers/net/tulip/tulip_core.c	Sun Jan  7 20:57:01 2001
@@ -329,7 +329,7 @@
 		if (tp->mii_cnt) {
 			tulip_select_media(dev, 1);
 			if (tulip_debug > 1)
-				printk(KERN_INFO "%s: Using MII transceiver %d, status "
+				printk(KERN_INFO "%s: Using mII transceiver %d, status "
 					   "%4.4x.\n",
 					   dev->name, tp->phys[0], tulip_mdio_read(dev, tp->phys[0], 1));
 			tulip_outl_csr(tp, csr6_mask_defstate, CSR6);
@@ -794,7 +794,7 @@
 			return -EPERM;
 		if (data[0] == 32  &&  (tp->flags & HAS_NWAY)) {
 			if (data[1] == 5)
-				tp->to_advertise = data[2];
+				tp->sym_advertise = data[2];
 		} else {
 			spin_lock_irqsave (&tp->lock, flags);
 			tulip_mdio_write(dev, data[0] & 0x1f, data[1] & 0x1f, data[2]);
@@ -1304,11 +1304,9 @@
 
 	if (tulip_media_cap[tp->default_port] & MediaIsMII) {
 		u16 media2advert[] = { 0x20, 0x40, 0x03e0, 0x60, 0x80, 0x100, 0x200 };
-		tp->to_advertise = media2advert[tp->default_port - 9];
-	} else if (tp->flags & HAS_8023X)
-		tp->to_advertise = 0x05e1;
-	else
-		tp->to_advertise = 0x01e1;
+		tp->mii_advertise = media2advert[tp->default_port - 9];
+		tp->mii_advertise |= (tp->flags & HAS_8023X); /* Matching bits! */
+	} 
 
 	/* This is logically part of _init_one(), but too complex to write inline. */
 	if (tp->flags & HAS_MEDIA_TABLE) {
@@ -1340,21 +1338,25 @@
 				((mii_status & 0x8000) == 0  && (mii_status & 0x7800) != 0)) {
 				int mii_reg0 = tulip_mdio_read(dev, phy, 0);
 				int mii_advert = tulip_mdio_read(dev, phy, 4);
-				int reg4 = ((mii_status>>6) & tp->to_advertise) | 1;
-				tp->phys[phy_idx] = phy;
-				tp->advertising[phy_idx++] = reg4;
+				int to_advert;
+
+				if (tp->mii_advertise)
+					to_advert = tp->mii_advertise;
+				else if (tp->advertising[phy_idx])
+					to_advert = tp->advertising[phy_idx];
+				else
+					tp->mii_advertise = to_advert = mii_advert;
+
+				tp->phys[phy_idx++] = phy;
 				printk(KERN_INFO "%s:  MII transceiver #%d "
 					   "config %4.4x status %4.4x advertising %4.4x.\n",
 					   dev->name, phy, mii_reg0, mii_status, mii_advert);
 				/* Fixup for DLink with miswired PHY. */
-				if (mii_advert != reg4) {
+				if (mii_advert != to_advert) {
 					printk(KERN_DEBUG "%s:  Advertising %4.4x on PHY %d,"
 						   " previously advertising %4.4x.\n",
-						   dev->name, reg4, phy, mii_advert);
-					printk(KERN_DEBUG "%s:  Advertising %4.4x (to advertise"
-						   " is %4.4x).\n",
-						   dev->name, reg4, tp->to_advertise);
-					tulip_mdio_write(dev, phy, 4, reg4);
+						   dev->name, to_advert, phy, mii_advert);
+					tulip_mdio_write(dev, phy, 4, to_advert);
 				}
 				/* Enable autonegotiation: some boards default to off. */
 				tulip_mdio_write(dev, phy, 0, mii_reg0 |
@@ -1388,7 +1390,8 @@
 	/* Reset the xcvr interface and turn on heartbeat. */
 	switch (chip_idx) {
 	case DC21041:
-		tp->to_advertise = 0x0061;
+		if (tp->sym_advertise == 0)
+			tp->sym_advertise = 0x0061;
 		outl(0x00000000, ioaddr + CSR13);
 		outl(0xFFFFFFFF, ioaddr + CSR14);
 		outl(0x00000008, ioaddr + CSR15); /* Listen on AUI also. */

--kVXhAStRUZ/+rrGn--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
