Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264481AbTLaNZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 08:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbTLaNZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 08:25:27 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:56218 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264481AbTLaNZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 08:25:19 -0500
Date: Wed, 31 Dec 2003 18:59:59 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: manfred@colorfullife.com, rusty@au1.ibm.com
Subject: BUG in x86 do_page_fault?  [was Re: in_atomic doesn't count local_irq_disable?]
Message-ID: <20031231185959.A9041@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <3FF044A2.3050503@colorfullife.com> <20031230185615.A9292@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031230185615.A9292@in.ibm.com>; from vatsa@in.ibm.com on Tue, Dec 30, 2003 at 06:56:15PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	in_atomic() doesn't seem to return true
in code sections where IRQ's have been disabled (using 
local_irq_disable).

As a result, I think do_page_fault() on x86 needs to 
be updated to note this fact:


--- fault.c.org Wed Dec 31 18:34:18 2003
+++ fault.c     Wed Dec 31 18:35:02 2003
@@ -259,7 +259,7 @@
         * If we're in an interrupt, have no user context or are running in an
         * atomic region then we must not take the fault..
         */
-       if (in_atomic() || !mm)
+       if (in_atomic() || irqs_disabled() || !mm)
                goto bad_area_nosemaphore;

        down_read(&mm->mmap_sem);


For ex: cosider some kernel code like this:


	local_irq_disable();

	/* Do something which leads to a page fault */

	local_irq_enable(); 

Such a code is buggy and should result in a oops(?) when
the page fault happens.

Without the above patch, the page fault handler 
will try acquiring the mmap_sem semaphore and can potentially
sleep inside schedule (with IRQs disabled).


Also isn't the same change  required in scheduler()
where it whines if called from a code section which is supposed to be 
atomic.

--- sched.c.org Wed Dec 31 18:49:10 2003
+++ sched.c     Wed Dec 31 18:49:43 2003
@@ -1507,7 +1507,7 @@
         * Otherwise, whine if we are scheduling when we should not be.
         */
        if (likely(!(current->state & (TASK_DEAD | TASK_ZOMBIE)))) {
-               if (unlikely(in_atomic())) {
+               if (unlikely(in_atomic() || irqs_disabled())) {
                        printk(KERN_ERR "bad: scheduling while atomic!\n");
                        dump_stack();
                }



On Tue, Dec 30, 2003 at 06:56:15PM +0530, Srivatsa Vaddagiri wrote:
> On Mon, Dec 29, 2003 at 04:13:38PM +0100, Manfred Spraul wrote:
> > 
> > What do you mean with unable? Could you post what was printed?
> 
> All I used to get was :
> 
> "Debug: sleeping function called from invalid context
> at include/linux/rwsem.h:45
> in_atomic: 0, irqs_disabled(): 1
> Call Trace:"
> 
> That's it. Nothing more. Looks like it could not read the
> stack at that point and hence couldn't dump the stack traceback.
> 
> I now inserted some printk's in do_page_fault
> to print regs->eip before calling down_read i.e:
> 
>         /*
>          * If we're in an interrupt, have no user context or are running in an
>          * atomic region then we must not take the fault..
>          */
>         if (in_atomic() || !mm)
>                 goto bad_area_nosemaphore;
> 
> +       if (irqs_disabled()) {
> +               printk("BAD Access at (EIP) %08lx\n", regs->eip);
> +               printk("Bad Access at virtual address %08lx\n",address);
> +       }
> 
>         down_read(&mm->mmap_sem);
> 
> 
> This is what I got now when I reran my stress test:
> 
> 
> BAD Access at (EIP) c011c1b5
> Bad Access at virtual address 05050501
> Debug: sleeping function called from invalid context at include/linux/rwsem.h:47
> in_atomic():0, irqs_disabled():1
> Call Trace:
>  [<c011fd66>] __might_sleep+0x86/0x90
>  [<c01378f6>] module_unload_free+0x36/0xe0
>  [<c011b889>] do_page_fault+0xc9/0x573
>  [<c013f1df>] buffered_rmqueue+0x10f/0x120
>  [<c013f2ba>] __alloc_pages+0xca/0x360
>  [<c0148d64>] do_anonymous_page+0x1c4/0x1d0
>  [<c011b7c0>] do_page_fault+0x0/0x573
>  [<c01378f6>] module_unload_free+0x36/0xe0
>  [<c0109d6d>] error_code+0x2d/0x38
>  [<01010101>] 
> 
> BAD Access at (EIP) c0139934
> Bad Access at virtual address 0101011f
> 
> 
> The first EIP (c011c1b5) is inside search_extable!!
> The second EIP (c0139934) is inside get_ksymbol() ...
> 
> I suspect the second happened when kdb tried decoding the (first) exception
> address and hence is secondary here ..
> 
> The stack trace that follows the first exception seems to be
> totally bogus(?) .. I suspect the first exception 
> happened in search_extable when looking up some module exception
> tables(?) ..Because search_module_extables() calls search_extable() with 
> interrupts disabled ..
> 
> I think this points to some module unload (race) issues during hotplug ..
> 
> Rusty, any comments?
> 
> 
> 
> 
> 
> 
> 
> > 
> > I guess it's a get_user within either spin_lock_irq() or local_irq_disable. Without more info about the context, it's difficult to figure out if the page fault handler or the caller should be updated
> 
> 
> Given the context above, I feel it would be correct for
> do_page_fault() to avoid calling down_read() when IRQs are
> disabled and instead just branch to bad_nosemaphore.
> (as Rusty seems to concur) .. However, schedule() doesn't
> seem to actually trap the case when it is called with interrupts disabled (as using local_irq_disable)?
> 
> -- 
> 
> 
> Thanks and Regards,
> Srivatsa Vaddagiri,
> Linux Technology Center,
> IBM Software Labs,
> Bangalore, INDIA - 560033
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> lhcs-devel mailing list
> lhcs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lhcs-devel

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
