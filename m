Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbTIBJrl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 05:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbTIBJrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 05:47:41 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:49373 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S263612AbTIBJrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 05:47:25 -0400
Date: Tue, 2 Sep 2003 11:47:01 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030902094701.GD145@elf.ucw.cz>
References: <20030901233833.GD470@elf.ucw.cz> <Pine.LNX.4.44.0309011740340.5614-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309011740340.5614-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > [Attached is patch "not changing core functionality". How did you
> > expect me to verify that? And it was you who protested on killing 3
> > printks.]
> 
> What is the problem with it? Why is it not better than what was there 
> before? 

Like except the fact it no longer works?

Okay, lets see:

@@ -65,9 +65,7 @@

 #include "power.h"

-extern long sys_sync(void);
-
-unsigned char software_suspend_enabled = 0;
+unsigned char software_suspend_enabled = 1;

 #define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))

...by this you enable suspend even before system is booted. That's bad
idea. It could hurt in the past (when we had sysrq-D so swsusp), and
it may hurt again in future when battery goes low during boot.

        int pfn;
        struct page *page;

-#ifdef CONFIG_DISCONTIGMEM
-       panic("Discontingmem not supported");
-#else
        BUG_ON (max_pfn != num_physpages);
-#endif
+

...you moved check down to swsusp_save but you did not test it - you
have typo in "CONFIG":

+int swsusp_save(void)
+{
+#if defined (CONFIG_HIGHMEM) || defined (COFNIG_DISCONTIGMEM)
+       printk("swsusp is not supported with high- or
discontig-mem.\n");
+       return -EPERM;
+#endif

-               if (PageHighMem(page))
-                       panic("Swsusp not supported on highmem
-               boxes. Send 1GB of RAM to <pavel@ucw.cz> and try again
-               ;-).");

Great, lets kill the messenger. Notice that when swsusp goes wrong it
tends to do bad data corruption, so some defensive programming is good
idea and this should be at least BUG_ON(). Gcc should optimize it
anyway.

-void do_magic_suspend_2(void)
+int do_magic_suspend_2(void)
 {
        int is_problem;
        read_swapfiles();
        is_problem = suspend_prepare_image();
        spin_unlock_irq(&suspend_pagedir_lock);
...
        barrier();
        mb();
-       spin_lock_irq(&suspend_pagedir_lock);   /* Done to disable
interrupts */
        mdelay(1000);
-
-       free_pages((unsigned long) pagedir_nosave, pagedir_order);
-       spin_unlock_irq(&suspend_pagedir_lock);
-       mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
...
-       might_sleep();
-       do_software_suspend();
+       return -EFAULT;
 }


You killed code to mark swap as normal swap space and replaced it with
simple return -EFAULT. This is extremely dangerous; now swap is marked
as containing valid suspend image. On next reboot, user code resume,
but disk already has changed state. There will be silent data
corruption going on, and filesystem may be marked as clean at the
end. Great way to loose all your data. Really.

        else if (!memcmp("S2",cur->swh.magic.magic,2))
                memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
        else {
-               if (noresume)
-                       return -EINVAL;
-               panic("%sUnable to find suspended-data signature
(%.10s - misspelled?\n",
+               printk("swsusp: %s: Unable to find suspended-data
signature (%.10s - misspelled?\n",
                        name_resume, cur->swh.magic.magic);
-       }
-       if (noresume) {
-               /* We don't do a sanity check here: we want to restore
the swap
-                  whatever version of kernel made the suspend image;
-                  We need to write swap, but swap is *not* enabled so
-                  we must write the device directly */
-               printk("%s: Fixing swap signatures %s...\n",
name_resume, resume_file);
-               bdev_write_page(bdev, 0, cur);
+               return -EFAULT;
        }

        printk( "%sSignature found, resuming\n", name_resume );

User has suspended, but he does not want to resume. Code was there to
restore swap space to "normal" state so it can be swapon-ed. This will
not kill data, only puzzled user.

-void software_resume(void)
+int __init swsusp_restore(void)
 {
-       if (num_online_cpus() > 1) {
-               printk(KERN_WARNING "Software Suspend has
malfunctioning SMP support. Disabled :(\n");
-               return;
-       }

I can not easily see where you moved this check.

-       /* We enable the possibility of machine suspend */
-       software_suspend_enabled = 1;
-       if (!resume_status)
-               return;
+       return do_magic(1);

You'd better keep the code as it was, first prepare all the data, only
then enter do_magic(). That way, as little code as possible will run
after we entered the assembly, making stuff easier to debug/check.
 
> > And managed to call sleeping functions with interrupts disabled and
> > break x86-64 somewhere in the process. 
> 
> The first is unintentional and not something I see here. Will investigate 
> further. 

As I told you before, its CONFIG_PREEMPT, and those BUG_ON() checks.

-       if (!is_problem) {
-               kernel_fpu_end();       /* save_processor_state() does
-       kernel_fpu_begin, and we need to revert it in order to p\ass
-       in_atomic() checks */
-               BUG_ON(in_atomic());
-               suspend_save_image();
-               suspend_power_down();   /* FIXME: if
-       suspend_power_down is commented out, console is lost after few
-       suspends ?!\ */
-       }
-
+       if (!is_problem)
+               return suspend_save_image();

You've killed kernel_fpu_end(), that might be part of problem. Also
you killed BUG_ON(in_atomic()) which would actually catch that error.

> Have you confirmed that x86-64 is broken, or are you simply trying to 
> raise more accusations? If it is broken, please tell exactly what the 
> problem is and I will fix it. 

How do you expect void do_magic() -> int do_magic() to work without
changing actuall do_magic implementation?

> > Hmm, and because you killed
> > BUG_ON(in_atomic()), you did not realize that you were breaking
> > that. 
> 
> That was in software_suspend() itself, which was completely bogus. For 
> one, you should review how you're getting called and realize that neither 
> places were atomic contexts. So, it was useless. 

The same way BUG_ON(in_atomic()) should not be in kmalloc()? This is
to guard against bad callers, please leave it in.

> Now, you did export software_suspend() for some unknown reason, and that 
> is simply bogus. Why would a module call you? 
> 
> Finally, you BUG()'d when you could simply return an error. That's 
> completely unfriendly to the user. Just return an error, like every other 
> sane code path. 

When someone calls kmalloc(GPF_KERNEL) with interrupts disabled, do
you just return NULL? No. If someone does that, it needs to be fixed.

> > And I do not think you actually tested those "panic" codepaths
> > to make sure you are not corrupting data, right?
> 
> panic() is not a valid replacement for sane error handling. Every single 
> panic() in swsusp can be replaced by proper error handling. You should 
> have done that a long time ago. Calling panic() is just lazy.

And every untested error handler means severe data corruption. I might
be lazy, but you are dangerous to the user data.

> And, the driver model is working fine. I don't know what you're 
> complaining about now, but a sane bug report would be helpful. So would 
> some patches -- you've been maintaining swsusp for two years now, and 
> you've not help convert one driver to the new model (even before it 
> changed). 

You've seen the reports before:

* ide problems (some user even posted decoded backtrace)

* UHCI leads to dead usb and machine 20x slower than it should be

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
