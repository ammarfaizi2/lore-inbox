Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVCRLi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVCRLi1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 06:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVCRLi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 06:38:27 -0500
Received: from mx2.elte.hu ([157.181.151.9]:31920 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261583AbVCRLiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 06:38:24 -0500
Date: Fri, 18 Mar 2005 12:38:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: dipankar@in.ibm.com, shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050318113811.GA18997@elte.hu>
References: <20050318002026.GA2693@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318002026.GA2693@us.ibm.com>
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


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> 5. Scalability -and- Realtime Response.
> 
> The trick here is to keep track of the CPU that did the
> rcu_read_lock() in the task structure.  If there is a preemption,
> there will be some slight inefficiency, but the correct lock will be
> released, preserving correctness.

the inefficiency will be larger, because (as explained in a previous
mail) multiple concurrent owners of the read-lock are not allowed. This
adds to the overhead of PREEMPT_RT on SMP, but is an intentional
tradeoff. I dont expect PREEMPT_RT to be used on an Altix :-|

#5 is still the best option, because in the normal 'infrequent
preemption' case it will behave in a cache-friendly way. A positive
effect of the lock serializing is that the callback backlog will stay
relatively small and that the RCU backlog processing can be made
deterministic as well (if needed), by making the backlog processing
thread(s) SCHED_FIFO.

	Ingo
