Return-Path: <linux-kernel-owner+w=401wt.eu-S932668AbWLMSgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668AbWLMSgX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 13:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbWLMSgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 13:36:22 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:45873 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932671AbWLMSgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 13:36:22 -0500
Subject: Re: realtime-preempt and arm
From: Steven Rostedt <rostedt@goodmis.org>
To: tike64 <tike64@yahoo.com>
Cc: junjiec@gmail.com, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <304269.38734.qm@web59207.mail.re1.yahoo.com>
References: <304269.38734.qm@web59207.mail.re1.yahoo.com>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 13:36:00 -0500
Message-Id: <1166034960.1785.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For -rt issues, please CC Ingo Molnar, and for High Res issues, please
CC Thomas Gleixner.


On Fri, 2006-12-01 at 01:07 -0800, tike64 wrote:
> > Hi,
> > 
> > Without the support of High Resolution Timer
> > supported, the timer resolution wouldn't change.
> 
> Ok, I understand that. I was not expecting more
> resolution. I expected only that I would get more
> precise 10ms delays. What confuses me is that the
> delays roughly doubled.
> 
> > With high-resolution-timer supported, our
> > arm926-based board could get resolution like
> 40~50us.
> > There are codes you can reference ,may be you should
> > just try to implement it.
> 
> It is good to know that the problem is not the arm
> architecture itself. Thanks to you for that.
> 
> The problem must be in the lh7a40x specific code or my
> configuration. I am not yet convinced enough that high
> resolution timer implementation would solve the
> problem. I don't need timing resolution finer than
> 10ms providing that FB doesn't blow it up to 60ms.
> 
> Could you or someone please give a hint where to look
> next or give an explanation why the lack of high
> resolution timer would behave like that.

Also, have you tried this with a nanosleep instead of a select.
Select's timeout is just that, a timeout. It's not suppose to be
accurate, as long as it doesn't expire early.  The reason I state this,
is that select uses a different mechanism than nanosleep, and that can
indeed affect the jitter.

Although without the high res enabled, you can't get better than jiffy
resolution, you shouldn't get a large jitter either.  BTW, using high
res won't help the select anyway. The select uses a normal
schedule_timeout, which means that it's not really expected to timeout,
but something should wake it up before hand. Which means that the good
old timer wheel (non-hrtimer) is going to do the waking of the process.
This means that you need to wait for the timer softirq to be scheduled
before your process wakes up. If there's a process with a higher
priority than the timer softirq running, then you need to wait.

Using nansleep uses the hrtimer code (available with out the high
resolutions).  The hrtimer uses its own timer softirq (softirq-hrtimer),
and it is special.  It inherits the priority of the task that created
the timer when the timer goes off.  Also, something like nanosleep,
won't even use the softirq, and will bypass the softirq all together,
and wake your process up from the interrupt.

So basically, don't use select for timing.

-- Steve


