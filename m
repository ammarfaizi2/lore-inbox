Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264121AbUKZVKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264121AbUKZVKF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264122AbUKZVGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 16:06:07 -0500
Received: from mx1.elte.hu ([157.181.1.137]:6077 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264126AbUKZVFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 16:05:17 -0500
Date: Fri, 26 Nov 2004 22:05:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
Message-ID: <20041126210501.GA23381@elte.hu>
References: <20041126010841.GA3563@elte.hu> <Pine.OSF.4.05.10411261649150.23754-100000@da410.ifa.au.dk> <20041126204138.GB21180@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041126204138.GB21180@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> it can produce such a flow on SMP, or if you add in a third non-RT
> task (task-C). Agreed?

here's the 4-task flow. I've simplified the operations to make it easier
to overview: "L1-success means" 'task locked lock1 and got it'. 
"L1-wait" means it tried to get lock1 but has to wait. "RT-prio" means a
non-RT task got boosted to RT priority. "old-prio" means priority got
restored to the original non-RT value. "UL-1" means 'unlocked lock1'.

	task-A		task-B		task-C		task-RT
	-------------------------------------------------------
	L2-success
			L1-success
					L1-wait
					.		L2-wait
					.		boost-A
	RT-prio				.		.
	L1-wait				.		.
	boost-B				.		.
	.		RT-prio		.		.
	.		[ 1 ms ]	.		.
	.		UL-1		.		.
	.		!RT-prio	.		.
	get-L1				.		.
	[ 1 ms ]			.		.
	UL-1				.		.
					get-L1		.
	UL-2						.
	old-prio					.
							get-L2
							L1-wait
							boost-C
					RT-prio		.
					[ 1 msec ]	.
					UL-1		.
					old-prio	.
							get-L1
							[ success ]

this is a 3 milliseconds worst-case. Ok?

	Ingo
