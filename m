Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWCHANn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWCHANn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 19:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWCHANn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 19:13:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58241 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964815AbWCHANm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 19:13:42 -0500
Date: Tue, 7 Mar 2006 16:15:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@osdl.org
Subject: Re: [patch] i386 spinlocks: disable interrupts only if we enabled
 them
Message-Id: <20060307161550.27941df5.akpm@osdl.org>
In-Reply-To: <200603071837_MC3-1-BA13-E5FB@compuserve.com>
References: <200603071837_MC3-1-BA13-E5FB@compuserve.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> _raw_spin_lock_flags() is entered with interrupts disabled.  If it
> cannot obtain a spinlock, it checks the flags that were passed and
> re-enables interrupts before spinning if that's how the flags are set.
> When the spinlock might be available, it disables interrupts (even if
> they are already disabled) before trying to get the lock.  Change that
> so interrupts are only disabled if they have been enabled.  This costs
> nine bytes of duplicated spinloop code.
> 
> Fastpath before patch:
>         jle <keep looping>      not-taken conditional jump
>         cli                     disable interrupts
>         jmp <try for lock>      unconditional jump
> 
> Fastpath after patch, if interrupts were not enabled:
>         jg <try for lock>       taken conditional branch
> 

Well no.  The fastpath is:

	jns	4f		we got the lock.

> 
> --- 2.6.16-rc5-d2.orig/include/asm-i386/spinlock.h
> +++ 2.6.16-rc5-d2/include/asm-i386/spinlock.h
> @@ -35,18 +35,23 @@
>  #define __raw_spin_lock_string_flags \
>  	"\n1:\t" \
>  	"lock ; decb %0\n\t" \
> -	"jns 4f\n\t" \
> +	"jns 5f\n" \
>  	"2:\t" \
>  	"testl $0x200, %1\n\t" \
> -	"jz 3f\n\t" \
> -	"sti\n\t" \
> +	"jz 4f\n\t" \
> +	"sti\n" \
>  	"3:\t" \
>  	"rep;nop\n\t" \
>  	"cmpb $0, %0\n\t" \
>  	"jle 3b\n\t" \
>  	"cli\n\t" \
>  	"jmp 1b\n" \
> -	"4:\n\t"
> +	"4:\t" \
> +	"rep;nop\n\t" \
> +	"cmpb $0, %0\n\t" \
> +	"jg 1b\n\t" \
> +	"jmp 4b\n" \
> +	"5:\n\t"
>  

So this is speeding up the slowpath, which really shouldn't matter unless
we have bigger problems.

And it's increasing text size.  Which wouldn't be a big problem if the
spinning code was still in an out-of-line section, but it isn't any more.

(I forget why we undid that optimisation.  What was wrong with it?)
