Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267477AbTACJDJ>; Fri, 3 Jan 2003 04:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267478AbTACJDJ>; Fri, 3 Jan 2003 04:03:09 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:37352 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267477AbTACJDG>;
	Fri, 3 Jan 2003 04:03:06 -0500
Date: Fri, 3 Jan 2003 14:43:34 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] RCU - Make barriers SMP-only
Message-ID: <20030103091334.GA8582@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch makes the barriers used in RCU list macros SMP-only avoiding
the unnecessary overhead of atomic operation on UP. Please apply.

Thanks
Dipankar

 list.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -urN linux-2.5.54-base/include/linux/list.h linux-2.5.54-rcu_barriers/include/linux/list.h
--- linux-2.5.54-base/include/linux/list.h	2003-01-02 08:50:59.000000000 +0530
+++ linux-2.5.54-rcu_barriers/include/linux/list.h	2003-01-03 14:27:21.000000000 +0530
@@ -83,7 +83,7 @@
 {
 	new->next = next;
 	new->prev = prev;
-	wmb();
+	smp_wmb();
 	next->prev = new;
 	prev->next = new;
 }
@@ -302,11 +302,11 @@
  */
 #define list_for_each_rcu(pos, head) \
 	for (pos = (head)->next, prefetch(pos->next); pos != (head); \
-        	pos = pos->next, ({ read_barrier_depends(); 0;}), prefetch(pos->next))
+        	pos = pos->next, ({ smp_read_barrier_depends(); 0;}), prefetch(pos->next))
         	
 #define __list_for_each_rcu(pos, head) \
 	for (pos = (head)->next; pos != (head); \
-        	pos = pos->next, ({ read_barrier_depends(); 0;}))
+        	pos = pos->next, ({ smp_read_barrier_depends(); 0;}))
         	
 /**
  * list_for_each_safe_rcu	-	iterate over an rcu-protected list safe
@@ -317,7 +317,7 @@
  */
 #define list_for_each_safe_rcu(pos, n, head) \
 	for (pos = (head)->next, n = pos->next; pos != (head); \
-		pos = n, ({ read_barrier_depends(); 0;}), n = pos->next)
+		pos = n, ({ smp_read_barrier_depends(); 0;}), n = pos->next)
 
 #else
 #warning "don't include kernel headers in userspace"
