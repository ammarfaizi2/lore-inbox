Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbVLUIC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVLUIC2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 03:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVLUIC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 03:02:28 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:62814 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S932197AbVLUIC2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 03:02:28 -0500
Message-ID: <43A90C07.4000003@cosmosbay.com>
Date: Wed, 21 Dec 2005 09:02:15 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Christoph Lameter <christoph@lameter.com>,
       Alok N Kataria <alokk@calsoftinc.com>,
       Shobhit Dayal <shobhit@calsoftinc.com>,
       Shai Fultheim <shai@scalex86.org>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT 00/02] SLOB optimizations
References: <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com> <20051220135725.GA29392@elte.hu> <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com> <1135093460.13138.302.camel@localhost.localdomain> <20051220181921.GF3356@waste.org> <1135106124.13138.339.camel@localhost.localdomain> <84144f020512201215j5767aab2nc0a4115c4501e066@mail.gmail.com> <1135114971.13138.396.camel@localhost.localdomain> <20051221065619.GC766@elte.hu> <43A90225.4060007@cosmosbay.com> <20051221074346.GA2398@elte.hu>
In-Reply-To: <20051221074346.GA2398@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar a écrit :
> * Eric Dumazet <dada1@cosmosbay.com> wrote:
> 
> 
>>>while it could possibly be cleaned up a bit, it's one of the 
>>>best-optimized subsystems Linux has. Most of the "unnecessary 
>>>complexity" in SLAB is related to a performance or a debugging feature.  
>>>Many times i have looked at the SLAB code in a disassembler, right next 
>>>to profile output from some hot workload, and have concluded: 'I couldnt 
>>>do this any better even with hand-coded assembly'.
>>
>>Well, I miss a version of kmem_cache_alloc()/kmem_cache_free() that 
>>wont play with IRQ masking.
> 
> 
> sure, but adding this sure wont reduce complexity ;)
> 
> 
>>The local_irq_save()/local_irq_restore() pair is quite expensive and 
>>could be avoided for several caches that are exclusively used in 
>>process context.
> 
> 
> in any case, on sane platforms (i386, x86_64) an irq-disable is 
> well-optimized in hardware, and is just as fast as a preempt_disable().
> 

I'm afraid its not the case on current hardware.

The irq enable/disable pair count for more than 50% the cpu time spent in 
kmem_cache_alloc()/kmem_cache_free()/kfree()

oprofile results on a dual Opteron 246 :

You can see the high profile numbers right after cli and popf(sti) 
instructions, popf being VERY expensive.

CPU: Hammer, speed 1993.39 MHz (estimated)
Counted CPU_CLK_UNHALTED events (Cycles outside of halt state) with a unit 
mask of 0x00 (No unit mask) count 50000

29993     1.9317  kfree
18654     1.2014  kmem_cache_alloc
12962     0.8348  kmem_cache_free

ffffffff8015c370 <kfree>: /* kfree total:  30334  1.9335 */
    770  0.0491 :ffffffff8015c370:       push   %rbp
   2477  0.1579 :ffffffff8015c371:       mov    %rdi,%rbp
                :ffffffff8015c374:       push   %rbx
                :ffffffff8015c375:       sub    $0x8,%rsp
   1792  0.1142 :ffffffff8015c379:       test   %rdi,%rdi
                :ffffffff8015c37c:       je     ffffffff8015c452 <kfree+0xe2>
    122  0.0078 :ffffffff8015c382:       pushfq
   1001  0.0638 :ffffffff8015c383:       popq   (%rsp)
   1456  0.0928 :ffffffff8015c386:       cli
   2489  0.1586 :ffffffff8015c387:       mov    $0xffffffff7fffffff,%rax    <<

...
     72  0.0046 :ffffffff8015c44e:       pushq  (%rsp)
   1080  0.0688 :ffffffff8015c451:       popfq
  13934  0.8882 :ffffffff8015c452:       add    $0x8,%rsp      << HERE >>
    290  0.0185 :ffffffff8015c456:       pop    %rbx
                :ffffffff8015c457:       pop    %rbp
    124  0.0079 :ffffffff8015c458:       retq


ffffffff8015c460 <kmem_cache_free>: /* kmem_cache_free total:  13084  0.8340 */
    388  0.0247 :ffffffff8015c460:       sub    $0x18,%rsp
    365  0.0233 :ffffffff8015c464:       mov    %rbp,0x10(%rsp)
                :ffffffff8015c469:       mov    %rbx,0x8(%rsp)
    121  0.0077 :ffffffff8015c46e:       mov    %rsi,%rbp
    262  0.0167 :ffffffff8015c471:       pushfq
    549  0.0350 :ffffffff8015c472:       popq   (%rsp)
    351  0.0224 :ffffffff8015c475:       cli
   2478  0.1579 :ffffffff8015c476:       mov    %gs:0x34,%eax
    592  0.0377 :ffffffff8015c47e:       cltq
                :ffffffff8015c480:       mov    (%rdi,%rax,8),%rbx
      7 4.5e-04 :ffffffff8015c484:       mov    (%rbx),%eax
    200  0.0127 :ffffffff8015c486:       cmp    0x4(%rbx),%eax
                :ffffffff8015c489:       jae    ffffffff8015c48f 
<kmem_cache_free+0x2f>
                :ffffffff8015c48b:       mov    %eax,%eax
    766  0.0488 :ffffffff8015c48d:       jmp    ffffffff8015c4a0 
<kmem_cache_free+0x40>
                :ffffffff8015c48f:       mov    %rbx,%rsi
     71  0.0045 :ffffffff8015c492:       callq  ffffffff8015c810 
<cache_flusharray>
                :ffffffff8015c497:       mov    (%rbx),%eax
      1 6.4e-05 :ffffffff8015c499:       data16
                :ffffffff8015c49a:       data16
                :ffffffff8015c49b:       data16
                :ffffffff8015c49c:       nop
                :ffffffff8015c49d:       data16
                :ffffffff8015c49e:       data16
                :ffffffff8015c49f:       nop
                :ffffffff8015c4a0:       mov    %rbp,0x10(%rbx,%rax,8)
     20  0.0013 :ffffffff8015c4a5:       incl   (%rbx)
    176  0.0112 :ffffffff8015c4a7:       pushq  (%rsp)
      7 4.5e-04 :ffffffff8015c4aa:       popfq
   6187  0.3944 :ffffffff8015c4ab:       mov    0x8(%rsp),%rbx << HERE>>
    543  0.0346 :ffffffff8015c4b0:       mov    0x10(%rsp),%rbp
                :ffffffff8015c4b5:       add    $0x18,%rsp
                :ffffffff8015c4b9:       retq


ffffffff8015bd70 <kmem_cache_alloc>: /* kmem_cache_alloc total:  18803  1.1985 */
    549  0.0350 :ffffffff8015bd70:       sub    $0x8,%rsp
    700  0.0446 :ffffffff8015bd74:       pushfq
   1427  0.0910 :ffffffff8015bd75:       popq   (%rsp)
    226  0.0144 :ffffffff8015bd78:       cli
   2399  0.1529 :ffffffff8015bd79:       mov    %gs:0x34,%eax  <<HERE>>
    416  0.0265 :ffffffff8015bd81:       cltq
                :ffffffff8015bd83:       mov    (%rdi,%rax,8),%rdx
     21  0.0013 :ffffffff8015bd87:       mov    (%rdx),%eax
    172  0.0110 :ffffffff8015bd89:       test   %eax,%eax
                :ffffffff8015bd8b:       je     ffffffff8015bda1 
<kmem_cache_alloc+0x31>
      8 5.1e-04 :ffffffff8015bd8d:       dec    %eax
   1338  0.0853 :ffffffff8015bd8f:       movl   $0x1,0xc(%rdx)
      9 5.7e-04 :ffffffff8015bd96:       mov    %eax,(%rdx)
      9 5.7e-04 :ffffffff8015bd98:       mov    %eax,%eax
   1146  0.0730 :ffffffff8015bd9a:       mov    0x10(%rdx,%rax,8),%rax
      4 2.5e-04 :ffffffff8015bd9f:       jmp    ffffffff8015bda6 
<kmem_cache_alloc+0x36>
                :ffffffff8015bda1:       callq  ffffffff8015c160 
<cache_alloc_refill>
    154  0.0098 :ffffffff8015bda6:       pushq  (%rsp)
    241  0.0154 :ffffffff8015bda9:       popfq
   9222  0.5878 :ffffffff8015bdaa:       prefetchw (%rax) <<HERE>>
    758  0.0483 :ffffffff8015bdad:       add    $0x8,%rsp
      4 2.5e-04 :ffffffff8015bdb1:       retq

Eric
