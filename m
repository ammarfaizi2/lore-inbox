Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269786AbUJVGhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269786AbUJVGhR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 02:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267808AbUJVGdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 02:33:39 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52612 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269854AbUJSQz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:55:28 -0400
Date: Tue, 19 Oct 2004 18:56:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
Message-ID: <20041019165646.GA14053@elte.hu>
References: <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019144642.GA6512@elte.hu> <28172.195.245.190.93.1098199429.squirrel@195.245.190.93> <20041019185016.2af4fa86@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041019185016.2af4fa86@mango.fruits.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> I don't get any oopses or panics, but i can observer a rather
> interesting behaviour. When i enable the latency traces via
> 
> echo 1 > /proc/sys/kernel/trace_enabled
> 
> my machine starts to make little pauses of ca 3-4 secs. X "hangs" for
> this duration and so does aplay when playing a .wav file. "hangs"
> means that the X display seems to be locked. Interestingly enough all
> keystrokes i entered during the "hang" seem to arrive fine after the
> hang has ended. aplay experiences an xrun.

do you get the same pauses if you do 'dmesg -n 1'? Also, are you using
preempt_thresh or the maximum-searching variant? preempt_thresh can
generate _tons_ of messages with a low threshold, freezing the system in
essence for long periods of time.

but this trace is weird:

> preemption latency trace v1.0.7 on 2.6.9-rc4-mm1-RT-U6
> -------------------------------------------------------
>  latency: 1841 us, entries: 4000 (12990)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:1]
>     -----------------
>     | task: aplay/2160, uid:1000 nice:0 policy:0 rt_prio:0
>     -----------------
>  => started at: __schedule+0x3b/0x5d0 <c02a767b>
>  => ended at:   finish_task_switch+0x43/0xb0 <c0114ae3>
> =======>
> 00000001 0.000ms (+0.000ms): __schedule (ksoftirqd)
> 00000001 0.000ms (+0.000ms): sched_clock (__schedule)
> 00000002 0.000ms (+0.000ms): deactivate_task (__schedule)
> 00000002 0.000ms (+0.000ms): dequeue_task (deactivate_task)
> 04000002 0.000ms (+0.000ms): __switch_to (__schedule)
> 04000002 0.001ms (+0.000ms): finish_task_switch (__schedule)
> 04000000 0.001ms (+0.000ms): schedule (down_write)
> 04000000 0.001ms (+0.000ms): __schedule (down_write)
> 04000001 0.001ms (+0.000ms): sched_clock (__schedule)
> 04000000 0.001ms (+0.000ms): schedule (down_write)
> 04000000 0.001ms (+0.000ms): __schedule (down_write)
> 04000001 0.002ms (+0.000ms): sched_clock (__schedule)
> 04000000 0.002ms (+0.000ms): schedule (down_write)

this doesnt seem like normal behavior. It seems two tasks are
ping-pong-ing a semaphore but are unable to make any progress. The whole
thing is non-preemptible because this semaphore was taken while in a 
PREEMPT_ACTIVE section.

(i'd say this is the BKL semaphore - it is quite special in that
regard.)

	Ingo
