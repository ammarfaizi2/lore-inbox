Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWIOPiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWIOPiZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 11:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWIOPiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 11:38:25 -0400
Received: from smtp.polymtl.ca ([132.207.4.11]:44253 "EHLO smtp.polymtl.ca")
	by vger.kernel.org with ESMTP id S1751408AbWIOPiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 11:38:24 -0400
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
From: Michel Dagenais <michel.dagenais@polymtl.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Martin Bligh <mbligh@mbligh.org>, Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, fche@redhat.com
In-Reply-To: <20060914223607.GB25004@elte.hu>
References: <20060914112718.GA7065@elte.hu>
	 <Pine.LNX.4.64.0609141537120.6762@scrub.home>
	 <20060914135548.GA24393@elte.hu>
	 <Pine.LNX.4.64.0609141623570.6761@scrub.home>
	 <20060914171320.GB1105@elte.hu> <4509BAD4.8010206@mbligh.org>
	 <20060914203430.GB9252@elte.hu> <4509C1D0.6080208@mbligh.org>
	 <20060914213113.GA16989@elte.hu> <4509D6E6.5030409@mbligh.org>
	 <20060914223607.GB25004@elte.hu>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 11:37:41 -0400
Message-Id: <1158334661.1803.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Poly-FromMTA: (saorge.dgi.polymtl.ca [132.207.169.35]) at Fri, 15 Sep 2006 15:37:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> only 5 bytes of NOP are needed by default, so that a kprobe can insert a 
> call/callq instruction. The easiest way in practice is to insert a 
> _single_, unconditional function call that is patched out to NOPs upon 
> its first occurance (doing this is not a performance issue at all). That 
> way the only cost is the NOP and the function parameter preparation 
> side-effects. (which might or might not be significant - with register 
> calling conventions and most parameters being readily available it 
> should be small.)

Interestingly, while this whole thread is full of diverging views, there
is nevertheless considerable common ground.

- Getting a trace output is very useful, whether it is generated from
dynamic or static tracepoints. You need some infrastructure (e.g.
relayfs + a few things) to get the data out efficiently.

- Some sort of static markers make sense in key locations. Whether they
are there "primarily" for dynamic or static tracepoints is mostly
irrelevant. Interesting suggestions were made for a syntax clearly
identifying their "probe point" status.

>From there we can get onto a constructive debate about the technical
details of each of these components.

> note that such a limited, minimally invasive 'data extraction point' 
> infrastructure is not actually what the LTT patches are doing. It's not 
> even close, and i think you'll be surprised. Let me quote from the 
> latest LTT patch (patch-2.6.17-lttng-0.5.108, which is the same version 
> submitted to lkml - although no specific tracepoints were submitted):

This is a case where it started with inline code but as you take into
account SMP and eventuelly multiple traces (e.g. the sysadmin is tracing
the system and a user is generating a trace for his processes) it
becomes larger and inlining may not be such a good idea any more, to say
the least. However, this is relatively easy to change.

It is also worth mentioning that code patching NOPs to minimize the cost
of inactive tracepoints was envisioned quite some time ago. Again you
might call these "static low overhead placeholders for optimized dynamic
tracepoints" or "optimized low overhead static tracepoints"... You need
however to be careful when code patching instructions on SMP as it may
not be trivial to atomically replace 5 NOPs by a call.

