Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVBXEeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVBXEeT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 23:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVBXEbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 23:31:48 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:40951 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261786AbVBXEUU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 23:20:20 -0500
Message-ID: <421D55FB.9060108@mvista.com>
Date: Wed, 23 Feb 2005 20:20:11 -0800
From: Frank Rowand <frowand@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john cooper <john.cooper@timesys.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Saksena, Manas" <Manas.Saksena@timesys.com>
Subject: Re: PPC RT Patch..
References: <1109182061.16201.6.camel@krustophenia.net>	 <Pine.LNX.4.61.0502231908040.13491@goblin.wat.veritas.com>	 <1109187381.3174.5.camel@krustophenia.net>	 <Pine.LNX.4.61.0502231952250.14603@goblin.wat.veritas.com>	 <1109190614.3126.1.camel@krustophenia.net>	 <Pine.LNX.4.61.0502232053320.14747@goblin.wat.veritas.com> <1109196876.4009.3.camel@krustophenia.net> <421D175A.2010804@timesys.com>
In-Reply-To: <421D175A.2010804@timesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john cooper wrote:
> Ingo,
>     We've had a PPC port of your RT work underway with
> a focus on trace instrumentation.  This is based upon
> realtime-preempt-2.6.11-rc2-V0.7.37-02.  A diff is
> attached.
> 
> To the extent possible the tracing facilities are the
> same as your x86 work.  In the process a few PPC/gcc
> issues needed to be resolved.  There is also a bug fix
> contained for tlb_gather_mmu() which was causing debug
> assertions to be generated in a path which attempted to
> sleep with a non-zero preempt count.

Manish Lachwani mentioned to me that he faced the same issue
with the MIPS RT support and that when he discussed
it with Ingo that the solution was for include/asm-ppc/tlb.h
to include/asm-generic/tlb-simple.h when PREEMPT_RT is turned on.
The patch does this for the #ifdef CONFIG_PPC_STD_MMU case,
but not for the #else case.  I don't know which case is used
for the Ampro board.


> 
> This does build and function when SMP is configured,
> though we have not yet verified it on other than a
> uniprocessor.  As a simplifying assumption, testing has
> thus far concentrated on the following modes:
> 
> PREEMPT_NONE
>     - verify baseline regression
> 
> PREEMPT_RT && !PREEMPT_SMP
>     - typical for an embedded RT PPC application
> 
> PREEMPT_RT && PREEMPT_SMP
>     - kicks in live locking code which otherwise receives no
>     coverage.  This is functionally equivalent to the above
>     config on a single CPU target thus no MP dynamic testing
>     is achieved.  Still quite useful IMHO.
> 
> The target used for development/testing is an Ampro EnCore PP1
> which sports a 300Mhz MPC8245.  For testing this boots with NFS
> as root.  An mp3 decode at nice --20 is launched which requires
> just under 20% of the CPU to maintain an uninterrupted audio
> decode and output.  To this a series of "du -s /" are launched
> to soak up excess CPU bandwidth.  Perhaps not rigorous but a
> fair sanity check and load for the purpose at hand.
> 
> Under these conditions maximum scheduling latencies are seen in
> the 120-150us range.  Note no attempt has yet been made to
> optimize arch specific paths and full trace instrumentation has
> been enabled.
> 
> I've written some logging code to help find problems such as
> the tlb issue above.  As it has not been made general I've
> removed it from this patch.  At some point I'll likely revisit
> this.
> 
> Comments/suggestions welcome.

I am glad to see the instrumentation and measurement related code
in your patch.  (My patch of last week ("Frank's patch") is lacking
that code.)

Other differences between the two patches are:

arch/ppc/syslib/i8259.c
    Frank neglected to convert i8259_lock to a raw spinlock.

arch/ppc/kernel/signal.c
    John added an enable of irqs in do_signal()  #ifdef CONFIG_PREEMPT_RT

arch/ppc/kernel/traps.c
    John added an enable of irqs and preempt_check_resched() in _exception().

various files
    Frank added the intrusive variable tb_to_us for use by cycles_to_usec()
    and added an ugly #ifdef in cycles_to_usec().
    John hard-coded cpu_khz for one specific board so that no change would
    be needed in cycles_to_usec().

various files
    John has the mmu_gather fix that is described above.

John's patch and Frank's patch are otherwise mostly the same, except for
the differences that result from being based on different kernel
versions.  I am glad to see that because it means that two sets of
eyes have agreed.

Frank's patch may have missed some EXPORT_SYMBOL()s in arch/ppc/lib/locks.c.
I'll check those over again tomorrow.


> -john


-Frank
-- 
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

