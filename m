Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267370AbUITVxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267370AbUITVxp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 17:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267372AbUITVxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 17:53:45 -0400
Received: from peabody.ximian.com ([130.57.169.10]:23782 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267370AbUITVxm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 17:53:42 -0400
Subject: Re: [RFC][PATCH] inotify 0.9.2
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, nautilus-list@gnome.org,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <1095652572.23128.2.camel@vertex>
References: <1095652572.23128.2.camel@vertex>
Content-Type: multipart/mixed; boundary="=-sl/49RxIvWIY2yNksnjC"
Date: Mon, 20 Sep 2004 17:52:34 -0400
Message-Id: <1095717155.5258.7.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sl/49RxIvWIY2yNksnjC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-09-19 at 23:56 -0400, John McCutchan wrote:

> I would appreciate design review, code review and testing.

Hi, John.

When you pass SLAB_PANIC to kmem_cache_create(), the slab layer will
panic the kernel and thus halt the machine.  So there is no reason to
check the return value.

We could remove the SLAB_PANIC, but I think that it makes sense, so
instead I removed the code checking the returns, saving a few bytes.

Patch is against your inotify patch.

	Robert Love


--=-sl/49RxIvWIY2yNksnjC
Content-Disposition: attachment; filename=inotify-slab-panic-rml-2.6.9-rc2.patch
Content-Type: text/x-patch; name=inotify-slab-panic-rml-2.6.9-rc2.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |   20 +++++++-------------
 1 files changed, 7 insertions(+), 13 deletions(-)

diff -urN linux-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify/drivers/char/inotify.c	2004-09-20 17:10:58.000000000 -0400
+++ linux/drivers/char/inotify.c	2004-09-20 17:33:03.369317992 -0400
@@ -942,19 +942,13 @@
 
 	inotify_debug_flags = INOTIFY_DEBUG_NONE;
 
-	watcher_cache = kmem_cache_create ("watcher_cache", 
-			sizeof(struct inotify_watcher), 0, SLAB_PANIC, NULL, NULL);
-
-	if (!watcher_cache) {
-		misc_deregister (&inotify_device);
-	}
-	kevent_cache = kmem_cache_create ("kevent_cache", 
-			sizeof(struct inotify_kernel_event), 0, SLAB_PANIC, NULL, NULL);
-
-	if (!kevent_cache) {
-		misc_deregister (&inotify_device);
-		kmem_cache_destroy (watcher_cache);
-	}
+	watcher_cache = kmem_cache_create ("watcher_cache",
+			sizeof(struct inotify_watcher), 0,
+			SLAB_PANIC, NULL, NULL);
+
+	kevent_cache = kmem_cache_create ("kevent_cache",
+			sizeof(struct inotify_kernel_event), 0,
+			SLAB_PANIC, NULL, NULL);
 
 	printk(KERN_ALERT "inotify 0.9.2 minor=%d\n", inotify_device.minor);
 out:

--=-sl/49RxIvWIY2yNksnjC--

