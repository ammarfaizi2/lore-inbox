Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267212AbUIJCeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267212AbUIJCeb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 22:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267511AbUIJCeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 22:34:31 -0400
Received: from holomorphy.com ([207.189.100.168]:38016 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267212AbUIJCdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 22:33:08 -0400
Date: Thu, 9 Sep 2004 19:32:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
Message-ID: <20040910023258.GB2616@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Paul Mackerras <paulus@samba.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>
References: <16704.52551.846184.630652@cargo.ozlabs.ibm.com> <20040909220040.GM3106@holomorphy.com> <16704.59668.899674.868174@cargo.ozlabs.ibm.com> <20040910000903.GS3106@holomorphy.com> <Pine.LNX.4.58.0409091712270.5912@ppc970.osdl.org> <20040910003505.GG11358@krispykreme> <Pine.LNX.4.58.0409091750300.5912@ppc970.osdl.org> <20040910014228.GH11358@krispykreme> <20040910015040.GI11358@krispykreme> <20040910022204.GA2616@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910022204.GA2616@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 11:50:41AM +1000, Anton Blanchard wrote:
>> Lets just make __preempt_spin_lock inline, then everything should work
>> as is.

On Thu, Sep 09, 2004 at 07:22:04PM -0700, William Lee Irwin III wrote:
> Well, there are patches that do this along with other more useful
> things in the works (my spin on this is en route shortly, sorry the
> response was delayed due to a power failure).

I ran into instant pain because various read_lock() -related locking
primitives don't exist... first approximation:

This patch folds __preempt_spin_lock() and __preempt_write_lock() into
their callers, and follows Ingo's patch in sweeping various other locking
variants into doing likewise for CONFIG_PREEMPT=y && CONFIG_SMP=y.

Compiletested on ia64.


Index: mm4-2.6.9-rc1/kernel/sched.c
===================================================================
--- mm4-2.6.9-rc1.orig/kernel/sched.c	2004-09-08 06:10:47.000000000 -0700
+++ mm4-2.6.9-rc1/kernel/sched.c	2004-09-09 18:59:53.723177997 -0700
@@ -4572,49 +4572,3 @@
 }
 EXPORT_SYMBOL(__might_sleep);
 #endif
-
-
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
-/*
- * This could be a long-held lock.  If another CPU holds it for a long time,
- * and that CPU is not asked to reschedule then *this* CPU will spin on the
- * lock for a long time, even if *this* CPU is asked to reschedule.
- *
- * So what we do here, in the slow (contended) path is to spin on the lock by
- * hand while permitting preemption.
- *
- * Called inside preempt_disable().
- */
-void __sched __preempt_spin_lock(spinlock_t *lock)
-{
-	if (preempt_count() > 1) {
-		_raw_spin_lock(lock);
-		return;
-	}
-	do {
-		preempt_enable();
-		while (spin_is_locked(lock))
-			cpu_relax();
-		preempt_disable();
-	} while (!_raw_spin_trylock(lock));
-}
-
-EXPORT_SYMBOL(__preempt_spin_lock);
-
-void __sched __preempt_write_lock(rwlock_t *lock)
-{
-	if (preempt_count() > 1) {
-		_raw_write_lock(lock);
-		return;
-	}
-
-	do {
-		preempt_enable();
-		while (rwlock_is_locked(lock))
-			cpu_relax();
-		preempt_disable();
-	} while (!_raw_write_trylock(lock));
-}
-
-EXPORT_SYMBOL(__preempt_write_lock);
-#endif /* defined(CONFIG_SMP) && defined(CONFIG_PREEMPT) */
Index: mm4-2.6.9-rc1/kernel/spinlock.c
===================================================================
--- mm4-2.6.9-rc1.orig/kernel/spinlock.c	2004-09-08 06:10:36.000000000 -0700
+++ mm4-2.6.9-rc1/kernel/spinlock.c	2004-09-09 19:34:54.890144445 -0700
@@ -33,90 +33,274 @@
 }
 EXPORT_SYMBOL(_write_trylock);
 
+
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+/*
+ * This could be a long-held lock.  If another CPU holds it for a long time,
+ * and that CPU is not asked to reschedule then *this* CPU will spin on the
+ * lock for a long time, even if *this* CPU is asked to reschedule.
+ * So what we do here, in the slow (contended) path is to spin on the lock by
+ * hand while permitting preemption.
+ */
 void __lockfunc _spin_lock(spinlock_t *lock)
 {
 	preempt_disable();
-	if (unlikely(!_raw_spin_trylock(lock)))
-		__preempt_spin_lock(lock);
+	if (unlikely(!_raw_spin_trylock(lock))) {
+		if (preempt_count() > 1)
+			_raw_spin_lock(lock);
+		else {
+			do {
+				preempt_enable();
+				while (spin_is_locked(lock))
+					cpu_relax();
+				preempt_disable();
+			} while (!_raw_spin_trylock(lock));
+		}
+	}
 }
 
-void __lockfunc _write_lock(rwlock_t *lock)
+void __lockfunc _spin_lock_irq(spinlock_t *lock)
 {
+	local_irq_disable();
 	preempt_disable();
-	if (unlikely(!_raw_write_trylock(lock)))
-		__preempt_write_lock(lock);
+	if (unlikely(!_raw_spin_trylock(lock))) {
+		if (preempt_count() > 1)
+			_raw_spin_lock(lock);
+		else {
+			do {
+				preempt_enable();
+				local_irq_enable();
+				while (spin_is_locked(lock))
+					cpu_relax();
+				preempt_disable();
+				local_irq_disable();
+			} while (!_raw_spin_trylock(lock));
+		}
+	}
 }
-#else
-void __lockfunc _spin_lock(spinlock_t *lock)
+
+unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)
 {
+	unsigned long flags;
+
+	local_irq_save(flags);
 	preempt_disable();
-	_raw_spin_lock(lock);
+	if (unlikely(!_raw_spin_trylock(lock))) {
+		if (preempt_count() > 1)
+			_raw_spin_lock_flags(lock, flags);
+		else {
+			do {
+				preempt_enable();
+				local_irq_restore(flags);
+				while (spin_is_locked(lock))
+					cpu_relax();
+				preempt_disable();
+				local_irq_save(flags);
+			} while (!_raw_spin_trylock(lock));
+		}
+	}
+	return flags;
+}
+
+void __lockfunc _spin_lock_bh(spinlock_t *lock)
+{
+	local_bh_disable();
+	preempt_disable();
+	if (unlikely(!_raw_spin_trylock(lock))) {
+		if (preempt_count() > 1)
+			_raw_spin_lock(lock);
+		else {
+			do {
+				preempt_enable();
+				local_bh_enable();
+				while (spin_is_locked(lock))
+					cpu_relax();
+				preempt_disable();
+				local_bh_disable();
+			} while (!_raw_spin_trylock(lock));
+		}
+	}
 }
 
 void __lockfunc _write_lock(rwlock_t *lock)
 {
 	preempt_disable();
-	_raw_write_lock(lock);
+	if (unlikely(!_raw_write_trylock(lock))) {
+		if (preempt_count() > 1)
+			_raw_write_lock(lock);
+		else {
+			do {
+				preempt_enable();
+				while (rwlock_is_locked(lock))
+					cpu_relax();
+				preempt_disable();
+			} while (!_raw_write_trylock(lock));
+		}
+	}
 }
-#endif
-EXPORT_SYMBOL(_spin_lock);
-EXPORT_SYMBOL(_write_lock);
 
-void __lockfunc _read_lock(rwlock_t *lock)
+void __lockfunc _write_lock_irq(rwlock_t *lock)
 {
+	local_irq_disable();
 	preempt_disable();
-	_raw_read_lock(lock);
+	if (unlikely(!_raw_write_trylock(lock))) {
+		if (preempt_count() > 1)
+			_raw_write_lock(lock);
+		else {
+			do {
+				preempt_enable();
+				local_irq_enable();
+				while (rwlock_is_locked(lock))
+					cpu_relax();
+				preempt_disable();
+				local_irq_disable();
+			} while (!_raw_write_trylock(lock));
+		}
+	}
 }
-EXPORT_SYMBOL(_read_lock);
 
-void __lockfunc _spin_unlock(spinlock_t *lock)
+unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock)
 {
-	_raw_spin_unlock(lock);
-	preempt_enable();
+	unsigned long flags;
+
+	local_irq_save(flags);
+	preempt_disable();
+	if (unlikely(!_raw_write_trylock(lock))) {
+		if (preempt_count() > 1)
+			_raw_write_lock(lock);
+		else {
+			do {
+				preempt_enable();
+				local_irq_restore(flags);
+				while (rwlock_is_locked(lock))
+					cpu_relax();
+				local_irq_save(flags);
+				preempt_disable();
+			} while (!_raw_write_trylock(lock));
+		}
+	}
+	return flags;
 }
-EXPORT_SYMBOL(_spin_unlock);
 
-void __lockfunc _write_unlock(rwlock_t *lock)
+void __lockfunc _write_lock_bh(rwlock_t *lock)
 {
-	_raw_write_unlock(lock);
-	preempt_enable();
+	local_bh_disable();
+	preempt_disable();
+	if (unlikely(!_raw_write_trylock(lock))) {
+		if (preempt_count() > 1)
+			_raw_write_lock(lock);
+		else {
+			do {
+				preempt_enable();
+				local_bh_enable();
+				while (rwlock_is_locked(lock))
+					cpu_relax();
+				local_bh_disable();
+				preempt_disable();
+			} while (!_raw_write_trylock(lock));
+		}
+	}
+}
+
+#ifdef NOTYET
+/*
+ * XXX: FIXME architectures don't implement locking primitives used here:
+ * _raw_read_trylock()
+ * _raw_read_lock_flags()
+ * rwlock_is_write_locked()
+ */
+void __lockfunc _read_lock(rwlock_t *lock)
+{
+	preempt_disable();
+	if (unlikely(!_raw_read_trylock(lock))) {
+		if (preempt_count() > 1)
+			_raw_read_lock(lock);
+		else {
+			do {
+				preempt_enable();
+				while (rwlock_is_write_locked(lock))
+					cpu_relax();
+				preempt_disable();
+			} while (!_raw_read_trylock(lock));
+		}
+	}
 }
-EXPORT_SYMBOL(_write_unlock);
 
-void __lockfunc _read_unlock(rwlock_t *lock)
+void __lockfunc _read_lock_irq(rwlock_t *lock)
 {
-	_raw_read_unlock(lock);
-	preempt_enable();
+	local_irq_disable();
+	preempt_disable();
+	if (unlikely(!_raw_read_trylock(lock))) {
+		if (preempt_count() > 1)
+			_raw_read_lock(lock);
+		else {
+			do {
+				preempt_enable();
+				local_irq_enable();
+				while (rwlock_is_write_locked(lock))
+					cpu_relax();
+				local_irq_disable();
+				preempt_disable();
+			} while (!_raw_read_trylock(lock));
+		}
+	}
 }
-EXPORT_SYMBOL(_read_unlock);
 
-unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)
+unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
 	preempt_disable();
-	_raw_spin_lock_flags(lock, flags);
+	if (unlikely(!_raw_read_trylock(lock))) {
+		if (preempt_count() > 1)
+			_raw_read_lock_flags(lock, flags);
+		else {
+			do {
+				preempt_enable();
+				local_irq_restore(flags);
+				while (rwlock_is_write_locked(lock))
+					cpu_relax();
+				local_irq_save(flags);
+				preempt_disable();
+			} while (!_raw_read_trylock(lock));
+		}
+	}
 	return flags;
 }
-EXPORT_SYMBOL(_spin_lock_irqsave);
 
-void __lockfunc _spin_lock_irq(spinlock_t *lock)
+void __lockfunc _read_lock_bh(rwlock_t *lock)
 {
-	local_irq_disable();
+	local_bh_disable();
 	preempt_disable();
-	_raw_spin_lock(lock);
+	if (unlikely(_raw_read_trylock(lock))) {
+		if (preempt_count() > 1)
+			_raw_read_lock(lock);
+		else {
+			do {
+				preempt_enable();
+				local_bh_enable();
+				while (rwlock_is_write_locked(lock))
+					cpu_relax();
+				local_bh_disable();
+				preempt_disable();
+			} while (!_raw_read_trylock(lock));
+		}
+	}
+}
+#else /* NOTYET */
+void __lockfunc _read_lock(rwlock_t *lock)
+{
+	preempt_disable();
+	_raw_read_lock(lock);
 }
-EXPORT_SYMBOL(_spin_lock_irq);
 
-void __lockfunc _spin_lock_bh(spinlock_t *lock)
+void __lockfunc _read_lock_irq(rwlock_t *lock)
 {
-	local_bh_disable();
+	local_irq_disable();
 	preempt_disable();
-	_raw_spin_lock(lock);
+	_raw_read_lock(lock);
 }
-EXPORT_SYMBOL(_spin_lock_bh);
 
 unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock)
 {
@@ -127,34 +311,51 @@
 	_raw_read_lock(lock);
 	return flags;
 }
-EXPORT_SYMBOL(_read_lock_irqsave);
 
-void __lockfunc _read_lock_irq(rwlock_t *lock)
+void __lockfunc _read_lock_bh(rwlock_t *lock)
 {
-	local_irq_disable();
+	local_bh_disable();
 	preempt_disable();
 	_raw_read_lock(lock);
 }
-EXPORT_SYMBOL(_read_lock_irq);
+#endif /* NOTYET */
 
-void __lockfunc _read_lock_bh(rwlock_t *lock)
+#else /* !CONFIG_PREEMPT */
+void __lockfunc _spin_lock(spinlock_t *lock)
 {
-	local_bh_disable();
 	preempt_disable();
-	_raw_read_lock(lock);
+	_raw_spin_lock(lock);
 }
-EXPORT_SYMBOL(_read_lock_bh);
 
-unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock)
+void __lockfunc _spin_lock_irq(spinlock_t *lock)
+{
+	local_irq_disable();
+	preempt_disable();
+	_raw_spin_lock(lock);
+}
+
+unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
 	preempt_disable();
-	_raw_write_lock(lock);
+	_raw_spin_lock_flags(lock, flags);
 	return flags;
 }
-EXPORT_SYMBOL(_write_lock_irqsave);
+
+void __lockfunc _spin_lock_bh(spinlock_t *lock)
+{
+	local_bh_disable();
+	preempt_disable();
+	_raw_spin_lock(lock);
+}
+
+void __lockfunc _write_lock(rwlock_t *lock)
+{
+	preempt_disable();
+	_raw_write_lock(lock);
+}
 
 void __lockfunc _write_lock_irq(rwlock_t *lock)
 {
@@ -162,7 +363,16 @@
 	preempt_disable();
 	_raw_write_lock(lock);
 }
-EXPORT_SYMBOL(_write_lock_irq);
+
+unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	preempt_disable();
+	_raw_write_lock(lock);
+	return flags;
+}
 
 void __lockfunc _write_lock_bh(rwlock_t *lock)
 {
@@ -170,8 +380,71 @@
 	preempt_disable();
 	_raw_write_lock(lock);
 }
+
+void __lockfunc _read_lock(rwlock_t *lock)
+{
+	preempt_disable();
+	_raw_read_lock(lock);
+}
+
+void __lockfunc _read_lock_irq(rwlock_t *lock)
+{
+	local_irq_disable();
+	preempt_disable();
+	_raw_read_lock(lock);
+}
+
+unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	preempt_disable();
+	_raw_read_lock(lock);
+	return flags;
+}
+
+void __lockfunc _read_lock_bh(rwlock_t *lock)
+{
+	local_bh_disable();
+	preempt_disable();
+	_raw_read_lock(lock);
+}
+#endif
+EXPORT_SYMBOL(_spin_lock);
+EXPORT_SYMBOL(_write_lock);
+EXPORT_SYMBOL(_read_lock);
+EXPORT_SYMBOL(_spin_lock_irq);
+EXPORT_SYMBOL(_spin_lock_irqsave);
+EXPORT_SYMBOL(_spin_lock_bh);
+EXPORT_SYMBOL(_read_lock_irq);
+EXPORT_SYMBOL(_read_lock_irqsave);
+EXPORT_SYMBOL(_read_lock_bh);
+EXPORT_SYMBOL(_write_lock_irq);
+EXPORT_SYMBOL(_write_lock_irqsave);
 EXPORT_SYMBOL(_write_lock_bh);
 
+void __lockfunc _spin_unlock(spinlock_t *lock)
+{
+	_raw_spin_unlock(lock);
+	preempt_enable();
+}
+EXPORT_SYMBOL(_spin_unlock);
+
+void __lockfunc _write_unlock(rwlock_t *lock)
+{
+	_raw_write_unlock(lock);
+	preempt_enable();
+}
+EXPORT_SYMBOL(_write_unlock);
+
+void __lockfunc _read_unlock(rwlock_t *lock)
+{
+	_raw_read_unlock(lock);
+	preempt_enable();
+}
+EXPORT_SYMBOL(_read_unlock);
+
 void __lockfunc _spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
 {
 	_raw_spin_unlock(lock);
