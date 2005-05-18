Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVERCyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVERCyX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 22:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVERCyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 22:54:23 -0400
Received: from gate.crashing.org ([63.228.1.57]:24197 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262059AbVERCyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 22:54:09 -0400
Subject: [PATCH] ppc32: Fix Alsa PowerMac driver on old machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Alsa-Devel List <alsa-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 18 May 2005 12:53:43 +1000
Message-Id: <1116384823.6122.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The g5 support code broke some earlier models unfortunately as those
bail out early from the detect function, before the point where I added
the code to locate the PCI device for use with DMA allocations.

This patch fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/sound/ppc/pmac.c
===================================================================
--- linux-work.orig/sound/ppc/pmac.c	2005-05-02 10:51:00.000000000 +1000
+++ linux-work/sound/ppc/pmac.c	2005-05-09 12:01:42.000000000 +1000
@@ -876,7 +876,7 @@
  */
 static int __init snd_pmac_detect(pmac_t *chip)
 {
-	struct device_node *sound;
+	struct device_node *sound = NULL;
 	unsigned int *prop, l;
 	struct macio_chip* macio;
 
@@ -906,20 +906,22 @@
 		chip->is_pbook_G3 = 1;
 	chip->node = find_devices("awacs");
 	if (chip->node)
-		return 0; /* ok */
+		sound = chip->node;
 
 	/*
 	 * powermac G3 models have a node called "davbus"
 	 * with a child called "sound".
 	 */
-	chip->node = find_devices("davbus");
+	if (!chip->node)
+		chip->node = find_devices("davbus");
 	/*
 	 * if we didn't find a davbus device, try 'i2s-a' since
 	 * this seems to be what iBooks have
 	 */
 	if (! chip->node) {
 		chip->node = find_devices("i2s-a");
-		if (chip->node && chip->node->parent && chip->node->parent->parent) {
+		if (chip->node && chip->node->parent &&
+		    chip->node->parent->parent) {
 			if (device_is_compatible(chip->node->parent->parent,
 						 "K2-Keylargo"))
 				chip->is_k2 = 1;
@@ -928,9 +930,11 @@
 	if (! chip->node)
 		return -ENODEV;
 
-	sound = find_devices("sound");
-	while (sound && sound->parent != chip->node)
-		sound = sound->next;
+	if (!sound) {
+		sound = find_devices("sound");
+		while (sound && sound->parent != chip->node)
+			sound = sound->next;
+	}
 	if (! sound)
 		return -ENODEV;
 	prop = (unsigned int *) get_property(sound, "sub-frame", NULL);
@@ -1019,7 +1023,8 @@
 		}
 	}
 	if (chip->pdev == NULL)
-		printk(KERN_WARNING "snd-powermac: can't locate macio PCI device !\n");
+		printk(KERN_WARNING "snd-powermac: can't locate macio PCI"
+		       " device !\n");
 
 	detect_byte_swap(chip);
 
@@ -1027,7 +1032,8 @@
 	   are available */
 	prop = (unsigned int *) get_property(sound, "sample-rates", &l);
 	if (! prop)
-		prop = (unsigned int *) get_property(sound, "output-frame-rates", &l);
+		prop = (unsigned int *) get_property(sound,
+						     "output-frame-rates", &l);
 	if (prop) {
 		int i;
 		chip->freqs_ok = 0;
@@ -1054,7 +1060,8 @@
 /*
  * exported - boolean info callbacks for ease of programming
  */
-int snd_pmac_boolean_stereo_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+int snd_pmac_boolean_stereo_info(snd_kcontrol_t *kcontrol,
+				 snd_ctl_elem_info_t *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	uinfo->count = 2;
@@ -1063,7 +1070,8 @@
 	return 0;
 }
 
-int snd_pmac_boolean_mono_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+int snd_pmac_boolean_mono_info(snd_kcontrol_t *kcontrol,
+			       snd_ctl_elem_info_t *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	uinfo->count = 1;


