Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030425AbWAMA4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030425AbWAMA4e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 19:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030428AbWAMA4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 19:56:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42199 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030425AbWAMA4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 19:56:32 -0500
Date: Thu, 12 Jan 2006 16:58:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 5/13] s390: show_task oops.
Message-Id: <20060112165826.5843e34c.akpm@osdl.org>
In-Reply-To: <20060112171516.GF16629@skybase.boeblingen.de.ibm.com>
References: <20060112171516.GF16629@skybase.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> [patch 5/13] s390: show_task oops.
> 
> The show_task function walks the kernel stack backchain of
> processes assuming that the processes are not running. Since
> this assumption is not correct walking the backchain can lead
> to an addressing exception and therefore to a kernel hang.
> So prevent the kernel hang (you still get incorrect results)
> verity that all read accesses are within the bounds of the
> kernel stack before performing them.
> 

This one needs to be thought about and tested versus the just-merged
s390-task_stack_page.patch.  I guess it'll still work, but some of the
pretty new accessors could be used in there, at least.

> --- linux-2.6/arch/s390/kernel/process.c	2006-01-12 15:43:19.000000000 +0100
> +++ linux-2.6-patched/arch/s390/kernel/process.c	2006-01-12 15:43:55.000000000 +0100
> @@ -58,10 +58,19 @@ asmlinkage void ret_from_fork(void) __as
>   */
>  unsigned long thread_saved_pc(struct task_struct *tsk)
>  {
> -	struct stack_frame *sf;
> +	struct stack_frame *sf, *low, *high;
>  
> -	sf = (struct stack_frame *) tsk->thread.ksp;
> -	sf = (struct stack_frame *) sf->back_chain;
> +	if (!tsk || !tsk->thread_info)
> +		return 0;
> +	low = (struct stack_frame *) tsk->thread_info;
> +	high = (struct stack_frame *)
> +		((unsigned long) tsk->thread_info + THREAD_SIZE) - 1;
> +	sf = (struct stack_frame *) (tsk->thread.ksp & PSW_ADDR_INSN);
> +	if (sf <= low || sf > high)
> +		return 0;
> +	sf = (struct stack_frame *) (sf->back_chain & PSW_ADDR_INSN);
> +	if (sf <= low || sf > high)
> +		return 0;
>  	return sf->gprs[8];
>  }
>  
