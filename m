Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265592AbUANWta (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 17:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbUANWtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 17:49:02 -0500
Received: from fmr06.intel.com ([134.134.136.7]:11501 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264949AbUANWsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:48:00 -0500
Date: Wed, 14 Jan 2004 14:50:01 -0800
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com, robustmutexes@lists.osdl.org
Subject: [RFC/PATCH] FUSYN 3/10: Support for i386
Message-ID: <0401141450.RcyaPdRdEcCb6bPcedXbgbQaHdHbcbOc9031@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0401141449.dbBcncYdzckbldFceb8bkcYaHaIc2aoc9031@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/i386/kernel/entry.S  |    5 +++
 include/asm-i386/fulock.h |   70 ++++++++++++++++++++++++++++++++++++++++++++++
 include/asm-i386/unistd.h |    7 +++-
 3 files changed, 81 insertions(+), 1 deletion(-)

--- linux/arch/i386/kernel/entry.S:1.1.1.10	Tue Jan 13 21:13:29 2004
+++ linux/arch/i386/kernel/entry.S	Wed Jan 14 11:11:48 2004
@@ -1048,5 +1048,10 @@
 	.long sys_utimes
  	.long sys_fadvise64_64
 	.long sys_ni_syscall	/* sys_vserver */
+	.long sys_ufulock_lock
+	.long sys_ufulock_unlock	/* 275 */
+	.long sys_ufulock_consistency
+	.long sys_ufuqueue_wait        
+	.long sys_ufuqueue_wake	     /* 278 */
 
 syscall_table_size=(.-sys_call_table)
--- /dev/null	Wed Jan 14 14:39:30 2004
+++ linux/include/asm-i386/fulock.h	Wed Jan  7 12:46:28 2004
@@ -0,0 +1,70 @@
+
+/*
+ * Fast User real-time/pi/pp/robust/deadlock SYNchronization
+ * (C) 2002-2003 Intel Corp
+ * Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>.
+ *
+ * Licensed under the FSF's GNU Public License v2 or later.
+ *
+ * Based on normal futexes (futex.c), (C) Rusty Russell.
+ * Please refer to Documentation/fusyn.txt for more info.
+ */
+
+#ifndef __asm_i386_fulock_h__
+#define __asm_i386_fulock_h__
+
+    /* fulock value / state; anything that is not this is a PID that
+     * currently owns the fulock. */
+
+enum vfulock {
+	VFULOCK_UNLOCKED  = 0x00000000,	/* Unlocked */
+	VFULOCK_HEALTHY   = VFULOCK_UNLOCKED, /* KCO mode: the lock is healthy */
+	VFULOCK_KCO	  = 0xfffffffd,	/* kernel controls ownership */
+	VFULOCK_DEAD	  = 0xfffffffe,	/* dead, kernel controls ownership */
+	VFULOCK_NR	  = 0xffffffff	/* fulock is not-recoverable */
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
+		       unsigned old_value, unsigned new_value)
+{
+	unsigned result;
+	asm __volatile__ (
+		"lock cmpxchg %3, %1"
+		: "=a" (result), "+m" ((*value))
+		: "a" (old_value), "r" (new_value)
+		: "memory");
+	return result == old_value;
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
+	*vfulock = value;
+}
+
+#endif /* #ifdef __KERNEL__ */
+#endif /* #ifndef __asm_i386_fulock_h__ */
--- linux/include/asm-i386/unistd.h:1.1.1.5	Mon Oct 20 13:55:33 2003
+++ linux/include/asm-i386/unistd.h	Fri Nov 21 13:26:01 2003
@@ -279,8 +279,13 @@
 #define __NR_utimes		271
 #define __NR_fadvise64_64	272
 #define __NR_vserver		273
+#define __NR_ufulock_lock	274
+#define __NR_ufulock_unlock	275
+#define __NR_ufulock_consistency	276
+#define __NR_ufuqueue_wait	277
+#define __NR_ufuqueue_wake	278
 
-#define NR_syscalls 274
+#define NR_syscalls 279
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
