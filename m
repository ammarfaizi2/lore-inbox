Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWAFJlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWAFJlt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 04:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWAFJlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 04:41:49 -0500
Received: from palrel13.hp.com ([156.153.255.238]:52126 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S932390AbWAFJls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 04:41:48 -0500
Date: Fri, 6 Jan 2006 01:39:51 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: ptrace denies access to EFLAGS_RF
Message-ID: <20060106093951.GA7676@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200601052314_MC3-1-B55E-CFB5@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601052314_MC3-1-B55E-CFB5@compuserve.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck,

Thanks for the quick patch. It does fix my problem.

Note that the same problem exists on x86_64 and
the same patch should fix the problem there as well.


On Thu, Jan 05, 2006 at 11:11:29PM -0500, Chuck Ebbert wrote:
> In-Reply-To: <20060105105130.GC3712@frankl.hpl.hp.com>
> 
> On Thu, 5 Jan 2006 at 02:51:30 -0800, Stephane Eranian wrote:
> 
> > I am trying to the user HW debug registers on i386
> > and I am running into a problem with ptrace() not allowing access
> > to EFLAGS_RF for POKEUSER (see FLAG_MASK).
> > 
> > I am not sure I understand the motivation for denying access
> > to this flag which can be used to resume after a code
> > breakpoint has been reached. It avoids the need to remove the
> > breakpoint, single step, and reinstall. The equivalent
> > functionality exists on IA-64 and is allowed by ptrace().
> 
> I see no reason for denying this.  This patch should fix it:
> 
> 
> i386: PTRACE_POKEUSR: allow changing RF bit in EFLAGS register.
> 
> Setting RF (resume flag) allows a debugger to resume execution
> after a code breakpoint without tripping the breakpoint again.
> It is reset by the CPU after execution of one instruction.
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> 
> --- 2.6.15a.orig/arch/i386/kernel/ptrace.c
> +++ 2.6.15a/arch/i386/kernel/ptrace.c
> @@ -32,9 +32,12 @@
>   * in exit.c or in signal.c.
>   */
>  
> -/* determines which flags the user has access to. */
> -/* 1 = access 0 = no access */
> -#define FLAG_MASK 0x00044dd5
> +/*
> + * Determines which flags the user has access to [1 = access, 0 = no access].
> + * Prohibits changing ID(21), VIP(20), VIF(19), VM(17), IOPL(12-13), IF(9).
> + * Also masks reserved bits (31-22, 15, 5, 3, 1).
> + */
> +#define FLAG_MASK 0x00054dd5
>  
>  /* set's the trap flag. */
>  #define TRAP_FLAG 0x100
> -- 
> Chuck
> Currently reading: _Thud!_ by Terry Pratchett

-- 

-Stephane
