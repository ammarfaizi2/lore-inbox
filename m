Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbTL3NVv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 08:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbTL3NVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 08:21:51 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:22149 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262446AbTL3NVs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 08:21:48 -0500
Date: Tue, 30 Dec 2003 18:56:15 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, rusty@au1.ibm.com,
       lhcs-devel@lists.sourceforge.net
Subject: Re: in_atomic doesn't count local_irq_disable?
Message-ID: <20031230185615.A9292@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <3FF044A2.3050503@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FF044A2.3050503@colorfullife.com>; from manfred@colorfullife.com on Mon, Dec 29, 2003 at 04:13:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 04:13:38PM +0100, Manfred Spraul wrote:
> 
> What do you mean with unable? Could you post what was printed?

All I used to get was :

"Debug: sleeping function called from invalid context
at include/linux/rwsem.h:45
in_atomic: 0, irqs_disabled(): 1
Call Trace:"

That's it. Nothing more. Looks like it could not read the
stack at that point and hence couldn't dump the stack traceback.

I now inserted some printk's in do_page_fault
to print regs->eip before calling down_read i.e:

        /*
         * If we're in an interrupt, have no user context or are running in an
         * atomic region then we must not take the fault..
         */
        if (in_atomic() || !mm)
                goto bad_area_nosemaphore;

+       if (irqs_disabled()) {
+               printk("BAD Access at (EIP) %08lx\n", regs->eip);
+               printk("Bad Access at virtual address %08lx\n",address);
+       }

        down_read(&mm->mmap_sem);


This is what I got now when I reran my stress test:


BAD Access at (EIP) c011c1b5
Bad Access at virtual address 05050501
Debug: sleeping function called from invalid context at include/linux/rwsem.h:47
in_atomic():0, irqs_disabled():1
Call Trace:
 [<c011fd66>] __might_sleep+0x86/0x90
 [<c01378f6>] module_unload_free+0x36/0xe0
 [<c011b889>] do_page_fault+0xc9/0x573
 [<c013f1df>] buffered_rmqueue+0x10f/0x120
 [<c013f2ba>] __alloc_pages+0xca/0x360
 [<c0148d64>] do_anonymous_page+0x1c4/0x1d0
 [<c011b7c0>] do_page_fault+0x0/0x573
 [<c01378f6>] module_unload_free+0x36/0xe0
 [<c0109d6d>] error_code+0x2d/0x38
 [<01010101>] 

BAD Access at (EIP) c0139934
Bad Access at virtual address 0101011f


The first EIP (c011c1b5) is inside search_extable!!
The second EIP (c0139934) is inside get_ksymbol() ...

I suspect the second happened when kdb tried decoding the (first) exception
address and hence is secondary here ..

The stack trace that follows the first exception seems to be
totally bogus(?) .. I suspect the first exception 
happened in search_extable when looking up some module exception
tables(?) ..Because search_module_extables() calls search_extable() with 
interrupts disabled ..

I think this points to some module unload (race) issues during hotplug ..

Rusty, any comments?







> 
> I guess it's a get_user within either spin_lock_irq() or local_irq_disable. Without more info about the context, it's difficult to figure out if the page fault handler or the caller should be updated


Given the context above, I feel it would be correct for
do_page_fault() to avoid calling down_read() when IRQs are
disabled and instead just branch to bad_nosemaphore.
(as Rusty seems to concur) .. However, schedule() doesn't
seem to actually trap the case when it is called with interrupts disabled (as using local_irq_disable)?

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560033
