Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWG1AtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWG1AtR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 20:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWG1AtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 20:49:16 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:32721
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932077AbWG1AtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 20:49:16 -0400
Date: Thu, 27 Jul 2006 17:48:57 -0700
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Esben Nielsen <nielsen.esben@googlemail.com>, linux-kernel@vger.kernel.org,
       compudj@krystal.dyndns.org, rostedt@goodmis.org, tglx@linutronix.de,
       mingo@elte.hu, dipankar@in.ibm.com, rusty@au1.ibm.com,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [RFC, PATCH -rt] NMI-safe mb- and atomic-free RT RCU
Message-ID: <20060728004857.GA5096@gnuppy.monkey.org>
References: <20060726001733.GA1953@us.ibm.com> <Pine.LNX.4.64.0607262202560.15681@localhost.localdomain> <20060727013943.GE4338@us.ibm.com> <Pine.LNX.4.64.0607270946030.10276@localhost.localdomain> <20060727154637.GA1288@us.ibm.com> <20060727195355.GA2887@gnuppy.monkey.org> <20060728000231.GB1288@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060728000231.GB1288@us.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 05:02:31PM -0700, Paul E. McKenney wrote:
> On Thu, Jul 27, 2006 at 12:53:56PM -0700, Bill Huey wrote:
> > On Thu, Jul 27, 2006 at 08:46:37AM -0700, Paul E. McKenney wrote:
> > > A possible elaboration would be to keep a linked list of tasks preempted
> > > in their RCU read-side critical sections so that they can be further
> > > boosted to the highest possible priority (numerical value of zero,
> > > not sure what the proper symbol is) if the grace period takes too many
> > > jiffies to complete.  Another piece is priority boosting when blocking
> > > on a mutex from within an RCU read-side critical section.
> > 
> > I'm not sure how folks feel about putting something like that in the
> > scheduler path since it's such a specialized cases. Some of the scheduler
> > folks might come out against this.
> 
> They might well.  And the resulting discussion might reveal a better
> way.  Or it might well turn out that the simple approach of boosting
> to an intermediate level without the list will suffice.

Another thing. What you mention above is really just having a set of owners
for the read side and not really a preemption list tracking thing with RCU
and special scheduler path. The more RCU does this kind of thing the more
it's just like a traditional read/write lock but with more parallelism since
it's holding on to read side owners on a per CPU basis.

This was close to the idea I had for extending read/write locks to be more
parallel friendly for live CPUs, per CPU owner bins on individual cache lines
(I'll clarify if somebody asks), but the use of read/write locks is seldom
and in non-critical places, so just moving the code fully to RCU would be a
better solution. The biggest problem is to scan or denote to some central
structure (task struct, lock struct) when you were either in or out of the
reader section without costly atomic operations. That's a really huge cost
as you know already (OLS slides).

bill

