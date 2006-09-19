Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751988AbWISOIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbWISOIB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 10:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbWISOIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 10:08:00 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:18450 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751988AbWISOH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 10:07:59 -0400
Date: Tue, 19 Sep 2006 10:07:58 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] USB: force root hub resume after power loss
Message-ID: <Pine.LNX.4.44L0.0609191007050.6555-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch(as785) forces the PM core to resume a root hub after a
power loss during system sleep.  If the root hub had been suspended
before the system sleep then normally the PM core would not resume it
afterward.  Without this resume, various sorts of wakeup events (like
port change events) can get lost.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/drivers/usb/core/hub.c
===================================================================
--- usb-2.6.orig/drivers/usb/core/hub.c
+++ usb-2.6/drivers/usb/core/hub.c
@@ -1066,6 +1066,12 @@ void usb_root_hub_lost_power(struct usb_
 	unsigned long flags;
 
 	dev_warn(&rhdev->dev, "root hub lost power or was reset\n");
+
+	/* Make sure no potential wakeup events get lost,
+	 * by forcing the root hub to be resumed.
+	 */
+	rhdev->dev.power.prev_state.event = PM_EVENT_ON;
+
 	spin_lock_irqsave(&device_state_lock, flags);
 	hub = hdev_to_hub(rhdev);
 	for (port1 = 1; port1 <= rhdev->maxchild; ++port1) {

