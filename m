Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267195AbUIORgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267195AbUIORgf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUIOReJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:34:09 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:40919 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266878AbUIORc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:32:59 -0400
Date: Wed, 15 Sep 2004 10:30:48 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: george anzinger <george@mvista.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
In-Reply-To: <1095268408.29408.2918.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0409151025090.3219@schroedinger.engr.sgi.com>
References: <1095265942.29408.2847.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0409150940420.1249@schroedinger.engr.sgi.com>
 <1095268408.29408.2918.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004, john stultz wrote:

> On Wed, 2004-09-15 at 09:46, Christoph Lameter wrote:
> > On Wed, 15 Sep 2004, john stultz wrote:
> >
> > > > struct time_source_t {
> > > > 	u8 type;
> > > > 	u8 shift;
> > > > 	u32 multiply;
> > > > 	void *address;
> > > > 	u64 mask;
> > > > 	int (*interrupt_at)(u64 counter_value);
> > > > };
> > >
> > > Could you explain the interrupt_at function further?
> >
> > Generates a timer interrupt when a certain counter value has been reached.
> > This is a common feature of most clock chips that I am aware of.
>
> Well, not all time sources have that feature. Both TSC, and cyclone
> don't. You'd have to do something else for those. This is why my
> proposal has absolutely nothing to do with interrupt generation. It has
> a single hook that needs to be called only every once in a while, which
> can be done however any architecture wants.
>
> Interrupt generation has more to do with soft-timers and scheduling then
> time of day anyway.

Hmm... I think this is a serious issue. The ability to exactly time an
interrupt and therefore specific actions is important. Maybe we can have a
fall back to soft interrupts if interrupt_at == NULL?

If the scheduler could assign dynamic time slices to processes then new
more effective designs of process scheduling become possible. F.e. on an
SMP system if a single process is running and no other contention exists
then the scheduler can simply let the process run without interruption.

On the other hand the system may reduce the time slices assigned to a
process that causes significant load on the system in order to insure the
responsiveness of other applications despite the load.

If one can schedule a tick dynamically then also NTP time correction can
be "scheduled" when it is likely that the clock has sufficiently deviated
from standard time. As soon as the time source has been sufficiently tamed
by scaling it correctly then the periods of checkup on the time source
could be gradually expanded.

Real time features such as posix-timer's also depend on the ability to
deliver a signal at an exact point in time. Soft timers can only give a
very rough approximation in these cases.

So I think this feature is essential.

