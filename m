Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967604AbWK2Txw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967604AbWK2Txw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 14:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967605AbWK2Txw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 14:53:52 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:34500 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S967604AbWK2Txv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 14:53:51 -0500
Date: Wed, 29 Nov 2006 20:51:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc6-rt8: alsa xruns
Message-ID: <20061129195144.GA8676@elte.hu>
References: <1164743931.15887.34.camel@cmn3.stanford.edu> <20061128200927.GA26934@elte.hu> <1164746224.15887.40.camel@cmn3.stanford.edu> <1164747854.15887.48.camel@cmn3.stanford.edu> <20061129134311.GA14566@elte.hu> <1164825498.18954.5.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164825498.18954.5.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> > ok, i reproduced something similar on one of my boxes and it turned 
> > out to be a tracer bug. I've uploaded -rt10, could you try it? (The 
> > xruns will likely remain, but at least the tracer should be more 
> > usable now to find out the reason for the xruns.)
> 
> I'm testing -rt10 right now (your binary rpm). Looks like the number 
> and length of the xruns went down, at least for now. All below 2mSec - 
> jack is running 128x2 @ 48000Hz. I'll let it run for a while and 
> report the traces (I have a script that collects all traces above 
> 60us, but not all xruns trigger a trace).

ok.

How do you gather the traces, are you using manual control of tracing 
via prctl(0,1) / prctl(0,0) - or the built-in wakeup tracing method? The 
wakeup tracing method will detect fundamental problems in -rt 
scheduling, but other types of delays can be better debugged via 
explicit tracing. [jackd used to have the gettimeofday(0,1)/(0,0) hack - 
this API hack has been replaced by prctl(0,1)/(0,0) to start/stop 
tracing] Take a look at linux/scripts/trace-it.c on how to set up 
manually triggered tracing. [if you do that then all you need to do is 
to start/stop the trace - the kernel will do a maximum search and will 
record the longest delay between start/stop calls.]

Also, can you see the xruns/latencies with latencytest too? (That one 
might be easier to reproduce for me.)

Also, my experience is that if there's a short succession of latencies 
after each other, then it's usually the first trace that makes most 
sense to analyze - the others might just be 'followup' or 'secondary' 
delays caused by the tracing/printing overhead of the first trace. So 
generally i concentrate on the first trace. But if the traces are 
reasonably apart then each of them makes sense - and sometimes one trace 
is more informative than another.

	Ingo
