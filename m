Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284122AbRLAOmk>; Sat, 1 Dec 2001 09:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284121AbRLAOmc>; Sat, 1 Dec 2001 09:42:32 -0500
Received: from tahallah.demon.co.uk ([158.152.175.193]:31238 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S284122AbRLAOmV>; Sat, 1 Dec 2001 09:42:21 -0500
Date: Sat, 1 Dec 2001 14:37:34 +0000 (GMT)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.17-pre2: Missing show_trace_task() implementation on
 sparc32
Message-ID: <Pine.LNX.4.33.0112011432340.2476-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see that the fix for implementation of show_trace_task() is missing from
the sparc32 tree in 2.4.17-pre1 and 2.4.17-pre2. Dave M has redone my
quick and dirty patch and placed it in arch/sparc/process.c

Here is the patch to include in 2.4.17-pre3, thanks.

--- linuxcvs-2.4.15-pre9/arch/sparc/kernel/process.c	Thu Nov 15 00:03:05 2001
+++ linuxcvs/arch/sparc/kernel/process.c	Sat Dec  1 14:06:16 2001
@@ -1,4 +1,4 @@
-/*  $Id: process.c,v 1.157 2001/11/13 00:57:05 davem Exp $
+/*  $Id: process.c,v 1.158 2001/11/26 23:45:00 davem Exp $
  *  linux/arch/sparc/kernel/process.c
  *
  *  Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
@@ -285,37 +285,29 @@
 	show_regwindow((struct reg_window *)regs->u_regs[14]);
 }

-#if NOTUSED
-void show_thread(struct thread_struct *thread)
+void show_trace_task(struct task_struct *tsk)
 {
-	int i;
-
-	printk("uwinmask:          0x%08lx  kregs:             0x%08lx\n", thread->uwinmask, (unsigned long)thread->kregs);
-	show_regs(thread->kregs);
-	printk("ksp:               0x%08lx  kpc:               0x%08lx\n", thread->ksp, thread->kpc);
-	printk("kpsr:              0x%08lx  kwim:              0x%08lx\n", thread->kpsr, thread->kwim);
-	printk("fork_kpsr:         0x%08lx  fork_kwim:         0x%08lx\n", thread->fork_kpsr, thread->fork_kwim);
-
-	for (i = 0; i < NSWINS; i++) {
-		if (!thread->rwbuf_stkptrs[i])
-			continue;
-		printk("reg_window[%d]:\n", i);
-		printk("stack ptr:         0x%08lx\n", thread->rwbuf_stkptrs[i]);
-		show_regwindow(&thread->reg_window[i]);
-	}
-	printk("w_saved:           0x%08lx\n", thread->w_saved);
-
-	/* XXX missing: float_regs */
-	printk("fsr:               0x%08lx  fpqdepth:          0x%08lx\n", thread->fsr, thread->fpqdepth);
-	/* XXX missing: fpqueue */
+	unsigned long pc, fp;
+	unsigned long task_base = (unsigned long) tsk;
+	struct reg_window *rw;
+	int count = 0;

-	printk("flags:             0x%08lx  current_ds:        0x%08lx\n", thread->flags, thread->current_ds.seg);
-
-	show_regwindow((struct reg_window *)thread->ksp);
+	if (!tsk)
+		return;

-	/* XXX missing: core_exec */
+	fp = tsk->thread.ksp;
+	do {
+		/* Bogus frame pointer? */
+		if (fp < (task_base + sizeof(struct task_struct)) ||
+		    fp >= (task_base + (PAGE_SIZE << 1)))
+			break;
+		rw = (struct reg_window *) fp;
+		pc = rw->ins[7];
+		printk("[%08lx] ", pc);
+		fp = rw->ins[6];
+	} while (++count < 16);
+	printk("\n");
 }
-#endif

 /*
  * Free current thread data structures etc..

-- 
A mindfuck is when Kosh and Talia gets together.

http://www.tahallah.demon.co.uk

