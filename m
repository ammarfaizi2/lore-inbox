Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268248AbUJSBTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268248AbUJSBTP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 21:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268265AbUJSBOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 21:14:43 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:56437 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268249AbUJSBMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 21:12:33 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Fw: X is killed when trying to suspend with USB Mouse plugged in
Date: Mon, 18 Oct 2004 20:12:27 -0500
User-Agent: KMail/1.6.2
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Nils Rennebarth <Nils.Rennebarth@web.de>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0410181842000.16460-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0410181842000.16460-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410182012.27593.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 October 2004 05:48 pm, Alan Stern wrote:
> On Mon, 18 Oct 2004, Andrew Morton wrote:
> 
> > Hi,
> > 
> > When I try to suspend 2.6.9-rc[1-4] when X is runnning and my USB Mouse 
> > is plugged in, I get an Ooops. X is killed and the suspend as well.
> > 
> > Attached is the oops with 2.6.9-rc4
> > The oops comes at the moment, that uhci_hcd is removed. If I do not 
> > remove that module, suspend does work but the laptop hangs hard during 
> > resume.
> > 
> > That only happens if I use /dev/input/mouse1 as input device for the 
> > mouse. With /dev/input/mice I can suspend and resume successfully.
> > 
> > So is using /dev/input/mouse1 something I shouldn't have done in the 
> > first place (came from some experimentation when trying to use the 
> > synaptics driver for my alps touchpad) or does it point to a bug in the 
> > uhci driver? Or a bug in X?
> 
> I don't know about /dev/input/mouse1.  But the oops isn't a bug... it's a 
> weakness in the way Linux implements loadable kernel modules.
> 

Ugh, it is not module implementation weakness, it looks like refcounting
problem in USB. Anyway, I wonder if the following patch will help (hide)
the problem (it is needed anyway so mousedv et all modules can be
unloaded at any time).

In any case I recommend using /dev/input/mice as it is always available,
otherwise your mouse can jump between various /dev/input/mouseX devices.

-- 
Dmitry


===================================================================


ChangeSet@1.1958, 2004-09-30 01:49:20-05:00, dtor_core@ameritech.net
  Input: evdev, joydev, mousedev, tsdev - remove class device and devfs
         entry when hardware driver disconnects instead of waiting for
         the last user to drop off. This way hardware drivers can be
         unloaded at any time.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 evdev.c    |    4 ++--
 joydev.c   |    4 ++--
 mousedev.c |    4 ++--
 tsdev.c    |   10 +++++-----
 4 files changed, 11 insertions(+), 11 deletions(-)


===================================================================



diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	2004-10-09 23:55:27 -05:00
+++ b/drivers/input/evdev.c	2004-10-09 23:55:27 -05:00
@@ -91,8 +91,6 @@
 
 static void evdev_free(struct evdev *evdev)
 {
-	devfs_remove("input/event%d", evdev->minor);
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
 	evdev_table[evdev->minor] = NULL;
 	kfree(evdev);
 }
@@ -441,6 +439,8 @@
 {
 	struct evdev *evdev = handle->private;
 
+	class_simple_device_remove(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
+	devfs_remove("input/event%d", evdev->minor);
 	evdev->exist = 0;
 
 	if (evdev->open) {
diff -Nru a/drivers/input/joydev.c b/drivers/input/joydev.c
--- a/drivers/input/joydev.c	2004-10-09 23:55:27 -05:00
+++ b/drivers/input/joydev.c	2004-10-09 23:55:27 -05:00
@@ -143,9 +143,7 @@
 
 static void joydev_free(struct joydev *joydev)
 {
-	devfs_remove("input/js%d", joydev->minor);
 	joydev_table[joydev->minor] = NULL;
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
 	kfree(joydev);
 }
 
@@ -466,6 +464,8 @@
 {
 	struct joydev *joydev = handle->private;
 
+	class_simple_device_remove(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
+	devfs_remove("input/js%d", joydev->minor);
 	joydev->exist = 0;
 
 	if (joydev->open)
diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	2004-10-09 23:55:27 -05:00
+++ b/drivers/input/mousedev.c	2004-10-09 23:55:27 -05:00
@@ -335,8 +335,6 @@
 
 static void mousedev_free(struct mousedev *mousedev)
 {
-	devfs_remove("input/mouse%d", mousedev->minor);
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
 	mousedev_table[mousedev->minor] = NULL;
 	kfree(mousedev);
 }
@@ -646,6 +644,8 @@
 {
 	struct mousedev *mousedev = handle->private;
 
+	class_simple_device_remove(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
+	devfs_remove("input/mouse%d", mousedev->minor);
 	mousedev->exist = 0;
 
 	if (mousedev->open) {
diff -Nru a/drivers/input/tsdev.c b/drivers/input/tsdev.c
--- a/drivers/input/tsdev.c	2004-10-09 23:55:27 -05:00
+++ b/drivers/input/tsdev.c	2004-10-09 23:55:27 -05:00
@@ -1,7 +1,7 @@
 /*
  * $Id: tsdev.c,v 1.15 2002/04/10 16:50:19 jsimmons Exp $
  *
- *  Copyright (c) 2001 "Crazy" james Simmons 
+ *  Copyright (c) 2001 "Crazy" james Simmons
  *
  *  Compaq touchscreen protocol driver. The protocol emulated by this driver
  *  is obsolete; for new programs use the tslib library which can read directly
@@ -177,8 +177,6 @@
 
 static void tsdev_free(struct tsdev *tsdev)
 {
-	devfs_remove("input/ts%d", tsdev->minor);
-	class_simple_device_remove(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
 	tsdev_table[tsdev->minor] = NULL;
 	kfree(tsdev);
 }
@@ -418,7 +416,7 @@
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/ts%d", minor);
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor + TSDEV_MINORS/2),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/tsraw%d", minor);
-	class_simple_device_add(input_class, 
+	class_simple_device_add(input_class,
 				MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
 				dev->dev, "ts%d", minor);
 
@@ -429,6 +427,9 @@
 {
 	struct tsdev *tsdev = handle->private;
 
+	class_simple_device_remove(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
+	devfs_remove("input/ts%d", tsdev->minor);
+	devfs_remove("input/tsraw%d", tsdev->minor);
 	tsdev->exist = 0;
 
 	if (tsdev->open) {
@@ -436,7 +437,6 @@
 		wake_up_interruptible(&tsdev->wait);
 	} else
 		tsdev_free(tsdev);
-	devfs_remove("input/tsraw%d", tsdev->minor);
 }
 
 static struct input_device_id tsdev_ids[] = {
