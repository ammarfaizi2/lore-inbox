Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWIQOot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWIQOot (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 10:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWIQOot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 10:44:49 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:63725 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932229AbWIQOos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 10:44:48 -0400
Date: Sun, 17 Sep 2006 16:36:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Mundt <lethal@linux-sh.org>
Cc: Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
Message-ID: <20060917143623.GB15534@elte.hu>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060917112128.GA3170@localhost.usen.ad.jp>
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


* Paul Mundt <lethal@linux-sh.org> wrote:

> What exactly are you trying to prove with this? Yes, people aren't 
> opposed to a lightweight marker facility. Ingo made some suggestions 
> regarding that, and others (Andrew, Martin, etc.) have pointed out 
> that this would also be beneficial for certain use cases. I don't see 
> anyone violently opposed to lightweight markers, I see people 
> violently opposed to the ltt-centric breed of static instrumentation 
> (and yes, I'm one of them), let's not confuse the two.

yes. The way i see this whole issue (and what i've been trying argue for 
a long time) is that with dynamic tracers we have a _continuum_ of 
_tracepoint maintainance models_ that maintainers can choose from, each 
of which model gives the same "end-user experience":

  - model #1: we could have all static markers in the main kernel 
    source. No dynamic markups at all.

  - model #2: we could have the least intrusive markers in the main
    kernel source, while the more intrusive ones would still be in the
    upstream kernel, but in scripts/instrumentation/.

  - model #3: we could have the 'hardest' markups in the source, and the 
    'easy' ones as dynamic markups in scripts/instrumentation/.

  - model #4: we could have each and every tracepoint in 
    scripts/intrumentation/ - none in the main source.

Note that each model has a different maintainance tradeoff. In my 
judgement model #2 is the one with the smallest total maintainance cost, 
but we dont _have to_ make a hard decision about this here and now. Not 
having to do a (potentially wrong) maintainance-model decision is always 
good!

These tracepoint models arent even global, they can and should be 
per-subsystem. A seldom changing subsystem could have all its markers 
right embedded in the main kernel source. A subsystem under active 
development will most likely not have many markers (because they are 
just a hindrance when doing high-frequency updates).

The tracepoint model is not only per-subsystem, it can also change in 
time. If a subsystem goes through heavy changes (due to a rewrite), it 
might remove all of its static markups and move all the tracing 
infrastructure into scripts. Once the rate of changes has 'cooled down', 
the tracepoints can move back into the source again.

Furthermore, since there is no end-user visible impact of these "where 
should the markups be" decisions, the decisions will be made on a pure 
technical basis. Nobody will flame anyone about having a particular 
static marker moved to a script, because it's only an implementational 
(performance and maintainance micro-overhead) issue, not a functionality 
issue. In fact, with dynamic tracers, an end-user visible breakage can 
even be fixed _after the main kernel has been released, compiled and 
booted on the end-user's system_. Systemtap scripts can be updated on 
live systems. So there is very, very little maintainance pressure caused 
by dynamic tracing.

On the other hand, if we accept static tracers into the mainline kernel, 
we have to decide in favor of tracepoint-maintainance model #1 
_FOREVER_. It will be a point of no return for a likely long time. 
Moving a static tracepoint or even breaking it will cause end-user pain 
that needs an _upstream kernel fix_. It needs a new stable kernel, etc., 
etc. It is very inflexible, and fundamentally so.

So my argument isnt "dynamic markup vs. static markup", my argument is: 
"we shouldnt force the kernel to carry a 100% set of static markups 
forever". We should allow maintainers to decide the 'mix' of static vs. 
dynamic markups that they prefer in their subsystem.

And i might even be proven wrong in a few years, maybe all tracepoints 
will be static markups in the source. I strongly doubt it, but still 
it's a possibility, it wouldnt be the first time i'm wrong. In that case 
we'd still have the same functionality (sans a few rarer arches that 
done have kprobes, yet). But one thing is sure: if i'm just 20% right, 
we'll be much worse off with all the static tracer dependencies.

> This thread would be much better off talking about how to go about 
> implementing lightweight markers rather than spent on mindless rants.

i agree, as long as it's lightweight markers for _dynamic tracers_, so 
that we keep our options open - as per the arguments above.

	Ingo
