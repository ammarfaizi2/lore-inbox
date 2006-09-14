Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWINSPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWINSPS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 14:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWINSPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 14:15:18 -0400
Received: from opersys.com ([64.40.108.71]:46607 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1750876AbWINSPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 14:15:17 -0400
Message-ID: <45099E90.8030508@opersys.com>
Date: Thu, 14 Sep 2006 14:25:20 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Martin J. Bligh" <mbligh@mbligh.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <450971CB.6030601@mbligh.org> <20060914174306.GA18890@elte.hu>
In-Reply-To: <20060914174306.GA18890@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> but that's not how a fair chunk of people want to use tracing. People 
> (enterprise customers trying to figure out performance problems, 
> engineers trying to debug things on a live, production system) want to 
> be able to insert a tracepoint anywhere and anytime - and also they want 
> to have zero overhead from tracing if no tracepoints are used on a 
> system.

This is an implementation issue. You can easily have it so that at
the site of a marker you generate some code in a special "trace"
section of the binary which does the actual tracing and insert
noops at the marker site. Therefore the only penalty until the
tracing is enabled is the execution of additional noops.

[ note: this comes from a suggestion made by Hiramatsu-san at
this year's OLS. ]

> wrong: the original demo tracepoints that came with SystemTap still work 
> on the current kernel, because the 'coupling' is loose: based on 
> function names.
> 
> Static tracepoints on the other hand, if added via an external patch, do 
> depend on the target function not moving around and the context of the 
> tracepoint not being changed. (and static tracepoints if in the source 
> all the time are a constant hindrance to development and code 
> readability.)

Instrumentation of function boundaries is usually not much of an issue.
Instrumentation of key events, though, is different. Here's the classic:
@@ -1709,6 +1712,7 @@ switch_tasks:
   		++*switch_count;

   		prepare_arch_switch(rq, next);
+		TRACE_SCHEDCHANGE(prev, next);
   		prev = context_switch(rq, prev, next);
   		barrier();

This is the kind of thing for which the instrumentation, be it static
or dynamic, requires some kind of intelligent analysis of where to
get the info. Now, answer honestly, wouldn't it be simpler to have
such an event marker instead of having to figure out for every kernel
binary you get where the darned probe needs to be inserted?

Karim
