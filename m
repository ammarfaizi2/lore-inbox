Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753181AbWKCH0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbWKCH0G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 02:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753184AbWKCH0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 02:26:06 -0500
Received: from sp604005mt.neufgp.fr ([84.96.92.11]:63883 "EHLO smtp.Neuf.fr")
	by vger.kernel.org with ESMTP id S1753181AbWKCH0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 02:26:03 -0500
Date: Fri, 03 Nov 2006 08:26:05 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: [x86_64] Strange oprofile results on access to per_cpu data
In-reply-to: <200611030356.54074.ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <454AEF0D.1090402@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7BIT
References: <20061029024504.760769000@sous-sol.org>
 <20061030231132.GA98768@muc.de>
 <1162376827.23462.5.camel@localhost.localdomain>
 <200611030356.54074.ak@suse.de>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi

While doing some oprofile analysis, I got this result on ip_route_input() : 
one particular instruction seems to spend a lot of cycles.

machine is a dual core 285, 2.6 GHz

/*
  * Command line: opannotate -a event:CPU_CLK_UNHALTED 
/usr/src/linux-2.6.18/vmlinux
  *
  * Interpretation of command line:
  * Output annotated assembly listing with samples
  *
  * CPU: AMD64 processors, speed 2600.01 MHz (estimated)
  * Counted CPU_CLK_UNHALTED events (Cycles outside of halt state) with a unit 
mask of 0x00 (No unit mask) count 10000
  */

ffffffff803e9860 <ip_route_input>: /* ip_route_input total: 543098  2.5487 */

/* relevant extract from ip_route_input() */
    600  0.0028 :ffffffff803e98b3:       mov    $0xffffffff806375e0,%rsi
    883  0.0041 :ffffffff803e98ba:       mov    %rax,%rdx
      6 2.8e-05 :ffffffff803e98bd:       mov    %rsi,%rcx
   2281  0.0107 :ffffffff803e98c0:       cmp    0xf0(%rdx),%r12d
   9767  0.0458 :ffffffff803e98c7:       jne    ffffffff803e98f1 
<ip_route_input+0x91>
    108 5.1e-04 :ffffffff803e98c9:       cmp    0xf4(%rdx),%r14d
  41459  0.1946 :ffffffff803e98d0:       jne    ffffffff803e98f1 
<ip_route_input+0x91>
    549  0.0026 :ffffffff803e98d2:       cmp    0xec(%rdx),%ebx
  88604  0.4158 :ffffffff803e98d8:       jne    ffffffff803e98f1 
<ip_route_input+0x91>
    478  0.0022 :ffffffff803e98da:       mov    0xe8(%rdx),%eax
    315  0.0015 :ffffffff803e98e0:       test   %eax,%eax
    241  0.0011 :ffffffff803e98e2:       jne    ffffffff803e98f1 
<ip_route_input+0x91>
    248  0.0012 :ffffffff803e98e4:       cmp    0xfc(%rdx),%r13b

   2314  0.0109 :ffffffff803e98eb:       je     ffffffff803ea3b3
################ BEGIN
    370  0.0017 :ffffffff803e98f1:       mov    %gs:0x8,%rax
222769  1.0454 :ffffffff803e98fa:       incl   0x38(%rcx,%rax,1)
################ END
      6 2.8e-05 :ffffffff803e98fe:       mov    (%rdx),%rdx
    833  0.0039 :ffffffff803e9901:       test   %rdx,%rdx

__raw_get_cpu_var(rt_cache_stat).field++ appears to be very expensive

(about 18000 RT_CACHE_STAT_INC(in_hlist_search); are done per second, not an 
impressive count in fact)

Are segment prefixes that expensive ?
Or is it only the first access to %gs:8 that is doing extra checks ?
(because other RT_CACHE_STAT_INC() done in the same function dont have this cost)
Or is it the loading of %rcx (done in ffffffff803e98bd) that is stalling ?

I was wondering if avoiding a dependancy would help :

As we dont have TLS support in kernel yet, I was considering trying (just for 
experimentation) to stick a struct rt_cache_stat in pda, since it avoids one step.

#if defined(RT_CACHE_STAT_IN_PDA)
# define RT_CACHE_STAT_INC(field) add_pda(rt_cache_stat.field, 1)
# define addr_of_rt_cache_stat(cpu) &cpu_pda(cpu)->rt_cache_stat
#else
   static DEFINE_PER_CPU(struct rt_cache_stat, rt_cache_stat);
# define RT_CACHE_STAT_INC(field) (__raw_get_cpu_var(rt_cache_stat).field++)
# define addr_of_rt_cache_stat(cpu) &per_cpu(rt_cache_stat, cpu)
#endif

so that RT_CACHE_STAT_INC(field) would map to

    addl $1,%gs:OFFSET  /* no register needed */

Thank you
Eric
