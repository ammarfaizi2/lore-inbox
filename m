Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUDHPUP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 11:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbUDHPUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 11:20:15 -0400
Received: from 80-218-57-148.dclient.hispeed.ch ([80.218.57.148]:49413 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S262022AbUDHPTz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 11:19:55 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Kitt Tientanopajai <kitt@gear.kku.ac.th>
Subject: Re: 2.6.5 yenta_socket irq 10: nobody cared!
Date: Thu, 8 Apr 2004 17:17:15 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200404060227.58325.daniel.ritz@gmx.ch> <200404072225.43358.daniel.ritz@gmx.ch> <20040408143730.09b29b49.kitt@gear.kku.ac.th>
In-Reply-To: <20040408143730.09b29b49.kitt@gear.kku.ac.th>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404081717.15794.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 April 2004 09:37, Kitt Tientanopajai wrote:
> Hi,
> 
> > ok, try the attached one...at least it compiles..
> > 
> > rgds
> > -daniel
> 
> Yes, the patch does work :) Now, I can insert card to the slot controlled by o2micro, no freeze :) My orinoco on TI controller works nicely too, no TX error anymore :)
> 
> Thank you very much for your help. 
> kitt
> 

you're welcome. but i now have the feeling that it's wrong. so another question:
my patch also changes the interrupt assignment for the USB controller at 00:1d.1
so the question is: does this one work ok? or is there an interrupt storm as soon
as you use the device? (like with yenta_socket before)

i looked at the spec of the o2micro controller. from your kernel 2.4-with-pcmcia-cs
output i can see that the o2micro is configured in pci/way mode which means
interrupts are serialized. so it is possible that the INTA/INTB pins are not
connected on the o2micro. the serial interrupt controller in the 82801CAM
assignes INTA on serial to PIRQA, INTB to PIRQB and so on...

so if the o2micro's INTA are actually connected, it's easy: just set the bit
in the config register and be done with it. if it's not connected than it's
harder. we need to find the right interrupt assignment for the serial
interrupt controller.

can you please undo my previous patch and apply the attached one instead.
the socket may be not working, but it prints the relevant registers from
the o2micro chip.

-daniel

===== drivers/pcmcia/yenta_socket.c 1.53 vs edited =====
--- 1.53/drivers/pcmcia/yenta_socket.c	Thu Mar 25 11:20:36 2004
+++ edited/drivers/pcmcia/yenta_socket.c	Thu Apr  8 16:56:07 2004
@@ -665,6 +665,7 @@
 #include "ti113x.h"
 #include "ricoh.h"
 #include "topic.h"
+#include "o2micro.h"
 
 enum {
 	CARDBUS_TYPE_DEFAULT = -1,
@@ -673,7 +674,8 @@
 	CARDBUS_TYPE_TI12XX,
 	CARDBUS_TYPE_TI1250,
 	CARDBUS_TYPE_RICOH,
-	CARDBUS_TYPE_TOPIC97
+	CARDBUS_TYPE_TOPIC97,
+	CARDBUS_TYPE_O2MICRO,
 };
 
 /*
@@ -713,6 +715,9 @@
 	[CARDBUS_TYPE_TOPIC97]	= {
 		.override	= topic97_override,
 	},
+	[CARDBUS_TYPE_O2MICRO]	= {
+		.override	= o2micro_override,
+	},
 };
 
 
@@ -1030,6 +1035,13 @@
 
 	CB_ID(PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_TOSHIBA_TOPIC97, TOPIC97),
 	CB_ID(PCI_VENDOR_ID_TOSHIBA, PCI_DEVICE_ID_TOSHIBA_TOPIC100, TOPIC97),
+
+	CB_ID(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_6729, O2MICRO),
+	CB_ID(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_6730, O2MICRO),
+	CB_ID(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_6812, O2MICRO),
+	CB_ID(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_6832, O2MICRO),
+	CB_ID(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_6836, O2MICRO),
+	CB_ID(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_6933, O2MICRO),
 
 	/* match any cardbus bridge */
 	CB_ID(PCI_ANY_ID, PCI_ANY_ID, DEFAULT),
===== drivers/pcmcia/i82365.c 1.49 vs edited =====
--- 1.49/drivers/pcmcia/i82365.c	Sun Mar 14 21:10:41 2004
+++ edited/drivers/pcmcia/i82365.c	Thu Apr  8 17:07:06 2004
@@ -65,7 +65,6 @@
 #include "cirrus.h"
 #include "vg468.h"
 #include "ricoh.h"
-#include "o2micro.h"
 
 #ifdef DEBUG
 static const char *version =
===== drivers/pcmcia/o2micro.h 1.3 vs edited =====
--- 1.3/drivers/pcmcia/o2micro.h	Sat Oct 19 01:11:25 2002
+++ edited/drivers/pcmcia/o2micro.h	Thu Apr  8 16:59:14 2004
@@ -48,6 +48,9 @@
 #ifndef PCI_DEVICE_ID_O2_6812
 #define PCI_DEVICE_ID_O2_6812		0x6872
 #endif
+#ifndef PCI_DEVICE_ID_O2_6933
+#define PCI_DEVICE_ID_O2_6933		0x6933
+#endif
 
 /* Additional PCI configuration registers */
 
@@ -103,6 +106,10 @@
 #define  O2_MODE_D_W97_IRQ	0x40
 #define  O2_MODE_D_ISA_IRQ	0x80
 
+#define  O2_MODE_D_IRQ_PCPCI	0x00
+#define  O2_MODE_D_IRQ_SER	0x02
+#define  O2_MODE_D_IRQ_PCI	0x03
+
 #define O2_MHPG_DMA		0x3c
 #define  O2_MHPG_CHANNEL	0x07
 #define  O2_MHPG_CINT_ENA	0x08
@@ -119,5 +126,25 @@
 #define  O2_MODE_E_SPKR_OUT	0x02
 #define  O2_MODE_E_LED_OUT	0x08
 #define  O2_MODE_E_SKTA_ACTV	0x10
+
+static int o2micro_override(struct yenta_socket *socket)
+{
+	u8 mode_d;
+	u32 mux_ctrl;
+
+	mode_d = config_readb(socket, O2_MODE_D);
+	mux_ctrl = config_readl(socket, O2_MUX_CONTROL);
+
+	printk(KERN_INFO "Yenta O2: socket %s, Mux Ctrk: %08x, Mode D: %02x\n",
+	       pci_name(socket->dev), mux_ctrl, mode_d);
+
+	/* XXX: hack: make sure PCI interrupt are not serialized */
+	if ((mode_d & O2_MODE_D_IRQ_MODE) == O2_MODE_D_IRQ_SER) {
+		mux_ctrl &= ~O2_MUX_SER_PCI;
+		config_writel(socket, O2_MUX_CONTROL, mux_ctrl);
+	}
+
+	return 0;
+}
 
 #endif /* _LINUX_O2MICRO_H */


