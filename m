Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284280AbRLGSTS>; Fri, 7 Dec 2001 13:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284295AbRLGSTD>; Fri, 7 Dec 2001 13:19:03 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:61891 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S284280AbRLGSSm>; Fri, 7 Dec 2001 13:18:42 -0500
Subject: [PATCH] 2.4.17-pre5 Handle vmalloc failure during ldt allocation
To: marcelo@conectiva.com.br
Date: Fri, 7 Dec 2001 18:18:38 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E16CPa2-0004kL-00@virgo.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcello,

Please consider below patch for your next -pre release. It handles the
case where vmalloc() fails during ldt allocation in
arch/i386/kernel/process.c::copy_segments(). Without the patch the kernel
just carries on when allocation fails, thus losing the ldt...

The patch is tested on i386, I did the other arch as well but I don't have
any to test on. But as you can see below their change is trivial as they
don't implement copy_segments() at all (it was just a no-op define) so I
am confident they will work fine, too.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

------ ldt_alloc_fail.diff ------
diff -urN linux-2.4.17-pre5-vanilla/arch/i386/kernel/process.c linux-2.4.17-pre5/arch/i386/kernel/process.c
--- linux-2.4.17-pre5-vanilla/arch/i386/kernel/process.c	Fri Oct  5 02:42:54 2001
+++ linux-2.4.17-pre5/arch/i386/kernel/process.c	Fri Dec  7 17:52:19 2001
@@ -548,10 +548,11 @@
  * we do not have to muck with descriptors here, that is
  * done in switch_mm() as needed.
  */
-void copy_segments(struct task_struct *p, struct mm_struct *new_mm)
+int copy_segments(struct task_struct *p, struct mm_struct *new_mm)
 {
 	struct mm_struct * old_mm;
 	void *old_ldt, *ldt;
+	int ret_val = 0;
 
 	ldt = NULL;
 	old_mm = current->mm;
@@ -560,13 +561,15 @@
 		 * Completely new LDT, we initialize it from the parent:
 		 */
 		ldt = vmalloc(LDT_ENTRIES*LDT_ENTRY_SIZE);
-		if (!ldt)
+		if (!ldt) {
 			printk(KERN_WARNING "ldt allocation failed\n");
-		else
+			ret_val = -ENOMEM;
+		} else
 			memcpy(ldt, old_ldt, LDT_ENTRIES*LDT_ENTRY_SIZE);
 	}
 	new_mm->context.segments = ldt;
 	new_mm->context.cpuvalid = ~0UL;	/* valid on all CPU's - they can't have stale data */
+	return ret_val;
 }
 
 /*
diff -urN linux-2.4.17-pre5-vanilla/include/asm-alpha/processor.h linux-2.4.17-pre5/include/asm-alpha/processor.h
--- linux-2.4.17-pre5-vanilla/include/asm-alpha/processor.h	Fri Oct  5 20:11:05 2001
+++ linux-2.4.17-pre5/include/asm-alpha/processor.h	Fri Dec  7 16:47:07 2001
@@ -121,7 +121,10 @@
 /* Create a kernel thread without removing it from tasklists.  */
 extern long kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
 
-#define copy_segments(tsk, mm)		do { } while (0)
+static inline int copy_segments(struct task_struct *p, struct mm_struct *mm)
+{
+	return 0;
+}
 #define release_segments(mm)		do { } while (0)
 
 unsigned long get_wchan(struct task_struct *p);
diff -urN linux-2.4.17-pre5-vanilla/include/asm-arm/processor.h linux-2.4.17-pre5/include/asm-arm/processor.h
--- linux-2.4.17-pre5-vanilla/include/asm-arm/processor.h	Thu Oct 11 17:04:57 2001
+++ linux-2.4.17-pre5/include/asm-arm/processor.h	Fri Dec  7 16:47:18 2001
@@ -100,7 +100,10 @@
 extern void release_thread(struct task_struct *);
 
 /* Copy and release all segment info associated with a VM */
-#define copy_segments(tsk, mm)		do { } while (0)
+static inline int copy_segments(struct task_struct *p, struct mm_struct *mm)
+{
+	return 0;
+}
 #define release_segments(mm)		do { } while (0)
 
 unsigned long get_wchan(struct task_struct *p);
diff -urN linux-2.4.17-pre5-vanilla/include/asm-cris/processor.h linux-2.4.17-pre5/include/asm-cris/processor.h
--- linux-2.4.17-pre5-vanilla/include/asm-cris/processor.h	Mon Oct  8 19:43:54 2001
+++ linux-2.4.17-pre5/include/asm-cris/processor.h	Fri Dec  7 16:47:44 2001
@@ -108,7 +108,10 @@
 
 #define KSTK_ESP(tsk)   ((tsk) == current ? rdusp() : (tsk)->thread.usp)
 
-#define copy_segments(tsk, mm)          do { } while (0)
+static inline int copy_segments(struct task_struct *p, struct mm_struct *mm)
+{
+	return 0;
+}
 #define release_segments(mm)            do { } while (0)
 #define forget_segments()               do { } while (0)
  
diff -urN linux-2.4.17-pre5-vanilla/include/asm-i386/processor.h linux-2.4.17-pre5/include/asm-i386/processor.h
--- linux-2.4.17-pre5-vanilla/include/asm-i386/processor.h	Thu Nov 22 19:46:19 2001
+++ linux-2.4.17-pre5/include/asm-i386/processor.h	Fri Dec  7 17:54:17 2001
@@ -432,7 +432,7 @@
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
 /* Copy and release all segment info associated with a VM */
-extern void copy_segments(struct task_struct *p, struct mm_struct * mm);
+extern int copy_segments(struct task_struct *p, struct mm_struct * mm);
 extern void release_segments(struct mm_struct * mm);
 
 /*
diff -urN linux-2.4.17-pre5-vanilla/include/asm-ia64/processor.h linux-2.4.17-pre5/include/asm-ia64/processor.h
--- linux-2.4.17-pre5-vanilla/include/asm-ia64/processor.h	Fri Nov  9 22:26:17 2001
+++ linux-2.4.17-pre5/include/asm-ia64/processor.h	Fri Dec  7 16:48:09 2001
@@ -466,7 +466,10 @@
 extern int kernel_thread (int (*fn)(void *), void *arg, unsigned long flags);
 
 /* Copy and release all segment info associated with a VM */
-#define copy_segments(tsk, mm)			do { } while (0)
+static inline int copy_segments(struct task_struct *p, struct mm_struct *mm)
+{
+	return 0;
+}
 #define release_segments(mm)			do { } while (0)
 
 /* Get wait channel for task P.  */
diff -urN linux-2.4.17-pre5-vanilla/include/asm-m68k/processor.h linux-2.4.17-pre5/include/asm-m68k/processor.h
--- linux-2.4.17-pre5-vanilla/include/asm-m68k/processor.h	Fri Oct  5 20:11:05 2001
+++ linux-2.4.17-pre5/include/asm-m68k/processor.h	Fri Dec  7 16:48:21 2001
@@ -107,7 +107,10 @@
 
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
-#define copy_segments(tsk, mm)		do { } while (0)
+static inline int copy_segments(struct task_struct *p, struct mm_struct *mm)
+{
+	return 0;
+}
 #define release_segments(mm)		do { } while (0)
 
 /*
diff -urN linux-2.4.17-pre5-vanilla/include/asm-mips/processor.h linux-2.4.17-pre5/include/asm-mips/processor.h
--- linux-2.4.17-pre5-vanilla/include/asm-mips/processor.h	Fri Oct  5 20:11:05 2001
+++ linux-2.4.17-pre5/include/asm-mips/processor.h	Fri Dec  7 16:48:41 2001
@@ -211,7 +211,10 @@
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
 /* Copy and release all segment info associated with a VM */
-#define copy_segments(p, mm) do { } while(0)
+static inline int copy_segments(struct task_struct *p, struct mm_struct *mm)
+{
+	return 0;
+}
 #define release_segments(mm) do { } while(0)
 
 /*
diff -urN linux-2.4.17-pre5-vanilla/include/asm-mips64/processor.h linux-2.4.17-pre5/include/asm-mips64/processor.h
--- linux-2.4.17-pre5-vanilla/include/asm-mips64/processor.h	Fri Oct  5 20:11:05 2001
+++ linux-2.4.17-pre5/include/asm-mips64/processor.h	Fri Dec  7 16:48:49 2001
@@ -234,7 +234,10 @@
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
 /* Copy and release all segment info associated with a VM */
-#define copy_segments(p, mm) do { } while(0)
+static inline int copy_segments(struct task_struct *p, struct mm_struct *mm)
+{
+	return 0;
+}
 #define release_segments(mm) do { } while(0)
 
 /*
diff -urN linux-2.4.17-pre5-vanilla/include/asm-parisc/processor.h linux-2.4.17-pre5/include/asm-parisc/processor.h
--- linux-2.4.17-pre5-vanilla/include/asm-parisc/processor.h	Fri Oct  5 20:11:05 2001
+++ linux-2.4.17-pre5/include/asm-parisc/processor.h	Fri Dec  7 16:49:01 2001
@@ -307,7 +307,10 @@
 extern void release_thread(struct task_struct *);
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
-#define copy_segments(tsk, mm)	do { } while (0)
+static inline int copy_segments(struct task_struct *p, struct mm_struct *mm)
+{
+	return 0;
+}
 #define release_segments(mm)	do { } while (0)
 
 extern inline unsigned long get_wchan(struct task_struct *p)
diff -urN linux-2.4.17-pre5-vanilla/include/asm-ppc/processor.h linux-2.4.17-pre5/include/asm-ppc/processor.h
--- linux-2.4.17-pre5-vanilla/include/asm-ppc/processor.h	Fri Oct  5 20:11:05 2001
+++ linux-2.4.17-pre5/include/asm-ppc/processor.h	Fri Dec  7 16:49:12 2001
@@ -628,7 +628,10 @@
 	return (t->regs) ? t->regs->nip : 0;
 }
 
-#define copy_segments(tsk, mm)		do { } while (0)
+static inline int copy_segments(struct task_struct *p, struct mm_struct *mm)
+{
+	return 0;
+}
 #define release_segments(mm)		do { } while (0)
 
 unsigned long get_wchan(struct task_struct *p);
diff -urN linux-2.4.17-pre5-vanilla/include/asm-s390/processor.h linux-2.4.17-pre5/include/asm-s390/processor.h
--- linux-2.4.17-pre5-vanilla/include/asm-s390/processor.h	Fri Oct  5 20:11:05 2001
+++ linux-2.4.17-pre5/include/asm-s390/processor.h	Fri Dec  7 16:49:23 2001
@@ -122,7 +122,10 @@
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
 /* Copy and release all segment info associated with a VM */
-#define copy_segments(nr, mm)           do { } while (0)
+static inline int copy_segments(struct task_struct *p, struct mm_struct *mm)
+{
+	return 0;
+}
 #define release_segments(mm)            do { } while (0)
 
 /*
diff -urN linux-2.4.17-pre5-vanilla/include/asm-s390x/processor.h linux-2.4.17-pre5/include/asm-s390x/processor.h
--- linux-2.4.17-pre5-vanilla/include/asm-s390x/processor.h	Fri Oct  5 20:11:05 2001
+++ linux-2.4.17-pre5/include/asm-s390x/processor.h	Fri Dec  7 16:49:31 2001
@@ -132,7 +132,10 @@
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
 /* Copy and release all segment info associated with a VM */
-#define copy_segments(nr, mm)           do { } while (0)
+static inline int copy_segments(struct task_struct *p, struct mm_struct *mm)
+{
+	return 0;
+}
 #define release_segments(mm)            do { } while (0)
 
 /*
diff -urN linux-2.4.17-pre5-vanilla/include/asm-sh/processor.h linux-2.4.17-pre5/include/asm-sh/processor.h
--- linux-2.4.17-pre5-vanilla/include/asm-sh/processor.h	Fri Oct  5 20:11:05 2001
+++ linux-2.4.17-pre5/include/asm-sh/processor.h	Fri Dec  7 16:49:42 2001
@@ -149,7 +149,10 @@
 
 
 /* Copy and release all segment info associated with a VM */
-#define copy_segments(p, mm)	do { } while(0)
+static inline int copy_segments(struct task_struct *p, struct mm_struct *mm)
+{
+	return 0;
+}
 #define release_segments(mm)	do { } while(0)
 
 /*
diff -urN linux-2.4.17-pre5-vanilla/include/asm-sparc/processor.h linux-2.4.17-pre5/include/asm-sparc/processor.h
--- linux-2.4.17-pre5-vanilla/include/asm-sparc/processor.h	Thu Oct 11 07:42:47 2001
+++ linux-2.4.17-pre5/include/asm-sparc/processor.h	Fri Dec  7 16:49:51 2001
@@ -149,7 +149,10 @@
 extern pid_t kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
 
-#define copy_segments(tsk, mm)		do { } while (0)
+static inline int copy_segments(struct task_struct *p, struct mm_struct *mm)
+{
+	return 0;
+}
 #define release_segments(mm)		do { } while (0)
 
 #define get_wchan(__TSK) \
diff -urN linux-2.4.17-pre5-vanilla/include/asm-sparc64/processor.h linux-2.4.17-pre5/include/asm-sparc64/processor.h
--- linux-2.4.17-pre5-vanilla/include/asm-sparc64/processor.h	Fri Dec  7 17:48:49 2001
+++ linux-2.4.17-pre5/include/asm-sparc64/processor.h	Fri Dec  7 16:50:01 2001
@@ -254,7 +254,10 @@
 
 extern pid_t kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
-#define copy_segments(tsk, mm)		do { } while (0)
+static inline int copy_segments(struct task_struct *p, struct mm_struct *mm)
+{
+	return 0;
+}
 #define release_segments(mm)		do { } while (0)
 
 #define get_wchan(__TSK) \
diff -urN linux-2.4.17-pre5-vanilla/kernel/fork.c linux-2.4.17-pre5/kernel/fork.c
--- linux-2.4.17-pre5-vanilla/kernel/fork.c	Wed Nov 21 18:18:42 2001
+++ linux-2.4.17-pre5/kernel/fork.c	Fri Dec  7 16:45:01 2001
@@ -343,7 +343,9 @@
 	/*
 	 * child gets a private LDT (if there was an LDT in the parent)
 	 */
-	copy_segments(tsk, mm);
+	retval = copy_segments(tsk, mm);
+	if (retval)
+		goto free_pt;
 
 	if (init_new_context(tsk,mm))
 		goto free_pt;
