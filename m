Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265495AbUGDKPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265495AbUGDKPY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 06:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbUGDKPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 06:15:24 -0400
Received: from ozlabs.org ([203.10.76.45]:5259 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265495AbUGDKPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 06:15:07 -0400
Date: Sun, 4 Jul 2004 20:11:58 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] SPLPAR spinlock optimisation
Message-ID: <20040704101158.GF4923@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently our spinlocks can call into the hypervisor on dedicated
processor machines. Doing this may slow our locks down, so avoid it
where possible.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/lib/locks.c~splpar_speedup arch/ppc64/lib/locks.c
--- foobar2/arch/ppc64/lib/locks.c~splpar_speedup	2004-07-04 19:40:39.518987541 +1000
+++ foobar2-anton/arch/ppc64/lib/locks.c	2004-07-04 19:55:27.966154716 +1000
@@ -38,6 +38,10 @@
 
 /* waiting for a spinlock... */
 #if defined(CONFIG_PPC_SPLPAR) || defined(CONFIG_PPC_ISERIES)
+
+/* We only yield to the hypervisor if we are in shared processor mode */
+#define SHARED_PROCESSOR (get_paca()->lppaca.xSharedProc)
+
 void __spin_yield(spinlock_t *lock)
 {
 	unsigned int lock_value, holder_cpu, yield_count;
@@ -65,6 +69,7 @@ void __spin_yield(spinlock_t *lock)
 
 #else /* SPLPAR || ISERIES */
 #define __spin_yield(x)	barrier()
+#define SHARED_PROCESSOR	0
 #endif
 
 /*
@@ -104,7 +109,8 @@ void _raw_spin_lock(spinlock_t *lock)
 			break;
 		do {
 			HMT_low();
-			__spin_yield(lock);
+			if (SHARED_PROCESSOR)
+				__spin_yield(lock);
 		} while (likely(lock->lock != 0));
 		HMT_medium();
 	}
@@ -123,7 +129,8 @@ void _raw_spin_lock_flags(spinlock_t *lo
 		local_irq_restore(flags);
 		do {
 			HMT_low();
-			__spin_yield(lock);
+			if (SHARED_PROCESSOR)
+				__spin_yield(lock);
 		} while (likely(lock->lock != 0));
 		HMT_medium();
 		local_irq_restore(flags_dis);
@@ -134,8 +141,12 @@ EXPORT_SYMBOL(_raw_spin_lock_flags);
 
 void spin_unlock_wait(spinlock_t *lock)
 {
-	while (lock->lock)
-		__spin_yield(lock);
+	while (lock->lock) {
+		HMT_low();
+		if (SHARED_PROCESSOR)
+			__spin_yield(lock);
+	}
+	HMT_medium();
 }
 
 EXPORT_SYMBOL(spin_unlock_wait);
@@ -213,7 +224,8 @@ void _raw_read_lock(rwlock_t *rw)
 			break;
 		do {
 			HMT_low();
-			__rw_yield(rw);
+			if (SHARED_PROCESSOR)
+				__rw_yield(rw);
 		} while (likely(rw->lock < 0));
 		HMT_medium();
 	}
@@ -275,7 +287,8 @@ void _raw_write_lock(rwlock_t *rw)
 			break;
 		do {
 			HMT_low();
-			__rw_yield(rw);
+			if (SHARED_PROCESSOR)
+				__rw_yield(rw);
 		} while (likely(rw->lock != 0));
 		HMT_medium();
 	}

_
