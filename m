Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWIOSUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWIOSUZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 14:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWIOSUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 14:20:24 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:13996 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932141AbWIOSUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 14:20:22 -0400
Date: Fri, 15 Sep 2006 20:12:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, karim@opersys.com,
       Roman Zippel <zippel@linux-m68k.org>, Tim Bird <tim.bird@am.sony.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915181208.GA17581@elte.hu>
References: <Pine.LNX.4.64.0609151339190.6761@scrub.home> <1158323938.29932.23.camel@localhost.localdomain> <Pine.LNX.4.64.0609151425180.6761@scrub.home> <1158327696.29932.29.camel@localhost.localdomain> <Pine.LNX.4.64.0609151523050.6761@scrub.home> <1158331277.29932.66.camel@localhost.localdomain> <450ABA2A.9060406@opersys.com> <1158332324.29932.82.camel@localhost.localdomain> <y0mmz91f46q.fsf@ton.toronto.redhat.com> <1158345108.29932.120.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158345108.29932.120.camel@localhost.localdomain>
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


* Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Gwe, 2006-09-15 am 13:08 -0400, ysgrifennodd Frank Ch. Eigler:
> > Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > - where 1000-cycle int3-dispatching overheads too high
> 
> Why are your despatching overheads 1000 cycles ? (and if its due to 
> int3 why are you using int 3 8))

this is being worked on actively: there's the "djprobes" patchset, which 
includes a simplified disassembler to analyze common target code and can 
thus insert much faster, call-a-trampoline-function based tracepoints 
that are just as fast as (or faster than) compile-time, static 
tracepoints.

there's no fundamental reason why INT3 should be the primary model of 
inserting kprobes. Sometimes we are unlucky and the code which we target 
is too complex - then we take a few hundred cycles of a penalty. If that 
piece of code is a really common destination then we can add a static 
marker in the source which both prepares parameters and inserts a 
sufficiently sized NOP (or a function call) to prepare things for fast 
dynamic tracing - but it should only be an optional performance helper 
that we have the freedom to zap.

(kprobes can be thought of as a special "JIT", and there's no 
fundamental reason why it couldnt do almost arbitrary transformations on 
kernel code.)

and there's alot more that kprobes/systemtap can do: it can be a method 
of extending the kernel along a 'plugin' model - without having to 
impact the kernel source! That way people can experiment with kernel 
extensions on live kernels, without the barrier of recompile/reboot.

	Ingo
