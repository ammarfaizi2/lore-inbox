Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbVATAeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbVATAeV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 19:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVATAdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 19:33:23 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:51341 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262008AbVATAcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 19:32:22 -0500
Message-ID: <41EEFC4F.1090704@kolivas.org>
Date: Thu, 20 Jan 2005 11:33:19 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: utz lehmann <lkml@s2y4n2c.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com, joq@io.com,
       CK Kernel <ck@vds.kolivas.org>, Andrew Morton <akpm@osdl.org>,
       alexn@dsv.su.se
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt	scheduling
References: <41EEE1B1.9080909@kolivas.org> <1106180177.4036.27.camel@segv.aura.of.mankind>
In-Reply-To: <1106180177.4036.27.camel@segv.aura.of.mankind>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

utz lehmann wrote:
> @@ -2406,6 +2489,10 @@ void scheduler_tick(void)
>  	task_t *p = current;
>  
>  	rq->timestamp_last_tick = sched_clock();
> +	if (iso_task(p) && !rq->iso_refractory)
> +		inc_iso_ticks(rq, p);
> +	else 
> +		dec_iso_ticks(rq, p);
> 
> scheduler_tick() is not only called by the timer interrupt but also form
> the fork code. Is this intended? I think the accounting for

The calling from fork code only occurs if there is one millisecond of 
time_slice left so it will only very rarely be hit. I dont think this 
accounting problem is worth worrying about.

> iso_refractory is wrong. Isn't calling it from
> timer.c::update_process_times() better?
> 
> And shouldn't real RT task also counted? If RT tasks use 40% cpu you can
> lockup the system as unprivileged user with SCHED_ISO because it doesn't
> reach the 70% cpu limit.

Ah yes. Good point. Will add that to the equation.

> Futher on i see a fundamental problem with this accounting for
> iso_refractory. What if i manage as unprivileged user to run a SCHED_ISO
> task which consumes all cpu and only sleeps very short during the timer
> interrupt? I think this will nearly lockup or very slow down the system.
> The iso_cpu limit can't guaranteed.

Right you are. The cpu accounting uses primitive on-interrupt run time 
which as we know is not infallible. To extend this I'll have to keep a 
timer based on the sched_clock which is already implemented. That's 
something for me to work on.

> sysrq-n causes a reboot.

And that will need looking into.

Thanks very much for your comments!

Cheers,
Con
