Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVDIBPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVDIBPq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 21:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVDIBOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 21:14:32 -0400
Received: from mail.dif.dk ([193.138.115.101]:63119 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261231AbVDIBMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 21:12:34 -0400
Date: Sat, 9 Apr 2005 03:15:07 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: LKML <linux-kernel@vger.kernel.org>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>,
       emu10k1-devel@lists.sourceforge.net
Subject: [PATCH] sound/oss/emu10k1: fix up warning: ignoring return value of
 `__copy_to_user'
Message-ID: <Pine.LNX.4.62.0504090304080.2455@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's an attempts at fixing these warnings 
sound/oss/emu10k1/cardwi.c:310: warning: ignoring return value of `__copy_to_user', declared with attribute warn_unused_result
sound/oss/emu10k1/cardwi.c:319: warning: ignoring return value of `__copy_to_user', declared with attribute warn_unused_result
in a sane way.

If this looks OK, then please apply, if not then comments are very 
welcome.

(please keep me on CC)


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

diff -upr linux-2.6.12-rc2-mm2-orig/sound/oss/emu10k1/audio.c linux-2.6.12-rc2-mm2/sound/oss/emu10k1/audio.c
--- linux-2.6.12-rc2-mm2-orig/sound/oss/emu10k1/audio.c	2005-03-02 08:37:48.000000000 +0100
+++ linux-2.6.12-rc2-mm2/sound/oss/emu10k1/audio.c	2005-04-09 03:02:40.000000000 +0200
@@ -110,13 +110,19 @@ static ssize_t emu10k1_audio_read(struct
 
 		if ((bytestocopy >= wiinst->buffer.fragment_size)
 		    || (bytestocopy >= count)) {
+			unsigned long residue;
 			bytestocopy = min_t(u32, bytestocopy, count);
 
-			emu10k1_wavein_xferdata(wiinst, (u8 __user *)buffer, &bytestocopy);
-
-			count -= bytestocopy;
-			buffer += bytestocopy;
-			ret += bytestocopy;
+			if ((residue = emu10k1_wavein_xferdata(wiinst, (u8 __user *)buffer, &bytestocopy))) {
+				residue = bytestocopy - residue;
+				count -= residue;
+				buffer += residue;
+				ret += residue;
+			} else {
+				count -= bytestocopy;
+				buffer += bytestocopy;
+				ret += bytestocopy;
+			}
 		}
 
 		if (count > 0) {
diff -upr linux-2.6.12-rc2-mm2-orig/sound/oss/emu10k1/cardwi.c linux-2.6.12-rc2-mm2/sound/oss/emu10k1/cardwi.c
--- linux-2.6.12-rc2-mm2-orig/sound/oss/emu10k1/cardwi.c	2005-03-02 08:38:12.000000000 +0100
+++ linux-2.6.12-rc2-mm2/sound/oss/emu10k1/cardwi.c	2005-04-09 03:02:06.000000000 +0200
@@ -304,10 +304,12 @@ void emu10k1_wavein_getxfersize(struct w
 	}
 }
 
-static void copy_block(u8 __user *dst, u8 * src, u32 str, u32 len, u8 cov)
+static unsigned long copy_block(u8 __user *dst, u8 * src, u32 str, u32 len, u8 cov)
 {
+	unsigned long ret = 0;
+
 	if (cov == 1)
-		__copy_to_user(dst, src + str, len);
+		return __copy_to_user(dst, src + str, len);
 	else {
 		u8 byte;
 		u32 i;
@@ -316,22 +318,24 @@ static void copy_block(u8 __user *dst, u
 
 		for (i = 0; i < len; i++) {
 			byte = src[2 * i] ^ 0x80;
-			__copy_to_user(dst + i, &byte, 1);
+			ret += __copy_to_user(dst + i, &byte, 1);
 		}
 	}
+
+	return ret;
 }
 
-void emu10k1_wavein_xferdata(struct wiinst *wiinst, u8 __user *data, u32 * size)
+unsigned long emu10k1_wavein_xferdata(struct wiinst *wiinst, u8 __user *data, u32 * size)
 {
 	struct wavein_buffer *buffer = &wiinst->buffer;
 	u32 sizetocopy, sizetocopy_now, start;
-	unsigned long flags;
+	unsigned long flags, ret = 0;
 
 	sizetocopy = min_t(u32, buffer->size, *size);
 	*size = sizetocopy;
 
 	if (!sizetocopy)
-		return;
+		return 0;
 
 	spin_lock_irqsave(&wiinst->lock, flags);
 	start = buffer->pos;
@@ -345,11 +349,12 @@ void emu10k1_wavein_xferdata(struct wiin
 	if (sizetocopy > sizetocopy_now) {
 		sizetocopy -= sizetocopy_now;
 
-		copy_block(data, buffer->addr, start, sizetocopy_now, buffer->cov);
-		copy_block(data + sizetocopy_now, buffer->addr, 0, sizetocopy, buffer->cov);
+		ret += copy_block(data, buffer->addr, start, sizetocopy_now, buffer->cov);
+		ret += copy_block(data + sizetocopy_now, buffer->addr, 0, sizetocopy, buffer->cov);
 	} else {
-		copy_block(data, buffer->addr, start, sizetocopy, buffer->cov);
+		ret += copy_block(data, buffer->addr, start, sizetocopy, buffer->cov);
 	}
+	return ret;
 }
 
 void emu10k1_wavein_update(struct emu10k1_card *card, struct wiinst *wiinst)
diff -upr linux-2.6.12-rc2-mm2-orig/sound/oss/emu10k1/cardwi.h linux-2.6.12-rc2-mm2/sound/oss/emu10k1/cardwi.h
--- linux-2.6.12-rc2-mm2-orig/sound/oss/emu10k1/cardwi.h	2005-03-02 08:38:38.000000000 +0100
+++ linux-2.6.12-rc2-mm2/sound/oss/emu10k1/cardwi.h	2005-04-09 03:03:20.000000000 +0200
@@ -83,7 +83,7 @@ void emu10k1_wavein_close(struct emu10k1
 void emu10k1_wavein_start(struct emu10k1_wavedevice *);
 void emu10k1_wavein_stop(struct emu10k1_wavedevice *);
 void emu10k1_wavein_getxfersize(struct wiinst *, u32 *);
-void emu10k1_wavein_xferdata(struct wiinst *, u8 __user *, u32 *);
+unsigned long emu10k1_wavein_xferdata(struct wiinst *, u8 __user *, u32 *);
 int emu10k1_wavein_setformat(struct emu10k1_wavedevice *, struct wave_format *);
 void emu10k1_wavein_update(struct emu10k1_card *, struct wiinst *);
 



