Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271305AbUJVMkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271305AbUJVMkO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 08:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271279AbUJVMd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 08:33:26 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:11440 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S271267AbUJVMZe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 08:25:34 -0400
Date: Fri, 22 Oct 2004 14:25:23 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 2/6] s390: core changes.
Message-ID: <20041022122523.GC3720@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 2/6] s390: core changes.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

s390 core changes:
 - Load pid to cr4 on context switch.
 - Correct and check buffer length of cpcmd. Fix cpcmd inline assembly.
 - Add missing cc clobber to do_softirq insline assembly.
 - Regenerate default configuration.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/defconfig            |   13 +++++++++++--
 arch/s390/kernel/asm-offsets.c |    2 ++
 arch/s390/kernel/cpcmd.c       |   23 ++++++++++++-----------
 arch/s390/kernel/entry.S       |    1 +
 arch/s390/kernel/entry64.S     |    1 +
 arch/s390/kernel/irq.c         |    2 +-
 6 files changed, 28 insertions(+), 14 deletions(-)

diff -urN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2004-10-22 13:51:34.000000000 +0200
+++ linux-2.6-patched/arch/s390/defconfig	2004-10-22 13:51:43.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.9-rc3
-# Fri Oct  8 19:17:35 2004
+# Linux kernel version: 2.6.9
+# Fri Oct 22 13:50:22 2004
 #
 CONFIG_MMU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
@@ -26,6 +26,7 @@
 # CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=17
 CONFIG_HOTPLUG=y
+CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_EMBEDDED is not set
@@ -49,6 +50,7 @@
 # CONFIG_MODULE_UNLOAD is not set
 CONFIG_OBSOLETE_MODPARM=y
 # CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
 
 #
@@ -144,6 +146,7 @@
 # SCSI low-level drivers
 #
 # CONFIG_SCSI_SATA is not set
+# CONFIG_SCSI_QLOGIC_1280_1040 is not set
 # CONFIG_SCSI_DEBUG is not set
 CONFIG_ZFCP=y
 CONFIG_CCW=y
@@ -157,7 +160,9 @@
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_LBD is not set
+# CONFIG_CDROM_PKTCDVD is not set
 
 #
 # S/390 block device drivers
@@ -224,6 +229,7 @@
 CONFIG_S390_TAPE_34XX=m
 # CONFIG_VMLOGRDR is not set
 # CONFIG_MONREADER is not set
+# CONFIG_DCSS_SHM is not set
 
 #
 # Cryptographic devices
@@ -427,6 +433,7 @@
 # CONFIG_DEVFS_FS is not set
 # CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_XATTR is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 
@@ -506,6 +513,7 @@
 #
 CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
+# CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_INFO is not set
@@ -513,6 +521,7 @@
 #
 # Security options
 #
+# CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 
 #
diff -urN linux-2.6/arch/s390/kernel/asm-offsets.c linux-2.6-patched/arch/s390/kernel/asm-offsets.c
--- linux-2.6/arch/s390/kernel/asm-offsets.c	2004-10-18 23:53:44.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/asm-offsets.c	2004-10-22 13:51:43.000000000 +0200
@@ -22,6 +22,8 @@
 	DEFINE(__THREAD_mm_segment,
 	       offsetof(struct task_struct, thread.mm_segment),);
 	BLANK();
+	DEFINE(__TASK_pid, offsetof(struct task_struct, pid),);
+	BLANK();
 	DEFINE(__PER_atmid, offsetof(per_struct, lowcore.words.perc_atmid),);
 	DEFINE(__PER_address, offsetof(per_struct, lowcore.words.address),);
 	DEFINE(__PER_access_id, offsetof(per_struct, lowcore.words.access_id),);
diff -urN linux-2.6/arch/s390/kernel/cpcmd.c linux-2.6-patched/arch/s390/kernel/cpcmd.c
--- linux-2.6/arch/s390/kernel/cpcmd.c	2004-10-18 23:54:07.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/cpcmd.c	2004-10-22 13:51:43.000000000 +0200
@@ -15,7 +15,7 @@
 #include <asm/system.h>
 
 static spinlock_t cpcmd_lock = SPIN_LOCK_UNLOCKED;
-static char cpcmd_buf[128];
+static char cpcmd_buf[240];
 
 void cpcmd(char *cmd, char *response, int rlen)
 {
@@ -24,22 +24,23 @@
         int cmdlen;
 
 	spin_lock_irqsave(&cpcmd_lock, flags);
-        cmdlen = strlen(cmd);
-        strcpy(cpcmd_buf, cmd);
-        ASCEBC(cpcmd_buf, cmdlen);
+	cmdlen = strlen(cmd);
+	BUG_ON(cmdlen>240);
+	strcpy(cpcmd_buf, cmd);
+	ASCEBC(cpcmd_buf, cmdlen);
 
-        if (response != NULL && rlen > 0) {
+	if (response != NULL && rlen > 0) {
 #ifndef CONFIG_ARCH_S390X
                 asm volatile ("LRA   2,0(%0)\n\t"
                               "LR    4,%1\n\t"
                               "O     4,%4\n\t"
                               "LRA   3,0(%2)\n\t"
                               "LR    5,%3\n\t"
-                              ".long 0x83240008 # Diagnose 83\n\t"
+                              ".long 0x83240008 # Diagnose X'08'\n\t"
                               : /* no output */
                               : "a" (cpcmd_buf), "d" (cmdlen),
                                 "a" (response), "d" (rlen), "m" (mask)
-                              : "2", "3", "4", "5" );
+                              : "cc", "2", "3", "4", "5" );
 #else /* CONFIG_ARCH_S390X */
                 asm volatile ("   lrag  2,0(%0)\n"
                               "   lgr   4,%1\n"
@@ -47,19 +48,19 @@
                               "   lrag  3,0(%2)\n"
                               "   lgr   5,%3\n"
                               "   sam31\n"
-                              "   .long 0x83240008 # Diagnose 83\n"
+                              "   .long 0x83240008 # Diagnose X'08'\n"
                               "   sam64"
                               : /* no output */
                               : "a" (cpcmd_buf), "d" (cmdlen),
                                 "a" (response), "d" (rlen), "m" (mask)
-                              : "2", "3", "4", "5" );
+                              : "cc", "2", "3", "4", "5" );
 #endif /* CONFIG_ARCH_S390X */
                 EBCASC(response, rlen);
         } else {
 #ifndef CONFIG_ARCH_S390X
                 asm volatile ("LRA   2,0(%0)\n\t"
                               "LR    3,%1\n\t"
-                              ".long 0x83230008 # Diagnose 83\n\t"
+                              ".long 0x83230008 # Diagnose X'08'\n\t"
                               : /* no output */
                               : "a" (cpcmd_buf), "d" (cmdlen)
                               : "2", "3"  );
@@ -67,7 +68,7 @@
                 asm volatile ("   lrag  2,0(%0)\n"
                               "   lgr   3,%1\n"
                               "   sam31\n"
-                              "   .long 0x83230008 # Diagnose 83\n"
+                              "   .long 0x83230008 # Diagnose X'08'\n"
                               "   sam64"
                               : /* no output */
                               : "a" (cpcmd_buf), "d" (cmdlen)
diff -urN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-patched/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	2004-10-18 23:53:37.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/entry64.S	2004-10-22 13:51:43.000000000 +0200
@@ -141,6 +141,7 @@
 	lg	%r15,__THREAD_ksp(%r3)	# load kernel stack from next->tss.ksp
         lmg     %r6,%r15,__SF_GPRS(%r15)# load __switch_to registers of next task
 	stg	%r3,__LC_CURRENT	# __LC_CURRENT = current task struct
+	lctl	%c4,%c4,__TASK_pid(%r3) # load pid to control reg. 4
 	lg	%r3,__THREAD_info(%r3)  # load thread_info from task struct
 	stg	%r3,__LC_THREAD_INFO
 	aghi	%r3,STACK_SIZE
diff -urN linux-2.6/arch/s390/kernel/entry.S linux-2.6-patched/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	2004-10-18 23:53:37.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/entry.S	2004-10-22 13:51:43.000000000 +0200
@@ -144,6 +144,7 @@
 	l	%r15,__THREAD_ksp(%r3)	# load kernel stack from next->tss.ksp
 	lm	%r6,%r15,__SF_GPRS(%r15)# load __switch_to registers of next task
 	st	%r3,__LC_CURRENT	# __LC_CURRENT = current task struct
+	lctl	%c4,%c4,__TASK_pid(%r3) # load pid to control reg. 4
 	l	%r3,__THREAD_info(%r3)  # load thread_info from task struct
 	st	%r3,__LC_THREAD_INFO
 	ahi	%r3,STACK_SIZE
diff -urN linux-2.6/arch/s390/kernel/irq.c linux-2.6-patched/arch/s390/kernel/irq.c
--- linux-2.6/arch/s390/kernel/irq.c	2004-10-18 23:54:32.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/irq.c	2004-10-22 13:51:43.000000000 +0200
@@ -86,7 +86,7 @@
 				     "   la    15,0(%1)\n"
 				     : : "a" (new), "a" (old),
 				         "a" (__do_softirq)
-				     : "0", "1", "2", "3", "4", "5",
+				     : "0", "1", "2", "3", "4", "5", "14",
 				       "cc", "memory" );
 		} else
 			/* We are already on the async stack. */
