Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWINRvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWINRvs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 13:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWINRvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 13:51:48 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:60889 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750834AbWINRvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 13:51:47 -0400
Date: Thu, 14 Sep 2006 19:43:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060914174306.GA18890@elte.hu>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <450971CB.6030601@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450971CB.6030601@mbligh.org>
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


* Martin J. Bligh <mbligh@mbligh.org> wrote:

> >>Comments and reviews are very welcome.
> >
> > i have one very fundamental question: why should we do this 
> > source-intrusive method of adding tracepoints instead of the 
> > dynamic, unintrusive (and thus zero-overhead) KProbes+SystemTap 
> > method?
> 
> Because:
> 
> 1. Kprobes are more overhead when they *are* being used.

minimally so - at least on i386 and x86_64. In that sense tracing is a 
_slowpath_, and it _will_ slow things down if done excessively. I dont 
care about the tracepoint being slower by a few instructions as long as 
it has _zero effect_ on normal code, be that source code or binary code.

> 2. You can get zero overhead by CONFIG'ing things out.

but that's not how a fair chunk of people want to use tracing. People 
(enterprise customers trying to figure out performance problems, 
engineers trying to debug things on a live, production system) want to 
be able to insert a tracepoint anywhere and anytime - and also they want 
to have zero overhead from tracing if no tracepoints are used on a 
system.

> 3. (most importantly) it's a bitch to maintain tracepoints out
>    of-tree on a rapidly moving kernel

wrong: the original demo tracepoints that came with SystemTap still work 
on the current kernel, because the 'coupling' is loose: based on 
function names.

Static tracepoints on the other hand, if added via an external patch, do 
depend on the target function not moving around and the context of the 
tracepoint not being changed. (and static tracepoints if in the source 
all the time are a constant hindrance to development and code 
readability.)

and of course the big advantage of dynamic probing is its flexibility: 
you can add add-hoc tracepoints to thousands of functions, instead of 
having to maintain hundreds (or thousands) of static tracepoints all the 
time. (and if we wont end up with hundreds/thousands of static 
tracepoints then it wont be usable enough as a generic solution.)

> 4. I believe kprobes still doesn't have full access to local 
> variables.

wrong: with SystemTap you can probe local variables too (via 
jprobes/kretprobes, all in the upstream kernel already).

> Now (3) is possibly solvable by putting the points in as no-ops 
> (either insert a few nops or just a marker entry in the symbol 
> table?), but full dynamic just isn't sustainable. [...]

i'm not sure i follow. Could you explain where SystemTap has this 
difficulty?

	Ingo
