Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030410AbWBQOq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbWBQOq4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 09:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbWBQOq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 09:46:56 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:34259 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030410AbWBQOqz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 09:46:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dtRJatdkfL46CVmjBbtDA/BRy1/Q1Bx/A9IBkt+0mUvKhB4l47ZVfDWcSEwzoGkpzH+rZpZzzSADA7SwF4/MoxDNs+eTWPMf02cBduXadiu46q8rybSi1+JBTmDg7WBiy/20q1tor+ycb7UjQhE411+K2eZxRtD2jybHhgOk74M=
Message-ID: <58cb370e0602170646h3d0cddo8b042eab251d9365@mail.gmail.com>
Date: Fri, 17 Feb 2006 15:46:53 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [patch] timer-irq-driven soft-watchdog, cleanups
Cc: "Andrew Morton" <akpm@osdl.org>, ce@ruault.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060217130801.GA16115@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43EF8388.10202@ruault.com> <20060215185120.6c35eca2.akpm@osdl.org>
	 <58cb370e0602160533n3325ba03yfedaf4e55278521d@mail.gmail.com>
	 <20060216122045.7a664bc6.akpm@osdl.org>
	 <58cb370e0602170347qeddb390u680895fd2f0aab7d@mail.gmail.com>
	 <20060217130801.GA16115@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
>
> > I'm still not 100% sure if it was false positive - it looked like from
> > the trace but I find it hard to believe that users wouldn't complain
> > about 10sec stalls [ Soft lockup detector claims to trigger if after
> > 10sec it hasn't been touched - is it really working as advertised?
> > How can we verify this? ].
>
> the watchdog is quite simple: it consists of per-CPU SCHED_FIFO prio 99
> [i.e. highest RT priority] threads that do nothing but:
>
>         while (!kthread_should_stop()) {
>                 msleep_interruptible(1000);
>                 touch_softlockup_watchdog();
>         }
>
> i can think of only one (pretty theoretical) scenario for a false
> positive here: msleep uses timers, which are processed by softirq
> context, which context itself might be delayed. Under extreme load, if
> softirqs get delayed for more than 9 seconds, this _might_ lead to false
> positives. But that i think is highly unlikely in the reported IDE
> cases.

Actually it seems very likely [ if I'm reading the code right ]: ide_intr()
IRQ handler contains "optimization" that it calls ide_do_request() for
the next request if the previous request is completed.  Processing the
next request involves waiting for device to become ready (up to 5sec)
and sending first chunk of data out in case of PIO-out protocol.
Moreover if the requests are short we can be hitting "optimization"
case few times in the row.  Hard IRQs will still have their chance to be
processed but softirq context can be delayed quite a lot as it is executed
after hard IRQ handler completes.

> in any case, the patch below gets rid of the softirq involvement, and
> makes the soft-watchdog purely timer-irq driven (and a few minor
> cleanups). Could you try it? I have tested it - it correctly detected a
> 11-seconds delay and stayed silent during a 9-seconds delay.
>
> If you still get warnings even with this patch applied, then my very
> strong suspicion is that the 10+ seconds delays in the IDE code are
> real, and not false-positives. If there are such places then the minimum
> we should do is to document them via touch_softlockup_watchdog() ...
> even if you "knew" about such places already.

Fully agreed, where is the patch?

Sorry but I have enough more high priority issues to take care of and
I'm not going to spend any more time on soft lockups even if they are
really problems in IDE subsystem.  If this is not fixed before 2.6.16
I'm submitting patch to Linus making DETECT_SOFTLOCKUP depend
on "CONFIG_IDE=n"... at least users will be able to use their systems
instead of seeing lockups.

DETECT_SOFTLOCKUP should be an aim in development not a
method of forcing driver maintainers to work on specific issues...

Thank you for understanding.

Bartlomiej
