Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266850AbUGVKF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266850AbUGVKF7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 06:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266849AbUGVKF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 06:05:59 -0400
Received: from mx1.elte.hu ([157.181.1.137]:42671 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266850AbUGVKF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 06:05:56 -0400
Date: Thu, 22 Jul 2004 12:06:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Scott Wood <scott@timesys.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: [patch] voluntary-preempt-2.6.8-rc2-H9
Message-ID: <20040722100657.GA14909@elte.hu>
References: <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721183010.GA2206@yoda.timesys> <20040721210051.GA2744@yoda.timesys> <20040721211826.GB30871@elte.hu> <20040721223749.GA2863@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721223749.GA2863@yoda.timesys>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Scott Wood <scott@timesys.com> wrote:

> > trying to make softirqs preemptible surely wont fly for 2.6 and it will
> > also overly complicate the softirq model. What's so terminally wrong
> > about adding preemption checks to the softirq paths? It should solve the
> > preemption problem for good. The unbound softirq paths are well-known
> > (mostly in the networking code) and already have preemption-alike
> > checks.
> 
> If every such loop in every softirq is taken care of, that would work
> (though only until someone adds a new softirq that forgets to check
> for preemption).  I don't see any such checks in either the transmit
> or receive network softirqs in vanilla 2.6.7, though (are they in a
> patch, or am I overlooking them?), much less in each individual
> driver.  There are checks for excessive work (where "excessive" is not
> well defined in terms of actual time), but none for need_resched()
> except in a few isolated places.

i've added an infrastructure for easy softirq lock-break and preemption 
to the -H9 version of the voluntary-preempt patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-H9

in -H9 i've fixed the most important softirq latency sources:

 - the RCU code

  this one is new and is really bad - it can literally execute tens of
  thousands of d_callback() functions within rcu_do_batch() causing
  millisecs of delays - e.g. triggered by the 'du /' test on a box with
  enough RAM. It affects UP just as much as SMP, in both preempt and 
  non-preempt mode as well.

 - the timer code

  no real latencies in practice but in theory if enough timers are set 
  to fire in the same jiffy it could be easily unbound.

 - net TX/RX code

  being the worst offender this had some throttling code already but it 
  didnt listen to resched requests. It does now.

it is really easy to do lock-break of softirqs, one only has to find a
place where it's safe to enable softirq processing and do a
cond_resched_softirq() call.

	Ingo
