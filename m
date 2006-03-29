Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWC2HR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWC2HR3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 02:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWC2HR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 02:17:29 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:50058 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751126AbWC2HR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 02:17:29 -0500
Date: Wed, 29 Mar 2006 09:14:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: PI patch against 2.6.16-rt9
Message-ID: <20060329071456.GA20187@elte.hu>
References: <20060328212448.GA7120@elte.hu> <Pine.LNX.4.44L0.0603282324030.22822-100000@lifa02.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0603282324030.22822-100000@lifa02.phys.au.dk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> > well, another possibility is that the task got blocked again, and we'll
> > continue boosting _the wrong chain_. I.e. we'll add extra priority to
> > task(s) that might not deserve it at all (it doesnt own the lock we are
> > interested in anymore).
> 
> This can't happen. We are always looking at the first waiter on 
> task->pi_waiter task->pi_lock held when doing the boosting. If task 
> has released the lock the entry task->pi_waiter is gone and no 
> boosting will take place!

no, the task got blocked _again_, as part of a _new_ blocking chain, and 
there's a _new_ PI waiter! How does the two-lock preemptible boosting 
algorithm ensure that if we are in the middle of boosting a 
blocking-dependency chain:

   T1 -> T2 -> ... -> TI -> TI+1 -> ... TN-1 -> TN

we are at TI, and we [the task doing the boosting] now get preempted.

What prevents TI from being part of a _totally new_ blocking-chain, 
where the only similarity between the two chains is that TI is in the 
middle of it:

   T1' -> T2' -> ... -> TI -> TI+1' -> ... TM-1 -> TM'

the only match between the two chains is 'TI'. Now the algorithm will
happily walk the wrong boosting chain, and will boost the wrong tasks.

	Ingo
