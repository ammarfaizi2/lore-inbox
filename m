Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVDNAjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVDNAjF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 20:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVDNAjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 20:39:05 -0400
Received: from mail.aei.ca ([206.123.6.14]:5625 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261405AbVDNAi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 20:38:58 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc2-mm3
Date: Wed, 13 Apr 2005 20:38:52 -0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050411012532.58593bc1.akpm@osdl.org> <200504132015.49877.tomlins@cam.org> <20050413172039.4502b2a9.akpm@osdl.org>
In-Reply-To: <20050413172039.4502b2a9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504132038.52377.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 April 2005 20:20, Andrew Morton wrote:
> Ed Tomlinson <tomlins@cam.org> wrote:
> >
> > > Don't think so - it works OK here.  Checked the .config?  Does the serial
> >  > port work if you do `echo foo > /dev/ttyS0'?  ACPI?
> > 
> >  Turned out it was some old ups software that got reactivated on the box displaying the
> >  console - was a pain to disable it....
> 
> OK.
> 
> >  In any case, when the box reboots there are not any messages.  Any ideas on what debug
> >  options to enable or suggestions on how we can figure out the cause of the reboots.
> 
> There were a few problems in the task switching area - maybe that.

These hit arch/i386.  Are they going to help on an x86_64 box?

Ed 
 
> From: Ingo Molnar <mingo@elte.hu>
> 
> delay the reloading of segment registers into switch_mm(), so that if
> the LDT size changes we dont get a (silent) fault and a zeroed selector
> register upon reloading.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  25-akpm/arch/i386/kernel/process.c     |   10 +++++-----
>  25-akpm/include/asm-i386/mmu_context.h |    7 +++++++
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff -puN arch/i386/kernel/process.c~sched-unlocked-context-switches-fix arch/i386/kernel/process.c
> --- 25/arch/i386/kernel/process.c~sched-unlocked-context-switches-fix	2005-04-12 03:43:07.254363568 -0700
> +++ 25-akpm/arch/i386/kernel/process.c	2005-04-12 03:43:07.259362808 -0700
> @@ -653,12 +653,12 @@ struct task_struct fastcall * __switch_t
>  	asm volatile("mov %%gs,%0":"=m" (prev->gs));
>  
>  	/*
> -	 * Restore %fs and %gs if needed.
> +	 * Clear selectors if needed:
>  	 */
> -	if (unlikely(prev->fs | prev->gs | next->fs | next->gs)) {
> -		loadsegment(fs, next->fs);
> -		loadsegment(gs, next->gs);
> -	}
> +        if (unlikely((prev->fs | prev->gs) && !(next->fs | next->gs))) {
> +                loadsegment(fs, next->fs);
> +                loadsegment(gs, next->gs);
> +        }
>  
>  	/*
>  	 * Now maybe reload the debug registers
> diff -puN include/asm-i386/mmu_context.h~sched-unlocked-context-switches-fix include/asm-i386/mmu_context.h
> --- 25/include/asm-i386/mmu_context.h~sched-unlocked-context-switches-fix	2005-04-12 03:43:07.256363264 -0700
> +++ 25-akpm/include/asm-i386/mmu_context.h	2005-04-12 03:43:07.260362656 -0700
> @@ -61,6 +61,13 @@ static inline void switch_mm(struct mm_s
>  		}
>  	}
>  #endif
> +	/*
> +	 * Now that we've switched the LDT, load segments:
> +	 */
> +	if (unlikely(current->thread.fs | current->thread.gs)) {
> +		loadsegment(fs, current->thread.fs);
> +		loadsegment(gs, current->thread.gs);
> +	}
>  }
>  
>  #define deactivate_mm(tsk, mm) \
> _
> 
> 
