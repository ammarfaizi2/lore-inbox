Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWCMOcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWCMOcN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 09:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWCMOcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 09:32:13 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55766 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750994AbWCMOcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 09:32:11 -0500
Date: Mon, 13 Mar 2006 15:29:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.16-rc6-rt1
Message-ID: <20060313142951.GA6246@elte.hu>
References: <20060312220218.GA3469@elte.hu> <Pine.LNX.4.44L0.0603131130460.25211-100000@lifa01.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0603131130460.25211-100000@lifa01.phys.au.dk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> However, I notice it re-introduces long latencies :-( The problem is 
> that the time need in adjust_prio_chain is proportional to the lock 
> depth and the function is called with two raw spinlocks held. This is 
> no problem when the locks are in the kernel and thus not very deeply 
> nested, but when it is exposed to futexes there is a problem as Joe 
> user can increase the task latency of the system by crafting deep 
> locking structures in userspace.

i dont think that's a problem. For userspace futexes we'll (have to) 
introduce some sensible locking depth anyway.

> I will be on paternity leave soonish. I might get time solve it as I 
> originally suggested some months back when my daughter is asleep. The 
> solution I suggested last fall, includes releasing _all_ locks at each 
> iteration in the loop in adjust_prio_chain such that higher priority 
> tasks gets a chance to run. To avoid having tasks released in the 
> middle get/put_tast_struct() are needed. That will cost extra atomic 
> instructions compared to the present implementation. Are people 
> prepared to pay that price? I am not talking about the scheduler based 
> solution; just doing the PI iteration in a little different (and 
> slightly more epensive) way.

well, we'd have to see the code for that, but i'm afraid this would be 
fundamentally racy. What if another CPU changes one of the data 
structures along the way?

	Ingo
