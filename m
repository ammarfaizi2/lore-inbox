Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbUKEXN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbUKEXN5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 18:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUKEXNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 18:13:36 -0500
Received: from peabody.ximian.com ([130.57.169.10]:25799 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261255AbUKEXNX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 18:13:23 -0500
Subject: [patch] inotify: add FIONREAD support
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 05 Nov 2004 18:14:04 -0500
Message-Id: <1099696444.6034.266.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John,

There are a handful of "standard" file ioctl's (FIBMAP, FIONREAD,
FIGETBSZ, etc.).  We don't have to implement any of them, but FIONREAD
is actually pretty useful: It tells you how many bytes are available on
the fd.

This turns out to be needed because things listening to inotify during
heavy file I/O can cause a scheduler scenario like

	wake up, read 1 event, block
		other guy runs, causes file I/O
			wake up, read 1 event, block
				other guy runs, causes file I/O
					etc

And so disk intense operations like untarring take a bit longer because
the scheduler behavior serializes the I/O operation, so to speak.  This
is a pathological case, and it relies on the scheduler semantics of the
two processes, but it happens.

If Gamin or Beagle or whatever can "peak" at the fd and see it has only
a small number of events available, they can yield or sleep for a few
milliseconds, allowing the file I/O to continue, and not cause the
scheduling mess.

So we see read events go from 1,1,1,1,1,... event read to something more
acceptable, such as 200,200,200,... events read, and that is nice.

Attached patch adds the FIONREAD ioctl.  It is only one line,
really. ;-)

Best,

	Robert Love


Add FIONREAD support to inotify.  Walrus.

 drivers/char/inotify.c |    6 ++++++
 1 files changed, 6 insertions(+)

diff -urN linux-2.6.10-rc1-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-2.6.10-rc1-inotify/drivers/char/inotify.c	2004-11-05 17:26:52.182836608 -0500
+++ linux/drivers/char/inotify.c	2004-11-05 18:01:54.755197024 -0500
@@ -35,6 +35,8 @@
 #include <linux/writeback.h>
 #include <linux/inotify.h>
 
+#include <asm/ioctls.h>
+
 static atomic_t watch_count;
 static atomic_t inotify_cookie;
 static kmem_cache_t *watch_cachep;
@@ -879,6 +881,7 @@
 	struct inotify_device *dev;
 	struct inotify_watch_request request;
 	void __user *p;
+	int bytes;
 	s32 wd;
 
 	dev = fp->private_data;
@@ -893,6 +896,9 @@
 		if (copy_from_user(&wd, p, sizeof (wd)))
 			return -EFAULT;
 		return inotify_ignore(dev, wd);
+	case FIONREAD:
+		bytes = dev->event_count * sizeof (struct inotify_event);
+		return put_user(bytes, (int *) p);
 	default:
 		return -ENOTTY;
 	}


