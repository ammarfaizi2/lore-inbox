Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264165AbTIIOJv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 10:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264170AbTIIOJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 10:09:51 -0400
Received: from ida.rowland.org ([192.131.102.52]:3844 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264165AbTIIOJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 10:09:49 -0400
Date: Tue, 9 Sep 2003 10:09:47 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
cc: David Brownell <david-b@pacbell.net>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: USB: irq 11: nobody cared!
In-Reply-To: <200309091454.32705.arekm@pld-linux.org>
Message-ID: <Pine.LNX.4.44L0.0309090959590.887-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Sep 2003, Arkadiusz Miskiewicz wrote:

> On Monday 08 of September 2003 18:38, David Brownell wrote:
> > Try changing uhci_reset() so it calls hc_reset() first,
> > and then does the config space write to get rid of "legacy
> > support mode".   That's the sequence it used before, which
> > seems odd because it's resetting hardware that it's not yet
> > responsible for.  Maybe the hc_reset() code should turn off
> > that legacy mode, and do some IRQ blocking.
> Unfortunately that didn't change a thing. Still I see ,,disable irq #xx'' and 
> usb is not working properly here.

reset_hc() doesn't do very much; it turns the controller off but doesn't
disable interrupts.  If the problem is extraneous interrupts arriving
during this time, maybe disabling them is the answer.  Try the patch
below.

Alan Stern


===== uhci-hcd.c 1.65 vs edited =====
--- 1.65/drivers/usb/host/uhci-hcd.c	Wed Sep  3 11:47:18 2003
+++ edited/drivers/usb/host/uhci-hcd.c	Tue Sep  9 10:05:38 2003
@@ -1960,8 +1960,9 @@
 {
 	unsigned int io_addr = uhci->io_addr;
 
-	/* Global reset for 50ms */
+	/* Disable interrupts and global reset for 50ms */
 	uhci->state = UHCI_RESET;
+	outw(0, io_addr + USBINTR);
 	outw(USBCMD_GRESET, io_addr + USBCMD);
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout((HZ*50+999) / 1000);


