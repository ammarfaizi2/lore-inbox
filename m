Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268577AbUIGTqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268577AbUIGTqv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 15:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268588AbUIGTW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 15:22:28 -0400
Received: from mail.dif.dk ([193.138.115.101]:8082 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S268506AbUIGTTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:19:01 -0400
Date: Tue, 7 Sep 2004 21:25:12 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>,
       Frank van de Pol <fvdpol@coil.demon.nl>
Subject: [PATCH] don't ignore copy_to_user return value in
 sound/core/seq/seq_clientmgr.c::snd_seq_read
Message-ID: <Pine.LNX.4.61.0409072117240.2707@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a patch that ensures the copy_to_user() return value gets checked 
and acted upon if it is != 0 (that is, if we failed to copy all data) in 
snd_seq_read().

Apart from being the right thing to do it also nicely gets rid of this 
warning with gcc 3.4.0 : 
sound/core/seq/seq_clientmgr.c: In function `snd_seq_read':
sound/core/seq/seq_clientmgr.c:423: warning: ignoring return value of `copy_to_user', declared with attribute warn_unused_result


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.9-rc1-bk13-orig/sound/core/seq/seq_clientmgr.c linux-2.6.9-rc1-bk13/sound/core/seq/seq_clientmgr.c
--- linux-2.6.9-rc1-bk13-orig/sound/core/seq/seq_clientmgr.c	2004-09-06 21:13:20.000000000 +0200
+++ linux-2.6.9-rc1-bk13/sound/core/seq/seq_clientmgr.c	2004-09-07 21:16:27.000000000 +0200
@@ -420,7 +420,10 @@ static ssize_t snd_seq_read(struct file 
 			count -= err;
 			buf += err;
 		} else {
-			copy_to_user(buf, &cell->event, sizeof(snd_seq_event_t));
+			if (copy_to_user(buf, &cell->event, sizeof(snd_seq_event_t))) {
+				err = -EFAULT;
+				break;
+			}
 			count -= sizeof(snd_seq_event_t);
 			buf += sizeof(snd_seq_event_t);
 		}


