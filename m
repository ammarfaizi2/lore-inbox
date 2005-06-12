Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVFLVrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVFLVrV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 17:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFLVpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 17:45:53 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:27535 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261270AbVFLVpF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 17:45:05 -0400
Date: Sun, 12 Jun 2005 14:45:19 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Bill Huey <bhuey@lnxw.com>,
       Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050612214519.GB1340@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050610193926.GA19568@nietzsche.lynx.com> <42A9F788.2040107@opersys.com> <20050610223724.GA20853@nietzsche.lynx.com> <20050610225231.GF6564@g5.random> <20050610230836.GD21618@nietzsche.lynx.com> <20050610232955.GH6564@g5.random> <20050611014133.GO1300@us.ibm.com> <20050611155459.GB5796@g5.random> <20050611210417.GC1299@us.ibm.com> <42AB7857.1090907@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AB7857.1090907@opersys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 07:48:39PM -0400, Karim Yaghmour wrote:
> 
> Paul E. McKenney wrote:
> > The big thing that I learned in reviewing the thread and in doing the
> > writeup is that there are a lot of different things that a realtime app
> > might want from a OS and from the hardware.  It seems to me that we
> > probably cannot do a simple linear ranking of the approaches -- some
> > will be better at one aspect, others will be better at another.
> 
> During the earlier thread, I did suggest a third option which I think
> could help integrate both PREEMPT_RT and the interrupt pipeline in
> Adeos and RTAI-fusion _without_ impacting on the rest of the kernel
> code. However, I haven't received any feedback whatsoever in that
> regard. So here it is again. Given how much discussion space is taken
> on "concepts", it may be worth entertaining a third option.

Good point -- I did "fly over" this one on earlier reading, partly because
I was somehow thinking that it was a dual-system-call-table approach so
that realtime processes would see deterministic implementations of system
calls (or get migrated/errored/whatever if there was no deterministic
implementation for that particular system call), while non-realtime
processes would see the standard stuff.

> > <alternate proposal>
> > Much like there is nothing precluding PREEMPT_RT to co-exist with
> > the nanokernel approach (on which RTAI is based), it could be suggested
> > the adding of a linux/hard-rt directory containing the (re?)implementation
> > of services/abstractions required for hard-rt applications. You still
> > get a single tree, but there's then a clear separation at many levels,
> > including maintainership. As such, much of what RTAI-fusion is currently
> > doing could find itself in linux/hard-rt. For example, RTAI-fusion
> > transparently provides a hard-rt deterministic nanosleep(). This and
> > other such replacements for kernel/*.c would live in hard-rt/ with
> > no disturbance to the rest of the tree. In the same way, include/linux
> > could be a symbolic link to either include/linux-hrt or include/linux-srt,
> > with headers in include/linux-hrt referring back to include/linux-srt
> > where appropriate. Again, zero cost for mainstream maintainers. If the
> > hard-rt stuff breaks, only the rt folks get the pain. Note that I'm not
> > suggesting creating duplicates like this for all directories. In fact,
> > most of what's in arch/* and drivers/* would remain unchanged, and
> > where appropriate, hard-rt/* and include/linux-hrt should reuse as much
> > of what already exists as possible.
> > 
> > Sure, the hard-rt part wouldn't have all the bells and whistles of the
> > mainstream part, but that's what we're going to have anyway if
> > PREEMPT_RT is included (as is clearly acknowledged elsewhere in this
> > thread by those backing it), unless there's a general consensus amongst
> > all subsystem maintainers that Linux should become QNX-like ... which,
> > to the best of my reading of this thread, most are not interested in.
> > 
> > The above suggestion doesn't solve the two-app vs. one-app dilemma, but
> > it takes away the "oh, horror, we need to maintain two separate kernel
> > trees for our application development" from those against the nanokernel
> > approach _without_ imposing additional burden on mainstream maintainers.
> > </alternate proposal>

This could potentially address the need for version-synchronization
between RTAI-Fusion and the Linux kernel.  Would you really want two
separate builds, or is there some reasonable way of producing a single
kernel binary that has both?  And if there is some reasonable way of
doing this, is it the right thing to do?

The single-binary approach could potentially reduce the
dual-OS-administration load associated with RTAI-Fusion.  However,
handling all the interactions between the deterministic and
non-deterministic system calls could get hairy.  No big deal for
scheduling primitives, but things could get interesting for I/O and
networking protocols.

> Let me clarify what I say above to make it clear that linux/hard-rt
> and include/linux-hrt/ could/would include a merged PREEMPT_RT, adeos, and
> rtai-fusion. The combo patch put together by Philippe (which includes both
> PREEMPT_RT and adeos) is already a good start in that direction. Like we
> said earlier, both methods are not mutually exclusive.

Agreed, most of the realtime approaches can be used together or combined.

> Note that my purpose by posting this proposal is to invite further
> discussion as to what is the best way to integrate any real-time approach
> to the existing kernel structure. What approach eventually makes it into
> this structure, whether it be PREEMPT_RT, Adeos, fusion, a combination of
> these, or something entirely different, is not something I attempt to
> resolve here. As it currently stands, for PREEMPT_RT at least, the
> intrusiveness of the patch onto the mainstream code is something that
> seems to make a lot of people uneasy.

So, one can use the following types of combination:

o	single source tree, multiple kernels (which is what I now
	think that you are getting at above).

o	straight merge, as between PREEMPT and PREEMPT_RT.

o	single kernel, multiple syscall implementations for
	some syscalls (deterministic vs. non-deterministic).

o	side-by-side combination, as with dual-OS/dual-core and
	pretty much any other approach.

Other combination approaches?

I have a paragraph in the updated version mentioning the possibility
of combinations, and if some of these get "cooked" enough, will add
more verbiage.

> Like I said earlier:
> > ... so here goes, it's just an idea I'm throwing in the lion pit ...
> > it clearly would require much more work and input ... so devour, tear,
> > and crush at will ...

						Thanx, Paul
