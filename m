Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbUKPV3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbUKPV3x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 16:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbUKPV3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 16:29:53 -0500
Received: from mx1.elte.hu ([157.181.1.137]:62867 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261823AbUKPV3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 16:29:43 -0500
Date: Tue, 16 Nov 2004 23:31:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: "K.R. Foley" <kr@cybsft.com>, Mark_H_Johnson@raytheon.com,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Stefan Schweizer <sschweizer@gmail.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
Message-ID: <20041116223135.GA27250@elte.hu>
References: <OFE5FC77BB.DA8F1FAE-ON86256F4E.0058C5CF-86256F4E.0058C604@raytheon.com> <20041116184315.GA5492@elte.hu> <419A5A53.6050100@cybsft.com> <20041116212401.GA16845@elte.hu> <20041116222039.662f41ac@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116222039.662f41ac@mango.fruits.de>
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

> I have not yet tried to get this kernel to lock up yet, but i made
> another interesting observation:
> 
> irq 8 at prio 98 (only irq 1 with higher prio 99). running rtc_wakeup
> in the console (it runs SCHED_FIFO allright). Switching consoles
> (different text consoles - not swithcing to X, though this basically
> produces similar results) produces large jitters (around 1 ms) and
> occasional missed irq's and piggy messages. This is completely
> reproducable here. The rtc histogram doesn't show any large wakeup
> latencies.

interesting, i'll try to reproduce this.

btw., for best rtc_wakeup results you should chrt IRQ#0 to prio 99 too,
because it uses rtc_lock, otherwise it's an extra PI pass to undo the
lock inversion, which adds another 10 usecs or so to the worst-case
path.

and i'd suggest to chrt irq 1 back to below prio 90, maybe this explains
the console-switching latency? If you do a console-switch via the
keyboard then its priority 99 can get inherited by events/0 which then
does the quite expensive VGA console clearing/copying with priority 99,
possibly delaying rtc_wakeup quite significantly, easily for a
millisecond or so. So what you are seeing might be priority inheritance
handling at work!

> I sometimes do get large values in /proc/latency_trace, but they seem
> to be unrelated to the console switching.

could you post such a large latency trace? Are they like the bad traces
Mark is occasionally seeing, with some ridiculously large latency and a
ridiculously short execution trace?

	Ingo
