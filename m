Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271736AbRICPo4>; Mon, 3 Sep 2001 11:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271733AbRICPoh>; Mon, 3 Sep 2001 11:44:37 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:41488 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271729AbRICPoT>; Mon, 3 Sep 2001 11:44:19 -0400
Date: Mon, 3 Sep 2001 17:44:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, Chris Wedgwood <cw@f00f.org>,
        David Luyer <david_luyer@pacific.net.au>, linux-kernel@vger.kernel.org
Subject: mmap-rb-7 [was Re: /proc/<n>/maps growing...]
Message-ID: <20010903174411.O699@athlon.random>
In-Reply-To: <20010806152919.H20837@athlon.random> <Pine.LNX.4.33.0108061020430.8972-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0108061020430.8972-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Aug 06, 2001 at 10:27:33AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 10:27:33AM -0700, Linus Torvalds wrote:
> Now, if you _really_ want to do this right, you can:
>  - hold the write lock on the semaphore. Nobody is going to change the
>    list.
> 
>  - walk the table just once, remembering what the previous entry was.
> 
>    NOTE! You ahve to do this _anyway_, as part of checking the "do I need
>    to unmap anything?" Right now we just call "do_munmap()", but done
>    right we would walk the tree _once_, noticing whether we need to unmap
>    or not, and keep track of what the previous one was.
> 
>  - just expand the previous entry when you notice that it's doable.
> 
>  - allocate and insert a new entry if needed.
> 
> However, this absolutely means getting rid of "insert_vm_struct()", and
> moving a large portion of it into the caller.
> 
> It also means doing the same for "do_munmap()".
> 
> Try it. I'd love to see the code. I didn't want to do it myself.

It's below, now rock solid, please include in the next kernel.

A few implementation details: the do_munmap case inside mmap(2) it's not
an extremely common case so I will walk the tree once more if there's an
overlapping mapping under us.  Also for the non MAP_FIXED mappings we'll
still walk the tree twice in mmap(2) because I didn't messed with the
get_unmapped_area API.

diff -urN 2.4.10pre4/arch/alpha/kernel/process.c mmap-rb/arch/alpha/kernel/process.c
--- 2.4.10pre4/arch/alpha/kernel/process.c	Wed Jul  4 04:03:45 2001
+++ mmap-rb/arch/alpha/kernel/process.c	Mon Sep  3 17:32:21 2001
@@ -50,7 +50,6 @@
  */
 
 unsigned long init_user_stack[1024] = { STACK_MAGIC, };
-static struct vm_area_struct init_mmap = INIT_MMAP;
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
 static struct signal_struct init_signals = INIT_SIGNALS;
diff -urN 2.4.10pre4/arch/arm/kernel/init_task.c mmap-rb/arch/arm/kernel/init_task.c
--- 2.4.10pre4/arch/arm/kernel/init_task.c	Thu Nov 16 15:37:26 2000
+++ mmap-rb/arch/arm/kernel/init_task.c	Mon Sep  3 17:32:23 2001
@@ -9,7 +9,6 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 
-static struct vm_area_struct init_mmap = INIT_MMAP;
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
 static struct signal_struct init_signals = INIT_SIGNALS;
diff -urN 2.4.10pre4/arch/cris/kernel/process.c mmap-rb/arch/cris/kernel/process.c
--- 2.4.10pre4/arch/cris/kernel/process.c	Sat Aug 11 08:03:53 2001
+++ mmap-rb/arch/cris/kernel/process.c	Mon Sep  3 17:32:23 2001
@@ -65,7 +65,6 @@
  * setup.
  */
 
-static struct vm_area_struct init_mmap = INIT_MMAP;
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
 static struct signal_struct init_signals = INIT_SIGNALS;
diff -urN 2.4.10pre4/arch/i386/kernel/init_task.c mmap-rb/arch/i386/kernel/init_task.c
--- 2.4.10pre4/arch/i386/kernel/init_task.c	Tue Aug  3 19:32:57 1999
+++ mmap-rb/arch/i386/kernel/init_task.c	Mon Sep  3 17:32:21 2001
@@ -6,7 +6,6 @@
 #include <asm/pgtable.h>
 #include <asm/desc.h>
 
-static struct vm_area_struct init_mmap = INIT_MMAP;
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
 static struct signal_struct init_signals = INIT_SIGNALS;
diff -urN 2.4.10pre4/arch/ia64/kernel/init_task.c mmap-rb/arch/ia64/kernel/init_task.c
--- 2.4.10pre4/arch/ia64/kernel/init_task.c	Mon Feb  7 03:42:40 2000
+++ mmap-rb/arch/ia64/kernel/init_task.c	Mon Sep  3 17:32:23 2001
@@ -13,7 +13,6 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 
-static struct vm_area_struct init_mmap = INIT_MMAP;
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
 static struct signal_struct init_signals = INIT_SIGNALS;
diff -urN 2.4.10pre4/arch/m68k/kernel/process.c mmap-rb/arch/m68k/kernel/process.c
--- 2.4.10pre4/arch/m68k/kernel/process.c	Thu Feb 22 03:44:54 2001
+++ mmap-rb/arch/m68k/kernel/process.c	Mon Sep  3 17:32:23 2001
@@ -38,7 +38,6 @@
  * alignment requirements and potentially different initial
  * setup.
  */
-static struct vm_area_struct init_mmap = INIT_MMAP;
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
 static struct signal_struct init_signals = INIT_SIGNALS;
diff -urN 2.4.10pre4/arch/mips/kernel/init_task.c mmap-rb/arch/mips/kernel/init_task.c
--- 2.4.10pre4/arch/mips/kernel/init_task.c	Tue Jul 27 07:41:09 1999
+++ mmap-rb/arch/mips/kernel/init_task.c	Mon Sep  3 17:32:23 2001
@@ -4,7 +4,6 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 
-static struct vm_area_struct init_mmap = INIT_MMAP;
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
 static struct signal_struct init_signals = INIT_SIGNALS;
diff -urN 2.4.10pre4/arch/mips64/kernel/init_task.c mmap-rb/arch/mips64/kernel/init_task.c
--- 2.4.10pre4/arch/mips64/kernel/init_task.c	Fri Feb 25 07:53:35 2000
+++ mmap-rb/arch/mips64/kernel/init_task.c	Mon Sep  3 17:32:23 2001
@@ -4,7 +4,6 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 
-static struct vm_area_struct init_mmap = INIT_MMAP;
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
 static struct signal_struct init_signals = INIT_SIGNALS;
diff -urN 2.4.10pre4/arch/parisc/kernel/init_task.c mmap-rb/arch/parisc/kernel/init_task.c
--- 2.4.10pre4/arch/parisc/kernel/init_task.c	Thu Dec 14 22:34:00 2000
+++ mmap-rb/arch/parisc/kernel/init_task.c	Mon Sep  3 17:32:23 2001
@@ -6,7 +6,6 @@
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 
-static struct vm_area_struct init_mmap = INIT_MMAP;
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
 static struct signal_struct init_signals = INIT_SIGNALS;
diff -urN 2.4.10pre4/arch/ppc/kernel/process.c mmap-rb/arch/ppc/kernel/process.c
--- 2.4.10pre4/arch/ppc/kernel/process.c	Sun Sep  2 20:03:55 2001
+++ mmap-rb/arch/ppc/kernel/process.c	Mon Sep  3 17:32:23 2001
@@ -48,7 +48,6 @@
 
 struct task_struct *last_task_used_math = NULL;
 struct task_struct *last_task_used_altivec = NULL;
-static struct vm_area_struct init_mmap = INIT_MMAP;
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
 static struct signal_struct init_signals = INIT_SIGNALS;
diff -urN 2.4.10pre4/arch/s390/kernel/init_task.c mmap-rb/arch/s390/kernel/init_task.c
--- 2.4.10pre4/arch/s390/kernel/init_task.c	Fri May 12 20:41:44 2000
+++ mmap-rb/arch/s390/kernel/init_task.c	Mon Sep  3 17:32:23 2001
@@ -12,7 +12,6 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 
-static struct vm_area_struct init_mmap = INIT_MMAP;
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
 static struct signal_struct init_signals = INIT_SIGNALS;
diff -urN 2.4.10pre4/arch/s390x/kernel/init_task.c mmap-rb/arch/s390x/kernel/init_task.c
--- 2.4.10pre4/arch/s390x/kernel/init_task.c	Thu Feb 22 03:44:55 2001
+++ mmap-rb/arch/s390x/kernel/init_task.c	Mon Sep  3 17:32:23 2001
@@ -12,7 +12,6 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 
-static struct vm_area_struct init_mmap = INIT_MMAP;
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
 static struct signal_struct init_signals = INIT_SIGNALS;
diff -urN 2.4.10pre4/arch/sh/kernel/init_task.c mmap-rb/arch/sh/kernel/init_task.c
--- 2.4.10pre4/arch/sh/kernel/init_task.c	Tue Aug 31 03:12:59 1999
+++ mmap-rb/arch/sh/kernel/init_task.c	Mon Sep  3 17:32:23 2001
@@ -5,7 +5,6 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 
-static struct vm_area_struct init_mmap = INIT_MMAP;
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
 static struct signal_struct init_signals = INIT_SIGNALS;
diff -urN 2.4.10pre4/arch/sparc/kernel/init_task.c mmap-rb/arch/sparc/kernel/init_task.c
--- 2.4.10pre4/arch/sparc/kernel/init_task.c	Tue Jul 27 07:41:09 1999
+++ mmap-rb/arch/sparc/kernel/init_task.c	Mon Sep  3 17:32:23 2001
@@ -4,7 +4,6 @@
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
 
-static struct vm_area_struct init_mmap = INIT_MMAP;
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
 static struct signal_struct init_signals = INIT_SIGNALS;
diff -urN 2.4.10pre4/arch/sparc64/kernel/init_task.c mmap-rb/arch/sparc64/kernel/init_task.c
--- 2.4.10pre4/arch/sparc64/kernel/init_task.c	Tue May  1 19:35:21 2001
+++ mmap-rb/arch/sparc64/kernel/init_task.c	Mon Sep  3 17:32:23 2001
@@ -4,7 +4,6 @@
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
 
-static struct vm_area_struct init_mmap = INIT_MMAP;
 static struct fs_struct init_fs = INIT_FS;
 static struct files_struct init_files = INIT_FILES;
 static struct signal_struct init_signals = INIT_SIGNALS;
diff -urN 2.4.10pre4/include/asm-alpha/processor.h mmap-rb/include/asm-alpha/processor.h
--- 2.4.10pre4/include/asm-alpha/processor.h	Tue Jan  2 17:41:21 2001
+++ mmap-rb/include/asm-alpha/processor.h	Mon Sep  3 17:32:21 2001
@@ -70,9 +70,6 @@
 	int bpt_nsaved;
 };
 
-#define INIT_MMAP { &init_mm, PAGE_OFFSET,  PAGE_OFFSET+0x10000000, \
-	NULL, PAGE_SHARED, VM_READ | VM_WRITE | VM_EXEC, 1, NULL, NULL }
-
 #define INIT_THREAD  { \
 	0, 0, 0, \
 	0, 0, 0, \
diff -urN 2.4.10pre4/include/asm-arm/processor.h mmap-rb/include/asm-arm/processor.h
--- 2.4.10pre4/include/asm-arm/processor.h	Thu Aug 16 22:03:39 2001
+++ mmap-rb/include/asm-arm/processor.h	Mon Sep  3 17:32:23 2001
@@ -68,13 +68,6 @@
 	EXTRA_THREAD_STRUCT
 };
 
-#define INIT_MMAP {					\
-	vm_mm:		&init_mm,			\
-	vm_page_prot:	PAGE_SHARED,			\
-	vm_flags:	VM_READ | VM_WRITE | VM_EXEC,	\
-	vm_avl_height:	1,				\
-}
-
 #define INIT_THREAD  {					\
 	refcount:	ATOMIC_INIT(1),			\
 	EXTRA_THREAD_STRUCT_INIT			\
diff -urN 2.4.10pre4/include/asm-cris/processor.h mmap-rb/include/asm-cris/processor.h
--- 2.4.10pre4/include/asm-cris/processor.h	Sat Aug 11 08:04:23 2001
+++ mmap-rb/include/asm-cris/processor.h	Mon Sep  3 17:32:23 2001
@@ -77,16 +77,6 @@
 
 #define current_regs() user_regs(current)
 
-/* INIT_MMAP is the kernels map of memory, between KSEG_C and KSEG_D */
-
-#ifdef CONFIG_CRIS_LOW_MAP
-#define INIT_MMAP { &init_mm, KSEG_6, KSEG_7, NULL, PAGE_SHARED, \
-			     VM_READ | VM_WRITE | VM_EXEC, 1, NULL, NULL }
-#else
-#define INIT_MMAP { &init_mm, KSEG_C, KSEG_D, NULL, PAGE_SHARED, \
-			     VM_READ | VM_WRITE | VM_EXEC, 1, NULL, NULL }
-#endif
-
 #define INIT_THREAD  { \
    0, 0, 0x20 }  /* ccr = int enable, nothing else */
 
diff -urN 2.4.10pre4/include/asm-i386/processor.h mmap-rb/include/asm-i386/processor.h
--- 2.4.10pre4/include/asm-i386/processor.h	Wed Aug 29 15:05:24 2001
+++ mmap-rb/include/asm-i386/processor.h	Mon Sep  3 17:32:21 2001
@@ -391,9 +391,6 @@
 	0,{~0,}			/* io permissions */		\
 }
 
-#define INIT_MMAP \
-{ &init_mm, 0, 0, NULL, PAGE_SHARED, VM_READ | VM_WRITE | VM_EXEC, 1, NULL, NULL }
-
 #define INIT_TSS  {						\
 	0,0, /* back_link, __blh */				\
 	sizeof(init_stack) + (long) &init_stack, /* esp0 */	\
diff -urN 2.4.10pre4/include/asm-ia64/processor.h mmap-rb/include/asm-ia64/processor.h
--- 2.4.10pre4/include/asm-ia64/processor.h	Sat Aug 11 08:04:25 2001
+++ mmap-rb/include/asm-ia64/processor.h	Mon Sep  3 17:32:23 2001
@@ -364,11 +364,6 @@
 	struct ia64_fpreg fph[96];	/* saved/loaded on demand */
 };
 
-#define INIT_MMAP {								\
-	&init_mm, PAGE_OFFSET, PAGE_OFFSET + 0x10000000, NULL, PAGE_SHARED,	\
-        VM_READ | VM_WRITE | VM_EXEC, 1, NULL, NULL				\
-}
-
 #define INIT_THREAD {					\
 	0,				/* ksp */	\
 	0,				/* flags */	\
diff -urN 2.4.10pre4/include/asm-m68k/processor.h mmap-rb/include/asm-m68k/processor.h
--- 2.4.10pre4/include/asm-m68k/processor.h	Tue Jan  2 17:41:22 2001
+++ mmap-rb/include/asm-m68k/processor.h	Mon Sep  3 17:32:23 2001
@@ -78,8 +78,6 @@
 	unsigned char  fpstate[FPSTATESIZE];  /* floating point state */
 };
 
-#define INIT_MMAP { &init_mm, 0, 0x40000000, NULL, __pgprot(_PAGE_PRESENT|_PAGE_ACCESSED), VM_READ | VM_WRITE | VM_EXEC, 1, NULL, NULL }
-
 #define INIT_THREAD  { \
 	sizeof(init_stack) + (unsigned long) init_stack, 0, \
 	PS_S, __KERNEL_DS, \
diff -urN 2.4.10pre4/include/asm-mips/processor.h mmap-rb/include/asm-mips/processor.h
--- 2.4.10pre4/include/asm-mips/processor.h	Wed Jul  4 04:03:47 2001
+++ mmap-rb/include/asm-mips/processor.h	Mon Sep  3 17:32:23 2001
@@ -171,9 +171,6 @@
 
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
 
-#define INIT_MMAP { &init_mm, KSEG0, KSEG1, NULL, PAGE_SHARED, \
-                    VM_READ | VM_WRITE | VM_EXEC, 1, NULL, NULL }
-
 #define INIT_THREAD  { \
         /* \
          * saved main processor registers \
diff -urN 2.4.10pre4/include/asm-mips64/processor.h mmap-rb/include/asm-mips64/processor.h
--- 2.4.10pre4/include/asm-mips64/processor.h	Sat Jul 21 00:04:30 2001
+++ mmap-rb/include/asm-mips64/processor.h	Mon Sep  3 17:32:23 2001
@@ -198,9 +198,6 @@
 
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
 
-#define INIT_MMAP { &init_mm, KSEG0, KSEG1, NULL, PAGE_SHARED, \
-                    VM_READ | VM_WRITE | VM_EXEC, 1, NULL, NULL }
-
 #define INIT_THREAD  { \
         /* \
          * saved main processor registers \
diff -urN 2.4.10pre4/include/asm-parisc/processor.h mmap-rb/include/asm-parisc/processor.h
--- 2.4.10pre4/include/asm-parisc/processor.h	Tue Jan  2 17:41:22 2001
+++ mmap-rb/include/asm-parisc/processor.h	Mon Sep  3 17:32:23 2001
@@ -107,9 +107,6 @@
 /* Thread struct flags. */
 #define PARISC_KERNEL_DEATH	(1UL << 31)	/* see die_if_kernel()... */
 
-#define INIT_MMAP { &init_mm, 0, 0, NULL, PAGE_SHARED, \
-		    VM_READ | VM_WRITE | VM_EXEC, 1, NULL, NULL }
-
 #define INIT_THREAD { {			\
 	{ 0, 0, 0, 0, 0, 0, 0, 0,	\
 	  0, 0, 0, 0, 0, 0, 0, 0,	\
diff -urN 2.4.10pre4/include/asm-ppc/processor.h mmap-rb/include/asm-ppc/processor.h
--- 2.4.10pre4/include/asm-ppc/processor.h	Sun Sep  2 20:04:00 2001
+++ mmap-rb/include/asm-ppc/processor.h	Mon Sep  3 17:32:23 2001
@@ -621,14 +621,6 @@
 }
 
 /*
- * Note: the vm_start and vm_end fields here should *not*
- * be in kernel space.  (Could vm_end == vm_start perhaps?)
- */
-#define INIT_MMAP { &init_mm, 0, 0x1000, NULL, \
-		    PAGE_SHARED, VM_READ | VM_WRITE | VM_EXEC, \
-		    1, NULL, NULL }
-
-/*
  * Return saved PC of a blocked thread. For now, this is the "user" PC
  */
 static inline unsigned long thread_saved_pc(struct thread_struct *t)
diff -urN 2.4.10pre4/include/asm-s390/processor.h mmap-rb/include/asm-s390/processor.h
--- 2.4.10pre4/include/asm-s390/processor.h	Sat Aug 11 08:04:26 2001
+++ mmap-rb/include/asm-s390/processor.h	Mon Sep  3 17:32:23 2001
@@ -95,10 +95,6 @@
 
 typedef struct thread_struct thread_struct;
 
-#define INIT_MMAP \
-{ &init_mm, 0, 0, NULL, PAGE_SHARED, \
-VM_READ | VM_WRITE | VM_EXEC, 1, NULL, NULL }
-
 #define INIT_THREAD { (struct pt_regs *) 0,                       \
                     { 0,{{0},{0},{0},{0},{0},{0},{0},{0},{0},{0}, \
 			    {0},{0},{0},{0},{0},{0}}},            \
diff -urN 2.4.10pre4/include/asm-s390x/processor.h mmap-rb/include/asm-s390x/processor.h
--- 2.4.10pre4/include/asm-s390x/processor.h	Sat Aug 11 08:04:29 2001
+++ mmap-rb/include/asm-s390x/processor.h	Mon Sep  3 17:32:23 2001
@@ -99,10 +99,6 @@
 
 typedef struct thread_struct thread_struct;
 
-#define INIT_MMAP \
-{ &init_mm, 0, 0, NULL, PAGE_SHARED, \
-VM_READ | VM_WRITE | VM_EXEC, 1, NULL,NULL }
-
 #define INIT_THREAD { (struct pt_regs *) 0,                       \
                     { 0,{{0},{0},{0},{0},{0},{0},{0},{0},{0},{0}, \
 			    {0},{0},{0},{0},{0},{0}}},            \
diff -urN 2.4.10pre4/include/asm-sh/processor.h mmap-rb/include/asm-sh/processor.h
--- 2.4.10pre4/include/asm-sh/processor.h	Wed Jul  4 04:03:47 2001
+++ mmap-rb/include/asm-sh/processor.h	Mon Sep  3 17:32:23 2001
@@ -114,9 +114,6 @@
 	union sh_fpu_union fpu;
 };
 
-#define INIT_MMAP \
-{ &init_mm, 0, 0, NULL, PAGE_SHARED, VM_READ | VM_WRITE | VM_EXEC, 1, NULL, NULL }
-
 #define INIT_THREAD  {						\
 	sizeof(init_stack) + (long) &init_stack, /* sp */	\
 	0,					 /* pc */	\
diff -urN 2.4.10pre4/include/asm-sparc/processor.h mmap-rb/include/asm-sparc/processor.h
--- 2.4.10pre4/include/asm-sparc/processor.h	Tue May  1 19:35:32 2001
+++ mmap-rb/include/asm-sparc/processor.h	Mon Sep  3 17:32:23 2001
@@ -91,9 +91,6 @@
 #define SPARC_FLAG_KTHREAD      0x1    /* task is a kernel thread */
 #define SPARC_FLAG_UNALIGNED    0x2    /* is allowed to do unaligned accesses */
 
-#define INIT_MMAP { &init_mm, (0), (0), \
-		    NULL, __pgprot(0x0) , VM_READ | VM_WRITE | VM_EXEC, 1, NULL, NULL }
-
 #define INIT_THREAD  { \
 /* uwinmask, kregs, ksp, kpc, kpsr, kwim */ \
    0,        0,     0,   0,   0,    0, \
diff -urN 2.4.10pre4/include/asm-sparc64/processor.h mmap-rb/include/asm-sparc64/processor.h
--- 2.4.10pre4/include/asm-sparc64/processor.h	Tue May  1 19:35:32 2001
+++ mmap-rb/include/asm-sparc64/processor.h	Mon Sep  3 17:32:23 2001
@@ -85,9 +85,6 @@
 #define FAULT_CODE_ITLB		0x04	/* Miss happened in I-TLB		*/
 #define FAULT_CODE_WINFIXUP	0x08	/* Miss happened during spill/fill	*/
 
-#define INIT_MMAP { &init_mm, 0xfffff80000000000, 0xfffff80001000000, \
-		    NULL, PAGE_SHARED , VM_READ | VM_WRITE | VM_EXEC, 1, NULL, NULL }
-
 #define INIT_THREAD  {					\
 /* ksp, wstate, cwp, flags, current_ds, */ 		\
    0,   0,      0,   0,     KERNEL_DS,			\
diff -urN 2.4.10pre4/include/linux/mm.h mmap-rb/include/linux/mm.h
--- 2.4.10pre4/include/linux/mm.h	Sun Sep  2 20:04:01 2001
+++ mmap-rb/include/linux/mm.h	Mon Sep  3 17:32:22 2001
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/mmzone.h>
 #include <linux/swap.h>
+#include <linux/rbtree.h>
 
 extern unsigned long max_mapnr;
 extern unsigned long num_physpages;
@@ -50,10 +51,7 @@
 	pgprot_t vm_page_prot;		/* Access permissions of this VMA. */
 	unsigned long vm_flags;		/* Flags, listed below. */
 
-	/* AVL tree of VM areas per task, sorted by address */
-	short vm_avl_height;
-	struct vm_area_struct * vm_avl_left;
-	struct vm_area_struct * vm_avl_right;
+	rb_node_t vm_rb;
 
 	/*
 	 * For areas with an address space and backing store,
@@ -490,7 +488,7 @@
 extern void unlock_vma_mappings(struct vm_area_struct *);
 extern void insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void __insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
-extern void build_mmap_avl(struct mm_struct *);
+extern void build_mmap_rb(struct mm_struct *);
 extern void exit_mmap(struct mm_struct *);
 
 extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
@@ -516,6 +514,22 @@
 
 extern unsigned long do_brk(unsigned long, unsigned long);
 
+static inline void __vma_unlink(struct mm_struct * mm, struct vm_area_struct * vma, struct vm_area_struct * prev)
+{
+	prev->vm_next = vma->vm_next;
+	rb_erase(&vma->vm_rb, &mm->mm_rb);
+	if (mm->mmap_cache == vma)
+		mm->mmap_cache = prev;
+}
+
+static inline int can_vma_merge(struct vm_area_struct * vma, unsigned long vm_flags)
+{
+	if (!vma->vm_file && vma->vm_flags == vm_flags)
+		return 1;
+	else
+		return 0;
+}
+
 struct zone_t;
 /* filemap.c */
 extern void remove_inode_page(struct page *);
@@ -562,6 +576,11 @@
 {
 	unsigned long grow;
 
+	/*
+	 * vma->vm_start/vm_end cannot change under us because the caller is required
+	 * to hold the mmap_sem in write mode. We need to get the spinlock only
+	 * before relocating the vma range ourself.
+	 */
 	address &= PAGE_MASK;
 	grow = (vma->vm_start - address) >> PAGE_SHIFT;
 	if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
diff -urN 2.4.10pre4/include/linux/rbtree.h mmap-rb/include/linux/rbtree.h
--- 2.4.10pre4/include/linux/rbtree.h	Thu Jan  1 01:00:00 1970
+++ mmap-rb/include/linux/rbtree.h	Mon Sep  3 17:32:22 2001
@@ -0,0 +1,133 @@
+/*
+  Red Black Trees
+  (C) 1999  Andrea Arcangeli <andrea@suse.de>
+  
+  This program is free software; you can redistribute it and/or modify
+  it under the terms of the GNU General Public License as published by
+  the Free Software Foundation; either version 2 of the License, or
+  (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program; if not, write to the Free Software
+  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+
+  linux/include/linux/rbtree.h
+
+  To use rbtrees you'll have to implement your own insert and search cores.
+  This will avoid us to use callbacks and to drop drammatically performances.
+  I know it's not the cleaner way,  but in C (not in C++) to get
+  performances and genericity...
+
+  Some example of insert and search follows here. The search is a plain
+  normal search over an ordered tree. The insert instead must be implemented
+  int two steps: as first thing the code must insert the element in
+  order as a red leaf in the tree, then the support library function
+  rb_insert_color() must be called. Such function will do the
+  not trivial work to rebalance the rbtree if necessary.
+
+-----------------------------------------------------------------------
+static inline struct page * rb_search_page_cache(struct inode * inode,
+						 unsigned long offset)
+{
+	rb_node_t * n = inode->i_rb_page_cache.rb_node;
+	struct page * page;
+
+	while (n)
+	{
+		page = rb_entry(n, struct page, rb_page_cache);
+
+		if (offset < page->offset)
+			n = n->rb_left;
+		else if (offset > page->offset)
+			n = n->rb_right;
+		else
+			return page;
+	}
+	return NULL;
+}
+
+static inline struct page * __rb_insert_page_cache(struct inode * inode,
+						   unsigned long offset,
+						   rb_node_t * node)
+{
+	rb_node_t ** p = &inode->i_rb_page_cache.rb_node;
+	rb_node_t * parent = NULL;
+	struct page * page;
+
+	while (*p)
+	{
+		parent = *p;
+		page = rb_entry(parent, struct page, rb_page_cache);
+
+		if (offset < page->offset)
+			p = &(*p)->rb_left;
+		else if (offset > page->offset)
+			p = &(*p)->rb_right;
+		else
+			return page;
+	}
+
+	rb_link_node(node, parent, p);
+
+	return NULL;
+}
+
+static inline struct page * rb_insert_page_cache(struct inode * inode,
+						 unsigned long offset,
+						 rb_node_t * node)
+{
+	struct page * ret;
+	if ((ret = __rb_insert_page_cache(inode, offset, node)))
+		goto out;
+	rb_insert_color(node, &inode->i_rb_page_cache);
+ out:
+	return ret;
+}
+-----------------------------------------------------------------------
+*/
+
+#ifndef	_LINUX_RBTREE_H
+#define	_LINUX_RBTREE_H
+
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+
+typedef struct rb_node_s
+{
+	struct rb_node_s * rb_parent;
+	int rb_color;
+#define	RB_RED		0
+#define	RB_BLACK	1
+	struct rb_node_s * rb_right;
+	struct rb_node_s * rb_left;
+}
+rb_node_t;
+
+typedef struct rb_root_s
+{
+	struct rb_node_s * rb_node;
+}
+rb_root_t;
+
+#define RB_ROOT	(rb_root_t) { NULL, }
+#define	rb_entry(ptr, type, member)					\
+	((type *)((char *)(ptr)-(unsigned long)(&((type *)0)->member)))
+
+extern void rb_insert_color(rb_node_t *, rb_root_t *);
+extern void rb_erase(rb_node_t *, rb_root_t *);
+
+static inline void rb_link_node(rb_node_t * node, rb_node_t * parent, rb_node_t ** rb_link)
+{
+	node->rb_parent = parent;
+	node->rb_color = RB_RED;
+	node->rb_left = node->rb_right = NULL;
+
+	*rb_link = node;
+}
+
+#endif	/* _LINUX_RBTREE_H */
diff -urN 2.4.10pre4/include/linux/sched.h mmap-rb/include/linux/sched.h
--- 2.4.10pre4/include/linux/sched.h	Sun Sep  2 20:04:01 2001
+++ mmap-rb/include/linux/sched.h	Mon Sep  3 17:32:49 2001
@@ -13,6 +13,7 @@
 #include <linux/types.h>
 #include <linux/times.h>
 #include <linux/timex.h>
+#include <linux/rbtree.h>
 
 #include <asm/system.h>
 #include <asm/semaphore.h>
@@ -199,12 +200,9 @@
 /* Maximum number of active map areas.. This is a random (large) number */
 #define MAX_MAP_COUNT	(65536)
 
-/* Number of map areas at which the AVL tree is activated. This is arbitrary. */
-#define AVL_MIN_MAP_COUNT	32
-
 struct mm_struct {
 	struct vm_area_struct * mmap;		/* list of VMAs */
-	struct vm_area_struct * mmap_avl;	/* tree of VMAs */
+	rb_root_t mm_rb;
 	struct vm_area_struct * mmap_cache;	/* last find_vma result */
 	pgd_t * pgd;
 	atomic_t mm_users;			/* How many users with user space? */
@@ -236,13 +234,10 @@
 
 #define INIT_MM(name) \
 {			 				\
-	mmap:		&init_mmap, 			\
-	mmap_avl:	NULL, 				\
-	mmap_cache:	NULL, 				\
+	mm_rb:		RB_ROOT,			\
 	pgd:		swapper_pg_dir, 		\
 	mm_users:	ATOMIC_INIT(2), 		\
 	mm_count:	ATOMIC_INIT(1), 		\
-	map_count:	1, 				\
 	mmap_sem:	__RWSEM_INITIALIZER(name.mmap_sem), \
 	page_table_lock: SPIN_LOCK_UNLOCKED, 		\
 	mmlist:		LIST_HEAD_INIT(name.mmlist),	\
diff -urN 2.4.10pre4/kernel/fork.c mmap-rb/kernel/fork.c
--- 2.4.10pre4/kernel/fork.c	Sun Sep  2 20:04:01 2001
+++ mmap-rb/kernel/fork.c	Mon Sep  3 17:32:22 2001
@@ -131,7 +131,6 @@
 	flush_cache_mm(current->mm);
 	mm->locked_vm = 0;
 	mm->mmap = NULL;
-	mm->mmap_avl = NULL;
 	mm->mmap_cache = NULL;
 	mm->map_count = 0;
 	mm->rss = 0;
@@ -198,8 +197,7 @@
 			goto fail_nomem;
 	}
 	retval = 0;
-	if (mm->map_count >= AVL_MIN_MAP_COUNT)
-		build_mmap_avl(mm);
+	build_mmap_rb(mm);
 
 fail_nomem:
 	flush_tlb_mm(current->mm);
diff -urN 2.4.10pre4/lib/Makefile mmap-rb/lib/Makefile
--- 2.4.10pre4/lib/Makefile	Sun Sep  2 20:04:01 2001
+++ mmap-rb/lib/Makefile	Mon Sep  3 17:32:22 2001
@@ -10,7 +10,7 @@
 
 export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o
 
-obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o
+obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o rbtree.o
 
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
diff -urN 2.4.10pre4/lib/rbtree.c mmap-rb/lib/rbtree.c
--- 2.4.10pre4/lib/rbtree.c	Thu Jan  1 01:00:00 1970
+++ mmap-rb/lib/rbtree.c	Mon Sep  3 17:32:22 2001
@@ -0,0 +1,293 @@
+/*
+  Red Black Trees
+  (C) 1999  Andrea Arcangeli <andrea@suse.de>
+  
+  This program is free software; you can redistribute it and/or modify
+  it under the terms of the GNU General Public License as published by
+  the Free Software Foundation; either version 2 of the License, or
+  (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program; if not, write to the Free Software
+  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+
+  linux/lib/rbtree.c
+*/
+
+#include <linux/rbtree.h>
+
+static void __rb_rotate_left(rb_node_t * node, rb_root_t * root)
+{
+	rb_node_t * right = node->rb_right;
+
+	if ((node->rb_right = right->rb_left))
+		right->rb_left->rb_parent = node;
+	right->rb_left = node;
+
+	if ((right->rb_parent = node->rb_parent))
+	{
+		if (node == node->rb_parent->rb_left)
+			node->rb_parent->rb_left = right;
+		else
+			node->rb_parent->rb_right = right;
+	}
+	else
+		root->rb_node = right;
+	node->rb_parent = right;
+}
+
+static void __rb_rotate_right(rb_node_t * node, rb_root_t * root)
+{
+	rb_node_t * left = node->rb_left;
+
+	if ((node->rb_left = left->rb_right))
+		left->rb_right->rb_parent = node;
+	left->rb_right = node;
+
+	if ((left->rb_parent = node->rb_parent))
+	{
+		if (node == node->rb_parent->rb_right)
+			node->rb_parent->rb_right = left;
+		else
+			node->rb_parent->rb_left = left;
+	}
+	else
+		root->rb_node = left;
+	node->rb_parent = left;
+}
+
+void rb_insert_color(rb_node_t * node, rb_root_t * root)
+{
+	rb_node_t * parent, * gparent;
+
+	while ((parent = node->rb_parent) && parent->rb_color == RB_RED)
+	{
+		gparent = parent->rb_parent;
+
+		if (parent == gparent->rb_left)
+		{
+			{
+				register rb_node_t * uncle = gparent->rb_right;
+				if (uncle && uncle->rb_color == RB_RED)
+				{
+					uncle->rb_color = RB_BLACK;
+					parent->rb_color = RB_BLACK;
+					gparent->rb_color = RB_RED;
+					node = gparent;
+					continue;
+				}
+			}
+
+			if (parent->rb_right == node)
+			{
+				register rb_node_t * tmp;
+				__rb_rotate_left(parent, root);
+				tmp = parent;
+				parent = node;
+				node = tmp;
+			}
+
+			parent->rb_color = RB_BLACK;
+			gparent->rb_color = RB_RED;
+			__rb_rotate_right(gparent, root);
+		} else {
+			{
+				register rb_node_t * uncle = gparent->rb_left;
+				if (uncle && uncle->rb_color == RB_RED)
+				{
+					uncle->rb_color = RB_BLACK;
+					parent->rb_color = RB_BLACK;
+					gparent->rb_color = RB_RED;
+					node = gparent;
+					continue;
+				}
+			}
+
+			if (parent->rb_left == node)
+			{
+				register rb_node_t * tmp;
+				__rb_rotate_right(parent, root);
+				tmp = parent;
+				parent = node;
+				node = tmp;
+			}
+
+			parent->rb_color = RB_BLACK;
+			gparent->rb_color = RB_RED;
+			__rb_rotate_left(gparent, root);
+		}
+	}
+
+	root->rb_node->rb_color = RB_BLACK;
+}
+
+static void __rb_erase_color(rb_node_t * node, rb_node_t * parent,
+			     rb_root_t * root)
+{
+	rb_node_t * other;
+
+	while ((!node || node->rb_color == RB_BLACK) && node != root->rb_node)
+	{
+		if (parent->rb_left == node)
+		{
+			other = parent->rb_right;
+			if (other->rb_color == RB_RED)
+			{
+				other->rb_color = RB_BLACK;
+				parent->rb_color = RB_RED;
+				__rb_rotate_left(parent, root);
+				other = parent->rb_right;
+			}
+			if ((!other->rb_left ||
+			     other->rb_left->rb_color == RB_BLACK)
+			    && (!other->rb_right ||
+				other->rb_right->rb_color == RB_BLACK))
+			{
+				other->rb_color = RB_RED;
+				node = parent;
+				parent = node->rb_parent;
+			}
+			else
+			{
+				if (!other->rb_right ||
+				    other->rb_right->rb_color == RB_BLACK)
+				{
+					register rb_node_t * o_left;
+					if ((o_left = other->rb_left))
+						o_left->rb_color = RB_BLACK;
+					other->rb_color = RB_RED;
+					__rb_rotate_right(other, root);
+					other = parent->rb_right;
+				}
+				other->rb_color = parent->rb_color;
+				parent->rb_color = RB_BLACK;
+				if (other->rb_right)
+					other->rb_right->rb_color = RB_BLACK;
+				__rb_rotate_left(parent, root);
+				node = root->rb_node;
+				break;
+			}
+		}
+		else
+		{
+			other = parent->rb_left;
+			if (other->rb_color == RB_RED)
+			{
+				other->rb_color = RB_BLACK;
+				parent->rb_color = RB_RED;
+				__rb_rotate_right(parent, root);
+				other = parent->rb_left;
+			}
+			if ((!other->rb_left ||
+			     other->rb_left->rb_color == RB_BLACK)
+			    && (!other->rb_right ||
+				other->rb_right->rb_color == RB_BLACK))
+			{
+				other->rb_color = RB_RED;
+				node = parent;
+				parent = node->rb_parent;
+			}
+			else
+			{
+				if (!other->rb_left ||
+				    other->rb_left->rb_color == RB_BLACK)
+				{
+					register rb_node_t * o_right;
+					if ((o_right = other->rb_right))
+						o_right->rb_color = RB_BLACK;
+					other->rb_color = RB_RED;
+					__rb_rotate_left(other, root);
+					other = parent->rb_left;
+				}
+				other->rb_color = parent->rb_color;
+				parent->rb_color = RB_BLACK;
+				if (other->rb_left)
+					other->rb_left->rb_color = RB_BLACK;
+				__rb_rotate_right(parent, root);
+				node = root->rb_node;
+				break;
+			}
+		}
+	}
+	if (node)
+		node->rb_color = RB_BLACK;
+}
+
+void rb_erase(rb_node_t * node, rb_root_t * root)
+{
+	rb_node_t * child, * parent;
+	int color;
+
+	if (!node->rb_left)
+		child = node->rb_right;
+	else if (!node->rb_right)
+		child = node->rb_left;
+	else
+	{
+		rb_node_t * old = node, * left;
+
+		node = node->rb_right;
+		while ((left = node->rb_left))
+			node = left;
+		child = node->rb_right;
+		parent = node->rb_parent;
+		color = node->rb_color;
+
+		if (child)
+			child->rb_parent = parent;
+		if (parent)
+		{
+			if (parent->rb_left == node)
+				parent->rb_left = child;
+			else
+				parent->rb_right = child;
+		}
+		else
+			root->rb_node = child;
+
+		if (node->rb_parent == old)
+			parent = node;
+		node->rb_parent = old->rb_parent;
+		node->rb_color = old->rb_color;
+		node->rb_right = old->rb_right;
+		node->rb_left = old->rb_left;
+
+		if (old->rb_parent)
+		{
+			if (old->rb_parent->rb_left == old)
+				old->rb_parent->rb_left = node;
+			else
+				old->rb_parent->rb_right = node;
+		} else
+			root->rb_node = node;
+
+		old->rb_left->rb_parent = node;
+		if (old->rb_right)
+			old->rb_right->rb_parent = node;
+		goto color;
+	}
+
+	parent = node->rb_parent;
+	color = node->rb_color;
+
+	if (child)
+		child->rb_parent = parent;
+	if (parent)
+	{
+		if (parent->rb_left == node)
+			parent->rb_left = child;
+		else
+			parent->rb_right = child;
+	}
+	else
+		root->rb_node = child;
+
+ color:
+	if (color == RB_BLACK)
+		__rb_erase_color(child, parent, root);
+}
diff -urN 2.4.10pre4/mm/filemap.c mmap-rb/mm/filemap.c
--- 2.4.10pre4/mm/filemap.c	Sun Sep  2 20:04:01 2001
+++ mmap-rb/mm/filemap.c	Mon Sep  3 17:32:22 2001
@@ -1798,6 +1798,7 @@
 	unsigned long end, int behavior)
 {
 	struct vm_area_struct * n;
+	struct mm_struct * mm = vma->vm_mm;
 
 	n = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (!n)
@@ -1810,12 +1811,12 @@
 		get_file(n->vm_file);
 	if (n->vm_ops && n->vm_ops->open)
 		n->vm_ops->open(n);
-	lock_vma_mappings(vma);
-	spin_lock(&vma->vm_mm->page_table_lock);
 	vma->vm_pgoff += (end - vma->vm_start) >> PAGE_SHIFT;
+	lock_vma_mappings(vma);
+	spin_lock(&mm->page_table_lock);
 	vma->vm_start = end;
-	__insert_vm_struct(current->mm, n);
-	spin_unlock(&vma->vm_mm->page_table_lock);
+	__insert_vm_struct(mm, n);
+	spin_unlock(&mm->page_table_lock);
 	unlock_vma_mappings(vma);
 	return 0;
 }
@@ -1824,6 +1825,7 @@
 	unsigned long start, int behavior)
 {
 	struct vm_area_struct * n;
+	struct mm_struct * mm = vma->vm_mm;
 
 	n = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (!n)
@@ -1838,10 +1840,10 @@
 	if (n->vm_ops && n->vm_ops->open)
 		n->vm_ops->open(n);
 	lock_vma_mappings(vma);
-	spin_lock(&vma->vm_mm->page_table_lock);
+	spin_lock(&mm->page_table_lock);
 	vma->vm_end = start;
-	__insert_vm_struct(current->mm, n);
-	spin_unlock(&vma->vm_mm->page_table_lock);
+	__insert_vm_struct(mm, n);
+	spin_unlock(&mm->page_table_lock);
 	unlock_vma_mappings(vma);
 	return 0;
 }
@@ -1850,6 +1852,7 @@
 	unsigned long start, unsigned long end, int behavior)
 {
 	struct vm_area_struct * left, * right;
+	struct mm_struct * mm = vma->vm_mm;
 
 	left = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (!left)
@@ -1873,16 +1876,16 @@
 		vma->vm_ops->open(left);
 		vma->vm_ops->open(right);
 	}
-	lock_vma_mappings(vma);
-	spin_lock(&vma->vm_mm->page_table_lock);
 	vma->vm_pgoff += (start - vma->vm_start) >> PAGE_SHIFT;
+	vma->vm_raend = 0;
+	lock_vma_mappings(vma);
+	spin_lock(&mm->page_table_lock);
 	vma->vm_start = start;
 	vma->vm_end = end;
 	setup_read_behavior(vma, behavior);
-	vma->vm_raend = 0;
-	__insert_vm_struct(current->mm, left);
-	__insert_vm_struct(current->mm, right);
-	spin_unlock(&vma->vm_mm->page_table_lock);
+	__insert_vm_struct(mm, left);
+	__insert_vm_struct(mm, right);
+	spin_unlock(&mm->page_table_lock);
 	unlock_vma_mappings(vma);
 	return 0;
 }
diff -urN 2.4.10pre4/mm/mlock.c mmap-rb/mm/mlock.c
--- 2.4.10pre4/mm/mlock.c	Sun Apr  1 01:17:34 2001
+++ mmap-rb/mm/mlock.c	Mon Sep  3 17:32:22 2001
@@ -36,9 +36,9 @@
 		get_file(n->vm_file);
 	if (n->vm_ops && n->vm_ops->open)
 		n->vm_ops->open(n);
+	vma->vm_pgoff += (end - vma->vm_start) >> PAGE_SHIFT;
 	lock_vma_mappings(vma);
 	spin_lock(&vma->vm_mm->page_table_lock);
-	vma->vm_pgoff += (end - vma->vm_start) >> PAGE_SHIFT;
 	vma->vm_start = end;
 	__insert_vm_struct(current->mm, n);
 	spin_unlock(&vma->vm_mm->page_table_lock);
@@ -100,13 +100,13 @@
 		vma->vm_ops->open(left);
 		vma->vm_ops->open(right);
 	}
+	vma->vm_raend = 0;
+	vma->vm_pgoff += (start - vma->vm_start) >> PAGE_SHIFT;
 	lock_vma_mappings(vma);
 	spin_lock(&vma->vm_mm->page_table_lock);
-	vma->vm_pgoff += (start - vma->vm_start) >> PAGE_SHIFT;
 	vma->vm_start = start;
 	vma->vm_end = end;
 	vma->vm_flags = newflags;
-	vma->vm_raend = 0;
 	__insert_vm_struct(current->mm, left);
 	__insert_vm_struct(current->mm, right);
 	spin_unlock(&vma->vm_mm->page_table_lock);
diff -urN 2.4.10pre4/mm/mmap.c mmap-rb/mm/mmap.c
--- 2.4.10pre4/mm/mmap.c	Sat May 26 04:03:50 2001
+++ mmap-rb/mm/mmap.c	Mon Sep  3 17:32:22 2001
@@ -17,6 +17,12 @@
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
 
+/*
+ * WARNING: the debugging will use recursive algorithms so never enable this
+ * unless you know what you are doing.
+ */
+#undef DEBUG_MM_RB
+
 /* description of effects of mapping type and prot in current implementation.
  * this is due to the limited x86 page protection hardware.  The expected
  * behavior is in parens:
@@ -204,14 +210,193 @@
 #undef _trans
 }
 
+#ifdef DEBUG_MM_RB
+static int browse_rb(rb_node_t * rb_node) {
+	int i = 0;
+	if (rb_node) {
+		i++;
+		i += browse_rb(rb_node->rb_left);
+		i += browse_rb(rb_node->rb_right);
+	}
+	return i;
+}
+
+static void validate_mm(struct mm_struct * mm) {
+	int bug = 0;
+	int i = 0;
+	struct vm_area_struct * tmp = mm->mmap;
+	while (tmp) {
+		tmp = tmp->vm_next;
+		i++;
+	}
+	if (i != mm->map_count)
+		printk("map_count %d vm_next %d\n", mm->map_count, i), bug = 1;
+	i = browse_rb(mm->mm_rb.rb_node);
+	if (i != mm->map_count)
+		printk("map_count %d rb %d\n", mm->map_count, i), bug = 1;
+	if (bug)
+		BUG();
+}
+#else
+#define validate_mm(mm) do { } while (0)
+#endif
+
+static struct vm_area_struct * find_vma_prepare(struct mm_struct * mm, unsigned long addr,
+						struct vm_area_struct ** pprev,
+						rb_node_t *** rb_link, rb_node_t ** rb_parent)
+{
+	struct vm_area_struct * vma;
+	rb_node_t ** __rb_link, * __rb_parent, * rb_prev;
+
+	__rb_link = &mm->mm_rb.rb_node;
+	rb_prev = __rb_parent = NULL;
+	vma = NULL;
+
+	while (*__rb_link) {
+		struct vm_area_struct *vma_tmp;
+
+		__rb_parent = *__rb_link;
+		vma_tmp = rb_entry(__rb_parent, struct vm_area_struct, vm_rb);
+
+		if (vma_tmp->vm_end > addr) {
+			vma = vma_tmp;
+			if (vma_tmp->vm_start <= addr)
+				return vma;
+			__rb_link = &__rb_parent->rb_left;
+		} else {
+			rb_prev = __rb_parent;
+			__rb_link = &__rb_parent->rb_right;
+		}
+	}
+
+	*pprev = NULL;
+	if (rb_prev)
+		*pprev = rb_entry(rb_prev, struct vm_area_struct, vm_rb);
+	*rb_link = __rb_link;
+	*rb_parent = __rb_parent;
+	return vma;
+}
+
+static inline void __vma_link_list(struct mm_struct * mm, struct vm_area_struct * vma, struct vm_area_struct * prev,
+				   rb_node_t * rb_parent)
+{
+	if (prev) {
+		vma->vm_next = prev->vm_next;
+		prev->vm_next = vma;
+	} else {
+		mm->mmap = vma;
+		if (rb_parent)
+			vma->vm_next = rb_entry(rb_parent, struct vm_area_struct, vm_rb);
+		else
+			vma->vm_next = NULL;
+	}
+}
+
+static inline void __vma_link_rb(struct mm_struct * mm, struct vm_area_struct * vma,
+				 rb_node_t ** rb_link, rb_node_t * rb_parent)
+{
+	rb_link_node(&vma->vm_rb, rb_parent, rb_link);
+	rb_insert_color(&vma->vm_rb, &mm->mm_rb);
+}
+
+static inline void __vma_link_file(struct vm_area_struct * vma)
+{
+	struct file * file;
+
+	file = vma->vm_file;
+	if (file) {
+		struct inode * inode = file->f_dentry->d_inode;
+		struct address_space *mapping = inode->i_mapping;
+		struct vm_area_struct **head;
+
+		if (vma->vm_flags & VM_DENYWRITE)
+			atomic_dec(&inode->i_writecount);
+
+		head = &mapping->i_mmap;
+		if (vma->vm_flags & VM_SHARED)
+			head = &mapping->i_mmap_shared;
+      
+		/* insert vma into inode's share list */
+		if((vma->vm_next_share = *head) != NULL)
+			(*head)->vm_pprev_share = &vma->vm_next_share;
+		*head = vma;
+		vma->vm_pprev_share = head;
+	}
+}
+
+static void __vma_link(struct mm_struct * mm, struct vm_area_struct * vma,  struct vm_area_struct * prev,
+		       rb_node_t ** rb_link, rb_node_t * rb_parent)
+{
+	__vma_link_list(mm, vma, prev, rb_parent);
+	__vma_link_rb(mm, vma, rb_link, rb_parent);
+	__vma_link_file(vma);
+}
+
+static inline void vma_link(struct mm_struct * mm, struct vm_area_struct * vma, struct vm_area_struct * prev,
+			    rb_node_t ** rb_link, rb_node_t * rb_parent)
+{
+	lock_vma_mappings(vma);
+	spin_lock(&mm->page_table_lock);
+	__vma_link(mm, vma, prev, rb_link, rb_parent);
+	spin_unlock(&mm->page_table_lock);
+	unlock_vma_mappings(vma);
+
+	mm->map_count++;
+	validate_mm(mm);
+}
+
+static int vma_merge(struct mm_struct * mm, struct vm_area_struct * prev,
+		     rb_node_t * rb_parent, unsigned long addr, unsigned long end, unsigned long vm_flags)
+{
+	spinlock_t * lock = &mm->page_table_lock;
+	if (!prev) {
+		prev = rb_entry(rb_parent, struct vm_area_struct, vm_rb);
+		goto merge_next;
+	}
+	if (prev->vm_end == addr && can_vma_merge(prev, vm_flags)) {
+		struct vm_area_struct * next;
+
+		spin_lock(lock);
+		prev->vm_end = end;
+		next = prev->vm_next;
+		if (next && prev->vm_end == next->vm_start && can_vma_merge(next, vm_flags)) {
+			prev->vm_end = next->vm_end;
+			__vma_unlink(mm, next, prev);
+			spin_unlock(lock);
+
+			mm->map_count--;
+			kmem_cache_free(vm_area_cachep, next);
+			return 1;
+		}
+		spin_unlock(lock);
+		return 1;
+	}
+
+	prev = prev->vm_next;
+	if (prev) {
+ merge_next:
+		if (!can_vma_merge(prev, vm_flags))
+			return 0;
+		if (end == prev->vm_start) {
+			spin_lock(lock);
+			prev->vm_start = addr;
+			spin_unlock(lock);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
 unsigned long do_mmap_pgoff(struct file * file, unsigned long addr, unsigned long len,
 	unsigned long prot, unsigned long flags, unsigned long pgoff)
 {
 	struct mm_struct * mm = current->mm;
-	struct vm_area_struct * vma;
+	struct vm_area_struct * vma, * prev;
 	unsigned int vm_flags;
 	int correct_wcount = 0;
 	int error;
+	rb_node_t ** rb_link, * rb_parent;
 
 	if (file && (!file->f_op || !file->f_op->mmap))
 		return -ENODEV;
@@ -292,9 +477,13 @@
 	}
 
 	/* Clear old maps */
-	error = -ENOMEM;
-	if (do_munmap(mm, addr, len))
-		return -ENOMEM;
+ munmap_back:
+	vma = find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
+	if (vma && vma->vm_start < addr + len) {
+		if (do_munmap(mm, addr, len))
+			return -ENOMEM;
+		goto munmap_back;
+	}
 
 	/* Check against address space limit. */
 	if ((mm->total_vm << PAGE_SHIFT) + len
@@ -308,14 +497,9 @@
 		return -ENOMEM;
 
 	/* Can we just expand an old anonymous mapping? */
-	if (addr && !file && !(vm_flags & VM_SHARED)) {
-		struct vm_area_struct * vma = find_vma(mm, addr-1);
-		if (vma && vma->vm_end == addr && !vma->vm_file && 
-		    vma->vm_flags == vm_flags) {
-			vma->vm_end = addr + len;
+	if (!file && !(vm_flags & VM_SHARED) && rb_parent)
+		if (vma_merge(mm, prev, rb_parent, addr, addr + len, vm_flags))
 			goto out;
-		}
-	}
 
 	/* Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
@@ -361,7 +545,7 @@
 	 */
 	addr = vma->vm_start;
 
-	insert_vm_struct(mm, vma);
+	vma_link(mm, vma, prev, rb_link, rb_parent);
 	if (correct_wcount)
 		atomic_inc(&file->f_dentry->d_inode->i_writecount);
 
@@ -436,10 +620,6 @@
 	return arch_get_unmapped_area(file, addr, len, pgoff, flags);
 }
 
-#define vm_avl_empty	(struct vm_area_struct *) NULL
-
-#include "mmap_avl.c"
-
 /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
 struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr)
 {
@@ -450,26 +630,23 @@
 		/* (Cache hit rate is typically around 35%.) */
 		vma = mm->mmap_cache;
 		if (!(vma && vma->vm_end > addr && vma->vm_start <= addr)) {
-			if (!mm->mmap_avl) {
-				/* Go through the linear list. */
-				vma = mm->mmap;
-				while (vma && vma->vm_end <= addr)
-					vma = vma->vm_next;
-			} else {
-				/* Then go through the AVL tree quickly. */
-				struct vm_area_struct * tree = mm->mmap_avl;
-				vma = NULL;
-				for (;;) {
-					if (tree == vm_avl_empty)
+			rb_node_t * rb_node;
+
+			rb_node = mm->mm_rb.rb_node;
+			vma = NULL;
+
+			while (rb_node) {
+				struct vm_area_struct * vma_tmp;
+
+				vma_tmp = rb_entry(rb_node, struct vm_area_struct, vm_rb);
+
+				if (vma_tmp->vm_end > addr) {
+					vma = vma_tmp;
+					if (vma_tmp->vm_start <= addr)
 						break;
-					if (tree->vm_end > addr) {
-						vma = tree;
-						if (tree->vm_start <= addr)
-							break;
-						tree = tree->vm_avl_left;
-					} else
-						tree = tree->vm_avl_right;
-				}
+					rb_node = rb_node->rb_left;
+				} else
+					rb_node = rb_node->rb_right;
 			}
 			if (vma)
 				mm->mmap_cache = vma;
@@ -483,47 +660,42 @@
 				      struct vm_area_struct **pprev)
 {
 	if (mm) {
-		if (!mm->mmap_avl) {
-			/* Go through the linear list. */
-			struct vm_area_struct * prev = NULL;
-			struct vm_area_struct * vma = mm->mmap;
-			while (vma && vma->vm_end <= addr) {
-				prev = vma;
-				vma = vma->vm_next;
-			}
-			*pprev = prev;
-			return vma;
-		} else {
-			/* Go through the AVL tree quickly. */
-			struct vm_area_struct * vma = NULL;
-			struct vm_area_struct * last_turn_right = NULL;
-			struct vm_area_struct * prev = NULL;
-			struct vm_area_struct * tree = mm->mmap_avl;
-			for (;;) {
-				if (tree == vm_avl_empty)
+		/* Go through the RB tree quickly. */
+		struct vm_area_struct * vma;
+		rb_node_t * rb_node, * rb_last_right, * rb_prev;
+		
+		rb_node = mm->mm_rb.rb_node;
+		rb_last_right = rb_prev = NULL;
+		vma = NULL;
+
+		while (rb_node) {
+			struct vm_area_struct * vma_tmp;
+
+			vma_tmp = rb_entry(rb_node, struct vm_area_struct, vm_rb);
+
+			if (vma_tmp->vm_end > addr) {
+				vma = vma_tmp;
+				rb_prev = rb_last_right;
+				if (vma_tmp->vm_start <= addr)
 					break;
-				if (tree->vm_end > addr) {
-					vma = tree;
-					prev = last_turn_right;
-					if (tree->vm_start <= addr)
-						break;
-					tree = tree->vm_avl_left;
-				} else {
-					last_turn_right = tree;
-					tree = tree->vm_avl_right;
-				}
+				rb_node = rb_node->rb_left;
+			} else {
+				rb_last_right = rb_node;
+				rb_node = rb_node->rb_right;
 			}
-			if (vma) {
-				if (vma->vm_avl_left != vm_avl_empty) {
-					prev = vma->vm_avl_left;
-					while (prev->vm_avl_right != vm_avl_empty)
-						prev = prev->vm_avl_right;
-				}
-				if ((prev ? prev->vm_next : mm->mmap) != vma)
-					printk("find_vma_prev: tree inconsistent with list\n");
-				*pprev = prev;
-				return vma;
+		}
+		if (vma) {
+			if (vma->vm_rb.rb_left) {
+				rb_prev = vma->vm_rb.rb_left;
+				while (rb_prev->rb_right)
+					rb_prev = rb_prev->rb_right;
 			}
+			*pprev = NULL;
+			if (rb_prev)
+				*pprev = rb_entry(rb_prev, struct vm_area_struct, vm_rb);
+			if ((rb_prev ? (*pprev)->vm_next : mm->mmap) != vma)
+				BUG();
+			return vma;
 		}
 	}
 	*pprev = NULL;
@@ -598,11 +770,16 @@
 
 	/* Work out to one of the ends. */
 	if (end == area->vm_end) {
+		/*
+		 * here area isn't visible to the semaphore-less readers
+		 * so we don't need to update it under the spinlock.
+		 */
 		area->vm_end = addr;
 		lock_vma_mappings(area);
 		spin_lock(&mm->page_table_lock);
 	} else if (addr == area->vm_start) {
 		area->vm_pgoff += (end - area->vm_start) >> PAGE_SHIFT;
+		/* same locking considerations of the above case */
 		area->vm_start = end;
 		lock_vma_mappings(area);
 		spin_lock(&mm->page_table_lock);
@@ -748,8 +925,7 @@
 		*npp = mpnt->vm_next;
 		mpnt->vm_next = free;
 		free = mpnt;
-		if (mm->mmap_avl)
-			avl_remove(mpnt, &mm->mmap_avl);
+		rb_erase(&mpnt->vm_rb, &mm->mm_rb);
 	}
 	mm->mmap_cache = NULL;	/* Kill the cache. */
 	spin_unlock(&mm->page_table_lock);
@@ -790,6 +966,7 @@
 		if (file)
 			atomic_inc(&file->f_dentry->d_inode->i_writecount);
 	}
+	validate_mm(mm);
 
 	/* Release the extra vma struct if it wasn't used */
 	if (extra)
@@ -819,8 +996,9 @@
 unsigned long do_brk(unsigned long addr, unsigned long len)
 {
 	struct mm_struct * mm = current->mm;
-	struct vm_area_struct * vma;
-	unsigned long flags, retval;
+	struct vm_area_struct * vma, * prev;
+	unsigned long flags;
+	rb_node_t ** rb_link, * rb_parent;
 
 	len = PAGE_ALIGN(len);
 	if (!len)
@@ -839,9 +1017,13 @@
 	/*
 	 * Clear old maps.  this also does some error checking for us
 	 */
-	retval = do_munmap(mm, addr, len);
-	if (retval != 0)
-		return retval;
+ munmap_back:
+	vma = find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
+	if (vma && vma->vm_start < addr + len) {
+		if (do_munmap(mm, addr, len))
+			return -ENOMEM;
+		goto munmap_back;
+	}
 
 	/* Check against address space limits *after* clearing old maps... */
 	if ((mm->total_vm << PAGE_SHIFT) + len
@@ -858,16 +1040,10 @@
 				MAP_FIXED|MAP_PRIVATE) | mm->def_flags;
 
 	flags |= VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
-	
+
 	/* Can we just expand an old anonymous mapping? */
-	if (addr) {
-		struct vm_area_struct * vma = find_vma(mm, addr-1);
-		if (vma && vma->vm_end == addr && !vma->vm_file && 
-		    vma->vm_flags == flags) {
-			vma->vm_end = addr + len;
-			goto out;
-		}
-	}	
+	if (rb_parent && vma_merge(mm, prev, rb_parent, addr, addr + len, flags))
+		goto out;
 
 	/*
 	 * create a vma struct for an anonymous mapping
@@ -886,7 +1062,7 @@
 	vma->vm_file = NULL;
 	vma->vm_private_data = NULL;
 
-	insert_vm_struct(mm, vma);
+	vma_link(mm, vma, prev, rb_link, rb_parent);
 
 out:
 	mm->total_vm += len >> PAGE_SHIFT;
@@ -897,14 +1073,20 @@
 	return addr;
 }
 
-/* Build the AVL tree corresponding to the VMA list. */
-void build_mmap_avl(struct mm_struct * mm)
+/* Build the RB tree corresponding to the VMA list. */
+void build_mmap_rb(struct mm_struct * mm)
 {
 	struct vm_area_struct * vma;
+	rb_node_t ** rb_link, * rb_parent;
 
-	mm->mmap_avl = NULL;
-	for (vma = mm->mmap; vma; vma = vma->vm_next)
-		avl_insert(vma, &mm->mmap_avl);
+	mm->mm_rb = RB_ROOT;
+	rb_link = &mm->mm_rb.rb_node;
+	rb_parent = NULL;
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		__vma_link_rb(mm, vma, rb_link, rb_parent);
+		rb_parent = &vma->vm_rb;
+		rb_link = &rb_parent->rb_right;
+	}
 }
 
 /* Release all mmaps. */
@@ -915,7 +1097,8 @@
 	release_segments(mm);
 	spin_lock(&mm->page_table_lock);
 	mpnt = mm->mmap;
-	mm->mmap = mm->mmap_avl = mm->mmap_cache = NULL;
+	mm->mmap = mm->mmap_cache = NULL;
+	mm->mm_rb = RB_ROOT;
 	mm->rss = 0;
 	spin_unlock(&mm->page_table_lock);
 	mm->total_vm = 0;
@@ -944,7 +1127,7 @@
 
 	/* This is just debugging */
 	if (mm->map_count)
-		printk("exit_mmap: map count is %d\n", mm->map_count);
+		BUG();
 
 	clear_page_tables(mm, FIRST_USER_PGD_NR, USER_PTRS_PER_PGD);
 }
@@ -953,55 +1136,27 @@
  * and into the inode's i_mmap ring.  If vm_file is non-NULL
  * then the i_shared_lock must be held here.
  */
-void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vmp)
+void __insert_vm_struct(struct mm_struct * mm, struct vm_area_struct * vma)
 {
-	struct vm_area_struct **pprev;
-	struct file * file;
-
-	if (!mm->mmap_avl) {
-		pprev = &mm->mmap;
-		while (*pprev && (*pprev)->vm_start <= vmp->vm_start)
-			pprev = &(*pprev)->vm_next;
-	} else {
-		struct vm_area_struct *prev, *next;
-		avl_insert_neighbours(vmp, &mm->mmap_avl, &prev, &next);
-		pprev = (prev ? &prev->vm_next : &mm->mmap);
-		if (*pprev != next)
-			printk("insert_vm_struct: tree inconsistent with list\n");
-	}
-	vmp->vm_next = *pprev;
-	*pprev = vmp;
+	struct vm_area_struct * __vma, * prev;
+	rb_node_t ** rb_link, * rb_parent;
 
+	__vma = find_vma_prepare(mm, vma->vm_start, &prev, &rb_link, &rb_parent);
+	if (__vma && __vma->vm_start < vma->vm_end)
+		BUG();
+	__vma_link(mm, vma, prev, rb_link, rb_parent);
 	mm->map_count++;
-	if (mm->map_count >= AVL_MIN_MAP_COUNT && !mm->mmap_avl)
-		build_mmap_avl(mm);
-
-	file = vmp->vm_file;
-	if (file) {
-		struct inode * inode = file->f_dentry->d_inode;
-		struct address_space *mapping = inode->i_mapping;
-		struct vm_area_struct **head;
-
-		if (vmp->vm_flags & VM_DENYWRITE)
-			atomic_dec(&inode->i_writecount);
-
-		head = &mapping->i_mmap;
-		if (vmp->vm_flags & VM_SHARED)
-			head = &mapping->i_mmap_shared;
-      
-		/* insert vmp into inode's share list */
-		if((vmp->vm_next_share = *head) != NULL)
-			(*head)->vm_pprev_share = &vmp->vm_next_share;
-		*head = vmp;
-		vmp->vm_pprev_share = head;
-	}
+	validate_mm(mm);
 }
 
-void insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vmp)
+void insert_vm_struct(struct mm_struct * mm, struct vm_area_struct * vma)
 {
-	lock_vma_mappings(vmp);
-	spin_lock(&current->mm->page_table_lock);
-	__insert_vm_struct(mm, vmp);
-	spin_unlock(&current->mm->page_table_lock);
-	unlock_vma_mappings(vmp);
+	struct vm_area_struct * __vma, * prev;
+	rb_node_t ** rb_link, * rb_parent;
+
+	__vma = find_vma_prepare(mm, vma->vm_start, &prev, &rb_link, &rb_parent);
+	if (__vma && __vma->vm_start < vma->vm_end)
+		BUG();
+	vma_link(mm, vma, prev, rb_link, rb_parent);
+	validate_mm(mm);
 }
diff -urN 2.4.10pre4/mm/mmap_avl.c mmap-rb/mm/mmap_avl.c
--- 2.4.10pre4/mm/mmap_avl.c	Fri Jan 15 23:41:04 1999
+++ mmap-rb/mm/mmap_avl.c	Thu Jan  1 01:00:00 1970
@@ -1,374 +0,0 @@
-/*
- * Searching a VMA in the linear list task->mm->mmap is horribly slow.
- * Use an AVL (Adelson-Velskii and Landis) tree to speed up this search
- * from O(n) to O(log n), where n is the number of VMAs of the task
- * n is typically around 6, but may reach 3000 in some cases: object-oriented
- * databases, persistent store, generational garbage collection (Java, Lisp),
- * ElectricFence.
- * Written by Bruno Haible <haible@ma2s2.mathematik.uni-karlsruhe.de>.
- */
-
-/* We keep the list and tree sorted by address. */
-#define vm_avl_key	vm_end
-#define vm_avl_key_t	unsigned long	/* typeof(vma->avl_key) */
-
-/*
- * task->mm->mmap_avl is the AVL tree corresponding to task->mm->mmap
- * or, more exactly, its root.
- * A vm_area_struct has the following fields:
- *   vm_avl_left     left son of a tree node
- *   vm_avl_right    right son of a tree node
- *   vm_avl_height   1+max(heightof(left),heightof(right))
- * The empty tree is represented as NULL.
- */
-
-/* Since the trees are balanced, their height will never be large. */
-#define avl_maxheight	41	/* why this? a small exercise */
-#define heightof(tree)	((tree) == vm_avl_empty ? 0 : (tree)->vm_avl_height)
-/*
- * Consistency and balancing rules:
- * 1. tree->vm_avl_height == 1+max(heightof(tree->vm_avl_left),heightof(tree->vm_avl_right))
- * 2. abs( heightof(tree->vm_avl_left) - heightof(tree->vm_avl_right) ) <= 1
- * 3. foreach node in tree->vm_avl_left: node->vm_avl_key <= tree->vm_avl_key,
- *    foreach node in tree->vm_avl_right: node->vm_avl_key >= tree->vm_avl_key.
- */
-
-#ifdef DEBUG_AVL
-
-/* Look up the nodes at the left and at the right of a given node. */
-static void avl_neighbours (struct vm_area_struct * node, struct vm_area_struct * tree, struct vm_area_struct ** to_the_left, struct vm_area_struct ** to_the_right)
-{
-	vm_avl_key_t key = node->vm_avl_key;
-
-	*to_the_left = *to_the_right = NULL;
-	for (;;) {
-		if (tree == vm_avl_empty) {
-			printk("avl_neighbours: node not found in the tree\n");
-			return;
-		}
-		if (key == tree->vm_avl_key)
-			break;
-		if (key < tree->vm_avl_key) {
-			*to_the_right = tree;
-			tree = tree->vm_avl_left;
-		} else {
-			*to_the_left = tree;
-			tree = tree->vm_avl_right;
-		}
-	}
-	if (tree != node) {
-		printk("avl_neighbours: node not exactly found in the tree\n");
-		return;
-	}
-	if (tree->vm_avl_left != vm_avl_empty) {
-		struct vm_area_struct * node;
-		for (node = tree->vm_avl_left; node->vm_avl_right != vm_avl_empty; node = node->vm_avl_right)
-			continue;
-		*to_the_left = node;
-	}
-	if (tree->vm_avl_right != vm_avl_empty) {
-		struct vm_area_struct * node;
-		for (node = tree->vm_avl_right; node->vm_avl_left != vm_avl_empty; node = node->vm_avl_left)
-			continue;
-		*to_the_right = node;
-	}
-	if ((*to_the_left && ((*to_the_left)->vm_next != node)) || (node->vm_next != *to_the_right))
-		printk("avl_neighbours: tree inconsistent with list\n");
-}
-
-#endif
-
-/*
- * Rebalance a tree.
- * After inserting or deleting a node of a tree we have a sequence of subtrees
- * nodes[0]..nodes[k-1] such that
- * nodes[0] is the root and nodes[i+1] = nodes[i]->{vm_avl_left|vm_avl_right}.
- */
-static void avl_rebalance (struct vm_area_struct *** nodeplaces_ptr, int count)
-{
-	for ( ; count > 0 ; count--) {
-		struct vm_area_struct ** nodeplace = *--nodeplaces_ptr;
-		struct vm_area_struct * node = *nodeplace;
-		struct vm_area_struct * nodeleft = node->vm_avl_left;
-		struct vm_area_struct * noderight = node->vm_avl_right;
-		int heightleft = heightof(nodeleft);
-		int heightright = heightof(noderight);
-		if (heightright + 1 < heightleft) {
-			/*                                                      */
-			/*                            *                         */
-			/*                          /   \                       */
-			/*                       n+2      n                     */
-			/*                                                      */
-			struct vm_area_struct * nodeleftleft = nodeleft->vm_avl_left;
-			struct vm_area_struct * nodeleftright = nodeleft->vm_avl_right;
-			int heightleftright = heightof(nodeleftright);
-			if (heightof(nodeleftleft) >= heightleftright) {
-				/*                                                        */
-				/*                *                    n+2|n+3            */
-				/*              /   \                  /    \             */
-				/*           n+2      n      -->      /   n+1|n+2         */
-				/*           / \                      |    /    \         */
-				/*         n+1 n|n+1                 n+1  n|n+1  n        */
-				/*                                                        */
-				node->vm_avl_left = nodeleftright; nodeleft->vm_avl_right = node;
-				nodeleft->vm_avl_height = 1 + (node->vm_avl_height = 1 + heightleftright);
-				*nodeplace = nodeleft;
-			} else {
-				/*                                                        */
-				/*                *                     n+2               */
-				/*              /   \                 /     \             */
-				/*           n+2      n      -->    n+1     n+1           */
-				/*           / \                    / \     / \           */
-				/*          n  n+1                 n   L   R   n          */
-				/*             / \                                        */
-				/*            L   R                                       */
-				/*                                                        */
-				nodeleft->vm_avl_right = nodeleftright->vm_avl_left;
-				node->vm_avl_left = nodeleftright->vm_avl_right;
-				nodeleftright->vm_avl_left = nodeleft;
-				nodeleftright->vm_avl_right = node;
-				nodeleft->vm_avl_height = node->vm_avl_height = heightleftright;
-				nodeleftright->vm_avl_height = heightleft;
-				*nodeplace = nodeleftright;
-			}
-		}
-		else if (heightleft + 1 < heightright) {
-			/* similar to the above, just interchange 'left' <--> 'right' */
-			struct vm_area_struct * noderightright = noderight->vm_avl_right;
-			struct vm_area_struct * noderightleft = noderight->vm_avl_left;
-			int heightrightleft = heightof(noderightleft);
-			if (heightof(noderightright) >= heightrightleft) {
-				node->vm_avl_right = noderightleft; noderight->vm_avl_left = node;
-				noderight->vm_avl_height = 1 + (node->vm_avl_height = 1 + heightrightleft);
-				*nodeplace = noderight;
-			} else {
-				noderight->vm_avl_left = noderightleft->vm_avl_right;
-				node->vm_avl_right = noderightleft->vm_avl_left;
-				noderightleft->vm_avl_right = noderight;
-				noderightleft->vm_avl_left = node;
-				noderight->vm_avl_height = node->vm_avl_height = heightrightleft;
-				noderightleft->vm_avl_height = heightright;
-				*nodeplace = noderightleft;
-			}
-		}
-		else {
-			int height = (heightleft<heightright ? heightright : heightleft) + 1;
-			if (height == node->vm_avl_height)
-				break;
-			node->vm_avl_height = height;
-		}
-	}
-}
-
-/* Insert a node into a tree. */
-static inline void avl_insert (struct vm_area_struct * new_node, struct vm_area_struct ** ptree)
-{
-	vm_avl_key_t key = new_node->vm_avl_key;
-	struct vm_area_struct ** nodeplace = ptree;
-	struct vm_area_struct ** stack[avl_maxheight];
-	int stack_count = 0;
-	struct vm_area_struct *** stack_ptr = &stack[0]; /* = &stack[stackcount] */
-	for (;;) {
-		struct vm_area_struct * node = *nodeplace;
-		if (node == vm_avl_empty)
-			break;
-		*stack_ptr++ = nodeplace; stack_count++;
-		if (key < node->vm_avl_key)
-			nodeplace = &node->vm_avl_left;
-		else
-			nodeplace = &node->vm_avl_right;
-	}
-	new_node->vm_avl_left = vm_avl_empty;
-	new_node->vm_avl_right = vm_avl_empty;
-	new_node->vm_avl_height = 1;
-	*nodeplace = new_node;
-	avl_rebalance(stack_ptr,stack_count);
-}
-
-/* Insert a node into a tree, and
- * return the node to the left of it and the node to the right of it.
- */
-static inline void avl_insert_neighbours (struct vm_area_struct * new_node, struct vm_area_struct ** ptree,
-	struct vm_area_struct ** to_the_left, struct vm_area_struct ** to_the_right)
-{
-	vm_avl_key_t key = new_node->vm_avl_key;
-	struct vm_area_struct ** nodeplace = ptree;
-	struct vm_area_struct ** stack[avl_maxheight];
-	int stack_count = 0;
-	struct vm_area_struct *** stack_ptr = &stack[0]; /* = &stack[stackcount] */
-	*to_the_left = *to_the_right = NULL;
-	for (;;) {
-		struct vm_area_struct * node = *nodeplace;
-		if (node == vm_avl_empty)
-			break;
-		*stack_ptr++ = nodeplace; stack_count++;
-		if (key < node->vm_avl_key) {
-			*to_the_right = node;
-			nodeplace = &node->vm_avl_left;
-		} else {
-			*to_the_left = node;
-			nodeplace = &node->vm_avl_right;
-		}
-	}
-	new_node->vm_avl_left = vm_avl_empty;
-	new_node->vm_avl_right = vm_avl_empty;
-	new_node->vm_avl_height = 1;
-	*nodeplace = new_node;
-	avl_rebalance(stack_ptr,stack_count);
-}
-
-/* Removes a node out of a tree. */
-static void avl_remove (struct vm_area_struct * node_to_delete, struct vm_area_struct ** ptree)
-{
-	vm_avl_key_t key = node_to_delete->vm_avl_key;
-	struct vm_area_struct ** nodeplace = ptree;
-	struct vm_area_struct ** stack[avl_maxheight];
-	int stack_count = 0;
-	struct vm_area_struct *** stack_ptr = &stack[0]; /* = &stack[stackcount] */
-	struct vm_area_struct ** nodeplace_to_delete;
-	for (;;) {
-		struct vm_area_struct * node = *nodeplace;
-#ifdef DEBUG_AVL
-		if (node == vm_avl_empty) {
-			/* what? node_to_delete not found in tree? */
-			printk("avl_remove: node to delete not found in tree\n");
-			return;
-		}
-#endif
-		*stack_ptr++ = nodeplace; stack_count++;
-		if (key == node->vm_avl_key)
-			break;
-		if (key < node->vm_avl_key)
-			nodeplace = &node->vm_avl_left;
-		else
-			nodeplace = &node->vm_avl_right;
-	}
-	nodeplace_to_delete = nodeplace;
-	/* Have to remove node_to_delete = *nodeplace_to_delete. */
-	if (node_to_delete->vm_avl_left == vm_avl_empty) {
-		*nodeplace_to_delete = node_to_delete->vm_avl_right;
-		stack_ptr--; stack_count--;
-	} else {
-		struct vm_area_struct *** stack_ptr_to_delete = stack_ptr;
-		struct vm_area_struct ** nodeplace = &node_to_delete->vm_avl_left;
-		struct vm_area_struct * node;
-		for (;;) {
-			node = *nodeplace;
-			if (node->vm_avl_right == vm_avl_empty)
-				break;
-			*stack_ptr++ = nodeplace; stack_count++;
-			nodeplace = &node->vm_avl_right;
-		}
-		*nodeplace = node->vm_avl_left;
-		/* node replaces node_to_delete */
-		node->vm_avl_left = node_to_delete->vm_avl_left;
-		node->vm_avl_right = node_to_delete->vm_avl_right;
-		node->vm_avl_height = node_to_delete->vm_avl_height;
-		*nodeplace_to_delete = node; /* replace node_to_delete */
-		*stack_ptr_to_delete = &node->vm_avl_left; /* replace &node_to_delete->vm_avl_left */
-	}
-	avl_rebalance(stack_ptr,stack_count);
-}
-
-#ifdef DEBUG_AVL
-
-/* print a list */
-static void printk_list (struct vm_area_struct * vma)
-{
-	printk("[");
-	while (vma) {
-		printk("%08lX-%08lX", vma->vm_start, vma->vm_end);
-		vma = vma->vm_next;
-		if (!vma)
-			break;
-		printk(" ");
-	}
-	printk("]");
-}
-
-/* print a tree */
-static void printk_avl (struct vm_area_struct * tree)
-{
-	if (tree != vm_avl_empty) {
-		printk("(");
-		if (tree->vm_avl_left != vm_avl_empty) {
-			printk_avl(tree->vm_avl_left);
-			printk("<");
-		}
-		printk("%08lX-%08lX", tree->vm_start, tree->vm_end);
-		if (tree->vm_avl_right != vm_avl_empty) {
-			printk(">");
-			printk_avl(tree->vm_avl_right);
-		}
-		printk(")");
-	}
-}
-
-static char *avl_check_point = "somewhere";
-
-/* check a tree's consistency and balancing */
-static void avl_checkheights (struct vm_area_struct * tree)
-{
-	int h, hl, hr;
-
-	if (tree == vm_avl_empty)
-		return;
-	avl_checkheights(tree->vm_avl_left);
-	avl_checkheights(tree->vm_avl_right);
-	h = tree->vm_avl_height;
-	hl = heightof(tree->vm_avl_left);
-	hr = heightof(tree->vm_avl_right);
-	if ((h == hl+1) && (hr <= hl) && (hl <= hr+1))
-		return;
-	if ((h == hr+1) && (hl <= hr) && (hr <= hl+1))
-		return;
-	printk("%s: avl_checkheights: heights inconsistent\n",avl_check_point);
-}
-
-/* check that all values stored in a tree are < key */
-static void avl_checkleft (struct vm_area_struct * tree, vm_avl_key_t key)
-{
-	if (tree == vm_avl_empty)
-		return;
-	avl_checkleft(tree->vm_avl_left,key);
-	avl_checkleft(tree->vm_avl_right,key);
-	if (tree->vm_avl_key < key)
-		return;
-	printk("%s: avl_checkleft: left key %lu >= top key %lu\n",avl_check_point,tree->vm_avl_key,key);
-}
-
-/* check that all values stored in a tree are > key */
-static void avl_checkright (struct vm_area_struct * tree, vm_avl_key_t key)
-{
-	if (tree == vm_avl_empty)
-		return;
-	avl_checkright(tree->vm_avl_left,key);
-	avl_checkright(tree->vm_avl_right,key);
-	if (tree->vm_avl_key > key)
-		return;
-	printk("%s: avl_checkright: right key %lu <= top key %lu\n",avl_check_point,tree->vm_avl_key,key);
-}
-
-/* check that all values are properly increasing */
-static void avl_checkorder (struct vm_area_struct * tree)
-{
-	if (tree == vm_avl_empty)
-		return;
-	avl_checkorder(tree->vm_avl_left);
-	avl_checkorder(tree->vm_avl_right);
-	avl_checkleft(tree->vm_avl_left,tree->vm_avl_key);
-	avl_checkright(tree->vm_avl_right,tree->vm_avl_key);
-}
-
-/* all checks */
-static void avl_check (struct task_struct * task, char *caller)
-{
-	avl_check_point = caller;
-/*	printk("task \"%s\", %s\n",task->comm,caller); */
-/*	printk("task \"%s\" list: ",task->comm); printk_list(task->mm->mmap); printk("\n"); */
-/*	printk("task \"%s\" tree: ",task->comm); printk_avl(task->mm->mmap_avl); printk("\n"); */
-	avl_checkheights(task->mm->mmap_avl);
-	avl_checkorder(task->mm->mmap_avl);
-}
-
-#endif
diff -urN 2.4.10pre4/mm/mprotect.c mmap-rb/mm/mprotect.c
--- 2.4.10pre4/mm/mprotect.c	Sun Apr  1 01:17:34 2001
+++ mmap-rb/mm/mprotect.c	Mon Sep  3 17:32:22 2001
@@ -91,22 +91,52 @@
 	return;
 }
 
-static inline int mprotect_fixup_all(struct vm_area_struct * vma,
+static inline int mprotect_fixup_all(struct vm_area_struct * vma, struct vm_area_struct ** pprev,
 	int newflags, pgprot_t prot)
 {
-	spin_lock(&vma->vm_mm->page_table_lock);
+	struct vm_area_struct * prev = *pprev;
+	struct mm_struct * mm = vma->vm_mm;
+
+	if (prev && prev->vm_end == vma->vm_start && can_vma_merge(prev, newflags) &&
+	    !vma->vm_file && !(vma->vm_flags & VM_SHARED)) {
+		spin_lock(&mm->page_table_lock);
+		prev->vm_end = vma->vm_end;
+		__vma_unlink(mm, vma, prev);
+		spin_unlock(&mm->page_table_lock);
+
+		kmem_cache_free(vm_area_cachep, vma);
+		mm->map_count--;
+
+		return 0;
+	}
+
+	spin_lock(&mm->page_table_lock);
 	vma->vm_flags = newflags;
 	vma->vm_page_prot = prot;
-	spin_unlock(&vma->vm_mm->page_table_lock);
+	spin_unlock(&mm->page_table_lock);
+
+	*pprev = vma;
+
 	return 0;
 }
 
-static inline int mprotect_fixup_start(struct vm_area_struct * vma,
+static inline int mprotect_fixup_start(struct vm_area_struct * vma, struct vm_area_struct ** pprev,
 	unsigned long end,
 	int newflags, pgprot_t prot)
 {
-	struct vm_area_struct * n;
+	struct vm_area_struct * n, * prev = *pprev;
+
+	*pprev = vma;
+
+	if (prev && prev->vm_end == vma->vm_start && can_vma_merge(prev, newflags) &&
+	    !vma->vm_file && !(vma->vm_flags & VM_SHARED)) {
+		spin_lock(&vma->vm_mm->page_table_lock);
+		prev->vm_end = end;
+		vma->vm_start = end;
+		spin_unlock(&vma->vm_mm->page_table_lock);
 
+		return 0;
+	}
 	n = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (!n)
 		return -ENOMEM;
@@ -119,17 +149,18 @@
 		get_file(n->vm_file);
 	if (n->vm_ops && n->vm_ops->open)
 		n->vm_ops->open(n);
+	vma->vm_pgoff += (end - vma->vm_start) >> PAGE_SHIFT;
 	lock_vma_mappings(vma);
 	spin_lock(&vma->vm_mm->page_table_lock);
-	vma->vm_pgoff += (end - vma->vm_start) >> PAGE_SHIFT;
 	vma->vm_start = end;
 	__insert_vm_struct(current->mm, n);
 	spin_unlock(&vma->vm_mm->page_table_lock);
 	unlock_vma_mappings(vma);
+
 	return 0;
 }
 
-static inline int mprotect_fixup_end(struct vm_area_struct * vma,
+static inline int mprotect_fixup_end(struct vm_area_struct * vma, struct vm_area_struct ** pprev,
 	unsigned long start,
 	int newflags, pgprot_t prot)
 {
@@ -154,10 +185,13 @@
 	__insert_vm_struct(current->mm, n);
 	spin_unlock(&vma->vm_mm->page_table_lock);
 	unlock_vma_mappings(vma);
+
+	*pprev = n;
+
 	return 0;
 }
 
-static inline int mprotect_fixup_middle(struct vm_area_struct * vma,
+static inline int mprotect_fixup_middle(struct vm_area_struct * vma, struct vm_area_struct ** pprev,
 	unsigned long start, unsigned long end,
 	int newflags, pgprot_t prot)
 {
@@ -184,39 +218,44 @@
 		vma->vm_ops->open(left);
 		vma->vm_ops->open(right);
 	}
+	vma->vm_pgoff += (start - vma->vm_start) >> PAGE_SHIFT;
+	vma->vm_raend = 0;
+	vma->vm_page_prot = prot;
 	lock_vma_mappings(vma);
 	spin_lock(&vma->vm_mm->page_table_lock);
-	vma->vm_pgoff += (start - vma->vm_start) >> PAGE_SHIFT;
 	vma->vm_start = start;
 	vma->vm_end = end;
 	vma->vm_flags = newflags;
-	vma->vm_raend = 0;
-	vma->vm_page_prot = prot;
 	__insert_vm_struct(current->mm, left);
 	__insert_vm_struct(current->mm, right);
 	spin_unlock(&vma->vm_mm->page_table_lock);
 	unlock_vma_mappings(vma);
+
+	*pprev = right;
+
 	return 0;
 }
 
-static int mprotect_fixup(struct vm_area_struct * vma, 
+static int mprotect_fixup(struct vm_area_struct * vma, struct vm_area_struct ** pprev,
 	unsigned long start, unsigned long end, unsigned int newflags)
 {
 	pgprot_t newprot;
 	int error;
 
-	if (newflags == vma->vm_flags)
+	if (newflags == vma->vm_flags) {
+		*pprev = vma;
 		return 0;
+	}
 	newprot = protection_map[newflags & 0xf];
 	if (start == vma->vm_start) {
 		if (end == vma->vm_end)
-			error = mprotect_fixup_all(vma, newflags, newprot);
+			error = mprotect_fixup_all(vma, pprev, newflags, newprot);
 		else
-			error = mprotect_fixup_start(vma, end, newflags, newprot);
+			error = mprotect_fixup_start(vma, pprev, end, newflags, newprot);
 	} else if (end == vma->vm_end)
-		error = mprotect_fixup_end(vma, start, newflags, newprot);
+		error = mprotect_fixup_end(vma, pprev, start, newflags, newprot);
 	else
-		error = mprotect_fixup_middle(vma, start, end, newflags, newprot);
+		error = mprotect_fixup_middle(vma, pprev, start, end, newflags, newprot);
 
 	if (error)
 		return error;
@@ -228,7 +267,7 @@
 asmlinkage long sys_mprotect(unsigned long start, size_t len, unsigned long prot)
 {
 	unsigned long nstart, end, tmp;
-	struct vm_area_struct * vma, * next;
+	struct vm_area_struct * vma, * next, * prev;
 	int error = -EINVAL;
 
 	if (start & ~PAGE_MASK)
@@ -242,41 +281,55 @@
 	if (end == start)
 		return 0;
 
-	/* XXX: maybe this could be down_read ??? - Rik */
 	down_write(&current->mm->mmap_sem);
 
-	vma = find_vma(current->mm, start);
+	vma = find_vma_prev(current->mm, start, &prev);
 	error = -EFAULT;
 	if (!vma || vma->vm_start > start)
 		goto out;
 
 	for (nstart = start ; ; ) {
 		unsigned int newflags;
+		int last = 0;
 
 		/* Here we know that  vma->vm_start <= nstart < vma->vm_end. */
 
 		newflags = prot | (vma->vm_flags & ~(PROT_READ | PROT_WRITE | PROT_EXEC));
 		if ((newflags & ~(newflags >> 4)) & 0xf) {
 			error = -EACCES;
-			break;
+			goto out;
 		}
 
-		if (vma->vm_end >= end) {
-			error = mprotect_fixup(vma, nstart, end, newflags);
-			break;
+		if (vma->vm_end > end) {
+			error = mprotect_fixup(vma, &prev, nstart, end, newflags);
+			goto out;
 		}
+		if (vma->vm_end == end)
+			last = 1;
 
 		tmp = vma->vm_end;
 		next = vma->vm_next;
-		error = mprotect_fixup(vma, nstart, tmp, newflags);
+		error = mprotect_fixup(vma, &prev, nstart, tmp, newflags);
 		if (error)
+			goto out;
+		if (last)
 			break;
 		nstart = tmp;
 		vma = next;
 		if (!vma || vma->vm_start != nstart) {
 			error = -EFAULT;
-			break;
+			goto out;
 		}
+	}
+	if (next && prev->vm_end == next->vm_start && can_vma_merge(next, prev->vm_flags) &&
+	    !prev->vm_file && !(prev->vm_flags & VM_SHARED)) {
+		spin_lock(&prev->vm_mm->page_table_lock);
+		prev->vm_end = next->vm_end;
+		__vma_unlink(prev->vm_mm, next, prev);
+		spin_unlock(&prev->vm_mm->page_table_lock);
+
+		kmem_cache_free(vm_area_cachep, next);
+		prev->vm_mm->map_count--;
 	}
 out:
 	up_write(&current->mm->mmap_sem);
diff -urN 2.4.10pre4/mm/mremap.c mmap-rb/mm/mremap.c
--- 2.4.10pre4/mm/mremap.c	Tue May  1 19:35:33 2001
+++ mmap-rb/mm/mremap.c	Mon Sep  3 17:32:22 2001
@@ -127,11 +127,58 @@
 	unsigned long addr, unsigned long old_len, unsigned long new_len,
 	unsigned long new_addr)
 {
-	struct vm_area_struct * new_vma;
+	struct mm_struct * mm = vma->vm_mm;
+	struct vm_area_struct * new_vma, * next, * prev;
+	int allocated_vma;
 
-	new_vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
-	if (new_vma) {
-		if (!move_page_tables(current->mm, new_addr, addr, old_len)) {
+	new_vma = NULL;
+	next = find_vma_prev(mm, new_addr, &prev);
+	if (next) {
+		if (prev && prev->vm_end == new_addr &&
+		    can_vma_merge(prev, vma->vm_flags) && !vma->vm_file && !(vma->vm_flags & VM_SHARED)) {
+			spin_lock(&mm->page_table_lock);
+			prev->vm_end = new_addr + new_len;
+			spin_unlock(&mm->page_table_lock);
+			new_vma = prev;
+			if (next != prev->vm_next)
+				BUG();
+			if (prev->vm_end == next->vm_start && can_vma_merge(next, prev->vm_flags)) {
+				spin_lock(&mm->page_table_lock);
+				prev->vm_end = next->vm_end;
+				__vma_unlink(mm, next, prev);
+				spin_unlock(&mm->page_table_lock);
+
+				mm->map_count--;
+				kmem_cache_free(vm_area_cachep, next);
+			}
+		} else if (next->vm_start == new_addr + new_len &&
+			   can_vma_merge(next, vma->vm_flags) && !vma->vm_file && !(vma->vm_flags & VM_SHARED)) {
+			spin_lock(&mm->page_table_lock);
+			next->vm_start = new_addr;
+			spin_unlock(&mm->page_table_lock);
+			new_vma = next;
+		}
+	} else {
+		prev = find_vma(mm, new_addr-1);
+		if (prev && prev->vm_end == new_addr &&
+		    can_vma_merge(prev, vma->vm_flags) && !vma->vm_file && !(vma->vm_flags & VM_SHARED)) {
+			spin_lock(&mm->page_table_lock);
+			prev->vm_end = new_addr + new_len;
+			spin_unlock(&mm->page_table_lock);
+			new_vma = prev;
+		}
+	}
+
+	allocated_vma = 0;
+	if (!new_vma) {
+		new_vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+		if (!new_vma)
+			goto out;
+		allocated_vma = 1;
+	}
+
+	if (!move_page_tables(current->mm, new_addr, addr, old_len)) {
+		if (allocated_vma) {
 			*new_vma = *vma;
 			new_vma->vm_start = new_addr;
 			new_vma->vm_end = new_addr+new_len;
@@ -142,17 +189,19 @@
 			if (new_vma->vm_ops && new_vma->vm_ops->open)
 				new_vma->vm_ops->open(new_vma);
 			insert_vm_struct(current->mm, new_vma);
-			do_munmap(current->mm, addr, old_len);
-			current->mm->total_vm += new_len >> PAGE_SHIFT;
-			if (new_vma->vm_flags & VM_LOCKED) {
-				current->mm->locked_vm += new_len >> PAGE_SHIFT;
-				make_pages_present(new_vma->vm_start,
-						   new_vma->vm_end);
-			}
-			return new_addr;
 		}
-		kmem_cache_free(vm_area_cachep, new_vma);
+		do_munmap(current->mm, addr, old_len);
+		current->mm->total_vm += new_len >> PAGE_SHIFT;
+		if (new_vma->vm_flags & VM_LOCKED) {
+			current->mm->locked_vm += new_len >> PAGE_SHIFT;
+			make_pages_present(new_vma->vm_start,
+					   new_vma->vm_end);
+		}
+		return new_addr;
 	}
+	if (allocated_vma)
+		kmem_cache_free(vm_area_cachep, new_vma);
+ out:
 	return -ENOMEM;
 }
 

It's also here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.10pre4/mmap-rb-7

Andrea
