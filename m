Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUCFFtb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 00:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUCFFtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 00:49:31 -0500
Received: from palrel12.hp.com ([156.153.255.237]:22402 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261505AbUCFFt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 00:49:26 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16457.26208.980359.82768@napali.hpl.hp.com>
Date: Fri, 5 Mar 2004 21:49:20 -0800
To: David Brownell <david-b@pacbell.net>
Cc: davidm@hpl.hp.com, Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, pochini@shiny.it
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
In-Reply-To: <404959A5.6040809@pacbell.net>
References: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>
	<20031028013013.GA3991@kroah.com>
	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>
	<3FA12A2E.4090308@pacbell.net>
	<16289.29015.81760.774530@napali.hpl.hp.com>
	<16289.55171.278494.17172@napali.hpl.hp.com>
	<3FA28C9A.5010608@pacbell.net>
	<16457.12968.365287.561596@napali.hpl.hp.com>
	<404959A5.6040809@pacbell.net>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 05 Mar 2004 20:55:01 -0800, David Brownell <david-b@pacbell.net> said:
  >> Turns out it's this patch that was causing the crashes:

  >> http://linux.bkbits.net:8080/linux-2.5/cset@1.1619.1.17

  David.B> Maybe in 2.6.4-rc2... but not in 2.6.0-test{8,9}!!

Of course.  What I'm saying is that in 2.6.0-test{8,9} it was rare to
trigger the problem (only with BTC keyboard) and the change above made
it trivial to trigger the keyboard.  Basically, your fix in
cset 1.1619.1.17 made it more common for stuff to be unlinked in
the "deferred" (proper) manner and that made it much more likely to
trigger the bug.

  David.B> The reason I keep ending up thinking that readl-elimination
  David.B> must be OK (me agreeing with Martin) is that the memory
  David.B> there came from dma_alloc_coherent() ... so if anything's
  David.B> wrong, it'd be at most lack of rmb(), not a stale-cache
  David.B> kind of thing.

It's not an issue of DMA coherency, it's an issue of DMA vs. interrupt
ordering.  I believe the WHD interrupt is arriving at the CPU before
the DMA update to the HCCA is done.  In my second patch, the readl()
at the beginning of the interrupt ensures that the DMA update to
the HCCA is completed before the readl() returns data.

  David.B> It reads the frame number directly from the controller, so
  David.B> it's not possible that it can be so stale that an rmb()
  David.B> wouldn't fix sequencing issues.

Eh, it's read like this:

   #define OHCI_FRAME_NO(hccap) ((u16)le32_to_cpup(&(hccap)->frame_no))

   finish_unlinks (ohci, OHCI_FRAME_NO(ohci->hcca), ptregs);

The HCCA is in host memory.

  >> - HCD ends up dereferencing a bad pointer and ends up reading
  >> from address 0xf0000000, which on our ia64 machines is a
  >> read-only area, which then results in a machine-check abort

  David.B> I'm surprised that DMA from a read-only area would be a
  David.B> problem!  :) If OHCI is getting a PCI error, I'd expect a
  David.B> "UE" IRQ.

You must have not received my follow-up message.  There was a typo in
my message: it was supposed to say "write-only" area.

  David.B> I still suspect some problem in the HID code.  But right
  David.B> now I'm quite certain of a recent-ish OHCI issue.

I'm 99% certain that the problem I saw back in October (BTC keyboard)
was identical to the one triggered by cset 1.1619.1.17.

	--david
