Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317354AbSHJWvl>; Sat, 10 Aug 2002 18:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317366AbSHJWvl>; Sat, 10 Aug 2002 18:51:41 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:3201 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S317354AbSHJWv3>;
	Sat, 10 Aug 2002 18:51:29 -0400
To: <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: [PATCH] 2.5.30 Generic HDLC update including critical fixes
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 11 Aug 2002 00:23:55 +0200
Message-ID: <m3lm7e8i9w.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

The attached patch updates 2.5.30 generic HDLC. It doesn't touch
the network core, yet. Please apply.
-- 
Krzysztof Halasa
Network Administrator

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=hdlc-2.5.30.patch

--- linux-2.5.orig/include/linux/hdlc.h	Tue Jul 23 20:23:39 2002
+++ linux-2.5/include/linux/hdlc.h	Sat Aug 10 19:16:07 2002
@@ -12,14 +12,16 @@
 #ifndef __HDLC_H
 #define __HDLC_H
 
-#define CLOCK_DEFAULT   0	/* Default (current) setting */
+#define GENERIC_HDLC_VERSION 3	/* For synchronization with sethdlc utility */
+
+#define CLOCK_DEFAULT   0	/* Default setting */
 #define CLOCK_EXT	1	/* External TX and RX clock - DTE */
 #define CLOCK_INT	2	/* Internal TX and RX clock - DCE */
 #define CLOCK_TXINT	3	/* Internal TX and external RX clock */
 #define CLOCK_TXFROMRX	4	/* TX clock derived from external RX clock */
 
 
-#define ENCODING_DEFAULT	0 /* Default (current) setting */
+#define ENCODING_DEFAULT	0 /* Default setting */
 #define ENCODING_NRZ		1
 #define ENCODING_NRZI		2
 #define ENCODING_FM_MARK	3
@@ -27,7 +29,7 @@
 #define ENCODING_MANCHESTER	5
 
 
-#define PARITY_DEFAULT		0 /* Default (current) setting */
+#define PARITY_DEFAULT		0 /* Default setting */
 #define PARITY_NONE		1 /* No parity */
 #define PARITY_CRC16_PR0	2 /* CRC16, initial value 0x0000 */
 #define PARITY_CRC16_PR1	3 /* CRC16, initial value 0xFFFF */
@@ -36,13 +38,11 @@
 #define PARITY_CRC32_PR0_CCITT	6 /* CRC32, initial value 0x00000000 */
 #define PARITY_CRC32_PR1_CCITT	7 /* CRC32, initial value 0xFFFFFFFF */
 
-#define LMI_DEFAULT		0 /* Default (current) setting */
+#define LMI_DEFAULT		0 /* Default setting */
 #define LMI_NONE		1 /* No LMI, all PVCs are static */
 #define LMI_ANSI		2 /* ANSI Annex D */
 #define LMI_CCITT		3 /* ITU-T Annex A */
 
-/* PPP doesn't need any info now - supply length = 0 to ioctl */
-
 
 #ifdef __KERNEL__
 
@@ -178,7 +178,7 @@
 	int (*ioctl)(struct net_device *dev, struct ifreq *ifr, int cmd);
 	int (*open)(struct hdlc_device_struct *hdlc);
 	void (*stop)(struct hdlc_device_struct *hdlc);
-	void (*detach)(struct hdlc_device_struct *hdlc);
+	void (*proto_detach)(struct hdlc_device_struct *hdlc);
 	void (*netif_rx)(struct sk_buff *skb);
 	int proto;		/* IF_PROTO_HDLC/CISCO/FR/etc. */
 
@@ -337,11 +337,11 @@
 
 
 /* May be used by hardware driver to gain control over HDLC device */
-static __inline__ void hdlc_detach(hdlc_device *hdlc)
+static __inline__ void hdlc_proto_detach(hdlc_device *hdlc)
 {
-	if (hdlc->detach)
-		hdlc->detach(hdlc);
-	hdlc->detach = NULL;
+	if (hdlc->proto_detach)
+		hdlc->proto_detach(hdlc);
+	hdlc->proto_detach = NULL;
 }
 
 
--- linux-2.5.orig/drivers/net/wan/hdlc_cisco.c	Tue Jul 23 20:23:34 2002
+++ linux-2.5/drivers/net/wan/hdlc_cisco.c	Sat Aug 10 19:26:38 2002
@@ -249,6 +249,7 @@
 {
 	cisco_proto *cisco_s = &ifr->ifr_settings->ifs_hdlc.cisco;
 	const size_t size = sizeof(cisco_proto);
+	cisco_proto new_settings;
 	struct net_device *dev = hdlc_to_dev(hdlc);
 	int result;
 
@@ -266,17 +267,20 @@
 		if(dev->flags & IFF_UP)
 			return -EBUSY;
 
-		if (copy_from_user(&hdlc->state.cisco.settings, cisco_s, size))
+		if (copy_from_user(&new_settings, cisco_s, size))
 			return -EFAULT;
 
-		/* FIXME - put sanity checks here */
-		hdlc_detach(hdlc);
+		if (new_settings.interval < 1 ||
+		    new_settings.timeout < 2)
+			return -EINVAL;
 
 		result=hdlc->attach(hdlc, ENCODING_NRZ,PARITY_CRC16_PR1_CCITT);
-		if (result) {
-			hdlc->proto = -1;
+
+		if (result)
 			return result;
-		}
+
+		hdlc_proto_detach(hdlc);
+		memcpy(&hdlc->state.cisco.settings, &new_settings, size);
 
 		hdlc->open = cisco_open;
 		hdlc->stop = cisco_close;
--- linux-2.5.orig/drivers/net/wan/hdlc_fr.c	Tue Jul 23 20:23:34 2002
+++ linux-2.5/drivers/net/wan/hdlc_fr.c	Sat Aug 10 19:26:38 2002
@@ -602,13 +602,15 @@
 	}
 
 	if (data[3] == FR_PAD && data[4] == NLPID_SNAP && data[5] == FR_PAD) {
-		u16 oui = ntohl(*(u16*)(data + 6));
-		u16 pid = ntohl(*(u16*)(data + 8));
+		u16 oui = ntohs(*(u16*)(data + 6));
+		u16 pid = ntohs(*(u16*)(data + 8));
 		skb_pull(skb, 10);
 
 		switch ((((u32)oui) << 16) | pid) {
 		case ETH_P_ARP: /* routed frame with SNAP */
 		case ETH_P_IPX:
+		case ETH_P_IP:	/* a long variant */
+		case ETH_P_IPV6:
 			skb->protocol = htons(pid);
 			break;
 
@@ -762,7 +764,7 @@
 	pvc_device *pvc = hdlc->state.fr.first_pvc;
 	while(pvc) {
 		pvc_device *next = pvc->next;
-		unregister_netdevice(&pvc->netdev);
+		unregister_netdev(&pvc->netdev);
 		kfree(pvc);
 		pvc = next;
 	}
@@ -778,6 +780,7 @@
 {
 	fr_proto *fr_s = &ifr->ifr_settings->ifs_hdlc.fr;
 	const size_t size = sizeof(fr_proto);
+	fr_proto new_settings;
 	struct net_device *dev = hdlc_to_dev(hdlc);
 	fr_proto_pvc pvc;
 	int result;
@@ -796,26 +799,40 @@
 		if(dev->flags & IFF_UP)
 			return -EBUSY;
 
-		if (copy_from_user(&hdlc->state.fr.settings, fr_s, size))
+		if (copy_from_user(&new_settings, fr_s, size))
 			return -EFAULT;
 
-		/* FIXME - put sanity checks here */
-		if (hdlc->proto != IF_PROTO_FR) {
-			hdlc_detach(hdlc);
-			hdlc->state.fr.first_pvc = NULL;
-			hdlc->state.fr.pvc_count = 0;
-		}
+		if (new_settings.lmi == LMI_DEFAULT)
+			new_settings.lmi = LMI_ANSI;
+
+		if ((new_settings.lmi != LMI_NONE &&
+		     new_settings.lmi != LMI_ANSI &&
+		     new_settings.lmi != LMI_CCITT) ||
+		    new_settings.t391 < 1 ||
+		    new_settings.t392 < 2 ||
+		    new_settings.n391 < 1 ||
+		    new_settings.n392 < 1 ||
+		    new_settings.n393 < new_settings.n392 ||
+		    new_settings.n393 > 32 ||
+		    (new_settings.dce != 0 &&
+		     new_settings.dce != 1))
+			return -EINVAL;
 
 		result=hdlc->attach(hdlc, ENCODING_NRZ,PARITY_CRC16_PR1_CCITT);
-		if (result) {
-			hdlc->proto = -1;
+		if (result)
 			return result;
+
+		if (hdlc->proto != IF_PROTO_FR) {
+			hdlc_proto_detach(hdlc);
+			hdlc->state.fr.first_pvc = NULL;
+			hdlc->state.fr.pvc_count = 0;
 		}
+		memcpy(&hdlc->state.fr.settings, &new_settings, size);
 
 		hdlc->open = fr_open;
 		hdlc->stop = fr_close;
 		hdlc->netif_rx = fr_rx;
-		hdlc->detach = fr_destroy;
+		hdlc->proto_detach = fr_destroy;
 		hdlc->proto = IF_PROTO_FR;
 		dev->hard_start_xmit = hdlc->xmit;
 		dev->hard_header = fr_hard_header;
--- linux-2.5.orig/drivers/net/wan/hdlc_generic.c	Tue Jul 23 20:23:34 2002
+++ linux-2.5/drivers/net/wan/hdlc_generic.c	Sat Aug 10 19:26:38 2002
@@ -38,7 +38,7 @@
 #include <linux/hdlc.h>
 
 
-static const char* version = "HDLC support module revision 1.08";
+static const char* version = "HDLC support module revision 1.10";
 
 
 static int hdlc_change_mtu(struct net_device *dev, int new_mtu)
@@ -66,6 +66,26 @@
 }
 
 
+#ifndef CONFIG_HDLC_RAW
+#define hdlc_raw_ioctl(hdlc, ifr)	-ENOSYS
+#endif
+
+#ifndef CONFIG_HDLC_PPP
+#define hdlc_ppp_ioctl(hdlc, ifr)	-ENOSYS
+#endif
+
+#ifndef CONFIG_HDLC_CISCO
+#define hdlc_cisco_ioctl(hdlc, ifr)	-ENOSYS
+#endif
+
+#ifndef CONFIG_HDLC_FR
+#define hdlc_fr_ioctl(hdlc, ifr)	-ENOSYS
+#endif
+
+#ifndef CONFIG_HDLC_X25
+#define hdlc_x25_ioctl(hdlc, ifr)	-ENOSYS
+#endif
+
 
 int hdlc_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
@@ -89,22 +109,12 @@
 	}
 
 	switch(proto) {
-#ifdef CONFIG_HDLC_RAW
 	case IF_PROTO_HDLC:	return hdlc_raw_ioctl(hdlc, ifr);
-#endif
-#ifdef CONFIG_HDLC_PPP
 	case IF_PROTO_PPP:	return hdlc_ppp_ioctl(hdlc, ifr);
-#endif
-#ifdef CONFIG_HDLC_CISCO
 	case IF_PROTO_CISCO:	return hdlc_cisco_ioctl(hdlc, ifr);
-#endif
-#ifdef CONFIG_HDLC_FR
 	case IF_PROTO_FR:	return hdlc_fr_ioctl(hdlc, ifr);
-#endif
-#ifdef CONFIG_HDLC_X25
 	case IF_PROTO_X25:	return hdlc_x25_ioctl(hdlc, ifr);
-#endif
-	default:		return -ENOSYS;
+	default:		return -EINVAL;
 	}
 }
 
@@ -125,7 +135,7 @@
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
 
 	hdlc->proto = -1;
-	hdlc->detach = NULL;
+	hdlc->proto_detach = NULL;
 
 	result = dev_alloc_name(dev, "hdlc%d");
 	if (result<0)
@@ -143,7 +153,7 @@
 
 void unregister_hdlc_device(hdlc_device *hdlc)
 {
-	hdlc_detach(hdlc);
+	hdlc_proto_detach(hdlc);
 
 	unregister_netdev(hdlc_to_dev(hdlc));
 	MOD_DEC_USE_COUNT;
--- linux-2.5.orig/drivers/net/wan/hdlc_ppp.c	Tue Jul 23 20:23:34 2002
+++ linux-2.5/drivers/net/wan/hdlc_ppp.c	Sat Aug 10 19:26:38 2002
@@ -96,13 +96,11 @@
 
 		/* no settable parameters */
 
-		hdlc_detach(hdlc);
-
 		result=hdlc->attach(hdlc, ENCODING_NRZ,PARITY_CRC16_PR1_CCITT);
-		if (result) {
-			hdlc->proto = -1;
+		if (result)
 			return result;
-		}
+
+		hdlc_proto_detach(hdlc);
 
 		hdlc->open = ppp_open;
 		hdlc->stop = ppp_close;
--- linux-2.5.orig/drivers/net/wan/hdlc_x25.c	Tue Jul 23 20:23:34 2002
+++ linux-2.5/drivers/net/wan/hdlc_x25.c	Sat Aug 10 19:26:38 2002
@@ -196,13 +196,11 @@
 		if(dev->flags & IFF_UP)
 			return -EBUSY;
 
-		hdlc_detach(hdlc);
-
 		result=hdlc->attach(hdlc, ENCODING_NRZ,PARITY_CRC16_PR1_CCITT);
-		if (result) {
-			hdlc->proto = -1;
+		if (result)
 			return result;
-		}
+
+		hdlc_proto_detach(hdlc);
 
 		hdlc->open = x25_open;
 		hdlc->stop = x25_close;
--- linux-2.5.orig/drivers/net/wan/hdlc_raw.c	Tue Jul 23 20:23:34 2002
+++ linux-2.5/drivers/net/wan/hdlc_raw.c	Sat Aug 10 19:26:38 2002
@@ -39,35 +39,40 @@
 {
 	raw_hdlc_proto *raw_s = &ifr->ifr_settings->ifs_hdlc.raw_hdlc;
 	const size_t size = sizeof(raw_hdlc_proto);
+	raw_hdlc_proto new_settings;
 	struct net_device *dev = hdlc_to_dev(hdlc);
 	int result;
 
 	switch (ifr->ifr_settings->type) {
 	case IF_GET_PROTO:
+		ifr->ifr_settings->type = IF_PROTO_HDLC;
 		if (copy_to_user(raw_s, &hdlc->state.raw_hdlc.settings, size))
 			return -EFAULT;
 		return 0;
 
 	case IF_PROTO_HDLC:
-		if(!capable(CAP_NET_ADMIN))
+		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
 
-		if(dev->flags & IFF_UP)
+		if (dev->flags & IFF_UP)
 			return -EBUSY;
 
-		if (copy_from_user(&hdlc->state.raw_hdlc.settings, raw_s, size))
+		if (copy_from_user(&new_settings, raw_s, size))
 			return -EFAULT;
 
+		if (new_settings.encoding == ENCODING_DEFAULT)
+			new_settings.encoding = ENCODING_NRZ;
 
-		/* FIXME - put sanity checks here */
-		hdlc_detach(hdlc);
+		if (new_settings.parity == PARITY_DEFAULT)
+			new_settings.parity = PARITY_NONE;
 
-		result=hdlc->attach(hdlc, hdlc->state.raw_hdlc.settings.encoding,
-				    hdlc->state.raw_hdlc.settings.parity);
-		if (result) {
-			hdlc->proto = -1;
+		result = hdlc->attach(hdlc, new_settings.encoding,
+				      new_settings.parity);
+		if (result)
 			return result;
-		}
+
+		hdlc_proto_detach(hdlc);
+		memcpy(&hdlc->state.raw_hdlc.settings, &new_settings, size);
 
 		hdlc->open = NULL;
 		hdlc->stop = NULL;
--- linux-2.5.orig/drivers/net/wan/hd6457x.c	Tue Jul 23 20:25:54 2002
+++ linux-2.5/drivers/net/wan/hd6457x.c	Sat Aug 10 20:21:46 2002
@@ -291,9 +291,9 @@
 #endif
 	port->hdlc.stats.rx_packets++;
 	port->hdlc.stats.rx_bytes += skb->len;
-	skb->dev->last_rx = jiffies;
 	skb->mac.raw = skb->data;
 	skb->dev = hdlc_to_dev(&port->hdlc);
+	skb->dev->last_rx = jiffies;
 	skb->protocol = htons(ETH_P_HDLC);
 	netif_rx(skb);
 }
--- linux-2.5.orig/drivers/net/wan/n2.c	Tue Jul 23 20:25:54 2002
+++ linux-2.5/drivers/net/wan/n2.c	Sat Aug 10 19:26:38 2002
@@ -1,7 +1,7 @@
 /*
  * SDL Inc. RISCom/N2 synchronous serial card driver for Linux
  *
- * Copyright (C) 1998-2001 Krzysztof Halasa <khc@pm.waw.pl>
+ * Copyright (C) 1998-2002 Krzysztof Halasa <khc@pm.waw.pl>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by
@@ -35,7 +35,7 @@
 #include "hd64570.h"
 
 
-static const char* version = "SDL RISCom/N2 driver version: 1.09";
+static const char* version = "SDL RISCom/N2 driver version: 1.10";
 static const char* devname = "RISCom/N2";
 
 #define USE_WINDOWSIZE 16384
@@ -159,7 +159,7 @@
 
 
 
-static int n2_set_iface(port_t *port)
+static void n2_set_iface(port_t *port)
 {
 	card_t *card = port->card;
 	int io = card->io;
@@ -169,12 +169,6 @@
 	u8 txs = port->txs & CLK_BRG_MASK;
 
 	switch(port->settings.clock_type) {
-	case CLOCK_EXT:
-		mcr &= port->phy_node ? ~CLOCK_OUT_PORT1 : ~CLOCK_OUT_PORT0;
-		rxs |= CLK_LINE_RX; /* RXC input */
-		txs |= CLK_LINE_TX; /* TXC input */
-		break;
-
 	case CLOCK_INT:
 		mcr |= port->phy_node ? CLOCK_OUT_PORT1 : CLOCK_OUT_PORT0;
 		rxs |= CLK_BRG_RX; /* BRG output */
@@ -193,8 +187,10 @@
 		txs |= CLK_RXCLK_TX; /* RX clock */
 		break;
 
-	default:
-		return -EINVAL;
+	default:		/* Clock EXTernal */
+		mcr &= port->phy_node ? ~CLOCK_OUT_PORT1 : ~CLOCK_OUT_PORT0;
+		rxs |= CLK_LINE_RX; /* RXC input */
+		txs |= CLK_LINE_TX; /* TXC input */
 	}
 
 	outb(mcr, io + N2_MCR);
@@ -203,7 +199,6 @@
 	sca_out(rxs, msci + RXS, card);
 	sca_out(txs, msci + TXS, card);
 	sca_set_port(port);
-	return 0;
 }
 
 
@@ -226,7 +221,8 @@
 	outb(inb(io + N2_PCR) | PCR_ENWIN, io + N2_PCR); /* open window */
 	outb(inb(io + N2_PSR) | PSR_DMAEN, io + N2_PSR); /* enable dma */
 	sca_open(hdlc);
-	return n2_set_iface(port);
+	n2_set_iface(port);
+	return 0;
 }
 
 
@@ -252,6 +248,7 @@
 {
 	union line_settings *line = &ifr->ifr_settings->ifs_line;
 	const size_t size = sizeof(sync_serial_settings);
+	sync_serial_settings new_line;
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	port_t *port = hdlc_to_port(hdlc);
 
@@ -275,10 +272,21 @@
 		if(!capable(CAP_NET_ADMIN))
 			return -EPERM;
 
-		if (copy_from_user(&port->settings, &line->sync, size))
+		if (copy_from_user(&new_line, &line->sync, size))
 			return -EFAULT;
-		/* FIXME - put sanity checks here */
-		return n2_set_iface(port);
+
+		if (new_line.clock_type != CLOCK_EXT &&
+		    new_line.clock_type != CLOCK_TXFROMRX &&
+		    new_line.clock_type != CLOCK_INT &&
+		    new_line.clock_type != CLOCK_TXINT)
+		return -EINVAL;	/* No such clock setting */
+
+		if (new_line.loopback != 0 && new_line.loopback != 1)
+			return -EINVAL;
+
+		memcpy(&port->settings, &new_line, size); /* Update settings */
+		n2_set_iface(port);
+		return 0;
 
 	default:
 		return hdlc_ioctl(dev, ifr, cmd);
--- linux-2.5.orig/drivers/net/wan/c101.c	Tue Jul 23 20:25:54 2002
+++ linux-2.5/drivers/net/wan/c101.c	Sat Aug 10 19:26:38 2002
@@ -1,7 +1,7 @@
 /*
  * Moxa C101 synchronous serial card driver for Linux
  *
- * Copyright (C) 2000-2001 Krzysztof Halasa <khc@pm.waw.pl>
+ * Copyright (C) 2000-2002 Krzysztof Halasa <khc@pm.waw.pl>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by
@@ -31,7 +31,7 @@
 #include "hd64570.h"
 
 
-static const char* version = "Moxa C101 driver version: 1.09";
+static const char* version = "Moxa C101 driver version: 1.10";
 static const char* devname = "C101";
 
 #define C101_PAGE 0x1D00
@@ -107,18 +107,13 @@
 #include "hd6457x.c"
 
 
-static int c101_set_iface(port_t *port)
+static void c101_set_iface(port_t *port)
 {
 	u8 msci = get_msci(port);
 	u8 rxs = port->rxs & CLK_BRG_MASK;
 	u8 txs = port->txs & CLK_BRG_MASK;
 
 	switch(port->settings.clock_type) {
-	case CLOCK_EXT:
-		rxs |= CLK_LINE_RX; /* RXC input */
-		txs |= CLK_LINE_TX; /* TXC input */
-		break;
-
 	case CLOCK_INT:
 		rxs |= CLK_BRG_RX; /* TX clock */
 		txs |= CLK_RXCLK_TX; /* BRG output */
@@ -134,8 +129,9 @@
 		txs |= CLK_RXCLK_TX; /* RX clock */
 		break;
 
-	default:
-		return -EINVAL;
+	default:	/* EXTernal clock */
+		rxs |= CLK_LINE_RX; /* RXC input */
+		txs |= CLK_LINE_TX; /* TXC input */
 	}
 
 	port->rxs = rxs;
@@ -143,7 +139,6 @@
 	sca_out(rxs, msci + RXS, port);
 	sca_out(txs, msci + TXS, port);
 	sca_set_port(port);
-	return 0;
 }
 
 
@@ -159,7 +154,8 @@
 	writeb(1, port->win0base + C101_DTR);
 	sca_out(0, MSCI1_OFFSET + CTL, port); /* RTS uses ch#2 output */
 	sca_open(hdlc);
-	return c101_set_iface(port);
+	c101_set_iface(port);
+	return 0;
 }
 
 
@@ -181,6 +177,7 @@
 {
 	union line_settings *line = &ifr->ifr_settings->ifs_line;
 	const size_t size = sizeof(sync_serial_settings);
+	sync_serial_settings new_line;
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	port_t *port = hdlc_to_port(hdlc);
 
@@ -204,10 +201,21 @@
 		if(!capable(CAP_NET_ADMIN))
 			return -EPERM;
 
-		if (copy_from_user(&port->settings, &line->sync, size))
+		if (copy_from_user(&new_line, &line->sync, size))
 			return -EFAULT;
-		/* FIXME - put sanity checks here */
-		return c101_set_iface(port);
+
+		if (new_line.clock_type != CLOCK_EXT &&
+		    new_line.clock_type != CLOCK_TXFROMRX &&
+		    new_line.clock_type != CLOCK_INT &&
+		    new_line.clock_type != CLOCK_TXINT)
+		return -EINVAL;	/* No such clock setting */
+
+		if (new_line.loopback != 0 && new_line.loopback != 1)
+			return -EINVAL;
+
+		memcpy(&port->settings, &new_line, size); /* Update settings */
+		c101_set_iface(port);
+		return 0;
 
 	default:
 		return hdlc_ioctl(dev, ifr, cmd);

--=-=-=--
