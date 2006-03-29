Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbWC2Mh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWC2Mh7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 07:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWC2Mh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 07:37:59 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36785 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751071AbWC2Mh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 07:37:58 -0500
Date: Wed, 29 Mar 2006 14:35:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: PI patch against 2.6.16-rt9
Message-ID: <20060329123526.GA4322@elte.hu>
References: <20060329071456.GA20187@elte.hu> <Pine.LNX.4.44L0.0603290851320.12114-100000@lifa01.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0603290851320.12114-100000@lifa01.phys.au.dk>
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

> The point is: It does not matter that is another chain!
> 
> It will _not_ boost any task which doesn't need boosting, because it 
> is not boosting according to current->prio but always 
> task->pi_waiters. So all it does is to fix the priorities on some 
> tasks. There is absolutely nothing wrong with that. [...]

doh, you are right, i missed that. All the state to do the boosting is 
contained in a single entry along the chain, so no prior information is 
needed.

the problem with deadlock detection remains though. Can we live with 
deadlock detection being a bit statistical? I think we can: deadlock 
detection is for _bugs_, no application should rely on it to provide 
actual functionality. (if it still does it will still work fine, but we 
dont design for them.) Also, if we walk long enough (say 1024 entries) 
the probability of a false positive ought to be pretty low. So i think 
the following type of deadlock detection ought to be pretty OK:

 - check whether we get back to 'current'.

 - check whether we exceed a configurable limit of steps

most 'sane' deadlocks will be detected quickly: they'll lead back to 
'current' and the kernel returns. On the off chance of the chain-walking 
getting lured into a completely unrelated chain the limit will catch it.

	Ingo
