Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267338AbUI0Uao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267338AbUI0Uao (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267323AbUI0U1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:27:46 -0400
Received: from peabody.ximian.com ([130.57.169.10]:44455 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267334AbUI0UXf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:23:35 -0400
Subject: patch] inotify: use bitmap.h functions
From: Robert Love <rml@novell.com>
To: Paul Jackson <pj@sgi.com>
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20040927124836.2983ff9b.pj@sgi.com>
References: <1096250524.18505.2.camel@vertex>
	 <1096305177.30503.65.camel@betsy.boston.ximian.com>
	 <20040927124836.2983ff9b.pj@sgi.com>
Content-Type: multipart/mixed; boundary="=-szQNEMu64zsgjVCnoEfl"
Date: Mon, 27 Sep 2004 16:22:15 -0400
Message-Id: <1096316535.30503.119.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-szQNEMu64zsgjVCnoEfl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-09-27 at 12:48 -0700, Paul Jackson wrote:

> > 	unsigned long		bitmask[MAX_INOTIFY_DEV_WATCHERS/BITS_PER_LONG];
> 
> This assumes that MAX_INOTIFY_DEV_WATCHERS is an integral multiple
> of BITS_PER_LONG, otherwise, the last word will be missing.

Yah.  Since we defined MAX_INOTIFY_DEV_WATCHERS, I presumed to be able
to ensure it was a multiple (e.g. just keep it a power of two) ...

> Perhaps this would this better be written as:
> 
> 	DECLARE_BITMAP(bitmask, MAX_INOTIFY_DEV_WATCHERS);

... but this is indeed cleaner.

> and the clearing of it in the original patch:
> 
> > +	memset(dev->bitmask, 0,
> > +	  sizeof(unsigned long) * MAX_INOTIFY_DEV_WATCHERS / BITS_PER_LONG);
> 
> might better be written as:
> 
> 	CLEAR_BITMAP(dev->bitmask, MAX_INOTIFY_DEV_WATCHERS);

I think you mean bitmap_zero(), but yah.  Agreed.

John, here is a patch to use the bitmap.h functions to manipulate the
bitmap.

	Robert Love


--=-szQNEMu64zsgjVCnoEfl
Content-Disposition: attachment; filename=inotify-rml-use-bitmaps-1.patch
Content-Type: text/x-patch; name=inotify-rml-use-bitmaps-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use <linux/bitmap.h> bitmap functions

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -urN linux-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-inotify/drivers/char/inotify.c	2004-09-27 16:08:22.701736912 -0400
+++ linux/drivers/char/inotify.c	2004-09-27 16:20:48.012432464 -0400
@@ -21,6 +21,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/bitmap.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -64,7 +65,7 @@
  * implies that the given WD is valid, unset implies it is not.
  */
 struct inotify_device {
-	unsigned long		bitmask[MAX_INOTIFY_DEV_WATCHERS/BITS_PER_LONG];
+	DECLARE_BITMAP(bitmask, MAX_INOTIFY_DEV_WATCHERS);
 	struct timer_list	timer;
 	wait_queue_head_t 	wait;
 	struct list_head 	events;
@@ -286,7 +287,7 @@
 
 	dev->nr_watches++;
 	wd = find_first_zero_bit(dev->bitmask, MAX_INOTIFY_DEV_WATCHERS);
-	set_bit (wd, dev->bitmask);
+	set_bit(wd, dev->bitmask);
 
 	return wd;
 }
@@ -775,8 +776,7 @@
 	if (!dev)
 		return -ENOMEM;
 
-	memset(dev->bitmask, 0,
-	  sizeof(unsigned long) * MAX_INOTIFY_DEV_WATCHERS / BITS_PER_LONG);
+	bitmap_zero(dev->bitmask, MAX_INOTIFY_DEV_WATCHERS);
 
 	INIT_LIST_HEAD(&dev->events);
 	INIT_LIST_HEAD(&dev->watchers);

--=-szQNEMu64zsgjVCnoEfl--

