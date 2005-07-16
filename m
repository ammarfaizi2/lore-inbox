Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVGPOKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVGPOKH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 10:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVGPOKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 10:10:06 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:53423 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261622AbVGPOFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 10:05:30 -0400
Message-ID: <42D9141E.3070401@colorfullife.com>
Date: Sat, 16 Jul 2005 16:05:18 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
CC: Ayaz Abdulla <AAbdulla@nvidia.com>
Subject: [PATCH] forcedeth: TX handler changes (experimental)
Content-Type: multipart/mixed;
 boundary="------------070800010001050908070209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070800010001050908070209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[If you receive the mail twice - sorry. I forgot to attach the actual patch]
Hi,

Attached is a patch that modifies the tx interrupt handling of the 
nForce nic. It's part of the attempts to figure out what causes the nic 
hangs (see bug 4552).
The change is experimental: It affects all nForce versions. I've tested 
it on my nForce 250-Gb.

Please test it. And especially: If you experince a nic hang, please send 
me the debug output. That's the block starting with

<<
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Got tx_timeout. irq: 00000000
eth1: Ring at  ...
<<

Thanks,
    Manfred

--------------070800010001050908070209
Content-Type: text/plain;
 name="patch-forcedeth-038-txirq"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-forcedeth-038-txirq"

--- 2.6/drivers/net/forcedeth.c	2005-07-16 13:10:30.000000000 +0200
+++ build-2.6/drivers/net/forcedeth.c	2005-07-16 15:58:03.000000000 +0200
@@ -87,6 +87,8 @@
  *	0.35: 26 Jun 2005: Support for MCP55 added.
  *	0.36: 28 Jun 2005: Add jumbo frame support.
  *	0.37: 10 Jul 2005: Additional ethtool support, cleanup of pci id list
+ *	0.38: 16 Jul 2005: tx irq rewrite: Use global flags instead of
+ *			   per-packet flags.
  *
  * Known bugs:
  * We suspect that on some hardware no TX done interrupts are generated.
@@ -98,7 +100,7 @@
  * DEV_NEED_TIMERIRQ will not harm you on sane hardware, only generating a few
  * superfluous timer interrupts from the nic.
  */
-#define FORCEDETH_VERSION		"0.36"
+#define FORCEDETH_VERSION		"0.38"
 #define DRV_NAME			"forcedeth"
 
 #include <linux/module.h>
@@ -133,12 +135,9 @@
  * Hardware access:
  */
 
-#define DEV_NEED_LASTPACKET1	0x0001	/* set LASTPACKET1 in tx flags */
-#define DEV_IRQMASK_1		0x0002  /* use NVREG_IRQMASK_WANTED_1 for irq mask */
-#define DEV_IRQMASK_2		0x0004  /* use NVREG_IRQMASK_WANTED_2 for irq mask */
-#define DEV_NEED_TIMERIRQ	0x0008  /* set the timer irq flag in the irq mask */
-#define DEV_NEED_LINKTIMER	0x0010	/* poll link settings. Relies on the timer irq */
-#define DEV_HAS_LARGEDESC	0x0020	/* device supports jumbo frames and needs packet format 2 */
+#define DEV_NEED_TIMERIRQ	0x0001  /* set the timer irq flag in the irq mask */
+#define DEV_NEED_LINKTIMER	0x0002	/* poll link settings. Relies on the timer irq */
+#define DEV_HAS_LARGEDESC	0x0003	/* device supports jumbo frames and needs packet format 2 */
 
 enum {
 	NvRegIrqStatus = 0x000,
@@ -149,13 +148,16 @@
 #define NVREG_IRQ_RX			0x0002
 #define NVREG_IRQ_RX_NOBUF		0x0004
 #define NVREG_IRQ_TX_ERR		0x0008
-#define NVREG_IRQ_TX2			0x0010
+#define NVREG_IRQ_TX_OK			0x0010
 #define NVREG_IRQ_TIMER			0x0020
 #define NVREG_IRQ_LINK			0x0040
+#define NVREG_IRQ_TX_ERROR		0x0080
 #define NVREG_IRQ_TX1			0x0100
-#define NVREG_IRQMASK_WANTED_1		0x005f
-#define NVREG_IRQMASK_WANTED_2		0x0147
-#define NVREG_IRQ_UNKNOWN		(~(NVREG_IRQ_RX_ERROR|NVREG_IRQ_RX|NVREG_IRQ_RX_NOBUF|NVREG_IRQ_TX_ERR|NVREG_IRQ_TX2|NVREG_IRQ_TIMER|NVREG_IRQ_LINK|NVREG_IRQ_TX1))
+#define NVREG_IRQMASK_WANTED		0x00df
+
+#define NVREG_IRQ_UNKNOWN	(~(NVREG_IRQ_RX_ERROR|NVREG_IRQ_RX|NVREG_IRQ_RX_NOBUF|NVREG_IRQ_TX_ERR| \
+					NVREG_IRQ_TX_OK|NVREG_IRQ_TIMER|NVREG_IRQ_LINK|NVREG_IRQ_TX_ERROR| \
+					NVREG_IRQ_TX1))
 
 	NvRegUnknownSetupReg6 = 0x008,
 #define NVREG_UNKSETUP6_VAL		3
@@ -296,7 +298,7 @@
 
 #define NV_TX_LASTPACKET	(1<<16)
 #define NV_TX_RETRYERROR	(1<<19)
-#define NV_TX_LASTPACKET1	(1<<24)
+#define NV_TX_FORCED_INTERRUPT	(1<<24)
 #define NV_TX_DEFERRED		(1<<26)
 #define NV_TX_CARRIERLOST	(1<<27)
 #define NV_TX_LATECOLLISION	(1<<28)
@@ -306,7 +308,7 @@
 
 #define NV_TX2_LASTPACKET	(1<<29)
 #define NV_TX2_RETRYERROR	(1<<18)
-#define NV_TX2_LASTPACKET1	(1<<23)
+#define NV_TX2_FORCED_INTERRUPT	(1<<30)
 #define NV_TX2_DEFERRED		(1<<25)
 #define NV_TX2_CARRIERLOST	(1<<26)
 #define NV_TX2_LATECOLLISION	(1<<27)
@@ -1013,9 +1015,39 @@
 	struct fe_priv *np = get_nvpriv(dev);
 	u8 __iomem *base = get_hwbase(dev);
 
-	dprintk(KERN_DEBUG "%s: Got tx_timeout. irq: %08x\n", dev->name,
+	printk(KERN_INFO "%s: Got tx_timeout. irq: %08x\n", dev->name,
 			readl(base + NvRegIrqStatus) & NVREG_IRQSTAT_MASK);
 
+	{
+		int i;
+
+		printk(KERN_INFO "%s: Ring at %lx: next %d nic %d\n",
+				dev->name, (unsigned long)np->ring_addr,
+				np->next_tx, np->nic_tx);
+		printk(KERN_INFO "%s: Dumping tx registers\n", dev->name);
+		for (i=0;i<0x400;i+= 32) {
+			printk(KERN_INFO "%3x: %08x %08x %08x %08x %08x %08x %08x %08x\n",
+					i,
+					readl(base + i + 0), readl(base + i + 4),
+					readl(base + i + 8), readl(base + i + 12),
+					readl(base + i + 16), readl(base + i + 20),
+					readl(base + i + 24), readl(base + i + 28));
+		}
+		printk(KERN_INFO "%s: Dumping tx ring\n", dev->name);
+		for (i=0;i<TX_RING;i+= 4) {
+			printk(KERN_INFO "%03x: %08x %08x // %08x %08x // %08x %08x // %08x %08x\n",
+					i, 
+					le32_to_cpu(np->tx_ring[i].PacketBuffer),
+					le32_to_cpu(np->tx_ring[i].FlagLen),
+					le32_to_cpu(np->tx_ring[i+1].PacketBuffer),
+					le32_to_cpu(np->tx_ring[i+1].FlagLen),
+					le32_to_cpu(np->tx_ring[i+2].PacketBuffer),
+					le32_to_cpu(np->tx_ring[i+2].FlagLen),
+					le32_to_cpu(np->tx_ring[i+3].PacketBuffer),
+					le32_to_cpu(np->tx_ring[i+3].FlagLen));
+		}
+	}
+
 	spin_lock_irq(&np->lock);
 
 	/* 1) stop tx engine */
@@ -1557,7 +1589,7 @@
 		if (!(events & np->irqmask))
 			break;
 
-		if (events & (NVREG_IRQ_TX1|NVREG_IRQ_TX2|NVREG_IRQ_TX_ERR)) {
+		if (events & (NVREG_IRQ_TX1|NVREG_IRQ_TX_OK|NVREG_IRQ_TX_ERROR|NVREG_IRQ_TX_ERR)) {
 			spin_lock(&np->lock);
 			nv_tx_done(dev);
 			spin_unlock(&np->lock);
@@ -2213,17 +2245,10 @@
 
 	if (np->desc_ver == DESC_VER_1) {
 		np->tx_flags = NV_TX_LASTPACKET|NV_TX_VALID;
-		if (id->driver_data & DEV_NEED_LASTPACKET1)
-			np->tx_flags |= NV_TX_LASTPACKET1;
 	} else {
 		np->tx_flags = NV_TX2_LASTPACKET|NV_TX2_VALID;
-		if (id->driver_data & DEV_NEED_LASTPACKET1)
-			np->tx_flags |= NV_TX2_LASTPACKET1;
 	}
-	if (id->driver_data & DEV_IRQMASK_1)
-		np->irqmask = NVREG_IRQMASK_WANTED_1;
-	if (id->driver_data & DEV_IRQMASK_2)
-		np->irqmask = NVREG_IRQMASK_WANTED_2;
+	np->irqmask = NVREG_IRQMASK_WANTED;
 	if (id->driver_data & DEV_NEED_TIMERIRQ)
 		np->irqmask |= NVREG_IRQ_TIMER;
 	if (id->driver_data & DEV_NEED_LINKTIMER) {
@@ -2329,73 +2354,63 @@
 static struct pci_device_id pci_tbl[] = {
 	{	/* nForce Ethernet Controller */
 		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_1),
-		.driver_data = DEV_IRQMASK_1|DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER,
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER,
 	},
 	{	/* nForce2 Ethernet Controller */
 		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_2),
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER,
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER,
 	},
 	{	/* nForce3 Ethernet Controller */
 		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_3),
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER,
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER,
 	},
 	{	/* nForce3 Ethernet Controller */
 		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_4),
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ|
-			DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
 	},
 	{	/* nForce3 Ethernet Controller */
 		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_5),
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ|
-			DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
 	},
 	{	/* nForce3 Ethernet Controller */
 		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_6),
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ|
-			DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
 	},
 	{	/* nForce3 Ethernet Controller */
 		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_7),
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ|
-			DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
 	},
 	{	/* CK804 Ethernet Controller */
 		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_8),
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ|
-			DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
 	},
 	{	/* CK804 Ethernet Controller */
 		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_9),
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ|
-			DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
 	},
 	{	/* MCP04 Ethernet Controller */
 		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_10),
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ|
-			DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
 	},
 	{	/* MCP04 Ethernet Controller */
 		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_11),
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ|
-			DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
 	},
 	{	/* MCP51 Ethernet Controller */
 		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_12),
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER,
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER,
 	},
 	{	/* MCP51 Ethernet Controller */
 		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_13),
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER,
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER,
 	},
 	{	/* MCP55 Ethernet Controller */
 		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_14),
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ|
-			DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
 	},
 	{	/* MCP55 Ethernet Controller */
 		PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NVENET_15),
-		.driver_data = DEV_NEED_LASTPACKET1|DEV_IRQMASK_2|DEV_NEED_TIMERIRQ|
-			DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
+		.driver_data = DEV_NEED_TIMERIRQ|DEV_NEED_LINKTIMER|DEV_HAS_LARGEDESC,
 	},
 	{0,},
 };

--------------070800010001050908070209--
