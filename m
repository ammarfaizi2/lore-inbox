Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264010AbSKZFRn>; Tue, 26 Nov 2002 00:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266108AbSKZFRn>; Tue, 26 Nov 2002 00:17:43 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:45767
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264010AbSKZFRm>; Tue, 26 Nov 2002 00:17:42 -0500
Date: Tue, 26 Nov 2002 00:28:23 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jaroslav Kysela <perex@perex.cz>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] bitops for ALSA core/init.c
Message-ID: <Pine.LNX.4.50.0211252356290.1462-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaroslav does this look ok?

Index: linux-2.5.49/sound/core/init.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.49/sound/core/init.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 init.c
--- linux-2.5.49/sound/core/init.c	23 Nov 2002 02:58:10 -0000	1.1.1.1
+++ linux-2.5.49/sound/core/init.c	25 Nov 2002 08:28:31 -0000
@@ -29,7 +29,7 @@
 #include <sound/info.h>

 int snd_cards_count = 0;
-static unsigned int snd_cards_lock = 0;	/* locked for registering/using */
+static unsigned long snd_cards_lock = 0;	/* locked for registering/using */
 snd_card_t *snd_cards[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS-1)] = NULL};
 rwlock_t snd_card_rwlock = RW_LOCK_UNLOCKED;

@@ -62,12 +62,12 @@
 	if (idx < 0) {
 		int idx2;
 		for (idx2 = 0; idx2 < snd_ecards_limit; idx2++)
-			if (!(snd_cards_lock & (1 << idx2))) {
+			if (!test_bit(idx2, &snd_cards_lock)) {
 				idx = idx2;
 				break;
 			}
 	} else if (idx < snd_ecards_limit) {
-		if (snd_cards_lock & (1 << idx))
+		if (test_bit(idx, &snd_cards_lock))
 			idx = -1;	/* invalid */
 	}
 	if (idx < 0 || idx >= snd_ecards_limit) {
@@ -76,7 +76,7 @@
 			snd_printk(KERN_ERR "card %i is out of range (0-%i)\n", idx, snd_ecards_limit-1);
 		goto __error;
 	}
-	snd_cards_lock |= 1 << idx;		/* lock it */
+	set_bit(idx, &snd_cards_lock);		/* lock it */
 	write_unlock(&snd_card_rwlock);
 	card->number = idx;
 	card->module = module;
@@ -146,7 +146,7 @@
 		/* Not fatal error */
 	}
 	write_lock(&snd_card_rwlock);
-	snd_cards_lock &= ~(1 << card->number);
+	clear_bit(card->number, &snd_cards_lock);
 	write_unlock(&snd_card_rwlock);
 	kfree(card);
 	return 0;

-- 
function.linuxpower.ca
