Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265338AbSJaTQx>; Thu, 31 Oct 2002 14:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265334AbSJaTPf>; Thu, 31 Oct 2002 14:15:35 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:37836 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265333AbSJaTPI>;
	Thu, 31 Oct 2002 14:15:08 -0500
Subject: [PATCH] (3/3) stack overflow checking for x86
From: "David C. Hansen" <haveblue@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.COM>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1036091906.4272.87.camel@nighthawk>
References: <1036091906.4272.87.camel@nighthawk>
Content-Type: multipart/mixed; boundary="=-h09/WPDFbpsfYHhPQzyO"
X-Mailer: Ximian Evolution 1.0.8 
Date: 31 Oct 2002 11:20:52 -0800
Message-Id: <1036092052.4272.96.camel@nighthawk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-h09/WPDFbpsfYHhPQzyO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

* stack checking (3/3)
   - use gcc's profiling features to check for stack overflows upon
     entry to functions.
   - Warn if the task goes over 4k.
   - Panic if the stack gets within 512 bytes of overflowing.
   - use kksymoops information, if available

This won't apply cleanly without the irqstack patch, but the conflict is
easy to resolve.  It requires the thread_info cleanup.
-- 
Dave Hansen
haveblue@us.ibm.com

--=-h09/WPDFbpsfYHhPQzyO
Content-Disposition: attachment; filename=C-stack_usage_check-2.5.45-4.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=C-stack_usage_check-2.5.45-4.patch; charset=ISO-8859-1

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.857.1.1 -> 1.859 =20
#	arch/i386/kernel/process.c	1.32.1.1 -> 1.36  =20
#	arch/i386/kernel/irq.c	1.23.1.1 -> 1.25  =20
#	            Makefile	1.326.2.11 -> 1.329 =20
#	include/asm-i386/thread_info.h	1.10    -> 1.11  =20
#	arch/i386/kernel/entry.S	1.38.1.3 -> 1.46  =20
#	  arch/i386/Makefile	1.24.2.3 -> 1.27  =20
#	arch/i386/boot/compressed/misc.c	1.9     -> 1.10  =20
#	arch/i386/kernel/init_task.c	1.6.1.1 -> 1.8   =20
#	arch/i386/kernel/i386_ksyms.c	1.36.2.3 -> 1.39  =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/31	haveblue@elm3b96.(none)	1.859
# Merge elm3b96.(none):/work/dave/bk/linux-2.5-irq-stack
# into elm3b96.(none):/work/dave/bk/linux-2.5-irq-stack+overflow-detect
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Thu Oct 31 11:13:28 2002
+++ b/Makefile	Thu Oct 31 11:13:28 2002
@@ -168,7 +168,8 @@
=20
 CPPFLAGS	:=3D -D__KERNEL__ -Iinclude
 CFLAGS 		:=3D $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
-	  	   -fomit-frame-pointer -fno-strict-aliasing -fno-common
+	  	   -fno-strict-aliasing -fno-common
+
 AFLAGS		:=3D -D__ASSEMBLY__ $(CPPFLAGS)
=20
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \
@@ -254,6 +255,10 @@
=20
 ifdef CONFIG_MODULES
 export EXPORT_FLAGS :=3D -DEXPORT_SYMTAB
+endif
+
+ifneq ($(CONFIG_FRAME_POINTER),y)
+CFLAGS          +=3D -fomit-frame-pointer
 endif
=20
 #
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Thu Oct 31 11:13:28 2002
+++ b/arch/i386/Makefile	Thu Oct 31 11:13:28 2002
@@ -51,6 +51,10 @@
 MACHINE	:=3D mach-generic
 endif
=20
+ifdef CONFIG_X86_STACK_CHECK
+CFLAGS +=3D -p
+endif
+
 HEAD :=3D arch/i386/kernel/head.o arch/i386/kernel/init_task.o
=20
 libs-y 					+=3D arch/i386/lib/
diff -Nru a/arch/i386/boot/compressed/misc.c b/arch/i386/boot/compressed/mi=
sc.c
--- a/arch/i386/boot/compressed/misc.c	Thu Oct 31 11:13:28 2002
+++ b/arch/i386/boot/compressed/misc.c	Thu Oct 31 11:13:28 2002
@@ -377,3 +377,7 @@
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
 	return high_loaded;
 }
+
+/* We don't actually check for stack overflows this early. */
+__asm__(".globl mcount ; mcount: ret\n");
+
diff -Nru a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Thu Oct 31 11:13:28 2002
+++ b/arch/i386/kernel/entry.S	Thu Oct 31 11:13:28 2002
@@ -519,6 +519,61 @@
 	pushl $do_spurious_interrupt_bug
 	jmp error_code
=20
+
+#ifdef CONFIG_X86_STACK_CHECK
+.data
+	.globl	stack_overflowed
+stack_overflowed:
+	.long	0
+.text
+
+ENTRY(mcount)
+	push %eax
+	movl $(THREAD_SIZE - 1),%eax
+	andl %esp,%eax
+	cmpl $STACK_WARN,%eax	/* more than half the stack is used*/
+	jle 1f
+2:
+	popl %eax
+	ret
+1:=09
+	lock;   btsl    $0,stack_overflowed
+	jc      2b
+=09
+	# switch to overflow stack
+	movl	%esp,%eax
+	movl	$(stack_overflow_stack + THREAD_SIZE - 4),%esp
+
+	pushf
+	cli
+	pushl	%eax
+
+	# push eip then esp of error for stack_overflow_panic
+	pushl	4(%eax)
+	pushl	%eax
+
+	# update the task pointer and cpu in the overflow stack's thread_info.
+	GET_THREAD_INFO_WITH_ESP(%eax)
+	movl	TI_TASK(%eax),%ebx
+	movl	%ebx,stack_overflow_stack+TI_TASK
+	movl	TI_CPU(%eax),%ebx
+	movl	%ebx,stack_overflow_stack+TI_CPU
+
+	call	stack_overflow
+
+	# pop off call arguments
+	addl	$8,%esp=20
+
+	popl	%eax
+	popf
+	movl	%eax,%esp
+	popl	%eax
+	movl	$0,stack_overflowed
+	ret
+
+#warning stack check enabled
+#endif
+
 .data
 ENTRY(sys_call_table)
 	.long sys_ni_syscall	/* 0 - old "setup()" system call*/
diff -Nru a/arch/i386/kernel/i386_ksyms.c b/arch/i386/kernel/i386_ksyms.c
--- a/arch/i386/kernel/i386_ksyms.c	Thu Oct 31 11:13:28 2002
+++ b/arch/i386/kernel/i386_ksyms.c	Thu Oct 31 11:13:28 2002
@@ -211,3 +211,8 @@
 EXPORT_SYMBOL(edd);
 EXPORT_SYMBOL(eddnr);
 #endif
+
+#ifdef CONFIG_X86_STACK_CHECK
+extern void mcount(void);
+EXPORT_SYMBOL(mcount);
+#endif
diff -Nru a/arch/i386/kernel/init_task.c b/arch/i386/kernel/init_task.c
--- a/arch/i386/kernel/init_task.c	Thu Oct 31 11:13:28 2002
+++ b/arch/i386/kernel/init_task.c	Thu Oct 31 11:13:28 2002
@@ -16,6 +16,10 @@
 union thread_union init_irq_union
 	__attribute__((__section__(".data.init_task")));
=20
+#ifdef CONFIG_X86_STACK_CHECK
+union thread_union stack_overflow_stack
+	__attribute__((__section__(".data.init_task")));
+#endif
=20
 /*
  * Initial thread structure.
diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	Thu Oct 31 11:13:28 2002
+++ b/arch/i386/kernel/process.c	Thu Oct 31 11:13:28 2002
@@ -156,7 +156,25 @@
=20
 __setup("idle=3D", idle_setup);
=20
-void show_regs(struct pt_regs * regs)
+void stack_overflow(unsigned long esp, unsigned long eip)
+{
+	int panicing =3D ((esp&(THREAD_SIZE-1)) <=3D STACK_PANIC);
+
+	printk( "esp: 0x%x masked: 0x%x STACK_PANIC:0x%x %d %d\n",=20
+		esp, (esp&(THREAD_SIZE-1)), STACK_PANIC, (((esp&(THREAD_SIZE-1)) <=3D ST=
ACK_PANIC)), panicing );
+=09
+	if (panicing)
+		print_symbol("stack overflow from %s\n", eip);
+	else
+		print_symbol("excessive stack use from %s\n", eip);
+	printk("esp: %p\n", (void*)esp);
+	show_trace((void*)esp);
+=09
+	if (panicing)
+		panic("stack overflow\n");
+}
+
+asmlinkage void show_regs(struct pt_regs * regs)
 {
 	unsigned long cr0 =3D 0L, cr2 =3D 0L, cr3 =3D 0L, cr4 =3D 0L;
=20
diff -Nru a/include/asm-i386/thread_info.h b/include/asm-i386/thread_info.h
--- a/include/asm-i386/thread_info.h	Thu Oct 31 11:13:28 2002
+++ b/include/asm-i386/thread_info.h	Thu Oct 31 11:13:28 2002
@@ -60,6 +60,8 @@
  */
 #define THREAD_ORDER 1=20
 #define INIT_THREAD_SIZE       THREAD_SIZE
+#define STACK_PANIC		0x200ul
+#define STACK_WARN		((THREAD_SIZE)>>1)
=20
 #ifndef __ASSEMBLY__
 #define INIT_THREAD_INFO(tsk)			\

--=-h09/WPDFbpsfYHhPQzyO--

