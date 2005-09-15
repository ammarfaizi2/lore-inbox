Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbVIOJUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbVIOJUE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 05:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbVIOJUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 05:20:04 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:5610 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932330AbVIOJUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 05:20:02 -0400
Date: Thu, 15 Sep 2005 11:20:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: George Anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.13-rt6, ktimer subsystem
Message-ID: <20050915092008.GA17915@elte.hu>
References: <20050913100040.GA13103@elte.hu> <43287C52.7050002@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43287C52.7050002@mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* George Anzinger <george@mvista.com> wrote:

> > the end-effect of ktimers is a much more deterministic HRT engine.  
> > The original merging of HR timers into the stock timer wheel was a 
> > Bad Idea (tm). We intend to push the ktimer subsystem upstream as 
> > well.
> 
> Well, having spent a bit of time looking at the code it appears that a 
> lot of the ideas we looked at and discarded (see 
> high-res-timers-discourse@lists.sourceforge.net) are in this.  Shame 
> it was all done with out reference or comment to that list, anyone on 
> it or even the lkml.

this was done in the timeframe of 2 days, and was posted ASAP - with you 
Cc:-ed for the specific purpose of getting feedback from you.

given the very good performance results of ktimers, and the 
simplification effect on the original HRT code:

   36 files changed, 2016 insertions(+), 3094 deletions(-)

it was a no-brainer to put it into the -rt tree.

> I DO agree that it _looks_ nicer, cleaner and so on. But there are a 
> lot of things we rejected in here and they really do need, at least, a 
> hard look.
> 
> A few of the top issues:
> 
> time in nanoseconds 64-bits, requires a divide to do much of anything 
> with it.  Divides are slow and should be avoided if possible.  This is 
> especially true in the embedded market.

Wrong. Divides are slow _on the micro micro level_. They make zero, nil, 
nada difference in reality. The cleanliness difference between having a 
flat nanosec scale and having some artificial 2x 32-bit structure are 
significant.

_By far_ the biggest problem of the HRT code is cleanliness (or the lack 
of it), and the resulting maintainance overhead, and the resulting gut 
reaction from upstream: "oh, yuck, bleh!". [Similar problems are true 
for the timer code in general - by far the biggest issues are 
organization and cleanliness, not micro-issues.]

Micro-level optimizations like 64-bit vs. 32-bit variables is the very 
very last issue to consider - and this statement comes from me, an 
admitted performance extremist. If the HRT code ever wants to go 
upstream then it _must get much much cleaner_. Thomas has been doing 
great work in this area.

> The rbtree is a high overhead tree. I suspect performance problems 
> here. [...]

Wrong. rbtrees are used for some of the most performance-critical areas 
of the kernel: the VMA tree, the new ext3 reservations code [a 
performance feature], access keys.

> [...] If it is the right answer here, then why not use it for normal 
> timers? [...]

i'd like to remind you that the code is less than a week old.

But, i dont think we want to make the majority of normal timeouts 
tree-based. There are in essence two fundamental time related objects in 
the kernel: timeouts and timers. Timeouts never expire in 99% of the 
cases - so they must be optimized for the 'fast insert+remove' codepath.  
Timers on the other hand expire in 99% of the cases, so they must be 
optimized for the 'fast insert+expire' codepath.

Also, for timers, since they are often used by time-deterministic code, 
it does not hurt to have a fundamentally deterministic design. The 
current upstream timer(timeout) wheel is fundamentally non-deterministic 
with an increasing number of timers, due to the cascading design.

hence the separation of timers and timeouts. I think that this 
distinction might as well stay for the long run.

and we'be been through a number of design variants during the past 
couple of weeks in the -rt tree: we tried the original HRT patch, a 
combo method with partly split HR timers, and now a completely separated 
design. From what i've seen ktimers are the best solution so far.

	Ingo
