Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263764AbTEODSV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTEODSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:18:21 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:64491 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263764AbTEODSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:14 -0400
Date: Thu, 15 May 2003 04:30:59 +0100
Message-Id: <200305150330.h4F3Uxh4000508@deviant.impure.org.uk>
To: akpm@digeo.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: BUG() -> BUG_ON() conversions.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various performance critical sections.
Lets give this a spin in other trees before pushing it
to Linus to make sure the unlikely() stuff is a win.

The increased cache footprint may be a pessimisation,
especially on earlier CPUs where unlikely() doesn't
do anything useful, and we fall back to trusting gcc
to DTRT.

    Dave

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/include/asm-i386/spinlock.h linux-2.5/include/asm-i386/spinlock.h
--- bk-linus/include/asm-i386/spinlock.h	2003-04-10 06:01:31.000000000 +0100
+++ linux-2.5/include/asm-i386/spinlock.h	2003-04-15 06:02:46.000000000 +0100
@@ -5,6 +5,7 @@
 #include <asm/rwlock.h>
 #include <asm/page.h>
 #include <linux/config.h>
+#include <linux/compiler.h>
 
 extern int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
@@ -70,10 +71,8 @@ typedef struct {
 static inline void _raw_spin_unlock(spinlock_t *lock)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
-	if (lock->magic != SPINLOCK_MAGIC)
-		BUG();
-	if (!spin_is_locked(lock))
-		BUG();
+	BUG_ON (lock->magic != SPINLOCK_MAGIC);
+	BUG_ON (!spin_is_locked(lock));
 #endif
 	__asm__ __volatile__(
 		spin_unlock_string
@@ -91,10 +90,8 @@ static inline void _raw_spin_unlock(spin
 {
 	char oldval = 1;
 #ifdef CONFIG_DEBUG_SPINLOCK
-	if (lock->magic != SPINLOCK_MAGIC)
-		BUG();
-	if (!spin_is_locked(lock))
-		BUG();
+	BUG_ON (lock->magic != SPINLOCK_MAGIC);
+	BUG_ON (!spin_is_locked(lock));
 #endif
 	__asm__ __volatile__(
 		spin_unlock_string
@@ -118,8 +115,8 @@ static inline void _raw_spin_lock(spinlo
 #ifdef CONFIG_DEBUG_SPINLOCK
 	__label__ here;
 here:
-	if (lock->magic != SPINLOCK_MAGIC) {
-printk("eip: %p\n", &&here);
+	if (unlikely(lock->magic != SPINLOCK_MAGIC)) {
+		printk("eip: %p\n", &&here);
 		BUG();
 	}
 #endif
@@ -174,8 +171,7 @@ typedef struct {
 static inline void _raw_read_lock(rwlock_t *rw)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
-	if (rw->magic != RWLOCK_MAGIC)
-		BUG();
+	BUG_ON (rw->magic != RWLOCK_MAGIC);
 #endif
 	__build_read_lock(rw, "__read_lock_failed");
 }
@@ -183,8 +179,7 @@ static inline void _raw_read_lock(rwlock
 static inline void _raw_write_lock(rwlock_t *rw)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
-	if (rw->magic != RWLOCK_MAGIC)
-		BUG();
+	BUG_ON (rw->magic != RWLOCK_MAGIC);
 #endif
 	__build_write_lock(rw, "__write_lock_failed");
 }
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/include/asm-i386/mmu_context.h linux-2.5/include/asm-i386/mmu_context.h
--- bk-linus/include/asm-i386/mmu_context.h	2003-04-10 06:01:31.000000000 +0100
+++ linux-2.5/include/asm-i386/mmu_context.h	2003-04-15 06:02:46.000000000 +0100
@@ -45,8 +45,8 @@ static inline void switch_mm(struct mm_s
 #ifdef CONFIG_SMP
 	else {
 		cpu_tlbstate[cpu].state = TLBSTATE_OK;
-		if (cpu_tlbstate[cpu].active_mm != next)
-			BUG();
+		BUG_ON (cpu_tlbstate[cpu].active_mm != next);
+
 		if (!test_and_set_bit(cpu, &next->cpu_vm_mask)) {
 			/* We were in lazy tlb mode and leave_mm disabled 
 			 * tlb flush IPI delivery. We must reload %cr3.
