Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbVJOA1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbVJOA1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 20:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbVJOA1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 20:27:05 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:53264 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750974AbVJOA1D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 20:27:03 -0400
Date: Sat, 15 Oct 2005 10:26:49 +1000
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suzanne Wood <suzannew@cs.pdx.edu>, paulmck@us.ibm.com
Subject: [LIST] Add missing rcu_dereference on first element
Message-ID: <20051015002649.GA28555@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

It seems that all the list_*_rcu primitives are missing a memory barrier
on the very first dereference.  For example,

#define list_for_each_rcu(pos, head) \
	for (pos = (head)->next; prefetch(pos->next), pos != (head); \
		pos = rcu_dereference(pos->next))

It will go something like:

	pos = (head)->next

	prefetch(pos->next)

	pos != (head)

	do stuff

We're missing a barrier here.

	pos = rcu_dereference(pos->next)

		fetch pos->next

		barrier given by rcu_dereference(pos->next)

		store pos

Without the missing barrier, the pos->next value may turn out to be
stale.  In fact, if "do stuff" were also dereferencing pos and relying
on list_for_each_rcu to provide the barrier then it may also break.

So here is a patch to make sure that we have a barrier for the first
element in the list.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

diff --git a/include/linux/list.h b/include/linux/list.h
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -442,12 +442,15 @@ static inline void list_splice_init(stru
  * as long as the traversal is guarded by rcu_read_lock().
  */
 #define list_for_each_rcu(pos, head) \
-	for (pos = (head)->next; prefetch(pos->next), pos != (head); \
-        	pos = rcu_dereference(pos->next))
+	for (pos = (head)->next; \
+		pos = rcu_dereference(pos), \
+			prefetch(pos->next), pos != (head); \
+        	pos = pos->next)
 
 #define __list_for_each_rcu(pos, head) \
-	for (pos = (head)->next; pos != (head); \
-        	pos = rcu_dereference(pos->next))
+	for (pos = (head)->next; \
+		rcu_dereference(pos) != (head); \
+        	pos = pos->next)
 
 /**
  * list_for_each_safe_rcu	-	iterate over an rcu-protected list safe
@@ -461,8 +464,9 @@ static inline void list_splice_init(stru
  * as long as the traversal is guarded by rcu_read_lock().
  */
 #define list_for_each_safe_rcu(pos, n, head) \
-	for (pos = (head)->next, n = pos->next; pos != (head); \
-		pos = rcu_dereference(n), n = pos->next)
+	for (pos = (head)->next; \
+		n = rcu_dereference(pos)->next, pos != (head); \
+		pos = n)
 
 /**
  * list_for_each_entry_rcu	-	iterate over rcu list of given type
@@ -474,11 +478,11 @@ static inline void list_splice_init(stru
  * the _rcu list-mutation primitives such as list_add_rcu()
  * as long as the traversal is guarded by rcu_read_lock().
  */
-#define list_for_each_entry_rcu(pos, head, member)			\
-	for (pos = list_entry((head)->next, typeof(*pos), member);	\
-	     prefetch(pos->member.next), &pos->member != (head); 	\
-	     pos = rcu_dereference(list_entry(pos->member.next, 	\
-					typeof(*pos), member)))
+#define list_for_each_entry_rcu(pos, head, member) \
+	for (pos = list_entry((head)->next, typeof(*pos), member); \
+		pos = rcu_dereference(pos), \
+			prefetch(pos->member.next), &pos->member != (head); \
+		pos = list_entry(pos->member.next, typeof(*pos), member))
 
 
 /**
@@ -492,8 +496,10 @@ static inline void list_splice_init(stru
  * as long as the traversal is guarded by rcu_read_lock().
  */
 #define list_for_each_continue_rcu(pos, head) \
-	for ((pos) = (pos)->next; prefetch((pos)->next), (pos) != (head); \
-        	(pos) = rcu_dereference((pos)->next))
+	for ((pos) = (pos)->next; \
+		(pos) = rcu_dereference((pos)), \
+			prefetch((pos)->next), (pos) != (head); \
+        	(pos) = (pos)->next)
 
 /*
  * Double linked lists with a single pointer list head.
@@ -696,8 +702,9 @@ static inline void hlist_add_after_rcu(s
 	     pos = n)
 
 #define hlist_for_each_rcu(pos, head) \
-	for ((pos) = (head)->first; pos && ({ prefetch((pos)->next); 1; }); \
-		(pos) = rcu_dereference((pos)->next))
+	for ((pos) = (head)->first; \
+		rcu_dereference((pos)) && ({ prefetch((pos)->next); 1; }); \
+		(pos) = (pos)->next)
 
 /**
  * hlist_for_each_entry	- iterate over list of given type
@@ -762,9 +769,9 @@ static inline void hlist_add_after_rcu(s
  */
 #define hlist_for_each_entry_rcu(tpos, pos, head, member)		 \
 	for (pos = (head)->first;					 \
-	     pos && ({ prefetch(pos->next); 1;}) &&			 \
+	     rcu_dereference(pos) && ({ prefetch(pos->next); 1;}) &&	 \
 		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;}); \
-	     pos = rcu_dereference(pos->next))
+	     pos = pos->next)
 
 #else
 #warning "don't include kernel headers in userspace"

--8t9RHnE3ZwKMSgU+--
