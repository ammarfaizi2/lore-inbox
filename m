Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264728AbUDUEDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264728AbUDUEDu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 00:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264721AbUDUEBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 00:01:22 -0400
Received: from ip-66-80-228-130.sjc.megapath.net ([66.80.228.130]:15859 "EHLO
	sodium.co.intel.com") by vger.kernel.org with ESMTP id S264702AbUDUD6W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 23:58:22 -0400
Date: Tue, 20 Apr 2004 21:03:41 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com
Subject: [RFC/PATCH] FUSYN 3/11: Support for i386
Message-ID: <0404202103.7dddec5a7cpbMcecWavajakcibKb5ckb1457@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0404202103.Eajc1b.dndIaLbXawacc8drbScVdPaPa1457@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/i386/kernel/entry.S  |    5 +++
 include/asm-i386/fulock.h |   70 ++++++++++++++++++++++++++++++++++++++++++++++
 include/asm-i386/unistd.h |    7 +++-
 3 files changed, 81 insertions(+), 1 deletion(-)

--- arch/i386/kernel/entry.S:1.1.1.13 Tue Apr 6 01:51:19 2004
+++ arch/i386/kernel/entry.S Tue Apr 6 02:15:23 2004
@@ -882,5 +882,10 @@
 	.long sys_utimes
  	.long sys_fadvise64_64
 	.long sys_ni_syscall	/* sys_vserver */
+	.long sys_ufulock_lock
+	.long sys_ufulock_unlock	/* 275 */
+	.long sys_ufulock_ctl
+	.long sys_ufuqueue_wait        
+	.long sys_ufuqueue_wake	     /* 278 */
 
 syscall_table_size=(.-sys_call_table)
--- /dev/null	Thu Apr 15 00:58:25 2004
+++ include/asm-i386/fulock.h Mon Feb 2 23:07:28 2004
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
+	VFULOCK_WP	  = 0xfffffffd,	/* Waiters blocked in the kernel */
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
--- include/asm-i386/unistd.h:1.1.1.8 Tue Apr 6 01:51:33 2004
+++ include/asm-i386/unistd.h Tue Apr 6 02:16:24 2004
@@ -279,8 +279,13 @@
 #define __NR_utimes		271
 #define __NR_fadvise64_64	272
 #define __NR_vserver		273
+#define __NR_ufulock_lock	274
+#define __NR_ufulock_unlock	275
+#define __NR_ufulock_ctl	276
+#define __NR_ufuqueue_wait	277
+#define __NR_ufuqueue_wake	278
 
-#define NR_syscalls 274
+#define NR_syscalls 279
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
