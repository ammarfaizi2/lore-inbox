Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVGYGqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVGYGqD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 02:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVGYFyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:54:52 -0400
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:37566 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261604AbVGYFxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:53:21 -0400
Message-Id: <20050725054533.796185000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:35:12 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 23/24] Input - check keycodesize when adjusting keymaps
Content-Disposition: inline; filename=input-check-keycodesize.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vojtech Pavlik <vojtech@suse.cz>

Input: check keycodesize when adjusting keymaps

When changing key mappings we need to make sure that the new
keycode value can be stored in dev->keycodesize bytes.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/char/keyboard.c |    4 ++--
 drivers/input/evdev.c   |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

Index: work/drivers/char/keyboard.c
===================================================================
--- work.orig/drivers/char/keyboard.c
+++ work/drivers/char/keyboard.c
@@ -198,10 +198,10 @@ int setkeycode(unsigned int scancode, un
 
 	if (scancode >= dev->keycodemax)
 		return -EINVAL;
-	if (keycode > KEY_MAX)
-		return -EINVAL;
 	if (keycode < 0 || keycode > KEY_MAX)
 		return -EINVAL;
+	if (keycode >> (dev->keycodesize * 8))
+		return -EINVAL;
 
 	oldkey = SET_INPUT_KEYCODE(dev, scancode, keycode);
 
Index: work/drivers/input/evdev.c
===================================================================
--- work.orig/drivers/input/evdev.c
+++ work/drivers/input/evdev.c
@@ -320,6 +320,7 @@ static long evdev_ioctl(struct file *fil
 			if (t < 0 || t >= dev->keycodemax || !dev->keycodesize) return -EINVAL;
 			if (get_user(v, ip + 1)) return -EFAULT;
 			if (v < 0 || v > KEY_MAX) return -EINVAL;
+			if (v >> (dev->keycodesize * 8)) return -EINVAL;
 			u = SET_INPUT_KEYCODE(dev, t, v);
 			clear_bit(u, dev->keybit);
 			set_bit(v, dev->keybit);

