Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUCFHVm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 02:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbUCFHVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 02:21:42 -0500
Received: from palrel12.hp.com ([156.153.255.237]:5297 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261606AbUCFHVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 02:21:37 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16457.31740.99944.563029@napali.hpl.hp.com>
Date: Fri, 5 Mar 2004 23:21:32 -0800
To: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>,
       vojtech@suse.cz, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       pochini@shiny.it, davidm@hpl.hp.com
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
In-Reply-To: <16457.26208.980359.82768@napali.hpl.hp.com>
References: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>
	<20031028013013.GA3991@kroah.com>
	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>
	<3FA12A2E.4090308@pacbell.net>
	<16289.29015.81760.774530@napali.hpl.hp.com>
	<16289.55171.278494.17172@napali.hpl.hp.com>
	<3FA28C9A.5010608@pacbell.net>
	<16457.12968.365287.561596@napali.hpl.hp.com>
	<404959A5.6040809@pacbell.net>
	<16457.26208.980359.82768@napali.hpl.hp.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 5 Mar 2004 21:49:20 -0800, David Mosberger <davidm@linux.hpl.hp.com> said:

  David> It's not an issue of DMA coherency, it's an issue of DMA
  David> vs. interrupt ordering.  I believe the WHD interrupt is
  David> arriving at the CPU before the DMA update to the HCCA is
  David> done.

Actually, it looks like I misunderstood the OHCI spec on first reading.
It seems like the causal relationship goes like this:

 (1) Start of Frame -> (2) update HccaFrameNumber -> (3) trigger SF interrupt

Now, suppose you get a WDH interrupt between (1) and (2).  You'd read
the old frame-number yet by the time the interrupt from (3) arrives
the HC might already be accessing the ED that you're about to remove.

If this is correct, then the first patch is probably a better
approach:

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

This actually makes tons of sense if you think of it like jiffies: you
need to make sure you delay at least one full frame-interval.  If you
set the tick to "+ 1" and the current tick is almost over, that
requirement is violated.  Setting it to "+ 2" should be safe.  The
only problem I can think of is if the delay between point (1) and (2)
were to exceed one frame-interval (1 msec).  While unlikely, the right
PCI topology and heavy bus traffic perhaps could cause such delays.
However, even then it's probably OK because the HC would presumably
stall when trying to update the HccaFrameNumber the second time and
the previous update hasn't completed yet.

Here is one little piece of evidence that's consistent with this
explanation: last week I tried to rip some audio tracks off a CD.
With PIO, this caused interrupts to get delayed 2-3msec and that
caused all kinds of weird effects on the USB bus.  Mostly, I'd
suddenly lose the keyboard or the mouse, though reconnecting them
would "fix" the problem for a short time.

	--david
