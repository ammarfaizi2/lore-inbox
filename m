Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263432AbRFAJYF>; Fri, 1 Jun 2001 05:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263431AbRFAJX4>; Fri, 1 Jun 2001 05:23:56 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:23195 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263432AbRFAJXs>;
	Fri, 1 Jun 2001 05:23:48 -0400
Message-ID: <3B175F1E.D7584605@mandrakesoft.com>
Date: Fri, 01 Jun 2001 05:23:42 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Mischke <thomas.mischke@isg.de>
Subject: PATCH: tulip net driver update
Content-Type: multipart/mixed;
 boundary="------------0C5397F298FD787AA590C660"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0C5397F298FD787AA590C660
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

tulip needs a small delay during rxtx restart.  different optimization
patterns in newer gccs served to expose this bug which was previously
hidden, so random users might hit a lack-of-networking depending on the
speed of their machine, their compiler, etc.

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
--------------0C5397F298FD787AA590C660
Content-Type: text/plain; charset=us-ascii;
 name="tulip-pre3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tulip-pre3.patch"

Index: linux_2_4/drivers/net/tulip/21142.c
diff -u linux_2_4/drivers/net/tulip/21142.c:1.1.1.28 linux_2_4/drivers/net/tulip/21142.c:1.1.1.28.26.1
--- linux_2_4/drivers/net/tulip/21142.c:1.1.1.28	Wed May 16 14:46:45 2001
+++ linux_2_4/drivers/net/tulip/21142.c	Fri Jun  1 02:19:08 2001
@@ -84,7 +84,7 @@
 			tp->csr6 &= 0x00D5;
 			tp->csr6 |= new_csr6;
 			outl(0x0301, ioaddr + CSR12);
-			tulip_restart_rxtx(tp, tp->csr6);
+			tulip_restart_rxtx(tp);
 		}
 		next_tick = 3*HZ;
 	}
@@ -117,7 +117,7 @@
 	udelay(100);
 	outl(csr14, ioaddr + CSR14);
 	tp->csr6 = 0x82420000 | (tp->sym_advertise & 0x0040 ? FullDuplex : 0);
-	tulip_outl_csr(tp, tp->csr6, CSR6);
+	outl(tp->csr6, ioaddr + CSR6);
 	if (tp->mtable  &&  tp->mtable->csr15dir) {
 		outl(tp->mtable->csr15dir, ioaddr + CSR15);
 		outl(tp->mtable->csr15val, ioaddr + CSR15);
@@ -201,12 +201,12 @@
 			outl(1, ioaddr + CSR13);
 		}
 #if 0							/* Restart shouldn't be needed. */
-		tulip_outl_csr(tp, tp->csr6 | csr6_sr, CSR6);
+		outl(tp->csr6 | RxOn, ioaddr + CSR6);
 		if (tulip_debug > 2)
 			printk(KERN_DEBUG "%s:  Restarting Tx and Rx, CSR5 is %8.8x.\n",
 				   dev->name, inl(ioaddr + CSR5));
 #endif
-		tulip_outl_csr(tp, tp->csr6 | csr6_st | csr6_sr, CSR6);
+		tulip_start_rxtx(tp);
 		if (tulip_debug > 2)
 			printk(KERN_DEBUG "%s:  Setting CSR6 %8.8x/%x CSR12 %8.8x.\n",
 				   dev->name, tp->csr6, inl(ioaddr + CSR6),
@@ -252,7 +252,7 @@
 		tp->csr6 = 0x83860000;
 		outl(0x0003FF7F, ioaddr + CSR14);
 		outl(0x0301, ioaddr + CSR12);
-		tulip_restart_rxtx(tp, tp->csr6);
+		tulip_restart_rxtx(tp);
 	}
 }
 
Index: linux_2_4/drivers/net/tulip/ChangeLog
diff -u linux_2_4/drivers/net/tulip/ChangeLog:1.1.1.11 linux_2_4/drivers/net/tulip/ChangeLog:1.1.1.11.20.1
--- linux_2_4/drivers/net/tulip/ChangeLog:1.1.1.11	Sat May 19 18:57:05 2001
+++ linux_2_4/drivers/net/tulip/ChangeLog	Fri Jun  1 02:19:08 2001
@@ -1,3 +1,23 @@
+2001-06-01  Jeff Garzik  <jgarzik@mandrakesoft.com>
+
+	* tulip.h:
+	- Remove tulip_outl_csr helper, redundant.
+	- Add tulip_start_rxtx inline helper.
+	- tulip_stop_rxtx helper: Add synchronization. Always use current
+	  csr6 value, instead of tp->csr6 value or value passed as arg.
+	- tulip_restart_rxtx helper: Add synchronization. Always
+	  use tp->csr6 for desired mode, not value passed as arg.
+	- New RxOn, TxOn, RxTx constants for csr6 modes.
+	- Remove now-redundant constants csr6_st, csr6_sr.
+
+	* 21142.c, interrupt.c, media.c, pnic.c, tulip_core.c:
+	Update for above rxtx helper changes.
+
+	* interrupt.c:
+	- whitespace cleanup around #ifdef CONFIG_NET_HW_FLOWCONTROL,
+	  convert tabs to spaces.
+	- Move tp->stats.rx_missed_errors update outside the ifdef.
+
 2001-05-18  Jeff Garzik  <jgarzik@mandrakesoft.com>
 
 	* tulip_core.c: Added ethtool support.
Index: linux_2_4/drivers/net/tulip/interrupt.c
diff -u linux_2_4/drivers/net/tulip/interrupt.c:1.1.1.40 linux_2_4/drivers/net/tulip/interrupt.c:1.1.1.40.10.1
--- linux_2_4/drivers/net/tulip/interrupt.c:1.1.1.40	Thu May 24 01:49:55 2001
+++ linux_2_4/drivers/net/tulip/interrupt.c	Fri Jun  1 02:19:08 2001
@@ -418,7 +418,7 @@
 					printk(KERN_WARNING "%s: The transmitter stopped."
 						   "  CSR5 is %x, CSR6 %x, new CSR6 %x.\n",
 						   dev->name, csr5, inl(ioaddr + CSR6), tp->csr6);
-				tulip_restart_rxtx(tp, tp->csr6);
+				tulip_restart_rxtx(tp);
 			}
 			spin_unlock(&tp->lock);
 		}
@@ -434,7 +434,7 @@
 				else
 					tp->csr6 |= 0x00200000;  /* Store-n-forward. */
 				/* Restart the transmit process. */
-				tulip_restart_rxtx(tp, tp->csr6);
+				tulip_restart_rxtx(tp);
 				outl(0, ioaddr + CSR1);
 			}
 			if (csr5 & (RxDied | RxNoBuf)) {
@@ -444,16 +444,15 @@
 				}
 			}
 			if (csr5 & RxDied) {		/* Missed a Rx frame. */
-#ifdef CONFIG_NET_HW_FLOWCONTROL
-                                if (tp->fc_bit && !test_bit(tp->fc_bit, &netdev_fc_xoff)) {
-                                        tp->stats.rx_errors++;
-                                        tulip_outl_csr(tp, tp->csr6 | csr6_st | csr6_sr, CSR6);
-                                }
                                 tp->stats.rx_missed_errors += inl(ioaddr + CSR8) & 0xffff;
+#ifdef CONFIG_NET_HW_FLOWCONTROL
+				if (tp->fc_bit && !test_bit(tp->fc_bit, &netdev_fc_xoff)) {
+					tp->stats.rx_errors++;
+					tulip_start_rxtx(tp);
+				}
 #else
 				tp->stats.rx_errors++;
-				tp->stats.rx_missed_errors += inl(ioaddr + CSR8) & 0xffff;
-				tulip_outl_csr(tp, tp->csr6 | csr6_st | csr6_sr, CSR6);
+				tulip_start_rxtx(tp);
 #endif
 			}
 			/*
Index: linux_2_4/drivers/net/tulip/media.c
diff -u linux_2_4/drivers/net/tulip/media.c:1.1.1.33 linux_2_4/drivers/net/tulip/media.c:1.1.1.33.26.1
--- linux_2_4/drivers/net/tulip/media.c:1.1.1.33	Wed May 16 14:46:45 2001
+++ linux_2_4/drivers/net/tulip/media.c	Fri Jun  1 02:19:08 2001
@@ -411,7 +411,6 @@
   */
 int tulip_check_duplex(struct net_device *dev)
 {
-	long ioaddr = dev->base_addr;
 	struct tulip_private *tp = dev->priv;
 	unsigned int bmsr, lpa, negotiated, new_csr6;
 
@@ -442,11 +441,8 @@
 	else		     new_csr6 &= ~FullDuplex;
 
 	if (new_csr6 != tp->csr6) {
-		if (inl(ioaddr + CSR6) & (csr6_st | csr6_sr))
-			tulip_restart_rxtx(tp, new_csr6);
-		else
-			outl(new_csr6, ioaddr + CSR6);
 		tp->csr6 = new_csr6;
+		tulip_restart_rxtx(tp);
 
 		if (tulip_debug > 0)
 			printk(KERN_INFO "%s: Setting %s-duplex based on MII"
Index: linux_2_4/drivers/net/tulip/pnic.c
diff -u linux_2_4/drivers/net/tulip/pnic.c:1.1.1.34 linux_2_4/drivers/net/tulip/pnic.c:1.1.1.34.20.1
--- linux_2_4/drivers/net/tulip/pnic.c:1.1.1.34	Sat May 19 18:57:04 2001
+++ linux_2_4/drivers/net/tulip/pnic.c	Fri Jun  1 02:19:08 2001
@@ -45,7 +45,7 @@
 		if (tp->csr6 != new_csr6) {
 			tp->csr6 = new_csr6;
 			/* Restart Tx */
-			tulip_restart_rxtx(tp, tp->csr6);
+			tulip_restart_rxtx(tp);
 			dev->trans_start = jiffies;
 		}
 	}
@@ -69,7 +69,7 @@
 			return;
 		if (! tp->nwayset  ||  jiffies - dev->trans_start > 1*HZ) {
 			tp->csr6 = 0x00420000 | (tp->csr6 & 0x0000fdff);
-			tulip_outl_csr(tp, tp->csr6, CSR6);
+			outl(tp->csr6, ioaddr + CSR6);
 			outl(0x30, ioaddr + CSR12);
 			outl(0x0201F078, ioaddr + 0xB8); /* Turn on autonegotiation. */
 			dev->trans_start = jiffies;
@@ -148,7 +148,7 @@
 			if (tp->csr6 != new_csr6) {
 				tp->csr6 = new_csr6;
 				/* Restart Tx */
-				tulip_restart_rxtx(tp, tp->csr6);
+				tulip_restart_rxtx(tp);
 				dev->trans_start = jiffies;
 				if (tulip_debug > 1)
 					printk(KERN_INFO "%s: Changing PNIC configuration to %s "
Index: linux_2_4/drivers/net/tulip/timer.c
diff -u linux_2_4/drivers/net/tulip/timer.c:1.1.1.22 linux_2_4/drivers/net/tulip/timer.c:1.1.1.22.86.1
--- linux_2_4/drivers/net/tulip/timer.c:1.1.1.22	Tue Apr  3 18:32:43 2001
+++ linux_2_4/drivers/net/tulip/timer.c	Fri Jun  1 02:19:08 2001
@@ -158,7 +158,7 @@
 				       medianame[tp->mtable->mleaf[tp->cur_index].media]);
 			tulip_select_media(dev, 0);
 			/* Restart the transmit process. */
-			tulip_restart_rxtx(tp, tp->csr6);
+			tulip_restart_rxtx(tp);
 			next_tick = (24*HZ)/10;
 			break;
 		}
Index: linux_2_4/drivers/net/tulip/tulip.h
diff -u linux_2_4/drivers/net/tulip/tulip.h:1.1.1.34 linux_2_4/drivers/net/tulip/tulip.h:1.1.1.34.10.1
--- linux_2_4/drivers/net/tulip/tulip.h:1.1.1.34	Thu May 24 01:49:56 2001
+++ linux_2_4/drivers/net/tulip/tulip.h	Fri Jun  1 02:19:08 2001
@@ -22,6 +22,7 @@
 #include <linux/spinlock.h>
 #include <linux/netdevice.h>
 #include <linux/timer.h>
+#include <linux/delay.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 
@@ -139,10 +140,13 @@
 enum tulip_mode_bits {
 	TxThreshold		= (1 << 22),
 	FullDuplex		= (1 << 9),
+	TxOn			= 0x2000,
 	AcceptBroadcast		= 0x0100,
 	AcceptAllMulticast	= 0x0080,
 	AcceptAllPhys		= 0x0040,
 	AcceptRunt		= 0x0008,
+	RxOn			= 0x0002,
+	RxTx			= (TxOn | RxOn),
 };
 
 
@@ -219,7 +223,6 @@
 	 *   (1,1)   *    1024   *   160   *
 	 ***********************************/
 
-	csr6_st = (1<<13),   /* Transmit conrol: 1 = transmit, 0 = stop */
 	csr6_fc = (1<<12),   /* Forces a collision in next transmission (for testing in loopback mode) */
 	csr6_om_int_loop = (1<<10), /* internal (FIFO) loopback flag */
 	csr6_om_ext_loop = (1<<11), /* external (PMD) loopback flag */
@@ -231,7 +234,6 @@
 	csr6_if = (1<<4),    /* Inverse Filtering, rejects only addresses in address table: can't be set */
 	csr6_pb = (1<<3),    /* Pass Bad Frames, (1) causes even bad frames to be passed on */
 	csr6_ho = (1<<2),    /* Hash-only filtering mode: can't be set */
-	csr6_sr = (1<<1),    /* Start(1)/Stop(0) Receive */
 	csr6_hp = (1<<0),    /* Hash/Perfect Receive Filtering Mode: can't be set */
 
 	csr6_mask_capture = (csr6_sc | csr6_ca),
@@ -435,20 +437,31 @@
 extern u16 t21041_csr15[];
 
 
-static inline void tulip_outl_csr (struct tulip_private *tp, u32 newValue, enum tulip_offsets offset)
+static inline void tulip_start_rxtx(struct tulip_private *tp)
 {
-	outl (newValue, tp->base_addr + offset);
+	long ioaddr = tp->base_addr;
+	outl(tp->csr6 | RxTx, ioaddr + CSR6);
+	barrier();
+	(void) inl(ioaddr + CSR6); /* mmio sync */
 }
 
-static inline void tulip_stop_rxtx(struct tulip_private *tp, u32 csr6mask)
+static inline void tulip_stop_rxtx(struct tulip_private *tp)
 {
-	tulip_outl_csr(tp, csr6mask & ~(csr6_st | csr6_sr), CSR6);
+	long ioaddr = tp->base_addr;
+	u32 csr6 = inl(ioaddr + CSR6);
+
+	if (csr6 & RxTx) {
+		outl(csr6 & ~RxTx, ioaddr + CSR6);
+		barrier();
+		(void) inl(ioaddr + CSR6); /* mmio sync */
+	}
 }
 
-static inline void tulip_restart_rxtx(struct tulip_private *tp, u32 csr6mask)
+static inline void tulip_restart_rxtx(struct tulip_private *tp)
 {
-	tulip_outl_csr(tp, csr6mask | csr6_sr, CSR6);
-	tulip_outl_csr(tp, csr6mask | csr6_st | csr6_sr, CSR6);
+	tulip_stop_rxtx(tp);
+	udelay(5);
+	tulip_start_rxtx(tp);
 }
 
 #endif /* __NET_TULIP_H__ */
Index: linux_2_4/drivers/net/tulip/tulip_core.c
diff -u linux_2_4/drivers/net/tulip/tulip_core.c:1.1.1.50 linux_2_4/drivers/net/tulip/tulip_core.c:1.1.1.50.10.1
--- linux_2_4/drivers/net/tulip/tulip_core.c:1.1.1.50	Thu May 24 01:49:56 2001
+++ linux_2_4/drivers/net/tulip/tulip_core.c	Fri Jun  1 02:19:08 2001
@@ -15,8 +15,8 @@
 */
 
 #define DRV_NAME	"tulip"
-#define DRV_VERSION	"0.9.15-pre2"
-#define DRV_RELDATE	"May 16, 2001"
+#define DRV_VERSION	"0.9.15-pre3"
+#define DRV_RELDATE	"June 1, 2001"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -276,7 +276,7 @@
 
 	/* On some chip revs we must set the MII/SYM port before the reset!? */
 	if (tp->mii_cnt  ||  (tp->mtable  &&  tp->mtable->has_mii))
-		tulip_outl_csr (tp, 0x00040000, CSR6);
+		outl(0x00040000, ioaddr + CSR6);
 
 	/* Reset the chip, holding bit 0 set at least 50 PCI cycles. */
 	outl(0x00000001, ioaddr + CSR0);
@@ -409,7 +409,7 @@
 				printk(KERN_INFO "%s: Using MII transceiver %d, status "
 					   "%4.4x.\n",
 					   dev->name, tp->phys[0], tulip_mdio_read(dev, tp->phys[0], 1));
-			tulip_outl_csr(tp, csr6_mask_defstate, CSR6);
+			outl(csr6_mask_defstate, ioaddr + CSR6);
 			tp->csr6 = csr6_mask_hdcap;
 			dev->if_port = 11;
 			outl(0x0000, ioaddr + CSR13);
@@ -455,13 +455,15 @@
 		tulip_select_media(dev, 1);
 
 	/* Start the chip's Tx to process setup frame. */
-	tulip_outl_csr(tp, tp->csr6, CSR6);
-	tulip_outl_csr(tp, tp->csr6 | csr6_st, CSR6);
+	tulip_stop_rxtx(tp);
+	barrier();
+	udelay(5);
+	outl(tp->csr6 | TxOn, ioaddr + CSR6);
 
 	/* Enable interrupts by setting the interrupt mask. */
 	outl(tulip_tbl[tp->chip_id].valid_intrs, ioaddr + CSR5);
 	outl(tulip_tbl[tp->chip_id].valid_intrs, ioaddr + CSR7);
-	tulip_outl_csr(tp, tp->csr6 | csr6_st | csr6_sr, CSR6);
+	tulip_start_rxtx(tp);
 	outl(0, ioaddr + CSR2);		/* Rx poll demand */
 
 	if (tulip_debug > 2) {
@@ -626,7 +628,7 @@
         if (tp->fc_bit && test_bit(tp->fc_bit,&netdev_fc_xoff))
                 printk("BUG tx_timeout restarting rx when fc on\n");
 #endif
-	tulip_restart_rxtx(tp, tp->csr6);
+	tulip_restart_rxtx(tp);
 	/* Trigger an immediate transmit demand. */
 	outl(0, ioaddr + CSR1);
 
@@ -756,7 +758,7 @@
 	outl (0x00000000, ioaddr + CSR7);
 
 	/* Stop the Tx and Rx processes. */
-	tulip_stop_rxtx(tp, inl(ioaddr + CSR6));
+	tulip_stop_rxtx(tp);
 
 	/* 21040 -- Leave the card in 10baseT state. */
 	if (tp->chip_id == DC21040)
@@ -1193,8 +1195,7 @@
 		spin_unlock_irqrestore(&tp->lock, flags);
 	}
 
-	/* Can someone explain to me what the OR here is supposed to accomplish???? */
-	tulip_outl_csr(tp, csr6 | 0x0000, CSR6);
+	outl(csr6, ioaddr + CSR6);
 }
 
 static void __devinit tulip_mwi_config (struct pci_dev *pdev,
@@ -1437,7 +1438,7 @@
 		tulip_mwi_config (pdev, dev);
 
 	/* Stop the chip's Tx and Rx processes. */
-	tulip_stop_rxtx(tp, inl(ioaddr + CSR6));
+	tulip_stop_rxtx(tp);
 
 	/* Clear the missed-packet counter. */
 	inl(ioaddr + CSR8);
@@ -1631,7 +1632,7 @@
 		outl(0x00000000, ioaddr + CSR13);
 		outl(0xFFFFFFFF, ioaddr + CSR14);
 		outl(0x00000008, ioaddr + CSR15); /* Listen on AUI also. */
-		tulip_outl_csr(tp, inl(ioaddr + CSR6) | csr6_fd, CSR6);
+		outl(inl(ioaddr + CSR6) | csr6_fd, ioaddr + CSR6);
 		outl(0x0000EF01, ioaddr + CSR13);
 		break;
 	case DC21040:
@@ -1647,10 +1648,10 @@
 	case DC21142:
 	case PNIC2:
 		if (tp->mii_cnt  ||  tulip_media_cap[dev->if_port] & MediaIsMII) {
-			tulip_outl_csr(tp, csr6_mask_defstate, CSR6);
+			outl(csr6_mask_defstate, ioaddr + CSR6);
 			outl(0x0000, ioaddr + CSR13);
 			outl(0x0000, ioaddr + CSR14);
-			tulip_outl_csr(tp, csr6_mask_hdcap, CSR6);
+			outl(csr6_mask_hdcap, ioaddr + CSR6);
 		} else
 			t21142_start_nway(dev);
 		break;
@@ -1658,21 +1659,21 @@
 		if ( ! tp->mii_cnt) {
 			tp->nway = 1;
 			tp->nwayset = 0;
-			tulip_outl_csr(tp, csr6_ttm | csr6_ca, CSR6);
+			outl(csr6_ttm | csr6_ca, ioaddr + CSR6);
 			outl(0x30, ioaddr + CSR12);
-			tulip_outl_csr(tp, 0x0001F078, CSR6);
-			tulip_outl_csr(tp, 0x0201F078, CSR6); /* Turn on autonegotiation. */
+			outl(0x0001F078, ioaddr + CSR6);
+			outl(0x0201F078, ioaddr + CSR6); /* Turn on autonegotiation. */
 		}
 		break;
 	case MX98713:
 	case COMPEX9881:
-		tulip_outl_csr(tp, 0x00000000, CSR6);
+		outl(0x00000000, ioaddr + CSR6);
 		outl(0x000711C0, ioaddr + CSR14); /* Turn on NWay. */
 		outl(0x00000001, ioaddr + CSR13);
 		break;
 	case MX98715:
 	case MX98725:
-		tulip_outl_csr(tp, 0x01a80000, CSR6);
+		outl(0x01a80000, ioaddr + CSR6);
 		outl(0xFFFFFFFF, ioaddr + CSR14);
 		outl(0x00001000, ioaddr + CSR12);
 		break;

--------------0C5397F298FD787AA590C660--

