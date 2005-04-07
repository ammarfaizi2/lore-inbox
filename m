Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVDGHLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVDGHLp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 03:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVDGHLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 03:11:45 -0400
Received: from mx2.elte.hu ([157.181.151.9]:647 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261743AbVDGHLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 03:11:37 -0400
Date: Thu, 7 Apr 2005 09:11:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch 4/5] sched: RCU sched domains
Message-ID: <20050407071101.GA26607@elte.hu>
References: <425322E0.9070307@yahoo.com.au> <42532317.5000901@yahoo.com.au> <42532346.5050308@yahoo.com.au> <425323A1.5030603@yahoo.com.au> <20050406061838.GB5973@elte.hu> <4253975E.20804@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4253975E.20804@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > At a minimum i think we need the fix+comment below.
> 
> Well if we say "this is actually RCU", then yes. And we should 
> probably change the preempt_{dis|en}ables in other places to 
> rcu_read_lock.
> 
> OTOH, if we say we just want all running threads to process through a 
> preemption stage, then this would just be a preempt_disable/enable 
> pair.
> 
> In practice that makes no difference yet, but it looks like you and 
> Paul are working to distinguish these two cases in the RCU code, to 
> accomodate your low latency RCU stuff?

it doesnt impact PREEMPT_RCU/PREEMPT_RT directly, because the scheduler 
itself always needs to be non-preemptible.

those few places where we currently do preempt_disable(), which should 
thus be rcu_read_lock(), are never in codepaths that can take alot of 
time.

but yes, in principle you are right, but in this particular (and 
special) case it's not a big issue. We should document the RCU read-lock 
dependencies cleanly and make all rcu-read-lock cases truly 
rcu_read_lock(), but it's not a pressing issue even considering possible 
future features like PREEMPT_RT.

the only danger in this area is to PREEMPT_RT: it is a bug on PREEMPT_RT 
if kernel code has an implicit 'spinlock means preempt-off and thus 
RCU-read-lock' assumption. Most of the time these get discovered via 
PREEMPT_DEBUG. (preempt_disable() disables preemption on PREEMPT_RT too, 
so that is not a problem either.)

	Ingo
