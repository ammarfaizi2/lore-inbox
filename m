Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbVJ2C6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVJ2C6p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 22:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVJ2C6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 22:58:45 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:16582 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751107AbVJ2C6o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 22:58:44 -0400
Date: Fri, 28 Oct 2005 19:59:07 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, dipankar@in.ibm.com, manfred@colorfullife.com,
       paulmck@us.ibm.com
Subject: [PATCH 1/2] Remove unused list_for_each_safe_rcu() API
Message-ID: <20051029025907.GA26879@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patch removes the unused list_for_each_safe_rcu() API.  Any out-of-tree
uses of this interface can instead use list_for_each_rcu(), as noted in
the documentation updates.  Builds, passes kernbench and LTP.

Signed-off-by: <paulmck@us.ibm.com>

---

 Documentation/RCU/checklist.txt |    8 ++++----
 Documentation/RCU/whatisRCU.txt |   23 ++++++++++++++++++++++-
 include/linux/list.h            |   16 ----------------
 3 files changed, 26 insertions(+), 21 deletions(-)

diff -urpNa -X dontdiff linux-2.6.14/Documentation/RCU/checklist.txt linux-2.6.14-RCUdoc/Documentation/RCU/checklist.txt
--- linux-2.6.14/Documentation/RCU/checklist.txt	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14-RCUdoc/Documentation/RCU/checklist.txt	2005-10-28 14:08:56.000000000 -0700
@@ -149,10 +149,10 @@ over a rather long period of time, but i
 	should be used in preference to call_rcu().
 
 9.	All RCU list-traversal primitives, which include
-	list_for_each_rcu(), list_for_each_entry_rcu(),
-	list_for_each_continue_rcu(), and list_for_each_safe_rcu(),
-	must be within an RCU read-side critical section.  RCU
-	read-side critical sections are delimited by rcu_read_lock()
+	list_for_each_rcu(), list_for_each_entry_rcu(), and
+	list_for_each_continue_rcu() must be within an RCU read-side
+	critical section (or under the corresponding update-side lock).
+	RCU read-side critical sections are delimited by rcu_read_lock()
 	and rcu_read_unlock(), or by similar primitives such as
 	rcu_read_lock_bh() and rcu_read_unlock_bh().
 
diff -urpNa -X dontdiff linux-2.6.14/Documentation/RCU/whatisRCU.txt linux-2.6.14-RCUdoc/Documentation/RCU/whatisRCU.txt
--- linux-2.6.14/Documentation/RCU/whatisRCU.txt	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14-RCUdoc/Documentation/RCU/whatisRCU.txt	2005-10-28 14:40:47.000000000 -0700
@@ -768,7 +768,6 @@ RCU pointer/list traversal:
 	rcu_dereference
 	list_for_each_rcu		(to be deprecated in favor of
 					 list_for_each_entry_rcu)
-	list_for_each_safe_rcu		(deprecated, not used)
 	list_for_each_entry_rcu
 	list_for_each_continue_rcu	(to be deprecated in favor of new
 					 list_for_each_entry_continue_rcu)
@@ -798,6 +797,9 @@ RCU grace period:
 See the comment headers in the source code (or the docbook generated
 from them) for more information.
 
+Quick Quiz #4:  Why isn't there a list_for_each_safe_rcu() and
+		a list_for_each_entry_safe_rcu()?
+
 
 8.  ANSWERS TO QUICK QUIZZES
 
@@ -892,6 +894,25 @@ Answer:		Just as PREEMPT_RT permits pree
 		Besides, how does the computer know what pizza parlor
 		the human being went to???
 
+Quick Quiz #4:  Why isn't there a list_for_each_safe_rcu() and
+		a list_for_each_entry_safe_rcu()?
+
+Answer:		They are not needed.  Any place you might be tempted
+		to use list_for_each_safe_rcu(), you should instead use
+		list_for_each_rcu().  Similarly, any place you might
+		want to use list_for_each_entry_safe_rcu() you should
+		instead use list_for_each_entry_rcu().
+
+		To see the reason for this substitution, consider that
+		the whole point of the _safe_ macros is to handle the
+		case where the body of the loop deletes the list
+		entry being examined.  But RCU takes care of this deletion
+		case automatically, since any removed list element cannot
+		be freed until after all RCU read-side critical sections,
+		including the one containing the list macro, have completed.
+		Since RCU provides the safety, there is no need for a
+		special "safe" variant of the list macros.
+
 
 ACKNOWLEDGEMENTS
 
diff -urpNa -X dontdiff linux-2.6.14/include/linux/list.h linux-2.6.14-RCUdoc/include/linux/list.h
--- linux-2.6.14/include/linux/list.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14-RCUdoc/include/linux/list.h	2005-10-28 14:40:52.000000000 -0700
@@ -452,22 +452,6 @@ static inline void list_splice_init(stru
         	pos = pos->next)
 
 /**
- * list_for_each_safe_rcu	-	iterate over an rcu-protected list safe
- *					against removal of list entry
- * @pos:	the &struct list_head to use as a loop counter.
- * @n:		another &struct list_head to use as temporary storage
- * @head:	the head for your list.
- *
- * This list-traversal primitive may safely run concurrently with
- * the _rcu list-mutation primitives such as list_add_rcu()
- * as long as the traversal is guarded by rcu_read_lock().
- */
-#define list_for_each_safe_rcu(pos, n, head) \
-	for (pos = (head)->next; \
-		n = rcu_dereference(pos)->next, pos != (head); \
-		pos = n)
-
-/**
  * list_for_each_entry_rcu	-	iterate over rcu list of given type
  * @pos:	the type * to use as a loop counter.
  * @head:	the head for your list.
