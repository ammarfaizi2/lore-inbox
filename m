Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751650AbWIPCD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbWIPCD3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 22:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbWIPCD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 22:03:29 -0400
Received: from opersys.com ([64.40.108.71]:27918 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751509AbWIPCD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 22:03:28 -0400
Message-ID: <450B6044.8020504@opersys.com>
Date: Fri, 15 Sep 2006 22:24:04 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Jose R. Santos" <jrs@us.ibm.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450B164B.7090404@us.ibm.com> <20060915220345.GC12789@elte.hu> <450B29FB.7000301@opersys.com> <20060915224338.GA22126@elte.hu> <450B382C.9070202@opersys.com> <20060915235224.GA30473@elte.hu>
In-Reply-To: <20060915235224.GA30473@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> ok, then i'd like to dispute your point. Contrary to your statement 
> there is a very fundamental difference between "static tracing" (static 
> call, which relies on compile-time insertion of trace points) and 
> "dynamic tracing" (which can insert trace points almost anywhere) - 
> _even if both use in-source markers_.

Good, a nice little down-to-earth debate for a change ;)

> The fundamental difference is this: dynamic tracing has full access to 
> the full environment of the code that it taps into _at the time of 
> tracepoint activation_, while static tracing has to get all its context 
> during compilation.

I disagree.

> To make my point easier to understand, consider the following example: 
> we want to tap into the middle of a global_function():
> 
>  int global_function(int arg1, int arg2, int arg3)
>  {
>          ... [lots of code] ...
> 
>          x = func2();
> 
>          ... [lots of code] ...
>  }
> 
> We want to trace the function right after 'x' has been assigned, and we 
> want to trace an event_A, with parameters: arg1, arg2, arg3 and x. This 
> is a pretty common scenario. Ok so far?

Ok so far.

> here is how the markup looks like under static tracing:
> 
>  int global_function(int arg1, int arg2, int arg3)
>  {
>          ... [lots of code] ...
> 
>          x = func2();
>          D(event_A, arg1, arg2, arg3, x);
> 
>          ... [lots of code] ...
>  }
> 
> that's what you'd expect, right? This is pretty common too, up to this 
> point.

No, that's not what I'd necessarily expect, though it could be and
definitely does match current standard practice. There's no reason,
though, D(foo) isn't calling a statically-linked function which has
a pluggable interface (a module-overloadable symbol if you'd like)
which can then do much more than initially fetch arg1-2-3 using,
as you alluded to earlier, built-in disassemblers and the likes.

One nice thing about the above, though, is that you can easily have
type information at build time and can actually create customized
logging info right there. But this is just brain farting, more
substance below.

> now how could the markup look like for a dynamic tracepoint:
> 
>  int global_function(int arg1, int arg2, int arg3)
>  {
>          ... [lots of code] ...
> 
>          x = func2();
>          D(event_A, x);
> 
>          ... [lots of code] ...
>  }
> 
> Note: there's no (arg1, arg2, arg3) passed to the markup! Why? Because 
> SystemTap has full access to the function's arguments and in this 
> particular case it's simply not necessary to reference them explicitly.
> So the markup has less of an overhead because it does not 'touch' arg1,
> arg2, arg3 if the tracepoint is not active [which is the common case we
> optimize for].

Again, this does not have to be the case. D(arg1, ..., N) could actually
be defined to nothing in *ALL* cases in a header. Nothing precludes
having a special parser that only runs if tracing is enabled and then
generates a special header and corresponding C file which then have
what it takes to make these D() markups meaningful. So in this case,
the compiler never gives a damn about arg1-Z (i.e. no touch or
dependency or anything of the likes), yet a compile-time option allows
you to suddenly make D(foo) turn into a system-tap usable probe point
or a direct call to a statically-linked function (which is what I refer
to as "static tracing".)

> Furthermore, the markup is also visually less intrusive.

That's debatable. If you're going to mark something up, you might as
well state right away what's typically interesting about the event.
Sure, you could make a point that arg32 is something you may be
interesting in some cases, but if arg1-3 are the ones most relevant
99% of the time for this function, then you might as well say that
in your trace marker.

> But better than that, the markup could look like this as well:
> 
>  int global_function(int arg1, int arg2, int arg3)
>  {
>          ... [lots of code] ...
> 
>          x = func2();
> 
>          ... [lots of code] ...
>  }
> 
> right, no markup at all, but in a script somewhere we'd have:
> 
>   insert.trace(global_function: "x = func2();", after);

That's two files. If we're talking funky, and the following is
by no means and endorsement I'm making -- just showing you what
could be possible, then here's a better one:

Look ma, no hands:

 int global_function(int arg1, int arg2, int arg3)
 {
         ... [lots of code] ...

         x = func2(); /*T* @here:arg1,arg2,arg3 */

         ... [lots of code] ...
 }

Now you can't say that's visually wrong: we've already got tons
of outdated comments in the code. And you can't say there's
entirely no precedent: kerneldoc. Yet, this can be used by a
build-time tool which automagically generates either information
for later use by probe inserters or, alternatively, substitutes
the default built file (say foo.c) with an equivalent (foo-trace.c)
which has inlined static tracing.

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
