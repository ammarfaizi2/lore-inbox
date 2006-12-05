Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967748AbWLEXZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967748AbWLEXZm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 18:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967752AbWLEXZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 18:25:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47618 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967748AbWLEXZl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 18:25:41 -0500
Message-ID: <4575FF08.2030100@redhat.com>
Date: Tue, 05 Dec 2006 18:21:44 -0500
From: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: linux-kernel@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 0/3] New firewire stack
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com> <20061205184921.GA5029@martell.zuzino.mipt.ru>
In-Reply-To: <20061205184921.GA5029@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> On Tue, Dec 05, 2006 at 12:22:29AM -0500, Kristian Høgsberg wrote:
>> I'm announcing an alternative firewire stack that I've been working on 
>> the last few weeks.
> 
> Is mainline firewire so hopeless, that you've decided to rewrite it? Could
> you show some ugly places in it?

Yes.  I'm not doing this lightheartedly.  It's a lot of work and it will
introduce regressions and instability for a little while.

My main point about ohci1394 (the old stacks PCI driver) is, that if you
really want to fix the issues with this driver, you have to shuffle the code
around so much that you'll introduce as many regressions as a clean rewrite.
The big problems in the ohci1394 drivers is the irq_handler, bus reset
handling and config rom handling.  These are some of the strong points of
fw-ohci.c:

  - Rock solid handling of generations and node IDs around bus resets.
    The only way to handle this atomically is to pass the generation
    count along all the way to the transmit function in the low-level
    driver.  The linux1394 low level driver API is broken in this
    respect.

  - Better handling of self ID receive and possible recursive bus
    resets.  Successive bus resets could overwrite the self ID DMA
    buffer, while we read out the contents.  The OHCI specification
    recommends a method similiar to linux/seqlock.h for reading out
    self IDs, to ensure we get a consistent result.

  - Much simpler bus reset handling; we only subscribe to the
    selfIDComplete interrupt and don't use the troublesome busReset
    interrupt.  Rely on async transmit context to not send data while
    busReset event bit is set.

  - Atomic updates of config rom contents as specified in section 5.5.6
    in the OHCI specification. The contents of the ConfigROMheader,
    BusOptions and ConfigROMmap registers are updated atomically by the
    controller after a reset.

The OHCI specification describes a number of the techniques to ensure race
free operation for the above cases, but the ohci1394 driver generally doesn't
use any of these.  If you want to see ugly code look at the ohci1394 irq
handler.  Much of the uglyness comes from trying to handle the busReset
interrupt, so that the mid-level linux1394 stack can fail I/O while the bus
reset takes place.  Now, OHCI hardware already reliably fails I/O during bus
reset, so there is no need to complicate the core stack with this extra state,
and the OHCI driver becomes much simpler and more reliable, since we now just
need to know when a bus reset has successfully completed.

Fixing this problem requires significant changes to the ohci1394 driver and
the mid-level stack, and will destabilize things until we've figure out how to
work around the odd flaky device out there.  Similar problems exists related
to sending packets without bus reset races, updating the config rom, and
reporting self ID packets and all require significant changes to the core
stack and ohci1394.  All taken together the scale tips towards a rewrite.

Another point is the various streaming drivers.  There used to be 5 different
userspace streaming APIs in the linux1394: raw1394, video1394, amdtp, dv1394
and rawiso.  Recently, amdtp (audio streaming) has been removed, since with
the rawiso interface, this can be done in userspace.  However the remaining 4
interfaces have slightly disjoint feature sets and can't really be phased out.
  In the long run, supporting 4 different interfaces that does almost the same
thing isn't feasible.  The streaming interface in my new stack (only
transmission implemented at this point) can replace all of these interfaces.

Finally, some parts aren't actually rewritten, just ported over and
refactored.  This is the case for the SBP-2 driver.  Functionally, my
fw-sbp2.c is identical to sbp2.c in the current stack, but I've changed it to
work with the new interfaces and cleaned up some of the redundancy.

> We can end up with two not quite working sets of firewire drivers your way.
> 
You can patch up the current stack to be less flaky, and Stefan has been doing
a great job at that lately, but it's still fundamentally broken in the ways
described above.

While my stack may less stable for the first couple of weeks, these are
transient issues, such as, say, lack of big endian testing, that are easily
fixed.  In the long run this new stack is much more maintainable and has a
bigger potential for stability.

Kristian

