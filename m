Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262540AbVGMVSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbVGMVSy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 17:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262604AbVGMVQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 17:16:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:10980 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262311AbVGMSpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:45:33 -0400
Date: Wed, 13 Jul 2005 11:44:26 -0700
From: Greg KH <gregkh@suse.de>
To: suresh.b.siddha@intel.com, ak@suse.de
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [11/11] x86_64: TASK_SIZE fixes for compatibility mode processes
Message-ID: <20050713184426.GM9330@kroah.com>
References: <20050713184130.GA9330@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713184130.GA9330@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Suresh Siddha <suresh.b.siddha@intel.com>

Appended patch will setup compatibility mode TASK_SIZE properly.  This will
fix atleast three known bugs that can be encountered while running
compatibility mode apps.

a) A malicious 32bit app can have an elf section at 0xffffe000.  During
   exec of this app, we will have a memory leak as insert_vm_struct() is
   not checking for return value in syscall32_setup_pages() and thus not
   freeing the vma allocated for the vsyscall page.  And instead of exec
   failing (as it has addresses > TASK_SIZE), we were allowing it to
   succeed previously.

b) With a 32bit app, hugetlb_get_unmapped_area/arch_get_unmapped_area
   may return addresses beyond 32bits, ultimately causing corruption
   because of wrap-around and resulting in SEGFAULT, instead of returning
   ENOMEM.

c) 32bit app doing this below mmap will now fail.

  mmap((void *)(0xFFFFE000UL), 0x10000UL, PROT_READ|PROT_WRITE,
	MAP_FIXED|MAP_PRIVATE|MAP_ANON, 0, 0);

Signed-off-by: Zou Nan hai <nanhai.zou@intel.com>
Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Andi Kleen <ak@muc.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/x86_64/ia32/ia32_binfmt.c  |    5 +----
 arch/x86_64/kernel/process.c    |    4 ++--
 arch/x86_64/kernel/ptrace.c     |   17 ++++++++++-------
 arch/x86_64/kernel/sys_x86_64.c |   14 ++++----------
 arch/x86_64/mm/fault.c          |    2 +-
 include/asm-x86_64/a.out.h      |    2 +-
 include/asm-x86_64/processor.h  |   11 ++++++-----
 7 files changed, 25 insertions(+), 30 deletions(-)

--- linux-2.6.12.2.orig/arch/x86_64/ia32/ia32_binfmt.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.2/arch/x86_64/ia32/ia32_binfmt.c	2005-07-13 10:56:37.000000000 -0700
@@ -46,7 +46,7 @@
 
 #define IA32_EMULATOR 1
 
-#define ELF_ET_DYN_BASE		(TASK_UNMAPPED_32 + 0x1000000)
+#define ELF_ET_DYN_BASE		(TASK_UNMAPPED_BASE + 0x1000000)
 
 #undef ELF_ARCH
 #define ELF_ARCH EM_386
@@ -307,9 +307,6 @@
 
 #define elf_addr_t __u32
 
-#undef TASK_SIZE
-#define TASK_SIZE 0xffffffff
-
 static void elf32_init(struct pt_regs *);
 
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
--- linux-2.6.12.2.orig/arch/x86_64/kernel/process.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.2/arch/x86_64/kernel/process.c	2005-07-13 10:56:37.000000000 -0700
@@ -656,7 +656,7 @@
 
 	switch (code) { 
 	case ARCH_SET_GS:
-		if (addr >= TASK_SIZE) 
+		if (addr >= TASK_SIZE_OF(task))
 			return -EPERM; 
 		cpu = get_cpu();
 		/* handle small bases via the GDT because that's faster to 
@@ -682,7 +682,7 @@
 	case ARCH_SET_FS:
 		/* Not strictly needed for fs, but do it for symmetry
 		   with gs */
-		if (addr >= TASK_SIZE)
+		if (addr >= TASK_SIZE_OF(task))
 			return -EPERM; 
 		cpu = get_cpu();
 		/* handle small bases via the GDT because that's faster to 
--- linux-2.6.12.2.orig/arch/x86_64/kernel/ptrace.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.2/arch/x86_64/kernel/ptrace.c	2005-07-13 10:56:37.000000000 -0700
@@ -257,12 +257,12 @@
 			value &= 0xffff;
 			return 0;
 		case offsetof(struct user_regs_struct,fs_base):
-			if (value >= TASK_SIZE)
+			if (value >= TASK_SIZE_OF(child))
 				return -EIO;
 			child->thread.fs = value;
 			return 0;
 		case offsetof(struct user_regs_struct,gs_base):
-			if (value >= TASK_SIZE)
+			if (value >= TASK_SIZE_OF(child))
 				return -EIO;
 			child->thread.gs = value;
 			return 0;
@@ -279,7 +279,7 @@
 			break;
 		case offsetof(struct user_regs_struct, rip):
 			/* Check if the new RIP address is canonical */
-			if (value >= TASK_SIZE)
+			if (value >= TASK_SIZE_OF(child))
 				return -EIO;
 			break;
 	}
@@ -419,6 +419,8 @@
 		break;
 
 	case PTRACE_POKEUSR: /* write the word at location addr in the USER area */
+	{
+		int dsize = test_tsk_thread_flag(child, TIF_IA32) ? 3 : 7;
 		ret = -EIO;
 		if ((addr & 7) ||
 		    addr > sizeof(struct user) - 7)
@@ -430,22 +432,22 @@
 			break;
 		/* Disallows to set a breakpoint into the vsyscall */
 		case offsetof(struct user, u_debugreg[0]):
-			if (data >= TASK_SIZE-7) break;
+			if (data >= TASK_SIZE_OF(child) - dsize) break;
 			child->thread.debugreg0 = data;
 			ret = 0;
 			break;
 		case offsetof(struct user, u_debugreg[1]):
-			if (data >= TASK_SIZE-7) break;
+			if (data >= TASK_SIZE_OF(child) - dsize) break;
 			child->thread.debugreg1 = data;
 			ret = 0;
 			break;
 		case offsetof(struct user, u_debugreg[2]):
-			if (data >= TASK_SIZE-7) break;
+			if (data >= TASK_SIZE_OF(child) - dsize) break;
 			child->thread.debugreg2 = data;
 			ret = 0;
 			break;
 		case offsetof(struct user, u_debugreg[3]):
-			if (data >= TASK_SIZE-7) break;
+			if (data >= TASK_SIZE_OF(child) - dsize) break;
 			child->thread.debugreg3 = data;
 			ret = 0;
 			break;
@@ -469,6 +471,7 @@
 		  break;
 		}
 		break;
+	}
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT:    /* restart after signal. */
 
--- linux-2.6.12.2.orig/arch/x86_64/kernel/sys_x86_64.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.2/arch/x86_64/kernel/sys_x86_64.c	2005-07-13 10:56:37.000000000 -0700
@@ -68,13 +68,7 @@
 static void find_start_end(unsigned long flags, unsigned long *begin,
 			   unsigned long *end)
 {
-#ifdef CONFIG_IA32_EMULATION
-	if (test_thread_flag(TIF_IA32)) { 
-		*begin = TASK_UNMAPPED_32;
-		*end = IA32_PAGE_OFFSET; 
-	} else 
-#endif
-	if (flags & MAP_32BIT) { 
+	if (!test_thread_flag(TIF_IA32) && (flags & MAP_32BIT)) {
 		/* This is usually used needed to map code in small
 		   model, so it needs to be in the first 31bit. Limit
 		   it to that.  This means we need to move the
@@ -84,10 +78,10 @@
 		   of playground for now. -AK */ 
 		*begin = 0x40000000; 
 		*end = 0x80000000;		
-	} else { 
-		*begin = TASK_UNMAPPED_64; 
+	} else {
+		*begin = TASK_UNMAPPED_BASE;
 		*end = TASK_SIZE; 
-		}
+	}
 } 
 
 unsigned long
--- linux-2.6.12.2.orig/arch/x86_64/mm/fault.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.2/arch/x86_64/mm/fault.c	2005-07-13 10:56:37.000000000 -0700
@@ -350,7 +350,7 @@
 	 * (error_code & 4) == 0, and that the fault was not a
 	 * protection error (error_code & 1) == 0.
 	 */
-	if (unlikely(address >= TASK_SIZE)) {
+	if (unlikely(address >= TASK_SIZE64)) {
 		if (!(error_code & 5) &&
 		      ((address >= VMALLOC_START && address < VMALLOC_END) ||
 		       (address >= MODULES_VADDR && address < MODULES_END))) {
--- linux-2.6.12.2.orig/include/asm-x86_64/a.out.h	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.2/include/asm-x86_64/a.out.h	2005-07-13 10:56:37.000000000 -0700
@@ -21,7 +21,7 @@
 
 #ifdef __KERNEL__
 #include <linux/thread_info.h>
-#define STACK_TOP (test_thread_flag(TIF_IA32) ? IA32_PAGE_OFFSET : TASK_SIZE)
+#define STACK_TOP TASK_SIZE
 #endif
 
 #endif /* __A_OUT_GNU_H__ */
--- linux-2.6.12.2.orig/include/asm-x86_64/processor.h	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.2/include/asm-x86_64/processor.h	2005-07-13 10:56:37.000000000 -0700
@@ -160,16 +160,17 @@
 /*
  * User space process size. 47bits minus one guard page.
  */
-#define TASK_SIZE	(0x800000000000UL - 4096)
+#define TASK_SIZE64	(0x800000000000UL - 4096)
 
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
 #define IA32_PAGE_OFFSET ((current->personality & ADDR_LIMIT_3GB) ? 0xc0000000 : 0xFFFFe000)
-#define TASK_UNMAPPED_32 PAGE_ALIGN(IA32_PAGE_OFFSET/3)
-#define TASK_UNMAPPED_64 PAGE_ALIGN(TASK_SIZE/3) 
-#define TASK_UNMAPPED_BASE	\
-	(test_thread_flag(TIF_IA32) ? TASK_UNMAPPED_32 : TASK_UNMAPPED_64)  
+
+#define TASK_SIZE 		(test_thread_flag(TIF_IA32) ? IA32_PAGE_OFFSET : TASK_SIZE64)
+#define TASK_SIZE_OF(child) 	((test_tsk_thread_flag(child, TIF_IA32)) ? IA32_PAGE_OFFSET : TASK_SIZE64)
+
+#define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE/3)
 
 /*
  * Size of io_bitmap.
