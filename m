Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVCAWSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVCAWSe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 17:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbVCAWS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 17:18:29 -0500
Received: from gate.crashing.org ([63.228.1.57]:45250 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262089AbVCAWSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 17:18:04 -0500
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>,
       Linas Vepstas <linas@austin.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <42249A44.4020507@pobox.com>
References: <422428EC.3090905@jp.fujitsu.com>  <42249A44.4020507@pobox.com>
Content-Type: text/plain
Date: Wed, 02 Mar 2005 09:15:40 +1100
Message-Id: <1109715340.5680.34.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have been thinking about PCI system and parity errors, and how to 
> handle them.  I do not think this is the correct approach.
> 
> A simple retry is... too simple.  If you are having a massive problem on 
> your PCI bus, more action should be taken than a retry.

It goes beyond that, see below.

> In my opinion each driver needs to be aware of PCI sys/parity errs, and 
> handle them.  For network drivers, this is rather simple -- check the 
> hardware, then restart the DMA engine.  Possibly turning off 
> TSO/checksum to guarantee that bad packets are not accepted.  For SATA 
> and SCSI drivers, this is more complex, as one must retry a number of 
> queued disk commands, after resetting the hardware.
> 
> A new API handles none of this.

On IBM pSeries machine (and I'm trying to figure out an API to deal with
that generically for drivers), upon a PCI error (either MMIO error or
DMA error), the slot is put in isolation automatically.

>From this point, we can instruct the firmware to 1) re-enable MMIO, 2)
re-enable DMA, 3) proceed to a slot reset and re-enable MMIO & DMA.

That allows all sort of recovery strategies. However, obviously, not all
architectures provide those facilities.

So I'm looking into a way to expose a generic API to drivers that would
allow them to use those facilities when present, and/or fallback to
whatever they can do when not (or just retry or even no recovery).

I have some ideas, but am not fully happy with them yet. But part of the
problem is the notification of the driver.

Checking IOs is one thing, what to do once a failure is detected is
another. Also, we need asynchronous notification, since a driver may
well be idle, not doing any IO, while the bus segment on which it's
sitting is getting isolated because another card on the same segment (or
another function on the same card) triggered an error.

Then, we need at least several back-and-forth callbacks. I'm thinking
about an additional callback in pci_driver() with a message and a state
indicating what happened, and returning wether to proceed or not, I'll
try to write down the details in a later email.

Another issue finally is the type of error informations. Various systems
may provide various details, like some systems, upon a DMA error, can
provide you with the actual address that faulted. Those infos can be
very useful for diagnosing the issue (since some errors are actual bugs,
for example, we spent a lot of time chasing issues with e1000 vs.
barriers). An "error cookie" is I think a good idea, with eventually
various accessors to extract data from it, and maybe a function to dump
the content in ascii form in some buffer...

Ben.




