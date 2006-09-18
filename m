Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965165AbWIRAKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbWIRAKY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 20:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965166AbWIRAKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 20:10:24 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:21969 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S965165AbWIRAKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 20:10:22 -0400
Subject: Re: tracepoint maintainance models
From: Nicholas Miell <nmiell@comcast.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Mundt <lethal@linux-sh.org>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
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
In-Reply-To: <20060917230623.GD8791@elte.hu>
References: <450D182B.9060300@opersys.com>
	 <20060917112128.GA3170@localhost.usen.ad.jp>
	 <20060917143623.GB15534@elte.hu> <1158524390.2471.49.camel@entropy>
	 <20060917230623.GD8791@elte.hu>
Content-Type: text/plain
Date: Sun, 17 Sep 2006 17:10:13 -0700
Message-Id: <1158538213.2471.73.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-18 at 01:06 +0200, Ingo Molnar wrote:
> * Nicholas Miell <nmiell@comcast.net> wrote:
> 
> > On my system, Solaris has 49 "real" static probes (with actual 
> > documentation[1]). They are as follows:
> 
> yeah, _some_ static markers are OK, as long as they are within a dynamic 
> tracing framework! (and are thus constantly "kept in check" by the easy 
> availability of dynamic probes)
> 
> what is being proposed here is entirely different from dprobes though: 
> Roman suggests that he doesnt want to implement kprobes on his arch, and 
> he wants LTT to remain an _all-static_ tracer. That's the point where i 
> beg to differ: static markers are fine (but they should be kept to a 
> minimum), but generic static /tracers/ need alot more than just a few 
> static markers to be meaningful.

Anyone know what's hard about kprobes on m68k? Roman?

> So if we accepted static tracers into the kernel, we'd automatically 
> commit (for a long period of time) to a much larger body of static 
> markers - and i'm highly uncomfortable about that. (for the many reasons 
> outlined before)
> 
> Even if the LTT folks proposed to "compromise" to 50 tracepoints - users 
> of static tracers would likely _not_ be willing to compromise, so there 
> would be a constant (and I say unnecessary) battle going on for the 
> increase of the number of static markers. Static markers, if done for 
> static tracers, have "viral" (Roman: here i mean "auto-spreading", not 
> "disease") properties in that sense - they want to spread to alot larger 
> area of code than they start out from.
> 
> While if we only have a dynamic tracing framework (which is a mix of 
> static markers and dynamic probes) then pretty much the only user 
> pressure would be: "implement kprobes!". (which is already implemented 
> for 5 major arches and takes only between 500 and 1000 lines of per-arch 
> code for most of them.)
> 
> ( furthermore, from what you've described it seems to me that 
>   kprobes/kretprobes/djprobes+SystemTap is already more capable than 
>   dprobes is - hence the number of static markes needed in Linux might 
>   in fact be lower in the end than in Solaris. )

Most of what makes dtrace better than SystemTap right now is the polish
of the userspace tools, the extra features (pre-userspace tracing,
post-mortem trace buffer extraction, speculative tracing, userspace
tracing, ABI stability notations, etc.), the better runtime library for
scripts, and the fact that they've found everything that can't be traced
without crashing the kernel and marked it untracable.

The D language itself may be quite limited (and hated because of that),
but it is clean and complete, which is something I can't say about
stap's language.

The existence of documentation really helps, too.

The actual probing mechanism itself is a very small part of what makes
dtrace good and SystemTap not there yet.

> > This is the important part: In a dynamic tracing system, the number of 
> > static probes necessary for the tracing system to be useful is 
> > drastically, dramatically, absurdly lower than in a purely static 
> > tracing system. Hell, you don't even need the static probes for it to 
> > be useful, they're just a convenience for events which happen in 
> > multiple places or a high-level name for a low-level implementation 
> > detail.
> 
> yeah, precisely my point.
>

I should note that, despite being unneeded in a dynamic trace system, I
think the addition of static probe points is actually useful, and the
convenience they provide shouldn't be minimized. Obviously you're not
going to want to add static probe points for implementation-details that
are likely to change in the future (without noting that they're
implementation-specific and prone to change, anyway).

> > In order for the static tracing system to be as useful as the dynamic 
> > system, all of those dynamically generated probe points would have to 
> > be manually added to the kernel. The maintenance burden of this number 
> > of probes is stupidly high. In reality, no static system would ever 
> > reach that level of coverage.
> 
> yeah, agreed.
> 
> 	Ingo
-- 
Nicholas Miell <nmiell@comcast.net>

