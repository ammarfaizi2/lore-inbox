Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271217AbTHFSaq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 14:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271373AbTHFSaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 14:30:46 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:24070 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S271217AbTHFSan
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 14:30:43 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Russel King <rmk@arm.linux.org.uk>
Subject: [PATCH 2.6] ToPIC specific init for yenta_socket
Date: Wed, 6 Aug 2003 20:25:08 +0200
User-Agent: KMail/1.5.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-pcmcia" <linux-pcmcia@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308062025.08861.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this patch adds override functions for the ToPIC family of controllers.
also adds the device id for ToPIC100 and (untested) support for zoom
video for ToPIC97/100.

tested with start/stop and suspend/resume.


--- 1.3/drivers/pcmcia/topic.h	Sat Oct 19 01:11:25 2002
+++ edited/drivers/pcmcia/topic.h	Wed Aug  6 19:25:39 2003
@@ -93,4 +93,60 @@
 #define  TOPIC97_RCR_CAUDIO_OFF		0x00000002
 #define  TOPIC_RCR_CAUDIO_INVERT	0x00000001
 
+#define TOPIC97_ZOOM_VIDEO_CONTROL	0x009c  /* 8 bit */
+#define  TOPIC97_ZOOM_VIDEO_ENABLE	0x01
+
+/* general ToPIC stuff */
+static int topic_init(struct pcmcia_socket *sock)
+{
+	struct yenta_socket *socket = container_of(sock, struct yenta_socket, socket);
+	u8 val;
+	
+	yenta_init(sock);
+
+	/* enable CB, CB/PCCARD regs, lock ID */
+	val = config_readb(socket, TOPIC_SLOT_CONTROL);
+	val |= TOPIC_SLOT_SLOTON | TOPIC_SLOT_SLOTEN | TOPIC_SLOT_ID_LOCK |
+	       TOPIC_SLOT_ID_WP;
+	config_writeb(socket, TOPIC_SLOT_CONTROL, val);
+
+	/* enable CB, HW change detect */
+	val = config_readb(socket, TOPIC_CARD_DETECT);
+	val |= TOPIC_CDR_MODE_PC32;
+	val &= ~TOPIC_CDR_SW_DETECT;
+	config_writeb(socket, TOPIC_CARD_DETECT, val);
+
+	return 0;
+}
+
+static int topic_override(struct yenta_socket *socket)
+{
+	socket->socket.ops->init = topic_init;
+	return 0;
+}
+
+/* ToPIC97/100 stuff */
+static void topic97_zoom_video(struct pcmcia_socket *sock, int onoff)
+{
+	struct yenta_socket *socket = container_of(sock, struct yenta_socket, socket);
+	config_writeb(socket, TOPIC97_ZOOM_VIDEO_CONTROL,
+	              onoff? TOPIC97_ZOOM_VIDEO_ENABLE: 0);
+}
+
+static int topic97_init(struct pcmcia_socket *sock)
+{
+	topic_init(sock);
+
+	/* ToPIC97/100 support ZV */
+	sock->zoom_video = topic97_zoom_video;
+
+	return 0;
+}
+
+static int topic97_override(struct yenta_socket *socket)
+{
+	socket->socket.ops->init = topic97_init;
+	return 0;
+}
+
 #endif /* _LINUX_TOPIC_H */
--- 1.35/drivers/pcmcia/yenta_socket.c	Sun Aug  3 17:05:56 2003
+++ edited/drivers/pcmcia/yenta_socket.c	Wed Aug  6 17:27:24 2003
@@ -769,6 +769,7 @@
 
 #include "ti113x.h"
 #include "ricoh.h"
+#include "topic.h"
 
 /*
  * Different cardbus controllers have slightly different
@@ -809,6 +810,11 @@
 	{ PD(RICOH,RL5C475), &ricoh_override },
 	{ PD(RICOH,RL5C476), &ricoh_override },
 	{ PD(RICOH,RL5C478), &ricoh_override },
+
+	{ PD(TOSHIBA,TOPIC95_A), &topic_override },
+	{ PD(TOSHIBA,TOPIC95_B), &topic_override },
+	{ PD(TOSHIBA,TOPIC97), &topic97_override },
+	{ PD(TOSHIBA,TOPIC100), &topic97_override },
 
 	{ }, /* all zeroes */
 };
--- 1.112/include/linux/pci_ids.h	Wed Aug  6 00:37:33 2003
+++ edited/include/linux/pci_ids.h	Wed Aug  6 16:55:04 2003
@@ -1310,6 +1310,7 @@
 #define PCI_DEVICE_ID_TOSHIBA_601	0x0601
 #define PCI_DEVICE_ID_TOSHIBA_TOPIC95	0x060a
 #define PCI_DEVICE_ID_TOSHIBA_TOPIC97	0x060f
+#define PCI_DEVICE_ID_TOSHIBA_TOPIC100	0x0617
 
 #define PCI_VENDOR_ID_TOSHIBA_2		0x102f
 #define PCI_DEVICE_ID_TOSHIBA_TX3927	0x000a

