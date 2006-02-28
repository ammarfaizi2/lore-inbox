Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWB1GHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWB1GHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 01:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbWB1GHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 01:07:24 -0500
Received: from mail4.hitachi.co.jp ([133.145.228.5]:58514 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1750803AbWB1GHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 01:07:23 -0500
Message-ID: <4403E894.4050300@sdl.hitachi.co.jp>
Date: Tue, 28 Feb 2006 15:07:16 +0900
From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: ananth@in.ibm.com, prasanna@in.ibm.com, anil.s.keshavamurthy@intel.com,
       systemtap@sources.redhat.com, jkenisto@us.ibm.com,
       linux-kernel@vger.kernel.org, sugita@sdl.hitachi.co.jp,
       soshima@redhat.com, haoki@redhat.com
Subject: Re: [PATCH][take2][2/2] kprobe: kprobe-booster against 2.6.16-rc5
 for i386
References: <43DE0A4D.20908@sdl.hitachi.co.jp>	<4402E920.5080402@sdl.hitachi.co.jp> <20060227185012.037c8830.akpm@osdl.org>
In-Reply-To: <20060227185012.037c8830.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew

Andrew Morton wrote:
> Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp> wrote:
>> Here is a patch of kprobe-booster for i386 arch against linux-2.6.16-rc5.
>>  The kprobe-booster patch is also under the influence of the NX-protection
>>  support patch. So, I fixed that.
>>
>>  Could you replace the previous patches with these patches?
> 
> I'd prefer not to.  Once a patch has been in -mm for this long I really
> prefer to not see wholesale replacements.  When people do this to me I
> usually turn their replacements into incremental patches so we can see what
> changed.  Which is useful.
> 
> Your first patch was identical to what I already have, so I dropped that.


Thank you for your advice. I will re-create an additional patch
against recent -mm tree.

> Your second patch made these changes:
> 
> --- devel/arch/i386/kernel/kprobes.c~kprobe-kprobe-booster-against-2616-rc5-for	2006-02-27 18:40:29.000000000 -0800
> +++ devel-akpm/arch/i386/kernel/kprobes.c	2006-02-27 18:40:57.000000000 -0800
> @@ -305,7 +305,7 @@ static int __kprobes kprobe_handler(stru
>  
>  	if (p->ainsn.boostable == 1 &&
>  #ifdef CONFIG_PREEMPT
> -	    !(pre_preempt_count) && /*
> +	    !(pre_preempt_count()) && /*
>  				       * This enables booster when the direct
>  				       * execution path aren't preempted.
>  				       */
> @@ -313,7 +313,7 @@ static int __kprobes kprobe_handler(stru
>  	    !p->post_handler && !p->break_handler ) {
>  		/* Boost up -- we can execute copied instructions directly */
>  		reset_current_kprobe();
> -		regs->eip = (unsigned long)&p->ainsn.insn;
> +		regs->eip = (unsigned long)p->ainsn.insn;
>  		preempt_enable_no_resched();
>  		return 1;
>  	}
> 
> The first hunk is surely wrong - pre_preempt_count is a local unsigned
> integer, not a function.

I'm sorry. It's my fault. The first hunk is just a degradation.

> And I'm not sure about the second hunk either - surely an `eip' should
> point at an instruction, not be assigned the value of an instruction?

This change is important. Because NX-protection support patch makes
the ainsn.insn a pointer instead of a data structure, so now (&p->ainsn.insn)
means just an address of the pointer -- not the instruction address.

> So I'll drop both patches.  If you have bugfixes, please make them relative
> to already-merged things.  Against most-recent -mm is best, as I do fix
> patches up, and other people send fixes which you might not have merged
> locally.  And please ensure that the changes compile and run with and
> without CONFIG_PREEMPT!

OK. I will get the latest -mm tree and test it.
And I will re-send the patch ASAP.

-- 
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: hiramatu@sdl.hitachi.co.jp



