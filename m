Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVHHJ7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVHHJ7u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 05:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVHHJ7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 05:59:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:41708 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S1750794AbVHHJ7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 05:59:49 -0400
Date: Mon, 8 Aug 2005 12:00:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc5-mm1
Message-ID: <20050808100036.GA12857@elte.hu>
References: <20050807014214.45968af3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050807014214.45968af3.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> - This kernel is broken on ia64: the spinlock consolidation patch 
> needs fixing.

ia64 had a couple of other compilation problems as well. The patch below 
fixes the spinlock-type issues and 3 other types of build errors.  The 
patched kernel builds fine in an ia64 crosscompiling setup, is otherwise 
untested.

	Ingo

-----

fix ia64 build errors:

 - merge to spinlock-consolidation.patch.

 - fix C syntax errors and calls to nonexistent functions in 
   arch/ia64/kernel/acpi.c and arch/ia64/kernel/iosapic.c

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 arch/ia64/kernel/acpi.c     |    4 ++--
 arch/ia64/kernel/iosapic.c  |    4 ++--
 include/asm-ia64/spinlock.h |   41 ++++++++++++++++-------------------------
 3 files changed, 20 insertions(+), 29 deletions(-)

Index: linux/arch/ia64/kernel/acpi.c
===================================================================
--- linux.orig/arch/ia64/kernel/acpi.c
+++ linux/arch/ia64/kernel/acpi.c
@@ -74,7 +74,7 @@ unsigned int acpi_cpei_override;
 unsigned int acpi_cpei_phys_cpuid;
 
 #define MAX_SAPICS 256
-u16 ia64_acpiid_to_sapicid[MAX_SAPICS] = {[0...MAX_SAPICS - 1] = -1 };
+u16 ia64_acpiid_to_sapicid[MAX_SAPICS] = {[0 ... MAX_SAPICS - 1] = -1 };
 
 EXPORT_SYMBOL(ia64_acpiid_to_sapicid);
 
@@ -138,7 +138,7 @@ const char *acpi_get_sysname(void)
 
 /* Array to record platform interrupt vectors for generic interrupt routing. */
 int platform_intr_list[ACPI_MAX_PLATFORM_INTERRUPTS] = {
-	[0...ACPI_MAX_PLATFORM_INTERRUPTS - 1] = -1
+	[0 ... ACPI_MAX_PLATFORM_INTERRUPTS - 1] = -1
 };
 
 enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_IOSAPIC;
Index: linux/arch/ia64/kernel/iosapic.c
===================================================================
--- linux.orig/arch/ia64/kernel/iosapic.c
+++ linux/arch/ia64/kernel/iosapic.c
@@ -735,11 +735,11 @@ again:
 	spin_unlock_irqrestore(&iosapic_lock, flags);
 
 	/* If vector is running out, we try to find a sharable vector */
-	vector = assign_irq_vector_nopanic(AUTO_ASSIGN);
+	vector = assign_irq_vector(AUTO_ASSIGN);
 	if (vector < 0) {
 		vector = iosapic_find_sharable_vector(trigger, polarity);
   		if (vector < 0)
-			Return -ENOSPC;
+			return -ENOSPC;
 	}
 
 	spin_lock_irqsave(&irq_descp(vector)->lock, flags);
Index: linux/include/asm-ia64/spinlock.h
===================================================================
--- linux.orig/include/asm-ia64/spinlock.h
+++ linux/include/asm-ia64/spinlock.h
@@ -86,17 +86,17 @@ __raw_spin_lock_flags (raw_spinlock_t *l
 #endif
 }
 
-#define _raw_spin_lock(lock) _raw_spin_lock_flags(lock, 0)
+#define __raw_spin_lock(lock) __raw_spin_lock_flags(lock, 0)
 
 /* Unlock by doing an ordered store and releasing the cacheline with nta */
-static inline void _raw_spin_unlock(spinlock_t *x) {
+static inline void __raw_spin_unlock(raw_spinlock_t *x) {
 	barrier();
 	asm volatile ("st4.rel.nta [%0] = r0\n\t" :: "r"(x));
 }
 
 #else /* !ASM_SUPPORTED */
-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
-# define _raw_spin_lock(x)								\
+#define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
+# define __raw_spin_lock(x)								\
 do {											\
 	__u32 *ia64_spinlock_ptr = (__u32 *) (x);					\
 	__u64 ia64_spinlock_val;							\
@@ -109,29 +109,20 @@ do {											\
 		} while (ia64_spinlock_val);						\
 	}										\
 } while (0)
-#define _raw_spin_unlock(x)	do { barrier(); ((spinlock_t *) x)->lock = 0; } while (0)
+#define __raw_spin_unlock(x)	do { barrier(); ((raw_spinlock_t *) x)->lock = 0; } while (0)
 #endif /* !ASM_SUPPORTED */
 
-#define spin_is_locked(x)	((x)->lock != 0)
-#define _raw_spin_trylock(x)	(cmpxchg_acq(&(x)->lock, 0, 1) == 0)
-#define spin_unlock_wait(x)	do { barrier(); } while ((x)->lock)
-
-typedef struct {
-	volatile unsigned int read_counter	: 24;
-	volatile unsigned int write_lock	:  8;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} rwlock_t;
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
+#define __raw_spin_is_locked(x)		((x)->lock != 0)
+#define __raw_spin_trylock(x)		(cmpxchg_acq(&(x)->lock, 0, 1) == 0)
+#define __raw_spin_unlock_wait(lock) \
+	do { while (__raw_spin_is_locked(lock)) cpu_relax(); } while (0)
 
-#define rwlock_init(x)		do { *(x) = RW_LOCK_UNLOCKED; } while(0)
-#define read_can_lock(rw)	(*(volatile int *)(rw) >= 0)
-#define write_can_lock(rw)	(*(volatile int *)(rw) == 0)
+#define __raw_read_can_lock(rw)		(*(volatile int *)(rw) >= 0)
+#define __raw_write_can_lock(rw)	(*(volatile int *)(rw) == 0)
 
-#define _raw_read_lock(rw)								\
+#define __raw_read_lock(rw)								\
 do {											\
-	rwlock_t *__read_lock_ptr = (rw);						\
+	raw_rwlock_t *__read_lock_ptr = (rw);						\
 											\
 	while (unlikely(ia64_fetchadd(1, (int *) __read_lock_ptr, acq) < 0)) {		\
 		ia64_fetchadd(-1, (int *) __read_lock_ptr, rel);			\
@@ -174,7 +165,7 @@ do {										\
 	(result == 0);								\
 })
 
-static inline void _raw_write_unlock(rwlock_t *x)
+static inline void __raw_write_unlock(raw_rwlock_t *x)
 {
 	u8 *y = (u8 *)x;
 	barrier();
@@ -202,7 +193,7 @@ static inline void _raw_write_unlock(rwl
 	(ia64_val == 0);						\
 })
 
-static inline void _raw_write_unlock(rwlock_t *x)
+static inline void __raw_write_unlock(raw_rwlock_t *x)
 {
 	barrier();
 	x->write_lock = 0;
@@ -210,6 +201,6 @@ static inline void _raw_write_unlock(rwl
 
 #endif /* !ASM_SUPPORTED */
 
-#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
+#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
 
 #endif /*  _ASM_IA64_SPINLOCK_H */
