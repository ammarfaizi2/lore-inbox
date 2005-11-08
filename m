Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbVKHHyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbVKHHyF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 02:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbVKHHyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 02:54:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22224 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030207AbVKHHyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 02:54:00 -0500
Date: Mon, 7 Nov 2005 23:50:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: luke.adi@gmail.com, bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: ADI Blackfin patch for kernel 2.6.14
Message-Id: <20051107235035.2bdb00e1.akpm@osdl.org>
In-Reply-To: <20051107165928.GA15586@kroah.com>
References: <489ecd0c0511010128x41d39643x37893ad48a8ef42a@mail.gmail.com>
	<20051101165136.GU8009@stusta.de>
	<489ecd0c0511012306w434d75fbs90e1969d82a07922@mail.gmail.com>
	<489ecd0c0511032059n394abbb2s9865c22de9b2c448@mail.gmail.com>
	<20051104230644.GA20625@kroah.com>
	<489ecd0c0511062258k4183d206odefd3baa46bb9a04@mail.gmail.com>
	<20051107165928.GA15586@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Mon, Nov 07, 2005 at 02:58:03PM +0800, Luke Yang wrote:
>  >   But this patch only includes the arch files for Blackfin. Do I have
>  > to break it into smaller chunks? It is hard to break it...
> 
>  Is there some reason this patch should not follow the documented
>  process?  Do you want it to be reviewed by people?  Accepted into the
>  main kernel tree?  If so, I suggest you do the proper thing.

We've taken arch patches in a single hit before.  It's not such a bad thing.

A basic requirement should be "it should all compile before and after the
patch".  That's pretty hard to do in this case if it's split up.

That being said, a 1.6MB patch is a bit hard to review, mainly because it
doesn't fit through the email server.

>From a quick look:

> +static spinlock_t dma_page_lock = SPIN_LOCK_UNLOCKED;

DEFINE_SPIN_LOCK()

> +static unsigned int dma_initialized = 0;

Remove the `= 0'

+/*
+ * Initial task structure.
+ *
+ * All other task structs will be allocated on slabs in fork.c
+ */
+__asm__(".align 4");
+struct task_struct init_task = INIT_TASK(init_task);

weird.  That align will probably go into .text, rather than where you want
it.  Use __attribute__((__aligned__(4))) or ____cacheline_aligned, or just
remove it - the compiler will align this guy on a 4-byte boundary anyway.


Does this architecture support SMP?  I see it's BROKEN_ON_SMP, but there
seems to be some smp-style stuff in there.


One concern when adding a new architecture is: will it be maintained
long-term?  We don't want to merge an arch and then have it bitrot.  Who is
behind this port, and how do we know that they'll still be around and doing
things in two years' time?


Can this arch use the generic IRQ handling code in kernel/irq/?


The idle routines don't appear to be up-to-date wrt post-2.6.14 changes. 
Or if they are, they won't be after I merge Nick's stuff ;)


get_reg() is way too big to be inlined.

Ditto put_reg().


Can this arch use the generic lib/semaphore-sleepers.c?

> +extern void icache_init(void);
> +extern void dcache_init(void);
> +extern int read_iloc(void);
> +extern unsigned long ipdt_table[];
> +extern unsigned long dpdt_table[];
> +extern unsigned long icplb_table[];
> +extern unsigned long dcplb_table[];
> +int DmaMemCpy(char *dest_addr, char *source_addr, unsigned short size);
> +int DmaMemCpy16(char *dest_addr, char *source_addr, int size);

extern decls should always go in header files.  If things like
icache_init() aren't in any headers, well mutter.  It'd be nice to fix
that.  Involves touching all architectures, yeah, not your job...


touch_l1_data() can have static scope.  Please review all global symbols
for this.


Does a new arch need to support old_mmap()?


old_select()?


> +void time_sched_init(irqreturn_t(*timer_routine)
> +		      (int, void *, struct pt_regs *));
> +unsigned long gettimeoffset(void);
> +extern unsigned long wall_jiffies;
> +extern int setup_irq(unsigned int, struct irqaction *);
> +inline static void do_leds(void);
> +
> +extern u_long get_cclk(void);

More extern-decls-in-c-files

> +asmlinkage int sys_bfin_spinlock(int *spinlock)

Whoa, that's a syscall I never expected to see.  What's it do?  Shouldn't
it be using get_user() and put_user()?  Or will this forever be a nommu
arch?


What _is_ a bluefin, anyway?


Are precompiled cross-complers/assemblers available anywhere?


bix:/home/akpm> grep volatile bfin_r2_4kernel-2.6.14.patch | wc -l
   2901

Cow.  You know that volatile in-kernel is basically always wrong?



