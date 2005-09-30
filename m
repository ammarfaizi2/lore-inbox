Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbVI3BqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbVI3BqE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 21:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbVI3BqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 21:46:04 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:39813 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751380AbVI3BqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 21:46:03 -0400
Date: Thu, 29 Sep 2005 18:46:36 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: George Anzinger <george@mvista.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Steven Rostedt <rostdt@goodmis.org>,
       Jeff Dike <jdike@addtoit.com>
Subject: Re: 2.6.13-rc6-rt9
Message-ID: <20050930014636.GV8177@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050818060126.GA13152@elte.hu> <1124470574.17311.4.camel@twins> <1124476205.17311.8.camel@twins> <20050819184334.GG1298@us.ibm.com> <1124566045.17311.11.camel@twins> <20050820212446.GA9822@ccure.user-mode-linux.org> <1127980463.14695.6.camel@twins> <20050930010041.GS8177@us.ibm.com> <1128042449.15115.375.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128042449.15115.375.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 03:07:29AM +0200, Thomas Gleixner wrote:
> On Thu, 2005-09-29 at 18:00 -0700, Paul E. McKenney wrote:
> > > Even with a current -rt (2.6.14-rc2-rt5) UML does not run. The issue is
> > > indeed (as jeff pointed out) that VTALRM is never send. The small test
> > > programm below illustrates this.
> > > 
> > > On a non-rt kernel it completed in 1 second.
> > > On a -rt kernel it waits at infinitum.
> > 
> > Will play with it and see what I broke...
> 
> Paul, 
> 
> you are not the culprit :)

Woo-hoo!!!  Exonerated!!!  This time, anyway...  ;-)

> The run_posix_cpu_timers(p) call is #ifdef'd out with PREEMPT_RT. 
> 
> Thats a hard to fix issue. 
> 
> It can not be run from hardirq context, as it takes a lot of locks
> (especially our favorites: tasklist_lock and sighand->siglock). :(
> 
> Maybe another playground for rcu, but it might also be solved by some
> other mechanism for accounting and delayed execution in the PREEMPT_RT
> case.

Certainly check_thread_timers() and check_process_timers() are playing
with a number of task_struct fields, so it is not immediately clear
to me how to safely replace tasklist_lock with RCU, at least not with
a simple and small patch.

What did you have in mind for delayed execution?

							Thanx, Paul
