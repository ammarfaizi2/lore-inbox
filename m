Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbUL1I0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbUL1I0z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 03:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbUL1I0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 03:26:55 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:42142 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261766AbUL1I0d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 03:26:33 -0500
Date: Tue, 28 Dec 2004 09:24:59 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] s390: core patches
Message-ID: <20041228082459.GB7988@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 1/8] s390: core changes.

From: Heiko Carstens <heiko.carstens@de.ibm.com>

s390 core changes:
 - Disable pfault pseudo page faults before stopping a cpu.
 - Add exception table for diag10 instruction.
 - Move initialization of active_mm of idle task to smp_create_idle.
 - Regenerate default configuration.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

diffstat:
 arch/s390/defconfig      |    9 +++++++--
 arch/s390/kernel/setup.c |    3 ---
 arch/s390/kernel/smp.c   |    9 ++++++++-
 arch/s390/mm/init.c      |   21 +++++++++++++++++----
 4 files changed, 32 insertions(+), 10 deletions(-)

diff -urN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2004-12-24 22:35:25.000000000 +0100
+++ linux-2.6-patched/arch/s390/defconfig	2004-12-28 08:50:46.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc2
-# Tue Nov 30 14:00:30 2004
+# Linux kernel version: 2.6.10
+# Mon Dec 27 11:03:23 2004
 #
 CONFIG_MMU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
@@ -158,6 +158,7 @@
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
@@ -567,6 +568,10 @@
 # CONFIG_CRYPTO_TEST is not set
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
diff -urN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2004-12-24 22:33:52.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2004-12-28 08:50:46.000000000 +0100
@@ -98,9 +98,6 @@
         clear_thread_flag(TIF_USEDFPU);
         current->used_math = 0;
 
-        /* Setup active_mm for idle_task  */
-        atomic_inc(&init_mm.mm_count);
-        current->active_mm = &init_mm;
         if (current->mm)
                 BUG();
         enter_lazy_tlb(&init_mm, current);
diff -urN linux-2.6/arch/s390/kernel/smp.c linux-2.6-patched/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/smp.c	2004-12-28 08:50:46.000000000 +0100
@@ -535,7 +535,7 @@
 extern void init_cpu_timer(void);
 extern void init_cpu_vtimer(void);
 extern int pfault_init(void);
-extern int pfault_token(void);
+extern void pfault_fini(void);
 
 int __devinit start_secondary(void *cpuvoid)
 {
@@ -571,6 +571,8 @@
 	p = fork_idle(cpu);
 	if (IS_ERR(p))
 		panic("failed fork for CPU %u: %li", cpu, PTR_ERR(p));
+	atomic_inc(&init_mm.mm_count);
+	p->active_mm = &init_mm;
 	current_set[cpu] = p;
 }
 
@@ -695,6 +697,11 @@
 		return -EBUSY;
 	}
 
+#ifdef CONFIG_PFAULT
+	/* Disable pfault pseudo page faults on this cpu. */
+	pfault_fini();
+#endif
+
 	/* disable all external interrupts */
 
 	cr_parms.start_ctl = 0;
diff -urN linux-2.6/arch/s390/mm/init.c linux-2.6-patched/arch/s390/mm/init.c
--- linux-2.6/arch/s390/mm/init.c	2004-12-24 22:35:23.000000000 +0100
+++ linux-2.6-patched/arch/s390/mm/init.c	2004-12-28 08:50:46.000000000 +0100
@@ -45,11 +45,24 @@
         if (addr >= 0x7ff00000)
                 return;
 #ifdef __s390x__
-        asm volatile ("sam31\n\t"
-                      "diag %0,%0,0x10\n\t"
-                      "sam64" : : "a" (addr) );
+        asm volatile (
+		"   sam31\n"
+		"   diag %0,%0,0x10\n"
+		"0: sam64\n"
+		".section __ex_table,\"a\"\n"
+		"   .align 8\n"
+		"   .quad 0b, 0b\n"
+		".previous\n"
+		: : "a" (addr));
 #else
-        asm volatile ("diag %0,%0,0x10" : : "a" (addr) );
+        asm volatile (
+		"   diag %0,%0,0x10\n"
+		"0:\n"
+		".section __ex_table,\"a\"\n"
+		"   .align 4\n"
+		"   .long 0b, 0b\n"
+		".previous\n"
+		: : "a" (addr));
 #endif
 }
 
