Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263950AbTIBQFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 12:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263939AbTIBQFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 12:05:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:51905 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263954AbTIBQFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 12:05:10 -0400
Date: Tue, 2 Sep 2003 09:11:13 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@suse.cz>
cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix up power managment in 2.6
In-Reply-To: <20030902094701.GD145@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0309020825280.5614-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -65,9 +65,7 @@
> 
>  #include "power.h"
> 
> -extern long sys_sync(void);
> -
> -unsigned char software_suspend_enabled = 0;
> +unsigned char software_suspend_enabled = 1;
> 
>  #define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
> 
> ...by this you enable suspend even before system is booted. That's bad
> idea. It could hurt in the past (when we had sysrq-D so swsusp), and
> it may hurt again in future when battery goes low during boot.

Does it or does it not cause a problem? Look at the old software_suspend() 
function - The handling of this flag was weird and non-standard. This is 
cleaner. 

> -#ifdef CONFIG_DISCONTIGMEM
> -       panic("Discontingmem not supported");
> -#else
>         BUG_ON (max_pfn != num_physpages);
> -#endif
> +
> 
> ...you moved check down to swsusp_save but you did not test it - you
> have typo in "CONFIG":

Woops. 

> 
> +int swsusp_save(void)
> +{
> +#if defined (CONFIG_HIGHMEM) || defined (COFNIG_DISCONTIGMEM)
> +       printk("swsusp is not supported with high- or
> discontig-mem.\n");
> +       return -EPERM;
> +#endif
> 
> -               if (PageHighMem(page))
> -                       panic("Swsusp not supported on highmem
> -               boxes. Send 1GB of RAM to <pavel@ucw.cz> and try again
> -               ;-).");
> 
> Great, lets kill the messenger. Notice that when swsusp goes wrong it
> tends to do bad data corruption, so some defensive programming is good
> idea and this should be at least BUG_ON(). Gcc should optimize it
> anyway.

First, look at the snippet that you pasted just before this, then explain 
how we could have a HIGHMEM page if we unconditionally error when HIGHMEM 
is enabled. 

> -void do_magic_suspend_2(void)
> +int do_magic_suspend_2(void)
>  {
>         int is_problem;
>         read_swapfiles();
>         is_problem = suspend_prepare_image();
>         spin_unlock_irq(&suspend_pagedir_lock);
> ...
>         barrier();
>         mb();
> -       spin_lock_irq(&suspend_pagedir_lock);   /* Done to disable
> interrupts */
>         mdelay(1000);
> -
> -       free_pages((unsigned long) pagedir_nosave, pagedir_order);
> -       spin_unlock_irq(&suspend_pagedir_lock);
> -       mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
> ...
> -       might_sleep();
> -       do_software_suspend();
> +       return -EFAULT;
>  }
> 
> 
> You killed code to mark swap as normal swap space and replaced it with
> simple return -EFAULT. This is extremely dangerous; now swap is marked
> as containing valid suspend image. On next reboot, user code resume,
> but disk already has changed state. There will be silent data
> corruption going on, and filesystem may be marked as clean at the
> end. Great way to loose all your data. Really.

Snide comments not appreicated. 

The resetting of the swapfiles happened in swsusp_free(). Please read the 
entire patch. That is, until the latest round of patches, in which the 
resetting happened immediately after the header was read. Again, please 
read the entire set of patches. 

>         else if (!memcmp("S2",cur->swh.magic.magic,2))
>                 memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
>         else {
> -               if (noresume)
> -                       return -EINVAL;
> -               panic("%sUnable to find suspended-data signature
> (%.10s - misspelled?\n",
> +               printk("swsusp: %s: Unable to find suspended-data
> signature (%.10s - misspelled?\n",
>                         name_resume, cur->swh.magic.magic);
> -       }
> -       if (noresume) {
> -               /* We don't do a sanity check here: we want to restore
> the swap
> -                  whatever version of kernel made the suspend image;
> -                  We need to write swap, but swap is *not* enabled so
> -                  we must write the device directly */
> -               printk("%s: Fixing swap signatures %s...\n",
> name_resume, resume_file);
> -               bdev_write_page(bdev, 0, cur);
> +               return -EFAULT;
>         }
> 
>         printk( "%sSignature found, resuming\n", name_resume );
> 
> User has suspended, but he does not want to resume. Code was there to
> restore swap space to "normal" state so it can be swapon-ed. This will
> not kill data, only puzzled user.

Read your own code: 

static int bdev_write_page(struct block_device *bdev, long pos, void *buf)
{
#if 0
        struct buffer_head *bh;
        BUG_ON (pos%PAGE_SIZE);
        bh = __bread(bdev, pos/PAGE_SIZE, PAGE_SIZE);
        if (!bh || (!bh->b_data)) {
                return -1;
        }
        memcpy(bh->b_data, buf, PAGE_SIZE);     /* FIXME: may need kmap() 
*/
        BUG_ON(!buffer_uptodate(bh));
        generic_make_request(WRITE, bh);
        if (!buffer_uptodate(bh))
                printk(KERN_CRIT "%sWarning %s: Fixing swap signatures unsuccessful...\n", name_resume, resume_file);
        wait_on_buffer(bh);
        brelse(bh);
        return 0;
#endif
        printk(KERN_CRIT "%sWarning %s: Fixing swap signatures unimplemented...\n", name_resume, resume_file);
        return 0;
}

Now explain to me why killing that part of code was unnecessary. You've 
already forced them to use mkswap(1) to restore the partition. Let's juts 
make it official. 

> -void software_resume(void)
> +int __init swsusp_restore(void)
>  {
> -       if (num_online_cpus() > 1) {
> -               printk(KERN_WARNING "Software Suspend has
> malfunctioning SMP support. Disabled :(\n");
> -               return;
> -       }
> 
> I can not easily see where you moved this check.

Read the rest of the patches, and the changelogs (I do believe it's in 
them). It's in kernel/power/main.c::enter_state(), so all PM handlers can 
use it. 

> -       /* We enable the possibility of machine suspend */
> -       software_suspend_enabled = 1;
> -       if (!resume_status)
> -               return;
> +       return do_magic(1);
> 
> You'd better keep the code as it was, first prepare all the data, only
> then enter do_magic(). That way, as little code as possible will run
> after we entered the assembly, making stuff easier to debug/check.

Will you read the code? Read your own code, then read the finished code. 
The entire thing, not just snippets of the patch, because you're obviously 
missing entire concepts. 

By the time you called do_magic(), you had stopped processes, freed memory 
and suspended drivers. I take care of that in kernel/power/main.c, then 
call swsusp. That's in the patches, and the changelogs. 

> -       if (!is_problem) {
> -               kernel_fpu_end();       /* save_processor_state() does
> -       kernel_fpu_begin, and we need to revert it in order to p\ass
> -       in_atomic() checks */
> -               BUG_ON(in_atomic());
> -               suspend_save_image();
> -               suspend_power_down();   /* FIXME: if
> -       suspend_power_down is commented out, console is lost after few
> -       suspends ?!\ */
> -       }
> -
> +       if (!is_problem)
> +               return suspend_save_image();
> 
> You've killed kernel_fpu_end(), that might be part of problem. Also
> you killed BUG_ON(in_atomic()) which would actually catch that error.

Again, you've exhibiting gross unfamiliarity with your own code. 
kernel_fpu_end() is called from do_fpu_end() which is called from 
restore_processor_state(), which is called from do_magic() (now
swsusp_arch_suspend()). 

As for the BUG_ON(in_atomic()), that's laziness, and just poor style. A 
nicer check would have been 

int software_suspend(void)
{
	if (in_atomic() || in_interrupt())
		return -EPERM;
	...
}

But, we can all take the moral way out and just make sure that our callers 
are calling us in the right context. 

> > Have you confirmed that x86-64 is broken, or are you simply trying to 
> > raise more accusations? If it is broken, please tell exactly what the 
> > problem is and I will fix it. 
> 
> How do you expect void do_magic() -> int do_magic() to work without
> changing actuall do_magic implementation?

Return is in %eax. We propogate the error from the C functions
(swsusp_suspend() and swsusp_restore()) to the caller of
swsusp_arch_suspend() (nee do_magic()).

> The same way BUG_ON(in_atomic()) should not be in kmalloc()? This is
> to guard against bad callers, please leave it in.

Except kmalloc() has 1000's of callers, many in non-obvious contexts, 
hence a real need for such a check. You have now three callers, which is 
trivial to look after. 

This is not a guessing game. You can impose calling rules that people must 
abide by. You can gracefully handle plausible errors. The code doesn't 
have to be such a damned mess. 

> > panic() is not a valid replacement for sane error handling. Every single 
> > panic() in swsusp can be replaced by proper error handling. You should 
> > have done that a long time ago. Calling panic() is just lazy.
> 
> And every untested error handler means severe data corruption. I might
> be lazy, but you are dangerous to the user data.

My point was that I'm actually trying to fix the error handling so we can 
gracefully back out of where we were. I.e. take the non-lazy approach. 

The fact that swsusp is riddled with so many panic()s and BUG()s has 
always indicated that it is volatile and unsafe. If you cannot handle the 
errors that you get during normal operation, then it is most likely not 
ready for prime time. 

Once again, I'm trying to make it better, against all odds. Against a 
multitude of kernel developers scoffing at the notion of swsusp ever 
working reliably. Against nearly everyone that has seen kernel code 
expressing sorrow for having to read and understand the code. And against 
you, who has no gratitude for someone trying to make marked improvements 
to the structure and reliability of the code.

> You've seen the reports before:
> 
> * ide problems (some user even posted decoded backtrace)
> 
> * UHCI leads to dead usb and machine 20x slower than it should be

I don't get this. Someone else reports an error -- admist you flaming me 
-- and then you get up and flame me about that, too? I saw the report, 
have contacted the person responsible, and see that I have a patch that 
should fix the problem. Unfortunately, I've wasted several hours writing 
you email trying to explain things to you, and I've not had a chance to 
test it.

In short, who the fuck do you think you are that you can constantly berate
me, and with problems that aren't even yours? You've wasted a lot of my
time, obviosuly not even bothered to read the patches or the comments that
go along with them, then have the nerve to attack me about driver reports
you're not even seeing, and tell me in private to revert swsusp and to "do
it soon".

I'm done with you. I rescind my offer to revert swsusp. You can submit 
patches yourself. I will not touch that POS any more, for better or worse. 


	Pat

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

> @@ -65,9 +65,7 @@
> 
>  #include "power.h"
> 
> -extern long sys_sync(void);
> -
> -unsigned char software_suspend_enabled = 0;
> +unsigned char software_suspend_enabled = 1;
> 
>  #define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
> 
> ...by this you enable suspend even before system is booted. That's bad
> idea. It could hurt in the past (when we had sysrq-D so swsusp), and
> it may hurt again in future when battery goes low during boot.

Does it or does it not cause a problem? Look at the old software_suspend() 
function - The handling of this flag was weird and non-standard. This is 
cleaner. 

> -#ifdef CONFIG_DISCONTIGMEM
> -       panic("Discontingmem not supported");
> -#else
>         BUG_ON (max_pfn != num_physpages);
> -#endif
> +
> 
> ...you moved check down to swsusp_save but you did not test it - you
> have typo in "CONFIG":

Woops. 

> 
> +int swsusp_save(void)
> +{
> +#if defined (CONFIG_HIGHMEM) || defined (COFNIG_DISCONTIGMEM)
> +       printk("swsusp is not supported with high- or
> discontig-mem.\n");
> +       return -EPERM;
> +#endif
> 
> -               if (PageHighMem(page))
> -                       panic("Swsusp not supported on highmem
> -               boxes. Send 1GB of RAM to <pavel@ucw.cz> and try again
> -               ;-).");
> 
> Great, lets kill the messenger. Notice that when swsusp goes wrong it
> tends to do bad data corruption, so some defensive programming is good
> idea and this should be at least BUG_ON(). Gcc should optimize it
> anyway.

First, look at the snippet that you pasted just before this, then explain 
how we could have a HIGHMEM page if we unconditionally error when HIGHMEM 
is enabled. 

> -void do_magic_suspend_2(void)
> +int do_magic_suspend_2(void)
>  {
>         int is_problem;
>         read_swapfiles();
>         is_problem = suspend_prepare_image();
>         spin_unlock_irq(&suspend_pagedir_lock);
> ...
>         barrier();
>         mb();
> -       spin_lock_irq(&suspend_pagedir_lock);   /* Done to disable
> interrupts */
>         mdelay(1000);
> -
> -       free_pages((unsigned long) pagedir_nosave, pagedir_order);
> -       spin_unlock_irq(&suspend_pagedir_lock);
> -       mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
> ...
> -       might_sleep();
> -       do_software_suspend();
> +       return -EFAULT;
>  }
> 
> 
> You killed code to mark swap as normal swap space and replaced it with
> simple return -EFAULT. This is extremely dangerous; now swap is marked
> as containing valid suspend image. On next reboot, user code resume,
> but disk already has changed state. There will be silent data
> corruption going on, and filesystem may be marked as clean at the
> end. Great way to loose all your data. Really.

Snide comments not appreicated. 

The resetting of the swapfiles happened in swsusp_free(). Please read the 
entire patch. That is, until the latest round of patches, in which the 
resetting happened immediately after the header was read. Again, please 
read the entire set of patches. 

>         else if (!memcmp("S2",cur->swh.magic.magic,2))
>                 memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
>         else {
> -               if (noresume)
> -                       return -EINVAL;
> -               panic("%sUnable to find suspended-data signature
> (%.10s - misspelled?\n",
> +               printk("swsusp: %s: Unable to find suspended-data
> signature (%.10s - misspelled?\n",
>                         name_resume, cur->swh.magic.magic);
> -       }
> -       if (noresume) {
> -               /* We don't do a sanity check here: we want to restore
> the swap
> -                  whatever version of kernel made the suspend image;
> -                  We need to write swap, but swap is *not* enabled so
> -                  we must write the device directly */
> -               printk("%s: Fixing swap signatures %s...\n",
> name_resume, resume_file);
> -               bdev_write_page(bdev, 0, cur);
> +               return -EFAULT;
>         }
> 
>         printk( "%sSignature found, resuming\n", name_resume );
> 
> User has suspended, but he does not want to resume. Code was there to
> restore swap space to "normal" state so it can be swapon-ed. This will
> not kill data, only puzzled user.

Read your own code: 

static int bdev_write_page(struct block_device *bdev, long pos, void *buf)
{
#if 0
        struct buffer_head *bh;
        BUG_ON (pos%PAGE_SIZE);
        bh = __bread(bdev, pos/PAGE_SIZE, PAGE_SIZE);
        if (!bh || (!bh->b_data)) {
                return -1;
        }
        memcpy(bh->b_data, buf, PAGE_SIZE);     /* FIXME: may need kmap() 
*/
        BUG_ON(!buffer_uptodate(bh));
        generic_make_request(WRITE, bh);
        if (!buffer_uptodate(bh))
                printk(KERN_CRIT "%sWarning %s: Fixing swap signatures unsuccessful...\n", name_resume, resume_file);
        wait_on_buffer(bh);
        brelse(bh);
        return 0;
#endif
        printk(KERN_CRIT "%sWarning %s: Fixing swap signatures unimplemented...\n", name_resume, resume_file);
        return 0;
}

Now explain to me why killing that part of code was unnecessary. You've 
already forced them to use mkswap(1) to restore the partition. Let's juts 
make it official. 

> -void software_resume(void)
> +int __init swsusp_restore(void)
>  {
> -       if (num_online_cpus() > 1) {
> -               printk(KERN_WARNING "Software Suspend has
> malfunctioning SMP support. Disabled :(\n");
> -               return;
> -       }
> 
> I can not easily see where you moved this check.

Read the rest of the patches, and the changelogs (I do believe it's in 
them). It's in kernel/power/main.c::enter_state(), so all PM handlers can 
use it. 

> -       /* We enable the possibility of machine suspend */
> -       software_suspend_enabled = 1;
> -       if (!resume_status)
> -               return;
> +       return do_magic(1);
> 
> You'd better keep the code as it was, first prepare all the data, only
> then enter do_magic(). That way, as little code as possible will run
> after we entered the assembly, making stuff easier to debug/check.

Will you read the code? Read your own code, then read the finished code. 
The entire thing, not just snippets of the patch, because you're obviously 
missing entire concepts. 

By the time you called do_magic(), you had stopped processes, freed memory 
and suspended drivers. I take care of that in kernel/power/main.c, then 
call swsusp. That's in the patches, and the changelogs. 

> -       if (!is_problem) {
> -               kernel_fpu_end();       /* save_processor_state() does
> -       kernel_fpu_begin, and we need to revert it in order to p\ass
> -       in_atomic() checks */
> -               BUG_ON(in_atomic());
> -               suspend_save_image();
> -               suspend_power_down();   /* FIXME: if
> -       suspend_power_down is commented out, console is lost after few
> -       suspends ?!\ */
> -       }
> -
> +       if (!is_problem)
> +               return suspend_save_image();
> 
> You've killed kernel_fpu_end(), that might be part of problem. Also
> you killed BUG_ON(in_atomic()) which would actually catch that error.

Again, you've exhibiting gross unfamiliarity with your own code. 
kernel_fpu_end() is called from do_fpu_end() which is called from 
restore_processor_state(), which is called from do_magic() (now
swsusp_arch_suspend()). 

As for the BUG_ON(in_atomic()), that's laziness, and just poor style. A 
nicer check would have been 

int software_suspend(void)
{
	if (in_atomic() || in_interrupt())
		return -EPERM;
	...
}

But, we can all take the moral way out and just make sure that our callers 
are calling us in the right context. 

> > Have you confirmed that x86-64 is broken, or are you simply trying to 
> > raise more accusations? If it is broken, please tell exactly what the 
> > problem is and I will fix it. 
> 
> How do you expect void do_magic() -> int do_magic() to work without
> changing actuall do_magic implementation?

Return is in %eax. We propogate the error from the C functions
(swsusp_suspend() and swsusp_restore()) to the caller of
swsusp_arch_suspend() (nee do_magic()).

> The same way BUG_ON(in_atomic()) should not be in kmalloc()? This is
> to guard against bad callers, please leave it in.

Except kmalloc() has 1000's of callers, many in non-obvious contexts, 
hence a real need for such a check. You have now three callers, which is 
trivial to look after. 

This is not a guessing game. You can impose calling rules that people must 
abide by. You can gracefully handle plausible errors. The code doesn't 
have to be such a damned mess. 

> > panic() is not a valid replacement for sane error handling. Every single 
> > panic() in swsusp can be replaced by proper error handling. You should 
> > have done that a long time ago. Calling panic() is just lazy.
> 
> And every untested error handler means severe data corruption. I might
> be lazy, but you are dangerous to the user data.

My point was that I'm actually trying to fix the error handling so we can 
gracefully back out of where we were. I.e. take the non-lazy approach. 

The fact that swsusp is riddled with so many panic()s and BUG()s has 
always indicated that it is volatile and unsafe. If you cannot handle the 
errors that you get during normal operation, then it is most likely not 
ready for prime time. 

Once again, I'm trying to make it better, against all odds. Against a 
multitude of kernel developers scoffing at the notion of swsusp ever 
working reliably. Against nearly everyone that has seen kernel code 
expressing sorrow for having to read and understand the code. And against 
you, who has no gratitude for someone trying to make marked improvements 
to the structure and reliability of the code.

> You've seen the reports before:
> 
> * ide problems (some user even posted decoded backtrace)
> 
> * UHCI leads to dead usb and machine 20x slower than it should be

I don't get this. Someone else reports an error -- admist you flaming me 
-- and then you get up and flame me about that, too? I saw the report, 
have contacted the person responsible, and see that I have a patch that 
should fix the problem. Unfortunately, I've wasted several hours writing 
you email trying to explain things to you, and I've not had a chance to 
test it.

In short, who the fuck do you think you are that you can constantly berate
me, and with problems that aren't even yours? You've wasted a lot of my
time, obviosuly not even bothered to read the patches or the comments that
go along with them, then have the nerve to attack me about driver reports
you're not even seeing, and tell me in private to revert swsusp and to "do
it soon".

I'm done with you. I rescind my offer to revert swsusp. You can submit 
patches yourself. I will not touch that POS any more, for better or worse. 


	Pat

