Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131373AbRBLQaq>; Mon, 12 Feb 2001 11:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131358AbRBLQag>; Mon, 12 Feb 2001 11:30:36 -0500
Received: from colorfullife.com ([216.156.138.34]:60676 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129907AbRBLQaY>;
	Mon, 12 Feb 2001 11:30:24 -0500
Message-ID: <3A880FA1.68477F94@colorfullife.com>
Date: Mon, 12 Feb 2001 17:30:25 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
Subject: [patch] bugfix for LC82C168 tulip hang
Content-Type: multipart/mixed;
 boundary="------------8F57EE6C1F9455CC7C96D0B8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8F57EE6C1F9455CC7C96D0B8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I just found a fatal flaw in the tulip driver for the LC82C168 (pnic)
chipset:

The driver assumes that CSR11 is a hardware timer, but the LC82C168
doesn't have that timer :-(
Thus no callback, and nic is hung.

Jeff, could you include the patch into your tree and forward it to Alan?

The patch is against 2.4.1, it fixes all pnic bugs I'm aware of:

- missing update of the FastEthernet bit in check_duplex()
- do not start the internal autonegotiation if an mii is connected, that
prevents successful communication with the mii.
- hw timer doesn't exist

--
	Manfred
--------------8F57EE6C1F9455CC7C96D0B8
Content-Type: text/plain; charset=us-ascii;
 name="patch-tulip"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-tulip"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 1
//  EXTRAVERSION =
diff -ur 2.4/drivers/net/tulip/interrupt.c build-2.4/drivers/net/tulip/interrupt.c
--- 2.4/drivers/net/tulip/interrupt.c	Sun Feb 11 00:38:34 2001
+++ build-2.4/drivers/net/tulip/interrupt.c	Mon Feb 12 16:44:19 2001
@@ -23,7 +23,7 @@
 
 
 
-static int tulip_refill_rx(struct net_device *dev)
+int tulip_refill_rx(struct net_device *dev)
 {
 	struct tulip_private *tp = (struct tulip_private *)dev->priv;
 	int entry;
@@ -332,10 +332,17 @@
                      /* Josip Loncaric at ICASE did extensive experimentation
 			to develop a good interrupt mitigation setting.*/
                                 outl(0x8b240000, ioaddr + CSR11);
-                        } else {
+                        } else if (tp->chip_id == LC82C168) {
+				/* the LC82C168 doesn't have a hw timer.*/
+				outl(0x00, ioaddr + CSR7);
+				tp->ttimer = 1;
+				mod_timer(&tp->timer, RUN_AT(HZ/50));
+			} else {
                           /* Mask all interrupting sources, set timer to
 				re-enable. */
                                 outl(((~csr5) & 0x0001ebef) | AbnormalIntr | TimerInt, ioaddr + CSR7);
+				printk(KERN_ERR "interrupts got masked, new csr7 is %d.\n",
+					((~csr5) & 0x0001ebef) | AbnormalIntr | TimerInt);
                                 outl(0x0012, ioaddr + CSR11);
                         }
 			break;
@@ -353,16 +360,24 @@
 	/* check if the card is in suspend mode */
 	entry = tp->dirty_rx % RX_RING_SIZE;
 	if (tp->rx_buffers[entry].skb == NULL) {
-		if (tulip_debug > 1)
-			printk(KERN_WARNING "%s: in rx suspend mode: (%lu) (tp->cur_rx = %u, ttimer = %d, rx = %d) go/stay in suspend mode\n", dev->name, tp->nir, tp->cur_rx, tp->ttimer, rx);
-		if (tp->ttimer == 0 || (inl(ioaddr + CSR11) & 0xffff) == 0) {
-			if (tulip_debug > 1)
-				printk(KERN_WARNING "%s: in rx suspend mode: (%lu) set timer\n", dev->name, tp->nir);
-			outl(tulip_tbl[tp->chip_id].valid_intrs | TimerInt,
-				ioaddr + CSR7);
-			outl(TimerInt, ioaddr + CSR5);
-			outl(12, ioaddr + CSR11);
+		if (tulip_debug > 1) {
+			printk(KERN_WARNING "%s: in rx suspend mode: (%lu) (tp->cur_rx = %u, ttimer = %d, rx = %d) go/stay in suspend mode\n",
+				dev->name, tp->nir, tp->cur_rx, tp->ttimer, rx);
+		}
+		if (tp->chip_id == LC82C168) {
+			outl(0x00, ioaddr + CSR7);
 			tp->ttimer = 1;
+			mod_timer(&tp->timer, RUN_AT(HZ/50));
+		} else {
+			if (tp->ttimer == 0 || (inl(ioaddr + CSR11) & 0xffff) == 0) {
+				if (tulip_debug > 1)
+					printk(KERN_WARNING "%s: in rx suspend mode: (%lu) set timer\n", dev->name, tp->nir);
+				outl(tulip_tbl[tp->chip_id].valid_intrs | TimerInt,
+					ioaddr + CSR7);
+				outl(TimerInt, ioaddr + CSR5);
+				outl(12, ioaddr + CSR11);
+				tp->ttimer = 1;
+			}
 		}
 	}
 
diff -ur 2.4/drivers/net/tulip/media.c build-2.4/drivers/net/tulip/media.c
--- 2.4/drivers/net/tulip/media.c	Sun Feb 11 00:38:34 2001
+++ build-2.4/drivers/net/tulip/media.c	Mon Feb 12 16:53:25 2001
@@ -419,3 +419,59 @@
 	return 0;
 }
 
+/* Modified version of tulip_check_duplex:
+ * Always update the 100mbps bit, even if the
+ * full duplex bit didn't change.
+ *	Manfred Spraul <manfred@colorfullife.com>
+ */
+int pnic_check_duplex(struct net_device *dev)
+{
+	struct tulip_private *tp = (struct tulip_private *)dev->priv;
+	int mii_reg1, mii_reg5, negotiated, duplex;
+	int new_csr6;
+
+	mii_reg1 = tulip_mdio_read(dev, tp->phys[0], 1);
+	mii_reg5 = tulip_mdio_read(dev, tp->phys[0], 5);
+	if (tulip_debug > 1)
+		printk(KERN_INFO "%s: MII status %4.4x, Link partner report "
+			   "%4.4x.\n", dev->name, mii_reg1, mii_reg5);
+	if (mii_reg1 == 0xffff)
+		return -2;
+	if ((mii_reg1 & 0x0004) == 0) {
+		int new_reg1 = tulip_mdio_read(dev, tp->phys[0], 1);
+		if ((new_reg1 & 0x0004) == 0) {
+			if (tulip_debug  > 1)
+				printk(KERN_INFO "%s: No link beat on the MII interface,"
+					   " status %4.4x.\n", dev->name, new_reg1);
+			return -1;
+		}
+	}
+	negotiated = mii_reg5 & tp->advertising[0];
+	/* 100baseTx-FD  or  10T-FD, but not 100-HD */
+	duplex = ((negotiated & 0x0300) == 0x0100
+			  || (negotiated & 0x00C0) == 0x0040) ||
+		tp->full_duplex_lock;
+
+	new_csr6 = tp->csr6;
+	if (negotiated & 0x038)	/* 100mbps. */
+		new_csr6 &= ~0x00400000;
+	 else
+		new_csr6 |= 0x00400000;
+	if (duplex)
+		new_csr6 |= 0x0200;
+	 else	
+		new_csr6 &= ~0x0200;
+	if (new_csr6 != tp->csr6) {
+		tp->full_duplex = duplex;
+		tp->csr6 = new_csr6;
+		tulip_restart_rxtx(tp, tp->csr6);
+		if (tulip_debug > 0)
+			printk(KERN_INFO "%s: Setting %s-duplex based on MII"
+				   "#%d link partner capability of %4.4x.\n",
+				   dev->name, tp->full_duplex ? "full" : "half",
+				   tp->phys[0], mii_reg5);
+		return 1;
+	}
+	return 0;
+}
+
diff -ur 2.4/drivers/net/tulip/pnic.c build-2.4/drivers/net/tulip/pnic.c
--- 2.4/drivers/net/tulip/pnic.c	Sun Feb 11 00:38:34 2001
+++ build-2.4/drivers/net/tulip/pnic.c	Mon Feb 12 16:44:59 2001
@@ -62,6 +62,11 @@
 			   dev->name, phy_reg, csr5);
 	if (inl(ioaddr + CSR5) & TPLnkFail) {
 		outl((inl(ioaddr + CSR7) & ~TPLnkFail) | TPLnkPass, ioaddr + CSR7);
+		/* If we use an external MII, then we mustn't use the 
+		 * internal negotiation.
+		 */
+		if (tulip_media_cap[dev->if_port] & MediaIsMII)
+			return;
 		if (! tp->nwayset  ||  jiffies - dev->trans_start > 1*HZ) {
 			tp->csr6 = 0x00420000 | (tp->csr6 & 0x0000fdff);
 			tulip_outl_csr(tp, tp->csr6, CSR6);
@@ -70,11 +75,18 @@
 			dev->trans_start = jiffies;
 		}
 	} else if (inl(ioaddr + CSR5) & TPLnkPass) {
-		pnic_do_nway(dev);
+		if (tulip_media_cap[dev->if_port] & MediaIsMII) {
+			spin_lock(&tp->lock);
+			pnic_check_duplex(dev);
+			spin_unlock(&tp->lock);
+		} else {
+			pnic_do_nway(dev);
+		}
 		outl((inl(ioaddr + CSR7) & ~TPLnkPass) | TPLnkFail, ioaddr + CSR7);
 	}
 }
 
+int tulip_refill_rx(struct net_device *dev);
 
 void pnic_timer(unsigned long data)
 {
@@ -82,10 +94,19 @@
 	struct tulip_private *tp = (struct tulip_private *)dev->priv;
 	long ioaddr = dev->base_addr;
 	int next_tick = 60*HZ;
-
+	
+	if(tp->ttimer != 0) {
+		disable_irq(dev->irq);
+		tulip_refill_rx(dev);
+		enable_irq(dev->irq);
+		outl(tulip_tbl[tp->chip_id].valid_intrs, ioaddr + CSR7);
+		tp->ttimer = 0;
+	}
 	if (tulip_media_cap[dev->if_port] & MediaIsMII) {
-		if (tulip_check_duplex(dev) > 0)
+		spin_lock_irq(&tp->lock);
+		if (pnic_check_duplex(dev) > 0)
 			next_tick = 3*HZ;
+		spin_unlock_irq(&tp->lock);
 	} else {
 		int csr12 = inl(ioaddr + CSR12);
 		int new_csr6 = tp->csr6 & ~0x40C40200;



--------------8F57EE6C1F9455CC7C96D0B8--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
