Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWINWZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWINWZp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 18:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWINWZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 18:25:45 -0400
Received: from dvhart.com ([64.146.134.43]:3554 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751377AbWINWZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 18:25:44 -0400
Message-ID: <4509D6E6.5030409@mbligh.org>
Date: Thu, 14 Sep 2006 15:25:42 -0700
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
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <4509BAD4.8010206@mbligh.org> <20060914203430.GB9252@elte.hu> <4509C1D0.6080208@mbligh.org> <20060914213113.GA16989@elte.hu>
In-Reply-To: <20060914213113.GA16989@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Martin Bligh <mbligh@mbligh.org> wrote:
> 
> 
>>>primarily because i fail to see any property of static tracers that 
>>>are not met by dynamic tracers. So to me dynamic tracers like 
>>>SystemTap are a superset of static tracers.
>>
>>1. They're harder to maintain out of tree.
> 
> as i mentioned before, SystemTap should be in tree. Relayfs was added 
> for the sake of SystemTap for example, i have no problem with moving 
> SystemTap into the tree either.

Right, but I'm not talking about the infrastructure, I'm talking about
the placement of the trace points, and the local variables they need
to access in order to get useful data.

>>2. they're written in some jibberish awk crap
> 
> You can write embedded-C SystemTap scripts too. There's an "EMBEDDED C" 
> section in "man stap".

OK, that helps - thanks. Will try to find some time to go back and look
again.

> 
>>3. They're slower. If you're doing thousands of tracepoints a second,
>>	into a circular 8GB log buffer, that *does* matter. You want
>>	to peturb what you're measuring as little as possible.
> 
> i very much agree that they should become as fast as possible. So to 
> rephrase the question: can we make dynamic tracepoints as fast (or 
> nearly as fast) as static tracepoints? If yes, should we care about 
> static tracers at all?

Depends how many nops you're willing to add, I guess. Anything, even
the static tracepoints really needs at least a branch to be useful,
IMHO. At least for what I've been doing with it, you need to stop
the data flow after a while (when the event you're interested in
happens, I'm using it like a flight data recorder, so we can go back
and do postmortem on what went wrong). I should imagine branch
prediction makes it very cheap on most modern CPUs, but don't have
hard data to hand.

OTOH, if you don't know in advance how big the tracing point is
(ie what it's having to do within there to log), you have a problem.
I believe the usual way kprobes/systemtap does this is to do a jump
out of line, which is significantly slower. If we could get a good
estimate on how large the trace point was *likely* to be, maybe we
could leave enough space in nop's inline? OTOH, if we do that a lot,
we end up increasing code size ....

So I suspect the correct compromise is to have macros that normally
are extremely non-invasive, either just entries in a data table (no
code impact) or that plus enough nops to do a jump (as I understand
it, you sometimes need the nops because it's not always possible to
relocate certain bits of code ... perhaps we can detect when?). But
it *will* be slower at trace time, because we're still jumping.
OTOH, if you want it to be fast, you recompile with the "I actually
need tracing to be superfast" option, and it leaves more space.
Seems to give the best of both worlds, as needed.

>>>So my position is that what we should concentrate on is to make the life 
>>>of dynamic tracers easier (be that a handful of generic, parametric 
>>>hooks that gather debuginfo information and add NOPs for easy patching), 
>>>while realizing that static tracers have no advantage over dynamic 
>>>tracers.
>>
>>I'm confused. You're saying that the dynamic tracers need help by 
>>adding some static data to the kernel, and yet at the same time 
>>rejecting static additions to the kernel on the grounds they have no 
>>value???
> 
> no. I'm saying that dynamic tracers are fundamentally more advanced, and 
> that _iff_ we are to add static info to the kernel we should add it _for 
> the sole sake of speeding up dynamic tracers_. If static tracers can 
> live off the same hooks then fine, but we should architect primarily for 
> the needs of the dynamic tracers.

OK. Not too fusssed about the exact details ... would it be fair to say
that you agree that we may need to add *some* instrumentation / hooks
into the codebase in order to locate where and what to trace? Beyond
that, it seems like little bits of implementation detail to me. What
we ended up with was basically:

	ktrace(major_type, minor_type, data, ...)

The minor and major types were enums, but given descriptive names, they
actually seem to help, rather than hinder, code readability. I'd send
out the code, but it needs a major cleanup first ;-)

> ok. For me 'static tracepoints' are like the sort of stuff that LTT 
> adds: funky function names littering the tree.

I think it can be done in different ways, some cleaner than others.
What's important, to me at least, is that the tags are in tree to make
them maintained along with the code, and we can get at all local
variable data, etc, easily. Obviously, beyond that, it should be
as clean and uninvasive as possible. Maybe others have different views,
not sure.

> i see the point behind 'data extraction point' hooks mentioned by you as 
> a compromise, which incidentally will also speed up dynamic tracepoints 
> to the level of static tracepoints. But they should be very much 
> constructed as data extraction points for the purposes of dynamic 
> tracers. (which the LTT hooks currently are not)

OK. Not sure I care too much what the purpose is, as long as they tag
where and what needs extracting, people can use them for whatever ...
as handbags to dance round, as far as I care ;-)

>>If we want it to be superfast, we could compile with a different 
>>config option to insert some tracing statically in there or something, 
>>but I agree it should not be the default.
> 
> for a dynamic tracer all that is needed is a 5-byte NOP (even on 
> 64-bit), and the availability of all the data. Maybe even a function 
> call that can be patched out after bootup, with NOPs. But the current 
> LTT stuff has lots of inlined crap that just bloats the kernel.

OK. But I don't think that's inherent to tracing hooks ... sounds like
more of an implementation detail? Worst case, it's a config option as
to whether to put a nop or inlined stuff in there, if we decide that
the extra speed of not doing a jump may be important?

> So you dont care about recompiling: that's fine - but others care, so as 
> long as all your needs are met (which we are working on meeting :-) then 
> we'll go for the solution that is better - instead of having some dual 
> debugging infrastructure.

Sounds absolutely correct to me. Even if we had some static points, I
think we'd still want the ability to mix both in *one* infrastructure.

>>>(Just like i would accept the reintroduction of the Big Kernel Lock
>>> too, if someone proved it that it's the right thing to do.)
>>
>>Surely it's still there at the moment? ;-)
> 
> no - at least for me it's the Big Kernel Semaphore ;-)

Ah, semantics ;-) Fair enough. It still needs to die though ...

M.
