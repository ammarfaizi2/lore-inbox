Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261743AbTCZPQG>; Wed, 26 Mar 2003 10:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261734AbTCZPPU>; Wed, 26 Mar 2003 10:15:20 -0500
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:9387 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261727AbTCZPKg> convert rfc822-to-8bit; Wed, 26 Mar 2003 10:10:36 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 update (1/9): s390 arch fixes.
Date: Wed, 26 Mar 2003 16:05:33 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303261605.33937.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Initialize timing related variables first and then enable the timer interrupt.
* Normalize nano seconds to micro seconds in do_gettimeofday.
* Add types for __kernel_timer_t and __kernel_clockid_t.
* Fix ugly bug in switch_to: set prev to the return value of resume, otherwise
  prev still contains the previous process at the time resume was called and
  not the previous process at the time resume returned. They differ...
* Add missing include to get the kernel compiled.
* Get a closer match with the i386 termios.h file.
* Cope with INITIAL_JIFFIES.
* Define cpu_relax to do a cpu yield on VM and LPAR.
* Don't reenable interrupts in program check handler.
* Add pte_file definitions.
* Console initialization fixes for 3215 and sclp.

diffstat:
 arch/s390/defconfig             |   76 ++++++++++++++++++++++++--------------
 arch/s390/kernel/entry.S        |    4 --
 arch/s390/kernel/ptrace.c       |   21 ++++++----
 arch/s390/kernel/time.c         |   16 ++++----
 arch/s390/mm/ioremap.c          |    2 -
 arch/s390x/defconfig            |   80 +++++++++++++++++++++++++---------------
 arch/s390x/kernel/entry.S       |    4 --
 arch/s390x/kernel/ptrace.c      |   27 ++++++++++---
 arch/s390x/kernel/time.c        |   20 +++++-----
 arch/s390x/mm/ioremap.c         |    2 -
 drivers/s390/char/con3215.c     |    9 ++--
 drivers/s390/char/sclp_tty.c    |    3 -
 include/asm-s390/pgtable.h      |   69 +++++++++++++++++++++++-----------
 include/asm-s390/posix_types.h  |    2 +
 include/asm-s390/processor.h    |    5 ++
 include/asm-s390/signal.h       |    1 
 include/asm-s390/system.h       |    2 -
 include/asm-s390/termios.h      |   25 ++++++------
 include/asm-s390x/pgtable.h     |   57 +++++++++++++++++++---------
 include/asm-s390x/posix_types.h |    2 +
 include/asm-s390x/processor.h   |    6 ++-
 include/asm-s390x/signal.h      |    1 
 include/asm-s390x/system.h      |    2 -
 include/asm-s390x/termios.h     |   27 ++++++-------
 24 files changed, 290 insertions(+), 173 deletions(-)

diff -urN linux-2.5.66/arch/s390/defconfig linux-2.5.66-s390/arch/s390/defconfig
--- linux-2.5.66/arch/s390/defconfig	Mon Mar 24 23:01:23 2003
+++ linux-2.5.66-s390/arch/s390/defconfig	Wed Mar 26 15:45:10 2003
@@ -2,7 +2,6 @@
 # Automatically generated make config: don't edit
 #
 CONFIG_MMU=y
-CONFIG_SWAP=y
 CONFIG_UID16=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_ARCH_S390=y
@@ -15,6 +14,7 @@
 #
 # General setup
 #
+CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
@@ -158,6 +158,9 @@
 # CONFIG_INET_ESP is not set
 # CONFIG_XFRM_USER is not set
 CONFIG_IPV6=m
+# CONFIG_IPV6_PRIVACY is not set
+# CONFIG_INET6_AH is not set
+# CONFIG_INET6_ESP is not set
 
 #
 # SCTP Configuration (EXPERIMENTAL)
@@ -252,48 +255,63 @@
 #
 # File systems
 #
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
 # CONFIG_QUOTA is not set
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
-# CONFIG_REISERFS_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_FAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+# CONFIG_DEVFS_FS is not set
+CONFIG_DEVPTS_FS=y
+# CONFIG_TMPFS is not set
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_XATTR=y
-# CONFIG_EXT3_FS_POSIX_ACL is not set
-CONFIG_JBD=y
-# CONFIG_JBD_DEBUG is not set
-# CONFIG_FAT_FS is not set
 # CONFIG_EFS_FS is not set
 # CONFIG_CRAMFS is not set
-# CONFIG_TMPFS is not set
-CONFIG_RAMFS=y
-# CONFIG_ISO9660_FS is not set
-# CONFIG_JFS_FS is not set
-# CONFIG_MINIX_FS is not set
 # CONFIG_VXFS_FS is not set
-# CONFIG_NTFS_FS is not set
 # CONFIG_HPFS_FS is not set
-CONFIG_PROC_FS=y
-# CONFIG_DEVFS_FS is not set
-CONFIG_DEVPTS_FS=y
 # CONFIG_QNX4FS_FS is not set
-# CONFIG_ROMFS_FS is not set
-CONFIG_EXT2_FS=y
-# CONFIG_EXT2_FS_XATTR is not set
 # CONFIG_SYSV_FS is not set
-# CONFIG_UDF_FS is not set
 # CONFIG_UFS_FS is not set
-# CONFIG_XFS_FS is not set
 
 #
 # Network File Systems
 #
-# CONFIG_CODA_FS is not set
-# CONFIG_INTERMEZZO_FS is not set
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V4 is not set
@@ -301,16 +319,17 @@
 CONFIG_NFSD_V3=y
 # CONFIG_NFSD_V4 is not set
 # CONFIG_NFSD_TCP is not set
-CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_GSS is not set
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_EXPORTFS=y
-# CONFIG_CIFS is not set
+CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_GSS is not set
 # CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_INTERMEZZO_FS is not set
 # CONFIG_AFS_FS is not set
-CONFIG_FS_MBCACHE=y
 
 #
 # Partition Types
@@ -324,6 +343,7 @@
 # CONFIG_MAC_PARTITION is not set
 # CONFIG_MSDOS_PARTITION is not set
 # CONFIG_LDM_PARTITION is not set
+# CONFIG_NEC98_PARTITION is not set
 # CONFIG_SGI_PARTITION is not set
 # CONFIG_ULTRIX_PARTITION is not set
 # CONFIG_SUN_PARTITION is not set
diff -urN linux-2.5.66/arch/s390/kernel/entry.S linux-2.5.66-s390/arch/s390/kernel/entry.S
--- linux-2.5.66/arch/s390/kernel/entry.S	Mon Mar 24 23:00:08 2003
+++ linux-2.5.66-s390/arch/s390/kernel/entry.S	Wed Mar 26 15:45:10 2003
@@ -644,13 +644,12 @@
         tm      __LC_PGM_INT_CODE+1,0x80 # check whether we got a per exception
         bnz     BASED(pgm_per)           # got per exception -> special case
 	SAVE_ALL __LC_PGM_OLD_PSW,1
-	la	%r8,0x7f
         l       %r3,__LC_PGM_ILC         # load program interruption code
+	la	%r8,0x7f
         l       %r7,BASED(.Ljump_table)
 	nr	%r8,%r3
         sll     %r8,2
 	GET_THREAD_INFO
-        stosm   24(%r15),0x03            # reenable interrupts
         l       %r7,0(%r8,%r7)		 # load address of handler routine
         la      %r2,SP_PTREGS(%r15)	 # address of register-save area
 	la      %r14,BASED(sysc_return)
@@ -677,7 +676,6 @@
 	GET_THREAD_INFO
 	la	%r4,0x7f
 	l	%r3,__LC_PGM_ILC	 # load program interruption code
-        stosm   24(%r15),0x03            # reenable interrupts
         nr      %r4,%r3                  # clear per-event-bit and ilc
         be      BASED(pgm_per_only)      # only per or per+check ?
         l       %r1,BASED(.Ljump_table)
diff -urN linux-2.5.66/arch/s390/kernel/ptrace.c linux-2.5.66-s390/arch/s390/kernel/ptrace.c
--- linux-2.5.66/arch/s390/kernel/ptrace.c	Mon Mar 24 23:01:24 2003
+++ linux-2.5.66-s390/arch/s390/kernel/ptrace.c	Wed Mar 26 15:45:10 2003
@@ -207,21 +207,24 @@
 		return ptrace_attach(child);
 
 	/*
-	 * I added child != current line so we can get the
-	 * ieee_instruction_pointer from the user structure DJB
+	 * Special cases to get/store the ieee instructions pointer.
 	 */
-	if (child != current) {
-		ret = ptrace_check_attach(child, request == PTRACE_KILL);
-		if (ret < 0)
-			return ret;
+	if (child == current) {
+		if (request == PTRACE_PEEKUSR && addr == PT_IEEE_IP)
+			return peek_user(child, addr, data);
+		if (request == PTRACE_POKEUSR && addr == PT_IEEE_IP)
+			return poke_user(child, addr, data);
 	}
 
-	/* Remove high order bit from address. */
-	addr &= PSW_ADDR_INSN;
+	ret = ptrace_check_attach(child, request == PTRACE_KILL);
+	if (ret < 0)
+		return ret;
 
 	switch (request) {
 	case PTRACE_PEEKTEXT:
 	case PTRACE_PEEKDATA:
+		/* Remove high order bit from address. */
+		addr &= PSW_ADDR_INSN;
 		/* read word at location addr. */
 		copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
 		if (copied != sizeof(tmp))
@@ -234,6 +237,8 @@
 
 	case PTRACE_POKETEXT:
 	case PTRACE_POKEDATA:
+		/* Remove high order bit from address. */
+		addr &= PSW_ADDR_INSN;
 		/* write the word at location addr. */
 		copied = access_process_vm(child, addr, &data, sizeof(data),1);
 		if (copied != sizeof(data))
diff -urN linux-2.5.66/arch/s390/kernel/time.c linux-2.5.66-s390/arch/s390/kernel/time.c
--- linux-2.5.66/arch/s390/kernel/time.c	Mon Mar 24 22:59:53 2003
+++ linux-2.5.66-s390/arch/s390/kernel/time.c	Wed Mar 26 15:45:10 2003
@@ -49,8 +49,9 @@
 u64 jiffies_64 = INITIAL_JIFFIES;
 
 static ext_int_info_t ext_int_info_timer;
-static uint64_t xtime_cc;
-static uint64_t init_timer_cc;
+static u64 init_timer_cc;
+static u64 jiffies_timer_cc;
+static u64 xtime_cc;
 
 extern unsigned long wall_jiffies;
 
@@ -70,7 +71,7 @@
 	__u64 now;
 
 	asm volatile ("STCK 0(%0)" : : "a" (&now) : "memory", "cc");
-        now = (now - init_timer_cc) >> 12;
+        now = (now - jiffies_timer_cc) >> 12;
 	/* We require the offset from the latest update of xtime */
 	now -= (__u64) wall_jiffies*USECS_PER_JIFFY;
 	return (unsigned long) now;
@@ -202,14 +203,14 @@
 	unsigned long cr0;
 	__u64 timer;
 
+	timer = jiffies_timer_cc + jiffies_64 * CLK_TICKS_PER_JIFFY;
+	S390_lowcore.jiffy_timer = timer;
+	timer += CLK_TICKS_PER_JIFFY + CPU_DEVIATION;
+	asm volatile ("SCKC %0" : : "m" (timer));
         /* allow clock comparator timer interrupt */
         asm volatile ("STCTL 0,0,%0" : "=m" (cr0) : : "memory");
         cr0 |= 0x800;
         asm volatile ("LCTL 0,0,%0" : : "m" (cr0) : "memory");
-	timer = init_timer_cc + jiffies_64 * CLK_TICKS_PER_JIFFY;
-	S390_lowcore.jiffy_timer = timer;
-	timer += CLK_TICKS_PER_JIFFY + CPU_DEVIATION;
-	asm volatile ("SCKC %0" : : "m" (timer));
 }
 
 /*
@@ -239,6 +240,7 @@
                 printk("time_init: TOD clock stopped/non-operational\n");
                 break;
         }
+	jiffies_timer_cc = init_timer_cc - jiffies_64 * CLK_TICKS_PER_JIFFY;
 
 	/* set xtime */
 	xtime_cc = init_timer_cc;
diff -urN linux-2.5.66/arch/s390/mm/ioremap.c linux-2.5.66-s390/arch/s390/mm/ioremap.c
--- linux-2.5.66/arch/s390/mm/ioremap.c	Mon Mar 24 23:00:04 2003
+++ linux-2.5.66-s390/arch/s390/mm/ioremap.c	Wed Mar 26 15:45:10 2003
@@ -38,7 +38,7 @@
                         printk("remap_area_pte: page already exists\n");
 			BUG();
 		}
-                set_pte(pte, pfn_pte(pfn, __pgprot(_PAGE_PRESENT | flags)));
+                set_pte(pte, pfn_pte(pfn, __pgprot(flags)));
                 address += PAGE_SIZE;
                 pfn++;
                 pte++;
diff -urN linux-2.5.66/arch/s390x/defconfig linux-2.5.66-s390/arch/s390x/defconfig
--- linux-2.5.66/arch/s390x/defconfig	Mon Mar 24 22:59:53 2003
+++ linux-2.5.66-s390/arch/s390x/defconfig	Wed Mar 26 15:45:10 2003
@@ -2,7 +2,6 @@
 # Automatically generated make config: don't edit
 #
 CONFIG_MMU=y
-CONFIG_SWAP=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_ARCH_S390=y
 CONFIG_ARCH_S390X=y
@@ -15,6 +14,7 @@
 #
 # General setup
 #
+CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
@@ -38,7 +38,9 @@
 #
 CONFIG_SMP=y
 CONFIG_NR_CPUS=64
-# CONFIG_S390_SUPPORT is not set
+CONFIG_S390_SUPPORT=y
+CONFIG_COMPAT=y
+CONFIG_BINFMT_ELF32=y
 
 #
 # I/O subsystem configuration
@@ -158,6 +160,9 @@
 # CONFIG_INET_ESP is not set
 # CONFIG_XFRM_USER is not set
 CONFIG_IPV6=m
+# CONFIG_IPV6_PRIVACY is not set
+# CONFIG_INET6_AH is not set
+# CONFIG_INET6_ESP is not set
 
 #
 # SCTP Configuration (EXPERIMENTAL)
@@ -252,51 +257,66 @@
 #
 # File systems
 #
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
 CONFIG_QUOTA=y
 # CONFIG_QFMT_V1 is not set
 # CONFIG_QFMT_V2 is not set
 CONFIG_QUOTACTL=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
-# CONFIG_REISERFS_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_FAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+# CONFIG_DEVFS_FS is not set
+CONFIG_DEVPTS_FS=y
+# CONFIG_TMPFS is not set
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_XATTR=y
-# CONFIG_EXT3_FS_POSIX_ACL is not set
-CONFIG_JBD=y
-# CONFIG_JBD_DEBUG is not set
-# CONFIG_FAT_FS is not set
 # CONFIG_EFS_FS is not set
 # CONFIG_CRAMFS is not set
-# CONFIG_TMPFS is not set
-CONFIG_RAMFS=y
-# CONFIG_ISO9660_FS is not set
-# CONFIG_JFS_FS is not set
-# CONFIG_MINIX_FS is not set
 # CONFIG_VXFS_FS is not set
-# CONFIG_NTFS_FS is not set
 # CONFIG_HPFS_FS is not set
-CONFIG_PROC_FS=y
-# CONFIG_DEVFS_FS is not set
-CONFIG_DEVPTS_FS=y
 # CONFIG_QNX4FS_FS is not set
-# CONFIG_ROMFS_FS is not set
-CONFIG_EXT2_FS=y
-# CONFIG_EXT2_FS_XATTR is not set
 # CONFIG_SYSV_FS is not set
-# CONFIG_UDF_FS is not set
 # CONFIG_UFS_FS is not set
-# CONFIG_XFS_FS is not set
 
 #
 # Network File Systems
 #
-# CONFIG_CODA_FS is not set
-# CONFIG_INTERMEZZO_FS is not set
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V4 is not set
@@ -304,16 +324,17 @@
 CONFIG_NFSD_V3=y
 # CONFIG_NFSD_V4 is not set
 # CONFIG_NFSD_TCP is not set
-CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_GSS is not set
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_EXPORTFS=y
-# CONFIG_CIFS is not set
+CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_GSS is not set
 # CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_INTERMEZZO_FS is not set
 # CONFIG_AFS_FS is not set
-CONFIG_FS_MBCACHE=y
 
 #
 # Partition Types
@@ -327,6 +348,7 @@
 # CONFIG_MAC_PARTITION is not set
 # CONFIG_MSDOS_PARTITION is not set
 # CONFIG_LDM_PARTITION is not set
+# CONFIG_NEC98_PARTITION is not set
 # CONFIG_SGI_PARTITION is not set
 # CONFIG_ULTRIX_PARTITION is not set
 # CONFIG_SUN_PARTITION is not set
diff -urN linux-2.5.66/arch/s390x/kernel/entry.S linux-2.5.66-s390/arch/s390x/kernel/entry.S
--- linux-2.5.66/arch/s390x/kernel/entry.S	Mon Mar 24 23:00:10 2003
+++ linux-2.5.66-s390/arch/s390x/kernel/entry.S	Wed Mar 26 15:45:10 2003
@@ -677,12 +677,11 @@
         tm      __LC_PGM_INT_CODE+1,0x80 # check whether we got a per exception
         jnz     pgm_per                  # got per exception -> special case
 	SAVE_ALL __LC_PGM_OLD_PSW,1
-	lghi	%r8,0x7f
 	lgf     %r3,__LC_PGM_ILC	 # load program interruption code
+	lghi	%r8,0x7f
 	ngr	%r8,%r3
         sll     %r8,3
 	GET_THREAD_INFO
-	stosm   48(%r15),0x03            # reenable interrupts
         larl    %r1,pgm_check_table
         lg      %r1,0(%r8,%r1)		 # load address of handler routine
         la      %r2,SP_PTREGS(%r15)	 # address of register-save area
@@ -709,7 +708,6 @@
 	GET_THREAD_INFO
 	lghi    %r4,0x7f
 	lgf     %r3,__LC_PGM_ILC	 # load program interruption code
-	stosm   48(%r15),0x03            # reenable interrupts
         nr      %r4,%r3			 # clear per-event-bit and ilc
         je      pgm_per_only		 # only per of per+check ?
         sll     %r4,3
diff -urN linux-2.5.66/arch/s390x/kernel/ptrace.c linux-2.5.66-s390/arch/s390x/kernel/ptrace.c
--- linux-2.5.66/arch/s390x/kernel/ptrace.c	Mon Mar 24 23:00:00 2003
+++ linux-2.5.66-s390/arch/s390x/kernel/ptrace.c	Wed Mar 26 15:45:10 2003
@@ -473,6 +473,8 @@
 }
 #endif
 
+#define PT32_IEEE_IP 0x13c
+
 static int
 do_ptrace(struct task_struct *child, long request, long addr, long data)
 {
@@ -481,16 +483,29 @@
 	if (request == PTRACE_ATTACH)
 		return ptrace_attach(child);
 
+
 	/*
-	 * I added child != current line so we can get the
-	 * ieee_instruction_pointer from the user structure DJB
+	 * Special cases to get/store the ieee instructions pointer.
 	 */
-	if (child != current) {
-		ret = ptrace_check_attach(child, request == PTRACE_KILL);
-		if (ret < 0)
-			return ret;
+	if (child == current) {
+		if (request == PTRACE_PEEKUSR &&
+		    addr == PT_IEEE_IP && !test_thread_flag(TIF_31BIT))
+			return peek_user(child, addr, data);
+		if (request == PTRACE_PEEKUSR &&
+		    addr == PT32_IEEE_IP && test_thread_flag(TIF_31BIT))
+			return peek_user_emu31(child, addr, data);
+		if (request == PTRACE_POKEUSR &&
+		    addr == PT_IEEE_IP && !test_thread_flag(TIF_31BIT))
+			return poke_user(child, addr, data);
+		if (request == PTRACE_POKEUSR &&
+		    addr == PT32_IEEE_IP && test_thread_flag(TIF_31BIT))
+			return poke_user_emu31(child, addr, data);
 	}
 
+	ret = ptrace_check_attach(child, request == PTRACE_KILL);
+	if (ret < 0)
+		return ret;
+
 	switch (request) {
 	/* First the common request for 31/64 bit */
 	case PTRACE_SYSCALL:
diff -urN linux-2.5.66/arch/s390x/kernel/time.c linux-2.5.66-s390/arch/s390x/kernel/time.c
--- linux-2.5.66/arch/s390x/kernel/time.c	Mon Mar 24 23:01:18 2003
+++ linux-2.5.66-s390/arch/s390x/kernel/time.c	Wed Mar 26 15:45:10 2003
@@ -48,8 +48,9 @@
 u64 jiffies_64 = INITIAL_JIFFIES;
 
 static ext_int_info_t ext_int_info_timer;
-static uint64_t xtime_cc;
-static uint64_t init_timer_cc;
+static u64 init_timer_cc;
+static u64 jiffies_timer_cc;
+static u64 xtime_cc;
 
 extern unsigned long wall_jiffies;
 
@@ -65,7 +66,7 @@
 	__u64 now;
 
 	asm volatile ("STCK 0(%0)" : : "a" (&now) : "memory", "cc");
-        now = (now - init_timer_cc) >> 12;
+        now = (now - jiffies_timer_cc) >> 12;
 	/* We require the offset from the latest update of xtime */
 	now -= (__u64) wall_jiffies*USECS_PER_JIFFY;
 	return (unsigned long) now;
@@ -83,7 +84,7 @@
 	do {
 		seq = read_seqbegin_irqsave(&xtime_lock, flags);
 		sec = xtime.tv_sec;
-		usec = xtime.tv_nsec + do_gettimeoffset();
+		usec = xtime.tv_nsec / 1000 + do_gettimeoffset();
 	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
 
 	while (usec >= 1000000) {
@@ -99,7 +100,7 @@
 {
 
 	write_seqlock_irq(&xtime_lock);
-	/* This is revolting. We need to set the xtime.tv_usec
+	/* This is revolting. We need to set the xtime.tv_nsec
 	 * correctly. However, the value in this location is
 	 * is value at the last tick.
 	 * Discover what correction gettimeofday
@@ -187,14 +188,14 @@
 	unsigned long cr0;
 	__u64 timer;
 
+	timer = jiffies_timer_cc + jiffies_64 * CLK_TICKS_PER_JIFFY;
+	S390_lowcore.jiffy_timer = timer;
+	timer += CLK_TICKS_PER_JIFFY + CPU_DEVIATION;
+	asm volatile ("SCKC %0" : : "m" (timer));
         /* allow clock comparator timer interrupt */
         asm volatile ("STCTG 0,0,%0" : "=m" (cr0) : : "memory");
         cr0 |= 0x800;
         asm volatile ("LCTLG 0,0,%0" : : "m" (cr0) : "memory");
-	timer = init_timer_cc + jiffies_64 * CLK_TICKS_PER_JIFFY;
-	S390_lowcore.jiffy_timer = timer;
-	timer += CLK_TICKS_PER_JIFFY + CPU_DEVIATION;
-	asm volatile ("SCKC %0" : : "m" (timer));
 }
 
 /*
@@ -224,6 +225,7 @@
                 printk("time_init: TOD clock stopped/non-operational\n");
                 break;
         }
+	jiffies_timer_cc = init_timer_cc - jiffies_64 * CLK_TICKS_PER_JIFFY;
 
 	/* set xtime */
 	xtime_cc = init_timer_cc;
diff -urN linux-2.5.66/arch/s390x/mm/ioremap.c linux-2.5.66-s390/arch/s390x/mm/ioremap.c
--- linux-2.5.66/arch/s390x/mm/ioremap.c	Mon Mar 24 23:00:37 2003
+++ linux-2.5.66-s390/arch/s390x/mm/ioremap.c	Wed Mar 26 15:45:10 2003
@@ -38,7 +38,7 @@
                         printk("remap_area_pte: page already exists\n");
 			BUG();
 		}
-                set_pte(pte, pfn_pte(pfn, __pgprot(_PAGE_PRESENT | flags)));
+                set_pte(pte, pfn_pte(pfn, __pgprot(flags)));
                 address += PAGE_SIZE;
                 pfn++;
                 pte++;
diff -urN linux-2.5.66/drivers/s390/char/con3215.c linux-2.5.66-s390/drivers/s390/char/con3215.c
--- linux-2.5.66/drivers/s390/char/con3215.c	Mon Mar 24 23:01:11 2003
+++ linux-2.5.66-s390/drivers/s390/char/con3215.c	Wed Mar 26 15:45:10 2003
@@ -884,7 +884,7 @@
  * 3215 console initialization code called from console_init().
  * NOTE: This is called before kmalloc is available.
  */
-static void __init
+static int __init
 con3215_init(void)
 {
 	struct ccw_device *cdev;
@@ -894,7 +894,7 @@
 
 	/* Check if 3215 is to be the console */
 	if (!CONSOLE_IS_3215)
-		return;
+		return -ENODEV;
 
 	/* Set the console mode for VM */
 	if (MACHINE_IS_VM) {
@@ -913,7 +913,7 @@
 
 	cdev = ccw_device_probe_console();
 	if (!cdev)
-		return;
+		return -ENODEV;
 
 	raw3215[0] = raw = (struct raw3215_info *)
 		alloc_bootmem_low(sizeof(struct raw3215_info));
@@ -938,9 +938,10 @@
 		free_bootmem((unsigned long) raw, sizeof(struct raw3215_info));
 		raw3215[0] = NULL;
 		printk("Couldn't find a 3215 console device\n");
-		return;
+		return -ENODEV;
 	}
 	register_console(&con3215);
+	return 0;
 }
 #endif
 
diff -urN linux-2.5.66/drivers/s390/char/sclp_tty.c linux-2.5.66-s390/drivers/s390/char/sclp_tty.c
--- linux-2.5.66/drivers/s390/char/sclp_tty.c	Mon Mar 24 23:00:03 2003
+++ linux-2.5.66-s390/drivers/s390/char/sclp_tty.c	Wed Mar 26 15:45:10 2003
@@ -797,6 +797,3 @@
 	if (tty_register_driver(&sclp_tty_driver))
 		panic("Couldn't register sclp_tty driver\n");
 }
-
-console_initcall(sclp_tty_init);
-
diff -urN linux-2.5.66/include/asm-s390/pgtable.h linux-2.5.66-s390/include/asm-s390/pgtable.h
--- linux-2.5.66/include/asm-s390/pgtable.h	Mon Mar 24 23:01:15 2003
+++ linux-2.5.66-s390/include/asm-s390/pgtable.h	Wed Mar 26 15:45:10 2003
@@ -143,13 +143,21 @@
  * C  : changed bit
  */
 
-/* Bits in the page table entry */
-#define _PAGE_PRESENT   0x001          /* Software                         */
-#define _PAGE_MKCLEAN   0x002          /* Software                         */
-#define _PAGE_ISCLEAN   0x004	       /* Software			   */
+/* Hardware bits in the page table entry */
 #define _PAGE_RO        0x200          /* HW read-only                     */
 #define _PAGE_INVALID   0x400          /* HW invalid                       */
 
+/* Software bits in the page table entry */
+#define _PAGE_MKCLEAN   0x002
+#define _PAGE_ISCLEAN   0x004
+
+/* Mask and four different kinds of invalid pages. */
+#define _PAGE_INVALID_MASK	0x601
+#define _PAGE_INVALID_EMPTY	0x400
+#define _PAGE_INVALID_NONE	0x001
+#define _PAGE_INVALID_SWAP	0x200
+#define _PAGE_INVALID_FILE	0x201
+
 /* Bits in the segment table entry */
 #define _PAGE_TABLE_LEN 0xf            /* only full page-tables            */
 #define _PAGE_TABLE_COM 0x10           /* common page-table                */
@@ -166,29 +174,28 @@
 /*
  * User and Kernel pagetables are identical
  */
-#define _PAGE_TABLE     (_PAGE_TABLE_LEN )
-#define _KERNPG_TABLE   (_PAGE_TABLE_LEN )
+#define _PAGE_TABLE	_PAGE_TABLE_LEN
+#define _KERNPG_TABLE	_PAGE_TABLE_LEN
 
 /*
  * The Kernel segment-tables includes the User segment-table
  */
 
-#define _SEGMENT_TABLE  (_USER_SEG_TABLE_LEN|0x80000000|0x100)
-#define _KERNSEG_TABLE  (_KERNEL_SEG_TABLE_LEN)
+#define _SEGMENT_TABLE	(_USER_SEG_TABLE_LEN|0x80000000|0x100)
+#define _KERNSEG_TABLE	_KERNEL_SEG_TABLE_LEN
 
-#define USER_STD_MASK           0x00000080UL
+#define USER_STD_MASK	0x00000080UL
 
 /*
  * No mapping available
  */
-#define PAGE_INVALID	  __pgprot(_PAGE_INVALID)
-#define PAGE_NONE_SHARED  __pgprot(_PAGE_PRESENT|_PAGE_INVALID)
-#define PAGE_NONE_PRIVATE __pgprot(_PAGE_PRESENT|_PAGE_INVALID|_PAGE_ISCLEAN)
-#define PAGE_RO_SHARED	  __pgprot(_PAGE_PRESENT|_PAGE_RO)
-#define PAGE_RO_PRIVATE	  __pgprot(_PAGE_PRESENT|_PAGE_RO|_PAGE_ISCLEAN)
-#define PAGE_COPY	  __pgprot(_PAGE_PRESENT|_PAGE_RO|_PAGE_ISCLEAN)
-#define PAGE_SHARED	  __pgprot(_PAGE_PRESENT)
-#define PAGE_KERNEL	  __pgprot(_PAGE_PRESENT)
+#define PAGE_NONE_SHARED  __pgprot(_PAGE_INVALID_NONE)
+#define PAGE_NONE_PRIVATE __pgprot(_PAGE_INVALID_NONE|_PAGE_ISCLEAN)
+#define PAGE_RO_SHARED	  __pgprot(_PAGE_RO)
+#define PAGE_RO_PRIVATE	  __pgprot(_PAGE_RO|_PAGE_ISCLEAN)
+#define PAGE_COPY	  __pgprot(_PAGE_RO|_PAGE_ISCLEAN)
+#define PAGE_SHARED	  __pgprot(0)
+#define PAGE_KERNEL	  __pgprot(0)
 
 /*
  * The S390 can't do page protection for execute, and considers that the
@@ -247,11 +254,20 @@
 	return (pmd_val(pmd) & (~PAGE_MASK & ~_PAGE_TABLE_INV)) != _PAGE_TABLE;
 }
 
-extern inline int pte_present(pte_t pte) { return pte_val(pte) & _PAGE_PRESENT; }
 extern inline int pte_none(pte_t pte)
 {
-	return ((pte_val(pte) & 
-                (_PAGE_INVALID | _PAGE_RO | _PAGE_PRESENT)) == _PAGE_INVALID);
+	return (pte_val(pte) & _PAGE_INVALID_MASK) == _PAGE_INVALID_EMPTY;
+}
+
+extern inline int pte_present(pte_t pte)
+{
+	return !(pte_val(pte) & _PAGE_INVALID) ||
+		(pte_val(pte) & _PAGE_INVALID_MASK) == _PAGE_INVALID_NONE;
+}
+
+extern inline int pte_file(pte_t pte)
+{
+	return (pte_val(pte) & _PAGE_INVALID_MASK) == _PAGE_INVALID_FILE;
 }
 
 #define pte_same(a,b)	(pte_val(a) == pte_val(b))
@@ -298,7 +314,7 @@
 
 extern inline void pte_clear(pte_t *ptep)
 {
-	pte_val(*ptep) = _PAGE_INVALID; 
+	pte_val(*ptep) = _PAGE_INVALID_EMPTY;
 }
 
 /*
@@ -495,7 +511,7 @@
 extern inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
 {
 	pte_t pte;
-	pte_val(pte) = (type << 1) | (offset << 12) | _PAGE_INVALID | _PAGE_RO;
+	pte_val(pte) = (type << 1) | (offset << 12) | _PAGE_INVALID_SWAP;
 	pte_val(pte) &= 0x7ffff6fe;  /* better to be paranoid */
 	return pte;
 }
@@ -509,6 +525,15 @@
 
 typedef pte_t *pte_addr_t;
 
+#define PTE_FILE_MAX_BITS	26
+
+#define pte_to_pgoff(__pte) \
+	((((__pte).pte >> 12) << 7) + (((__pte).pte >> 1) & 0x7f))
+
+#define pgoff_to_pte(__off) \
+	((pte_t) { ((((__off) & 0x7f) << 1) + (((__off) >> 7) << 12)) \
+		   | _PAGE_INVALID_FILE })
+
 #endif /* !__ASSEMBLY__ */
 
 #define kern_addr_valid(addr)   (1)
diff -urN linux-2.5.66/include/asm-s390/posix_types.h linux-2.5.66-s390/include/asm-s390/posix_types.h
--- linux-2.5.66/include/asm-s390/posix_types.h	Mon Mar 24 22:59:46 2003
+++ linux-2.5.66-s390/include/asm-s390/posix_types.h	Wed Mar 26 15:45:10 2003
@@ -30,6 +30,8 @@
 typedef long            __kernel_time_t;
 typedef long            __kernel_suseconds_t;
 typedef long            __kernel_clock_t;
+typedef int		__kernel_timer_t;
+typedef int		__kernel_clockid_t;
 typedef int             __kernel_daddr_t;
 typedef char *          __kernel_caddr_t;
 typedef unsigned short	__kernel_uid16_t;
diff -urN linux-2.5.66/include/asm-s390/processor.h linux-2.5.66-s390/include/asm-s390/processor.h
--- linux-2.5.66/include/asm-s390/processor.h	Mon Mar 24 23:00:35 2003
+++ linux-2.5.66-s390/include/asm-s390/processor.h	Wed Mar 26 15:45:10 2003
@@ -133,7 +133,10 @@
 #define KSTK_EIP(tsk)	(__KSTK_PTREGS(tsk)->psw.addr)
 #define KSTK_ESP(tsk)	(__KSTK_PTREGS(tsk)->gprs[15])
 
-#define cpu_relax()	barrier()
+/*
+ * Give up the time slice of the virtual PU.
+ */
+#define cpu_relax()	asm volatile ("diag 0,0,68" : : : "memory")
 
 /*
  * Set PSW mask to specified value, while leaving the
diff -urN linux-2.5.66/include/asm-s390/signal.h linux-2.5.66-s390/include/asm-s390/signal.h
--- linux-2.5.66/include/asm-s390/signal.h	Mon Mar 24 23:01:13 2003
+++ linux-2.5.66-s390/include/asm-s390/signal.h	Wed Mar 26 15:45:10 2003
@@ -10,6 +10,7 @@
 #define _ASMS390_SIGNAL_H
 
 #include <linux/types.h>
+#include <linux/time.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
diff -urN linux-2.5.66/include/asm-s390/system.h linux-2.5.66-s390/include/asm-s390/system.h
--- linux-2.5.66/include/asm-s390/system.h	Mon Mar 24 23:01:48 2003
+++ linux-2.5.66-s390/include/asm-s390/system.h	Wed Mar 26 15:45:10 2003
@@ -82,7 +82,7 @@
 		break;							     \
 	save_fp_regs(&prev->thread.fp_regs);				     \
 	restore_fp_regs(&next->thread.fp_regs);				     \
-	resume(prev,next);						     \
+	prev = resume(prev,next);					     \
 } while (0)
 
 #define nop() __asm__ __volatile__ ("nop")
diff -urN linux-2.5.66/include/asm-s390/termios.h linux-2.5.66-s390/include/asm-s390/termios.h
--- linux-2.5.66/include/asm-s390/termios.h	Mon Mar 24 23:00:11 2003
+++ linux-2.5.66-s390/include/asm-s390/termios.h	Wed Mar 26 15:45:10 2003
@@ -12,7 +12,6 @@
 #include <asm/termbits.h>
 #include <asm/ioctls.h>
 
-
 struct winsize {
 	unsigned short ws_row;
 	unsigned short ws_col;
@@ -44,7 +43,7 @@
 #define TIOCM_RI	TIOCM_RNG
 #define TIOCM_OUT1	0x2000
 #define TIOCM_OUT2	0x4000
-#define TIOCM_LOOP      0x8000
+#define TIOCM_LOOP	0x8000
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 
@@ -62,7 +61,8 @@
 #define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
 #define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
 #define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC         13	/* synchronous HDLC */
+#define N_HDLC		13	/* synchronous HDLC */
+#define N_SYNC_PPP	14	/* synchronous PPP */
 #define N_HCI		15  /* Bluetooth HCI UART */
 
 #ifdef __KERNEL__
@@ -78,19 +78,18 @@
 /*
  * Translate a "termio" structure into a "termios". Ugh.
  */
+#define SET_LOW_TERMIOS_BITS(termios, termio, x) { \
+	unsigned short __tmp; \
+	get_user(__tmp,&(termio)->x); \
+	(termios)->x = (0xffff0000 & ((termios)->x)) | __tmp; \
+}
 
 #define user_termio_to_kernel_termios(termios, termio) \
 ({ \
-        unsigned short tmp; \
-        get_user(tmp, &(termio)->c_iflag); \
-        (termios)->c_iflag = (0xffff0000 & ((termios)->c_iflag)) | tmp; \
-        get_user(tmp, &(termio)->c_oflag); \
-        (termios)->c_oflag = (0xffff0000 & ((termios)->c_oflag)) | tmp; \
-        get_user(tmp, &(termio)->c_cflag); \
-        (termios)->c_cflag = (0xffff0000 & ((termios)->c_cflag)) | tmp; \
-        get_user(tmp, &(termio)->c_lflag); \
-        (termios)->c_lflag = (0xffff0000 & ((termios)->c_lflag)) | tmp; \
-        get_user((termios)->c_line, &(termio)->c_line); \
+	SET_LOW_TERMIOS_BITS(termios, termio, c_iflag); \
+	SET_LOW_TERMIOS_BITS(termios, termio, c_oflag); \
+	SET_LOW_TERMIOS_BITS(termios, termio, c_cflag); \
+	SET_LOW_TERMIOS_BITS(termios, termio, c_lflag); \
 	copy_from_user((termios)->c_cc, (termio)->c_cc, NCC); \
 })
 
diff -urN linux-2.5.66/include/asm-s390x/pgtable.h linux-2.5.66-s390/include/asm-s390x/pgtable.h
--- linux-2.5.66/include/asm-s390x/pgtable.h	Mon Mar 24 23:00:20 2003
+++ linux-2.5.66-s390/include/asm-s390x/pgtable.h	Wed Mar 26 15:45:10 2003
@@ -145,13 +145,21 @@
  * C  : changed bit
  */
 
-/* Bits in the page table entry */
-#define _PAGE_PRESENT   0x001          /* Software                         */
-#define _PAGE_MKCLEAN   0x002          /* Software                         */
-#define _PAGE_ISCLEAN   0x004          /* Software                         */
+/* Hardware bits in the page table entry */
 #define _PAGE_RO        0x200          /* HW read-only                     */
 #define _PAGE_INVALID   0x400          /* HW invalid                       */
 
+/* Software bits in the page table entry */
+#define _PAGE_MKCLEAN   0x002
+#define _PAGE_ISCLEAN   0x004
+
+/* Mask and four different kinds of invalid pages. */
+#define _PAGE_INVALID_MASK	0x601
+#define _PAGE_INVALID_EMPTY	0x400
+#define _PAGE_INVALID_NONE	0x001
+#define _PAGE_INVALID_SWAP	0x200
+#define _PAGE_INVALID_FILE	0x201
+
 /* Bits in the segment table entry */
 #define _PMD_ENTRY_INV   0x20          /* invalid segment table entry      */
 #define _PMD_ENTRY       0x00        
@@ -177,14 +185,13 @@
 /*
  * No mapping available
  */
-#define PAGE_INVALID	  __pgprot(_PAGE_INVALID)
-#define PAGE_NONE_SHARED  __pgprot(_PAGE_PRESENT|_PAGE_INVALID)
-#define PAGE_NONE_PRIVATE __pgprot(_PAGE_PRESENT|_PAGE_INVALID|_PAGE_ISCLEAN)
-#define PAGE_RO_SHARED	  __pgprot(_PAGE_PRESENT|_PAGE_RO)
-#define PAGE_RO_PRIVATE	  __pgprot(_PAGE_PRESENT|_PAGE_RO|_PAGE_ISCLEAN)
-#define PAGE_COPY	  __pgprot(_PAGE_PRESENT|_PAGE_RO|_PAGE_ISCLEAN)
-#define PAGE_SHARED	  __pgprot(_PAGE_PRESENT)
-#define PAGE_KERNEL	  __pgprot(_PAGE_PRESENT)
+#define PAGE_NONE_SHARED  __pgprot(_PAGE_INVALID_NONE)
+#define PAGE_NONE_PRIVATE __pgprot(_PAGE_INVALID_NONE|_PAGE_ISCLEAN)
+#define PAGE_RO_SHARED	  __pgprot(_PAGE_RO)
+#define PAGE_RO_PRIVATE	  __pgprot(_PAGE_RO|_PAGE_ISCLEAN)
+#define PAGE_COPY	  __pgprot(_PAGE_RO|_PAGE_ISCLEAN)
+#define PAGE_SHARED	  __pgprot(0)
+#define PAGE_KERNEL	  __pgprot(0)
 
 /*
  * The S390 can't do page protection for execute, and considers that the
@@ -261,16 +268,21 @@
 	return (pmd_val(pmd) & (~PAGE_MASK & ~_PMD_ENTRY_INV)) != _PMD_ENTRY;
 }
 
+extern inline int pte_none(pte_t pte)
+{
+	return (pte_val(pte) & _PAGE_INVALID_MASK) == _PAGE_INVALID_EMPTY;
+}
+
 extern inline int pte_present(pte_t pte)
 {
-	return pte_val(pte) & _PAGE_PRESENT;
+	return !(pte_val(pte) & _PAGE_INVALID) ||
+		(pte_val(pte) & _PAGE_INVALID_MASK) == _PAGE_INVALID_NONE;
 }
 
-extern inline int pte_none(pte_t pte)
+extern inline int pte_file(pte_t pte)
 {
-	return ((pte_val(pte) & 
-		 (_PAGE_INVALID | _PAGE_RO | _PAGE_PRESENT)) == _PAGE_INVALID);
-} 
+	return (pte_val(pte) & _PAGE_INVALID_MASK) == _PAGE_INVALID_FILE;
+}
 
 #define pte_same(a,b)	(pte_val(a) == pte_val(b))
 
@@ -317,7 +329,7 @@
 
 extern inline void pte_clear(pte_t *ptep)
 {
-	pte_val(*ptep) = _PAGE_INVALID;
+	pte_val(*ptep) = _PAGE_INVALID_EMPTY;
 }
 
 /*
@@ -535,6 +547,15 @@
 
 typedef pte_t *pte_addr_t;
 
+#define PTE_FILE_MAX_BITS	59
+
+#define pte_to_pgoff(__pte) \
+	((((__pte).pte >> 12) << 7) + (((__pte).pte >> 1) & 0x7f))
+
+#define pgoff_to_pte(__off) \
+	((pte_t) { ((((__off) & 0x7f) << 1) + (((__off) >> 7) << 12)) \
+		   | _PAGE_INVALID_FILE })
+
 #endif /* !__ASSEMBLY__ */
 
 #define kern_addr_valid(addr)   (1)
diff -urN linux-2.5.66/include/asm-s390x/posix_types.h linux-2.5.66-s390/include/asm-s390x/posix_types.h
--- linux-2.5.66/include/asm-s390x/posix_types.h	Mon Mar 24 23:01:48 2003
+++ linux-2.5.66-s390/include/asm-s390x/posix_types.h	Wed Mar 26 15:45:10 2003
@@ -31,6 +31,8 @@
 typedef long            __kernel_time_t;
 typedef long            __kernel_suseconds_t;
 typedef long            __kernel_clock_t;
+typedef int		__kernel_timer_t;
+typedef int		__kernel_clockid_t;
 typedef int             __kernel_daddr_t;
 typedef char *          __kernel_caddr_t;
 typedef unsigned long   __kernel_sigset_t;      /* at least 32 bits */
diff -urN linux-2.5.66/include/asm-s390x/processor.h linux-2.5.66-s390/include/asm-s390x/processor.h
--- linux-2.5.66/include/asm-s390x/processor.h	Mon Mar 24 23:01:18 2003
+++ linux-2.5.66-s390/include/asm-s390x/processor.h	Wed Mar 26 15:45:10 2003
@@ -148,7 +148,11 @@
 #define KSTK_EIP(tsk)	(__KSTK_PTREGS(tsk)->psw.addr)
 #define KSTK_ESP(tsk)	(__KSTK_PTREGS(tsk)->gprs[15])
 
-#define cpu_relax()	barrier()
+/*
+ * Give up the time slice of the virtual PU.
+ */
+#define cpu_relax() \
+	asm volatile ("ex 0,%0" : : "i" (__LC_DIAG44_OPCODE) : "memory")
 
 /*
  * Set PSW mask to specified value, while leaving the
diff -urN linux-2.5.66/include/asm-s390x/signal.h linux-2.5.66-s390/include/asm-s390x/signal.h
--- linux-2.5.66/include/asm-s390x/signal.h	Mon Mar 24 23:00:50 2003
+++ linux-2.5.66-s390/include/asm-s390x/signal.h	Wed Mar 26 15:45:10 2003
@@ -10,6 +10,7 @@
 #define _ASMS390_SIGNAL_H
 
 #include <linux/types.h>
+#include <linux/time.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
diff -urN linux-2.5.66/include/asm-s390x/system.h linux-2.5.66-s390/include/asm-s390x/system.h
--- linux-2.5.66/include/asm-s390x/system.h	Mon Mar 24 23:01:43 2003
+++ linux-2.5.66-s390/include/asm-s390x/system.h	Wed Mar 26 15:45:10 2003
@@ -74,7 +74,7 @@
 		break;							     \
 	save_fp_regs(&prev->thread.fp_regs);				     \
 	restore_fp_regs(&next->thread.fp_regs);				     \
-	resume(prev,next);						     \
+	prev = resume(prev,next);					     \
 } while (0)
 
 #define nop() __asm__ __volatile__ ("nop")
diff -urN linux-2.5.66/include/asm-s390x/termios.h linux-2.5.66-s390/include/asm-s390x/termios.h
--- linux-2.5.66/include/asm-s390x/termios.h	Mon Mar 24 23:01:18 2003
+++ linux-2.5.66-s390/include/asm-s390x/termios.h	Wed Mar 26 15:45:10 2003
@@ -12,7 +12,6 @@
 #include <asm/termbits.h>
 #include <asm/ioctls.h>
 
-
 struct winsize {
 	unsigned short ws_row;
 	unsigned short ws_col;
@@ -44,7 +43,7 @@
 #define TIOCM_RI	TIOCM_RNG
 #define TIOCM_OUT1	0x2000
 #define TIOCM_OUT2	0x4000
-#define TIOCM_LOOP      0x8000
+#define TIOCM_LOOP	0x8000
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 
@@ -62,8 +61,9 @@
 #define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
 #define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
 #define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC         13	/* synchronous HDLC */
-#define N_HCI		15	/* Bluetooth HCI UART */
+#define N_HDLC		13	/* synchronous HDLC */
+#define N_SYNC_PPP	14	/* synchronous PPP */
+#define N_HCI		15  /* Bluetooth HCI UART */
 
 #ifdef __KERNEL__
 
@@ -78,19 +78,18 @@
 /*
  * Translate a "termio" structure into a "termios". Ugh.
  */
+#define SET_LOW_TERMIOS_BITS(termios, termio, x) { \
+	unsigned short __tmp; \
+	get_user(__tmp,&(termio)->x); \
+	(termios)->x = (0xffff0000 & ((termios)->x)) | __tmp; \
+}
 
 #define user_termio_to_kernel_termios(termios, termio) \
 ({ \
-        unsigned short tmp; \
-        get_user(tmp, &(termio)->c_iflag); \
-        (termios)->c_iflag = (0xffff0000 & ((termios)->c_iflag)) | tmp; \
-        get_user(tmp, &(termio)->c_oflag); \
-        (termios)->c_oflag = (0xffff0000 & ((termios)->c_oflag)) | tmp; \
-        get_user(tmp, &(termio)->c_cflag); \
-        (termios)->c_cflag = (0xffff0000 & ((termios)->c_cflag)) | tmp; \
-        get_user(tmp, &(termio)->c_lflag); \
-        (termios)->c_lflag = (0xffff0000 & ((termios)->c_lflag)) | tmp; \
-        get_user((termios)->c_line, &(termio)->c_line); \
+	SET_LOW_TERMIOS_BITS(termios, termio, c_iflag); \
+	SET_LOW_TERMIOS_BITS(termios, termio, c_oflag); \
+	SET_LOW_TERMIOS_BITS(termios, termio, c_cflag); \
+	SET_LOW_TERMIOS_BITS(termios, termio, c_lflag); \
 	copy_from_user((termios)->c_cc, (termio)->c_cc, NCC); \
 })
 

