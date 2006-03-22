Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWCVWNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWCVWNG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWCVWMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:12:47 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:22956 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932098AbWCVWMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:12:39 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH  5/12] PNP: adjust pnp_register_card_driver() signature
Date: Wed, 22 Mar 2006 15:12:34 -0700
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
Message-Id: <200603221512.34967.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that pnp_register_card_driver() returns the
number of devices claimed.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm5/sound/isa/dt019x.c
===================================================================
--- work-mm5.orig/sound/isa/dt019x.c	2006-03-22 09:57:34.000000000 -0700
+++ work-mm5/sound/isa/dt019x.c	2006-03-22 10:13:34.000000000 -0700
@@ -272,6 +272,8 @@
 	return 0;
 }
 
+static unsigned int __devinitdata dt019x_devices;
+
 static int __devinit snd_dt019x_pnp_probe(struct pnp_card_link *card,
 					  const struct pnp_card_device_id *pid)
 {
@@ -285,6 +287,7 @@
 		if (res < 0)
 			return res;
 		dev++;
+		dt019x_devices++;
 		return 0;
 	}
 	return -ENODEV;
@@ -336,10 +339,13 @@
 
 static int __init alsa_card_dt019x_init(void)
 {
-	int cards = 0;
+	int err;
+
+	err = pnp_register_card_driver(&dt019x_pnpc_driver);
+	if (err)
+		return err;
 
-	cards = pnp_register_card_driver(&dt019x_pnpc_driver);
-	if (cards <= 0) {
+	if (!dt019x_devices) {
 		pnp_unregister_card_driver(&dt019x_pnpc_driver);
 #ifdef MODULE
 		snd_printk(KERN_ERR "no DT-019X / ALS-007 based soundcards found\n");
