Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293002AbSBVVRX>; Fri, 22 Feb 2002 16:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287552AbSBVVRP>; Fri, 22 Feb 2002 16:17:15 -0500
Received: from sproxy.gmx.net ([213.165.64.20]:52910 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S293002AbSBVVRB>;
	Fri, 22 Feb 2002 16:17:01 -0500
Subject: [RFC] [PATCH] C exceptions in kernel
From: Dan Aloni <da-x@gmx.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-aY7JTc3QtSki/nzQaZK5"
X-Mailer: Evolution/1.0.2 
Date: 22 Feb 2002 23:12:02 +0200
Message-Id: <1014412325.1074.36.camel@callisto.yi.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aY7JTc3QtSki/nzQaZK5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch implements C exceptions in the kernel, which *don't*
depend on special support from the compiler. This is a 'request for
comments'. The patch is very initial, should not be applied.

I actually got this code to work in the kernel:

        try {
                printk("TEST: before throwing \n");
                throw(1000);
                printk("TEST: won't run\n");
        }
        catch(unsigned long, value) {
                printk("TEST: caught: %ld\n", value);
        } yrt;

I know it would a *hugh* task to get all existing code in the kernel
to use exceptions, but the design allows exceptions to be used locally
within the local call branches in *new* code. Basically, exception
handling needs to be added only to functions who call functions which
already use exceptions.

Although this patch is against 2.4, it should go to 2.5 (2.5.5-dj1
currently breaks here, so I am temporarily developing it using 2.4)

This patch implements only for i386 at the moment. Theoretically can be
ported to other archs. Of course, the arch dependant functions in this
code are separated for the ease of porting.

I haven't written it with interrupts and SMP in mind. I wonder what
are the race conditions and what should be protected there.

For unhandled exceptions, there's a possibility to add a function that
printk's the information about the unhandled exception (file, line
number, etc), and optionally calls panic() or BUG().

The code supports re-throwing from catches.

Last thing: I must get rid of that yrt closer macro. Suggestions?

--=-aY7JTc3QtSki/nzQaZK5
Content-Disposition: attachment; filename=exceptions.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset=ISO-8859-1

diff -urN 2.4.18-ac3/arch/i386/kernel/Makefile 2.4.18-ac3-exceptions/arch/i=
386/kernel/Makefile
--- 2.4.18-ac3/arch/i386/kernel/Makefile	Sat Jan 19 10:22:58 2002
+++ 2.4.18-ac3-exceptions/arch/i386/kernel/Makefile	Fri Feb 22 20:09:09 200=
2
@@ -18,7 +18,8 @@
=20
 obj-y	:=3D process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
-		pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o
+		pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o \
+		exception.o
=20
=20
 ifdef CONFIG_PCI
diff -urN 2.4.18-ac3/arch/i386/kernel/exception.S 2.4.18-ac3-exceptions/arc=
h/i386/kernel/exception.S
--- 2.4.18-ac3/arch/i386/kernel/exception.S	Thu Jan  1 02:00:00 1970
+++ 2.4.18-ac3-exceptions/arch/i386/kernel/exception.S	Fri Feb 22 20:18:45 =
2002
@@ -0,0 +1,112 @@
+/*
+ *   linux/arch/i386/kernel/exception.S
+ *
+ *   2002, Dan Aloni <da-x@gmx.net>
+ *
+ *   i386-specific exceptions implementation
+ */
+
+/*=20
+ * offsets of stuff in except_t=20
+ */
+=09
+#define VALUE_OFFSET 0x18
+#define PREV_OFFSET 0x1c
+
+/*=20
+ * no data, define anyway
+ */
+=09
+.data
+.align 4
+
+/*
+ * code section
+ */
+=09
+.text=09
+.align 4
+
+/*
+ * long try_exception(except_t **current_frame, *this_exception)
+ *
+ * This function is used in the beginning of the try block. The function
+ * saves the current state of execution, which is the stack pointers, IP
+ * to return to, and the registers that a reserved during function calls.
+ *
+ * This function returns *twice*. Once with return value 0, for the normal=
.=20
+ * execution, and second when the exception is caught, throw_exception=20
+ * restores the execution state and sets the return value to 1.
+ *
+ * current_frame is the per-process variable that stores a pointer to
+ * the current exception frame (except_t), i.e, the exception frame that=20
+ * was created by the most recent 'try' block in the current execution.
+ *
+ * this_exception is the new exception frame to initialize.
+ */
+=09
+.globl try_exception
+try_exception:
+	movl 0x4(%esp),%ecx /* current_frame */
+	movl 0x8(%esp),%eax /* this_exception */
+
+	/* this_exception->prev =3D current_frame */
+	/* current_frame =3D this_exception */
+=09
+	movl (%ecx), %edx
+	movl %edx, PREV_OFFSET (%eax)
+	movl %eax, (%ecx)
+
+	/* save return address, ebp, esi, edi, ebx, esp */
+	movl (%esp), %ecx
+	movl %ecx, 0x0(%eax)
+	movl %ebp, 0x4(%eax)
+	movl %esi, 0x8(%eax)
+	movl %edi, 0xC(%eax)=20
+	movl %ebx, 0x10(%eax)
+	movl %esp, 0x14(%eax)
+	xorl %eax, %eax
+	ret
+
+/*
+ * throw_exception(except_t *current_frame, unsigned long value)
+ *
+ * Throws an exception with the given value. This restores the state that
+ * was saved in the frame using try_exception, and jumps back to where
+ * try_exception was called, with return value of 1. current_frame points
+ * to the current exception.=20
+ *
+ * If current_frame =3D=3D NULL, there is no code to catch the exception!
+ * in that case, throw_exception will return 1
+ *
+ */
+=09
+.align 4
+.globl throw_exception
+throw_exception:
+	movl 0x4(%esp), %eax /* current_frame */
+	test %eax, %eax      /* return 1 if there's no handler */
+	jz no_handler
+	movl 0x8(%esp), %edx /* value */
+
+	/* restore execution state */
+	movl 0x0(%eax), %ecx
+	movl 0x4(%eax), %ebp
+	movl 0x8(%eax), %esi
+	movl 0xC(%eax), %edi=20
+	movl 0x10(%eax), %ebx
+	movl 0x14(%eax), %esp
+
+	/* set the exception value */
+	addl $4, %esp
+	movl %edx, VALUE_OFFSET (%eax)
+
+	/* jump back to where try_exception returns */
+	movl $0x1, %eax
+	jmpl *%ecx
+
+no_handler:
+	xorl %eax, %eax
+	ret=20
+=09
+.align 4
diff -urN 2.4.18-ac3/include/asm-i386/exception.h 2.4.18-ac3-exceptions/inc=
lude/asm-i386/exception.h
--- 2.4.18-ac3/include/asm-i386/exception.h	Thu Jan  1 02:00:00 1970
+++ 2.4.18-ac3-exceptions/include/asm-i386/exception.h	Fri Feb 22 21:08:21 =
2002
@@ -0,0 +1,13 @@
+#ifndef _I386_EXCEPTION_H
+#define _I386_EXCEPTION_H
+
+struct exception_arch_struct {
+	unsigned long eip; /* 0x0 */
+	unsigned long ebp; /* 0x4 */
+	unsigned long esi; /* 0x8 */
+	unsigned long edi; /* 0xC */
+	unsigned long ebx; /* 0x10 */
+	unsigned long esp; /* 0x14 */
+};
+
+#endif
diff -urN 2.4.18-ac3/include/linux/exception.h 2.4.18-ac3-exceptions/includ=
e/linux/exception.h
--- 2.4.18-ac3/include/linux/exception.h	Thu Jan  1 02:00:00 1970
+++ 2.4.18-ac3-exceptions/include/linux/exception.h	Fri Feb 22 21:12:40 200=
2
@@ -0,0 +1,83 @@
+#ifndef _LINUX_EXCEPTION_H
+#define _LINUX_EXCEPTION_H
+
+/*
+ * linux/include/linux/exception.h
+ *
+ * 2002, Dan Aloni <da-x@gmx.net>
+ *
+ * C exceptions for the Linux kernel.
+ */
+
+#include <asm/exception.h>
+#include <linux/sched.h>
+
+/*=20
+ * struct exception_struct - an exception frame=20
+ *
+ * These are linked together from the current->exception and down using th=
e 'prev' field
+ * to the first exception in the current thread.
+ */
+
+struct exception_struct {
+	struct exception_arch_struct arch;  /* arch dependant stuff */
+	unsigned long value;                /* exception value */
+	struct exception_struct *prev;      /* previous frame */
+	unsigned char caught;               /* was this frame's catch ran already=
 */
+};
+
+typedef struct exception_struct except_t;
+
+/* implementation can be found in arch/<arch>/kernel/exception.S */
+
+extern long try_exception(struct exception_struct **current_frame, struct =
exception_struct *e);
+extern void throw_exception(struct exception_struct *current_frame, unsign=
ed long value);
+
+/*
+ * try, catch, throw, and yrt overlapping macros with current->exception a=
s the
+ * current exception frame.
+ */
+
+#define try try__cur_frame(current->exception)
+#define catch(_type_, _dec_) catch__cur_frame(current->exception, _type_, =
_dec_)
+#define throw(_value_) throw__cur_frame(current->exception, _value_)
+#define yrt yrt__cur_frame(current->exception)
+
+
+/*=20
+ * begin a try block:
+ */
+
+#define try__cur_frame(_cur_frame_) { \
+	struct exception_struct _exception_; \
+	if (!try_exception(&(_cur_frame_), &_exception_)) \
+
+/*
+ * begin a catch block:
+ */
+
+#define catch__cur_frame(_cur_frame_, _type_, _dec_) \
+        else { \
+		struct exception_struct *_this_frame_ =3D _cur_frame_; \
+		_type_ _dec_ =3D (_type_)_this_frame_->value; \
+		_exception_.caught =3D 1; \
+		_cur_frame_ =3D _this_frame_->prev; {=20
+
+/*
+ * throw function:=20
+ */
+
+#define throw__cur_frame(_cur_frame_, _value_) \
+		throw_exception(_cur_frame_, (unsigned long)_value_)
+
+/*
+ * yrt - this macro must end an exception frame declaration.
+ */
+
+#define yrt__cur_frame(_cur_frame_) } }; \
+	if (!_exception_.caught) \
+		_cur_frame_ =3D (_cur_frame_)->prev;  \
+}
+
+#endif
+
diff -urN 2.4.18-ac3/include/linux/sched.h 2.4.18-ac3-exceptions/include/li=
nux/sched.h
--- 2.4.18-ac3/include/linux/sched.h	Fri Feb 22 11:51:15 2002
+++ 2.4.18-ac3-exceptions/include/linux/sched.h	Fri Feb 22 20:28:40 2002
@@ -385,6 +385,7 @@
 	struct sem_queue *semsleeping;
 /* CPU-specific state of this task */
 	struct thread_struct thread;
+	struct exception_struct *exception;
 /* filesystem information */
 	struct fs_struct *fs;
 /* open file information */

--=-aY7JTc3QtSki/nzQaZK5--

