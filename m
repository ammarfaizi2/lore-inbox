Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWCVWMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWCVWMU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWCVWMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:12:20 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:36558 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932092AbWCVWMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:12:19 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH  2/12] PNP: adjust pnp_register_card_driver() signature
Date: Wed, 22 Mar 2006 15:12:14 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Massimo Piccioni <dafastidio@libero.it>, Takashi Iwai <tiwai@suse.de>
References: <200603221455.26230.bjorn.helgaas@hp.com>
In-Reply-To: <200603221455.26230.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221512.14335.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that pnp_register_card_driver() returns the
number of devices claimed.  And fix a __init/__devinit issue.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm6/sound/isa/als100.c
===================================================================
--- work-mm6.orig/sound/isa/als100.c	2006-03-22 11:24:42.000000000 -0700
+++ work-mm6/sound/isa/als100.c	2006-03-22 11:48:33.000000000 -0700
@@ -199,7 +199,7 @@
 	return 0;
 }
 
-static int __init snd_card_als100_probe(int dev,
+static int __devinit snd_card_als100_probe(int dev,
 					struct pnp_card_link *pcard,
 					const struct pnp_card_device_id *pid)
 {
@@ -281,6 +281,8 @@
 	return 0;
 }
 
+static unsigned int __devinitdata als100_devices;
+
 static int __devinit snd_als100_pnp_detect(struct pnp_card_link *card,
 					   const struct pnp_card_device_id *id)
 {
@@ -294,6 +296,7 @@
 		if (res < 0)
 			return res;
 		dev++;
+		als100_devices++;
 		return 0;
 	}
 	return -ENODEV;
@@ -345,10 +348,13 @@
 
 static int __init alsa_card_als100_init(void)
 {
-	int cards;
+	int err;
+
+	err = pnp_register_card_driver(&als100_pnpc_driver);
+	if (err)
+		return err;
 
-	cards = pnp_register_card_driver(&als100_pnpc_driver);
-	if (cards <= 0) {
+	if (!als100_devices) {
 		pnp_unregister_card_driver(&als100_pnpc_driver);
 #ifdef MODULE
 		snd_printk(KERN_ERR "no ALS100 based soundcards found\n");
