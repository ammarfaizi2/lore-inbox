Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310114AbSCFVhq>; Wed, 6 Mar 2002 16:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310120AbSCFVhi>; Wed, 6 Mar 2002 16:37:38 -0500
Received: from age.cs.columbia.edu ([128.59.22.100]:40975 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S310114AbSCFVh0>; Wed, 6 Mar 2002 16:37:26 -0500
Date: Wed, 6 Mar 2002 16:37:03 -0500 (EST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] starfire net driver update for 2.2.21pre3
Message-ID: <Pine.LNX.4.44.0203061621120.31906-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

This update brings the 2.2 driver in line with the 2.4 driver (Jeff
Garzik's ethtool additions) and also adds sparc64 support (tested!) and 
better error and stats handling.

Please apply.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-------------------------------------
diff -urX /misc/stuff/kernels/diff_kernel_excludes linux/arch/sparc64/config.in linux-2.2.21pre3/arch/sparc64/config.in
--- linux/arch/sparc64/config.in	Sun Mar 25 11:37:30 2001
+++ linux-2.2.21pre3/arch/sparc64/config.in	Mon Mar  4 18:59:39 2002
@@ -250,6 +250,7 @@
 			tristate 'RealTek 8129/8139 (not 8019/8029!) support' CONFIG_RTL8139
 			tristate 'PCI NE2000 support' CONFIG_NE2K_PCI
 			tristate 'EtherExpressPro/100 support' CONFIG_EEXPRESS_PRO100
+			tristate 'Adaptec Starfire/DuraLAN support' CONFIG_ADAPTEC_STARFIRE
 			tristate 'SysKonnect SK-98xx support' CONFIG_SK98LIN
 		fi
 		bool 'FDDI driver support' CONFIG_FDDI
diff -urX /misc/stuff/kernels/diff_kernel_excludes linux/drivers/net/starfire-kcomp22.h linux-2.2.21pre3/drivers/net/starfire-kcomp22.h
--- linux/drivers/net/starfire-kcomp22.h	Wed Mar  6 13:43:04 2002
+++ linux-2.2.21pre3/drivers/net/starfire-kcomp22.h	Wed Mar  6 12:43:35 2002
@@ -73,10 +73,20 @@
 	char	reserved2[32];
 };
 
+/* for passing single values */
+struct ethtool_value {
+	u32	cmd;
+	u32	data;
+};
+
 /* CMDs currently supported */
 #define ETHTOOL_GSET		0x00000001 /* Get settings. */
 #define ETHTOOL_SSET		0x00000002 /* Set settings, privileged. */
 #define ETHTOOL_GDRVINFO	0x00000003 /* Get driver info. */
+#define ETHTOOL_GMSGLVL		0x00000007 /* Get driver message level */
+#define ETHTOOL_SMSGLVL		0x00000008 /* Set driver msg level, priv. */
+#define ETHTOOL_NWAY_RST	0x00000009 /* Restart autonegotiation, priv. */
+#define ETHTOOL_GLINK		0x0000000a /* Get link status */
 
 /* Indicates what features are supported by the interface. */
 #define SUPPORTED_10baseT_Half		(1 << 0)
@@ -163,6 +173,7 @@
 #define __devinit			__init
 #define __devinitdata			__initdata
 #define __devexit
+#define __devexit_p(foo)		foo
 #define MODULE_DEVICE_TABLE(foo,bar)
 #define SET_MODULE_OWNER(dev)
 #define COMPAT_MOD_INC_USE_COUNT	MOD_INC_USE_COUNT
@@ -178,6 +189,10 @@
 #define del_timer_sync(timer)		del_timer(timer)
 #define alloc_etherdev(size)		init_etherdev(NULL, size)
 #define register_netdev(dev)		0
+
+#ifdef CONFIG_SPARC64
+typedef unsigned long dma_addr_t;
+#endif /* CONFIG_SPARC64 */
 
 static inline void *pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
 					 dma_addr_t *dma_handle)
diff -urX /misc/stuff/kernels/diff_kernel_excludes linux/drivers/net/starfire.c linux-2.2.21pre3/drivers/net/starfire.c
--- linux/drivers/net/starfire.c	Wed Mar  6 13:43:05 2002
+++ linux-2.2.21pre3/drivers/net/starfire.c	Wed Mar  6 12:19:25 2002
@@ -93,13 +93,21 @@
 	- Fixed initialization timing problems
 	- Fixed interrupt mask definitions
 
+	LK1.3.5 (jgarzik)
+	- ethtool NWAY_RST, GLINK, [GS]MSGLVL support
+
+	LK1.3.6 (Ion Badulescu)
+	- Sparc64 support and fixes
+	- Better stats and error handling
+
 TODO:
 	- implement tx_timeout() properly
+	- VLAN support
 */
 
 #define DRV_NAME	"starfire"
-#define DRV_VERSION	"1.03+LK1.3.4"
-#define DRV_RELDATE	"August 14, 2001"
+#define DRV_VERSION	"1.03+LK1.3.6"
+#define DRV_RELDATE	"March 6, 2002"
 
 #include <linux/version.h>
 #include <linux/module.h>
@@ -124,8 +132,11 @@
  * for this driver to really use the firmware. Note that Rx/Tx
  * hardware TCP checksumming is not possible without the firmware.
  *
- * I'm currently [Feb 2001] talking to Adaptec about this redistribution
- * issue. Stay tuned...
+ * If Adaptec could allow redistribution of the firmware (even in binary
+ * format), life would become a lot easier. Unfortunately, I've lost my
+ * Adaptec contacts, so progress on this front is rather unlikely to
+ * occur. If anybody from Adaptec reads this and can help with this matter,
+ * please let me know...
  */
 #undef HAS_FIRMWARE
 /*
@@ -250,6 +261,8 @@
 
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("Adaptec Starfire Ethernet driver");
+MODULE_LICENSE("GPL");
+
 MODULE_PARM(max_interrupt_work, "i");
 MODULE_PARM(mtu, "i");
 MODULE_PARM(debug, "i");
@@ -603,6 +616,7 @@
 	long ioaddr;
 	int drv_flags, io_size;
 	int boguscnt;
+	u16 cmd;
 	u8 cache;
 
 /* when built into the kernel, we only print version if device is found */
@@ -638,14 +652,22 @@
 		goto err_out_free_netdev;
 	}
 
-	ioaddr = (long) ioremap (ioaddr, io_size);
+	/* ioremap is borken in Linux-2.2.x/sparc64 */
+#if !defined(CONFIG_SPARC64) || LINUX_VERSION_CODE > 0x20300
+	ioaddr = (long) ioremap(ioaddr, io_size);
 	if (!ioaddr) {
 		printk (KERN_ERR DRV_NAME " %d: cannot remap 0x%x @ 0x%lx, aborting\n",
 			card_idx, io_size, ioaddr);
 		goto err_out_free_res;
 	}
+#endif /* !CONFIG_SPARC64 || Linux 2.3.0+ */
 
-	pci_set_master (pdev);
+	pci_set_master(pdev);
+
+	/* enable MWI -- it vastly improves Rx performance on sparc64 */
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	cmd |= PCI_COMMAND_INVALIDATE;
+	pci_write_config_word(pdev, PCI_COMMAND, cmd);
 
 	/* set PCI cache size */
 	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &cache);
@@ -664,7 +685,7 @@
 
 	/* Serial EEPROM reads are hidden by the hardware. */
 	for (i = 0; i < 6; i++)
-		dev->dev_addr[i] = readb(ioaddr + EEPROMCtrl + 20-i);
+		dev->dev_addr[i] = readb(ioaddr + EEPROMCtrl + 20 - i);
 
 #if ! defined(final_version) /* Dump the EEPROM contents during development. */
 	if (debug > 4)
@@ -770,7 +791,7 @@
 
 #ifdef ZEROCOPY
 	printk(KERN_INFO "%s: scatter-gather and hardware TCP cksumming enabled.\n",
-	       dev->name,
+	       dev->name);
 #else  /* not ZEROCOPY */
 	printk(KERN_INFO "%s: scatter-gather and hardware TCP cksumming disabled.\n",
 	       dev->name);
@@ -926,7 +947,7 @@
 
 	/* Fill both the unused Tx SA register and the Rx perfect filter. */
 	for (i = 0; i < 6; i++)
-		writeb(dev->dev_addr[i], ioaddr + StationAddr + 5-i);
+		writeb(dev->dev_addr[i], ioaddr + StationAddr + 5 - i);
 	for (i = 0; i < 16; i++) {
 		u16 *eaddrs = (u16 *)dev->dev_addr;
 		long setup_frm = ioaddr + PerfFilterTable + i * 16;
@@ -973,9 +994,9 @@
 #ifdef HAS_FIRMWARE
 	/* Load Rx/Tx firmware into the frame processors */
 	for (i = 0; i < FIRMWARE_RX_SIZE * 2; i++)
-		writel(cpu_to_le32(firmware_rx[i]), ioaddr + RxGfpMem + i * 4);
+		writel(firmware_rx[i], ioaddr + RxGfpMem + i * 4);
 	for (i = 0; i < FIRMWARE_TX_SIZE * 2; i++)
-		writel(cpu_to_le32(firmware_tx[i]), ioaddr + TxGfpMem + i * 4);
+		writel(firmware_tx[i], ioaddr + TxGfpMem + i * 4);
 	/* Enable the Rx and Tx units, and the Rx/Tx frame processors. */
 	writel(0x003F, ioaddr + GenCtrl);
 #else  /* not HAS_FIRMWARE */
@@ -1150,8 +1171,8 @@
 
 	np->tx_ring[entry].first_addr = cpu_to_le32(np->tx_info[entry].first_mapping);
 #ifdef ZEROCOPY
-	np->tx_ring[entry].first_len = cpu_to_le32(skb_first_frag_len(skb));
-	np->tx_ring[entry].total_len = cpu_to_le32(skb->len);
+	np->tx_ring[entry].first_len = cpu_to_le16(skb_first_frag_len(skb));
+	np->tx_ring[entry].total_len = cpu_to_le16(skb->len);
 	/* Add "| TxDescIntr" to generate Tx-done interrupts. */
 	np->tx_ring[entry].status = cpu_to_le32(TxDescID | TxCRCEn);
 	np->tx_ring[entry].nbufs = cpu_to_le32(skb_shinfo(skb)->nr_frags + 1);
@@ -1164,8 +1185,10 @@
 		np->tx_ring[entry].status |= cpu_to_le32(TxRingWrap | TxDescIntr);
 
 #ifdef ZEROCOPY
-	if (skb->ip_summed == CHECKSUM_HW)
+	if (skb->ip_summed == CHECKSUM_HW) {
 		np->tx_ring[entry].status |= cpu_to_le32(TxCalTCP);
+		np->stats.tx_compressed++;
+	}
 #endif /* ZEROCOPY */
 
 	if (debug > 5) {
@@ -1443,6 +1466,7 @@
 #if defined(full_rx_status) || defined(csum_rx_status)
 		if (le32_to_cpu(np->rx_done_q[np->rx_done].status2) & 0x01000000) {
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
+			np->stats.rx_compressed++;
 		}
 		/*
 		 * This feature doesn't seem to be working, at least
@@ -1574,12 +1598,17 @@
 		printk(KERN_NOTICE "%s: Increasing Tx FIFO threshold to %d bytes\n",
 		       dev->name, np->tx_threshold * 16);
 	}
-	if ((intr_status & ~(IntrNormalMask | IntrAbnormalSummary | IntrLinkChange | IntrStatsMax | IntrTxDataLow | IntrPCIPad)) && debug)
+	if (intr_status & IntrRxGFPDead) {
+		np->stats.rx_fifo_errors++;
+		np->stats.rx_errors++;
+	}
+	if (intr_status & (IntrNoTxCsum | IntrDMAErr)) {
+		np->stats.tx_fifo_errors++;
+		np->stats.tx_errors++;
+	}
+	if ((intr_status & ~(IntrNormalMask | IntrAbnormalSummary | IntrLinkChange | IntrStatsMax | IntrTxDataLow | IntrRxGFPDead | IntrNoTxCsum | IntrPCIPad)) && debug)
 		printk(KERN_ERR "%s: Something Wicked happened! %4.4x.\n",
 		       dev->name, intr_status);
-	/* Hmmmmm, it's not clear how to recover from DMA faults. */
-	if (intr_status & IntrDMAErr)
-		np->stats.tx_fifo_errors++;
 }
 
 
@@ -1787,6 +1816,47 @@
 		return 0;
 	}
 
+	/* restart autonegotiation */
+	case ETHTOOL_NWAY_RST: {
+		int tmp;
+		int r = -EINVAL;
+		/* if autoneg is off, it's an error */
+		tmp = mdio_read(dev, np->phys[0], MII_BMCR);
+		if (tmp & BMCR_ANENABLE) {
+			tmp |= (BMCR_ANRESTART);
+			mdio_write(dev, np->phys[0], MII_BMCR, tmp);
+			r = 0;
+		}
+		return r;
+	}
+	/* get link status */
+	case ETHTOOL_GLINK: {
+		struct ethtool_value edata = {ETHTOOL_GLINK};
+		if (mdio_read(dev, np->phys[0], MII_BMSR) & BMSR_LSTATUS)
+			edata.data = 1;
+		else
+			edata.data = 0;
+		if (copy_to_user(useraddr, &edata, sizeof(edata)))
+			return -EFAULT;
+		return 0;
+	}
+
+	/* get message-level */
+	case ETHTOOL_GMSGLVL: {
+		struct ethtool_value edata = {ETHTOOL_GMSGLVL};
+		edata.data = debug;
+		if (copy_to_user(useraddr, &edata, sizeof(edata)))
+			return -EFAULT;
+		return 0;
+	}
+	/* set message-level */
+	case ETHTOOL_SMSGLVL: {
+		struct ethtool_value edata;
+		if (copy_from_user(&edata, useraddr, sizeof(edata)))
+			return -EFAULT;
+		debug = edata.data;
+		return 0;
+	}
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1961,7 +2031,7 @@
 static struct pci_driver starfire_driver = {
 	name:		DRV_NAME,
 	probe:		starfire_init_one,
-	remove:		starfire_remove_one,
+	remove:		__devexit_p(starfire_remove_one),
 	id_table:	starfire_pci_tbl,
 };
 

