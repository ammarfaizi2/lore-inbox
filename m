Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUKXAJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUKXAJp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 19:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbUKXAEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 19:04:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54441 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261369AbUKWRnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 12:43:19 -0500
Date: Tue, 23 Nov 2004 09:42:55 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: USB: uhci.c poll for wakeup events
Message-ID: <20041123094255.72ffe5e8@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forwarded from: Alan Stern

This patch causes the uhci driver in 2.4 to wake up the controller when
the root-hub polling loop detects a connect change event.  Normally the
wakeup is handled by an interrupt, but it turns out the recent Genesys
Logic GL880S UHCI controller is defective and does not generate the 
necessary IRQ.  With this patch the controller becomes useable.

[P3: The usb-uhci is not affected, apparently.]


Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

--- linux-2.4.27/drivers/usb/host/uhci.c.orig	2003-06-13 10:51:36.000000000 -0400
+++ linux-2.4.27/drivers/usb/host/uhci.c	2004-10-28 11:52:27.000000000 -0400
@@ -1981,6 +1981,8 @@
 	if ((data > 0) && (uhci->rh.send != 0)) {
 		dbg("root-hub INT complete: port1: %x port2: %x data: %x",
 			inw(io_addr + USBPORTSC1), inw(io_addr + USBPORTSC2), data);
+		if (uhci->is_suspended)
+			wakeup_hc(uhci);
 		uhci_call_completion(urb);
 	}
 


