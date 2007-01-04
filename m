Return-Path: <linux-kernel-owner+w=401wt.eu-S932263AbXADDI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbXADDI5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 22:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbXADDI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 22:08:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:26322 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932263AbXADDI4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 22:08:56 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,234,1165219200"; 
   d="scan'208"; a="181244591:sNHT21894957"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: kernel + gcc 4.1 = several problems
Date: Thu, 4 Jan 2007 11:08:46 +0800
Message-ID: <10EA09EFD8728347A513008B6B0DA77A086B84@pdsmsx411.ccr.corp.intel.com>
In-Reply-To: <Pine.LNX.4.64.0701030731080.4473@woody.osdl.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel + gcc 4.1 = several problems
thread-index: AccvUfIQRHxvivaiS1ab9hpAgUM77gAWlneg
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: "Linus Torvalds" <torvalds@osdl.org>,
       "Grzegorz Kulewski" <kangur@polcom.net>
Cc: "Alan" <alan@lxorguk.ukuu.org.uk>, "Mikael Pettersson" <mikpe@it.uu.se>,
       <s0348365@sms.ed.ac.uk>, <76306.1226@compuserve.com>, <akpm@osdl.org>,
       <bunk@stusta.de>, <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       <yanmin_zhang@linux.intel.com>
X-OriginalArrivalTime: 04 Jan 2007 03:08:54.0933 (UTC) FILETIME=[AB12C450:01C72FAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Linus Torvalds
> Sent: 2007Äê1ÔÂ4ÈÕ 0:04
> To: Grzegorz Kulewski
> Cc: Alan; Mikael Pettersson; s0348365@sms.ed.ac.uk;
> 76306.1226@compuserve.com; akpm@osdl.org; bunk@stusta.de; greg@kroah.com;
> linux-kernel@vger.kernel.org; yanmin_zhang@linux.intel.com
> Subject: Re: kernel + gcc 4.1 = several problems
> 
> 
> 
> On Wed, 3 Jan 2007, Grzegorz Kulewski wrote:
> >
> > Could you explain why CMOV is pointless now? Are there any benchmarks proving
> > that?
> 
> CMOV (and, more generically, any "predicated instruction") tends to
> generally a bad idea on an aggressively out-of-order CPU. It doesn't
> always have to be horrible, but in practice it is seldom very nice, and
> (as usual) on the P4 it can be really quite bad.
> 
> On a P4, I think a cmov basically takes 10 cycles.
> 
> But even ignoring the usual P4 "I suck at things that aren't totally
> normal", cmov is actually not a great idea. You can always replace it by
> 
> 		j<negated condition> forward
> 		mov ..., %reg
> 	forward:
> 
> and assuming the branch is AT ALL predictable (and 95+% of all branches
> are), the branch-over will actually be a LOT better for a CPU.
> 
> Why? Becuase branches can be predicted, and when they are predicted they
> basically go away. They go away on many levels, too. Not just the branch
> itself, but the _conditional_ for the branch goes away as far as the
> critical path of code is concerned: the CPU still has to calculate it and
> check it, but from a performance angle it "doesn't exist any more",
> because it's not holding anything else up (well, you want to do it in
> _some_ reasonable time, but the point stands..)
> 
> Similarly, whichever side of the branch wasn't taken goes away. Again, in
> an out-of-order machine with register renaming, this means that even if
> the branch isn't taken above, and you end up executing all the non-branch
> instructions, because you now UNCONDITIONALLY over-write the register, the
> old data in the register is now DEAD, so now all the OTHER writes to that
> register are off the critical path too!
> 
> So the end result is that with a conditional branch, ona good CPU, the
> _only_ part of the code that is actually performance-sensitive is the
> actual calculation of the value that gets used!
> 
> In contrast, if you use a predicated instruction, ALL of it is on the
> critical path. Calculating the conditional is on the critical path.
> Calculating the value that gets used is obviously ALSO on the critical
> path, but so is the calculation for the value that DOESN'T get used too.
> So the cmov - rather than speeding things up - actually slows things down,
> because it makes more code be dependent on each other.
> 
> So here's the basic rule:
> 
>  - cmov is sometimes nice for code density. It's not a big win, but it
>    certainly can be a win.
> 
>  - if you KNOW the branch is totally unpredictable, cmov is often good for
>    performance. But a compiler almost never knows that, and even if you
>    train it with input data and profiling, remember that not very many
>    branches _are_ totally unpredictable, so even if you were to know that
>    something is unpredictable, it's going to be very rare.
> 
>  - on a P4, branch mispredictions are expensive, but so is cmov, so all
>    the above is to some degree exaggerated. On nicer microarchitectures
>    (the Intel Core 2 in particular is something I have to say is very nice
>    indeed), the difference will be a lot less noticeable. The loss from
>    cmov isn't very big (it's not as sucky as P4), but neither is the win
>    (branch misprediction isn't that expensive either).
> 
> Here's an example program that you can test and time yourself.
> 
> On my Core 2, I get
> 
> 	[torvalds@woody ~]$ gcc -DCMOV -Wall -O2 t.c
> 	[torvalds@woody ~]$ time ./a.out
> 	600000000
> 
> 	real    0m0.194s
> 	user    0m0.192s
> 	sys     0m0.000s
> 
> 	[torvalds@woody ~]$ gcc -Wall -O2 t.c
> 	[torvalds@woody ~]$ time ./a.out
> 	600000000
> 
> 	real    0m0.167s
> 	user    0m0.168s
> 	sys     0m0.000s
> 
> ie the cmov is quite a bit slower. Maybe I did something wrong. But note
> how cmov not only is slower, it's fundamnetally more limited too (ie the
> branch-over can actually do a lot of things cmov simply cannot do).


Hi,
cmov will stall on eflags in your test program.
I think you will see benefit of cmov if you can manage to put some instructions which does NOT modify eflags between testl and cmov. 

Thanks
Zou Nan hai
