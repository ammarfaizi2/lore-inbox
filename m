Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263398AbVCMHdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbVCMHdm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 02:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbVCMHcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 02:32:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:25224 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263389AbVCMH3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 02:29:20 -0500
Date: Sat, 12 Mar 2005 23:29:11 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: chrisw@osdl.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: Linux 2.6.11.3
Message-ID: <20050313072911.GA20398@kroah.com>
References: <20050313072813.GA20358@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050313072813.GA20358@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/Makefile b/Makefile
--- a/Makefile	2005-03-12 22:45:06 -08:00
+++ b/Makefile	2005-03-12 22:45:06 -08:00
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 11
-EXTRAVERSION = .2
+EXTRAVERSION = .3
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
diff -Nru a/arch/ppc/oprofile/op_model_fsl_booke.c b/arch/ppc/oprofile/op_model_fsl_booke.c
--- a/arch/ppc/oprofile/op_model_fsl_booke.c	2005-03-12 22:45:06 -08:00
+++ b/arch/ppc/oprofile/op_model_fsl_booke.c	2005-03-12 22:45:06 -08:00
@@ -150,7 +150,6 @@
 	int is_kernel;
 	int val;
 	int i;
-	unsigned int cpu = smp_processor_id();
 
 	/* set the PMM bit (see comment below) */
 	mtmsr(mfmsr() | MSR_PMM);
@@ -162,7 +161,7 @@
 		val = ctr_read(i);
 		if (val < 0) {
 			if (oprofile_running && ctr[i].enabled) {
-				oprofile_add_sample(pc, is_kernel, i, cpu);
+				oprofile_add_pc(pc, is_kernel, i);
 				ctr_write(i, reset_value[i]);
 			} else {
 				ctr_write(i, 0);
diff -Nru a/arch/ppc/platforms/4xx/ebony.h b/arch/ppc/platforms/4xx/ebony.h
--- a/arch/ppc/platforms/4xx/ebony.h	2005-03-12 22:45:06 -08:00
+++ b/arch/ppc/platforms/4xx/ebony.h	2005-03-12 22:45:06 -08:00
@@ -61,8 +61,8 @@
  */
 
 /* OpenBIOS defined UART mappings, used before early_serial_setup */
-#define UART0_IO_BASE	(u8 *) 0xE0000200
-#define UART1_IO_BASE	(u8 *) 0xE0000300
+#define UART0_IO_BASE	0xE0000200
+#define UART1_IO_BASE	0xE0000300
 
 /* external Epson SG-615P */
 #define BASE_BAUD	691200
diff -Nru a/arch/ppc/platforms/4xx/luan.h b/arch/ppc/platforms/4xx/luan.h
--- a/arch/ppc/platforms/4xx/luan.h	2005-03-12 22:45:06 -08:00
+++ b/arch/ppc/platforms/4xx/luan.h	2005-03-12 22:45:06 -08:00
@@ -47,9 +47,9 @@
 #define RS_TABLE_SIZE	3
 
 /* PIBS defined UART mappings, used before early_serial_setup */
-#define UART0_IO_BASE	(u8 *) 0xa0000200
-#define UART1_IO_BASE	(u8 *) 0xa0000300
-#define UART2_IO_BASE	(u8 *) 0xa0000600
+#define UART0_IO_BASE	0xa0000200
+#define UART1_IO_BASE	0xa0000300
+#define UART2_IO_BASE	0xa0000600
 
 #define BASE_BAUD	11059200
 #define STD_UART_OP(num)					\
diff -Nru a/arch/ppc/platforms/4xx/ocotea.h b/arch/ppc/platforms/4xx/ocotea.h
--- a/arch/ppc/platforms/4xx/ocotea.h	2005-03-12 22:45:06 -08:00
+++ b/arch/ppc/platforms/4xx/ocotea.h	2005-03-12 22:45:06 -08:00
@@ -56,8 +56,8 @@
 #define RS_TABLE_SIZE	2
 
 /* OpenBIOS defined UART mappings, used before early_serial_setup */
-#define UART0_IO_BASE	(u8 *) 0xE0000200
-#define UART1_IO_BASE	(u8 *) 0xE0000300
+#define UART0_IO_BASE	0xE0000200
+#define UART1_IO_BASE	0xE0000300
 
 #define BASE_BAUD	11059200/16
 #define STD_UART_OP(num)					\
diff -Nru a/drivers/char/drm/drm_ioctl.c b/drivers/char/drm/drm_ioctl.c
--- a/drivers/char/drm/drm_ioctl.c	2005-03-12 22:45:06 -08:00
+++ b/drivers/char/drm/drm_ioctl.c	2005-03-12 22:45:06 -08:00
@@ -326,6 +326,8 @@
 
 	DRM_COPY_FROM_USER_IOCTL(sv, argp, sizeof(sv));
 
+	memset(&version, 0, sizeof(version));
+
 	dev->driver->version(&version);
 	retv.drm_di_major = DRM_IF_MAJOR;
 	retv.drm_di_minor = DRM_IF_MINOR;
diff -Nru a/drivers/media/video/adv7170.c b/drivers/media/video/adv7170.c
--- a/drivers/media/video/adv7170.c	2005-03-12 22:45:06 -08:00
+++ b/drivers/media/video/adv7170.c	2005-03-12 22:45:06 -08:00
@@ -130,7 +130,7 @@
 		u8 block_data[32];
 
 		msg.addr = client->addr;
-		msg.flags = client->flags;
+		msg.flags = 0;
 		while (len >= 2) {
 			msg.buf = (char *) block_data;
 			msg.len = 0;
diff -Nru a/drivers/media/video/adv7175.c b/drivers/media/video/adv7175.c
--- a/drivers/media/video/adv7175.c	2005-03-12 22:45:06 -08:00
+++ b/drivers/media/video/adv7175.c	2005-03-12 22:45:06 -08:00
@@ -126,7 +126,7 @@
 		u8 block_data[32];
 
 		msg.addr = client->addr;
-		msg.flags = client->flags;
+		msg.flags = 0;
 		while (len >= 2) {
 			msg.buf = (char *) block_data;
 			msg.len = 0;
diff -Nru a/drivers/media/video/bt819.c b/drivers/media/video/bt819.c
--- a/drivers/media/video/bt819.c	2005-03-12 22:45:06 -08:00
+++ b/drivers/media/video/bt819.c	2005-03-12 22:45:06 -08:00
@@ -146,7 +146,7 @@
 		u8 block_data[32];
 
 		msg.addr = client->addr;
-		msg.flags = client->flags;
+		msg.flags = 0;
 		while (len >= 2) {
 			msg.buf = (char *) block_data;
 			msg.len = 0;
diff -Nru a/drivers/media/video/saa7110.c b/drivers/media/video/saa7110.c
--- a/drivers/media/video/saa7110.c	2005-03-12 22:45:06 -08:00
+++ b/drivers/media/video/saa7110.c	2005-03-12 22:45:06 -08:00
@@ -60,8 +60,10 @@
 
 #define	I2C_SAA7110		0x9C	/* or 0x9E */
 
+#define SAA7110_NR_REG		0x35
+
 struct saa7110 {
-	unsigned char reg[54];
+	u8 reg[SAA7110_NR_REG];
 
 	int norm;
 	int input;
@@ -95,31 +97,28 @@
 		     unsigned int       len)
 {
 	int ret = -1;
-	u8 reg = *data++;
+	u8 reg = *data;		/* first register to write to */
 
-	len--;
+	/* Sanity check */
+	if (reg + (len - 1) > SAA7110_NR_REG)
+		return ret;
 
 	/* the saa7110 has an autoincrement function, use it if
 	 * the adapter understands raw I2C */
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		struct saa7110 *decoder = i2c_get_clientdata(client);
 		struct i2c_msg msg;
-		u8 block_data[54];
 
-		msg.len = 0;
-		msg.buf = (char *) block_data;
+		msg.len = len;
+		msg.buf = (char *) data;
 		msg.addr = client->addr;
-		msg.flags = client->flags;
-		while (len >= 1) {
-			msg.len = 0;
-			block_data[msg.len++] = reg;
-			while (len-- >= 1 && msg.len < 54)
-				block_data[msg.len++] =
-				    decoder->reg[reg++] = *data++;
-			ret = i2c_transfer(client->adapter, &msg, 1);
-		}
+		msg.flags = 0;
+		ret = i2c_transfer(client->adapter, &msg, 1);
+
+		/* Cache the written data */
+		memcpy(decoder->reg + reg, data + 1, len - 1);
 	} else {
-		while (len-- >= 1) {
+		for (++data, --len; len; len--) {
 			if ((ret = saa7110_write(client, reg++,
 						 *data++)) < 0)
 				break;
@@ -192,7 +191,7 @@
 	return 0;
 }
 
-static const unsigned char initseq[] = {
+static const unsigned char initseq[1 + SAA7110_NR_REG] = {
 	0, 0x4C, 0x3C, 0x0D, 0xEF, 0xBD, 0xF2, 0x03, 0x00,
 	/* 0x08 */ 0xF8, 0xF8, 0x60, 0x60, 0x00, 0x86, 0x18, 0x90,
 	/* 0x10 */ 0x00, 0x59, 0x40, 0x46, 0x42, 0x1A, 0xFF, 0xDA,
diff -Nru a/drivers/media/video/saa7114.c b/drivers/media/video/saa7114.c
--- a/drivers/media/video/saa7114.c	2005-03-12 22:45:06 -08:00
+++ b/drivers/media/video/saa7114.c	2005-03-12 22:45:06 -08:00
@@ -163,7 +163,7 @@
 		u8 block_data[32];
 
 		msg.addr = client->addr;
-		msg.flags = client->flags;
+		msg.flags = 0;
 		while (len >= 2) {
 			msg.buf = (char *) block_data;
 			msg.len = 0;
diff -Nru a/drivers/media/video/saa7185.c b/drivers/media/video/saa7185.c
--- a/drivers/media/video/saa7185.c	2005-03-12 22:45:06 -08:00
+++ b/drivers/media/video/saa7185.c	2005-03-12 22:45:06 -08:00
@@ -118,7 +118,7 @@
 		u8 block_data[32];
 
 		msg.addr = client->addr;
-		msg.flags = client->flags;
+		msg.flags = 0;
 		while (len >= 2) {
 			msg.buf = (char *) block_data;
 			msg.len = 0;
diff -Nru a/drivers/net/r8169.c b/drivers/net/r8169.c
--- a/drivers/net/r8169.c	2005-03-12 22:45:06 -08:00
+++ b/drivers/net/r8169.c	2005-03-12 22:45:06 -08:00
@@ -1683,16 +1683,19 @@
 	rtl8169_make_unusable_by_asic(desc);
 }
 
-static inline void rtl8169_return_to_asic(struct RxDesc *desc, int rx_buf_sz)
+static inline void rtl8169_mark_to_asic(struct RxDesc *desc, u32 rx_buf_sz)
 {
-	desc->opts1 |= cpu_to_le32(DescOwn + rx_buf_sz);
+	u32 eor = le32_to_cpu(desc->opts1) & RingEnd;
+
+	desc->opts1 = cpu_to_le32(DescOwn | eor | rx_buf_sz);
 }
 
-static inline void rtl8169_give_to_asic(struct RxDesc *desc, dma_addr_t mapping,
-					int rx_buf_sz)
+static inline void rtl8169_map_to_asic(struct RxDesc *desc, dma_addr_t mapping,
+				       u32 rx_buf_sz)
 {
 	desc->addr = cpu_to_le64(mapping);
-	desc->opts1 |= cpu_to_le32(DescOwn + rx_buf_sz);
+	wmb();
+	rtl8169_mark_to_asic(desc, rx_buf_sz);
 }
 
 static int rtl8169_alloc_rx_skb(struct pci_dev *pdev, struct sk_buff **sk_buff,
@@ -1712,7 +1715,7 @@
 	mapping = pci_map_single(pdev, skb->tail, rx_buf_sz,
 				 PCI_DMA_FROMDEVICE);
 
-	rtl8169_give_to_asic(desc, mapping, rx_buf_sz);
+	rtl8169_map_to_asic(desc, mapping, rx_buf_sz);
 
 out:
 	return ret;
@@ -2150,7 +2153,7 @@
 			skb_reserve(skb, NET_IP_ALIGN);
 			eth_copy_and_sum(skb, sk_buff[0]->tail, pkt_size, 0);
 			*sk_buff = skb;
-			rtl8169_return_to_asic(desc, rx_buf_sz);
+			rtl8169_mark_to_asic(desc, rx_buf_sz);
 			ret = 0;
 		}
 	}
diff -Nru a/drivers/net/sis900.c b/drivers/net/sis900.c
--- a/drivers/net/sis900.c	2005-03-12 22:45:06 -08:00
+++ b/drivers/net/sis900.c	2005-03-12 22:45:06 -08:00
@@ -236,7 +236,7 @@
 	signature = (u16) read_eeprom(ioaddr, EEPROMSignature);    
 	if (signature == 0xffff || signature == 0x0000) {
 		printk (KERN_INFO "%s: Error EERPOM read %x\n", 
-			net_dev->name, signature);
+			pci_name(pci_dev), signature);
 		return 0;
 	}
 
@@ -268,7 +268,7 @@
 	if (!isa_bridge)
 		isa_bridge = pci_get_device(PCI_VENDOR_ID_SI, 0x0018, isa_bridge);
 	if (!isa_bridge) {
-		printk("%s: Can not find ISA bridge\n", net_dev->name);
+		printk("%s: Can not find ISA bridge\n", pci_name(pci_dev));
 		return 0;
 	}
 	pci_read_config_byte(isa_bridge, 0x48, &reg);
@@ -456,10 +456,6 @@
 	net_dev->tx_timeout = sis900_tx_timeout;
 	net_dev->watchdog_timeo = TX_TIMEOUT;
 	net_dev->ethtool_ops = &sis900_ethtool_ops;
-	
-	ret = register_netdev(net_dev);
-	if (ret)
-		goto err_unmap_rx;
 		
 	/* Get Mac address according to the chip revision */
 	pci_read_config_byte(pci_dev, PCI_CLASS_REVISION, &revision);
@@ -476,7 +472,7 @@
 
 	if (ret == 0) {
 		ret = -ENODEV;
-		goto err_out_unregister;
+		goto err_unmap_rx;
 	}
 	
 	/* 630ET : set the mii access mode as software-mode */
@@ -486,7 +482,7 @@
 	/* probe for mii transceiver */
 	if (sis900_mii_probe(net_dev) == 0) {
 		ret = -ENODEV;
-		goto err_out_unregister;
+		goto err_unmap_rx;
 	}
 
 	/* save our host bridge revision */
@@ -496,6 +492,10 @@
 		pci_dev_put(dev);
 	}
 
+	ret = register_netdev(net_dev);
+	if (ret)
+		goto err_unmap_rx;
+
 	/* print some information about our NIC */
 	printk(KERN_INFO "%s: %s at %#lx, IRQ %d, ", net_dev->name,
 	       card_name, ioaddr, net_dev->irq);
@@ -505,8 +505,6 @@
 
 	return 0;
 
- err_out_unregister:
- 	unregister_netdev(net_dev);
  err_unmap_rx:
 	pci_free_consistent(pci_dev, RX_TOTAL_SIZE, sis_priv->rx_ring,
 		sis_priv->rx_ring_dma);
@@ -533,6 +531,7 @@
 static int __init sis900_mii_probe(struct net_device * net_dev)
 {
 	struct sis900_private * sis_priv = net_dev->priv;
+	const char *dev_name = pci_name(sis_priv->pci_dev);
 	u16 poll_bit = MII_STAT_LINK, status = 0;
 	unsigned long timeout = jiffies + 5 * HZ;
 	int phy_addr;
@@ -582,21 +581,20 @@
 					mii_phy->phy_types =
 					    (mii_status & (MII_STAT_CAN_TX_FDX | MII_STAT_CAN_TX)) ? LAN : HOME;
 				printk(KERN_INFO "%s: %s transceiver found at address %d.\n",
-				       net_dev->name, mii_chip_table[i].name,
+				       dev_name, mii_chip_table[i].name,
 				       phy_addr);
 				break;
 			}
 			
 		if( !mii_chip_table[i].phy_id1 ) {
 			printk(KERN_INFO "%s: Unknown PHY transceiver found at address %d.\n",
-			       net_dev->name, phy_addr);
+			       dev_name, phy_addr);
 			mii_phy->phy_types = UNKNOWN;
 		}
 	}
 	
 	if (sis_priv->mii == NULL) {
-		printk(KERN_INFO "%s: No MII transceivers found!\n",
-			net_dev->name);
+		printk(KERN_INFO "%s: No MII transceivers found!\n", dev_name);
 		return 0;
 	}
 
@@ -621,7 +619,7 @@
 			poll_bit ^= (mdio_read(net_dev, sis_priv->cur_phy, MII_STATUS) & poll_bit);
 			if (time_after_eq(jiffies, timeout)) {
 				printk(KERN_WARNING "%s: reset phy and link down now\n",
-					net_dev->name);
+				       dev_name);
 				return -ETIME;
 			}
 		}
@@ -691,7 +689,7 @@
 		sis_priv->mii = default_phy;
 		sis_priv->cur_phy = default_phy->phy_addr;
 		printk(KERN_INFO "%s: Using transceiver found at address %d as default\n",
-					net_dev->name,sis_priv->cur_phy);
+		       pci_name(sis_priv->pci_dev), sis_priv->cur_phy);
 	}
 	
 	status = mdio_read(net_dev, sis_priv->cur_phy, MII_CONTROL);
diff -Nru a/drivers/net/via-rhine.c b/drivers/net/via-rhine.c
--- a/drivers/net/via-rhine.c	2005-03-12 22:45:06 -08:00
+++ b/drivers/net/via-rhine.c	2005-03-12 22:45:06 -08:00
@@ -1899,6 +1899,9 @@
 	struct rhine_private *rp = netdev_priv(dev);
 	void __iomem *ioaddr = rp->base;
 
+	if (!(rp->quirks & rqWOL))
+		return; /* Nothing to do for non-WOL adapters */
+
 	rhine_power_init(dev);
 
 	/* Make sure we use pattern 0, 1 and not 4, 5 */
diff -Nru a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
--- a/drivers/pci/hotplug/pciehp_ctrl.c	2005-03-12 22:45:06 -08:00
+++ b/drivers/pci/hotplug/pciehp_ctrl.c	2005-03-12 22:45:06 -08:00
@@ -1354,10 +1354,11 @@
 				dbg("PCI Bridge Hot-Remove s:b:d:f(%02x:%02x:%02x:%02x)\n", 
 					ctrl->seg, func->bus, func->device, func->function);
 				bridge_slot_remove(func);
-			} else
+			} else {
 				dbg("PCI Function Hot-Remove s:b:d:f(%02x:%02x:%02x:%02x)\n", 
 					ctrl->seg, func->bus, func->device, func->function);
 				slot_remove(func);
+			}
 
 			func = pciehp_slot_find(ctrl->slot_bus, device, 0);
 		}
diff -Nru a/fs/cramfs/inode.c b/fs/cramfs/inode.c
--- a/fs/cramfs/inode.c	2005-03-12 22:45:06 -08:00
+++ b/fs/cramfs/inode.c	2005-03-12 22:45:06 -08:00
@@ -70,6 +70,7 @@
 			inode->i_data.a_ops = &cramfs_aops;
 		} else {
 			inode->i_size = 0;
+			inode->i_blocks = 0;
 			init_special_inode(inode, inode->i_mode,
 				old_decode_dev(cramfs_inode->size));
 		}
diff -Nru a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
--- a/net/ipv4/tcp_timer.c	2005-03-12 22:45:06 -08:00
+++ b/net/ipv4/tcp_timer.c	2005-03-12 22:45:06 -08:00
@@ -38,6 +38,7 @@
 
 #ifdef TCP_DEBUG
 const char tcp_timer_bug_msg[] = KERN_DEBUG "tcpbug: unknown timer value\n";
+EXPORT_SYMBOL(tcp_timer_bug_msg);
 #endif
 
 /*
