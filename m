Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUFLU1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUFLU1i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 16:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264918AbUFLU1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 16:27:38 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:5262 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S264917AbUFLU13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 16:27:29 -0400
Subject: Re: timer + fpu stuff locks up computer
From: Alexander Nyberg <alexn@telia.com>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       stian@nixia.no
In-Reply-To: <20040612184511.GD3396@sirius.home>
References: <20040612134413.GA3396@sirius.home>
	 <1087050351.707.5.camel@boxen> <20040612151422.GC3396@sirius.home>
	 <20040612184511.GD3396@sirius.home>
Content-Type: text/plain
Message-Id: <1087072045.707.54.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 12 Jun 2004 22:27:25 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-12 at 20:45, Sergey Vlasov wrote:
> On Sat, Jun 12, 2004 at 07:14:22PM +0400, Sergey Vlasov wrote:
> > If the FPU state belong to the userspace process, kernel_fpu_begin()
> > is safe even if some exceptions are pending.  However, after
> > __clear_fpu() the FPU is "orphaned", and kernel_fpu_begin() does
> > nothing with it.
> > 
> > Replacing fwait with fnclex instead of removing it completely should
> > avoid the fault later.
> 
> Yes, it seems to be enough.  Another case where it looks like FPU
> might be "orphaned" is exit(); however, it is handled as a normal task
> switch, __switch_to() calls __unlazy_fpu(), which clears pending
> exceptions.
> 
> I'm still not sure what to do about possibly lost FP exceptions.  This
> can happen in two cases:
> 
> 1) Program calls execve() while an FP exception is pending.
> 
>    In this case clear_fpu() is called when the original executable is
>    already destroyed.  Even if we generate a SIGFPE in this case, it
>    would be delivered to the new executable.
> 
> 2) Program returns from a signal handler while an FP exception is
>    pending.
> 
>    In this case at clear_fpu() time restore_sigcontext() has already
>    wiped out all state of the signal handler, so the SIGFPE would
>    appear to be raised from the program code at the point where it was
>    interrupted by the handled signal.
> 
> Signed-Off-By: Sergey Vlasov <vsu@altlinux.ru>
> 
> --- linux-2.6.6/include/asm-i386/i387.h.fp-lockup	2004-05-10 06:33:06 +0400
> +++ linux-2.6.6/include/asm-i386/i387.h	2004-06-12 22:02:58 +0400
> @@ -48,10 +48,17 @@
>  		save_init_fpu( tsk ); \
>  } while (0)
>  
> +/*
> + * There might be some pending exceptions in the FP state at this point.
> + * However, it is too late to report them: this code is called during execve()
> + * (when the original executable is already gone) and during sigreturn() (when
> + * the signal handler context is already lost).  So just clear them to prevent
> + * problems later.
> + */
>  #define __clear_fpu( tsk )					\
>  do {								\
>  	if ((tsk)->thread_info->status & TS_USEDFPU) {		\
> -		asm volatile("fwait");				\
> +		asm volatile("fnclex");				\
>  		(tsk)->thread_info->status &= ~TS_USEDFPU;	\
>  		stts();						\
>  	}							\
> 

This works, tested also on a box with md and things looked fine.


Alex

