Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272378AbTHRT7n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 15:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272445AbTHRT7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 15:59:43 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:17156 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S272378AbTHRT7j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 15:59:39 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Russell King <rmk@arm.linux.org.uk>,
       "linux-pcmcia" <linux-pcmcia@lists.infradead.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [CFT][PCMCIA 2.6] add Toshiba ToPIC97 zoom video support to yenta_socket
Date: Mon, 18 Aug 2003 21:53:58 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308182153.58645.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adds zoom video support for tosiba ToPIC97 and ToPIC100 chips.
against 2.6-bk + russell's yenta patches (see:
	http://marc.theaimsgroup.com/?l=linux-kernel&m=106113111729296&w=3 )
and of course it's untested 'cos i don't have a ZV card around.

rgds
-daniel


--- 1.3/drivers/pcmcia/topic.h	Sat Oct 19 01:11:25 2002
+++ edited/drivers/pcmcia/topic.h	Mon Aug 18 18:34:19 2003
@@ -31,20 +31,7 @@
 #ifndef _LINUX_TOPIC_H
 #define _LINUX_TOPIC_H
 
-#ifndef PCI_VENDOR_ID_TOSHIBA
-#define PCI_VENDOR_ID_TOSHIBA		0x1179
-#endif
-#ifndef PCI_DEVICE_ID_TOSHIBA_TOPIC95_A
-#define PCI_DEVICE_ID_TOSHIBA_TOPIC95_A	0x0603
-#endif
-#ifndef PCI_DEVICE_ID_TOSHIBA_TOPIC95_B
-#define PCI_DEVICE_ID_TOSHIBA_TOPIC95_B	0x060a
-#endif
-#ifndef PCI_DEVICE_ID_TOSHIBA_TOPIC97
-#define PCI_DEVICE_ID_TOSHIBA_TOPIC97	0x060f
-#endif
-
-/* Register definitions for Toshiba ToPIC95 controllers */
+/* Register definitions for Toshiba ToPIC95/97/100 controllers */
 
 #define TOPIC_SOCKET_CONTROL		0x0090	/* 32 bit */
 #define  TOPIC_SCR_IRQSEL		0x00000001
@@ -92,5 +79,62 @@
 #define  TOPIC97_RCR_RI_DISABLE		0x00000004
 #define  TOPIC97_RCR_CAUDIO_OFF		0x00000002
 #define  TOPIC_RCR_CAUDIO_INVERT	0x00000001
+
+#define TOPIC97_MISC1			0x00ad  /* 8bit */
+#define  TOPIC97_MISC1_CLOCKRUN_ENABLE	0x80
+#define  TOPIC97_MISC1_CLOCKRUN_MODE	0x40
+#define  TOPIC97_MISC1_DETECT_REQ_ENA	0x10
+#define  TOPIC97_MISC1_SCK_CLEAR_DIS	0x04
+#define  TOPIC97_MISC1_R2_LOW_ENABLE	0x10
+
+#define TOPIC97_MISC2			0x00ae  /* 8 bit */
+#define  TOPIC97_MISC2_SPWRCLK_MASK	0x70
+#define  TOPIC97_MISC2_SPWRMOD		0x08
+#define  TOPIC97_MISC2_SPWR_ENABLE	0x04
+#define  TOPIC97_MISC2_ZV_MODE		0x02
+#define  TOPIC97_MISC2_ZV_ENABLE	0x01
+
+#define TOPIC97_ZOOM_VIDEO_CONTROL	0x009c  /* 8 bit */
+#define  TOPIC97_ZV_CONTROL_ENABLE	0x01
+
+#define TOPIC97_AUDIO_VIDEO_SWITCH	0x003c  /* 8 bit */
+#define  TOPIC97_AVS_AUDIO_CONTROL	0x02
+#define  TOPIC97_AVS_VIDEO_CONTROL	0x01
+
+
+static void topic97_zoom_video(struct pcmcia_socket *sock, int onoff)
+{
+	struct yenta_socket *socket = container_of(sock, struct yenta_socket, socket);
+	u8 reg_zv, reg;
+
+	reg_zv = config_readb(socket, TOPIC97_ZOOM_VIDEO_CONTROL);
+	if (onoff) {
+		reg_zv |= TOPIC97_ZV_CONTROL_ENABLE;
+		config_writeb(socket, TOPIC97_ZOOM_VIDEO_CONTROL, reg_zv);
+
+		reg = config_readb(socket, TOPIC97_MISC2);
+		reg |= TOPIC97_MISC2_ZV_ENABLE;
+		config_writeb(socket, TOPIC97_MISC2, reg);
+
+		/* not sure this is needed, doc is unclear */
+#if 0
+		reg = config_readb(socket, TOPIC97_AUDIO_VIDEO_SWITCH);
+		reg |= TOPIC97_AVS_AUDIO_CONTROL | TOPIC97_AVS_VIDEO_CONTROL;
+		config_writeb(socket, TOPIC97_AUDIO_VIDEO_SWITCH, reg);
+#endif
+	}
+	else {
+		reg_zv &= ~TOPIC97_ZV_CONTROL_ENABLE;
+		config_writeb(socket, TOPIC97_ZOOM_VIDEO_CONTROL, reg_zv);
+	}
+
+}
+
+static int topic97_override(struct yenta_socket *socket)
+{
+	/* ToPIC97/100 support ZV */
+	socket->socket.zoom_video = topic97_zoom_video;
+	return 0;
+}
 
 #endif /* _LINUX_TOPIC_H */
--- 1.115/include/linux/pci_ids.h	Sat Aug 16 16:19:05 2003
+++ edited/include/linux/pci_ids.h	Mon Aug 18 13:35:20 2003
@@ -1330,7 +1330,10 @@
 #define PCI_VENDOR_ID_TOSHIBA		0x1179
 #define PCI_DEVICE_ID_TOSHIBA_601	0x0601
 #define PCI_DEVICE_ID_TOSHIBA_TOPIC95	0x060a
+#define PCI_DEVICE_ID_TOSHIBA_TOPIC95_A 0x0603
+#define PCI_DEVICE_ID_TOSHIBA_TOPIC95_B 0x060a
 #define PCI_DEVICE_ID_TOSHIBA_TOPIC97	0x060f
+#define PCI_DEVICE_ID_TOSHIBA_TOPIC100	0x0617
 
 #define PCI_VENDOR_ID_TOSHIBA_2		0x102f
 #define PCI_DEVICE_ID_TOSHIBA_TX3927	0x000a
--- linux-2.5/drivers/pcmcia/yenta_socket.c	2003-08-18 13:13:50.000000000 +0200
+++ edited/drivers/pcmcia/yenta_socket.c	2003-08-18 18:28:37.000000000 +0200
@@ -660,6 +660,7 @@
 
 #include "ti113x.h"
 #include "ricoh.h"
+#include "topic.h"
 
 enum {
 	CARDBUS_TYPE_DEFAULT = -1,
@@ -667,7 +668,8 @@
 	CARDBUS_TYPE_TI113X,
 	CARDBUS_TYPE_TI12XX,
 	CARDBUS_TYPE_TI1250,
-	CARDBUS_TYPE_RICOH
+	CARDBUS_TYPE_RICOH,
+	CARDBUS_TYPE_TOPIC97
 };
 
 /*
@@ -704,6 +706,9 @@
 		.save_state	= ricoh_save_state,
 		.restore_state	= ricoh_restore_state,
 	},
+	[CARDBUS_TYPE_TOPIC97]	= {
+		.override	= topic97_override,
+	},
 };
 
 
@@ -1012,6 +1017,9 @@
 	CB_ID(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_RL5C476, RICOH),
 	CB_ID(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_RL5C478, RICOH),
 
+	CB_ID(PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_TOSHIBA_TOPIC97, TOPIC97),
+	CB_ID(PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_TOSHIBA_TOPIC100, TOPIC97),
+
 	/* match any cardbus bridge */
 	CB_ID(PCI_ANY_ID, PCI_ANY_ID, DEFAULT),
 	{ /* all zeroes */ }

