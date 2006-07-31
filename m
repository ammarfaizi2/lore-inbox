Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030492AbWGaWWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030492AbWGaWWf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 18:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbWGaWWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 18:22:35 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:22247
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1030492AbWGaWWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 18:22:35 -0400
Date: Mon, 31 Jul 2006 15:22:19 -0700
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Esben Nielsen <nielsen.esben@googlemail.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, rostedt@goodmis.org, dipankar@in.ibm.com,
       mingo@elte.hu, tytso@us.ibm.com, dvhltc@us.ibm.com,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [RFC, PATCH, -rt] Early prototype RCU priority-boost patch
Message-ID: <20060731222219.GA12960@gnuppy.monkey.org>
References: <20060728001918.GA2634@us.ibm.com> <Pine.LNX.4.64.0607281222580.10047@localhost.localdomain> <20060728155220.GC1289@us.ibm.com> <20060728222716.GA13794@gnuppy.monkey.org> <20060729021829.GN1289@us.ibm.com> <20060729025037.GB15392@gnuppy.monkey.org> <20060731143850.GA1293@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060731143850.GA1293@us.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 07:38:50AM -0700, Paul E. McKenney wrote:
> On Fri, Jul 28, 2006 at 07:50:37PM -0700, Bill Huey wrote:
> > The problem here is that I can't see how it's going to boost the thread
> > if the things doing the RCU sync can't track the list of readers. It
> > might be record in the trask struct, now what ?
> 
> The first boost is performed by the task itself the first time there
> is a preemption attempt (or the first time it blocks on a mutex), so
> no need to track the list of readers in that case.  The trick is that
> there is no benefit to boosting someone who is already running -- we
> only need to boost the first time they are considering blocking.
> 
> If there is a need for a second "boost to the sky" in case of excessively
> delayed grace period (or to provide deterministic synchronize_rcu()
> latency), then we need a list only of those RCU readers who have attempted
> to block at least once thus far in their current RCU read-side critical
> section.  But I was putting this off until I get the simple case right.
> Cowardly of me, I know!  ;-)
 
Ok, I see what you're talking about.

> Finally found Steve Rostedt's PI document (in 2.6.18-rc2), very helpful
> (though I suppose I should reserve judgement until after I get this
> working...)
> 
> > It's a possible solution to a rather difficult problem. What do you think ?
> > too much of a hack ?
> 
> I am not sure -- seems to be a dual approach to boosting the RCU reader's
> priority in the preemption case.  I suspect that a real priority boost
> would still be needed in the case where the RCU reader blocks on a mutex,
> since we need the priority inheritance to happen in that case, right?

This is unfortunately true. It maybe that my suggestion isn't going to
work in this scenario. I'll have to think about this more. I think that
either way you still have to extract information somewhere that there is
you're in a live RCU reader section anyways, either through an RCU read
side counter or some kind of mechanism like that (boosted priority or
ceiling can denote some use of RCU, as in a some kind of count, but this
is getting more complicated and remotely less useful) and still take tha
into account when you do priority inheritance.

I'll have to think about this more, but you are probably completely
correct and it might not be possible to priority boost an RCU read side
without some kind of explicit reader tracking in the task struct.

bill

