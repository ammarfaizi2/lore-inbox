Return-Path: <linux-kernel-owner+w=401wt.eu-S1161057AbXALJ6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbXALJ6N (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 04:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbXALJ6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 04:58:13 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:54879 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with SMTP id S1161061AbXALJ6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 04:58:12 -0500
Message-ID: <45A75968.7010109@dev.rtsoft.ru>
Date: Fri, 12 Jan 2007 12:48:24 +0300
From: Dmitry Antipov <antipov@dev.rtsoft.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.20-rc4: async I/O support for inotify
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is a proposal async I/O notification support for the inotify.

Dmitry

--- .orig-2.6.20-rc4/fs/inotify_user.c	2007-01-12 08:27:10.000000000 +0300
+++ 2.6.20-rc4/fs/inotify_user.c	2007-01-12 09:53:12.000000000 +0300
@@ -72,6 +72,7 @@
   */
  struct inotify_device {
  	wait_queue_head_t 	wq;		/* wait queue for i/o */
+	struct fasync_struct    *fasync;        /* async i/o notification */
  	struct mutex		ev_mutex;	/* protects event queue */
  	struct mutex		up_mutex;	/* synchronizes watch updates */
  	struct list_head 	events;		/* list of queued events */
@@ -301,6 +302,7 @@
  	dev->queue_size += sizeof(struct inotify_event) + kevent->event.len;
  	list_add_tail(&kevent->list, &dev->events);
  	wake_up_interruptible(&dev->wq);
+	kill_fasync(&dev->fasync, SIGIO, POLL_IN);

  out:
  	mutex_unlock(&dev->ev_mutex);
@@ -485,6 +487,7 @@
  {
  	struct inotify_device *dev = file->private_data;

+	fasync_helper(-1, file, 0, &dev->fasync);
  	inotify_destroy(dev->ih);

  	/* destroy all of the events on this device */
@@ -518,12 +521,19 @@
  	return ret;
  }

+static int inotify_fasync(int fd, struct file *file, int on)
+{
+	struct inotify_device *dev = file->private_data;
+	return fasync_helper(fd, file, on, &dev->fasync);
+}
+
  static const struct file_operations inotify_fops = {
  	.poll           = inotify_poll,
  	.read           = inotify_read,
  	.release        = inotify_release,
  	.unlocked_ioctl = inotify_ioctl,
  	.compat_ioctl	= inotify_ioctl,
+	.fasync         = inotify_fasync,
  };

  static const struct inotify_operations inotify_user_ops = {

