Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263966AbRFELoy>; Tue, 5 Jun 2001 07:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263967AbRFELoo>; Tue, 5 Jun 2001 07:44:44 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:37332 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S263966AbRFELof>; Tue, 5 Jun 2001 07:44:35 -0400
Message-ID: <3B1CC45C.F61ED7BA@uow.edu.au>
Date: Tue, 05 Jun 2001 21:37:00 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/devfs/base.c
In-Reply-To: <9fht4j$cce$1@cesium.transmeta.com> from "H. Peter Anvin" at Jun 04, 2001 11:10:27 PM <E157AlZ-0006Vi-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > It's trivial to calculate for DAGs -- directed acyclic graphs.  It's
> > when the "acyclic" constraint is violated that you have problems!
> 
> It may well be that interrupt stacks are a win anyway. If we can get the kernel
> struct out of the stack pages (which would fix some very unpleasant cache
> colour problems) and take the non irq stack down to 4K then irq stacks would
> pay off once you had 25 or so processes on a system

All this talk about stack utilisation, we may as well fix 
up the current (ly broken) instrumentation.

The patch enables the display of least-ever stack headroom
in the sysrq-T handler.  Also prints a little summary at
the end of the SYSRQ-T output which shows:

a) which currently-running pid has used the most stack and

b) the name of the process which used the most stack since
   the machine booted.

On my super-stripped-down development box, the answer is

	Minimum ever: `zsh' with 3908 bytes

Against -ac7, it's all dependent upon CONFIG_DEBUG_SLAB.





--- linux-2.4.5-ac7/include/asm-i386/processor.h	Tue Jun  5 17:46:37 2001
+++ ac/include/asm-i386/processor.h	Tue Jun  5 21:20:47 2001
@@ -446,7 +446,21 @@
 #define KSTK_ESP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)))[1022])
 
 #define THREAD_SIZE (2*PAGE_SIZE)
+#ifdef CONFIG_DEBUG_SLAB	/* For tracking max stack utilisation */
+#define HAVE_STACK_PREFILL
+unsigned min_stack_headroom(struct task_struct *tsk);
+#define alloc_task_struct()								\
+	({										\
+		struct task_struct *p =							\
+			((struct task_struct *) __get_free_pages(GFP_KERNEL,1));	\
+		if (p)									\
+			memset(p+1, 0xa5, PAGE_SIZE*2 - sizeof(*p));			\
+		p;									\
+	})
+#else
 #define alloc_task_struct() ((struct task_struct *) __get_free_pages(GFP_KERNEL,1))
+#endif
+
 #define free_task_struct(p) free_pages((unsigned long) (p), 1)
 #define get_task_struct(tsk)      atomic_inc(&virt_to_page(tsk)->count)
 
--- linux-2.4.5-ac7/kernel/sched.c	Tue Jun  5 17:46:37 2001
+++ ac/kernel/sched.c	Tue Jun  5 21:30:02 2001
@@ -1101,9 +1101,31 @@
 	return retval;
 }
 
-static void show_task(struct task_struct * p)
+#ifdef HAVE_STACK_PREFILL
+
+static unsigned min_ever_stack_headroom = ~0U;
+static char min_stack_name[16];
+
+/* tasklist_lock needed if tsk != current */
+unsigned min_stack_headroom(struct task_struct *tsk)
+{
+	unsigned long *p = (unsigned long *)(tsk + 1);
+	unsigned ret;
+	while (*p == 0xa5a5a5a5)
+		p++;
+	ret = (unsigned long)p - (unsigned long)(tsk + 1);
+	if (ret < min_ever_stack_headroom) {
+		min_ever_stack_headroom = ret;
+		strncpy(min_stack_name, tsk->comm, sizeof(min_stack_name));
+	}
+	return ret;
+}
+
+#endif
+
+static void show_task(struct task_struct * p,
+		unsigned *least_spare_stack, pid_t *pid)
 {
-	unsigned long free = 0;
 	int state;
 	static const char * stat_nam[] = { "R", "S", "D", "Z", "T", "W" };
 
@@ -1124,13 +1146,19 @@
 	else
 		printk(" %016lx ", thread_saved_pc(&p->thread));
 #endif
+#ifdef HAVE_STACK_PREFILL
 	{
-		unsigned long * n = (unsigned long *) (p+1);
-		while (!*n)
-			n++;
-		free = (unsigned long) n - (unsigned long)(p+1);
+		unsigned long free = min_stack_headroom(p);
+
+		printk("%5lu %5d %6d ", free, p->pid, p->p_pptr->pid);
+		if (free < *least_spare_stack) {
+			*least_spare_stack = free;
+			*pid = p->pid;
+		}
 	}
-	printk("%5lu %5d %6d ", free, p->pid, p->p_pptr->pid);
+#else
+	printk("%5d ????? %6d ", p->pid, p->p_pptr->pid);
+#endif
 	if (p->p_cptr)
 		printk("%5d ", p->p_cptr->pid);
 	else
@@ -1175,6 +1203,8 @@
 void show_state(void)
 {
 	struct task_struct *p;
+	unsigned least_spare_stack;
+	pid_t pid;
 
 #if (BITS_PER_LONG == 32)
 	printk("\n"
@@ -1185,6 +1215,8 @@
 	       "                                 free                        sibling\n");
 	printk("  task                 PC        stack   pid father child younger older\n");
 #endif
+	least_spare_stack = ~0U;
+	pid = -1;
 	read_lock(&tasklist_lock);
 	for_each_task(p) {
 		/*
@@ -1192,9 +1224,17 @@
 		 * console might take alot of time:
 		 */
 		touch_nmi_watchdog();
-		show_task(p);
+		show_task(p, &least_spare_stack, &pid);
 	}
 	read_unlock(&tasklist_lock);
+#ifdef HAVE_STACK_PREFILL
+	if (pid != -1) {
+		printk("Minimum stack headroom: pid %d with %u bytes\n",
+			pid, least_spare_stack);
+		printk("Minimum ever: `%s' with %u bytes\n",
+				min_stack_name, min_ever_stack_headroom);
+	}
+#endif
 }
 
 /*
--- linux-2.4.5-ac7/kernel/exit.c	Mon May 28 13:31:49 2001
+++ ac/kernel/exit.c	Tue Jun  5 21:07:34 2001
@@ -455,6 +455,9 @@
 
 	tsk->exit_code = code;
 	exit_notify();
+#ifdef HAVE_STACK_PREFILL
+	min_stack_headroom(current);
+#endif
 	schedule();
 	BUG();
 /*
