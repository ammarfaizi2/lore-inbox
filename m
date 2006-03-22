Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWCVWOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWCVWOg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWCVWNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:13:08 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:26065 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932107AbWCVWM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:12:56 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH  8/12] PNP: adjust pnp_register_card_driver() signature
Date: Wed, 22 Mar 2006 15:12:52 -0700
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
Message-Id: <200603221512.52484.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that pnp_register_card_driver() returns the
number of devices claimed.  And fix some __init/__devinit issues.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm6/sound/isa/gus/interwave.c
===================================================================
--- work-mm6.orig/sound/isa/gus/interwave.c	2006-03-22 11:24:41.000000000 -0700
+++ work-mm6/sound/isa/gus/interwave.c	2006-03-22 12:07:43.000000000 -0700
@@ -791,7 +791,7 @@
 	return 0;
 }
 
-static int __init snd_interwave_nonpnp_probe1(int dev, struct platform_device *devptr)
+static int __devinit snd_interwave_nonpnp_probe1(int dev, struct platform_device *devptr)
 {
 	struct snd_card *card;
 	int err;
@@ -809,7 +809,7 @@
 	return 0;
 }
 
-static int __init snd_interwave_nonpnp_probe(struct platform_device *pdev)
+static int __devinit snd_interwave_nonpnp_probe(struct platform_device *pdev)
 {
 	int dev = pdev->id;
 	int err;
@@ -867,6 +867,7 @@
 };
 
 #ifdef CONFIG_PNP
+static unsigned int __devinitdata interwave_pnp_devices;
 
 static int __devinit snd_interwave_pnp_detect(struct pnp_card_link *pcard,
 					      const struct pnp_card_device_id *pid)
@@ -897,6 +898,7 @@
 	}
 	pnp_set_card_drvdata(pcard, card);
 	dev++;
+	interwave_pnp_devices++;
 	return 0;
 }
 
@@ -954,10 +956,10 @@
 	}
 
 	/* ISA PnP cards */
-	i = pnp_register_card_driver(&interwave_pnpc_driver);
-	if (i >= 0) {
+	err = pnp_register_card_driver(&interwave_pnpc_driver);
+	if (!err) {
 		pnp_registered = 1;
-		cards += i;
+		cards += interwave_pnp_devices;;
 	}
 
 	if (!cards) {
