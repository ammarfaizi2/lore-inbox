Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266839AbUJNSuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266839AbUJNSuS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUJNSsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:48:33 -0400
Received: from mx1.elte.hu ([157.181.1.137]:42170 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267251AbUJNSXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:23:17 -0400
Date: Thu, 14 Oct 2004 20:24:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@Raytheon.com
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       Daniel Walker <dwalker@mvista.com>, Bill Huey <bhuey@lnxw.com>,
       Andrew Morton <akpm@osdl.org>, Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
Message-ID: <20041014182438.GA30078@elte.hu>
References: <OF2289D554.769CEFC1-ON86256F2D.005DF70B-86256F2D.005DF791@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF2289D554.769CEFC1-ON86256F2D.005DF70B-86256F2D.005DF791@raytheon.com>
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


* Mark_H_Johnson@Raytheon.com <Mark_H_Johnson@Raytheon.com> wrote:

> Not sure if I can bring this up to multi user yet. Some initial testing
> in single user mode indicates problems when I turn on networking. See
> the attached messages from /var/log/messages to see the kinds of problems
> I am having. The key ones appear after doing
>   ./S10network start
> as part of single stepping the init sequence. I stopped at this point
> to make sure I had a good record of the messages.

could you try to disable SELINUX? It seems it's not fully safe yet.

> A side question - if
>   CONFIG_PREEMPT_REALTIME=y
> you say that IRQ's must be threaded, is this going to be "permanent" and
> if so - why?

in a fully preemptible model all execution must be 'sequential', because
irq threads themselves can schedule too and could be preempted too. The
only way to make 'direct' interrupts possible again would be to disable
interrupts in _all_ non-preemptible sections, which would be quite some
work.

Another reason for the 'linearization' of as much execution as possible
is that such direct interrupts couldnt be preempted (or else you could
reenter them) which is impossible because all locks are mutexes.

a third reason is that nesting 'blocks' any underlying context. So if
task A is interrupted by irq X and schedules away (lets assume this is
safe) - nobody could unwind 'task A' - irq X blocks it until it finishes
execution. With linearlized contexts 'task A' could reschedule on
another CPU - or could get its priority raised with time if an RT
deadline is approaching, etc. It's much more flexible to have everything
flattened out.

this comes at a performance cost - but basically if you implement all
the properties one would expect form such an approach you'd end up with
a completely different irq scheduler - there's no point in that. Best is
to 'merge' all contexts, hardirqs and softirqs into the normal task
concept.

> I would prefer to not use threaded IRQ's if possible due to lower CPU
> overhead [see previous email describing results...] and some problems
> I see with setting priorities on those IRQ's (relative to real time
> tasks).

the overhead we can try to optimize later on. What problems do you see
with setting priorities on those IRQs?

	Ingo
