Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVCVLcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVCVLcp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 06:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbVCVL36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 06:29:58 -0500
Received: from mx1.elte.hu ([157.181.1.137]:35256 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262269AbVCVL3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 06:29:12 -0500
Date: Tue, 22 Mar 2005 12:28:56 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>
Subject: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050322112856.GA25129@elte.hu>
References: <20050319191658.GA5921@elte.hu> <20050320174508.GA3902@us.ibm.com> <20050321085332.GA7163@elte.hu> <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu> <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu> <20050322100153.GA23143@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322100153.GA23143@elte.hu>
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

> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > hm, another thing: i think call_rcu() needs to take the read-lock.
> > Right now it assumes that it has the data structure private, but
> > that's only statistically true on PREEMPT_RT: another CPU may have
> > this CPU's RCU control structure in use. So IRQs-off (or preempt-off)
> > is not a guarantee to have the data structure, the read lock has to be
> > taken.
> 
> i've reworked the code to use the read-lock to access the per-CPU data
> RCU structures, and it boots with 2 CPUs and PREEMPT_RT now. The
> -40-05 patch can be downloaded from the usual place:

bah, it's leaking dentries at a massive scale. I'm giving up on this
variant for the time being and have gone towards a much simpler variant,
implemented in the -40-07 patch at:

   http://redhat.com/~mingo/realtime-preempt/

it's along the lines of Esben's patch, but with the conceptual bug fixed
via the rcu_read_lock_nesting code from Paul's patch.

there's a new CONFIG_PREEMPT_RCU option. (always-enabled on PREEMPT_RT)
It builds & boots fine on my 2-way box, doesnt leak dentries and
networking is up and running.

first question, (ignoring the grace priod problem) is this a correct RCU
implementation? The critical scenario is when a task gets migrated to
another CPU, so that current->rcu_data is that of another CPU's. That is
why ->active_readers is an atomic variable now. [ Note that while
->active_readers may be decreased from another CPU, it's always
increased on the current CPU, so when a preemption-off section
determines that a quiescent state has passed that determination stays
true up until it enables preemption again. This is needed for correct
callback processing. ]

this implementation has the 'long grace periods' problem. Starvation
should only be possible if a system has zero idle time for a long period
of time, and even then it needs the permanent starvation of
involuntarily preempted rcu-read-locked tasks. Is there any way to force
such a situation? (which would turn this into a DoS)

[ in OOM situations we could force quiescent state by walking all tasks
and checking for nonzero ->rcu_read_lock_nesting values and priority
boosting affected tasks (to RT prio 99 or RT prio 1), which they'd
automatically drop when they decrease their rcu_read_lock_nesting
counter to zero. ]

	Ingo
