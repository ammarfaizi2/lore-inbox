Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbULIJDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbULIJDu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 04:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbULIJDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 04:03:50 -0500
Received: from mx2.elte.hu ([157.181.151.9]:17301 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261456AbULIJDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 04:03:43 -0500
Date: Thu, 9 Dec 2004 10:02:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Message-ID: <20041209090250.GA14516@elte.hu>
References: <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <41B6839B.4090403@cybsft.com> <20041208083447.GB7720@elte.hu> <41B726D1.6030009@cybsft.com> <1102522720.30593.3.camel@krustophenia.net> <41B7314E.1050904@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B7314E.1050904@cybsft.com>
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

> [...] it looks to me like the whole scheduler is built on the premise
> of allowing RT tasks to be just like other tasks with a few
> exceptions, one of which is that RT tasks never hit the expired task
> array.

this is more or less correct, and we are trying to keep RT scheduling
'integrated' into the SCHED_NORMAL scheduler as long as it's practical.

but Lee is correct too in that the scheduling behavior of RT tasks and
SCHED_NORMAL tasks is completely different. But on the implementational
level the distinction is less stark and boils down to a few branches
here and there, while 90% of the scheduling code is shared.

to answer your question: it is true that if there is an RT task active
then we never switch the arrays. That's how RT tasks work: they run
until they want. That's why it needs privileges to use RT scheduling,
and that's why a buggy RT task can lock up the system. The 'array
switching' mechanism is part of the 10% of code that is only used by
non-RT tasks. SCHED_FIFO tasks dont have any timeslices, they run until
they deschedule voluntarily. SCHED_RR tasks have a notion of timeslices
but they only yield to RR tasks on their own priority level, which is
implemented without an array-switch. [the array-switch implements fair
scheduling between different-priority SCHED_NORMAL tasks - this is a
fundamentally harder problem which necessiates more work from the
scheduler.]

(btw., the 'global RT balancing' SMP code i recently added, and the
priority inheritance scheduler code increases the 10% of non-shared
scheduling code to perhaps 15% or so. Not always is it possible to share
code.)

	Ingo
