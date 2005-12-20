Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbVLTKyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbVLTKyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 05:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbVLTKyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 05:54:47 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:61396 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750919AbVLTKyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 05:54:46 -0500
Date: Tue, 20 Dec 2005 11:54:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch] fix spinlock-debugging smp_processor_id() usage
Message-ID: <20051220105417.GA15120@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


when a spinlock debugging check hits, we print the CPU number as an 
informational thing - but there is no guarantee that preemption is off 
at that point - hence we should use raw_smp_processor_id(). Otherwise 
DEBUG_PREEMPT will print a warning. With the patch applied, the warning 
goes away and only the spinlock-debugging info is printed.

it's an obvious bugfix, and i think it should get into 2.6.15.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/lib/spinlock_debug.c
===================================================================
--- linux.orig/lib/spinlock_debug.c
+++ linux/lib/spinlock_debug.c
@@ -20,7 +20,8 @@ static void spin_bug(spinlock_t *lock, c
 		if (lock->owner && lock->owner != SPINLOCK_OWNER_INIT)
 			owner = lock->owner;
 		printk("BUG: spinlock %s on CPU#%d, %s/%d\n",
-			msg, smp_processor_id(), current->comm, current->pid);
+			msg, raw_smp_processor_id(),
+			current->comm, current->pid);
 		printk(" lock: %p, .magic: %08x, .owner: %s/%d, .owner_cpu: %d\n",
 			lock, lock->magic,
 			owner ? owner->comm : "<none>",
@@ -78,8 +79,8 @@ static void __spin_lock_debug(spinlock_t
 		if (print_once) {
 			print_once = 0;
 			printk("BUG: spinlock lockup on CPU#%d, %s/%d, %p\n",
-				smp_processor_id(), current->comm, current->pid,
-					lock);
+				raw_smp_processor_id(), current->comm,
+				current->pid, lock);
 			dump_stack();
 		}
 	}
@@ -120,7 +121,8 @@ static void rwlock_bug(rwlock_t *lock, c
 
 	if (xchg(&print_once, 0)) {
 		printk("BUG: rwlock %s on CPU#%d, %s/%d, %p\n", msg,
-			smp_processor_id(), current->comm, current->pid, lock);
+			raw_smp_processor_id(), current->comm,
+			current->pid, lock);
 		dump_stack();
 #ifdef CONFIG_SMP
 		/*
@@ -148,8 +150,8 @@ static void __read_lock_debug(rwlock_t *
 		if (print_once) {
 			print_once = 0;
 			printk("BUG: read-lock lockup on CPU#%d, %s/%d, %p\n",
-				smp_processor_id(), current->comm, current->pid,
-					lock);
+				raw_smp_processor_id(), current->comm,
+				current->pid, lock);
 			dump_stack();
 		}
 	}
@@ -220,8 +222,8 @@ static void __write_lock_debug(rwlock_t 
 		if (print_once) {
 			print_once = 0;
 			printk("BUG: write-lock lockup on CPU#%d, %s/%d, %p\n",
-				smp_processor_id(), current->comm, current->pid,
-					lock);
+				raw_smp_processor_id(), current->comm,
+				current->pid, lock);
 			dump_stack();
 		}
 	}
