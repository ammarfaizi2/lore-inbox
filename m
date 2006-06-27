Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030595AbWF0BhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030595AbWF0BhY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 21:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030597AbWF0BhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 21:37:24 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:418 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030595AbWF0BhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 21:37:23 -0400
Date: Mon, 26 Jun 2006 18:37:57 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       stern@rowland.harvard.edu, mingo@elte.hu, tytso@us.ibm.com,
       dvhltc@us.ibm.com
Subject: Re: [PATCH 1/2] srcu: RCU variant permitting read-side blocking
Message-ID: <20060627013757.GK1295@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060626190328.GD2141@us.ibm.com> <20060626190743.GE2141@us.ibm.com> <20060626134447.a75cb385.akpm@osdl.org> <20060627005350.GG1295@us.ibm.com> <20060626181418.70aeffd3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626181418.70aeffd3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 06:14:18PM -0700, Andrew Morton wrote:
> On Mon, 26 Jun 2006 17:53:51 -0700
> "Paul E. McKenney" <paulmck@us.ibm.com> wrote:
> 
> > > > +struct srcu_struct_array {
> > > > +	int c[2];
> > > > +} ____cacheline_internode_aligned_in_smp;
> > > 
> > > ____cacheline_internode_aligned_in_smp isn't implemented..
> > 
> > It was not long ago...  :-/
> 
> I was trying to work out why on earth this compiled.
> 
> It gives you a global variable called
> ____cacheline_internode_aligned_in_smp.  That works nicely until you
> include this header file from two .c files, at which time you get two
> global variables called ____cacheline_internode_aligned_in_smp.  And the
> linker will happily swallow even that unless you're using -fno-common.

Hmmm...

Sounds like percpu_alloc() is strongly recommended.  Made the changes,
compiling, hope to test overnight.

> > > > +		if (sum == 0)
> > > > +			break;
> > > > +		schedule_timeout_interruptible(1);
> > > > +	}
> > > 
> > > Little sleeps like this are a worry.  It's usually an indication that we've
> > > been lazy and haven't put in the wakeups which are needed for a
> > > minimum-latency wait.
> > 
> > I have been even -more- lazy and have absolutely -no- wakeups.  ;-)
> > The alternative would be to have srcu_read_unlock() wake up the
> > task doing the synchronize_srcu(), but getting that right is painful.
> 
> Shouldn't be too hard...
> 
> A wakeup can be relatively expensive, but one can often do
> 
> 	if (something_which_is_inexpensive())
> 		wake_up(...);
> 
> although it takes care.

Exactly.  ;-)  Been there, done that, gotten it right, but have also
run up almost every blind alley that there is.

Besides, prior to this, there is a synchronize_sched().  In many cases,
the readers will have all completed during the synchronize_sched()
latency, so my bet is that the extra complexity will have no benefit in
the common case.  And if someone comes up with with a good reason to do
a blocking network receive or some such in the SRCU read-side critical
sections, I will be happy to add the wakeup machinations.

Fair enough?

(Besides, we will want to save some of the complexity budget for a
hierarchical implementation should Jesse Barnes prove correct about
future 1,000-CPU dies, right?)

> if you want to be _really_ sleazy you can do
> 
> 	if (something_which_is_inexpensive_and_isnt_quite_right())
> 		wake_up(...);
> 
> and, at the other end:
> 
> 	while (something) {
> 		schedule_timeout_interruptible(1);
> 	}
> 
> and rely upon the flakey-wakeup to work most of the time, so it usually
> interrupts the sleep.

Urg...

> Now erase this from your mind.

To erase it from my mind, I would have had to allow it to get that far
in the first place.  ;-)

							Thanx, Paul
