Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271402AbTGXB2G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 21:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271403AbTGXB2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 21:28:06 -0400
Received: from mta11.srv.hcvlny.cv.net ([167.206.5.46]:9141 "EHLO
	mta11.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S271402AbTGXB2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 21:28:01 -0400
Date: Wed, 23 Jul 2003 21:41:45 -0400
From: Josef Jeff Sipek <jeffpc@optonline.net>
Subject: [PATCH][2.6] (needs testing) Fix
 "sleeping function called from illegal context" from Bugzilla bug # 641
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <200307232141.45221.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent this in a while ago, but nobody said anything...Here it is again:

Debug: sleeping function called from illegal context at include/asm/semaphore.h:
119
Call Trace:
 [<c011dadf>] __might_sleep+0x5f/0x80
 [<e325c3f6>] +0x40a/0x574 [snd_emux_synth]
 [<e3258b4a>] lock_preset+0x1ca/0x290 [snd_emux_synth]
 [<e325c3f6>] +0x40a/0x574 [snd_emux_synth]
 [<e325aaaf>] snd_soundfont_search_zone+0x2f/0xf0 [snd_emux_synth]
 [<e0911f10>] snd_timer_s_function+0x0/0x20 [snd_timer]
 [<e3256830>] get_zone+0x70/0x90 [snd_emux_synth]
 [<e3254632>] snd_emux_note_on+0xf2/0x4a0 [snd_emux_synth]
 [<c010c263>] do_IRQ+0x233/0x370
 [<e325eec0>] emux_ops+0x0/0x20 [snd_emux_synth]
 [<e09090f6>] +0xf6/0x3c0 [snd_seq_midi_emul]
 [<c014b0eb>] check_poison_obj+0x3b/0x190
 [<c02aefb4>] kfree_skbmem+0x64/0x70
 [<e3257293>] snd_emux_event_input+0x63/0xa0 [snd_emux_synth]
 [<e325eec0>] emux_ops+0x0/0x20 [snd_emux_synth]
 [<e3241657>] snd_seq_deliver_single_event+0x147/0x1b0 [snd_seq]
 [<e3241965>] snd_seq_deliver_event+0x45/0xb0 [snd_seq]
 [<e3241a9a>] snd_seq_dispatch_event+0xca/0x1b0 [snd_seq]
 [<c011165a>] do_gettimeofday+0x1a/0x90
 [<e3247335>] snd_seq_check_queue+0x245/0x500 [snd_seq]
 [<c016b19b>] do_sync_read+0x8b/0xc0
 [<e09113fd>] snd_timer_interrupt+0x48d/0x610 [snd_timer]
 [<c02ab029>] sock_poll+0x29/0x40

Patch against 2.6.0-test1:

diff -Naur -x dontdiff linux-2.6.0-test1-vanilla/sound/synth/emux/soundfont.c linux-2.6.0-test1-eva/sound/synth/emux/soundfont.c
--- linux-2.6.0-test1-vanilla/sound/synth/emux/soundfont.c	2003-07-13 23:36:41.000000000 -0400
+++ linux-2.6.0-test1-eva/sound/synth/emux/soundfont.c	2003-07-18 04:31:36.000000000 -0400
@@ -66,15 +66,11 @@
 static int
 lock_preset(snd_sf_list_t *sflist, int nonblock)
 {
-	unsigned long flags;
-	spin_lock_irqsave(&sflist->lock, flags);
-	if (sflist->sf_locked && nonblock) {
-		spin_unlock_irqrestore(&sflist->lock, flags);
-		return -EBUSY;
-	}
-	spin_unlock_irqrestore(&sflist->lock, flags);
-	down(&sflist->presets_mutex);
-	sflist->sf_locked = 1;
+	if (nonblock) {
+		if (down_trylock(&sflist->presets_mutex))
+			return -EBUSY;
+	} else 
+		down(&sflist->presets_mutex);
 	return 0;
 }
 
@@ -86,7 +82,6 @@
 unlock_preset(snd_sf_list_t *sflist)
 {
 	up(&sflist->presets_mutex);
-	sflist->sf_locked = 0;
 }
 
 
@@ -1356,7 +1351,6 @@
 
 	init_MUTEX(&sflist->presets_mutex);
 	spin_lock_init(&sflist->lock);
-	sflist->sf_locked = 0;
 	sflist->memhdr = hdr;
 
 	if (callback)
diff -Naur -x dontdiff linux-2.6.0-test1-vanilla/include/sound/soundfont.h linux-2.6.0-test1-eva/include/sound/soundfont.h
--- linux-2.6.0-test1-vanilla/include/sound/soundfont.h	2003-07-13 23:39:23.000000000 -0400
+++ linux-2.6.0-test1-eva/include/sound/soundfont.h	2003-07-18 04:35:12.000000000 -0400
@@ -95,7 +95,6 @@
 	int zone_locked;	/* locked time for zone */
 	int sample_locked;	/* locked time for sample */
 	snd_sf_callback_t callback;	/* callback functions */
-	char sf_locked;		/* font lock flag */
 	struct semaphore presets_mutex;
 	spinlock_t lock;
 	snd_util_memhdr_t *memhdr;


Bug: http://bugme.osdl.org/show_bug.cgi?id=641

Josef "Jeff" Sipek

-- 
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.

