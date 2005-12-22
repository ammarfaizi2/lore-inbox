Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbVLVR4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbVLVR4v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 12:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbVLVR4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 12:56:51 -0500
Received: from fsmlabs.com ([168.103.115.128]:34224 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1030244AbVLVR4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 12:56:49 -0500
X-ASG-Debug-ID: 1135274206-14315-91-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Thu, 22 Dec 2005 10:02:06 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Eric Dumazet <dada1@cosmosbay.com>
cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Christoph Lameter <christoph@lameter.com>,
       Alok N Kataria <alokk@calsoftinc.com>,
       Shobhit Dayal <shobhit@calsoftinc.com>,
       Shai Fultheim <shai@scalex86.org>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
X-ASG-Orig-Subj: Re: [PATCH RT 00/02] SLOB optimizations
Subject: Re: [PATCH RT 00/02] SLOB optimizations
In-Reply-To: <43A90C07.4000003@cosmosbay.com>
Message-ID: <Pine.LNX.4.64.0512211945590.31683@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com>
 <20051220135725.GA29392@elte.hu> <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
 <1135093460.13138.302.camel@localhost.localdomain> <20051220181921.GF3356@waste.org>
 <1135106124.13138.339.camel@localhost.localdomain>
 <84144f020512201215j5767aab2nc0a4115c4501e066@mail.gmail.com>
 <1135114971.13138.396.camel@localhost.localdomain> <20051221065619.GC766@elte.hu>
 <43A90225.4060007@cosmosbay.com> <20051221074346.GA2398@elte.hu>
 <43A90C07.4000003@cosmosbay.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463810560-58104516-1135223220=:31683"
Content-ID: <Pine.LNX.4.64.0512212017490.31683@montezuma.fsmlabs.com>
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.6549
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463810560-58104516-1135223220=:31683
Content-Type: TEXT/PLAIN; CHARSET=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.0512212017491.31683@montezuma.fsmlabs.com>

On Wed, 21 Dec 2005, Eric Dumazet wrote:

> Ingo Molnar a =E9crit :
> > * Eric Dumazet <dada1@cosmosbay.com> wrote:
> >=20
> > in any case, on sane platforms (i386, x86_64) an irq-disable is
> > well-optimized in hardware, and is just as fast as a preempt_disable().
> >=20
>=20
> I'm afraid its not the case on current hardware.
>=20
> The irq enable/disable pair count for more than 50% the cpu time spent in
> kmem_cache_alloc()/kmem_cache_free()/kfree()
>=20
> oprofile results on a dual Opteron 246 :
>=20
> You can see the high profile numbers right after cli and popf(sti)
> instructions, popf being VERY expensive.
>=20
> CPU: Hammer, speed 1993.39 MHz (estimated)
> Counted CPU_CLK_UNHALTED events (Cycles outside of halt state) with a uni=
t
> mask of 0x00 (No unit mask) count 50000
>=20
> 29993     1.9317  kfree
> 18654     1.2014  kmem_cache_alloc
> 12962     0.8348  kmem_cache_free
>=20
> ffffffff8015c370 <kfree>: /* kfree total:  30334  1.9335 */
>    770  0.0491 :ffffffff8015c370:       push   %rbp
>   2477  0.1579 :ffffffff8015c371:       mov    %rdi,%rbp
>                :ffffffff8015c374:       push   %rbx
>                :ffffffff8015c375:       sub    $0x8,%rsp
>   1792  0.1142 :ffffffff8015c379:       test   %rdi,%rdi
>                :ffffffff8015c37c:       je     ffffffff8015c452 <kfree+0x=
e2>
>    122  0.0078 :ffffffff8015c382:       pushfq
>   1001  0.0638 :ffffffff8015c383:       popq   (%rsp)
>   1456  0.0928 :ffffffff8015c386:       cli
>   2489  0.1586 :ffffffff8015c387:       mov    $0xffffffff7fffffff,%rax  =
  <<
>=20
> ...
>     72  0.0046 :ffffffff8015c44e:       pushq  (%rsp)
>   1080  0.0688 :ffffffff8015c451:       popfq
>  13934  0.8882 :ffffffff8015c452:       add    $0x8,%rsp      << HERE >>

Isn't that due to taking an interrupt?
---1463810560-58104516-1135223220=:31683--
