Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268767AbUIGXeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268767AbUIGXeI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 19:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268769AbUIGXeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 19:34:08 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:19809 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S268767AbUIGXdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 19:33:02 -0400
Date: Tue, 7 Sep 2004 16:28:55 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: andrea@suse.de, shemminger@osdl.org, akpm@osdl.org, dipankar@in.ibm.com,
       rusty@au1.ibm.com, faith@redhat.com, riel@redhat.com, ak@suse.de,
       mjbligh@us.ibm.com, gh@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][Patch] RCU documentation
Message-ID: <20040907232855.GA13513@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Attached is a patch to place some RCU documentation in the Documentation
directory.  Patch should apply to pretty much any kernel version.  ;-)

Thoughts?

						Thanx, Paul

Signed-off-by: paulmck@us.ibm.com


 RTFP.txt      |  352 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 UP.txt        |   64 ++++++++++
 checklist.txt |  157 +++++++++++++++++++++++++
 listRCU.txt   |  301 +++++++++++++++++++++++++++++++++++++++++++++++++
 rcu.txt       |   56 +++++++++
 5 files changed, 930 insertions(+)


diff -urN -X dontdiff linux-2.6.8.1/Documentation/RCU/UP.txt linux-2.6.8.1-rcudoc/Documentation/RCU/UP.txt
--- linux-2.6.8.1/Documentation/RCU/UP.txt	Wed Dec 31 16:00:00 1969
+++ linux-2.6.8.1-rcudoc/Documentation/RCU/UP.txt	Thu Aug 12 15:40:39 2004
@@ -0,0 +1,64 @@
+RCU on Uniprocessor Systems
+
+
+A common misconception is that, on UP systems, the call_rcu() primitive
+may immediately invoke its function, and that the synchronize_kernel
+primitive may return immediately.  The basis of this misconception
+is that since there is only one CPU, it should not be necessary to
+wait for anything else to get done, since there are no other CPUs for
+anything else to be happening on.  Although this approach will sort of
+work a surprising amount of the time, it is a very bad idea in general.
+This document presents two examples that demonstrate exactly how bad an
+idea this is.
+
+
+Example 1: softirq Suicide
+
+Suppose that an RCU-based algorithm scans a linked list containing
+elements A, B, and C in process context, and can delete elements from
+this same list in softirq context.  Suppose that the process-context scan
+is referencing element B when it is interrupted by softirq processing,
+which deletes element B, and then invokes call_rcu() to free element B
+after a grace period.
+
+Now, if call_rcu() were to directly invoke its arguments, then upon return
+from softirq, the list scan would find itself referencing a newly freed
+element B.  This situation can greatly decrease the life expectancy of
+your kernel.
+
+
+Example 2: Function-Call Fatality
+
+Of course, one could avert the suicide described in the preceding example
+by having call_rcu() directly invoke its arguments only if it was called
+from process context.  However, this can fail in a similar manner.
+
+Suppose that an RCU-based algorithm again scans a linked list containing
+elements A, B, and C in process contexts, but that it invokes a function
+on each element as it is scanned.  Suppose further that this function
+deletes element B from the list, then passes it to call_rcu() for deferred
+freeing.  This may be a bit unconventional, but it is perfectly legal
+RCU usage, since call_rcu() must wait for a grace period to elapse.
+Therefore, in this case, allowing call_rcu() to immediately invoke
+its arguments would cause it to fail to make the fundamental guarantee
+underlying RCU, namely that call_rcu() defers invoking its arguments until
+all RCU read-side critical sections currently executing have completed.
+
+Quick Quiz: why is it -not- legal to invoke synchronize_kernel() in
+this case?
+
+
+Summary
+
+Permitting call_rcu() to immediatly invoke its arguments or permitting
+synchronize_kernel() to immediatly return breaks RCU, even on a UP system.
+So do not do it!  Even on a UP system, the RCU infrastructure -must-
+respect grace periods.
+
+
+Answer to Quick Quiz
+
+The calling function is scanning an RCU-protected linked list, and
+is therefore within an RCU read-side critical section.  Therefore,
+the called function has been invoked within an RCU read-side critical
+section, and is not permitted to block.
diff -urN -X dontdiff linux-2.6.8.1/Documentation/RCU/checklist.txt linux-2.6.8.1-rcudoc/Documentation/RCU/checklist.txt
--- linux-2.6.8.1/Documentation/RCU/checklist.txt	Wed Dec 31 16:00:00 1969
+++ linux-2.6.8.1-rcudoc/Documentation/RCU/checklist.txt	Mon Aug 30 17:44:02 2004
@@ -0,0 +1,157 @@
+Review Checklist for RCU Patches
+
+
+This document contains a checklist for producing and reviewing patches
+that make use of RCU.  Violating any of the rules listed below will
+result in the same sorts of problems that leaving out a locking primitive
+would cause.  This list is based on experiences reviewing such patches
+over a rather long period of time, but improvements are always welcome!
+
+0.	Is RCU being applied to a read-mostly situation?  If the data
+	structure is updated more than about 10% of the time, then
+	you should strongly consider some other approach, unless
+	detailed performance measurements show that RCU is nonetheless
+	the right tool for the job.
+
+	The other exception would be where performance is not an issue,
+	and RCU provides a simpler implementation.  An example of this
+	situation is the dynamic NMI code in the Linux 2.6 kernel,
+	at least on architectures where NMIs are rare.
+
+1.	Does the update code have proper mutual exclusion?
+
+	RCU does allow -readers- to run (almost) naked, but -writers- must
+	still use some sort of mutual exclusion, such as:
+	
+	a.	locking,
+	b.	atomic operations, or
+	c.	restricting updates to a single task.
+
+	If you choose #b, be prepared to describe how you have handled
+	memory barriers on weakly ordered machines (pretty much all of
+	them -- even x86 allows reads to be reordered), and be prepared
+	to explain why this added complexity is worthwhile.  If you
+	choose #c, be prepared to explain how this single task does not
+	become a major bottleneck on big multiprocessor machines.
+
+2.	Do the RCU read-side critical sections make proper use of
+	rcu_read_lock() and friends?  These primitives are needed
+	to suppress preemption (or bottom halves, in the case of
+	rcu_read_lock_bh()) in the read-side critical sections,
+	and are also an excellent aid to readability.
+
+3.	Does the update code tolerate concurrent accesses?
+
+	The whole point of RCU is to permit readers to run without
+	any locks or atomic operations.  This means that readers will
+	be running while updates are in progress.  There are a number
+	of ways to handle this concurrency, depending on the situation:
+
+	a.	Make updates appear atomic to readers.  For example,
+		pointer updates to properly aligned fields will appear
+		atomic, as will individual atomic primitives.  Operations
+		performed under a lock and sequences of multiple atomic
+		primitives will -not- appear to be atomic.
+
+		This is almost always the best approach.
+
+	b.	Carefully order the updates and the reads so that
+		readers see valid data at all phases of the update.
+		This is often more difficult than it sounds, especially
+		given modern CPUs' tendency to reorder memory references.
+		One must usually liberally sprinkle memory barriers
+		(smp_wmb(), smp_rmb(), smp_mb()) through the code,
+		making it difficult to understand and to test.
+
+		It is usually better to group the changing data into
+		a separate structure, so that the change may be made
+		to appear atomic by updating a pointer to reference
+		a new structure containing updated values.
+
+4.	Weakly ordered CPUs pose special challenges.  Almost all CPUs
+	are weakly ordered -- even i386 CPUs allow reads to be reordered.
+	RCU code must take all of the following measures to prevent
+	memory-corruption problems:
+
+	a.	Readers must maintain proper ordering of their memory
+		accesses.  The rcu_dereference() primitive ensures that
+		the CPU picks up the pointer before it picks up the data
+		that the pointer points to.  This really is necessary
+		on Alpha CPUs.	If you don't believe me, see:
+
+			http://www.openvms.compaq.com/wizard/wiz_2637.html
+
+		The rcu_dereference() primitive is also an excellent
+		documentation aid, letting the person reading the code
+		know exactly which pointers are protected by RCU.
+
+		The rcu_dereference() primitive is used by the various
+		"_rcu()" list-traversal primitives, such as the
+		list_for_each_entry_rcu().
+
+	b.	If the list macros are being used, the list_del_rcu(),
+		list_add_tail_rcu(), and list_del_rcu() primitives must
+		be used in order to prevent weakly ordered machines from
+		misordering structure initialization and pointer planting.
+		Similarly, if the hlist macros are being used, the
+		hlist_del_rcu() and hlist_add_head_rcu() primitives
+		are required.
+
+	c.	Updates must ensure that initialization of a given
+		structure happens before pointers to that structure are
+		publicized.  Use the rcu_assign_pointer() primitive
+		when publicizing a pointer to a structure that can
+		be traversed by an RCU read-side critical section.
+
+		[The rcu_assign_pointer() primitive is in process.]
+
+5.	If call_rcu(), or a related primitive such as call_rcu_bh(),
+	is used, the callback function must be written to be called
+	from softirq context.  In particular, it cannot block.
+
+6.	Since synchronize_kernel() blocks, it cannot be called from
+	any sort of irq context.
+
+7.	If the updater uses call_rcu(), then the corresponding readers
+	must use rcu_read_lock() and rcu_read_unlock().  If the updater
+	uses call_rcu_bh(), then the corresponding readers must use
+	rcu_read_lock_bh() and rcu_read_unlock_bh().  Mixing things up
+	will result in confusion and broken kernels.
+
+	One exception to this rule: rcu_read_lock() and rcu_read_unlock()
+	may be substituted for rcu_read_lock_bh() and rcu_read_unlock_bh()
+	in cases where local bottom halves are already known to be
+	disabled, for example, in irq or softirq context.  Commenting
+	such cases is a must, of course!  And the jury is still out on
+	whether the increased speed is worth it.
+
+8.	Although synchronize_kernel() is a bit slower than is call_rcu(),
+	it usually results in simpler code.  So, unless update performance
+	is important or the updaters cannot block, synchronize_kernel()
+	should be used in preference to call_rcu().
+
+9.	All RCU list-traversal primitives, which include
+	list_for_each_rcu(), list_for_each_entry_rcu(),
+	list_for_each_continue_rcu(), and list_for_each_safe_rcu(),
+	must be within an RCU read-side critical section.  RCU
+	read-side critical sections are delimited by rcu_read_lock()
+	and rcu_read_unlock(), or by similar primitives such as
+	rcu_read_lock_bh() and rcu_read_unlock_bh().
+
+	Use of the _rcu() list-traversal primitives outside of an
+	RCU read-side critical section causes no harm other than
+	a slight performance degradation on Alpha CPUs and some
+	confusion on the part of people trying to read the code.
+
+	Another way of thinking of this is "If you are holding the
+	lock that prevents the data structure from changing, why do
+	you also need RCU-based protection?"  That said, there may
+	well be situations where use of the _rcu() list-traversal
+	primitives while the update-side lock is held results in
+	simpler and more maintainable code.  The jury is still out
+	on this question.
+
+10.	Conversely, if you are in an RCU read-side critical section,
+	you -must- use the "_rcu()" variants of the list macros.
+	Failing to do so will break Alpha and confuse people reading
+	your code.
diff -urN -X dontdiff linux-2.6.8.1/Documentation/RCU/listRCU.txt linux-2.6.8.1-rcudoc/Documentation/RCU/listRCU.txt
--- linux-2.6.8.1/Documentation/RCU/listRCU.txt	Wed Dec 31 16:00:00 1969
+++ linux-2.6.8.1-rcudoc/Documentation/RCU/listRCU.txt	Fri Aug 13 16:04:53 2004
@@ -0,0 +1,301 @@
+Using RCU to Protect Read-Mostly Linked Lists
+
+
+One of the best applications of RCU is to protect read-mostly linked lists
+("struct list_head" in list.h).  One big advantage of this approach
+is that all of the required memory barriers are included for you in
+the list macros.  This document describes several applications of RCU,
+with the best fits first.
+
+
+Example 1: Read-Side Action Taken Outside of Lock, No In-Place Updates
+
+The best applications are cases where, if reader-writer locking were
+used, the read-side lock would be dropped before taking any action
+based on the results of the search.  The most celebrated example is
+the routing table.  Because the routing table is tracking the state of
+equipment outside of the computer, it will at times contain stale data.
+Therefore, once the route has been computed, there is no need to hold
+the routing table static during transmission of the packet.  After all,
+you can hold the routing table static all you want, but that won't keep
+the external internet from changing, and it is the state of the external
+internet that really matters.  In addition, routing entries are typically
+added or deleted, rather than being modified in place.
+
+A straightforward example of this use of RCU may be found in the
+system-call auditing support.  For example, a reader-writer locked
+implementation of audit_filter_task() might be as follows:
+
+	static enum audit_state audit_filter_task(struct task_struct *tsk)
+	{
+		struct audit_entry *e;
+		enum audit_state   state;
+
+		read_lock(&auditsc_lock);
+		list_for_each_entry(e, &audit_tsklist, list) {
+			if (audit_filter_rules(tsk, &e->rule, NULL, &state)) {
+				read_unlock(&auditsc_lock);
+				return state;
+			}
+		}
+		read_unlock(&auditsc_lock);
+		return AUDIT_BUILD_CONTEXT;
+	}
+
+Here the list is searched under the lock, but the lock is dropped before
+the corresponding value is returned.  By the time that this value is acted
+on, the list may well have been modified.  This makes sense, since if
+you are turning auditing off, it is OK to audit a few extra system calls.
+
+This means that RCU can be easily applied to the read side, as follows:
+
+	static enum audit_state audit_filter_task(struct task_struct *tsk)
+	{
+		struct audit_entry *e;
+		enum audit_state   state;
+
+		rcu_read_lock();
+		list_for_each_entry_rcu(e, &audit_tsklist, list) {
+			if (audit_filter_rules(tsk, &e->rule, NULL, &state)) {
+				rcu_read_unlock();
+				return state;
+			}
+		}
+		rcu_read_unlock();
+		return AUDIT_BUILD_CONTEXT;
+	}
+
+The read_lock() and read_unlock() calls have become rcu_read_lock()
+and rcu_read_unlock(), respectively, and the list_for_each_entry() has
+become list_for_each_entry_rcu().  The _rcu() list-traversal primitives
+insert the read-side memory barriers that are required on DEC Alpha CPUs.
+
+The changes to the update side are also straightforward.  A reader-writer
+lock might be used as follows for deletion and insertion:
+
+	static inline int audit_del_rule(struct audit_rule *rule,
+					 struct list_head *list)
+	{
+		struct audit_entry  *e;
+
+		write_lock(&auditsc_lock);
+		list_for_each_entry(e, list, list) {
+			if (!audit_compare_rule(rule, &e->rule)) {
+				list_del(&e->list);
+				call_rcu(&e->rcu, audit_free_rule, e);
+				return 0;
+			}
+		}
+		write_unlock(&auditsc_lock);
+		return -EFAULT;		/* No matching rule */
+	}
+
+	static inline int audit_add_rule(struct audit_entry *entry,
+					 struct list_head *list)
+	{
+		write_lock(&auditsc_lock);
+		if (entry->rule.flags & AUDIT_PREPEND) {
+			entry->rule.flags &= ~AUDIT_PREPEND;
+			list_add(&entry->list, list);
+		} else {
+			list_add_tail(&entry->list, list);
+		}
+		write_unlock(&auditsc_lock);
+		return 0;
+	}
+
+Following are the RCU equivalents for these two functions:
+
+	static inline int audit_del_rule(struct audit_rule *rule,
+					 struct list_head *list)
+	{
+		struct audit_entry  *e;
+
+		/* Do not use the _rcu iterator here, since this is the only
+		 * deletion routine. */
+		list_for_each_entry(e, list, list) {
+			if (!audit_compare_rule(rule, &e->rule)) {
+				list_del_rcu(&e->list);
+				call_rcu(&e->rcu, audit_free_rule, e);
+				return 0;
+			}
+		}
+		return -EFAULT;		/* No matching rule */
+	}
+
+	static inline int audit_add_rule(struct audit_entry *entry,
+					 struct list_head *list)
+	{
+		if (entry->rule.flags & AUDIT_PREPEND) {
+			entry->rule.flags &= ~AUDIT_PREPEND;
+			list_add_rcu(&entry->list, list);
+		} else {
+			list_add_tail_rcu(&entry->list, list);
+		}
+		return 0;
+	}
+
+Normally, the write_lock() and write_unlock() would be replaced by
+a spin_lock() and a spin_unlock(), but in this case, all callers hold
+audit_netlink_sem, so no additional locking is required.  The auditsc_lock
+can therefore be eliminated, since use of RCU eliminates the need for
+writers to exclude readers.
+
+The list_del(), list_add(), and list_add_tail() primitives have been
+replaced by list_del_rcu(), list_add_rcu(), and list_add_tail_rcu().
+The _rcu() list-manipulation primitives add memory barriers that are
+needed on weakly ordered CPUs (most of them!).
+
+So, when readers can tolerate stale data and when entries are either added
+or deleted, without in-place modification, it is very easy to use RCU!
+
+
+Example 2: Handling In-Place Updates
+
+The system-call auditing code does not update auditing rules in place.
+However, if it did, reader-writer-locked code to do so might look as
+follows (presumably, the field_count is only permitted to decrease,
+otherwise, the added fields would need to be filled in):
+
+	static inline int audit_upd_rule(struct audit_rule *rule,
+					 struct list_head *list,
+					 __u32 newaction,
+					 __u32 newfield_count)
+	{
+		struct audit_entry  *e;
+		struct audit_newentry *ne;
+
+		write_lock(&auditsc_lock);
+		list_for_each_entry(e, list, list) {
+			if (!audit_compare_rule(rule, &e->rule)) {
+				e->rule.action = newaction;
+				e->rule.file_count = newfield_count;
+				write_unlock(&auditsc_lock);
+				return 0;
+			}
+		}
+		write_unlock(&auditsc_lock);
+		return -EFAULT;		/* No matching rule */
+	}
+
+The RCU version creates a copy, updates the copy, then replaces the old
+entry with the newly updated entry.  This sequence of actions, allowing
+concurrent reads while doing a copy to perform an update, is what gives
+RCU ("read-copy update") its name.  The RCU code is as follows:
+
+	static inline int audit_upd_rule(struct audit_rule *rule,
+					 struct list_head *list,
+					 __u32 newaction,
+					 __u32 newfield_count)
+	{
+		struct audit_entry  *e;
+		struct audit_newentry *ne;
+
+		list_for_each_entry(e, list, list) {
+			if (!audit_compare_rule(rule, &e->rule)) {
+				ne = kmalloc(sizeof(*entry), GFP_ATOMIC);
+				if (ne == NULL)
+					return _ENOMEM;
+				audit_copy_rule(&ne->rule, &e->rule);
+				ne->rule.action = newaction;
+				ne->rule.file_count = newfield_count;
+				list_add_rcu(ne, e);
+				list_del(e);
+				call_rcu(&e->rcu, audit_free_rule, e);
+				return 0;
+			}
+		}
+		return -EFAULT;		/* No matching rule */
+	}
+
+Again, this assumes that the caller holds audit_netlink_sem.  Normally,
+the reader-writer lock would become a spinlock in this sort of code.
+
+
+Example 3: Eliminating Stale Data
+
+The auditing examples above tolerate stale data, as do most algorithms
+that are tracking external state.  Because there is a delay from the
+time the external state changes before Linux becomes aware of the change,
+additional RCU-induced staleness is normally not a problem.
+
+However, there are many examples where stale data cannot be tolerated.
+One example in the Linux kernel is the System V IPC (see the ipc_lock()
+function in ipc/util.c).  This code checks a "deleted" flag under a
+per-entry spinlock, and, if the "deleted" flag is set, pretends that the
+entry does not exist.  For this to be helpful, the search function must
+return holding the per-entry spinlock, as ipc_lock() does in fact do.
+
+Quick Quiz:  Why does the search function need to return holding the
+per-entry lock for this deleted-flag technique to be helpful?
+
+If the system-call audit module were to ever need to reject stale data,
+one way to accomplish this would be to add a "deleted" flag and a "lock"
+spinlock to the audit_entry structure, and modify audit_filter_task()
+as follows:
+
+	static enum audit_state audit_filter_task(struct task_struct *tsk)
+	{
+		struct audit_entry *e;
+		enum audit_state   state;
+
+		rcu_read_lock();
+		list_for_each_entry_rcu(e, &audit_tsklist, list) {
+			if (audit_filter_rules(tsk, &e->rule, NULL, &state)) {
+				spin_lock(&e->lock);
+				if (e->deleted) {
+					spin_unlock(&e->lock);
+					rcu_read_unlock();
+					return AUDIT_BUILD_CONTEXT;
+				}
+				rcu_read_unlock();
+				return state;
+			}
+		}
+		rcu_read_unlock();
+		return AUDIT_BUILD_CONTEXT;
+	}
+
+The audit_del_rule() function would need to set the "deleted"
+flag under the spinlock as follows:
+
+	static inline int audit_del_rule(struct audit_rule *rule,
+					 struct list_head *list)
+	{
+		struct audit_entry  *e;
+
+		/* Do not use the _rcu iterator here, since this is the only
+		 * deletion routine. */
+		list_for_each_entry(e, list, list) {
+			if (!audit_compare_rule(rule, &e->rule)) {
+				spin_lock(&e->lock);
+				list_del_rcu(&e->list);
+				e->deleted = 1;
+				spin_unlock(&e->lock);
+				call_rcu(&e->rcu, audit_free_rule, e);
+				return 0;
+			}
+		}
+		return -EFAULT;		/* No matching rule */
+	}
+
+
+Summary
+
+Read-mostly list-based data structures that can tolerate stale data are
+the most amenable to use of RCU.  The simplest case is where entries are
+either added or deleted from the data structure (or atomically modified
+in place), but non-atomic in-place modifications can be handled by making
+a copy, updating the copy, then replacing the original with the copy.
+If stale data cannot be tolerated, then a "deleted" flag may be used
+in conjunction with a per-entry spinlock in order to allow the search
+function to reject newly deleted data.
+
+
+Answer to Quick Quiz
+
+If the search function drops the per-entry lock before returning, then
+the caller will be processing stale data in any case.  If it is really
+OK to be processing stale data, then you don't need a "deleted" flag.
+If processing stale data really is a problem, then you need to hold the
+per-entry lock across all of the code that uses the value looked up.
diff -urN -X dontdiff linux-2.6.8.1/Documentation/RCU/rcu.txt linux-2.6.8.1-rcudoc/Documentation/RCU/rcu.txt
--- linux-2.6.8.1/Documentation/RCU/rcu.txt	Wed Dec 31 16:00:00 1969
+++ linux-2.6.8.1-rcudoc/Documentation/RCU/rcu.txt	Mon Aug 30 17:34:26 2004
@@ -0,0 +1,56 @@
+RCU Concepts
+
+
+The basic idea behind RCU is to split destructive operations into two
+parts, one that makes anyone from seeing the data item being destroyed,
+and one that actually carries out the destruction.  A "grace period"
+must elapse between the two parts, and this grace period must be long
+enough that any readers accessing the item being deleted have since
+dropped their references.  For example, an RCU-protected deletion from a
+linked list would first remove the item from the list, wait for a grace
+period to elapse, then free the element.  See the listRCU.txt file for 
+more information on using RCU with linked lists.
+
+
+Frequently Asked Questions
+
+
+o	Why would anyone want to use RCU?
+
+	The advantage of RCU's two-part approach is that RCU readers need
+	not acquire any locks, perform any atomic instructions, write to
+	shared memory, or (on CPUs other than Alpha) execute any memory
+	barriers.  The fact that these operations are quite expensive
+	on modern CPUs is what gives RCU its performance advantages
+	in read-mostly situations.  The fact that RCU readers need not
+	acquire locks can also greatly simplify deadlock-avoidance code.
+
+
+o	How can the updater tell when a grace period has completed
+	if the RCU readers give no indication when they are done?
+
+	Just as with spinlocks, RCU readers are not permitted to
+	block, switch to user-mode execution, or enter the idle loop.
+	Therefore, as soon as a CPU is seen passing through any of these
+	three states, we know that that CPU has exited any previous RCU
+	read-side critical sections.  So, if we remove an item from a
+	linked list, and then wait until all CPUs have switched context,
+	executed in user mode, or executed in the idle loop, we can
+	safely free up that item.
+
+o	If I am running on a uniprocessor kernel, which can only do one
+	thing at a time, why should I wait for a grace period?
+
+	See the UP.txt file in this directory.
+
+o	How can I see where RCU is currently used in the Linux kernel?
+
+	Search for "rcu_read_lock", "call_rcu", and "synchronize_kernel".
+
+o	What guidelines should I follow when writing code that uses RCU?
+
+	See the checklist.txt file in this directory.
+
+o	Where can I find more information on RCU?
+
+	See the RTFP.txt file in this directory.
diff -urN -X dontdiff linux-2.6.8.1/Documentation/RCU/RTFP.txt linux-2.6.8.1-rcudoc/Documentation/RCU/RTFP.txt
--- linux-2.6.8.1/Documentation/RCU/RTFP.txt	Wed Dec 31 16:00:00 1969
+++ linux-2.6.8.1-rcudoc/Documentation/RCU/RTFP.txt	Mon Aug 30 17:48:30 2004
@@ -0,0 +1,352 @@
+Read the F-ing Papers!
+
+
+This document describes RCU-related publications, and is followed by
+the corresponding bibtex entries.
+
+The first thing resembling RCU was published in 1980, when Kung and Lehman
+[Kung80] recommended use of a garbage collector to defer destruction
+of nodes in a parallel binary search tree in order to simplify its
+implementation.  This works well in environments that have garbage
+collectors, but current production garbage collectors incur significant
+read-side overhead.
+
+In 1982, Manber and Ladner [Manber82,Manber84] recommended deferring
+destruction until all threads running at that time have terminated, again
+for a parallel binary search tree.  This approach works well in systems
+with short-lived threads, such as the K42 research operating system.
+However, Linux has long-lived tasks, so more is needed.
+
+In 1986, Hennessy, Osisek, and Seigh [Hennessy89] introduced passive
+serialization, which is an RCU-like mechanism that relies on the presence
+of "quiescent states" in the VM/XA hypervisor that are guaranteed not
+to be referencing the data structure.  However, this mechanism was not
+optimized for modern computer systems, which is not surprising given
+that these overheads were not so expensive in the mid-80s.  Nonetheless,
+passive serialization appears to be the first deferred-destruction
+mechanism to be used in production.  Furthermore, the relevant patent has
+lapsed, so this approach may be used in non-GPL software, if desired.
+(In contrast, use of RCU is permitted only in software licensed under
+GPL.  Sorry!!!)
+
+In 1990, Pugh [Pugh90] noted that explicitly tracking which threads
+were reading a given data structure permitted deferred free to operate
+in the presence of non-terminating threads.  However, this explicit
+tracking imposes significant read-side overhead, which is undesirable
+in read-mostly situations.  This algorithm does take pains to avoid
+write-side contention and parallelize the other write-side overheads by
+providing a fine-grained locking design, however, it would be interesting
+to see how much of the performance advantage reported in 1990 remains
+in 2004.
+
+At about this same time, Adams [Adams91] described ``chaotic relaxation'',
+where the normal barriers between successive iterations of convergent
+numerical algorithms are relaxed, so that iteration $n$ might use
+data from iteration $n-1$ or even $n-2$.  This introduces error,
+which typically slows convergence and thus increases the number of
+iterations required.  However, this increase is sometimes more than made
+up for by a reduction in the number of expensive barrier operations,
+which are otherwise required to synchronize the threads at the end
+of each iteration.  Unfortunately, chaotic relaxation requires highly
+structured data, such as the matrices used in scientific programs, and
+is thus inapplicable to most data structures in operating-system kernels.
+
+In 1993, Jacobson [Jacobson93] verbally described what is perhaps the
+simplest deferred-free technique: simply waiting a fixed amount of time
+before freeing blocks awaiting deferred free.  Jacobson did not describe
+any write-side changes he might have made in this work using SGI's Irix
+kernel.  Aju John published a similar technique in 1995 [AjuJohn95].
+This works well if there is a well-defined upper bound on the length of
+time that reading threads can hold references, as there might well be in
+hard real-time systems.  However, if this time is exceeded, perhaps due
+to preemption, excessive interrupts, or larger-than-anticipated load,
+memory corruption can ensue, with no reasonable means of diagnosis.
+Jacobson's technique is therefore inappropriate for use in production
+operating-system kernels, except when such kernels can provide hard
+real-time response guarantees for all operations.
+
+Also in 1995, Pu et al. [Pu95a] applied a technique similar to that of Pugh's
+read-side-tracking to permit replugging of algorithms within a commercial
+Unix operating system.  However, this replugging permitted only a single
+reader at a time.  The following year, this same group of researchers
+extended their technique to allow for multiple readers [Cowan96a].
+Their approach requires memory barriers (and thus pipeline stalls),
+but reduces memory latency, contention, and locking overheads.
+
+1995 also saw the first publication of DYNIX/ptx's RCU mechanism
+[Slingwine95], which was optimized for modern CPU architectures,
+and was successfully applied to a number of situations within the
+DYNIX/ptx kernel.  The corresponding conference paper appeared in 1998
+[McKenney98].
+
+In 1999, the Tornado and K42 groups described their "generations"
+mechanism, which quite similar to RCU [Gamsa99].  These operating systems
+made pervasive use of RCU in place of "existence locks", which greatly
+simplifies locking hierarchies.
+
+2001 saw the first RCU presentation involving Linux [McKenney01a]
+at OLS.  The resulting abundance of RCU patches was presented the
+following year [McKenney02a], and use of RCU in dcache was first
+described that same year [Linder02a].
+
+Also in 2002, Michael [Michael02b,Michael02a] presented techniques
+that defer the destruction of data structures to simplify non-blocking
+synchronization (wait-free synchronization, lock-free synchronization,
+and obstruction-free synchronization are all examples of non-blocking
+synchronization).  In particular, this technique eliminates locking,
+reduces contention, reduces memory latency for readers, and parallelizes
+pipeline stalls and memory latency for writers.  However, these
+techniques still impose significant read-side overhead in the form of
+memory barriers.  Researchers at Sun worked along similar lines in the
+same timeframe [HerlihyLM02,HerlihyLMS03].
+
+In 2003, the K42 group described how RCU could be used to create
+hot-pluggable implementations of operating-system functions.  Later that
+year saw a paper describing an RCU implementation of System V IPC
+[Arcangeli03], and an introduction to RCU in Linux Journal [McKenney03a].
+
+2004 has seen a Linux-Journal article on use of RCU in dcache
+[McKenney04a], a performance comparison of locking to RCU on several
+different CPUs [McKenney04b], a dissertation describing use of RCU in a
+number of operating-system kernels [PaulEdwardMcKenneyPhD], and a paper
+describing how to make RCU safe for soft-realtime applications [Sarma04c].
+
+
+Bibtex Entries
+
+@article{Kung80
+,author="H. T. Kung and Q. Lehman"
+,title="Concurrent Maintenance of Binary Search Trees"
+,Year="1980"
+,Month="September"
+,journal="ACM Transactions on Database Systems"
+,volume="5"
+,number="3"
+,pages="354-382"
+}
+
+@techreport{Manber82
+,author="Udi Manber and Richard E. Ladner"
+,title="Concurrency Control in a Dynamic Search Structure"
+,institution="Department of Computer Science, University of Washington"
+,address="Seattle, Washington"
+,year="1982"
+,number="82-01-01"
+,month="January"
+,pages="28"
+}
+
+@article{Manber84
+,author="Udi Manber and Richard E. Ladner"
+,title="Concurrency Control in a Dynamic Search Structure"
+,Year="1984"
+,Month="September"
+,journal="ACM Transactions on Database Systems"
+,volume="9"
+,number="3"
+,pages="439-455"
+}
+
+@techreport{Hennessy89
+,author="James P. Hennessy and Damian L. Osisek and Joseph W. {Seigh II}"
+,title="Passive Serialization in a Multitasking Environment"
+,institution="US Patent and Trademark Office"
+,address="Washington, DC"
+,year="1989"
+,number="US Patent 4,809,168 (lapsed)"
+,month="February"
+,pages="11"
+}
+
+@techreport{Pugh90
+,author="William Pugh"
+,title="Concurrent Maintenance of Skip Lists"
+,institution="Institute of Advanced Computer Science Studies, Department of Computer Science, University of Maryland"
+,address="College Park, Maryland"
+,year="1990"
+,number="CS-TR-2222.1"
+,month="June"
+}
+
+@Book{Adams91
+,Author="Gregory R. Adams"
+,title="Concurrent Programming, Principles, and Practices"
+,Publisher="Benjamin Cummins"
+,Year="1991"
+}
+
+@unpublished{Jacobson93
+,author="Van Jacobson"
+,title="Avoid Read-Side Locking Via Delayed Free"
+,year="1993"
+,month="September"
+,note="Verbal discussion"
+}
+
+@Conference{AjuJohn95
+,Author="Aju John"
+,Title="Dynamic vnodes -- Design and Implementation"
+,Booktitle="{USENIX Winter 1995}"
+,Publisher="USENIX Association"
+,Month="January"
+,Year="1995"
+,pages="11-23"
+,Address="New Orleans, LA"
+}
+
+@techreport{Slingwine95
+,author="John D. Slingwine and Paul E. McKenney"
+,title="Apparatus and Method for Achieving Reduced Overhead Mutual
+Exclusion and Maintaining Coherency in a Multiprocessor System
+Utilizing Execution History and Thread Monitoring"
+,institution="US Patent and Trademark Office"
+,address="Washington, DC"
+,year="1995"
+,number="US Patent 5,442,758"
+,month="August"
+}
+
+@Conference{McKenney98
+,Author="Paul E. McKenney and John D. Slingwine"
+,Title="Read-Copy Update: Using Execution History to Solve Concurrency
+Problems"
+,Booktitle="{Parallel and Distributed Computing and Systems}"
+,Month="October"
+,Year="1998"
+,pages="509-518"
+,Address="Las Vegas, NV"
+}
+
+@Conference{Gamsa99
+,Author="Ben Gamsa and Orran Krieger and Jonathan Appavoo and Michael Stumm"
+,Title="Tornado: Maximizing Locality and Concurrency in a Shared Memory
+Multiprocessor Operating System"
+,Booktitle="{Proceedings of the 3\textsuperscript{rd} Symposium on
+Operating System Design and Implementation}"
+,Month="February"
+,Year="1999"
+,pages="87-100"
+,Address="New Orleans, LA"
+}
+
+@Conference{McKenney01a
+,Author="Paul E. McKenney and Jonathan Appavoo and Andi Kleen and
+Orran Krieger and Rusty Russell and Dipankar Sarma and Maneesh Soni"
+,Title="Read-Copy Update"
+,Booktitle="{Ottawa Linux Symposium}"
+,Month="July"
+,Year="2001"
+,note="Available:
+\url{http://www.linuxsymposium.org/2001/abstracts/readcopy.php}
+\url{http://www.rdrop.com/users/paulmck/rclock/rclock_OLS.2001.05.01c.pdf}
+[Viewed June 23, 2004]"
+annotation="
+Described RCU, and presented some patches implementing and using it in
+the Linux kernel.
+"
+}
+
+@Conference{Linder02a
+,Author="Hanna Linder and Dipankar Sarma and Maneesh Soni"
+,Title="Scalability of the Directory Entry Cache"
+,Booktitle="{Ottawa Linux Symposium}"
+,Month="June"
+,Year="2002"
+,pages="289-300"
+}
+
+@Conference{McKenney02a
+,Author="Paul E. McKenney and Dipankar Sarma and
+Andrea Arcangeli and Andi Kleen and Orran Krieger and Rusty Russell"
+,Title="Read-Copy Update"
+,Booktitle="{Ottawa Linux Symposium}"
+,Month="June"
+,Year="2002"
+,pages="338-367"
+,note="Available:
+\url{http://www.linux.org.uk/~ajh/ols2002_proceedings.pdf.gz}
+[Viewed June 23, 2004]"
+}
+
+@article{Appavoo03a
+,author="J. Appavoo and K. Hui and C. A. N. Soules and R. W. Wisniewski and
+D. M. {Da Silva} and O. Krieger and M. A. Auslander and D. J. Edelsohn and
+B. Gamsa and G. R. Ganger and P. McKenney and M. Ostrowski and
+B. Rosenburg and M. Stumm and J. Xenidis"
+,title="Enabling Autonomic Behavior in Systems Software With Hot Swapping"
+,Year="2003"
+,Month="January"
+,journal="IBM Systems Journal"
+,volume="42"
+,number="1"
+,pages="60-76"
+}
+
+@Conference{Arcangeli03
+,Author="Andrea Arcangeli and Mingming Cao and Paul E. McKenney and
+Dipankar Sarma"
+,Title="Using Read-Copy Update Techniques for {System V IPC} in the
+{Linux} 2.5 Kernel"
+,Booktitle="Proceedings of the 2003 USENIX Annual Technical Conference
+(FREENIX Track)"
+,Publisher="USENIX Association"
+,year="2003"
+,month="June"
+,pages="297-310"
+}
+
+@article{McKenney03a
+,author="Paul E. McKenney"
+,title="Using {RCU} in the {Linux} 2.5 Kernel"
+,Year="2003"
+,Month="October"
+,journal="Linux Journal"
+,volume="1"
+,number="114"
+,pages="18-26"
+}
+
+@article{McKenney04a
+,author="Paul E. McKenney and Dipankar Sarma and Maneesh Soni"
+,title="Scaling dcache with {RCU}"
+,Year="2004"
+,Month="January"
+,journal="Linux Journal"
+,volume="1"
+,number="118"
+,pages="38-46"
+}
+
+@Conference{McKenney04b
+,Author="Paul E. McKenney"
+,Title="{RCU} vs. Locking Performance on Different {CPUs}"
+,Booktitle="{linux.conf.au}"
+,Month="January"
+,Year="2004"
+,Address="Adelaide, Australia"
+,note="Available:
+\url{http://www.linux.org.au/conf/2004/abstracts.html#90}
+\url{http://www.rdrop.com/users/paulmck/rclock/lockperf.2004.01.17a.pdf}
+[Viewed June 23, 2004]"
+}
+
+@phdthesis{PaulEdwardMcKenneyPhD
+,author="Paul E. McKenney"
+,title="Exploiting Deferred Destruction:
+An Analysis of Read-Copy-Update Techniques
+in Operating System Kernels"
+,school="OGI School of Science and Engineering at
+Oregon Health and Sciences University"
+,year="2004"
+}
+
+@Conference{Sarma04c
+,Author="Dipankar Sarma and Paul E. McKenney"
+,Title="Making RCU Safe for Deep Sub-Millisecond Response Realtime Applications"
+,Booktitle="Proceedings of the 2004 USENIX Annual Technical Conference
+(FREENIX Track)"
+,Publisher="USENIX Association"
+,year="2004"
+,month="June"
+,pages="182-191"
+}
