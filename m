Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVERMmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVERMmS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 08:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVERMmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 08:42:18 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:405 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261254AbVERMlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 08:41:51 -0400
Date: Wed, 18 May 2005 18:11:44 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Alexander Nyberg <alexn@telia.com>
Cc: fastboot@lists.osdl.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>
Subject: Re: [Fastboot] [2/2] kdump: Save trap information for later analyzis
Message-ID: <20050518124144.GB3657@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1116103800.6153.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116103800.6153.31.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2005 at 10:50:00PM +0200, Alexander Nyberg wrote:
> If we are faulting in kernel it is quite possible this will lead to a
> panic. Save trap number, cr2 (in case of page fault) and error_code in
> the current thread (these fields already exist for signal delivery but
> are not used here). 
> 
> This helps later kdump crash analyzing from user-space (a script has
> been submitted to dig this info out in gdb).
> 
> Signed-off-by: Alexander Nyberg <alexn@telia.com>
> 
> Index: mm/arch/i386/mm/fault.c
> ===================================================================
> --- mm.orig/arch/i386/mm/fault.c	2005-05-14 22:05:56.000000000 +0200
> +++ mm/arch/i386/mm/fault.c	2005-05-14 22:06:21.000000000 +0200
> @@ -469,6 +469,9 @@
>  		printk(KERN_ALERT "*pte = %08lx\n", page);
>  	}
>  #endif
> +	tsk->thread.cr2 = address;
> +	tsk->thread.trap_no = 14;
> +	tsk->thread.error_code = error_code;
>  	die("Oops", regs, error_code);
>  	bust_spinlocks(0);
>  	do_exit(SIGKILL);
> Index: mm/arch/i386/kernel/traps.c
> ===================================================================
> --- mm.orig/arch/i386/kernel/traps.c	2005-05-14 22:05:56.000000000 +0200
> +++ mm/arch/i386/kernel/traps.c	2005-05-14 22:06:21.000000000 +0200
> @@ -431,8 +431,11 @@
>  	}
>  
>  	kernel_trap: {
> -		if (!fixup_exception(regs))
> +		if (!fixup_exception(regs)) {
> +			current->thread.trap_no = trapnr;
> +			current->thread.error_code = error_code;
>  			die(str, regs, error_code);
> +		}
>  		return;
>  	}
>  
> @@ -537,6 +540,9 @@
>  	}
>  	put_cpu();
>  
> +	current->thread.error_code = error_code;
> +	current->thread.trap_no = 13;
> +	


This assignment is being done again in case thread was running in user mode.
That can now be done away with as above code will take care of both the cases.

	if (!user_mode(regs))
		goto gp_in_kernel;

	current->thread.error_code = error_code;
	current->thread.trap_no = 13;
	force_sig(SIGSEGV, current);



>  	if (regs->eflags & VM_MASK)
>  		goto gp_in_vm86;
>  
> @@ -977,9 +983,9 @@
>  					  error_code);
>  			return;
>  		}
> -		die_if_kernel("cache flush denied", regs, error_code);
>  		current->thread.trap_no = 19;
>  		current->thread.error_code = error_code;
> +		die_if_kernel("cache flush denied", regs, error_code);
>  		force_sig(SIGSEGV, current);
>  	}
>  }
> 
> 

> _______________________________________________
> fastboot mailing list
> fastboot@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/fastboot

