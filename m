Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVATE0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVATE0v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 23:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVATE0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 23:26:51 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:13009 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262042AbVATE0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 23:26:48 -0500
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft
	rt	scheduling
From: utz lehmann <lkml@s2y4n2c.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com, joq@io.com,
       CK Kernel <ck@vds.kolivas.org>, Andrew Morton <akpm@osdl.org>,
       alexn@dsv.su.se
In-Reply-To: <41EEFC4F.1090704@kolivas.org>
References: <41EEE1B1.9080909@kolivas.org>
	 <1106180177.4036.27.camel@segv.aura.of.mankind>
	 <41EEFC4F.1090704@kolivas.org>
Content-Type: text/plain
Date: Thu, 20 Jan 2005 05:26:41 +0100
Message-Id: <1106195201.4180.23.camel@segv.aura.of.mankind>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a3828f1c4d839cf12e8a3b808f7ed34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-20 at 11:33 +1100, Con Kolivas wrote:
> utz lehmann wrote:
> > @@ -2406,6 +2489,10 @@ void scheduler_tick(void)
> >  	task_t *p = current;
> >  
> >  	rq->timestamp_last_tick = sched_clock();
> > +	if (iso_task(p) && !rq->iso_refractory)
> > +		inc_iso_ticks(rq, p);
> > +	else 
> > +		dec_iso_ticks(rq, p);
> > 
> > scheduler_tick() is not only called by the timer interrupt but also form
> > the fork code. Is this intended? I think the accounting for
> 
> The calling from fork code only occurs if there is one millisecond of 
> time_slice left so it will only very rarely be hit. I dont think this 
> accounting problem is worth worrying about.

I had experimented with throttling runaway RT tasks. I use a similar
accounting. I saw a difference between counting with or without the
calling from fork. If i remember correctly the timeout expired too fast
if the non-RT load was "while /bin/true; do :; done".
With "while true; do :; done" ("true" is bash buildin) it worked good.
But maybe it's not important in the real world.

> 
> > Futher on i see a fundamental problem with this accounting for
> > iso_refractory. What if i manage as unprivileged user to run a SCHED_ISO
> > task which consumes all cpu and only sleeps very short during the timer
> > interrupt? I think this will nearly lockup or very slow down the system.
> > The iso_cpu limit can't guaranteed.
> 
> Right you are. The cpu accounting uses primitive on-interrupt run time 
> which as we know is not infallible. To extend this I'll have to keep a 
> timer based on the sched_clock which is already implemented. That's 
> something for me to work on.

If i understand sched_clock correctly it only has higher resolution if
you can use tsc. In the non tsc case it's jiffies based. (On x86).
I think you can easily fool a timer tick/jiffies based accounting and do
a local DoS.
Making SCHED_ISO privileged if you don't have a high resolution
sched_clock is ugly.
I really like the idea of a unprivileged SCHED_ISO but it has to be safe
for a multi user system. And the kernel default should be safe for multi
user.

cheers
utz

