Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbULIWIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbULIWIh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 17:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbULIWIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 17:08:36 -0500
Received: from mx2.elte.hu ([157.181.151.9]:4276 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261651AbULIWGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 17:06:46 -0500
Date: Thu, 9 Dec 2004 23:06:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Mark_H_Johnson@raytheon.com, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Message-ID: <20041209220632.GE14194@elte.hu>
References: <OFADAD8EC1.8BCE1EC6-ON86256F65.005EFFA6@raytheon.com> <20041209173136.GE7975@elte.hu> <41B8B6C4.60200@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B8B6C4.60200@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> running realfeel with rtc histogram generates > 100 usec entries in
> the histogram but none of these are ever caught by the wakeup tracing.

can you reproduce this with rtc_wakeup:

  http://www.affenbande.org/~tapas/wiki/index.php?rtc_wakeup

?

> I think I know why we don't get traces from this. TIF_NEED_RESCHED is
> not set for IRQ 8 at the time that it wakes up realfeel so
> _need_resched fails and trace_start_sched_wakeup doesn't actually call
> __trace_start_sched_wakeup(p)???

here's the code:

+static inline void trace_start_sched_wakeup(task_t *p, runqueue_t *rq)
+{
+       if (TASK_PREEMPTS_CURR(p, rq) && (p != rq->curr) && _need_resched())
+               __trace_start_sched_wakeup(p);
+}

indeed this only triggers if the woken up task has a higher priority
than the waker... hm. Could you try to reverse the priorities of 
realfeel and IRQ8, does that produce traces?

	Ingo
