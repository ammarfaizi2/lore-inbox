Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVGZK10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVGZK10 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 06:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVGZK10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 06:27:26 -0400
Received: from mx2.elte.hu ([157.181.151.9]:746 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261618AbVGZK1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 06:27:25 -0400
Date: Tue, 26 Jul 2005 12:26:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.13rc3: RLIMIT_RTPRIO broken
Message-ID: <20050726102638.GA4000@elte.hu>
References: <42E22D0C.1010608@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E22D0C.1010608@domdv.de>
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


* Andreas Steinmetz <ast@domdv.de> wrote:

> RLIMIT_RTPRIO is supposed to grant non privileged users the right to 
> use SCHED_FIFO/SCHED_RR scheduling policies with priorites bounded by 
> the RLIMIT_RTPRIO value via sched_setscheduler(). This is usually used 
> by audio users.
> 
> Unfortunately this is broken in 2.6.13rc3 as you can see in the 
> excerpt from sched_setscheduler below:
> 
>         /*
>          * Allow unprivileged RT tasks to decrease priority:
>          */
>         if (!capable(CAP_SYS_NICE)) {
>                 /* can't change policy */
>                 if (policy != p->policy)
>                         return -EPERM;
> 
> After the above unconditional test which causes sched_setscheduler to
> fail with no regard to the RLIMIT_RTPRIO value the following check is made:
> 
>                /* can't increase priority */
>                 if (policy != SCHED_NORMAL &&
>                     param->sched_priority > p->rt_priority &&
>                     param->sched_priority >
>                                 p->signal->rlim[RLIMIT_RTPRIO].rlim_cur)
>                         return -EPERM;
> 
> Thus I do believe that the RLIMIT_RTPRIO value must be taken into 
> account for the policy check, especially as the RLIMIT_RTPRIO limit is 
> of no use without this change.
> 
> The attached patch fixes this problem. I would appreciate it if the 
> fix would make it into 2.6.13.

[back from KS/OLS]

indeed. The effect of the bug is that RLIMIT_RTPRIO is completely
non-functional in 2.6.12.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
