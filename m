Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTDNRpz (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263615AbTDNRpz (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:45:55 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:63646 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id S263590AbTDNRp2 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:45:28 -0400
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (1/16): base s390 fixes.
Date: Mon, 14 Apr 2003 19:47:04 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304141947.04708.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 fixes:
 - Initialize timing related variables first and then enable the timer interrupt.
 - Normalize nano seconds to micro seconds in do_gettimeofday.
 - Add types for __kernel_timer_t and __kernel_clockid_t.
 - Fix ugly bug in switch_to: set prev to the return value of resume, otherwise
   prev still contains the previous process at the time resume was called and
   not the previous process at the time resume returned. They differ...
 - Add missing include to get the kernel compiled.
 - Get a closer match with the i386 termios.h file.
 - Cope with INITIAL_JIFFIES.
 - Define cpu_relax to do a cpu yield on VM and LPAR.
 - Don't reenable interrupts in program check handler.
 - Add pte_file definitions.
 - Fix PT_IEEE_IP special case in ptrace.
 - Use compare and swap to release the lock in _raw_spin_unlock.
 - Introduce invoke_softirq to switch to async. interrupt stack.

diffstat:
 arch/s390/defconfig            |   81 +++++++++++++++++++++++++----------------
 arch/s390/kernel/entry.S       |    4 --
 arch/s390/kernel/ptrace.c      |   21 ++++++----
 arch/s390/kernel/time.c        |   16 ++++----
 arch/s390/mm/fault.c           |    1 
 arch/s390/mm/ioremap.c         |    2 -
 include/asm-s390/hardirq.h     |    2 +
 include/asm-s390/pgtable.h     |   69 +++++++++++++++++++++++-----------
 include/asm-s390/posix_types.h |    2 +
 include/asm-s390/processor.h   |    5 ++
 include/asm-s390/signal.h      |    1 
 include/asm-s390/spinlock.h    |    8 ++--
 include/asm-s390/system.h      |    2 -
 include/asm-s390/termios.h     |   25 ++++++------
 include/linux/interrupt.h      |    3 +
 kernel/softirq.c               |    2 -
 16 files changed, 153 insertions(+), 91 deletions(-)

diff -urN linux-2.5.67/arch/s390/defconfig linux-2.5.67-s390/arch/s390/defconfig
--- linux-2.5.67/arch/s390/defconfig	Mon Apr  7 19:32:27 2003
+++ linux-2.5.67-s390/arch/s390/defconfig	Mon Apr 14 19:11:44 2003
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
@@ -141,7 +141,6 @@
 # CONFIG_PACKET_MMAP is not set
 # CONFIG_NETLINK_DEV is not set
 # CONFIG_NETFILTER is not set
-# CONFIG_FILTER is not set
 CONFIG_UNIX=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
@@ -156,8 +155,12 @@
 # CONFIG_SYN_COOKIES is not set
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
-# CONFIG_XFRM_USER is not set
+# CONFIG_INET_IPCOMP is not set
 CONFIG_IPV6=m
+# CONFIG_IPV6_PRIVACY is not set
+# CONFIG_INET6_AH is not set
+# CONFIG_INET6_ESP is not set
+# CONFIG_XFRM_USER is not set
 
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
@@ -359,6 +379,7 @@
 # CONFIG_CRYPTO_TWOFISH is not set
 # CONFIG_CRYPTO_SERPENT is not set
 # CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_DEFLATE is not set
 # CONFIG_CRYPTO_TEST is not set
 
 #
diff -urN linux-2.5.67/arch/s390/kernel/entry.S linux-2.5.67-s390/arch/s390/kernel/entry.S
--- linux-2.5.67/arch/s390/kernel/entry.S	Mon Apr  7 19:30:44 2003
+++ linux-2.5.67-s390/arch/s390/kernel/entry.S	Mon Apr 14 19:11:44 2003
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
diff -urN linux-2.5.67/arch/s390/kernel/ptrace.c linux-2.5.67-s390/arch/s390/kernel/ptrace.c
--- linux-2.5.67/arch/s390/kernel/ptrace.c	Mon Apr  7 19:32:31 2003
+++ linux-2.5.67-s390/arch/s390/kernel/ptrace.c	Mon Apr 14 19:11:44 2003
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
diff -urN linux-2.5.67/arch/s390/kernel/time.c linux-2.5.67-s390/arch/s390/kernel/time.c
--- linux-2.5.67/arch/s390/kernel/time.c	Mon Apr  7 19:30:34 2003
+++ linux-2.5.67-s390/arch/s390/kernel/time.c	Mon Apr 14 19:11:44 2003
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
diff -urN linux-2.5.67/arch/s390/mm/fault.c linux-2.5.67-s390/arch/s390/mm/fault.c
--- linux-2.5.67/arch/s390/mm/fault.c	Mon Apr  7 19:32:20 2003
+++ linux-2.5.67-s390/arch/s390/mm/fault.c	Mon Apr 14 19:11:44 2003
@@ -22,7 +22,6 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
-#include <linux/compatmac.h>
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/module.h>
diff -urN linux-2.5.67/arch/s390/mm/ioremap.c linux-2.5.67-s390/arch/s390/mm/ioremap.c
--- linux-2.5.67/arch/s390/mm/ioremap.c	Mon Apr  7 19:30:43 2003
+++ linux-2.5.67-s390/arch/s390/mm/ioremap.c	Mon Apr 14 19:11:44 2003
@@ -38,7 +38,7 @@
                         printk("remap_area_pte: page already exists\n");
 			BUG();
 		}
-                set_pte(pte, pfn_pte(pfn, __pgprot(_PAGE_PRESENT | flags)));
+                set_pte(pte, pfn_pte(pfn, __pgprot(flags)));
                 address += PAGE_SIZE;
                 pfn++;
                 pte++;
diff -urN linux-2.5.67/include/asm-s390/hardirq.h linux-2.5.67-s390/include/asm-s390/hardirq.h
--- linux-2.5.67/include/asm-s390/hardirq.h	Mon Apr  7 19:33:02 2003
+++ linux-2.5.67-s390/include/asm-s390/hardirq.h	Mon Apr 14 19:11:44 2003
@@ -80,6 +80,8 @@
 
 extern void do_call_softirq(void);
 
+#define invoke_softirq() do_call_softirq()
+
 #if CONFIG_PREEMPT
 # define in_atomic()	(in_interrupt() || preempt_count() == PREEMPT_ACTIVE)
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
diff -urN linux-2.5.67/include/asm-s390/pgtable.h linux-2.5.67-s390/include/asm-s390/pgtable.h
--- linux-2.5.67/include/asm-s390/pgtable.h	Mon Apr  7 19:32:22 2003
+++ linux-2.5.67-s390/include/asm-s390/pgtable.h	Mon Apr 14 19:11:44 2003
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
diff -urN linux-2.5.67/include/asm-s390/posix_types.h linux-2.5.67-s390/include/asm-s390/posix_types.h
--- linux-2.5.67/include/asm-s390/posix_types.h	Mon Apr  7 19:30:33 2003
+++ linux-2.5.67-s390/include/asm-s390/posix_types.h	Mon Apr 14 19:11:44 2003
@@ -30,6 +30,8 @@
 typedef long            __kernel_time_t;
 typedef long            __kernel_suseconds_t;
 typedef long            __kernel_clock_t;
+typedef int		__kernel_timer_t;
+typedef int		__kernel_clockid_t;
 typedef int             __kernel_daddr_t;
 typedef char *          __kernel_caddr_t;
 typedef unsigned short	__kernel_uid16_t;
diff -urN linux-2.5.67/include/asm-s390/processor.h linux-2.5.67-s390/include/asm-s390/processor.h
--- linux-2.5.67/include/asm-s390/processor.h	Mon Apr  7 19:31:18 2003
+++ linux-2.5.67-s390/include/asm-s390/processor.h	Mon Apr 14 19:11:44 2003
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
diff -urN linux-2.5.67/include/asm-s390/signal.h linux-2.5.67-s390/include/asm-s390/signal.h
--- linux-2.5.67/include/asm-s390/signal.h	Mon Apr  7 19:32:17 2003
+++ linux-2.5.67-s390/include/asm-s390/signal.h	Mon Apr 14 19:11:44 2003
@@ -10,6 +10,7 @@
 #define _ASMS390_SIGNAL_H
 
 #include <linux/types.h>
+#include <linux/time.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
diff -urN linux-2.5.67/include/asm-s390/spinlock.h linux-2.5.67-s390/include/asm-s390/spinlock.h
--- linux-2.5.67/include/asm-s390/spinlock.h	Mon Apr  7 19:33:03 2003
+++ linux-2.5.67-s390/include/asm-s390/spinlock.h	Mon Apr 14 19:11:44 2003
@@ -52,9 +52,11 @@
 
 extern inline void _raw_spin_unlock(spinlock_t *lp)
 {
-	__asm__ __volatile("    xc 0(4,%1),0(%1)\n"
-                           "    bcr 15,0"
-			   : "+m" (lp->lock) : "a" (&lp->lock) : "cc" );
+	unsigned int old;
+
+	__asm__ __volatile("cs %0,%3,0(%4)"
+			   : "=d" (old), "=m" (lp->lock)
+			   : "0" (lp->lock), "d" (0), "a" (lp) : "cc" );
 }
 		
 /*
diff -urN linux-2.5.67/include/asm-s390/system.h linux-2.5.67-s390/include/asm-s390/system.h
--- linux-2.5.67/include/asm-s390/system.h	Mon Apr  7 19:33:01 2003
+++ linux-2.5.67-s390/include/asm-s390/system.h	Mon Apr 14 19:11:44 2003
@@ -82,7 +82,7 @@
 		break;							     \
 	save_fp_regs(&prev->thread.fp_regs);				     \
 	restore_fp_regs(&next->thread.fp_regs);				     \
-	resume(prev,next);						     \
+	prev = resume(prev,next);					     \
 } while (0)
 
 #define nop() __asm__ __volatile__ ("nop")
diff -urN linux-2.5.67/include/asm-s390/termios.h linux-2.5.67-s390/include/asm-s390/termios.h
--- linux-2.5.67/include/asm-s390/termios.h	Mon Apr  7 19:30:58 2003
+++ linux-2.5.67-s390/include/asm-s390/termios.h	Mon Apr 14 19:11:44 2003
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
 
diff -urN linux-2.5.67/include/linux/interrupt.h linux-2.5.67-s390/include/linux/interrupt.h
--- linux-2.5.67/include/linux/interrupt.h	Mon Apr  7 19:31:41 2003
+++ linux-2.5.67-s390/include/linux/interrupt.h	Mon Apr 14 19:11:44 2003
@@ -77,6 +77,9 @@
 extern void FASTCALL(cpu_raise_softirq(unsigned int cpu, unsigned int nr));
 extern void FASTCALL(raise_softirq(unsigned int nr));
 
+#ifndef invoke_softirq
+#define invoke_softirq() do_softirq()
+#endif
 
 
 /* Tasklets --- multithreaded analogue of BHs.
diff -urN linux-2.5.67/kernel/softirq.c linux-2.5.67-s390/kernel/softirq.c
--- linux-2.5.67/kernel/softirq.c	Mon Apr 14 19:11:36 2003
+++ linux-2.5.67-s390/kernel/softirq.c	Mon Apr 14 19:11:44 2003
@@ -105,7 +105,7 @@
 	BUG_ON(irqs_disabled());
 	if (unlikely(!in_interrupt() &&
 		     local_softirq_pending()))
-		do_softirq();
+		invoke_softirq();
 	preempt_check_resched();
 }
 EXPORT_SYMBOL(local_bh_enable);

