Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbTISK21 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 06:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbTISK1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 06:27:16 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:19086 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261491AbTISK0x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 06:26:53 -0400
Subject: [PATCH 8/11] input: Fix the INPUT_KEYCODE macro and its usage
In-Reply-To: <10639672012999@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Sep 2003 12:26:41 +0200
Message-Id: <10639672013970@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1346, 2003-09-19 01:22:06-07:00, vojtech@suse.cz
  input.h, keyboard.c, evdev.c:
    Fix the INPUT_KEYCODE macro and its usage.


 drivers/char/keyboard.c |    2 +-
 drivers/input/evdev.c   |   12 +++++-------
 include/linux/input.h   |    2 +-
 3 files changed, 7 insertions(+), 9 deletions(-)

===================================================================

diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Fri Sep 19 12:16:01 2003
+++ b/drivers/char/keyboard.c	Fri Sep 19 12:16:01 2003
@@ -205,7 +205,7 @@
 	INPUT_KEYCODE(dev, scancode) = keycode;
 
 	for (i = 0; i < dev->keycodemax; i++)
-		if(INPUT_KEYCODE(dev, scancode) == oldkey)
+		if(keycode == oldkey)
 			break;
 	if (i == dev->keycodemax)
 		clear_bit(oldkey, dev->keybit);
diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	Fri Sep 19 12:16:01 2003
+++ b/drivers/input/evdev.c	Fri Sep 19 12:16:01 2003
@@ -208,7 +208,7 @@
 	struct evdev *evdev = list->evdev;
 	struct input_dev *dev = evdev->handle.dev;
 	struct input_absinfo abs;
-	int i, t, u;
+	int i, t, u, v;
 
 	if (!evdev->exist) return -ENODEV;
 
@@ -239,14 +239,12 @@
 		case EVIOCSKEYCODE:
 			if (get_user(t, ((int *) arg) + 0)) return -EFAULT;
 			if (t < 0 || t > dev->keycodemax || !dev->keycodesize) return -EINVAL;
+			if (get_user(v, ((int *) arg) + 1)) return -EFAULT;
 			u = INPUT_KEYCODE(dev, t);
-			if (get_user(INPUT_KEYCODE(dev, t), ((int *) arg) + 1)) return -EFAULT;
-
-			for (i = 0; i < dev->keycodemax; i++)
-				if(INPUT_KEYCODE(dev, t) == u) break;
+			INPUT_KEYCODE(dev, t) = v;
+			for (i = 0; i < dev->keycodemax; i++) if (v == u) break;
 			if (i == dev->keycodemax) clear_bit(u, dev->keybit);
-			set_bit(INPUT_KEYCODE(dev, t), dev->keybit);
-
+			set_bit(v, dev->keybit);
 			return 0;
 
 		case EVIOCSFF:
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Fri Sep 19 12:16:01 2003
+++ b/include/linux/input.h	Fri Sep 19 12:16:01 2003
@@ -751,7 +751,7 @@
 #define LONG(x) ((x)/BITS_PER_LONG)
 
 #define INPUT_KEYCODE(dev, scancode) ((dev->keycodesize == 1) ? ((u8*)dev->keycode)[scancode] : \
-	((dev->keycodesize == 1) ? ((u16*)dev->keycode)[scancode] : (((u32*)dev->keycode)[scancode])))
+	((dev->keycodesize == 2) ? ((u16*)dev->keycode)[scancode] : (((u32*)dev->keycode)[scancode])))
 
 #define init_input_dev(dev)	do { INIT_LIST_HEAD(&((dev)->h_list)); INIT_LIST_HEAD(&((dev)->node)); } while (0)
 

