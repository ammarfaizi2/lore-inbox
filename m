Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315943AbSGARpj>; Mon, 1 Jul 2002 13:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSGARpi>; Mon, 1 Jul 2002 13:45:38 -0400
Received: from ra.abo.fi ([130.232.213.1]:57339 "EHLO ra.abo.fi")
	by vger.kernel.org with ESMTP id <S315943AbSGARpe>;
	Mon, 1 Jul 2002 13:45:34 -0400
Date: Mon, 1 Jul 2002 20:47:56 +0300 (EEST)
From: Marcus Alanen <maalanen@ra.abo.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, <t.sailer@alumni.ethz.ch>
cc: linux-kernel@vger.kernel.org
Subject: [patch, 2.4] esssolo1.c doesn't free resources correctly
Message-ID: <Pine.LNX.4.44.0207012032170.26291-100000@tuxedo.abo.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/sound/esssolo1.c, a failed solo1_probe() frees resources in 
the wrong order (Look at the allocation order). Also, the wrong 
unregister_sound_* routines are used.


I don't know if register_sound_special should use unit 10 ("dmfm") 
instead of 15 ("unknown").


Compiles, not tested.

Marcus

===== drivers/sound/esssolo1.c 1.11 vs edited =====
--- 1.11/drivers/sound/esssolo1.c	Fri Mar 29 01:00:15 2002
+++ edited/drivers/sound/esssolo1.c	Mon Jul  1 20:21:52 2002
@@ -2377,9 +2377,9 @@
 	return 0;
 
  err:
-	unregister_sound_dsp(s->dev_dmfm);
+	unregister_sound_special(s->dev_dmfm);
  err_dev4:
-	unregister_sound_dsp(s->dev_midi);
+	unregister_sound_midi(s->dev_midi);
  err_dev3:
 	unregister_sound_mixer(s->dev_mixer);
  err_dev2:
@@ -2390,13 +2390,13 @@
  err_irq:
 	if (s->gameport.io)
 		release_region(s->gameport.io, GAMEPORT_EXTENT);
-	release_region(s->iobase, IOBASE_EXTENT);
+	release_region(s->mpubase, MPUBASE_EXTENT);
  err_region4:
-	release_region(s->sbbase+FMSYNTH_EXTENT, SBBASE_EXTENT-FMSYNTH_EXTENT);
- err_region3:
 	release_region(s->ddmabase, DDMABASE_EXTENT);
+ err_region3:
+	release_region(s->sbbase+FMSYNTH_EXTENT, SBBASE_EXTENT-FMSYNTH_EXTENT);
  err_region2:
-	release_region(s->mpubase, MPUBASE_EXTENT);
+	release_region(s->iobase, IOBASE_EXTENT);
  err_region1:
 	kfree(s);
 	return ret;


