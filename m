Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbWIQLVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWIQLVt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 07:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWIQLVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 07:21:49 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:58247 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S964941AbWIQLVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 07:21:48 -0400
Date: Sun, 17 Sep 2006 20:21:28 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: The emperor is naked: why *comprehensive* static markup belongs in mainline
Message-ID: <20060917112128.GA3170@localhost.usen.ad.jp>
References: <450D182B.9060300@opersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450D182B.9060300@opersys.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2006 at 05:40:59AM -0400, Karim Yaghmour wrote:
> Now, orthodox Linux kernel development philosophy, in as far
> I've experienced it online and face-to-face with various
> developers, has been that *any* form of static instrumentation
> is to be avoided. And the single argument that has constantly
> come back has always been that such instrumentation creates
> unmaintainable bloat.

There are more arguments than this, but for some reason you choose to
ignore them and selectively interpret the maintenance one. The
maintenance thing is one part of it, some of the other issues are:

	- Placing trace points where they will have an impact on
	  performance.

	- You have a select user base that will tolerate rebuilding
	  their kernel and maintaining separate debug kernels to boot
	  when the need for tracing comes up, whereas most users will
	  not want to or be unable to do this.

Dynamic instrumentation solves some of these problems, but not all.
Taking an int3 on the event might not be your idea of performance in the
tracing case, but it's much more appealing to leaving static points
enabled in a running system, or having to switch between kernels
arbitrarily to get any work done.

As Ingo has also pointed out, there's plenty of room for optimization in
the kprobes case, and with djprobes on the way, this will be even more
marginalized. Why you choose to write this off is mind boggling,
particularly since it goes to lowering the cost of dynamic
instrumentation, which seems to be one of your primary concerns.

> The "perfect" solution:
> -----------------------
> 
> And sure enough, eventually, truth came knocking. And truth
> had a name. It was called dtrace. All of a sudden, everybody
> and his little sister insisted Linux should have an equivalent.
> I'll spare the reader all the political stuff in between, but
> I'll readily admit to this: ltt wasn't a dtrace substitute.
> While it did target the right audience, it lacked the ability
> to allow the user to arbitrarily control instrumentation at
> runtime.
> 
So DTrace was the "perfect" solution because it did allow for dynamic
instrumentation, and ltt wasn't a substitute because it lacked it?
That's clearly the most compelling argument for static instrumentation
I've ever seen.

> Now, you can imagine Frank writing this piece ... "must not
> sound too uncompromising" ... "must insist on what kernel
> developers like to see" ... "mention dynamic tracing" ...
> I mean, look at the choice of words: "I'm in favour of
> *some* *lightweigth* event-marking facility", "... where
> *dynamic probing* is not ..." Smart. Keep to accepted
> orthodox principles, don't upset the natives.
> 
What exactly are you trying to prove with this? Yes, people aren't
opposed to a lightweight marker facility. Ingo made some suggestions
regarding that, and others (Andrew, Martin, etc.) have pointed out that
this would also be beneficial for certain use cases. I don't see anyone
violently opposed to lightweight markers, I see people violently opposed
to the ltt-centric breed of static instrumentation (and yes, I'm one of
them), let's not confuse the two.

This thread would be much better off talking about how to go about
implementing lightweight markers rather than spent on mindless rants.

> And what does Jose say? Well I couldn't say it better than him:
> 
> > I agree with you here, I think is silly to claim dynamic instrumentation 
> > as a fix for the "constant maintainace overhead" of static trace point.  
> > Working on LKET, one of the biggest burdens that we've had is mantainig 
> > the probe points when something in the kernel changes enough to cause a 
> > breakage of the dynamic instrumentation.  The solution to this is having 
> > the SystemTap tapsets maintained by the subsystems maintainers so that 
> > changes in the code can be applied to the dynamic instrumentation as 
> > well.  This of course means that the subsystem maintainer would need to 
> > maintain two pieces of code instead of one.  There are a lot of 
> > advantages to dynamic vs static instrumentation, but I don't think 
> > maintainace overhead is one of them.
> 
> Well, well, well. Here's a guy doing *exactly* what I was
> asked to do a couple of years back. And what does he say?
> "I think is silly to claim dynamic instrumentation as a
> fix for the "constant maintainace overhead" of static trace
> point."
> 
That's a pretty liberal interpretation of that paragraph. Comparatively
let's look at this:

> > Working on LKET, one of the biggest burdens that we've had is mantainig 
> > the probe points when something in the kernel changes enough to cause a 
> > breakage of the dynamic instrumentation. 

Strange, that reads a lot like a maintenance burden to me, and the only
argument for alleviating the burden is by punting it off to subsystem
maintainers so they can sync up the probe points along with the code.

Markers may very well be the answer for this, but you can't
realistically sit there claiming that this is not a maintenance issue
when it's clearly been an issue for everyone involved. Shifting the
burden is one thing, and might be the answer if there's a consensus,
claiming that it's not there is ignoring reality.

> And just in case you missed it the first time in his
> paragraph, he repeats it *again* at the end:
> " There are a lot of advantages to dynamic vs static
> instrumentation, but I don't think maintainace overhead is
> one of them."
> 
Easy to say when you aren't maintaining the trace points ;-)

> But not content with Jose and Frank's first-hand experience
> and testimonials about the cost of outside maintenance of
> dynamically-inserted tracepoint, and obviously outright
> dismissing the feedback from such heretics as Roman, Martin,
> Mathieu, Tim, Karim and others, we have a continued barrage of
> criticism from, shall we say, very orthodox kernel developers
> who insist that the collective experience of the previously
> mentioned people is simply misguided and that, as experienced
> kernel developers, *they* know better.
> 
Have you considered that some of the suggestions being offered are aimed
at what's best for the kernel instead of what's best for LTT?

Feedback is one thing, saying "kprobes sucks because it's not available
on my architecture and I don't feel like porting it" is a rather
different beast.

> That concession, however, still doesn't stop those very
> same orthodox developers continuing to insist that
> somehow "dynamic tracing" is superior to "static tracing",
> even though they have actually never had to maintain an
> infrastructure based on either for the purpose of allowing
> mainstream users to trace their kernels for *user* purposes.
> And in all fairness some are pretty open about it.
> 
And once these points are mainlined, who will be maintaining them I
wonder?

> For the argument, as it is at this stage of the long
> intertwined thread of this week, is that "dynamic tracing"
> is superior to "static tracing" because, amongst other
> things, "static tracing" requires more instrumentation
> than "dynamic tracing". But that, as I said within said
> thread, is a fallacy. The statement that "static tracing"
> requires more instrumentation than "dynamic tracing" is
> only true in as far as you ignore that there is a cost
> for out-of-tree maintenance of scripts for use by probe
> mechanisms. And as you've read earlier, those doing this
> stuff tell us there *is* cost to this. Not only do they
> say that, but they go as far as telling us that this
> cost is *no different* than that involved in maintaining
> static trace points. That, in itself, flies in the face
> of all accepted orthodox principles on the topic of
> mainlined static tracing.
> 
Yes, if you want to do tracing, trace points have to be maintained. I
don't think this strikes anyone as being news. It's where it becomes
maintained, and at what cost it has on the rest of the system that is
the issue.

> Nevertheless, I persist and submit a proposal which I feel
> addresses many, if not all, of the previous fears I've heard
> voiced over the years. Yet, while ample opportunity was
> given and repeated requests, hardliners and observers alike
> refuse to even comment on what I propose -- what's changed.
> So, here again, yet another time, a proposal for a static
> markup system:
> 
The only issue with this is that the argument list has to be maintained
in two places. Personally I don't have any objections to something like
this, though. As long as the places where this happens are restricted to
useful points determined by subsystem maintainers, and the rest handled
by dynamic instrumentation. Otherwise you fall back in to "my tracepoint
is better than yours" fight and they start piling up again, even sans
overhead..
