Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261434AbTCTMwR>; Thu, 20 Mar 2003 07:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261436AbTCTMwR>; Thu, 20 Mar 2003 07:52:17 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:63914 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261434AbTCTMwQ>; Thu, 20 Mar 2003 07:52:16 -0500
Date: Thu, 20 Mar 2003 18:39:46 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] list barriers smp-only
Message-ID: <20030320130946.GA2217@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the list macros use smp-only version of the barriers,
no need to hurt UP performance. It got dropped from my list of things
to push long ago.

Thanks
Dipankar


diff -urN linux-2.5.65-base/include/linux/list.h linux-2.5.65-nowmb/include/linux/list.h
--- linux-2.5.65-base/include/linux/list.h	2003-03-18 03:14:07.000000000 +0530
+++ linux-2.5.65-nowmb/include/linux/list.h	2003-03-20 18:33:12.000000000 +0530
@@ -84,7 +84,7 @@
 {
 	new->next = next;
 	new->prev = prev;
-	wmb();
+	smp_wmb();
 	next->prev = new;
 	prev->next = new;
 }
@@ -303,11 +303,11 @@
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
@@ -318,7 +318,7 @@
  */
 #define list_for_each_safe_rcu(pos, n, head) \
 	for (pos = (head)->next, n = pos->next; pos != (head); \
-		pos = n, ({ read_barrier_depends(); 0;}), n = pos->next)
+		pos = n, ({ smp_read_barrier_depends(); 0;}), n = pos->next)
 
 /* 
  * Double linked lists with a single pointer list head. 
