Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267304AbUHWW3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267304AbUHWW3f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 18:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268138AbUHWVh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 17:37:27 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:51598 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S267881AbUHWVYC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 17:24:02 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 23 Aug 2004 14:23:35 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andy Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [patch] lazy TSS's I/O bitmap copy ...
Message-ID: <Pine.LNX.4.58.0408231311460.3221@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch implements a lazy I/O bitmap copy for the i386 
architecture. With I/O bitmaps now reaching considerable sizes, if the 
switched task does not perform any I/O operation, we can save the copy 
altogether. In my box X is working fine with the following patch, even if 
more test would be required.


Signed-off-by: Davide Libenzi <davidel@xmailserver.org>


- Davide



arch/i386/kernel/process.c   |   33 +++++++++++----------------------
arch/i386/kernel/traps.c     |   20 ++++++++++++++++++++
include/asm-i386/processor.h |    1 +
3 files changed, 32 insertions(+), 22 deletions(-)



Index: arch/i386/kernel/process.c
===================================================================
RCS file: /usr/src/bkcvs/linux-2.5/arch/i386/kernel/process.c,v
retrieving revision 1.82
diff -u -r1.82 process.c
--- a/arch/i386/kernel/process.c	14 Jul 2004 16:27:05 -0000	1.82
+++ b/arch/i386/kernel/process.c	23 Aug 2004 19:33:12 -0000
@@ -551,28 +551,17 @@
 		loaddebug(next, 7);
 	}
 
-	if (unlikely(prev->io_bitmap_ptr || next->io_bitmap_ptr)) {
-		if (next->io_bitmap_ptr) {
-			/*
-			 * 4 cachelines copy ... not good, but not that
-			 * bad either. Anyone got something better?
-			 * This only affects processes which use ioperm().
-			 * [Putting the TSSs into 4k-tlb mapped regions
-			 * and playing VM tricks to switch the IO bitmap
-			 * is not really acceptable.]
-			 */
-			memcpy(tss->io_bitmap, next->io_bitmap_ptr,
-				IO_BITMAP_BYTES);
-			tss->io_bitmap_base = IO_BITMAP_OFFSET;
-		} else
-			/*
-			 * a bitmap offset pointing outside of the TSS limit
-			 * causes a nicely controllable SIGSEGV if a process
-			 * tries to use a port IO instruction. The first
-			 * sys_ioperm() call sets up the bitmap properly.
-			 */
-			tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
-	}
+	/*
+	 * Lazy TSS's I/O bitmap copy. We set an invalid offset here and
+	 * we let the task to get a GPF in case an I/O instruction is performed.
+	 * The handler of the GPF will verify that the faulting task has a valid
+	 * I/O bitmap and, it true, does the real copy and restart the instruction.
+	 * This will save us for redoundant copies when the currently switched task
+	 * does not perform any I/O during its timeslice.
+	 */
+	tss->io_bitmap_base = next->io_bitmap_ptr ? INVALID_IO_BITMAP_OFFSET_LAZY:
+		INVALID_IO_BITMAP_OFFSET;
+
 	return prev_p;
 }
 
Index: arch/i386/kernel/traps.c
===================================================================
RCS file: /usr/src/bkcvs/linux-2.5/arch/i386/kernel/traps.c,v
retrieving revision 1.77
diff -u -r1.77 traps.c
--- a/arch/i386/kernel/traps.c	13 Jul 2004 18:02:33 -0000	1.77
+++ b/arch/i386/kernel/traps.c	23 Aug 2004 19:34:52 -0000
@@ -431,6 +431,26 @@
 
 asmlinkage void do_general_protection(struct pt_regs * regs, long error_code)
 {
+	int cpu = smp_processor_id();
+	struct tss_struct *tss = init_tss + cpu;
+	struct task_struct *tsk = current;
+	struct thread_struct *tsk_th = &tsk->thread;
+
+	/*
+	 * Perform the lazy TSS's I/O bitmap copy. If the TSS has an
+	 * invalid offset set (the LAZY one) and the faulting thread has
+	 * a valid I/O bitmap pointer, we copy the I/O bitmap in the TSS
+	 * and we set the offset field correctly. Then we let the CPU to
+	 * restart the faulting instruction.
+	 */
+	if (tss->io_bitmap_base == INVALID_IO_BITMAP_OFFSET_LAZY &&
+	    tsk_th->io_bitmap_ptr) {
+		memcpy(tss->io_bitmap, tsk_th->io_bitmap_ptr,
+		       IO_BITMAP_BYTES);
+		tss->io_bitmap_base = IO_BITMAP_OFFSET;
+		return;
+	}
+
 	if (regs->eflags & X86_EFLAGS_IF)
 		local_irq_enable();
  
Index: include/asm-i386/processor.h
===================================================================
RCS file: /usr/src/bkcvs/linux-2.5/include/asm-i386/processor.h,v
retrieving revision 1.68
diff -u -r1.68 processor.h
--- a/include/asm-i386/processor.h	27 Jun 2004 17:53:48 -0000	1.68
+++ b/include/asm-i386/processor.h	23 Aug 2004 19:32:58 -0000
@@ -304,6 +304,7 @@
 #define IO_BITMAP_LONGS (IO_BITMAP_BYTES/sizeof(long))
 #define IO_BITMAP_OFFSET offsetof(struct tss_struct,io_bitmap)
 #define INVALID_IO_BITMAP_OFFSET 0x8000
+#define INVALID_IO_BITMAP_OFFSET_LAZY 0x9000
 
 struct i387_fsave_struct {
 	long	cwd;
