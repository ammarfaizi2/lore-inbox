Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbUF3UDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUF3UDK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 16:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbUF3UCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 16:02:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2990 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262109AbUF3UAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 16:00:55 -0400
Date: Wed, 30 Jun 2004 15:56:06 -0400
From: John Linville <linville@redhat.com>
Message-Id: <200406301956.i5UJu6mp007649@savage.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: i810_audio MMIO patch
Cc: jgarzik@pobox.com, herbert@gondor.apana.org.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached is a second patch to account for (most of) Herbert Xu's
comments.

I have left-out the part about changing state->card to a
local variable where it is used a lot.  Unfortunately, that usage is
somewhat pervasive and I would prefer to make those changes in a separate
patch -- after I have had a chance to do some testing.

If you'd prefer one patch to account for the original plus these
changes, let me know and I'll be happy to provide it.

John

diff -urNp linux-2.4.21.orig/drivers/sound/i810_audio.c linux-2.4.21/drivers/sound/i810_audio.c
--- linux-2.4.21.orig/drivers/sound/i810_audio.c	2004-06-30 15:35:09.034185181 -0400
+++ linux-2.4.21/drivers/sound/i810_audio.c	2004-06-30 13:06:28.000000000 -0400
@@ -455,8 +455,10 @@ struct i810_card {
 #define I810_IOREAD(size, type, card, off)				\
 ({									\
 	type val;							\
-	if (card->use_mmio) val=read##size(card->iobase_mmio+off);	\
-	else val=in##size(card->iobase+off);				\
+	if (card->use_mmio)						\
+		val=read##size(card->iobase_mmio+off);			\
+	else								\
+		val=in##size(card->iobase+off);				\
 	val;								\
 })
 
@@ -466,8 +468,10 @@ struct i810_card {
 
 #define I810_IOWRITE(size, val, card, off)				\
 ({									\
-	if (card->use_mmio) write##size(val, card->iobase_mmio+off);	\
-	else out##size(val, card->iobase+off);				\
+	if (card->use_mmio)						\
+		write##size(val, card->iobase_mmio+off);		\
+	else								\
+		out##size(val, card->iobase+off);			\
 })
 
 #define I810_IOWRITEL(val, card, off)	I810_IOWRITE(l, val, card, off)
@@ -2818,9 +2822,11 @@ static int i810_ac97_power_up_bus(struct
 	 *	See if the primary codec comes ready. This must happen
 	 *	before we start doing DMA stuff
 	 */	
-	/* see i810_ac97_init for the next 7 lines (jsaw) */
-	if (card->use_mmio) readw(card->ac97base_mmio);
-	else inw(card->ac97base);
+	/* see i810_ac97_init for the next 10 lines (jsaw) */
+	if (card->use_mmio)
+		readw(card->ac97base_mmio);
+	else
+		inw(card->ac97base);
 	if (ich_use_mmio(card)) {
 		primary_codec_id = (int) readl(card->iobase_mmio + SDM) & 0x3;
 		printk(KERN_INFO "i810_audio: Primary codec has ID %d\n",
@@ -2838,8 +2844,10 @@ static int i810_ac97_power_up_bus(struct
 		else 
 			printk("no response.\n");
 	}
-	if (card->use_mmio) readw(card->ac97base_mmio);
-	else inw(card->ac97base);
+	if (card->use_mmio)
+		readw(card->ac97base_mmio);
+	else
+		inw(card->ac97base);
 	return 1;
 }
 
@@ -2883,8 +2891,10 @@ static int __devinit i810_ac97_init(stru
 	for (num_ac97 = 0; num_ac97 < nr_ac97_max; num_ac97++) {
 		/* codec reset */
 		printk(KERN_INFO "i810_audio: Resetting connection %d\n", num_ac97);
-		if (card->use_mmio) readw(card->ac97base_mmio + 0x80*num_ac97);
-		else inw(card->ac97base + 0x80*num_ac97);
+		if (card->use_mmio)
+			readw(card->ac97base_mmio + 0x80*num_ac97);
+		else
+			inw(card->ac97base + 0x80*num_ac97);
 
 		/* If we have the SDATA_IN Map Register, as on ICH4, we
 		   do not loop thru all possible codec IDs but thru all 
@@ -3162,7 +3172,7 @@ static int __devinit i810_probe(struct p
 		}
 	}
 
-	if (!(card->use_mmio) && !(card->iobase)) {
+	if (!(card->use_mmio) && (!(card->iobase) || !(card->ac97base))) {
 		printk(KERN_ERR "i810_audio: No I/O resources available.\n");
 		goto out_mem;
 	}
