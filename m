Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262589AbSJHBrn>; Mon, 7 Oct 2002 21:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262592AbSJHBrn>; Mon, 7 Oct 2002 21:47:43 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:63497
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262589AbSJHBrm>; Mon, 7 Oct 2002 21:47:42 -0400
Subject: [PATCH] preempt_count overflow with brlocks
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Oct 2002 21:53:15 -0400
Message-Id: <1034041998.30670.280.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Now that brlocks loop over NR_CPUS, on SMP every brlock/brunlock results
in the acquire/release of 32 locks.  This incs/decs the preempt_count by
32.

Since we only have 7 bits now for actually storing the lock depth, we
cannot nest but 3 locks deep.  I doubt we ever acquire three brlocks
concurrently, but it is still a concern.

Attached patch disables/enables preemption explicitly once and only once
for each lock/unlock.  This is also an optimization as it removes 31
incs, decs, and conditionals. :)

Problem reported by Andrew Morton.

Patch is against 2.5.41, please apply.

	Robert Love

diff -urN linux-2.5.41/lib/brlock.c linux/lib/brlock.c
--- linux-2.5.41/lib/brlock.c	2002-10-07 14:24:45.000000000 -0400
+++ linux/lib/brlock.c	2002-10-07 21:38:02.000000000 -0400
@@ -24,8 +24,9 @@
 {
 	int i;
 
+	preempt_disable();
 	for (i = 0; i < NR_CPUS; i++)
-		write_lock(&__brlock_array[i][idx]);
+		_raw_write_lock(&__brlock_array[i][idx]);
 }
 
 void __br_write_unlock (enum brlock_indices idx)
@@ -33,7 +34,8 @@
 	int i;
 
 	for (i = 0; i < NR_CPUS; i++)
-		write_unlock(&__brlock_array[i][idx]);
+		_raw_write_unlock(&__brlock_array[i][idx]);
+	preempt_enable();
 }
 
 #else /* ! __BRLOCK_USE_ATOMICS */
@@ -48,11 +50,12 @@
 {
 	int i;
 
+	preempt_disable();
 again:
-	spin_lock(&__br_write_locks[idx].lock);
+	_raw_spin_lock(&__br_write_locks[idx].lock);
 	for (i = 0; i < NR_CPUS; i++)
 		if (__brlock_array[i][idx] != 0) {
-			spin_unlock(&__br_write_locks[idx].lock);
+			_raw_spin_unlock(&__br_write_locks[idx].lock);
 			barrier();
 			cpu_relax();
 			goto again;

