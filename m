Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310811AbSCHLVt>; Fri, 8 Mar 2002 06:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310812AbSCHLVk>; Fri, 8 Mar 2002 06:21:40 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:63246 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S310811AbSCHLV3>;
	Fri, 8 Mar 2002 06:21:29 -0500
Date: Thu, 7 Mar 2002 23:10:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: fchabaud@free.fr
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp is at it... again
Message-ID: <20020307221037.GA506@elf.ucw.cz>
In-Reply-To: <20020305205940.GE318@elf.ucw.cz> <200203070954.g279sPl16112@colombe.home.perso>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200203070954.g279sPl16112@colombe.home.perso>
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> I also made a modification in stopping task to stop normal task and then
> >> kernel threads (I had to add a new PF_KERNTHREAD flag). Perhaps the bug
> >> has to do with the *order* of stopping processes (I think of that
> >> because kernel messages are written to log files: what happens if
> >> kjournald thread is stopped and a task still writes ?)
> > 
> > Nothing that bad should happen... kjournald is only _delayed_ right?
> > And it could be delayed by scheduling as well.
> 
> Actually, I'm not sure that so simple. I have passed hours trying to
> figure out exactly what's happening but I'm not confident with that
> assumption. All transactions in journal have an expiration time based on
> jiffies and I'm not sure jiffies are correctly resumed, are they ? Maybe
> this expiration of transaction is handled in a way that is not
> inocuitous in our context.

Unless we made jiffies go back, we did nothing that could not happen
before, right? Your machine could for some reason freeze for half an
hour, then resume. That should be equivalent to swsusp.

> Index: linux/arch/i386/kernel/apm.c

apm.c parts not applied, I'm trying to keep it small.

> diff -u linux/drivers/char/agp/agpgart_be.c:1.1.1.2 linux/drivers/char/agp/agpgart_be.c:1.1.1.1.4.1
> --- linux/drivers/char/agp/agpgart_be.c:1.1.1.2	Mon Mar  4 20:17:17 2002
> +++ linux/drivers/char/agp/agpgart_be.c	Thu Mar  7 10:10:42

This is needed even without swsusp, no?

> +++ linux/fs/buffer.c	Thu Mar  7 10:11:23 2002

Applied.

> +++ linux/fs/jbd/journal.c	Thu Mar  7 10:11:28 2002


Applied.

> -		jbd_debug(2, "transaction too old, requesting commit for "
> -					"handle %p\n", handle);
> +		jbd_debug(2, "transaction %d too old, requesting commit for "
> +					"handle %p\n", tid, handle);

I have enough of my own debugging hooks ;-)).

> +++ linux/fs/reiserfs/journal.c	Thu Mar  7 10:11:30 2002

Applied.

> +++ linux/include/asm-i386/suspend.h	Thu Mar  7 10:11:34 2002
> @@ -260,9 +260,9 @@
>  	if (!resume) {
>  		do_magic_suspend_1();
>  		save_processor_context();	/* We need to capture registers and memory at "same time" */
> -		do_magic_suspend_2();
> -		restore_processor_context();
> -		return;
> +		do_magic_suspend_2(); /* We should never return from here except when suspension fails */
> +		/*restore_processor_context();
> +		return;*/

I kept comment, but I'm not sure I want to go through normal resume at
this point.

> +++ linux/include/linux/sched.h	Thu Mar  7 10:11:43 2002

Applied.

> +++ linux/include/linux/suspend.h	Thu Mar  7 10:11:44 2002

Applied.

> diff -u linux/kernel/suspend.c:1.1.1.1 linux/kernel/suspend.c:1.1.2.1.2.2
> --- linux/kernel/suspend.c:1.1.1.1	Thu Mar  7 10:32:18 2002
> +++ linux/kernel/suspend.c	Thu Mar  7 10:11:46 2002
> @@ -78,7 +78,10 @@
>  #include <linux/major.h>
>  #include <linux/blk.h>
>  #include <linux/swap.h>
> -
> +#include <linux/pm.h>
> +#ifdef CONFIG_APM
> +# include <linux/apm_bios.h>
> +#endif
>  #include <asm/uaccess.h>
>  #include <asm/mmu_context.h>
>  #include <asm/pgtable.h>

Is CONFIG_APM really neccessary?

> @@ -95,7 +98,8 @@
>  #undef SUSPEND_CONSOLE
>  #endif
>  
> -#define TIMEOUT	(6 * HZ)			/* Timeout for stopping processes */
> +#define TIMEOUT	(12 * HZ)			/* Timeout for stopping processes (flushing ext3 journal
> +						   may take a while */
>  #define ADDRESS(x) ((unsigned long) phys_to_virt(((x) << PAGE_SHIFT)))
>  
>  extern void wakeup_bdflush(void);

But you are not flushing journal just now, are you?

> @@ -197,16 +204,28 @@
>   */
>  
>  #define INTERESTING(p) \
> -			/* We don't want to touch kernel_threads..*/ \
>  			if (p->flags & PF_IOTHREAD) \
>  				continue; \
> +			/* We don't want to touch kernel_threads on first pass...*/ \
> +			if (p->flags & PF_KERNTHREAD) \
> +				continue; \
>  			if (p == current) \
>  				continue; \
>  			if (p->state == TASK_ZOMBIE) \
>  				continue;
> +#define INTERESTING_FORCE(p) \
> +			if (p->flags & PF_IOTHREAD) \
> +				continue; \
> +			/* We want to touch *only* kernel_threads on second pass...*/ \
> +			if (!(p->flags & PF_KERNTHREAD)) \
> +				continue; \
> +			if (p == current) \
> +				continue; \
> +			if (p->state == TASK_ZOMBIE) \
> +				continue;
>  

I hope this 2-phase suspend is not really neccessary. I tried not to
apply it.

> +	if(flag)
> +		flush_signals(current); /* We have signaled a kernel thread, which isn't normal behaviour
> +					   and that may lead to 100%CPU sucking because those threads
> +					   just don't manage signals. */

But this looks critical.

> +/* Make disk drivers accept operations, again */
> +static void drivers_unsuspend(void)
> +{
> +#ifdef CONFIG_BLK_DEV_IDE
> +	ide_disk_unsuspend();
> +#endif
> +}
> +
> +/* Called from process context */
> +static int drivers_suspend(void)
> +{
> +#ifdef CONFIG_BLK_DEV_IDE
> +	ide_disk_suspend();
> +#else
> +#error Are you sure your disk driver supports suspend?
> +#endif
> +	if(!pm_suspend_state) {
> +		if(pm_send_all(PM_SUSPEND,(void *)3)) {
> +			printk(KERN_WARNING "Problem while sending suspend event\n");
> +			return(1);
> +		}
> +		pm_suspend_state=1;
> +	} else
> +		printk(KERN_WARNING "PM suspend state already raised\n");
> +	  
> +	return(0);
> +}
> +
> +/* Called from interrupts disabled */
> +#define RESUME_PHASE1 1
> +#define RESUME_PHASE2 2
> +#define RESUME_ALL_PHASES (RESUME_PHASE1 | RESUME_PHASE2)

This looks better than what I have... So PHASE1 is interrupts off,
PHASE2 is interrupts on, ok? 

> -#ifdef CONFIG_BLK_DEV_IDE
> -	ide_disk_unsuspend();
> -#endif
> +	drivers_unsuspend();

This was already there.

> +++ linux/mm/page_alloc.c	Thu Mar  7 10:11:46 2002

I do not like this. loopcount seems very arbitrary, and what I have
here seems to work with 2.4.18...

> +++ linux/mm/vmscan.c	Thu Mar  7 10:11:46 2002

Applied.

Oh, and you probably want to create little linux/CREDITS diff
;-))). 
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
