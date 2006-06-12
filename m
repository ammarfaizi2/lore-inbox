Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWFLJVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWFLJVS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 05:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWFLJVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 05:21:18 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:45268 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751263AbWFLJVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 05:21:17 -0400
Date: Mon, 12 Jun 2006 11:20:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.17-rc6-rt3
Message-ID: <20060612092023.GA30872@elte.hu>
References: <20060610082406.GA31985@elte.hu> <1150104040.3835.3.camel@frecb000686>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1150104040.3835.3.camel@frecb000686>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5137]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sébastien Dugué <sebastien.dugue@bull.net> wrote:

> > I think all of the regressions reported against rt1 are fixed, please 
> > re-report if any of them is still unfixed.
> 
>   Great, boots fine on my dual Xeon and solves the ping problem I was 
> having.
> 
>   Thomas, any hint at what was going on?

the problem was caused by a mismerge of the __raise_softirq_irqoff() 
changes of preempt-softirqs. In PREEMPT_SOFTIRQS, softirq activation 
means a wakeup of the softirq thread - hence __raise_softirq_irqoff() 
must wake up the softirq thead too. This didnt happen in -rt1 so the 
network softirq (which processes things like ping reply packets) got 
delayed to the natural softirq event - the next timer interrupt in the 
usual case. Hence depending on HZ you got a delay of 1-4-10 msecs 
(divided into two parts).

	Ingo
