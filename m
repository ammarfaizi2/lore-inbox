Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263655AbUKANqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263655AbUKANqr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 08:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbUKANmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 08:42:23 -0500
Received: from mx1.elte.hu ([157.181.1.137]:54401 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262020AbUKANld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 08:41:33 -0500
Date: Mon, 1 Nov 2004 14:42:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Lee Revell <rlrevell@joe-job.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041101134235.GA18009@elte.hu>
References: <1099171567.1424.9.camel@krustophenia.net> <20041030233849.498fbb0f@mango.fruits.de> <20041031120721.GA19450@elte.hu> <20041031124828.GA22008@elte.hu> <1099227269.1459.45.camel@krustophenia.net> <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu> <20041031162059.1a3dd9eb@mango.fruits.de> <20041031165913.2d0ad21e@mango.fruits.de> <20041031200621.212ee044@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031200621.212ee044@mango.fruits.de>
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

> new max. jitter: 4.3% (41 usec)
> new max. jitter: 4.9% (47 usec)

a couple of conceptual questions: why does rtc_wakeup poll() on
/dev/rtc? Shouldnt a read() be enough?

i'm seeing some weird traces, which show rtc_wakeup doing this cycle:

	[~900 usecs pass]

	hardirq 8 comes in, wakes IRQ 8 thread
	IRQ 8 thread wakes up rtc_wakeup

	rtc_wakeup fast-thread returns from sys_read()
	rtc_wakeup fast-thread enters sys_poll() and returns immediately
	rtc_wakeup fast-thread enters sys_read() and blocks

	rtc_wakeup slow-thread runs and does the calculations.

	[repeat]

this i think shows that the logic is wrong somewhere and that read()
will achieve the blocking. This also means that the sys_read()-return +
sys_poll() overhead is added to the 'IRQ wakeup' overhead!

removing the poll() lines doesnt seem to impact the quality of the data,
but i still see roughly 50 usecs added to the 'real' latency that i see
in traces.

	Ingo
