Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262199AbULPXk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbULPXk6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 18:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbULPXjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 18:39:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:13523 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262195AbULPXjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 18:39:36 -0500
Date: Thu, 16 Dec 2004 15:38:15 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 1/2] usbfs: Remove extraneous disconnection checks
Message-ID: <20041216233815.GA10997@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[2 USB patches to be applied to the latest -bk tree, both fixing real
bugs. I figured it's easier than creating a whole bk tree for them]



This patch fixes a bug in the usbfs code.  The driver is too zealous about
checking for disconnected devices before doing things.  In particular, it
is necessary to reap all outstanding asynchronous URBs and unbind from
interfaces when the device file is closed, even if the device is no longer
connected.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c	2004-12-16 15:35:55 -08:00
+++ b/drivers/usb/core/devio.c	2004-12-16 15:35:55 -08:00
@@ -523,13 +523,12 @@
 
 	usb_lock_device(dev);
 	list_del_init(&ps->list);
-
-	if (connected(dev)) {
-		for (ifnum = 0; ps->ifclaimed && ifnum < 8*sizeof(ps->ifclaimed); ifnum++)
-			if (test_bit(ifnum, &ps->ifclaimed))
-				releaseintf(ps, ifnum);
-		destroy_all_async(ps);
+	for (ifnum = 0; ps->ifclaimed && ifnum < 8*sizeof(ps->ifclaimed);
+			ifnum++) {
+		if (test_bit(ifnum, &ps->ifclaimed))
+			releaseintf(ps, ifnum);
 	}
+	destroy_all_async(ps);
 	usb_unlock_device(dev);
 	usb_put_dev(dev);
 	ps->dev = NULL;
@@ -1034,7 +1033,7 @@
 	int ret;
 
 	add_wait_queue(&ps->wait, &wait);
-	while (connected(dev)) {
+	for (;;) {
 		__set_current_state(TASK_INTERRUPTIBLE);
 		if ((as = async_getcompleted(ps)))
 			break;
