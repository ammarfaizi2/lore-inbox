Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267287AbUIOSxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267287AbUIOSxU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 14:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUIOSxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 14:53:19 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:64656 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267287AbUIOSxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 14:53:15 -0400
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: george anzinger <george@mvista.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <Pine.LNX.4.58.0409151025090.3219@schroedinger.engr.sgi.com>
References: <1095265942.29408.2847.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0409150940420.1249@schroedinger.engr.sgi.com>
	 <1095268408.29408.2918.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0409151025090.3219@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1095274131.29408.2990.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 15 Sep 2004 11:48:51 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 10:30, Christoph Lameter wrote:
> On Wed, 15 Sep 2004, john stultz wrote:
> 
> > Well, not all time sources have that feature. Both TSC, and cyclone
> > don't. You'd have to do something else for those. This is why my
> > proposal has absolutely nothing to do with interrupt generation. It has
> > a single hook that needs to be called only every once in a while, which
> > can be done however any architecture wants.
> >
> > Interrupt generation has more to do with soft-timers and scheduling then
> > time of day anyway.
> 
> Hmm... I think this is a serious issue. The ability to exactly time an
> interrupt and therefore specific actions is important. Maybe we can have a
> fall back to soft interrupts if interrupt_at == NULL?

Oh, its an issue, but one the time of day subsystem shouldn't solve. The
code that manages interval (be it timer or whatever) interrupts should
use the time of day subsystem to ensure they are triggering accurately,
and manipulate the intervals as needed. 

> If the scheduler could assign dynamic time slices to processes then new
> more effective designs of process scheduling become possible. F.e. on an
> SMP system if a single process is running and no other contention exists
> then the scheduler can simply let the process run without interruption.
> 
> On the other hand the system may reduce the time slices assigned to a
> process that causes significant load on the system in order to insure the
> responsiveness of other applications despite the load.

Yep, all of this is outside what the time of day subsystem should do.
Interval interrupt scheduling should be done by other code (I suggest
the timer code do it).


> If one can schedule a tick dynamically then also NTP time correction can
> be "scheduled" when it is likely that the clock has sufficiently deviated
> from standard time. As soon as the time source has been sufficiently tamed
> by scaling it correctly then the periods of checkup on the time source
> could be gradually expanded.

NTP adjustments need to be applied smoothly and consistently as time
progresses. Adjustment to the NTP parameters occur at do_adjtimex and at
interval boundaries (ie: the interrupt_hook in my code, or look at
update_wall_time and second_overflow in the existing code). So in my
understanding its not really a schedulable function. 


> Real time features such as posix-timer's also depend on the ability to
> deliver a signal at an exact point in time. Soft timers can only give a
> very rough approximation in these cases.
> 
> So I think this feature is essential.

I think the functionality is essential, but that it doesn't belong in the time of day code.

Basically we have two things we're trying to do: 

1. Keep accurate time 
2. Generate hardware interrupts accurately

While frequently the same hardware can do both, not all hardware is
usable for both functions. Thus I believe we should cleanly split these
two subsystems. My proposal only provided the keep accurate time part,
however one could using that functionality, to then manipulate hardware
interrupts to ensure accuracy in the timer subsystem.

thanks
-john

