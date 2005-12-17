Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932607AbVLQQrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbVLQQrK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 11:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbVLQQrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 11:47:10 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:23988 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932607AbVLQQrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 11:47:08 -0500
Date: Sat, 17 Dec 2005 08:47:23 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, dada1@cosmosbay.com, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, Simon.Derr@bull.net, ak@suse.de,
       clameter@sgi.com
Subject: Re: [PATCH 04/04] Cpuset: skip rcu check if task is in root cpuset
Message-ID: <20051217164723.GA28255@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051214084031.21054.13829.sendpatchset@jackhammer.engr.sgi.com> <20051214084049.21054.34108.sendpatchset@jackhammer.engr.sgi.com> <20051216175201.GA24876@us.ibm.com> <20051216120651.cb57ad2e.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051216120651.cb57ad2e.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 12:06:51PM -0800, Paul Jackson wrote:
> Paul wrote:
> > So I am not convinced that this optimization is worthwhile.
> 
> Nice analysis - thanks.

Glad you liked it.  ;-)

> I read from your analysis that, except on alpha, we're down to
> so little that it's going to be difficult on PREEMPT kernels to
> discern a clear difference, and on non-PREEMPT kernels, the
> rcu read lock is a no-op, so definitely not worth trying to
> optimize away.
> 
> On the ia64 sn2_defconfig kernel (which is CONFIG_PREEMPT and
> CONFIG_DEBUG_PREEMPT, and is the one I happen to care most about) I see
> one short branch with this optimization, versus two calls, to the
> add_preempt_count() and sub_preempt_count() routines, if I don't have
> this optimization.  These two *_preempt_count() routines in
> kernel/sched.c generate 172 lines of assembly code, containing
> several branches, due to the BUG checks.

Hmmmm...  Looking at 2.6.14, I see the following:

	#define rcu_read_lock()         preempt_disable()
	#define rcu_read_unlock()       preempt_enable()

Chasing down preempt_disable():

	#define preempt_disable() \
	do { \
		inc_preempt_count(); \
		barrier(); \
	} while (0)

	#define inc_preempt_count() add_preempt_count(1)
	#define add_preempt_count(val) do {preempt_count() += (val);} while (0)

This reduces to a single increment and a compiler directive.

	#define preempt_enable() \
	do { \
		preempt_enable_no_resched(); \
		preempt_check_resched(); \
	} while (0)

	#define preempt_enable_no_resched() \
	do { \
		barrier(); \
		dec_preempt_count(); \
	} while (0)

	#define dec_preempt_count() sub_preempt_count(1)
	#define sub_preempt_count(val) do {preempt_count() -= (val);} while (0)

	#define preempt_check_resched() \
	do { \
		if (unlikely(test_thread_flag(TIF_NEED_RESCHED))) \
			preempt_schedule(); \
	} while (0)

This reduces to a compiler directive, a single decrement, and (in
the common case) a test.  I don't see 172 lines of assembly code here.

Ah!!!  You have CONFIG_DEBUG_PREEMPT!!!

But that is a debugging configuration.  I don't understand the desire
to optimize that configuration.

> So in that case (obviously not one of the cases with a huge installed
> base ;) this optimization seems well worth it.  One short branch is
> cheaper than two subroutine calls to a couple of pages of code.

Looking at the debugging versions of add_preempt_count() and
sub_preempt_count() in sched.c, I can indeed believe that the optimization
could provide some benefit.  But it seems like you could gain this
benefit and more simply by disabling CONFIG_DEBUG_PREEMPT.

> I can easily accept either way on this one - keeping or removing this
> optimization.  And it involves tradeoffs that vary by architecture and
> configuration, but that aren't (so far as I know) worth custom per-arch
> optimized code.
> 
> I'd slightly prefer to leave this optimization in, on the grounds that
> it makes a worthwhile (albeit modest) improvement in the cases, and is
> only trivially worse (an added short branch) in other cases.
> 
> What's your recommendation, Paul?  You have far more experience here than I.

My usual position would be to avoid putting too much effort into optimizing
debug code, but please feel free to educate me on this one!

							Thanx, Paul
