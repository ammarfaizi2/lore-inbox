Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965463AbWKIOf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965463AbWKIOf4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 09:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966015AbWKIOfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 09:35:55 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:15571 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965463AbWKIOfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 09:35:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U55g1CeXoB7XA59HCrxpM1GWeOLRRpOk1WhDiQ+/ILIW6GvbaLnYS1tgQRMxL3gfyLXtE44KLyZGNT4DYR0e9OHne9Gygc8nr2J5CE/0QewgMmIrz7wKwZ4Vb1C6Mot1N/5bRnnGmK4AGPUq3d9c830tmdRvuq1PXk95kh5QMpQ=
Message-ID: <3f250c710611090635j530e7f02q7a84d367fa2ab41c@mail.gmail.com>
Date: Thu, 9 Nov 2006 10:35:53 -0400
From: "Mauricio Lin" <mauriciolin@gmail.com>
To: balbir@in.ibm.com
Subject: Re: Jiffies wraparound is not treated in the schedstats
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4552CAD9.1080603@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3f250c710611081005v5fcf3236qfb10b47bab1ada5f@mail.gmail.com>
	 <4552CAD9.1080603@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balbir,

I did not know about arithmetic properties of the unsigned types, so
the misundertanding about jiffies calculation. It was my mistake.

On 11/9/06, Balbir Singh <balbir@in.ibm.com> wrote:
> Mauricio Lin wrote:
> > Hi Balbir,
> >
> > Do you know why in the sched_info_arrive() and sched_info_depart()
> > functions the calculation of delta_jiffies does not use the time_after
> > or time_before macro to prevent  the miscalculation when jiffies
> > overflow?
> >
> > For instance the delta_jiffies variable is simply calculated as:
> >
> > delta_jiffies = now - t->sched_info.last_queued;
> >
> > Do not you think the more logical way should be
> >
> > if (time_after(now, t->sched_info.last_queued))
> >    delta_jiffies = now - t->sched_info.last_queued;
> > else
> >    delta_jiffies = (MAX_JIFFIES - t->sched_info.last_queued) + now
> >
>
> What's MAX_JIFFIES? Is it MAX_ULONG? jiffies is unsigned long
> so you'll have to be careful with unsigned long arithmetic.

It is ULONG_MAX. :)

>
> Consider that now is 5 and t->sched_info.last_queued is 10.
>
> On my system
>
> perl -e '{printf("%lu\n", -5 + (1<<32) - 1);}'
> 4294967291
>
> perl -e '{printf("%lu\n", -5 );}'
> 4294967291
>
>
> > I have included more variables to measure some issues of schedule in
> > the kernel (following schedstat idea) and I noticed that jiffies
> > wraparound has led to wrong values, since the user space tool when
> > collecting the values is producing negative values.
> >
>
> hmm.. jiffies wrapped around in sched_info_depart()? I've never seen
> that happen. Could you post the additions and user space tool to look at?
> What additional features are you planning to measure in the scheduler?

Well, one of the behaviour we would like to check its the time that
the system remains idle. As the schedstat already provide the
sched_goidle (number of time the system gets idle), during the
measurements we would like to know also the time spent in the idle
state.

Checking the results, perhaps such new info is not necessary to be
included if we want the percentage of use in our measurements. For
instance if we want the cpu_load calculated as:

cpu_load = (cpu_time2 - cpu_time1)/sample_period

where "cpu_time" corresponds to the rq->rq_sched_info.cpu_time in the
kernel and "sample period" is the time spent running the use case.

So the "cpu_idle_load" can be calculated as (1-cpu_load).

If we include in the __sched_info_switch() (kernel) something like:

...
	if (prev != rq->idle)
		sched_info_depart(prev);
	else
		rq->rq_sched_info.idle_time +=
			jiffies - prev->sched_info.last_arrival;

	if (next != rq->idle)
		sched_info_arrive(next);
	else
		next->sched_info.last_arrival = jiffies;
...

We can calculated the cpu_idle_load at user space as:

cpu_idle_load = (cpu_idle_time2 - cpu_idle_time1)/sample_period

where cpu_idle_time corresponds to rq->rq_sched_info.idle_time

This info leads to the same result if we just base the calculation on
the (1-cpu_load) as mentioned previously.

BR,

Mauricio Lin.
