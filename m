Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266664AbUGVBtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266664AbUGVBtm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 21:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266666AbUGVBtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 21:49:42 -0400
Received: from mx1.elte.hu ([157.181.1.137]:37545 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266664AbUGVBti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 21:49:38 -0400
Date: Wed, 21 Jul 2004 23:08:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Scott Wood <scott@timesys.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Lee Revell <rlrevell@joe-job.com>,
       Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040721210832.GA30871@elte.hu>
References: <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au> <20040721183415.GC2206@yoda.timesys> <20040721184650.GA27375@elte.hu> <20040721195650.GA2186@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721195650.GA2186@yoda.timesys>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-1.524, required 5.9,
	autolearn=not spam, BAYES_01 -1.52
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Scott Wood <scott@timesys.com> wrote:

> > > You're still running do_softirq() with preemption disabled, which is
> > > almost as bad as doing it under a lock.
> > 
> > well softirqs are designed like that. 
> 
> And those who wish to continue using them like that can.  However, in
> my patch they never run with preemption disabled, which can result in
> substantial latency improvement (as long as nothing else is causing
> similar delays).  I see nothing in the design that *requires* them to
> continue running with preemption disabled.

did you get my other mail in which i explained how e.g. the networking
code _relies_ on the softirq semantics?

of course you can improve latencies by making something preemptible that
wasnt preemptible before, but if you do that you should be absolutely
sure that it can be done without breaking that code. And in this case it
cannot be done. The comments in your patch also suggest that you were
unsure about this issue:

 +/* As far as I can tell, local_bh_disable() didn't stop ksoftirqd
 +   from running before.  Since all softirqs now run from one of
 +   the ksoftirqds, this shouldn't be necessary. */
 +
 +static inline void local_bh_disable(void)
 +{
 +}

local_bh_disable() of course stops ksoftirqd from running on that CPU.

> Do you also add preemption checks in all of the various loops that can
> be run from within a single softirq instance?

no, that's the next step, if those loops turn out to be problematic. 
E.g. network device backlogs default to a value of 100 or so which
shouldnt generate too bad latencies. If it does it's easy to break out
of those loops, they are already breakout-aware.

	Ingo
