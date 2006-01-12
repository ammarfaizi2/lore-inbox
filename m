Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161359AbWALWN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161359AbWALWN4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161358AbWALWN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:13:56 -0500
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:400 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S1161359AbWALWNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:13:55 -0500
Date: Thu, 12 Jan 2006 14:11:32 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       discuss@x86-64.org
Subject: Re: ptrace denies access to EFLAGS_RF
Message-ID: <20060112221132.GE30055@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200601061112_MC3-1-B567-47BB@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601061112_MC3-1-B567-47BB@compuserve.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck,

I tired today with 2.6.15-git8 and now it works just fine
on my Opteron box.

Thanks for your help.

On Fri, Jan 06, 2006 at 11:10:16AM -0500, Chuck Ebbert wrote:
> In-Reply-To: <20060106140217.GD7676@frankl.hpl.hp.com>
> 
> On Fri, 6 Jan 2006 at 06:02:17 -0800, Stephane Eranian wrote:
> 
> 
> > To my surprise, applying the same fix to the x86_64 does not
> > solve the problem on my Opteron box. I verified that the
> > offset (144) matches with what the kernel is expecting.
> > Somehow the RF is lost or not set in the proper location.
> > I cannot make forward progress once I reach the breakpoint.
> 
> 
> I sent this to Andi this morning.  Does it work for you?
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> 
>  arch/x86_64/ia32/ptrace32.c |    9 ++++++---
>  arch/x86_64/kernel/ptrace.c |    9 ++++++---
>  2 files changed, 12 insertions(+), 6 deletions(-)
> 
> --- 2.6.15-64a.orig/arch/x86_64/ia32/ptrace32.c
> +++ 2.6.15-64a/arch/x86_64/ia32/ptrace32.c
> @@ -28,9 +28,12 @@
>  #include <asm/i387.h>
>  #include <asm/fpu32.h>
>  
> -/* determines which flags the user has access to. */
> -/* 1 = access 0 = no access */
> -#define FLAG_MASK 0x44dd5UL
> +/*
> + * Determines which flags the user has access to [1 = access, 0 = no access].
> + * Prohibits changing ID(21), VIP(20), VIF(19), VM(17), IOPL(12-13), IF(9).
> + * Also masks reserved bits (31-22, 15, 5, 3, 1).
> + */
> +#define FLAG_MASK 0x54dd5UL
>  
>  #define R32(l,q) \
>  	case offsetof(struct user32, regs.l): stack[offsetof(struct pt_regs, q)/8] = val; break
> --- 2.6.15-64a.orig/arch/x86_64/kernel/ptrace.c
> +++ 2.6.15-64a/arch/x86_64/kernel/ptrace.c
> @@ -36,9 +36,12 @@
>   * in exit.c or in signal.c.
>   */
>  
> -/* determines which flags the user has access to. */
> -/* 1 = access 0 = no access */
> -#define FLAG_MASK 0x44dd5UL
> +/*
> + * Determines which flags the user has access to [1 = access, 0 = no access].
> + * Prohibits changing ID(21), VIP(20), VIF(19), VM(17), IOPL(12-13), IF(9).
> + * Also masks reserved bits (63-22, 15, 5, 3, 1).
> + */
> +#define FLAG_MASK 0x54dd5UL
>  
>  /* set's the trap flag. */
>  #define TRAP_FLAG 0x100UL
> -- 
> Chuck
> Currently reading: _Thud!_ by Terry Pratchett

-- 

-Stephane
