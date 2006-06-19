Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbWFSTPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbWFSTPq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 15:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbWFSTPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 15:15:46 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:24274 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932540AbWFSTPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 15:15:45 -0400
Date: Mon, 19 Jun 2006 21:15:43 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
Message-ID: <20060619191543.GA17187@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

while looking for loop places to apply cpu_relax() to, I found the
following gems:

arch/i386/kernel/crash.c/crash_nmi_callback():

        /* Assume hlt works */
        halt();
        for(;;);

        return 1;
}

arch/i386/kernel/doublefault.c/doublefault_fn():

        for (;;) /* nothing */;
}

Let's assume that we have a less than moderate fan failure that causes
the CPU to heat up beyond the critical limit...
That might result in - you guessed it - crashes or doublefaults.
In which case we enter the corresponding handler and do... what?
Exactly, we accelerate the CPUs happy march into bit heaven by letting it
execute a busy-loop under a non-working fan.
Thanks, your users will be very happy, I think ;)
(especially since it was "just" a simple fan failure that could have been
entirely remedied by buying another fan for $3)


The same thing applies to
arch/i386/kernel/smp.c/stop_this_cpu(), albeit there it's less catastrophic
due to most likely normal working conditions there.

IMHO on any critical CPU failure we should:
- try to log it (might be difficult with a broken CPU, though)
- optionally somehow directly alert the user
- STOP the system, COMPLETELY (that way people WILL take notice, hopefully
  before it's too late and actual damage will have occurred)
- make DAMN SURE that the (possibly already broken) CPU won't have a
  less than nice time once the system is stopped

Am I completely missing something here?

If this is an issue, then maybe we should consolidate those places into
one function that safely(!) halts a CPU, optionally disabling APIC etc.

Oh, and once you finished processing my mail here, you could optionally
also look at my report about almost unusably broken USB:
http://lkml.org/lkml/2006/6/19/54
(no replies yet despite advanced breakage)

Thanks!

Andreas Mohr
