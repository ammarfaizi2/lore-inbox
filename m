Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbUCMB5b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 20:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbUCMB5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 20:57:31 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:14288 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S262987AbUCMB5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 20:57:02 -0500
Date: Fri, 12 Mar 2004 10:50:33 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Rik Faith <faith@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Light-weight Auditing Framework
Message-ID: <20040312185033.GA2507@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <16464.30442.852919.24605@neuro.alephnull.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16464.30442.852919.24605@neuro.alephnull.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 09:25:46AM -0500, Rik Faith wrote:
> Below is a patch against 2.6.4 that provides a low-overhead system-call
> auditing framework for Linux that is usable by LSM components (e.g.,
> SELinux).  This is an update of the patch discussed in this thread:
>     http://marc.theaimsgroup.com/?t=107815888100001&r=1&w=2

[ . . . ]

Great application of RCU -- audit rules should not change
often, but could be referenced quite frequently!

A couple of comments:

o	I don't see any rcu_read_lock() or rcu_read_unlock() calls.
	These are needed on the read side in order to (1) let the
	people reading the code know the extent of the read-side
	critical section and (2) disable preemption in CONFIG_PREEMPT
	kernels.  Without the former, someone will end up putting
	a blocking primitive in the wrong place.  Without the latter,
	the kernel will do the dirty work all by itself.  Either way,
	you get breakage.

	For example, I suspect that audit_filter_task() needs to
	read as follows:

static enum audit_state audit_filter_task(struct task_struct *tsk)
{
	struct audit_entry *e; 
	enum audit_state   state;

	rcu_read_lock();
	list_for_each_entry_rcu(e, &audit_tsklist, list) {
		if (audit_filter_rules(tsk, &e->rule, NULL, &state)) {
			rcu_read_unlock();
			return state;
		}
	}
	rcu_read_unlock();
	return AUDIT_BUILD_CONTEXT;
}

	Alternatively, you could put the rcu_read_lock() and
	rcu_read_unlock() around the single call to audit_filter_task()
	from audit_alloc().

	All of the list_for_each_.*_rcu() macros need to be enclosed
	by rcu_read_lock() and rcu_read_unlock() calls.

o	Presumably something surrounding netlink_kernel_create()
	ensures that only one instance of audit_del_rule() will
	be executing at a given time.  If not, some locking is
	needed.

	Once this locking is present, the list_for_each_entry_rcu()
	in audit_del_rule() should be changed to list_for_each_entry(),
	as it cannot race with deletion, since it -is- deletion.
	The list_del_rcu() is correct, and should remain.

	If you are using some sort of implicit locking, then please
	inject a clue...

o	The audit_add_rule() function also needs something to prevent
	races with other audit_add_rule() and audit_del_rule()
	instances.  Again, this might be happening somehow in
	the netlink_kernel_create() mechanism, but I don't
	immediately see it.  Then again, I do not claim to fully
	understand how the netlink_kernel_create() mechanism
	functions.

Again, looks like a promising application of RCU!

						Thanx, Paul
