Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWIOBFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWIOBFR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 21:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWIOBFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 21:05:17 -0400
Received: from dvhart.com ([64.146.134.43]:21474 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751397AbWIOBFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 21:05:15 -0400
Message-ID: <4509FC15.6020407@mbligh.org>
Date: Thu, 14 Sep 2006 18:04:21 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
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
References: <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <4509BAD4.8010206@mbligh.org> <20060914203430.GB9252@elte.hu> <4509C1D0.6080208@mbligh.org> <20060914213113.GA16989@elte.hu> <4509D6E6.5030409@mbligh.org> <20060914223607.GB25004@elte.hu> <4509DEC3.70806@mbligh.org> <20060914231956.GB29229@elte.hu>
In-Reply-To: <20060914231956.GB29229@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i.e. we should have macros to prepare local information, with macro 
> arities of 2, 3, 4 and 5:
> 
>     _(name, data1);
>    __(name, data1, data2);
>   ___(name, data1, data2, data3);
>  ____(name, data1, data2, data3, data4);

Personally I think that's way more visually offensive that something
that looks like a function call, but still ;-) We do it as a caps macro

KTRACE(foo, bar)

internally, which I suppose makes it not look like a function call.
But at the end of the day, it's all just a matter of visual taste,
what's actually in there is way more important.

> that and nothing more. But no guarantees that these trace points will 
> always be there and usable for static tracers: for example about 50% of 
> all tracepoints can be eliminated via a function attribute. (which 
> function attribute tells GCC to generate a 5-byte NOP as the first 
> instruction of the function prologue.) That will be invariant to things 
> like function renames, etc.

Yup, sometimes you just want to know when a function is called, and
there's no real need to add that. The hook for system calls should be
pretty generic too. But things like instrumenting the reclaim code need
more work - I ended up incrementing some counters for each type of page
recovery failure in shrink_list() and then just logging one compound
event on the stats structure at the end. That's pretty specific, but
does give you a lot of useful data when the box is dying from mem
pressure.

>> So perhaps it'll all work. Still need a little bit of data maintained 
>> in tree though.
> 
> ok. And i think SystemTap itself should be in tree too, with a couple of 
> examples and helper scripts all around tracing and probing - and of 
> course an LTT-compatible trace output so that all the nice LTT userspace 
> code and visualization can live on.

I have to figure out how to graft the internal Google stuff onto the
same mechanism ... I definitely want to be able to combine the static
points with dynamic ones. And then add schedstats and blktrace into
the same thing so it interleaves properly ... seeing the blktrace type
data interact with memory reclaim debugging was very useful to me, for
instance. All these little fragmented tools are way more difficult to
deal with.

M.

