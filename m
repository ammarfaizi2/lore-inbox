Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272152AbTG2VSk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 17:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272069AbTG2VSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 17:18:40 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:10150 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S272152AbTG2VMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 17:12:08 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.0-test2 wanXL driver
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 29 Jul 2003 22:59:21 +0200
Message-ID: <m3lluhnj6e.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

The following patch adds support wanXL sync serial adapters from SBE Inc.
They were supported in Linux 2.2 but the driver had to rely on
SBE-supplied closed-source firmware which was apparently unstable
in certain configurations. Therefore the old driver has never been
included in Linux 2.4.

This driver has been written from scratch and it contains open-source
firmware for the on-board QUICC processor.

Please apply.
Thanks.
-- 
Krzysztof Halasa
Network Administrator

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=wanxl-2.6.0-test2-1.15.patch

--- linux-2.6.orig/drivers/net/wan/Makefile	2003-05-27 03:00:41.000000000 +0200
+++ linux-2.6/drivers/net/wan/Makefile	2003-07-13 23:08:09.000000000 +0200
@@ -66,3 +66,25 @@
 endif
 obj-$(CONFIG_N2)		+= n2.o
 obj-$(CONFIG_C101)		+= c101.o
+obj-$(CONFIG_WANXL)		+= wanxl.o
+
+ifeq ($(CONFIG_WANXL_BUILD_FIRMWARE),y)
+ifeq ($(ARCH),m68k)
+  AS68K = $(AS)
+  LD68K = $(LD)
+else
+  AS68K = as68k
+  LD68K = ld68k
+endif
+
+quiet_cmd_build_wanxlfw = BLD FW  $@
+      cmd_build_wanxlfw = \
+	$(CPP) -Wp,-MD,$(depfile) -Iinclude $(obj)/wanxlfw.S | $(AS68K) -m68360 -o $(obj)/wanxlfw.o; \
+	$(LD68K) --oformat binary -Ttext 0x1000 $(obj)/wanxlfw.o -o $(obj)/wanxlfw.bin; \
+	hexdump -ve '"\n" 16/1 "0x%02X,"' $(obj)/wanxlfw.bin | sed 's/0x  ,//g;1s/^/static u8 firmware[]={/;$$s/,$$/\n};\n/' >$(obj)/wanxlfw.inc; \
+	rm -f $(obj)/wanxlfw.bin $(obj)/wanxlfw.o
+
+$(obj)/wanxlfw.inc:	$(obj)/wanxlfw.S
+	$(call if_changed_dep,build_wanxlfw)
+targets += wanxlfw.inc
+endif
--- linux-2.6.orig/drivers/net/wan/wanxl.h	2003-07-29 19:21:04.000000000 +0200
+++ linux-2.6/drivers/net/wan/wanxl.h	2003-07-17 20:37:34.000000000 +0200
@@ -0,0 +1,152 @@
+/*
+ * wanXL serial card driver for Linux
+ * definitions common to host driver and card firmware
+ *
+ * Copyright (C) 2003 Krzysztof Halasa <khc@pm.waw.pl>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License
+ * as published by the Free Software Foundation.
+ */
+
+#define RESET_WHILE_LOADING 0
+
+/* firmware rebuild is required if any of the following is changed */
+#define DETECT_RAM 0		/* needed for > 4MB RAM, 16 MB maximum */
+#define QUICC_MEMCPY_USES_PLX 1	/* must be used if the host has > 256 MB RAM */
+
+
+#define STATUS_CABLE_V35	2
+#define STATUS_CABLE_X21	3
+#define STATUS_CABLE_V24	4
+#define STATUS_CABLE_EIA530	5
+#define STATUS_CABLE_INVALID	6
+#define STATUS_CABLE_NONE	7
+
+#define STATUS_CABLE_DCE	0x8000
+#define STATUS_CABLE_DSR	0x0010
+#define STATUS_CABLE_DCD	0x0008
+#define STATUS_CABLE_PM_SHIFT	5
+
+#define PDM_OFFSET 0x1000
+
+#define TX_BUFFERS 10		/* per port */
+#define RX_BUFFERS 30
+#define RX_QUEUE_LENGTH 40	/* card->host queue length - per card */
+
+#define PACKET_EMPTY		0x00
+#define PACKET_FULL		0x10
+#define PACKET_SENT		0x20 /* TX only */
+#define PACKET_UNDERRUN		0x30 /* TX only */
+#define PACKET_PORT_MASK	0x03 /* RX only */
+
+/* bit numbers in PLX9060 doorbell registers */
+#define DOORBELL_FROM_CARD_TX_0		0 /* packet sent by the card */
+#define DOORBELL_FROM_CARD_TX_1		1
+#define DOORBELL_FROM_CARD_TX_2		2
+#define DOORBELL_FROM_CARD_TX_3		3
+#define DOORBELL_FROM_CARD_RX		4
+#define DOORBELL_FROM_CARD_CABLE_0	5 /* cable/PM/etc. changed */
+#define DOORBELL_FROM_CARD_CABLE_1	6
+#define DOORBELL_FROM_CARD_CABLE_2	7
+#define DOORBELL_FROM_CARD_CABLE_3	8
+
+#define DOORBELL_TO_CARD_OPEN_0		0
+#define DOORBELL_TO_CARD_OPEN_1		1
+#define DOORBELL_TO_CARD_OPEN_2		2
+#define DOORBELL_TO_CARD_OPEN_3		3
+#define DOORBELL_TO_CARD_CLOSE_0	4
+#define DOORBELL_TO_CARD_CLOSE_1	5
+#define DOORBELL_TO_CARD_CLOSE_2	6
+#define DOORBELL_TO_CARD_CLOSE_3	7
+#define DOORBELL_TO_CARD_TX_0		8 /* outbound packet queued */
+#define DOORBELL_TO_CARD_TX_1		9
+#define DOORBELL_TO_CARD_TX_2		10
+#define DOORBELL_TO_CARD_TX_3		11
+
+/* firmware-only status bits, starting from last DOORBELL_TO_CARD + 1 */
+#define TASK_SCC_0			12
+#define TASK_SCC_1			13
+#define TASK_SCC_2			14
+#define TASK_SCC_3			15
+
+#define ALIGN32(x) (((x) + 3) & 0xFFFFFFFC)
+#define BUFFER_LENGTH	ALIGN32(HDLC_MAX_MRU + 4) /* 4 bytes for 32-bit CRC */
+
+/* Address of TX and RX buffers in 68360 address space */
+#define BUFFERS_ADDR	0x4000	/* 16 KB */
+
+#ifndef __ASSEMBLER__
+#define PLX_OFFSET		0
+#else
+#define PLX_OFFSET		PLX + 0x80
+#endif
+
+#define PLX_MAILBOX_0		(PLX_OFFSET + 0x40)
+#define PLX_MAILBOX_1		(PLX_OFFSET + 0x44)
+#define PLX_MAILBOX_2		(PLX_OFFSET + 0x48)
+#define PLX_MAILBOX_3		(PLX_OFFSET + 0x4C)
+#define PLX_MAILBOX_4		(PLX_OFFSET + 0x50)
+#define PLX_MAILBOX_5		(PLX_OFFSET + 0x54)
+#define PLX_MAILBOX_6		(PLX_OFFSET + 0x58)
+#define PLX_MAILBOX_7		(PLX_OFFSET + 0x5C)
+#define PLX_DOORBELL_TO_CARD	(PLX_OFFSET + 0x60)
+#define PLX_DOORBELL_FROM_CARD	(PLX_OFFSET + 0x64)
+#define PLX_INTERRUPT_CS	(PLX_OFFSET + 0x68)
+#define PLX_CONTROL		(PLX_OFFSET + 0x6C)
+
+#ifdef __ASSEMBLER__
+#define PLX_DMA_0_MODE		(PLX + 0x100)
+#define PLX_DMA_0_PCI		(PLX + 0x104)
+#define PLX_DMA_0_LOCAL		(PLX + 0x108)
+#define PLX_DMA_0_LENGTH	(PLX + 0x10C)
+#define PLX_DMA_0_DESC		(PLX + 0x110)
+#define PLX_DMA_1_MODE		(PLX + 0x114)
+#define PLX_DMA_1_PCI		(PLX + 0x118)
+#define PLX_DMA_1_LOCAL		(PLX + 0x11C)
+#define PLX_DMA_1_LENGTH	(PLX + 0x120)
+#define PLX_DMA_1_DESC		(PLX + 0x124)
+#define PLX_DMA_CMD_STS		(PLX + 0x128)
+#define PLX_DMA_ARBITR_0	(PLX + 0x12C)
+#define PLX_DMA_ARBITR_1	(PLX + 0x130)
+#endif
+
+#define DESC_LENGTH 12
+
+/* offsets from start of status_t */
+/* card to host */
+#define STATUS_OPEN		0
+#define STATUS_CABLE		(STATUS_OPEN + 4)
+#define STATUS_RX_OVERRUNS	(STATUS_CABLE + 4)
+#define STATUS_RX_FRAME_ERRORS	(STATUS_RX_OVERRUNS + 4)
+
+/* host to card */
+#define STATUS_PARITY		(STATUS_RX_FRAME_ERRORS + 4)
+#define STATUS_ENCODING		(STATUS_PARITY + 4)
+#define STATUS_CLOCKING		(STATUS_ENCODING + 4)
+#define STATUS_TX_DESCS		(STATUS_CLOCKING + 4)
+
+#ifndef __ASSEMBLER__
+
+typedef struct {
+	volatile u32 stat;
+	u32 address;		/* PCI address */
+	volatile u32 length;
+}desc_t;
+
+
+typedef struct {
+// Card to host
+	volatile u32 open;
+	volatile u32 cable;
+	volatile u32 rx_overruns;
+	volatile u32 rx_frame_errors;
+
+// Host to card
+	u32 parity;
+	u32 encoding;
+	u32 clocking;
+	desc_t tx_descs[TX_BUFFERS];
+}port_status_t;
+
+#endif /* __ASSEMBLER__ */
--- linux-2.6.orig/drivers/net/wan/wanxl.c	2003-07-29 19:21:04.000000000 +0200
+++ linux-2.6/drivers/net/wan/wanxl.c	2003-07-23 15:12:31.000000000 +0200
@@ -0,0 +1,744 @@
+/*
+ * wanXL serial card driver for Linux
+ * host part
+ *
+ * Copyright (C) 2003 Krzysztof Halasa <khc@pm.waw.pl>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License
+ * as published by the Free Software Foundation.
+ *
+ * Status:
+ *   - Only DTE (external clock) support with NRZ and NRZI encodings
+ *   - wanXL100 will require minor driver modifications, no access to hw
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/fcntl.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/netdevice.h>
+#include <linux/hdlc.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+#include <asm/delay.h>
+
+#include "wanxl.h"
+
+static const char* version = "wanXL serial card driver version: 0.44";
+
+#define PLX_CTL_RESET   0x40000000 /* adapter reset */
+
+/* MAILBOX #1 - PUTS COMMANDS */
+#define MBX1_CMD_ABORTJ 0x85000000 /* Abort and Jump */
+#ifdef __LITTLE_ENDIAN
+#define MBX1_CMD_BSWAP  0x8C000001 /* little-endian Byte Swap Mode */
+#else
+#define MBX1_CMD_BSWAP  0x8C000000 /* big-endian Byte Swap Mode */
+#endif
+
+/* MAILBOX #2 - DRAM SIZE */
+#define MBX2_MEMSZ_MASK 0xFFFF0000 /* PUTS Memory Size Register mask */
+
+
+typedef struct {
+	hdlc_device hdlc;	/* HDLC device struct - must be first */
+	struct card_t *card;
+	spinlock_t lock;	/* for wanxl_xmit */
+	int node;		/* physical port #0 - 3 */
+	unsigned int clock_type;
+	int tx_in, tx_out;
+	struct sk_buff *tx_skbs[TX_BUFFERS];
+	port_status_t status;	/* shared between host and card */
+}port_t;
+
+
+typedef struct card_t {
+	int n_ports;		/* 1, 2 or 4 ports */
+	u8 irq;
+
+	u8 *plx;		/* PLX PCI9060 virtual base address */
+	struct pci_dev *pdev;	/* for pdev->slot_name */
+	port_t *ports[4];
+	int rx_in;
+	struct sk_buff *rx_skbs[RX_QUEUE_LENGTH];
+	desc_t rx_descs[RX_QUEUE_LENGTH]; /* shared between host and card */
+}card_t;
+
+
+
+static inline port_t* hdlc_to_port(hdlc_device *hdlc)
+{
+        return (port_t*)hdlc;
+}
+
+
+static inline port_t* dev_to_port(struct net_device *dev)
+{
+        return hdlc_to_port(dev_to_hdlc(dev));
+}
+
+
+static inline const char* port_name(port_t *port)
+{
+	return hdlc_to_name((hdlc_device*)port);
+}
+
+
+static inline const char* card_name(struct pci_dev *pdev)
+{
+	return pdev->slot_name;
+}
+
+
+
+/* Cable and/or personality module change interrupt service */
+static inline void wanxl_cable_intr(port_t *port)
+{
+	u32 value = port->status.cable;
+	int valid = 1;
+	const char *cable, *pm, *dte = "", *dsr = "", *dcd = "";
+
+	switch(value & 0x7) {
+	case STATUS_CABLE_V35: cable = "V.35"; break;
+	case STATUS_CABLE_X21: cable = "X.21"; break;
+	case STATUS_CABLE_V24: cable = "V.24"; break;
+	case STATUS_CABLE_EIA530: cable = "EIA530"; break;
+	case STATUS_CABLE_NONE: cable = "no"; break;
+	default: cable = "invalid";
+	}
+
+	switch((value >> STATUS_CABLE_PM_SHIFT) & 0x7) {
+	case STATUS_CABLE_V35: pm = "V.35"; break;
+	case STATUS_CABLE_X21: pm = "X.21"; break;
+	case STATUS_CABLE_V24: pm = "V.24"; break;
+	case STATUS_CABLE_EIA530: pm = "EIA530"; break;
+	case STATUS_CABLE_NONE: pm = "no personality"; valid = 0; break;
+	default: pm = "invalid personality"; valid = 0;
+	}
+
+	if (valid) {
+		if ((value & 7) == ((value >> STATUS_CABLE_PM_SHIFT) & 7)) {
+			dsr = (value & STATUS_CABLE_DSR) ? ", DSR ON" :
+				", DSR off";
+			dcd = (value & STATUS_CABLE_DCD) ? ", carrier ON" :
+				", carrier off";
+		}
+		dte = (value & STATUS_CABLE_DCE) ? " DCE" : " DTE";
+	}
+	printk(KERN_INFO "%s: %s%s module, %s cable%s%s\n",
+	       port_name(port), pm, dte, cable, dsr, dcd);
+
+	hdlc_set_carrier(value & STATUS_CABLE_DCD, &port->hdlc);
+}
+
+
+
+/* Transmit complete interrupt service */
+static inline void wanxl_tx_intr(port_t *port)
+{
+	while (1) {
+                desc_t *desc;
+		desc = &port->status.tx_descs[port->tx_in];
+		struct sk_buff *skb = port->tx_skbs[port->tx_in];
+
+		switch (desc->stat) {
+		case PACKET_FULL:
+		case PACKET_EMPTY:
+			netif_wake_queue(&port->hdlc.netdev);
+			return;
+
+		case PACKET_UNDERRUN:
+			port->hdlc.stats.tx_errors++;
+			port->hdlc.stats.tx_fifo_errors++;
+			break;
+
+		default:
+			port->hdlc.stats.tx_packets++;
+			port->hdlc.stats.tx_bytes += skb->len;
+		}
+                desc->stat = PACKET_EMPTY; /* Free descriptor */
+		dev_kfree_skb_irq(skb);
+                port->tx_in = (port->tx_in + 1) % TX_BUFFERS;
+        }
+}
+
+
+
+/* Receive complete interrupt service */
+static inline void wanxl_rx_intr(card_t *card)
+{
+	desc_t *desc;
+	port_t *port;
+	while(desc = &card->rx_descs[card->rx_in], desc->stat != PACKET_EMPTY){
+		struct sk_buff *skb = card->rx_skbs[card->rx_in];
+		port = card->ports[desc->stat & PACKET_PORT_MASK];
+
+		if ((desc->stat & PACKET_PORT_MASK) > card->n_ports)
+			printk(KERN_CRIT "wanXL %s: received packet for"
+			       " nonexistent port\n", card_name(card->pdev));
+
+		else if (!skb)
+			port->hdlc.stats.rx_dropped++;
+
+		else {
+			skb_put(skb, desc->length);
+
+#ifdef CONFIG_HDLC_DEBUG_PKT
+			printk(KERN_DEBUG "%s RX(%i):", port_name(port),
+			       skb->len);
+			debug_frame(skb);
+#endif
+			port->hdlc.stats.rx_packets++;
+			port->hdlc.stats.rx_bytes += skb->len;
+			skb->mac.raw = skb->data;
+			skb->dev = hdlc_to_dev(&port->hdlc);
+			skb->dev->last_rx = jiffies;
+			skb->protocol =
+				hdlc_type_trans(skb, hdlc_to_dev(&port->hdlc));
+			netif_rx(skb);
+			skb = NULL;
+		}
+
+		if (!skb) {
+			skb = dev_alloc_skb(BUFFER_LENGTH);
+			desc->address = skb ? virt_to_bus(skb->data) : 0;
+			card->rx_skbs[card->rx_in] = skb;
+		}
+		desc->stat = PACKET_EMPTY; /* Free descriptor */
+		card->rx_in = (card->rx_in + 1) % RX_QUEUE_LENGTH;
+	}
+}
+
+
+
+static irqreturn_t wanxl_intr(int irq, void* dev_id, struct pt_regs *regs)
+{
+        card_t *card = dev_id;
+        int i;
+        u32 stat;
+        int handled = 0;
+
+
+        while((stat = readl(card->plx + PLX_DOORBELL_FROM_CARD)) != 0) {
+                handled = 1;
+		writel(stat, card->plx + PLX_DOORBELL_FROM_CARD);
+
+                for (i = 0; i < card->n_ports; i++) {
+			if (stat & (1 << (DOORBELL_FROM_CARD_TX_0 + i)))
+				wanxl_tx_intr(card->ports[i]);
+			if (stat & (1 << (DOORBELL_FROM_CARD_CABLE_0 + i)))
+				wanxl_cable_intr(card->ports[i]);
+		}
+		if (stat & (1 << DOORBELL_FROM_CARD_RX))
+			wanxl_rx_intr(card);
+        }
+
+        return IRQ_RETVAL(handled);
+}
+
+
+
+static int wanxl_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	hdlc_device *hdlc = dev_to_hdlc(dev);
+        port_t *port = hdlc_to_port(hdlc);
+
+        spin_lock(&port->lock);
+
+	desc_t *desc = &port->status.tx_descs[port->tx_out];
+        if (desc->stat != PACKET_EMPTY) {
+                /* should never happen - previous xmit should stop queue */
+#ifdef CONFIG_HDLC_DEBUG_PKT
+                printk(KERN_DEBUG "%s: transmitter buffer full\n",
+		       port_name(port));
+#endif
+		netif_stop_queue(&hdlc->netdev);
+		spin_unlock_irq(&port->lock);
+		return 1;       /* request packet to be queued */
+	}
+
+#ifdef CONFIG_HDLC_DEBUG_PKT
+	printk(KERN_DEBUG "%s TX(%i):", port_name(port), skb->len);
+	debug_frame(skb);
+#endif
+
+	port->tx_skbs[port->tx_out] = skb;
+	desc->address = virt_to_bus(skb->data);
+	desc->length = skb->len;
+	desc->stat = PACKET_FULL;
+	writel(1 << (DOORBELL_TO_CARD_TX_0 + port->node),
+	       port->card->plx + PLX_DOORBELL_TO_CARD);
+	dev->trans_start = jiffies;
+
+	port->tx_out = (port->tx_out + 1) % TX_BUFFERS;
+
+	if (port->status.tx_descs[port->tx_out].stat != PACKET_EMPTY) {
+		netif_stop_queue(&hdlc->netdev);
+#ifdef CONFIG_HDLC_DEBUG_PKT
+		printk(KERN_DEBUG "%s: transmitter buffer full\n",
+		       port_name(port));
+#endif
+	}
+
+	spin_unlock(&port->lock);
+	return 0;
+}
+
+
+
+static int wanxl_attach(hdlc_device *hdlc, unsigned short encoding,
+			unsigned short parity)
+{
+	port_t *port = hdlc_to_port(hdlc);
+
+	if (encoding != ENCODING_NRZ &&
+	    encoding != ENCODING_NRZI)
+		return -EINVAL;
+
+	if (parity != PARITY_NONE &&
+	    parity != PARITY_CRC32_PR1_CCITT &&
+	    parity != PARITY_CRC16_PR1_CCITT &&
+	    parity != PARITY_CRC32_PR0_CCITT &&
+	    parity != PARITY_CRC16_PR0_CCITT)
+		return -EINVAL;
+
+	port->status.encoding = encoding;
+	port->status.parity = parity;
+	return 0;
+}
+
+
+
+static int wanxl_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+{
+	const size_t size = sizeof(sync_serial_settings);
+	sync_serial_settings line;
+	hdlc_device *hdlc = dev_to_hdlc(dev);
+	port_t *port = hdlc_to_port(hdlc);
+
+	if (cmd != SIOCWANDEV)
+		return hdlc_ioctl(dev, ifr, cmd);
+
+	switch (ifr->ifr_settings.type) {
+	case IF_GET_IFACE:
+		ifr->ifr_settings.type = IF_IFACE_SYNC_SERIAL;
+		if (ifr->ifr_settings.size < size) {
+			ifr->ifr_settings.size = size; /* data size wanted */
+			return -ENOBUFS;
+		}
+		line.clock_type = port->status.clocking;
+		line.clock_rate = 0;
+		line.loopback = 0;
+
+		if (copy_to_user(ifr->ifr_settings.ifs_ifsu.sync, &line, size))
+			return -EFAULT;
+		return 0;
+
+	case IF_IFACE_SYNC_SERIAL:
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+		if (dev->flags & IFF_UP)
+			return -EBUSY;
+
+		if (copy_from_user(&line, ifr->ifr_settings.ifs_ifsu.sync,
+				   size))
+			return -EFAULT;
+
+		if (line.clock_type != CLOCK_EXT &&
+		    line.clock_type != CLOCK_TXFROMRX)
+			return -EINVAL; /* No such clock setting */
+
+		if (line.loopback != 0)
+			return -EINVAL;
+
+		port->status.clocking = line.clock_type;
+		return 0;
+
+	default:
+		return hdlc_ioctl(dev, ifr, cmd);
+        }
+}
+
+
+
+static int wanxl_open(struct net_device *dev)
+{
+	hdlc_device *hdlc = dev_to_hdlc(dev);
+	port_t *port = hdlc_to_port(hdlc);
+	u8 *dbr = port->card->plx + PLX_DOORBELL_TO_CARD;
+	long start;
+	int i;
+
+	if (port->status.open) {
+		printk(KERN_ERR "%s: port already open\n", port_name(port));
+		return -EIO;
+	}
+	if ((i = hdlc_open(hdlc)) != 0)
+		return i;
+
+	port->tx_in = port->tx_out = 0;
+	for (i = 0; i < TX_BUFFERS; i++)
+		port->status.tx_descs[i].stat = PACKET_EMPTY;
+	/* signal the card */
+	writel(1 << (DOORBELL_TO_CARD_OPEN_0 + port->node), dbr);
+
+	start = jiffies;
+	do
+		if (port->status.open)
+			return 0;
+	while (jiffies - start < HZ);
+
+	printk(KERN_ERR "%s: unable to open port\n", port_name(port));
+	/* ask the card to close the port, should it be still alive */
+	writel(1 << (DOORBELL_TO_CARD_CLOSE_0 + port->node), dbr);
+	return -EFAULT;
+}
+
+
+
+static int wanxl_close(struct net_device *dev)
+{
+	hdlc_device *hdlc = dev_to_hdlc(dev);
+	port_t *port = hdlc_to_port(hdlc);
+	long start;
+	int i;
+
+	hdlc_close(hdlc);
+	/* signal the card */
+	writel(1 << (DOORBELL_TO_CARD_CLOSE_0 + port->node),
+	       port->card->plx + PLX_DOORBELL_TO_CARD);
+
+	start = jiffies;
+	do
+		if (!port->status.open)
+			break;
+	while (jiffies - start < HZ);
+
+	if (port->status.open)
+		printk(KERN_ERR "%s: unable to close port\n", port_name(port));
+
+	for (i = 0; i < TX_BUFFERS; i++) {
+		desc_t *desc = &port->status.tx_descs[i];
+
+		if (desc->stat != PACKET_EMPTY) {
+			desc->stat = PACKET_EMPTY;
+			dev_kfree_skb(port->tx_skbs[i]);
+		}
+	}
+	return 0;
+}
+
+
+
+static struct net_device_stats *wanxl_get_stats(struct net_device *dev)
+{
+	hdlc_device * hdlc = dev_to_hdlc(dev);
+	port_t *port = hdlc_to_port(hdlc);
+	
+	hdlc->stats.rx_over_errors = port->status.rx_overruns;
+	hdlc->stats.rx_frame_errors = port->status.rx_frame_errors;
+	hdlc->stats.rx_errors = hdlc->stats.rx_over_errors +
+		hdlc->stats.rx_frame_errors;
+        return &dev_to_hdlc(dev)->stats;
+}
+
+
+
+static int wanxl_puts_command(card_t *card, u32 cmd)
+{
+	u32 start = jiffies;
+
+	writel(cmd, card->plx + PLX_MAILBOX_1);
+	do {
+		if (readl(card->plx + PLX_MAILBOX_1) == 0)
+			return 0;
+
+		schedule();
+	}while (jiffies - start < 5 * HZ);
+
+	return -1;
+}
+
+
+
+static void wanxl_reset(card_t *card)
+{
+	u32 old_value = readl(card->plx + PLX_CONTROL) & ~PLX_CTL_RESET;
+
+	writel(0x80, card->plx + PLX_MAILBOX_0);
+	writel(old_value | PLX_CTL_RESET, card->plx + PLX_CONTROL);
+	readl(card->plx + PLX_CONTROL); /* wait for posted write */
+	udelay(1);
+	writel(old_value, card->plx + PLX_CONTROL);
+	readl(card->plx + PLX_CONTROL); /* wait for posted write */
+}
+
+
+
+static void wanxl_pci_remove_one(struct pci_dev *pdev)
+{
+	card_t *card = pci_get_drvdata(pdev);
+	int i;
+
+	/* unregister and free all host resources */
+	if (card->irq)
+		free_irq(card->irq, card);
+
+	for (i = 0; i < 4; i++)
+		if (card->ports[i]->card)
+			unregister_hdlc_device(&card->ports[i]->hdlc);
+
+	wanxl_reset(card);
+
+	for (i = 0; i < RX_QUEUE_LENGTH; i++)
+		if (card->rx_skbs[i])
+			dev_kfree_skb(card->rx_skbs[i]);
+
+	if (card->plx)
+		iounmap(card->plx);
+	pci_release_regions(pdev);
+	kfree(card);
+	pci_set_drvdata(pdev, NULL);
+}
+
+
+#include "wanxlfw.inc"
+
+static int __devinit wanxl_pci_init_one(struct pci_dev *pdev,
+					const struct pci_device_id *ent)
+{
+	card_t *card;
+	u32 ramsize, stat;
+	long start;
+	u32 plx_phy;		/* PLX PCI base address */
+	u32 mem_phy;		/* memory PCI base addr */
+	u8 *mem;		/* memory virtual base addr */
+	int i, ports, alloc_size;
+
+	i = pci_enable_device(pdev);
+	if (i)
+		return i;
+
+	i = pci_request_regions(pdev, "wanXL");
+	if (i)
+		return i;
+
+	switch (pdev->device) {
+	case PCI_DEVICE_ID_SBE_WANXL100: ports = 1; break;
+	case PCI_DEVICE_ID_SBE_WANXL200: ports = 2; break;
+	default: ports = 4;
+	}
+
+	alloc_size = sizeof(card_t) + ports * sizeof(port_t);
+	card = kmalloc(alloc_size, GFP_KERNEL);
+	if (virt_to_bus(card) + alloc_size > 256 * 1024 * 1024) {
+		/* wanXL can only access first 256 MB */
+		kfree(card);
+		card = kmalloc(alloc_size, GFP_KERNEL | GFP_DMA);
+	}
+	if (card == NULL) {
+		pci_release_regions(pdev);
+		printk(KERN_ERR "wanXL %s: unable to allocate memory\n",
+		       card_name(pdev));
+		return -ENOBUFS;
+	}
+	memset(card, 0, alloc_size);
+
+	pci_set_drvdata(pdev, card);
+	card->pdev = pdev;
+	card->n_ports = ports;
+
+	/* set up PLX mapping */
+	plx_phy = pci_resource_start(pdev, 0);
+	card->plx = ioremap_nocache(plx_phy, 0x70);
+
+#if RESET_WHILE_LOADING
+	wanxl_reset(card);
+#endif
+
+	start = jiffies;
+	while ((stat = readl(card->plx + PLX_MAILBOX_0)) != 0) {
+		if (jiffies - start >= 20 * HZ) {
+			printk(KERN_WARNING "wanXL %s: timeout waiting for"
+			       " PUTS to complete\n", card_name(pdev));
+			return -ENODEV;
+		}
+
+		switch(stat & 0xC0) {
+		case 0x00:	/* hmm - PUTS completed with non-zero code? */
+		case 0x80:	/* PUTS still testing the hardware */
+			break;
+
+		default:
+			printk(KERN_WARNING "wanXL %s: PUTS test 0x%X"
+			       " failed\n", card_name(pdev), stat & 0x30);
+			return -ENODEV;
+		}
+
+		schedule();
+	}
+
+	/* get on-board memory size (PUTS detects no more than 4 MB) */
+	ramsize = readl(card->plx + PLX_MAILBOX_2) & MBX2_MEMSZ_MASK;
+
+	/* set up on-board RAM mapping */
+	mem_phy = pci_resource_start(pdev, 2);
+
+
+	/* sanity check the board's reported memory size */
+	if (ramsize < BUFFERS_ADDR +
+	    (TX_BUFFERS + RX_BUFFERS) * BUFFER_LENGTH * ports) {
+		printk(KERN_WARNING "wanXL %s: no enough on-board RAM"
+		       " (%u bytes detected, %u bytes required)\n",
+		       card_name(pdev), ramsize, BUFFERS_ADDR +
+		       (TX_BUFFERS + RX_BUFFERS) * BUFFER_LENGTH * ports);
+		wanxl_pci_remove_one(pdev);
+		return -ENODEV;
+	}
+
+	if (wanxl_puts_command(card, MBX1_CMD_BSWAP)) {
+		printk(KERN_WARNING "wanXL %s: unable to Set Byte Swap"
+		       " Mode\n", card_name(pdev));
+		wanxl_pci_remove_one(pdev);
+		return -ENODEV;
+	}
+
+	for (i = 0; i < ports; i++) {
+		port_t *port = card->ports[i] = (void *)card + sizeof(card_t) +
+			i * sizeof(port_t);
+		struct net_device *dev = hdlc_to_dev(&port->hdlc);
+		spin_lock_init(&port->lock);
+		SET_MODULE_OWNER(dev);
+		dev->tx_queue_len = 50;
+		dev->do_ioctl = wanxl_ioctl;
+		dev->open = wanxl_open;
+		dev->stop = wanxl_close;
+		port->hdlc.attach = wanxl_attach;
+		port->hdlc.xmit = wanxl_xmit;
+		if(register_hdlc_device(&port->hdlc)) {
+			printk(KERN_ERR "wanXL %s: unable to register hdlc"
+			       " device\n", card_name(pdev));
+			wanxl_pci_remove_one(pdev);
+			return -ENOBUFS;
+		}
+		dev->get_stats = wanxl_get_stats;
+		port->card = card;
+		port->node = i;
+		port->status.clocking = CLOCK_EXT;
+	}
+
+	for (i = 0; i < RX_QUEUE_LENGTH; i++) {
+		struct sk_buff *skb = dev_alloc_skb(BUFFER_LENGTH);
+		card->rx_skbs[i] = skb;
+		if (skb)
+			card->rx_descs[i].address = virt_to_bus(skb->data);
+	}
+
+	mem = ioremap_nocache(mem_phy, PDM_OFFSET + sizeof(firmware));
+	for (i = 0; i < sizeof(firmware); i += 4)
+		writel(htonl(*(u32*)(firmware + i)), mem + PDM_OFFSET + i);
+
+	for (i = 0; i < ports; i++)
+		writel(virt_to_bus(&card->ports[i]->status),
+		       mem + PDM_OFFSET + 4 + i * 4);
+	writel(virt_to_bus(card->rx_descs), mem + PDM_OFFSET + 20);
+
+	writel(PDM_OFFSET, mem);
+	iounmap(mem);
+
+	writel(0, card->plx + PLX_MAILBOX_5);
+
+	if (wanxl_puts_command(card, MBX1_CMD_ABORTJ)) {
+		printk(KERN_WARNING "wanXL %s: unable to Abort and Jump\n",
+		       card_name(pdev));
+		wanxl_pci_remove_one(pdev);
+		return -ENODEV;
+	}
+
+	stat = 0;
+	start = jiffies;
+	do {
+		if ((stat = readl(card->plx + PLX_MAILBOX_5)) != 0)
+			break;
+		schedule();
+	}while (jiffies - start < 5 * HZ);
+
+	if (!stat) {
+		printk(KERN_WARNING "wanXL %s: timeout while initializing card"
+		       "firmware\n", card_name(pdev));
+		wanxl_pci_remove_one(pdev);
+		return -ENODEV;
+	}
+
+#if DETECT_RAM
+	ramsize = stat;
+#endif
+
+	printk(KERN_INFO "wanXL %s: at 0x%X, %u KB of RAM at 0x%X, irq"
+	       " %u\n" KERN_INFO "wanXL %s: port", card_name(pdev),
+	       plx_phy, ramsize / 1024, mem_phy, pdev->irq, card_name(pdev));
+
+	for (i = 0; i < ports; i++)
+		printk("%s #%i: %s", i ? "," : "", i,
+		       port_name(card->ports[i]));
+	printk("\n");
+
+	/* Allocate IRQ */
+	if(request_irq(pdev->irq, wanxl_intr, SA_SHIRQ, "wanXL", card)) {
+		printk(KERN_WARNING "wanXL %s: could not allocate IRQ%i.\n",
+		       card_name(pdev), pdev->irq);
+		wanxl_pci_remove_one(pdev);
+		return -EBUSY;
+	}
+	card->irq = pdev->irq;
+
+	return 0;
+}
+
+static struct pci_device_id wanxl_pci_tbl[] __devinitdata = {
+	{ PCI_VENDOR_ID_SBE, PCI_DEVICE_ID_SBE_WANXL100, PCI_ANY_ID,
+	  PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_SBE, PCI_DEVICE_ID_SBE_WANXL200, PCI_ANY_ID,
+	  PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_SBE, PCI_DEVICE_ID_SBE_WANXL400, PCI_ANY_ID,
+	  PCI_ANY_ID, 0, 0, 0 },
+	{ 0, }
+};
+
+
+static struct pci_driver wanxl_pci_driver = {
+	name:           "wanXL",
+	id_table:       wanxl_pci_tbl,
+	probe:          wanxl_pci_init_one,
+	remove:         wanxl_pci_remove_one,
+};
+
+
+static int __init wanxl_init_module(void)
+{
+#ifdef MODULE
+	printk(KERN_INFO "%s\n", version);
+#endif
+	return pci_module_init(&wanxl_pci_driver);
+}
+
+static void __exit wanxl_cleanup_module(void)
+{
+	pci_unregister_driver(&wanxl_pci_driver);
+}
+
+
+MODULE_AUTHOR("Krzysztof Halasa <khc@pm.waw.pl>");
+MODULE_DESCRIPTION("SBE Inc. wanXL serial port driver");
+MODULE_LICENSE("GPL v2");
+MODULE_DEVICE_TABLE(pci, wanxl_pci_tbl);
+
+module_init(wanxl_init_module);
+module_exit(wanxl_cleanup_module);
--- linux-2.6.orig/drivers/net/wan/wanxlfw.S	2003-07-29 19:21:04.000000000 +0200
+++ linux-2.6/drivers/net/wan/wanxlfw.S	2003-07-16 00:48:50.000000000 +0200
@@ -0,0 +1,895 @@
+.psize 0
+/*
+  wanXL serial card driver for Linux
+  card firmware part
+
+  Copyright (C) 2003 Krzysztof Halasa <khc@pm.waw.pl>
+
+  This program is free software; you can redistribute it and/or modify it
+  under the terms of version 2 of the GNU General Public License
+  as published by the Free Software Foundation.
+
+
+
+
+	DPRAM BDs:
+	0x000 - 0x050 TX#0	0x050 - 0x140 RX#0
+	0x140 - 0x190 TX#1	0x190 - 0x280 RX#1
+	0x280 - 0x2D0 TX#2	0x2D0 - 0x3C0 RX#2
+	0x3C0 - 0x410 TX#3	0x410 - 0x500 RX#3
+
+
+	000 5FF 1536 Bytes Dual-Port RAM User Data / BDs
+	600 6FF 256 Bytes Dual-Port RAM User Data / BDs
+	700 7FF 256 Bytes Dual-Port RAM User Data / BDs
+	C00 CBF 192 Bytes Dual-Port RAM Parameter RAM Page 1
+	D00 DBF 192 Bytes Dual-Port RAM Parameter RAM Page 2
+	E00 EBF 192 Bytes Dual-Port RAM Parameter RAM Page 3
+	F00 FBF 192 Bytes Dual-Port RAM Parameter RAM Page 4
+
+	local interrupts		    level
+	NMI					7
+	PIT timer, CPM (RX/TX complete)		4
+	PCI9060	DMA and PCI doorbells		3
+	Cable - not used			1
+*/
+
+#include <linux/hdlc.h>
+#include "wanxl.h"
+
+/* memory addresses and offsets */
+
+MAX_RAM_SIZE	= 16 * 1024 * 1024	// max RAM supported by hardware
+
+PCI9060_VECTOR	= 0x0000006C
+CPM_IRQ_BASE	= 0x40
+ERROR_VECTOR	= CPM_IRQ_BASE * 4
+SCC1_VECTOR	= (CPM_IRQ_BASE + 0x1E) * 4
+SCC2_VECTOR	= (CPM_IRQ_BASE + 0x1D) * 4
+SCC3_VECTOR	= (CPM_IRQ_BASE + 0x1C) * 4
+SCC4_VECTOR	= (CPM_IRQ_BASE + 0x1B) * 4
+CPM_IRQ_LEVEL	= 4
+TIMER_IRQ	= 128
+TIMER_IRQ_LEVEL = 4
+PITR_CONST	= 0x100 + 16		// 1 Hz timer
+
+MBAR		= 0x0003FF00
+
+VALUE_WINDOW	= 0x40000000
+ORDER_WINDOW	= 0xC0000000
+
+PLX		= 0xFFF90000
+
+CSRA		= 0xFFFB0000
+CSRB		= 0xFFFB0002
+CSRC		= 0xFFFB0004
+CSRD		= 0xFFFB0006
+STATUS_CABLE_LL		= 0x2000
+STATUS_CABLE_DTR	= 0x1000
+
+DPRBASE		= 0xFFFC0000
+
+SCC1_BASE	= DPRBASE + 0xC00
+MISC_BASE	= DPRBASE + 0xCB0
+SCC2_BASE	= DPRBASE + 0xD00
+SCC3_BASE	= DPRBASE + 0xE00
+SCC4_BASE	= DPRBASE + 0xF00
+
+// offset from SCCx_BASE
+// SCC_xBASE contain offsets from DPRBASE and must be divisible by 8
+SCC_RBASE	= 0		// 16-bit RxBD base address
+SCC_TBASE	= 2		// 16-bit TxBD base address
+SCC_RFCR	= 4		// 8-bit Rx function code
+SCC_TFCR	= 5		// 8-bit Tx function code
+SCC_MRBLR	= 6		// 16-bit maximum Rx buffer length
+SCC_C_MASK	= 0x34		// 32-bit CRC constant
+SCC_C_PRES	= 0x38		// 32-bit CRC preset
+SCC_MFLR	= 0x46		// 16-bit max Rx frame length (without flags)
+
+REGBASE		= DPRBASE + 0x1000
+PICR		= REGBASE + 0x026	// 16-bit periodic irq control
+PITR		= REGBASE + 0x02A	// 16-bit periodic irq timing
+OR1		= REGBASE + 0x064	// 32-bit RAM bank #1 options
+CICR		= REGBASE + 0x540	// 32(24)-bit CP interrupt config
+CIMR		= REGBASE + 0x548	// 32-bit CP interrupt mask
+CISR		= REGBASE + 0x54C	// 32-bit CP interrupts in-service
+PADIR		= REGBASE + 0x550	// 16-bit PortA data direction bitmap
+PAPAR		= REGBASE + 0x552	// 16-bit PortA pin assignment bitmap
+PAODR		= REGBASE + 0x554	// 16-bit PortA open drain bitmap
+PADAT		= REGBASE + 0x556	// 16-bit PortA data register
+
+PCDIR		= REGBASE + 0x560	// 16-bit PortC data direction bitmap
+PCPAR		= REGBASE + 0x562	// 16-bit PortC pin assignment bitmap
+PCSO		= REGBASE + 0x564	// 16-bit PortC special options
+PCDAT		= REGBASE + 0x566	// 16-bit PortC data register
+PCINT		= REGBASE + 0x568	// 16-bit PortC interrupt control
+CR		= REGBASE + 0x5C0	// 16-bit Command register
+
+SCC1_REGS	= REGBASE + 0x600
+SCC2_REGS	= REGBASE + 0x620
+SCC3_REGS	= REGBASE + 0x640
+SCC4_REGS	= REGBASE + 0x660
+SICR		= REGBASE + 0x6EC	// 32-bit SI clock route
+
+// offset from SCCx_REGS
+SCC_GSMR_L	= 0x00	// 32 bits
+SCC_GSMR_H	= 0x04	// 32 bits
+SCC_PSMR	= 0x08	// 16 bits
+SCC_TODR	= 0x0C	// 16 bits
+SCC_DSR		= 0x0E	// 16 bits
+SCC_SCCE	= 0x10	// 16 bits
+SCC_SCCM	= 0x14	// 16 bits
+SCC_SCCS	= 0x17	// 8 bits
+
+#if QUICC_MEMCPY_USES_PLX
+	.macro memcpy_from_pci src, dest, len // len must be < 8 MB
+	addl #3, \len
+	andl #0xFFFFFFFC, \len		// always copy n * 4 bytes
+	movel \src, PLX_DMA_0_PCI
+	movel \dest, PLX_DMA_0_LOCAL
+	movel \len, PLX_DMA_0_LENGTH
+	movel #0x0103, PLX_DMA_CMD_STS	// start channel 0 transfer
+	bsr memcpy_from_pci_run
+	.endm
+	
+	.macro memcpy_to_pci src, dest, len
+	addl #3, \len
+	andl #0xFFFFFFFC, \len		// always copy n * 4 bytes
+	movel \src, PLX_DMA_1_LOCAL
+	movel \dest, PLX_DMA_1_PCI
+	movel \len, PLX_DMA_1_LENGTH
+	movel #0x0301, PLX_DMA_CMD_STS	// start channel 1 transfer
+	bsr memcpy_to_pci_run
+	.endm
+
+#else
+
+	.macro memcpy src, dest, len	// len must be < 65536 bytes
+	movel %d7, -(%sp)		// src and dest must be < 256 MB
+	movel \len, %d7			// bits 0 and 1
+	lsrl #2, \len
+	andl \len, \len
+	beq 99f				// only 0 - 3 bytes
+	subl #1, \len			// for dbf
+98:	movel (\src)+, (\dest)+
+	dbfw \len, 98b
+99:	movel %d7, \len
+	btstl #1, \len
+	beq 99f
+	movew (\src)+, (\dest)+
+99:	btstl #0, \len
+	beq 99f
+	moveb (\src)+, (\dest)+
+99:
+	movel (%sp)+, %d7
+	.endm
+
+	.macro memcpy_from_pci src, dest, len
+	addl #VALUE_WINDOW, \src
+	memcpy \src, \dest, \len
+	.endm
+
+	.macro memcpy_to_pci src, dest, len
+	addl #VALUE_WINDOW, \dest
+	memcpy \src, \dest, \len
+	.endm
+#endif
+
+
+	.macro wait_for_command
+99:	btstl #0, CR
+	bne 99b
+	.endm
+
+
+
+
+/****************************** card initialization *******************/
+	.text
+	.global _start
+_start:	bra init
+
+	.org _start + 4
+ch_status_addr:	.long 0, 0, 0, 0
+rx_descs_addr:	.long 0
+
+init:
+#if DETECT_RAM
+	movel OR1, %d0
+	andl #0xF00007FF, %d0		// mask AMxx bits
+	orl #0xFFFF800 & ~(MAX_RAM_SIZE - 1), %d0 // update RAM bank size
+	movel %d0, OR1
+#endif
+
+	addl #VALUE_WINDOW, rx_descs_addr // PCI addresses of shared data
+	clrl %d0			// D0 = 4 * port
+init_1:	tstl ch_status_addr(%d0)
+	beq init_2
+	addl #VALUE_WINDOW, ch_status_addr(%d0)
+init_2:	addl #4, %d0
+	cmpl #4 * 4, %d0
+	bne init_1
+
+	movel #pci9060_interrupt, PCI9060_VECTOR
+	movel #error_interrupt, ERROR_VECTOR
+	movel #port_interrupt_1, SCC1_VECTOR
+	movel #port_interrupt_2, SCC2_VECTOR
+	movel #port_interrupt_3, SCC3_VECTOR
+	movel #port_interrupt_4, SCC4_VECTOR
+	movel #timer_interrupt, TIMER_IRQ * 4
+
+	movel #0x78000000, CIMR		// only SCCx IRQs from CPM
+	movew #(TIMER_IRQ_LEVEL << 8) + TIMER_IRQ, PICR	// interrupt from PIT
+	movew #PITR_CONST, PITR
+
+	// SCC1=SCCa SCC2=SCCb SCC3=SCCc SCC4=SCCd prio=4 HP=-1 IRQ=64-79
+	movel #0xD41F40 + (CPM_IRQ_LEVEL << 13), CICR
+	movel #0x543, PLX_DMA_0_MODE	// 32-bit, Ready, Burst, IRQ
+	movel #0x543, PLX_DMA_1_MODE
+	movel #0x0, PLX_DMA_0_DESC	// from PCI to local
+	movel #0x8, PLX_DMA_1_DESC	// from local to PCI
+	movel #0x101, PLX_DMA_CMD_STS	// enable both DMA channels
+	// enable local IRQ, DMA, doorbells and PCI IRQ
+	orl #0x000F0300, PLX_INTERRUPT_CS
+
+#if DETECT_RAM
+	bsr ram_test
+#else
+	movel #1, PLX_MAILBOX_5		// non-zero value = init complete
+#endif
+	bsr check_csr
+
+	movew #0xFFFF, PAPAR		// all pins are clocks/data
+	clrw PADIR			// first function
+	clrw PCSO			// CD and CTS always active
+
+
+/****************************** main loop *****************************/
+
+main:	movel channel_stats, %d7	// D7 = doorbell + irq status
+	clrl channel_stats
+
+	tstl %d7
+	bne main_1
+	// nothing to do - wait for next event
+	stop #0x2200			// supervisor + IRQ level 2
+	movew #0x2700, %sr		// disable IRQs again
+	bra main
+
+main_1:	clrl %d0			// D0 = 4 * port
+	clrl %d6			// D6 = doorbell to host value
+
+main_l: btstl #DOORBELL_TO_CARD_CLOSE_0, %d7
+	beq main_op
+	bclrl #DOORBELL_TO_CARD_OPEN_0, %d7 // in case both bits are set
+	bsr close_port
+main_op:
+	btstl #DOORBELL_TO_CARD_OPEN_0, %d7
+	beq main_cl
+	bsr open_port
+main_cl:
+	btstl #DOORBELL_TO_CARD_TX_0, %d7
+	beq main_txend
+	bsr tx
+main_txend:
+	btstl #TASK_SCC_0, %d7
+	beq main_next
+	bsr tx_end
+	bsr rx
+
+main_next:
+	lsrl #1, %d7			// port status for next port
+	addl #4, %d0			// D0 = 4 * next port
+	cmpl #4 * 4, %d0
+	bne main_l
+	movel %d6, PLX_DOORBELL_FROM_CARD // signal the host
+	bra main
+
+
+/****************************** open port *****************************/
+
+open_port:				// D0 = 4 * port, D6 = doorbell to host
+	movel ch_status_addr(%d0), %a0	// A0 = port status address
+	tstl STATUS_OPEN(%a0)
+	bne open_port_ret		// port already open
+	movel #1, STATUS_OPEN(%a0)	// confirm the port is open
+// setup BDs
+	clrl tx_in(%d0)
+	clrl tx_out(%d0)
+	clrl tx_count(%d0)
+	clrl rx_in(%d0)
+
+	movel SICR, %d1			// D1 = clock settings in SICR
+	andl clocking_mask(%d0), %d1
+	cmpl #CLOCK_TXFROMRX, STATUS_CLOCKING(%a0)
+	bne open_port_clock_ext
+	orl clocking_txfromrx(%d0), %d1
+	bra open_port_set_clock
+
+open_port_clock_ext:
+	orl clocking_ext(%d0), %d1
+open_port_set_clock:
+	movel %d1, SICR			// update clock settings in SICR
+
+	orw #STATUS_CABLE_DTR, csr_output(%d0)	// DTR on
+	bsr check_csr			// call with disabled timer interrupt
+
+// Setup TX descriptors
+	movel first_buffer(%d0), %d1	// D1 = starting buffer address
+	movel tx_first_bd(%d0), %a1	// A1 = starting TX BD address
+	movel #TX_BUFFERS - 2, %d2	// D2 = TX_BUFFERS - 1 counter
+	movel #0x18000000, %d3		// D3 = initial TX BD flags: Int + Last
+	cmpl #PARITY_NONE, STATUS_PARITY(%a0)
+	beq open_port_tx_loop
+	bsetl #26, %d3			// TX BD flag: Transmit CRC
+open_port_tx_loop:
+	movel %d3, (%a1)+		// TX flags + length
+	movel %d1, (%a1)+		// buffer address
+	addl #BUFFER_LENGTH, %d1
+	dbfw %d2, open_port_tx_loop
+
+	bsetl #29, %d3			// TX BD flag: Wrap (last BD)
+	movel %d3, (%a1)+		// Final TX flags + length
+	movel %d1, (%a1)+		// buffer address
+
+// Setup RX descriptors			// A1 = starting RX BD address
+	movel #RX_BUFFERS - 2, %d2	// D2 = RX_BUFFERS - 1 counter
+open_port_rx_loop:
+	movel #0x90000000, (%a1)+	// RX flags + length
+	movel %d1, (%a1)+		// buffer address
+	addl #BUFFER_LENGTH, %d1
+	dbfw %d2, open_port_rx_loop
+
+	movel #0xB0000000, (%a1)+	// Final RX flags + length
+	movel %d1, (%a1)+		// buffer address
+
+// Setup port parameters
+	movel scc_base_addr(%d0), %a1	// A1 = SCC_BASE address
+	movel scc_reg_addr(%d0), %a2	// A2 = SCC_REGS address
+
+	movel #0xFFFF, SCC_SCCE(%a2)	// clear status bits
+	movel #0x0000, SCC_SCCM(%a2)	// interrupt mask
+
+	movel tx_first_bd(%d0), %d1
+	movew %d1, SCC_TBASE(%a1)	// D1 = offset of first TxBD
+	addl #TX_BUFFERS * 8, %d1
+	movew %d1, SCC_RBASE(%a1)	// D1 = offset of first RxBD
+	moveb #0x8, SCC_RFCR(%a1)	// Intel mode, 1000
+	moveb #0x8, SCC_TFCR(%a1)
+
+// Parity settings
+	cmpl #PARITY_CRC16_PR1_CCITT, STATUS_PARITY(%a0)
+	bne open_port_parity_1
+	clrw SCC_PSMR(%a2)		// CRC16-CCITT
+	movel #0xF0B8, SCC_C_MASK(%a1)
+	movel #0xFFFF, SCC_C_PRES(%a1)
+	movew #HDLC_MAX_MRU + 2, SCC_MFLR(%a1) // 2 bytes for CRC
+	movew #2, parity_bytes(%d0)
+	bra open_port_2
+
+open_port_parity_1:
+	cmpl #PARITY_CRC32_PR1_CCITT, STATUS_PARITY(%a0)
+	bne open_port_parity_2
+	movew #0x0800, SCC_PSMR(%a2)	// CRC32-CCITT
+	movel #0xDEBB20E3, SCC_C_MASK(%a1)
+	movel #0xFFFFFFFF, SCC_C_PRES(%a1)
+	movew #HDLC_MAX_MRU + 4, SCC_MFLR(%a1) // 4 bytes for CRC
+	movew #4, parity_bytes(%d0)
+	bra open_port_2
+	
+open_port_parity_2:
+	cmpl #PARITY_CRC16_PR0_CCITT, STATUS_PARITY(%a0)
+	bne open_port_parity_3
+	clrw SCC_PSMR(%a2)		// CRC16-CCITT preset 0
+	movel #0xF0B8, SCC_C_MASK(%a1)
+	clrl SCC_C_PRES(%a1)
+	movew #HDLC_MAX_MRU + 2, SCC_MFLR(%a1) // 2 bytes for CRC
+	movew #2, parity_bytes(%d0)
+	bra open_port_2
+
+open_port_parity_3:
+	cmpl #PARITY_CRC32_PR0_CCITT, STATUS_PARITY(%a0)
+	bne open_port_parity_4
+	movew #0x0800, SCC_PSMR(%a2)	// CRC32-CCITT preset 0
+	movel #0xDEBB20E3, SCC_C_MASK(%a1)
+	clrl SCC_C_PRES(%a1)
+	movew #HDLC_MAX_MRU + 4, SCC_MFLR(%a1) // 4 bytes for CRC
+	movew #4, parity_bytes(%d0)
+	bra open_port_2
+	
+open_port_parity_4:
+	clrw SCC_PSMR(%a2)		// no parity
+	movel #0xF0B8, SCC_C_MASK(%a1)
+	movel #0xFFFF, SCC_C_PRES(%a1)
+	movew #HDLC_MAX_MRU, SCC_MFLR(%a1) // 0 bytes for CRC
+	clrw parity_bytes(%d0)
+
+open_port_2:
+	movel #0x00000003, SCC_GSMR_H(%a2) // RTSM
+	cmpl #ENCODING_NRZI, STATUS_ENCODING(%a0)
+	bne open_port_nrz
+	movel #0x10040900, SCC_GSMR_L(%a2) // NRZI: TCI Tend RECN+TENC=1
+	bra open_port_3
+
+open_port_nrz:
+	movel #0x10040000, SCC_GSMR_L(%a2) // NRZ: TCI Tend RECN+TENC=0
+open_port_3:
+	movew #BUFFER_LENGTH, SCC_MRBLR(%a1)
+	movel %d0, %d1
+	lsll #4, %d1			// D1 bits 7 and 6 = port
+	orl #1, %d1
+	movew %d1, CR			// Init SCC RX and TX params
+	wait_for_command
+
+	// TCI Tend ENR ENT
+	movew #0x001F, SCC_SCCM(%a2)	// TXE RXF BSY TXB RXB interrupts
+	orl #0x00000030, SCC_GSMR_L(%a2) // enable SCC
+open_port_ret:
+	rts
+
+
+/****************************** close port ****************************/
+	
+close_port:				// D0 = 4 * port, D6 = doorbell to host
+	movel scc_reg_addr(%d0), %a0	// A0 = SCC_REGS address
+	clrw SCC_SCCM(%a0)		// no SCC interrupts
+	andl #0xFFFFFFCF, SCC_GSMR_L(%a0) // Disable ENT and ENR
+
+	andw #~STATUS_CABLE_DTR, csr_output(%d0) // DTR off
+	bsr check_csr			// call with disabled timer interrupt
+
+	movel ch_status_addr(%d0), %d1
+	clrl STATUS_OPEN(%d1)		// confirm the port is closed
+	rts
+
+
+/****************************** transmit packet ***********************/
+// queue packets for transmission
+tx:					// D0 = 4 * port, D6 = doorbell to host
+	cmpl #TX_BUFFERS, tx_count(%d0)
+	beq tx_ret			// all DB's = descs in use
+
+	movel tx_out(%d0), %d1
+	movel %d1, %d2			// D1 = D2 = tx_out BD# = desc#
+	mulul #DESC_LENGTH, %d2		// D2 = TX desc offset
+	addl ch_status_addr(%d0), %d2
+	addl #STATUS_TX_DESCS, %d2	// D2 = TX desc address
+	cmpl #PACKET_FULL, (%d2)	// desc status
+	bne tx_ret
+
+// queue it
+	movel 4(%d2), %a0		// PCI address
+	lsll #3, %d1			// BD is 8-bytes long
+	addl tx_first_bd(%d0), %d1	// D1 = current tx_out BD addr
+
+	movel 4(%d1), %a1		// A1 = dest address
+	movel 8(%d2), %d2		// D2 = length
+	movew %d2, 2(%d1)		// length into BD
+	memcpy_from_pci %a0, %a1, %d2
+	bsetl #31, (%d1)		// CP go ahead
+
+// update tx_out and tx_count
+	movel tx_out(%d0), %d1
+	addl #1, %d1
+	cmpl #TX_BUFFERS, %d1
+	bne tx_1
+	clrl %d1
+tx_1:	movel %d1, tx_out(%d0)
+
+	addl #1, tx_count(%d0)
+	bra tx
+
+tx_ret: rts
+
+
+/****************************** packet received ***********************/
+
+// Service receive buffers		// D0 = 4 * port, D6 = doorbell to host
+rx:	movel rx_in(%d0), %d1		// D1 = rx_in BD#
+	lsll #3, %d1			// BD is 8-bytes long
+	addl rx_first_bd(%d0), %d1	// D1 = current rx_in BD address
+	movew (%d1), %d2		// D2 = RX BD flags
+	btstl #15, %d2
+	bne rx_ret			// BD still empty
+
+	btstl #1, %d2
+	bne rx_overrun
+
+	tstw parity_bytes(%d0)
+	bne rx_parity
+	bclrl #2, %d2			// do not test for CRC errors
+rx_parity:
+	andw #0x0CBC, %d2		// mask status bits
+	cmpw #0x0C00, %d2		// correct frame
+	bne rx_bad_frame
+	clrl %d3
+	movew 2(%d1), %d3
+	subw parity_bytes(%d0), %d3	// D3 = packet length
+	cmpw #HDLC_MAX_MRU, %d3
+	bgt rx_bad_frame
+
+rx_good_frame:
+	movel rx_out, %d2
+	mulul #DESC_LENGTH, %d2
+	addl rx_descs_addr, %d2		// D2 = RX desc address
+	cmpl #PACKET_EMPTY, (%d2)	// desc stat
+	bne rx_overrun
+
+	movel %d3, 8(%d2)
+	movel 4(%d1), %a0		// A0 = source address
+	movel 4(%d2), %a1
+	tstl %a1
+	beq rx_ignore_data
+	memcpy_to_pci %a0, %a1, %d3
+rx_ignore_data:
+	movel packet_full(%d0), (%d2)	// update desc stat
+
+// update D6 and rx_out
+	bsetl #DOORBELL_FROM_CARD_RX, %d6 // signal host that RX completed
+	movel rx_out, %d2
+	addl #1, %d2
+	cmpl #RX_QUEUE_LENGTH, %d2
+	bne rx_1
+	clrl %d2
+rx_1:	movel %d2, rx_out
+
+rx_free_bd:
+	andw #0xF000, (%d1)		// clear CM and error bits
+	bsetl #31, (%d1)		// free BD
+// update rx_in
+	movel rx_in(%d0), %d1
+	addl #1, %d1
+	cmpl #RX_BUFFERS, %d1
+	bne rx_2
+	clrl %d1
+rx_2:	movel %d1, rx_in(%d0)
+	bra rx
+
+rx_overrun:
+	movel ch_status_addr(%d0), %d2
+	addl #1, STATUS_RX_OVERRUNS(%d2)
+	bra rx_free_bd
+
+rx_bad_frame:
+	movel ch_status_addr(%d0), %d2
+	addl #1, STATUS_RX_FRAME_ERRORS(%d2)
+	bra rx_free_bd
+
+rx_ret: rts
+
+
+/****************************** packet transmitted ********************/
+
+// Service transmit buffers		// D0 = 4 * port, D6 = doorbell to host
+tx_end:	tstl tx_count(%d0)
+	beq tx_end_ret			// TX buffers already empty
+
+	movel tx_in(%d0), %d1
+	movel %d1, %d2			// D1 = D2 = tx_in BD# = desc#
+	lsll #3, %d1			// BD is 8-bytes long
+	addl tx_first_bd(%d0), %d1	// D1 = current tx_in BD address
+	movew (%d1), %d3		// D3 = TX BD flags
+	btstl #15, %d3
+	bne tx_end_ret			// BD still being transmitted
+
+// update D6, tx_in and tx_count
+	orl bell_tx(%d0), %d6		// signal host that TX desc freed
+	subl #1, tx_count(%d0)
+	movel tx_in(%d0), %d1
+	addl #1, %d1
+	cmpl #TX_BUFFERS, %d1
+	bne tx_end_1
+	clrl %d1
+tx_end_1:
+	movel %d1, tx_in(%d0)
+
+// free host's descriptor
+	mulul #DESC_LENGTH, %d2		// D2 = TX desc offset
+	addl ch_status_addr(%d0), %d2
+	addl #STATUS_TX_DESCS, %d2	// D2 = TX desc address
+	btstl #1, %d3
+	bne tx_end_underrun
+	movel #PACKET_SENT, (%d2)
+	bra tx_end
+
+tx_end_underrun:
+	movel #PACKET_UNDERRUN, (%d2)
+	bra tx_end
+
+tx_end_ret: rts
+
+
+/****************************** PLX PCI9060 DMA memcpy ****************/
+
+#if QUICC_MEMCPY_USES_PLX
+// called with interrupts disabled
+memcpy_from_pci_run:
+	movel %d0, -(%sp)
+	movew %sr, -(%sp)
+memcpy_1:
+	movel PLX_DMA_CMD_STS, %d0	// do not btst PLX register directly
+	btstl #4, %d0			// transfer done?
+	bne memcpy_end
+	stop #0x2200			// enable PCI9060 interrupts
+	movew #0x2700, %sr		// disable interrupts again
+	bra memcpy_1
+
+memcpy_to_pci_run:
+	movel %d0, -(%sp)
+	movew %sr, -(%sp)
+memcpy_2:
+	movel PLX_DMA_CMD_STS, %d0	// do not btst PLX register directly
+	btstl #12, %d0			// transfer done?
+	bne memcpy_end
+	stop #0x2200			// enable PCI9060 interrupts
+	movew #0x2700, %sr		// disable interrupts again
+	bra memcpy_2
+
+memcpy_end:
+	movew (%sp)+, %sr
+	movel (%sp)+, %d0
+	rts
+#endif
+
+
+
+
+
+	
+/****************************** PLX PCI9060 interrupt *****************/
+
+pci9060_interrupt:
+	movel %d0, -(%sp)
+
+	movel PLX_DOORBELL_TO_CARD, %d0
+	movel %d0, PLX_DOORBELL_TO_CARD	// confirm all requests
+	orl %d0, channel_stats
+
+	movel #0x0909, PLX_DMA_CMD_STS	// clear DMA ch #0 and #1 interrupts
+
+	movel (%sp)+, %d0
+	rte
+
+/****************************** SCC interrupts ************************/
+
+port_interrupt_1:
+	orl #0, SCC1_REGS + SCC_SCCE; // confirm SCC events
+	orl #1 << TASK_SCC_0, channel_stats
+	movel #0x40000000, CISR
+	rte
+
+port_interrupt_2:
+	orl #0, SCC2_REGS + SCC_SCCE; // confirm SCC events
+	orl #1 << TASK_SCC_1, channel_stats
+	movel #0x20000000, CISR
+	rte
+
+port_interrupt_3:
+	orl #0, SCC3_REGS + SCC_SCCE; // confirm SCC events
+	orl #1 << TASK_SCC_2, channel_stats
+	movel #0x10000000, CISR
+	rte
+
+port_interrupt_4:
+	orl #0, SCC4_REGS + SCC_SCCE; // confirm SCC events
+	orl #1 << TASK_SCC_3, channel_stats
+	movel #0x08000000, CISR
+	rte
+
+error_interrupt:
+	rte
+
+
+/****************************** cable and PM routine ******************/
+// modified registers: none
+check_csr:
+	movel %d0, -(%sp)
+	movel %d1, -(%sp)
+	movel %d2, -(%sp)
+	movel %a0, -(%sp)
+	movel %a1, -(%sp)
+
+	clrl %d0			// D0 = 4 * port
+	movel #CSRA, %a0		// A0 = CSR address
+
+check_csr_loop:
+	movew (%a0), %d1		// D1 = CSR input bits
+	andl #0xE7, %d1			// PM and cable sense bits (no DCE bit)
+	cmpw #STATUS_CABLE_V35 * (1 + 1 << STATUS_CABLE_PM_SHIFT), %d1
+	bne check_csr_1
+	movew #0x0E08, %d1
+	bra check_csr_valid
+
+check_csr_1:
+	cmpw #STATUS_CABLE_X21 * (1 + 1 << STATUS_CABLE_PM_SHIFT), %d1
+	bne check_csr_2
+	movew #0x0408, %d1
+	bra check_csr_valid
+
+check_csr_2:
+	cmpw #STATUS_CABLE_V24 * (1 + 1 << STATUS_CABLE_PM_SHIFT), %d1
+	bne check_csr_3
+	movew #0x0208, %d1
+	bra check_csr_valid
+
+check_csr_3:
+	cmpw #STATUS_CABLE_EIA530 * (1 + 1 << STATUS_CABLE_PM_SHIFT), %d1
+	bne check_csr_disable
+	movew #0x0D08, %d1
+	bra check_csr_valid
+
+check_csr_disable:
+	movew #0x0008, %d1		// D1 = disable everything
+	movew #0x80E7, %d2		// D2 = input mask: ignore DSR
+	bra check_csr_write
+
+check_csr_valid:			// D1 = mode and IRQ bits
+	movew csr_output(%d0), %d2
+	andw #0x3000, %d2		// D2 = requested LL and DTR bits
+	orw %d2, %d1			// D1 = all requested output bits
+	movew #0x80FF, %d2		// D2 = input mask: include DSR
+
+check_csr_write:
+	cmpw old_csr_output(%d0), %d1
+	beq check_csr_input
+	movew %d1, old_csr_output(%d0)
+	movew %d1, (%a0)		// Write CSR output bits
+
+check_csr_input:
+	movew (PCDAT), %d1
+	andw dcd_mask(%d0), %d1
+	beq check_csr_dcd_on		// DCD and CTS signals are negated
+	movew (%a0), %d1		// D1 = CSR input bits
+	andw #~STATUS_CABLE_DCD, %d1	// DCD off
+	bra check_csr_previous
+
+check_csr_dcd_on:
+	movew (%a0), %d1		// D1 = CSR input bits
+	orw #STATUS_CABLE_DCD, %d1	// DCD on
+check_csr_previous:
+	andw %d2, %d1			// input mask
+	movel ch_status_addr(%d0), %a1
+	cmpl STATUS_CABLE(%a1), %d1	// check for change
+	beq check_csr_next
+	movel %d1, STATUS_CABLE(%a1)	// update status
+	movel bell_cable(%d0), PLX_DOORBELL_FROM_CARD	// signal the host
+
+check_csr_next:
+	addl #2, %a0			// next CSR register
+	addl #4, %d0			// D0 = 4 * next port
+	cmpl #4 * 4, %d0
+	bne check_csr_loop
+
+	movel (%sp)+, %a1
+	movel (%sp)+, %a0
+	movel (%sp)+, %d2
+	movel (%sp)+, %d1
+	movel (%sp)+, %d0
+	rts
+
+
+/****************************** timer interrupt ***********************/
+
+timer_interrupt:
+	bsr check_csr
+	rte
+
+
+/****************************** RAM sizing and test *******************/
+#if DETECT_RAM
+ram_test:
+	movel #0x12345678, %d1		// D1 = test value
+	movel %d1, (128 * 1024 - 4)
+	movel #128 * 1024, %d0		// D0 = RAM size tested
+ram_test_size:
+	cmpl #MAX_RAM_SIZE, %d0
+	beq ram_test_size_found
+	movel %d0, %a0
+	addl #128 * 1024 - 4, %a0
+	cmpl (%a0), %d1
+	beq ram_test_size_check
+ram_test_next_size:
+	lsll #1, %d0
+	bra ram_test_size
+
+ram_test_size_check:
+	eorl #0xFFFFFFFF, %d1
+	movel %d1, (128 * 1024 - 4)
+	cmpl (%a0), %d1
+	bne ram_test_next_size
+
+ram_test_size_found:			// D0 = RAM size
+	movel %d0, %a0			// A0 = fill ptr
+	subl #firmware_end + 4, %d0
+	lsrl #2, %d0
+	movel %d0, %d1			// D1 = DBf counter
+ram_test_fill:
+	movel %a0, -(%a0)
+	dbfw %d1, ram_test_fill
+	subl #0x10000, %d1
+	cmpl #0xFFFFFFFF, %d1
+	bne ram_test_fill
+
+ram_test_loop:				// D0 = DBf counter
+	cmpl (%a0)+, %a0
+	dbnew %d0, ram_test_loop
+	bne ram_test_found_bad
+	subl #0x10000, %d0
+	cmpl #0xFFFFFFFF, %d0
+	bne ram_test_loop
+	bra ram_test_all_ok
+
+ram_test_found_bad:
+	subl #4, %a0
+ram_test_all_ok:
+	movel %a0, PLX_MAILBOX_5
+	rts
+#endif
+
+
+/****************************** constants *****************************/
+
+scc_reg_addr:
+	.long SCC1_REGS, SCC2_REGS, SCC3_REGS, SCC4_REGS
+scc_base_addr:
+	.long SCC1_BASE, SCC2_BASE, SCC3_BASE, SCC4_BASE
+
+tx_first_bd:
+	.long DPRBASE
+	.long DPRBASE + (TX_BUFFERS + RX_BUFFERS) * 8
+	.long DPRBASE + (TX_BUFFERS + RX_BUFFERS) * 8 * 2
+	.long DPRBASE + (TX_BUFFERS + RX_BUFFERS) * 8 * 3
+
+rx_first_bd:
+	.long DPRBASE + TX_BUFFERS * 8
+	.long DPRBASE + TX_BUFFERS * 8 + (TX_BUFFERS + RX_BUFFERS) * 8
+	.long DPRBASE + TX_BUFFERS * 8 + (TX_BUFFERS + RX_BUFFERS) * 8 * 2
+	.long DPRBASE + TX_BUFFERS * 8 + (TX_BUFFERS + RX_BUFFERS) * 8 * 3
+
+first_buffer:
+	.long BUFFERS_ADDR
+	.long BUFFERS_ADDR + (TX_BUFFERS + RX_BUFFERS) * BUFFER_LENGTH
+	.long BUFFERS_ADDR + (TX_BUFFERS + RX_BUFFERS) * BUFFER_LENGTH * 2
+	.long BUFFERS_ADDR + (TX_BUFFERS + RX_BUFFERS) * BUFFER_LENGTH * 3
+
+bell_tx:
+	.long 1 << DOORBELL_FROM_CARD_TX_0, 1 << DOORBELL_FROM_CARD_TX_1
+	.long 1 << DOORBELL_FROM_CARD_TX_2, 1 << DOORBELL_FROM_CARD_TX_3
+
+bell_cable:
+	.long 1 << DOORBELL_FROM_CARD_CABLE_0, 1 << DOORBELL_FROM_CARD_CABLE_1
+	.long 1 << DOORBELL_FROM_CARD_CABLE_2, 1 << DOORBELL_FROM_CARD_CABLE_3
+
+packet_full:
+	.long PACKET_FULL, PACKET_FULL + 1, PACKET_FULL + 2, PACKET_FULL + 3
+
+clocking_ext:
+	.long 0x0000002C, 0x00003E00, 0x002C0000, 0x3E000000
+clocking_txfromrx:
+	.long 0x0000002D, 0x00003F00, 0x002D0000, 0x3F000000
+clocking_mask:
+	.long 0x000000FF, 0x0000FF00, 0x00FF0000, 0xFF000000
+dcd_mask:
+	.word 0x020, 0, 0x080, 0, 0x200, 0, 0x800
+
+	.ascii "wanXL firmware\n"
+	.asciz "Copyright (C) 2003 Krzysztof Halasa <khc@pm.waw.pl>\n"
+
+
+/****************************** variables *****************************/
+
+		.align 4
+channel_stats:	.long 0
+
+tx_in:		.long 0, 0, 0, 0	// transmitted
+tx_out:		.long 0, 0, 0, 0	// received from host for transmission
+tx_count:	.long 0, 0, 0, 0	// currently in transmit queue
+
+rx_in:		.long 0, 0, 0, 0	// received from port
+rx_out:		.long 0			// transmitted to host
+parity_bytes:	.word 0, 0, 0, 0, 0, 0, 0 // only 4 words are used
+
+csr_output:	.word 0
+old_csr_output:	.word 0, 0, 0, 0, 0, 0, 0
+		.align 4
+firmware_end:				// must be dword-aligned
--- linux-2.6.orig/drivers/net/wan/wanxlfw.inc	2003-07-29 19:21:04.000000000 +0200
+++ linux-2.6/drivers/net/wan/wanxlfw.inc	2003-07-24 20:15:34.000000000 +0200
@@ -0,0 +1,158 @@
+static u8 firmware[]={
+0x60,0x00,0x00,0x16,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x06,0xB9,0x40,0x00,0x00,0x00,0x00,0x00,
+0x10,0x14,0x42,0x80,0x4A,0xB0,0x09,0xB0,0x00,0x00,0x10,0x04,0x67,0x00,0x00,0x0E,
+0x06,0xB0,0x40,0x00,0x00,0x00,0x09,0xB0,0x00,0x00,0x10,0x04,0x58,0x80,0x0C,0x80,
+0x00,0x00,0x00,0x10,0x66,0x00,0xFF,0xDE,0x21,0xFC,0x00,0x00,0x16,0xBC,0x00,0x6C,
+0x21,0xFC,0x00,0x00,0x17,0x5E,0x01,0x00,0x21,0xFC,0x00,0x00,0x16,0xDE,0x01,0x78,
+0x21,0xFC,0x00,0x00,0x16,0xFE,0x01,0x74,0x21,0xFC,0x00,0x00,0x17,0x1E,0x01,0x70,
+0x21,0xFC,0x00,0x00,0x17,0x3E,0x01,0x6C,0x21,0xFC,0x00,0x00,0x18,0x4C,0x02,0x00,
+0x23,0xFC,0x78,0x00,0x00,0x00,0xFF,0xFC,0x15,0x48,0x33,0xFC,0x04,0x80,0xFF,0xFC,
+0x10,0x26,0x33,0xFC,0x01,0x10,0xFF,0xFC,0x10,0x2A,0x23,0xFC,0x00,0xD4,0x9F,0x40,
+0xFF,0xFC,0x15,0x40,0x23,0xFC,0x00,0x00,0x05,0x43,0xFF,0xF9,0x01,0x00,0x23,0xFC,
+0x00,0x00,0x05,0x43,0xFF,0xF9,0x01,0x14,0x23,0xFC,0x00,0x00,0x00,0x00,0xFF,0xF9,
+0x01,0x10,0x23,0xFC,0x00,0x00,0x00,0x08,0xFF,0xF9,0x01,0x24,0x23,0xFC,0x00,0x00,
+0x01,0x01,0xFF,0xF9,0x01,0x28,0x00,0xB9,0x00,0x0F,0x03,0x00,0xFF,0xF9,0x00,0xE8,
+0x23,0xFC,0x00,0x00,0x00,0x01,0xFF,0xF9,0x00,0xD4,0x61,0x00,0x06,0x74,0x33,0xFC,
+0xFF,0xFF,0xFF,0xFC,0x15,0x52,0x42,0x79,0xFF,0xFC,0x15,0x50,0x42,0x79,0xFF,0xFC,
+0x15,0x64,0x2E,0x3A,0x08,0x50,0x42,0xB9,0x00,0x00,0x19,0x54,0x4A,0x87,0x66,0x00,
+0x00,0x0E,0x4E,0x72,0x22,0x00,0x46,0xFC,0x27,0x00,0x60,0x00,0xFF,0xE6,0x42,0x80,
+0x42,0x86,0x08,0x07,0x00,0x04,0x67,0x00,0x00,0x0A,0x08,0x87,0x00,0x00,0x61,0x00,
+0x02,0xA0,0x08,0x07,0x00,0x00,0x67,0x00,0x00,0x06,0x61,0x00,0x00,0x36,0x08,0x07,
+0x00,0x08,0x67,0x00,0x00,0x06,0x61,0x00,0x02,0xB8,0x08,0x07,0x00,0x0C,0x67,0x00,
+0x00,0x0A,0x61,0x00,0x04,0x94,0x61,0x00,0x03,0x60,0xE2,0x8F,0x58,0x80,0x0C,0x80,
+0x00,0x00,0x00,0x10,0x66,0x00,0xFF,0xBC,0x23,0xC6,0xFF,0xF9,0x00,0xE4,0x60,0x00,
+0xFF,0x92,0x20,0x70,0x09,0xB0,0x00,0x00,0x10,0x04,0x4A,0xA8,0x00,0x00,0x66,0x00,
+0x02,0x4E,0x21,0x7C,0x00,0x00,0x00,0x01,0x00,0x00,0x42,0xB0,0x09,0xB0,0x00,0x00,
+0x19,0x58,0x42,0xB0,0x09,0xB0,0x00,0x00,0x19,0x68,0x42,0xB0,0x09,0xB0,0x00,0x00,
+0x19,0x78,0x42,0xB0,0x09,0xB0,0x00,0x00,0x19,0x88,0x22,0x39,0xFF,0xFC,0x16,0xEC,
+0xC2,0xB0,0x09,0xB0,0x00,0x00,0x18,0xF2,0x0C,0xA8,0x00,0x00,0x00,0x04,0x00,0x18,
+0x66,0x00,0x00,0x0E,0x82,0xB0,0x09,0xB0,0x00,0x00,0x18,0xE2,0x60,0x00,0x00,0x0A,
+0x82,0xB0,0x09,0xB0,0x00,0x00,0x18,0xD2,0x23,0xC1,0xFF,0xFC,0x16,0xEC,0x00,0x70,
+0x10,0x00,0x09,0xB0,0x00,0x00,0x19,0xAA,0x61,0x00,0x05,0x76,0x22,0x30,0x09,0xB0,
+0x00,0x00,0x18,0x92,0x22,0x70,0x09,0xB0,0x00,0x00,0x18,0x72,0x74,0x08,0x26,0x3C,
+0x18,0x00,0x00,0x00,0x0C,0xA8,0x00,0x00,0x00,0x01,0x00,0x10,0x67,0x00,0x00,0x06,
+0x08,0xC3,0x00,0x1A,0x22,0xC3,0x22,0xC1,0x06,0x81,0x00,0x00,0x05,0xFC,0x51,0xCA,
+0xFF,0xF4,0x08,0xC3,0x00,0x1D,0x22,0xC3,0x22,0xC1,0x74,0x1C,0x22,0xFC,0x90,0x00,
+0x00,0x00,0x22,0xC1,0x06,0x81,0x00,0x00,0x05,0xFC,0x51,0xCA,0xFF,0xF0,0x22,0xFC,
+0xB0,0x00,0x00,0x00,0x22,0xC1,0x22,0x70,0x09,0xB0,0x00,0x00,0x18,0x62,0x24,0x70,
+0x09,0xB0,0x00,0x00,0x18,0x52,0x25,0x7C,0x00,0x00,0xFF,0xFF,0x00,0x10,0x25,0x7C,
+0x00,0x00,0x00,0x00,0x00,0x14,0x22,0x30,0x09,0xB0,0x00,0x00,0x18,0x72,0x33,0x41,
+0x00,0x02,0x06,0x81,0x00,0x00,0x00,0x50,0x33,0x41,0x00,0x00,0x13,0x7C,0x00,0x08,
+0x00,0x04,0x13,0x7C,0x00,0x08,0x00,0x05,0x0C,0xA8,0x00,0x00,0x00,0x05,0x00,0x10,
+0x66,0x00,0x00,0x2A,0x42,0x6A,0x00,0x08,0x23,0x7C,0x00,0x00,0xF0,0xB8,0x00,0x34,
+0x23,0x7C,0x00,0x00,0xFF,0xFF,0x00,0x38,0x33,0x7C,0x05,0xFA,0x00,0x46,0x31,0xBC,
+0x00,0x02,0x09,0xB0,0x00,0x00,0x19,0x9C,0x60,0x00,0x00,0xBC,0x0C,0xA8,0x00,0x00,
+0x00,0x07,0x00,0x10,0x66,0x00,0x00,0x2C,0x35,0x7C,0x08,0x00,0x00,0x08,0x23,0x7C,
+0xDE,0xBB,0x20,0xE3,0x00,0x34,0x23,0x7C,0xFF,0xFF,0xFF,0xFF,0x00,0x38,0x33,0x7C,
+0x05,0xFC,0x00,0x46,0x31,0xBC,0x00,0x04,0x09,0xB0,0x00,0x00,0x19,0x9C,0x60,0x00,
+0x00,0x86,0x0C,0xA8,0x00,0x00,0x00,0x04,0x00,0x10,0x66,0x00,0x00,0x26,0x42,0x6A,
+0x00,0x08,0x23,0x7C,0x00,0x00,0xF0,0xB8,0x00,0x34,0x42,0xA9,0x00,0x38,0x33,0x7C,
+0x05,0xFA,0x00,0x46,0x31,0xBC,0x00,0x02,0x09,0xB0,0x00,0x00,0x19,0x9C,0x60,0x00,
+0x00,0x56,0x0C,0xA8,0x00,0x00,0x00,0x06,0x00,0x10,0x66,0x00,0x00,0x28,0x35,0x7C,
+0x08,0x00,0x00,0x08,0x23,0x7C,0xDE,0xBB,0x20,0xE3,0x00,0x34,0x42,0xA9,0x00,0x38,
+0x33,0x7C,0x05,0xFC,0x00,0x46,0x31,0xBC,0x00,0x04,0x09,0xB0,0x00,0x00,0x19,0x9C,
+0x60,0x00,0x00,0x24,0x42,0x6A,0x00,0x08,0x23,0x7C,0x00,0x00,0xF0,0xB8,0x00,0x34,
+0x23,0x7C,0x00,0x00,0xFF,0xFF,0x00,0x38,0x33,0x7C,0x05,0xF8,0x00,0x46,0x42,0x70,
+0x09,0xB0,0x00,0x00,0x19,0x9C,0x25,0x7C,0x00,0x00,0x00,0x03,0x00,0x04,0x0C,0xA8,
+0x00,0x00,0x00,0x02,0x00,0x14,0x66,0x00,0x00,0x0E,0x25,0x7C,0x10,0x04,0x09,0x00,
+0x00,0x00,0x60,0x00,0x00,0x0A,0x25,0x7C,0x10,0x04,0x00,0x00,0x00,0x00,0x33,0x7C,
+0x05,0xFC,0x00,0x06,0x22,0x00,0xE9,0x89,0x00,0x81,0x00,0x00,0x00,0x01,0x33,0xC1,
+0xFF,0xFC,0x15,0xC0,0x08,0x39,0x00,0x00,0xFF,0xFC,0x15,0xC0,0x66,0x00,0xFF,0xF6,
+0x35,0x7C,0x00,0x1F,0x00,0x14,0x00,0xAA,0x00,0x00,0x00,0x30,0x00,0x00,0x4E,0x75,
+0x20,0x70,0x09,0xB0,0x00,0x00,0x18,0x52,0x42,0x68,0x00,0x14,0x02,0xA8,0xFF,0xFF,
+0xFF,0xCF,0x00,0x00,0x02,0x70,0xEF,0xFF,0x09,0xB0,0x00,0x00,0x19,0xAA,0x61,0x00,
+0x03,0x70,0x22,0x30,0x09,0xB0,0x00,0x00,0x10,0x04,0x42,0xB0,0x19,0x90,0x4E,0x75,
+0x0C,0xB0,0x00,0x00,0x00,0x0A,0x09,0xB0,0x00,0x00,0x19,0x78,0x67,0x00,0x00,0xA8,
+0x22,0x30,0x09,0xB0,0x00,0x00,0x19,0x68,0x24,0x01,0x4C,0x3C,0x20,0x00,0x00,0x00,
+0x00,0x0C,0xD4,0xB0,0x09,0xB0,0x00,0x00,0x10,0x04,0x06,0x82,0x00,0x00,0x00,0x1C,
+0x0C,0xB0,0x00,0x00,0x00,0x10,0x29,0x90,0x66,0x00,0x00,0x7C,0x20,0x70,0x29,0xA0,
+0x00,0x04,0xE7,0x89,0xD2,0xB0,0x09,0xB0,0x00,0x00,0x18,0x72,0x22,0x70,0x19,0xA0,
+0x00,0x04,0x24,0x30,0x29,0xA0,0x00,0x08,0x31,0x82,0x19,0xA0,0x00,0x02,0x56,0x82,
+0x02,0x82,0xFF,0xFF,0xFF,0xFC,0x23,0xC8,0xFF,0xF9,0x01,0x04,0x23,0xC9,0xFF,0xF9,
+0x01,0x08,0x23,0xC2,0xFF,0xF9,0x01,0x0C,0x23,0xFC,0x00,0x00,0x01,0x03,0xFF,0xF9,
+0x01,0x28,0x61,0x00,0x01,0xF6,0x08,0xF0,0x00,0x1F,0x19,0x90,0x22,0x30,0x09,0xB0,
+0x00,0x00,0x19,0x68,0x52,0x81,0x0C,0x81,0x00,0x00,0x00,0x0A,0x66,0x00,0x00,0x04,
+0x42,0x81,0x21,0x81,0x09,0xB0,0x00,0x00,0x19,0x68,0x52,0xB0,0x09,0xB0,0x00,0x00,
+0x19,0x78,0x60,0x00,0xFF,0x4C,0x4E,0x75,0x22,0x30,0x09,0xB0,0x00,0x00,0x19,0x88,
+0xE7,0x89,0xD2,0xB0,0x09,0xB0,0x00,0x00,0x18,0x82,0x34,0x30,0x19,0x90,0x08,0x02,
+0x00,0x0F,0x66,0x00,0x01,0x12,0x08,0x02,0x00,0x01,0x66,0x00,0x00,0xE6,0x4A,0x70,
+0x09,0xB0,0x00,0x00,0x19,0x9C,0x66,0x00,0x00,0x06,0x08,0x82,0x00,0x02,0x02,0x42,
+0x0C,0xBC,0x0C,0x42,0x0C,0x00,0x66,0x00,0x00,0xDC,0x42,0x83,0x36,0x30,0x19,0xA0,
+0x00,0x02,0x96,0x70,0x09,0xB0,0x00,0x00,0x19,0x9C,0x0C,0x43,0x05,0xF8,0x6E,0x00,
+0x00,0xC4,0x24,0x3A,0x04,0x84,0x4C,0x3C,0x20,0x00,0x00,0x00,0x00,0x0C,0xD4,0xBA,
+0xFA,0xF4,0x0C,0xB0,0x00,0x00,0x00,0x00,0x29,0x90,0x66,0x00,0x00,0x96,0x21,0x83,
+0x29,0xA0,0x00,0x08,0x20,0x70,0x19,0xA0,0x00,0x04,0x22,0x70,0x29,0xA0,0x00,0x04,
+0x4A,0x89,0x67,0x00,0x00,0x2A,0x56,0x83,0x02,0x83,0xFF,0xFF,0xFF,0xFC,0x23,0xC8,
+0xFF,0xF9,0x01,0x1C,0x23,0xC9,0xFF,0xF9,0x01,0x18,0x23,0xC3,0xFF,0xF9,0x01,0x20,
+0x23,0xFC,0x00,0x00,0x03,0x01,0xFF,0xF9,0x01,0x28,0x61,0x00,0x01,0x2C,0x21,0xB0,
+0x09,0xB0,0x00,0x00,0x18,0xC2,0x29,0x90,0x08,0xC6,0x00,0x04,0x24,0x3A,0x04,0x1A,
+0x52,0x82,0x0C,0x82,0x00,0x00,0x00,0x28,0x66,0x00,0x00,0x04,0x42,0x82,0x23,0xC2,
+0x00,0x00,0x19,0x98,0x02,0x70,0xF0,0x00,0x19,0x90,0x08,0xF0,0x00,0x1F,0x19,0x90,
+0x22,0x30,0x09,0xB0,0x00,0x00,0x19,0x88,0x52,0x81,0x0C,0x81,0x00,0x00,0x00,0x1E,
+0x66,0x00,0x00,0x04,0x42,0x81,0x21,0x81,0x09,0xB0,0x00,0x00,0x19,0x88,0x60,0x00,
+0xFE,0xF8,0x24,0x30,0x09,0xB0,0x00,0x00,0x10,0x04,0x52,0xB0,0x29,0xA0,0x00,0x08,
+0x60,0x00,0xFF,0xC2,0x24,0x30,0x09,0xB0,0x00,0x00,0x10,0x04,0x52,0xB0,0x29,0xA0,
+0x00,0x0C,0x60,0x00,0xFF,0xB0,0x4E,0x75,0x4A,0xB0,0x09,0xB0,0x00,0x00,0x19,0x78,
+0x67,0x00,0x00,0x86,0x22,0x30,0x09,0xB0,0x00,0x00,0x19,0x58,0x24,0x01,0xE7,0x89,
+0xD2,0xB0,0x09,0xB0,0x00,0x00,0x18,0x72,0x36,0x30,0x19,0x90,0x08,0x03,0x00,0x0F,
+0x66,0x00,0x00,0x66,0x8C,0xB0,0x09,0xB0,0x00,0x00,0x18,0xA2,0x53,0xB0,0x09,0xB0,
+0x00,0x00,0x19,0x78,0x22,0x30,0x09,0xB0,0x00,0x00,0x19,0x58,0x52,0x81,0x0C,0x81,
+0x00,0x00,0x00,0x0A,0x66,0x00,0x00,0x04,0x42,0x81,0x21,0x81,0x09,0xB0,0x00,0x00,
+0x19,0x58,0x4C,0x3C,0x20,0x00,0x00,0x00,0x00,0x0C,0xD4,0xB0,0x09,0xB0,0x00,0x00,
+0x10,0x04,0x06,0x82,0x00,0x00,0x00,0x1C,0x08,0x03,0x00,0x01,0x66,0x00,0x00,0x0E,
+0x21,0xBC,0x00,0x00,0x00,0x20,0x29,0x90,0x60,0x00,0xFF,0x7E,0x21,0xBC,0x00,0x00,
+0x00,0x30,0x29,0x90,0x60,0x00,0xFF,0x72,0x4E,0x75,0x2F,0x00,0x40,0xE7,0x20,0x39,
+0xFF,0xF9,0x01,0x28,0x08,0x00,0x00,0x04,0x66,0x00,0x00,0x2C,0x4E,0x72,0x22,0x00,
+0x46,0xFC,0x27,0x00,0x60,0x00,0xFF,0xE8,0x2F,0x00,0x40,0xE7,0x20,0x39,0xFF,0xF9,
+0x01,0x28,0x08,0x00,0x00,0x0C,0x66,0x00,0x00,0x0E,0x4E,0x72,0x22,0x00,0x46,0xFC,
+0x27,0x00,0x60,0x00,0xFF,0xE8,0x46,0xDF,0x20,0x1F,0x4E,0x75,0x2F,0x00,0x20,0x39,
+0xFF,0xF9,0x00,0xE0,0x23,0xC0,0xFF,0xF9,0x00,0xE0,0x81,0xB9,0x00,0x00,0x19,0x54,
+0x23,0xFC,0x00,0x00,0x09,0x09,0xFF,0xF9,0x01,0x28,0x20,0x1F,0x4E,0x73,0x00,0xB9,
+0x00,0x00,0x00,0x00,0xFF,0xFC,0x16,0x10,0x00,0xB9,0x00,0x00,0x10,0x00,0x00,0x00,
+0x19,0x54,0x23,0xFC,0x40,0x00,0x00,0x00,0xFF,0xFC,0x15,0x4C,0x4E,0x73,0x00,0xB9,
+0x00,0x00,0x00,0x00,0xFF,0xFC,0x16,0x30,0x00,0xB9,0x00,0x00,0x20,0x00,0x00,0x00,
+0x19,0x54,0x23,0xFC,0x20,0x00,0x00,0x00,0xFF,0xFC,0x15,0x4C,0x4E,0x73,0x00,0xB9,
+0x00,0x00,0x00,0x00,0xFF,0xFC,0x16,0x50,0x00,0xB9,0x00,0x00,0x40,0x00,0x00,0x00,
+0x19,0x54,0x23,0xFC,0x10,0x00,0x00,0x00,0xFF,0xFC,0x15,0x4C,0x4E,0x73,0x00,0xB9,
+0x00,0x00,0x00,0x00,0xFF,0xFC,0x16,0x70,0x00,0xB9,0x00,0x00,0x80,0x00,0x00,0x00,
+0x19,0x54,0x23,0xFC,0x08,0x00,0x00,0x00,0xFF,0xFC,0x15,0x4C,0x4E,0x73,0x4E,0x73,
+0x2F,0x00,0x2F,0x01,0x2F,0x02,0x2F,0x08,0x2F,0x09,0x42,0x80,0x20,0x7C,0xFF,0xFB,
+0x00,0x00,0x32,0x10,0x02,0x81,0x00,0x00,0x00,0xE7,0x0C,0x41,0x00,0x42,0x66,0x00,
+0x00,0x0A,0x32,0x3C,0x0E,0x08,0x60,0x00,0x00,0x3E,0x0C,0x41,0x00,0x63,0x66,0x00,
+0x00,0x0A,0x32,0x3C,0x04,0x08,0x60,0x00,0x00,0x2E,0x0C,0x41,0x00,0x84,0x66,0x00,
+0x00,0x0A,0x32,0x3C,0x02,0x08,0x60,0x00,0x00,0x1E,0x0C,0x41,0x00,0xA5,0x66,0x00,
+0x00,0x0A,0x32,0x3C,0x0D,0x08,0x60,0x00,0x00,0x0E,0x32,0x3C,0x00,0x08,0x34,0x3C,
+0x80,0xE7,0x60,0x00,0x00,0x14,0x34,0x30,0x09,0xB0,0x00,0x00,0x19,0xAA,0x02,0x42,
+0x30,0x00,0x82,0x42,0x34,0x3C,0x80,0xFF,0xB2,0x70,0x09,0xB0,0x00,0x00,0x19,0xAC,
+0x67,0x00,0x00,0x0C,0x31,0x81,0x09,0xB0,0x00,0x00,0x19,0xAC,0x30,0x81,0x32,0x39,
+0xFF,0xFC,0x15,0x66,0xC2,0x70,0x09,0xB0,0x00,0x00,0x19,0x02,0x67,0x00,0x00,0x0C,
+0x32,0x10,0x02,0x41,0xFF,0xF7,0x60,0x00,0x00,0x08,0x32,0x10,0x00,0x41,0x00,0x08,
+0xC2,0x42,0x22,0x70,0x09,0xB0,0x00,0x00,0x10,0x04,0xB2,0xA9,0x00,0x04,0x67,0x00,
+0x00,0x12,0x23,0x41,0x00,0x04,0x23,0xF0,0x09,0xB0,0x00,0x00,0x18,0xB2,0xFF,0xF9,
+0x00,0xE4,0x54,0x88,0x58,0x80,0x0C,0x80,0x00,0x00,0x00,0x10,0x66,0x00,0xFF,0x34,
+0x22,0x5F,0x20,0x5F,0x24,0x1F,0x22,0x1F,0x20,0x1F,0x4E,0x75,0x61,0x00,0xFF,0x12,
+0x4E,0x73,0xFF,0xFC,0x16,0x00,0xFF,0xFC,0x16,0x20,0xFF,0xFC,0x16,0x40,0xFF,0xFC,
+0x16,0x60,0xFF,0xFC,0x0C,0x00,0xFF,0xFC,0x0D,0x00,0xFF,0xFC,0x0E,0x00,0xFF,0xFC,
+0x0F,0x00,0xFF,0xFC,0x00,0x00,0xFF,0xFC,0x01,0x40,0xFF,0xFC,0x02,0x80,0xFF,0xFC,
+0x03,0xC0,0xFF,0xFC,0x00,0x50,0xFF,0xFC,0x01,0x90,0xFF,0xFC,0x02,0xD0,0xFF,0xFC,
+0x04,0x10,0x00,0x00,0x40,0x00,0x00,0x01,0x2F,0x60,0x00,0x02,0x1E,0xC0,0x00,0x03,
+0x0E,0x20,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x02,0x00,0x00,0x00,0x04,0x00,0x00,
+0x00,0x08,0x00,0x00,0x00,0x20,0x00,0x00,0x00,0x40,0x00,0x00,0x00,0x80,0x00,0x00,
+0x01,0x00,0x00,0x00,0x00,0x10,0x00,0x00,0x00,0x11,0x00,0x00,0x00,0x12,0x00,0x00,
+0x00,0x13,0x00,0x00,0x00,0x2C,0x00,0x00,0x3E,0x00,0x00,0x2C,0x00,0x00,0x3E,0x00,
+0x00,0x00,0x00,0x00,0x00,0x2D,0x00,0x00,0x3F,0x00,0x00,0x2D,0x00,0x00,0x3F,0x00,
+0x00,0x00,0x00,0x00,0x00,0xFF,0x00,0x00,0xFF,0x00,0x00,0xFF,0x00,0x00,0xFF,0x00,
+0x00,0x00,0x00,0x20,0x00,0x00,0x00,0x80,0x00,0x00,0x02,0x00,0x00,0x00,0x08,0x00,
+0x77,0x61,0x6E,0x58,0x4C,0x20,0x66,0x69,0x72,0x6D,0x77,0x61,0x72,0x65,0x0A,0x43,
+0x6F,0x70,0x79,0x72,0x69,0x67,0x68,0x74,0x20,0x28,0x43,0x29,0x20,0x32,0x30,0x30,
+0x33,0x20,0x4B,0x72,0x7A,0x79,0x73,0x7A,0x74,0x6F,0x66,0x20,0x48,0x61,0x6C,0x61,
+0x73,0x61,0x20,0x3C,0x6B,0x68,0x63,0x40,0x70,0x6D,0x2E,0x77,0x61,0x77,0x2E,0x70,
+0x6C,0x3E,0x0A,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
+};
--- linux-2.6.orig/drivers/net/wan/Kconfig	2003-07-29 19:18:51.000000000 +0200
+++ linux-2.6/drivers/net/wan/Kconfig	2003-07-23 14:30:23.000000000 +0200
@@ -320,6 +319,30 @@
 comment "X.25/LAPB support is disabled"
 	depends on WAN && HDLC && (LAPB!=m || HDLC!=m) && LAPB!=y
 
+config WANXL
+	tristate "SBE Inc. wanXL support"
+	depends on HDLC && PCI
+	help
+	  This driver is for wanXL PCI cards made by SBE Inc.  If you have
+	  such a card, say Y here and see <http://hq.pm.waw.pl/pub/hdlc/>.
+
+	  If you want to compile the driver as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want),
+	  say M here and read <file:Documentation/modules.txt>.  The module
+	  will be called wanxl.
+
+	  If unsure, say N here.
+
+config WANXL_BUILD_FIRMWARE
+	bool "rebuild wanXL firmware"
+	depends on WANXL
+	help
+	  This option allows you to rebuild firmware run by the QUICC
+	  processor. It requires as68k, ld68k and hexdump programs.
+	  You should never need this option.
+
+	  If unsure, say N here.
+
 config PC300
 	tristate "Cyclades-PC300 support (RS-232/V.35, X.21, T1/E1 boards)"
 	depends on HDLC && PCI

--=-=-=--
