Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbVHYWKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbVHYWKJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 18:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbVHYWKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 18:10:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13510 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964922AbVHYWKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 18:10:08 -0400
Date: Thu, 25 Aug 2005 23:13:14 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, bcollins@debian.org
Subject: [PATCH] late spinlock initialization in ieee1394/ohci
Message-ID: <20050825221314.GY9322@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

spinlock used in irq handler should be initialized before registering
irq, even if we know that our device has interrupts disabled; handler
is registered shared and taking spinlock is done unconditionally.  As
it is, we can and do get oopsen on boot for some configuration, depending
on irq routing - I've got a reproducer.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-base/drivers/ieee1394/ohci1394.c current/drivers/ieee1394/ohci1394.c
--- RC13-rc7-base/drivers/ieee1394/ohci1394.c	2005-08-24 01:56:37.000000000 -0400
+++ current/drivers/ieee1394/ohci1394.c	2005-08-25 18:02:49.000000000 -0400
@@ -478,7 +478,6 @@
 	int num_ports, i;
 
 	spin_lock_init(&ohci->phy_reg_lock);
-	spin_lock_init(&ohci->event_lock);
 
 	/* Put some defaults to these undefined bus options */
 	buf = reg_read(ohci, OHCI1394_BusOptions);
@@ -3402,7 +3401,14 @@
 	/* We hopefully don't have to pre-allocate IT DMA like we did
 	 * for IR DMA above. Allocate it on-demand and mark inactive. */
 	ohci->it_legacy_context.ohci = NULL;
+	spin_lock_init(&ohci->event_lock);
 
+	/*
+	 * interrupts are disabled, all right, but... due to SA_SHIRQ we
+	 * might get called anyway.  We'll see no event, of course, but
+	 * we need to get to that "no event", so enough should be initialized
+	 * by that point.
+	 */
 	if (request_irq(dev->irq, ohci_irq_handler, SA_SHIRQ,
 			 OHCI1394_DRIVER_NAME, ohci))
 		FAIL(-ENOMEM, "Failed to allocate shared interrupt %d", dev->irq);
