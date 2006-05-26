Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWEZNzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWEZNzj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 09:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWEZNzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 09:55:39 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:19669 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750755AbWEZNzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 09:55:38 -0400
Message-ID: <447708D8.6040000@bigpond.net.au>
Date: Fri, 26 May 2006 23:55:36 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Mike Galbraith <efault@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFC 2/5] sched: Add CPU rate soft caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <20060526042041.2886.69840.sendpatchset@heathwren.pw.nest> <200605262048.53131.kernel@kolivas.org>
In-Reply-To: <200605262048.53131.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 26 May 2006 13:55:36 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Friday 26 May 2006 14:20, Peter Williams wrote:
>> This patch implements (soft) CPU rate caps per task as a proportion of a
>> single CPU's capacity expressed in parts per thousand.  The CPU usage
>> of capped tasks is determined by using Kalman filters to calculate the
>> (recent) average lengths of the task's scheduling cycle and the time
>> spent on the CPU each cycle and taking the ratio of the latter to the
>> former.  To minimize overhead associated with uncapped tasks these
>> statistics are not kept for them.
>>
>> Notes:
>>
>> 1. To minimize the overhead incurred when testing to skip caps processing
>> for uncapped tasks a new flag PF_HAS_CAP has been added to flags.
> 
> [ot]I'm sorry to see an Australian adopt American spelling [/ot]

I think you'll find the Oxford English Dictionary (which was the 
reference when I went to school in the middle of last century) uses the 
z and offers the s version as an option.

> 
>> 3. Enforcement of caps is not as strict as it could be in order to
>> reduce the possibility of a task being starved of CPU while holding
>> an important system resource with resultant overall performance
>> degradation.  In effect, all runnable capped tasks will get some amount
>> of CPU access every active/expired swap cycle.  This will be most
>> apparent for small or zero soft caps.
> 
> The array swap happens very frequently if there are nothing but heavily cpu 
> bound tasks, which is not an infrequent workload. I doubt the zero caps are 
> very effective in that environment.

Yes and it depends on HZ as well (i.e. it works better when HZis zero). 
  With HZ=250 and a zero capped hard spinning task competing with 
another hard spinning task on a single CPU system it struggles to keep 
it below below 4%.  I've tested hard caps down to 0.5% in the same test 
and it copes.  So a long term solution such as something similar to the 
rt_mutex priority inheritance is needed so that stricter soft capping 
can be enforced.  I don't think that it would be hard to be more strict 
as it would just involve some checking when determining idx in schedule().

BTW in my SPA schedulers this can be controlled by varying the promotion 
rate.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
