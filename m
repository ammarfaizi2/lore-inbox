Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWFLHT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWFLHT1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 03:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWFLHT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 03:19:27 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:49078 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751025AbWFLHT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 03:19:26 -0400
Date: Mon, 12 Jun 2006 09:18:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrey Gelman <agelman@012.net.il>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Assumably a BUG in Linux Kernel (scheduler part)
Message-ID: <20060612071830.GA26475@elte.hu>
References: <200606091732.02943.agelman@012.net.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606091732.02943.agelman@012.net.il>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrey Gelman <agelman@012.net.il> wrote:

> Hello there !
> Assumably, I've discovered a bug in Linux kernel (version 2.6.16), at:
> kernel\sched.c   function set_user_nice()
[...]

> //-------------------------------------------------
> /*
> 	//BUGGED FORMULA : 5 lines
>         old_prio = p->prio;
>         new_prio = NICE_TO_PRIO(nice);
>         delta = new_prio - old_prio;
>         p->static_prio = NICE_TO_PRIO(nice);
>         p->prio += delta;
> */
>     //BUG FIX : 5 lines
>     old_prio = p->static_prio;
>     new_prio = NICE_TO_PRIO(nice);
>     delta = new_prio - old_prio;
>     p->static_prio = new_prio;
>     p->prio += delta;
> //-------------------------------------------------

you are right, this is a bug in the scheduler - good find.

I did accidentally fix it months ago via one of the PI-scheduling 
cleanups, and thus the fix is in the current -mm tree and is scheduled 
for 2.6.18 inclusion:

 http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm2/broken-out/pi-futex-scheduler-support-for-pi.patch

(see the adding of effective_prio() to set_user_nice(), instead of an 
open-coded calculation of the priority)

But i did not realize that this also fixed a bug. The effects of the bug 
are minor: a user can renice only 19 times (to go from 0 to +19), so 
there's a finite amount of extra timeslices a CPU hog might win due to 
this. I'd not include the effective_prio() change in 2.6.17 - it touches 
quite some code and we are close to the release of 2.6.17. Nevertheless 
kudos for finding and pointing out this bug!

Andrew, please add this to the changelog of
pi-futex-scheduler-support-for-pi.patch:

the effective_prio() cleanups also fix a priority-calculation bug 
pointed out by Andrey Gelman, in set_user_nice().

	Ingo
