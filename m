Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310209AbSCFVlG>; Wed, 6 Mar 2002 16:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310205AbSCFVk6>; Wed, 6 Mar 2002 16:40:58 -0500
Received: from age.cs.columbia.edu ([128.59.22.100]:41999 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S310135AbSCFVkk>; Wed, 6 Mar 2002 16:40:40 -0500
Date: Wed, 6 Mar 2002 16:40:34 -0500 (EST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] starfire net driver update for 2.4.19pre2
Message-ID: <Pine.LNX.4.44.0203061637270.31906-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

This update adds sparc64 support (tested!) and better error and stats 
handling. It also removes the experimental tag from the driver, since I 
don't consider it experimental anymore.

Please apply.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
--------------------------------------
--- linux/drivers/net/Config.in	Wed Mar  6 14:14:37 2002
+++ linux-2.4.18-rc4/drivers/net/Config.in	Wed Mar  6 14:55:36 2002
@@ -153,7 +153,7 @@
    fi
    if [ "$CONFIG_NET_PCI" = "y" ]; then
       dep_tristate '    AMD PCnet32 PCI support' CONFIG_PCNET32 $CONFIG_PCI
-      dep_tristate '    Adaptec Starfire support (EXPERIMENTAL)' CONFIG_ADAPTEC_STARFIRE $CONFIG_PCI $CONFIG_EXPERIMENTAL
+      dep_tristate '    Adaptec Starfire/DuraLAN support' CONFIG_ADAPTEC_STARFIRE $CONFIG_PCI
       if [ "$CONFIG_ISA" = "y" -o "$CONFIG_EISA" = "y" ]; then
 	 dep_tristate '    Ansel Communications EISA 3200 support (EXPERIMENTAL)' CONFIG_AC3200 $CONFIG_EXPERIMENTAL
       fi
--- linux/drivers/net/starfire.c	Wed Mar  6 14:14:38 2002
+++ linux-2.4.18-rc4/drivers/net/starfire.c	Wed Mar  6 16:32:58 2002
@@ -96,13 +96,18 @@
 	LK1.3.5 (jgarzik)
 	- ethtool NWAY_RST, GLINK, [GS]MSGLVL support
 
+	LK1.3.6 (Ion Badulescu)
+	- Sparc64 support and fixes
+	- Better stats and error handling
+
 TODO:
 	- implement tx_timeout() properly
+	- VLAN support
 */
 
 #define DRV_NAME	"starfire"
-#define DRV_VERSION	"1.03+LK1.3.5"
-#define DRV_RELDATE	"November 17, 2001"
+#define DRV_VERSION	"1.03+LK1.3.6"
+#define DRV_RELDATE	"March 6, 2002"
 
 #include <linux/version.h>
 #include <linux/module.h>
@@ -127,8 +132,11 @@
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
@@ -608,6 +616,7 @@
 	long ioaddr;
 	int drv_flags, io_size;
 	int boguscnt;
+	u16 cmd;
 	u8 cache;
 
 /* when built into the kernel, we only print version if device is found */
@@ -643,14 +652,22 @@
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
+
+	pci_set_master(pdev);
 
-	pci_set_master (pdev);
+	/* enable MWI -- it vastly improves Rx performance on sparc64 */
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	cmd |= PCI_COMMAND_INVALIDATE;
+	pci_write_config_word(pdev, PCI_COMMAND, cmd);
 
 	/* set PCI cache size */
 	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &cache);
@@ -669,7 +686,7 @@
 
 	/* Serial EEPROM reads are hidden by the hardware. */
 	for (i = 0; i < 6; i++)
-		dev->dev_addr[i] = readb(ioaddr + EEPROMCtrl + 20-i);
+		dev->dev_addr[i] = readb(ioaddr + EEPROMCtrl + 20 - i);
 
 #if ! defined(final_version) /* Dump the EEPROM contents during development. */
 	if (debug > 4)
@@ -931,7 +948,7 @@
 
 	/* Fill both the unused Tx SA register and the Rx perfect filter. */
 	for (i = 0; i < 6; i++)
-		writeb(dev->dev_addr[i], ioaddr + StationAddr + 5-i);
+		writeb(dev->dev_addr[i], ioaddr + StationAddr + 5 - i);
 	for (i = 0; i < 16; i++) {
 		u16 *eaddrs = (u16 *)dev->dev_addr;
 		long setup_frm = ioaddr + PerfFilterTable + i * 16;
@@ -978,9 +995,9 @@
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
@@ -1155,8 +1172,8 @@
 
 	np->tx_ring[entry].first_addr = cpu_to_le32(np->tx_info[entry].first_mapping);
 #ifdef ZEROCOPY
-	np->tx_ring[entry].first_len = cpu_to_le32(skb_first_frag_len(skb));
-	np->tx_ring[entry].total_len = cpu_to_le32(skb->len);
+	np->tx_ring[entry].first_len = cpu_to_le16(skb_first_frag_len(skb));
+	np->tx_ring[entry].total_len = cpu_to_le16(skb->len);
 	/* Add "| TxDescIntr" to generate Tx-done interrupts. */
 	np->tx_ring[entry].status = cpu_to_le32(TxDescID | TxCRCEn);
 	np->tx_ring[entry].nbufs = cpu_to_le32(skb_shinfo(skb)->nr_frags + 1);
@@ -1169,8 +1186,10 @@
 		np->tx_ring[entry].status |= cpu_to_le32(TxRingWrap | TxDescIntr);
 
 #ifdef ZEROCOPY
-	if (skb->ip_summed == CHECKSUM_HW)
+	if (skb->ip_summed == CHECKSUM_HW) {
 		np->tx_ring[entry].status |= cpu_to_le32(TxCalTCP);
+		np->stats.tx_compressed++;
+	}
 #endif /* ZEROCOPY */
 
 	if (debug > 5) {
@@ -1448,6 +1467,7 @@
 #if defined(full_rx_status) || defined(csum_rx_status)
 		if (le32_to_cpu(np->rx_done_q[np->rx_done].status2) & 0x01000000) {
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
+			np->stats.rx_compressed++;
 		}
 		/*
 		 * This feature doesn't seem to be working, at least
@@ -1579,12 +1599,17 @@
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
 
 

