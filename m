Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbVBJBAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbVBJBAo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 20:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVBJBAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 20:00:44 -0500
Received: from gate.crashing.org ([63.228.1.57]:46771 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261995AbVBJBA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 20:00:27 -0500
Subject: Re: PCI Error reporting & recovery
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <420876DC.3040201@jp.fujitsu.com>
References: <1107835865.7687.78.camel@gaston>
	 <420876DC.3040201@jp.fujitsu.com>
Content-Type: text/plain
Date: Thu, 10 Feb 2005 11:59:38 +1100
Message-Id: <1107997178.7733.184.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-08 at 17:22 +0900, Hidetoshi Seto wrote:
> Hi, Ben.
> 
> How kind of you to remember.

Well, mailing lists archives did remember for me :)

> Now I have a rewrite of the previous "clear/read_pci_errors" patch.
> The new one adopts iomap infrastructure, considering generality,
> capability and so on. And the part of its implementation for IA64 is
> now under test using converted SCSI/NIC drivers.

Ok. I still wonder if we want something that works without the iomap
stuff though...

> Soon I'll post the patch to lkml(+IA64ML) with some explanation of the
> change and the result of test, and will beg/hear comments.

Ok, can you post what you have now so I can get an idea of where you are
going ?

> Interesting.
> Actually I don't have enough knowledge about platforms other than IA32/64,
> so it will be helpful if you could tell me practical matters about ppc64
> etc.

Ok, so here's how things work on ppc64:

There is usually one controlling bridge per slot (with individual error
management at the slot level), though it's possible that several devices
end up on the same segment (think cards with P2P bridges on them).

When any error happens, the slot automatically isolates itself. That is
reads return all 1's and writes get dropped. At this point, we can query
the firmware for error informations.

Currently, our IO accessors (readX/writeX) will do this "query"
automatically when the IOs return all 1's, and will log an event that is
treated later at task time by some error management.

We have the possibility, via the firmware, of re-enabling IO (but not
DMA) on the slot, to do, for example, diagnostic to the hardware,
re-enabling DMA, or reset the slot (trigger the PCI reset). This means
we can provide means of recovery for drivers who have a proper API to
hook on that (which is what I'd like to define).

It has to be an asynchronous  API, that is all drivers on a given
"isolated" segment (usually only one) get notifed of errors, and may be
given a chance to react.

I'm not sure at this point what is the best API to provide here since we
may have more than one driver on the slot. I suppose we must ensure all
drivers have ack'ed the isolation event before we allow one of them to
re-enable IO operations or ask for a reset. And since several drivers
have to "tell" what they can do before anything is actually done (IO
re-enable, slot reset, ...), we need some kind of async interface, maybe
via a new callback in the pci_driver structure.

I think the case of devices sharing a segment is rare enough not to
impact the design too much. One thing is the PCI layer must know a
driver that is error management aware from one that is not (maybe by the
presence of the new callback ?).

Once the error occurs on the slot, and has been "detected" by a driver
on the segment, we could then call their error callbacks mgmnt
indicating the slot state (isolated, still enabled, been reset)
depending on what the platform supports.

The driver can then do whatever it needs and return a result code
indicating that 0) - can proceed normally (did recover), 1) can't
proceed in the current state (that is, needs IOs re-enabled if isolated,
or need a reset).

The system would then go through each step it's capable of, and call
drivers with the state, until all drivers agree (or a driver gives up
completely, in which case it's just left dead).

For example, ppc64 would first call the callback with slot isolated. The
driver would use this opportunity to cleanup stuff and typically return
"1" (can't proceed in the current state) (or an error to "give up").
Then, we would turn back IOs on and call the driver again, which would
then return either 0 (if it diagnosed & recovered fully) or "1 if it
wants the slot to be reset, etc...

I'm not sure what to do if one driver can recover (returns 0) at the "io
enabled" stage but another can't (returns "1"). We could either give up
on the second one, or reset the slot.

In the end, a last message has to be sent telling to restart operations
(this shouldn't be done as part of the "IO re-enabled" messages since
because of the above another driver may have rejected the state and
asked for a reset).

Unless somebody has a better idea...

Now, the actual error informations can be quite rich. We can get to the
type of error (master abort, target abort, data parity, address parity,
etc... and I think in some cases, we can know the address of the access
that triggered the error.

Ben.


