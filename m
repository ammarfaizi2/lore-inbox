Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291795AbSBHUmk>; Fri, 8 Feb 2002 15:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291806AbSBHUm1>; Fri, 8 Feb 2002 15:42:27 -0500
Received: from f39.law11.hotmail.com ([64.4.17.39]:42245 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S291802AbSBHUmI>;
	Fri, 8 Feb 2002 15:42:08 -0500
X-Originating-IP: [156.153.254.10]
From: "Balbir Singh" <balbir_soni@hotmail.com>
To: tigran@veritas.com
Cc: linux-kernel@vger.kernel.org, balbir_soni@hotmail.com
Subject: Re: [patch] larger kernel stack (8k->16k) per task (fwd)
Date: Fri, 08 Feb 2002 12:42:02 -0800
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_769_4aa9_45ba"
Message-ID: <F39q2pNdXfH4Ryzp5fO0000a02b@hotmail.com>
X-OriginalArrivalTime: 08 Feb 2002 20:42:02.0489 (UTC) FILETIME=[0FF46690:01C1B0E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_769_4aa9_45ba
Content-Type: text/plain; format=flowed

Modified the patch to fix smpboot.c and traps.c
vmlinux.lds and sched.h need not be fixed. The
size of INIT_TASK is still 8K, so that other
architectures using 8K stacks are not hurt.

This is a patch specific to i386. Its main use is to debug
kernel code which causes an overflow of the kernel stack.
It is highly recommended to use the existing stack size of
8KB, increasing the stack size to 16KB with an 200
processes running on an average causes 1.5MB of
extra memory to be used.

I have tested this patch on my desktop to my satisfaction.
I do not think that this affects an SMP system. Testing on
an SMP box and reporting Bugs and/or success of the patch
would be highly appreciated.

The patch is included as an attachment along with this
email.



>
>Hi Balbir,
>
>On Fri, 8 Feb 2002, Balbir Singh wrote:
> > 2. I think you missed getuser.S in arch/i386/kernel/lib.
> >    All the __get_user_x should change to
>
>no, I didn't miss them. If you read the patch again you will see them.
>
> >
> > 3. I verified that the instance of GET_CURRENT in hw-irq.h
> >    is not being used by anybody and can safely be removed.
>
>yes, I also verified and came to the same conclusion but left the change
>in the patch on purpose (so if anyone does start using it, it is already
>correct)
>
> >
> > __get_user_1:
> >         movl %esp,%edx
> >         andl $~(THREAD_SIZE - 1),%edx
> >         cmpl addr_limit(%edx),%eax
> >
> > I have a patch that lets the user select any stack size
> > from 8K to 64K, it can be configured. And yes, it works
> > on my system.
> >
> > I do not have the /proc entry that u have though in
> > my patch.
> >
> > Would you like to merge both the patches or would you
> > like me to do it and send out a new version.
> >
> >
> > The patch is attached along with this email. It
> > is againt 2.4.17
>
>The serious problem with your patch is that you missed quite a few places
>(e.g.  smpboot.c and traps.c). Most importantly, you missed the alignment
>in vmlinux.lds so I guess your machine boots by pure luck :) In the early
>stages (first hours of writing it) I missed that one too and was puzzled
>by random panics on boot...
>
>Actually, the patch I sent is only part of the "complete piece", the other
>part being changes to kdb to work correctly with large stack. I can
>separate those from kdb patch that I use and send out if there was enough
>interest.
>
>Regards,
>Tigran
>




_________________________________________________________________
Send and receive Hotmail on your mobile device: http://mobile.msn.com

------=_NextPart_000_769_4aa9_45ba
Content-Type: text/plain; name="big_stack_patch.diff.txt"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="big_stack_patch.diff.txt"

diff -Naur linux/arch/i386/config.in linux-new/arch/i386/config.in
--- linux/arch/i386/config.in	Fri Dec 21 10:41:53 2001
+++ linux-new/arch/i386/config.in	Wed Feb  6 19:14:10 2002
@@ -413,6 +413,26 @@
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
    bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
-fi
+   choice 'Bigger Stack Size Support' \
+	"off    CONFIG_NOBIGSTACK \
+	 16KB   CONFIG_STACK_SIZE_16KB \
+	 32KB   CONFIG_STACK_SIZE_32KB \
+	 64KB   CONFIG_STACK_SIZE_64KB" off

+  if [ "$CONFIG_NOBIGSTACK" = "y" ]; then
+     define_int CONFIG_STACK_SIZE_SHIFT 1
+  else
+    if [ "$CONFIG_STACK_SIZE_16KB" = "y" ]; then
+       define_int CONFIG_STACK_SIZE_SHIFT 2
+    else
+      if [ "$CONFIG_STACK_SIZE_32KB" = "y" ]; then
+        define_int CONFIG_STACK_SIZE_SHIFT 3
+      else
+        if [ "$CONFIG_STACK_SIZE_64KB" = "y" ]; then
+          define_int CONFIG_STACK_SIZE_SHIF 4
+        fi
+      fi
+    fi
+  fi
+fi
endmenu
diff -Naur linux/arch/i386/kernel/entry.S linux-new/arch/i386/kernel/entry.S
--- linux/arch/i386/kernel/entry.S	Fri Nov  2 18:18:49 2001
+++ linux-new/arch/i386/kernel/entry.S	Wed Feb  6 18:51:55 2002
@@ -45,6 +45,7 @@
#include <linux/linkage.h>
#include <asm/segment.h>
#include <asm/smp.h>
+#include <asm/current.h>

EBX		= 0x00
ECX		= 0x04
@@ -128,10 +129,6 @@
	.long 3b,6b;	\
.previous

-#define GET_CURRENT(reg) \
-	movl $-8192, reg; \
-	andl %esp, reg
-
ENTRY(lcall7)
	pushfl			# We get a different stack layout with call gates,
	pushl %eax		# which has to be cleaned up later..
@@ -144,7 +141,7 @@
	movl %ecx,CS(%esp)	#
	movl %esp,%ebx
	pushl %ebx
-	andl $-8192,%ebx	# GET_CURRENT
+	andl $-THREAD_SIZE,%ebx	# GET_CURRENT
	movl exec_domain(%ebx),%edx	# Get the execution domain
	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
	pushl $0x7
@@ -165,7 +162,7 @@
	movl %ecx,CS(%esp)	#
	movl %esp,%ebx
	pushl %ebx
-	andl $-8192,%ebx	# GET_CURRENT
+	andl $-THREAD_SIZE,%ebx	# GET_CURRENT
	movl exec_domain(%ebx),%edx	# Get the execution domain
	movl 4(%edx),%edx	# Get the lcall7 handler for the domain
	pushl $0x27
diff -Naur linux/arch/i386/kernel/init_task.c 
linux-new/arch/i386/kernel/init_task.c
--- linux/arch/i386/kernel/init_task.c	Mon Sep 17 16:29:09 2001
+++ linux-new/arch/i386/kernel/init_task.c	Wed Feb  6 16:43:52 2002
@@ -14,7 +14,7 @@
/*
  * Initial task structure.
  *
- * We need to make sure that this is 8192-byte aligned due to the
+ * We need to make sure that this is 16384-byte aligned due to the
  * way process stacks are handled. This is done by having a special
  * "init_task" linker map entry..
  */
diff -Naur linux/arch/i386/kernel/smpboot.c 
linux-new/arch/i386/kernel/smpboot.c
--- linux/arch/i386/kernel/smpboot.c	Fri Dec 21 10:41:53 2001
+++ linux-new/arch/i386/kernel/smpboot.c	Fri Feb  8 13:23:28 2002
@@ -819,7 +819,7 @@

	/* So we see what's up   */
	printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
-	stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle);
+	stack_start.esp = (void *)idle->thread.esp;

	/*
	 * This grunge runs the startup process for
diff -Naur linux/arch/i386/kernel/traps.c linux-new/arch/i386/kernel/traps.c
--- linux/arch/i386/kernel/traps.c	Sun Sep 30 13:26:08 2001
+++ linux-new/arch/i386/kernel/traps.c	Fri Feb  8 13:20:04 2002
@@ -158,7 +158,7 @@
	unsigned long esp = tsk->thread.esp;

	/* User space on another CPU? */
-	if ((esp ^ (unsigned long)tsk) & (PAGE_MASK<<1))
+	if ((esp ^ (unsigned long)tsk) & ~(THREAD_SIZE - 1))
		return;
	show_trace((unsigned long *)esp);
}
diff -Naur linux/arch/i386/lib/getuser.S linux-new/arch/i386/lib/getuser.S
--- linux/arch/i386/lib/getuser.S	Mon Jan 12 14:42:52 1998
+++ linux-new/arch/i386/lib/getuser.S	Fri Feb  8 11:20:26 2002
@@ -21,6 +21,10 @@
  * as they get called from within inline assembly.
  */

+/* Duplicated from asm/processor.h */
+#include <asm/current.h>
+#include <linux/config.h>
+
addr_limit = 12

.text
@@ -28,7 +32,7 @@
.globl __get_user_1
__get_user_1:
	movl %esp,%edx
-	andl $0xffffe000,%edx
+	andl $~(THREAD_SIZE - 1),%edx
	cmpl addr_limit(%edx),%eax
	jae bad_get_user
1:	movzbl (%eax),%edx
@@ -41,7 +45,7 @@
	addl $1,%eax
	movl %esp,%edx
	jc bad_get_user
-	andl $0xffffe000,%edx
+	andl $~(THREAD_SIZE - 1),%edx
	cmpl addr_limit(%edx),%eax
	jae bad_get_user
2:	movzwl -1(%eax),%edx
@@ -54,7 +58,7 @@
	addl $3,%eax
	movl %esp,%edx
	jc bad_get_user
-	andl $0xffffe000,%edx
+	andl $~(THREAD_SIZE - 1),%edx
	cmpl addr_limit(%edx),%eax
	jae bad_get_user
3:	movl -3(%eax),%edx
diff -Naur linux/include/asm-i386/current.h 
linux-new/include/asm-i386/current.h
--- linux/include/asm-i386/current.h	Fri Aug 14 17:35:22 1998
+++ linux-new/include/asm-i386/current.h	Wed Feb  6 20:05:53 2002
@@ -1,15 +1,44 @@
#ifndef _I386_CURRENT_H
#define _I386_CURRENT_H

+#include <asm/page.h>
+
+/*
+ * Configurable page sizes on i386, mainly for debugging purposes.
+ * (c) Balbir Singh
+ */
+
+#ifdef __ASSEMBLY__
+
+#define PAGE_SIZE	4096	/* as cannot handle 1UL << 12 */
+#define THREAD_SIZE ((1 << CONFIG_STACK_SIZE_SHIFT) * PAGE_SIZE)
+
+#else	/* __ASSEMBLY__ */
+
+#define THREAD_SIZE ((1 << CONFIG_STACK_SIZE_SHIFT) * PAGE_SIZE)
+#define alloc_task_struct() \
+  ((struct task_struct *) 
__get_free_pages(GFP_KERNEL,CONFIG_STACK_SIZE_SHIFT))
+
+#define free_task_struct(p) \
+  free_pages((unsigned long) (p), CONFIG_STACK_SIZE_SHIFT)
+
struct task_struct;

static inline struct task_struct * get_current(void)
{
	struct task_struct *current;
-	__asm__("andl %%esp,%0; ":"=r" (current) : "0" (~8191UL));
+	__asm__("andl %%esp,%0; ":"=r" (current) : "0" (~(THREAD_SIZE - 1)));
	return current;
- }
-
+}
+
#define current get_current()

+#endif /* __ASSEMBLY__ */
+
+#define GET_CURRENT(reg) \
+        movl $-THREAD_SIZE, (reg); \
+        andl %esp, (reg)
+
+
#endif /* !(_I386_CURRENT_H) */
+#define THREAD_SIZE ((1 << CONFIG_STACK_SIZE_SHIFT) * PAGE_SIZE)
diff -Naur linux/include/asm-i386/hw_irq.h 
linux-new/include/asm-i386/hw_irq.h
--- linux/include/asm-i386/hw_irq.h	Thu Nov 22 12:46:18 2001
+++ linux-new/include/asm-i386/hw_irq.h	Wed Feb  6 20:05:55 2002
@@ -15,6 +15,7 @@
#include <linux/config.h>
#include <asm/atomic.h>
#include <asm/irq.h>
+#include <asm/current.h>

/*
  * IDT vectors usable for external interrupt sources start
@@ -113,10 +114,6 @@
#define IRQ_NAME2(nr) nr##_interrupt(void)
#define IRQ_NAME(nr) IRQ_NAME2(IRQ##nr)

-#define GET_CURRENT \
-	"movl %esp, %ebx\n\t" \
-	"andl $-8192, %ebx\n\t"
-
/*
  *	SMP has a few special interrupts for IPI messages
  */
diff -Naur linux/include/asm-i386/processor.h 
linux-new/include/asm-i386/processor.h
--- linux/include/asm-i386/processor.h	Thu Nov 22 12:46:19 2001
+++ linux-new/include/asm-i386/processor.h	Wed Feb  6 20:05:55 2002
@@ -14,6 +14,7 @@
#include <asm/types.h>
#include <asm/sigcontext.h>
#include <asm/cpufeature.h>
+#include <asm/current.h>
#include <linux/cache.h>
#include <linux/config.h>
#include <linux/threads.h>
@@ -447,9 +448,6 @@
#define KSTK_EIP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)))[1019])
#define KSTK_ESP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)))[1022])

-#define THREAD_SIZE (2*PAGE_SIZE)
-#define alloc_task_struct() ((struct task_struct *) 
__get_free_pages(GFP_KERNEL,1))
-#define free_task_struct(p) free_pages((unsigned long) (p), 1)
#define get_task_struct(tsk)      atomic_inc(&virt_to_page(tsk)->count)

#define init_task	(init_task_union.task)


------=_NextPart_000_769_4aa9_45ba--
