Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291603AbSBHPRx>; Fri, 8 Feb 2002 10:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291608AbSBHPRn>; Fri, 8 Feb 2002 10:17:43 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:8520 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S291603AbSBHPRQ>;
	Fri, 8 Feb 2002 10:17:16 -0500
Date: Fri, 8 Feb 2002 15:20:19 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: <linux-kernel@vger.kernel.org>
cc: Hugh Dickins <hugh@veritas.com>
Subject: [patch] larger kernel stack (8k->16k) per task
Message-ID: <Pine.LNX.4.33.0202081511400.1359-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In the light of some talks here about increasing kernel stack, here is my
patch for i386 architecture that some may find useful. It also has a nice
extra (/proc/stack) implemented by Hugh Dickins which helps to find major
offenders.

It is against 2.4.9 but should be easy to port in any direction. (One way
the patch could be improved is by making the size CONFIG_ option instead
of hardcoding). Oh btw, please don't tell me "but now you'd need _four_
physically-contiguous pages to create a task instead of two!" because I
know it (and think it's not too bad).

Regards,
Tigran

diff -urN 249-vx/arch/i386/kernel/entry.S 249-vx-bigstack/arch/i386/kernel/entry.S
--- 249-vx/arch/i386/kernel/entry.S	Tue Jun 12 19:47:28 2001
+++ 249-vx-bigstack/arch/i386/kernel/entry.S	Sun Jan 13 00:14:30 2002
@@ -130,7 +130,7 @@
 .previous

 #define GET_CURRENT(reg) \
-	movl $-8192, reg; \
+	movl $-16384, reg; \
 	andl %esp, reg

 ENTRY(lcall7)
@@ -145,7 +145,7 @@
 	movl %ecx,CS(%esp)	#
 	movl %esp,%ebx
 	pushl %ebx
-	andl $-8192,%ebx	# GET_CURRENT
+	andl $-16384,%ebx	# GET_CURRENT
 	movl exec_domain(%ebx),%edx	# Get the execution domain
 	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	pushl $0x7
@@ -166,7 +166,7 @@
 	movl %ecx,CS(%esp)	#
 	movl %esp,%ebx
 	pushl %ebx
-	andl $-8192,%ebx	# GET_CURRENT
+	andl $-16384,%ebx	# GET_CURRENT
 	movl exec_domain(%ebx),%edx	# Get the execution domain
 	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
 	pushl $0x27
diff -urN 249-vx/arch/i386/kernel/head.S 249-vx-bigstack/arch/i386/kernel/head.S
--- 249-vx/arch/i386/kernel/head.S	Wed Jun 20 19:00:53 2001
+++ 249-vx-bigstack/arch/i386/kernel/head.S	Sun Jan 13 00:14:30 2002
@@ -320,7 +320,7 @@
 	ret

 ENTRY(stack_start)
-	.long SYMBOL_NAME(init_task_union)+8192
+	.long SYMBOL_NAME(init_task_union)+16384
 	.long __KERNEL_DS

 /* This is the default interrupt "handler" :-) */
diff -urN 249-vx/arch/i386/kernel/process.c 249-vx-bigstack/arch/i386/kernel/process.c
--- 249-vx/arch/i386/kernel/process.c	Thu Jul 26 02:19:11 2001
+++ 249-vx-bigstack/arch/i386/kernel/process.c	Sun Jan 13 00:14:30 2002
@@ -757,12 +757,12 @@
 		return 0;
 	stack_page = (unsigned long)p;
 	esp = p->thread.esp;
-	if (!stack_page || esp < stack_page || esp > 8188+stack_page)
+	if (!stack_page || esp < stack_page || esp > 16380+stack_page)
 		return 0;
 	/* include/asm-i386/system.h:switch_to() pushes ebp last. */
 	ebp = *(unsigned long *) esp;
 	do {
-		if (ebp < stack_page || ebp > 8184+stack_page)
+		if (ebp < stack_page || ebp > 16376+stack_page)
 			return 0;
 		eip = *(unsigned long *) (ebp+4);
 		if (eip < first_sched || eip >= last_sched)
diff -urN 249-vx/arch/i386/kernel/smpboot.c 249-vx-bigstack/arch/i386/kernel/smpboot.c
--- 249-vx/arch/i386/kernel/smpboot.c	Tue Feb 13 22:13:43 2001
+++ 249-vx-bigstack/arch/i386/kernel/smpboot.c	Sun Jan 13 00:14:30 2002
@@ -577,7 +577,7 @@

 	/* So we see what's up   */
 	printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
-	stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle);
+	stack_start.esp = (void *) idle->thread.esp;

 	/*
 	 * This grunge runs the startup process for
diff -urN 249-vx/arch/i386/kernel/traps.c 249-vx-bigstack/arch/i386/kernel/traps.c
--- 249-vx/arch/i386/kernel/traps.c	Sun Aug 12 19:13:59 2001
+++ 249-vx-bigstack/arch/i386/kernel/traps.c	Sun Jan 13 00:14:30 2002
@@ -160,7 +160,7 @@
 	unsigned long esp = tsk->thread.esp;

 	/* User space on another CPU? */
-	if ((esp ^ (unsigned long)tsk) & (PAGE_MASK<<1))
+	if ((esp ^ (unsigned long)tsk) & ~(THREAD_SIZE-1))
 		return;
 	show_trace((unsigned long *)esp);
 }
diff -urN 249-vx/arch/i386/lib/getuser.S 249-vx-bigstack/arch/i386/lib/getuser.S
--- 249-vx/arch/i386/lib/getuser.S	Mon Jan 12 21:42:52 1998
+++ 249-vx-bigstack/arch/i386/lib/getuser.S	Sun Jan 13 00:14:30 2002
@@ -28,7 +28,7 @@
 .globl __get_user_1
 __get_user_1:
 	movl %esp,%edx
-	andl $0xffffe000,%edx
+	andl $-16384,%edx
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 1:	movzbl (%eax),%edx
@@ -41,7 +41,7 @@
 	addl $1,%eax
 	movl %esp,%edx
 	jc bad_get_user
-	andl $0xffffe000,%edx
+	andl $-16384,%edx
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 2:	movzwl -1(%eax),%edx
@@ -54,7 +54,7 @@
 	addl $3,%eax
 	movl %esp,%edx
 	jc bad_get_user
-	andl $0xffffe000,%edx
+	andl $-16384,%edx
 	cmpl addr_limit(%edx),%eax
 	jae bad_get_user
 3:	movl -3(%eax),%edx
diff -urN 249-vx/arch/i386/vmlinux.lds 249-vx-bigstack/arch/i386/vmlinux.lds
--- 249-vx/arch/i386/vmlinux.lds	Sat Jan 12 21:31:54 2002
+++ 249-vx-bigstack/arch/i386/vmlinux.lds	Sun Jan 13 00:14:30 2002
@@ -36,7 +36,7 @@

   _edata = .;			/* End of data section */

-  . = ALIGN(8192);		/* init_task */
+  . = ALIGN(16384);		/* init_task */
   .data.init_task : { *(.data.init_task) }

   . = ALIGN(4096);		/* Init code and data */
diff -urN 249-vx/include/asm-i386/current.h 249-vx-bigstack/include/asm-i386/current.h
--- 249-vx/include/asm-i386/current.h	Sat Aug 15 00:35:22 1998
+++ 249-vx-bigstack/include/asm-i386/current.h	Sun Jan 13 00:14:30 2002
@@ -6,7 +6,7 @@
 static inline struct task_struct * get_current(void)
 {
 	struct task_struct *current;
-	__asm__("andl %%esp,%0; ":"=r" (current) : "0" (~8191UL));
+	__asm__("andl %%esp,%0; ":"=r" (current) : "0" (~16383UL));
 	return current;
  }

diff -urN 249-vx/include/asm-i386/hw_irq.h 249-vx-bigstack/include/asm-i386/hw_irq.h
--- 249-vx/include/asm-i386/hw_irq.h	Wed Aug 15 22:21:11 2001
+++ 249-vx-bigstack/include/asm-i386/hw_irq.h	Sun Jan 13 00:14:30 2002
@@ -115,7 +115,7 @@

 #define GET_CURRENT \
 	"movl %esp, %ebx\n\t" \
-	"andl $-8192, %ebx\n\t"
+	"andl $-16384, %ebx\n\t"

 /*
  *	SMP has a few special interrupts for IPI messages
diff -urN 249-vx/include/asm-i386/processor.h 249-vx-bigstack/include/asm-i386/processor.h
--- 249-vx/include/asm-i386/processor.h	Wed Aug 15 22:21:11 2001
+++ 249-vx-bigstack/include/asm-i386/processor.h	Sun Jan 13 00:14:30 2002
@@ -445,13 +445,27 @@
 }

 unsigned long get_wchan(struct task_struct *p);
-#define KSTK_EIP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)))[1019])
-#define KSTK_ESP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)))[1022])

-#define THREAD_SIZE (2*PAGE_SIZE)
-#define alloc_task_struct() ((struct task_struct *) __get_free_pages(GFP_KERNEL,1))
-#define free_task_struct(p) free_pages((unsigned long) (p), 1)
-#define get_task_struct(tsk)      atomic_inc(&virt_to_page(tsk)->count)
+#define THREAD_ORDER	2
+#define THREAD_SIZE	(PAGE_SIZE << THREAD_ORDER)
+#define THREAD_LONGS	(THREAD_SIZE / sizeof(unsigned long))
+
+#define KSTK_EIP(tsk)	(((unsigned long *)(tsk))[THREAD_LONGS-5])
+#define KSTK_ESP(tsk)	(((unsigned long *)(tsk))[THREAD_LONGS-2])
+
+#define alloc_task_struct()						\
+    ({									\
+	unsigned long tsk = __get_free_pages(GFP_KERNEL, THREAD_ORDER);	\
+	if (tsk != 0) {							\
+		/* Alt-SysRq-T show_task() show if stack went deep */	\
+		memset((char*)tsk+sizeof(struct task_struct), 0,	\
+			THREAD_SIZE-sizeof(struct task_struct));	\
+	}								\
+	(struct task_struct *) tsk;					\
+    })
+
+#define free_task_struct(tsk) free_pages((unsigned long) (tsk), THREAD_ORDER)
+#define get_task_struct(tsk)  atomic_inc(&virt_to_page(tsk)->count)

 #define init_task	(init_task_union.task)
 #define init_stack	(init_task_union.stack)
diff -urN 249-vx/include/linux/sched.h 249-vx-bigstack/include/linux/sched.h
--- 249-vx/include/linux/sched.h	Sat Jan 12 23:53:58 2002
+++ 249-vx-bigstack/include/linux/sched.h	Sun Jan 13 00:14:30 2002
@@ -484,7 +484,7 @@


 #ifndef INIT_TASK_SIZE
-# define INIT_TASK_SIZE	2048*sizeof(long)
+# define INIT_TASK_SIZE	4096*sizeof(long)
 #endif

 union task_union {
diff -urN 249-vx/kernel/exit.c 249-vx-bigstack/kernel/exit.c
--- 249-vx/kernel/exit.c	Sun Aug 12 18:52:29 2001
+++ 249-vx-bigstack/kernel/exit.c	Sun Jan 13 00:14:30 2002
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/completion.h>
 #include <linux/tty.h>
+#include <linux/proc_fs.h>
 #ifdef CONFIG_BSD_PROCESS_ACCT
 #include <linux/acct.h>
 #endif
@@ -24,6 +25,74 @@

 int getrusage(struct task_struct *, int, struct rusage *);

+#ifdef CONFIG_PROC_FS
+static int max_stack_depth;
+static pid_t max_stack_pid;
+static struct task_struct *max_stack_task; /* kept for kdb */
+static spinlock_t max_stack_lock = SPIN_LOCK_UNLOCKED;
+static void check_stack_depth(struct task_struct *);
+
+static int stack_read_proc(char *page, char **start, off_t off,
+				int count, int *eof, void *data)
+{
+	struct task_struct *p;
+	int len;
+
+	read_lock(&tasklist_lock);
+	for_each_task(p)
+		check_stack_depth(p);
+	read_unlock(&tasklist_lock);
+
+	spin_lock(&max_stack_lock);
+	len = sprintf(page,
+		"Deepest stack is 0x%04x (+ task 0x%04x = 0x%04x) for pid %d %.16s\n",
+		max_stack_depth, sizeof(*p), sizeof(*p) + max_stack_depth,
+		max_stack_pid, max_stack_task->comm);
+	spin_unlock(&max_stack_lock);
+
+	*eof = (len <= off + count);
+	*start = page + off;
+	len -= off;
+	if (len > count)
+		len = count;
+	if (len < 0)
+		len = 0;
+	return len;
+}
+
+static void check_stack_depth(struct task_struct *p)
+{
+	int depth;
+	struct task_struct *old_stack_task;
+	unsigned long *sp = (unsigned long *)(p + 1);
+
+	while (!*sp)
+		sp++;
+	depth = (int)p + THREAD_SIZE - (int)sp;
+	if (depth <= max_stack_depth)
+		return;
+
+	old_stack_task = NULL;
+	spin_lock(&max_stack_lock);
+	if (depth > max_stack_depth) {
+		old_stack_task = max_stack_task;
+		max_stack_depth = depth;
+		max_stack_pid = p->pid;
+		max_stack_task = p;
+		get_task_struct(p);
+	}
+	spin_unlock(&max_stack_lock);
+
+	if (old_stack_task)
+		free_task_struct(old_stack_task);
+	else
+		create_proc_read_entry("stack",
+			0444, NULL, stack_read_proc, NULL);
+}
+#else  /* ndef CONFIG_PROC_FS */
+#define check_stack_depth(p)	do { } while (0)
+#endif /* ndef CONFIG_PROC_FS */
+
 static void release_task(struct task_struct * p)
 {
 	if (p != current) {
@@ -63,6 +132,7 @@
 		current->counter += p->counter;
 		if (current->counter >= MAX_COUNTER)
 			current->counter = MAX_COUNTER;
+		check_stack_depth(p);
 		p->pid = 0;
 		free_task_struct(p);
 	} else {

