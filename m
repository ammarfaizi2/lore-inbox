Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317477AbSFMGUf>; Thu, 13 Jun 2002 02:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317478AbSFMGUe>; Thu, 13 Jun 2002 02:20:34 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:38129 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317477AbSFMGUc>; Thu, 13 Jun 2002 02:20:32 -0400
Date: Thu, 13 Jun 2002 02:20:33 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.20 x86 iobitmap cleanup
Message-ID: <20020613022033.H4081@redhat.com>
In-Reply-To: <20020606011546.A10030@redhat.com> <Pine.LNX.4.33.0206121300330.1533-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 01:04:09PM -0700, Linus Torvalds wrote:
> Why do you introduce a arch_dispose_thread_struct(), instead of just 
> making the x86 exit_thread() do it?

That makes much more sense.  Below is an updated patch against cset 
1.479 that allocs in sys_ioperm() and copy_thread() and frees in 
exit_thread().  It also gets rid of the IO_BITMAP_SIZE+1 crap, as 
only the tss actually needs the tail long, and we weren't copying 
it into the bitmap anyways.  There is a test program at 
http://www.kvack.org/~blah/iobitmap.c .   Side note: double kfree() 
does not trigger a BUG()...

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."

:r ~/patches/v2.5/v2.5.21.5-io_bitmap-B0.diff
diff -urN linus-2.5/arch/i386/kernel/ioport.c work-2.5.diff/arch/i386/kernel/ioport.c
--- linus-2.5/arch/i386/kernel/ioport.c	Wed Jun 12 20:59:11 2002
+++ work-2.5.diff/arch/i386/kernel/ioport.c	Thu Jun 13 02:10:59 2002
@@ -10,10 +10,10 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/ioport.h>
-#include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/stddef.h>
+#include <linux/slab.h>
 
 /* Set EXTENT bits starting at BASE in BITMAP to value TURN_ON. */
 static void set_bitmap(unsigned long *bitmap, short base, short extent, int new_value)
@@ -66,12 +66,16 @@
 	 * IO bitmap up. ioperm() is much less timing critical than clone(),
 	 * this is why we delay this operation until now:
 	 */
-	if (!t->ioperm) {
+	if (!t->ts_io_bitmap) {
+		unsigned long *bitmap;
+		bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
+		if (!bitmap)
+			return -ENOMEM;
 		/*
 		 * just in case ...
 		 */
-		memset(t->io_bitmap,0xff,(IO_BITMAP_SIZE+1)*4);
-		t->ioperm = 1;
+		memset(bitmap, 0xff, IO_BITMAP_BYTES);
+		t->ts_io_bitmap = bitmap;
 		/*
 		 * this activates it in the TSS
 		 */
@@ -81,7 +85,7 @@
 	/*
 	 * do it in the per-thread copy and in the TSS ...
 	 */
-	set_bitmap(t->io_bitmap, from, num, !turn_on);
+	set_bitmap(t->ts_io_bitmap, from, num, !turn_on);
 	set_bitmap(tss->io_bitmap, from, num, !turn_on);
 
 	return 0;
diff -urN linus-2.5/arch/i386/kernel/process.c work-2.5.diff/arch/i386/kernel/process.c
--- linus-2.5/arch/i386/kernel/process.c	Wed Jun 12 20:59:11 2002
+++ work-2.5.diff/arch/i386/kernel/process.c	Thu Jun 13 02:03:36 2002
@@ -509,7 +509,13 @@
  */
 void exit_thread(void)
 {
-	/* nothing to do ... */
+	struct task_struct *tsk = current;
+
+	/* The process may have allocated an io port bitmap... nuke it. */
+	if (unlikely(NULL != tsk->thread.ts_io_bitmap)) {
+		kfree(tsk->thread.ts_io_bitmap);
+		tsk->thread.ts_io_bitmap = NULL;
+	}
 }
 
 void flush_thread(void)
@@ -549,6 +555,7 @@
 	struct task_struct * p, struct pt_regs * regs)
 {
 	struct pt_regs * childregs;
+	struct task_struct *tsk;
 
 	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
 	struct_cpy(childregs, regs);
@@ -563,8 +570,17 @@
 	savesegment(fs,p->thread.fs);
 	savesegment(gs,p->thread.gs);
 
-	unlazy_fpu(current);
-	struct_cpy(&p->thread.i387, &current->thread.i387);
+	tsk = current;
+	unlazy_fpu(tsk);
+	struct_cpy(&p->thread.i387, &tsk->thread.i387);
+
+	if (unlikely(NULL != tsk->thread.ts_io_bitmap)) {
+		p->thread.ts_io_bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
+		if (!p->thread.ts_io_bitmap)
+			return -ENOMEM;
+		memcpy(p->thread.ts_io_bitmap, tsk->thread.ts_io_bitmap,
+			IO_BITMAP_BYTES);
+	}
 
 	return 0;
 }
@@ -685,8 +701,8 @@
 		loaddebug(next, 7);
 	}
 
-	if (unlikely(prev->ioperm || next->ioperm)) {
-		if (next->ioperm) {
+	if (unlikely(prev->ts_io_bitmap || next->ts_io_bitmap)) {
+		if (next->ts_io_bitmap) {
 			/*
 			 * 4 cachelines copy ... not good, but not that
 			 * bad either. Anyone got something better?
@@ -695,8 +711,8 @@
 			 * and playing VM tricks to switch the IO bitmap
 			 * is not really acceptable.]
 			 */
-			memcpy(tss->io_bitmap, next->io_bitmap,
-				 IO_BITMAP_SIZE*sizeof(unsigned long));
+			memcpy(tss->io_bitmap, next->ts_io_bitmap,
+				IO_BITMAP_BYTES);
 			tss->bitmap = IO_BITMAP_OFFSET;
 		} else
 			/*
diff -urN linus-2.5/include/asm-i386/processor.h work-2.5.diff/include/asm-i386/processor.h
--- linus-2.5/include/asm-i386/processor.h	Wed Jun 12 20:59:17 2002
+++ work-2.5.diff/include/asm-i386/processor.h	Thu Jun 13 02:02:30 2002
@@ -267,6 +267,7 @@
  * Size of io_bitmap in longwords: 32 is ports 0-0x3ff.
  */
 #define IO_BITMAP_SIZE	32
+#define IO_BITMAP_BYTES	(IO_BITMAP_SIZE * 4)
 #define IO_BITMAP_OFFSET offsetof(struct tss_struct,io_bitmap)
 #define INVALID_IO_BITMAP_OFFSET 0x8000
 
@@ -370,8 +371,7 @@
 	unsigned long		screen_bitmap;
 	unsigned long		v86flags, v86mask, v86mode, saved_esp0;
 /* IO permissions */
-	int		ioperm;
-	unsigned long	io_bitmap[IO_BITMAP_SIZE+1];
+	unsigned long	*ts_io_bitmap;
 };
 
 #define INIT_THREAD  {						\
@@ -381,7 +381,7 @@
 	0, 0, 0,						\
 	{ { 0, }, },		/* 387 state */			\
 	0,0,0,0,0,0,						\
-	0,{~0,}			/* io permissions */		\
+	NULL,			/* io permissions */		\
 }
 
 #define INIT_TSS  {						\
