Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313458AbSC2PXy>; Fri, 29 Mar 2002 10:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313459AbSC2PXo>; Fri, 29 Mar 2002 10:23:44 -0500
Received: from imladris.infradead.org ([194.205.184.45]:18182 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S313458AbSC2PXa>; Fri, 29 Mar 2002 10:23:30 -0500
Date: Fri, 29 Mar 2002 15:23:14 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] generic show_stack facility
Message-ID: <20020329152314.A22333@phoenix.infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a prototype for show_stack to sched.h and exports
it.  Andrea's VM updates want this, as does Tux and I think it's a facility
we want to proive genericly.

Note that some architectures (e.g. ia64) have a conflicting prototype and
some (e.g. sparc) don't have show_stack at all, but I think -pre5 is early
enough in the 2.4.19 cycle to let the maintainers fix it.

Could you apply the patch to your tree?

	Christoph

diff -uNr -Xdontdiff ../master/linux-2.4.19-pre4/arch/i386/kernel/irq.c linux/arch/i386/kernel/irq.c
--- ../master/linux-2.4.19-pre4/arch/i386/kernel/irq.c	Wed Nov  7 20:09:56 2001
+++ linux/arch/i386/kernel/irq.c	Fri Mar 29 15:55:39 2002
@@ -192,8 +192,6 @@
 unsigned char global_irq_holder = NO_PROC_ID;
 unsigned volatile long global_irq_lock; /* pendantic: long for set_bit --RR */
 
-extern void show_stack(unsigned long* esp);
-
 static void show(char * str)
 {
 	int i;
@@ -224,7 +222,7 @@
 		}
 		esp &= ~(THREAD_SIZE-1);
 		esp += sizeof(struct task_struct);
-		show_stack((void*)esp);
+		show_stack((void *)esp);
  	}
 	printk("\nCPU %d:",cpu);
 	show_stack(NULL);
diff -uNr -Xdontdiff ../master/linux-2.4.19-pre4/arch/ia64/kernel/irq.c linux/arch/ia64/kernel/irq.c
--- ../master/linux-2.4.19-pre4/arch/ia64/kernel/irq.c	Thu Mar 21 15:24:10 2002
+++ linux/arch/ia64/kernel/irq.c	Fri Mar 29 15:56:13 2002
@@ -192,8 +192,6 @@
 unsigned int global_irq_holder = NO_PROC_ID;
 unsigned volatile long global_irq_lock; /* pedantic: long for set_bit --RR */
 
-extern void show_stack(unsigned long* esp);
-
 static void show(char * str)
 {
 	int i;
diff -uNr -Xdontdiff ../master/linux-2.4.19-pre4/arch/mips/kernel/traps.c linux/arch/mips/kernel/traps.c
--- ../master/linux-2.4.19-pre4/arch/mips/kernel/traps.c	Thu Mar 21 15:24:13 2002
+++ linux/arch/mips/kernel/traps.c	Fri Mar 29 15:53:53 2002
@@ -182,12 +182,12 @@
  * This routine abuses get_user()/put_user() to reference pointers
  * with at least a bit of error checking ...
  */
-void show_stack(unsigned int *sp)
+void show_stack(unsigned long *sp)
 {
 	int i;
-	unsigned int *stack;
+	unsigned long *stack;
 
-	stack = sp ? sp : (unsigned int *)&sp;
+	stack = sp ? sp : (unsigned long *)&sp;
 	i = 0;
 
 	printk("Stack:");
diff -uNr -Xdontdiff ../master/linux-2.4.19-pre4/include/linux/sched.h linux/include/linux/sched.h
--- ../master/linux-2.4.19-pre4/include/linux/sched.h	Thu Mar 21 15:24:23 2002
+++ linux/include/linux/sched.h	Fri Mar 29 15:59:51 2002
@@ -145,6 +145,7 @@
 extern void sched_init(void);
 extern void init_idle(void);
 extern void show_state(void);
+extern void show_stack(unsigned long *esp);
 extern void cpu_init (void);
 extern void trap_init(void);
 extern void update_process_times(int user);
diff -uNr -Xdontdiff ../master/linux-2.4.19-pre4/kernel/ksyms.c linux/kernel/ksyms.c
--- ../master/linux-2.4.19-pre4/kernel/ksyms.c	Thu Mar 21 15:24:23 2002
+++ linux/kernel/ksyms.c	Fri Mar 29 15:52:20 2002
@@ -487,6 +487,7 @@
 EXPORT_SYMBOL(seq_release);
 EXPORT_SYMBOL(seq_read);
 EXPORT_SYMBOL(seq_lseek);
+EXPORT_SYMBOL(show_stack);
 
 /* Program loader interfaces */
 EXPORT_SYMBOL(setup_arg_pages);
