Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWI0OB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWI0OB5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 10:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWI0OB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 10:01:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5027 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932185AbWI0OB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 10:01:56 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <billh@gnuppy.monkey.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re: 2.6.18-rt1]
References: <20060920141907.GA30765@elte.hu>
	<20060921065624.GA9841@gnuppy.monkey.org>
	<m1irjaqaqa.fsf@ebiederm.dsl.xmission.com>
	<20060927050856.GA16140@gnuppy.monkey.org>
	<m11wpxrgnm.fsf@ebiederm.dsl.xmission.com>
	<20060927063415.GB16140@gnuppy.monkey.org>
	<m1d59hpy1j.fsf@ebiederm.dsl.xmission.com>
	<20060927090149.GB16938@elte.hu>
Date: Wed, 27 Sep 2006 07:59:59 -0600
In-Reply-To: <20060927090149.GB16938@elte.hu> (Ingo Molnar's message of "Wed,
	27 Sep 2006 11:01:49 +0200")
Message-ID: <m1lko5o1eo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>> Yes I am.  The motivator would be the RT work but I don't see a reason 
>> why the it couldn't be put in the mainline kernel.  If not at least we 
>> need the big fat comment in the mainline kernel that says 
>> put_task_struct must be safe to call with interrupts disabled.
>> 
>> The way the code is structured now it deviates from the mainline 
>> kernel in more than just changing locking behavior.  Which is what 
>> brought me into this conversation in the first place.  So removing 
>> that point of discord would be good.
>
> well, this is one of those few cases (out of ~50,000 lock uses in the 
> kernel) where such a change was unavoidable: put_task_struct() is used 
> in the scheduler context-switch path. (see sched.c:finish_task_switch())

I had missed that was in a preempt disable path when I skimmed through
the users.

> So that's why i first turned it into a separate, extra delayed-free via 
> the "desched thread", and later on picked up the RCUification from Paul 
> McKenney. The RCUification was the simpler (and hence easier to 
> maintain) change. There is no problem with putting this into the RCU 
> path on PREEMPT_RT, as this is a resource-freeing act. I.e. whatever 
> 'delay' there might be in RCU processing, it does not impact program 
> logic. I agree with you that on !PREEMPT_RT there's no reason to 
> complicate things with an extra layer of indirection.

I'm still wondering if we can move put_task_struct a little lower in
the logic in the places where it is called, so it isn't called under a
lock, or with preemption disabled.  The only downside I see is that it
might convolute the logic into unreadability.

In general I get nervous about calling big functions while holding locks.

Eric
