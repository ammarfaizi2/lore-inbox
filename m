Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUDUEDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUDUEDt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 00:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264729AbUDUECF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 00:02:05 -0400
Received: from ip-66-80-228-130.sjc.megapath.net ([66.80.228.130]:22515 "EHLO
	sodium.co.intel.com") by vger.kernel.org with ESMTP id S264704AbUDUD6c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 23:58:32 -0400
Date: Tue, 20 Apr 2004 21:03:51 -0700
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com
Subject: [RFC/PATCH] FUSYN 5/11: Support for ppc
Message-ID: <0404202103.6cvckalaIdfdkbCcjbPaTd2cdcAdWbkc1457@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0404202103.Va9cbcgcHa9cJbkbodgdubRaHahaEbYd1457@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/ppc/kernel/misc.S   |   11 +++++--
 include/asm-ppc/fulock.h |   68 +++++++++++++++++++++++++++++++++++++++++++++++
 include/asm-ppc/unistd.h |    7 ++++
 3 files changed, 82 insertions(+), 4 deletions(-)

--- /dev/null	Thu Apr 15 00:58:25 2004
+++ include/asm-ppc/fulock.h Tue Apr 6 02:30:02 2004
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
+#ifndef __asm_ppc_fulock_h__
+#define __asm_ppc_fulock_h__
+
+/*
+ * fulock value / state; anything that is not this is a PID that
+ * currently owns the fulock.
+ */
+
+enum vfulock {
+	VFULOCK_UNLOCKED = 0x00000000, /* Unlocked */
+        VFULOCK_HEALTHY   = VFULOCK_UNLOCKED, /* KCO mode: the lock is healthy */
+	VFULOCK_WP       = 0xfffffffd, /* kernel controls ownership */
+	VFULOCK_DEAD     = 0xfffffffe, /* dead, kernel controls ownership */
+	VFULOCK_NR       = 0xffffffff  /* fulock is not-recoverable */
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
+#endif /* #ifndef __asm_ppc_fulock_h__ */
--- include/asm-ppc/unistd.h:1.1.1.4 Tue Apr 6 00:22:57 2004
+++ include/asm-ppc/unistd.h Tue Apr 6 02:16:30 2004
@@ -260,8 +260,13 @@
 #define __NR_fstatfs64		253
 #define __NR_fadvise64_64	254
 #define __NR_rtas		255
+#define __NR_ufulock_lock       256
+#define __NR_ufulock_unlock     257
+#define __NR_ufulock_ctl	258
+#define __NR_ufuqueue_wait      259
+#define __NR_ufuqueue_wake      260
 
-#define __NR_syscalls		256
+#define __NR_syscalls		261
 
 #define __NR(n)	#n
 
--- arch/ppc/kernel/misc.S:1.1.1.5 Tue Apr 6 00:22:00 2004
+++ arch/ppc/kernel/misc.S Tue Apr 6 02:15:36 2004
@@ -292,7 +292,7 @@
  * sense anyway.
  *    -- Cort
  */
-	mfmsr 	r4
+	mfmsr	r4
 	/* Copy all except the MSR_EE bit from r4 (current MSR value)
 	   to r3.  This is the sort of thing the rlwimi instruction is
 	   designed for.  -- paulus. */
@@ -976,7 +976,7 @@
  * R5    has shift count
  * result in R3/R4
  *
- *  ashrdi3: arithmetic right shift (sign propagation)	
+ *  ashrdi3: arithmetic right shift (sign propagation)
  *  lshrdi3: logical right shift
  *  ashldi3: left shift
  */
@@ -1314,7 +1314,7 @@
 	.long sys_fstat64
 	.long sys_pciconfig_read
 	.long sys_pciconfig_write
-	.long sys_pciconfig_iobase 	/* 200 */
+	.long sys_pciconfig_iobase	/* 200 */
 	.long sys_ni_syscall		/* 201 - reserved - MacOnLinux - new */
 	.long sys_getdents64
 	.long sys_pivot_root
@@ -1370,3 +1370,8 @@
 	.long sys_fstatfs64
 	.long ppc_fadvise64_64
 	.long sys_ni_syscall	/* 255 - rtas (used on ppc64) */
+	.long sys_ufulock_lock
+	.long sys_ufulock_unlock
+	.long sys_ufulock_ctl
+	.long sys_ufuqueue_wait
+	.long sys_ufuqueue_wake   /* 260 */
