Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282657AbRKZXqu>; Mon, 26 Nov 2001 18:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282658AbRKZXqk>; Mon, 26 Nov 2001 18:46:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:47490 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S282657AbRKZXqa>;
	Mon, 26 Nov 2001 18:46:30 -0500
Date: Mon, 26 Nov 2001 15:46:25 -0800 (PST)
Message-Id: <20011126.154625.124867265.davem@redhat.com>
To: alex.buell@tahallah.demon.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] show_trace_task() sparc32
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0111262311170.29479-100000@tahallah.demon.co.uk>
In-Reply-To: <Pine.LNX.4.33.0111262311170.29479-100000@tahallah.demon.co.uk>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alex Buell <alex.buell@tahallah.demon.co.uk>
   Date: Mon, 26 Nov 2001 23:13:45 +0000 (GMT)
   
   I don't know enough about the task stuff to implement this properly. I did
   this patch for 2.4.15-pre9 but just noticed that 2.4.16 doesn't have it in
   place.

Thanks for pointing this out, the following is in CVS and was
passed on to Marcelo for 2.4.17-preX...

--- arch/sparc/kernel/process.c.~1~	Mon Nov 12 16:57:05 2001
+++ arch/sparc/kernel/process.c	Mon Nov 26 15:45:00 2001
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
