Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264558AbUANXHC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 18:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbUANXFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 18:05:23 -0500
Received: from fmr06.intel.com ([134.134.136.7]:10891 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265141AbUANXDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 18:03:13 -0500
Date: Wed, 14 Jan 2004 14:50:06 -0800
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com, robustmutexes@lists.osdl.org
Subject: [RFC/PATCH] FUSYN 4/10: Support for ia64
Message-ID: <0401141450.iarcJcJcWaOdRbVdkc.c1c.bKcraCddb9031@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0401141450.RcyaPdRdEcCb6bPcedXbgbQaHdHbcbOc9031@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/ia64/kernel/entry.S  |   10 +++---
 include/asm-ia64/fulock.h |   75 ++++++++++++++++++++++++++++++++++++++++++++++
 include/asm-ia64/unistd.h |    8 ++++
 3 files changed, 87 insertions(+), 6 deletions(-)

--- linux/arch/ia64/kernel/entry.S:1.1.1.7	Tue Jan 13 20:54:35 2004
+++ linux/arch/ia64/kernel/entry.S	Wed Jan 14 11:11:48 2004
@@ -1469,11 +1469,11 @@
 	data8 sys_fstatfs64
 	data8 sys_statfs64
 	data8 sys_ni_syscall
-	data8 sys_ni_syscall			// 1260
-	data8 sys_ni_syscall
-	data8 sys_ni_syscall
-	data8 sys_ni_syscall
-	data8 sys_ni_syscall
+        data8 sys_ufulock_lock			// 1260
+        data8 sys_ufulock_unlock
+        data8 sys_ufulock_consistency
+        data8 sys_ufuqueue_wait
+        data8 sys_ufuqueue_wake
 	data8 sys_ni_syscall			// 1265
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
--- /dev/null	Wed Jan 14 14:39:30 2004
+++ linux/include/asm-ia64/fulock.h	Wed Jan  7 12:46:36 2004
@@ -0,0 +1,75 @@
+
+/*
+ * Fast User real-time/pi/pp/robust/deadlock SYNchronization
+ * (C) 2002-2003 Intel Corp
+ * David P. Howell <david.p.howell@intel.com>
+ *
+ * Licensed under the FSF's GNU Public License v2 or later.
+ *
+ * Based on normal futexes (futex.c), (C) Rusty Russell.
+ * Please refer to Documentation/fusyn.txt for more info.
+ */
+
+#ifndef __asm_ia64_fulock_h__
+#define __asm_ia64_fulock_h__
+
+    /* fulock value / state; anything that is not this is a PID that
+     * currently owns the fulock. */
+
+enum vfulock {
+	VFULOCK_UNLOCKED  = 0x00000000, /* Unlocked */
+	VFULOCK_HEALTHY   = VFULOCK_UNLOCKED, /* KCO mode: the lock is healthy */
+	VFULOCK_KCO       = 0xfffffffd, /* kernel controls ownership */
+	VFULOCK_DEAD      = 0xfffffffe, /* dead, kernel controls ownership */
+	VFULOCK_NR        = 0xffffffff  /* fulock is not-recoverable */
+};
+
+
+#ifdef __KERNEL__
+
+/**
+ * [User usable] Atomic compare and swap.
+ *
+ * Used for locking a vfulock.
+ *
+ * @value     Pointer to the value to compare and swap.
+ * @old_value Value that *value has to have for the swap to occur.
+ * @new_value New value to set it *value == old_value.
+ * @return    !0 if the swap succeeded. 0 if failed.
+ */
+static inline
+unsigned vfulock_acas (volatile unsigned *value,
+                       unsigned old_value, unsigned new_value)
+{
+	unsigned retval;
+
+	/* The following should be the expansion of the cmpxchg_acq() */
+	/* macro from intrinsics.h. Needed this due to glibc builds   */
+	/* issues with including asm/types.h.			      */
+	asm volatile ("mov ar.ccv=%0;;" :: "rO"(old_value));
+	asm volatile ("cmpxchg4.acq %0=[%1],%2,ar.ccv"
+			 : "=r"(retval) 
+			 : "r"(value), 
+			   "r"(new_value)
+			 : "memory");
+	return retval == old_value;
+}
+
+
+/**
+ * Set an ufulock's associated value.
+ *
+ * @vfulock: Pointer to the address of the ufulock to contain for.
+ * @value:    New value to assign.
+ *
+ * Wrapper for arch-specific idiosyncrasies when setting a value that
+ * is shared across different address mappings.
+ */
+static inline
+void vfulock_set (volatile unsigned *vfulock, unsigned value)
+{
+        *vfulock = value;
+}
+
+#endif /* #ifdef __KERNEL__ */
+#endif /* #ifndef __asm_ia64_fulock_h__ */
--- linux/include/asm-ia64/unistd.h:1.1.1.6	Mon Oct 20 13:56:48 2003
+++ linux/include/asm-ia64/unistd.h	Fri Nov 21 13:26:01 2003
@@ -248,10 +248,16 @@
 #define __NR_clock_nanosleep		1256
 #define __NR_fstatfs64			1257
 #define __NR_statfs64			1258
+/* Hole: 1259 */
+#define __NR_ufulock_lock		1260
+#define __NR_ufulock_unlock		1261
+#define __NR_ufulock_consistency	1262
+#define __NR_ufuqueue_wait		1263
+#define __NR_ufuqueue_wake		1264
 
 #ifdef __KERNEL__
 
-#define NR_syscalls			256 /* length of syscall table */
+#define NR_syscalls			265 /* length of syscall table */
 
 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)
 
