Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270680AbUJUO1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270680AbUJUO1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 10:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUJUOXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 10:23:52 -0400
Received: from mx2.elte.hu ([157.181.151.9]:32470 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S270693AbUJUOUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 10:20:55 -0400
Date: Thu, 21 Oct 2004 16:22:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021142215.GA3972@elte.hu>
References: <OF7C037699.07E90948-ON86256F34.0047151D@raytheon.com> <20041021141439.GB2875@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021141439.GB2875@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> the soundcard IRQ trace you got is interesting:
> 
>  BUG: sleeping function called from invalid context X(2948) at kernel/mutex.c:25 Oct 21 07:53:02 localhost kernel: in_atomic():1 [00010000], irqs_disabled():0
>   [<c011f06a>] __might_sleep+0xca/0xe0 (12)
>   [<c01387e6>] _mutex_lock+0x26/0x50 (36)
>   [<e0a549b6>] snd_audiopci_interrupt+0x46/0xf0 [snd_ens1371] (20)
>   [<c01436f6>] handle_IRQ_event+0x46/0x80 (24)
>   [<c0143837>] __do_IRQ+0x107/0x160 (32)
>   [<c010a299>] do_IRQ+0x59/0x90 (36)
>   [<c0108510>] common_interrupt+0x18/0x20 (20)
>  preempt count: 00010001
> 
> do you have PREEMPT_REALTIME enabled? The above trace is a direct
> interrupt - only the timer interrupt is allowed to execute directly in
> the PREEMPT_REALTIME model - things break badly if it happens for any
> other interrupt (such as the soundcard IRQ).

this also seems to be the major cause of the other problems in your log:
kernel preempting off a hardirq context and then confusing other kernel
code. It's surprising that it booted up at all! Now how did the
soundcard IRQ end up being non-threaded?

	Ingo
