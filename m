Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262599AbVCVKCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbVCVKCM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 05:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbVCVKCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 05:02:12 -0500
Received: from mx2.elte.hu ([157.181.151.9]:50908 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262599AbVCVKCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 05:02:00 -0500
Date: Tue, 22 Mar 2005 11:01:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-05
Message-ID: <20050322100153.GA23143@elte.hu>
References: <20050319191658.GA5921@elte.hu> <20050320174508.GA3902@us.ibm.com> <20050321085332.GA7163@elte.hu> <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu> <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322093201.GA21945@elte.hu>
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

> hm, another thing: i think call_rcu() needs to take the read-lock.
> Right now it assumes that it has the data structure private, but
> that's only statistically true on PREEMPT_RT: another CPU may have
> this CPU's RCU control structure in use. So IRQs-off (or preempt-off)
> is not a guarantee to have the data structure, the read lock has to be
> taken.

i've reworked the code to use the read-lock to access the per-CPU data
RCU structures, and it boots with 2 CPUs and PREEMPT_RT now. The -40-05
patch can be downloaded from the usual place:

  http://redhat.com/~mingo/realtime-preempt/

had to add two hacks though:

 static void rcu_advance_callbacks(struct rcu_data *rdp)
 {
        if (rdp->batch != rcu_ctrlblk.batch) {
                if (rdp->donetail) // HACK
                        *rdp->donetail = rdp->waitlist;
		...

 void fastcall call_rcu(struct rcu_head *head,
          void (*func)(struct rcu_head *rcu))
 [...]
        rcu_advance_callbacks(rdp);
        if (rdp->waittail) // HACK
                *rdp->waittail = head;
	...

without them it crashes during bootup.

maybe we are better off with the completely unlocked read path and the
long grace periods.

	Ingo
