Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266741AbUGUVhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266741AbUGUVhV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 17:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266740AbUGUVhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 17:37:21 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64418 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266743AbUGUVhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 17:37:14 -0400
Date: Wed, 21 Jul 2004 22:40:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Scott Wood <scott@timesys.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040721204036.GA29962@elte.hu>
References: <1089677823.10777.64.camel@mindpipe> <20040712174639.38c7cf48.akpm@osdl.org> <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu> <20040721183213.GB2206@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721183213.GB2206@yoda.timesys>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Scott Wood <scott@timesys.com> wrote:

> On Wed, Jul 21, 2004 at 10:52:46AM +0200, Ingo Molnar wrote:
> > this, if enabled, causes all softirqs to be processed within ksoftirqd,
> > and it also breaks out of the softirq loop if preemption of ksoftirqd
> > has been triggered by a higher-prio task.
> 
> You'll still have the latency of finishing the currently executing
> softirq, which often includes a loop itself (whose break condition is
> based on not hogging the CPU, rather than letting higher priority
> tasks in as soon as possible).

well, i share your desire for lower latencies but this is what the
semantics of softirqs require.

but it's really easy to break out of softirq processing early and
restart it later. All it needs in net_rx_action() is to:

	if (softirq_defer && need_resched())
		goto softnet_break;

since the network softirq code is already latency-aware. The same
'lock-break'-alike methods can be used for other softirq code too.

	Ingo
