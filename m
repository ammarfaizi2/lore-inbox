Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVBGMTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVBGMTr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 07:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVBGMTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 07:19:47 -0500
Received: from styx.suse.cz ([82.119.242.94]:37006 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261405AbVBGMTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 07:19:41 -0500
Date: Mon, 7 Feb 2005 13:20:33 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.de>, David Fries <dfries@mail.win.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux joydev joystick disconnect patch 2.6.11-rc2
Message-ID: <20050207122033.GA16959@ucw.cz>
References: <20041123212813.GA3196@spacedout.fries.net> <d120d500050201072413193c62@mail.gmail.com> <20050206131241.GA19564@ucw.cz> <200502062021.13726.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200502062021.13726.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 08:21:13PM -0500, Dmitry Torokhov wrote:
> > > Opening braces should go on the same line as the statement (if (...) {).
> >  
> > How about this patch?
> 
> Looks fine now. Hmm, wait a sec... Don't we also need kill_fasync calls in
> disconnect routines as well?

This should do it:


ChangeSet@1.2130, 2005-02-07 13:19:59+01:00, vojtech@suse.cz
  input: Do a kill_fasync() in input handlers on device disconnect
         to notify a client using poll() that the device is gone.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 evdev.c    |    3 +++
 joydev.c   |    3 +++
 mousedev.c |    3 +++
 tsdev.c    |    3 +++
 4 files changed, 12 insertions(+)


diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	2005-02-07 13:20:15 +01:00
+++ b/drivers/input/evdev.c	2005-02-07 13:20:15 +01:00
@@ -440,6 +440,7 @@
 static void evdev_disconnect(struct input_handle *handle)
 {
 	struct evdev *evdev = handle->private;
+	struct evdev_list *list;
 
 	class_simple_device_remove(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
 	devfs_remove("input/event%d", evdev->minor);
@@ -448,6 +449,8 @@
 	if (evdev->open) {
 		input_close_device(handle);
 		wake_up_interruptible(&evdev->wait);
+		list_for_each_entry(list, &evdev->list, node)
+			kill_fasync(&list->fasync, SIGIO, POLLHUP | POLLERR);
 	} else
 		evdev_free(evdev);
 }
diff -Nru a/drivers/input/joydev.c b/drivers/input/joydev.c
--- a/drivers/input/joydev.c	2005-02-07 13:20:15 +01:00
+++ b/drivers/input/joydev.c	2005-02-07 13:20:15 +01:00
@@ -462,6 +462,7 @@
 static void joydev_disconnect(struct input_handle *handle)
 {
 	struct joydev *joydev = handle->private;
+	struct joydev_list *list;
 
 	class_simple_device_remove(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
 	devfs_remove("input/js%d", joydev->minor);
@@ -470,6 +471,8 @@
 	if (joydev->open) {
 		input_close_device(handle);
 		wake_up_interruptible(&joydev->wait);
+		list_for_each_entry(list, &joydev->list, node)
+			kill_fasync(&list->fasync, SIGIO, POLLHUP | POLLERR);
 	} else
 		joydev_free(joydev);
 }
diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	2005-02-07 13:20:15 +01:00
+++ b/drivers/input/mousedev.c	2005-02-07 13:20:15 +01:00
@@ -652,6 +652,7 @@
 static void mousedev_disconnect(struct input_handle *handle)
 {
 	struct mousedev *mousedev = handle->private;
+	struct mousedev_list *list;
 
 	class_simple_device_remove(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
 	devfs_remove("input/mouse%d", mousedev->minor);
@@ -660,6 +661,8 @@
 	if (mousedev->open) {
 		input_close_device(handle);
 		wake_up_interruptible(&mousedev->wait);
+		list_for_each_entry(list, &mousedev->list, node)
+			kill_fasync(&list->fasync, SIGIO, POLLHUP | POLLERR);
 	} else {
 		if (mousedev_mix.open)
 			input_close_device(handle);
diff -Nru a/drivers/input/tsdev.c b/drivers/input/tsdev.c
--- a/drivers/input/tsdev.c	2005-02-07 13:20:15 +01:00
+++ b/drivers/input/tsdev.c	2005-02-07 13:20:15 +01:00
@@ -424,6 +424,7 @@
 static void tsdev_disconnect(struct input_handle *handle)
 {
 	struct tsdev *tsdev = handle->private;
+	struct tsdev_list *list;
 
 	class_simple_device_remove(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
 	devfs_remove("input/ts%d", tsdev->minor);
@@ -433,6 +434,8 @@
 	if (tsdev->open) {
 		input_close_device(handle);
 		wake_up_interruptible(&tsdev->wait);
+		list_for_each_entry(list, &tsdev->list, node)
+			kill_fasync(&list->fasync, SIGIO, POLLHUP | POLLERR);
 	} else
 		tsdev_free(tsdev);
 }

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
