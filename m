Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbUKFA7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbUKFA7g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 19:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbUKFA7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 19:59:36 -0500
Received: from peabody.ximian.com ([130.57.169.10]:52935 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261297AbUKFA7d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 19:59:33 -0500
Subject: Re: [patch] inotify: add FIONREAD support
From: Robert Love <rml@novell.com>
To: Greg KH <greg@kroah.com>
Cc: John McCutchan <ttb@tentacle.dhs.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1099702663.6034.270.camel@localhost>
References: <1099696444.6034.266.camel@localhost>
	 <20041106004755.GA23981@kroah.com>  <1099702663.6034.270.camel@localhost>
Content-Type: text/plain
Date: Fri, 05 Nov 2004 20:00:14 -0500
Message-Id: <1099702814.6034.273.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-05 at 19:57 -0500, Robert Love wrote:

> Why?  p is annotated __user.

Oh, but I typecast that away.  Doh.

	Robert Love


Add FIONREAD support to inotify, take two.  Strawberries.

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
+		return put_user(bytes, (int __user *) p);
 	default:
 		return -ENOTTY;
 	}


