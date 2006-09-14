Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWINXws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWINXws (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 19:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWINXws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 19:52:48 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:56787 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932150AbWINXwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 19:52:47 -0400
Date: Fri, 15 Sep 2006 01:43:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Daniel Walker <dwalker@mvista.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060914234354.GA2754@elte.hu>
References: <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home> <20060914181557.GA22469@elte.hu> <Pine.LNX.4.64.0609142038570.6761@scrub.home> <20060914202452.GA9252@elte.hu> <Pine.LNX.4.64.0609142248360.6761@scrub.home> <1158268113.17467.38.camel@c-67-180-230-165.hsd1.ca.comcast.net> <Pine.LNX.4.64.0609142324181.6761@scrub.home> <20060914221521.GA23371@elte.hu> <Pine.LNX.4.64.0609150113450.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609150113450.6761@scrub.home>
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

> > While with SystemTap the coupling is alot smaller.
> 
> What guarantees we don't have similiar problems with dynamic 
> tracepoints? As soon as any tracing is merged, users will have some 
> kind of expectation [...]

because users rely on the functionality, not on the implementation 
details. As i outlined it before: with dynamic tracers, static 
tracepoints _are not a necessity_. With static tracers, _static 
tracepoints are the only game in town_.

i outlined one such specific "removal of static tracepoint" example 
already: static trace points at the head/prologue of functions (half of 
the existing tracepoints are such). The sock_sendmsg() example i quoted 
before is such a case. Those trace points can be replaced with a simple 
GCC function attribute, which would cause a 5-byte (or whatever 
necessary) NOP to be inserted at the function prologue. The attribute 
would be alot less invasive than an explicit tracepoint (and thus easier 
to maintain):

 int __trace function(char arg1, char arg2)
 {
 }

where kprobes can be used to attach a lightweight tracepoint that does a 
call, not a break (INT3) instruction. With static tracers we couldnt do 
this so we'd have to stick with the static tracepoints forever! It's 
always hard to remove features, so we have to make sure we add the 
feature that we know is the best long-term solution.

	Ingo
