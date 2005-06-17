Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVFQRUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVFQRUi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 13:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVFQRUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 13:20:38 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:63704 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S262024AbVFQRUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 13:20:18 -0400
Message-ID: <42B30654.4030307@zabbo.net>
Date: Fri, 17 Jun 2005 10:20:20 -0700
From: Zach Brown <zab@zabbo.net>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       John McCutchan <ttb@tentacle.dhs.org>
Subject: Re: [patch] inotify, improved.
References: <1118855899.3949.21.camel@betsy>  <42B1BC4B.3010804@zabbo.net>	 <1118946334.3949.63.camel@betsy>  <42B227B5.3090509@yahoo.com.au>	 <1118972109.7280.13.camel@phantasy> <1119021336.3949.104.camel@betsy>
In-Reply-To: <1119021336.3949.104.camel@betsy>
Content-Type: multipart/mixed;
 boundary="------------080207020500010101030507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080207020500010101030507
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


> +		schedule();

Here's a stab at getting rid of that raw schedule() in inotify_read().
It maintains the behaviour where it returns when an event doesn't fit
and returns after events have been copied instead of sleeping.  It
changes behaviour in that it returns partial reads that suceeded instead
of the error that stopped processing.  It also lets threads who race out
of a wakeup to find an empty list go back to sleep instead of returning
0.  Dunno if that's behaviour you'd prefer but it seemed reasonable.  I
hope that lockless list_empty() is OK, I didn't think very hard about it.

Compiles but totally untested.  Check my work :)

- z

--------------080207020500010101030507
Content-Type: text/x-patch;
 name="inotify-use-w-e-i-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="inotify-use-w-e-i-0.patch"

Index: 2.6-mm-inotify-throwaway/fs/inotify.c
===================================================================
--- 2.6-mm-inotify-throwaway.orig/fs/inotify.c	2005-06-17 09:32:52.000000000 -0700
+++ 2.6-mm-inotify-throwaway/fs/inotify.c	2005-06-17 10:16:11.000000000 -0700
@@ -639,52 +639,32 @@
 static ssize_t inotify_read(struct file *file, char __user *buf,
 			    size_t count, loff_t *pos)
 {
-	size_t event_size = sizeof (struct inotify_event);
-	struct inotify_device *dev;
-	char __user *start;
-	int ret;
-	DEFINE_WAIT(wait);
-
-	start = buf;
-	dev = file->private_data;
-
-	while (1) {
-		int events;
-
-		prepare_to_wait(&dev->wq, &wait, TASK_INTERRUPTIBLE);
-
-		down(&dev->sem);
-		events = !list_empty(&dev->events);
-		up(&dev->sem);
-		if (events) {
-			ret = 0;
-			break;
-		}
-
-		if (file->f_flags & O_NONBLOCK) {
-			ret = -EAGAIN;
-			break;
-		}
-
-		if (signal_pending(current)) {
-			ret = -EINTR;
-			break;
-		}
-
-		schedule();
-	}
-
-	finish_wait(&dev->wq, &wait);
-	if (ret)
-		return ret;
+	struct inotify_device *dev = file->private_data;
+	char __user *start = buf;
+	int ret = 0;
 
 	down(&dev->sem);
 	while (1) {
 		struct inotify_kernel_event *kevent;
+		static size_t event_size = sizeof (struct inotify_event);
 
-		ret = buf - start;
-		if (list_empty(&dev->events))
-			break;
+		if (list_empty(&dev->events)) {
+			/* return partial instead of sleeping */
+			if (buf > start)
+				break;
+			if (file->f_flags & O_NONBLOCK) {
+				ret = -EAGAIN;
+				break;
+			}
+			up(&dev->sem);
+			ret = wait_event_interruptible(dev->wq,
+						!list_empty(&dev->events));
+			down(&dev->sem);
+			if (ret)
+				break;
+			continue;
+
+		}
 
 		kevent = inotify_dev_get_event(dev);
 		if (event_size + kevent->event.len > count)
@@ -710,6 +690,9 @@
 	}
 	up(&dev->sem);
 
+	if (buf > start)
+		ret = buf - start;
+
 	return ret;
 }
 

--------------080207020500010101030507--
