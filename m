Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVA0U2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVA0U2b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVA0U2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:28:31 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:55556 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261163AbVA0U1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:27:25 -0500
Date: Thu, 27 Jan 2005 20:27:21 +0000
From: Arjan van de Ven <arjan@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
Message-ID: <20050127202720.GA12390@infradead.org>
References: <20050127101117.GA9760@infradead.org> <20050127101322.GE9760@infradead.org> <20050127202335.GA2033@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127202335.GA2033@infradead.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Jan 27, 2005 at 08:23:35PM +0000, Christoph Hellwig wrote:
> > +		p = arch_align_stack((unsigned long)p);
> 
> looking at the code p already is unsigned long, so the cast is not needed.

yeah

how about this one instead ?


The patch below replaces the existing 8Kb randomisation of the userspace
stack pointer (which is currently only done for Hyperthreaded P-IVs) with a
more general randomisation over a 64Kb range. 64Kb is not a lot, but it's a
start and once the dust settles we can increase this value to a more
agressive value.


Signed-off-by Arjan van de Ven <arjanv@redhat.com>

diff -purN step1/arch/i386/kernel/process.c step2/arch/i386/kernel/process.c
--- step1/arch/i386/kernel/process.c	2005-01-26 18:24:35.000000000 +0100
+++ step2/arch/i386/kernel/process.c	2005-01-27 21:10:19.000000000 +0100
@@ -36,6 +36,7 @@
 #include <linux/module.h>
 #include <linux/kallsyms.h>
 #include <linux/ptrace.h>
+#include <linux/random.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -828,3 +829,9 @@ asmlinkage int sys_get_thread_area(struc
 	return 0;
 }
 
+unsigned long arch_align_stack(unsigned long sp)
+{
+	if (randomize_va_space)
+		sp -= ((get_random_int() % 4096) << 4);
+	return sp & ~0xf;
+}
diff -purN step1/arch/x86_64/kernel/process.c step2/arch/x86_64/kernel/process.c
--- step1/arch/x86_64/kernel/process.c	2005-01-26 18:24:49.000000000 +0100
+++ step2/arch/x86_64/kernel/process.c	2005-01-27 21:10:19.000000000 +0100
@@ -743,3 +743,10 @@ int dump_task_regs(struct task_struct *t
  
 	return 1;
 }
+
+unsigned long arch_align_stack(unsigned long sp)
+{
+	if (randomize_vs_space)
+		sp -= ((get_random_int() % 4096) << 4);
+	return sp & ~0xf;
+}
diff -purN step1/fs/binfmt_elf.c step2/fs/binfmt_elf.c
--- step1/fs/binfmt_elf.c	2005-01-27 21:09:32.000000000 +0100
+++ step2/fs/binfmt_elf.c	2005-01-27 21:18:58.000000000 +0100
@@ -165,21 +165,14 @@ create_elf_tables(struct linux_binprm *b
 	if (k_platform) {
 		size_t len = strlen(k_platform) + 1;
 
-#ifdef CONFIG_X86_HT
 		/*
 		 * In some cases (e.g. Hyper-Threading), we want to avoid L1
 		 * evictions by the processes running on the same package. One
 		 * thing we can do is to shuffle the initial stack for them.
-		 *
-		 * The conditionals here are unneeded, but kept in to make the
-		 * code behaviour the same as pre change unless we have
-		 * hyperthreaded processors. This should be cleaned up
-		 * before 2.6
 		 */
 	 
-		if (smp_num_siblings > 1)
-			STACK_ALLOC(p, ((current->pid % 64) << 7));
-#endif
+		p = arch_align_stack(p);
+
 		u_platform = (elf_addr_t __user *)STACK_ALLOC(p, len);
 		if (__copy_to_user(u_platform, k_platform, len))
 			return -EFAULT;
diff -purN step1/fs/exec.c step2/fs/exec.c
--- step1/fs/exec.c	2005-01-27 21:09:32.000000000 +0100
+++ step2/fs/exec.c	2005-01-27 21:18:37.000000000 +0100
@@ -400,7 +400,8 @@ int setup_arg_pages(struct linux_binprm 
 	while (i < MAX_ARG_PAGES)
 		bprm->page[i++] = NULL;
 #else
-	stack_base = stack_top - MAX_ARG_PAGES * PAGE_SIZE;
+	stack_base = arch_align_stack(STACK_TOP - MAX_ARG_PAGES*PAGE_SIZE);
+	stack_base = PAGE_ALIGN(stack_base);
 	bprm->p += stack_base;
 	mm->arg_start = bprm->p;
 	arg_size = stack_top - (PAGE_MASK & (unsigned long) mm->arg_start);
diff -purN step1/include/asm-alpha/system.h step2/include/asm-alpha/system.h
--- step1/include/asm-alpha/system.h	2004-12-24 22:34:58.000000000 +0100
+++ step2/include/asm-alpha/system.h	2005-01-27 21:16:20.000000000 +0100
@@ -621,4 +621,6 @@ __cmpxchg(volatile void *ptr, unsigned l
 
 #endif /* __ASSEMBLY__ */
 
+#define arch_align_stack(x) (x)
+
 #endif
diff -purN step1/include/asm-arm/system.h step2/include/asm-arm/system.h
--- step1/include/asm-arm/system.h	2004-12-24 22:34:00.000000000 +0100
+++ step2/include/asm-arm/system.h	2005-01-27 21:16:37.000000000 +0100
@@ -383,6 +383,8 @@ static inline unsigned long __xchg(unsig
 
 #endif /* __ASSEMBLY__ */
 
+#define arch_align_stack(x) (x)
+
 #endif /* __KERNEL__ */
 
 #endif
diff -purN step1/include/asm-arm26/system.h step2/include/asm-arm26/system.h
--- step1/include/asm-arm26/system.h	2005-01-26 18:24:39.000000000 +0100
+++ step2/include/asm-arm26/system.h	2005-01-27 21:16:33.000000000 +0100
@@ -245,6 +245,8 @@ static inline unsigned long __xchg(unsig
 
 #endif /* __ASSEMBLY__ */
 
+#define arch_align_stack(x) (x)
+
 #endif /* __KERNEL__ */
 
 #endif
diff -purN step1/include/asm-cris/system.h step2/include/asm-cris/system.h
--- step1/include/asm-cris/system.h	2004-12-24 22:34:58.000000000 +0100
+++ step2/include/asm-cris/system.h	2005-01-27 21:16:41.000000000 +0100
@@ -69,4 +69,6 @@ extern inline unsigned long __xchg(unsig
   return x;
 }
 
+#define arch_align_stack(x) (x)
+
 #endif
diff -purN step1/include/asm-frv/system.h step2/include/asm-frv/system.h
--- step1/include/asm-frv/system.h	2005-01-26 18:24:39.000000000 +0100
+++ step2/include/asm-frv/system.h	2005-01-27 21:16:46.000000000 +0100
@@ -120,4 +120,6 @@ do {						\
 extern void die_if_kernel(const char *, ...) __attribute__((format(printf, 1, 2)));
 extern void free_initmem(void);
 
+#define arch_align_stack(x) (x)
+
 #endif /* _ASM_SYSTEM_H */
diff -purN step1/include/asm-h8300/system.h step2/include/asm-h8300/system.h
--- step1/include/asm-h8300/system.h	2004-12-24 22:34:33.000000000 +0100
+++ step2/include/asm-h8300/system.h	2005-01-27 21:16:49.000000000 +0100
@@ -144,4 +144,6 @@ static inline unsigned long __xchg(unsig
         asm("jmp @@0");			\
 })
 
+#define arch_align_stack(x) (x)
+
 #endif /* _H8300_SYSTEM_H */
diff -purN step1/include/asm-i386/system.h step2/include/asm-i386/system.h
--- step1/include/asm-i386/system.h	2005-01-26 18:24:39.000000000 +0100
+++ step2/include/asm-i386/system.h	2005-01-27 21:13:41.000000000 +0100
@@ -468,4 +468,6 @@ void enable_hlt(void);
 extern int es7000_plat;
 void cpu_idle_wait(void);
 
+extern unsigned long arch_align_stack(unsigned long sp);
+
 #endif
diff -purN step1/include/asm-ia64/system.h step2/include/asm-ia64/system.h
--- step1/include/asm-ia64/system.h	2005-01-26 18:24:39.000000000 +0100
+++ step2/include/asm-ia64/system.h	2005-01-27 21:17:08.000000000 +0100
@@ -285,6 +285,9 @@ do {						\
 #define ia64_platform_is(x) (strcmp(x, platform_name) == 0)
 
 void cpu_idle_wait(void);
+
+#define arch_align_stack(x) (x)
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
diff -purN step1/include/asm-m32r/system.h step2/include/asm-m32r/system.h
--- step1/include/asm-m32r/system.h	2005-01-26 18:24:39.000000000 +0100
+++ step2/include/asm-m32r/system.h	2005-01-27 21:17:13.000000000 +0100
@@ -294,4 +294,6 @@ static __inline__ unsigned long __xchg(u
 #define set_mb(var, value) do { xchg(&var, value); } while (0)
 #define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
+#define arch_align_stack(x) (x)
+
 #endif  /* _ASM_M32R_SYSTEM_H */
diff -purN step1/include/asm-m68k/system.h step2/include/asm-m68k/system.h
--- step1/include/asm-m68k/system.h	2004-12-24 22:35:23.000000000 +0100
+++ step2/include/asm-m68k/system.h	2005-01-27 21:17:25.000000000 +0100
@@ -194,6 +194,8 @@ static inline unsigned long __cmpxchg(vo
 					(unsigned long)(n),sizeof(*(ptr))))
 #endif
 
+#define arch_align_stack(x) (x)
+
 #endif /* __KERNEL__ */
 
 #endif /* _M68K_SYSTEM_H */
diff -purN step1/include/asm-m68knommu/system.h step2/include/asm-m68knommu/system.h
--- step1/include/asm-m68knommu/system.h	2004-12-24 22:35:00.000000000 +0100
+++ step2/include/asm-m68knommu/system.h	2005-01-27 21:17:21.000000000 +0100
@@ -281,5 +281,6 @@ cmpxchg(volatile int *p, int old, int ne
 })
 #endif
 #endif
+#define arch_align_stack(x) (x)
 
 #endif /* _M68KNOMMU_SYSTEM_H */
diff -purN step1/include/asm-mips/system.h step2/include/asm-mips/system.h
--- step1/include/asm-mips/system.h	2004-12-24 22:34:32.000000000 +0100
+++ step2/include/asm-mips/system.h	2005-01-27 21:17:29.000000000 +0100
@@ -433,4 +433,6 @@ do {						\
 #define finish_arch_switch(rq, prev)	spin_unlock_irq(&(prev)->switch_lock)
 #define task_running(rq, p) 		((rq)->curr == (p) || spin_is_locked(&(p)->switch_lock))
 
+#define arch_align_stack(x) (x)
+
 #endif /* _ASM_SYSTEM_H */
diff -purN step1/include/asm-parisc/system.h step2/include/asm-parisc/system.h
--- step1/include/asm-parisc/system.h	2005-01-26 18:24:39.000000000 +0100
+++ step2/include/asm-parisc/system.h	2005-01-27 21:17:36.000000000 +0100
@@ -205,4 +205,6 @@ extern spinlock_t pa_tlb_lock;
 
 #endif
 
+#define arch_align_stack(x) (x)
+
 #endif
diff -purN step1/include/asm-ppc/system.h step2/include/asm-ppc/system.h
--- step1/include/asm-ppc/system.h	2005-01-26 18:24:39.000000000 +0100
+++ step2/include/asm-ppc/system.h	2005-01-27 21:17:43.000000000 +0100
@@ -201,5 +201,7 @@ __cmpxchg(volatile void *ptr, unsigned l
 				    (unsigned long)_n_, sizeof(*(ptr))); \
   })
 
+#define arch_align_stack(x) (x)
+
 #endif /* __KERNEL__ */
 #endif /* __PPC_SYSTEM_H */
diff -purN step1/include/asm-ppc64/system.h step2/include/asm-ppc64/system.h
--- step1/include/asm-ppc64/system.h	2005-01-26 18:24:39.000000000 +0100
+++ step2/include/asm-ppc64/system.h	2005-01-27 21:17:39.000000000 +0100
@@ -300,5 +300,7 @@ __cmpxchg(volatile void *ptr, unsigned l
  */
 #define NET_IP_ALIGN   0
 
+#define arch_align_stack(x) (x)
+
 #endif /* __KERNEL__ */
 #endif
diff -purN step1/include/asm-s390/system.h step2/include/asm-s390/system.h
--- step1/include/asm-s390/system.h	2005-01-26 18:24:39.000000000 +0100
+++ step2/include/asm-s390/system.h	2005-01-27 21:17:46.000000000 +0100
@@ -461,6 +461,8 @@ extern void (*_machine_restart)(char *co
 extern void (*_machine_halt)(void);
 extern void (*_machine_power_off)(void);
 
+#define arch_align_stack(x) (x)
+
 #endif /* __KERNEL__ */
 
 #endif
diff -purN step1/include/asm-sh/system.h step2/include/asm-sh/system.h
--- step1/include/asm-sh/system.h	2004-12-24 22:35:28.000000000 +0100
+++ step2/include/asm-sh/system.h	2005-01-27 21:17:55.000000000 +0100
@@ -259,4 +259,6 @@ static __inline__ unsigned long __xchg(u
 void disable_hlt(void);
 void enable_hlt(void);
 
+#define arch_align_stack(x) (x)
+
 #endif
diff -purN step1/include/asm-sh64/system.h step2/include/asm-sh64/system.h
--- step1/include/asm-sh64/system.h	2004-12-24 22:35:15.000000000 +0100
+++ step2/include/asm-sh64/system.h	2005-01-27 21:17:51.000000000 +0100
@@ -191,4 +191,6 @@ extern void print_seg(char *file,int lin
 
 #define PL() printk("@ <%s,%s:%d>\n",__FILE__,__FUNCTION__,__LINE__)
 
+#define arch_align_stack(x) (x)
+
 #endif /* __ASM_SH64_SYSTEM_H */
diff -purN step1/include/asm-sparc/system.h step2/include/asm-sparc/system.h
--- step1/include/asm-sparc/system.h	2004-12-24 22:35:23.000000000 +0100
+++ step2/include/asm-sparc/system.h	2005-01-27 21:18:04.000000000 +0100
@@ -257,4 +257,6 @@ extern void die_if_kernel(char *str, str
 
 #endif /* __ASSEMBLY__ */
 
+#define arch_align_stack(x) (x)
+
 #endif /* !(__SPARC_SYSTEM_H) */
diff -purN step1/include/asm-sparc64/system.h step2/include/asm-sparc64/system.h
--- step1/include/asm-sparc64/system.h	2004-12-24 22:33:48.000000000 +0100
+++ step2/include/asm-sparc64/system.h	2005-01-27 21:17:59.000000000 +0100
@@ -337,4 +337,6 @@ __cmpxchg(volatile void *ptr, unsigned l
 
 #endif /* !(__ASSEMBLY__) */
 
+#define arch_align_stack(x) (x)
+
 #endif /* !(__SPARC64_SYSTEM_H) */
diff -purN step1/include/asm-v850/system.h step2/include/asm-v850/system.h
--- step1/include/asm-v850/system.h	2004-12-24 22:35:23.000000000 +0100
+++ step2/include/asm-v850/system.h	2005-01-27 21:18:11.000000000 +0100
@@ -106,6 +106,9 @@ extern inline unsigned long __xchg (unsi
 	local_irq_restore (flags);
 
 	return tmp;
+
 }
 
+#define arch_align_stack(x) (x)
+
 #endif /* __V850_SYSTEM_H__ */
diff -purN step1/include/asm-x86_64/system.h step2/include/asm-x86_64/system.h
--- step1/include/asm-x86_64/system.h	2005-01-26 18:24:39.000000000 +0100
+++ step2/include/asm-x86_64/system.h	2005-01-27 21:13:49.000000000 +0100
@@ -338,4 +338,6 @@ void enable_hlt(void);
 #define HAVE_EAT_KEY
 void eat_key(void);
 
+extern unsigned long arch_align_stack(unsigned long sp);
+
 #endif
