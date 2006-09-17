Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbWIQCXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWIQCXb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 22:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWIQCXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 22:23:31 -0400
Received: from opersys.com ([64.40.108.71]:9480 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S964917AbWIQCXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 22:23:30 -0400
Message-ID: <450CB675.5020909@opersys.com>
Date: Sat, 16 Sep 2006 22:44:05 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>, fche@redhat.com
Subject: Re: [patch] kprobes: optimize branch placement
References: <450BCAF1.2030205@sgi.com> <20060916172419.GA15427@Krystal> <20060916173552.GA7362@elte.hu> <20060916175606.GA2837@Krystal> <20060916191043.GA22558@elte.hu> <20060916193745.GA29022@elte.hu> <20060916202939.GA4520@elte.hu> <20060916204342.GA5208@elte.hu> <450C7039.20208@opersys.com> <20060916155704.ef425542.akpm@osdl.org> <20060916232446.GB23132@elte.hu>
In-Reply-To: <20060916232446.GB23132@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> yeah. Performance of kprobes was never really a big issue, kprobes were 
> always more than fast enough in my opinion. Would be nice if Mathieu 
> could try to re-run his kprobes test with these patches applied. I still 
> havent given up on the hope of convincing the LTT folks that they 
> shouldnt let their sizable codebase drop on the floor but should attempt 
> to integrate it with kprobes/systemtap. There's nothing wrong with what 
> LTT gives to users, it's just the tracing engine itself (the static hook 
> based component) that i have a conceptual problem with - not with the 
> rest. Most of the know-how of tracers is in the identification of the 
> information that should be extracted, its linkup and delivery to 
> user-space tools.

You keep claiming that the use of kprobes/stap would be an equivalent
substitute for what ltt needs and as a past maintainer of ltt I'm
telling it isn't, *even* if the speed of such things were *better*
than that allowed by direct inlined static calls. Speed of the method
from event to tracer is but part of the issue and I've never personally
considered it even the most difficult one to solve.

The most difficult issue, and this one is *not* technical, is the
requirement for outside maintenance of event location delimiters --
whether it be by patch or by script. *THAT* is an intractable
problem so long as there is no mechanism for static markup of the
code. If *THAT* is resolved, then what hides behind the marked up
code -- to which you've devoted considerable bandwidth in this
thread -- becomes utterly *irrelevant*. Roman could then have his
direct inline calls, you could have your uber-optimized steriod-
probes, and neither would conflict.

Your contention up to this point has been that direct inline calls
inherently require more markup than dynamically-instertable ones.
And, to me, this is a fundamental flaw in your argument. My
argument, and you have yet to respond to my earlier email where
I assert this, is that what is sufficient for tracing a given set
of events by means of binary editing *that-does-not-require-out-
of-tree-maintenance* can be made to be sufficient for the tracing
of events using direct inlined static calls. The *only* difference
being that binary editing allows further extension of the pool of
events of interest by means of outside specification of additional
interest points. But given that both those groups working on
dynamic-inserters and those directly patching the kernel are
interested very much in the same events, and both claim that they
need some sort of inlined instrumentation, then there is no point
in pitting the hooking mechanisms amongst themselves.

Clearly those working on dynamic inserters would gladly immediately
use any static instrumentation allowing fastest event-to-tracer
time, and clearly those basing their work on a patch for events
would benefit from the ability to dynamically extend their event
pool. Again: the word is *orthogonal*.

You, and many others, claim that out-of-tree maintenance of
dynamically-insertable probe points is much simpler than in-tree
maintenance and you mainly base this on *your* experience of
having to port *your* trace points around. Now, there are two
parts to this:

First, the alluded simplicity of out-of-tree probe points is a
fallacy. Those working on such things came out publicly stating
the opposite -- and a historical note here: many of those that
participated in the inception of some of these projects were
themselves convinced at the onset that once they got their thing
figured out they'd never need any sort of mainline markup; clearly
experience has shown otherwise. Both Frank, which is one of the
major contributors to stap, and Jose, which maintains LKET - an
ltt-equivalent that uses stap to get its events, have actually
said the opposite. Here's from an earlier email by Jose:
> I agree with you here, I think is silly to claim dynamic instrumentation 
> as a fix for the "constant maintainace overhead" of static trace point.  
> Working on LKET, one of the biggest burdens that we've had is mantainig 
> the probe points when something in the kernel changes enough to cause a 
> breakage of the dynamic instrumentation.  The solution to this is having 
> the SystemTap tapsets maintained by the subsystems maintainers so that 
> changes in the code can be applied to the dynamic instrumentation as 
> well.  This of course means that the subsystem maintainer would need to 
> maintain two pieces of code instead of one.  There are a lot of 
> advantages to dynamic vs static instrumentation, but I don't think 
> maintainace overhead is one of them.
What more do I need to say?

Second, the fact that *your* experience points to the low
maintainability of static instrumentation does not mean that
this actually readily applies to other possible markup
methods. You've named very specific arguments why *your*
experience leads you to believe in the problematic nature of
static markup, and I've provided you with a proposal that
addresses every single one of the issues you mentioned. Yet,
again, you don't bother giving me feedback on it. So here it
is one more time:

> Here's static markup as it could be implemented:
> 
> The plain function:
>  int global_function(int arg1, int arg2, int arg3)
>  {
>          ... [lots of code] ...
> 
>          x = func2();
> 
>          ... [lots of code] ...
>  }
> 
> The function with static markup:
>  int global_function(int arg1, int arg2, int arg3)
>  {
>          ... [lots of code] ...
> 
>          x = func2(); /*T* @here:arg1,arg2,arg3 */
> 
>          ... [lots of code] ...
>  }
> 
> The semantics are primitive at this stage, and they could definitely
> benefit from lkml input, but essentially we have a build-time parser
> that goes around the code and automagically does one of two things:
> a) create information for binary editors to use
> b) generate an alternative C file (foo-trace.c) with inlined static
>    function calls.
> 
> And there might be other possibilities I haven't thought of.
> 
> This beats every argument I've seen to date on static instrumentation.
> Namely:
> - It isn't visually offensive: it's a comment.
> - It's not a maintenance drag: outdated comments are not alien.
> - It doesn't use weird function names or caps: it's a comment.
> - There is precedent: kerneldoc.
> And it does preserve most of the key things those who've asked for
> static markup are looking for. Namely:
> - Static instrumentation
> - Mainline maintainability
> - Contextualized variables

If you would care to give your approval to the above, then I
think this thread is over.

Thanks,

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
