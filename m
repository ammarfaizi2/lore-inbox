Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268378AbUH3S4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268378AbUH3S4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 14:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268824AbUH3SYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:24:08 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:47299 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S268848AbUH3SCP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 14:02:15 -0400
Date: Mon, 30 Aug 2004 20:02:45 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: core changes.
Message-ID: <20040830180245.GA6411@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: core changes.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

s390 core changes:
 - Fix a race condition between kernel thread creation and preemption.
 - Fix idal_is_needed for the border case 0x7ffff000.
 - Get rid of compiler warnings in compat_signal.c and profile.c.
 - Regenerate default configuration.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/defconfig              |   11 ++++++++---
 arch/s390/kernel/compat_signal.c |   24 +++++++++++++++++-------
 arch/s390/kernel/entry.S         |    5 ++++-
 arch/s390/kernel/entry64.S       |    5 ++++-
 arch/s390/kernel/process.c       |   27 +++------------------------
 arch/s390/kernel/profile.c       |    1 +
 include/asm-s390/idals.h         |    2 +-
 7 files changed, 38 insertions(+), 37 deletions(-)

diff -urN linux-2.6/arch/s390/defconfig linux-2.6-s390/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	Mon Aug 30 19:14:07 2004
+++ linux-2.6-s390/arch/s390/defconfig	Mon Aug 30 19:14:21 2004
@@ -1,5 +1,7 @@
 #
 # Automatically generated make config: don't edit
+# Linux kernel version: 2.6.9-rc1
+# Mon Aug 30 19:03:48 2004
 #
 CONFIG_MMU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
@@ -130,9 +132,7 @@
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_SATA is not set
-# CONFIG_SCSI_EATA_PIO is not set
 # CONFIG_SCSI_DEBUG is not set
 CONFIG_ZFCP=y
 CONFIG_CCW=y
@@ -168,6 +168,7 @@
 CONFIG_MD_LINEAR=m
 CONFIG_MD_RAID0=m
 CONFIG_MD_RAID1=m
+# CONFIG_MD_RAID10 is not set
 CONFIG_MD_RAID5=m
 # CONFIG_MD_RAID6 is not set
 CONFIG_MD_MULTIPATH=m
@@ -236,11 +237,13 @@
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
 CONFIG_IPV6=y
 # CONFIG_IPV6_PRIVACY is not set
 # CONFIG_INET6_AH is not set
 # CONFIG_INET6_ESP is not set
 # CONFIG_INET6_IPCOMP is not set
+# CONFIG_INET6_TUNNEL is not set
 # CONFIG_IPV6_TUNNEL is not set
 # CONFIG_NETFILTER is not set
 CONFIG_XFRM=y
@@ -442,6 +445,7 @@
 CONFIG_EXPORTFS=y
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
@@ -485,8 +489,8 @@
 CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_SLAB is not set
-# CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_INFO is not set
 
 #
 # Security options
@@ -505,6 +509,7 @@
 # CONFIG_CRYPTO_SHA1_Z990 is not set
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_WHIRLPOOL is not set
 # CONFIG_CRYPTO_DES is not set
 # CONFIG_CRYPTO_DES_Z990 is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
diff -urN linux-2.6/arch/s390/kernel/compat_signal.c linux-2.6-s390/arch/s390/kernel/compat_signal.c
--- linux-2.6/arch/s390/kernel/compat_signal.c	Mon Aug 30 19:14:07 2004
+++ linux-2.6-s390/arch/s390/kernel/compat_signal.c	Mon Aug 30 19:14:21 2004
@@ -218,14 +218,17 @@
 		 struct old_sigaction32 __user *oact)
 {
         struct k_sigaction new_ka, old_ka;
+	unsigned long sa_handler, sa_restorer;
         int ret;
 
         if (act) {
 		compat_old_sigset_t mask;
 		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
-		    __get_user((unsigned long)new_ka.sa.sa_handler, &act->sa_handler) ||
-		    __get_user((unsigned long)new_ka.sa.sa_restorer, &act->sa_restorer))
+		    __get_user(sa_handler, &act->sa_handler) ||
+		    __get_user(sa_restorer, &act->sa_restorer))
 			return -EFAULT;
+		new_ka.sa.sa_handler = (__sighandler_t) sa_handler;
+		new_ka.sa.sa_restorer = (void (*)(void)) sa_restorer;
 		__get_user(new_ka.sa.sa_flags, &act->sa_flags);
 		__get_user(mask, &act->sa_mask);
 		siginitset(&new_ka.sa.sa_mask, mask);
@@ -234,9 +237,11 @@
         ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
 
 	if (!ret && oact) {
+		sa_handler = (unsigned long) old_ka.sa.sa_handler;
+		sa_restorer = (unsigned long) old_ka.sa.sa_restorer;
 		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
-		    __put_user((unsigned long)old_ka.sa.sa_handler, &oact->sa_handler) ||
-		    __put_user((unsigned long)old_ka.sa.sa_restorer, &oact->sa_restorer))
+		    __put_user(sa_handler, &oact->sa_handler) ||
+		    __put_user(sa_restorer, &oact->sa_restorer))
 			return -EFAULT;
 		__put_user(old_ka.sa.sa_flags, &oact->sa_flags);
 		__put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask);
@@ -253,6 +258,7 @@
 	   struct sigaction32 __user *oact,  size_t sigsetsize)
 {
 	struct k_sigaction new_ka, old_ka;
+	unsigned long sa_handler;
 	int ret;
 	compat_sigset_t set32;
 
@@ -261,7 +267,7 @@
 		return -EINVAL;
 
 	if (act) {
-		ret = get_user((unsigned long)new_ka.sa.sa_handler, &act->sa_handler);
+		ret = get_user(sa_handler, &act->sa_handler);
 		ret |= __copy_from_user(&set32, &act->sa_mask,
 					sizeof(compat_sigset_t));
 		switch (_NSIG_WORDS) {
@@ -278,6 +284,7 @@
 		
 		if (ret)
 			return -EFAULT;
+		new_ka.sa.sa_handler = (__sighandler_t) sa_handler;
 	}
 
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
@@ -311,17 +318,19 @@
 							struct pt_regs *regs)
 {
 	stack_t kss, koss;
+	unsigned long ss_sp;
 	int ret, err = 0;
 	mm_segment_t old_fs = get_fs();
 
 	if (uss) {
 		if (!access_ok(VERIFY_READ, uss, sizeof(*uss)))
 			return -EFAULT;
-		err |= __get_user((unsigned long) kss.ss_sp, &uss->ss_sp);
+		err |= __get_user(ss_sp, &uss->ss_sp);
 		err |= __get_user(kss.ss_size, &uss->ss_size);
 		err |= __get_user(kss.ss_flags, &uss->ss_flags);
 		if (err)
 			return -EFAULT;
+		kss.ss_sp = (void *) ss_sp;
 	}
 
 	set_fs (KERNEL_DS);
@@ -333,7 +342,8 @@
 	if (!ret && uoss) {
 		if (!access_ok(VERIFY_WRITE, uoss, sizeof(*uoss)))
 			return -EFAULT;
-		err |= __put_user((unsigned long) koss.ss_sp, &uoss->ss_sp);
+		ss_sp = (unsigned long) koss.ss_sp;
+		err |= __put_user(ss_sp, &uoss->ss_sp);
 		err |= __put_user(koss.ss_size, &uoss->ss_size);
 		err |= __put_user(koss.ss_flags, &uoss->ss_flags);
 		if (err)
diff -urN linux-2.6/arch/s390/kernel/entry.S linux-2.6-s390/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	Sat Aug 14 12:54:51 2004
+++ linux-2.6-s390/arch/s390/kernel/entry.S	Mon Aug 30 19:14:21 2004
@@ -304,7 +304,10 @@
 ret_from_fork:
 	l	%r13,__LC_SVC_NEW_PSW+4
 	l	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
-        l       %r1,BASED(.Lschedtail)
+	tm	SP_PSW+1(%r15),0x01	# forking a kernel thread ?
+	bo	BASED(0f)
+	st	%r15,SP_R15(%r15)	# store stack pointer for new kthread
+0:	l       %r1,BASED(.Lschedtail)
 	basr    %r14,%r1
         stosm   24(%r15),0x03     # reenable interrupts
 	b	BASED(sysc_return)
diff -urN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-s390/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	Sat Aug 14 12:54:51 2004
+++ linux-2.6-s390/arch/s390/kernel/entry64.S	Mon Aug 30 19:14:21 2004
@@ -304,7 +304,10 @@
 ret_from_fork:
 	lg	%r13,__LC_SVC_NEW_PSW+8
 	lg	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
-        brasl   %r14,schedule_tail
+	tm	SP_PSW+1(%r15),0x01	# forking a kernel thread ?
+	jo	0f
+	stg	%r15,SP_R15(%r15)	# store stack pointer for new kthread
+0:	brasl   %r14,schedule_tail
         stosm   24(%r15),0x03     # reenable interrupts
 	j	sysc_return
 
diff -urN linux-2.6/arch/s390/kernel/process.c linux-2.6-s390/arch/s390/kernel/process.c
--- linux-2.6/arch/s390/kernel/process.c	Mon Aug 30 19:14:07 2004
+++ linux-2.6-s390/arch/s390/kernel/process.c	Mon Aug 30 19:14:21 2004
@@ -186,41 +186,20 @@
 
 extern void kernel_thread_starter(void);
 
-#ifndef CONFIG_ARCH_S390X
-
-__asm__(".align 4\n"
-	"kernel_thread_starter:\n"
-	"    l     15,0(8)\n"
-	"    sr    15,7\n"
-	"    stosm 24(15),3\n"
-	"    lr    2,10\n"
-	"    basr  14,9\n"
-	"    sr    2,2\n"
-	"    br    11\n");
-
-#else /* CONFIG_ARCH_S390X */
-
 __asm__(".align 4\n"
 	"kernel_thread_starter:\n"
-	"    lg    15,0(8)\n"
-	"    sgr   15,7\n"
-	"    stosm 48(15),3\n"
-	"    lgr   2,10\n"
+	"    la    2,0(10)\n"
 	"    basr  14,9\n"
-	"    sgr   2,2\n"
+	"    la    2,0\n"
 	"    br    11\n");
 
-#endif /* CONFIG_ARCH_S390X */
-
 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
 	struct pt_regs regs;
 
 	memset(&regs, 0, sizeof(regs));
-	regs.psw.mask = PSW_KERNEL_BITS;
+	regs.psw.mask = PSW_KERNEL_BITS | PSW_MASK_IO | PSW_MASK_EXT;
 	regs.psw.addr = (unsigned long) kernel_thread_starter | PSW_ADDR_AMODE;
-	regs.gprs[7] = STACK_FRAME_OVERHEAD + sizeof(struct pt_regs);
-	regs.gprs[8] = __LC_KERNEL_STACK;
 	regs.gprs[9] = (unsigned long) fn;
 	regs.gprs[10] = (unsigned long) arg;
 	regs.gprs[11] = (unsigned long) do_exit;
diff -urN linux-2.6/arch/s390/kernel/profile.c linux-2.6-s390/arch/s390/kernel/profile.c
--- linux-2.6/arch/s390/kernel/profile.c	Mon Aug 30 19:14:07 2004
+++ linux-2.6-s390/arch/s390/kernel/profile.c	Mon Aug 30 19:14:21 2004
@@ -6,6 +6,7 @@
  *
  */
 #include <linux/proc_fs.h>
+#include <linux/profile.h>
 
 static struct proc_dir_entry * root_irq_dir;
 
diff -urN linux-2.6/include/asm-s390/idals.h linux-2.6-s390/include/asm-s390/idals.h
--- linux-2.6/include/asm-s390/idals.h	Sat Aug 14 12:54:48 2004
+++ linux-2.6-s390/include/asm-s390/idals.h	Mon Aug 30 19:14:21 2004
@@ -35,7 +35,7 @@
 idal_is_needed(void *vaddr, unsigned int length)
 {
 #ifdef __s390x__
-	return ((__pa(vaddr) + length) >> 31) != 0;
+	return ((__pa(vaddr) + length - 1) >> 31) != 0;
 #else
 	return 0;
 #endif
