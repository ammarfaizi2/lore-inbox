Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262640AbVCDE0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbVCDE0K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 23:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVCDETO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 23:19:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36059 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262610AbVCDD7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 22:59:06 -0500
Message-ID: <4227DCE9.2040604@pobox.com>
Date: Thu, 03 Mar 2005 22:58:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev <netdev@oss.sgi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, ionut@badula.org
Subject: [PATCH, RFT] starfire net driver update
Content-Type: multipart/mixed;
 boundary="------------070300050900020608080705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070300050900020608080705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The starfire net driver was just updated to include the firmware that 
Adaptec kindly GPL'd for us a while ago.  The firmware is needed to 
enable zero-copy.

Can someone with this card give it a test, to make sure all is still 
working?

Particularly, if you could test an application that uses sendfile(2) 
[zero-copy], that would be useful.

	Jeff



--------------070300050900020608080705
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

#
# ChangeSet
#   2005/03/03 22:53:40-05:00 jgarzik@pobox.com 
#   [netdrvr starfire] Add GPL'd firmware, remove compat code
#   
#   Contributed by Ion Badulescu <ionut@badula.org>,
#   further fixed up by me.
# 
diff -Nru a/drivers/net/starfire.c b/drivers/net/starfire.c
--- a/drivers/net/starfire.c	2005-03-03 22:53:54 -05:00
+++ b/drivers/net/starfire.c	2005-03-03 22:53:54 -05:00
@@ -2,7 +2,7 @@
 /*
 	Written 1998-2000 by Donald Becker.
 
-	Current maintainer is Ion Badulescu <ionut@cs.columbia.edu>. Please
+	Current maintainer is Ion Badulescu <ionut ta badula tod org>. Please
 	send all bug reports to me, and not to Donald Becker, as this code
 	has been heavily modified from Donald's original version.
 
@@ -129,12 +129,18 @@
 	- put the chip to a D3 slumber on driver unload
 	- added config option to enable/disable NAPI
 
-TODO:	bugfixes (no bugs known as of right now)
+	LK1.4.2 (Ion Badulescu)
+	- finally added firmware (GPL'ed by Adaptec)
+	- removed compatibility code for 2.2.x
+
+TODO:	- fix forced speed/duplexing code (broken a long time ago, when
+	somebody converted the driver to use the generic MII code)
+	- fix VLAN support
 */
 
 #define DRV_NAME	"starfire"
-#define DRV_VERSION	"1.03+LK1.4.1"
-#define DRV_RELDATE	"February 10, 2002"
+#define DRV_VERSION	"1.03+LK1.4.2"
+#define DRV_RELDATE	"January 19, 2005"
 
 #include <linux/config.h>
 #include <linux/version.h>
@@ -145,25 +151,15 @@
 #include <linux/etherdevice.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/crc32.h>
+#include <linux/ethtool.h>
+#include <linux/mii.h>
+#include <linux/if_vlan.h>
 #include <asm/processor.h>		/* Processor type for cache alignment. */
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
-/*
- * Adaptec's license for their drivers (which is where I got the
- * firmware files) does not allow one to redistribute them. Thus, we can't
- * include the firmware with this driver.
- *
- * However, should a legal-to-distribute firmware become available,
- * the driver developer would need only to obtain the firmware in the
- * form of a C header file.
- * Once that's done, the #undef below must be changed into a #define
- * for this driver to really use the firmware. Note that Rx/Tx
- * hardware TCP checksumming is not possible without the firmware.
- *
- * WANTED: legal firmware to include with this GPL'd driver.
- */
-#undef HAS_FIRMWARE
+#include "starfire_firmware.h"
 /*
  * The current frame processor firmware fails to checksum a fragment
  * of length 1. If and when this is fixed, the #define below can be removed.
@@ -172,13 +168,7 @@
 /*
  * Define this if using the driver with the zero-copy patch
  */
-#if defined(HAS_FIRMWARE) && defined(MAX_SKB_FRAGS)
 #define ZEROCOPY
-#endif
-
-#ifdef HAS_FIRMWARE
-#include "starfire_firmware.h"
-#endif /* HAS_FIRMWARE */
 
 #if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 #define VLAN_SUPPORT
@@ -202,11 +192,7 @@
    The Starfire has a 512 element hash table based on the Ethernet CRC. */
 static int multicast_filter_limit = 512;
 /* Whether to do TCP/UDP checksums in hardware */
-#ifdef HAS_FIRMWARE
 static int enable_hw_cksum = 1;
-#else
-static int enable_hw_cksum = 0;
-#endif
 
 #define PKT_BUF_SZ	1536		/* Size of each temporary Rx buffer.*/
 /*
@@ -291,43 +277,15 @@
 #define RX_DESC_ADDR_SIZE RxDescAddr32bit
 #endif
 
-#ifdef MAX_SKB_FRAGS
 #define skb_first_frag_len(skb)	skb_headlen(skb)
 #define skb_num_frags(skb) (skb_shinfo(skb)->nr_frags + 1)
-#else  /* not MAX_SKB_FRAGS */
-#define skb_first_frag_len(skb)	(skb->len)
-#define skb_num_frags(skb) 1
-#endif /* not MAX_SKB_FRAGS */
-
-/* 2.2.x compatibility code */
-#if LINUX_VERSION_CODE < 0x20300
-
-#include "starfire-kcomp22.h"
-
-#else  /* LINUX_VERSION_CODE > 0x20300 */
-
-#include <linux/crc32.h>
-#include <linux/ethtool.h>
-#include <linux/mii.h>
-
-#include <linux/if_vlan.h>
-
-#define init_tx_timer(dev, func, timeout) \
-	dev->tx_timeout = func; \
-	dev->watchdog_timeo = timeout;
-#define kick_tx_timer(dev, func, timeout)
-
-#define netif_start_if(dev)
-#define netif_stop_if(dev)
-
-#define PCI_SLOT_NAME(pci_dev)	pci_name(pci_dev)
-
-#endif /* LINUX_VERSION_CODE > 0x20300 */
 
 #ifdef HAVE_NETDEV_POLL
 #define init_poll(dev) \
+do { \
 	dev->poll = &netdev_poll; \
-	dev->weight = max_interrupt_work;
+	dev->weight = max_interrupt_work; \
+} while (0)
 #define netdev_rx(dev, ioaddr) \
 do { \
 	u32 intr_enable; \
@@ -341,7 +299,7 @@
 		/* Paranoia check */ \
 		intr_enable = readl(ioaddr + IntrEnable); \
 		if (intr_enable & (IntrRxDone | IntrRxEmpty)) { \
-			printk("%s: interrupt while in polling mode!\n", dev->name); \
+			printk(KERN_INFO "%s: interrupt while in polling mode!\n", dev->name); \
 			intr_enable &= ~(IntrRxDone | IntrRxEmpty); \
 			writel(intr_enable, ioaddr + IntrEnable); \
 		} \
@@ -371,6 +329,7 @@
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("Adaptec Starfire Ethernet driver");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
 
 module_param(max_interrupt_work, int, 0);
 module_param(mtu, int, 0);
@@ -425,7 +384,7 @@
 minimum-length padding.  It does not use the completion queue
 consumer index, but instead checks for non-zero status entries.
 
-For receive this driver uses type 0/1/2/3 receive descriptors.  The driver
+For receive this driver uses type 2/3 receive descriptors.  The driver
 allocates full frame size skbuffs for the Rx ring buffers, so all frames
 should fit in a single descriptor.  The driver does not use the completion
 queue consumer index, but instead checks for non-zero status entries.
@@ -476,7 +435,7 @@
 
 */
 
-
+
 
 enum chip_capability_flags {CanHaveMII=1, };
 
@@ -670,7 +629,6 @@
 	u32 timestamp;
 };
 /* XXX: this is ugly and I'm not sure it's worth the trouble -Ion */
-#ifdef HAS_FIRMWARE
 #ifdef VLAN_SUPPORT
 typedef struct full_rx_done_desc rx_done_desc;
 #define RxComplType RxComplType3
@@ -678,15 +636,6 @@
 typedef struct csum_rx_done_desc rx_done_desc;
 #define RxComplType RxComplType2
 #endif /* not VLAN_SUPPORT */
-#else  /* not HAS_FIRMWARE */
-#ifdef VLAN_SUPPORT
-typedef struct basic_rx_done_desc rx_done_desc;
-#define RxComplType RxComplType1
-#else  /* not VLAN_SUPPORT */
-typedef struct short_rx_done_desc rx_done_desc;
-#define RxComplType RxComplType0
-#endif /* not VLAN_SUPPORT */
-#endif /* not HAS_FIRMWARE */
 
 enum rx_done_bits {
 	RxOK=0x20000000, RxFIFOErr=0x10000000, RxBufQ2=0x08000000,
@@ -898,13 +847,10 @@
 	/* enable MWI -- it vastly improves Rx performance on sparc64 */
 	pci_set_mwi(pdev);
 
-#ifdef MAX_SKB_FRAGS
-	dev->features |= NETIF_F_SG;
-#endif /* MAX_SKB_FRAGS */
 #ifdef ZEROCOPY
 	/* Starfire can do TCP/UDP checksumming */
 	if (enable_hw_cksum)
-		dev->features |= NETIF_F_IP_CSUM;
+		dev->features |= NETIF_F_IP_CSUM | NETIF_F_SG;
 #endif /* ZEROCOPY */
 #ifdef VLAN_SUPPORT
 	dev->features |= NETIF_F_HW_VLAN_RX | NETIF_F_HW_VLAN_FILTER;
@@ -1008,7 +954,8 @@
 	/* The chip-specific entries in the device structure. */
 	dev->open = &netdev_open;
 	dev->hard_start_xmit = &start_tx;
-	init_tx_timer(dev, tx_timeout, TX_TIMEOUT);
+	dev->tx_timeout = tx_timeout;
+	dev->watchdog_timeo = TX_TIMEOUT;
 	init_poll(dev);
 	dev->stop = &netdev_close;
 	dev->get_stats = &get_stats;
@@ -1039,7 +986,7 @@
 				if ((mdio_read(dev, phy, MII_BMCR) & BMCR_RESET) == 0)
 					break;
 			if (boguscnt == 0) {
-				printk("%s: PHY reset never completed!\n", dev->name);
+				printk("%s: PHY#%d reset never completed!\n", dev->name, phy);
 				continue;
 			}
 			mii_status = mdio_read(dev, phy, MII_BMSR);
@@ -1110,6 +1057,7 @@
 	size_t tx_done_q_size, rx_done_q_size, tx_ring_size, rx_ring_size;
 
 	/* Do we ever need to reset the chip??? */
+
 	retval = request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev);
 	if (retval)
 		return retval;
@@ -1211,7 +1159,6 @@
 
 	writel(np->intr_timer_ctrl, ioaddr + IntrTimerCtrl);
 
-	netif_start_if(dev);
 	netif_start_queue(dev);
 
 	if (debug > 1)
@@ -1238,13 +1185,11 @@
 	writel(ETH_P_8021Q, ioaddr + VlanType);
 #endif /* VLAN_SUPPORT */
 
-#ifdef HAS_FIRMWARE
 	/* Load Rx/Tx firmware into the frame processors */
 	for (i = 0; i < FIRMWARE_RX_SIZE * 2; i++)
 		writel(firmware_rx[i], ioaddr + RxGfpMem + i * 4);
 	for (i = 0; i < FIRMWARE_TX_SIZE * 2; i++)
 		writel(firmware_tx[i], ioaddr + TxGfpMem + i * 4);
-#endif /* HAS_FIRMWARE */
 	if (enable_hw_cksum)
 		/* Enable the Rx and Tx units, and the Rx/Tx frame processors. */
 		writel(TxEnable|TxGFPEnable|RxEnable|RxGFPEnable, ioaddr + GenCtrl);
@@ -1378,8 +1323,6 @@
 	u32 status;
 	int i;
 
-	kick_tx_timer(dev, tx_timeout, TX_TIMEOUT);
-
 	/*
 	 * be cautious here, wrapping the queue has weird semantics
 	 * and we may not have enough slots even when it seems we do.
@@ -1404,7 +1347,7 @@
 		}
 
 		if (has_bad_length)
-			skb_checksum_help(skb);
+			skb_checksum_help(skb, 0);
 	}
 #endif /* ZEROCOPY && HAS_BROKEN_FIRMWARE */
 
@@ -1433,12 +1376,10 @@
 			np->tx_info[entry].mapping =
 				pci_map_single(np->pci_dev, skb->data, skb_first_frag_len(skb), PCI_DMA_TODEVICE);
 		} else {
-#ifdef MAX_SKB_FRAGS
 			skb_frag_t *this_frag = &skb_shinfo(skb)->frags[i - 1];
 			status |= this_frag->size;
 			np->tx_info[entry].mapping =
 				pci_map_single(np->pci_dev, page_address(this_frag->page) + this_frag->page_offset, this_frag->size, PCI_DMA_TODEVICE);
-#endif /* MAX_SKB_FRAGS */
 		}
 
 		np->tx_ring[entry].addr = cpu_to_dma(np->tx_info[entry].mapping);
@@ -1531,7 +1472,6 @@
 				np->tx_info[entry].mapping = 0;
 				np->dirty_tx += np->tx_info[entry].used_slots;
 				entry = (entry + np->tx_info[entry].used_slots) % TX_RING_SIZE;
-#ifdef MAX_SKB_FRAGS
 				{
 					int i;
 					for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
@@ -1543,7 +1483,7 @@
 						entry++;
 					}
 				}
-#endif /* MAX_SKB_FRAGS */
+
 				dev_kfree_skb_irq(skb);
 			}
 			np->tx_done_q[np->tx_done].status = 0;
@@ -1603,7 +1543,7 @@
 		if (debug > 4)
 			printk(KERN_DEBUG "  netdev_rx() status of %d was %#8.8x.\n", np->rx_done, desc_status);
 		if (!(desc_status & RxOK)) {
-			/* There was a error. */
+			/* There was an error. */
 			if (debug > 2)
 				printk(KERN_DEBUG "  netdev_rx() Rx error was %#8.8x.\n", desc_status);
 			np->stats.rx_errors++;
@@ -1656,11 +1596,10 @@
 #endif
 
 		skb->protocol = eth_type_trans(skb, dev);
-#if defined(HAS_FIRMWARE) || defined(VLAN_SUPPORT)
+#ifdef VLAN_SUPPORT
 		if (debug > 4)
 			printk(KERN_DEBUG "  netdev_rx() status2 of %d was %#4.4x.\n", np->rx_done, le16_to_cpu(desc->status2));
 #endif
-#ifdef HAS_FIRMWARE
 		if (le16_to_cpu(desc->status2) & 0x0100) {
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 			np->stats.rx_compressed++;
@@ -1679,7 +1618,6 @@
 			skb->csum = le16_to_cpu(desc->csum);
 			printk(KERN_DEBUG "%s: checksum_hw, status2 = %#x\n", dev->name, le16_to_cpu(desc->status2));
 		}
-#endif /* HAS_FIRMWARE */
 #ifdef VLAN_SUPPORT
 		if (np->vlgrp && le16_to_cpu(desc->status2) & 0x0200) {
 			if (debug > 4)
@@ -1900,9 +1838,6 @@
 }
 
 
-/* Chips may use the upper or lower CRC bits, and may reverse and/or invert
-   them.  Select the endian-ness that results in minimal calculations.
-*/
 static void set_rx_mode(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
@@ -1969,6 +1904,8 @@
 		memset(mc_filter, 0, sizeof(mc_filter));
 		for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
 		     i++, mclist = mclist->next) {
+			/* The chip uses the upper 9 CRC bits
+			   as index into the hash table */
 			int bit_nr = ether_crc_le(ETH_ALEN, mclist->dmi_addr) >> 23;
 			__u32 *fptr = (__u32 *) &mc_filter[(bit_nr >> 4) & ~1];
 
@@ -2001,7 +1938,7 @@
 	struct netdev_private *np = netdev_priv(dev);
 	strcpy(info->driver, DRV_NAME);
 	strcpy(info->version, DRV_VERSION);
-	strcpy(info->bus_info, PCI_SLOT_NAME(np->pci_dev));
+	strcpy(info->bus_info, pci_name(np->pci_dev));
 }
 
 static int get_settings(struct net_device *dev, struct ethtool_cmd *ecmd)
@@ -2083,7 +2020,6 @@
 	int i;
 
 	netif_stop_queue(dev);
-	netif_stop_if(dev);
 
 	if (debug > 1) {
 		printk(KERN_DEBUG "%s: Shutting down ethercard, Intr status %#8.8x.\n",
@@ -2184,7 +2120,13 @@
 /* when a module, this is printed whether or not devices are found in probe */
 #ifdef MODULE
 	printk(version);
+#ifdef HAVE_NETDEV_POLL
+	printk(KERN_INFO DRV_NAME ": polling (NAPI) enabled\n");
+#else
+	printk(KERN_INFO DRV_NAME ": polling (NAPI) disabled\n");
 #endif
+#endif
+
 #ifndef ADDR_64BITS
 	/* we can do this test only at run-time... sigh */
 	if (sizeof(dma_addr_t) == sizeof(u64)) {
@@ -2192,10 +2134,6 @@
 		return -ENODEV;
 	}
 #endif /* not ADDR_64BITS */
-#ifndef HAS_FIRMWARE
-	/* unconditionally disable hw cksums if firmware is not present */
-	enable_hw_cksum = 0;
-#endif /* not HAS_FIRMWARE */
 	return pci_module_init (&starfire_driver);
 }
 
diff -Nru a/drivers/net/starfire_firmware.h b/drivers/net/starfire_firmware.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/net/starfire_firmware.h	2005-03-03 22:53:54 -05:00
@@ -0,0 +1,346 @@
+/*
+ * Copyright 2003 Adaptec, Inc.
+ *
+ * Please read the following license before using the Adaptec Software
+ * ("Program"). If you do not agree to the license terms, do not use the
+ * Program:
+ *
+ * You agree to be bound by version 2 of the General Public License ("GPL")
+ * dated June 1991, which can be found at http://www.fsf.org/licenses/gpl.html.
+ * If the link is broken, write to Free Software Foundation, 59 Temple Place,
+ * Boston, Massachusetts 02111-1307.
+ *
+ * BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE IT IS LICENSED "AS IS" AND
+ * THERE IS NO WARRANTY FOR THE PROGRAM, INCLUDING BUT NOT LIMITED TO THE
+ * IMPLIED WARRANTIES OF MERCHANTIBILITY OR FITNESS FOR A PARTICULAR PURPOSE
+ * (TO THE EXTENT PERMITTED BY APPLICABLE LAW). USE OF THE PROGRAM IS AT YOUR
+ * OWN RISK. IN NO EVENT WILL ADAPTEC OR ITS LICENSORS BE LIABLE TO YOU FOR
+ * DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES
+ * ARISING OUT OF THE USE OR INABILITY TO USE THE PROGRAM.
+ *
+ */
+
+static const u32 firmware_rx[] = {
+  0x010003dc, 0x00000000,
+  0x04000421, 0x00000086,
+  0x80000015, 0x0000180e,
+  0x81000015, 0x00006664,
+  0x1a0040ab, 0x00000b06,
+  0x14200011, 0x00000000,
+  0x14204022, 0x0000aaaa,
+  0x14204022, 0x00000300,
+  0x14204022, 0x00000000,
+  0x1a0040ab, 0x00000b14,
+  0x14200011, 0x00000000,
+  0x83000015, 0x00000002,
+  0x04000021, 0x00000000,
+  0x00000010, 0x00000000,
+  0x04000421, 0x00000087,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00008015, 0x00000000,
+  0x0000003e, 0x00000000,
+  0x00000010, 0x00000000,
+  0x82000015, 0x00004000,
+  0x009e8050, 0x00000000,
+  0x03008015, 0x00000000,
+  0x86008015, 0x00000000,
+  0x82000015, 0x00008000,
+  0x0100001c, 0x00000000,
+  0x000050a0, 0x0000010c,
+  0x4e20d011, 0x00006008,
+  0x1420d012, 0x00004008,
+  0x0000f090, 0x00007000,
+  0x0000c8b0, 0x00003000,
+  0x00004040, 0x00000000,
+  0x00108015, 0x00000000,
+  0x00a2c150, 0x00004000,
+  0x00a400b0, 0x00000014,
+  0x00000020, 0x00000000,
+  0x2500400d, 0x00002525,
+  0x00047220, 0x00003100,
+  0x00934070, 0x00000000,
+  0x00000020, 0x00000000,
+  0x00924460, 0x00000184,
+  0x2b20c011, 0x00000000,
+  0x0000c420, 0x00000540,
+  0x36014018, 0x0000422d,
+  0x14200011, 0x00000000,
+  0x00924460, 0x00000183,
+  0x3200001f, 0x00000034,
+  0x02ac0015, 0x00000002,
+  0x00a60110, 0x00000008,
+  0x42200011, 0x00000000,
+  0x00924060, 0x00000103,
+  0x0000001e, 0x00000000,
+  0x00000020, 0x00000100,
+  0x0000001e, 0x00000000,
+  0x00924460, 0x00000086,
+  0x00004080, 0x00000000,
+  0x0092c070, 0x00000000,
+  0x00924060, 0x00000100,
+  0x0000c890, 0x00005000,
+  0x00a6c110, 0x00000000,
+  0x00b0c090, 0x00000012,
+  0x021c0015, 0x00000000,
+  0x3200001f, 0x00000034,
+  0x00924460, 0x00000510,
+  0x44210011, 0x00000000,
+  0x42000011, 0x00000000,
+  0x83000015, 0x00000040,
+  0x00924460, 0x00000508,
+  0x45014018, 0x00004545,
+  0x00808050, 0x00000000,
+  0x62208012, 0x00000000,
+  0x82000015, 0x00000800,
+  0x15200011, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x80000015, 0x0000eea4,
+  0x81000015, 0x0000005f,
+  0x00000060, 0x00000000,
+  0x00004120, 0x00000000,
+  0x00004a00, 0x00004000,
+  0x00924460, 0x00000190,
+  0x5601401a, 0x00005956,
+  0x14000011, 0x00000000,
+  0x00934050, 0x00000018,
+  0x00930050, 0x00000018,
+  0x3601403a, 0x0000002d,
+  0x000643a9, 0x00000000,
+  0x0000c420, 0x00000140,
+  0x5601401a, 0x00005956,
+  0x14000011, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x000642a9, 0x00000000,
+  0x00024420, 0x00000183,
+  0x5601401a, 0x00005956,
+  0x82000015, 0x00002000,
+  0x15200011, 0x00000000,
+  0x82000015, 0x00000010,
+  0x15200011, 0x00000000,
+  0x82000015, 0x00000010,
+  0x15200011, 0x00000000,
+};	/* 104 Rx instructions */
+#define FIRMWARE_RX_SIZE 104
+
+static const u32 firmware_tx[] = {
+  0x010003dc, 0x00000000,
+  0x04000421, 0x00000086,
+  0x80000015, 0x0000180e,
+  0x81000015, 0x00006664,
+  0x1a0040ab, 0x00000b06,
+  0x14200011, 0x00000000,
+  0x14204022, 0x0000aaaa,
+  0x14204022, 0x00000300,
+  0x14204022, 0x00000000,
+  0x1a0040ab, 0x00000b14,
+  0x14200011, 0x00000000,
+  0x83000015, 0x00000002,
+  0x04000021, 0x00000000,
+  0x00000010, 0x00000000,
+  0x04000421, 0x00000087,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00008015, 0x00000000,
+  0x0000003e, 0x00000000,
+  0x00000010, 0x00000000,
+  0x82000015, 0x00004000,
+  0x009e8050, 0x00000000,
+  0x03008015, 0x00000000,
+  0x86008015, 0x00000000,
+  0x82000015, 0x00008000,
+  0x0100001c, 0x00000000,
+  0x000050a0, 0x0000010c,
+  0x4e20d011, 0x00006008,
+  0x1420d012, 0x00004008,
+  0x0000f090, 0x00007000,
+  0x0000c8b0, 0x00003000,
+  0x00004040, 0x00000000,
+  0x00108015, 0x00000000,
+  0x00a2c150, 0x00004000,
+  0x00a400b0, 0x00000014,
+  0x00000020, 0x00000000,
+  0x2500400d, 0x00002525,
+  0x00047220, 0x00003100,
+  0x00934070, 0x00000000,
+  0x00000020, 0x00000000,
+  0x00924460, 0x00000184,
+  0x2b20c011, 0x00000000,
+  0x0000c420, 0x00000540,
+  0x36014018, 0x0000422d,
+  0x14200011, 0x00000000,
+  0x00924460, 0x00000183,
+  0x3200001f, 0x00000034,
+  0x02ac0015, 0x00000002,
+  0x00a60110, 0x00000008,
+  0x42200011, 0x00000000,
+  0x00924060, 0x00000103,
+  0x0000001e, 0x00000000,
+  0x00000020, 0x00000100,
+  0x0000001e, 0x00000000,
+  0x00924460, 0x00000086,
+  0x00004080, 0x00000000,
+  0x0092c070, 0x00000000,
+  0x00924060, 0x00000100,
+  0x0000c890, 0x00005000,
+  0x00a6c110, 0x00000000,
+  0x00b0c090, 0x00000012,
+  0x021c0015, 0x00000000,
+  0x3200001f, 0x00000034,
+  0x00924460, 0x00000510,
+  0x44210011, 0x00000000,
+  0x42000011, 0x00000000,
+  0x83000015, 0x00000040,
+  0x00924460, 0x00000508,
+  0x45014018, 0x00004545,
+  0x00808050, 0x00000000,
+  0x62208012, 0x00000000,
+  0x82000015, 0x00000800,
+  0x15200011, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x80000015, 0x0000eea4,
+  0x81000015, 0x0000005f,
+  0x00000060, 0x00000000,
+  0x00004120, 0x00000000,
+  0x00004a00, 0x00004000,
+  0x00924460, 0x00000190,
+  0x5601401a, 0x00005956,
+  0x14000011, 0x00000000,
+  0x00934050, 0x00000018,
+  0x00930050, 0x00000018,
+  0x3601403a, 0x0000002d,
+  0x000643a9, 0x00000000,
+  0x0000c420, 0x00000140,
+  0x5601401a, 0x00005956,
+  0x14000011, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x000642a9, 0x00000000,
+  0x00024420, 0x00000183,
+  0x5601401a, 0x00005956,
+  0x82000015, 0x00002000,
+  0x15200011, 0x00000000,
+  0x82000015, 0x00000010,
+  0x15200011, 0x00000000,
+  0x82000015, 0x00000010,
+  0x15200011, 0x00000000,
+};	/* 104 Tx instructions */
+#define FIRMWARE_TX_SIZE 104
+#if 0
+static const u32 firmware_wol[] = {
+  0x010003dc, 0x00000000,
+  0x19000421, 0x00000087,
+  0x80000015, 0x00001a1a,
+  0x81000015, 0x00001a1a,
+  0x1a0040ab, 0x00000b06,
+  0x15200011, 0x00000000,
+  0x15204022, 0x0000aaaa,
+  0x15204022, 0x00000300,
+  0x15204022, 0x00000000,
+  0x1a0040ab, 0x00000b15,
+  0x15200011, 0x00000000,
+  0x83000015, 0x00000002,
+  0x04000021, 0x00000000,
+  0x00000010, 0x00000000,
+  0x04000421, 0x00000087,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00008015, 0x00000000,
+  0x0000003e, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x82000015, 0x00004000,
+  0x82000015, 0x00008000,
+  0x0000000c, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00004080, 0x00000100,
+  0x1f20c011, 0x00001122,
+  0x2720f011, 0x00003011,
+  0x19200071, 0x00000000,
+  0x1a200051, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x1d2040a4, 0x00003344,
+  0x1d2040a2, 0x00005566,
+  0x000040a0, 0x00000100,
+  0x00108050, 0x00000001,
+  0x1a208012, 0x00000006,
+  0x82000015, 0x00008080,
+  0x010003dc, 0x00000000,
+  0x1d2040a4, 0x00002233,
+  0x1d2040a4, 0x00004455,
+  0x2d208011, 0x00000005,
+  0x1d2040a4, 0x00006611,
+  0x00108050, 0x00000001,
+  0x27200011, 0x00000000,
+  0x1d2050a4, 0x00006600,
+  0x82000015, 0x00008080,
+  0x010003dc, 0x00000000,
+  0x00000050, 0x00000000,
+  0x1b200031, 0x00000000,
+  0x0000001e, 0x00000000,
+  0x0000001e, 0x00000000,
+  0x0000001e, 0x00000000,
+  0x0000001e, 0x00000000,
+  0x00924460, 0x00000086,
+  0x00004080, 0x00000000,
+  0x0092c070, 0x00000000,
+  0x00924060, 0x00000100,
+  0x0000c890, 0x00005000,
+  0x00a6c110, 0x00000000,
+  0x00b0c090, 0x00000012,
+  0x021c0015, 0x00000000,
+  0x3200001f, 0x00000034,
+  0x00924460, 0x00000510,
+  0x44210011, 0x00000000,
+  0x42000011, 0x00000000,
+  0x83000015, 0x00000040,
+  0x00924460, 0x00000508,
+  0x476a0012, 0x00000100,
+  0x83000015, 0x00000008,
+  0x16200011, 0x00000000,
+  0x001e8050, 0x00000000,
+  0x001e8050, 0x00000000,
+  0x00808050, 0x00000000,
+  0x03008015, 0x00000000,
+  0x62208012, 0x00000000,
+  0x82000015, 0x00000800,
+  0x16200011, 0x00000000,
+  0x80000015, 0x0000eea4,
+  0x81000015, 0x0000005f,
+  0x00000020, 0x00000000,
+  0x00004120, 0x00000000,
+  0x00004a00, 0x00004000,
+  0x00924460, 0x00000190,
+  0x5c01401a, 0x0000595c,
+  0x15000011, 0x00000000,
+  0x00934050, 0x00000018,
+  0x00930050, 0x00000018,
+  0x3601403a, 0x0000002d,
+  0x00064029, 0x00000000,
+  0x0000c420, 0x00000140,
+  0x5c01401a, 0x0000595c,
+  0x15000011, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00064029, 0x00000000,
+  0x00024420, 0x00000183,
+  0x5c01401a, 0x0000595c,
+  0x82000015, 0x00002000,
+  0x16200011, 0x00000000,
+  0x82000015, 0x00000010,
+  0x16200011, 0x00000000,
+  0x82000015, 0x00000010,
+  0x16200011, 0x00000000,
+};	/* 104 WoL instructions */
+#define FIRMWARE_WOL_SIZE 104
+#endif

--------------070300050900020608080705--
