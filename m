Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVDSQH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVDSQH7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 12:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVDSQH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 12:07:59 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:10444 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261616AbVDSQHu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 12:07:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dZv9zz6oEBuLOogUui3mDGOQFCLl2n5eXwx2BeKp9TmsoFQoAA7H+V+qb9trod/S+SRhW6BHOqUuRgEnX860KDFjToHqmqAbXJIR2HKKJHW34WLLYQ9hrpRtKPMRfD95O8B2qF/Qs+aZ91u0YdRI4U3WrVmk+j6WqyYccTwBO+M=
Message-ID: <29495f1d0504190907234a0d1d@mail.gmail.com>
Date: Tue, 19 Apr 2005 09:07:49 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: vatsa@in.ibm.com
Subject: Re: VST and Sched Load Balance
Cc: george@mvista.com, nickpiggin@yahoo.com.au, mingo@elte.hu,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050407124629.GA17268@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050407124629.GA17268@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/05, Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
> Hi,
>         VST patch (http://lwn.net/Articles/118693/) attempts to avoid useless
> regular (local) timer ticks when a CPU is idle.

<snip>

>  linux-2.6.11-vatsa/kernel/sched.c |   52 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 52 insertions(+)
> 
> diff -puN kernel/sched.c~vst-sched_load_balance kernel/sched.c
> --- linux-2.6.11/kernel/sched.c~vst-sched_load_balance  2005-04-07 17:51:34.000000000 +0530
> +++ linux-2.6.11-vatsa/kernel/sched.c   2005-04-07 17:56:18.000000000 +0530

<snip>

> @@ -1796,6 +1817,25 @@ find_busiest_group(struct sched_domain *
> 
>                         nr_cpus++;
>                         avg_load += load;
> +
> +#ifdef CONFIG_VST
> +                       if (idle != NOT_IDLE || !grp_sleeping ||
> +                                               (grp_sleeping && woken))
> +                               continue;
> +
> +                       sd1 = sd + (i-cpu);
> +                       interval = sd1->balance_interval;
> +
> +                       /* scale ms to jiffies */
> +                       interval = msecs_to_jiffies(interval);
> +                       if (unlikely(!interval))
> +                               interval = 1;
> +
> +                       if (jiffies - sd1->last_balance >= interval) {
> +                               woken = 1;
> +                               cpu_set(i, wakemask);
> +                       }

Sorry for the late reply, but shouldn't this jiffies comparison be
done with time_after() or time_before()?

Thanks,
Nish
