Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262792AbVA1WQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbVA1WQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 17:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262793AbVA1WQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 17:16:26 -0500
Received: from gizmo06ps.bigpond.com ([144.140.71.41]:54151 "HELO
	gizmo06ps.bigpond.com") by vger.kernel.org with SMTP
	id S262792AbVA1WQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 17:16:17 -0500
Message-ID: <41FAB9A5.6020105@bigpond.net.au>
Date: Sat, 29 Jan 2005 09:16:05 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Jack O'Quin" <joq@io.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu> <87sm4opxto.fsf@sulphur.joq.us> <20050126070404.GA27280@elte.hu> <87fz0neshg.fsf@sulphur.joq.us> <1106782165.5158.15.camel@npiggin-nld.site> <20050128080802.GA2860@elte.hu> <871xc62bot.fsf@sulphur.joq.us> <20050128084049.GA5004@elte.hu>
In-Reply-To: <20050128084049.GA5004@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Jack O'Quin <joq@io.com> wrote:
> 
> 
>>>i'm wondering, couldnt Jackd solve this whole issue completely in
>>>user-space, via a simple setuid-root wrapper app that does nothing else
>>>but validates whether the user is in the 'jackd' group and then keeps a
>>>pipe open to to the real jackd process which it forks off, deprivileges
>>>and exec()s? Then unprivileged jackd could request RT-priority changes
>>>via that pipe in a straightforward way. Jack normally gets installed as
>>>root/admin anyway, so it's not like this couldnt be done.
>>
>>Perhaps.
>>
>>Until recently, that didn't work because of the longstanding rlimits
>>bug in mlockall().  For scheduling only, it might be possible.
>>
>>Of course, this violates your requirement that the user not be able to
>>lock up the CPU for DoS.  The jackd watchdog is not perfect.
> 
> 
> there is a legitimate fear that if it's made "too easy" to acquire some
> sort of SCHED_FIFO priority, that an "arm's race" would begin between
> desktop apps, each trying to set themselves to SCHED_FIFO (or SCHED_ISO)
> and advising users to 'raise the limit if they see delays' - just to get
> snappier than the rest.
> 
> thus after a couple of years we'd end up with lots of desktop apps
> running as SCHED_FIFO, and latency would go down the drain again.
> 
> (yeah, this feels like going back to the drawing board.)

I think part of the problem here is that by comparing each tasks limit 
to the runqueue's usage rate (and to some extent using a relatively 
short decay period) you're creating the need for the limits to be quite 
large i.e. it has to be big enough to be bigger than the combined usage 
rates of all the unprivileged real time tasks and also to handle the 
short term usage rate peaks of the task.

If the average usage rate is estimated over longer periods it will be 
lower allowing lower limits to be used.  Also if the task's own usage 
rate estimates are used to test the limits then the limit can be lower.

If the default limits can be made sufficiently small then the temptation 
to use this feature by "ordinary" applications will disappear.

I'm not an expert but I imagine that the CPU usage rates of most RT 
tasks taken over reasonably long time intervals is quite low and 
therefore the default limits could also be quite low without adversely 
effecting the programs that this mechanism is meant to help.

The sched_cpustats.[ch] files that are part of my SPA scheduler patches 
provide a cheap method of estimating per task usage rates.  They 
estimate usage rates for a task over its recent scheduling cycles but 
could be modified to provide updates every tick for the currently active 
task for use with this mechanism.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
