Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315442AbSGAHUu>; Mon, 1 Jul 2002 03:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315439AbSGAHUt>; Mon, 1 Jul 2002 03:20:49 -0400
Received: from macker.loria.fr ([152.81.1.70]:38284 "EHLO macker.loria.fr")
	by vger.kernel.org with ESMTP id <S315438AbSGAHUr>;
	Mon, 1 Jul 2002 03:20:47 -0400
X-Amavix: Anti-spam check done by SpamAssassin
X-Amavix: Anti-virus check done by McAfee
X-Amavix: Scanned by Amavix
Date: Sun, 30 Jun 2002 23:49:19 +0200 (CEST)
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
X-X-Sender: samy@localhost.localdomain
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
To: zab@zabbo.net, <linux-sound@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.18 linux/drivers/maestro.c dev_audio flaw
Message-ID: <Pine.LNX.4.44.0206302335280.592-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

It seems that the value of ess->dev_audio is wrongly interpreted. Here's
its only initialization :
(maestro.c:3473)

		if ((s->dev_audio = register_sound_dsp(&ess_audio_fops, -1)) < 0)

register_sound_dsp can return -ENOMEM for instance, so checking whether < 0
is mandatory. However, in (almost) the rest of the file, only == -1 is
tested, so here's a patch.

Furthermore, printing some error message may sometimes be handy, such as when
-ENOENT is returned (no hole was found for the driver), just to understand why
the device was probed, but isn't actually accessible.

Best regards,

Samuel Thibault

diff -urN linux-2.4.18-cor/drivers/sound/maestro.c linux-2.4.18-cor2/drivers/sound/maestro.c
--- linux-2.4.18-cor/drivers/sound/maestro.c	Sun Jun 30 22:02:11 2002
+++ linux-2.4.18-cor2/drivers/sound/maestro.c	Sun Jun 30 23:34:26 2002
@@ -1963,7 +1963,7 @@
 	for(i=0;i<NR_DSPS;i++)
 	{
 		s=&c->channels[i];
-		if(s->dev_audio == -1)
+		if(s->dev_audio < 0)
 			break;
 		spin_lock(&s->lock);
 		ess_update_ptr(s);
@@ -2917,7 +2917,7 @@
 	for(i=0;i<NR_DSPS;i++) {
 		struct ess_state *ess = &s->card->channels[i];

-		if(ess->dev_audio == -1)
+		if(ess->dev_audio < 0)
 			continue;

 		ess->dma_dac.ready = s->dma_dac.mapped = 0;
@@ -3480,7 +3480,7 @@
 	for(;i<NR_DSPS;i++)
 	{
 		struct ess_state *s=&card->channels[i];
-		s->dev_audio = -1;
+		s->dev_audio = -ENODEV;
 	}

 	ess = &card->channels[0];
@@ -3541,7 +3541,7 @@
 		for(i=0;i<NR_DSPS;i++)
 		{
 			struct ess_state *s = &card->channels[i];
-			if(s->dev_audio != -1)
+			if(s->dev_audio >= 0)
 				unregister_sound_dsp(s->dev_audio);
 		}
 		release_region(card->iobase, 256);
@@ -3586,7 +3586,7 @@
 	for(i=0;i<NR_DSPS;i++)
 	{
 		struct ess_state *ess = &card->channels[i];
-		if(ess->dev_audio != -1)
+		if(ess->dev_audio >= 0)
 			unregister_sound_dsp(ess->dev_audio);
 	}
 	/* Goodbye, Mr. Bond. */
@@ -3690,7 +3690,7 @@
 	for(i=0;i<NR_DSPS;i++) {
 		struct ess_state *s = &card->channels[i];

-		if(s->dev_audio == -1)
+		if(s->dev_audio < 0)
 			continue;

 		M_printk("maestro: stopping apus for device %d\n",i);
@@ -3743,7 +3743,7 @@
 		struct ess_state *s = &card->channels[i];
 		int chan,reg;

-		if(s->dev_audio == -1)
+		if(s->dev_audio < 0)
 			continue;

 		for(chan = 0 ; chan < 6 ; chan++) {



