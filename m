Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264703AbUDUEBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264703AbUDUEBp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 00:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbUDUEBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 00:01:43 -0400
Received: from ip-66-80-228-130.sjc.megapath.net ([66.80.228.130]:20211 "EHLO
	sodium.co.intel.com") by vger.kernel.org with ESMTP id S264703AbUDUD61
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 23:58:27 -0400
Date: Tue, 20 Apr 2004 21:03:46 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com
Subject: [RFC/PATCH] FUSYN 4/11: Support for ia64
Message-ID: <0404202103.Va9cbcgcHa9cJbkbodgdubRaHahaEbYd1457@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0404202103.7dddec5a7cpbMcecWavajakcibKb5ckb1457@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/ia64/kernel/entry.S  |   10 +++---
 include/asm-ia64/fulock.h |   75 ++++++++++++++++++++++++++++++++++++++++++++++
 include/asm-ia64/unistd.h |    8 ++++
 3 files changed, 87 insertions(+), 6 deletions(-)

--- include/asm-ia64/unistd.h:1.1.1.7 Tue Apr 6 00:22:52 2004
+++ include/asm-ia64/unistd.h Tue Apr 6 02:16:25 2004
@@ -248,13 +248,19 @@
 #define __NR_clock_nanosleep		1256
 #define __NR_fstatfs64			1257
 #define __NR_statfs64			1258
+/* Hole: 1259 */
 #define __NR_reserved1			1259	/* reserved for NUMA interface */
 #define __NR_reserved2			1260	/* reserved for NUMA interface */
 #define __NR_reserved3			1261	/* reserved for NUMA interface */
+#define __NR_ufulock_lock		1262
+#define __NR_ufulock_unlock		1263
+#define __NR_ufulock_ctl		1264
+#define __NR_ufuqueue_wait		1265
+#define __NR_ufuqueue_wake		1266
 
 #ifdef __KERNEL__
 
-#define NR_syscalls			256 /* length of syscall table */
+#define NR_syscalls			265 /* length of syscall table */
 
 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)
 
--- arch/ia64/kernel/entry.S:1.1.1.8 Tue Apr 6 00:21:45 2004
+++ arch/ia64/kernel/entry.S Tue Apr 6 02:15:29 2004
@@ -1502,11 +1502,11 @@
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
+        data8 sys_ufulock_ctl
+        data8 sys_ufuqueue_wait
+        data8 sys_ufuqueue_wake
 	data8 sys_ni_syscall			// 1265
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
--- /dev/null	Thu Apr 15 00:58:25 2004
+++ include/asm-ia64/fulock.h Mon Feb 2 23:07:33 2004
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
+	VFULOCK_WP        = 0xfffffffd, /* Waiters blocked in the kernel */
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
