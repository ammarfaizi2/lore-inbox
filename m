Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269602AbUI3WzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269602AbUI3WzX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 18:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269606AbUI3WzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 18:55:22 -0400
Received: from peabody.ximian.com ([130.57.169.10]:53956 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269602AbUI3Wy7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 18:54:59 -0400
Subject: [patch] inotify: rename slab-related stuff
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1096410792.4365.3.camel@vertex>
References: <1096410792.4365.3.camel@vertex>
Content-Type: multipart/mixed; boundary="=-cCa4ia+DrVqeFe4M6FPt"
Date: Thu, 30 Sep 2004 18:53:36 -0400
Message-Id: <1096584816.4203.98.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cCa4ia+DrVqeFe4M6FPt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hey, John.

Following patch renames some slab-related stuff.

First rename the "kevent_cache" variable to "event_cachep".  The name
"kevent" sounds too close to the kernel event layer, which is going in.
And the 'p' suffix is the standard for slab cache variables.  No idea
why.

Second rename the "watcher_cache" variable to "watch_cachep" as the
thing is now a watch object, not a watcher.  Also, same thing with the
'p'.

We do not have to worry about namespace, since the variables are local
to the file.

Finally, give the slab caches more descriptive user-visible names:
"inotify_watch_cache" and "inotify_event_cache".

Patch is on top of 0.11.0 and my past indiscretions.

	Robert Love


--=-cCa4ia+DrVqeFe4M6FPt
Content-Disposition: attachment; filename=inotify-rename-slab-stuff-1.patch
Content-Type: text/x-patch; name=inotify-rename-slab-stuff-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

rename slab-related things

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff -urN linux-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify/drivers/char/inotify.c	2004-09-30 18:44:21.131858232 -0400
+++ linux/drivers/char/inotify.c	2004-09-30 18:48:10.334014208 -0400
@@ -46,8 +46,8 @@
 #define MAX_INOTIFY_QUEUED_EVENTS 256	/* max events queued on the dev*/
 
 static atomic_t watcher_count;
-static kmem_cache_t *watcher_cache;
-static kmem_cache_t *kevent_cache;
+static kmem_cache_t *watch_cachep;
+static kmem_cache_t *event_cachep;
 
 /* For debugging */
 static int inotify_debug_flags;
@@ -139,7 +139,7 @@
 {
 	struct inotify_kernel_event *kevent;
 
-	kevent = kmem_cache_alloc(kevent_cache, GFP_ATOMIC);
+	kevent = kmem_cache_alloc(event_cachep, GFP_ATOMIC);
 	if (!kevent) {
 		iprintk(INOTIFY_DEBUG_ALLOC,
 			"failed to alloc kevent (%d,%d)\n", wd, mask);
@@ -181,7 +181,7 @@
 	kevent->event.mask = 0;
 
 	iprintk(INOTIFY_DEBUG_ALLOC, "free'd kevent %p\n", kevent);
-	kmem_cache_free(kevent_cache, kevent);
+	kmem_cache_free(event_cachep, kevent);
 }
 
 #define inotify_dev_has_events(dev) (!list_empty(&dev->events))
@@ -321,7 +321,7 @@
 {
 	struct inotify_watch *watcher;
 
-	watcher = kmem_cache_alloc(watcher_cache, GFP_KERNEL);
+	watcher = kmem_cache_alloc(watch_cachep, GFP_KERNEL);
 	if (!watcher) {
 		iprintk(INOTIFY_DEBUG_ALLOC,
 			"failed to allocate watcher (%p,%d)\n", inode, mask);
@@ -344,7 +344,7 @@
 		iprintk(INOTIFY_DEBUG_ERRORS,
 			"Could not get wd for watcher %p\n", watcher);
 		iprintk(INOTIFY_DEBUG_ALLOC, "free'd watcher %p\n", watcher);
-		kmem_cache_free(watcher_cache, watcher);
+		kmem_cache_free(watch_cachep, watcher);
 		return NULL;
 	}
 
@@ -361,7 +361,7 @@
 {
 	inotify_dev_put_wd(dev, watcher->wd);
 	iprintk(INOTIFY_DEBUG_ALLOC, "free'd watcher %p\n", watcher);
-	kmem_cache_free(watcher_cache, watcher);
+	kmem_cache_free(watch_cachep, watcher);
 }
 
 /*
@@ -975,11 +975,11 @@
 
 	inotify_debug_flags = INOTIFY_DEBUG_NONE;
 
-	watcher_cache = kmem_cache_create("watcher_cache",
+	watch_cachep = kmem_cache_create("inotify_watch_cache",
 			sizeof(struct inotify_watch), 0, SLAB_PANIC,
 			NULL, NULL);
 
-	kevent_cache = kmem_cache_create("kevent_cache",
+	event_cachep = kmem_cache_create("inotify_event_cache",
 			sizeof(struct inotify_kernel_event), 0,
 			SLAB_PANIC, NULL, NULL);
 

--=-cCa4ia+DrVqeFe4M6FPt--

