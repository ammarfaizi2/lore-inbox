Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbVIJWlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVIJWlu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVIJWd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:33:56 -0400
Received: from styx.suse.cz ([82.119.242.94]:22692 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932346AbVIJWdt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:49 -0400
Subject: [PATCH 5/26] fix checking whether new keycode fits size-wise
In-Reply-To: <11263916511448@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:11 +0200
Message-Id: <11263916513180@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: fix checking whether new keycode fits size-wise
From: Ian Campbell <ijc@hellion.org.uk>
Date: 1125816074 -0500

When dev->keycodesize == sizeof(int) the old code produces
incorrect result.

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/char/keyboard.c |    2 +-
 drivers/input/evdev.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

4cee99564db7f65a6f88e4b752da52768cde3802
diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -200,7 +200,7 @@ int setkeycode(unsigned int scancode, un
 		return -EINVAL;
 	if (keycode < 0 || keycode > KEY_MAX)
 		return -EINVAL;
-	if (keycode >> (dev->keycodesize * 8))
+	if (dev->keycodesize < sizeof(keycode) && (keycode >> (dev->keycodesize * 8)))
 		return -EINVAL;
 
 	oldkey = SET_INPUT_KEYCODE(dev, scancode, keycode);
diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -320,7 +320,7 @@ static long evdev_ioctl(struct file *fil
 			if (t < 0 || t >= dev->keycodemax || !dev->keycodesize) return -EINVAL;
 			if (get_user(v, ip + 1)) return -EFAULT;
 			if (v < 0 || v > KEY_MAX) return -EINVAL;
-			if (v >> (dev->keycodesize * 8)) return -EINVAL;
+			if (dev->keycodesize < sizeof(v) && (v >> (dev->keycodesize * 8))) return -EINVAL;
 			u = SET_INPUT_KEYCODE(dev, t, v);
 			clear_bit(u, dev->keybit);
 			set_bit(v, dev->keybit);

