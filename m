Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbUKWKqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbUKWKqE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 05:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbUKWKqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 05:46:04 -0500
Received: from mx1.elte.hu ([157.181.1.137]:1171 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262448AbUKWKon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 05:44:43 -0500
Date: Tue, 23 Nov 2004 12:46:39 +0100
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
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
Message-ID: <20041123114639.GA23730@elte.hu>
References: <OF73D7316A.42DF9BE5-ON86256F54.0057B6DC@raytheon.com> <20041122221224.GA13799@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122221224.GA13799@elte.hu>
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

> * Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:
> 
> >  - echo 0 > /proc/sys/kernel/preempt_wakeup_timing [entered, but
> > display was frozen at this point and did not see newline nor any
> > further output]
> 
> managed to reproduce this on an SMP box but not on an UP box, so i
> think this is SMP related. It definitely happens almost immediately
> after preempt_wakeup_timing is reset - or after preempt_max_timing is
> reset.  (Perhaps a dump_stack() from the wrong place, or something
> like that.)

The lockup was caused by the mutex wakeup being done under the PI lock,
and if a new critical-section latency is reported within try_to_wake_up
then the trylock done there deadlocked. The NMI watchdog triggered but
the printks done there deadlocked as well.

I fixed both the deadlock scenario, and made the NMI printout path more
robust to get the messages out to the console in even such a case. 

The fixes are in the latest (-30-4) patch which can be found at the
usual place:

  http://redhat.com/~mingo/realtime-preempt/  

	Ingo
