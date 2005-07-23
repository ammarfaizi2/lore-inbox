Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVGWPqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVGWPqn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 11:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVGWPoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 11:44:18 -0400
Received: from pop.gmx.net ([213.165.64.20]:61875 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261757AbVGWPnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 11:43:21 -0400
X-Authenticated: #2813124
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Subject: Re: oz6812, yenta_socket and madwifi
Date: Sat, 23 Jul 2005 17:44:17 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507231744.17519.daniel.ritz@gmx.ch>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

since i'm the one that put that code there in the first place i guess
i have to comment on it :)

the attached patch should also fix your problem. and it cleans up the
magic numbers a bit.

rgds
-daniel

-------------

[PATCH] disable read prefetch/write burst on old O2Micro bridges

older O2Micro bridges have problems with both read prefetch and write burst
depending on the combination of the chipset, bridge, cardbus card. safest
is to disable read prefetch and write burst on those old bridges.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

diff --git a/drivers/pcmcia/o2micro.h b/drivers/pcmcia/o2micro.h
--- a/drivers/pcmcia/o2micro.h
+++ b/drivers/pcmcia/o2micro.h
@@ -120,11 +120,16 @@
 #define  O2_MODE_E_LED_OUT	0x08
 #define  O2_MODE_E_SKTA_ACTV	0x10
 
+#define O2_RESERVED1		0x94
+#define O2_RESERVED2		0xD4
+#define O2_RES_READ_PREFETCH	0x02
+#define O2_RES_WRITE_BURST	0x08
+
 static int o2micro_override(struct yenta_socket *socket)
 {
 	/*
-	 * 'reserved' register at 0x94/D4. chaning it to 0xCA (8 bit) enables
-	 * read prefetching which for example makes the RME Hammerfall DSP
+	 * 'reserved' register at 0x94/D4. allows setting read prefetch and write
+	 * bursting. read prefetching for example makes the RME Hammerfall DSP
 	 * working. for some bridges it is at 0x94, for others at 0xD4. it's
 	 * ok to write to both registers on all O2 bridges.
 	 * from Eric Still, 02Micro.
@@ -132,20 +137,35 @@ static int o2micro_override(struct yenta
 	u8 a, b;
 
 	if (PCI_FUNC(socket->dev->devfn) == 0) {
-		a = config_readb(socket, 0x94);
-		b = config_readb(socket, 0xD4);
+		a = config_readb(socket, O2_RESERVED1);
+		b = config_readb(socket, O2_RESERVED2);
 
 		printk(KERN_INFO "Yenta O2: res at 0x94/0xD4: %02x/%02x\n", a, b);
 
 		switch (socket->dev->device) {
+		/*
+		 * older bridges have problems with both read prefetch and write
+		 * bursting depending on the combination of the chipset, bridge
+		 * and the cardbus card. so disable them to be on the safe side.
+		 */
+		case PCI_DEVICE_ID_O2_6729:
+		case PCI_DEVICE_ID_O2_6730:
+		case PCI_DEVICE_ID_O2_6812:
 		case PCI_DEVICE_ID_O2_6832:
-			printk(KERN_INFO "Yenta O2: old bridge, not enabling read prefetch / write burst\n");
+		case PCI_DEVICE_ID_O2_6836:
+			printk(KERN_INFO "Yenta O2: old bridge, disabling read prefetch/write burst\n");
+			config_writeb(socket, O2_RESERVED1,
+			              a & ~(O2_RES_READ_PREFETCH | O2_RES_READ_PREFETCH));
+			config_writeb(socket, O2_RESERVED2,
+			              b & ~(O2_RES_READ_PREFETCH | O2_RES_READ_PREFETCH));
 			break;
 
 		default:
 			printk(KERN_INFO "Yenta O2: enabling read prefetch/write burst\n");
-			config_writeb(socket, 0x94, a | 0x0a);
-			config_writeb(socket, 0xD4, b | 0x0a);
+			config_writeb(socket, O2_RESERVED1,
+			              a | O2_RES_READ_PREFETCH | O2_RES_READ_PREFETCH);
+			config_writeb(socket, O2_RESERVED2,
+			              b | O2_RES_READ_PREFETCH | O2_RES_READ_PREFETCH);
 		}
 	}
 
