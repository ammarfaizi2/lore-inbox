Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSFFFPr>; Thu, 6 Jun 2002 01:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316822AbSFFFPr>; Thu, 6 Jun 2002 01:15:47 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:2294 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316070AbSFFFPp>; Thu, 6 Jun 2002 01:15:45 -0400
Date: Thu, 6 Jun 2002 01:15:46 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] 2.5.20 x86 iobitmap cleanup
Message-ID: <20020606011546.A10030@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus et al,

Below is a patch against base 2.5.20 which makes the io port 
bitmap in thread_struct a pointer to a bitmap that is only 
allocated when the process calls ioperm.  This results in 132 
bytes being removed from struct task_struct.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."


diff -urN v2.5.20/arch/i386/kernel/ioport.c iobitmap-2.5.20.diff/arch/i386/kernel/ioport.c
--- v2.5.20/arch/i386/kernel/ioport.c	Mon Jul 19 18:22:48 1999
+++ iobitmap-2.5.20.diff/arch/i386/kernel/ioport.c	Thu Jun  6 00:54:22 2002
@@ -66,12 +66,15 @@
 	 * IO bitmap up. ioperm() is much less timing critical than clone(),
 	 * this is why we delay this operation until now:
 	 */
-	if (!t->ioperm) {
+	if (!t->ts_io_bitmap) {
+		unsigned long *bitmap = kmalloc((IO_BITMAP_SIZE+1)*4, GFP_KERNEL);
+		if (!bitmap)
+			return -ENOMEM;
 		/*
 		 * just in case ...
 		 */
-		memset(t->io_bitmap,0xff,(IO_BITMAP_SIZE+1)*4);
-		t->ioperm = 1;
+		memset(bitmap, 0xff, (IO_BITMAP_SIZE+1)*4);
+		t->ts_io_bitmap = bitmap;
 		/*
 		 * this activates it in the TSS
 		 */
@@ -81,7 +84,7 @@
 	/*
 	 * do it in the per-thread copy and in the TSS ...
 	 */
-	set_bitmap(t->io_bitmap, from, num, !turn_on);
+	set_bitmap(t->ts_io_bitmap, from, num, !turn_on);
 	set_bitmap(tss->io_bitmap, from, num, !turn_on);
 
 	return 0;
diff -urN v2.5.20/arch/i386/kernel/process.c iobitmap-2.5.20.diff/arch/i386/kernel/process.c
--- v2.5.20/arch/i386/kernel/process.c	Thu Jun  6 00:35:52 2002
+++ iobitmap-2.5.20.diff/arch/i386/kernel/process.c	Thu Jun  6 00:51:03 2002
@@ -685,8 +685,8 @@
 		loaddebug(next, 7);
 	}
 
-	if (unlikely(prev->ioperm || next->ioperm)) {
-		if (next->ioperm) {
+	if (unlikely(prev->ts_io_bitmap || next->ts_io_bitmap)) {
+		if (next->ts_io_bitmap) {
 			/*
 			 * 4 cachelines copy ... not good, but not that
 			 * bad either. Anyone got something better?
@@ -695,7 +695,7 @@
 			 * and playing VM tricks to switch the IO bitmap
 			 * is not really acceptable.]
 			 */
-			memcpy(tss->io_bitmap, next->io_bitmap,
+			memcpy(tss->io_bitmap, next->ts_io_bitmap,
 				 IO_BITMAP_SIZE*sizeof(unsigned long));
 			tss->bitmap = IO_BITMAP_OFFSET;
 		} else
diff -urN v2.5.20/include/asm-alpha/thread_info.h iobitmap-2.5.20.diff/include/asm-alpha/thread_info.h
--- v2.5.20/include/asm-alpha/thread_info.h	Thu Jun  6 00:35:33 2002
+++ iobitmap-2.5.20.diff/include/asm-alpha/thread_info.h	Thu Jun  6 01:01:05 2002
@@ -51,6 +51,7 @@
 #define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
+#define arch_dispose_thread_struct(tsk)		do{}while(0)
 
 #endif /* __ASSEMBLY__ */
 
diff -urN v2.5.20/include/asm-arm/thread_info.h iobitmap-2.5.20.diff/include/asm-arm/thread_info.h
--- v2.5.20/include/asm-arm/thread_info.h	Thu Jun  6 00:36:03 2002
+++ iobitmap-2.5.20.diff/include/asm-arm/thread_info.h	Thu Jun  6 01:01:13 2002
@@ -82,6 +82,7 @@
 
 extern struct thread_info *alloc_thread_info(void);
 extern void free_thread_info(struct thread_info *);
+#define arch_dispose_thread_struct(tsk)		do{}while(0)
 
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
diff -urN v2.5.20/include/asm-i386/processor.h iobitmap-2.5.20.diff/include/asm-i386/processor.h
--- v2.5.20/include/asm-i386/processor.h	Thu Jun  6 00:35:53 2002
+++ iobitmap-2.5.20.diff/include/asm-i386/processor.h	Thu Jun  6 00:50:06 2002
@@ -369,8 +369,7 @@
 	unsigned long		screen_bitmap;
 	unsigned long		v86flags, v86mask, v86mode, saved_esp0;
 /* IO permissions */
-	int		ioperm;
-	unsigned long	io_bitmap[IO_BITMAP_SIZE+1];
+	unsigned long	*ts_io_bitmap;
 };
 
 #define INIT_THREAD  {						\
@@ -380,7 +379,7 @@
 	0, 0, 0,						\
 	{ { 0, }, },		/* 387 state */			\
 	0,0,0,0,0,0,						\
-	0,{~0,}			/* io permissions */		\
+	0,NULL,			/* io permissions */		\
 }
 
 #define INIT_TSS  {						\
diff -urN v2.5.20/include/asm-i386/thread_info.h iobitmap-2.5.20.diff/include/asm-i386/thread_info.h
--- v2.5.20/include/asm-i386/thread_info.h	Thu Jun  6 00:35:32 2002
+++ iobitmap-2.5.20.diff/include/asm-i386/thread_info.h	Thu Jun  6 01:00:13 2002
@@ -79,6 +79,7 @@
 #define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
+#define arch_dispose_thread_struct(tsk)	kfree((tsk)->thread.ts_io_bitmap)
 
 #else /* !__ASSEMBLY__ */
 
diff -urN v2.5.20/include/asm-ia64/thread_info.h iobitmap-2.5.20.diff/include/asm-ia64/thread_info.h
--- v2.5.20/include/asm-ia64/thread_info.h	Thu Jun  6 00:35:33 2002
+++ iobitmap-2.5.20.diff/include/asm-ia64/thread_info.h	Thu Jun  6 01:01:39 2002
@@ -46,6 +46,7 @@
 
 /* how to get the thread information struct from C */
 #define current_thread_info() ((struct thread_info *) ((char *) current + IA64_TASK_SIZE))
+#define arch_dispose_thread_struct(tsk)		do{}while(0)
 
 #endif /* !__ASSEMBLY */
 
diff -urN v2.5.20/include/asm-ppc/thread_info.h iobitmap-2.5.20.diff/include/asm-ppc/thread_info.h
--- v2.5.20/include/asm-ppc/thread_info.h	Thu Jun  6 00:35:49 2002
+++ iobitmap-2.5.20.diff/include/asm-ppc/thread_info.h	Thu Jun  6 01:01:46 2002
@@ -55,6 +55,7 @@
 #define free_thread_info(ti)	free_pages((unsigned long) (ti), 1)
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
+#define arch_dispose_thread_struct(tsk)		do{}while(0)
 #endif /* __ASSEMBLY__ */
 
 /*
diff -urN v2.5.20/include/asm-ppc64/thread_info.h iobitmap-2.5.20.diff/include/asm-ppc64/thread_info.h
--- v2.5.20/include/asm-ppc64/thread_info.h	Thu Jun  6 00:36:03 2002
+++ iobitmap-2.5.20.diff/include/asm-ppc64/thread_info.h	Thu Jun  6 01:01:51 2002
@@ -50,6 +50,7 @@
 #define free_thread_info(ti)	free_pages((unsigned long) (ti), THREAD_ORDER)
 #define get_thread_info(ti)	get_task_struct((ti)->task)
 #define put_thread_info(ti)	put_task_struct((ti)->task)
+#define arch_dispose_thread_struct(tsk)		do{}while(0)
 
 #if THREAD_SIZE != (4*PAGE_SIZE)
 #error update vmlinux.lds and current_thread_info to match
diff -urN v2.5.20/include/asm-sparc64/thread_info.h iobitmap-2.5.20.diff/include/asm-sparc64/thread_info.h
--- v2.5.20/include/asm-sparc64/thread_info.h	Thu Jun  6 00:35:49 2002
+++ iobitmap-2.5.20.diff/include/asm-sparc64/thread_info.h	Thu Jun  6 01:02:03 2002
@@ -130,6 +130,7 @@
 /* how to get the thread information struct from C */
 register struct thread_info *current_thread_info_reg asm("g6");
 #define current_thread_info()	(current_thread_info_reg)
+#define arch_dispose_thread_struct(tsk)		do{}while(0)
 
 /* thread information allocation */
 #if PAGE_SHIFT == 13
diff -urN v2.5.20/include/asm-x86_64/thread_info.h iobitmap-2.5.20.diff/include/asm-x86_64/thread_info.h
--- v2.5.20/include/asm-x86_64/thread_info.h	Thu Jun  6 00:35:33 2002
+++ iobitmap-2.5.20.diff/include/asm-x86_64/thread_info.h	Thu Jun  6 01:02:08 2002
@@ -71,6 +71,7 @@
 #define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
+#define arch_dispose_thread_struct(tsk)		do{}while(0)
 
 #else /* !__ASSEMBLY__ */
 
diff -urN v2.5.20/kernel/fork.c iobitmap-2.5.20.diff/kernel/fork.c
--- v2.5.20/kernel/fork.c	Thu Jun  6 00:35:50 2002
+++ iobitmap-2.5.20.diff/kernel/fork.c	Thu Jun  6 01:00:10 2002
@@ -123,6 +123,7 @@
 
 void __put_task_struct(struct task_struct *tsk)
 {
+	arch_dispose_thread_struct(tsk);
 	free_thread_info(tsk->thread_info);
 	kmem_cache_free(task_struct_cachep,tsk);
 }
