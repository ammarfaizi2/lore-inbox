Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267313AbUIUFoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267313AbUIUFoY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 01:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUIUFoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 01:44:24 -0400
Received: from peabody.ximian.com ([130.57.169.10]:36840 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267313AbUIUFoQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 01:44:16 -0400
Subject: Re: [RFC][PATCH] inotify 0.9.2
From: Robert Love <rml@ximian.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, nautilus-list@gnome.org,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <1095652572.23128.2.camel@vertex>
References: <1095652572.23128.2.camel@vertex>
Content-Type: multipart/mixed; boundary="=-WOoGHH91FiXEqZCUFqu8"
Date: Tue, 21 Sep 2004 01:44:15 -0400
Message-Id: <1095745455.2454.64.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WOoGHH91FiXEqZCUFqu8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-09-19 at 23:56 -0400, John McCutchan wrote:

> I would appreciate design review, code review and testing.

Hello sir!

kmalloc() can fail, so check the return value and handle appropriately.

Patch is against inotify 0.9.2 plus the last patches I sent.

Thanks,

	Robert Love


--=-WOoGHH91FiXEqZCUFqu8
Content-Disposition: attachment; filename=inotify-check-kmalloc-rml-1.patch
Content-Type: text/x-patch; name=inotify-check-kmalloc-rml-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

kmalloc() can fail. Check the return value.

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

--- linux-inotify/drivers/char/inotify.c	2004-09-21 01:30:09.160707592 -0400
+++ linux/drivers/char/inotify.c	2004-09-21 01:40:47.777623064 -0400
@@ -551,11 +551,15 @@
 	int events;
 	int event_count;
 
-	eventbuf = kmalloc(sizeof(struct inotify_event) * MAX_EVENTS_AT_ONCE, 
-			GFP_KERNEL);
+	out = -ENOMEM;
+	eventbuf = kmalloc(sizeof(struct inotify_event) * MAX_EVENTS_AT_ONCE,
+			   GFP_KERNEL);
+	if (!eventbuf)
+		goto out;
+
+	out = 0;
 	events = 0;
 	event_count = 0;
-	out = 0;
 	err = 0;
 
 	obuf = buf;
@@ -644,7 +648,8 @@
 	}
 }
 
-static int inotify_open(struct inode *inode, struct file *file) {
+static int inotify_open(struct inode *inode, struct file *file)
+{
 	struct inotify_device *dev;
 
 	if (atomic_read(&watcher_count) == MAX_INOTIFY_DEVS)
@@ -653,7 +658,11 @@
 	atomic_inc(&watcher_count);
 
 	dev = kmalloc(sizeof(struct inotify_device), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
 	dev->bitmask = kmalloc(__BITMASK_SIZE, GFP_KERNEL);
+	if (!dev->bitmask)
+		return -ENOMEM;
 	memset(dev->bitmask, 0, __BITMASK_SIZE);
 
 	INIT_LIST_HEAD(&dev->events);

--=-WOoGHH91FiXEqZCUFqu8--

