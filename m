Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVAXS0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVAXS0w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 13:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVAXS0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 13:26:51 -0500
Received: from twin.jikos.cz ([213.151.79.26]:48013 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S261558AbVAXSZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 13:25:26 -0500
Date: Mon, 24 Jan 2005 19:25:19 +0100 (CET)
From: Jirka Kosina <jikos@jikos.cz>
To: Patrick Mochel <mochel@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix bad locking in drivers/base/driver.c
Message-ID: <Pine.LNX.4.58.0501241921310.5857@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there has been (for quite some time) a bug in function driver_unregister() 
- the lock/unlock sequence is protecting nothing and the actual 
bus_remove_driver() is called outside critical section.

Please apply.

--- linux-2.6.11-rc2/drivers/base/driver.c.old	2005-01-22 02:48:48.000000000 +0100
+++ linux-2.6.11-rc2/drivers/base/driver.c	2005-01-24 19:19:33.243501684 +0100
@@ -106,8 +106,8 @@
 
 void driver_unregister(struct device_driver * drv)
 {
-	bus_remove_driver(drv);
 	down(&drv->unload_sem);
+	bus_remove_driver(drv);
 	up(&drv->unload_sem);
 }
 
-- 
JiKos.
