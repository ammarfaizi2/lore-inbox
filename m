Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWAKCiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWAKCiV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 21:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWAKCiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 21:38:21 -0500
Received: from omta01sl.mx.bigpond.com ([144.140.92.153]:49991 "EHLO
	omta01sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932308AbWAKCiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 21:38:20 -0500
Message-ID: <43C46F99.1000902@bigpond.net.au>
Date: Wed, 11 Jan 2006 13:38:17 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Martin Bligh <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <20060110173159.55cce659.akpm@osdl.org> <43C4624D.4040604@google.com> <200601111249.05881.kernel@kolivas.org>
In-Reply-To: <200601111249.05881.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 11 Jan 2006 02:38:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Wed, 11 Jan 2006 12:41 pm, Martin Bligh wrote:
> 
>>Seems to have gone wrong between 2.6.14-rc1-mm1 and 2.6.14-rc2-mm1 ?
>>See http://test.kernel.org/perf/kernbench.moe.png for clearest effect.
> 
> 
> The only new scheduler patch at that time was this:
> +sched-modified-nice-support-for-smp-load-balancing.patch
> 
> which was Peter's modifications to my smp nice support. cc'ed Peter
> 

This patch will probably have overhead implications as it will skip some 
tasks during load balancing looking for ones whose bias_prio is small 
enough to fit within the amount of bias to be moved.  Because the 
candidate tasks are ordered in the array by dynamic priority and not 
nice (or bias_prio) the search is exhaustive.  I need to think about 
whether this can be made a little smarter e.g. skip to the next idx as 
soon as a task whose bias_prio is too large is encountered.  This would 
have the effect of missing some tasks that could have been moved due but 
these will generally be tasks with interactive bonuses causing them to 
be in a lower slot in the queue than would otherwise be the case and as 
they generally do small CPU runs not moving them probably won't make 
much difference.

 > I guess we need to check whether reversing this patch helps.

It would be interesting to see if it does.

If it does we probably have to wear the cost (and try to reduce it) as 
without this change smp nice support is fairly ineffective due to the 
fact that it moves exactly the same tasks as would be moved without it. 
  At the most it changes the frequency at which load balancing occurs.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
