Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131690AbRCURNZ>; Wed, 21 Mar 2001 12:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131692AbRCURNQ>; Wed, 21 Mar 2001 12:13:16 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:2182 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S131690AbRCURNC>; Wed, 21 Mar 2001 12:13:02 -0500
Message-ID: <3AB8DFBD.6107091D@mvista.com>
Date: Wed, 21 Mar 2001 09:07:09 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Keith Owens <kaos@ocs.com.au>, nigel@nrg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <Pine.LNX.4.05.10103201920410.26853-100000@cosmic.nrg.org>
		<22991.985166394@ocs3.ocs-net>
		<15032.30533.638717.696704@pizda.ninka.net>
		<3AB88929.D1B324F2@mvista.com> <15032.37094.204955.41554@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> george anzinger writes:
>  > By the by, if a preemption lock is all that is needed the patch defines
>  > it and it is rather fast (an inc going in and a dec & test comming
>  > out).  A lot faster than a spin lock with its "LOCK" access.  A preempt
>  > lock does not need to be "LOCK"ed because the only contender is the same
>  > cpu.
> 
> So we would have to invoke this thing around every set of
> smp_processor_id() references?

Well, most of them are already protected.  In most preemptable kernels
there are several protection mechanisms which are used singly or in some
combination.  These are:

a.) interrupt disable
b.) preemption disable
c.) spin_lock

Nigel will tell you that systems he worked on used a & c only.  This
requires that all places where you want to disable preemption be short
enough that you don't take a hit on the interrupt disable (i.e. don't
turn them off for too long).  There are pros and cons to not using
preemption disable, however, even if the off time is very short:

Pro:  The preemption disable is much lower overhead.  We are talking
about something like ++,--, if() schedule verses cli, sti.  More
instructions in the preemption disable case but if done carefully you
have a ++,-- , test, and a correctly predicted non branch (probably
requires asm code to get the non branch, but it can be done.  This is
MUCH faster that the cli, sti because these are VERY heavy
instructions.  (Note that the ++ & -- need to be atomic but NOT locked
as the contention is with the current cpu, not others.)

Con:  The idea of preemption is to get to the contending task as fast as
possible not to to necessarily do it efficiently.  By doing the cli, sti
thing, once the interruption IS taken the system is free to do the
context switch after it has basically trashed the cache with the
interrupt itself.  In the preemption disable method, while it is faster
for the normal, non preempting cases, if a preemption becomes pending,
it can not be taken, so the system must return from the interrupt and
continue thus adding an interrupt return and a bunch of cache faulting
to the preemption delay.  (It is true that the interrupt return is in
the "way" but one could counter argue that the cache disruption is small
because we are, after all, talking about a SHORT protected region which
can not use much cache in the first place.)

Other arguments can be made for the preemption disable.  For example, on
most systems, there are cases where an explicit schedule call wants to
be made with out the possibility of preemption.  Linux can only do this
by turning off interrupts, but this only protects the call and not the
return while preemption can be disabled for the round trip.  (Of course,
the system could save the interrupt system state as part of the task
state if the return leg really needed to be protected.  The up side here
is that the synchronization methods used in linux do not seem to ever
require this sort of protection.  You may note that the preemption path
in the patch does disable preemption while it calls schedule, but this
is to protect against preempting the preemption which quickly leads to
stack overflow...

As to the original question, references to smp_processor_id are for at
least two reasons.  If the reason for the reference is to dodge a
spin_lock, then they need to be protected with either a.) or b.).  I
don't think you will find this very often, but it is probably done in a
few places.  Note, however, that testing found the unprotected cr2 in
the do_page_fault code and has not found any of these (i.e. nothing in
the patch suggests that these even exist).  I think we can safely say
that these things will not be found in the kernel directory.  The driver
directory and one or more of the file system directories are another
matter.  The list handling code that Andrew points out is also a place
where an implied assumption of not being preemptable was made.  Again a
dodge to avoid a spin lock and the same arguments apply.

On the other hand, other references to smp_processor_id are usually made
for dispatching reasons.  I think you will find that these are already
protected by a.) or c.) just because they must be even if there is no
preemption.

George
