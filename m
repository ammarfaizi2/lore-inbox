Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288153AbSA0QzB>; Sun, 27 Jan 2002 11:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288188AbSA0Qyw>; Sun, 27 Jan 2002 11:54:52 -0500
Received: from mx2.elte.hu ([157.181.151.9]:10127 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288153AbSA0Qyd>;
	Sun, 27 Jan 2002 11:54:33 -0500
Date: Sun, 27 Jan 2002 18:26:04 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] [sched] avoid %fs/%gs reloading on x86.
Message-ID: <Pine.LNX.4.33.0201271817310.5713-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the patch below further optimizes the x86 context-switch code. On P6 class
CPUs it takes 36 cycles to reload %fs and %gs, while both registers are
zero in most of the cases. (exceptions are LinuxThreads, Wine, DOSEMU,
etc.) It's much cheaper to check whether any non-zero %fs or %gs selector
is involved, and do the segment reload in that case only.

when applied to 2.5.3-pre5, the patch achieves a 2.5% improvement in
2-task lat_ctx context-switch performance.

(i've also added unlikely() constructs to context-switch slow paths. The
performance improvement was measured on kernel compiled with a 2.x gcc
compiler that does not use the unlikely() extension yet.)

	Ingo

--- linux/arch/i386/kernel/process.c.orig	Sun Jan 27 15:33:29 2002
+++ linux/arch/i386/kernel/process.c	Sun Jan 27 16:07:45 2002
@@ -689,15 +689,17 @@
 	asm volatile("movl %%gs,%0":"=m" (*(int *)&prev->gs));

 	/*
-	 * Restore %fs and %gs.
+	 * Restore %fs and %gs if needed.
 	 */
-	loadsegment(fs, next->fs);
-	loadsegment(gs, next->gs);
+	if (unlikely(prev->fs | prev->gs | next->fs | next->gs)) {
+		loadsegment(fs, next->fs);
+		loadsegment(gs, next->gs);
+	}

 	/*
 	 * Now maybe reload the debug registers
 	 */
-	if (next->debugreg[7]){
+	if (unlikely(next->debugreg[7])) {
 		loaddebug(next, 0);
 		loaddebug(next, 1);
 		loaddebug(next, 2);
@@ -707,7 +709,7 @@
 		loaddebug(next, 7);
 	}

-	if (prev->ioperm || next->ioperm) {
+	if (unlikely(prev->ioperm || next->ioperm)) {
 		if (next->ioperm) {
 			/*
 			 * 4 cachelines copy ... not good, but not that

