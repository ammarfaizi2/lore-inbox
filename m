Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbTIEWVZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 18:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264015AbTIEWVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 18:21:24 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:24564 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263787AbTIEWVV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 18:21:21 -0400
Message-ID: <3F590BDD.9010902@mvista.com>
Date: Fri, 05 Sep 2003 15:19:09 -0700
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: Andrew Morton <akpm@osdl.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, jun.nakajima@intel.com
Subject: Re: [PATCHSET][2.6-test4][0/6]Support for HPET based timer - Take
 2
References: <C8C38546F90ABF408A5961FC01FDBF1902C7D211@fmsmsx405.fm.intel.com> <20030829112347.2d8e292d.akpm@osdl.org> <20030829210335.GA3150@codepoet.org>
In-Reply-To: <20030829210335.GA3150@codepoet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> On Fri Aug 29, 2003 at 11:23:47AM -0700, Andrew Morton wrote:
> 
>>"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> wrote:
>>
>>>Resending the patch.
>>
>>Thanks, I'll include these in the next -mm kernel.
>>
>>Reading the code, the only thing which leaps out is:
>>
>>+/* Use our own asm for 64 bit multiply/divide */
>>+#define ASM_MUL64_REG(eax_out,edx_out,reg_in,eax_in) 			\
>>+		__asm__ __volatile__("mull %2" 				\
>>+				:"=a" (eax_out), "=d" (edx_out) 	\
>>+				:"r" (reg_in), "0" (eax_in))

This can be done in standard C.  If you want an inline, how about 
(from .../kernel/posix-timers.c):

static inline u64  mpy_l_X_l_ll(unsigned long mpy1,unsigned long mpy2)
{
	return (u64)mpy1 * mpy2;
}


>>+
>>+#define ASM_DIV64_REG(eax_out,edx_out,reg_in,eax_in,edx_in) 		\
>>+		__asm__ __volatile__("divl %2" 				\
>>+				:"=a" (eax_out), "=d" (edx_out) 	\
>>+				:"r" (reg_in), "0" (eax_in), "1" (edx_in))

This appears to be the same as (from .../include/asm-i386/div64.h):

#define div_long_long_rem(a,b,c) div_ll_X_l_rem(a,b,c)

extern inline long
div_ll_X_l_rem(long long divs, long div, long *rem)
{
	long dum2;
       __asm__("divl %2":"=a"(dum2), "=d"(*rem)
       :	"rm"(div), "A"(divs));

	return dum2;

}

-g

>>
>>We seem to keep on proliferating home-grown x86 64-bit math functions.
>>
>>Do you really need these?  Is it possible to use do_div() and the C 64x64
>>`*' operator instead?
> 
> 
> 
> The fundamental reason these are proliferating is that given
> some random bit of code such as:
> 
>     u64 foo=9, bar=3, baz;
>     baz = foo / bar;
>     baz = foo % bar;
> 
> gcc then generates code calling __udivdi3 and __umoddi3.  Since
> the kernel does not provide these, people keep reinventing them.
> Perhaps it is time to kill off do_div and all its little friends
> and simply copy __udivdi3 and __umoddi3 from libgcc.....
> 
>  -Erik
> 
> --
> Erik B. Andersen             http://codepoet-consulting.com/
> --This message was written using 73% post-consumer electrons--
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

