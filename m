Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268168AbTB1VPf>; Fri, 28 Feb 2003 16:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268174AbTB1VPf>; Fri, 28 Feb 2003 16:15:35 -0500
Received: from air-2.osdl.org ([65.172.181.6]:4506 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268168AbTB1VPb>;
	Fri, 28 Feb 2003 16:15:31 -0500
Subject: Possible FIFO race in lock_sock()
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1046467548.30194.258.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 28 Feb 2003 13:25:50 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doing a review to understand socket locking, found a race by inspection
but don't have a test to reproduce the problem.

It appears lock_sock() basically reinvents a semaphore in order to have
FIFO wakeup and allow test semantics for the bottom half.  The problem
is that when socket is locked, the wakeup is guaranteed FIFO.  It is
possible for another requester to sneak in the window between when owner
is cleared and the next queued requester is woken up.

Don't know what this impacts, perhaps out of order data on a pipe?

Scenario:
	Multiple requesters (A, B, C, D) and new requester N
	
	Assume A gets socket lock and is owner. 
	B, C, D are on the wait queue.
	A release_lock which ends up waking up B
	Before B runs and acquires socket lock:
	   N requests socket lock and sees owner is NULL so it grabs it.

The patch just checks the waitq before proceeding with the fast path.

Other alternatives:
1. Ignore it we aren't guaranteeing FIFO anyway.
	- then why bother with waitq when spin lock will do.
2. Replace socket_lock with a semaphore
	- with changes to BH to get same semantics
3. Implement a better FIFO spin lock

Comments?

diff -Nru a/include/net/sock.h b/include/net/sock.h
--- a/include/net/sock.h	Fri Feb 28 13:24:43 2003
+++ b/include/net/sock.h	Fri Feb 28 13:24:43 2003
@@ -356,7 +356,7 @@
 #define lock_sock(__sk) \
 do {	might_sleep(); \
 	spin_lock_bh(&((__sk)->lock.slock)); \
-	if ((__sk)->lock.owner != NULL) \
+	if ((__sk)->lock.owner != NULL || waitqueue_active(&((__sk)->lock.wq))) \
 		__lock_sock(__sk); \
 	(__sk)->lock.owner = (void *)1; \
 	spin_unlock_bh(&((__sk)->lock.slock)); \


