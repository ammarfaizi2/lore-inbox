Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264705AbUDUEDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264705AbUDUEDt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 00:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUDUECb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 00:02:31 -0400
Received: from ip-66-80-228-130.sjc.megapath.net ([66.80.228.130]:24819 "EHLO
	sodium.co.intel.com") by vger.kernel.org with ESMTP id S264705AbUDUD6h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 23:58:37 -0400
Date: Tue, 20 Apr 2004 21:03:56 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com
Subject: [RFC/PATCH] FUSYN 6/11: Support for ppc64
Message-ID: <0404202103.udQb1ctb~bBbHc8cVa0b0cwamc~a6aJc1457@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0404202103.6cvckalaIdfdkbCcjbPaTd2cdcAdWbkc1457@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/ppc64/kernel/misc.S   |    5 +++
 include/asm-ppc64/fulock.h |   68 +++++++++++++++++++++++++++++++++++++++++++++
 include/asm-ppc64/unistd.h |    7 +++-
 3 files changed, 79 insertions(+), 1 deletion(-)

--- /dev/null	Thu Apr 15 00:58:25 2004
+++ include/asm-ppc64/fulock.h Wed Apr 14 21:01:45 2004
@@ -0,0 +1,68 @@
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
+#ifndef __asm_ppc64_fulock_h__
+#define __asm_ppc64_fulock_h__
+
+/*
+ * fulock value / state; anything that is not this is a PID that
+ * currently owns the fulock.
+ */
+
+enum vfulock {
+	VFULOCK_UNLOCKED = 0x00000000, /* Unlocked */
+        VFULOCK_HEALTHY   = VFULOCK_UNLOCKED, /* KCO mode: the lock is healthy */
+	VFULOCK_KCO      = 0xfffffffd, /* KCO: kernel controls ownership */
+	VFULOCK_DEAD     = 0xfffffffe, /* KCO: dead, kernel controls ownership */
+	VFULOCK_NR       = 0xffffffff  /* KCO: fulock is not-recoverable */
+};
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
+
+	result = cmpxchg (value, old_value, new_value);
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
+#endif /* #ifndef __asm_ppc64_fulock_h__ */
--- include/asm-ppc64/unistd.h:1.1.1.4 Tue Apr 6 00:22:57 2004
+++ include/asm-ppc64/unistd.h Wed Apr 14 21:01:45 2004
@@ -266,8 +266,13 @@
 #define __NR_fstatfs64		253
 #define __NR_fadvise64_64	254
 #define __NR_rtas		255
+#define __NR_ufulock_lock	256
+#define __NR_ufulock_unlock	257
+#define __NR_ufulock_ctl	258
+#define __NR_ufuqueue_wait	259
+#define __NR_ufuqueue_wake	260
 
-#define __NR_syscalls		256
+#define __NR_syscalls		261
 #ifdef __KERNEL__
 #define NR_syscalls	__NR_syscalls
 #endif
--- arch/ppc64/kernel/misc.S:1.1.1.5 Tue Apr 6 00:22:01 2004
+++ arch/ppc64/kernel/misc.S Wed Apr 14 21:01:45 2004
@@ -1087,3 +1087,8 @@
 	.llong .sys_fstatfs64
 	.llong .sys_ni_syscall		/* 32bit only fadvise64_64 */
 	.llong .ppc_rtas		/* 255 */
+	.llong .sys_ufulock_lock
+	.llong .sys_ufulock_unlock
+	.llong .sys_ufulock_ctl
+	.llong .sys_ufuqueue_wait        
+	.llong .sys_ufuqueue_wake
