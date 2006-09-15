Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWIORJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWIORJU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 13:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWIORJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 13:09:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21987 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932069AbWIORJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 13:09:16 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: karim@opersys.com, Roman Zippel <zippel@linux-m68k.org>,
       Tim Bird <tim.bird@am.sony.com>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>
	<Pine.LNX.4.64.0609141537120.6762@scrub.home>
	<20060914135548.GA24393@elte.hu>
	<Pine.LNX.4.64.0609141623570.6761@scrub.home>
	<20060914171320.GB1105@elte.hu>
	<Pine.LNX.4.64.0609141935080.6761@scrub.home>
	<20060914181557.GA22469@elte.hu> <4509B03A.3070504@am.sony.com>
	<1158320406.29932.16.camel@localhost.localdomain>
	<Pine.LNX.4.64.0609151339190.6761@scrub.home>
	<1158323938.29932.23.camel@localhost.localdomain>
	<Pine.LNX.4.64.0609151425180.6761@scrub.home>
	<1158327696.29932.29.camel@localhost.localdomain>
	<Pine.LNX.4.64.0609151523050.6761@scrub.home>
	<1158331277.29932.66.camel@localhost.localdomain>
	<450ABA2A.9060406@opersys.com>
	<1158332324.29932.82.camel@localhost.localdomain>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 15 Sep 2006 13:08:29 -0400
In-Reply-To: <1158332324.29932.82.camel@localhost.localdomain>
Message-ID: <y0mmz91f46q.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> [...]
> > 
> >    		prepare_arch_switch(rq, next);
> > +		TRACE_SCHEDCHANGE(prev, next);
> >    		prev = context_switch(rq, prev, next);
> >    		barrier();
> 
> The gdb debug data lets you find each line and also the variable
> assignments (except when highly optimised in some cases). [...]

Unfortunately, variables and even control flow are quite regularly
made non-probe-capable by modern gcc.  Statement boundaries and
variables are not preserved.  There is an arms race within gcc to both
improve code optimization and its own "reverse-engineering" debugging
data generation, and the former is always ahead.

The end result is that there are many spots that we'd like to probe in
systemtap, but can't place exactly or extract all the data we'd like.
Really.

There are also spots that for other reasons cannot tolerate a fully
dynamic kprobes-style probe:

- where 1000-cycle int3-dispatching overheads too high
- in low-level code such as fault handling or locking, that, if probed
  dynamically, could entail infinite regress
- debugging information may not be available

This is the reason why I'm in favour of some lightweight event-marking
facility: a way of catching those points where dynamic probing is not
sufficiently fast or dependable.

> [...]
> All we appear to lack is systemtap ability to parse debug data so it can
> be told "trace on line 9 of sched.c and record rq and next"

Actually:

#! stap
probe kernel.function("*@kernel/sched.c:9") { printf("%p %p", $rq, $next) }

- FChE
