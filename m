Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265883AbUFOTGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265883AbUFOTGN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 15:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265880AbUFOTDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 15:03:38 -0400
Received: from cfcafw.SGI.COM ([198.149.23.1]:17537 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S265865AbUFOTCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 15:02:49 -0400
Date: Tue, 15 Jun 2004 14:01:14 -0500
From: Robin Holt <holt@sgi.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Dean Nelson <dcn@sgi.com>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: calling kthread_create() from interrupt thread
Message-ID: <20040615190114.GA6151@lnx-holt.americas.sgi.com>
References: <40CF350B.mailxD2X1NPFBC@aqua.americas.sgi.com> <1087321777.2710.43.camel@laptop.fenrus.com> <20040615180525.GA17145@sgi.com> <Pine.LNX.4.53.0406151412350.2353@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0406151412350.2353@chaos>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 02:15:34PM -0400, Richard B. Johnson wrote:
> On Tue, 15 Jun 2004, Dean Nelson wrote:
> 
> > On Tue, Jun 15, 2004 at 07:49:37PM +0200, Arjan van de Ven wrote:
> > > On Tue, 2004-06-15 at 19:42, Dean Nelson wrote:
> > > > I'm working on a driver that needs to create threads that can sleep/block
> > > > for an indefinite period of time.
> > > >
> > > >     . Can kthread_create() be called from an interrupt handler?
> > >
> > > no
> > >
> > > >
> > > >     . Is the cost of a kthread's creation/demise low enough so that one
> > > >       can, as often as needed, create a kthread that performs a simple
> > > >       function and exits?  Or is the cost too high for this?
> > >
> > > for that we have keventd in 2.4, work queues in 2.6
> >
> > As mentioned above, it is possible for this "simple" function to sleep/block
> > for an indefinite period of time. I was under the impression that one
> > couldn't block a work queue thread for an indefinite period of time. Am
> > I mistaken?
> >
> > Thanks,
> > Dean
> >
> 
> If you make a kernel thread, it can sleep forever if it wants, you
> can wake it up with wake_up_interruptible() from an interrupt after
> you have laid out the work you want it to do. That kernel thread
> has access to all your kernel data space, plus can spin-lock to
> prevent an interrupt from changing things in critical sections,
> etc.
> 
> It's the greatest thing since sliced bread.
> 

The problem Dean is trying to address is as follows:

We receive an interrupt.  The interrupt handler determines that some work
needs to be done.  Part of that work to be done may result in the process
needing to go to sleep waiting for a resource to become available.

Currently, the interrupt handler wakes a thread sleeping on a
wait_event_interruptible().  This wakeup is taking approx 35uSec.  Dean
is looking for a lower latency means of doing the wakeup.

Thanks,
Robin
