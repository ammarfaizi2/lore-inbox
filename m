Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWINUko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWINUko (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 16:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWINUko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 16:40:44 -0400
Received: from dvhart.com ([64.146.134.43]:59105 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751156AbWINUko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 16:40:44 -0400
Message-ID: <4509BE4A.6000006@mbligh.org>
Date: Thu, 14 Sep 2006 13:40:42 -0700
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
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       fche@redhat.com
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <450971CB.6030601@mbligh.org> <20060914174306.GA18890@elte.hu> <4509B5A4.2070508@mbligh.org> <20060914201448.GA7357@elte.hu>
In-Reply-To: <20060914201448.GA7357@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Martin Bligh <mbligh@mbligh.org> wrote:
> 
> 
>>an external patch is, indeed, pretty useless. Merging a few simple 
>>tracepoints should not be a problem [...]
> 
> 
> the problem is, LTT is not about a 'few' tracepoints: it adds a whopping 
> 350 tracepoints, a fair portion of it is multi-line with tons of 
> arguments.

"static tracepoints" does not equate directly to "all of LTT". I'm not
saying we should accept LTT as-is. I'm saying we should not reject the
concept of static tracepoints.

>  $ diffstat patch-2.6.17-lttng-0.5.108-instrumentation*
>  98 files changed, 1450 insertions(+), 64 deletions(-)
> 
> saying "it's just a few lightweight tracepoints" misses two points: it's 
> not just a few, and it's not lightweight.
> 
> and the set of tracepoints never gets smaller. People who start to rely 
> on a tracepoint will scream bloody murder if it goes away or breaks. 
> Static tracepoints are a maintainance PITA that will rarely get smaller, 
> and will easily grow ...

If people are *using* them, it's no easier to maintain them outside of
tree, than in-tree. it's significantly harder.

>>[...] - see blktrace and schedstats, for instance.
> 
> yes, i do want to remove the 34 schedstats tracepoints too, once a 
> feasible alternative is present. I already have to do two compilations 
> when changing something substantial in the scheduler - once with and 
> once without schedstats.
> 
> same for blktrace: once SystemTap can provide a compatible replacement, 
> it should.

Your argument about schedstats only seems to illustrate the flaws in the
arguments for dynamic tracepointing - you've put your finger on exactly
what the problem is, when the code changes, the tracing HAS to change
too. The best time to do this is when the code itself changes.

It's the same arguement for putting documentation in the C file against
the source itself.

>>It amuses me that we're so opposed to external patches to the tree 
>>(for perfectly understandable reasons), but we somehow think 
>>tracepoints are magically different and should be maintained out of 
>>tree somehow.
> 
> i think you misunderstood what i meant. SystemTap should very much be 
> integrated into the kernel proper, but i dont think the _rules_ (and 
> scripts) should become part of the _source code files themselves_. So 
> yes, there's advantage to kernel integration, but there's disadvantage 
> to littering the kernel source with countless static tracepoints, if 
> dynamic tracepoints can offer the same benefits (or more).

If you're talking about the scriptable awk-like "stuff" that comes with
Systemtap, yes I agree it should not be in the C code, it's foul.
However, I don't think a simple macro hooks are a burden.

> the question is: what is more maintainance, hundreds of static 
> tracepoints (with long parameter lists) all around the (core) kernel, or 
> hundreds of detached dynamic rules that need an update every now and 
> then? [but of which most would still be usable even if some of them 
> "broke"] To me the answer is clear: having hundreds of tracepoints 
> _within_ the source code is higher cost. But please prove me wrong :-)

How can you possibly say that maintaining the same set of data in two
dis-coupled trees is easier than doing it in the same place? You don't
require any *less* information to do it with systemtap than you do with
some form of static tracing.

If you're talking about the effort of maintaining just what's in the
kernel tree, then of course it's a little easier, but that's only half
the equation. And I don't think it's much of a burden, frankly. Yes,
if we have 2 billion tracepoints, it'll be a pain in the arse, but the
taste of the subsystem maintainers is what would regulate this, along
with everything else that we do. They'll accept a few important ones,
and reject the rest. If it's not valuable in general, they won't take
it. I don't see what the big problem is.

What *is* a problem is having a two separate mechanisms for doing
dynamic and static tracing. They should share the same logging 
facilities and readback mechanisms so we can read both types
consistently from userspace, and the data is correctly interspersed.

M.
