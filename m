Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbUCAXSi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 18:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbUCAXSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 18:18:35 -0500
Received: from topaz.cx ([66.220.6.227]:59281 "EHLO mail.topaz.cx")
	by vger.kernel.org with ESMTP id S261480AbUCAXSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 18:18:33 -0500
Date: Mon, 1 Mar 2004 18:18:23 -0500
From: Chip Salzenberg <chip@pobox.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.3: re-enable UHCI interrupts on APM resume
Message-ID: <20040301231822.GB14500@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: OUTLOOK ERROR: Message text violates P.A.T.R.I.O.T. act
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote the below patch which fixes a lockup problem with USB
on the ThinkPad A30.  It's small, helpful, and not ThinkPad-specific.

So, although it will already be part of the next USB merge, I wanted
you to see it.  Maybe you'll find it worth including in 2.6.4.

--- 2.6/drivers/usb/host/uhci-hcd.c.orig	Fri Feb 20 15:04:41 2004
+++ 2.6/drivers/usb/host/uhci-hcd.c	Sun Feb 22 15:23:59 2004
@@ -2471,9 +2471,16 @@
 
 	pci_set_master(to_pci_dev(uhci_dev(uhci)));
 
-	if (uhci->state == UHCI_SUSPENDED)
+	if (uhci->state == UHCI_SUSPENDED) {
+
+		/*
+		 * Some systems clear the Interrupt Enable register during
+		 * PM suspend/resume, so reinitialize it.
+		 */
+		outw(USBINTR_TIMEOUT | USBINTR_RESUME | USBINTR_IOC |
+				USBINTR_SP, uhci->io_addr + USBINTR);
 		uhci->resume_detect = 1;
-	else {
+	} else {
 		reset_hc(uhci);
 		start_hc(uhci);
 	}


-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K
