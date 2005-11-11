Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVKKL0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVKKL0c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 06:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVKKL0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 06:26:32 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:29812 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750700AbVKKL0b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 06:26:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TpmJ4kattMYkjfKL2iNlmcpoviHsltAGDa5EDhYIbNOtdnxsBaPOKLL/UFhSzZfepTuYt+F86HztduJgdjVdyoInmz+7toaxn9ZZxSVUoNbQfCdxOChs3LgahIgjAryYi6hU95XeYZs9y5FCjRq9vz3OJYSoNZ//nTgm1e8QVKc=
Message-ID: <489ecd0c0511110326j3a01cabbheeeac6168193a0b0@mail.gmail.com>
Date: Fri, 11 Nov 2005 19:26:31 +0800
From: Luke Yang <luke.adi@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: ADI Blackfin patch for kernel 2.6.14
Cc: Greg KH <greg@kroah.com>, bunk@stusta.de, linux-kernel@vger.kernel.org
In-Reply-To: <20051107235035.2bdb00e1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <489ecd0c0511010128x41d39643x37893ad48a8ef42a@mail.gmail.com>
	 <20051101165136.GU8009@stusta.de>
	 <489ecd0c0511012306w434d75fbs90e1969d82a07922@mail.gmail.com>
	 <489ecd0c0511032059n394abbb2s9865c22de9b2c448@mail.gmail.com>
	 <20051104230644.GA20625@kroah.com>
	 <489ecd0c0511062258k4183d206odefd3baa46bb9a04@mail.gmail.com>
	 <20051107165928.GA15586@kroah.com>
	 <20051107235035.2bdb00e1.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> We've taken arch patches in a single hit before.  It's not such a bad thing.
>
> A basic requirement should be "it should all compile before and after the
> patch".  That's pretty hard to do in this case if it's split up.
>
> That being said, a 1.6MB patch is a bit hard to review, mainly because it
> doesn't fit through the email server.
>
> From a quick look:
>
> > +static spinlock_t dma_page_lock = SPIN_LOCK_UNLOCKED;
>
> DEFINE_SPIN_LOCK()
>
> > +static unsigned int dma_initialized = 0;
>
> Remove the `= 0'
>
> +/*
> + * Initial task structure.
> + *
> + * All other task structs will be allocated on slabs in fork.c
> + */
> +__asm__(".align 4");
> +struct task_struct init_task = INIT_TASK(init_task);
>
> weird.  That align will probably go into .text, rather than where you want
> it.  Use __attribute__((__aligned__(4))) or ____cacheline_aligned, or just
> remove it - the compiler will align this guy on a 4-byte boundary anyway.
>
>
> Does this architecture support SMP?  I see it's BROKEN_ON_SMP, but there
> seems to be some smp-style stuff in there.

   It doesn't support SMP now.

>
>
> One concern when adding a new architecture is: will it be maintained
> long-term?  We don't want to merge an arch and then have it bitrot.  Who is
> behind this port, and how do we know that they'll still be around and doing
> things in two years' time?

   I don't clearly know the process of maintaining an arch in kernel. 
But I am sure we can follow the right process.  My question is: How do
they maintain the m68knommu arch? I think it need the uclinux patch to
run on real platfrom. What is the process like?

>
>
> Can this arch use the generic IRQ handling code in kernel/irq/?

     Yes.

>
>
> The idle routines don't appear to be up-to-date wrt post-2.6.14 changes.
> Or if they are, they won't be after I merge Nick's stuff ;)
>
>
> get_reg() is way too big to be inlined.
>
> Ditto put_reg().
>
>
> Can this arch use the generic lib/semaphore-sleepers.c?
>
> > +extern void icache_init(void);
> > +extern void dcache_init(void);
> > +extern int read_iloc(void);
> > +extern unsigned long ipdt_table[];
> > +extern unsigned long dpdt_table[];
> > +extern unsigned long icplb_table[];
> > +extern unsigned long dcplb_table[];
> > +int DmaMemCpy(char *dest_addr, char *source_addr, unsigned short size);
> > +int DmaMemCpy16(char *dest_addr, char *source_addr, int size);
>
> extern decls should always go in header files.  If things like
> icache_init() aren't in any headers, well mutter.  It'd be nice to fix
> that.  Involves touching all architectures, yeah, not your job...
>
>
> touch_l1_data() can have static scope.  Please review all global symbols
> for this.
>
>
> Does a new arch need to support old_mmap()?
>
>
> old_select()?
>
>
> > +void time_sched_init(irqreturn_t(*timer_routine)
> > +                   (int, void *, struct pt_regs *));
> > +unsigned long gettimeoffset(void);
> > +extern unsigned long wall_jiffies;
> > +extern int setup_irq(unsigned int, struct irqaction *);
> > +inline static void do_leds(void);
> > +
> > +extern u_long get_cclk(void);
>
> More extern-decls-in-c-files
>
> > +asmlinkage int sys_bfin_spinlock(int *spinlock)
>
> Whoa, that's a syscall I never expected to see.  What's it do?  Shouldn't
> it be using get_user() and put_user()?  Or will this forever be a nommu
> arch?
>
>
> What _is_ a bluefin, anyway?
>
>
> Are precompiled cross-complers/assemblers available anywhere?

    Yes, please visit blackfin.uclinux.org to get our toolchain.

>
>
> bix:/home/akpm> grep volatile bfin_r2_4kernel-2.6.14.patch | wc -l
>   2901
>
> Cow.  You know that volatile in-kernel is basically always wrong?
>
    To the other detail questions/issues, I'll write to you soon.
Thank you for your help.

Luke Yang
