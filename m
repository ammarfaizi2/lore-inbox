Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262813AbVCWGV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbVCWGV6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 01:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbVCWGV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 01:21:57 -0500
Received: from mx1.elte.hu ([157.181.1.137]:31938 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262813AbVCWGVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 01:21:30 -0500
Date: Wed, 23 Mar 2005 07:21:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-01
Message-ID: <20050323062116.GA31626@elte.hu>
References: <20050319191658.GA5921@elte.hu> <20050320174508.GA3902@us.ibm.com> <20050321085332.GA7163@elte.hu> <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu> <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu> <20050323044849.GA1294@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323044849.GA1294@us.ibm.com>
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

> !!!  The difference is that in the stock kernel, rcu_check_callbacks()
> is invoked from irq.  In PREEMPT_RT, it is invoked from process
> context and appears to be preemptible.  This means that
> rcu_advance_callbacks() can be preempted, resulting in all sorts of
> problems.  Need to disable preemption over this.

we can disable preemption in the PREEMPT_RT kernel too, but only for
code we know the maximum execution length of. I.e. we dont want want to
disable preemption while processing the callback _list_, but we can use
preemption-off to protect the per-cpu data structures.

> There are probably other bugs of this sort, I will track them down.
> 
> But, just to make sure I understand -- if I have preempt disabled over
> all accesses to a per-CPU variable, and that variable is -not-
> accessed from a real interrupt handler, then I am safe without a lock,
> right?

correct, assuming that the pointer you get to the per-CPU data is truly
pointing to the current CPU's data. (i.e. the current->rcu_data pointer
approach breaks this assumption.)

	Ingo
