Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262943AbTDBAVt>; Tue, 1 Apr 2003 19:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262945AbTDBAVt>; Tue, 1 Apr 2003 19:21:49 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:37270 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S262943AbTDBAVs>; Tue, 1 Apr 2003 19:21:48 -0500
Date: Tue, 1 Apr 2003 16:33:07 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: whitney@math.berkeley.edu
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.65: Caching MSR_IA32_SYSENTER_CS kills dosemu
In-Reply-To: <Pine.LNX.4.44.0304011320580.13867-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0304011632060.2951-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Apr 2003, Linus Torvalds wrote:

> Can you test this patch? 

This patch (on top of the previous one) does the trick for me.  Thanks!

Wayne

> ===== arch/i386/kernel/vm86.c 1.22 vs edited =====
> --- 1.22/arch/i386/kernel/vm86.c	Mon Mar 31 14:30:01 2003
> +++ edited/arch/i386/kernel/vm86.c	Tue Apr  1 13:25:28 2003
> @@ -113,10 +113,14 @@
>  		printk("vm86: could not access userspace vm86_info\n");
>  		do_exit(SIGSEGV);
>  	}
> +
> +	preempt_disable();
>  	tss = init_tss + smp_processor_id();
>  	current->thread.esp0 = current->thread.saved_esp0;
>  	load_esp0(tss, current->thread.esp0);
>  	current->thread.saved_esp0 = 0;
> +	preempt_enable();
> +
>  	loadsegment(fs, current->thread.saved_fs);
>  	loadsegment(gs, current->thread.saved_gs);
>  	ret = KVM86->regs32;
> @@ -289,10 +293,11 @@
>  	asm volatile("movl %%fs,%0":"=m" (tsk->thread.saved_fs));
>  	asm volatile("movl %%gs,%0":"=m" (tsk->thread.saved_gs));
>  
> -	tss = init_tss + get_cpu();
> +	preempt_disable();
> +	tss = init_tss + smp_processor_id();
>  	tss->esp0 = tsk->thread.esp0 = (unsigned long) &info->VM86_TSS_ESP0;
>  	disable_sysenter(tss);
> -	put_cpu();
> +	preempt_enable();
>  
>  	tsk->thread.screen_bitmap = info->screen_bitmap;
>  	if (info->flags & VM86_SCREEN_BITMAP)


