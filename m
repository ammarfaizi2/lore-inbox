Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbUCWCls (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 21:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbUCWCls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 21:41:48 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:41136 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262191AbUCWCll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 21:41:41 -0500
Date: Mon, 22 Mar 2004 18:39:18 -0800
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-Id: <20040322183918.5e0f17c7.pj@sgi.com>
In-Reply-To: <20040323020940.GV2045@holomorphy.com>
References: <1079651064.8149.158.camel@arrakis>
	<20040318165957.592e49d3.pj@sgi.com>
	<1079659184.8149.355.camel@arrakis>
	<20040318175654.435b1639.pj@sgi.com>
	<1079737351.17841.51.camel@arrakis>
	<20040319165928.45107621.pj@sgi.com>
	<20040320031843.GY2045@holomorphy.com>
	<20040320000235.5e72040a.pj@sgi.com>
	<20040320111340.GA2045@holomorphy.com>
	<20040322171243.070774e5.pj@sgi.com>
	<20040323020940.GV2045@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> go for it

I'll try.

The main thing I keep seeing, when I look at the resulting machine
code, is that things such as the following (stripped of everything
except the bare bones hardwired stuff I needed to compile):

    #define BITS_TO_LONGS(i) (i+63)/64
    #define NR_CPUS 64
    #define __mask(bits)    struct { unsigned long _m[BITS_TO_LONGS(bits)]; }
    typedef __mask(NR_CPUS) cpumask_t;

    #define mask_and(d,s1,s2)                                       \
    do {                                                            \
	    int i;                                                  \
	    for (i = 0; i < sizeof(d)/sizeof(unsigned long); i++)   \
		    d._m[i] = s1._m[i] & s2._m[i];                  \
    } while(0)

    unsigned long f(cpumask_t c, cpumask_t d, cpumask_t e)
    {
	mask_and(c,d,e);
	return c._m[0];
    }


end up producing quite fine code, such as a single inline 64 bit and
instruction, with no evidence of the for loop, array or struct wrapper,
on an ia64 (gcc 3.2.3 -O2) for the interesting guts of my silly little
test function f().

Objdump -d of function f() in above:

    4000000000000610 <f>:
    4000000000000610:       0d 60 c0 19 3f 23       [MFI]       adds r12=-16,r12
    4000000000000616:       00 00 00 02 00 00                   nop.f 0x0
    400000000000061c:       21 0a 31 80                         and r8=r34,r33;;
    4000000000000620:       11 00 00 00 01 00       [MIB]       nop.m 0x0
    4000000000000626:       c0 80 30 00 42 80                   adds r12=16,r12
    400000000000062c:       08 00 84 00                         br.ret.sptk.many b0;;

>From this I conjecture that I can provide a single call:

    cpumask_and(cpumask_t d, cpumask_t s1, cpumask_t s2);

that works on both normal (1 to 32 cpu) systems and on big iron systems,
with traditional 'C' pass by value semantics, all derived from a single
mask type that works for both node and cpu masks.

The one sticky point evident to me so far would be if some generic code
were passing a cpumask_t across a function call boundary, and needed to
be optimum for both small and sparc64 - one would want to pass by value,
the other would want to pass a pointer to the cpumask.

This is not your fathers 'C'.  The compile time inlining and
optimization provided by gcc enables it to do a lot more than Dennis
Ritchie's original C compiler that I learned on.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
