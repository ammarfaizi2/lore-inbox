Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422730AbWJDSFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422730AbWJDSFK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422731AbWJDSFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:05:09 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:52317 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422730AbWJDSFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:05:01 -0400
Date: Wed, 4 Oct 2006 20:05:02 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Please pull git390 'for-linus' branch
Message-ID: <20061004180502.GA2242@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 arch/s390/Kconfig                 |    3 ++
 arch/s390/defconfig               |   57 +++++++++++++++++++++++++++++--------
 arch/s390/kernel/compat_wrapper.S |    7 +++++
 arch/s390/kernel/head31.S         |    8 +++--
 arch/s390/kernel/head64.S         |   12 ++++----
 arch/s390/kernel/setup.c          |   55 ++++++++----------------------------
 arch/s390/kernel/signal.c         |   17 +++++------
 arch/s390/kernel/syscalls.S       |    2 +
 arch/s390/mm/init.c               |   45 ++++++++++-------------------
 drivers/s390/cio/device_fsm.c     |    2 +
 drivers/s390/cio/device_ops.c     |   14 ++++++---
 drivers/s390/cio/device_pgid.c    |    8 +++++
 drivers/s390/crypto/ap_bus.c      |   23 ++++++++-------
 include/asm-s390/io.h             |    5 ---
 include/asm-s390/page.h           |    1 +
 include/asm-s390/pgalloc.h        |    2 +
 include/asm-s390/pgtable.h        |   18 ++++++------
 include/asm-s390/spinlock.h       |    4 +--
 include/asm-s390/unistd.h         |    4 ++-
 19 files changed, 151 insertions(+), 136 deletions(-)

Cornelia Huck:
      [S390] Add timeouts during sense PGID, path verification and disband PGID.

Heiko Carstens:
      [S390] Wire up sys_getcpu system call.
      [S390] Remove crept in whitespace from head*.S again.
      [S390] Have s390 use add_active_range() and free_area_init_nodes.
      [S390] Remove open-coded mem_map usage.

Martin Schwidefsky:
      [S390] update default configuration
      [S390] user-copy optimization fallout.
      [S390] incorrect placement of include.

Peter Oberparleiter:
      [S390] cio: add timeout handler for internal operations.
      [S390] cio: improve unit check handling for internal operations

Ralph Wuerthner:
      [S390] zcrypt device registration/unregistration race.

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index f900a51..51c2dfe 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -233,6 +233,9 @@ config WARN_STACK_SIZE
 	  This allows you to specify the maximum frame size a function may
 	  have without the compiler complaining about it.
 
+config ARCH_POPULATES_NODE_MAP
+	def_bool y
+
 source "mm/Kconfig"
 
 comment "I/O subsystem configuration"
diff --git a/arch/s390/defconfig b/arch/s390/defconfig
index 35da539..b6cad75 100644
--- a/arch/s390/defconfig
+++ b/arch/s390/defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc2
-# Thu Jul 27 13:51:07 2006
+# Linux kernel version: 2.6.18
+# Wed Oct  4 19:45:46 2006
 #
 CONFIG_MMU=y
 CONFIG_LOCKDEP_SUPPORT=y
@@ -26,10 +26,11 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-CONFIG_SYSCTL=y
+# CONFIG_UTS_NS is not set
 CONFIG_AUDIT=y
 # CONFIG_AUDITSYSCALL is not set
 CONFIG_IKCONFIG=y
@@ -38,7 +39,9 @@ # CONFIG_CPUSETS is not set
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
+# CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -47,12 +50,12 @@ CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
-CONFIG_RT_MUTEXES=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
 CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 # CONFIG_SLOB is not set
@@ -71,6 +74,7 @@ CONFIG_STOP_MACHINE=y
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
 
 #
@@ -100,6 +104,7 @@ CONFIG_HOTPLUG_CPU=y
 CONFIG_DEFAULT_MIGRATION_COST=1000000
 CONFIG_COMPAT=y
 CONFIG_SYSVIPC_COMPAT=y
+CONFIG_AUDIT_ARCH=y
 
 #
 # Code generation options
@@ -107,11 +112,13 @@ #
 # CONFIG_MARCH_G5 is not set
 CONFIG_MARCH_Z900=y
 # CONFIG_MARCH_Z990 is not set
+# CONFIG_MARCH_Z9_109 is not set
 CONFIG_PACK_STACK=y
 # CONFIG_SMALL_STACK is not set
 CONFIG_CHECK_STACK=y
 CONFIG_STACK_GUARD=256
 # CONFIG_WARN_STACK is not set
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -165,6 +172,7 @@ # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
 CONFIG_NET_KEY=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -183,21 +191,28 @@ # CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
 CONFIG_IPV6=y
 # CONFIG_IPV6_PRIVACY is not set
 # CONFIG_IPV6_ROUTER_PREF is not set
 # CONFIG_INET6_AH is not set
 # CONFIG_INET6_ESP is not set
 # CONFIG_INET6_IPCOMP is not set
+# CONFIG_IPV6_MIP6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
 CONFIG_INET6_XFRM_MODE_TRANSPORT=y
 CONFIG_INET6_XFRM_MODE_TUNNEL=y
+CONFIG_INET6_XFRM_MODE_BEET=y
+# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
 # CONFIG_IPV6_TUNNEL is not set
+# CONFIG_IPV6_SUBTREES is not set
+# CONFIG_IPV6_MULTIPLE_TABLES is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
 
@@ -224,7 +239,6 @@ # CONFIG_IPX is not set
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 
@@ -301,6 +315,7 @@ # SCSI device support
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+CONFIG_SCSI_NETLINK=y
 CONFIG_SCSI_PROC_FS=y
 
 #
@@ -322,18 +337,18 @@ CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 
 #
-# SCSI Transport Attributes
+# SCSI Transports
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 CONFIG_SCSI_FC_ATTRS=y
 # CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
 
 #
 # SCSI low-level drivers
 #
 # CONFIG_ISCSI_TCP is not set
-# CONFIG_SCSI_SATA is not set
 # CONFIG_SCSI_DEBUG is not set
 CONFIG_ZFCP=y
 CONFIG_CCW=y
@@ -378,6 +393,7 @@ # CONFIG_MD_RAID456 is not set
 CONFIG_MD_MULTIPATH=m
 # CONFIG_MD_FAULTY is not set
 CONFIG_BLK_DEV_DM=y
+# CONFIG_DM_DEBUG is not set
 CONFIG_DM_CRYPT=y
 CONFIG_DM_SNAPSHOT=y
 CONFIG_DM_MIRROR=y
@@ -487,14 +503,12 @@ CONFIG_IUCV=m
 # CONFIG_NETIUCV is not set
 # CONFIG_SMSGIUCV is not set
 # CONFIG_CLAW is not set
-# CONFIG_MPC is not set
 CONFIG_QETH=y
 
 #
 # Gigabit Ethernet default settings
 #
 # CONFIG_QETH_IPV6 is not set
-# CONFIG_QETH_PERF_STATS is not set
 CONFIG_CCWGROUP=y
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
@@ -518,8 +532,9 @@ # CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
-# CONFIG_FS_POSIX_ACL is not set
+CONFIG_FS_POSIX_ACL=y
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -549,8 +564,10 @@ # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
@@ -598,6 +615,7 @@ # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
 # CONFIG_9P_FS is not set
+CONFIG_GENERIC_ACL=y
 
 #
 # Partition Types
@@ -627,10 +645,17 @@ #
 # CONFIG_NLS is not set
 
 #
+# Distributed Lock Manager
+#
+
+#
 # Instrumentation Support
 #
+
+#
+# Profiling support
+#
 # CONFIG_PROFILING is not set
-CONFIG_STATISTICS=y
 CONFIG_KPROBES=y
 
 #
@@ -638,6 +663,7 @@ # Kernel hacking
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
@@ -659,10 +685,12 @@ # CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_INFO is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
 # CONFIG_FRAME_POINTER is not set
 # CONFIG_UNWIND_INFO is not set
 CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_LKDTM is not set
 
 #
 # Security options
@@ -674,6 +702,9 @@ #
 # Cryptographic options
 #
 CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=m
+CONFIG_CRYPTO_BLKCIPHER=m
+CONFIG_CRYPTO_MANAGER=m
 # CONFIG_CRYPTO_HMAC is not set
 # CONFIG_CRYPTO_NULL is not set
 # CONFIG_CRYPTO_MD4 is not set
@@ -685,6 +716,8 @@ # CONFIG_CRYPTO_SHA256_S390 is not set
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
+CONFIG_CRYPTO_ECB=m
+CONFIG_CRYPTO_CBC=m
 # CONFIG_CRYPTO_DES is not set
 # CONFIG_CRYPTO_DES_S390 is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index 4aabeea..cb0efae 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -1658,3 +1658,10 @@ compat_sys_vmsplice_wrapper:
 	llgfr	%r4,%r4			# unsigned int
 	llgfr	%r5,%r5			# unsigned int
 	jg	compat_sys_vmsplice
+
+	.globl	sys_getcpu_wrapper
+sys_getcpu_wrapper:
+	llgtr	%r2,%r2			# unsigned *
+	llgtr	%r3,%r3			# unsigned *
+	llgtr	%r4,%r4			# struct getcpu_cache *
+	jg	sys_tee
diff --git a/arch/s390/kernel/head31.S b/arch/s390/kernel/head31.S
index 1b952a3..0a2c929 100644
--- a/arch/s390/kernel/head31.S
+++ b/arch/s390/kernel/head31.S
@@ -258,10 +258,10 @@ #
 # find out if the diag 0x9c is available
 #
 	mvc	__LC_PGM_NEW_PSW(8),.Lpcdiag9c-.LPG1(%r13)
-	stap   __LC_CPUID+4		# store cpu address
-	lh     %r1,__LC_CPUID+4
-	diag   %r1,0,0x9c		# test diag 0x9c
-	oi     2(%r12),1		# set diag9c flag
+	stap	__LC_CPUID+4		# store cpu address
+	lh	%r1,__LC_CPUID+4
+	diag	%r1,0,0x9c		# test diag 0x9c
+	oi	2(%r12),1		# set diag9c flag
 .Lchkdiag9c:
 
 	lpsw  .Lentry-.LPG1(13)		# jump to _stext in primary-space,
diff --git a/arch/s390/kernel/head64.S b/arch/s390/kernel/head64.S
index b30e589..42f54d4 100644
--- a/arch/s390/kernel/head64.S
+++ b/arch/s390/kernel/head64.S
@@ -253,12 +253,12 @@ #
 #
 # find out if the diag 0x9c is available
 #
-	la     %r1,0f-.LPG1(%r13)	# set program check address
-	stg    %r1,__LC_PGM_NEW_PSW+8
-	stap   __LC_CPUID+4		# store cpu address
-	lh     %r1,__LC_CPUID+4
-	diag   %r1,0,0x9c		# test diag 0x9c
-	oi     6(%r12),1		# set diag9c flag
+	la	%r1,0f-.LPG1(%r13)	# set program check address
+	stg	%r1,__LC_PGM_NEW_PSW+8
+	stap	__LC_CPUID+4		# store cpu address
+	lh	%r1,__LC_CPUID+4
+	diag	%r1,0,0x9c		# test diag 0x9c
+	oi	6(%r12),1		# set diag9c flag
 0:
 
 #
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index a21cfbb..49f2b68 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -70,7 +70,6 @@ struct {
 #define CHUNK_READ_WRITE 0
 #define CHUNK_READ_ONLY 1
 volatile int __cpu_logical_map[NR_CPUS]; /* logical cpu to cpu address */
-unsigned long __initdata zholes_size[MAX_NR_ZONES];
 static unsigned long __initdata memory_end;
 
 /*
@@ -358,21 +357,6 @@ void machine_power_off(void)
  */
 void (*pm_power_off)(void) = machine_power_off;
 
-static void __init
-add_memory_hole(unsigned long start, unsigned long end)
-{
-	unsigned long dma_pfn = MAX_DMA_ADDRESS >> PAGE_SHIFT;
-
-	if (end <= dma_pfn)
-		zholes_size[ZONE_DMA] += end - start + 1;
-	else if (start > dma_pfn)
-		zholes_size[ZONE_NORMAL] += end - start + 1;
-	else {
-		zholes_size[ZONE_DMA] += dma_pfn - start + 1;
-		zholes_size[ZONE_NORMAL] += end - dma_pfn;
-	}
-}
-
 static int __init early_parse_mem(char *p)
 {
 	memory_end = memparse(p, &p);
@@ -494,7 +478,6 @@ setup_memory(void)
 {
         unsigned long bootmap_size;
 	unsigned long start_pfn, end_pfn, init_pfn;
-	unsigned long last_rw_end;
 	int i;
 
 	/*
@@ -543,46 +526,34 @@ #ifdef CONFIG_BLK_DEV_INITRD
 #endif
 
 	/*
-	 * Initialize the boot-time allocator (with low memory only):
+	 * Initialize the boot-time allocator
 	 */
 	bootmap_size = init_bootmem(start_pfn, end_pfn);
 
 	/*
 	 * Register RAM areas with the bootmem allocator.
 	 */
-	last_rw_end = start_pfn;
 
 	for (i = 0; i < MEMORY_CHUNKS && memory_chunk[i].size > 0; i++) {
-		unsigned long start_chunk, end_chunk;
+		unsigned long start_chunk, end_chunk, pfn;
 
 		if (memory_chunk[i].type != CHUNK_READ_WRITE)
 			continue;
-		start_chunk = (memory_chunk[i].addr + PAGE_SIZE - 1);
-		start_chunk >>= PAGE_SHIFT;
-		end_chunk = (memory_chunk[i].addr + memory_chunk[i].size);
-		end_chunk >>= PAGE_SHIFT;
-		if (start_chunk < start_pfn)
-			start_chunk = start_pfn;
-		if (end_chunk > end_pfn)
-			end_chunk = end_pfn;
-		if (start_chunk < end_chunk) {
-			/* Initialize storage key for RAM pages */
-			for (init_pfn = start_chunk ; init_pfn < end_chunk;
-			     init_pfn++)
-				page_set_storage_key(init_pfn << PAGE_SHIFT,
-						     PAGE_DEFAULT_KEY);
-			free_bootmem(start_chunk << PAGE_SHIFT,
-				     (end_chunk - start_chunk) << PAGE_SHIFT);
-			if (last_rw_end < start_chunk)
-				add_memory_hole(last_rw_end, start_chunk - 1);
-			last_rw_end = end_chunk;
-		}
+		start_chunk = PFN_DOWN(memory_chunk[i].addr);
+		end_chunk = start_chunk + PFN_DOWN(memory_chunk[i].size) - 1;
+		end_chunk = min(end_chunk, end_pfn);
+		if (start_chunk >= end_chunk)
+			continue;
+		add_active_range(0, start_chunk, end_chunk);
+		pfn = max(start_chunk, start_pfn);
+		for (; pfn <= end_chunk; pfn++)
+			page_set_storage_key(PFN_PHYS(pfn), PAGE_DEFAULT_KEY);
 	}
 
 	psw_set_key(PAGE_DEFAULT_KEY);
 
-	if (last_rw_end < end_pfn - 1)
-		add_memory_hole(last_rw_end, end_pfn - 1);
+	free_bootmem_with_active_regions(0, max_pfn);
+	reserve_bootmem(0, PFN_PHYS(start_pfn));
 
 	/*
 	 * Reserve the bootmem bitmap itself as well. We do this in two
diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index 642095e..4392a77 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -113,17 +113,15 @@ sys_sigaltstack(const stack_t __user *us
 /* Returns non-zero on fault. */
 static int save_sigregs(struct pt_regs *regs, _sigregs __user *sregs)
 {
-	unsigned long old_mask = regs->psw.mask;
 	_sigregs user_sregs;
 
 	save_access_regs(current->thread.acrs);
 
 	/* Copy a 'clean' PSW mask to the user to avoid leaking
 	   information about whether PER is currently on.  */
-	regs->psw.mask = PSW_MASK_MERGE(PSW_USER_BITS, regs->psw.mask);
-	memcpy(&user_sregs.regs.psw, &regs->psw, sizeof(sregs->regs.psw) +
-	       sizeof(sregs->regs.gprs));
-	regs->psw.mask = old_mask;
+	user_sregs.regs.psw.mask = PSW_MASK_MERGE(PSW_USER_BITS, regs->psw.mask);
+	user_sregs.regs.psw.addr = regs->psw.addr;
+	memcpy(&user_sregs.regs.gprs, &regs->gprs, sizeof(sregs->regs.gprs));
 	memcpy(&user_sregs.regs.acrs, current->thread.acrs,
 	       sizeof(sregs->regs.acrs));
 	/* 
@@ -139,7 +137,6 @@ static int save_sigregs(struct pt_regs *
 /* Returns positive number on error */
 static int restore_sigregs(struct pt_regs *regs, _sigregs __user *sregs)
 {
-	unsigned long old_mask = regs->psw.mask;
 	int err;
 	_sigregs user_sregs;
 
@@ -147,12 +144,12 @@ static int restore_sigregs(struct pt_reg
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
 
 	err = __copy_from_user(&user_sregs, sregs, sizeof(_sigregs));
-	regs->psw.mask = PSW_MASK_MERGE(old_mask, regs->psw.mask);
-	regs->psw.addr |= PSW_ADDR_AMODE;
 	if (err)
 		return err;
-	memcpy(&regs->psw, &user_sregs.regs.psw, sizeof(sregs->regs.psw) +
-	       sizeof(sregs->regs.gprs));
+	regs->psw.mask = PSW_MASK_MERGE(regs->psw.mask,
+					user_sregs.regs.psw.mask);
+	regs->psw.addr = PSW_ADDR_AMODE | user_sregs.regs.psw.addr;
+	memcpy(&regs->gprs, &user_sregs.regs.gprs, sizeof(sregs->regs.gprs));
 	memcpy(&current->thread.acrs, &user_sregs.regs.acrs,
 	       sizeof(sregs->regs.acrs));
 	restore_access_regs(current->thread.acrs);
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index 93be1d5..e59baec 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -318,3 +318,5 @@ SYSCALL(sys_splice,sys_splice,sys_splice
 SYSCALL(sys_sync_file_range,sys_sync_file_range,sys_sync_file_range_wrapper)
 SYSCALL(sys_tee,sys_tee,sys_tee_wrapper)
 SYSCALL(sys_vmsplice,sys_vmsplice,compat_sys_vmsplice_wrapper)
+NI_SYSCALL							/* 310 sys_move_pages */
+SYSCALL(sys_getcpu,sys_getcpu,sys_getcpu_wrapper)
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 127044e..d998917 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -62,19 +62,21 @@ void show_mem(void)
 {
         int i, total = 0, reserved = 0;
         int shared = 0, cached = 0;
+	struct page *page;
 
         printk("Mem-info:\n");
         show_free_areas();
         printk("Free swap:       %6ldkB\n", nr_swap_pages<<(PAGE_SHIFT-10));
         i = max_mapnr;
         while (i-- > 0) {
+		page = pfn_to_page(i);
                 total++;
-                if (PageReserved(mem_map+i))
+		if (PageReserved(page))
                         reserved++;
-                else if (PageSwapCache(mem_map+i))
+		else if (PageSwapCache(page))
                         cached++;
-                else if (page_count(mem_map+i))
-                        shared += page_count(mem_map+i) - 1;
+		else if (page_count(page))
+			shared += page_count(page) - 1;
         }
         printk("%d pages of RAM\n",total);
         printk("%d reserved pages\n",reserved);
@@ -82,7 +84,6 @@ void show_mem(void)
         printk("%d pages swap cached\n",cached);
 }
 
-extern unsigned long __initdata zholes_size[];
 /*
  * paging_init() sets up the page tables
  */
@@ -99,16 +100,15 @@ void __init paging_init(void)
         unsigned long pgdir_k = (__pa(swapper_pg_dir) & PAGE_MASK) | _KERNSEG_TABLE;
         static const int ssm_mask = 0x04000000L;
 	unsigned long ro_start_pfn, ro_end_pfn;
-	unsigned long zones_size[MAX_NR_ZONES];
+	unsigned long max_zone_pfns[MAX_NR_ZONES];
 
 	ro_start_pfn = PFN_DOWN((unsigned long)&__start_rodata);
 	ro_end_pfn = PFN_UP((unsigned long)&__end_rodata);
 
-	memset(zones_size, 0, sizeof(zones_size));
-	zones_size[ZONE_DMA] = max_low_pfn;
-	free_area_init_node(0, &contig_page_data, zones_size,
-			    __pa(PAGE_OFFSET) >> PAGE_SHIFT,
-			    zholes_size);
+	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
+	max_zone_pfns[ZONE_DMA] = max_low_pfn;
+	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
+	free_area_init_nodes(max_zone_pfns);
 
 	/* unmap whole virtual address space */
 	
@@ -153,7 +153,6 @@ void __init paging_init(void)
 	__raw_local_irq_ssm(ssm_mask);
 
         local_flush_tlb();
-        return;
 }
 
 #else /* CONFIG_64BIT */
@@ -169,26 +168,16 @@ void __init paging_init(void)
         unsigned long pgdir_k = (__pa(swapper_pg_dir) & PAGE_MASK) |
           _KERN_REGION_TABLE;
 	static const int ssm_mask = 0x04000000L;
-	unsigned long zones_size[MAX_NR_ZONES];
-	unsigned long dma_pfn, high_pfn;
 	unsigned long ro_start_pfn, ro_end_pfn;
+	unsigned long max_zone_pfns[MAX_NR_ZONES];
 
-	memset(zones_size, 0, sizeof(zones_size));
-	dma_pfn = MAX_DMA_ADDRESS >> PAGE_SHIFT;
-	high_pfn = max_low_pfn;
 	ro_start_pfn = PFN_DOWN((unsigned long)&__start_rodata);
 	ro_end_pfn = PFN_UP((unsigned long)&__end_rodata);
 
-	if (dma_pfn > high_pfn)
-		zones_size[ZONE_DMA] = high_pfn;
-	else {
-		zones_size[ZONE_DMA] = dma_pfn;
-		zones_size[ZONE_NORMAL] = high_pfn - dma_pfn;
-	}
-
-	/* Initialize mem_map[].  */
-	free_area_init_node(0, &contig_page_data, zones_size,
-			    __pa(PAGE_OFFSET) >> PAGE_SHIFT, zholes_size);
+	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
+	max_zone_pfns[ZONE_DMA] = PFN_DOWN(MAX_DMA_ADDRESS);
+	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
+	free_area_init_nodes(max_zone_pfns);
 
 	/*
 	 * map whole physical memory to virtual memory (identity mapping) 
@@ -237,8 +226,6 @@ void __init paging_init(void)
 	__raw_local_irq_ssm(ssm_mask);
 
         local_flush_tlb();
-
-        return;
 }
 #endif /* CONFIG_64BIT */
 
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index dace46f..b676202 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -349,6 +349,8 @@ ccw_device_done(struct ccw_device *cdev,
 
 	sch = to_subchannel(cdev->dev.parent);
 
+	ccw_device_set_timeout(cdev, 0);
+
 	if (state != DEV_STATE_ONLINE)
 		cio_disable_subchannel(sch);
 
diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index 93a897e..84b9b18 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -216,6 +216,9 @@ ccw_device_call_handler(struct ccw_devic
 	      (stctl & SCSW_STCTL_PRIM_STATUS)))
 		return 0;
 
+	/* Clear pending timers for device driver initiated I/O. */
+	if (ending_status)
+		ccw_device_set_timeout(cdev, 0);
 	/*
 	 * Now we are ready to call the device driver interrupt handler.
 	 */
@@ -285,10 +288,10 @@ ccw_device_wake_up(struct ccw_device *cd
 		 if (cdev->private->flags.doverify ||
 			 cdev->private->state == DEV_STATE_VERIFY)
 			 cdev->private->intparm = -EAGAIN;
-		 if ((irb->scsw.dstat & DEV_STAT_UNIT_CHECK) &&
-		     !(irb->ecw[0] &
-		       (SNS0_CMD_REJECT | SNS0_INTERVENTION_REQ)))
-			 cdev->private->intparm = -EAGAIN;
+		else if ((irb->scsw.dstat & DEV_STAT_UNIT_CHECK) &&
+			 !(irb->ecw[0] &
+			   (SNS0_CMD_REJECT | SNS0_INTERVENTION_REQ)))
+			cdev->private->intparm = -EAGAIN;
 		else if ((irb->scsw.dstat & DEV_STAT_ATTENTION) &&
 			 (irb->scsw.dstat & DEV_STAT_DEV_END) &&
 			 (irb->scsw.dstat & DEV_STAT_UNIT_EXCEP))
@@ -309,7 +312,10 @@ __ccw_device_retry_loop(struct ccw_devic
 
 	sch = to_subchannel(cdev->dev.parent);
 	do {
+		ccw_device_set_timeout(cdev, 60 * HZ);
 		ret = cio_start (sch, ccw, lpm);
+		if (ret != 0)
+			ccw_device_set_timeout(cdev, 0);
 		if (ret == -EBUSY) {
 			/* Try again later. */
 			spin_unlock_irq(&sch->lock);
diff --git a/drivers/s390/cio/device_pgid.c b/drivers/s390/cio/device_pgid.c
index 8ca2d07..84917b3 100644
--- a/drivers/s390/cio/device_pgid.c
+++ b/drivers/s390/cio/device_pgid.c
@@ -96,6 +96,9 @@ ccw_device_sense_pgid_start(struct ccw_d
 {
 	int ret;
 
+	/* Set a timeout of 60s */
+	ccw_device_set_timeout(cdev, 60*HZ);
+
 	cdev->private->state = DEV_STATE_SENSE_PGID;
 	cdev->private->imask = 0x80;
 	cdev->private->iretry = 5;
@@ -480,6 +483,8 @@ ccw_device_verify_start(struct ccw_devic
 		ccw_device_verify_done(cdev, -ENODEV);
 		return;
 	}
+	/* After 60s path verification is considered to have failed. */
+	ccw_device_set_timeout(cdev, 60*HZ);
 	__ccw_device_verify_start(cdev);
 }
 
@@ -554,6 +559,9 @@ ccw_device_disband_irq(struct ccw_device
 void
 ccw_device_disband_start(struct ccw_device *cdev)
 {
+	/* After 60s disbanding is considered to have failed. */
+	ccw_device_set_timeout(cdev, 60*HZ);
+
 	cdev->private->flags.pgid_single = 0;
 	cdev->private->iretry = 5;
 	cdev->private->imask = 0x80;
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 6ed0985..cd30f37 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -449,8 +449,6 @@ static int ap_device_probe(struct device
 
 	ap_dev->drv = ap_drv;
 	rc = ap_drv->probe ? ap_drv->probe(ap_dev) : -ENODEV;
-	if (rc)
-		ap_dev->unregistered = 1;
 	return rc;
 }
 
@@ -487,14 +485,7 @@ static int ap_device_remove(struct devic
 	struct ap_device *ap_dev = to_ap_dev(dev);
 	struct ap_driver *ap_drv = ap_dev->drv;
 
-	spin_lock_bh(&ap_dev->lock);
-	__ap_flush_queue(ap_dev);
-	/**
-	 * set ->unregistered to 1 while holding the lock. This prevents
-	 * new messages to be put on the queue from now on.
-	 */
-	ap_dev->unregistered = 1;
-	spin_unlock_bh(&ap_dev->lock);
+	ap_flush_queue(ap_dev);
 	if (ap_drv->remove)
 		ap_drv->remove(ap_dev);
 	return 0;
@@ -763,6 +754,7 @@ static void ap_scan_bus(void *data)
 			break;
 		ap_dev->qid = qid;
 		ap_dev->queue_depth = queue_depth;
+		ap_dev->unregistered = 1;
 		spin_lock_init(&ap_dev->lock);
 		INIT_LIST_HEAD(&ap_dev->pendingq);
 		INIT_LIST_HEAD(&ap_dev->requestq);
@@ -784,7 +776,12 @@ static void ap_scan_bus(void *data)
 		/* Add device attributes. */
 		rc = sysfs_create_group(&ap_dev->device.kobj,
 					&ap_dev_attr_group);
-		if (rc)
+		if (!rc) {
+			spin_lock_bh(&ap_dev->lock);
+			ap_dev->unregistered = 0;
+			spin_unlock_bh(&ap_dev->lock);
+		}
+		else
 			device_unregister(&ap_dev->device);
 	}
 }
@@ -970,6 +967,8 @@ void ap_queue_message(struct ap_device *
 			rc = __ap_queue_message(ap_dev, ap_msg);
 		if (!rc)
 			wake_up(&ap_poll_wait);
+		if (rc == -ENODEV)
+			ap_dev->unregistered = 1;
 	} else {
 		ap_dev->drv->receive(ap_dev, ap_msg, ERR_PTR(-ENODEV));
 		rc = 0;
@@ -1028,6 +1027,8 @@ static int __ap_poll_all(struct device *
 	spin_lock(&ap_dev->lock);
 	if (!ap_dev->unregistered) {
 		rc = ap_poll_queue(to_ap_dev(dev), (unsigned long *) data);
+		if (rc)
+			ap_dev->unregistered = 1;
 	} else
 		rc = 0;
 	spin_unlock(&ap_dev->lock);
diff --git a/include/asm-s390/io.h b/include/asm-s390/io.h
index 63c78b9..efb7de9 100644
--- a/include/asm-s390/io.h
+++ b/include/asm-s390/io.h
@@ -45,11 +45,6 @@ static inline void * phys_to_virt(unsign
         return __io_virt(address);
 }
 
-/*
- * Change "struct page" to physical address.
- */
-#define page_to_phys(page)	((page - mem_map) << PAGE_SHIFT)
-
 extern void * __ioremap(unsigned long offset, unsigned long size, unsigned long flags);
 
 static inline void * ioremap (unsigned long offset, unsigned long size)
diff --git a/include/asm-s390/page.h b/include/asm-s390/page.h
index 796c400..363ea76 100644
--- a/include/asm-s390/page.h
+++ b/include/asm-s390/page.h
@@ -137,6 +137,7 @@ #define PAGE_OFFSET             0x0UL
 #define __pa(x)                 (unsigned long)(x)
 #define __va(x)                 (void *)(unsigned long)(x)
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+#define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
 
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
diff --git a/include/asm-s390/pgalloc.h b/include/asm-s390/pgalloc.h
index 803bc70..28619de 100644
--- a/include/asm-s390/pgalloc.h
+++ b/include/asm-s390/pgalloc.h
@@ -116,7 +116,7 @@ #endif /* __s390x__ */
 static inline void
 pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct page *page)
 {
-	pmd_populate_kernel(mm, pmd, (pte_t *)((page-mem_map) << PAGE_SHIFT));
+	pmd_populate_kernel(mm, pmd, (pte_t *)page_to_phys(page));
 }
 
 /*
diff --git a/include/asm-s390/pgtable.h b/include/asm-s390/pgtable.h
index ecdff13..519f0a5 100644
--- a/include/asm-s390/pgtable.h
+++ b/include/asm-s390/pgtable.h
@@ -599,7 +599,7 @@ #define ptep_set_access_flags(__vma, __a
  */
 static inline int page_test_and_clear_dirty(struct page *page)
 {
-	unsigned long physpage = __pa((page - mem_map) << PAGE_SHIFT);
+	unsigned long physpage = page_to_phys(page);
 	int skey = page_get_storage_key(physpage);
 
 	if (skey & _PAGE_CHANGED)
@@ -612,13 +612,13 @@ static inline int page_test_and_clear_di
  */
 static inline int page_test_and_clear_young(struct page *page)
 {
-	unsigned long physpage = __pa((page - mem_map) << PAGE_SHIFT);
+	unsigned long physpage = page_to_phys(page);
 	int ccode;
 
-	asm volatile (
-		"rrbe 0,%1\n"
-		"ipm  %0\n"
-		"srl  %0,28\n"
+	asm volatile(
+		"	rrbe	0,%1\n"
+		"	ipm	%0\n"
+		"	srl	%0,28\n"
 		: "=d" (ccode) : "a" (physpage) : "cc" );
 	return ccode & 2;
 }
@@ -636,7 +636,7 @@ static inline pte_t mk_pte_phys(unsigned
 
 static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
 {
-	unsigned long physpage = __pa((page - mem_map) << PAGE_SHIFT);
+	unsigned long physpage = page_to_phys(page);
 
 	return mk_pte_phys(physpage, pgprot);
 }
@@ -664,11 +664,11 @@ #define pte_page(x) pfn_to_page(pte_pfn(
 
 #define pmd_page_vaddr(pmd) (pmd_val(pmd) & PAGE_MASK)
 
-#define pmd_page(pmd) (mem_map+(pmd_val(pmd) >> PAGE_SHIFT))
+#define pmd_page(pmd) pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT)
 
 #define pgd_page_vaddr(pgd) (pgd_val(pgd) & PAGE_MASK)
 
-#define pgd_page(pgd) (mem_map+(pgd_val(pgd) >> PAGE_SHIFT))
+#define pgd_page(pgd) pfn_to_page(pgd_val(pgd) >> PAGE_SHIFT)
 
 /* to find an entry in a page-table-directory */
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
diff --git a/include/asm-s390/spinlock.h b/include/asm-s390/spinlock.h
index 6b78af1..3fd4382 100644
--- a/include/asm-s390/spinlock.h
+++ b/include/asm-s390/spinlock.h
@@ -11,10 +11,10 @@
 #ifndef __ASM_SPINLOCK_H
 #define __ASM_SPINLOCK_H
 
-#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
-
 #include <linux/smp.h>
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
+
 static inline int
 _raw_compare_and_swap(volatile unsigned int *lock,
 		      unsigned int old, unsigned int new)
diff --git a/include/asm-s390/unistd.h b/include/asm-s390/unistd.h
index 0cccfd8..a19238c 100644
--- a/include/asm-s390/unistd.h
+++ b/include/asm-s390/unistd.h
@@ -247,8 +247,10 @@ #define __NR_splice		306
 #define __NR_sync_file_range	307
 #define __NR_tee		308
 #define __NR_vmsplice		309
+/* Number 310 is reserved for new sys_move_pages */
+#define __NR_getcpu		311
 
-#define NR_syscalls 310
+#define NR_syscalls 312
 
 /* 
  * There are some system calls that are not present on 64 bit, some
