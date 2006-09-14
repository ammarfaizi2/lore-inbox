Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWINX2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWINX2I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 19:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWINX2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 19:28:08 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:23497 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932115AbWINX2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 19:28:05 -0400
Date: Fri, 15 Sep 2006 01:19:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Martin Bligh <mbligh@mbligh.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       fche@redhat.com
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060914231956.GB29229@elte.hu>
References: <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <4509BAD4.8010206@mbligh.org> <20060914203430.GB9252@elte.hu> <4509C1D0.6080208@mbligh.org> <20060914213113.GA16989@elte.hu> <4509D6E6.5030409@mbligh.org> <20060914223607.GB25004@elte.hu> <4509DEC3.70806@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4509DEC3.70806@mbligh.org>
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


* Martin Bligh <mbligh@mbligh.org> wrote:

> > note that such a limited, minimally invasive 'data extraction point' 
> > infrastructure is not actually what the LTT patches are doing. It's 
> > not even close, and i think you'll be surprised. Let me quote from 
> > the latest LTT patch (patch-2.6.17-lttng-0.5.108, which is the same 
> > version submitted to lkml - although no specific tracepoints were 
> > submitted):
> 
> OK, I grant you that's pretty scary ;-) However, it's not the only way 
> to do it. Most things we're using write a statically sized 64-bit 
> event into a relayfs buffer, with a timestamp, a minor and major event 
> type, and a byte of data payload.

oh, no need to tell me. I wrote ktrace 10 years ago, iotrace 8 years ago 
and latency-trace 2 years ago. (The latter even does extensive mcount 
based tracing, which is as demanding on the ringbuffer as it gets - on 
my testbox i routinely get 10-20 million trace events per second, where 
each trace entry includes: type, cpu, flags, preempt_count, pid, 
timestamp and 4 words of arbitrary payload, all fit into 32 bytes. It 
has static tracepoints too, in addition to the 20,000-40,000 mcount 
tracepoints a typical kernel has.)

So i think i know the advantages and disadvantages of static tracers, 
their maintainance and performance impact.

but i think (and i think now you'll be surprised) the way to go is to do 
all this in SystemTap ;-) If we add any static points to the kernel then 
it should have a pure 'local data preparation for extraction' purpose - 
nothing more. Static tracing can be built around that too, but at that 
point it will be unnecessary because SystemTap will be able to do that 
too, with the same (or better, considering the LTT mess) performance.

i.e. we should have macros to prepare local information, with macro 
arities of 2, 3, 4 and 5:

    _(name, data1);
   __(name, data1, data2);
  ___(name, data1, data2, data3);
 ____(name, data1, data2, data3, data4);

that and nothing more. But no guarantees that these trace points will 
always be there and usable for static tracers: for example about 50% of 
all tracepoints can be eliminated via a function attribute. (which 
function attribute tells GCC to generate a 5-byte NOP as the first 
instruction of the function prologue.) That will be invariant to things 
like function renames, etc.

> So perhaps it'll all work. Still need a little bit of data maintained 
> in tree though.

ok. And i think SystemTap itself should be in tree too, with a couple of 
examples and helper scripts all around tracing and probing - and of 
course an LTT-compatible trace output so that all the nice LTT userspace 
code and visualization can live on.

	Ingo
