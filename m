Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265223AbTFEWMm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 18:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbTFEWMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 18:12:42 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:39871 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265223AbTFEWMl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 18:12:41 -0400
Date: Thu, 5 Jun 2003 15:28:06 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TTY changes for 2.5.70
Message-ID: <20030605222806.GC7717@kroah.com>
References: <20030605222731.GA7717@kroah.com> <20030605222753.GB7717@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030605222753.GB7717@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1314, 2003/06/05 14:21:57-07:00, greg@kroah.com

TTY: add a release function for tty_class devices.

This fixes a race with looking at files in /sys/class/tty/ and removing a
tty device.


 drivers/char/tty_io.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)


diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Thu Jun  5 15:21:07 2003
+++ b/drivers/char/tty_io.c	Thu Jun  5 15:21:07 2003
@@ -2114,6 +2114,12 @@
 }
 static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
 
+static void release_tty_dev(struct class_device *class_dev)
+{
+	struct tty_dev *tty_dev = to_tty_dev(class_dev);
+	kfree(tty_dev);
+}
+
 static void tty_add_class_device(char *name, dev_t dev, struct device *device)
 {
 	struct tty_dev *tty_dev = NULL;
@@ -2134,6 +2140,7 @@
 
 	tty_dev->class_dev.dev = device;
 	tty_dev->class_dev.class = &tty_class;
+	tty_dev->class_dev.release = &release_tty_dev;
 	snprintf(tty_dev->class_dev.class_id, BUS_ID_SIZE, "%s", temp);
 	retval = class_device_register(&tty_dev->class_dev);
 	if (retval)
@@ -2167,7 +2174,6 @@
 		list_del(&tty_dev->node);
 		spin_unlock(&tty_dev_list_lock);
 		class_device_unregister(&tty_dev->class_dev);
-		kfree(tty_dev);
 	} else {
 		spin_unlock(&tty_dev_list_lock);
 	}
