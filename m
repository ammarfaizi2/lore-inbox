Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWI0QRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWI0QRz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 12:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWI0QRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 12:17:54 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:42648 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751190AbWI0QRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 12:17:53 -0400
Date: Wed, 27 Sep 2006 09:18:47 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Bill Huey <billh@gnuppy.monkey.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re: 2.6.18-rt1]
Message-ID: <20060927161847.GB1291@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060920141907.GA30765@elte.hu> <20060921065624.GA9841@gnuppy.monkey.org> <m1irjaqaqa.fsf@ebiederm.dsl.xmission.com> <20060927050856.GA16140@gnuppy.monkey.org> <m11wpxrgnm.fsf@ebiederm.dsl.xmission.com> <20060927063415.GB16140@gnuppy.monkey.org> <m1d59hpy1j.fsf@ebiederm.dsl.xmission.com> <20060927090149.GB16938@elte.hu> <m1lko5o1eo.fsf@ebiederm.dsl.xmission.com> <20060927140659.GA31025@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060927140659.GA31025@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 04:06:59PM +0200, Ingo Molnar wrote:
> 
> * Eric W. Biederman <ebiederm@xmission.com> wrote:
> 
> > I'm still wondering if we can move put_task_struct a little lower in 
> > the logic in the places where it is called, so it isn't called under a 
> > lock, or with preemption disabled.  The only downside I see is that it 
> > might convolute the logic into unreadability.
> 
> well it's all a function of the task reaping logic: right now we in 
> essence complete the reaping from the scheduler, via prev_state == 
> TASK_DEAD. We cannot do it sooner because the task is still in use. I 
> had one other implementation upstream some time ago, which was a 
> single-slot cache for reaped tasks - but that uglified other codepaths 
> because _something_ has to notice that the task has been unscheduled.

I believe that we are way too far into the task-teardown process for
something like synchronize_rcu() to be feasible (not enough of the
task left to be able to sleep!), but thought I should bring up the
possibility on the off-chance that it caused someone to come up with a
better approach.

Another possible approach would be workqueues.  The disadvantages here are
(1) higher overhead (2) workqueues can be delayed for a -long- time in a
realtime environment, which increases vulnerability to memory exhaustion.

Again, hoping this provokes some better ideas...

							Thanx, Paul
