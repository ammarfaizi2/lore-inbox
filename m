Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWAaXhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWAaXhy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 18:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWAaXhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 18:37:54 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:60114 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932131AbWAaXhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 18:37:53 -0500
Date: Tue, 31 Jan 2006 15:37:11 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, dipankar@in.ibm.com, stern@rowland.harvard.edu,
       shemminger@osdl.org
Subject: [PATCH] RCU documentation fixes (January 2006 update)
Message-ID: <20060131233711.GA23015@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Updates to in-tree RCU documentation based on comments over the past
few months.

Signed-off-by: <paulmck@us.ibm.com>

---

 RTFP.txt      |   25 ++++++++++++++-----------
 checklist.txt |    6 ++++++
 listRCU.txt   |   19 +++++++++++--------
 rcu.txt       |    5 +++++
 rcuref.txt    |   31 +++++++++++++++----------------
 whatisRCU.txt |   31 +++++++++++++++++--------------
 6 files changed, 68 insertions(+), 49 deletions(-)

diff -urpNa -X dontdiff linux-2.6.16-rc1/Documentation/RCU/checklist.txt linux-2.6.16-rc1-RCUdoc/Documentation/RCU/checklist.txt
--- linux-2.6.16-rc1/Documentation/RCU/checklist.txt	2006-01-25 20:37:59.000000000 -0800
+++ linux-2.6.16-rc1-RCUdoc/Documentation/RCU/checklist.txt	2006-01-25 20:38:26.000000000 -0800
@@ -177,3 +177,9 @@ over a rather long period of time, but i
 
 	If you want to wait for some of these other things, you might
 	instead need to use synchronize_irq() or synchronize_sched().
+
+12.	Any lock acquired by an RCU callback must be acquired elsewhere
+	with irq disabled, e.g., via spin_lock_irqsave().  Failing to
+	disable irq on a given acquisition of that lock will result in
+	deadlock as soon as the RCU callback happens to interrupt that
+	acquisition's critical section.
diff -urpNa -X dontdiff linux-2.6.16-rc1/Documentation/RCU/listRCU.txt linux-2.6.16-rc1-RCUdoc/Documentation/RCU/listRCU.txt
--- linux-2.6.16-rc1/Documentation/RCU/listRCU.txt	2006-01-16 23:44:47.000000000 -0800
+++ linux-2.6.16-rc1-RCUdoc/Documentation/RCU/listRCU.txt	2006-01-25 20:32:15.000000000 -0800
@@ -232,7 +232,7 @@ entry does not exist.  For this to be he
 return holding the per-entry spinlock, as ipc_lock() does in fact do.
 
 Quick Quiz:  Why does the search function need to return holding the
-per-entry lock for this deleted-flag technique to be helpful?
+	per-entry lock for this deleted-flag technique to be helpful?
 
 If the system-call audit module were to ever need to reject stale data,
 one way to accomplish this would be to add a "deleted" flag and a "lock"
@@ -275,8 +275,8 @@ flag under the spinlock as follows:
 	{
 		struct audit_entry  *e;
 
-		/* Do not use the _rcu iterator here, since this is the only
-		 * deletion routine. */
+		/* Do not need to use the _rcu iterator here, since this
+		 * is the only deletion routine. */
 		list_for_each_entry(e, list, list) {
 			if (!audit_compare_rule(rule, &e->rule)) {
 				spin_lock(&e->lock);
@@ -304,9 +304,12 @@ function to reject newly deleted data.
 
 
 Answer to Quick Quiz
+	Why does the search function need to return holding the per-entry
+	lock for this deleted-flag technique to be helpful?
 
-If the search function drops the per-entry lock before returning, then
-the caller will be processing stale data in any case.  If it is really
-OK to be processing stale data, then you don't need a "deleted" flag.
-If processing stale data really is a problem, then you need to hold the
-per-entry lock across all of the code that uses the value looked up.
+	If the search function drops the per-entry lock before returning,
+	then the caller will be processing stale data in any case.  If it
+	is really OK to be processing stale data, then you don't need a
+	"deleted" flag.  If processing stale data really is a problem,
+	then you need to hold the per-entry lock across all of the code
+	that uses the value that was returned.
diff -urpNa -X dontdiff linux-2.6.16-rc1/Documentation/RCU/rcuref.txt linux-2.6.16-rc1-RCUdoc/Documentation/RCU/rcuref.txt
--- linux-2.6.16-rc1/Documentation/RCU/rcuref.txt	2006-01-16 23:44:47.000000000 -0800
+++ linux-2.6.16-rc1-RCUdoc/Documentation/RCU/rcuref.txt	2006-01-25 20:13:11.000000000 -0800
@@ -1,7 +1,7 @@
-Refcounter design for elements of lists/arrays protected by RCU.
+Reference-count design for elements of lists/arrays protected by RCU.
 
-Refcounting on elements of  lists which are protected by traditional
-reader/writer spinlocks or semaphores are straight forward as in:
+Reference counting on elements of lists which are protected by traditional
+reader/writer spinlocks or semaphores are straightforward:
 
 1.				2.
 add()				search_and_reference()
@@ -28,12 +28,12 @@ release_referenced()			delete()
 					    ...
 					}
 
-If this list/array is made lock free using rcu as in changing the
-write_lock in add() and delete() to spin_lock and changing read_lock
+If this list/array is made lock free using RCU as in changing the
+write_lock() in add() and delete() to spin_lock and changing read_lock
 in search_and_reference to rcu_read_lock(), the atomic_get in
 search_and_reference could potentially hold reference to an element which
-has already been deleted from the list/array.  atomic_inc_not_zero takes
-care of this scenario. search_and_reference should look as;
+has already been deleted from the list/array.  Use atomic_inc_not_zero()
+in this scenario as follows:
 
 1.					2.
 add()					search_and_reference()
@@ -51,17 +51,16 @@ add()					search_and_reference()
 release_referenced()			delete()
 {					{
     ...					    write_lock(&list_lock);
-    atomic_dec(&el->rc, relfunc)	    ...
-    ...					    delete_element
-}					    write_unlock(&list_lock);
- 					    ...
+    if (atomic_dec_and_test(&el->rc))       ...
+        call_rcu(&el->head, el_free);       delete_element
+    ...                                     write_unlock(&list_lock);
+} 					    ...
 					    if (atomic_dec_and_test(&el->rc))
 					        call_rcu(&el->head, el_free);
 					    ...
 					}
 
-Sometimes, reference to the element need to be obtained in the
-update (write) stream.  In such cases, atomic_inc_not_zero might be an
-overkill since the spinlock serialising list updates are held. atomic_inc
-is to be used in such cases.
-
+Sometimes, a reference to the element needs to be obtained in the
+update (write) stream.  In such cases, atomic_inc_not_zero() might be
+overkill, since we hold the update-side spinlock.  One might instead
+use atomic_inc() in such cases.
diff -urpNa -X dontdiff linux-2.6.16-rc1/Documentation/RCU/rcu.txt linux-2.6.16-rc1-RCUdoc/Documentation/RCU/rcu.txt
--- linux-2.6.16-rc1/Documentation/RCU/rcu.txt	2006-01-16 23:44:47.000000000 -0800
+++ linux-2.6.16-rc1-RCUdoc/Documentation/RCU/rcu.txt	2006-01-25 19:55:26.000000000 -0800
@@ -111,6 +111,11 @@ o	What are all these files in this direc
 
 		You are reading it!
 
+	rcuref.txt
+
+		Describes how to combine use of reference counts
+		with RCU.
+
 	whatisRCU.txt
 
 		Overview of how the RCU implementation works.  Along
diff -urpNa -X dontdiff linux-2.6.16-rc1/Documentation/RCU/RTFP.txt linux-2.6.16-rc1-RCUdoc/Documentation/RCU/RTFP.txt
--- linux-2.6.16-rc1/Documentation/RCU/RTFP.txt	2006-01-16 23:44:47.000000000 -0800
+++ linux-2.6.16-rc1-RCUdoc/Documentation/RCU/RTFP.txt	2006-01-25 19:44:02.000000000 -0800
@@ -90,16 +90,20 @@ at OLS.  The resulting abundance of RCU 
 following year [McKenney02a], and use of RCU in dcache was first
 described that same year [Linder02a].
 
-Also in 2002, Michael [Michael02b,Michael02a] presented techniques
-that defer the destruction of data structures to simplify non-blocking
-synchronization (wait-free synchronization, lock-free synchronization,
-and obstruction-free synchronization are all examples of non-blocking
-synchronization).  In particular, this technique eliminates locking,
-reduces contention, reduces memory latency for readers, and parallelizes
-pipeline stalls and memory latency for writers.  However, these
-techniques still impose significant read-side overhead in the form of
-memory barriers.  Researchers at Sun worked along similar lines in the
-same timeframe [HerlihyLM02,HerlihyLMS03].
+Also in 2002, Michael [Michael02b,Michael02a] presented "hazard-pointer"
+techniques that defer the destruction of data structures to simplify
+non-blocking synchronization (wait-free synchronization, lock-free
+synchronization, and obstruction-free synchronization are all examples of
+non-blocking synchronization).  In particular, this technique eliminates
+locking, reduces contention, reduces memory latency for readers, and
+parallelizes pipeline stalls and memory latency for writers.  However,
+these techniques still impose significant read-side overhead in the
+form of memory barriers.  Researchers at Sun worked along similar lines
+in the same timeframe [HerlihyLM02,HerlihyLMS03].  These techniques
+can be thought of as inside-out reference counts, where the count is
+represented by the number of hazard pointers referencing a given data
+structure (rather than the more conventional counter field within the
+data structure itself).
 
 In 2003, the K42 group described how RCU could be used to create
 hot-pluggable implementations of operating-system functions.  Later that
@@ -113,7 +117,6 @@ number of operating-system kernels [Paul
 describing how to make RCU safe for soft-realtime applications [Sarma04c],
 and a paper describing SELinux performance with RCU [JamesMorris04b].
 
-
 2005 has seen further adaptation of RCU to realtime use, permitting
 preemption of RCU realtime critical sections [PaulMcKenney05a,
 PaulMcKenney05b].
diff -urpNa -X dontdiff linux-2.6.16-rc1/Documentation/RCU/whatisRCU.txt linux-2.6.16-rc1-RCUdoc/Documentation/RCU/whatisRCU.txt
--- linux-2.6.16-rc1/Documentation/RCU/whatisRCU.txt	2006-01-25 16:51:42.000000000 -0800
+++ linux-2.6.16-rc1-RCUdoc/Documentation/RCU/whatisRCU.txt	2006-01-26 17:59:39.000000000 -0800
@@ -200,12 +200,11 @@ rcu_assign_pointer()
 	the new value, and also executes any memory-barrier instructions
 	required for a given CPU architecture.
 
-	Perhaps just as important, it serves to document which pointers
-	are protected by RCU.  That said, rcu_assign_pointer() is most
-	frequently used indirectly, via the _rcu list-manipulation
-	primitives such as list_add_rcu().  The primitives
-	rcu_assign_pointer(), list_add_rcu(), hlist_add_head(), and
-	friends mark the point at which the structure is accessible
+	Perhaps just as important, it serves to document (1) which
+	pointers are protected by RCU and (2) the point at which a
+	given structure becomes accessible to other CPUs.  That said,
+	rcu_assign_pointer() is most frequently used indirectly, via
+	the _rcu list-manipulation primitives such as list_add_rcu().
 
 rcu_dereference()
 
@@ -260,9 +259,11 @@ rcu_dereference()
 	locking.
 
 	As with rcu_assign_pointer(), an important function of
-	rcu_dereference() is to document which pointers are protected
-	by RCU.  And, again like rcu_assign_pointer(), rcu_dereference()
-	is typically used indirectly, via the _rcu list-manipulation
+	rcu_dereference() is to document which pointers are protected by
+	RCU, in particular, flagging a pointer that is subject to changing
+	at any time, including immediately after the rcu_dereference().
+	And, again like rcu_assign_pointer(), rcu_dereference() is
+	typically used indirectly, via the _rcu list-manipulation
 	primitives, such as list_for_each_entry_rcu().
 
 The following diagram shows how each API communicates among the
@@ -329,7 +330,7 @@ for specialized uses, but are relatively
 3.  WHAT ARE SOME EXAMPLE USES OF CORE RCU API?
 
 This section shows a simple use of the core RCU API to protect a
-global pointer to a dynamically allocated structure.  More typical
+global pointer to a dynamically allocated structure.  More-typical
 uses of RCU may be found in listRCU.txt, arrayRCU.txt, and NMI-RCU.txt.
 
 	struct foo {
@@ -412,6 +413,8 @@ o	Use synchronize_rcu() -after- removing
 	data item.
 
 See checklist.txt for additional rules to follow when using RCU.
+And again, more-typical uses of RCU may be found in listRCU.txt,
+arrayRCU.txt, and NMI-RCU.txt.
 
 
 4.  WHAT IF MY UPDATING THREAD CANNOT BLOCK?
@@ -515,7 +518,7 @@ production-quality implementation, and s
 
 for papers describing the Linux kernel RCU implementation.  The OLS'01
 and OLS'02 papers are a good introduction, and the dissertation provides
-more details on the current implementation.
+more details on the current implementation as of early 2004.
 
 
 5A.  "TOY" IMPLEMENTATION #1: LOCKING
@@ -770,7 +773,6 @@ RCU pointer/list traversal:
 	rcu_dereference
 	list_for_each_rcu		(to be deprecated in favor of
 					 list_for_each_entry_rcu)
-	list_for_each_safe_rcu		(deprecated, not used)
 	list_for_each_entry_rcu
 	list_for_each_continue_rcu	(to be deprecated in favor of new
 					 list_for_each_entry_continue_rcu)
@@ -809,7 +811,8 @@ Quick Quiz #1:	Why is this argument naiv
 Answer:		Consider the following sequence of events:
 
 		1.	CPU 0 acquires some unrelated lock, call it
-			"problematic_lock".
+			"problematic_lock", disabling irq via
+			spin_lock_irqsave().
 
 		2.	CPU 1 enters synchronize_rcu(), write-acquiring
 			rcu_gp_mutex.
@@ -896,7 +899,7 @@ Answer:		Just as PREEMPT_RT permits pree
 ACKNOWLEDGEMENTS
 
 My thanks to the people who helped make this human-readable, including
-Jon Walpole, Josh Triplett, Serge Hallyn, and Suzanne Wood.
+Jon Walpole, Josh Triplett, Serge Hallyn, Suzanne Wood, and Alan Stern.
 
 
 For more information, see http://www.rdrop.com/users/paulmck/RCU.
