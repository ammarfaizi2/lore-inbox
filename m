Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265708AbSKFPi2>; Wed, 6 Nov 2002 10:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265715AbSKFPi2>; Wed, 6 Nov 2002 10:38:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3595 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265708AbSKFPi1>; Wed, 6 Nov 2002 10:38:27 -0500
Date: Wed, 6 Nov 2002 07:45:20 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Voyager subarchitecture for 2.5.46 
In-Reply-To: <200211061503.gA6F3DW02053@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0211060729210.2393-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 6 Nov 2002, J.E.J. Bottomley wrote:
> 
> There are certain architectures (voyager is the only one currently supported, 
> but I suspect the Numa machines will have this too) where the TSC cannot be 
> used for cross CPU timings because the processors are driven by separate 
> clocks and may even have different clock speeds.

I disagree.

We should use the TSC everywhere (if it exists, of course), and the fact
that two CPU's don't run synchronized shouldn't matter.

The solution is to make all the TSC calibration and offsets be per-CPU.  
That should be fairly trivial, since we _already_ do the calibration
per-CPU anyway for bogomips (for no good reason except the whole process
is obviously just a funny thing to do, which is the point of bogomips).

The only even half-way "interesting" case I see is a udelay() getting
preempted, and I suspect most of those already run non-preemptable, so in
the short run we could just force that with preempt_off()/on() inside
udelay().

In the long run we probably do _not_ want to do that nonpreemptable
udelay(), but even that is debatable (anybody who is willing to be
preempted should not have been using udelay() in the first place, but
actually sleeping - and people who use udelay() for things like IO port
accesses etc almost certainly won't mind not being moved across CPU's).

Let's face it, we don't have that many tsc-related data structures. What, 
we have:

 - loops_per_jiffy, which is already a per-CPU thing, used by udelay()
 - fast_gettimeoffset_quotient - which is global right now and shouldn't 
   be.
 - delay_at_last_interrupt. See previous.
 - possibly even all of xtime and all the NTP stuff

It's clearly stupid in the long run to depend on the TSC synchronization.
We should consider different CPU's to be different clock-domains, and just
synchronize them using the primitives we already have (hey, people can use
ntp to synchronize over networks quite well, and that's without the kind
of synchronization primitives that we have within the same box).

Anybody willin gto look into this? I suspect the numa people should be
more motivated than most of us.. You still want fast gettimeofday() on
NUMA too..

		Linus

