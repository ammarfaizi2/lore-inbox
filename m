Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVFBUjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVFBUjW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVFBUhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:37:34 -0400
Received: from fmr24.intel.com ([143.183.121.16]:17091 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261232AbVFBUdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:33:08 -0400
Date: Thu, 2 Jun 2005 13:32:56 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: discuss@x86-64.org, linux-kernel@vger.kernel.org, ak@suse.de
Cc: akpm@osdl.org, nanhai.zou@intel.com, rohit.seth@intel.com,
       rajesh.shah@intel.com
Subject: [Patch] x86_64: TASK_SIZE fixes for compatibility mode processes
Message-ID: <20050602133256.A14384@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is another take at this patch.
(previously posted by Nanhai http://www.x86-64.org/lists/discuss/msg06556.html)

This needs to be considered for 2.6.12, as this patch fixes critical issues
(memory leak, hugetlb 32bit app failure). See below for more details.

Based on Andi's suggestions, we have gone through the code which uses 
TASK_SIZE and even though our patch doesn't break any of the existing things, 
we used TASK_SIZE_OF at some of the places to be safe.

Please apply.

thanks,
suresh
--

Appended patch will setup compatibility mode TASK_SIZE properly. This
will fix atleast three known bugs that can be encountered while running
compatibility mode apps.

a) A malicious 32bit app can have an elf section at 0xffffe000. During
exec of this app, we will have a memory leak as insert_vm_struct() is
not checking for return value in syscall32_setup_pages() and thus not
freeing the vma allocated for the vsyscall page. And instead of exec failing
(as it has addresses > TASK_SIZE), we were allowing it to succeed previously.

b) With a 32bit app, hugetlb_get_unmapped_area/arch_get_unmapped_area may
return addresses beyond 32bits, ultimately causing corruption because of 
wrap-around and resulting in SEGFAULT, instead of returning ENOMEM.

c) 32bit app doing this below mmap will now fail.
  mmap((void *)(0xFFFFE000UL), 0x10000UL, PROT_READ|PROT_WRITE,
	MAP_FIXED|MAP_PRIVATE|MAP_ANON, 0, 0);


Signed-off-by: Zou Nan hai <nanhai.zou@intel.com>
Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com> 

diff -Nru linux-2.6.12-rc4-mm2/arch/x86_64/ia32/ia32_binfmt.c linux-compat/arch/x86_64/ia32/ia32_binfmt.c
--- linux-2.6.12-rc4-mm2/arch/x86_64/ia32/ia32_binfmt.c	2005-05-06 22:20:31.000000000 -0700
+++ linux-compat/arch/x86_64/ia32/ia32_binfmt.c	2005-05-24 15:48:18.204190792 -0700
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
diff -Nru linux-2.6.12-rc4-mm2/arch/x86_64/kernel/process.c linux-compat/arch/x86_64/kernel/process.c
--- linux-2.6.12-rc4-mm2/arch/x86_64/kernel/process.c	2005-05-24 10:43:13.334953896 -0700
+++ linux-compat/arch/x86_64/kernel/process.c	2005-05-24 17:19:39.224948984 -0700
@@ -683,7 +683,7 @@
 
 	switch (code) { 
 	case ARCH_SET_GS:
-		if (addr >= TASK_SIZE) 
+		if (addr >= TASK_SIZE_OF(task)) 
 			return -EPERM; 
 		cpu = get_cpu();
 		/* handle small bases via the GDT because that's faster to 
@@ -709,7 +709,7 @@
 	case ARCH_SET_FS:
 		/* Not strictly needed for fs, but do it for symmetry
 		   with gs */
-		if (addr >= TASK_SIZE)
+		if (addr >= TASK_SIZE_OF(task))
 			return -EPERM; 
 		cpu = get_cpu();
 		/* handle small bases via the GDT because that's faster to 
diff -Nru linux-2.6.12-rc4-mm2/arch/x86_64/kernel/ptrace.c linux-compat/arch/x86_64/kernel/ptrace.c
--- linux-2.6.12-rc4-mm2/arch/x86_64/kernel/ptrace.c	2005-05-24 10:43:13.335953744 -0700
+++ linux-compat/arch/x86_64/kernel/ptrace.c	2005-05-24 18:09:22.411435704 -0700
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
 
diff -Nru linux-2.6.12-rc4-mm2/arch/x86_64/kernel/sys_x86_64.c linux-compat/arch/x86_64/kernel/sys_x86_64.c
--- linux-2.6.12-rc4-mm2/arch/x86_64/kernel/sys_x86_64.c	2005-05-24 10:43:13.339953136 -0700
+++ linux-compat/arch/x86_64/kernel/sys_x86_64.c	2005-05-24 15:48:18.204190792 -0700
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
diff -Nru linux-2.6.12-rc4-mm2/arch/x86_64/mm/fault.c linux-compat/arch/x86_64/mm/fault.c
--- linux-2.6.12-rc4-mm2/arch/x86_64/mm/fault.c	2005-05-24 10:43:13.344952376 -0700
+++ linux-compat/arch/x86_64/mm/fault.c	2005-05-24 17:11:57.811094552 -0700
@@ -350,7 +350,7 @@
 	 * (error_code & 4) == 0, and that the fault was not a
 	 * protection error (error_code & 1) == 0.
 	 */
-	if (unlikely(address >= TASK_SIZE)) {
+	if (unlikely(address >= TASK_SIZE64)) {
 		if (!(error_code & 5) &&
 		      ((address >= VMALLOC_START && address < VMALLOC_END) ||
 		       (address >= MODULES_VADDR && address < MODULES_END))) {
diff -Nru linux-2.6.12-rc4-mm2/include/asm-x86_64/a.out.h linux-compat/include/asm-x86_64/a.out.h
--- linux-2.6.12-rc4-mm2/include/asm-x86_64/a.out.h	2005-05-06 22:20:31.000000000 -0700
+++ linux-compat/include/asm-x86_64/a.out.h	2005-05-24 15:48:18.206190488 -0700
@@ -21,7 +21,7 @@
 
 #ifdef __KERNEL__
 #include <linux/thread_info.h>
-#define STACK_TOP (test_thread_flag(TIF_IA32) ? IA32_PAGE_OFFSET : TASK_SIZE)
+#define STACK_TOP TASK_SIZE
 #endif
 
 #endif /* __A_OUT_GNU_H__ */
diff -Nru linux-2.6.12-rc4-mm2/include/asm-x86_64/processor.h linux-compat/include/asm-x86_64/processor.h
--- linux-2.6.12-rc4-mm2/include/asm-x86_64/processor.h	2005-05-24 10:43:14.692747480 -0700
+++ linux-compat/include/asm-x86_64/processor.h	2005-05-24 18:28:13.675457432 -0700
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
