Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266809AbSK1Wtj>; Thu, 28 Nov 2002 17:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266817AbSK1Wtj>; Thu, 28 Nov 2002 17:49:39 -0500
Received: from [195.39.17.254] ([195.39.17.254]:26116 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266809AbSK1Wtf>;
	Thu, 28 Nov 2002 17:49:35 -0500
Date: Thu, 28 Nov 2002 21:52:45 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>, perex@suse.cz
Subject: hp100: more cleanups, print coax vs. 10baseT
Message-ID: <20021128205244.GA10512@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here's patch, unfortunately it does not make coax on hp100 work. If
you know how to make it work, please let me know.

Network is correctly recognized as 10Mb/s network (coax), but I can't
push packets through it.

								Pavel

--- clean/drivers/net/hp100.c	2002-11-23 19:55:22.000000000 +0100
+++ linux-swsusp/drivers/net/hp100.c	2002-11-28 21:50:11.000000000 +0100
@@ -117,7 +117,6 @@
 #include <asm/bitops.h>
 #include <asm/io.h>
 
-#define LINUX_2_1
 typedef struct net_device_stats hp100_stats_t;
 
 #include "hp100.h"
@@ -285,7 +284,6 @@
 
 #define HP100_PCI_IDS_SIZE	(sizeof(hp100_pci_ids)/sizeof(struct hp100_pci_id))
 
-#if LINUX_VERSION_CODE >= 0x20400
 static struct pci_device_id hp100_pci_tbl[] __initdata = {
 	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_J2585A, PCI_ANY_ID, PCI_ANY_ID,},
 	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_J2585B, PCI_ANY_ID, PCI_ANY_ID,},
@@ -294,7 +292,6 @@
 	{}			/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(pci, hp100_pci_tbl);
-#endif				/* LINUX_VERSION_CODE >= 0x20400 */
 
 static int hp100_rx_ratio = HP100_DEFAULT_RX_RATIO;
 static int hp100_priority_tx = HP100_DEFAULT_PRIORITY_TX;
@@ -356,8 +353,8 @@
  * address - Jean II */
 static inline dma_addr_t virt_to_whatever(struct net_device *dev, u32 * ptr)
 {
-  return ((u_long) ptr) +
-    ((struct hp100_private *) (dev->priv))->whatever_offset;
+	return ((u_long) ptr) +
+		((struct hp100_private *) (dev->priv))->whatever_offset;
 }
 
 /* TODO: This function should not really be needed in a good design... */
@@ -376,9 +373,7 @@
 {
 	int base_addr = dev ? dev->base_addr : 0;
 	int ioaddr = 0;
-#ifdef CONFIG_PCI
 	int pci_start_index = 0;
-#endif
 
 #ifdef HP100_DEBUG_B
 	hp100_outw(0x4200, TRACE);
@@ -854,7 +849,10 @@
 		printk("100Mb/s Voice Grade AnyLAN network.\n");
 		break;
 	case HP100_LAN_10:
-		printk("10Mb/s network.\n");
+		printk("10Mb/s network (10baseT).\n");
+		break;
+	case HP100_LAN_COAX:
+		printk("10Mb/s network (coax).\n");
 		break;
 	default:
 		printk("Warning! Link down.\n");
@@ -889,7 +887,7 @@
 		wait();
 	} else {
 		hp100_outw(HP100_INT_EN | HP100_RESET_LB, OPTION_LSW);
-		hp100_cascade_reset(dev, TRUE);
+		hp100_cascade_reset(dev, 1);
 		hp100_page(MAC_CTRL);
 		hp100_andb(~(HP100_RX_EN | HP100_TX_EN), MAC_CFG_1);
 	}
@@ -900,7 +898,7 @@
 	wait();
 
 	/* Go into reset again. */
-	hp100_cascade_reset(dev, TRUE);
+	hp100_cascade_reset(dev, 1);
 
 	/* Set Option Registers to a safe state  */
 	hp100_outw(HP100_DEBUG_EN |
@@ -943,13 +941,13 @@
 	wait();			/* TODO: Do we really need this? */
 
 	/* Enable Hardware (e.g. unreset) */
-	hp100_cascade_reset(dev, FALSE);
+	hp100_cascade_reset(dev, 0);
 
 	/* ------- initialisation complete ----------- */
 
 	/* Finally try to log in the Hub if there may be a VG connection. */
-	if (lp->lan_type != HP100_LAN_10)
-		hp100_login_to_vg_hub(dev, FALSE);	/* relogin */
+	if ((lp->lan_type == HP100_LAN_100) || (lp->lan_type == HP100_LAN_ERR))
+		hp100_login_to_vg_hub(dev, 0);	/* relogin */
 }
 
 
@@ -1191,7 +1189,7 @@
 	hp100_stop_interface(dev);
 
 	if (lp->lan_type == HP100_LAN_100)
-		lp->hub_status = hp100_login_to_vg_hub(dev, FALSE);
+		lp->hub_status = hp100_login_to_vg_hub(dev, 0);
 
 	netif_stop_queue(dev);
 
@@ -1508,13 +1506,31 @@
 			hp100_andb(~HP100_BM_MASTER, BM);
 		}	/* end of shutdown procedure for non-etr parts */
 
-		hp100_cascade_reset(dev, TRUE);
+		hp100_cascade_reset(dev, 1);
 	}
 	hp100_page(PERFORMANCE);
 	/* hp100_outw( HP100_BM_READ | HP100_BM_WRITE | HP100_RESET_HB, OPTION_LSW ); */
 	/* Busmaster mode should be shut down now. */
 }
 
+static int hp100_check_lan(struct net_device *dev)
+{
+	struct hp100_private *lp = (struct hp100_private *) dev->priv;
+
+	if (lp->lan_type < 0) {	/* no LAN type detected yet? */
+		hp100_stop_interface(dev);
+		if ((lp->lan_type = hp100_sense_lan(dev)) < 0) {
+			printk("hp100: %s: no connection found - check wire\n", dev->name);
+			hp100_start_interface(dev);	/* 10Mb/s RX packets maybe handled */
+			return -EIO;
+		}
+		if (lp->lan_type == HP100_LAN_100)
+			lp->hub_status = hp100_login_to_vg_hub(dev, 0);	/* relogin */
+		hp100_start_interface(dev);
+	}
+	return 0;
+}
+
 /* 
  *  transmit functions
  */
@@ -1550,23 +1566,14 @@
 		if (jiffies - dev->trans_start < HZ)
 			return -EAGAIN;
 
-		if (lp->lan_type < 0) {	/* no LAN type detected yet? */
-			hp100_stop_interface(dev);
-			if ((lp->lan_type = hp100_sense_lan(dev)) < 0) {
-				printk("hp100: %s: no connection found - check wire\n", dev->name);
-				hp100_start_interface(dev);	/* 10Mb/s RX pkts maybe handled */
-				return -EIO;
-			}
-			if (lp->lan_type == HP100_LAN_100)
-				lp->hub_status = hp100_login_to_vg_hub(dev, FALSE);	/* relogin */
-			hp100_start_interface(dev);
-		}
+		if (hp100_check_lan(dev))
+			return -EIO;
 
 		if (lp->lan_type == HP100_LAN_100 && lp->hub_status < 0) {
 			/* we have a 100Mb/s adapter but it isn't connected to hub */
 			printk("hp100: %s: login to 100Mb/s hub retry\n", dev->name);
 			hp100_stop_interface(dev);
-			lp->hub_status = hp100_login_to_vg_hub(dev, FALSE);
+			lp->hub_status = hp100_login_to_vg_hub(dev, 0);
 			hp100_start_interface(dev);
 		} else {
 			spin_lock_irqsave(&lp->lock, flags);
@@ -1577,18 +1584,18 @@
 			if (i == HP100_LAN_ERR)
 				printk("hp100: %s: link down detected\n", dev->name);
 			else if (lp->lan_type != i) {	/* cable change! */
-				/* it's very hard - all network setting must be changed!!! */
+				/* it's very hard - all network settings must be changed!!! */
 				printk("hp100: %s: cable change 10Mb/s <-> 100Mb/s detected\n", dev->name);
 				lp->lan_type = i;
 				hp100_stop_interface(dev);
 				if (lp->lan_type == HP100_LAN_100)
-					lp->hub_status = hp100_login_to_vg_hub(dev, FALSE);
+					lp->hub_status = hp100_login_to_vg_hub(dev, 0);
 				hp100_start_interface(dev);
 			} else {
 				printk("hp100: %s: interface reset\n", dev->name);
 				hp100_stop_interface(dev);
 				if (lp->lan_type == HP100_LAN_100)
-					lp->hub_status = hp100_login_to_vg_hub(dev, FALSE);
+					lp->hub_status = hp100_login_to_vg_hub(dev, 0);
 				hp100_start_interface(dev);
 			}
 		}
@@ -1699,17 +1706,8 @@
 	if (skb->len <= 0)
 		return 0;
 
-	if (lp->lan_type < 0) {	/* no LAN type detected yet? */
-		hp100_stop_interface(dev);
-		if ((lp->lan_type = hp100_sense_lan(dev)) < 0) {
-			printk("hp100: %s: no connection found - check wire\n", dev->name);
-			hp100_start_interface(dev);	/* 10Mb/s RX packets maybe handled */
-			return -EIO;
-		}
-		if (lp->lan_type == HP100_LAN_100)
-			lp->hub_status = hp100_login_to_vg_hub(dev, FALSE);	/* relogin */
-		hp100_start_interface(dev);
-	}
+	if (hp100_check_lan(dev))
+		return -EIO;
 
 	/* If there is not enough free memory on the card... */
 	i = hp100_inl(TX_MEM_FREE) & 0x7fffffff;
@@ -1729,7 +1727,7 @@
 			/* we have a 100Mb/s adapter but it isn't connected to hub */
 			printk("hp100: %s: login to 100Mb/s hub retry\n", dev->name);
 			hp100_stop_interface(dev);
-			lp->hub_status = hp100_login_to_vg_hub(dev, FALSE);
+			lp->hub_status = hp100_login_to_vg_hub(dev, 0);
 			hp100_start_interface(dev);
 		} else {
 			spin_lock_irqsave(&lp->lock, flags);
@@ -1745,13 +1743,13 @@
 				lp->lan_type = i;
 				hp100_stop_interface(dev);
 				if (lp->lan_type == HP100_LAN_100)
-					lp->hub_status = hp100_login_to_vg_hub(dev, FALSE);
+					lp->hub_status = hp100_login_to_vg_hub(dev, 0);
 				hp100_start_interface(dev);
 			} else {
 				printk("hp100: %s: interface reset\n", dev->name);
 				hp100_stop_interface(dev);
 				if (lp->lan_type == HP100_LAN_100)
-					lp->hub_status = hp100_login_to_vg_hub(dev, FALSE);
+					lp->hub_status = hp100_login_to_vg_hub(dev, 0);
 				hp100_start_interface(dev);
 				mdelay(1);
 			}
@@ -2220,7 +2218,7 @@
 #ifdef HP100_DEBUG
 			printk("hp100: %s: 100VG MAC settings have changed - relogin.\n", dev->name);
 #endif
-			lp->hub_status = hp100_login_to_vg_hub(dev, TRUE);	/* force a relogin to the hub */
+			lp->hub_status = hp100_login_to_vg_hub(dev, 1);	/* force a relogin to the hub */
 		}
 	} else {
 		int i;
@@ -2245,7 +2243,7 @@
 #ifdef HP100_DEBUG
 				printk("hp100: %s: 100VG MAC settings have changed - relogin.\n", dev->name);
 #endif
-				lp->hub_status = hp100_login_to_vg_hub(dev, TRUE);	/* force a relogin to the hub */
+				lp->hub_status = hp100_login_to_vg_hub(dev, 1);	/* force a relogin to the hub */
 			}
 		}
 	}
@@ -2539,7 +2537,7 @@
 		hp100_page(MAC_CTRL);
 		hp100_outb(val_10, 10_LAN_CFG_1);
 		hp100_page(PERFORMANCE);
-		return HP100_LAN_10;
+		return HP100_LAN_COAX;
 	}
 
 	if ((lp->id->id == 0x02019F022) ||
@@ -2685,7 +2683,7 @@
 	 */
 	hp100_page(MAC_CTRL);
 	startst = hp100_inb(VG_LAN_CFG_1);
-	if ((force_relogin == TRUE) || (hp100_inb(MAC_CFG_4) & HP100_MAC_SEL_ST)) {
+	if ((force_relogin == 1) || (hp100_inb(MAC_CFG_4) & HP100_MAC_SEL_ST)) {
 #ifdef HP100_DEBUG_TRAINING
 		printk("hp100: %s: Start training\n", dev->name);
 #endif
@@ -2847,7 +2845,7 @@
 	printk("hp100: %s: cascade_reset\n", dev->name);
 #endif
 
-	if (enable == TRUE) {
+	if (enable) {
 		hp100_outw(HP100_HW_RST | HP100_RESET_LB, OPTION_LSW);
 		if (lp->chip == HP100_CHIPID_LASSEN) {
 			/* Lassen requires a PCI transmit fifo reset */
--- clean/drivers/net/hp100.h	2001-05-16 19:25:38.000000000 +0200
+++ linux-swsusp/drivers/net/hp100.h	2002-11-28 21:18:09.000000000 +0100
@@ -518,12 +518,9 @@
  */
 #define HP100_LAN_100		100	/* lan_type value for VG */
 #define HP100_LAN_10		10	/* lan_type value for 10BaseT */
+#define HP100_LAN_COAX		9	/* lan_type value for Coax */
 #define HP100_LAN_ERR		(-1)	/* lan_type value for link down */
 
-#define TRUE 1
-#define FALSE 0
-
-
 /* 
  * Bus Master Data Structures  ----------------------------------------------
  */
Binary files /dev/null and linux-swsusp/drivers/net/hp100.o differ

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
