Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWGYGDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWGYGDr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 02:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWGYGDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 02:03:46 -0400
Received: from ccerelbas02.cce.hp.com ([161.114.21.105]:40108 "EHLO
	ccerelbas02.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751400AbWGYGDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 02:03:45 -0400
Date: Mon, 24 Jul 2006 22:54:39 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@hpl.hp.com>
Subject: Re: [PATCH] i386 TIF flags for debug regs and io bitmap in ctxsw (v2)
Message-ID: <20060725055439.GA18053@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20060704072939.GC5902@frankl.hpl.hp.com> <20060705115406.GA8294@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060705115406.GA8294@frankl.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to follow-up the TIF flags and especially on the
rules of inheritance. It appears the TIF flags are copied from
parent to child task systematically on copy_process.
Then they are adjusted in copy_threads() or sub-functions.

The TIF_IO_BITMAP is checked in copy_threads() with the following code:

int copy_thread(int nr, unsigned long clone_flags, unsigned long esp,
	unsigned long unused,
	struct task_struct * p, struct pt_regs * regs)
{
	....
	if (unlikely(test_tsk_thread_flag(tsk, TIF_IO_BITMAP))) {
		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
		if (!p->thread.io_bitmap_ptr) {
			p->thread.io_bitmap_max = 0;
			return -ENOMEM;
		}
		memcpy(p->thread.io_bitmap_ptr, tsk->thread.io_bitmap_ptr,
			IO_BITMAP_BYTES);
		set_tsk_thread_flag(p, TIF_IO_BITMAP);
	}

I would think that the set_tsk_thread_flag() is extraneous.

As for TIF_DEBUG, my patch is not clearing it. I don't think you can
have HW breakpoints be inherited from one task to the other.

Any comments on this?


On Wed, Jul 05, 2006 at 04:54:06AM -0700, Stephane Eranian wrote:
> Hello,
> 
> Here is the second version of my TIF flag patch for i386.
> This version incoporates the changes suggested by Chuck. 
> 
> This patch is against mainline.
> 
> This patch covers the i386 modifications.
>  
> Changelog:
> 	- add TIF_DEBUG to track when debug registers are active
>  	- add TIF_IO_BITMAP to track when I/O bitmap is used
>  	- modify __switch_to() to use the new TIF flags
>  
> <signed-off-by>: eranian@hpl.hp.com
> 
> diff --git a/arch/i386/kernel/ioport.c b/arch/i386/kernel/ioport.c
> --- a/arch/i386/kernel/ioport.c
> +++ b/arch/i386/kernel/ioport.c
> @@ -79,6 +79,7 @@ asmlinkage long sys_ioperm(unsigned long
>  
>  		memset(bitmap, 0xff, IO_BITMAP_BYTES);
>  		t->io_bitmap_ptr = bitmap;
> +		set_thread_flag(TIF_IO_BITMAP);
>  	}
>  
>  	/*
> diff --git a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
> --- a/arch/i386/kernel/process.c
> +++ b/arch/i386/kernel/process.c
> @@ -359,16 +359,16 @@ EXPORT_SYMBOL(kernel_thread);
>   */
>  void exit_thread(void)
>  {
> -	struct task_struct *tsk = current;
> -	struct thread_struct *t = &tsk->thread;
> -
>  	/* The process may have allocated an io port bitmap... nuke it. */
> -	if (unlikely(NULL != t->io_bitmap_ptr)) {
> +	if (unlikely(test_thread_flag(TIF_IO_BITMAP))) {
> +		struct task_struct *tsk = current;
> +		struct thread_struct *t = &tsk->thread;
>  		int cpu = get_cpu();
>  		struct tss_struct *tss = &per_cpu(init_tss, cpu);
>  
>  		kfree(t->io_bitmap_ptr);
>  		t->io_bitmap_ptr = NULL;
> +		clear_thread_flag(TIF_IO_BITMAP);
>  		/*
>  		 * Careful, clear this in the TSS too:
>  		 */
> @@ -387,6 +387,7 @@ void flush_thread(void)
>  
>  	memset(tsk->thread.debugreg, 0, sizeof(unsigned long)*8);
>  	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));	
> +	clear_tsk_thread_flag(tsk, TIF_DEBUG);
>  	/*
>  	 * Forget coprocessor state..
>  	 */
> @@ -431,7 +432,7 @@ int copy_thread(int nr, unsigned long cl
>  	savesegment(gs,p->thread.gs);
>  
>  	tsk = current;
> -	if (unlikely(NULL != tsk->thread.io_bitmap_ptr)) {
> +	if (unlikely(test_tsk_thread_flag(tsk, TIF_IO_BITMAP))) {
>  		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
>  		if (!p->thread.io_bitmap_ptr) {
>  			p->thread.io_bitmap_max = 0;
> @@ -439,6 +440,7 @@ int copy_thread(int nr, unsigned long cl
>  		}
>  		memcpy(p->thread.io_bitmap_ptr, tsk->thread.io_bitmap_ptr,
>  			IO_BITMAP_BYTES);
> +		set_tsk_thread_flag(p, TIF_IO_BITMAP);
>  	}
>  
>  	/*
> @@ -533,10 +535,24 @@ int dump_task_regs(struct task_struct *t
>  	return 1;
>  }
>  
> -static inline void
> -handle_io_bitmap(struct thread_struct *next, struct tss_struct *tss)
> +static inline void __switch_to_xtra(struct task_struct *next_p,
> +				    struct tss_struct *tss)
>  {
> -	if (!next->io_bitmap_ptr) {
> +	struct thread_struct *next;
> +
> +	next = &next_p->thread;
> +
> +	if (test_tsk_thread_flag(next_p, TIF_DEBUG)) {
> +		set_debugreg(next->debugreg[0], 0);
> +		set_debugreg(next->debugreg[1], 1);
> +		set_debugreg(next->debugreg[2], 2);
> +		set_debugreg(next->debugreg[3], 3);
> +		/* no 4 and 5 */
> +		set_debugreg(next->debugreg[6], 6);
> +		set_debugreg(next->debugreg[7], 7);
> +	}
> +
> +	if (!test_tsk_thread_flag(next_p, TIF_IO_BITMAP)) {
>  		/*
>  		 * Disable the bitmap via an invalid offset. We still cache
>  		 * the previous bitmap owner and the IO bitmap contents:
> @@ -544,6 +560,7 @@ handle_io_bitmap(struct thread_struct *n
>  		tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
>  		return;
>  	}
> +
>  	if (likely(next == tss->io_bitmap_owner)) {
>  		/*
>  		 * Previous owner of the bitmap (hence the bitmap content)
> @@ -673,18 +690,9 @@ struct task_struct fastcall * __switch_t
>  	/*
>  	 * Now maybe reload the debug registers
>  	 */
> -	if (unlikely(next->debugreg[7])) {
> -		set_debugreg(next->debugreg[0], 0);
> -		set_debugreg(next->debugreg[1], 1);
> -		set_debugreg(next->debugreg[2], 2);
> -		set_debugreg(next->debugreg[3], 3);
> -		/* no 4 and 5 */
> -		set_debugreg(next->debugreg[6], 6);
> -		set_debugreg(next->debugreg[7], 7);
> -	}
> -
> -	if (unlikely(prev->io_bitmap_ptr || next->io_bitmap_ptr))
> -		handle_io_bitmap(next, tss);
> +	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW))
> +	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP))
> +		__switch_to_xtra(next_p, tss);
>  
>  	disable_tsc(prev_p, next_p);
>  
> diff --git a/arch/i386/kernel/ptrace.c b/arch/i386/kernel/ptrace.c
> --- a/arch/i386/kernel/ptrace.c
> +++ b/arch/i386/kernel/ptrace.c
> @@ -468,8 +468,11 @@ long arch_ptrace(struct task_struct *chi
>  				  for(i=0; i<4; i++)
>  					  if ((0x5f54 >> ((data >> (16 + 4*i)) & 0xf)) & 1)
>  						  goto out_tsk;
> +				  if (data)
> +					  set_tsk_thread_flag(child, TIF_DEBUG);
> +				  else
> +					  clear_tsk_thread_flag(child, TIF_DEBUG);
>  			  }
> -
>  			  addr -= (long) &dummy->u_debugreg;
>  			  addr = addr >> 2;
>  			  child->thread.debugreg[addr] = data;
> diff --git a/include/asm-i386/thread_info.h b/include/asm-i386/thread_info.h
> --- a/include/asm-i386/thread_info.h
> +++ b/include/asm-i386/thread_info.h
> @@ -140,6 +140,8 @@ static inline struct thread_info *curren
>  #define TIF_SECCOMP		8	/* secure computing */
>  #define TIF_RESTORE_SIGMASK	9	/* restore signal mask in do_signal() */
>  #define TIF_MEMDIE		16
> +#define TIF_DEBUG		17	/* uses debug registers */
> +#define TIF_IO_BITMAP		18	/* uses I/O bitmap */
>  
>  #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
>  #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
> @@ -151,6 +153,8 @@ static inline struct thread_info *curren
>  #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
>  #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
>  #define _TIF_RESTORE_SIGMASK	(1<<TIF_RESTORE_SIGMASK)
> +#define _TIF_DEBUG		(1<<TIF_DEBUG)
> +#define _TIF_IO_BITMAP		(1<<TIF_IO_BITMAP)
>  
>  /* work to do on interrupt/exception return */
>  #define _TIF_WORK_MASK \
> @@ -159,6 +163,9 @@ static inline struct thread_info *curren
>  /* work to do on any return to u-space */
>  #define _TIF_ALLWORK_MASK	(0x0000FFFF & ~_TIF_SECCOMP)
>  
> +/* flags to check in __switch_to() */
> +#define _TIF_WORK_CTXSW (_TIF_DEBUG|_TIF_IO_BITMAP)
> +
>  /*
>   * Thread-synchronous status.
>   *

-- 

-Stephane
