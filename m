Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWCRIqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWCRIqO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 03:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWCRIqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 03:46:14 -0500
Received: from 213-239-205-134.clients.your-server.de ([213.239.205.134]:47575
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932300AbWCRIqO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 03:46:14 -0500
Subject: Re: [patch 5/8] hrtimer remove state field
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.64.0603172242370.16802@scrub.home>
References: <20060312080316.826824000@localhost.localdomain>
	 <20060312080332.274315000@localhost.localdomain>
	 <Pine.LNX.4.64.0603121302590.16802@scrub.home>
	 <1142169010.19916.397.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121422180.16802@scrub.home>
	 <1142170505.19916.402.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121444530.16802@scrub.home>
	 <1142172917.19916.421.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121523320.16802@scrub.home>
	 <1142175286.19916.459.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121608440.17704@scrub.home>
	 <1142178108.19916.475.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121650230.16802@scrub.home>
	 <1142180796.19916.497.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603152055380.16802@scrub.home>
	 <1142499713.29968.11.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603172242370.16802@scrub.home>
Content-Type: text/plain
Date: Sat, 18 Mar 2006 09:46:22 +0100
Message-Id: <1142671582.17279.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 23:07 +0100, Roman Zippel wrote:
> > The general locking rules would be still the same and I dont see
> > increased flexibility at all.
> 
> Current users already do the serialize the calls into hrtimer themselves 
> (stopping and restarting), which can make the locking even simpler.

Serialization of the users does not help for protecting the timer queues
especially not on SMP.

Can you please give a real example how to simplify this. Nobody has any
objections to simplify locking when possible. But unproven claims in
repeated form do not help. After a while they just get annoying.

> > > If we tightened a bit what a user is allowed to 
> > > do, we could gain flexibility on the other side, e.g. allow drivers to 
> > > create timer sources or how to integrate cpu timer.
> > 
> > -ENOPARSE. Can you please explain what "allow drivers to create timer
> > sources" means and why the above locking is in the way ?
> 
> For example dynamically attaching a timer_base to a clock source (e.g. to 
> create a monotonic timer independent of NTP adjustments). Right now as 
> soon as any timer_base is active it cannot be deconfigured again due to 
> pointers to it from timers, so this would require different locking.

I do not really understand what you want to achieve. 

Timer bases are related to clock sources. You can switch the clock
source of the CLOCK_MONOTONIC timer base at any given time to a
different one which is not NTP adjusted. Where is the problem?

The timer base does not care about the underlying clock source at all.
All it knows of it is the function which reads the current time related
to this clock. When the underlying clock changes the way it generates
current time then the timer base does not care at all. 

This is not a problem of hrtimers. Its a problem of the clock source
abstraction layer like John Stultz GTOD framework.

If you want to have timer bases with dynamic clock sources which can go
away then you have to take care of much more than locking. But I really
do not see a need for this.

	tglx


