Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272260AbTG3Vup (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 17:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272264AbTG3Vup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 17:50:45 -0400
Received: from w197.z066088144.sjc-ca.dsl.cnc.net ([66.88.144.197]:49384 "EHLO
	kali.zeta-soft.com") by vger.kernel.org with ESMTP id S272260AbTG3Vuj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 17:50:39 -0400
From: "Scott L. Burson" <gyro@zeta-soft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Wed, 30 Jul 2003 14:50:39 -0700 (PDT)
To: linux-kernel@vger.kernel.org
CC: Mathieu.Malaterre@creatis.insa-lyon.fr
CC: hw.support@amd.com
Subject: Spinlock performance on Athlon MP (2.4)
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <16168.12542.850631.294911@kali.zeta-soft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In March of last year I briefly corresponded with this list about a
performance problem that shows up on the dual Athlon MP running a 2.4 kernel 
(apparently any 2.4 kernel, though I happen to be using 2.4.18).  I don't
have a solution, but I do have some more information.

First, and probably the reason you haven't heard more complaints about the
problem, its severity is evidently dependent on the size of main memory.  At
512MB it doesn't seem to be much of a problem (right, Mathieu?).  At 2.5GB,
which is what I have, it can be quite serious.  For instance, if I start two
`find' processes at the roots of different filesystems, the system can spend
(according to `top') 95% - 98% of its time in the kernel.  It even gets
worse than that, but `top' stops updating -- in fact, the system can seem
completely frozen, but it does recover eventually.  Stopping or killing one
of the `find' processes brings it back fairly quickly, though it can take a
while to accomplish that.

The dual Pentium, as you are probably aware, has no trace of the problem.

What I think is going on (after doing some profiling, some lockmeter
measurements, and other stuff I'll describe below) is simply that the
spinlock handoff time is much longer on the Athlon than on the Pentium.  So
any spinlock contention hurts much worse on the Athlon.

The kernel spinlock loop includes the Pentium 4 PAUSE instruction (aka "REP
NOP").  The Intel Pentium instruction set reference manual has this to say
about PAUSE:

   When executing a spin-wait loop, a Pentium 4 or Intel Xeon processor
   suffers a severe performance penalty when exiting the loop because it
   detects a possible memory order violation. The PAUSE instruction provides
   a hint to the processor that the code sequence is a spin-wait loop. The
   processor uses this hint to avoid the memory order violation in most
   situations, which greatly improves processor performance.

I don't know enough about cache coherency protocols to know what a memory
order violation is or what it might cost in nanoseconds, but clearly the
Pentium had a bad enough problem that Intel decided to fix it.  I speculate
that the Athlon has the same problem.

I urge AMD to do the following:

(1) Figure out whether this is in fact the problem.

(2) Figure out whether a different instruction sequence for the spinlock
inner loop would work better.  (The existing sequence, for those at AMD who
may not have the kernel source handy, is simply CMPB 0, [lock address];
PAUSE; JLE [address of CMPB].)

(3) Make sure the Hammer doesn't have the same problem -- or if it does, fix 
it!  I assure you it will show up in the field.

Meanwhile, supposing that (a) this is the problem and (b) there's no
alternative instruction sequence that cures it, the question remains what to
do about it.

One of the first things I found when profiling was that the worst of the
problem seemed to be in the slab allocator.  I made some changes to
`mm/slab.c' in 2.4.18 intended to reduce spinlock contention therein.  I
believe they were successful (though I should do some before-and-after runs
with lockmeter to verify this), and I think they ameliorate the problem
somewhat.  However, it appears that there are other sources of contention
that show up once that one is fixed (the next one appears, according to the
profiler, to be somewhere in `shrink_cache' in `mm/vmscan.c').  (Sorry I
never released my patch to `slab.c'; since it wasn't a complete cure, and
I didn't understand why not, and didn't have any more time to try to figure
it out, I didn't send it out.  But it is stable; I've been using it for over
a year.)

I could continue to try to remove sources of contention in 2.4, but of
course another interesting question is how much it would help simply to
switch to 2.6.  I don't know that the 2.6 beta is quite to the point where
I'm ready to try it; and anyway 2.6 is probably still a few months from
general use.  If it's thought that 2.6 reduces contention generally, it
might be worth a shot; but on the other hand it probably would still be
worthwhile to fix this in 2.4, if I can.  Comments?

-- Scott
