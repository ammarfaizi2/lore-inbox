Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbULJVmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbULJVmp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 16:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbULJVmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 16:42:44 -0500
Received: from mx2.elte.hu ([157.181.151.9]:43740 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261824AbULJVlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 16:41:10 -0500
Date: Fri, 10 Dec 2004 22:40:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15
Message-ID: <20041210214033.GG5864@elte.hu>
References: <OFDDE2143E.7CA72E68-ON86256F66.0073F88B-86256F66.0073F8B7@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OFDDE2143E.7CA72E68-ON86256F66.0073F88B-86256F66.0073F8B7@raytheon.com>
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


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> Comparison of .32-18RT and .32-18PK results
> RT has PREEMPT_RT,
> PK has PREEMPT_DESKTOP and no threaded IRQ's.
> 2.4 has lowlat + preempt patches applied
> 
>       within 100 usec
>        CPU loop (%)   Elapsed Time (sec)    2.4
> Test   RT     PK        RT      PK   |   CPU  Elapsed
> X     90.40 100.00&     73 *    64+  |  97.20   70
> top   78.56 100.00&     39 *    31+  |  97.48   29
> neto  92.82 100.00&    350 *   184+  |  96.23   36
> neti  90.69 100.00&    350 *   170+  |  95.86   41
> diskw 82.96  99.99     360 *    61+  |  77.64   29
> diskc 91.41  99.34     350 *   310+  |  84.12   77
> diskr 88.41  99.96     360 *   310+  |  90.66   86
> total                 1881    1130   |         368
>  [higher is better]  [lower is better]
> * wide variation in audio duration
> + long stretch of audio duration "too fast"
> & 100% to digits shown, had a FEW samples > 100 usec.
> 
> WOW! Look at the 100% values measured on -18PK. The performance of 2.6
> with PREEMPT_DESKTOP is far better than 2.4 preempt+lowlat in every
> way except the non RT starvation problem. Something fixed between -12
> and -18 really made a big improvement.

yep, i guess it's the two missed-preemption points i fixed in -16.

> It is still disturbing to see the worse results for -18RT and I wish I
> knew what the cause was. Perhaps the traces I sent earlier can provide
> a clue.

are you sure you got the order of the columns right? :-|

e.g. the lt004.18PK traces you sent show a number of huge latencies,
biggest one being 1949µs. The biggest one in lt001.18RT is 250 usecs,
and much of that i believe is due to debugging overhead. (It's not
apples to apples because i dont have the RT-under-stress traces yet.) 

something's really not kosher here.

> Other notes:
> 
> [1] -PK has many more latency traces > 250 usec [some MUCH longer]
> than -RT. I ended up collecting more traces for -RT since I set the
> limit to 100 usec, but only got about 8 > 250 usec traces compared to
> 40 for -PK.

this too is suspicious to me. How can then the PREEMPT_RT kernel end up
performing within 100 usecs in only 78.56% of the measurements - it's
ridiculously low! The tracer might have a bug, but such a selective bug?

the only recent thing added was the global RT balancer, which is not
active under PREEMPT_DESKTOP. Maybe this code somehow interferes with
your workload? Could you try to disable it, by changing kernel/sched.c's
#ifdefs from:

 #if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_SMP)

to:

 #if 0

(there are ~5 such places in sched.c)

	Ingo
