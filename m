Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbUCFCIx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 21:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbUCFCIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 21:08:52 -0500
Received: from palrel12.hp.com ([156.153.255.237]:49055 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261202AbUCFCIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 21:08:45 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16457.12968.365287.561596@napali.hpl.hp.com>
Date: Fri, 5 Mar 2004 18:08:40 -0800
To: David Brownell <david-b@pacbell.net>
Cc: davidm@hpl.hp.com, Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, pochini@shiny.it
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
In-Reply-To: <3FA28C9A.5010608@pacbell.net>
References: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>
	<20031028013013.GA3991@kroah.com>
	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>
	<3FA12A2E.4090308@pacbell.net>
	<16289.29015.81760.774530@napali.hpl.hp.com>
	<16289.55171.278494.17172@napali.hpl.hp.com>
	<3FA28C9A.5010608@pacbell.net>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, finally a bit of progress.  If you remember back in October 2003 I
reported:

 > One-line summary: plug-in your USB keyboard, see your machine die.

 > So, I have this non-name USB keyboard (with built-in 2-port USB
 > hub) which reliably crashes 2.6.0-test{8,9} on both x86 and ia64.
 > In retrospect, it's clear to me that the same keyboard also
 > occasionally crashes 2.4 kernels, but there the problem appears
 > more seldom.  Perhaps once in 10 reboots and once the machine is
 > booted and the keyboard is running, it keeps on working.  The
 > keyboard in question is a BTC 5141H.

After this, I spent a (small) amount of time looking over the HID code
etc to see what could be causing it.  I could find nothing wrong so I
gave up, connected another USB keyboard, and basically ignored the
problem.  In retrospect, that was Good Thinking, because I was
apparently looking at the wrong code: the problem _does_ appear to be
coming from the USB HCD, not from the HIDeous code.

Specifically, after upgrading to 2.6.4-rc2, _all_ of the ia64 machines
I tested would crash as soon as they had _any_ USB keyboard plugged
in.  That is, the problem no longer was limited to the BTC keyboard,
which is special because it has a built-in hub.  This was encouraging.

Turns out it's this patch that was causing the crashes:

 http://linux.bkbits.net:8080/linux-2.5/cset@1.1619.1.17

That was strange, because even to my USB-untrained eye the patch
looked obviously correct.  However, I think the root cause of the
problem really has to do with a race-condition between the controller
and the driver.  In particular, if I apply the patch below, my USB
keyboards (including the BTC keyboard) work just fine!

===== drivers/usb/host/ohci-q.c 1.48 vs edited =====
--- 1.48/drivers/usb/host/ohci-q.c	Tue Mar  2 05:52:46 2004
+++ edited/drivers/usb/host/ohci-q.c	Fri Mar  5 17:25:55 2004
@@ -438,7 +451,7 @@
 	 * behave.  frame_no wraps every 2^16 msec, and changes right before
 	 * SF is triggered.
 	 */
-	ed->tick = OHCI_FRAME_NO(ohci->hcca) + 1;
+	ed->tick = OHCI_FRAME_NO(ohci->hcca) + 2;
 
 	/* rm_list is just singly linked, for simplicity */
 	ed->ed_next = ohci->ed_rm_list;

However, I think the root-cause of the problem may be this optimization
in ohci_irq():

	/* we can eliminate a (slow) readl() if _only_ WDH caused this irq */

Indeed, if I apply this patch instead:

===== drivers/usb/host/ohci-hcd.c 1.56 vs edited =====
--- 1.56/drivers/usb/host/ohci-hcd.c	Tue Mar  2 05:52:40 2004
+++ edited/drivers/usb/host/ohci-hcd.c	Fri Mar  5 17:45:09 2004
@@ -584,7 +584,7 @@
  	int			ints; 
 
 	/* we can eliminate a (slow) readl() if _only_ WDH caused this irq */
-	if ((ohci->hcca->done_head != 0)
+	if (0 && (ohci->hcca->done_head != 0)
 			&& ! (le32_to_cpup (&ohci->hcca->done_head) & 0x01)) {
 		ints =  OHCI_INTR_WDH;
 

there are no crashes either.

So my theory is that I was seeing this sequence of events:

 - HCD signals WDH interrupt & sends DMA to update the frame number in
   the host-controller communication area (HCCA)

 - host gets interrupt, but skips readl() and hence reads a stale
   frame number N instead of the up-to-date value (N+1)

 - HCD cancels a transfer descriptor (TD), moves it to the "remove list"
   and calculates the frame number at which it can be remove from
   the host-controller's list as N+1

 - SOF interrupt arrives (probably was pending already?)

 - interrupt handler does a readl() and now sees the updated
   frame-number N+1

 - HCD sees that the cancelled TD's time stamp N+1 is <= the current
   current time stamp (N+1) and goes ahead and removes it from the
   host-list, while the controller is still looking at the entry being
   removed

 - HCD ends up dereferencing a bad pointer and ends up reading from
   address 0xf0000000, which on our ia64 machines is a read-only area,
   which then results in a machine-check abort

Does this sound plausible?

What beats me is why UHCI would have the same issue.  I know even less
about UHCI than I do about OHCI but perhaps there is a similar
problem.

	--david
