Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWINUzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWINUzr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 16:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWINUzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 16:55:47 -0400
Received: from dvhart.com ([64.146.134.43]:62433 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1750958AbWINUzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 16:55:46 -0400
Message-ID: <4509C1D0.6080208@mbligh.org>
Date: Thu, 14 Sep 2006 13:55:44 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       fche@redhat.com
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <4509BAD4.8010206@mbligh.org> <20060914203430.GB9252@elte.hu>
In-Reply-To: <20060914203430.GB9252@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Martin Bligh <mbligh@mbligh.org> wrote:
> 
> 
>>>if there are lots of tracepoints (and the union of _all_ useful 
>>>tracepoints that i ever encountered in my life goes into the thousands) 
>>>then the overhead is not zero at all.
>>>
>>>also, the other disadvantages i listed very much count too. Static 
>>>tracepoints are fundamentally limited because:
>>>
>>> - they can only be added at the source code level
>>>
>>> - modifying them requires a reboot which is not practical in a
>>>   production environment
>>>
>>> - there can only be a limited set of them, while many problems need
>>>   finegrained tracepoints tailored to the problem at hand
>>>
>>> - conditional tracepoints are typically either nonexistent or very
>>>   limited.
>>>
>>>for me these are all _independent_ grounds for rejection, as a generic 
>>>kernel infrastructure.
>>
>>I don't think anyone is saying that static tracepoints do not have 
>>their limitations, or that dynamic tracepointing is useless. But 
>>that's not the point ... why can't we have one infrastructure that 
>>supports both? Preferably in a fairly simple, consistent way.
> 
> 
> primarily because i fail to see any property of static tracers that are 
> not met by dynamic tracers. So to me dynamic tracers like SystemTap are 
> a superset of static tracers.

1. They're harder to maintain out of tree.
2. they're written in some jibberish awk crap
3. They're slower. If you're doing thousands of tracepoints a second,
	into a circular 8GB log buffer, that *does* matter. You want
	to peturb what you're measuring as little as possible.

If you're running across thousands of systems, in live production, in
order to catch a rare race condition, the performance does matter.

> So my position is that what we should concentrate on is to make the life 
> of dynamic tracers easier (be that a handful of generic, parametric 
> hooks that gather debuginfo information and add NOPs for easy patching), 
> while realizing that static tracers have no advantage over dynamic 
> tracers.

I'm confused. You're saying that the dynamic tracers need help by
adding some static data to the kernel, and yet at the same time
rejecting static additions to the kernel on the grounds they have
no value???

Perhaps we're just meaning different things by static tracing. To me,
what is important is that there is a well-defined place in the source
code where the data needed to be logged, and the exact place to log
it at, is defined. If all that macro does to the compilation is add
a couple of nops, and make an entry in a symbol data, or other debug
data, for something to hook into later that's *fine*. The point is
to maintain the location and intelligence about *what* to trace.

Perhaps I'm calling that static, and you're calling it dynamic? Would
explain why we're disagreeing ;-) Seems to be exactly what you're
suggesting above?

If we want it to be superfast, we could compile with a different config 
option to insert some tracing statically in there or something, but I
agree it should not be the default.

> i.e. why add infrastructure for the sake of something that is clearly 
> inferior? I have no problem with adding infrastructure for SystemTap, 
> but i am asking the question: is it worth adding a static tracer?

Yes ;-) Realise that your usage model is not exactly the same as
everyone else's, and I don't give a damn if I have to recompile. I
realise other people do, but ....

> I would of course accept static tracers too if someone proved it that 
> they offer something that dynamic tracers cannot do.

Can you *really* trace *any* variable (stack variables, etc) at *any*
point within *any* function with kprobes? It didn't do that before,
and I find it hard to see how it could, given compiler optimizations,
etc.

> (Just like i would accept the reintroduction of the Big Kernel Lock too, 
> if someone proved it that it's the right thing to do.)

Surely it's still there at the moment? ;-)

M.
