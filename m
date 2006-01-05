Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWAEXeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWAEXeW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWAEXeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:34:21 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:56468 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932252AbWAEXeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:34:18 -0500
Date: Fri, 6 Jan 2006 00:30:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Martin Bligh <mbligh@mbligh.org>, Matt Mackall <mpm@selenic.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
Message-ID: <20060105233049.GA3441@elte.hu>
References: <200601041959_MC3-1-B550-5EE2@compuserve.com> <43BC716A.5080204@mbligh.org> <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105170255.GK3356@waste.org> <43BD5E6F.1040000@mbligh.org> <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org> <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org> <43BD784F.4040804@mbligh.org> <Pine.LNX.4.64.0601051208510.3169@g5.osdl.org> <Pine.LNX.4.64.0601051213270.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601051213270.3169@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> On Thu, 5 Jan 2006, Linus Torvalds wrote:
> > 
> > The cache effects are likely the biggest ones, and no, I don't know how 
> > much denser it will be in the cache. Especially with a 64-byte one.. 
> > (although 128 bytes is fairly common too).
> 
> Oh, but validatign things like "likely()" and "unlikely()" branch 
> hints might be a noticeably bigger issue.

i frequently validate branches in performance-critical kernel code like 
the scheduler (and the mutex code ;), via instruction-granularity 
profiling, driven by a high-frequency (10-100 KHz) NMI interrupt. A bad 
branch layout shows up pretty clearly in annotated assembly listings:

c037313c:     1715 <schedule>:
c037313c:     1715 	55                   	push   %ebp
c037313d:      264 	b8 00 f0 ff ff       	mov    $0xfffff000,%eax
c0373142:      150 	89 e5                	mov    %esp,%ebp
c0373144:        0 	57                   	push   %edi
c0373145:      852 	56                   	push   %esi
c0373146:      215 	53                   	push   %ebx
c0373147:        0 	83 ec 30             	sub    $0x30,%esp
c037314a:      184 	21 e0                	and    %esp,%eax
c037314c:      120 	8b 10                	mov    (%eax),%edx
c037314e:        0 	83 ba 84 00 00 00 00 	cmpl   $0x0,0x84(%edx)
c0373155:       83 	75 2b                	jne    c0373182 <schedule+0x46>
c0373157:      104 	8b 48 14             	mov    0x14(%eax),%ecx
c037315a:       39 	f7 c1 ff ff ff ef    	test   $0xefffffff,%ecx
c0373160:      112 	74 20                	je     c0373182 <schedule+0x46>
c0373162:        0 	ff b2 9c 00 00 00    	pushl  0x9c(%edx)
c0373168:        0 	8d 82 a4 01 00 00    	lea    0x1a4(%edx),%eax
c037316e:        0 	51                   	push   %ecx
c037316f:        0 	50                   	push   %eax
c0373170:        0 	68 7e 0e 39 c0       	push   $0xc0390e7e
c0373175:        0 	e8 a3 36 da ff       	call   c011681d <printk>
c037317a:        0 	e8 48 03 d9 ff       	call   c01034c7 <dump_stack>
c037317f:        0 	83 c4 10             	add    $0x10,%esp
c0373182:      323 	8b 55 04             	mov    0x4(%ebp),%edx
c0373185:        5 	b8 02 00 00 00       	mov    $0x2,%eax
c037318a:        0 	e8 b3 3f da ff       	call   c0117142 <profile_hit>
c037318f:      349 	b8 00 f0 ff ff       	mov    $0xfffff000,%eax
c0373194:      880 	21 e0                	and    %esp,%eax
c0373196:        0 	8b 00                	mov    (%eax),%eax
c0373198:        0 	89 45 d4             	mov    %eax,0xffffffd4(%ebp)
c037319b:      440 	83 78 14 00          	cmpl   $0x0,0x14(%eax)
c037319f:        5 	78 05                	js     c03731a6 <schedule+0x6a>

the second column is the number of profiler hits. As you can see, the 
branch at c0373160 is always taken, and there's a hole of 32 bytes in 
the instruction stream. It is relatively easy to identify the 
likely/unlikely candidates for various workloads. (It would probably be 
even better to have a visual tool that also associates the source code 
with the data.)

i've seen alot of such profiles on alot of different workloads, and my 
guesstimate would be that with 'perfect' likely/unlikely hints, and with 
'perfect' function ordering, we could roughly halve (!) the current 
icache footprint of the kernel on complex workloads too.

Especially with 64 or 128 byte L1 cachelines our codepaths are really 
fragmented and we can easily have 3-4 times of the optimal icache 
footprint, for a given syscall. We very often have cruft in the hotpath, 
and we often have functions that belong together ripped apart by things 
like e.g. __sched annotators. I havent seen many cases of wrongly judged 
likely/unlikely hints, what happens typically is that there's no 
annotation and the default compiler guess is wrong.

the dcache footprint of the kernel is much better, mostly because it's 
so easy to control it in C. The icache footprint is alot more elusive.  
(and also alot more critical to execution speed on nontrivial workloads)

so i think there are two major focus areas to improve our icache 
footprint:

 - reduce code size
 - reduce fragmentation of the codepath

fortunately both are hard and technically challenging projects, and both 
will improve the icache footprint - and they will also bring other 
benefits. [ We usually have much more problems with the easy and boring 
stuff ;-) ]

icache fragmentation reduction is also hard because it has to deal with 
fundamentally conflicting constraints: one workload's ideal ordering is 
different from another workload's ideal ordering, and such workloads can 
be superimposed on a system.

I think the only sane solution [that would be endorsed by distributions] 
is to allow users to reorder function sections runtime (per boot). That 
is alot faster and more robust (from a production POV) than a full 
recompilation of the kernel. Recompilation is always risky, it needs too 
much context, and has too many tool dependencies - and is thus currently 
untestable. And we dont really need a recompilation of the kernel 
technically - we need a relinking. Relinking is much safer from a 
testability POV: reordering of the functions doesnt change their 
internal instruction sequence or their interactions.

and we could use mcount() to gather function-cohesion data runtime. The 
mcount() call could be patched out from the image runtime, when no data 
gathering is happening. Given that the average function size is ~100 
bytes, and an mcount call costs 5 bytes, the overhead would be +5% of 
size and an extra 5-byte NOP per function. That's not good, but it is 
still at least an order of magnitude smaller than the possible gain in 
icache footprint. (Also, people could run mcount()-less kernels as well, 
once the data has been gathered, and the relink was done.)

one problem are modules though - they could only be reordered within 
themselves. On an average system which has ~100 modules loaded, the 
average icache fragmentation is +100*128/2 == 6.4K [with 128 byte L1 
cachelines], which can be significant (depending on the workload). OTOH, 
modules do have strong internal cohesion - they contain functions that 
belong together conceptually. So by reordering functions within modules 
we'll likely be able to realize most of the icache savings possible. The 
only exception would be workloads that utilize many modules at a high 
frequency. Such workloads will likely trash the icache anyway.

	Ingo
