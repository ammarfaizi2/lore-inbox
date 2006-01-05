Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWAELkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWAELkf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 06:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbWAELkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 06:40:35 -0500
Received: from omta01sl.mx.bigpond.com ([144.140.92.153]:5489 "EHLO
	omta01sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750804AbWAELke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 06:40:34 -0500
Message-ID: <43BD038E.9070204@bigpond.net.au>
Date: Thu, 05 Jan 2006 22:31:26 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Helge Hafting <helgehaf@aitel.hist.no>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client  on	interactive
 response
References: <43BB2414.6060400@bigpond.net.au> <43A8EF87.1080108@bigpond.net.au> <1135145341.7910.17.camel@lade.trondhjem.org> <43A8F714.4020406@bigpond.net.au> <20060102110145.GA25624@aitel.hist.no> <43B9BD19.5050408@bigpond.net.au> <43BB2414.6060400@bigpond.net.au> <5.2.1.1.2.20060105070601.026b21f0@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20060105070601.026b21f0@pop.gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 5 Jan 2006 11:31:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> At 08:51 AM 1/5/2006 +1100, Peter Williams wrote:
> 
>> I think that some of the harder to understand parts of the scheduler 
>> code are actually attempts to overcome the undesirable effects (such 
>> as those I've described) of inappropriately identifying tasks as 
>> interactive.  I think that it would have been better to attempt to fix 
>> the inappropriate identifications rather than their effects and I 
>> think the prudent use of TASK_NONINTERACTIVE is an important tool for 
>> achieving this.
> 
> 
> IMHO, that's nothing but a cover for the weaknesses induced by using 
> exclusively sleep time as an information source for the priority 
> calculation.  While this heuristic does work pretty darn well, it's 
> easily fooled (intentionally or otherwise).  The challenge is to find 
> the right low cost informational component, and to stir it in at O(1).

TASK_NONINTERACTIVE helps in this regard, is no cost in the code where 
it's used and probably decreases the costs in the scheduler code by 
enabling some processing to be skipped.  If by its judicious use the 
heuristic is only fed interactive sleep data the heuristics accuracy in 
identifying interactive tasks should be improved.  It may also allow the 
heuristic to be simplified.

Other potential information sources the priority calculation may also 
benefit from TASK_INTERACTIVE.  E.g. measuring interactive latency 
requires knowing that the task is waking from an interactive sleep.

> 
> The fundamental problem with the whole interactivity issue is that the 
> kernel has no way to know if there's a human involved or not.

Which is why SCHED_BATCH has promise.  The key for it becoming really 
useful will be getting authors of non interactive programs to use it. 
The hard part will be getting them to admit that their programs are non 
interactive and undeserving of a boost.

>  My 
> 100%cpu GL screensaver is interactive while I'm mindlessly staring at it.

I've never actually seen what bonuses the screensaver gets :-) but I 
imagine any sleeping they do is in a very regular sleep/run pattern and 
this regularity can be measured and used to exclude them from bonuses. 
However, it would need some extra parameters to avoid depriving audio 
and video programs of bonuses as they too have very regular sleep/run 
patterns.  The average sleep/run interval is one possibility as 
audio/video programs tend to use small intervals.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
