Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVGAVtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVGAVtH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 17:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVGAVtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 17:49:07 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:17168 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261565AbVGAVhf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 17:37:35 -0400
Message-Id: <200507012131.j61LVCLi027276@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/2] UML - skas0 - separate kernel address space on stock hosts
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Jul 2005 17:31:12 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML has had two modes of operation - an insecure, slow mode (tt mode) in
which the kernel is mapped into every process address space which requires
no host kernel modifications, and a secure, faster mode (skas mode) in which
the UML kernel is in a separate host address space, which requires a patch 
to the host kernel.

This patch implements something very close to skas mode for hosts
which don't support skas - I'm calling this skas0.  It provides the security
of the skas host patch, and some of the performance gains.

The two main things that are provided by the skas patch, /proc/mm and 
PTRACE_FAULTINFO, are implemented in a way that require no host patch.

For the remote address space changing stuff (mmap, munmap, and
mprotect), we set aside two pages in the process above its stack,
one of which contains a little bit of code which can call mmap et
al.

To update the address space, the system call information (system
call number and arguments) are written to the stub page above the
code.  The %esp is set to the beginning of the data, the %eip is set
the the start of the stub, and it repeatedly pops the information
into its registers and makes the system call until it sees a system
call number of zero.  This is to amortize the cost of the context
switch across multiple address space updates.

When the updates are done, it SIGSTOPs itself, and the kernel
process continues what it was doing.

For a PTRACE_FAULTINFO replacement, we set up a SIGSEGV handler in
the child, and let it handle segfaults rather than nullifying them.
The handler is in the same page as the mmap stub.  The second page
is used as the stack.  The handler reads cr2 and err from the
sigcontext, sticks them at the base of the stack in a faultinfo
struct, and SIGSTOPs itself.  The kernel then reads the faultinfo
and handles the fault.

A complication on x86_64 is that this involves resetting the
registers to the segfault values when the process is inside the kill
system call.  This breaks on x86_64 because %rcx will contain %rip
because you tell SYSRET where to return to by putting the value in
%rcx.  So, this corrupts $rcx on return from the segfault.  To work
around this, I added an arch_finish_segv, which on x86 does nothing,
but which on x86_64 ptraces the child back through the sigreturn.
This causes %rcx to be restored by sigreturn and avoids the
corruption.  Ultimately, I think I will replace this with the trick
of having it send itself a blocked signal which will be unblocked by
the sigreturn.  This will allow it to be stopped just after the
sigreturn, and PTRACE_SYSCALLed without all the back-and-forth of
PTRACE_SYSCALLing it through sigreturn.

This runs on a stock host, so theoretically (and hopefully), tt mode
isn't needed any more.  We need to make sure that this is better in
every way than tt mode, though.  I'm concerned about the speed of
address space updates and page fault handling, since they involve
extra round-trips to the child.  We can amortize the round-trip cost
for large address space updates by writing all of the operations to
the data page and having the child execute them all at the same
time.  This will help fork and exec, but not page faults, since they
involve only one page.

I can't think of any way to help page faults, except to add
something like PTRACE_FAULTINFO to the host.  There is
PTRACE_SIGINFO, but UML doesn't use siginfo for SIGSEGV (or anything
else) because there isn't enough information in the siginfo struct
to handle page faults (the faulting operation type is missing).
Adding that would make PTRACE_SIGINFO a usable equivalent to
PTRACE_FAULTINFO.

As for the code itself:
	The system call stub is in arch/um/kernel/sys-$(SUBARCH)/stub.S.  
It is put in its own section of the binary along with stub_segv_handler in
arch/um/kernel/skas/process.c.  This is manipulated with
run_syscall_stub in arch/um/kernel/skas/mem_user.c.  syscall_stub
will execute any system call at all, but it's only used for mmap,
munmap, and mprotect.
	The x86_64 stub calls sigreturn by hand rather than allowing
the normal sigreturn to happen, because the normal sigreturn is a
SA_RESTORER in UML's address space provided by libc.  Needless to
say, this is not available in the child's address space.  Also, it
does a couple of odd pops before that which restore the stack to the
state it was in at the time the signal handler was called.
	There is a new field in the arch mmu_context, which is now a
union.  This is the pid to be manipulated rather than the /proc/mm
file descriptor.  Code which deals with this now checks proc_mm to
see whether it should use the usual skas code or the new code.
	userspace_tramp is now used to create a new host process for
every UML process, rather than one per UML processor.  It checks
proc_mm and ptrace_faultinfo to decide whether to map in the pages
above its stack.
	start_userspace now makes CLONE_VM conditional on proc_mm
since we need separate address spaces now.
	switch_mm_skas now just sets userspace_pid[0] to the new pid
rather than PTRACE_SWITCH_MM.  There is an addition to userspace
which updates its idea of the pid being manipulated each time around
the loop.  This is important on exec, when the pid will change
underneath userspace().
	The stub page has a pte, but it can't be mapped in using tlb_flush
because it is part of tlb_flush.  This is why it's required for it to be
mapped in by userspace_tramp.

Other random things -
	The stub section in uml.lds.S is page aligned.  This page is written
out to the backing vm file in setup_physmem because it is mapped from there 
into user processes.
	There's some confusion with TASK_SIZE now that there are a
couple of extra pages that the process can't use.  TASK_SIZE is
considered by the elf code to be the usable process memory, which is
reasonable, so it is decreased by two pages.  This confuses the
definition of USER_PGDS_IN_LAST_PML4, making it too small because of
the rounding down of the uneven division.  So we round it to the
nearest PGDIR_SIZE rather than the lower one.
	I added a missing PT_SYSCALL_ARG6_OFFSET macro.
	um_mmu.h was made into a userspace-usable file.
	proc_mm and ptrace_faultinfo are globals which say whether the
host supports these features.  
	there is a bad interaction between the mm.nr_ptes check at the
end of exit_mmap, stack randomization, and skas0.  exit_mmap will
stop freeing pages at the PGDIR_SIZE boundary after the last vma.
If the stack isn't on the last page table page, the last pte page
won't be freed, as it should be since the stub ptes are there, and
exit_mmap will BUG because there is an unfreed page.  To get around
this, TASK_SIZE is set to the next lowest PGDIR_SIZE boundary and
mm->nr_ptes is decremented after the calls to init_stub_pte.  This
ensures that we know the process stack (and all other process
mappings) will be below the top page table page, and thus we know
that mm->nr_ptes will be one too many, and can be decremented.
	
Things that need fixing -
	We may need better assurrences that the stub code is PIC.
	The stub pte is set up in init_new_context_skas.  alloc_pgdir is
probably the right place.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/Kconfig_i386
===================================================================
--- linux-2.6.12.orig/arch/um/Kconfig_i386	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/Kconfig_i386	2005-07-01 16:40:57.000000000 -0400
@@ -19,6 +19,18 @@ config 3_LEVEL_PGTABLES
 	memory.  All the memory that can't be mapped directly will be treated
 	as high memory.
 
+config STUB_CODE
+	hex
+	default 0xbfffe000
+
+config STUB_DATA
+	hex
+	default 0xbffff000
+
+config STUB_START
+	hex
+	default STUB_CODE
+
 config ARCH_HAS_SC_SIGNALS
 	bool
 	default y
Index: linux-2.6.12/arch/um/Kconfig_x86_64
===================================================================
--- linux-2.6.12.orig/arch/um/Kconfig_x86_64	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/Kconfig_x86_64	2005-07-01 16:40:57.000000000 -0400
@@ -14,6 +14,18 @@ config 3_LEVEL_PGTABLES
        bool
        default y
 
+config STUB_CODE
+	hex
+	default 0x7fbfffe000
+
+config STUB_DATA
+	hex
+	default 0x7fbffff000
+
+config STUB_START
+	hex
+	default STUB_CODE
+
 config ARCH_HAS_SC_SIGNALS
 	bool
 	default n
Index: linux-2.6.12/arch/um/Makefile-i386
===================================================================
--- linux-2.6.12.orig/arch/um/Makefile-i386	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/Makefile-i386	2005-07-01 16:40:57.000000000 -0400
@@ -8,7 +8,7 @@ ifeq ($(CONFIG_MODE_SKAS),y)
   endif
 endif
 
-CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH)
+CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH) $(STUB_CFLAGS)
 ARCH_USER_CFLAGS :=
 
 ifneq ($(CONFIG_GPROF),y)
Index: linux-2.6.12/arch/um/Makefile-x86_64
===================================================================
--- linux-2.6.12.orig/arch/um/Makefile-x86_64	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/Makefile-x86_64	2005-07-01 16:40:57.000000000 -0400
@@ -4,7 +4,7 @@
 SUBARCH_LIBS := arch/um/sys-x86_64/
 START := 0x60000000
 
-CFLAGS += -U__$(SUBARCH)__ -fno-builtin
+CFLAGS += -U__$(SUBARCH)__ -fno-builtin $(STUB_CFLAGS)
 ARCH_USER_CFLAGS := -D__x86_64__
 
 ELF_ARCH := i386:x86-64
Index: linux-2.6.12/arch/um/defconfig
===================================================================
--- linux-2.6.12.orig/arch/um/defconfig	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/defconfig	2005-07-01 16:40:57.000000000 -0400
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.12-rc3-skas3-v9-pre2
-# Sun Apr 24 19:46:10 2005
+# Linux kernel version: 2.6.12-rc6-mm1
+# Tue Jun 14 18:22:21 2005
 #
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_UML=y
@@ -13,23 +13,32 @@ CONFIG_GENERIC_CALIBRATE_DELAY=y
 #
 # UML-specific options
 #
-CONFIG_MODE_TT=y
+# CONFIG_MODE_TT is not set
+# CONFIG_STATIC_LINK is not set
 CONFIG_MODE_SKAS=y
 CONFIG_UML_X86=y
 # CONFIG_64BIT is not set
 CONFIG_TOP_ADDR=0xc0000000
 # CONFIG_3_LEVEL_PGTABLES is not set
+CONFIG_STUB_CODE=0xbfffe000
+CONFIG_STUB_DATA=0xbffff000
+CONFIG_STUB_START=0xbfffe000
 CONFIG_ARCH_HAS_SC_SIGNALS=y
 CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA=y
-CONFIG_LD_SCRIPT_STATIC=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+CONFIG_LD_SCRIPT_DYN=y
 CONFIG_NET=y
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=m
-CONFIG_HOSTFS=y
+# CONFIG_HOSTFS is not set
 CONFIG_MCONSOLE=y
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_HOST_2G_2G is not set
-# CONFIG_SMP is not set
 CONFIG_NEST_LEVEL=0
 CONFIG_KERNEL_HALF_GIGS=1
 # CONFIG_HIGHMEM is not set
@@ -63,6 +72,8 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 CONFIG_KALLSYMS_EXTRA_PASS=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
@@ -81,6 +92,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
 
@@ -115,6 +127,7 @@ CONFIG_UML_SOUND=m
 CONFIG_SOUND=m
 CONFIG_HOSTAUDIO=m
 CONFIG_UML_RANDOM=y
+# CONFIG_MMAPPER is not set
 
 #
 # Block devices
@@ -176,6 +189,17 @@ CONFIG_INET=y
 # CONFIG_INET_TUNNEL is not set
 CONFIG_IP_TCPDIAG=y
 # CONFIG_IP_TCPDIAG_IPV6 is not set
+
+#
+# TCP congestion control
+#
+CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_WESTWOOD=y
+CONFIG_TCP_CONG_HTCP=y
+# CONFIG_TCP_CONG_HSTCP is not set
+# CONFIG_TCP_CONG_HYBLA is not set
+# CONFIG_TCP_CONG_VEGAS is not set
+# CONFIG_TCP_CONG_SCALABLE is not set
 # CONFIG_IPV6 is not set
 # CONFIG_NETFILTER is not set
 
@@ -206,11 +230,15 @@ CONFIG_IP_TCPDIAG=y
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
+# CONFIG_KGDBOE is not set
 # CONFIG_NETPOLL is not set
+# CONFIG_NETPOLL_RX is not set
+# CONFIG_NETPOLL_TRAP is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
+# CONFIG_IEEE80211 is not set
 CONFIG_DUMMY=m
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
@@ -227,6 +255,7 @@ CONFIG_PPP=m
 # CONFIG_PPP_SYNC_TTY is not set
 # CONFIG_PPP_DEFLATE is not set
 # CONFIG_PPP_BSDCOMP is not set
+# CONFIG_PPP_MPPE is not set
 # CONFIG_PPPOE is not set
 CONFIG_SLIP=m
 # CONFIG_SLIP_COMPRESSED is not set
@@ -240,10 +269,12 @@ CONFIG_SLIP=m
 #
 CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
+# CONFIG_REISER4_FS is not set
 CONFIG_REISERFS_FS=y
 # CONFIG_REISERFS_CHECK is not set
 # CONFIG_REISERFS_PROC_INFO is not set
@@ -256,6 +287,7 @@ CONFIG_REISERFS_FS=y
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
 CONFIG_QUOTA=y
 # CONFIG_QFMT_V1 is not set
 # CONFIG_QFMT_V2 is not set
@@ -265,6 +297,12 @@ CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 
 #
+# Caches
+#
+# CONFIG_FSCACHE is not set
+# CONFIG_FUSE_FS is not set
+
+#
 # CD-ROM/DVD Filesystems
 #
 CONFIG_ISO9660_FS=m
@@ -291,6 +329,8 @@ CONFIG_TMPFS=y
 # CONFIG_TMPFS_XATTR is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
+# CONFIG_CONFIGFS_FS is not set
+# CONFIG_RELAYFS_FS is not set
 
 #
 # Miscellaneous filesystems
@@ -319,6 +359,7 @@ CONFIG_RAMFS=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
+# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -404,14 +445,15 @@ CONFIG_CRC32=m
 # CONFIG_PRINTK_TIME is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_LOG_BUF_SHIFT=14
+CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
-# CONFIG_DEBUG_SLAB is not set
+CONFIG_DEBUG_SLAB=y
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_KOBJECT is not set
 CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_FS is not set
 CONFIG_FRAME_POINTER=y
-CONFIG_PT_PROXY=y
+# CONFIG_GPROF is not set
 # CONFIG_GCOV is not set
 # CONFIG_SYSCALL_DEBUG is not set
Index: linux-2.6.12/arch/um/include/mem.h
===================================================================
--- linux-2.6.12.orig/arch/um/include/mem.h	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/include/mem.h	2005-07-01 16:40:57.000000000 -0400
@@ -13,6 +13,7 @@ extern int physmem_subst_mapping(void *v
 extern int is_remapped(void *virt);
 extern int physmem_remove_mapping(void *virt);
 extern void physmem_forget_descriptor(int fd);
+extern unsigned long to_phys(void *virt);
 
 #endif
 
Index: linux-2.6.12/arch/um/include/registers.h
===================================================================
--- linux-2.6.12.orig/arch/um/include/registers.h	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/include/registers.h	2005-07-01 16:40:57.000000000 -0400
@@ -14,6 +14,7 @@ extern int restore_fp_registers(int pid,
 extern void save_registers(int pid, union uml_pt_regs *regs);
 extern void restore_registers(int pid, union uml_pt_regs *regs);
 extern void init_registers(int pid);
+extern void get_safe_registers(unsigned long * regs);
 
 #endif
 
Index: linux-2.6.12/arch/um/include/sysdep-i386/ptrace_user.h
===================================================================
--- linux-2.6.12.orig/arch/um/include/sysdep-i386/ptrace_user.h	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/include/sysdep-i386/ptrace_user.h	2005-07-01 16:40:57.000000000 -0400
@@ -20,11 +20,24 @@
 #define PT_SYSCALL_ARG3_OFFSET PT_OFFSET(EDX)
 #define PT_SYSCALL_ARG4_OFFSET PT_OFFSET(ESI)
 #define PT_SYSCALL_ARG5_OFFSET PT_OFFSET(EDI)
+#define PT_SYSCALL_ARG6_OFFSET PT_OFFSET(EBP)
 
 #define PT_SYSCALL_RET_OFFSET PT_OFFSET(EAX)
 
+#define REGS_SYSCALL_NR EAX /* This is used before a system call */
+#define REGS_SYSCALL_ARG1 EBX
+#define REGS_SYSCALL_ARG2 ECX
+#define REGS_SYSCALL_ARG3 EDX
+#define REGS_SYSCALL_ARG4 ESI
+#define REGS_SYSCALL_ARG5 EDI
+#define REGS_SYSCALL_ARG6 EBP
+
+#define REGS_IP_INDEX EIP
+#define REGS_SP_INDEX UESP
+
 #define PT_IP_OFFSET PT_OFFSET(EIP)
 #define PT_IP(regs) ((regs)[EIP])
+#define PT_SP_OFFSET PT_OFFSET(UESP)
 #define PT_SP(regs) ((regs)[UESP])
 
 #ifndef FRAME_SIZE
Index: linux-2.6.12/arch/um/include/sysdep-i386/stub.h
===================================================================
--- linux-2.6.12.orig/arch/um/include/sysdep-i386/stub.h	2005-07-01 06:36:40.652577584 -0400
+++ linux-2.6.12/arch/um/include/sysdep-i386/stub.h	2005-07-01 16:40:57.000000000 -0400
@@ -0,0 +1,18 @@
+/* 
+ * Copyright (C) 2004 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __SYSDEP_STUB_H
+#define __SYSDEP_STUB_H
+
+#include <asm/ptrace.h>
+#include <asm/unistd.h>
+
+extern void stub_segv_handler(int sig);
+
+#define STUB_SYSCALL_RET EAX
+#define STUB_MMAP_NR __NR_mmap2
+#define MMAP_OFFSET(o) ((o) >> PAGE_SHIFT)
+
+#endif
Index: linux-2.6.12/arch/um/include/sysdep-x86_64/ptrace_user.h
===================================================================
--- linux-2.6.12.orig/arch/um/include/sysdep-x86_64/ptrace_user.h	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/include/sysdep-x86_64/ptrace_user.h	2005-07-01 16:40:57.000000000 -0400
@@ -55,6 +55,20 @@
 #define PTRACE_OLDSETOPTIONS 21
 #endif
 
+/* These are before the system call, so the the system call number is RAX
+ * rather than ORIG_RAX, and arg4 is R10 rather than RCX
+ */
+#define REGS_SYSCALL_NR PT_INDEX(RAX)
+#define REGS_SYSCALL_ARG1 PT_INDEX(RDI)
+#define REGS_SYSCALL_ARG2 PT_INDEX(RSI)
+#define REGS_SYSCALL_ARG3 PT_INDEX(RDX)
+#define REGS_SYSCALL_ARG4 PT_INDEX(R10)
+#define REGS_SYSCALL_ARG5 PT_INDEX(R8)
+#define REGS_SYSCALL_ARG6 PT_INDEX(R9)
+
+#define REGS_IP_INDEX PT_INDEX(RIP)
+#define REGS_SP_INDEX PT_INDEX(RSP)
+
 #endif
 
 /*
Index: linux-2.6.12/arch/um/include/sysdep-x86_64/stub.h
===================================================================
--- linux-2.6.12.orig/arch/um/include/sysdep-x86_64/stub.h	2005-07-01 06:36:40.652577584 -0400
+++ linux-2.6.12/arch/um/include/sysdep-x86_64/stub.h	2005-07-01 16:40:57.000000000 -0400
@@ -0,0 +1,19 @@
+/* 
+ * Copyright (C) 2004 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __SYSDEP_STUB_H
+#define __SYSDEP_STUB_H
+
+#include <asm/ptrace.h>
+#include <asm/unistd.h>
+#include <sysdep/ptrace_user.h>
+
+extern void stub_segv_handler(int sig);
+
+#define STUB_SYSCALL_RET PT_INDEX(RAX)
+#define STUB_MMAP_NR __NR_mmap
+#define MMAP_OFFSET(o) (o)
+
+#endif
Index: linux-2.6.12/arch/um/include/tlb.h
===================================================================
--- linux-2.6.12.orig/arch/um/include/tlb.h	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/include/tlb.h	2005-07-01 16:40:57.000000000 -0400
@@ -37,31 +37,25 @@ struct host_vm_op {
 extern void mprotect_kernel_vm(int w);
 extern void force_flush_all(void);
 extern void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
-			     unsigned long end_addr, int force, int data,
-			     void (*do_ops)(int, struct host_vm_op *, int));
+                             unsigned long end_addr, int force,
+                             void (*do_ops)(union mm_context *, 
+                                            struct host_vm_op *, int));
 extern int flush_tlb_kernel_range_common(unsigned long start,
 					 unsigned long end);
 
 extern int add_mmap(unsigned long virt, unsigned long phys, unsigned long len,
 		    int r, int w, int x, struct host_vm_op *ops, int index,
-		    int last_filled, int data,
-		    void (*do_ops)(int, struct host_vm_op *, int));
+                    int last_filled, union mm_context *mmu,
+                    void (*do_ops)(union mm_context *, struct host_vm_op *, 
+                                   int));
 extern int add_munmap(unsigned long addr, unsigned long len,
 		      struct host_vm_op *ops, int index, int last_filled,
-		      int data, void (*do_ops)(int, struct host_vm_op *, int));
+                      union mm_context *mmu, 
+                      void (*do_ops)(union mm_context *, struct host_vm_op *, 
+                                     int));
 extern int add_mprotect(unsigned long addr, unsigned long len, int r, int w,
 			int x, struct host_vm_op *ops, int index,
-			int last_filled, int data,
-			void (*do_ops)(int, struct host_vm_op *, int));
+                        int last_filled, union mm_context *mmu, 
+                        void (*do_ops)(union mm_context *, struct host_vm_op *,
+                                       int));
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.12/arch/um/kernel/dyn.lds.S
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/dyn.lds.S	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/dyn.lds.S	2005-07-01 16:40:57.000000000 -0400
@@ -67,6 +67,12 @@ SECTIONS
     *(.stub .text.* .gnu.linkonce.t.*)
     /* .gnu.warning sections are handled specially by elf32.em.  */
     *(.gnu.warning)
+
+    . = ALIGN(4096);
+    __syscall_stub_start = .;
+    *(.__syscall_stub*)
+    __syscall_stub_end = .;
+    . = ALIGN(4096);
   } =0x90909090
   .fini           : {
     KEEP (*(.fini))
Index: linux-2.6.12/arch/um/kernel/physmem.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/physmem.c	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/physmem.c	2005-07-01 16:40:57.000000000 -0400
@@ -353,6 +353,8 @@ void map_memory(unsigned long virt, unsi
 
 #define PFN_UP(x) (((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
 
+extern int __syscall_stub_start, __binary_start;
+
 void setup_physmem(unsigned long start, unsigned long reserve_end,
 		   unsigned long len, unsigned long highmem)
 {
@@ -371,6 +373,12 @@ void setup_physmem(unsigned long start, 
 		exit(1);
 	}
 
+	/* Special kludge - This page will be mapped in to userspace processes
+	 * from physmem_fd, so it needs to be written out there.
+	 */
+	os_seek_file(physmem_fd, __pa(&__syscall_stub_start));
+	os_write_file(physmem_fd, &__syscall_stub_start, PAGE_SIZE);
+
 	bootmap_size = init_bootmem(pfn, pfn + delta);
 	free_bootmem(__pa(reserve_end) + bootmap_size,
 		     len - bootmap_size - reserve);
Index: linux-2.6.12/arch/um/kernel/process.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/process.c	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/process.c	2005-07-01 16:40:57.000000000 -0400
@@ -32,6 +32,7 @@
 #include "uml-config.h"
 #include "choose-mode.h"
 #include "mode.h"
+#include "tempfile.h"
 #ifdef UML_CONFIG_MODE_SKAS
 #include "skas.h"
 #include "skas_ptrace.h"
@@ -358,11 +359,16 @@ void forward_pending_sigio(int target)
 		kill(target, SIGIO);
 }
 
+int ptrace_faultinfo = 0;
+int proc_mm = 1;
+
+extern void *__syscall_stub_start, __syscall_stub_end;
+
 #ifdef UML_CONFIG_MODE_SKAS
-static inline int check_skas3_ptrace_support(void)
+static inline void check_skas3_ptrace_support(void)
 {
 	struct ptrace_faultinfo fi;
-	int pid, n, ret = 1;
+	int pid, n;
 
 	printf("Checking for the skas3 patch in the host...");
 	pid = start_ptraced_child();
@@ -374,33 +380,31 @@ static inline int check_skas3_ptrace_sup
 		else {
 			perror("not found");
 		}
-		ret = 0;
-	} else {
+	} 
+	else {
+		ptrace_faultinfo = 1;
 		printf("found\n");
 	}
 
 	init_registers(pid);
 	stop_ptraced_child(pid, 1, 1);
-
-	return(ret);
 }
 
 int can_do_skas(void)
 {
-	int ret = 1;
-
 	printf("Checking for /proc/mm...");
 	if (os_access("/proc/mm", OS_ACC_W_OK) < 0) {
+		proc_mm = 0;
 		printf("not found\n");
-		ret = 0;
 		goto out;
-	} else {
+	} 
+	else {
 		printf("found\n");
 	}
 
-	ret = check_skas3_ptrace_support();
 out:
-	return ret;
+	check_skas3_ptrace_support();
+	return 1;
 }
 #else
 int can_do_skas(void)
Index: linux-2.6.12/arch/um/kernel/skas/exec_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/exec_kern.c	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/exec_kern.c	2005-07-01 16:40:57.000000000 -0400
@@ -18,7 +18,7 @@
 void flush_thread_skas(void)
 {
 	force_flush_all();
-	switch_mm_skas(current->mm->context.skas.mm_fd);
+        switch_mm_skas(&current->mm->context.skas.id);
 }
 
 void start_thread_skas(struct pt_regs *regs, unsigned long eip, 
Index: linux-2.6.12/arch/um/kernel/skas/include/mm_id.h
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/include/mm_id.h	2005-07-01 06:36:40.652577584 -0400
+++ linux-2.6.12/arch/um/kernel/skas/include/mm_id.h	2005-07-01 16:40:57.000000000 -0400
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) 2005 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __MM_ID_H
+#define __MM_ID_H
+
+struct mm_id {
+	union {
+		int mm_fd;
+		int pid;
+	} u;
+	unsigned long stack;
+};
+
+#endif
Index: linux-2.6.12/arch/um/kernel/skas/include/mmu-skas.h
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/include/mmu-skas.h	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/include/mmu-skas.h	2005-07-01 16:40:57.000000000 -0400
@@ -6,10 +6,15 @@
 #ifndef __SKAS_MMU_H
 #define __SKAS_MMU_H
 
+#include "mm_id.h"
+
 struct mmu_context_skas {
-	int mm_fd;
+	struct mm_id id;
+        unsigned long last_page_table;
 };
 
+extern void switch_mm_skas(struct mm_id * mm_idp);
+
 #endif
 
 /*
Index: linux-2.6.12/arch/um/kernel/skas/include/skas.h
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/include/skas.h	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/include/skas.h	2005-07-01 16:40:57.000000000 -0400
@@ -6,9 +6,11 @@
 #ifndef __SKAS_H
 #define __SKAS_H
 
+#include "mm_id.h"
 #include "sysdep/ptrace.h"
 
 extern int userspace_pid[];
+extern int proc_mm, ptrace_faultinfo;
 
 extern void switch_threads(void *me, void *next);
 extern void thread_wait(void *sw, void *fb);
@@ -22,16 +24,17 @@ extern void new_thread_proc(void *stack,
 extern void remove_sigstack(void);
 extern void new_thread_handler(int sig);
 extern void handle_syscall(union uml_pt_regs *regs);
-extern void map(int fd, unsigned long virt, unsigned long len, int r, int w,
-		int x, int phys_fd, unsigned long long offset);
-extern int unmap(int fd, void *addr, unsigned long len);
-extern int protect(int fd, unsigned long addr, unsigned long len, 
-		   int r, int w, int x);
+extern int map(struct mm_id * mm_idp, unsigned long virt, unsigned long len,
+               int r, int w, int x, int phys_fd, unsigned long long offset);
+extern int unmap(struct mm_id * mm_idp, void *addr, unsigned long len);
+extern int protect(struct mm_id * mm_idp, unsigned long addr, 
+		   unsigned long len, int r, int w, int x);
 extern void user_signal(int sig, union uml_pt_regs *regs, int pid);
 extern int new_mm(int from);
-extern void start_userspace(int cpu);
+extern int start_userspace(unsigned long stub_stack);
 extern void get_skas_faultinfo(int pid, struct faultinfo * fi);
 extern long execute_syscall_skas(void *r);
+extern unsigned long current_stub_stack(void);
 
 #endif
 
Index: linux-2.6.12/arch/um/kernel/skas/mem.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/mem.c	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/mem.c	2005-07-01 16:40:57.000000000 -0400
@@ -5,7 +5,9 @@
 
 #include "linux/config.h"
 #include "linux/mm.h"
+#include "asm/pgtable.h"
 #include "mem_user.h"
+#include "skas.h"
 
 unsigned long set_task_sizes_skas(int arg, unsigned long *host_size_out, 
 				  unsigned long *task_size_out)
@@ -18,7 +20,9 @@ unsigned long set_task_sizes_skas(int ar
 	*task_size_out = CONFIG_HOST_TASK_SIZE;
 #else
 	*host_size_out = top;
-	*task_size_out = top;
+	if (proc_mm && ptrace_faultinfo)
+		*task_size_out = top;
+	else *task_size_out = CONFIG_STUB_START & PGDIR_MASK;
 #endif
 	return(((unsigned long) set_task_sizes_skas) & ~0xffffff);
 }
Index: linux-2.6.12/arch/um/kernel/skas/mem_user.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/mem_user.c	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/mem_user.c	2005-07-01 16:40:57.000000000 -0400
@@ -3,100 +3,171 @@
  * Licensed under the GPL
  */
 
+#include <signal.h>
 #include <errno.h>
 #include <sys/mman.h>
+#include <sys/wait.h>
+#include <asm/page.h>
+#include <asm/unistd.h>
 #include "mem_user.h"
 #include "mem.h"
+#include "mm_id.h"
 #include "user.h"
 #include "os.h"
 #include "proc_mm.h"
+#include "ptrace_user.h"
+#include "user_util.h"
+#include "kern_util.h"
+#include "task.h"
+#include "registers.h"
+#include "uml-config.h"
+#include "sysdep/ptrace.h"
+#include "sysdep/stub.h"
+#include "skas.h"
+
+extern unsigned long syscall_stub, __syscall_stub_start;
+  
+extern void wait_stub_done(int pid, int sig, char * fname);
 
-void map(int fd, unsigned long virt, unsigned long len, int r, int w,
-	 int x, int phys_fd, unsigned long long offset)
+static long run_syscall_stub(struct mm_id * mm_idp, int syscall,
+                             unsigned long *args)
 {
-	struct proc_mm_op map;
-	int prot, n;
+        int n, pid = mm_idp->u.pid;
+        unsigned long regs[MAX_REG_NR];
 
-	prot = (r ? PROT_READ : 0) | (w ? PROT_WRITE : 0) | 
-		(x ? PROT_EXEC : 0);
+        get_safe_registers(regs);
+        regs[REGS_IP_INDEX] = UML_CONFIG_STUB_CODE +
+                ((unsigned long) &syscall_stub - 
+                 (unsigned long) &__syscall_stub_start);
+        /* XXX Don't have a define for starting a syscall */
+        regs[REGS_SYSCALL_NR] = syscall;
+        regs[REGS_SYSCALL_ARG1] = args[0];
+        regs[REGS_SYSCALL_ARG2] = args[1];
+        regs[REGS_SYSCALL_ARG3] = args[2];
+        regs[REGS_SYSCALL_ARG4] = args[3];
+        regs[REGS_SYSCALL_ARG5] = args[4];
+        regs[REGS_SYSCALL_ARG6] = args[5];
+        n = ptrace_setregs(pid, regs);
+        if(n < 0){
+                printk("run_syscall_stub : PTRACE_SETREGS failed, "
+                       "errno = %d\n", n);
+                return(n);
+        }
 
-	map = ((struct proc_mm_op) { .op 	= MM_MMAP,
-				     .u 	= 
-				     { .mmap	= 
-				       { .addr 		= virt,
-					 .len		= len,
-					 .prot		= prot,
-					 .flags		= MAP_SHARED | 
-					                  MAP_FIXED,
-					 .fd		= phys_fd,
-					 .offset	= offset
-				       } } } );
-	n = os_write_file(fd, &map, sizeof(map));
-	if(n != sizeof(map)) 
-		printk("map : /proc/mm map failed, err = %d\n", -n);
+        wait_stub_done(pid, 0, "run_syscall_stub");
+
+        return(*((unsigned long *) mm_idp->stack));
 }
 
-int unmap(int fd, void *addr, unsigned long len)
+int map(struct mm_id *mm_idp, unsigned long virt, unsigned long len,
+        int r, int w, int x, int phys_fd, unsigned long long offset)
 {
-	struct proc_mm_op unmap;
-	int n;
+        int prot, n;
+
+        prot = (r ? PROT_READ : 0) | (w ? PROT_WRITE : 0) | 
+                (x ? PROT_EXEC : 0);
 
-	unmap = ((struct proc_mm_op) { .op 	= MM_MUNMAP,
-				       .u 	= 
-				       { .munmap	= 
-					 { .addr 	= (unsigned long) addr,
-					   .len		= len } } } );
-	n = os_write_file(fd, &unmap, sizeof(unmap));
-	if(n != sizeof(unmap)) {
-		if(n < 0)
-			return(n);
-		else if(n > 0)
-			return(-EIO);
-	}
+        if(proc_mm){
+                struct proc_mm_op map;
+                int fd = mm_idp->u.mm_fd;
+                map = ((struct proc_mm_op) { .op	= MM_MMAP,
+                                             .u		= 
+                                             { .mmap	= 
+                                               { .addr	= virt,
+                                                 .len	= len,
+                                                 .prot	= prot,
+                                                 .flags	= MAP_SHARED | 
+                                                 MAP_FIXED,
+                                                 .fd	= phys_fd,
+                                                 .offset= offset
+                                               } } } );
+                n = os_write_file(fd, &map, sizeof(map));
+                if(n != sizeof(map)) 
+                        printk("map : /proc/mm map failed, err = %d\n", -n);
+        }
+        else {
+                long res;
+                unsigned long args[] = { virt, len, prot, 
+                                         MAP_SHARED | MAP_FIXED, phys_fd,
+                                         MMAP_OFFSET(offset) };
+
+                res = run_syscall_stub(mm_idp, STUB_MMAP_NR, args);
+                if((void *) res == MAP_FAILED)
+                        printk("mmap stub failed, errno = %d\n", res);
+        }
 
-	return(0);
+        return 0;
 }
 
-int protect(int fd, unsigned long addr, unsigned long len, int r, int w, 
-	    int x, int must_succeed)
+int unmap(struct mm_id *mm_idp, void *addr, unsigned long len)
 {
-	struct proc_mm_op protect;
-	int prot, n;
+        int n;
 
-	prot = (r ? PROT_READ : 0) | (w ? PROT_WRITE : 0) | 
-		(x ? PROT_EXEC : 0);
+        if(proc_mm){
+                struct proc_mm_op unmap;
+                int fd = mm_idp->u.mm_fd;
+                unmap = ((struct proc_mm_op) { .op	= MM_MUNMAP,
+                                               .u	= 
+                                               { .munmap	= 
+                                                 { .addr	= 
+                                                   (unsigned long) addr,
+                                                   .len		= len } } } );
+                n = os_write_file(fd, &unmap, sizeof(unmap));
+                if(n != sizeof(unmap)) {
+                        if(n < 0)
+                                return(n);
+                        else if(n > 0)
+                                return(-EIO);
+                }
+        }
+        else {
+                int res;
+                unsigned long args[] = { (unsigned long) addr, len, 0, 0, 0, 
+                                         0 };
+
+                res = run_syscall_stub(mm_idp, __NR_munmap, args);
+                if(res < 0)
+                        printk("munmap stub failed, errno = %d\n", res);
+        }
+  
+        return(0);
+}
 
-	protect = ((struct proc_mm_op) { .op 	= MM_MPROTECT,
-				       .u 	= 
-				       { .mprotect	= 
-					 { .addr 	= (unsigned long) addr,
-					   .len		= len,
-					   .prot	= prot } } } );
-
-	n = os_write_file(fd, &protect, sizeof(protect));
-	if(n != sizeof(protect)) {
-		if(n == 0) return(0);
+int protect(struct mm_id *mm_idp, unsigned long addr, unsigned long len, 
+	    int r, int w, int x)
+{
+        struct proc_mm_op protect;
+        int prot, n;
 
-		if(must_succeed)
-			panic("protect failed, err = %d", -n);
+        prot = (r ? PROT_READ : 0) | (w ? PROT_WRITE : 0) | 
+                (x ? PROT_EXEC : 0);
 
-		return(-EIO);
-	}
+        if(proc_mm){
+                int fd = mm_idp->u.mm_fd;
+                protect = ((struct proc_mm_op) { .op	= MM_MPROTECT,
+                                                 .u	= 
+                                                 { .mprotect	= 
+                                                   { .addr	= 
+                                                     (unsigned long) addr,
+                                                     .len	= len,
+                                                     .prot	= prot } } } );
+
+                n = os_write_file(fd, &protect, sizeof(protect));
+                if(n != sizeof(protect))
+                        panic("protect failed, err = %d", -n);
+        }
+        else {
+                int res;
+                unsigned long args[] = { addr, len, prot, 0, 0, 0 };
+
+                res = run_syscall_stub(mm_idp, __NR_mprotect, args);
+                if(res < 0)
+                        panic("mprotect stub failed, errno = %d\n", res);
+        }
 
-	return(0);
+        return(0);
 }
 
 void before_mem_skas(unsigned long unused)
 {
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.12/arch/um/kernel/skas/mmu.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/mmu.c	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/mmu.c	2005-07-01 16:40:57.000000000 -0400
@@ -3,46 +3,138 @@
  * Licensed under the GPL
  */
 
+#include "linux/config.h"
 #include "linux/sched.h"
 #include "linux/list.h"
 #include "linux/spinlock.h"
 #include "linux/slab.h"
+#include "linux/errno.h"
+#include "linux/mm.h"
 #include "asm/current.h"
 #include "asm/segment.h"
 #include "asm/mmu.h"
+#include "asm/pgalloc.h"
+#include "asm/pgtable.h"
 #include "os.h"
 #include "skas.h"
 
+extern int __syscall_stub_start;
+
+static int init_stub_pte(struct mm_struct *mm, unsigned long proc, 
+			 unsigned long kernel)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	spin_lock(&mm->page_table_lock);
+	pgd = pgd_offset(mm, proc);
+	pud = pud_alloc(mm, pgd, proc);
+	if (!pud)
+		goto out;
+
+	pmd = pmd_alloc(mm, pud, proc);
+	if (!pmd)
+		goto out_pmd;
+
+	pte = pte_alloc_map(mm, pmd, proc);
+	if (!pte)
+		goto out_pte;
+
+	/* There's an interaction between the skas0 stub pages, stack 
+	 * randomization, and the BUG at the end of exit_mmap.  exit_mmap
+         * checks that the number of page tables freed is the same as had
+         * been allocated.  If the stack is on the last page table page,
+	 * then the stack pte page will be freed, and if not, it won't.  To 
+	 * avoid having to know where the stack is, or if the process mapped
+	 * something at the top of its address space for some other reason,
+	 * we set TASK_SIZE to end at the start of the last page table.
+	 * This keeps exit_mmap off the last page, but introduces a leak
+	 * of that page.  So, we hang onto it here and free it in 
+	 * destroy_context_skas.
+	 */
+
+        mm->context.skas.last_page_table = pmd_page_kernel(*pmd);
+
+	*pte = mk_pte(virt_to_page(kernel), __pgprot(_PAGE_PRESENT));
+	*pte = pte_mkexec(*pte);
+	*pte = pte_wrprotect(*pte);
+	spin_unlock(&mm->page_table_lock);
+	return(0);
+
+ out_pmd:
+	pud_free(pud);
+ out_pte:
+	pmd_free(pmd);
+ out:
+	spin_unlock(&mm->page_table_lock);
+	return(-ENOMEM);
+}
+
 int init_new_context_skas(struct task_struct *task, struct mm_struct *mm)
 {
-	int from;
+	struct mm_struct *cur_mm = current->mm;
+	struct mm_id *mm_id = &mm->context.skas.id;
+	unsigned long stack;
+	int from, ret;
+
+	if(proc_mm){
+		if((cur_mm != NULL) && (cur_mm != &init_mm))
+			from = cur_mm->context.skas.id.u.mm_fd;
+		else from = -1;
+
+		ret = new_mm(from);
+		if(ret < 0){
+			printk("init_new_context_skas - new_mm failed, "
+			       "errno = %d\n", ret);
+			return ret;
+		}
+		mm_id->u.mm_fd = ret;
+	}
+	else {
+		/* This zeros the entry that pgd_alloc didn't, needed since
+		 * we are about to reinitialize it, and want mm.nr_ptes to
+		 * be accurate.
+		 */
+		mm->pgd[USER_PTRS_PER_PGD] = __pgd(0);
+		       
+		ret = init_stub_pte(mm, CONFIG_STUB_CODE,
+				    (unsigned long) &__syscall_stub_start);
+		if(ret)
+			goto out;
+
+		ret = -ENOMEM;
+		stack = get_zeroed_page(GFP_KERNEL);
+		if(stack == 0)
+			goto out;
+		mm_id->stack = stack;
+
+		ret = init_stub_pte(mm, CONFIG_STUB_DATA, stack);
+		if(ret)
+			goto out_free;
 
-	if((current->mm != NULL) && (current->mm != &init_mm))
-		from = current->mm->context.skas.mm_fd;
-	else from = -1;
-
-	mm->context.skas.mm_fd = new_mm(from);
-	if(mm->context.skas.mm_fd < 0){
-		printk("init_new_context_skas - new_mm failed, errno = %d\n",
-		       mm->context.skas.mm_fd);
-		return(mm->context.skas.mm_fd);
+		mm->nr_ptes--;
+		mm_id->u.pid = start_userspace(stack);
 	}
 
-	return(0);
+	return 0;
+
+ out_free:
+	free_page(mm_id->stack);
+ out:
+	return ret;
 }
 
 void destroy_context_skas(struct mm_struct *mm)
 {
-	os_close_file(mm->context.skas.mm_fd);
-}
+	struct mmu_context_skas *mmu = &mm->context.skas;
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
+	if(proc_mm)
+		os_close_file(mmu->id.u.mm_fd);
+	else {
+		os_kill_ptraced_process(mmu->id.u.pid, 1);
+		free_page(mmu->id.stack);
+		free_page(mmu->last_page_table);
+	}
+}
Index: linux-2.6.12/arch/um/kernel/skas/process.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/process.c	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/process.c	2005-07-01 16:40:57.000000000 -0400
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Copyright (C) 2002- 2004 Jeff Dike (jdike@addtoit.com)
  * Licensed under the GPL
  */
 
@@ -14,6 +14,7 @@
 #include <sys/mman.h>
 #include <sys/user.h>
 #include <asm/unistd.h>
+#include <asm/types.h>
 #include "user.h"
 #include "ptrace_user.h"
 #include "time_user.h"
@@ -21,13 +22,17 @@
 #include "user_util.h"
 #include "kern_util.h"
 #include "skas.h"
+#include "mm_id.h"
 #include "sysdep/sigcontext.h"
+#include "sysdep/stub.h"
 #include "os.h"
 #include "proc_mm.h"
 #include "skas_ptrace.h"
 #include "chan_user.h"
 #include "signal_user.h"
 #include "registers.h"
+#include "mem.h"
+#include "uml-config.h"
 #include "process.h"
 
 int is_skas_winch(int pid, int fd, void *data)
@@ -39,20 +44,55 @@ int is_skas_winch(int pid, int fd, void 
 	return(1);
 }
 
+void wait_stub_done(int pid, int sig, char * fname)
+{
+        int n, status, err;
+
+        do {
+                if ( sig != -1 ) {
+                        err = ptrace(PTRACE_CONT, pid, 0, sig);
+                        if(err)
+                                panic("%s : continue failed, errno = %d\n",
+                                      fname, errno);
+                }
+                sig = 0;
+
+                CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
+        } while((n >= 0) && WIFSTOPPED(status) &&
+                (WSTOPSIG(status) == SIGVTALRM));
+
+        if((n < 0) || !WIFSTOPPED(status) ||
+           (WSTOPSIG(status) != SIGUSR1 && WSTOPSIG(status != SIGTRAP))){
+                panic("%s : failed to wait for SIGUSR1/SIGTRAP, "
+                      "pid = %d, n = %d, errno = %d, status = 0x%x\n",
+                      fname, pid, n, errno, status);
+        }
+}
+
 void get_skas_faultinfo(int pid, struct faultinfo * fi)
 {
-	int err;
+        int err;
 
-        err = ptrace(PTRACE_FAULTINFO, pid, 0, fi);
-	if(err)
-                panic("get_skas_faultinfo - PTRACE_FAULTINFO failed, "
-                      "errno = %d\n", errno);
-
-        /* Special handling for i386, which has different structs */
-        if (sizeof(struct ptrace_faultinfo) < sizeof(struct faultinfo))
-                memset((char *)fi + sizeof(struct ptrace_faultinfo), 0,
-                       sizeof(struct faultinfo) -
-                       sizeof(struct ptrace_faultinfo));
+        if(ptrace_faultinfo){
+                err = ptrace(PTRACE_FAULTINFO, pid, 0, fi);
+                if(err)
+                        panic("get_skas_faultinfo - PTRACE_FAULTINFO failed, "
+                              "errno = %d\n", errno);
+
+                /* Special handling for i386, which has different structs */
+                if (sizeof(struct ptrace_faultinfo) < sizeof(struct faultinfo))
+                        memset((char *)fi + sizeof(struct ptrace_faultinfo), 0,
+                               sizeof(struct faultinfo) - 
+                               sizeof(struct ptrace_faultinfo));
+        }
+        else {
+                wait_stub_done(pid, SIGSEGV, "get_skas_faultinfo");
+ 
+                /* faultinfo is prepared by the stub-segv-handler at start of 
+                 * the stub stack page. We just have to copy it.
+                 */
+                memcpy(fi, (void *)current_stub_stack(), sizeof(*fi));
+        }
 }
 
 static void handle_segv(int pid, union uml_pt_regs * regs)
@@ -91,11 +131,56 @@ static void handle_trap(int pid, union u
 	handle_syscall(regs);
 }
 
-static int userspace_tramp(void *arg)
+extern int __syscall_stub_start;
+
+static int userspace_tramp(void *stack)
 {
-	init_new_thread_signals(0);
-	enable_timer();
+	void *addr;
+
 	ptrace(PTRACE_TRACEME, 0, 0, 0);
+
+	init_new_thread_signals(1);
+	enable_timer();
+
+	if(!proc_mm){
+		/* This has a pte, but it can't be mapped in with the usual
+		 * tlb_flush mechanism because this is part of that mechanism
+		 */
+		int fd;
+		__u64 offset;
+
+		fd = phys_mapping(to_phys(&__syscall_stub_start), &offset);
+		addr = mmap64((void *) UML_CONFIG_STUB_CODE, page_size(), 
+			      PROT_EXEC, MAP_FIXED | MAP_PRIVATE, fd, offset);
+		if(addr == MAP_FAILED){
+			printk("mapping mmap stub failed, errno = %d\n", 
+			       errno);
+			exit(1);
+		}
+
+		if(stack != NULL){
+			fd = phys_mapping(to_phys(stack), &offset);
+			addr = mmap((void *) UML_CONFIG_STUB_DATA, page_size(),
+				    PROT_READ | PROT_WRITE, 
+				    MAP_FIXED | MAP_SHARED, fd, offset);
+			if(addr == MAP_FAILED){
+				printk("mapping segfault stack failed, "
+				       "errno = %d\n", errno);
+				exit(1);
+			}
+		}
+	}
+	if(!ptrace_faultinfo && (stack != NULL)){
+		unsigned long v = UML_CONFIG_STUB_CODE +
+				  (unsigned long) stub_segv_handler -
+				  (unsigned long) &__syscall_stub_start;
+
+		set_sigstack((void *) UML_CONFIG_STUB_DATA, page_size());
+		set_handler(SIGSEGV, (void *) v, SA_ONSTACK,
+			    SIGIO, SIGWINCH, SIGALRM, SIGVTALRM,
+			    SIGUSR1, -1);
+	}
+
 	os_stop_process(os_getpid());
 	return(0);
 }
@@ -105,11 +190,11 @@ static int userspace_tramp(void *arg)
 #define NR_CPUS 1
 int userspace_pid[NR_CPUS];
 
-void start_userspace(int cpu)
+int start_userspace(unsigned long stub_stack)
 {
 	void *stack;
 	unsigned long sp;
-	int pid, status, n;
+	int pid, status, n, flags;
 
 	stack = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
 		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
@@ -117,8 +202,9 @@ void start_userspace(int cpu)
 		panic("start_userspace : mmap failed, errno = %d", errno);
 	sp = (unsigned long) stack + PAGE_SIZE - sizeof(void *);
 
-	pid = clone(userspace_tramp, (void *) sp, 
-		    CLONE_FILES | CLONE_VM | SIGCHLD, NULL);
+	flags = CLONE_FILES | SIGCHLD;
+	if(proc_mm) flags |= CLONE_VM;
+	pid = clone(userspace_tramp, (void *) sp, flags, (void *) stub_stack);
 	if(pid < 0)
 		panic("start_userspace : clone failed, errno = %d", errno);
 
@@ -140,7 +226,7 @@ void start_userspace(int cpu)
 	if(munmap(stack, PAGE_SIZE) < 0)
 		panic("start_userspace : munmap failed, errno = %d\n", errno);
 
-	userspace_pid[cpu] = pid;
+	return(pid);
 }
 
 void userspace(union uml_pt_regs *regs)
@@ -174,7 +260,9 @@ void userspace(union uml_pt_regs *regs)
 		if(WIFSTOPPED(status)){
 		  	switch(WSTOPSIG(status)){
 			case SIGSEGV:
-                                handle_segv(pid, regs);
+                                if(PTRACE_FULL_FAULTINFO || !ptrace_faultinfo)
+                                        user_signal(SIGSEGV, regs, pid);
+                                else handle_segv(pid, regs);
 				break;
 			case SIGTRAP + 0x80:
 			        handle_trap(pid, regs, local_using_sysemu);
@@ -194,6 +282,7 @@ void userspace(union uml_pt_regs *regs)
 			        printk("userspace - child stopped with signal "
 				       "%d\n", WSTOPSIG(status));
 			}
+			pid = userspace_pid[0];
 			interrupt_end();
 
 			/* Avoid -ERESTARTSYS handling in host */
@@ -334,21 +423,19 @@ void reboot_skas(void)
 	siglongjmp(initial_jmpbuf, INIT_JMP_REBOOT);
 }
 
-void switch_mm_skas(int mm_fd)
+void switch_mm_skas(struct mm_id *mm_idp)
 {
 	int err;
 
 #warning need cpu pid in switch_mm_skas
-	err = ptrace(PTRACE_SWITCH_MM, userspace_pid[0], 0, mm_fd);
-	if(err)
-		panic("switch_mm_skas - PTRACE_SWITCH_MM failed, errno = %d\n",
-		      errno);
-}
-
-void kill_off_processes_skas(void)
-{
-#warning need to loop over userspace_pids in kill_off_processes_skas
-	os_kill_ptraced_process(userspace_pid[0], 1);
+	if(proc_mm){
+		err = ptrace(PTRACE_SWITCH_MM, userspace_pid[0], 0, 
+			     mm_idp->u.mm_fd);
+		if(err)
+			panic("switch_mm_skas - PTRACE_SWITCH_MM failed, "
+			      "errno = %d\n", errno);
+	}
+	else userspace_pid[0] = mm_idp->u.pid;
 }
 
 /*
Index: linux-2.6.12/arch/um/kernel/skas/process_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/process_kern.c	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/process_kern.c	2005-07-01 16:40:57.000000000 -0400
@@ -175,9 +175,12 @@ static int start_kernel_proc(void *unuse
 	return(0);
 }
 
+extern int userspace_pid[];
+
 int start_uml_skas(void)
 {
-	start_userspace(0);
+	if(proc_mm)
+		userspace_pid[0] = start_userspace(0);
 
 	init_new_thread_signals(1);
 
@@ -199,3 +202,31 @@ int thread_pid_skas(struct task_struct *
 #warning Need to look up userspace_pid by cpu
 	return(userspace_pid[0]);
 }
+
+void kill_off_processes_skas(void)
+{
+	if(proc_mm)
+#warning need to loop over userspace_pids in kill_off_processes_skas
+		os_kill_ptraced_process(userspace_pid[0], 1);
+	else {
+		struct task_struct *p;
+		int pid, me;
+
+		me = os_getpid();
+		for_each_process(p){
+			if(p->mm == NULL)
+				continue;
+
+			pid = p->mm->context.skas.id.u.pid;
+			os_kill_ptraced_process(pid, 1);
+		}
+	}
+}
+
+unsigned long current_stub_stack(void)
+{
+	if(current->mm == NULL)
+		return(0);
+
+	return(current->mm->context.skas.id.stack);
+}
Index: linux-2.6.12/arch/um/kernel/skas/tlb.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/tlb.c	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/tlb.c	2005-07-01 16:40:57.000000000 -0400
@@ -6,6 +6,7 @@
 
 #include "linux/stddef.h"
 #include "linux/sched.h"
+#include "linux/config.h"
 #include "linux/mm.h"
 #include "asm/page.h"
 #include "asm/pgtable.h"
@@ -17,7 +18,7 @@
 #include "os.h"
 #include "tlb.h"
 
-static void do_ops(int fd, struct host_vm_op *ops, int last)
+static void do_ops(union mm_context *mmu, struct host_vm_op *ops, int last)
 {
 	struct host_vm_op *op;
 	int i;
@@ -26,18 +27,18 @@ static void do_ops(int fd, struct host_v
 		op = &ops[i];
 		switch(op->type){
 		case MMAP:
-			map(fd, op->u.mmap.addr, op->u.mmap.len,
+                        map(&mmu->skas.id, op->u.mmap.addr, op->u.mmap.len,
 			    op->u.mmap.r, op->u.mmap.w, op->u.mmap.x,
 			    op->u.mmap.fd, op->u.mmap.offset);
 			break;
 		case MUNMAP:
-			unmap(fd, (void *) op->u.munmap.addr,
+                        unmap(&mmu->skas.id, (void *) op->u.munmap.addr,
 			      op->u.munmap.len);
 			break;
 		case MPROTECT:
-			protect(fd, op->u.mprotect.addr, op->u.mprotect.len,
-				op->u.mprotect.r, op->u.mprotect.w,
-				op->u.mprotect.x);
+                        protect(&mmu->skas.id, op->u.mprotect.addr,
+                                op->u.mprotect.len, op->u.mprotect.r, 
+                                op->u.mprotect.w, op->u.mprotect.x);
 			break;
 		default:
 			printk("Unknown op type %d in do_ops\n", op->type);
@@ -46,12 +47,15 @@ static void do_ops(int fd, struct host_v
 	}
 }
 
+extern int proc_mm;
+
 static void fix_range(struct mm_struct *mm, unsigned long start_addr,
 		      unsigned long end_addr, int force)
 {
-        int fd = mm->context.skas.mm_fd;
+        if(!proc_mm && (end_addr > CONFIG_STUB_START))
+                end_addr = CONFIG_STUB_START;
 
-        fix_range_common(mm, start_addr, end_addr, force, fd, do_ops);
+        fix_range_common(mm, start_addr, end_addr, force, do_ops);
 }
 
 void __flush_tlb_one_skas(unsigned long addr)
@@ -69,16 +73,20 @@ void flush_tlb_range_skas(struct vm_area
 
 void flush_tlb_mm_skas(struct mm_struct *mm)
 {
+	unsigned long end;
+
 	/* Don't bother flushing if this address space is about to be
          * destroyed.
          */
         if(atomic_read(&mm->mm_users) == 0)
                 return;
 
-        fix_range(mm, 0, host_task_size, 0);
+	end = proc_mm ? task_size : CONFIG_STUB_START;
+        fix_range(mm, 0, end, 0);
 }
 
 void force_flush_all_skas(void)
 {
-        fix_range(current->mm, 0, host_task_size, 1);
+	unsigned long end = proc_mm ? task_size : CONFIG_STUB_START;
+        fix_range(current->mm, 0, end, 1);
 }
Index: linux-2.6.12/arch/um/kernel/tlb.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/tlb.c	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/tlb.c	2005-07-01 16:40:57.000000000 -0400
@@ -18,13 +18,15 @@
 #define ADD_ROUND(n, inc) (((n) + (inc)) & ~((inc) - 1))
 
 void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
-                      unsigned long end_addr, int force, int data,
-                      void (*do_ops)(int, struct host_vm_op *, int))
+                      unsigned long end_addr, int force,
+                      void (*do_ops)(union mm_context *, struct host_vm_op *, 
+                                     int))
 {
         pgd_t *npgd;
         pud_t *npud;
         pmd_t *npmd;
         pte_t *npte;
+        union mm_context *mmu = &mm->context;
         unsigned long addr, end;
         int r, w, x;
         struct host_vm_op ops[16];
@@ -40,7 +42,7 @@ void fix_range_common(struct mm_struct *
                                 end = end_addr;
                         if(force || pgd_newpage(*npgd)){
                                 op_index = add_munmap(addr, end - addr, ops,
-                                                      op_index, last_op, data,
+                                                      op_index, last_op, mmu,
                                                       do_ops);
                                 pgd_mkuptodate(*npgd);
                         }
@@ -55,7 +57,7 @@ void fix_range_common(struct mm_struct *
                                 end = end_addr;
                         if(force || pud_newpage(*npud)){
                                 op_index = add_munmap(addr, end - addr, ops,
-                                                      op_index, last_op, data,
+                                                      op_index, last_op, mmu,
                                                       do_ops);
                                 pud_mkuptodate(*npud);
                         }
@@ -70,7 +72,7 @@ void fix_range_common(struct mm_struct *
                                 end = end_addr;
                         if(force || pmd_newpage(*npmd)){
                                 op_index = add_munmap(addr, end - addr, ops,
-                                                      op_index, last_op, data,
+                                                      op_index, last_op, mmu,
                                                       do_ops);
                                 pmd_mkuptodate(*npmd);
                         }
@@ -93,21 +95,21 @@ void fix_range_common(struct mm_struct *
                                 op_index = add_mmap(addr,
                                                     pte_val(*npte) & PAGE_MASK,
                                                     PAGE_SIZE, r, w, x, ops,
-                                                    op_index, last_op, data,
+                                                    op_index, last_op, mmu,
                                                     do_ops);
                         else op_index = add_munmap(addr, PAGE_SIZE, ops,
-                                                   op_index, last_op, data,
+                                                   op_index, last_op, mmu, 
                                                    do_ops);
                 }
                 else if(pte_newprot(*npte))
                         op_index = add_mprotect(addr, PAGE_SIZE, r, w, x, ops,
-                                                op_index, last_op, data,
+                                                op_index, last_op, mmu,
                                                 do_ops);
 
                 *npte = pte_mkuptodate(*npte);
                 addr += PAGE_SIZE;
         }
-        (*do_ops)(data, ops, op_index);
+        (*do_ops)(mmu, ops, op_index);
 }
 
 int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
@@ -195,51 +197,6 @@ int flush_tlb_kernel_range_common(unsign
         return(updated);
 }
 
-void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
-{
-        address &= PAGE_MASK;
-        flush_tlb_range(vma, address, address + PAGE_SIZE);
-}
-
-void flush_tlb_all(void)
-{
-        flush_tlb_mm(current->mm);
-}
-  
-void flush_tlb_kernel_range(unsigned long start, unsigned long end)
-{
-        CHOOSE_MODE_PROC(flush_tlb_kernel_range_tt,
-                         flush_tlb_kernel_range_common, start, end);
-}
-
-void flush_tlb_kernel_vm(void)
-{
-        CHOOSE_MODE(flush_tlb_kernel_vm_tt(),
-                    flush_tlb_kernel_range_common(start_vm, end_vm));
-}
-
-void __flush_tlb_one(unsigned long addr)
-{
-        CHOOSE_MODE_PROC(__flush_tlb_one_tt, __flush_tlb_one_skas, addr);
-}
-
-void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, 
-     unsigned long end)
-{
-        CHOOSE_MODE_PROC(flush_tlb_range_tt, flush_tlb_range_skas, vma, start,
-                         end);
-}
-
-void flush_tlb_mm(struct mm_struct *mm)
-{
-        CHOOSE_MODE_PROC(flush_tlb_mm_tt, flush_tlb_mm_skas, mm);
-}
-
-void force_flush_all(void)
-{
-        CHOOSE_MODE(force_flush_all_tt(), force_flush_all_skas());
-}
-
 pgd_t *pgd_offset_proc(struct mm_struct *mm, unsigned long address)
 {
         return(pgd_offset(mm, address));
@@ -270,9 +227,9 @@ pte_t *addr_pte(struct task_struct *task
 }
 
 int add_mmap(unsigned long virt, unsigned long phys, unsigned long len,
-     int r, int w, int x, struct host_vm_op *ops, int index,
-     int last_filled, int data,
-     void (*do_ops)(int, struct host_vm_op *, int))
+             int r, int w, int x, struct host_vm_op *ops, int index, 
+             int last_filled, union mm_context *mmu, 
+             void (*do_ops)(union mm_context *, struct host_vm_op *, int))
 {
         __u64 offset;
 	struct host_vm_op *last;
@@ -292,7 +249,7 @@ int add_mmap(unsigned long virt, unsigne
 	}
 
 	if(index == last_filled){
-		(*do_ops)(data, ops, last_filled);
+		(*do_ops)(mmu, ops, last_filled);
 		index = -1;
 	}
 
@@ -310,8 +267,8 @@ int add_mmap(unsigned long virt, unsigne
 }
 
 int add_munmap(unsigned long addr, unsigned long len, struct host_vm_op *ops,
-	       int index, int last_filled, int data,
-	       void (*do_ops)(int, struct host_vm_op *, int))
+	       int index, int last_filled, union mm_context *mmu,
+	       void (*do_ops)(union mm_context *, struct host_vm_op *, int))
 {
 	struct host_vm_op *last;
 
@@ -325,7 +282,7 @@ int add_munmap(unsigned long addr, unsig
 	}
 
 	if(index == last_filled){
-		(*do_ops)(data, ops, last_filled);
+		(*do_ops)(mmu, ops, last_filled);
 		index = -1;
 	}
 
@@ -337,8 +294,9 @@ int add_munmap(unsigned long addr, unsig
 }
 
 int add_mprotect(unsigned long addr, unsigned long len, int r, int w, int x,
-		 struct host_vm_op *ops, int index, int last_filled, int data,
-		 void (*do_ops)(int, struct host_vm_op *, int))
+                 struct host_vm_op *ops, int index, int last_filled,
+                 union mm_context *mmu, 
+                 void (*do_ops)(union mm_context *, struct host_vm_op *, int))
 {
 	struct host_vm_op *last;
 
@@ -354,7 +312,7 @@ int add_mprotect(unsigned long addr, uns
 	}
 
 	if(index == last_filled){
-		(*do_ops)(data, ops, last_filled);
+		(*do_ops)(mmu, ops, last_filled);
 		index = -1;
 	}
 
@@ -367,3 +325,49 @@ int add_mprotect(unsigned long addr, uns
 						      .x	= x } } });
 	return(index);
 }
+
+void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
+{
+        address &= PAGE_MASK;
+        flush_tlb_range(vma, address, address + PAGE_SIZE);
+}
+
+void flush_tlb_all(void)
+{
+        flush_tlb_mm(current->mm);
+}
+  
+void flush_tlb_kernel_range(unsigned long start, unsigned long end)
+{
+        CHOOSE_MODE_PROC(flush_tlb_kernel_range_tt, 
+                         flush_tlb_kernel_range_common, start, end);
+}
+
+void flush_tlb_kernel_vm(void)
+{
+        CHOOSE_MODE(flush_tlb_kernel_vm_tt(), 
+                    flush_tlb_kernel_range_common(start_vm, end_vm));
+}
+
+void __flush_tlb_one(unsigned long addr)
+{
+        CHOOSE_MODE_PROC(__flush_tlb_one_tt, __flush_tlb_one_skas, addr);
+}
+
+void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, 
+		     unsigned long end)
+{
+        CHOOSE_MODE_PROC(flush_tlb_range_tt, flush_tlb_range_skas, vma, start, 
+                         end);
+}
+
+void flush_tlb_mm(struct mm_struct *mm)
+{
+        CHOOSE_MODE_PROC(flush_tlb_mm_tt, flush_tlb_mm_skas, mm);
+}
+
+void force_flush_all(void)
+{
+        CHOOSE_MODE(force_flush_all_tt(), force_flush_all_skas());
+}
+
Index: linux-2.6.12/arch/um/kernel/tt/tlb.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/tt/tlb.c	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/tt/tlb.c	2005-07-01 16:40:57.000000000 -0400
@@ -17,7 +17,7 @@
 #include "os.h"
 #include "tlb.h"
 
-static void do_ops(int unused, struct host_vm_op *ops, int last)
+static void do_ops(union mm_context *mmu, struct host_vm_op *ops, int last)
 {
 	struct host_vm_op *op;
 	int i;
@@ -55,7 +55,7 @@ static void fix_range(struct mm_struct *
                 panic("fix_range fixing wrong address space, current = 0x%p",
                       current);
 
-        fix_range_common(mm, start_addr, end_addr, force, 0, do_ops);
+        fix_range_common(mm, start_addr, end_addr, force, do_ops);
 }
 
 atomic_t vmchange_seq = ATOMIC_INIT(1);
Index: linux-2.6.12/arch/um/kernel/uml.lds.S
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/uml.lds.S	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/uml.lds.S	2005-07-01 16:40:57.000000000 -0400
@@ -30,6 +30,7 @@ SECTIONS
 	_einittext = .;
   }
   . = ALIGN(4096);
+
   .text      :
   {
     *(.text)
@@ -39,6 +40,12 @@ SECTIONS
     /* .gnu.warning sections are handled specially by elf32.em.  */
     *(.gnu.warning)
     *(.gnu.linkonce.t*)
+
+    . = ALIGN(4096);
+    __syscall_stub_start = .;
+    *(.__syscall_stub*)
+    __syscall_stub_end = .;
+    . = ALIGN(4096);
   }
 
   #include "asm/common.lds.S"
Index: linux-2.6.12/arch/um/os-Linux/sys-i386/registers.c
===================================================================
--- linux-2.6.12.orig/arch/um/os-Linux/sys-i386/registers.c	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/os-Linux/sys-i386/registers.c	2005-07-01 16:40:57.000000000 -0400
@@ -121,6 +121,11 @@ void init_registers(int pid)
 		      err);
 }
 
+void get_safe_registers(unsigned long *regs)
+{
+	memcpy(regs, exec_regs, HOST_FRAME_SIZE * sizeof(unsigned long));
+}
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: linux-2.6.12/arch/um/os-Linux/sys-x86_64/registers.c
===================================================================
--- linux-2.6.12.orig/arch/um/os-Linux/sys-x86_64/registers.c	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/os-Linux/sys-x86_64/registers.c	2005-07-01 16:40:57.000000000 -0400
@@ -69,6 +69,11 @@ void init_registers(int pid)
 		      err);
 }
 
+void get_safe_registers(unsigned long *regs)
+{
+	memcpy(regs, exec_regs, HOST_FRAME_SIZE * sizeof(unsigned long));
+}
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: linux-2.6.12/arch/um/scripts/Makefile.rules
===================================================================
--- linux-2.6.12.orig/arch/um/scripts/Makefile.rules	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/scripts/Makefile.rules	2005-07-01 16:40:57.000000000 -0400
@@ -16,6 +16,11 @@ define unprofile
 endef
 
 
+# The stubs and unmap.o can't try to call mcount or update basic block data
+define unprofile
+	$(patsubst -pg,,$(patsubst -fprofile-arcs -ftest-coverage,,$(1)))
+endef
+
 quiet_cmd_make_link = SYMLINK $@
 cmd_make_link       = ln -sf $(srctree)/arch/$(SUBARCH)/$($(notdir $@)-dir)/$(notdir $@) $@
 
Index: linux-2.6.12/arch/um/sys-i386/Makefile
===================================================================
--- linux-2.6.12.orig/arch/um/sys-i386/Makefile	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/sys-i386/Makefile	2005-07-01 16:40:57.000000000 -0400
@@ -1,6 +1,6 @@
 obj-y = bitops.o bugs.o checksum.o delay.o fault.o ksyms.o ldt.o ptrace.o \
-	ptrace_user.o semaphore.o signal.o sigcontext.o syscalls.o sysrq.o \
-	sys_call_table.o
+	ptrace_user.o semaphore.o signal.o sigcontext.o stub.o stub_segv.o \
+	syscalls.o sysrq.o sys_call_table.o
 
 obj-$(CONFIG_HIGHMEM) += highmem.o
 obj-$(CONFIG_MODULES) += module.o
@@ -16,6 +16,14 @@ semaphore.c-dir = kernel
 highmem.c-dir = mm
 module.c-dir = kernel
 
+STUB_CFLAGS = -Wp,-MD,$(depfile) $(call unprofile,$(USER_CFLAGS))
+
+# _cflags works with kernel files, not with userspace ones, but c_flags does,
+# why ask why?
+$(obj)/stub_segv.o : c_flags = $(STUB_CFLAGS)
+
+$(obj)/stub.o : a_flags = $(STUB_CFLAGS)
+
 subdir- := util
 
 include arch/um/scripts/Makefile.unmap
Index: linux-2.6.12/arch/um/sys-i386/stub.S
===================================================================
--- linux-2.6.12.orig/arch/um/sys-i386/stub.S	2005-07-01 06:36:40.652577584 -0400
+++ linux-2.6.12/arch/um/sys-i386/stub.S	2005-07-01 16:40:57.000000000 -0400
@@ -0,0 +1,8 @@
+#include "uml-config.h"
+	
+	.globl syscall_stub
+.section .__syscall_stub, "x"
+syscall_stub:
+	int 	$0x80
+	mov	%eax, UML_CONFIG_STUB_DATA
+	int3
Index: linux-2.6.12/arch/um/sys-i386/stub_segv.c
===================================================================
--- linux-2.6.12.orig/arch/um/sys-i386/stub_segv.c	2005-07-01 06:36:40.652577584 -0400
+++ linux-2.6.12/arch/um/sys-i386/stub_segv.c	2005-07-01 16:40:57.000000000 -0400
@@ -0,0 +1,30 @@
+/* 
+ * Copyright (C) 2004 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL
+ */
+
+#include <signal.h>
+#include <asm/sigcontext.h>
+#include <asm/unistd.h>
+#include "uml-config.h"
+#include "sysdep/sigcontext.h"
+#include "sysdep/faultinfo.h"
+
+void __attribute__ ((__section__ (".__syscall_stub")))
+stub_segv_handler(int sig)
+{
+	struct sigcontext *sc = (struct sigcontext *) (&sig + 1);
+
+	GET_FAULTINFO_FROM_SC(*((struct faultinfo *) UML_CONFIG_STUB_DATA), 
+			      sc);
+
+	__asm__("movl %0, %%eax ; int $0x80": : "g" (__NR_getpid));
+	__asm__("movl %%eax, %%ebx ; movl %0, %%eax ; movl %1, %%ecx ;"
+		"int $0x80": : "g" (__NR_kill), "g" (SIGUSR1));
+	/* Pop the frame pointer and return address since we need to leave
+	 * the stack in its original form when we do the sigreturn here, by
+	 * hand.
+	 */
+	__asm__("popl %%eax ; popl %%eax ; popl %%eax ; movl %0, %%eax ; "
+		"int $0x80" : : "g" (__NR_sigreturn));
+}
Index: linux-2.6.12/arch/um/sys-x86_64/Makefile
===================================================================
--- linux-2.6.12.orig/arch/um/sys-x86_64/Makefile	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/arch/um/sys-x86_64/Makefile	2005-07-01 16:40:57.000000000 -0400
@@ -6,8 +6,8 @@
 
 #XXX: why into lib-y?
 lib-y = bitops.o bugs.o csum-partial.o delay.o fault.o mem.o memcpy.o \
-	ptrace.o ptrace_user.o semaphore.o sigcontext.o signal.o \
-	syscalls.o sysrq.o thunk.o syscall_table.o
+	ptrace.o ptrace_user.o semaphore.o sigcontext.o signal.o stub.o \
+	stub_segv.o syscalls.o syscall_table.o sysrq.o thunk.o
 
 obj-y := ksyms.o
 obj-$(CONFIG_MODULES) += module.o um_module.o
@@ -28,6 +28,14 @@ semaphore.c-dir = kernel
 thunk.S-dir = lib
 module.c-dir = kernel
 
+STUB_CFLAGS = -Wp,-MD,$(depfile) $(call unprofile,$(USER_CFLAGS))
+
+# _cflags works with kernel files, not with userspace ones, but c_flags does,
+# why ask why?
+$(obj)/stub_segv.o : c_flags = $(STUB_CFLAGS)
+
+$(obj)/stub.o : a_flags = $(STUB_CFLAGS)
+
 subdir- := util
 
 include arch/um/scripts/Makefile.unmap
Index: linux-2.6.12/arch/um/sys-x86_64/stub.S
===================================================================
--- linux-2.6.12.orig/arch/um/sys-x86_64/stub.S	2005-07-01 06:36:40.652577584 -0400
+++ linux-2.6.12/arch/um/sys-x86_64/stub.S	2005-07-01 16:40:57.000000000 -0400
@@ -0,0 +1,15 @@
+#include "uml-config.h"
+
+	.globl syscall_stub
+.section .__syscall_stub, "x"
+syscall_stub:
+	syscall
+	/* We don't have 64-bit constants, so this constructs the address
+	 * we need.
+	 */
+	movq	$(UML_CONFIG_STUB_DATA >> 32), %rbx
+	salq	$32, %rbx
+	movq	$(UML_CONFIG_STUB_DATA & 0xffffffff), %rcx
+	or	%rcx, %rbx
+	movq	%rax, (%rbx)
+	int3
Index: linux-2.6.12/arch/um/sys-x86_64/stub_segv.c
===================================================================
--- linux-2.6.12.orig/arch/um/sys-x86_64/stub_segv.c	2005-07-01 06:36:40.652577584 -0400
+++ linux-2.6.12/arch/um/sys-x86_64/stub_segv.c	2005-07-01 16:40:57.000000000 -0400
@@ -0,0 +1,31 @@
+/* 
+ * Copyright (C) 2004 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL
+ */
+
+#include <signal.h>
+#include <linux/compiler.h>
+#include <asm/unistd.h>
+#include "uml-config.h"
+#include "sysdep/sigcontext.h"
+#include "sysdep/faultinfo.h"
+
+void __attribute__ ((__section__ (".__syscall_stub")))
+stub_segv_handler(int sig)
+{
+	struct ucontext *uc;
+
+	__asm__("movq %%rdx, %0" : "=g" (uc) :);
+        GET_FAULTINFO_FROM_SC(*((struct faultinfo *) UML_CONFIG_STUB_DATA),
+                              &uc->uc_mcontext);
+
+	__asm__("movq %0, %%rax ; syscall": : "g" (__NR_getpid));
+	__asm__("movq %%rax, %%rdi ; movq %0, %%rax ; movq %1, %%rsi ;"
+		"syscall": : "g" (__NR_kill), "g" (SIGUSR1));
+	/* Two popqs to restore the stack to the state just before entering
+	 * the handler, one pops the return address, the other pops the frame
+	 * pointer.
+	 */
+	__asm__("popq %%rax ; popq %%rax ; movq %0, %%rax ; syscall" : : "g" 
+		(__NR_rt_sigreturn));
+}
Index: linux-2.6.12/include/asm-um/mmu_context.h
===================================================================
--- linux-2.6.12.orig/include/asm-um/mmu_context.h	2005-07-01 16:39:49.000000000 -0400
+++ linux-2.6.12/include/asm-um/mmu_context.h	2005-07-01 16:40:57.000000000 -0400
@@ -7,7 +7,9 @@
 #define __UM_MMU_CONTEXT_H
 
 #include "linux/sched.h"
+#include "linux/config.h"
 #include "choose-mode.h"
+#include "um_mmu.h"
 
 #define get_mmu_context(task) do ; while(0)
 #define activate_context(tsk) do ; while(0)
@@ -18,8 +20,6 @@ static inline void activate_mm(struct mm
 {
 }
 
-extern void switch_mm_skas(int mm_fd);
-
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, 
 			     struct task_struct *tsk)
 {
@@ -30,7 +30,7 @@ static inline void switch_mm(struct mm_s
 		cpu_set(cpu, next->cpu_vm_mask);
 		if(next != &init_mm)
 			CHOOSE_MODE((void) 0, 
-				    switch_mm_skas(next->context.skas.mm_fd));
+				    switch_mm_skas(&next->context.skas.id));
 	}
 }
 

