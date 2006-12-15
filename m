Return-Path: <linux-kernel-owner+w=401wt.eu-S1752849AbWLOQZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbWLOQZA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752850AbWLOQZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:25:00 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:32624 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbWLOQYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:24:33 -0500
Date: Fri, 15 Dec 2006 17:24:14 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Please pull git390 'for-linus' branch
Message-ID: <20061215162414.GJ4920@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 arch/s390/defconfig          |   47 ++++++++++++++++++++++++---------
 arch/s390/hypfs/hypfs_diag.c |    4 +-
 arch/s390/kernel/ipl.c       |   59 ++++++++++--------------------------------
 arch/s390/kernel/reipl.S     |    6 +++-
 arch/s390/kernel/reipl64.S   |    5 +++-
 arch/s390/kernel/reset.S     |   42 +++++++++++++++++++++++++++++
 drivers/s390/char/sclp_cpi.c |    2 +
 drivers/s390/cio/cio.c       |   25 ++++++++++++++++-
 drivers/s390/cio/css.c       |    3 +-
 drivers/s390/cio/qdio.c      |   13 +++++---
 drivers/s390/crypto/ap_bus.c |   14 ++++++++-
 include/asm-s390/qdio.h      |    1 +
 include/asm-s390/reset.h     |    1 +
 13 files changed, 150 insertions(+), 72 deletions(-)

Christian Borntraeger (2):
      [S390] hypfs fixes
      [S390] sclp_cpi module license.

Martin Schwidefsky (1):
      [S390] update default configuration

Michael Holzheu (3):
      [S390] Fix reboot hang on LPARs
      [S390] Fix reboot hang
      [S390] Save prefix register for dump on panic

Ralph Wuerthner (1):
      [S390] zcrypt: module unload fixes.

Stefan Bader (1):
      [S390] cio: css_register_subchannel race.

Ursula Braun (1):
      [S390] Hipersocket multicast queue: make sure outbound handler is called

diff --git a/arch/s390/defconfig b/arch/s390/defconfig
index a6ec919..5368cf4 100644
--- a/arch/s390/defconfig
+++ b/arch/s390/defconfig
@@ -1,14 +1,15 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.19-rc2
-# Wed Oct 18 17:11:10 2006
+# Linux kernel version: 2.6.20-rc1
+# Fri Dec 15 16:52:28 2006
 #
 CONFIG_MMU=y
 CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+# CONFIG_ARCH_HAS_ILOG2_U32 is not set
+# CONFIG_ARCH_HAS_ILOG2_U64 is not set
 CONFIG_GENERIC_HWEIGHT=y
-CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_TIME=y
 CONFIG_S390=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
@@ -37,12 +38,13 @@ CONFIG_AUDIT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_CPUSETS is not set
+CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
-# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -119,6 +121,7 @@ CONFIG_PACK_STACK=y
 CONFIG_CHECK_STACK=y
 CONFIG_STACK_GUARD=256
 # CONFIG_WARN_STACK is not set
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -128,6 +131,7 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_RESOURCES_64BIT=y
+CONFIG_HOLES_IN_ZONE=y
 
 #
 # I/O subsystem configuration
@@ -196,6 +200,7 @@ CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 CONFIG_IPV6=y
 # CONFIG_IPV6_PRIVACY is not set
 # CONFIG_IPV6_ROUTER_PREF is not set
@@ -211,7 +216,6 @@ CONFIG_INET6_XFRM_MODE_BEET=y
 # CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
 CONFIG_IPV6_SIT=y
 # CONFIG_IPV6_TUNNEL is not set
-# CONFIG_IPV6_SUBTREES is not set
 # CONFIG_IPV6_MULTIPLE_TABLES is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
@@ -246,6 +250,7 @@ CONFIG_IPV6_SIT=y
 # QoS and/or fair queueing
 #
 CONFIG_NET_SCHED=y
+CONFIG_NET_SCH_FIFO=y
 CONFIG_NET_SCH_CLK_JIFFIES=y
 # CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
 # CONFIG_NET_SCH_CLK_CPU is not set
@@ -277,6 +282,7 @@ CONFIG_NET_CLS_ROUTE=y
 CONFIG_NET_CLS_FW=m
 CONFIG_NET_CLS_U32=m
 # CONFIG_CLS_U32_PERF is not set
+CONFIG_CLS_U32_MARK=y
 CONFIG_NET_CLS_RSVP=m
 CONFIG_NET_CLS_RSVP6=m
 # CONFIG_NET_EMATCH is not set
@@ -315,6 +321,7 @@ CONFIG_SYS_HYPERVISOR=y
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+# CONFIG_SCSI_TGT is not set
 CONFIG_SCSI_NETLINK=y
 CONFIG_SCSI_PROC_FS=y
 
@@ -335,6 +342,7 @@ CONFIG_CHR_DEV_SG=y
 CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
+CONFIG_SCSI_SCAN_ASYNC=y
 
 #
 # SCSI Transports
@@ -546,6 +554,7 @@ CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 # CONFIG_FUSE_FS is not set
+CONFIG_GENERIC_ACL=y
 
 #
 # CD-ROM/DVD Filesystems
@@ -571,7 +580,7 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-# CONFIG_CONFIGFS_FS is not set
+CONFIG_CONFIGFS_FS=m
 
 #
 # Miscellaneous filesystems
@@ -616,7 +625,6 @@ CONFIG_SUNRPC=y
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
 # CONFIG_9P_FS is not set
-CONFIG_GENERIC_ACL=y
 
 #
 # Partition Types
@@ -646,6 +654,14 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_NLS is not set
 
 #
+# Distributed Lock Manager
+#
+CONFIG_DLM=m
+CONFIG_DLM_TCP=y
+# CONFIG_DLM_SCTP is not set
+# CONFIG_DLM_DEBUG is not set
+
+#
 # Instrumentation Support
 #
 
@@ -663,6 +679,8 @@ CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
+CONFIG_DEBUG_FS=y
+CONFIG_HEADERS_CHECK=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_LOG_BUF_SHIFT=17
 # CONFIG_SCHEDSTATS is not set
@@ -679,13 +697,11 @@ CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_INFO is not set
-CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_FRAME_POINTER is not set
 # CONFIG_UNWIND_INFO is not set
 CONFIG_FORCED_INLINING=y
-CONFIG_HEADERS_CHECK=y
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_LKDTM is not set
 
@@ -699,10 +715,11 @@ CONFIG_HEADERS_CHECK=y
 # Cryptographic options
 #
 CONFIG_CRYPTO=y
-CONFIG_CRYPTO_ALGAPI=m
-CONFIG_CRYPTO_BLKCIPHER=m
-CONFIG_CRYPTO_MANAGER=m
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_MANAGER=y
 # CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
 # CONFIG_CRYPTO_NULL is not set
 # CONFIG_CRYPTO_MD4 is not set
 # CONFIG_CRYPTO_MD5 is not set
@@ -713,8 +730,10 @@ CONFIG_CRYPTO_MANAGER=m
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
 CONFIG_CRYPTO_ECB=m
-CONFIG_CRYPTO_CBC=m
+CONFIG_CRYPTO_CBC=y
+# CONFIG_CRYPTO_LRW is not set
 # CONFIG_CRYPTO_DES is not set
 # CONFIG_CRYPTO_DES_S390 is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
@@ -740,8 +759,10 @@ CONFIG_CRYPTO_CBC=m
 #
 # Library routines
 #
+CONFIG_BITREVERSE=m
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=m
 # CONFIG_LIBCRC32C is not set
 CONFIG_PLIST=y
+CONFIG_IOMAP_COPY=y
diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
index 443fa37..2782cf9 100644
--- a/arch/s390/hypfs/hypfs_diag.c
+++ b/arch/s390/hypfs/hypfs_diag.c
@@ -379,7 +379,7 @@ static void *diag204_alloc_vbuf(int pages)
 static void *diag204_alloc_rbuf(void)
 {
 	diag204_buf = (void*)__get_free_pages(GFP_KERNEL,0);
-	if (diag204_buf)
+	if (!diag204_buf)
 		return ERR_PTR(-ENOMEM);
 	diag204_buf_pages = 1;
 	return diag204_buf;
@@ -521,7 +521,7 @@ __init int hypfs_diag_init(void)
 	}
 	rc = diag224_get_name_table();
 	if (rc) {
-		diag224_delete_name_table();
+		diag204_free_buffer();
 		printk(KERN_ERR "hypfs: could not get name table.\n");
 	}
 	return rc;
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index a36bea1..9e9972e 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -609,42 +609,12 @@ static ssize_t on_panic_store(struct subsystem *subsys, const char *buf,
 static struct subsys_attribute on_panic_attr =
 		__ATTR(on_panic, 0644, on_panic_show, on_panic_store);
 
-static void print_fcp_block(struct ipl_parameter_block *fcp_block)
-{
-	printk(KERN_EMERG "wwpn:      %016llx\n",
-		(unsigned long long)fcp_block->ipl_info.fcp.wwpn);
-	printk(KERN_EMERG "lun:       %016llx\n",
-		(unsigned long long)fcp_block->ipl_info.fcp.lun);
-	printk(KERN_EMERG "bootprog:  %lld\n",
-		(unsigned long long)fcp_block->ipl_info.fcp.bootprog);
-	printk(KERN_EMERG "br_lba:    %lld\n",
-		(unsigned long long)fcp_block->ipl_info.fcp.br_lba);
-	printk(KERN_EMERG "device:    %llx\n",
-		(unsigned long long)fcp_block->ipl_info.fcp.devno);
-	printk(KERN_EMERG "opt:       %x\n", fcp_block->ipl_info.fcp.opt);
-}
-
 void do_reipl(void)
 {
 	struct ccw_dev_id devid;
 	static char buf[100];
 	char loadparm[LOADPARM_LEN + 1];
 
-	switch (reipl_type) {
-	case IPL_TYPE_CCW:
-		reipl_get_ascii_loadparm(loadparm);
-		printk(KERN_EMERG "reboot on ccw device: 0.0.%04x\n",
-			reipl_block_ccw->ipl_info.ccw.devno);
-		printk(KERN_EMERG "loadparm = '%s'\n", loadparm);
-		break;
-	case IPL_TYPE_FCP:
-		printk(KERN_EMERG "reboot on fcp device:\n");
-		print_fcp_block(reipl_block_fcp);
-		break;
-	default:
-		break;
-	}
-
 	switch (reipl_method) {
 	case IPL_METHOD_CCW_CIO:
 		devid.devno = reipl_block_ccw->ipl_info.ccw.devno;
@@ -654,6 +624,7 @@ void do_reipl(void)
 		reipl_ccw_dev(&devid);
 		break;
 	case IPL_METHOD_CCW_VM:
+		reipl_get_ascii_loadparm(loadparm);
 		if (strlen(loadparm) == 0)
 			sprintf(buf, "IPL %X",
 				reipl_block_ccw->ipl_info.ccw.devno);
@@ -683,7 +654,6 @@ void do_reipl(void)
 		diag308(DIAG308_IPL, NULL);
 		break;
 	}
-	printk(KERN_EMERG "reboot failed!\n");
 	signal_processor(smp_processor_id(), sigp_stop_and_store_status);
 }
 
@@ -692,19 +662,6 @@ static void do_dump(void)
 	struct ccw_dev_id devid;
 	static char buf[100];
 
-	switch (dump_type) {
-	case IPL_TYPE_CCW:
-		printk(KERN_EMERG "Automatic dump on ccw device: 0.0.%04x\n",
-		       dump_block_ccw->ipl_info.ccw.devno);
-		break;
-	case IPL_TYPE_FCP:
-		printk(KERN_EMERG "Automatic dump on fcp device:\n");
-		print_fcp_block(dump_block_fcp);
-		break;
-	default:
-		return;
-	}
-
 	switch (dump_method) {
 	case IPL_METHOD_CCW_CIO:
 		smp_send_stop();
@@ -1037,15 +994,21 @@ static void do_reset_calls(void)
 }
 
 extern void reset_mcck_handler(void);
+extern void reset_pgm_handler(void);
+extern __u32 dump_prefix_page;
 
 void s390_reset_system(void)
 {
 	struct _lowcore *lc;
 
-	/* Stack for interrupt/machine check handler */
 	lc = (struct _lowcore *)(unsigned long) store_prefix();
+
+	/* Stack for interrupt/machine check handler */
 	lc->panic_stack = S390_lowcore.panic_stack;
 
+	/* Save prefix page address for dump case */
+	dump_prefix_page = (unsigned long) lc;
+
 	/* Disable prefixing */
 	set_prefix(0);
 
@@ -1056,5 +1019,11 @@ void s390_reset_system(void)
 	S390_lowcore.mcck_new_psw.mask = PSW_KERNEL_BITS & ~PSW_MASK_MCHECK;
 	S390_lowcore.mcck_new_psw.addr =
 		PSW_ADDR_AMODE | (unsigned long) &reset_mcck_handler;
+
+	/* Set new program check handler */
+	S390_lowcore.program_new_psw.mask = PSW_KERNEL_BITS & ~PSW_MASK_MCHECK;
+	S390_lowcore.program_new_psw.addr =
+		PSW_ADDR_AMODE | (unsigned long) &reset_pgm_handler;
+
 	do_reset_calls();
 }
diff --git a/arch/s390/kernel/reipl.S b/arch/s390/kernel/reipl.S
index f9434d4..c3f4d9b 100644
--- a/arch/s390/kernel/reipl.S
+++ b/arch/s390/kernel/reipl.S
@@ -16,7 +16,7 @@ do_reipl_asm:	basr	%r13,0
 		stm	%r0,%r15,__LC_GPREGS_SAVE_AREA
 		stctl	%c0,%c15,__LC_CREGS_SAVE_AREA
 		stam	%a0,%a15,__LC_AREGS_SAVE_AREA
-		stpx	__LC_PREFIX_SAVE_AREA
+		mvc	__LC_PREFIX_SAVE_AREA(4),dump_prefix_page-.Lpg0(%r13)
 		stckc	.Lclkcmp-.Lpg0(%r13)
 		mvc	__LC_CLOCK_COMP_SAVE_AREA(8),.Lclkcmp-.Lpg0(%r13)
 		stpt	__LC_CPU_TIMER_SAVE_AREA
@@ -79,3 +79,7 @@ do_reipl_asm:	basr	%r13,0
 		.long	0x00000000,0x00000000
 		.long	0x00000000,0x00000000
 		.long	0x00000000,0x00000000
+	.globl dump_prefix_page
+dump_prefix_page:
+	.long 0x00000000
+
diff --git a/arch/s390/kernel/reipl64.S b/arch/s390/kernel/reipl64.S
index f18ef26..dbb3eed 100644
--- a/arch/s390/kernel/reipl64.S
+++ b/arch/s390/kernel/reipl64.S
@@ -20,7 +20,7 @@ do_reipl_asm:	basr	%r13,0
 		stg	%r0,__LC_GPREGS_SAVE_AREA-0x1000+8(%r1)
 		stctg	%c0,%c15,__LC_CREGS_SAVE_AREA-0x1000(%r1)
 		stam	%a0,%a15,__LC_AREGS_SAVE_AREA-0x1000(%r1)
-		stpx	__LC_PREFIX_SAVE_AREA-0x1000(%r1)
+		mvc	__LC_PREFIX_SAVE_AREA-0x1000(4,%r1),dump_prefix_page-.Lpg0(%r13)
 		stfpc	__LC_FP_CREG_SAVE_AREA-0x1000(%r1)
 		stckc	.Lclkcmp-.Lpg0(%r13)
 		mvc	__LC_CLOCK_COMP_SAVE_AREA-0x1000(8,%r1),.Lclkcmp-.Lpg0(%r13)
@@ -103,3 +103,6 @@ do_reipl_asm:	basr	%r13,0
 		.long	0x00000000,0x00000000
 		.long	0x00000000,0x00000000
 		.long	0x00000000,0x00000000
+	.globl dump_prefix_page
+dump_prefix_page:
+	.long 0x00000000
diff --git a/arch/s390/kernel/reset.S b/arch/s390/kernel/reset.S
index be8688c..8a87355 100644
--- a/arch/s390/kernel/reset.S
+++ b/arch/s390/kernel/reset.S
@@ -3,6 +3,7 @@
  *
  *    Copyright (C) IBM Corp. 2006
  *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
+ *		 Michael Holzheu <holzheu@de.ibm.com>
  */
 
 #include <asm/ptrace.h>
@@ -27,6 +28,26 @@ reset_mcck_handler:
 s390_reset_mcck_handler:
 	.quad	0
 
+	.globl	reset_pgm_handler
+reset_pgm_handler:
+	stmg	%r0,%r15,__LC_SAVE_AREA
+	basr	%r13,0
+0:	lg	%r15,__LC_PANIC_STACK	# load panic stack
+	aghi	%r15,-STACK_FRAME_OVERHEAD
+	lg	%r1,s390_reset_pgm_handler-0b(%r13)
+	ltgr	%r1,%r1
+	jz	1f
+	basr	%r14,%r1
+	lmg	%r0,%r15,__LC_SAVE_AREA
+	lpswe	__LC_PGM_OLD_PSW
+1:	lpswe	disabled_wait_psw-0b(%r13)
+	.globl s390_reset_pgm_handler
+s390_reset_pgm_handler:
+	.quad	0
+	.align	8
+disabled_wait_psw:
+	.quad	0x0002000180000000,0x0000000000000000 + reset_pgm_handler
+
 #else /* CONFIG_64BIT */
 
 	.globl	reset_mcck_handler
@@ -45,4 +66,25 @@ reset_mcck_handler:
 s390_reset_mcck_handler:
 	.long	0
 
+	.globl	reset_pgm_handler
+reset_pgm_handler:
+	stm	%r0,%r15,__LC_SAVE_AREA
+	basr	%r13,0
+0:	l	%r15,__LC_PANIC_STACK	# load panic stack
+	ahi	%r15,-STACK_FRAME_OVERHEAD
+	l	%r1,s390_reset_pgm_handler-0b(%r13)
+	ltr	%r1,%r1
+	jz	1f
+	basr	%r14,%r1
+	lm	%r0,%r15,__LC_SAVE_AREA
+	lpsw	__LC_PGM_OLD_PSW
+
+1:	lpsw	disabled_wait_psw-0b(%r13)
+	.globl	s390_reset_pgm_handler
+s390_reset_pgm_handler:
+	.long	0
+disabled_wait_psw:
+	.align 8
+	.long	0x000a0000,0x00000000 + reset_pgm_handler
+
 #endif /* CONFIG_64BIT */
diff --git a/drivers/s390/char/sclp_cpi.c b/drivers/s390/char/sclp_cpi.c
index f7c10d9..4f873ae 100644
--- a/drivers/s390/char/sclp_cpi.c
+++ b/drivers/s390/char/sclp_cpi.c
@@ -49,6 +49,8 @@ static struct sclp_register sclp_cpi_event =
 	.send_mask = EvTyp_CtlProgIdent_Mask
 };
 
+MODULE_LICENSE("GPL");
+
 MODULE_AUTHOR(
 	"Martin Peschke, IBM Deutschland Entwicklung GmbH "
 	"<mpeschke@de.ibm.com>");
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index 7835a71..3a403f1 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -871,11 +871,32 @@ __clear_subchannel_easy(struct subchannel_id schid)
 	return -EBUSY;
 }
 
+static int pgm_check_occured;
+
+static void cio_reset_pgm_check_handler(void)
+{
+	pgm_check_occured = 1;
+}
+
+static int stsch_reset(struct subchannel_id schid, volatile struct schib *addr)
+{
+	int rc;
+
+	pgm_check_occured = 0;
+	s390_reset_pgm_handler = cio_reset_pgm_check_handler;
+	rc = stsch(schid, addr);
+	s390_reset_pgm_handler = NULL;
+	if (pgm_check_occured)
+		return -EIO;
+	else
+		return rc;
+}
+
 static int __shutdown_subchannel_easy(struct subchannel_id schid, void *data)
 {
 	struct schib schib;
 
-	if (stsch_err(schid, &schib))
+	if (stsch_reset(schid, &schib))
 		return -ENXIO;
 	if (!schib.pmcw.ena)
 		return 0;
@@ -972,7 +993,7 @@ static int __reipl_subchannel_match(struct subchannel_id schid, void *data)
 	struct schib schib;
 	struct sch_match_id *match_id = data;
 
-	if (stsch_err(schid, &schib))
+	if (stsch_reset(schid, &schib))
 		return -ENXIO;
 	if (schib.pmcw.dnv &&
 	    (schib.pmcw.dev == match_id->devid.devno) &&
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 4c81d89..9d6c024 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -139,6 +139,8 @@ css_register_subchannel(struct subchannel *sch)
 	sch->dev.release = &css_subchannel_release;
 	sch->dev.groups = subch_attr_groups;
 
+	css_get_ssd_info(sch);
+
 	/* make it known to the system */
 	ret = css_sch_device_register(sch);
 	if (ret) {
@@ -146,7 +148,6 @@ css_register_subchannel(struct subchannel *sch)
 			__func__, sch->dev.bus_id);
 		return ret;
 	}
-	css_get_ssd_info(sch);
 	return ret;
 }
 
diff --git a/drivers/s390/cio/qdio.c b/drivers/s390/cio/qdio.c
index 9d4ea44..6fd1940 100644
--- a/drivers/s390/cio/qdio.c
+++ b/drivers/s390/cio/qdio.c
@@ -979,12 +979,11 @@ __qdio_outbound_processing(struct qdio_q *q)
 
 	if (q->is_iqdio_q) {
 		/* 
-		 * for asynchronous queues, we better check, if the fill
-		 * level is too high. for synchronous queues, the fill
-		 * level will never be that high. 
+		 * for asynchronous queues, we better check, if the sent
+		 * buffer is already switched from PRIMED to EMPTY.
 		 */
-		if (atomic_read(&q->number_of_buffers_used)>
-		    IQDIO_FILL_LEVEL_TO_POLL)
+		if ((q->queue_type == QDIO_IQDIO_QFMT_ASYNCH) &&
+		    !qdio_is_outbound_q_done(q))
 			qdio_mark_q(q);
 
 	} else if (!q->hydra_gives_outbound_pcis)
@@ -1825,6 +1824,10 @@ qdio_fill_qs(struct qdio_irq *irq_ptr, struct ccw_device *cdev,
 			q->sbal[j]=*(outbound_sbals_array++);
 
                 q->queue_type=q_format;
+		if ((q->queue_type == QDIO_IQDIO_QFMT) &&
+		    (no_output_qs > 1) &&
+		    (i == no_output_qs-1))
+			q->queue_type = QDIO_IQDIO_QFMT_ASYNCH;
 		q->int_parm=int_parm;
 		q->is_input_q=0;
 		q->schid = irq_ptr->schid;
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index ad60afe..81b5899 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1129,7 +1129,15 @@ static void ap_poll_thread_stop(void)
 	mutex_unlock(&ap_poll_thread_mutex);
 }
 
-static void ap_reset(void)
+static void ap_reset_domain(void)
+{
+	int i;
+
+	for (i = 0; i < AP_DEVICES; i++)
+		ap_reset_queue(AP_MKQID(i, ap_domain_index));
+}
+
+static void ap_reset_all(void)
 {
 	int i, j;
 
@@ -1139,7 +1147,7 @@ static void ap_reset(void)
 }
 
 static struct reset_call ap_reset_call = {
-	.fn = ap_reset,
+	.fn = ap_reset_all,
 };
 
 /**
@@ -1229,10 +1237,12 @@ void ap_module_exit(void)
 	int i;
 	struct device *dev;
 
+	ap_reset_domain();
 	ap_poll_thread_stop();
 	del_timer_sync(&ap_config_timer);
 	del_timer_sync(&ap_poll_timer);
 	destroy_workqueue(ap_work_queue);
+	tasklet_kill(&ap_tasklet);
 	s390_root_dev_unregister(ap_root_device);
 	while ((dev = bus_find_device(&ap_bus_type, NULL, NULL,
 		    __ap_match_all)))
diff --git a/include/asm-s390/qdio.h b/include/asm-s390/qdio.h
index 7189c79..127f72e 100644
--- a/include/asm-s390/qdio.h
+++ b/include/asm-s390/qdio.h
@@ -34,6 +34,7 @@
 #define QDIO_QETH_QFMT 0
 #define QDIO_ZFCP_QFMT 1
 #define QDIO_IQDIO_QFMT 2
+#define QDIO_IQDIO_QFMT_ASYNCH 3
 
 struct qdio_buffer_element{
 	unsigned int flags;
diff --git a/include/asm-s390/reset.h b/include/asm-s390/reset.h
index 9b439cf..532e65a 100644
--- a/include/asm-s390/reset.h
+++ b/include/asm-s390/reset.h
@@ -19,5 +19,6 @@ extern void register_reset_call(struct reset_call *reset);
 extern void unregister_reset_call(struct reset_call *reset);
 extern void s390_reset_system(void);
 extern void (*s390_reset_mcck_handler)(void);
+extern void (*s390_reset_pgm_handler)(void);
 
 #endif /* _ASM_S390_RESET_H */
