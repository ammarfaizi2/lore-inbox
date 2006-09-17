Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWIQPJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWIQPJM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 11:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWIQPJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 11:09:12 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:57525 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932284AbWIQPJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 11:09:11 -0400
Date: Sun, 17 Sep 2006 17:00:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>,
       karim@opersys.com, Andrew Morton <akpm@osdl.org>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060917150035.GA20225@elte.hu>
References: <20060915204812.GA6909@elte.hu> <Pine.LNX.4.64.0609152314250.6761@scrub.home> <20060915215112.GB12789@elte.hu> <Pine.LNX.4.64.0609160018110.6761@scrub.home> <20060915231419.GA24731@elte.hu> <Pine.LNX.4.64.0609160139130.6761@scrub.home> <20060916082214.GD6317@elte.hu> <Pine.LNX.4.64.0609161831270.6761@scrub.home> <20060916231407.GA23132@elte.hu> <y0mu036eglz.fsf@ton.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y0mu036eglz.fsf@ton.toronto.redhat.com>
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


* Frank Ch. Eigler <fche@redhat.com> wrote:

> [...]  It would be much better if we were able to sketch out plausible 
> designs for static instrumentation and similar dynamic probes, and 
> carry out gedanken experiments aobut how they would need to adopt to 
> realistic examples of code drift.  It is not the case that all 
> "maintenance" is alike.

see my previous mail - hopefully that explains my position even clearer.

A number of people have expressed doubts about the all-static model (i'm 
amongst them) - and that's all based on actual experience. So there's no 
need for Gedanken-experiments, because we've got real-life experiments
:-) A number of people also have expressed that they think an all-static
markup model is the right one - and that's based on experience as well.

Just looking at the opinions objectively and excluding my opinion i'd 
say that the most likely model will thus be a _hybrid_ one: some 
markups will be static, some will be dynamic.

Whether a tracepoint will be static or dynamic will depend on the 'flux 
of changes' in the tracing code and of the code they trace. If tracing 
code has a high flux, or the traced code has a high flux, then the 
lowest maintainance overhead is to have a dynamic tracepoint. If _both_ 
the tracing code and the traced code has low flux of changes, then the 
lowest maintainance overhead will be a static markup.

Put differently: dynamic markups will turn into static markups if the 
code that they handle "cools down". Static markups will turn into 
dynamic markups if the code where they reside in gets "too hot" or if 
the markups themselves are "too hot".

But one thing is sure: with a static tracer model accepted into the 
kernel we are forced to have a comprehensive, always-maintained, full 
set of static markups in the tree, for a long time. Dynamic tracers will 
still be around, but we wont be able to fully benefit from the more 
flexible tracepoint maintainance models they allow, because we'll always 
have to carry around the static markups, for the sake of static tracers. 
There will likely be periodic friction about how many static markups 
there should be in the source: subsystem maintainers will want them out, 
static-trace-users will want them in. If a crutial static markup is 
removed or damaged then the kernel will regress materially.

	Ingo
