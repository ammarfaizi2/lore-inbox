Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWCVWNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWCVWNw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWCVWNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:13:31 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:57298 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932101AbWCVWNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:13:16 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH 12/12] PNP: adjust pnp_register_card_driver() signature
Date: Wed, 22 Mar 2006 15:13:12 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>, Paul Barton-Davis <pbd@op.net>
References: <200603221455.26230.bjorn.helgaas@hp.com>
In-Reply-To: <200603221455.26230.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221513.12321.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that pnp_register_card_driver() returns the
number of devices claimed.  And fix some __init/__devinit issues.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm6/sound/isa/wavefront/wavefront.c
===================================================================
--- work-mm6.orig/sound/isa/wavefront/wavefront.c	2006-03-22 11:24:41.000000000 -0700
+++ work-mm6/sound/isa/wavefront/wavefront.c	2006-03-22 12:16:20.000000000 -0700
@@ -589,7 +589,7 @@
 	return snd_card_register(card);
 }	
 
-static int __init snd_wavefront_nonpnp_probe(struct platform_device *pdev)
+static int __devinit snd_wavefront_nonpnp_probe(struct platform_device *pdev)
 {
 	int dev = pdev->id;
 	struct snd_card *card;
@@ -637,6 +637,7 @@
 
 
 #ifdef CONFIG_PNP
+static unsigned int __devinitdata wavefront_pnp_devices;
 
 static int __devinit snd_wavefront_pnp_detect(struct pnp_card_link *pcard,
                                               const struct pnp_card_device_id *pid)
@@ -670,6 +671,7 @@
 
 	pnp_set_card_drvdata(pcard, card);
 	dev++;
+	wavefront_pnp_devices++;
 	return 0;
 }
 
@@ -729,10 +731,10 @@
 	}
 
 #ifdef CONFIG_PNP
-	i = pnp_register_card_driver(&wavefront_pnpc_driver);
-	if (i >= 0) {
+	err = pnp_register_card_driver(&wavefront_pnpc_driver);
+	if (!err) {
 		pnp_registered = 1;
-		cards += i;
+		cards += wavefront_pnp_devices;
 	}
 #endif
 
