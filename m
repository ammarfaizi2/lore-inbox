Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbTFUNiH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 09:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbTFUNiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 09:38:07 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:22178 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263705AbTFUNiB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 09:38:01 -0400
Subject: [PATCH 7/11] input: Fixes for the uinput userspace
In-Reply-To: <10562035171778@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sat, 21 Jun 2003 15:51:57 +0200
Message-Id: <10562035172084@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1365, 2003-06-21 04:43:13-07:00, neilb@cse.unsw.edu.au
  input: Three fixes for the uinput userspace input device driver.


 uinput.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
--- a/drivers/input/misc/uinput.c	Sat Jun 21 15:25:36 2003
+++ b/drivers/input/misc/uinput.c	Sat Jun 21 15:25:36 2003
@@ -49,11 +49,11 @@
 
 	udev = (struct uinput_device *)dev->private;
 
-	udev->head = (udev->head + 1) % UINPUT_BUFFER_SIZE;
 	udev->buff[udev->head].type = type;
 	udev->buff[udev->head].code = code;
 	udev->buff[udev->head].value = value;
 	do_gettimeofday(&udev->buff[udev->head].time);
+	udev->head = (udev->head + 1) % UINPUT_BUFFER_SIZE;
 
 	wake_up_interruptible(&udev->waitq);
 
@@ -82,6 +82,7 @@
 	udev->dev->event = uinput_dev_event;
 	udev->dev->upload_effect = uinput_dev_upload_effect;
 	udev->dev->erase_effect = uinput_dev_erase_effect;
+	udev->dev->private = udev;
 
 	init_waitqueue_head(&(udev->waitq));
 
@@ -264,7 +265,7 @@
 		return -ENODEV;
 
 	while ((udev->head != udev->tail) && 
-	    (retval + sizeof(struct uinput_device) <= count)) {
+	    (retval + sizeof(struct input_event) <= count)) {
 		if (copy_to_user(buffer + retval, &(udev->buff[udev->tail]),
 		    sizeof(struct input_event))) return -EFAULT;
 		udev->tail = (udev->tail + 1) % UINPUT_BUFFER_SIZE;

