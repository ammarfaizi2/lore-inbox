Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317119AbSFFSqW>; Thu, 6 Jun 2002 14:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317112AbSFFSpI>; Thu, 6 Jun 2002 14:45:08 -0400
Received: from keen.esi.ac.at ([193.170.117.2]:33043 "EHLO keen.esi.ac.at")
	by vger.kernel.org with ESMTP id <S317110AbSFFSoJ>;
	Thu, 6 Jun 2002 14:44:09 -0400
Date: Thu, 6 Jun 2002 20:44:06 +0200 (CEST)
From: Gerald Teschl <gerald@esi.ac.at>
To: linux-kernel@vger.kernel.org
cc: zwane@linux.realnet.co.sz, <alan@redhat.com>,
        <linux-sound@vger.kernel.org>
Subject: [PATCH] opl3sa2 isapnp activation fix
Message-ID: <Pine.LNX.4.44.0206062030340.9347-100000@keen.esi.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now here is the new version of the opl3sa2 activation fix. This new
version now adds the fix as a quirk to isapnp. Zwane Mwaikambo and
I have discussed this very carefully and we now both agree that this
is the best way to fix the problem. The patch is against 2.4.19-pre10
and requires the previous isapnp_dma0.patch.

It now loops over all acceptable dma_resources and only allows dma0
if dma channel 0 is the ONLY value accepted by the card. In
addition, it also fixes the problem that a card would not get
deactivated upon removal of the module.

Gerald

opl3sa2_dma0.patch:
-------------------------
--- linux.orig/drivers/pnp/quirks.c	Thu Jun  6 18:04:43 2002
+++ linux/drivers/pnp/quirks.c	Thu Jun  6 18:07:25 2002
@@ -102,6 +102,28 @@
 	return;
 }
 
+extern int isapnp_allow_dma0;
+static void __init quirk_opl3sax_resources(struct pci_dev *dev)
+{
+	/* This really isn't a device quirk but isapnp core code
+	 * doesn't allow a DMA channel of 0, afflicted card is an
+	 * OPL3Sax where x=4.
+	 */
+	struct isapnp_resources *res;
+	int max;
+	res = (struct isapnp_resources *)dev->sysdata;
+	max = res->dma->map;
+	for (res = res->alt; res; res = res->alt) {
+		if (res->dma->map > max)
+			max = res->dma->map;
+	}
+	if (max == 1 && isapnp_allow_dma0 == -1) {
+		printk(KERN_INFO "isapnp: opl3sa4 quirk: Allowing dma 0.\n");
+		isapnp_allow_dma0 = 1;
+	}
+	return;
+}
+
 /*
  *  ISAPnP Quirks
  *  Cards or devices that need some tweaking due to broken hardware
@@ -133,6 +155,8 @@
 		quirk_sb16audio_resources },
 	{ ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0045),
 		quirk_sb16audio_resources },
+	{ ISAPNP_VENDOR('Y','M','H'), ISAPNP_DEVICE(0x0021),
+		quirk_opl3sax_resources },
 	{ 0 }
 };
 
--- linux.orig/drivers/sound/opl3sa2.c	Thu Jun  6 18:04:44 2002
+++ linux/drivers/sound/opl3sa2.c	Thu Jun  6 18:07:25 2002
@@ -57,6 +57,7 @@
  *                         (Jan 7, 2001)
  * Zwane Mwaikambo	   Added PM support. (Dec 4 2001)
  * Zwane Mwaikambo	   Code, data structure cleanups. (Feb 15 2002)
+ * Gerald Teschl	   ISA PnP activate fix. (Jun 02 2002)
  *
  */
 
@@ -873,10 +874,11 @@
 	}
 	else {
 		if(dev->activate(dev) < 0) {
-			printk(KERN_WARNING PFX "ISA PnP activate failed\n");
+			printk(KERN_WARNING PFX "ISA PnP activate failed.\n");
 			opl3sa2_state[card].activated = 0;
 			return -ENODEV;
 		}
+		opl3sa2_state[card].activated = 1;
 
 		printk(KERN_DEBUG
 		       PFX "Activated ISA PnP card %d (active=%d)\n",

