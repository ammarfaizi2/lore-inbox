Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVBFNPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVBFNPj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 08:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVBFNPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 08:15:01 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:48590 "EHLO suse.de")
	by vger.kernel.org with ESMTP id S261232AbVBFNMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 08:12:22 -0500
Date: Sun, 6 Feb 2005 14:12:41 +0100
From: Vojtech Pavlik <vojtech@suse.de>
To: dtor_core@ameritech.net
Cc: David Fries <dfries@mail.win.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux joydev joystick disconnect patch 2.6.11-rc2
Message-ID: <20050206131241.GA19564@ucw.cz>
References: <20041123212813.GA3196@spacedout.fries.net> <20050201145215.GA29942@spacedout.fries.net> <d120d500050201072413193c62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d500050201072413193c62@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 10:24:39AM -0500, Dmitry Torokhov wrote:
> On Tue, 1 Feb 2005 08:52:15 -0600, David Fries <dfries@mail.win.org> wrote:
> > Currently a blocking read, select, or poll call will not return if a
> > joystick device is unplugged.  This patch allows them to return.
> > 
> ...
> > static unsigned int joydev_poll(struct file *file, poll_table *wait)
> > {
> > +       int mask = 0;
> >        struct joydev_list *list = file->private_data;
> >        poll_wait(file, &list->joydev->wait, wait);
> > -       if (list->head != list->tail || list->startup < list->joydev->nabs + list->joydev->nkey)
> > -               return POLLIN | POLLRDNORM;
> > -       return 0;
> > +       if(!list->joydev->exist)
> > +               mask |= POLLERR;
> 
> Probably need POLLHUP in addition (or instead of POLLERR).
> 
> >        if (joydev->open)
> > +       {
> >                input_close_device(handle);
> > +               wake_up_interruptible(&joydev->wait);
> > +       }
> >        else
> > +       {
> >                joydev_free(joydev);
> > +       }
> 
> Opening braces should go on the same line as the statement (if (...) {).
 
How about this patch?


ChangeSet@1.2116, 2005-02-06 13:58:37+01:00, vojtech@silver.ucw.cz
  input: Fix poll() behavior of input handlers on disconnect.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 evdev.c    |    5 ++---
 joydev.c   |   10 +++++-----
 mousedev.c |    6 +++---
 tsdev.c    |    6 ++----
 4 files changed, 12 insertions(+), 15 deletions(-)


diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	2005-02-06 14:12:04 +01:00
+++ b/drivers/input/evdev.c	2005-02-06 14:12:04 +01:00
@@ -199,9 +199,8 @@
 {
 	struct evdev_list *list = file->private_data;
 	poll_wait(file, &list->evdev->wait, wait);
-	if (list->head != list->tail)
-		return POLLIN | POLLRDNORM;
-	return 0;
+	return ((list->head == list->tail) ? 0 : (POLLIN | POLLRDNORM)) |
+		(list->evdev->exist ? 0 : (POLLHUP | POLLERR));
 }
 
 static int evdev_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
diff -Nru a/drivers/input/joydev.c b/drivers/input/joydev.c
--- a/drivers/input/joydev.c	2005-02-06 14:12:04 +01:00
+++ b/drivers/input/joydev.c	2005-02-06 14:12:04 +01:00
@@ -281,9 +281,8 @@
 {
 	struct joydev_list *list = file->private_data;
 	poll_wait(file, &list->joydev->wait, wait);
-	if (list->head != list->tail || list->startup < list->joydev->nabs + list->joydev->nkey)
-		return POLLIN | POLLRDNORM;
-	return 0;
+	return ((list->head != list->tail || list->startup < list->joydev->nabs + list->joydev->nkey) ? 
+		(POLLIN | POLLRDNORM) : 0) | (list->joydev->exist ? 0 : (POLLHUP | POLLERR));
 }
 
 static int joydev_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
@@ -468,9 +467,10 @@
 	devfs_remove("input/js%d", joydev->minor);
 	joydev->exist = 0;
 
-	if (joydev->open)
+	if (joydev->open) {
 		input_close_device(handle);
-	else
+		wake_up_interruptible(&joydev->wait);
+	} else
 		joydev_free(joydev);
 }
 
diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	2005-02-06 14:12:04 +01:00
+++ b/drivers/input/mousedev.c	2005-02-06 14:12:04 +01:00
@@ -595,9 +595,8 @@
 {
 	struct mousedev_list *list = file->private_data;
 	poll_wait(file, &list->mousedev->wait, wait);
-	if (list->ready || list->buffer)
-		return POLLIN | POLLRDNORM;
-	return 0;
+	return ((list->ready || list->buffer) ? (POLLIN | POLLRDNORM) : 0) |
+		(list->mousedev->exist ? 0 : (POLLHUP | POLLERR));
 }
 
 static struct file_operations mousedev_fops = {
@@ -660,6 +659,7 @@
 
 	if (mousedev->open) {
 		input_close_device(handle);
+		wake_up_interruptible(&mousedev->wait);
 	} else {
 		if (mousedev_mix.open)
 			input_close_device(handle);
diff -Nru a/drivers/input/tsdev.c b/drivers/input/tsdev.c
--- a/drivers/input/tsdev.c	2005-02-06 14:12:04 +01:00
+++ b/drivers/input/tsdev.c	2005-02-06 14:12:04 +01:00
@@ -232,11 +232,9 @@
 static unsigned int tsdev_poll(struct file *file, poll_table * wait)
 {
 	struct tsdev_list *list = file->private_data;
-
 	poll_wait(file, &list->tsdev->wait, wait);
-	if (list->head != list->tail)
-		return POLLIN | POLLRDNORM;
-	return 0;
+	return ((list->head == list->tail) ? 0 : (POLLIN | POLLRDNORM)) |
+		(list->tsdev->exist ? 0 : (POLLHUP | POLLERR));
 }
 
 static int tsdev_ioctl(struct inode *inode, struct file *file,

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
