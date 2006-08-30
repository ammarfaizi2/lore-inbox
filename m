Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWH3SNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWH3SNF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 14:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWH3SNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 14:13:05 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:48054 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751200AbWH3SNE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 14:13:04 -0400
Date: Wed, 30 Aug 2006 11:13:47 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: ego@in.ibm.com, mingo@elte.hu, nickpiggin@yahoo.com.au,
       arjan@infradead.org, rusty@rustcorp.com.au, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@intel.linux.com,
       davej@redhat.com, dipankar@in.ibm.com, vatsa@in.ibm.com,
       ashok.raj@intel.com, josht@us.ibm.com
Subject: Re: [RFC][PATCH 4/4] Rename lock_cpu_hotplug/unlock_cpu_hotplug
Message-ID: <20060830181347.GF1296@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <44EDBDDE.7070203@yahoo.com.au> <20060824150026.GA14853@elte.hu> <20060825035328.GA6322@in.ibm.com> <20060827005944.67f51e92.pj@sgi.com> <20060829180511.GA1495@us.ibm.com> <20060829123102.88de61fa.pj@sgi.com> <20060829200304.GF1290@us.ibm.com> <20060829193828.d38395fe.pj@sgi.com> <20060830151405.GD1296@us.ibm.com> <20060830105434.d00ae4dc.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060830105434.d00ae4dc.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 10:54:34AM -0700, Paul Jackson wrote:
> Paul E. McKenney wrote:
> > Well, my next question was going to be whether cpuset readers really
> > need to exclude the writers, or whether there can be a transition
> > period while the mastodon makes the change as long as it avoids stomping
> > the locusts.  ;-)
> 
> The mastodon's (aka mammoths ;) may make a batch of several related
> changes to the cpuset configuration.  What's important is that the
> locusts see either none or all of the changes in a given batch, not
> some intermediate inconsistent state, and that the locusts see the
> change batches in the same order they were applied.
> 
> Off the top of my head, I doubt I care when the locusts see the
> changes.  Some delay is ok, if that's your question.
> 
> But don't try too hard to fit any work you do to cpusets.  For now,
> I don't plan to mess with cpuset locking anytime soon.  And when I
> do next, it might be that all I need to do is to change the quick
> lock held by the locusts from a mutex to an ordinary rwsem, so that
> multiple readers (locusts) can access the cpuset configuration in
> parallel.

Sounds like a job for RCU (if locusts never sleep in critical sections)
or SRCU (if locusts do block).  ;-)  Seriously, this would get you
deterministic read-side acquisition overhead.  And very low overhead
at that -- no memory barriers, cache misses, or atomic instructions
in the common case of no mammoths/mastodons.

That said, I am not familiar enough with cpusets to know if there are
any gotchas in making the change appear atomic.  The usual approach
is to link updates in, so that readers either see the new state or
do not, but don't see any intermediate states.  I would guess that
updates sometimes involve moving resources from one set to another,
and that such moves must be atomic in the "mv" command sense.  There
are some reasonably straightforward ways of making this happen.

							Thanx, Paul
