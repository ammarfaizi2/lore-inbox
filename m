Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318242AbSGWU3d>; Tue, 23 Jul 2002 16:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318244AbSGWU3d>; Tue, 23 Jul 2002 16:29:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38900 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S318242AbSGWU3c>;
	Tue, 23 Jul 2002 16:29:32 -0400
Message-ID: <3D3DBD4B.4EFD3543@mvista.com>
Date: Tue, 23 Jul 2002 13:32:11 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: odd memory corruption in 2.5.27?
References: <Pine.LNX.4.44.0207231053190.32636-100000@linux-box.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> 
> On Tue, 23 Jul 2002, Trond Myklebust wrote:
> 
> > Just means that some RPC message reply from the server was crap. We should
> > deal fine with that sort of thing...
> >
> > AFAICS The Oops itself happened deep down in the socket layer in the part
> > which has to do with reassembling fragments into packets. The garbage
> > collector tried to release a fragment that had timed out and Oopsed.
> >
> > Suggests either memory corruption or else that the networking driver is doing
> > something odd ('cos at that point in the socket layer *only* the driver + the
> > fragment handler should have touched the skb).
> 
> Thanks, that helps quite a bit, i'll see if i can pinpoint it and send it
> to the relevant people.
> 
I just spent a month tracking down this issue.  It comes
down to the slab allocater using per cpu data structures and
protecting them with a combination of interrupt disables and
spin_locks.  Preemption is allowed (incorrectly) if
interrupts are off and preempt_count goes to zero on the
spin_unlock.  I will wager that this is an SMP machine. 
After the preemption interrupts will be on (schedule() does
that) AND you could be on a different cpu.  Either of these
is a BAD thing.

The proposed fix is to catch the attempted preemption in
preempt_schedule() and just return if the interrupt system
is off.  (Of course there is more that this to it, but I do
believe that the problem is known.  You could blow this
assertion out of the water by asserting that the machine is
NOT smp.)
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
