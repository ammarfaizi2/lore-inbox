Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265687AbTIEUxS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 16:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265695AbTIEUxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 16:53:18 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:23611 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S265687AbTIEUxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 16:53:14 -0400
Date: Fri, 5 Sep 2003 22:48:25 +0200
Message-Id: <200309052048.h85KmPLr000867@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dmasound core fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmasound core fixes from Christoph Hellwig:
  - Some exported symbols are declared __init - in the modular case this is
    freed before the other modules can call it..
  - dmasound.lock is initialized to late, do it at compile time

--- linux-2.6.0-test4/sound/oss/dmasound/dmasound_core.c	Sun Aug 24 09:50:28 2003
+++ linux-m68k-2.6.0-test4/sound/oss/dmasound/dmasound_core.c	Wed Aug 27 13:52:09 2003
@@ -226,7 +226,7 @@
      *  Mid level stuff
      */
 
-struct sound_settings dmasound;
+struct sound_settings dmasound = { .lock = SPIN_LOCK_UNLOCKED };
 
 static inline void sound_silence(void)
 {
@@ -374,7 +374,7 @@
 	.release	= mixer_release,
 };
 
-static void __init mixer_init(void)
+static void mixer_init(void)
 {
 #ifndef MODULE
 	int mixer_unit;
@@ -1339,7 +1339,7 @@
 #endif
 };
 
-static int __init sq_init(void)
+static int sq_init(void)
 {
 #ifndef MODULE
 	int sq_unit;
@@ -1349,7 +1349,6 @@
 	if (dmasound.mach.record)
 		sq_fops.read = sq_read ;
 #endif
-	spin_lock_init(&dmasound.lock);
 	sq_unit = register_sound_dsp(&sq_fops, -1);
 	if (sq_unit < 0) {
 		printk(KERN_ERR "dmasound_core: couldn't register fops\n") ;
@@ -1557,7 +1556,7 @@
 	.release	= state_release,
 };
 
-static int __init state_init(void)
+static int state_init(void)
 {
 #ifndef MODULE
 	int state_unit;
@@ -1576,7 +1575,7 @@
      *  This function is called by _one_ chipset-specific driver
      */
 
-int __init dmasound_init(void)
+int dmasound_init(void)
 {
 	int res ;
 #ifdef MODULE
@@ -1647,7 +1646,7 @@
 
 #else /* !MODULE */
 
-static int __init dmasound_setup(char *str)
+static int dmasound_setup(char *str)
 {
 	int ints[6], size;
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
