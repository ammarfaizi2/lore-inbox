Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVDCGlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVDCGlb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 01:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVDCGla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 01:41:30 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:11731 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261535AbVDCGjd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 01:39:33 -0500
Date: Sat, 2 Apr 2005 22:39:48 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: dipankar@in.ibm.com, manfred@colorfullife.com
Subject: [RFC,PATCH 4/4] Update RCU documentation
Message-ID: <20050403063948.GA1740@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update the RCU documentation to allow for the new synchronize_rcu() and
synchronize_sched() primitives.  Fix a few other nits as well.

Signed-off-by: <paulmck@us.ibm.com>
---
Depends on the earlier "Deprecate synchronize_kernel, GPL replacement" patch.

 RTFP.txt      |   29 +++++++++++++++++++++++++++--
 UP.txt        |    8 ++++----
 checklist.txt |   47 ++++++++++++++++++++++++++++++++++-------------
 listRCU.txt   |   13 +++++++++----
 rcu.txt       |    4 +++-
 5 files changed, 77 insertions(+), 24 deletions(-)

diff -urpN -X dontdiff linux-2.6.12-rc1/Documentation/RCU/RTFP.txt linux-2.6.12-rc1-bettersk/Documentation/RCU/RTFP.txt
--- linux-2.6.12-rc1/Documentation/RCU/RTFP.txt	Tue Mar  1 23:38:13 2005
+++ linux-2.6.12-rc1-bettersk/Documentation/RCU/RTFP.txt	Sat Apr  2 12:03:29 2005
@@ -108,8 +108,9 @@ year saw a paper describing an RCU imple
 2004 has seen a Linux-Journal article on use of RCU in dcache
 [McKenney04a], a performance comparison of locking to RCU on several
 different CPUs [McKenney04b], a dissertation describing use of RCU in a
-number of operating-system kernels [PaulEdwardMcKenneyPhD], and a paper
-describing how to make RCU safe for soft-realtime applications [Sarma04c].
+number of operating-system kernels [PaulEdwardMcKenneyPhD], a paper
+describing how to make RCU safe for soft-realtime applications [Sarma04c],
+and a paper describing SELinux performance with RCU [JamesMorris04b].
 
 
 Bibtex Entries
@@ -341,6 +342,17 @@ Dipankar Sarma"
 ,pages="18-26"
 }
 
+@techreport{Friedberg03a
+,author="Stuart A. Friedberg"
+,title="Lock-Free Wild Card Search Data Structure and Method"
+,institution="US Patent and Trademark Office"
+,address="Washington, DC"
+,year="2003"
+,number="US Patent 6,662,184 (contributed under GPL)"
+,month="December"
+,pages="112"
+}
+
 @article{McKenney04a
 ,author="Paul E. McKenney and Dipankar Sarma and Maneesh Soni"
 ,title="Scaling dcache with {RCU}"
@@ -373,6 +385,9 @@ in Operating System Kernels"
 ,school="OGI School of Science and Engineering at
 Oregon Health and Sciences University"
 ,year="2004"
+,note="Available:
+\url{http://www.rdrop.com/users/paulmck/RCU/RCUdissertation.2004.07.14e1.pdf}
+[Viewed October 15, 2004]"
 }
 
 @Conference{Sarma04c
@@ -384,4 +399,14 @@ Oregon Health and Sciences University"
 ,year="2004"
 ,month="June"
 ,pages="182-191"
+}
+
+@unpublished{JamesMorris04b
+,Author="James Morris"
+,Title="Recent Developments in {SELinux} Kernel Performance"
+,month="December"
+,year="2004"
+,note="Available:
+\url{http://www.livejournal.com/users/james_morris/2153.html}
+[Viewed December 10, 2004]"
 }
diff -urpN -X dontdiff linux-2.6.12-rc1/Documentation/RCU/UP.txt linux-2.6.12-rc1-bettersk/Documentation/RCU/UP.txt
--- linux-2.6.12-rc1/Documentation/RCU/UP.txt	Tue Mar  1 23:37:54 2005
+++ linux-2.6.12-rc1-bettersk/Documentation/RCU/UP.txt	Sat Apr  2 12:04:09 2005
@@ -2,11 +2,11 @@ RCU on Uniprocessor Systems
 
 
 A common misconception is that, on UP systems, the call_rcu() primitive
-may immediately invoke its function, and that the synchronize_kernel
+may immediately invoke its function, and that the synchronize_rcu()
 primitive may return immediately.  The basis of this misconception
 is that since there is only one CPU, it should not be necessary to
 wait for anything else to get done, since there are no other CPUs for
-anything else to be happening on.  Although this approach will sort of
+anything else to be happening on.  Although this approach will -sort- -of-
 work a surprising amount of the time, it is a very bad idea in general.
 This document presents two examples that demonstrate exactly how bad an
 idea this is.
@@ -44,14 +44,14 @@ its arguments would cause it to fail to 
 underlying RCU, namely that call_rcu() defers invoking its arguments until
 all RCU read-side critical sections currently executing have completed.
 
-Quick Quiz: why is it -not- legal to invoke synchronize_kernel() in
+Quick Quiz: why is it -not- legal to invoke synchronize_rcu() in
 this case?
 
 
 Summary
 
 Permitting call_rcu() to immediately invoke its arguments or permitting
-synchronize_kernel() to immediately return breaks RCU, even on a UP system.
+synchronize_rcu() to immediately return breaks RCU, even on a UP system.
 So do not do it!  Even on a UP system, the RCU infrastructure -must-
 respect grace periods.
 
diff -urpN -X dontdiff linux-2.6.12-rc1/Documentation/RCU/checklist.txt linux-2.6.12-rc1-bettersk/Documentation/RCU/checklist.txt
--- linux-2.6.12-rc1/Documentation/RCU/checklist.txt	Tue Mar  1 23:38:13 2005
+++ linux-2.6.12-rc1-bettersk/Documentation/RCU/checklist.txt	Sat Apr  2 12:30:50 2005
@@ -32,7 +32,10 @@ over a rather long period of time, but i
 	them -- even x86 allows reads to be reordered), and be prepared
 	to explain why this added complexity is worthwhile.  If you
 	choose #c, be prepared to explain how this single task does not
-	become a major bottleneck on big multiprocessor machines.
+	become a major bottleneck on big multiprocessor machines (for
+	example, if the task is updating information relating to itself
+	that other tasks can read, there by definition can be no
+	bottleneck).
 
 2.	Do the RCU read-side critical sections make proper use of
 	rcu_read_lock() and friends?  These primitives are needed
@@ -89,27 +92,34 @@ over a rather long period of time, but i
 		"_rcu()" list-traversal primitives, such as the
 		list_for_each_entry_rcu().
 
-	b.	If the list macros are being used, the list_del_rcu(),
-		list_add_tail_rcu(), and list_del_rcu() primitives must
-		be used in order to prevent weakly ordered machines from
-		misordering structure initialization and pointer planting.
+	b.	If the list macros are being used, the list_add_tail_rcu()
+		and list_add_rcu() primitives must be used in order
+		to prevent weakly ordered machines from misordering
+		structure initialization and pointer planting.
 		Similarly, if the hlist macros are being used, the
-		hlist_del_rcu() and hlist_add_head_rcu() primitives
-		are required.
+		hlist_add_head_rcu() primitive is required.
 
-	c.	Updates must ensure that initialization of a given
+	c.	If the list macros are being used, the list_del_rcu()
+		primitive must be used to keep list_del()'s pointer
+		poisoning from inflicting toxic effects on concurrent
+		readers.  Similarly, if the hlist macros are being used,
+		the hlist_del_rcu() primitive is required.
+
+		The list_replace_rcu() primitive may be used to
+		replace an old structure with a new one in an
+		RCU-protected list.
+
+	d.	Updates must ensure that initialization of a given
 		structure happens before pointers to that structure are
 		publicized.  Use the rcu_assign_pointer() primitive
 		when publicizing a pointer to a structure that can
 		be traversed by an RCU read-side critical section.
 
-		[The rcu_assign_pointer() primitive is in process.]
-
 5.	If call_rcu(), or a related primitive such as call_rcu_bh(),
 	is used, the callback function must be written to be called
 	from softirq context.  In particular, it cannot block.
 
-6.	Since synchronize_kernel() blocks, it cannot be called from
+6.	Since synchronize_rcu() can block, it cannot be called from
 	any sort of irq context.
 
 7.	If the updater uses call_rcu(), then the corresponding readers
@@ -125,9 +135,9 @@ over a rather long period of time, but i
 	such cases is a must, of course!  And the jury is still out on
 	whether the increased speed is worth it.
 
-8.	Although synchronize_kernel() is a bit slower than is call_rcu(),
+8.	Although synchronize_rcu() is a bit slower than is call_rcu(),
 	it usually results in simpler code.  So, unless update performance
-	is important or the updaters cannot block, synchronize_kernel()
+	is important or the updaters cannot block, synchronize_rcu()
 	should be used in preference to call_rcu().
 
 9.	All RCU list-traversal primitives, which include
@@ -155,3 +165,14 @@ over a rather long period of time, but i
 	you -must- use the "_rcu()" variants of the list macros.
 	Failing to do so will break Alpha and confuse people reading
 	your code.
+
+11.	Note that synchronize_rcu() -only- guarantees to wait until
+	all currently executing rcu_read_lock()-protected RCU read-side
+	critical sections complete.  It does -not- necessarily guarantee
+	that all currently running interrupts, NMIs, preempt_disable()
+	code, or idle loops will complete.  Therefore, if you do not have
+	rcu_read_lock()-protected read-side critical sections, do -not-
+	use synchronize_rcu().
+
+	If you want to wait for some of these other things, you might
+	instead need to use synchronize_irq() or synchronize_sched().
diff -urpN -X dontdiff linux-2.6.12-rc1/Documentation/RCU/listRCU.txt linux-2.6.12-rc1-bettersk/Documentation/RCU/listRCU.txt
--- linux-2.6.12-rc1/Documentation/RCU/listRCU.txt	Tue Mar  1 23:37:51 2005
+++ linux-2.6.12-rc1-bettersk/Documentation/RCU/listRCU.txt	Sat Apr  2 12:11:31 2005
@@ -32,6 +32,7 @@ implementation of audit_filter_task() mi
 		enum audit_state   state;
 
 		read_lock(&auditsc_lock);
+		/* Note: audit_netlink_sem held by caller. */
 		list_for_each_entry(e, &audit_tsklist, list) {
 			if (audit_filter_rules(tsk, &e->rule, NULL, &state)) {
 				read_unlock(&auditsc_lock);
@@ -55,6 +56,7 @@ This means that RCU can be easily applie
 		enum audit_state   state;
 
 		rcu_read_lock();
+		/* Note: audit_netlink_sem held by caller. */
 		list_for_each_entry_rcu(e, &audit_tsklist, list) {
 			if (audit_filter_rules(tsk, &e->rule, NULL, &state)) {
 				rcu_read_unlock();
@@ -139,12 +141,15 @@ Normally, the write_lock() and write_unl
 a spin_lock() and a spin_unlock(), but in this case, all callers hold
 audit_netlink_sem, so no additional locking is required.  The auditsc_lock
 can therefore be eliminated, since use of RCU eliminates the need for
-writers to exclude readers.
+writers to exclude readers.  Normally, the write_lock() calls would
+be converted into spin_lock() calls.
 
 The list_del(), list_add(), and list_add_tail() primitives have been
 replaced by list_del_rcu(), list_add_rcu(), and list_add_tail_rcu().
 The _rcu() list-manipulation primitives add memory barriers that are
-needed on weakly ordered CPUs (most of them!).
+needed on weakly ordered CPUs (most of them!).  The list_del_rcu()
+primitive omits the pointer poisoning debug-assist code that would
+otherwise cause concurrent readers to fail spectacularly.
 
 So, when readers can tolerate stale data and when entries are either added
 or deleted, without in-place modification, it is very easy to use RCU!
@@ -166,6 +171,7 @@ otherwise, the added fields would need t
 		struct audit_newentry *ne;
 
 		write_lock(&auditsc_lock);
+		/* Note: audit_netlink_sem held by caller. */
 		list_for_each_entry(e, list, list) {
 			if (!audit_compare_rule(rule, &e->rule)) {
 				e->rule.action = newaction;
@@ -199,8 +205,7 @@ RCU ("read-copy update") its name.  The 
 				audit_copy_rule(&ne->rule, &e->rule);
 				ne->rule.action = newaction;
 				ne->rule.file_count = newfield_count;
-				list_add_rcu(ne, e);
-				list_del(e);
+				list_replace_rcu(e, ne);
 				call_rcu(&e->rcu, audit_free_rule, e);
 				return 0;
 			}
diff -urpN -X dontdiff linux-2.6.12-rc1/Documentation/RCU/rcu.txt linux-2.6.12-rc1-bettersk/Documentation/RCU/rcu.txt
--- linux-2.6.12-rc1/Documentation/RCU/rcu.txt	Tue Mar  1 23:37:42 2005
+++ linux-2.6.12-rc1-bettersk/Documentation/RCU/rcu.txt	Sat Apr  2 12:13:36 2005
@@ -43,7 +43,9 @@ o	If I am running on a uniprocessor kern
 
 o	How can I see where RCU is currently used in the Linux kernel?
 
-	Search for "rcu_read_lock", "call_rcu", and "synchronize_kernel".
+	Search for "rcu_read_lock", "rcu_read_unlock", "call_rcu",
+	"rcu_read_lock_bh", "rcu_read_unlock_bh", "call_rcu_bh",
+	"synchronize_rcu", and "synchronize_net".
 
 o	What guidelines should I follow when writing code that uses RCU?
 
