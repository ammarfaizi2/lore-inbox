Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbUCVEpR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 23:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUCVEpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 23:45:17 -0500
Received: from [198.247.175.96] ([198.247.175.96]:52132 "EHLO jethro.hick.org")
	by vger.kernel.org with ESMTP id S261693AbUCVEo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 23:44:28 -0500
Date: Sun, 21 Mar 2004 22:43:07 -0600 (CST)
From: Matt Miller <mmiller@hick.org>
To: linux-kernel@vger.kernel.org
cc: mmiller@hick.org
Subject: [PATCH] 2.6: mmap complement, fdmap
Message-ID: <Pine.LNX.4.58.0403212157110.31106@jethro.hick.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This patch (for 2.6.4) exposes a new system call (sys_fdmap) that allows
for mapping a virtual memory range to a file descriptor in the context of
a process.  This can be seen as the complement to mmap in that it provides
a mechanism to operate on a range of memory as if it were a file.  The
supported file operations are: read, write, llseek, and mmap.

The prototype for the system call is:

	int fdmap(void *vma, size_t len, int flags);

	or

	_syscall3(int,fdmap,void *,vma,size_t,len,int,flags);

	``flags'' can be one of O_RDONLY, O_WRONLY, or O_RDWR.

I have verified functionality on ia32 and sparc as these are the only
architectures I currently have some type of access to.  To test, start the
kernel configuration process and go under File systems/Pseudo filesystems
and select this option:

	[*] Virtual memory file descriptor mapping support

Please let me know about any and all suggestions/bugs/flames.  I tried to
be as thorough as possible but do suspect that I've missed some things.
I'm looking forward to hearing feedback.


Matt

-------

Patch details:

 Target kernel release   : 2.6.4
 Target subsystem        : fs
 Number of new files     : 1
 Number of modified files: 33
 Total file changes      : 34

Patched file list:

 arch/alpha/kernel/systbls.S        |    4
 arch/arm/kernel/calls.S            |    5
 arch/i386/kernel/entry.S           |    5
 arch/ia64/kernel/entry.S           |    4
 arch/m68k/kernel/entry.S           |    5
 arch/mips/kernel/scall32-o32.S     |    5
 arch/mips/kernel/scall64-64.S      |    5
 arch/mips/kernel/scall64-n32.S     |    5
 arch/mips/kernel/scall64-o32.S     |    5
 arch/parisc/kernel/syscall_table.S |    6
 arch/ppc/kernel/misc.S             |    5
 arch/ppc64/kernel/misc.S           |    5
 arch/s390/kernel/syscalls.S        |    5
 arch/sh/kernel/entry.S             |    5
 arch/sparc/kernel/systbls.S        |    8
 arch/sparc64/kernel/systbls.S      |   16 +
 arch/um/kernel/sys_call_table.c    |    5
 arch/v850/kernel/entry.S           |    6
 fs/Kconfig                         |    8
 fs/Makefile                        |    2
 fs/fdmap.c                         |  517
+++++++++++++++++++++++++++++++++++++
 include/asm-alpha/unistd.h         |    2
 include/asm-arm/unistd.h           |    1
 include/asm-i386/unistd.h          |    3
 include/asm-ia64/unistd.h          |    3
 include/asm-m68k/unistd.h          |    3
 include/asm-mips/unistd.h          |   15 -
 include/asm-parisc/unistd.h        |    3
 include/asm-ppc/unistd.h           |    3
 include/asm-ppc64/unistd.h         |    3
 include/asm-s390/unistd.h          |    5
 include/asm-sparc/unistd.h         |    2
 include/asm-sparc64/unistd.h       |    2
 include/asm-v850/unistd.h          |    1
 34 files changed, 657 insertions(+), 20 deletions(-)

Patch contents:

-- CUT HERE --

diff -X dontdiff -uprN linux-2.6.4/arch/alpha/kernel/systbls.S linux-2.6.4-fdmap/arch/alpha/kernel/systbls.S
--- linux-2.6.4/arch/alpha/kernel/systbls.S	Wed Mar 10 20:55:35 2004
+++ linux-2.6.4-fdmap/arch/alpha/kernel/systbls.S	Sun Mar 21 08:57:18 2004
@@ -292,7 +292,11 @@ sys_call_table:
 	.quad alpha_ni_syscall
 	.quad alpha_ni_syscall
 	.quad alpha_ni_syscall
+#ifdef CONFIG_FDMAP
+	.quad sys_fdmap
+#else
 	.quad alpha_ni_syscall
+#endif
 	.quad alpha_ni_syscall			/* 275 */
 	.quad alpha_ni_syscall
 	.quad alpha_ni_syscall
diff -X dontdiff -uprN linux-2.6.4/arch/arm/kernel/calls.S linux-2.6.4-fdmap/arch/arm/kernel/calls.S
--- linux-2.6.4/arch/arm/kernel/calls.S	Wed Mar 10 20:55:55 2004
+++ linux-2.6.4-fdmap/arch/arm/kernel/calls.S	Sun Mar 21 08:57:40 2004
@@ -288,6 +288,11 @@ __syscall_start:
 		.long	sys_pciconfig_iobase
 		.long	sys_pciconfig_read
 		.long	sys_pciconfig_write
+#ifdef CONFIG_FDMAP
+		.long sys_fdmap
+#else
+		.long sys_ni_syscall
+#endif
 __syscall_end:

 		.rept	NR_syscalls - (__syscall_end - __syscall_start) / 4
diff -X dontdiff -uprN linux-2.6.4/arch/i386/kernel/entry.S linux-2.6.4-fdmap/arch/i386/kernel/entry.S
--- linux-2.6.4/arch/i386/kernel/entry.S	Wed Mar 10 20:55:24 2004
+++ linux-2.6.4-fdmap/arch/i386/kernel/entry.S	Sun Mar 21 08:58:38 2004
@@ -882,5 +882,10 @@ ENTRY(sys_call_table)
 	.long sys_utimes
  	.long sys_fadvise64_64
 	.long sys_ni_syscall	/* sys_vserver */
+#ifdef CONFIG_FDMAP
+	.long sys_fdmap /* 274 */
+#else
+	.long sys_ni_syscall
+#endif

 syscall_table_size=(.-sys_call_table)
diff -X dontdiff -uprN linux-2.6.4/arch/ia64/kernel/entry.S linux-2.6.4-fdmap/arch/ia64/kernel/entry.S
--- linux-2.6.4/arch/ia64/kernel/entry.S	Wed Mar 10 20:55:24 2004
+++ linux-2.6.4-fdmap/arch/ia64/kernel/entry.S	Sun Mar 21 08:58:57 2004
@@ -1501,7 +1501,11 @@ sys_call_table:
 	data8 sys_clock_nanosleep
 	data8 sys_fstatfs64
 	data8 sys_statfs64
+#ifdef CONFIG_FDMAP
+	data8 sys_fdmap
+#else
 	data8 sys_ni_syscall
+#endif
 	data8 sys_ni_syscall			// 1260
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
diff -X dontdiff -uprN linux-2.6.4/arch/m68k/kernel/entry.S linux-2.6.4-fdmap/arch/m68k/kernel/entry.S
--- linux-2.6.4/arch/m68k/kernel/entry.S	Wed Mar 10 20:55:21 2004
+++ linux-2.6.4-fdmap/arch/m68k/kernel/entry.S	Sun Mar 21 08:59:17 2004
@@ -663,3 +663,8 @@ sys_call_table:
 	.long sys_lremovexattr
 	.long sys_fremovexattr
 	.long sys_futex		/* 235 */
+#ifdef CONFIG_FDMAP
+	.long sys_fdmap
+#else
+	.long sys_ni_syscall
+#endif
diff -X dontdiff -uprN linux-2.6.4/arch/mips/kernel/scall32-o32.S linux-2.6.4-fdmap/arch/mips/kernel/scall32-o32.S
--- linux-2.6.4/arch/mips/kernel/scall32-o32.S	Wed Mar 10 20:55:22 2004
+++ linux-2.6.4-fdmap/arch/mips/kernel/scall32-o32.S	Sun Mar 21 08:59:43 2004
@@ -614,6 +614,11 @@ out:	jr	ra
 	sys	sys_clock_nanosleep	4	/* 4265 */
 	sys	sys_tgkill		3
 	sys	sys_utimes		2
+#ifdef CONFIG_FDMAP
+	sys	sys_fdmap		3
+#else
+	sys	sys_ni_syscall		0
+#endif

 	.endm

diff -X dontdiff -uprN linux-2.6.4/arch/mips/kernel/scall64-64.S linux-2.6.4-fdmap/arch/mips/kernel/scall64-64.S
--- linux-2.6.4/arch/mips/kernel/scall64-64.S	Wed Mar 10 20:55:36 2004
+++ linux-2.6.4-fdmap/arch/mips/kernel/scall64-64.S	Sun Mar 21 09:07:05 2004
@@ -432,3 +432,8 @@ sys_call_table:
 	PTR	sys_clock_nanosleep
 	PTR	sys_tgkill			/* 5225 */
 	PTR	sys_utimes
+#ifdef CONFIG_FDMAP
+	PTR	sys_fdmap
+#else
+	PTR	sys_ni_syscall
+#endif
diff -X dontdiff -uprN linux-2.6.4/arch/mips/kernel/scall64-n32.S linux-2.6.4-fdmap/arch/mips/kernel/scall64-n32.S
--- linux-2.6.4/arch/mips/kernel/scall64-n32.S	Wed Mar 10 20:55:44 2004
+++ linux-2.6.4-fdmap/arch/mips/kernel/scall64-n32.S	Sun Mar 21 09:07:17 2004
@@ -341,3 +341,8 @@ EXPORT(sysn32_call_table)
 	PTR	sys_clock_nanosleep
 	PTR	sys_tgkill
 	PTR	compat_sys_utimes		/* 6230 */
+#ifdef CONFIG_FDMAP
+	PTR	sys_fdmap
+#else
+	PTR	sys_ni_syscall
+#endif
diff -X dontdiff -uprN linux-2.6.4/arch/mips/kernel/scall64-o32.S linux-2.6.4-fdmap/arch/mips/kernel/scall64-o32.S
--- linux-2.6.4/arch/mips/kernel/scall64-o32.S	Wed Mar 10 20:55:20 2004
+++ linux-2.6.4-fdmap/arch/mips/kernel/scall64-o32.S	Sun Mar 21 09:07:29 2004
@@ -523,6 +523,11 @@ out:	jr	ra
 	sys	sys_clock_nanosleep	4		/* 4265 */
 	sys	sys_tgkill		3
 	sys	compat_sys_utimes	2
+#ifdef CONFIG_FDMAP
+	sys	sys_fdmap		3
+#else
+	sys	sys_ni_syscall		0
+#endif

 	.endm

diff -X dontdiff -uprN linux-2.6.4/arch/parisc/kernel/syscall_table.S linux-2.6.4-fdmap/arch/parisc/kernel/syscall_table.S
--- linux-2.6.4/arch/parisc/kernel/syscall_table.S	Wed Mar 10 20:55:21 2004
+++ linux-2.6.4-fdmap/arch/parisc/kernel/syscall_table.S	Sun Mar 21 09:00:08 2004
@@ -334,3 +334,9 @@
 	ENTRY_SAME(epoll_ctl)		/* 225 */
 	ENTRY_SAME(epoll_wait)
  	ENTRY_SAME(remap_file_pages)
+	ENTRY_SMAE(ni_syscall)
+#ifdef CONFIG_FDMAP
+	ENTRY_SAME(fdmap)
+#else
+	ENTRY_SAME(ni_syscall)
+#endif
diff -X dontdiff -uprN linux-2.6.4/arch/ppc/kernel/misc.S linux-2.6.4-fdmap/arch/ppc/kernel/misc.S
--- linux-2.6.4/arch/ppc/kernel/misc.S	Wed Mar 10 20:55:44 2004
+++ linux-2.6.4-fdmap/arch/ppc/kernel/misc.S	Sun Mar 21 09:00:20 2004
@@ -1380,3 +1380,8 @@ _GLOBAL(sys_call_table)
 	.long sys_fstatfs64
 	.long ppc_fadvise64_64
 	.long sys_ni_syscall	/* 255 - rtas (used on ppc64) */
+#ifdef CONFIG_FDMAP
+	.long sys_fdmap
+#else
+	.long sys_ni_syscall
+#endif
diff -X dontdiff -uprN linux-2.6.4/arch/ppc64/kernel/misc.S linux-2.6.4-fdmap/arch/ppc64/kernel/misc.S
--- linux-2.6.4/arch/ppc64/kernel/misc.S	Wed Mar 10 20:55:44 2004
+++ linux-2.6.4-fdmap/arch/ppc64/kernel/misc.S	Sun Mar 21 09:00:33 2004
@@ -1116,3 +1116,8 @@ _GLOBAL(sys_call_table)
 	.llong .sys_fstatfs64
 	.llong .sys_ni_syscall		/* 32bit only fadvise64_64 */
 	.llong .ppc_rtas		/* 255 */
+#ifdef CONFIG_FDMAP
+	.llong .sys_fdmap
+#else
+	.llong .sys_ni_syscall
+#endif
diff -X dontdiff -uprN linux-2.6.4/arch/s390/kernel/syscalls.S linux-2.6.4-fdmap/arch/s390/kernel/syscalls.S
--- linux-2.6.4/arch/s390/kernel/syscalls.S	Wed Mar 10 20:55:22 2004
+++ linux-2.6.4-fdmap/arch/s390/kernel/syscalls.S	Sun Mar 21 09:01:02 2004
@@ -273,3 +273,8 @@ SYSCALL(sys_clock_getres,sys_clock_getre
 SYSCALL(sys_clock_nanosleep,sys_clock_nanosleep,sys32_clock_nanosleep_wrapper)
 NI_SYSCALL							/* reserved for vserver */
 SYSCALL(s390_fadvise64_64,sys_ni_syscall,sys32_fadvise64_64_wrapper)
+#ifdef CONFIG_FDMAP
+SYSCALL(sys_fdmap,sys_fdmap,sys_fdmap) /* 265 */
+#else
+NI_SYSCALL
+#endif
diff -X dontdiff -uprN linux-2.6.4/arch/sh/kernel/entry.S linux-2.6.4-fdmap/arch/sh/kernel/entry.S
--- linux-2.6.4/arch/sh/kernel/entry.S	Wed Mar 10 20:55:25 2004
+++ linux-2.6.4-fdmap/arch/sh/kernel/entry.S	Sun Mar 21 09:01:13 2004
@@ -1129,6 +1129,11 @@ ENTRY(sys_call_table)
 	.long sys_utimes
  	.long sys_fadvise64_64_wrapper
 	.long sys_ni_syscall	/* Reserved for vserver */
+#ifdef CONFIG_FDMAP
+	.long sys_fdmap
+#else
+	.long sys_ni_syscall
+#endif

 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
diff -X dontdiff -uprN linux-2.6.4/arch/sparc/kernel/systbls.S linux-2.6.4-fdmap/arch/sparc/kernel/systbls.S
--- linux-2.6.4/arch/sparc/kernel/systbls.S	Wed Mar 10 20:55:27 2004
+++ linux-2.6.4-fdmap/arch/sparc/kernel/systbls.S	Sun Mar 21 09:01:34 2004
@@ -61,7 +61,13 @@ sys_call_table:
 /*200*/	.long sys_ssetmask, sys_sigsuspend, sys_newlstat, sys_uselib, old_readdir
 /*205*/	.long sys_readahead, sys_socketcall, sys_syslog, sys_lookup_dcookie, sys_fadvise64
 /*210*/	.long sys_fadvise64_64, sys_tgkill, sys_waitpid, sys_swapoff, sys_sysinfo
-/*215*/	.long sys_ipc, sys_sigreturn, sys_clone, sys_nis_syscall, sys_adjtimex
+/*215*/	.long sys_ipc, sys_sigreturn, sys_clone,
+#ifdef CONFIG_MAP
+/*218*/	.long sys_fdmap
+#else
+/*218*/	.long sys_ni_syscall
+#endif
+/*219*/ .long sys_adjtimex
 /*220*/	.long sys_sigprocmask, sys_ni_syscall, sys_delete_module, sys_ni_syscall, sys_getpgid
 /*225*/	.long sys_bdflush, sys_sysfs, sys_nis_syscall, sys_setfsuid16, sys_setfsgid16
 /*230*/	.long sys_select, sys_time, sys_nis_syscall, sys_stime, sys_statfs64
diff -X dontdiff -uprN linux-2.6.4/arch/sparc64/kernel/systbls.S linux-2.6.4-fdmap/arch/sparc64/kernel/systbls.S
--- linux-2.6.4/arch/sparc64/kernel/systbls.S	Wed Mar 10 20:55:26 2004
+++ linux-2.6.4-fdmap/arch/sparc64/kernel/systbls.S	Sun Mar 21 09:01:59 2004
@@ -62,7 +62,13 @@ sys_call_table32:
 /*200*/	.word sys_ssetmask, sys_sigsuspend, compat_sys_newlstat, sys_uselib, old32_readdir
 	.word sys32_readahead, sys32_socketcall, sys_syslog, sys32_lookup_dcookie, sys32_fadvise64
 /*210*/	.word sys32_fadvise64_64, sys_tgkill, sys_waitpid, sys_swapoff, sys32_sysinfo
-	.word sys32_ipc, sys32_sigreturn, sys_clone, sys_nis_syscall, sys32_adjtimex
+/*215*/	.word sys32_ipc, sys32_sigreturn, sys_clone
+#ifdef CONFIG_FDMAP
+/*218*/  .word sys_fdmap,
+#else
+/*218*/	.word sys_ni_syscall
+#endif
+/*219*/  .word sys32_adjtimex
 /*220*/	.word compat_sys_sigprocmask, sys_ni_syscall, sys32_delete_module, sys_ni_syscall, sys_getpgid
 	.word sys32_bdflush, sys32_sysfs, sys_nis_syscall, sys32_setfsuid16, sys32_setfsgid16
 /*230*/	.word sys32_select, sys_time, sys_nis_syscall, sys_stime, compat_statfs64
@@ -124,7 +130,13 @@ sys_call_table:
 /*200*/	.word sys_ssetmask, sys_nis_syscall, sys_newlstat, sys_uselib, sys_nis_syscall
 	.word sys_readahead, sys_socketcall, sys_syslog, sys_lookup_dcookie, sys_fadvise64
 /*210*/	.word sys_fadvise64_64, sys_tgkill, sys_waitpid, sys_swapoff, sys_sysinfo
-	.word sys_ipc, sys_nis_syscall, sys_clone, sys_nis_syscall, sys_adjtimex
+	.word sys_ipc, sys_nis_syscall, sys_clone
+#ifdef CONFIG_FDMAP
+/*218*/  .word sys_fdmap
+#else
+/*218*/	.word sys_ni_syscall
+#endif
+/*219*/  .word sys_adjtimex
 /*220*/	.word sys_nis_syscall, sys_ni_syscall, sys_delete_module, sys_ni_syscall, sys_getpgid
 	.word sys_bdflush, sys_sysfs, sys_nis_syscall, sys_setfsuid, sys_setfsgid
 /*230*/	.word sys_select, sys_nis_syscall, sys_nis_syscall, sys_stime, sys_statfs64
diff -X dontdiff -uprN linux-2.6.4/arch/um/kernel/sys_call_table.c linux-2.6.4-fdmap/arch/um/kernel/sys_call_table.c
--- linux-2.6.4/arch/um/kernel/sys_call_table.c	Wed Mar 10 20:55:43 2004
+++ linux-2.6.4-fdmap/arch/um/kernel/sys_call_table.c	Sun Mar 21 08:56:45 2004
@@ -489,6 +489,11 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_epoll_wait ] = sys_epoll_wait,
         [ __NR_remap_file_pages ] = sys_remap_file_pages,
         [ __NR_set_tid_address ] = sys_set_tid_address,
+#ifdef __NR_fdmap
+	[ __NR_fdmap ] = sys_fdmap,
+#else
+	[ __NR_fdmap ] = sys_ni_syscall,
+#endif

 	ARCH_SYSCALLS
 	[ LAST_SYSCALL + 1 ... NR_syscalls ] =
diff -X dontdiff -uprN linux-2.6.4/arch/v850/kernel/entry.S linux-2.6.4-fdmap/arch/v850/kernel/entry.S
--- linux-2.6.4/arch/v850/kernel/entry.S	Wed Mar 10 20:55:44 2004
+++ linux-2.6.4-fdmap/arch/v850/kernel/entry.S	Sun Mar 21 09:02:25 2004
@@ -1117,5 +1117,11 @@ C_DATA(sys_call_table):
 	.long CSYM(sys_pivot_root)	// 200
 	.long CSYM(sys_gettid)
 	.long CSYM(sys_tkill)
+#ifdef CONFIG_FDMAP
+	.long CSYM(sys_fdmap)
+#else
+	.long CSYM(sys_ni_syscall)
+#endif
+
 sys_call_table_end:
 C_END(sys_call_table)
diff -X dontdiff -uprN linux-2.6.4/fs/Kconfig linux-2.6.4-fdmap/fs/Kconfig
--- linux-2.6.4/fs/Kconfig	Wed Mar 10 20:55:29 2004
+++ linux-2.6.4-fdmap/fs/Kconfig	Sat Mar 20 15:21:41 2004
@@ -864,6 +864,14 @@ config TMPFS

 	  See <file:Documentation/filesystems/tmpfs.txt> for details.

+config FDMAP
+	bool "Virtual memory file descriptor mapping support"
+	help
+		Fdmap allows for accessing a range of memory inside a given process
+		as if it were a file on disk.  This can be seen as the counterpart
+		to mmap, simply, fdmap allows for opening a range of memory that
+		can be operated on by way of read, write, lseek, et al.
+
 config HUGETLBFS
 	bool "HugeTLB file system support"
 	depends X86 || IA64 || PPC64 || SPARC64 || X86_64 || BROKEN
diff -X dontdiff -uprN linux-2.6.4/fs/Makefile linux-2.6.4-fdmap/fs/Makefile
--- linux-2.6.4/fs/Makefile	Wed Mar 10 20:55:29 2004
+++ linux-2.6.4-fdmap/fs/Makefile	Sat Mar 20 15:22:17 2004
@@ -44,6 +44,8 @@ obj-y				+= devpts/

 obj-$(CONFIG_PROFILING)		+= dcookies.o

+obj-$(CONFIG_FDMAP) += fdmap.o
+
 # Do not add any filesystems before this line
 obj-$(CONFIG_REISERFS_FS)	+= reiserfs/
 obj-$(CONFIG_EXT3_FS)		+= ext3/ # Before ext2 so root fs can be ext3
diff -X dontdiff -uprN linux-2.6.4/fs/fdmap.c linux-2.6.4-fdmap/fs/fdmap.c
--- linux-2.6.4/fs/fdmap.c	Wed Dec 31 18:00:00 1969
+++ linux-2.6.4-fdmap/fs/fdmap.c	Sun Mar 21 04:08:22 2004
@@ -0,0 +1,517 @@
+/*
+ * purpose
+ *
+ *    Map process memory ranges to virtual file descriptors.  This can be
+ *    thought of as being the opposite of mmap, simply, instead of mapping
+ *    a file's contents to a memory range, fdmap maps a memory range to
+ *    a virtual file.  This allows one to read, write, seek, and even
+ *    mmap the virtual file's contents as if it were a real file on disk.
+ *
+ * interface
+ *
+ *    fdmap exposes a new system call identifier.  The system call takes
+ *    arguments as the following prototype conveys:
+ *
+ *       int fdmap(void *addr, size_t len, int flags);
+ *
+ *    ``flags'' can be one of O_RDONLY, O_WRONLY, or O_RDWR.
+ *
+ *    syscall number
+ *
+ *       alpha, arm, ia32, sh: 274
+ *       sparc, sparc64: 218
+ *       ia64: 1259
+ *       m68k: 236
+ *       mips: 32b=4268 64b=5227 64be32=6231
+ *       parisc: 229
+ *       ppc, ppc64: 256
+ *       s390: 265
+ *       v850: 203
+ *
+ * based on
+ *
+ *    The underlying virtual filesystem code was adapted from sockfs.
+ *
+ * Matt Miller
+ * mmiller@hick.org
+ * 3/20/04
+ */
+#include <linux/string.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/utime.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/mount.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/cache.h>
+#include <asm/uaccess.h>
+
+typedef struct {
+	unsigned long vma;
+	size_t        vma_len;
+} fdmap_context;
+
+typedef struct {
+	fdmap_context fdmap;
+	struct inode  vfs_inode;
+} fdmap_alloc;
+
+static struct super_block *fdmap_get_sb(struct file_system_type *fs_type,
+		int flags, const char *dev, void *data);
+
+static void fdmap_init_once(void *ctx, kmem_cache_t *cachep,
+			    unsigned long flags);
+static struct inode *fdmap_alloc_inode(struct super_block *sb);
+static void fdmap_destroy_inode(struct inode *inode);
+
+static int fdmap_delete_dentry(struct dentry *dentry);
+
+static struct page* fdmap_nopage(struct vm_area_struct *area,
+		unsigned long address, int *type);
+
+static int fdmap_open_mem(unsigned long addr, size_t len, int flags);
+
+static loff_t fdmap_llseek(struct file *f, loff_t off, int whence);
+static ssize_t fdmap_read(struct file *f, char *buf, size_t size, loff_t *off);
+static ssize_t fdmap_write(struct file *f, const char *buf, size_t size,
+		loff_t *off);
+static int fdmap_mmap(struct file *f, struct vm_area_struct *vma);
+
+static unsigned int fdmap_copy_from_user_to_user(unsigned long base_dst,
+		unsigned long base_src,
+		unsigned int total);
+static fdmap_context *fdmap_get_context(struct inode *inode);
+
+static struct super_operations fdmap_super_ops =
+{
+	.alloc_inode   = fdmap_alloc_inode,
+	.destroy_inode = fdmap_destroy_inode,
+};
+
+static struct file_system_type fdmap_fs_type =
+{
+	.name          = "fdmapfs",
+	.get_sb        = fdmap_get_sb,
+	.kill_sb       = kill_anon_super,
+};
+
+static struct dentry_operations fdmap_dentry_ops =
+{
+	.d_delete      = fdmap_delete_dentry,
+};
+
+static struct vm_operations_struct fdmap_vm_ops =
+{
+	.nopage        = fdmap_nopage,
+};
+
+static struct file_operations fdmap_file_ops =
+{
+	.llseek        = fdmap_llseek,
+	.read          = fdmap_read,
+	.write         = fdmap_write,
+	.mmap          = fdmap_mmap,
+};
+
+#define FDMAP_MAGIC 0x46444d41 // FDMA
+
+static kmem_cache_t *fdmap_inode_cachep;
+static struct vfsmount *fdmap_mnt;
+static atomic_t fdmap_initialized = { 1 };
+
+/*
+ * register and mount the fdmapfs
+ */
+static void fdmap_initialize(void)
+{
+	fdmap_inode_cachep = kmem_cache_create("fdmap_inode_cache",
+			sizeof(fdmap_alloc), 0,
+			SLAB_HWCACHE_ALIGN | SLAB_RECLAIM_ACCOUNT,
+			fdmap_init_once, NULL);
+
+	if (!fdmap_inode_cachep) {
+		printk("fdmap: failed to allocate cache.\n");
+		goto out;
+	}
+
+	register_filesystem(&fdmap_fs_type);
+
+	if (!(fdmap_mnt = kern_mount(&fdmap_fs_type))) {
+		printk("fdmap: failed to mount fdmapfs.\n");
+	}
+
+out:
+}
+
+static struct super_block *fdmap_get_sb(struct file_system_type *fs_type,
+		int flags, const char *dev, void *data)
+{
+	return get_sb_pseudo(fs_type, "fdmap:", &fdmap_super_ops, FDMAP_MAGIC);
+}
+
+static void fdmap_init_once(void *ctx, kmem_cache_t *cachep,
+		unsigned long flags)
+{
+	fdmap_alloc *fma = (fdmap_alloc *)ctx;
+
+	if ((flags & SLAB_CTOR_CONSTRUCTOR))
+		inode_init_once(&fma->vfs_inode);
+}
+
+static struct inode *fdmap_alloc_inode(struct super_block *sb)
+{
+	fdmap_alloc *fma = (fdmap_alloc *)kmem_cache_alloc(fdmap_inode_cachep,
+			SLAB_KERNEL);
+
+	if (!fma)
+		return NULL;
+
+	return &fma->vfs_inode;
+}
+
+static void fdmap_destroy_inode(struct inode *inode)
+{
+	kmem_cache_free(fdmap_inode_cachep,
+			container_of(inode, fdmap_alloc, vfs_inode));
+}
+
+static int fdmap_delete_dentry(struct dentry *dentry)
+{
+	return 1;
+}
+
+/*
+ * used in conjunction with mmap of the virtual file, fdmap_nopage will
+ * copy the contents of the mapped memory range at the offset
+ * relative to the address being requested
+ */
+static struct page* fdmap_nopage(struct vm_area_struct *area,
+		unsigned long addr, int *type)
+{
+	struct page *page = alloc_page(GFP_USER);
+	struct file *f = area->vm_file;
+	fdmap_context *fmc = (fdmap_context *)f->private_data;
+	unsigned long offset;
+	struct page *fpage;
+	void *saddr, *daddr;
+	int len = PAGE_SIZE;
+
+	addr   &= PAGE_MASK;
+	offset  = addr - area->vm_start + (area->vm_pgoff << PAGE_SHIFT);
+
+	if (addr + PAGE_SIZE > area->vm_end)
+		len = area->vm_end - addr;
+
+	if (get_user_pages(current, current->mm, fmc->vma + offset, 1, 0, 0,
+			&fpage, NULL) < 0)
+		return NULL;
+
+	daddr = kmap(page);
+	saddr = kmap(fpage);
+
+	memcpy(daddr, saddr, len);
+
+	kunmap(fpage);
+	kunmap(page);
+
+	if (type)
+		*type = VM_FAULT_MINOR;
+
+	set_page_dirty(page);
+
+	return page;
+}
+
+/*
+ * entry point for the fdmap syscall
+ */
+asmlinkage int sys_fdmap(void *vma, size_t len, int flags)
+{
+	unsigned long addr = (unsigned long)vma;
+	int fd = -EINVAL;
+
+	if ((atomic_read(&fdmap_initialized) == 1) &&
+			(atomic_dec_and_test(&fdmap_initialized)))
+		fdmap_initialize();
+
+	if ((!len) ||
+			((addr + len) > TASK_SIZE) ||
+			((addr + len) < addr)) {
+		fd = -EINVAL;
+		goto out;
+	}
+
+	fd = fdmap_open_mem(addr, len, flags);
+
+out:
+	return fd;
+}
+
+/*
+ * open a virtual file and corresponding file descriptor that is tied
+ * to the passed in memory range.
+ */
+static int fdmap_open_mem(unsigned long addr, size_t len, int flags)
+{
+	struct inode *inode = NULL;
+	fdmap_context *fmc = NULL;
+	struct file *file = NULL;
+	struct qstr this;
+	int fd = 0,
+	    res = -ENFILE;
+	char name[32];
+
+	flags &= (O_RDONLY | O_WRONLY | O_RDWR);
+
+	if (flags & O_RDONLY)
+	   flags &= ~O_WRONLY;
+	if (flags & O_WRONLY)
+	   flags &= ~O_RDONLY;
+
+	if (!(inode = new_inode(fdmap_mnt->mnt_sb)))
+		goto out;
+
+	inode->i_mode = S_IRWXUGO;
+	inode->i_uid  = current->fsuid;
+	inode->i_gid  = current->fsgid;
+	inode->i_size = (loff_t)len;
+
+	fmc = fdmap_get_context(inode);
+
+	if ((fd = get_unused_fd()) < 0)
+		goto cleanup;
+
+	if (!(file = get_empty_filp()))
+		goto cleanup;
+
+	sprintf(name, "[%lu]",  inode->i_ino);
+
+	this.name = name;
+	this.len  = strlen(name);
+	this.hash = inode->i_ino;
+
+	file->f_dentry = d_alloc(fdmap_mnt->mnt_sb->s_root, &this);
+
+	if (!file->f_dentry) {
+		res = -ENOMEM;
+		goto cleanup;
+	}
+
+	file->f_dentry->d_op = &fdmap_dentry_ops;
+
+	d_add(file->f_dentry, inode);
+
+	file->f_vfsmnt     = mntget(fdmap_mnt);
+	file->f_mapping    = file->f_dentry->d_inode->i_mapping;
+	file->f_op         = inode->i_fop = &fdmap_file_ops;
+	file->f_mode       = 3;
+	file->f_flags      = flags;
+	file->f_pos        = 0;
+	file->private_data = fmc;
+
+	fd_install(fd, file);
+
+	fmc->vma     = addr;
+	fmc->vma_len = len;
+
+	res = fd;
+
+	goto out;
+
+cleanup:
+	if (file)
+		put_filp(file);
+
+	if (fd >= 0)
+		put_unused_fd(fd);
+out:
+	return res;
+}
+
+static loff_t fdmap_llseek(struct file *f, loff_t off, int whence)
+{
+	fdmap_context *fmc = (fdmap_context *)f->private_data;
+	int res = -EINVAL;
+
+	if (!fmc)
+		goto out;
+
+	switch (whence) {
+
+		case 0:
+			if (off < 0 || off > fmc->vma_len)
+				break;
+
+			f->f_pos = off;
+			res = 0;
+			break;
+		case 1:
+			if ((off < 0) && (f->f_pos + off < fmc->vma_len))
+				break;
+			if ((off >= 0) && (f->f_pos + off >= fmc->vma_len))
+				break;
+
+			f->f_pos += off;
+			res = 0;
+			break;
+		case 2:
+			if (off > 0)
+				break;
+			if (fmc->vma_len + off < 0)
+				break;
+
+			f->f_pos = fmc->vma_len + off;
+			res = 0;
+			break;
+		default:
+			break;
+	}
+
+out:
+	return (res < 0) ? res : f->f_pos;
+}
+
+static ssize_t fdmap_read(struct file *f, char *buf, size_t size, loff_t *off)
+{
+	fdmap_context *fmc = (fdmap_context *)f->private_data;
+	ssize_t total = -EINVAL;
+
+	if ((!fmc) ||
+	    (!buf) ||
+	    ((unsigned long)(buf + size) > TASK_SIZE) ||
+	    ((unsigned long)(buf + size) < (unsigned long)buf))
+		goto out;
+
+
+	if (f->f_flags == O_WRONLY) {
+		total = -EACCES;
+		goto out;
+	}
+
+	total = (size > fmc->vma_len - f->f_pos) ? fmc->vma_len - f->f_pos
+			: size;
+
+	if (total)
+		total = fdmap_copy_from_user_to_user((unsigned long)buf,
+				fmc->vma + f->f_pos, (unsigned int)total);
+
+
+	f->f_pos += total;
+
+	if (off)
+		*off = f->f_pos;
+
+out:
+	return total;
+}
+
+static ssize_t fdmap_write(struct file *f, const char *buf, size_t size,
+		loff_t *off)
+{
+	fdmap_context *fmc = (fdmap_context *)f->private_data;
+	ssize_t total = -EINVAL;
+
+	if ((!fmc) ||
+	    (!buf) ||
+	    ((unsigned long)(buf + size) > TASK_SIZE) ||
+	    ((unsigned long)(buf + size) < (unsigned long)buf))
+		goto out;
+
+	if (f->f_flags == O_RDONLY) {
+		total = -EACCES;
+		goto out;
+	}
+
+	total = (size > fmc->vma_len - f->f_pos) ? fmc->vma_len - f->f_pos
+			: size;
+
+	if (total)
+		total = fdmap_copy_from_user_to_user(fmc->vma + f->f_pos,
+				(unsigned long)buf, (unsigned int)total);
+
+	f->f_pos += total;
+
+	if (off)
+		*off = f->f_pos;
+
+out:
+	return total;
+}
+
+static int fdmap_mmap(struct file *f, struct vm_area_struct *vma)
+{
+	fdmap_context *fmc = (fdmap_context *)f->private_data;
+
+	if (vma->vm_end - (vma->vm_start + vma->vm_pgoff) > fmc->vma_len)
+		return -EFBIG;
+
+	vma->vm_ops = &fdmap_vm_ops;
+
+	return 0;
+}
+
+/*
+ * copy memory from one user address to another user address for a given
+ * number of bytes
+ */
+static unsigned int fdmap_copy_from_user_to_user(unsigned long base_dst,
+		unsigned long base_src, unsigned int total)
+{
+	unsigned int curr = 0;
+
+	while (curr < total) {
+
+		unsigned long src = (unsigned long)(base_src + curr);
+		unsigned long src_offset = src % PAGE_SIZE;
+		unsigned long dst = (unsigned long)(base_dst + curr);
+		unsigned long dst_offset = dst % PAGE_SIZE;
+		unsigned long len = total - curr;
+		struct page *spage, *dpage;
+		void *skaddr, *dkaddr;
+
+		if (len > PAGE_SIZE)
+			len = PAGE_SIZE;
+
+		down_read(&current->mm->mmap_sem);
+
+		spage = dpage = NULL;
+
+		if ((get_user_pages(current, current->mm, src, 1, 0, 0, &spage,
+				NULL) < 0) ||
+		    (get_user_pages(current, current->mm, dst, 1, 1, 0, &dpage,
+				NULL) < 0)) {
+
+			if (spage)
+				put_page(spage);
+
+			up_read(&current->mm->mmap_sem);
+			break;
+		}
+
+		skaddr = kmap_atomic(spage, KM_USER0);
+		dkaddr = kmap_atomic(dpage, KM_USER0);
+
+		memcpy(dkaddr + dst_offset, skaddr + src_offset, len);
+
+		kunmap_atomic(dkaddr, KM_USER0);
+		kunmap_atomic(skaddr, KM_USER0);
+
+		set_page_dirty_lock(dpage);
+
+		put_page(dpage);
+		put_page(spage);
+
+		up_read(&current->mm->mmap_sem);
+
+		curr += len;
+	}
+
+	return curr;
+}
+
+static fdmap_context *fdmap_get_context(struct inode *inode)
+{
+	return &container_of(inode, fdmap_alloc, vfs_inode)->fdmap;
+}
diff -X dontdiff -uprN linux-2.6.4/include/asm-alpha/unistd.h linux-2.6.4-fdmap/include/asm-alpha/unistd.h
--- linux-2.6.4/include/asm-alpha/unistd.h	Wed Mar 10 20:55:26 2004
+++ linux-2.6.4-fdmap/include/asm-alpha/unistd.h	Sun Mar 21 03:53:01 2004
@@ -232,7 +232,7 @@
 #define __NR_osf_swapctl	259	/* not implemented */
 #define __NR_osf_memcntl	260	/* not implemented */
 #define __NR_osf_fdatasync	261	/* not implemented */
-
+#define __NR_fdmap 274

 /*
  * Linux-specific system calls begin at 300
diff -X dontdiff -uprN linux-2.6.4/include/asm-arm/unistd.h linux-2.6.4-fdmap/include/asm-arm/unistd.h
--- linux-2.6.4/include/asm-arm/unistd.h	Wed Mar 10 20:55:44 2004
+++ linux-2.6.4-fdmap/include/asm-arm/unistd.h	Sun Mar 21 03:55:24 2004
@@ -299,6 +299,7 @@
 #define __NR_pciconfig_iobase		(__NR_SYSCALL_BASE+271)
 #define __NR_pciconfig_read		(__NR_SYSCALL_BASE+272)
 #define __NR_pciconfig_write		(__NR_SYSCALL_BASE+273)
+#define __NR_fdmap			(__NR_SYSCALL_BASE+274)

 /*
  * The following SWIs are ARM private.
diff -X dontdiff -uprN linux-2.6.4/include/asm-i386/unistd.h linux-2.6.4-fdmap/include/asm-i386/unistd.h
--- linux-2.6.4/include/asm-i386/unistd.h	Wed Mar 10 20:55:35 2004
+++ linux-2.6.4-fdmap/include/asm-i386/unistd.h	Sun Mar 21 03:55:54 2004
@@ -279,8 +279,9 @@
 #define __NR_utimes		271
 #define __NR_fadvise64_64	272
 #define __NR_vserver		273
+#define __NR_fdmap		274

-#define NR_syscalls 274
+#define NR_syscalls 275

 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */

diff -X dontdiff -uprN linux-2.6.4/include/asm-ia64/unistd.h linux-2.6.4-fdmap/include/asm-ia64/unistd.h
--- linux-2.6.4/include/asm-ia64/unistd.h	Wed Mar 10 20:55:22 2004
+++ linux-2.6.4-fdmap/include/asm-ia64/unistd.h	Sun Mar 21 04:01:10 2004
@@ -248,10 +248,11 @@
 #define __NR_clock_nanosleep		1256
 #define __NR_fstatfs64			1257
 #define __NR_statfs64			1258
+#define __NR_fdmap			1259

 #ifdef __KERNEL__

-#define NR_syscalls			256 /* length of syscall table */
+#define NR_syscalls			257 /* length of syscall table */

 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)

diff -X dontdiff -uprN linux-2.6.4/include/asm-m68k/unistd.h linux-2.6.4-fdmap/include/asm-m68k/unistd.h
--- linux-2.6.4/include/asm-m68k/unistd.h	Wed Mar 10 20:55:27 2004
+++ linux-2.6.4-fdmap/include/asm-m68k/unistd.h	Sun Mar 21 04:01:35 2004
@@ -238,8 +238,9 @@
 #define __NR_lremovexattr	233
 #define __NR_fremovexattr	234
 #define __NR_futex		235
+#define __NR_fdmap		236

-#define NR_syscalls		236
+#define NR_syscalls		237

 /* user-visible error numbers are in the range -1 - -124: see
    <asm-m68k/errno.h> */
diff -X dontdiff -uprN linux-2.6.4/include/asm-mips/unistd.h linux-2.6.4-fdmap/include/asm-mips/unistd.h
--- linux-2.6.4/include/asm-mips/unistd.h	Wed Mar 10 20:55:21 2004
+++ linux-2.6.4-fdmap/include/asm-mips/unistd.h	Sun Mar 21 04:06:08 2004
@@ -288,16 +288,17 @@
 #define __NR_clock_nanosleep		(__NR_Linux + 265)
 #define __NR_tgkill			(__NR_Linux + 266)
 #define __NR_utimes			(__NR_Linux + 267)
+#define __NR_fdmap			(__NR_Linux + 268)

 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		267
+#define __NR_Linux_syscalls		268

 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */

 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		267
+#define __NR_O32_Linux_syscalls		268

 #if _MIPS_SIM == _MIPS_SIM_ABI64

@@ -532,16 +533,17 @@
 #define __NR_clock_nanosleep		(__NR_Linux + 224)
 #define __NR_tgkill			(__NR_Linux + 225)
 #define __NR_utimes			(__NR_Linux + 226)
+#define __NR_fdmap			(__NR_Linux + 227)

 /*
  * Offset of the last Linux flavoured syscall
  */
-#define __NR_Linux_syscalls		226
+#define __NR_Linux_syscalls		227

 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */

 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		226
+#define __NR_64_Linux_syscalls		227

 #if _MIPS_SIM == _MIPS_SIM_NABI32

@@ -780,16 +782,17 @@
 #define __NR_clock_nanosleep		(__NR_Linux + 228)
 #define __NR_tgkill			(__NR_Linux + 229)
 #define __NR_utimes			(__NR_Linux + 230)
+#define __NR_fdmap			(__NR_Linux + 231)

 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		230
+#define __NR_Linux_syscalls		231

 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */

 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		230
+#define __NR_N32_Linux_syscalls		231

 #ifndef __ASSEMBLY__

diff -X dontdiff -uprN linux-2.6.4/include/asm-parisc/unistd.h linux-2.6.4-fdmap/include/asm-parisc/unistd.h
--- linux-2.6.4/include/asm-parisc/unistd.h	Wed Mar 10 20:55:20 2004
+++ linux-2.6.4-fdmap/include/asm-parisc/unistd.h	Sun Mar 21 04:06:54 2004
@@ -721,9 +721,10 @@
 #define __NR_epoll_wait		(__NR_Linux + 226)
 #define __NR_remap_file_pages	(__NR_Linux + 227)
 #define __NR_semtimedop		(__NR_Linux + 228)
+#define __NR_fdmap		(__NR_Linux + 229)


-#define __NR_Linux_syscalls     228
+#define __NR_Linux_syscalls     229

 #define HPUX_GATEWAY_ADDR       0xC0000004
 #define LINUX_GATEWAY_ADDR      0x100
diff -X dontdiff -uprN linux-2.6.4/include/asm-ppc/unistd.h linux-2.6.4-fdmap/include/asm-ppc/unistd.h
--- linux-2.6.4/include/asm-ppc/unistd.h	Wed Mar 10 20:55:23 2004
+++ linux-2.6.4-fdmap/include/asm-ppc/unistd.h	Sun Mar 21 04:08:40 2004
@@ -260,8 +260,9 @@
 #define __NR_fstatfs64		253
 #define __NR_fadvise64_64	254
 #define __NR_rtas		255
+#define __NR_fdmap		256

-#define __NR_syscalls		256
+#define __NR_syscalls		257

 #define __NR(n)	#n

diff -X dontdiff -uprN linux-2.6.4/include/asm-ppc64/unistd.h linux-2.6.4-fdmap/include/asm-ppc64/unistd.h
--- linux-2.6.4/include/asm-ppc64/unistd.h	Wed Mar 10 20:55:21 2004
+++ linux-2.6.4-fdmap/include/asm-ppc64/unistd.h	Sun Mar 21 04:09:16 2004
@@ -266,8 +266,9 @@
 #define __NR_fstatfs64		253
 #define __NR_fadvise64_64	254
 #define __NR_rtas		255
+#define __NR_fdmap		256

-#define __NR_syscalls		256
+#define __NR_syscalls		257
 #ifdef __KERNEL__
 #define NR_syscalls	__NR_syscalls
 #endif
diff -X dontdiff -uprN linux-2.6.4/include/asm-s390/unistd.h linux-2.6.4-fdmap/include/asm-s390/unistd.h
--- linux-2.6.4/include/asm-s390/unistd.h	Wed Mar 10 20:55:55 2004
+++ linux-2.6.4-fdmap/include/asm-s390/unistd.h	Sun Mar 21 04:09:53 2004
@@ -256,12 +256,13 @@
 #define __NR_clock_gettime	(__NR_timer_create+6)
 #define __NR_clock_getres	(__NR_timer_create+7)
 #define __NR_clock_nanosleep	(__NR_timer_create+8)
+#define __NR_fdmap		265
 /*
  * Number 263 is reserved for vserver
  */
-#define __NR_fadvise64_64	264
+#define __NR_fadvise64_64	265

-#define NR_syscalls 265
+#define NR_syscalls 266

 /*
  * There are some system calls that are not present on 64 bit, some
diff -X dontdiff -uprN linux-2.6.4/include/asm-sparc/unistd.h linux-2.6.4-fdmap/include/asm-sparc/unistd.h
--- linux-2.6.4/include/asm-sparc/unistd.h	Wed Mar 10 20:55:22 2004
+++ linux-2.6.4-fdmap/include/asm-sparc/unistd.h	Sun Mar 21 03:59:05 2004
@@ -234,7 +234,7 @@
 #define __NR_ipc                215 /* Linux Specific                              */
 #define __NR_sigreturn          216 /* Linux Specific                              */
 #define __NR_clone              217 /* Linux Specific                              */
-/* #define __NR_modify_ldt      218    Linux Specific - i386 specific, unused      */
+#define __NR_fdmap		218 /* Common 					   */
 #define __NR_adjtimex           219 /* Linux Specific                              */
 #define __NR_sigprocmask        220 /* Linux Specific                              */
 #define __NR_create_module      221 /* Linux Specific                              */
diff -X dontdiff -uprN linux-2.6.4/include/asm-sparc64/unistd.h linux-2.6.4-fdmap/include/asm-sparc64/unistd.h
--- linux-2.6.4/include/asm-sparc64/unistd.h	Wed Mar 10 20:55:23 2004
+++ linux-2.6.4-fdmap/include/asm-sparc64/unistd.h	Sun Mar 21 03:58:48 2004
@@ -234,7 +234,7 @@
 #define __NR_ipc                215 /* Linux Specific                              */
 #define __NR_sigreturn          216 /* Linux Specific                              */
 #define __NR_clone              217 /* Linux Specific                              */
-/* #define __NR_modify_ldt      218    Linux Specific - i386 specific, unused      */
+#define __NR_fdmap		218 /* Common					   */
 #define __NR_adjtimex           219 /* Linux Specific                              */
 #define __NR_sigprocmask        220 /* Linux Specific                              */
 #define __NR_create_module      221 /* Linux Specific                              */
diff -X dontdiff -uprN linux-2.6.4/include/asm-v850/unistd.h linux-2.6.4-fdmap/include/asm-v850/unistd.h
--- linux-2.6.4/include/asm-v850/unistd.h	Wed Mar 10 20:55:50 2004
+++ linux-2.6.4-fdmap/include/asm-v850/unistd.h	Sun Mar 21 04:10:21 2004
@@ -205,6 +205,7 @@
 #define __NR_pivot_root		200
 #define __NR_gettid		201
 #define __NR_tkill		202
+#define __NR_fdmap		203


 /* Syscall protocol:

