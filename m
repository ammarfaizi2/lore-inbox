Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWCVWOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWCVWOh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWCVWNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:13:06 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:17814 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932103AbWCVWNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:13:01 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH  9/12] PNP: adjust pnp_register_card_driver() signature
Date: Wed, 22 Mar 2006 15:12:57 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>
References: <200603221455.26230.bjorn.helgaas@hp.com>
In-Reply-To: <200603221455.26230.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221512.57680.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that pnp_register_card_driver() returns the
number of devices claimed.  And fix some __init/__devinit issues.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm6/sound/isa/sb/sb16.c
===================================================================
--- work-mm6.orig/sound/isa/sb/sb16.c	2006-03-22 11:24:41.000000000 -0700
+++ work-mm6/sound/isa/sb/sb16.c	2006-03-22 12:12:20.000000000 -0700
@@ -369,7 +369,7 @@
 	return card;
 }
 
-static int __init snd_sb16_probe(struct snd_card *card, int dev)
+static int __devinit snd_sb16_probe(struct snd_card *card, int dev)
 {
 	int xirq, xdma8, xdma16;
 	struct snd_sb *chip;
@@ -518,7 +518,7 @@
 }
 #endif
 
-static int __init snd_sb16_nonpnp_probe1(int dev, struct platform_device *devptr)
+static int __devinit snd_sb16_nonpnp_probe1(int dev, struct platform_device *devptr)
 {
 	struct snd_card_sb16 *acard;
 	struct snd_card *card;
@@ -548,7 +548,7 @@
 }
 
 
-static int __init snd_sb16_nonpnp_probe(struct platform_device *pdev)
+static int __devinit snd_sb16_nonpnp_probe(struct platform_device *pdev)
 {
 	int dev = pdev->id;
 	int err;
@@ -629,6 +629,7 @@
 
 
 #ifdef CONFIG_PNP
+static unsigned int __devinitdata sb16_pnp_devices;
 
 static int __devinit snd_sb16_pnp_detect(struct pnp_card_link *pcard,
 					 const struct pnp_card_device_id *pid)
@@ -651,6 +652,7 @@
 		}
 		pnp_set_card_drvdata(pcard, card);
 		dev++;
+		sb16_pnp_devices++;
 		return 0;
 	}
 
@@ -727,10 +729,10 @@
 	}
 #ifdef CONFIG_PNP
 	/* PnP cards at last */
-	i = pnp_register_card_driver(&sb16_pnpc_driver);
-	if (i >= 0) {
+	err = pnp_register_card_driver(&sb16_pnpc_driver);
+	if (!err) {
 		pnp_registered = 1;
-		cards += i;
+		cards += sb16_pnp_devices;
 	}
 #endif
 
