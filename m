Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVAaXER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVAaXER (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVAaXER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:04:17 -0500
Received: from [144.140.70.13] ([144.140.70.13]:44194 "HELO
	gizmo03bw.bigpond.com") by vger.kernel.org with SMTP
	id S261421AbVAaXEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:04:05 -0500
Message-ID: <41FEB951.8070307@bigpond.net.au>
Date: Tue, 01 Feb 2005 10:03:45 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Jack O'Quin" <joq@io.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <200501201542.j0KFgOwo019109@localhost.localdomain> <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu> <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu> <41F6C5CE.9050303@bigpond.net.au> <20050126092014.GA7003@elte.hu>
In-Reply-To: <20050126092014.GA7003@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
> 
>>As I understand this (and I may be wrong), the intention is that if a
>>task has its RT_CPU_RATIO rlimit set to a value greater than zero then
>>setting its scheduling policy to SCHED_RR or SCHED_FIFO is allowed. 
> 
> 
> correct.
> 
> 
>>This causes me to ask the following questions:
>>
>>1. Why is current->signal->rlim[RLIMIT_RT_CPU_RATIO].rlim_cur being used 
>>in setscheduler() instead of p->signal->rlim[RLIMIT_RT_CPU_RATIO].rlim_cur?
>>
>>2. What stops a task that had a non zero RT_CPU_RATIO rlimit and
>>changed its policy to SCHED_RR or SCHED_FIFO from then setting
>>RT_CPU_RATIO rlimit back to zero and escaping the controls?  As far as
>>I can see (and, once again, I may be wrong) the mechanism for setting
>>rlimits only requires CAP_SYS_RESOURCE privileges in order to increase
>>the value.
> 
> 
> you are right, both are bugs.
> 
> i've uploaded the -D6 patch that should have both fixed:
> 
>   http://redhat.com/~mingo/rt-limit-patches/
> 

I've just noticed what might be a bug in the original code.  Shouldn't 
the following:

        if ((current->euid != p->euid) && (current->euid != p->uid) &&
                !capable(CAP_SYS_NICE))

be:

        if ((current->uid != p->uid) && (current->euid != p->uid) &&
                !capable(CAP_SYS_NICE))

I.e. if the real or effective uid of the task doing the setting is not 
the same as the uid of the target task it is not allowed to change the 
target task's policy unless it is specially privileged.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
