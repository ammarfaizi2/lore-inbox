Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758430AbWK0RLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758430AbWK0RLt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 12:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758433AbWK0RLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 12:11:48 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:27799 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1758430AbWK0RLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 12:11:48 -0500
Message-ID: <456B1C52.4040305@s5r6.in-berlin.de>
Date: Mon, 27 Nov 2006 18:11:46 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Robert Crocombe <rcrocomb@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux1394-devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: ieee1394: host adapter disappears on 1394 bus reset
References: <e6babb600611220731p67b15e51q95f524683070ae80@mail.gmail.com>	 <4564C4C7.5060403@s5r6.in-berlin.de>	 <e6babb600611221628nd9430c6pe3ab36e9862b3b6d@mail.gmail.com> <e6babb600611270739k27e1ed51va3cd82ccfa0b77ff@mail.gmail.com>
In-Reply-To: <e6babb600611270739k27e1ed51va3cd82ccfa0b77ff@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/2006 4:39 PM, Robert Crocombe wrote:
> On 11/22/06, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
>> One thing you could try next is to add a debug logging macro which
>> prints the contents of OHCI1394_IntEventClear, OHCI1394_IntEventSet, and
>> OHCI1394_IntMaskSet, right after ohci1394's call to
>> hpsb_selfid_complete. (I'm merely poking in the dark here.)
> 
> I think you've got something!  I managed to provoke failure from 3 of
> the 5 interfaces in a single burst of reset clicking!  And yes, all 3
> failed interfaces are on the Indigita card, and no, the Fireboard has
> never failed.
> 
> The last thing I see from the failed interfaces is this:
> 
> Nov 27 08:25:51 spanky kernel: ohci1394: fw-host3: PhyReqFilter=0000000000000000
> Nov 27 08:25:51 spanky kernel: ohci1394: fw-host3: IntEventClear
> 00000000 IntEventSet 6ffdc33f IntMaskSet 00000000

Zero bits in the mask mean that the chip will not generate a processor
interrupt for the type of event represented by the bit. And the
difference between what can be read from IntEventClear and IntEventSet
is that the former is the masked version of the latter.

You probably noticed yourself that ohci1394's interrupt handler
explicitly enables some bits in the interrupt mask shortly before the
call to hpsb_selfid_complete. This means there is either something going
wrong during hpsb_selfid_complete (which wouldn't surprise me, since
there are busy wait loops involved) or the write access to the interrupt
mask wasn't flushed soon enough.

> which looks very different from the entries by the interfaces that
> survive (these are the lines immediately before the one above)
> 
> Nov 27 08:25:51 spanky kernel: ohci1394: fw-host4: IntEventClear
> 00000000 IntEventSet 04508000 IntMaskSet 818300f3
> Nov 27 08:25:51 spanky kernel:
> Nov 27 08:25:51 spanky kernel: ohci1394: fw-host2: IntEventClear
> 00000000 IntEventSet 04508000 IntMaskSet 818300f3
> Nov 27 08:25:51 spanky kernel:

This mask looks much better.

> I'm not sure if this says anything to you except "hey, don't use those
> Indigita cards".  The problem is, I can't get the number of ports I
> need using only Fireboards (I think I need 6, and I have 5 PCI slots
> but need to use some of the other slots).
[...]

As you wrote, both cards use the same link layer controller, although
they could have different chip revisions. The controllers of the
Indigita card sit behind the bridge, which /perhaps/ contributes to the
problem. But perhaps more importantly, how are the IRQs distributed?
# cat /proc/interrupts

Anyway, I think a driver problem is more likely the cause than a
potential hardware issue.

Please add
	reg_read(ohci, OHCI1394_IntMaskSet);
right before hpsb_selfid_complete(host, phyid, isroot);. This will flush
the previous reg_write before hpsb_selfid_complete starts doing
unspeakable things.

And I should finally start to work on a fix for hpsb_selfid_complete,
i.e. move all the time-consuming but less time-critical parts off into a
tasklet or workqueue job...


Question to others:

ohci1394.c::ohci_irq_handler() is taking a per-host spinlock around some
register reads and writes, particularly:
...
	spin_lock_irqsave(&ohci->event_lock, flags);
	event = reg_read(ohci, OHCI1394_IntEventClear);
	reg_write(ohci, OHCI1394_IntEventClear, event &
						~OHCI1394_busReset);
	spin_unlock_irqrestore(&ohci->event_lock, flags);
...
	spin_lock_irqsave(&ohci->event_lock, flags);
	reg_write(ohci, OHCI1394_IntMaskClear, OHCI1394_busReset);
	run_an_insane_loop_as_an_alleged_fix_for_dorky_hardware;
	spin_unlock_irqrestore(&ohci->event_lock, flags);
...
	spin_lock_irqsave(&ohci->event_lock, flags);
	reg_write(ohci, OHCI1394_IntEventClear, OHCI1394_busReset);
	reg_write(ohci, OHCI1394_IntMaskSet, OHCI1394_busReset);
	spin_unlock_irqrestore(&ohci->event_lock, flags);

I think these spinlocks are totally useless 1. because
ohci_irq_handler() is only called as the hardware interrupt servicing
routine and 2. because they don't flush the register write operations.
Right? Wrong? [Ohci1394's reg_write() is a writel().]
-- 
Stefan Richter
-=====-=-==- =-== ==-==
http://arcgraph.de/sr/
