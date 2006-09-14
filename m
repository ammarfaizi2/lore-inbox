Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWINSYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWINSYu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 14:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWINSYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 14:24:50 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:65495 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750904AbWINSYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 14:24:49 -0400
Date: Thu, 14 Sep 2006 20:15:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060914181557.GA22469@elte.hu>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609141935080.6761@scrub.home>
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


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > for me these are all _independent_ grounds for rejection, as a generic 
> > kernel infrastructure.
> 
> Tracepoints of course need to be managed, but that's true for both 
> dynamic and static tracepoints. [...]

that's not true, and this is the important thing that i believe you are 
missing. A dynamic tracepoint is _detached_ from the normal source code 
and thus is zero maintainance overhead. You dont have to maintain it 
during normal development - only if you need it. You dont see the 
dynamic tracepoints in the source code.

a static tracepoint, once it's in the mainline kernel, is a nonzero 
maintainance overhead _until eternity_. It is a constant visual 
hindrance and a constant build-correctness and boot-correctness problem 
if you happen to change the code that is being traced by a static 
tracepoint. Again, I am talking out of actual experience with static 
tracepoints: i frequently break my kernel via static tracepoints and i 
have constant maintainance cost from them. So what i do is that i try to 
minimize the number of static tracepoints to _zero_. I.e. i only add 
them when i need them for a given bug.

static tracepoints are inferior to dynamic tracepoints in almost every 
way.

> [...]  Both have their advantages and disadvantages and just hammering 
> on the possible problems of static ones [...]

how about giving a line by line rebuttal to the very real problems of 
static tracepoints i listed (twice already), instead of calling them 
"possible problems"?

i am giving a line by line rebuttal of all arguments that come up. 
Please be fair and do the same. Here are the arguments again, for a 
third time. Thanks!

> > also, the other disadvantages i listed very much count too. Static 
> > tracepoints are fundamentally limited because:
> > 
> >   - they can only be added at the source code level
> > 
> >   - modifying them requires a reboot which is not practical in a
> >     production environment
> > 
> >   - there can only be a limited set of them, while many problems need
> >     finegrained tracepoints tailored to the problem at hand
> > 
> >   - conditional tracepoints are typically either nonexistent or very
> >     limited.


> > the kprobes infrastructure, despite being fairly young, is widely 
> > available: powerpc, i386, x86_64, ia64 and sparc64. The other 
> > architectures are free to implement them too, there's nothing 
> > hardware-specific about kprobes and the "porting overhead" is in 
> > essence a one-time cost - while for static tracepoints the 
> > maintainance overhead goes on forever and scales linearly with the 
> > number of tracepoints added.
> 
> kprobes are not trivial to implement [...]

nor are smp-alternatives, which was suggested as a solution to reduce 
the overhead of static tracepoints. So what's the point? It's a one-off 
development overhead that has already been done for all the major 
arches. If another arch needs it they can certainly implement it.

it's like arguing against ptrace on the grounds of: "application 
developers can add printf if they want to debug their apps, or they can 
add static tracepoints too, and besides, ptrace is hard to implement".

> I also think you highly exaggerate the maintaince overhead of static 
> tracepoints, once added they hardly need any maintainance, most of the 
> time you can just ignore them. [...]

hundreds (or possibly thousands) of tracepoints? Have you ever tried to 
maintain that? I have and it's a nightmare.

Even assuming a rich set of hundreds of static tracepoints, it doesnt 
even solve the problems at hand: people want to do much more when they 
probe the kernel - and today, with DTrace under Solaris people _know_ 
that much better tracing _can be done_, and they _demand_ that Linux 
adopts an intelligent solution. The clock is ticking for dinosaurs like 
static printks and static tracepoints to debug the kernel...

> [...] The kernel is full debug prints, do you seriously suggest to 
> throw them out because of their "high maintainance"?

oh yes, these days i frequently throw them out when i find them in code 
i modify. (my most recent such zap was rwsemtrace()). Also, obviously 
when most of them were added we didnt have good kernel debugging 
infrastructure (in fact we didnt have any kernel debugging 
infrastructure besides printk), so _something_ had to be used back then. 
But today there's little reason to keep them. Welcome to 2006 :-)

	Ingo
