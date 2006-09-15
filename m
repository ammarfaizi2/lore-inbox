Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWIPAA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWIPAA6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 20:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWIPAA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 20:00:57 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:10642 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932234AbWIPAA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 20:00:56 -0400
Date: Sat, 16 Sep 2006 01:52:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: "Jose R. Santos" <jrs@us.ibm.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915235224.GA30473@elte.hu>
References: <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450B164B.7090404@us.ibm.com> <20060915220345.GC12789@elte.hu> <450B29FB.7000301@opersys.com> <20060915224338.GA22126@elte.hu> <450B382C.9070202@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450B382C.9070202@opersys.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karim Yaghmour <karim@opersys.com> wrote:

> > So you dispute that markups for dynamic tracing will be more 
> > flexible and you dispute that they will be less intrusive than 
> > markups for static tracing?
> 
> No, I'm saying that the flexibility of the markup is not tied to the 
> instrumentation "grab" mechanism (direct call or binary editing.) 
> That's the "arbitrary" I'm talking about.

ok, then i'd like to dispute your point. Contrary to your statement 
there is a very fundamental difference between "static tracing" (static 
call, which relies on compile-time insertion of trace points) and 
"dynamic tracing" (which can insert trace points almost anywhere) - 
_even if both use in-source markers_.

The fundamental difference is this: dynamic tracing has full access to 
the full environment of the code that it taps into _at the time of 
tracepoint activation_, while static tracing has to get all its context 
during compilation.

To make my point easier to understand, consider the following example: 
we want to tap into the middle of a global_function():

 int global_function(int arg1, int arg2, int arg3)
 {
         ... [lots of code] ...

         x = func2();

         ... [lots of code] ...
 }

We want to trace the function right after 'x' has been assigned, and we 
want to trace an event_A, with parameters: arg1, arg2, arg3 and x. This 
is a pretty common scenario. Ok so far?

here is how the markup looks like under static tracing:

 int global_function(int arg1, int arg2, int arg3)
 {
         ... [lots of code] ...

         x = func2();
         D(event_A, arg1, arg2, arg3, x);

         ... [lots of code] ...
 }

that's what you'd expect, right? This is pretty common too, up to this 
point.

now how could the markup look like for a dynamic tracepoint:

 int global_function(int arg1, int arg2, int arg3)
 {
         ... [lots of code] ...

         x = func2();
         D(event_A, x);

         ... [lots of code] ...
 }

Note: there's no (arg1, arg2, arg3) passed to the markup! Why? Because 
SystemTap has full access to the function's arguments and in this 
particular case it's simply not necessary to reference them explicitly.
So the markup has less of an overhead because it does not 'touch' arg1,
arg2, arg3 if the tracepoint is not active [which is the common case we
optimize for].

Furthermore, the markup is also visually less intrusive.

But better than that, the markup could look like this as well:

 int global_function(int arg1, int arg2, int arg3)
 {
         ... [lots of code] ...

         x = func2();

         ... [lots of code] ...
 }

right, no markup at all, but in a script somewhere we'd have:

  insert.trace(global_function: "x = func2();", after);

or maybe even in a script, annotated in patch format, so that the 
context of the tapped code is captured too.

so, as a result: the dynamic markup() does the same, but has less impact 
on the compiled code (less parameters touched), and is more flexible in 
terms of attachment to the source code.

Can we do any of this with the static tracepoint? We cannot, 
fundamentally! So if we allowed static tracers to access that tracepoint 
anytime, we could never make things more intelligent there in the 
future!

	Ingo
