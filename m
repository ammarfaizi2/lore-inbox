Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262508AbTCRSUI>; Tue, 18 Mar 2003 13:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262516AbTCRSUI>; Tue, 18 Mar 2003 13:20:08 -0500
Received: from vbws78.voicebs.com ([66.238.160.78]:17171 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S262508AbTCRSUB>; Tue, 18 Mar 2003 13:20:01 -0500
Message-ID: <3E7765DE.10609@didntduck.org>
Date: Tue, 18 Mar 2003 13:30:54 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kevin Pedretti <ktpedre@sandia.gov>, linux-kernel@vger.kernel.org
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4
 due to wrmsr (performance)
References: <Pine.LNX.4.44.0303180809190.11381-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0303180809190.11381-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Tue, 18 Mar 2003, Kevin Pedretti wrote:
> 
>>    I wasn't aware of what you state below but it makes sense.  What I 
>>haven't been able to figure out, and nobody seems to know, is why the 
>>rodata section of an executable is placed in the text section and is not 
>>page aligned.  This seems to be a mixing of code and data on the same 
>>page.  Maybe it doesn't matter since it is read only?
> 
> 
> It's a bad idea to share even read-only data, but the impact of read-only 
> data is much less that read-write. In particular, you should avoid sharing 
> _any_ code and data in the same physical L1 cache-line, since that will be 
> a big problem for any CPU with exclusion between the I$ and D$.
> 
> HOWEVER, modern x86 CPU's tend to have the I$ be part of the cache 
> coherency protocol, so instead of having exclusion they allow sharing as 
> long as the D$ isn't actually dirty. In that case it's fine to share 
> read-only data and code, although the cache utilization goes down if you 
> do a lot of it.
> 
> Anyway, as long as they are in separate cache-lines, you should be ok even 
> on something with cache exclusion.
> 
> When it comes to actually _writing_ to the data, at least on the P4 you
> don't want to have read-write data anywhere _near_ the I$ (somebody
> reported half-page granularity). This is true on crusoe too, btw (at a
> 128-byte granularity).
> 
> Anyway, I think gcc should make sure that even the ro-data section is at
> least cacheline-aligned so that it stays away from cachelines used for I$.  
> That makes sense even on CPU's that don't have exclusion, since it
> actually gives slightly better L1 cache utilization.
> 
> You can run this (stupid) test-program to try. On my P4 I get
> 
> 	empty overhead=320 cycles
> 	load overhead=0 cycles
> 	I$ load overhead=0 cycles
> 	I$ load overhead=0 cycles
> 	I$ store overhead=264 cycles
> 
> and on my PIII I get
> 
> 	empty overhead=74 cycles
> 	load overhead=8 cycles
> 	I$ load overhead=8 cycles
> 	I$ load overhead=8 cycles
> 	I$ store overhead=103 cycles
> 
> and (just for fun) on an old crusoe I get
> 
> 	empty overhead=67 cycles
> 	load overhead=-9 cycles
> 	I$ load overhead=-14 cycles
> 	I$ load overhead=-14 cycles
> 	I$ store overhead=12 cycles
> 
> where that "negative overhead" just shows that we do some strnge things to
> scheduling, and the loop actually ends up faster if it has a load in it
> than without the load..
> 
> But you can see that storing to code is a really bad idea. Especially on a 
> P4, where the overhead for a store was 264 cycles! (You can also see the 
> cost of doing just the empty synchronization and rdtsc - 320 cycles for a 
> rdtsc and two locked memory accesses on a P4).
> 
> I don't have access to an old Pentium - I think that was the one that had 
> the strict exclusion between the L1 I$ and D$, and then you should see the 
> I$ load overhead go up.
> 
> 			Linus

Here's a few more data points:

vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 451.037
empty overhead=105 cycles
load overhead=-2 cycles
I$ load overhead=30 cycles
I$ load overhead=90 cycles
I$ store overhead=95 cycles


vendor_id       : GenuineIntel
cpu family      : 6
model           : 3
model name      : Pentium II (Klamath)
stepping        : 3
cpu MHz         : 265.913
empty overhead=73 cycles
load overhead=10 cycles
I$ load overhead=10 cycles
I$ load overhead=10 cycles
I$ store overhead=2 cycles


vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1409.946
empty overhead=11 cycles
load overhead=5 cycles
I$ load overhead=5 cycles
I$ load overhead=5 cycles
I$ store overhead=826 cycles

The Athlon XP shows really bad behavior when you store to the text area.

--
				Brian Gerst

