Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWAKMJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWAKMJn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 07:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWAKMJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 07:09:43 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:51590 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1750908AbWAKMJm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 07:09:42 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17348.62853.456052.12175@jaguar.mkp.net>
Date: Wed, 11 Jan 2006 07:09:41 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: [patch] sem2mutex input
X-Mailer: VM 7.19 under Emacs 21.4.1
From: jes@trained-monkey.org (Jes Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Relative to Linus' git tree.

Cheers,
Jes


Use mutex instead of semaphore.

Signed-off-by: Jes Sorensen <jes@sgi.com>

----

 drivers/input/input.c |   15 ++++++++-------
 include/linux/input.h |    2 +-
 2 files changed, 9 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/input/input.c
===================================================================
--- linux-2.6.orig/drivers/input/input.c
+++ linux-2.6/drivers/input/input.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/poll.h>
 #include <linux/device.h>
+#include <linux/mutex.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("Input core");
@@ -224,7 +225,7 @@
 	struct input_dev *dev = handle->dev;
 	int err;
 
-	err = down_interruptible(&dev->sem);
+	err = mutex_lock_interruptible(&dev->mutex);
 	if (err)
 		return err;
 
@@ -236,7 +237,7 @@
 	if (err)
 		handle->open--;
 
-	up(&dev->sem);
+	mutex_unlock(&dev->mutex);
 
 	return err;
 }
@@ -255,13 +256,13 @@
 
 	input_release_device(handle);
 
-	down(&dev->sem);
+	mutex_lock(&dev->mutex);
 
 	if (!--dev->users && dev->close)
 		dev->close(dev);
 	handle->open--;
 
-	up(&dev->sem);
+	mutex_unlock(&dev->mutex);
 }
 
 static void input_link_handle(struct input_handle *handle)
@@ -512,13 +513,13 @@
 	struct input_dev *input_dev = to_input_dev(dev);			\
 	int retval;								\
 										\
-	retval = down_interruptible(&input_dev->sem);				\
+	retval = mutex_lock_interruptible(&input_dev->mutex);			\
 	if (retval)								\
 		return retval;							\
 										\
 	retval = sprintf(buf, "%s\n", input_dev->name ? input_dev->name : "");	\
 										\
-	up(&input_dev->sem);							\
+	mutex_unlock(&input_dev->mutex);					\
 										\
 	return retval;								\
 }										\
@@ -771,7 +772,7 @@
 		return -EINVAL;
 	}
 
-	init_MUTEX(&dev->sem);
+	mutex_init(&dev->mutex);
 	set_bit(EV_SYN, dev->evbit);
 
 	/*
Index: linux-2.6/include/linux/input.h
===================================================================
--- linux-2.6.orig/include/linux/input.h
+++ linux-2.6/include/linux/input.h
@@ -929,7 +929,7 @@
 
 	struct input_handle *grab;
 
-	struct semaphore sem;	/* serializes open and close operations */
+	struct mutex mutex;	/* serializes open and close operations */
 	unsigned int users;
 
 	struct class_device cdev;
