Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbVJ1Ohk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbVJ1Ohk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbVJ1Ohk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:37:40 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:27824 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030196AbVJ1Ohj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:37:39 -0400
Date: Fri, 28 Oct 2005 16:37:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: better wake-balancing: respin
Message-ID: <20051028143750.GA1806@elte.hu>
References: <200510270124.j9R1OPg27107@unix-os.sc.intel.com> <4361EC95.5040800@yahoo.com.au> <20051028100806.GA19507@elte.hu> <43620583.9080500@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43620583.9080500@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Ingo, I wasn't aware that tasks are bouncing around wildly; does your 
> patch improve things? Then by definition it must penalise workloads 
> where the pairings are more predictable?

for TPC, most of the non-to-idle migrations are 'wrong'. So basically 
any change that gets rid of extra migrations is a win. This does not 
mean that it is all bouncing madly.

> I would prefer to try fixing wake balancing before giving up and 
> turning it off for busy CPUs.

agreed, and that was my suggestion: improve the heuristics to not hurt 
workloads where there is no natural pairing.

one possible way would be to do a task_hot() check in the passive 
balancing code, and only migrate the task when it's been inactive for a 
long time: that should be the case for most TPC wakeups. (This assumes 
an accurate cache-hot estimator, for which another patch exists.)

> Without any form of wake balancing, then a multiprocessor system will 
> tend to have a completely random distribution of tasks over CPUs over 
> time. I prefer to add a driver so it is not completely random for 
> amenable workloads.

but my patch does not do 'no form of wake balancing'. It will do 
non-load-related wake balancing if the target CPU is idle. Arguably, 
that can easily be 'never' under common workloads.

	Ingo
