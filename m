Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWCVWNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWCVWNF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWCVWMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:12:49 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:58005 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932103AbWCVWMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:12:46 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH  6/12] PNP: adjust pnp_register_card_driver() signature
Date: Wed, 22 Mar 2006 15:12:41 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Christian Fischbach <fishbach@pool.informatik.rwth-aachen.de>,
       Abramo Bagnara <abramo@alsa-project.org>
References: <200603221455.26230.bjorn.helgaas@hp.com>
In-Reply-To: <200603221455.26230.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221512.41849.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that pnp_register_card_driver() returns the
number of devices claimed.  And fix some __init/__devinit issues.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm6/sound/isa/es18xx.c
===================================================================
--- work-mm6.orig/sound/isa/es18xx.c	2006-03-22 11:24:41.000000000 -0700
+++ work-mm6/sound/isa/es18xx.c	2006-03-22 12:05:00.000000000 -0700
@@ -2203,7 +2203,7 @@
 	return snd_card_register(card);
 }
 
-static int __init snd_es18xx_nonpnp_probe1(int dev, struct platform_device *devptr)
+static int __devinit snd_es18xx_nonpnp_probe1(int dev, struct platform_device *devptr)
 {
 	struct snd_card *card;
 	int err;
@@ -2220,7 +2220,7 @@
 	return 0;
 }
 
-static int __init snd_es18xx_nonpnp_probe(struct platform_device *pdev)
+static int __devinit snd_es18xx_nonpnp_probe(struct platform_device *pdev)
 {
 	int dev = pdev->id;
 	int err;
@@ -2296,6 +2296,8 @@
 
 
 #ifdef CONFIG_PNP
+static unsigned int __devinitdata es18xx_pnp_devices;
+
 static int __devinit snd_audiodrive_pnp_detect(struct pnp_card_link *pcard,
 					       const struct pnp_card_device_id *pid)
 {
@@ -2326,6 +2328,7 @@
 
 	pnp_set_card_drvdata(pcard, card);
 	dev++;
+	es18xx_pnp_devices++;
 	return 0;
 }
 
@@ -2396,10 +2399,10 @@
 	}
 
 #ifdef CONFIG_PNP
-	i = pnp_register_card_driver(&es18xx_pnpc_driver);
-	if (i >= 0) {
+	err = pnp_register_card_driver(&es18xx_pnpc_driver);
+	if (!err) {
 		pnp_registered = 1;
-		cards += i;
+		cards += es18xx_pnp_devices;
 	}
 #endif
 
