Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267587AbUIBGcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267587AbUIBGcn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 02:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267602AbUIBGcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 02:32:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:40585 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267587AbUIBGcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 02:32:41 -0400
Date: Thu, 2 Sep 2004 08:33:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Message-ID: <20040902063335.GA17657@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com>
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


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> In 2.4, it appears that the duration of the write system call is
> basically fixed and dependent on the duration of the audio fragment.
> In 2.6, this behavior is now different. If I look at the chart in
> detail, it appears the system is queueing up several write operations
> during the first few seconds of testing. You can see this by
> consistently low elapsed times for the write system call. Then the
> elapsed time for the write bounces up / down in a sawtooth pattern
> over a 1 msec range. Could someone explain the cause of this new
> behavior and if there is a setting to restore the old behavior? I am
> concerned that this queueing adds latency to audio operations (when
> trying to synchronize audio with other real time behavior).

i think i found the reason for the sawtooth: it's a bug in hardirq
redirection. In certain situations we can end up not waking up softirqd,
resulting in a random 0-1msec latency between hardirq arrival and
softirq execution. We dont see higher latencies because timer IRQs
always wake up softirqd which hides the bug to a certain degree.

I'll fix this in -Q8.

	Ingo
