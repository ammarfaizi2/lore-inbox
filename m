Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbULOJSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbULOJSX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 04:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbULOJSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 04:18:23 -0500
Received: from mx2.elte.hu ([157.181.151.9]:51383 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262303AbULOJRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 04:17:18 -0500
Date: Wed, 15 Dec 2004 10:17:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@Raytheon.com
Cc: Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
Message-ID: <20041215091703.GD13551@elte.hu>
References: <OF48DAA6CB.4EA3A6BD-ON86256F6A.007B5393@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF48DAA6CB.4EA3A6BD-ON86256F6A.007B5393@raytheon.com>
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


* Mark_H_Johnson@Raytheon.com <Mark_H_Johnson@Raytheon.com> wrote:

> Based on the number of latency_trace files, -00RT still
> is far better than -00PK. In particular, I get some extended
> delays in -00PK from:
>  - network (I have an 2000 usec example!)
>  - rcu_process_callbacks (around 250 usec)
>  - clear_page_range (around 170 usec)
>  - free_pages_and_swap_cache (around 140 usec)
>  - do_no_page (around 170 usec)
>  - ide [IRQ?] (around 200 usec)
>  - journal_remove_journal_head (> 1000 usec)
>  - do_wait / wait_task_zombie (around 200 usec)
> A fix to the network & journaling latencies would be helpful.
> The others are certainly less important. I'll send the traces
> separately.

the network ones are hard to fix, because it's softirq overhead and that
with PK is fundamentally non-preemptable. A good number of attempts to
cut down on the latency paths there resulted in broken networking, so
i'd not try that again.

The fix is softirq threading. Perhaps you could try PK+THREAD_SOFTIRQS
[but keep hardirqs non-threaded] - this would have higher overhead than
PK but lower overhead than full threading of all IRQs. This wont fix the
jfs overhead but that one might be fixable, maybe someone from the FS
land can take a look at the journalling overhead, that is in process
context and should be thus easier to fix.

> Also, if you get some odd trace results on an SMP system, Ingo already
> has some fixes applied in response to some buglets I found & reported
> separately.

yeah - they are in the latest (-33-03) kernel.

	Ingo
