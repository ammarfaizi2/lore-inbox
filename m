Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWINOEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWINOEO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWINOEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:04:14 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:59296 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750718AbWINOEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:04:13 -0400
Date: Thu, 14 Sep 2006 15:55:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060914135548.GA24393@elte.hu>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609141537120.6762@scrub.home>
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

> On Thu, 14 Sep 2006, Ingo Molnar wrote:
> 
> > i have one very fundamental question: why should we do this 
> > source-intrusive method of adding tracepoints instead of the dynamic, 
> > unintrusive (and thus zero-overhead) KProbes+SystemTap method?
> 
> Could you define "zero-overhead"?

zero overhead when not used: not a single instruction added to the 
kernel codepath that is to be traced, anywhere. (which will be the case 
on 99% of the systems)

> Actual implementation aside having a core number of tracepoints is far 
> more portable than KProbes.

the key point is that we want _zero_ "static tracepoints". Firstly, 
static tracepoints are fundamentally limited:

 - they can only be added at the source code level

 - modifying them requires a reboot which is not practical in a 
   production environment

 - there can only be a limited set of them, while many problems need 
   finegrained tracepoints tailored to the problem at hand

 - conditional tracepoints are typically either nonexistent or very 
   limited.

But besides the usability problems, the most important problem is that 
static tracepoints add a _constant maintainance overhead_ to the kernel. 
I'm talking from first hand experience: i wrote 'iotrace' (a static 
tracer) in 1996 and have maintained it for many years, and even today 
i'm maintaining a handful of tracepoints in the -rt kernel. I _dont_ 
want static tracepoints in the mainline kernel.

enter KProbes+SystemTap. It needs no changes at the source code level at 
all, so no maintainance overhead to generic kernel code. Tracepoints can 
be added and removed while the system is running. Trace actions and 
filters can be added based on a scripting language, so tracing is as 
dynamic as it gets.

(check out http://lwn.net/Articles/198557/ if you have an lwn 
subscription - it's subscriber-only for a few weeks)

	Ingo
