Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267967AbUIUS5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267967AbUIUS5t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 14:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267963AbUIUS5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 14:57:49 -0400
Received: from peabody.ximian.com ([130.57.169.10]:41856 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267967AbUIUS5p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 14:57:45 -0400
Subject: Re: [RFC][PATCH] inotify 0.9.2
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <1095782674.4944.41.camel@betsy.boston.ximian.com>
References: <1095652572.23128.2.camel@vertex>
	 <1095782674.4944.41.camel@betsy.boston.ximian.com>
Content-Type: multipart/mixed; boundary="=-W+ifv+tBvOOmxOY1/2j9"
Date: Tue, 21 Sep 2004 14:56:36 -0400
Message-Id: <1095792996.4944.59.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-W+ifv+tBvOOmxOY1/2j9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-09-21 at 12:04 -0400, Robert Love wrote:

> Hey, John.
> 
> We are seeing an oops when monitoring a large number of directories.
> The system keeps running, but I/O gets flaky and eventually processes
> start getting stuck.
> 
> Also, the ioctl() stops returning new WD after 1024.  Thereafter, it
> keeps returning the same value.
> 
> I have attached the relevant bits from the syslog.  I will debug it, but
> I thought that perhaps you would immediately see the issue.

OK.  I fixed the problem with ioctl() failing after 1024 WD's.  This may
also fix the oopses.  Still checking on that.

The problem was that we were passing the size of dev->bitmask in _bytes_
to find_first_zero_bit().  But find_first_zero_bit()'s second parameter
is the size in _bits_.

I then went ahead and just made dev->bitmask an array, since we know the
size at compile time.

Comments?

Best,

	Robert Love


--=-W+ifv+tBvOOmxOY1/2j9
Content-Disposition: attachment; filename=inotify-fix-wd-rml-1.patch
Content-Type: text/x-patch; name=inotify-fix-wd-rml-1.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Fix problem with ioctl() failing after 1024 WD's, by giving ffz bits not bytes.
Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

--- linux-inotify-rml/drivers/char/inotify.c	2004-09-20 18:02:32.886258448 -0400
+++ linux/drivers/char/inotify.c	2004-09-21 14:51:11.433908024 -0400
@@ -43,7 +43,6 @@
 #define MAX_INOTIFY_DEVS 8 /* We only support X watchers */
 #define MAX_INOTIFY_DEV_WATCHERS 8192 /* A dev can only have Y watchers */
 #define MAX_INOTIFY_QUEUED_EVENTS 256 /* Only the first Z events will be queued */
-#define __BITMASK_SIZE (MAX_INOTIFY_DEV_WATCHERS / 8)
 
 #define INOTIFY_DEV_TIMER_TIME jiffies + (HZ/4)
 
@@ -71,7 +70,7 @@
 	struct timer_list	timer;
 	char			read_state;
 	spinlock_t		lock;
-	void *			bitmask;
+	unsigned long		bitmask[MAX_INOTIFY_DEV_WATCHERS / BITS_PER_LONG];
 };
 #define inotify_device_event_list(pos) list_entry((pos), struct inotify_event, list)
 
@@ -239,7 +238,7 @@
 
 	dev->watcher_count++;
 
-	wd = find_first_zero_bit (dev->bitmask, __BITMASK_SIZE);
+	wd = find_first_zero_bit (dev->bitmask, MAX_INOTIFY_DEV_WATCHERS);
 
 	set_bit (wd, dev->bitmask);
 
@@ -653,8 +652,7 @@
 	atomic_inc(&watcher_count);
 
 	dev = kmalloc(sizeof(struct inotify_device), GFP_KERNEL);
-	dev->bitmask = kmalloc(__BITMASK_SIZE, GFP_KERNEL);
-	memset(dev->bitmask, 0, __BITMASK_SIZE);
+	memset(dev->bitmask, 0, MAX_INOTIFY_DEV_WATCHERS);
 
 	INIT_LIST_HEAD(&dev->events);
 	INIT_LIST_HEAD(&dev->watchers);

--=-W+ifv+tBvOOmxOY1/2j9--

