Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUEMTPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUEMTPl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264488AbUEMTPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:15:41 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:48107 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S264443AbUEMTNf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:13:35 -0400
Date: Thu, 13 May 2004 21:13:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (1/6): core s390.
Message-ID: <20040513191329.GB2916@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: core changes.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

s390 core changes:
 - Rename idle_cpu_mask to nohz_cpu_mask as agreed with Dipankar.
 - Refine compiler version check for "Q" constraints in uaccess.h.
 - Store per process ptrace information to the correct place.
 - Fix per cpu data access for 64-bit modules.
 - Add topology_init function for cpu hotplug.
 - Define TASK_SIZE dependent on TIF_31BIT and define MM_VM_SIZE
   to 4TB to get rid of elf_map32 and arch_get_unmapped_area.

diffstat:
 arch/s390/defconfig             |    3 ++-
 arch/s390/kernel/binfmt_elf32.c |   23 +----------------------
 arch/s390/kernel/compat_exec.c  |    3 ---
 arch/s390/kernel/entry.S        |   16 +++++++++-------
 arch/s390/kernel/entry64.S      |   16 +++++++++-------
 arch/s390/kernel/module.c       |    3 ++-
 arch/s390/kernel/smp.c          |   19 +++++++++++++++++++
 arch/s390/kernel/sys_s390.c     |   32 --------------------------------
 arch/s390/kernel/time.c         |    6 +++---
 arch/s390/mm/init.c             |    2 +-
 include/asm-s390/percpu.h       |   20 ++++++++++++++++++--
 include/asm-s390/pgtable.h      |    4 ----
 include/asm-s390/processor.h    |   11 +++++++----
 include/asm-s390/uaccess.h      |    4 ++--
 include/linux/sched.h           |    2 +-
 kernel/rcupdate.c               |    2 +-
 kernel/sched.c                  |    6 +++---
 17 files changed, 78 insertions(+), 94 deletions(-)

diff -urN linux-2.6/arch/s390/defconfig linux-2.6-s390/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	Mon May 10 04:33:13 2004
+++ linux-2.6-s390/arch/s390/defconfig	Thu May 13 21:00:53 2004
@@ -433,7 +433,6 @@
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
-# CONFIG_INTERMEZZO_FS is not set
 # CONFIG_AFS_FS is not set
 
 #
@@ -505,9 +504,11 @@
 # CONFIG_CRYPTO_ARC4 is not set
 # CONFIG_CRYPTO_DEFLATE is not set
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_TEST is not set
 
 #
 # Library routines
 #
 # CONFIG_CRC32 is not set
+# CONFIG_LIBCRC32C is not set
diff -urN linux-2.6/arch/s390/kernel/binfmt_elf32.c linux-2.6-s390/arch/s390/kernel/binfmt_elf32.c
--- linux-2.6/arch/s390/kernel/binfmt_elf32.c	Mon May 10 04:33:19 2004
+++ linux-2.6-s390/arch/s390/kernel/binfmt_elf32.c	Thu May 13 21:00:53 2004
@@ -32,10 +32,6 @@
 #define NUM_FPRS      16
 #define NUM_ACRS      16    
 
-#define TASK31_SIZE		(0x80000000UL)
-#undef TASK_SIZE
-#define TASK_SIZE TASK31_SIZE
-
 /* For SVR4/S390 the function pointer to be registered with `atexit` is
    passed in R14. */
 #define ELF_PLAT_INIT(_r, load_addr) \
@@ -51,7 +47,7 @@
    the loader.  We need to make sure that it is out of the way of the program
    that it will "exec", and that there is sufficient room for the brk.  */
 
-#define ELF_ET_DYN_BASE         (TASK31_SIZE / 3 * 2)
+#define ELF_ET_DYN_BASE         (TASK_SIZE / 3 * 2)
 
 /* Wow, the "main" arch needs arch dependent functions too.. :) */
 
@@ -169,7 +165,6 @@
 #undef start_thread
 #define start_thread                    start_thread31 
 #define setup_arg_pages(bprm, exec)     setup_arg_pages32(bprm, exec)
-#define elf_map				elf_map32
 
 MODULE_DESCRIPTION("Binary format loader for compatibility with 32bit Linux for S390 binaries,"
                    " Copyright 2000 IBM Corporation"); 
@@ -188,19 +183,3 @@
 
 #include "../../../fs/binfmt_elf.c"
 
-static unsigned long
-elf_map32 (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type)
-{
-	unsigned long map_addr;
-
-	if (!addr) 
-		addr = TASK_UNMAPPED_BASE;
-
-	down_write(&current->mm->mmap_sem);
-	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
-			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr),
-			   prot, type,
-			   eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
-	up_write(&current->mm->mmap_sem);
-	return(map_addr);
-}
diff -urN linux-2.6/arch/s390/kernel/compat_exec.c linux-2.6-s390/arch/s390/kernel/compat_exec.c
--- linux-2.6/arch/s390/kernel/compat_exec.c	Mon May 10 04:33:19 2004
+++ linux-2.6-s390/arch/s390/kernel/compat_exec.c	Thu May 13 21:00:53 2004
@@ -34,9 +34,6 @@
 #endif
 
 
-#undef STACK_TOP
-#define STACK_TOP TASK31_SIZE
-
 int setup_arg_pages32(struct linux_binprm *bprm, int executable_stack)
 {
 	unsigned long stack_base;
diff -urN linux-2.6/arch/s390/kernel/entry.S linux-2.6-s390/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	Mon May 10 04:32:02 2004
+++ linux-2.6-s390/arch/s390/kernel/entry.S	Thu May 13 21:00:53 2004
@@ -471,9 +471,10 @@
 pgm_per_std:
 	SAVE_ALL __LC_PGM_OLD_PSW,__LC_SAVE_AREA,1
 	GET_THREAD_INFO
-	mvc	__THREAD_per+__PER_atmid(2,%r9),__LC_PER_ATMID
-	mvc	__THREAD_per+__PER_address(4,%r9),__LC_PER_ADDRESS
-	mvc	__THREAD_per+__PER_access_id(1,%r9),__LC_PER_ACCESS_ID
+	l	%r1,__TI_task(%r9)
+	mvc	__THREAD_per+__PER_atmid(2,%r1),__LC_PER_ATMID
+	mvc	__THREAD_per+__PER_address(4,%r1),__LC_PER_ADDRESS
+	mvc	__THREAD_per+__PER_access_id(1,%r1),__LC_PER_ACCESS_ID
 	la	%r4,0x7f
 	l	%r3,__LC_PGM_ILC	 # load program interruption code
         nr      %r4,%r3                  # clear per-event-bit and ilc
@@ -495,11 +496,12 @@
 pgm_svcper:
 	SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
 	lh	%r7,0x8a	  # get svc number from lowcore
-        stosm   24(%r15),0x03     # reenable interrupts
         GET_THREAD_INFO           # load pointer to task_struct to R9
-	mvc	__THREAD_per+__PER_atmid(2,%r9),__LC_PER_ATMID
-	mvc	__THREAD_per+__PER_address(4,%r9),__LC_PER_ADDRESS
-	mvc	__THREAD_per+__PER_access_id(1,%r9),__LC_PER_ACCESS_ID
+	l	%r1,__TI_task(%r9)
+	mvc	__THREAD_per+__PER_atmid(2,%r1),__LC_PER_ATMID
+	mvc	__THREAD_per+__PER_address(4,%r1),__LC_PER_ADDRESS
+	mvc	__THREAD_per+__PER_access_id(1,%r1),__LC_PER_ACCESS_ID
+        stosm   24(%r15),0x03     # reenable interrupts
         sla     %r7,2             # *4 and test for svc 0
 	bnz	BASED(pgm_svcstd) # svc number > 0 ?
 	# svc 0: system call number in %r1
diff -urN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-s390/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	Mon May 10 04:32:02 2004
+++ linux-2.6-s390/arch/s390/kernel/entry64.S	Thu May 13 21:00:53 2004
@@ -505,9 +505,10 @@
 pgm_per_std:
 	SAVE_ALL __LC_PGM_OLD_PSW,__LC_SAVE_AREA,1
 	GET_THREAD_INFO
-	mvc	__THREAD_per+__PER_atmid(2,%r9),__LC_PER_ATMID
-	mvc	__THREAD_per+__PER_address(8,%r9),__LC_PER_ADDRESS
-	mvc	__THREAD_per+__PER_access_id(1,%r9),__LC_PER_ACCESS_ID
+	lg	%r1,__TI_task(%r9)
+	mvc	__THREAD_per+__PER_atmid(2,%r1),__LC_PER_ATMID
+	mvc	__THREAD_per+__PER_address(8,%r1),__LC_PER_ADDRESS
+	mvc	__THREAD_per+__PER_access_id(1,%r1),__LC_PER_ACCESS_ID
 	lghi    %r4,0x7f
 	lgf     %r3,__LC_PGM_ILC	 # load program interruption code
         nr      %r4,%r3			 # clear per-event-bit and ilc
@@ -528,11 +529,12 @@
 pgm_svcper:
 	SAVE_ALL __LC_SVC_OLD_PSW,__LC_SAVE_AREA,1
 	llgh    %r7,__LC_SVC_INT_CODE # get svc number from lowcore
-	stosm   48(%r15),0x03     # reenable interrupts
         GET_THREAD_INFO           # load pointer to task_struct to R9
-	mvc	__THREAD_per+__PER_atmid(2,%r9),__LC_PER_ATMID
-	mvc	__THREAD_per+__PER_address(8,%r9),__LC_PER_ADDRESS
-	mvc	__THREAD_per+__PER_access_id(1,%r9),__LC_PER_ACCESS_ID
+	lg	%r1,__TI_task(%r9)
+	mvc	__THREAD_per+__PER_atmid(2,%r1),__LC_PER_ATMID
+	mvc	__THREAD_per+__PER_address(8,%r1),__LC_PER_ADDRESS
+	mvc	__THREAD_per+__PER_access_id(1,%r1),__LC_PER_ACCESS_ID
+	stosm   48(%r15),0x03     # reenable interrupts
 	slag	%r7,%r7,2         # *4 and test for svc 0
 	jnz	pgm_svcstd
 	# svc 0: system call number in %r1
diff -urN linux-2.6/arch/s390/kernel/module.c linux-2.6-s390/arch/s390/kernel/module.c
--- linux-2.6/arch/s390/kernel/module.c	Mon May 10 04:33:19 2004
+++ linux-2.6-s390/arch/s390/kernel/module.c	Thu May 13 21:00:53 2004
@@ -277,7 +277,8 @@
 			*(unsigned int *) loc = val;
 		else if (r_type == R_390_GOTENT ||
 			 r_type == R_390_GOTPLTENT)
-			*(unsigned int *) loc = val >> 1;
+			*(unsigned int *) loc =
+				(val + (Elf_Addr) me->module_core - loc) >> 1;
 		else if (r_type == R_390_GOT64 ||
 			 r_type == R_390_GOTPLT64)
 			*(unsigned long *) loc = val;
diff -urN linux-2.6/arch/s390/kernel/smp.c linux-2.6-s390/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	Thu May 13 21:00:43 2004
+++ linux-2.6-s390/arch/s390/kernel/smp.c	Thu May 13 21:00:53 2004
@@ -31,6 +31,7 @@
 #include <linux/delay.h>
 #include <linux/cache.h>
 #include <linux/interrupt.h>
+#include <linux/cpu.h>
 
 #include <asm/sigp.h>
 #include <asm/pgalloc.h>
@@ -651,6 +652,24 @@
         return 0;
 }
 
+static DEFINE_PER_CPU(struct cpu, cpu_devices);
+
+static int __init topology_init(void)
+{
+	int cpu;
+	int ret;
+
+	for_each_cpu(cpu) {
+		ret = register_cpu(&per_cpu(cpu_devices, cpu), cpu, NULL);
+		if (ret)
+			printk(KERN_WARNING "topology_init: register_cpu %d "
+			       "failed (%d)\n", cpu, ret);
+	}
+	return 0;
+}
+
+subsys_initcall(topology_init);
+
 EXPORT_SYMBOL(cpu_possible_map);
 EXPORT_SYMBOL(lowcore_ptr);
 EXPORT_SYMBOL(smp_ctl_set_bit);
diff -urN linux-2.6/arch/s390/kernel/sys_s390.c linux-2.6-s390/arch/s390/kernel/sys_s390.c
--- linux-2.6/arch/s390/kernel/sys_s390.c	Mon May 10 04:32:28 2004
+++ linux-2.6-s390/arch/s390/kernel/sys_s390.c	Thu May 13 21:00:53 2004
@@ -138,38 +138,6 @@
 	return sys_select(a.n, a.inp, a.outp, a.exp, a.tvp);
 
 }
-#else /* CONFIG_ARCH_S390X */
-unsigned long
-arch_get_unmapped_area(struct file *filp, unsigned long addr,
-		       unsigned long len, unsigned long pgoff,
-		       unsigned long flags)
-{
-	struct vm_area_struct *vma;
-	unsigned long end;
-
-	if (test_thread_flag(TIF_31BIT)) { 
-		if (!addr) 
-			addr = 0x40000000; 
-		end = 0x80000000;		
-	} else { 
-		if (!addr) 
-			addr = TASK_SIZE / 2;
-		end = TASK_SIZE; 
-	}
-
-	if (len > end)
-		return -ENOMEM;
-	addr = PAGE_ALIGN(addr);
-
-	for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
-		/* At this point:  (!vma || addr < vma->vm_end). */
-		if (end - len < addr)
-			return -ENOMEM;
-		if (!vma || addr + len <= vma->vm_start)
-			return addr;
-		addr = vma->vm_end;
-	}
-}
 #endif /* CONFIG_ARCH_S390X */
 
 /*
diff -urN linux-2.6/arch/s390/kernel/time.c linux-2.6-s390/arch/s390/kernel/time.c
--- linux-2.6/arch/s390/kernel/time.c	Mon May 10 04:31:58 2004
+++ linux-2.6-s390/arch/s390/kernel/time.c	Thu May 13 21:00:53 2004
@@ -468,7 +468,7 @@
 	__u64 tmp;
 	__u32 ticks;
 
-	if (!cpu_isset(smp_processor_id(), idle_cpu_mask))
+	if (!cpu_isset(smp_processor_id(), nohz_cpu_mask))
 		return;
 
 	/* Calculate how many ticks have passed */
@@ -511,7 +511,7 @@
 			do_timer(regs);
 #endif
 	}
-	cpu_clear(smp_processor_id(), idle_cpu_mask);
+	cpu_clear(smp_processor_id(), nohz_cpu_mask);
 }
 
 /*
@@ -536,7 +536,7 @@
 	 * This cpu is going really idle. Set up the clock comparator
 	 * for the next event.
 	 */
-	cpu_set(smp_processor_id(), idle_cpu_mask);
+	cpu_set(smp_processor_id(), nohz_cpu_mask);
 	timer = (__u64) (next_timer_interrupt() - jiffies) + jiffies_64;
 	timer = jiffies_timer_cc + timer * CLK_TICKS_PER_JIFFY;
 	asm volatile ("SCKC %0" : : "m" (timer));
diff -urN linux-2.6/arch/s390/mm/init.c linux-2.6-s390/arch/s390/mm/init.c
--- linux-2.6/arch/s390/mm/init.c	Mon May 10 04:32:54 2004
+++ linux-2.6-s390/arch/s390/mm/init.c	Thu May 13 21:00:53 2004
@@ -69,7 +69,7 @@
                 else if (PageSwapCache(mem_map+i))
                         cached++;
                 else if (page_count(mem_map+i))
-                        shared += atomic_read(&mem_map[i].count) - 1;
+                        shared += page_count(mem_map+i) - 1;
         }
         printk("%d pages of RAM\n",total);
         printk("%d reserved pages\n",reserved);
diff -urN linux-2.6/include/asm-s390/percpu.h linux-2.6-s390/include/asm-s390/percpu.h
--- linux-2.6/include/asm-s390/percpu.h	Mon May 10 04:33:20 2004
+++ linux-2.6-s390/include/asm-s390/percpu.h	Thu May 13 21:00:53 2004
@@ -5,10 +5,26 @@
 #include <asm/lowcore.h>
 
 /*
- * s390 uses the generic implementation for per cpu data, with the exception that
- * the offset of the cpu local data area is cached in the cpu's lowcore memory
+ * For builtin kernel code s390 uses the generic implementation for
+ * per cpu data, with the exception that the offset of the cpu local
+ * data area is cached in the cpu's lowcore memory
+ * For 64 bit module code s390 forces the use of a GOT slot for the
+ * address of the per cpu variable. This is needed because the module
+ * may be more than 4G above the per cpu area.
  */
+#if defined(__s390x__) && defined(MODULE)
+#define __get_got_cpu_var(var,offset) \
+  (*({ unsigned long *__ptr; \
+       asm ( "larl %0,per_cpu__"#var"@GOTENT" : "=a" (__ptr) ); \
+       ((typeof(&per_cpu__##var))((*__ptr) + offset)); \
+    }))
+#undef __get_cpu_var
+#define __get_cpu_var(var) __get_got_cpu_var(var,S390_lowcore.percpu_offset)
+#undef per_cpu
+#define per_cpu(var,cpu) __get_got_cpu_var(var,__per_cpu_offset[cpu])
+#else
 #undef __get_cpu_var
 #define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, S390_lowcore.percpu_offset))
+#endif
 
 #endif /* __ARCH_S390_PERCPU__ */
diff -urN linux-2.6/include/asm-s390/pgtable.h linux-2.6-s390/include/asm-s390/pgtable.h
--- linux-2.6/include/asm-s390/pgtable.h	Mon May 10 04:33:13 2004
+++ linux-2.6-s390/include/asm-s390/pgtable.h	Thu May 13 21:00:53 2004
@@ -784,10 +784,6 @@
  */
 #define pgtable_cache_init()	do { } while (0)
 
-#ifdef __s390x__
-# define HAVE_ARCH_UNMAPPED_AREA
-#endif /* __s390x__ */
-
 #define __HAVE_ARCH_PTEP_ESTABLISH
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
diff -urN linux-2.6/include/asm-s390/processor.h linux-2.6-s390/include/asm-s390/processor.h
--- linux-2.6/include/asm-s390/processor.h	Mon May 10 04:32:29 2004
+++ linux-2.6-s390/include/asm-s390/processor.h	Thu May 13 21:00:53 2004
@@ -63,16 +63,19 @@
 
 # define TASK_SIZE		(0x80000000UL)
 # define TASK_UNMAPPED_BASE	(TASK_SIZE / 2)
+# define DEFAULT_TASK_SIZE	(0x80000000UL)
 
 #else /* __s390x__ */
 
-# define TASK_SIZE		(0x40000000000UL)
-# define TASK31_SIZE		(0x80000000UL)
-# define TASK_UNMAPPED_BASE	(test_thread_flag(TIF_31BIT) ? \
-					(TASK31_SIZE / 2) : (TASK_SIZE / 2))
+# define TASK_SIZE		(test_thread_flag(TIF_31BIT) ? \
+					(0x80000000UL) : (0x40000000000UL))
+# define TASK_UNMAPPED_BASE	(TASK_SIZE / 2)
+# define DEFAULT_TASK_SIZE	(0x40000000000UL)
 
 #endif /* __s390x__ */
 
+#define MM_VM_SIZE(mm)		DEFAULT_TASK_SIZE
+
 typedef struct {
         __u32 ar4;
 } mm_segment_t;
diff -urN linux-2.6/include/asm-s390/uaccess.h linux-2.6-s390/include/asm-s390/uaccess.h
--- linux-2.6/include/asm-s390/uaccess.h	Mon May 10 04:32:02 2004
+++ linux-2.6-s390/include/asm-s390/uaccess.h	Thu May 13 21:00:53 2004
@@ -119,7 +119,7 @@
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.
  */
-#if __GNUC__ > 2
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
 #define __put_user_asm(x, ptr, err) \
 ({								\
 	err = 0;						\
@@ -174,7 +174,7 @@
 
 extern int __put_user_bad(void);
 
-#if __GNUC__ > 2
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
 #define __get_user_asm(x, ptr, err) \
 ({								\
 	err = 0;						\
diff -urN linux-2.6/include/linux/sched.h linux-2.6-s390/include/linux/sched.h
--- linux-2.6/include/linux/sched.h	Thu May 13 21:00:46 2004
+++ linux-2.6-s390/include/linux/sched.h	Thu May 13 21:00:53 2004
@@ -150,7 +150,7 @@
 extern void sched_init_smp(void);
 extern void init_idle(task_t *idle, int cpu);
 
-extern cpumask_t idle_cpu_mask;
+extern cpumask_t nohz_cpu_mask;
 
 extern void show_state(void);
 extern void show_regs(struct pt_regs *);
diff -urN linux-2.6/kernel/rcupdate.c linux-2.6-s390/kernel/rcupdate.c
--- linux-2.6/kernel/rcupdate.c	Thu May 13 21:00:48 2004
+++ linux-2.6-s390/kernel/rcupdate.c	Thu May 13 21:00:53 2004
@@ -113,7 +113,7 @@
 		return;
 	}
 	/* Can't change, since spin lock held. */
-	active = idle_cpu_mask;
+	active = nohz_cpu_mask;
 	cpus_complement(active);
 	cpus_and(rcu_ctrlblk.rcu_cpu_mask, cpu_online_map, active);
 }
diff -urN linux-2.6/kernel/sched.c linux-2.6-s390/kernel/sched.c
--- linux-2.6/kernel/sched.c	Thu May 13 21:00:48 2004
+++ linux-2.6-s390/kernel/sched.c	Thu May 13 21:00:53 2004
@@ -3246,13 +3246,13 @@
 }
 
 /*
- * In a system that switches off the HZ timer idle_cpu_mask
+ * In a system that switches off the HZ timer nohz_cpu_mask
  * indicates which cpus entered this state. This is used
  * in the rcu update to wait only for active cpus. For system
- * which do not switch off the HZ timer idle_cpu_mask should
+ * which do not switch off the HZ timer nohz_cpu_mask should
  * always be CPU_MASK_NONE.
  */
-cpumask_t idle_cpu_mask = CPU_MASK_NONE;
+cpumask_t nohz_cpu_mask = CPU_MASK_NONE;
 
 #ifdef CONFIG_SMP
 /*
