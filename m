Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271323AbTGRJSd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 05:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271386AbTGRJSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 05:18:33 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.31]:39296 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S271323AbTGRJSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:18:31 -0400
Date: Fri, 18 Jul 2003 05:33:23 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: [PATCH][2.6] Fix "sleeping function called from illegal context"
 from Bugzilla bug # 641
In-reply-to: <200307180510.02780.jeffpc@optonline.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <200307180533.23210.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.2
References: <200307180510.02780.jeffpc@optonline.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I'll get it right this time... Sorry for the extra traffic.

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


Josef "Jeff" Sipek

-- 
FORTUNE PROVIDES QUESTIONS FOR THE GREAT ANSWERS: #19
A:      To be or not to be.
Q:      What is the square root of 4b^2?

