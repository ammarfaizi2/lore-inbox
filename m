Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751928AbWISMAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbWISMAV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 08:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbWISMAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 08:00:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1195 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751928AbWISMAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 08:00:20 -0400
Date: Tue, 19 Sep 2006 12:59:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060919115945.GA4965@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
	Michel Dagenais <michel.dagenais@polymtl.ca>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060914112718.GA7065@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2006 at 01:27:18PM +0200, Ingo Molnar wrote:
> 
> * Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
> 
> > Following an advice Christoph gave me this summer, submitting a 
> > smaller, easier to review patch should make everybody happier. Here is 
> > a stripped down version of LTTng : I removed everything that would 
> > make the code review reluctant (especially kernel instrumentation and 
> > kernel state dump module). I plan to release this "core" version every 
> > few LTTng releases and post it to LKML.
> > 
> > Comments and reviews are very welcome.
> 
> i have one very fundamental question: why should we do this 
> source-intrusive method of adding tracepoints instead of the dynamic, 
> unintrusive (and thus zero-overhead) KProbes+SystemTap method?

Coming a little late to this thread because I've been travelling the last
three weeks I'll answer here before wading through hundreds of mails.

I'll categorize tracing methods into a few categories:

  a) static and in-inline

     These are tracepoints directly in the kernel source, always compiled
     in (or under a CONFIG option).  We have various ad-hoc tracers of
     this type already in the kernel, e.g. blktrace or xfs's ktrace

  b) dynamic and in-line (markers)
     
     These are in-line but normally don't do anything in the code except
     of maybe adding a nop.  We currently don't support this at all.

  c) dynamic and out-of-line

     These are mainained as external modules or things that need to be
     translated to modules.  We have various low-level mechanisms to
     implement the hooking up of those currently (*probes) but no other
     infratsurcture in the kernel to help with those.  There's an external
     project, systemtap which supports probes like those but has a bunch
     of problems:

       - it doesn't allow writing scripts in C but only in some odd scripting
	 language
       - it doesn't actually put support code into the kernel tree but keeps
	 it separate, not allowing to keep probes with the kernel either.
	 In addition it also needs quite frequent updates because it has to
	 poke deep into kernel internals by it's nature.

So what's the right way of tracing for us?   I'd say a pretty clear all three,
and most importantly we need to have a common infrastrucuture for all of those.

The most important bit we need right now is a reliable framework to transfer
trace data to userspace - one we have that we support a) and a subset of
b) above.  LTT might be that missing bit, but I'd need to look at the actual
patches to see if it's suitable.  b) is something people have talked about
a lot and we've seen lots of prototypes, in my eyes it's the second priority.

But even after that the way we support c) is very rudimentary - we need
helpers to look at data, put probes at points outside of function entry/
return we needs things like a dwarf parser, an so on.

I think the systemtap approach of the external package is the very last
thing we need.  Unlike you said elsewhere having the tracepoints externally
does not eliminitate maintaince overhead - it shifts it to someone else.
Shifting maintaince overhead to someone else is a valid concept in the
linux kernel development, we do this all the time for things we don't care
about.  I think it's fundamentally wrong for traces, though.  Traces are
very important for debugging complex problems, and I've grown very tired
of maintaining all my ad-hoc scripts.  Having them in the kernel tree
or traces static in it's nature inline would allow and force kernel developers
to always keept it uptodate with it's changes. 
