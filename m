Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWINUDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWINUDx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 16:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWINUDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 16:03:52 -0400
Received: from dvhart.com ([64.146.134.43]:51681 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1750913AbWINUDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 16:03:52 -0400
Message-ID: <4509B5A4.2070508@mbligh.org>
Date: Thu, 14 Sep 2006 13:03:48 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <450971CB.6030601@mbligh.org> <20060914174306.GA18890@elte.hu>
In-Reply-To: <20060914174306.GA18890@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Martin J. Bligh <mbligh@mbligh.org> wrote:
> 
> 
>>>>Comments and reviews are very welcome.
>>>
>>>i have one very fundamental question: why should we do this 
>>>source-intrusive method of adding tracepoints instead of the 
>>>dynamic, unintrusive (and thus zero-overhead) KProbes+SystemTap 
>>>method?
>>
>>Because:
>>
>>1. Kprobes are more overhead when they *are* being used.
> 
> 
> minimally so - at least on i386 and x86_64. In that sense tracing is a 
> _slowpath_, and it _will_ slow things down if done excessively. I dont 
> care about the tracepoint being slower by a few instructions as long as 
> it has _zero effect_ on normal code, be that source code or binary code.

Would be interesting to see some measurements. But jumping is slower
than a simple branch (or noops to skip over that can be overwritten).

>>2. You can get zero overhead by CONFIG'ing things out.
> 
> but that's not how a fair chunk of people want to use tracing. People 
> (enterprise customers trying to figure out performance problems, 
> engineers trying to debug things on a live, production system) want to 
> be able to insert a tracepoint anywhere and anytime - and also they want 
> to have zero overhead from tracing if no tracepoints are used on a 
> system.

I'm fine with that ... "a fair chunk of people" - but it's not everyone,
by any means. We need both static and dynamic tracepoints, in one
infrastructure.

>>3. (most importantly) it's a bitch to maintain tracepoints out
>>   of-tree on a rapidly moving kernel
> 
> wrong: the original demo tracepoints that came with SystemTap still work 
> on the current kernel, because the 'coupling' is loose: based on 
> function names.

And what do those trace? I bet not half the stuff we want to do.
I've been migrating Google's tracepoints around between different
kernel versions, and it's not a mechanical port. Just stupid things
like renaming of functions inside memory reclaim creates pain, for
starters. (shrink_cache/shrink_list, refill_inactive_zone, etc).

> Static tracepoints on the other hand, if added via an external patch, do 
> depend on the target function not moving around and the context of the 
> tracepoint not being changed. (and static tracepoints if in the source 
> all the time are a constant hindrance to development and code 
> readability.)

an external patch is, indeed, pretty useless. Merging a few simple
tracepoints should not be a problem - see blktrace and schedstats,
for instance.

> and of course the big advantage of dynamic probing is its flexibility: 
> you can add add-hoc tracepoints to thousands of functions, instead of 
> having to maintain hundreds (or thousands) of static tracepoints all the 
> time. (and if we wont end up with hundreds/thousands of static 
> tracepoints then it wont be usable enough as a generic solution.)

I wasn't saying that dynamic tracepoints are useless - I agree it's
valuable to add stuff on the fly. But some things are better done
statically.

>>4. I believe kprobes still doesn't have full access to local 
>>variables. 
> 
> wrong: with SystemTap you can probe local variables too (via 
> jprobes/kretprobes, all in the upstream kernel already).

I'll look again, but last time I looked it didn't do this, and
when I spoke to the kprobes/systemtap people at OLS, IIRC they
said it still couldn't.

>>Now (3) is possibly solvable by putting the points in as no-ops 
>>(either insert a few nops or just a marker entry in the symbol 
>>table?), but full dynamic just isn't sustainable. [...]
> 
> i'm not sure i follow. Could you explain where SystemTap has this 
> difficulty?

If you have an extremely limited set of probes, on a static area
of the kernel, then yes, they may work for a long time. But try
tracing something like the scheduler, which people seem to delight
in rewriting every month or two ...

It amuses me that we're so opposed to external patches to the tree
(for perfectly understandable reasons), but we somehow think tracepoints
are magically different and should be maintained out of tree somehow.
You yourself made the argument that it's a maintainance burden to
keep the trace points *in* the tree ... if that's true, how is it
any easier to keep them outside of the tree?

If we really want to, we can still keep the hooks inside the code,
and have them do absolutely nothing at all - putting markers into
the symbol table is pretty much free. It also reuses the well
structured code-sharing mechanism we already have in place - the
linux kernel tree.

I really don't want to deal with all the systemtap crap - I just
want something that works, and I don't particularly care if I have
to recompile the kernel to get it. I know that doesn't suit everyone,
but there are requirements on both sides, and we should not dismiss
each other's requirements out of hand.

Having one consistent consistent collection mechanism for all these
different types of tracing data seems both logical and very important
to me ...

M.
