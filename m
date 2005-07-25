Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVGYT1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVGYT1d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVGYTZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:25:17 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:41739 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261282AbVGYTW4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:22:56 -0400
Message-ID: <42E53CFB.7080300@tmr.com>
Date: Mon, 25 Jul 2005 15:26:51 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2.6.13-rc3a] i386: inline restore_fpu
References: <200507212309_MC3-1-A534-95EF@compuserve.com> <20050722081417.GJ3160@stusta.de> <Pine.LNX.4.58.0507221028070.6074@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507221028070.6074@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 22 Jul 2005, Adrian Bunk wrote:
> 
>>If this patch makes a difference, could you do me a favour and check 
>>whether replacing the current cpu_has_fxsr #define in
>>include/asm-i386/cpufeature.h with
>>
>>  #define cpu_has_fxsr           1
>>
>>on top of your patch brings an additional improvement?
> 
> 
> It would be really sad if it made a difference. There might be a branch
> mispredict, but the real expense of the fnsave/fxsave will be that
> instruction itself, and any cache misses associated with it. The 9%
> performace difference would almost have to be due to a memory bank
> conflict or something (likely some unnecessary I$ prefetching that
> interacts badly with the writeback needed for the _big_ memory write
> forced by the fxsave).
> 
> I can't see any way that a single branch mispredict could make that big of 
> a difference, but I _can_ see how bad memory access patterns could do it.
> 
> Btw, the switch from fnsave to fxsave (and thus the change from a 112-byte
> save area to a 512-byte one, or whatever the exact details are) caused
> _huge_ performance degradation for various context switching benchmarks. I
> really hated that, but obviously the need to support SSE2 made it
> non-optional. The point being that the real overhead is that big memory 
> read/write in fxrestor/fxsave.
> 
> What _could_ make a bigger difference is not doing the lazy FPU at all.  
> That lazy FPU is a huge optimization on 99.9% of all loads, but it sounds
> like java/volanomark are broken and always use the FPU, and then we take a
> big hit on doing the FP restore exception (an exception is a lot more
> expensive than a mispredict).

It seems expensive to do the save/restore when it isn't needed, that's 
why the code got lazy. Would it be useful to have a small flag or count 
field and start by assuming that FPU is not used, and if the exception 
takes place set the count to unconditionally save the FP state for some 
number of context switches and then try reverting to lazy save?

That 99.9% may be a guess, but I suspect that there are a lot of 
applications which alternate between using FPU and not, even if they do 
use FPU for some parts of the application. That way the performance of 
lazy save would be realized for the common applications, and the 
overhead of exception would be greatly reduced for both the ill-behaved 
and legitimately FPU intensive application.

> 
> Something like the following (totally untested) should make it be
> non-lazy. It's going to slow down normal task switches, but might speed up 
> the "restoring FP context all the time" case.
> 
> Chuck? This should work fine with or without your inline thing. Does it 
> make any difference?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
