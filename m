Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTDOLyU (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 07:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTDOLyH 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 07:54:07 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:52362 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261293AbTDOLx5 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 07:53:57 -0400
Date: Tue, 15 Apr 2003 13:05:04 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUGed to death
Message-ID: <20030415120457.GA11998@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Duncan Sands <baldrick@wanadoo.fr>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@digeo.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <80690000.1050351598@flay> <200304142310.05110.baldrick@wanadoo.fr> <20030414211740.GB11160@suse.de> <200304151357.32819.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304151357.32819.baldrick@wanadoo.fr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 01:57:32PM +0200, Duncan Sands wrote:

 > It is questionable.  Since even in core kernel code there are
 > many places with
 > 	if (cond)
 > 		BUG();
 > rather than
 > 	BUG_ON(cond);
 > it may be worth seeing if converting them makes a difference
 > (increases code size though).

The spinlock code sticks out as a possible good target.
Any takers for benchmarking ?

		Dave


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
