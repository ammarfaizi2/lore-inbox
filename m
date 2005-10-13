Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbVJMCMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbVJMCMZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 22:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbVJMCMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 22:12:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:45198 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964859AbVJMCMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 22:12:07 -0400
Date: Wed, 12 Oct 2005 19:10:56 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Cc: linux-kernel@vger.kernel.org
Subject: [patch 6/8] input: move the input class devices under their new input_dev devices
Message-ID: <20051013021056.GG31732@kroah.com>
References: <20051013014147.235668000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="input-class_device-move.patch"
In-Reply-To: <20051013020844.GA31732@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/input/evdev.c    |    6 +++---
 drivers/input/joydev.c   |    6 +++---
 drivers/input/mousedev.c |   10 +++++-----
 drivers/input/tsdev.c    |    6 +++---
 4 files changed, 14 insertions(+), 14 deletions(-)

--- gregkh-2.6.orig/drivers/input/mousedev.c
+++ gregkh-2.6/drivers/input/mousedev.c
@@ -648,9 +648,9 @@ static struct input_handle *mousedev_con
 
 	mousedev_table[minor] = mousedev;
 
-	class_device_create(input_class, NULL,
+	class_device_create(&input_dev_class, &dev->cdev,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
-			dev->dev, "mouse%d", minor);
+			dev->cdev.dev, "mouse%d", minor);
 
 	return &mousedev->handle;
 }
@@ -660,7 +660,7 @@ static void mousedev_disconnect(struct i
 	struct mousedev *mousedev = handle->private;
 	struct mousedev_list *list;
 
-	class_device_destroy(input_class,
+	class_device_destroy(&input_dev_class,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
 	mousedev->exist = 0;
 
@@ -734,7 +734,7 @@ static int __init mousedev_init(void)
 	mousedev_mix.exist = 1;
 	mousedev_mix.minor = MOUSEDEV_MIX;
 
-	class_device_create(input_class, NULL,
+	class_device_create(&input_dev_class, NULL,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX), NULL, "mice");
 
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
@@ -753,7 +753,7 @@ static void __exit mousedev_exit(void)
 	if (psaux_registered)
 		misc_deregister(&psaux_mouse);
 #endif
-	class_device_destroy(input_class,
+	class_device_destroy(&input_dev_class,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX));
 	input_unregister_handler(&mousedev_handler);
 }
--- gregkh-2.6.orig/drivers/input/evdev.c
+++ gregkh-2.6/drivers/input/evdev.c
@@ -686,9 +686,9 @@ static struct input_handle *evdev_connec
 
 	evdev_table[minor] = evdev;
 
-	class_device_create(input_class, NULL,
+	class_device_create(&input_dev_class, &dev->cdev,
 			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
-			dev->dev, "event%d", minor);
+			dev->cdev.dev, "event%d", minor);
 
 	return &evdev->handle;
 }
@@ -698,7 +698,7 @@ static void evdev_disconnect(struct inpu
 	struct evdev *evdev = handle->private;
 	struct evdev_list *list;
 
-	class_device_destroy(input_class,
+	class_device_destroy(&input_dev_class,
 			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
 	evdev->exist = 0;
 
--- gregkh-2.6.orig/drivers/input/joydev.c
+++ gregkh-2.6/drivers/input/joydev.c
@@ -513,9 +513,9 @@ static struct input_handle *joydev_conne
 
 	joydev_table[minor] = joydev;
 
-	class_device_create(input_class, NULL,
+	class_device_create(&input_dev_class, &dev->cdev,
 			MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
-			dev->dev, "js%d", minor);
+			dev->cdev.dev, "js%d", minor);
 
 	return &joydev->handle;
 }
@@ -525,7 +525,7 @@ static void joydev_disconnect(struct inp
 	struct joydev *joydev = handle->private;
 	struct joydev_list *list;
 
-	class_device_destroy(input_class, MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
+	class_device_destroy(&input_dev_class, MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
 	joydev->exist = 0;
 
 	if (joydev->open) {
--- gregkh-2.6.orig/drivers/input/tsdev.c
+++ gregkh-2.6/drivers/input/tsdev.c
@@ -409,9 +409,9 @@ static struct input_handle *tsdev_connec
 
 	tsdev_table[minor] = tsdev;
 
-	class_device_create(input_class, NULL,
+	class_device_create(&input_dev_class, &dev->cdev,
 			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
-			dev->dev, "ts%d", minor);
+			dev->cdev.dev, "ts%d", minor);
 
 	return &tsdev->handle;
 }
@@ -421,7 +421,7 @@ static void tsdev_disconnect(struct inpu
 	struct tsdev *tsdev = handle->private;
 	struct tsdev_list *list;
 
-	class_device_destroy(input_class,
+	class_device_destroy(&input_dev_class,
 			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
 	tsdev->exist = 0;
 

--
