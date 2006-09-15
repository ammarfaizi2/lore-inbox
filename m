Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWIOHAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWIOHAl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 03:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWIOHAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 03:00:41 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:9424 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750918AbWIOHAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 03:00:40 -0400
Message-ID: <450A4F88.2050409@us.ibm.com>
Date: Fri, 15 Sep 2006 00:00:24 -0700
From: Vara Prasad <prasadav@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Bligh <mbligh@mbligh.org>
CC: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       fche@redhat.com, systemtap <systemtap@sourceware.org>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <4509BAD4.8010206@mbligh.org> <20060914203430.GB9252@elte.hu> <4509C1D0.6080208@mbligh.org> <20060914213113.GA16989@elte.hu> <4509D6E6.5030409@mbligh.org> <20060914223607.GB25004@elte.hu> <4509DEC3.70806@mbligh.org>
In-Reply-To: <4509DEC3.70806@mbligh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:

> Ingo Molnar wrote:
>
>> * Martin Bligh <mbligh@mbligh.org> wrote:
>>
>>>> i very much agree that they should become as fast as possible. So 
>>>> to rephrase the question: can we make dynamic tracepoints as fast 
>>>> (or nearly as fast) as static tracepoints? If yes, should we care 
>>>> about static tracers at all?
>>>
>>>
>>> Depends how many nops you're willing to add, I guess. Anything, even 
>>> the static tracepoints really needs at least a branch to be useful, 
>>> IMHO. At least for what I've been doing with it, you need to stop 
>>> the data flow after a while (when the event you're interested in 
>>> happens, I'm using it like a flight data recorder, so we can go back 
>>> and do postmortem on what went wrong). I should imagine branch 
>>> prediction makes it very cheap on most modern CPUs, but don't have 
>>> hard data to hand.
>>
>>
>> only 5 bytes of NOP are needed by default, so that a kprobe can 
>> insert a call/callq instruction. The easiest way in practice is to 
>> insert a _single_, unconditional function call that is patched out to 
>> NOPs upon its first occurance (doing this is not a performance issue 
>> at all). That way the only cost is the NOP and the function parameter 
>> preparation side-effects. (which might or might not be significant - 
>> with register calling conventions and most parameters being readily 
>> available it should be small.)
>>
>> note that such a limited, minimally invasive 'data extraction point' 
>> infrastructure is not actually what the LTT patches are doing. It's 
>> not even close, and i think you'll be surprised. Let me quote from 
>> the latest LTT patch (patch-2.6.17-lttng-0.5.108, which is the same 
>> version submitted to lkml - although no specific tracepoints were 
>> submitted):
>
>
> OK, I grant you that's pretty scary ;-) However, it's not the only way
> to do it. Most things we're using write a statically sized 64-bit event
> into a relayfs buffer, with a timestamp, a minor and major event type,
> and a byte of data payload.
>
>> believe it or not, this is inlined into: kernel/sched.c ...
>>
>> 'enuff said. LTT is so far from being even considerable that it's not 
>> even funny.
>
>
> Particularly if we're doing more complex things like that, I'd agree
> that the overhead of doing the out of line jump is non-existant by
> comparison. Even with the relayfs logging alone, perhaps the jump is
> not that heavy ... hmmm.
>
> If we put the NOPs in (at least as an option on some architectures)
> from a macro, you don't really need the full kprobes implemented to
> to tracing, even ... just overwrite the nops with a jump, so presumably
> would be easier to port. However, not sure how local variable data
> is specified in that case ... perhaps the kprobes guys know better.
> Most of the complexity seemed to be with relocating existing code
> because you didn't have nops.


With kprobes one can place probes anywhere you want but the ones placed 
in the middle of the function are not maintainable because they are tied 
to a location in the code.  Having a NOP leaves a maintainable address 
that we can hook into when needed. 

AFAIK writing a portable code for using local variables is not easy 
without using DWARF information, hence we don't handle that in kprobes. 
Jprobes is a special case where you can have access to function 
arguments at the function entry point. SystemTap can be used to specify 
probes anywhere in the function and local variables can also be used in 
the probe handlers. The problem still is maintainability as probes are 
specified using line numbers.

>
> To me, the main thing is to have hooks for the at least some of the
> basic needs maintained in-kernel - from the dtrace paper Val pointed
> me to, that seems to be exactly what they do too, and it integrates
> with the newly added dynamic ones where necessary. 


Once we have these static markers one can use both dynamic probes and 
static probes intermixed getting best of both worlds as Frank 
demonstrated in OLS.

Here are couple of proposals that were discussed in the systemtap 
mailing list in how to specify static markers, we could use these ideas 
with the rest in deciding on a maker proposal.
http://sources.redhat.com/ml/systemtap/2006-q3/msg00273.html
http://sourceware.org/ml/systemtap/2005-q4/msg00415.html

> Plus I hate the
> whole awk thing, and general complexity of systemtap, but we can
> probably avoid that easily enough - either the embedded C option
> you mentioned, or just a different definiton for the same hook macros
> under a config option.
>
> So perhaps it'll all work. Still need a little bit of data maintained
> in tree though.


For placing probes at the begin and end of function we don't really need 
markers as function boundary works as a marker.
I think we only need markers in few places where an important decision 
is made in the middle of a function.

>
> M.
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


