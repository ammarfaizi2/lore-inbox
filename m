Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbVATVmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVATVmX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 16:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVATVmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 16:42:22 -0500
Received: from almesberger.net ([63.105.73.238]:10756 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262018AbVATVlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 16:41:47 -0500
Date: Thu, 20 Jan 2005 18:39:51 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Karim Yaghmour <karim@opersys.com>
Cc: tglx@linutronix.de, Roman Zippel <zippel@linux-m68k.org>,
       Tim Bird <tim.bird@am.sony.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: [RFC] Instrumentation (was Re: 2.6.11-rc1-mm1)
Message-ID: <20050120183951.A17570@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ 3rd try. Apologies to Karim, Thomas, and Roman, who apparently also
  received my previous attempts. For some reason, one of my upstream
  DNS servers decided to send me highly bogus MX records. ]

Karim Yaghmour wrote:
> Might I add that this is part of the problem ... No personal
> offence intended, but there's been _A LOT_ of things said about
> LTT that were based on third-hand account and no direct contact
> with the toolset/code.

Sigh, yes, guilty as charged ...

At least today, I have a good excuse: my cable modem died, and I
couldn't possibly have download things to look at :)

> > As far as kprobes go, then you still need to have some form or another
> > of marking the code for key events, unless you keep maintaining a set
> > of kprobes-able points separately, which really makes it unusable for
> > the rest of us, as the users of LTT have discovered over time (having
> > to create a new patch for every new kernel that comes out.)

Yes, I think you will need some set of "pads" in the code, where you
can attach probes. I'm not sure how many, though. An alternative, at
least in some cases, would be to move such things into separate
functions, so that you could put the probe just at function entry.
Then add a comment that this function isn't supposed to be torn
apart without dire need.

> > Generating new interrupts is simply unacceptable for LTT's functionality.

Absolutely. If I remember correctly, this is in the process of being
addressed in kprobes. You basically have the following choices:

 - if the probe target is an instruction long enough, replace it with
   a jump or call (that's what I think the kprobes folks are working
   on. I remember for sure that they were thinking about it.)
 - if the probe target is in a basic block with enough room after the
   target, see above (needs feedback from compiler or assembler)
 - if all else fails, add some NOPs (i.e. the marker approach)

> I have received very little feedback on this suggestion,

Probably because everybody saw that it was good :-)

> As for the location of ltt trace points, then they are very rarely
> at function boundaries. Here's a classic:
> 		prepare_arch_switch(rq, next);
> 		ltt_ev_schedchange(prev, next);
> 		prev = context_switch(rq, prev, next);

Yes, in some cases, you don't have a choice but to add some marker.

> > Removing this data would require more data for each event to
> > be logged, and require parsing through the trace before reading it in
> > order to obtain markers allowing random access.

So you need seeking, even in the presence of fine-grained control
over what gets traced in the first place ? (As opposed to extracting
the interesting data from the full trace, given that the latter
shouldn't contain too much noise.)

> If I understand you correctly, you are talking about the fact that
> the transport layer's management of the buffers is syncrhonized
> with some user-space entity that consumes the buffers produced
> and talks back to relayfs (albeit indirectly) to let it know that
> said buffers are now available?

Or that they have been consumed. My question is just whether this
kind of aggregation is something you need.

> I have nothing against kprobes. People keep refering to it as if
> it magically made all the related problems go away, and it doesn't.

Yes, I know just too well :-) In umlsim, I have pretty much the
same problems, and the solutions aren't always nice. So far, I've
been lucky enough that I could almost always find a suitable
function entry to abuse.

However, since a kprobes-based mechanism is - in the worst case,
i.e. when needing markup - as good as direct calls to LTT, and gives
you a lot more flexibility if things aren't quite as hostile, I
think it makes sense to focus on such a solution.

> Nothing precludes us to move in this direction once something is
> in the kernel, it's all currently hidden away in a .h, and it would
> be the same with this.

Yup, but you could move even more intelligence outside the kernel.
All you really need in the kernel is a place to put the probe,
plus some debugging information to tell you where you find the
data (the latter possibly combined with gently coercing the
compiler to put it at some accessible place).

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
