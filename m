Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318776AbSHGSTQ>; Wed, 7 Aug 2002 14:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318791AbSHGSTQ>; Wed, 7 Aug 2002 14:19:16 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:26358 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S318776AbSHGSTO>;
	Wed, 7 Aug 2002 14:19:14 -0400
Message-ID: <3D51656B.34338AE1@mvista.com>
Date: Wed, 07 Aug 2002 11:22:35 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Wolfgang Wegner <ww@kt.e-technik.uni-dortmund.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Anything special with 64 Bit Operations in Kernel?
References: <20020807162037.F2949@bigmac.e-technik.uni-dortmund.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang Wegner wrote:
> 
> Hi,
> 
> sorry if this is off-topic because "a bit" x86-centric, but i have some
> problems since using 64-bit operations in kernel-space (especially: in
> interrupt context), and am wondering if there might be any special issues.
> 
> What i do quite often is a 64-bit/32-bit division, and also some other
> calculations, and now i found out that my code hangs the machine because
> of a "divide error" (that's what the oops prints to the console prior
> to the halt, sysrq keeps working). All "division by zero" errors are from
> my knowledge avoided correctly.

This is caused by overflow.  The div results in a number
that will not fit in 32-bits.

In all archs, there is a file (.../include/asm/div64.h) that
defines a function (do_div(n,base)) that does a (64-bit
n)/(32-bit base) with a 64-bit result.  Watch out, however,
as the result is returned in "n" with the function value
being the remainder (32-bit).  This will not overflow, but
when you take the low 32-bits of the result, you are
ignoring the fact that the result is bigger than 32-bits.

-g
> 
> It *seems* that more/other problems happen when the code is running on
> an athlon, but unfortunately there are also different distribution
> releases (and thus gcc versions) involved, so i am still unsure there.
> (And don't have all machines under my control to make it uniform)
> 
> I did not find any references on problems specific to 64-bit operations,
> so in case anyone also experienced strange behaviour - be it processor,
> compiler or kernel - or knows a place where i could look, please let
> me know!
> My main problem is that these events occur only occasionally, so it is
> a bit difficult to give an accurate example.
> 
> Thanks,
> Wolfgang
> 
> P.S.:
> Another point: we had to change
> static s64 st_pll_mult(s32 var1, s32 var2, s8 frac1, s8 frac2, s8 frac_res)
> to
> static void st_pll_mult(s64 * retval, s32 var1, s32 var2, s8 frac1, s8 frac2, s8 frac_res)
> because else the resulting s64 is sometimes overwritten by something else,
> depending on the code around the function call.
> (don't know all compiler versions, but i was using gcc-2.95.3 from SuSE 7.3
> and can reproduce this)
> Should i release the kernel from the suspicion and try another compiler? :)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
