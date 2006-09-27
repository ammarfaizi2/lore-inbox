Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWI0JJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWI0JJr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 05:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWI0JJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 05:09:47 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:65185 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751064AbWI0JJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 05:09:45 -0400
Date: Wed, 27 Sep 2006 11:01:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Bill Huey <billh@gnuppy.monkey.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re: 2.6.18-rt1]
Message-ID: <20060927090149.GB16938@elte.hu>
References: <20060920141907.GA30765@elte.hu> <20060921065624.GA9841@gnuppy.monkey.org> <m1irjaqaqa.fsf@ebiederm.dsl.xmission.com> <20060927050856.GA16140@gnuppy.monkey.org> <m11wpxrgnm.fsf@ebiederm.dsl.xmission.com> <20060927063415.GB16140@gnuppy.monkey.org> <m1d59hpy1j.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1d59hpy1j.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric W. Biederman <ebiederm@xmission.com> wrote:

> Yes I am.  The motivator would be the RT work but I don't see a reason 
> why the it couldn't be put in the mainline kernel.  If not at least we 
> need the big fat comment in the mainline kernel that says 
> put_task_struct must be safe to call with interrupts disabled.
> 
> The way the code is structured now it deviates from the mainline 
> kernel in more than just changing locking behavior.  Which is what 
> brought me into this conversation in the first place.  So removing 
> that point of discord would be good.

well, this is one of those few cases (out of ~50,000 lock uses in the 
kernel) where such a change was unavoidable: put_task_struct() is used 
in the scheduler context-switch path. (see sched.c:finish_task_switch())

So that's why i first turned it into a separate, extra delayed-free via 
the "desched thread", and later on picked up the RCUification from Paul 
McKenney. The RCUification was the simpler (and hence easier to 
maintain) change. There is no problem with putting this into the RCU 
path on PREEMPT_RT, as this is a resource-freeing act. I.e. whatever 
'delay' there might be in RCU processing, it does not impact program 
logic. I agree with you that on !PREEMPT_RT there's no reason to 
complicate things with an extra layer of indirection.

	Ingo
