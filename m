Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbVBXOBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbVBXOBI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 09:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbVBXOBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 09:01:08 -0500
Received: from mail.timesys.com ([65.117.135.102]:61611 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262351AbVBXOBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 09:01:05 -0500
Message-ID: <421DDD29.7010606@timesys.com>
Date: Thu, 24 Feb 2005 08:56:57 -0500
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank Rowand <frowand@mvista.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Saksena, Manas" <Manas.Saksena@timesys.com>,
       john cooper <john.cooper@timesys.com>
Subject: Re: PPC RT Patch..
References: <1109182061.16201.6.camel@krustophenia.net>	 <Pine.LNX.4.61.0502231908040.13491@goblin.wat.veritas.com>	 <1109187381.3174.5.camel@krustophenia.net>	 <Pine.LNX.4.61.0502231952250.14603@goblin.wat.veritas.com>	 <1109190614.3126.1.camel@krustophenia.net>	 <Pine.LNX.4.61.0502232053320.14747@goblin.wat.veritas.com> <1109196876.4009.3.camel@krustophenia.net> <421D175A.2010804@timesys.com> <421D55FB.9060108@mvista.com>
In-Reply-To: <421D55FB.9060108@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Feb 2005 13:58:52.0171 (UTC) FILETIME=[F8C0CDB0:01C51A78]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Rowand wrote:
> john cooper wrote:
>> ... There is also a bug fix
>> contained for tlb_gather_mmu() which was causing debug
>> assertions to be generated in a path which attempted to
>> sleep with a non-zero preempt count.
> 
> 
> Manish Lachwani mentioned to me that he faced the same issue
> with the MIPS RT support and that when he discussed
> it with Ingo that the solution was for include/asm-ppc/tlb.h
> to include/asm-generic/tlb-simple.h when PREEMPT_RT is turned on.
> The patch does this for the #ifdef CONFIG_PPC_STD_MMU case,
> but not for the #else case.  I don't know which case is used
> for the Ampro board.

It appeared to me a generic issue though I believe a number
of solutions are possible.  asm-generic/tlb.h:tlb_gather_mmu()
expands to linux/percpu.h:get_cpu_var() which does a
preempt_disable() and __get_cpu_var().  This caused the debug
assertion to kick when __page_cache_release() and to a lesser
extent activate_page() attempted to block on a mutex (though
other paths may well exist).  My approach was to replace the
outer layer preempt_disable/enable calls with a mutex-spinlock.

The fix was fairly easy once it was known from where the
gratuitous call to preempt_disable() existed.  I cobbled
together a logging mechanism which detected the problem.  As it
wasn't very general I removed it from the patch.  I didn't see
an alternate means of diagnosing such a scenario so I'll likely
address generalizing the code.

-john


-- 
john.cooper@timesys.com
