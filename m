Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWIOAUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWIOAUP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 20:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWIOAUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 20:20:14 -0400
Received: from alnrmhc12.comcast.net ([204.127.225.92]:58353 "EHLO
	alnrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932170AbWIOAUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 20:20:12 -0400
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
From: Nicholas Miell <nmiell@comcast.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Martin Bligh <mbligh@mbligh.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       fche@redhat.com
In-Reply-To: <20060914231956.GB29229@elte.hu>
References: <20060914135548.GA24393@elte.hu>
	 <Pine.LNX.4.64.0609141623570.6761@scrub.home>
	 <20060914171320.GB1105@elte.hu> <4509BAD4.8010206@mbligh.org>
	 <20060914203430.GB9252@elte.hu> <4509C1D0.6080208@mbligh.org>
	 <20060914213113.GA16989@elte.hu> <4509D6E6.5030409@mbligh.org>
	 <20060914223607.GB25004@elte.hu> <4509DEC3.70806@mbligh.org>
	 <20060914231956.GB29229@elte.hu>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 17:19:48 -0700
Message-Id: <1158279588.2474.21.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 01:19 +0200, Ingo Molnar wrote: 
> but i think (and i think now you'll be surprised) the way to go is to do 
> all this in SystemTap ;-) If we add any static points to the kernel then 
> it should have a pure 'local data preparation for extraction' purpose - 
> nothing more. Static tracing can be built around that too, but at that 
> point it will be unnecessary because SystemTap will be able to do that 
> too, with the same (or better, considering the LTT mess) performance.
> 
> i.e. we should have macros to prepare local information, with macro 
> arities of 2, 3, 4 and 5:
> 
>     _(name, data1);
>    __(name, data1, data2);
>   ___(name, data1, data2, data3);
>  ____(name, data1, data2, data3, data4);
> 
> that and nothing more. But no guarantees that these trace points will 
> always be there and usable for static tracers: for example about 50% of 
> all tracepoints can be eliminated via a function attribute. (which 
> function attribute tells GCC to generate a 5-byte NOP as the first 
> instruction of the function prologue.) That will be invariant to things 
> like function renames, etc.

Another interesting idea would be the addition to gcc of a:

__builtin_trace_point(char *name, ...)

It would output a function call sized NOP at it's call site, and store
in another section the trace point name, location, and (this is the
important part) a series of DWARF expressions to reconstruct the trace
point's argument list from the stack frame and saved registers.

This would completely eliminate the argument passing overhead of a
patched-out function call in the cases where the trace point takes
arguments.

It'd also make your __trace function attribute unnecessary, because gcc
could presumably figure out that the trace point is at the beginning of
the function.

It "only" requires compiler support on every architecture that the
kernel cares about and compiler upgrades for everyone who wants to use
static trace points, which is no mean feat.




(Roman Zippel was trimmed from the CC list because his server is
rejecting mail from me and/or Comcast. If the first attempts actually
make it through and this is yet another duplicate, sorry.)

-- 
Nicholas Miell <nmiell@comcast.net>

