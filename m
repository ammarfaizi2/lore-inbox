Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268864AbUIMTGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268864AbUIMTGn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 15:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268860AbUIMTGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 15:06:43 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:54694 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S268864AbUIMTF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 15:05:58 -0400
Date: Mon, 13 Sep 2004 12:01:43 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: dipankar@in.ibm.com, riel@redhat.com, shemminger@osdl.org, dean@arctic.org,
       tytso@mit.edu, nikita@clusterfs.com, akpm@osdl.org, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Updates to RCU documentation
Message-ID: <20040913190143.GA2081@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Here are some updates to the RCU documentation, thank you to everyone
who reviewed and commented!  This applies to linux-2.6.9-rc2.

							Thanx, Paul


diff -urpN -X ../dontdiff linux-2.5/Documentation/RCU/UP.txt linux-2.5-rcudoc/Documentation/RCU/UP.txt
--- linux-2.5/Documentation/RCU/UP.txt	Thu Sep  9 16:19:21 2004
+++ linux-2.5-rcudoc/Documentation/RCU/UP.txt	Mon Sep 13 09:20:42 2004
@@ -50,8 +50,8 @@ this case?
 
 Summary
 
-Permitting call_rcu() to immediatly invoke its arguments or permitting
-synchronize_kernel() to immediatly return breaks RCU, even on a UP system.
+Permitting call_rcu() to immediately invoke its arguments or permitting
+synchronize_kernel() to immediately return breaks RCU, even on a UP system.
 So do not do it!  Even on a UP system, the RCU infrastructure -must-
 respect grace periods.
 
diff -urpN -X ../dontdiff linux-2.5/Documentation/RCU/arrayRCU.txt linux-2.5-rcudoc/Documentation/RCU/arrayRCU.txt
--- linux-2.5/Documentation/RCU/arrayRCU.txt	Wed Dec 31 16:00:00 1969
+++ linux-2.5-rcudoc/Documentation/RCU/arrayRCU.txt	Mon Sep 13 11:37:48 2004
@@ -0,0 +1,141 @@
+Using RCU to Protect Read-Mostly Arrays
+
+
+Although RCU is more commonly used to protect linked lists, it can
+also be used to protect arrays.  Three situations are as follows:
+
+1.  Hash Tables
+
+2.  Static Arrays
+
+3.  Resizeable Arrays
+
+Each of these situations are discussed below.
+
+
+Situation 1: Hash Tables
+
+Hash tables are often implemented as an array, where each array entry
+has a linked-list hash chain.  Each hash chain can be protected by RCU
+as described in the listRCU.txt document.  This approach also applies
+to other array-of-list situations, such as radix trees.
+
+
+Situation 2: Static Arrays
+
+Static arrays, where the data (rather than a pointer to the data) is
+located in each array element, and where the array is never resized,
+have not been used with RCU.  Rik van Riel recommends using seqlock in
+this situation, which would also have minimal read-side overhead as long
+as updates are rare.
+
+Quick Quiz:  Why is it so important that updates be rare when
+	     using seqlock?
+
+
+Situation 3: Resizeable Arrays
+
+Use of RCU for resizeable arrays is demonstrated by the grow_ary()
+function used by the System V IPC code.  The array is used to map from
+semaphore, message-queue, and shared-memory IDs to the data structure
+that represents the corresponding IPC construct.  The grow_ary()
+function does not acquire any locks; instead its caller must hold the
+ids->sem semaphore.
+
+The grow_ary() function, shown below, does some limit checks, allocates a
+new ipc_id_ary, copies the old to the new portion of the new, initializes
+the remainder of the new, updates the ids->entries pointer to point to
+the new array, and invokes ipc_rcu_putref() to free up the old array.
+Note that rcu_assign_pointer() is used to update the ids->entries pointer,
+which includes any memory barriers required on whatever architecture
+you are running on.
+
+	static int grow_ary(struct ipc_ids* ids, int newsize)
+	{
+		struct ipc_id_ary* new;
+		struct ipc_id_ary* old;
+		int i;
+		int size = ids->entries->size;
+
+		if(newsize > IPCMNI)
+			newsize = IPCMNI;
+		if(newsize <= size)
+			return newsize;
+
+		new = ipc_rcu_alloc(sizeof(struct kern_ipc_perm *)*newsize +
+				    sizeof(struct ipc_id_ary));
+		if(new == NULL)
+			return size;
+		new->size = newsize;
+		memcpy(new->p, ids->entries->p,
+		       sizeof(struct kern_ipc_perm *)*size +
+		       sizeof(struct ipc_id_ary));
+		for(i=size;i<newsize;i++) {
+			new->p[i] = NULL;
+		}
+		old = ids->entries;
+
+		/*
+		 * Use rcu_assign_pointer() to make sure the memcpyed
+		 * contents of the new array are visible before the new
+		 * array becomes visible.
+		 */
+		rcu_assign_pointer(ids->entries, new);
+
+		ipc_rcu_putref(old);
+		return newsize;
+	}
+
+The ipc_rcu_putref() function decrements the array's reference count
+and then, if the reference count has dropped to zero, uses call_rcu()
+to free the array after a grace period has elapsed.
+
+The array is traversed by the ipc_lock() function.  This function
+indexes into the array under the protection of rcu_read_lock(),
+using rcu_dereference() to pick up the pointer to the array so
+that it may later safely be dereferenced -- memory barriers are
+required on the Alpha CPU.  Since the size of the array is stored
+with the array itself, there can be no array-size mismatches, so
+a simple check suffices.  The pointer to the structure corresponding
+to the desired IPC object is placed in "out", with NULL indicating
+a non-existent entry.  After acquiring "out->lock", the "out->deleted"
+flag indicates whether the IPC object is in the process of being
+deleted, and, if not, the pointer is returned.
+
+	struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id)
+	{
+		struct kern_ipc_perm* out;
+		int lid = id % SEQ_MULTIPLIER;
+		struct ipc_id_ary* entries;
+
+		rcu_read_lock();
+		entries = rcu_dereference(ids->entries);
+		if(lid >= entries->size) {
+			rcu_read_unlock();
+			return NULL;
+		}
+		out = entries->p[lid];
+		if(out == NULL) {
+			rcu_read_unlock();
+			return NULL;
+		}
+		spin_lock(&out->lock);
+		
+		/* ipc_rmid() may have already freed the ID while ipc_lock
+		 * was spinning: here verify that the structure is still valid
+		 */
+		if (out->deleted) {
+			spin_unlock(&out->lock);
+			rcu_read_unlock();
+			return NULL;
+		}
+		return out;
+	}
+
+
+Answer to Quick Quiz:
+
+	The reason that it is important that updates be rare when
+	using seqlock is that frequent updates can livelock readers.
+	One way to avoid this problem is to assign a seqlock for
+	each array entry rather than to the entire array.
diff -urpN -X ../dontdiff linux-2.5/Documentation/RCU/listRCU.txt linux-2.5-rcudoc/Documentation/RCU/listRCU.txt
--- linux-2.5/Documentation/RCU/listRCU.txt	Thu Sep  9 16:19:21 2004
+++ linux-2.5-rcudoc/Documentation/RCU/listRCU.txt	Mon Sep 13 09:20:42 2004
@@ -18,8 +18,8 @@ equipment outside of the computer, it wi
 Therefore, once the route has been computed, there is no need to hold
 the routing table static during transmission of the packet.  After all,
 you can hold the routing table static all you want, but that won't keep
-the external internet from changing, and it is the state of the external
-internet that really matters.  In addition, routing entries are typically
+the external Internet from changing, and it is the state of the external
+Internet that really matters.  In addition, routing entries are typically
 added or deleted, rather than being modified in place.
 
 A straightforward example of this use of RCU may be found in the
@@ -195,7 +195,7 @@ RCU ("read-copy update") its name.  The 
 			if (!audit_compare_rule(rule, &e->rule)) {
 				ne = kmalloc(sizeof(*entry), GFP_ATOMIC);
 				if (ne == NULL)
-					return _ENOMEM;
+					return -ENOMEM;
 				audit_copy_rule(&ne->rule, &e->rule);
 				ne->rule.action = newaction;
 				ne->rule.file_count = newfield_count;
@@ -255,6 +255,12 @@ as follows:
 		rcu_read_unlock();
 		return AUDIT_BUILD_CONTEXT;
 	}
+
+Note that this example assumes that entries are only added and deleted.
+Additional mechanism is required to deal correctly with the
+update-in-place performed by audit_upd_rule().  For one thing,
+audit_upd_rule() would need additional memory barriers to ensure
+that the list_add_rcu() was really executed before the list_del_rcu().
 
 The audit_del_rule() function would need to set the "deleted"
 flag under the spinlock as follows:
diff -urpN -X ../dontdiff linux-2.5/Documentation/RCU/rcu.txt linux-2.5-rcudoc/Documentation/RCU/rcu.txt
--- linux-2.5/Documentation/RCU/rcu.txt	Thu Sep  9 16:19:21 2004
+++ linux-2.5-rcudoc/Documentation/RCU/rcu.txt	Mon Sep 13 09:20:42 2004
@@ -1,20 +1,19 @@
 RCU Concepts
 
 
-The basic idea behind RCU is to split destructive operations into two
-parts, one that makes anyone from seeing the data item being destroyed,
-and one that actually carries out the destruction.  A "grace period"
-must elapse between the two parts, and this grace period must be long
-enough that any readers accessing the item being deleted have since
-dropped their references.  For example, an RCU-protected deletion from a
-linked list would first remove the item from the list, wait for a grace
-period to elapse, then free the element.  See the listRCU.txt file for
-more information on using RCU with linked lists.
+The basic idea behind RCU (read-copy update) is to split destructive
+operations into two parts, one that prevents anyone from seeing the data
+item being destroyed, and one that actually carries out the destruction.
+A "grace period" must elapse between the two parts, and this grace period
+must be long enough that any readers accessing the item being deleted have
+since dropped their references.  For example, an RCU-protected deletion
+from a linked list would first remove the item from the list, wait for
+a grace period to elapse, then free the element.  See the listRCU.txt
+file for more information on using RCU with linked lists.
 
 
 Frequently Asked Questions
 
-
 o	Why would anyone want to use RCU?
 
 	The advantage of RCU's two-part approach is that RCU readers need
@@ -25,7 +24,6 @@ o	Why would anyone want to use RCU?
 	in read-mostly situations.  The fact that RCU readers need not
 	acquire locks can also greatly simplify deadlock-avoidance code.
 
-
 o	How can the updater tell when a grace period has completed
 	if the RCU readers give no indication when they are done?
 
@@ -50,6 +48,19 @@ o	How can I see where RCU is currently u
 o	What guidelines should I follow when writing code that uses RCU?
 
 	See the checklist.txt file in this directory.
+
+o	Why the name "RCU"?
+
+	"RCU" stands for "read-copy update".  The file listRCU.txt has
+	more information on where this name came from, search for
+	"read-copy update" to find it.
+
+o	I hear that RCU is patented?  What is with that?
+
+	Yes, it is.  There are several known patents related to RCU,
+	search for the string "Patent" in RTFP.txt to find them.
+	Of these, one was allowed to lapse by the assignee, and the
+	others have been contributed to the Linux kernel under GPL.
 
 o	Where can I find more information on RCU?
 
diff -urpN -X ../dontdiff linux-2.5/Documentation/RCU/RTFP.txt linux-2.5-rcudoc/Documentation/RCU/RTFP.txt
--- linux-2.5/Documentation/RCU/RTFP.txt	Thu Sep  9 16:19:21 2004
+++ linux-2.5-rcudoc/Documentation/RCU/RTFP.txt	Mon Sep 13 09:20:42 2004
@@ -202,10 +202,33 @@ Utilizing Execution History and Thread M
 ,institution="US Patent and Trademark Office"
 ,address="Washington, DC"
 ,year="1995"
-,number="US Patent 5,442,758"
+,number="US Patent 5,442,758 (contributed under GPL)"
 ,month="August"
 }
 
+@techreport{Slingwine97
+,author="John D. Slingwine and Paul E. McKenney"
+,title="Method for maintaining data coherency using thread
+activity summaries in a multicomputer system"
+,institution="US Patent and Trademark Office"
+,address="Washington, DC"
+,year="1997"
+,number="US Patent 5,608,893 (contributed under GPL)"
+,month="March"
+}
+
+@techreport{Slingwine98
+,author="John D. Slingwine and Paul E. McKenney"
+,title="Apparatus and method for achieving reduced overhead
+mutual exclusion and maintaining coherency in a multiprocessor
+system utilizing execution history and thread monitoring"
+,institution="US Patent and Trademark Office"
+,address="Washington, DC"
+,year="1998"
+,number="US Patent 5,727,209 (contributed under GPL)"
+,month="March"
+}
+
 @Conference{McKenney98
 ,Author="Paul E. McKenney and John D. Slingwine"
 ,Title="Read-Copy Update: Using Execution History to Solve Concurrency
@@ -227,6 +250,18 @@ Operating System Design and Implementati
 ,Year="1999"
 ,pages="87-100"
 ,Address="New Orleans, LA"
+}
+
+@techreport{Slingwine01
+,author="John D. Slingwine and Paul E. McKenney"
+,title="Apparatus and method for achieving reduced overhead
+mutual exclusion and maintaining coherency in a multiprocessor
+system utilizing execution history and thread monitoring"
+,institution="US Patent and Trademark Office"
+,address="Washington, DC"
+,year="2001"
+,number="US Patent 5,219,690 (contributed under GPL)"
+,month="April"
 }
 
 @Conference{McKenney01a
