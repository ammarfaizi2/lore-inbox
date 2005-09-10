Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbVIJWeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVIJWeR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVIJWeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:34:15 -0400
Received: from styx.suse.cz ([82.119.242.94]:31908 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932352AbVIJWdv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:51 -0400
Subject: [PATCH 14/26] atkbd - handle keyboards generating scancode 0x7f
In-Reply-To: <11263916532605@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:13 +0200
Message-Id: <1126391653526@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: atkbd - handle keyboards generating scancode 0x7f
From: Vojtech Pavlik <vojtech@suse.cz>
Date: 1125897101 -0500

Extend bat_xl handling to do err_xl handling, so that
keyboards using 0x7f scancode for regular keys can work.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/input/keyboard/atkbd.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

903b126bffb77dc313b7c2971880df408bf41a9e
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -208,6 +208,7 @@ struct atkbd {
 	unsigned char resend;
 	unsigned char release;
 	unsigned char bat_xl;
+	unsigned char err_xl;
 	unsigned int last;
 	unsigned long time;
 };
@@ -296,15 +297,18 @@ static irqreturn_t atkbd_interrupt(struc
 		if (atkbd->emul ||
 		    !(code == ATKBD_RET_EMUL0 || code == ATKBD_RET_EMUL1 ||
 		      code == ATKBD_RET_HANGUEL || code == ATKBD_RET_HANJA ||
-		      code == ATKBD_RET_ERR ||
+		     (code == ATKBD_RET_ERR && !atkbd->err_xl) ||
 	             (code == ATKBD_RET_BAT && !atkbd->bat_xl))) {
 			atkbd->release = code >> 7;
 			code &= 0x7f;
 		}
 
-		if (!atkbd->emul &&
-		     (code & 0x7f) == (ATKBD_RET_BAT & 0x7f))
+		if (!atkbd->emul) {
+		     if ((code & 0x7f) == (ATKBD_RET_BAT & 0x7f))
 			atkbd->bat_xl = !atkbd->release;
+		     if ((code & 0x7f) == (ATKBD_RET_ERR & 0x7f))
+			atkbd->err_xl = !atkbd->release;
+		}
 	}
 
 	switch (code) {

