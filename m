Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268147AbUHXSU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268147AbUHXSU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 14:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268156AbUHXSU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 14:20:29 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:7832 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S268147AbUHXSUP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 14:20:15 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 24 Aug 2004 11:20:07 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Andy Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [patch] lazy I/O bitmap copy for i386 (ver 2) ...
Message-ID: <Pine.LNX.4.58.0408241113370.2026@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch implements the lazy I/O bitmap copy for the i386 
architecture. It uses an invalid bitmap offset inside the TSS to eventually 
handle the correct bitmap update in the GPF handler. The logic is the same 
of the first version, plus the usage of get/put_cpu() (thx Brian) and the 
nesting over the latest Ingo variable bitmap bits.



- Davide



arch/i386/kernel/ioport.c    |    7 +++++--
arch/i386/kernel/process.c   |   25 +++++++++++--------------
arch/i386/kernel/traps.c     |   29 +++++++++++++++++++++++++++++
include/asm-i386/processor.h |    7 ++++++-
4 files changed, 51 insertions(+), 17 deletions(-)




Index: arch/i386/kernel/ioport.c
===================================================================
RCS file: /usr/src/bkcvs/linux-2.5/arch/i386/kernel/ioport.c,v
retrieving revision 1.13
diff -u -r1.13 ioport.c
--- a/arch/i386/kernel/ioport.c	23 Aug 2004 19:42:10 -0000	1.13
+++ b/arch/i386/kernel/ioport.c	24 Aug 2004 17:45:31 -0000
@@ -105,8 +105,11 @@
 
 	t->io_bitmap_max = bytes;
 
-	/* Update the TSS: */
-	memcpy(tss->io_bitmap, t->io_bitmap_ptr, bytes_updated);
+	/*
+	 * Sets the lazy trigger so that the next I/O operation will
+	 * reload the correct bitmap.
+	 */
+	tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET_LAZY;
 
 	put_cpu();
 
Index: arch/i386/kernel/process.c
===================================================================
RCS file: /usr/src/bkcvs/linux-2.5/arch/i386/kernel/process.c,v
retrieving revision 1.84
diff -u -r1.84 process.c
--- a/arch/i386/kernel/process.c	23 Aug 2004 19:42:10 -0000	1.84
+++ b/arch/i386/kernel/process.c	24 Aug 2004 16:37:25 -0000
@@ -561,20 +561,17 @@
 		loaddebug(next, 7);
 	}
 
-	if (unlikely(prev->io_bitmap_ptr || next->io_bitmap_ptr)) {
-		if (next->io_bitmap_ptr)
-			/*
-			 * Copy the relevant range of the IO bitmap.
-			 * Normally this is 128 bytes or less:
-			 */
-			memcpy(tss->io_bitmap, next->io_bitmap_ptr,
-				max(prev->io_bitmap_max, next->io_bitmap_max));
-		else
-			/*
-			 * Clear any possible leftover bits:
-			 */
-			memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
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
retrieving revision 1.81
diff -u -r1.81 traps.c
--- a/arch/i386/kernel/traps.c	23 Aug 2004 19:55:11 -0000	1.81
+++ b/arch/i386/kernel/traps.c	24 Aug 2004 17:32:26 -0000
@@ -450,6 +450,35 @@
 
 asmlinkage void do_general_protection(struct pt_regs * regs, long error_code)
 {
+	int cpu = get_cpu();
+	struct tss_struct *tss = &per_cpu(init_tss, cpu);
+	struct thread_struct *tsk_th = &current->thread;
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
+		       tsk_th->io_bitmap_max);
+		/*
+		 * If the previously set map was extending to higher ports
+		 * than the current one, pad extra space with 0xff (no access).
+		 */
+		if (tsk_th->io_bitmap_max < tss->map_size)
+			memset((char *) tss->io_bitmap + tsk_th->io_bitmap_max, 0xff,
+			       tss->map_size - tsk_th->io_bitmap_max);
+		tss->map_size = tsk_th->io_bitmap_max;
+		tss->io_bitmap_base = IO_BITMAP_OFFSET;
+		put_cpu();
+		return;
+	}
+	put_cpu();
+
 	if (regs->eflags & VM_MASK)
 		goto gp_in_vm86;
 
Index: include/asm-i386/processor.h
===================================================================
RCS file: /usr/src/bkcvs/linux-2.5/include/asm-i386/processor.h,v
retrieving revision 1.70
diff -u -r1.70 processor.h
--- a/include/asm-i386/processor.h	23 Aug 2004 19:42:10 -0000	1.70
+++ b/include/asm-i386/processor.h	24 Aug 2004 16:53:53 -0000
@@ -305,6 +305,7 @@
 #define IO_BITMAP_LONGS (IO_BITMAP_BYTES/sizeof(long))
 #define IO_BITMAP_OFFSET offsetof(struct tss_struct,io_bitmap)
 #define INVALID_IO_BITMAP_OFFSET 0x8000
+#define INVALID_IO_BITMAP_OFFSET_LAZY 0x9000
 
 struct i387_fsave_struct {
 	long	cwd;
@@ -390,9 +391,13 @@
 	 */
 	unsigned long	io_bitmap[IO_BITMAP_LONGS + 1];
 	/*
+	 * Effective size of the currently set I/O bitmap.
+	 */
+	unsigned long	map_size;
+	/*
 	 * pads the TSS to be cacheline-aligned (size is 0x100)
 	 */
-	unsigned long __cacheline_filler[37];
+	unsigned long __cacheline_filler[36];
 	/*
 	 * .. and then another 0x100 bytes for emergency kernel stack
 	 */
