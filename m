Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753255AbWKFQRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbWKFQRQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753309AbWKFQRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:17:16 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:59794 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1753255AbWKFQRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:17:15 -0500
Date: Mon, 6 Nov 2006 08:18:17 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Falk Hueffner <falk@debian.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: ipc/msg.c "cleanup" breaks fakeroot on Alpha
Message-ID: <20061106161817.GA1615@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <87d583f97t.fsf@debian.org> <20061104172954.GA3668@elte.hu> <Pine.LNX.4.64.0611040938490.25218@g5.osdl.org> <87bqnnjd1w.fsf@debian.org> <Pine.LNX.4.64.0611041019180.25218@g5.osdl.org> <454E0B1F.7090106@colorfullife.com> <20061106055745.GA4080@us.ibm.com> <454ED4EA.5070701@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454ED4EA.5070701@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 07:23:38AM +0100, Manfred Spraul wrote:
> Paul E. McKenney wrote:
> 
> >I also don't understand why the code in sys_msgrcv() doesn't have
> >to remap the msqid, similar to the way it is done in sys_semtimedop().
> >
> What do you mean with remap?

What ipc_lock() does, more or less.

> >So, what am I missing here?  How does a msgrcv() racing with an rmid()
> >avoid taking a lock on a message queue that just got freed?  (The
> >ipc_lock_by_ptr() in "Lockless receive, part 3".)  My concern is the
> >following sequence of steps:
> >
> >o	expunge_all() invokes wake_up_process() and sets r_msg.
> >
> >o	sys_msgrcv() is awakened, but for whatever reason does
> >	not actually start executing (e.g., lots of other busy
> >	processes at higher priority).
> >
> >o	expunge_all() returns to freeque(), which runs through the
> >	rest of its processing, finally calling ipc_rcu_putref().
> >
> >o	ipc_rcu_putref() invokes call_rcu() to free the message
> >	queue after a grace period.
> >
> >o	ipc_immediate_free() is invoked at the end of a grace
> >	period, freeing the message queue.
> >
> >o	sys_msgrcv() finally gets a chance to run, and does an
> >	rcu_read_lock() -- but too late!!!
> >
> Not too late:
> sys_msgrcv() checks msr_d.r_msr, notices that the value is -EIDRM and
> returns to user space with -EIDRM immediately. This codepath
> doesn't touch the message queue pointer, thus it doesn't matter that the
> message queue is already freed.
> The code only touches the message queue pointer if msr_d.r_msr
> is -EAGAIN - and the rcu_read_lock() guarantees there is no rcu grace
> period between the test for -EAGAIN and the ipc_lock_by_ptr.
> Thus this should be safe.

OK, seems like it does handle that scenario.  Sorry for the noise!

And the other possible scenario, where the wakeup happens before the
assignment of NULL to msr_d.r_msr, be prevented by the two rounds of
rq lock (one in try_to_wake_up(), the other when the task actually
starts running).

						Thanx, Paul

> But back to the oops:
> The oops happens in expunge_all, called from sys_msgctl.
> Thus it must be an msgctl(IPC_SET).
> IPC_SET is special: it calls expunge_all(-EAGAIN): that's necessary
> because IPC_SET can change the permissions.
> Unfortunately, faked doesn't use IPC_SET at all :-(
> 
> Falk - could you strace your "fakeroot ls" test? Are there any IPC_SET 
> calls?
> Which gcc version do you use? Is it possible that gcc auto-inlined 
> something?
> 
> --
>    Manfred
