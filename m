Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965326AbWI0FJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965326AbWI0FJg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 01:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965327AbWI0FJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 01:09:36 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:12185
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S965326AbWI0FJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 01:09:35 -0400
Date: Tue, 26 Sep 2006 22:08:56 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re: 2.6.18-rt1]
Message-ID: <20060927050856.GA16140@gnuppy.monkey.org>
References: <20060920141907.GA30765@elte.hu> <20060921065624.GA9841@gnuppy.monkey.org> <m1irjaqaqa.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1irjaqaqa.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 08:55:41PM -0600, Eric W. Biederman wrote:
> Bill Huey (hui) <billh@gnuppy.monkey.org> writes:
> > This patch moves put_task_struct() reaping into a thread instead of an
> > RCU callback function as discussed with Esben publically and Ingo privately:
> 
> Stupid question.

It's a great question actually.

> Why does the rt tree make all calls to put_task_struct an rcu action?
> We only need the rcu callback from kernel/exit.c

Because the conversion of memory allocation routines like kmalloc and kfree aren't
safely callable within a preempt_disable critical section since they were incompletely
converted in the -rt. It can run into the sleeping in atomic scenario which can result
in a deadlock since those routines use blocking locks internally in the implementation
now as a result of the spinlock_t conversion to blocking locks.
 
> Nothing else needs those semantics.

Right, blame it on the incomplete conversion of the kmalloc and friends. GFP_ATOMIC is
is kind of meaningless in the -rt tree and it might be a good thing to add something
like GFP_RT_ATOMIC for cases like this to be handled properly and restore that particular
semantic in a more meaningful way.
 
> I agree that put_task_struct is the most common point so this is unlikely
> to remove your issues with rcu callbacks but it just seems completely backwards
> to increase the number of rcu callbacks in the rt tree.

I'm not sure what mean here, but if you mean that you don't like the RCU API abuse then
I agree with you on that. However, Ingo disagrees and I'm not going to argue it with him.
Although, I'm not going stop you if you do. :)

bill

