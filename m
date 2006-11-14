Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933196AbWKNDfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933196AbWKNDfN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 22:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933197AbWKNDfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 22:35:13 -0500
Received: from twinlark.arctic.org ([207.7.145.18]:29061 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S933196AbWKNDfM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 22:35:12 -0500
Date: Mon, 13 Nov 2006 19:35:11 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: Andi Kleen <ak@suse.de>
cc: Suleiman Souhlal <ssouhlal@freebsd.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>, vojtech@suse.cz,
       Jiri Bohac <jbohac@suse.cz>
Subject: Re: [PATCH 1/2] Make the TSC safe to be used by gettimeofday().
In-Reply-To: <200611140344.00407.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0611131908060.28562@twinlark.arctic.org>
References: <455916A5.2030402@FreeBSD.org> <200611140305.00383.ak@suse.de>
 <45592929.2000606@FreeBSD.org> <200611140344.00407.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006, Andi Kleen wrote:

> > A cow-orker suggested that we use SIDT and encode the CPU number in the 
> > limit of the IDT, which should be even faster than LSL.
> 
> Possible yes. Did you time it?
> 
> But then we would make the IDT variable length in memory? While
> the CPUs probably won't care some Hypervisors seem to be picky
> about these limits. LSL still seems somewhat safer.

i'm one of the coworkers suleiman is referring to... below is the README 
from <http://arctic.org/~dean/vtime64.tar.gz>.  see the tarball if you 
want to peruse the code.

the nomenclature in this benchmark doesn't line up with the patch suleiman
posted, but the concept is similar.

in this code i mock-up an implementation of a "uint64_t vtime64(void)"
vsyscall which return 64-bit ns since the epoch.  i think this is a
much more useful syscall than gettimeofday() because it doesn't require
extra multiply/divide to break the data into two pieces (which most
folks then recombine back into a uint64_t).  the concepts are the same
for a vgettimeofday.

note that fundamentally the same code as vtime64() can be used to
provide clock_gettime(CLOCK_MONOTONIC) (akin to gethrtime() on slowaris).
it just needs a different epoch (one which causes the values to remain
monotonic across adjtime()).

i mock up three new methods of implementing vgetcpu() suggested by Nathan
Laredo -- using sidt/sgdt/sldt, and present a comparison vs. the existing
kernel lsl code.

the s*dt instructions have varying degrees of complexity in their use
in a vgetcpu() implementation.  sldt is clearly the fastest but has
conflicts with code such as wine.  note that the sidt limit is essentially
"infinity" if it's >= 0xfff (64-bit) or 0x7ff (32-bit) ... because there
are only 256 software interrupts.

the s*dt instructions are faster than lsl everywhere simply because lsl is
microcoded, involves protection tests, and extra memory references.

note that i don't present the data, but sidt is faster than rdtscp on
rev F opteron especially if all you want is the cpuid.

first -- an implementation where the userland code handles restarting
the vsyscall.

guide to the table:

ff = family
mm = model
ss = stepping
lm = long mode or not
     (note the 32-bit code was timed on 64-bit boxes in long mode... it might
     be different if the kernel itself was also in 32-bit mode)

vendor name  ffmmss lm  |----------- timings all in cycles ----------|  note

GenuineIntel 060f05 32  sgdt 112.0  sidt 111.1  sldt 107.1  lsl 196.1  core2
GenuineIntel 060f05 64  sgdt 102.1  sidt 104.1  sldt  96.2  lsl 178.1  core2

AuthenticAMD 0f4102 32  sgdt  80.1  sidt  80.1  sldt  58.1  lsl 156.0  revF opteron
AuthenticAMD 0f4102 64  sgdt  67.1  sidt  65.1  sldt  41.0  lsl 136.0  revF opteron

AuthenticAMD 0f2102 32  sgdt  77.0  sidt  77.7  sldt  56.0  lsl 154.3  revE opteron
AuthenticAMD 0f2102 64  sgdt  65.0  sidt  63.1  sldt  40.0  lsl 137.6  revE opteron

GenuineIntel 0f0401 32  sgdt 231.7  sidt 225.9  sldt 218.0  lsl 421.5  nocona
GenuineIntel 0f0401 64  sgdt 212.3  sidt 210.0  sldt 200.7  lsl 449.9  nocona

GenuineIntel 0f0403 32  sgdt 232.1  sidt 244.1  sldt 221.4  lsl 420.1  p4 desktop
GenuineIntel 0f0403 64  sgdt 216.1  sidt 216.8  sldt 204.1  lsl 396.1  p4 desktop

GenuineIntel 0f0209 32  sgdt 240.1  sidt 232.1  sldt 224.4  lsl 384.1  xeon


next an implementation which relies on the kernel restarting the computation when
necessary.  this would be achieved by testing to see when the task to be restarted
is on the vsyscall page and backtracking the task to the vsyscall entry point.

this is challenging when the vsyscall is implemented in C -- because of potential
stack usage.  there are ways to get this to work though, even without resorting to
assembly.  i'm presenting this only as a best case scenario should such an effort
be undertaken.  (i have a crazy idea involving the direction flag which i need to
mock up.)

vendor name  ffmmss lm  |----------- timings all in cycles ----------|  note

GenuineIntel 060f05 32  sgdt  90.0  sidt  91.0  sldt  86.0  lsl 128.0  core2
GenuineIntel 060f05 64  sgdt  76.0  sidt  78.1  sldt  76.5  lsl 113.0  core2

AuthenticAMD 0f4102 32  sgdt  43.0  sidt  43.1  sldt  28.0  lsl  82.0  revF opteron
AuthenticAMD 0f4102 64  sgdt  29.0  sidt  28.6  sldt  16.0  lsl  72.0  revF opteron

AuthenticAMD 0f2102 32  sgdt  44.0  sidt  42.8  sldt  28.0  lsl  82.6  revE opteron
AuthenticAMD 0f2102 64  sgdt  27.0  sidt  25.6  sldt  14.5  lsl  72.0  revE opteron

GenuineIntel 0f0401 32  sgdt 111.9  sidt 120.1  sldt 108.6  lsl 225.0  nocona
GenuineIntel 0f0401 64  sgdt 100.9  sidt 100.0  sldt 100.0  lsl 158.0  nocona

GenuineIntel 0f0403 32  sgdt 129.5  sidt 116.1  sldt 112.0  lsl 228.0  p4 desktop
GenuineIntel 0f0403 64  sgdt 104.9  sidt 102.2  sldt 100.0  lsl 138.0  p4 desktop

GenuineIntel 0f0209 32  sgdt 136.0  sidt 136.1  sldt 132.5  lsl 200.0  xeon

-dean

p.s. i work at google, and google paid for this experiment.
