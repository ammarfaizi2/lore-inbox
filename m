Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030511AbVIAWyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030511AbVIAWyy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030500AbVIAWx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:53:28 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:37392 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1030499AbVIAWxX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:53:23 -0400
Message-Id: <200509012217.j81MH5II011540@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 5/12] UML - Use host AIO support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Sep 2005 18:17:05 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes UML use host AIO support when it (and 
/usr/include/linux/aio_abi.h) are present.  This is only the support, with
no consumers - a consumer is coming in the next patch.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: test/arch/um/include/aio.h
===================================================================
--- test.orig/arch/um/include/aio.h	2005-09-01 07:45:10.520901648 -0400
+++ test/arch/um/include/aio.h	2005-09-01 17:09:05.000000000 -0400
@@ -0,0 +1,28 @@
+/* 
+ * Copyright (C) 2004 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef AIO_H__
+#define AIO_H__
+
+enum aio_type { AIO_READ, AIO_WRITE, AIO_MMAP };
+
+struct aio_thread_reply {
+	void *data;
+	int err;
+};
+
+struct aio_context {
+	int reply_fd;
+	struct aio_context *next;
+};
+
+#define INIT_AIO_CONTEXT { .reply_fd	= -1, \
+			   .next	= NULL }
+
+extern int submit_aio(enum aio_type type, int fd, char *buf, int len, 
+		      unsigned long long offset, int reply_fd, 
+                      struct aio_context *aio);
+
+#endif
Index: test/arch/um/include/init.h
===================================================================
--- test.orig/arch/um/include/init.h	2005-06-17 15:48:29.000000000 -0400
+++ test/arch/um/include/init.h	2005-09-01 16:04:47.000000000 -0400
@@ -111,7 +111,15 @@
 
 #ifndef __KERNEL__
 
-#define __initcall(fn) static initcall_t __initcall_##fn __init_call = fn
+#define __define_initcall(level,fn) \
+	static initcall_t __initcall_##fn __attribute_used__ \
+	__attribute__((__section__(".initcall" level ".init"))) = fn
+
+/* Userspace initcalls shouldn't depend on anything in the kernel, so we'll
+ * make them run first.
+ */
+#define __initcall(fn) __define_initcall("1", fn)
+
 #define __exitcall(fn) static exitcall_t __exitcall_##fn __exit_call = fn
 
 #define __init_call __attribute__ ((unused,__section__ (".initcall.init")))
Index: test/arch/um/include/irq_kern.h
===================================================================
--- test.orig/arch/um/include/irq_kern.h	2005-06-17 15:48:29.000000000 -0400
+++ test/arch/um/include/irq_kern.h	2005-09-01 16:04:47.000000000 -0400
@@ -7,12 +7,15 @@
 #define __IRQ_KERN_H__
 
 #include "linux/interrupt.h"
+#include "asm/ptrace.h"
 
 extern int um_request_irq(unsigned int irq, int fd, int type,
 			  irqreturn_t (*handler)(int, void *,
 						 struct pt_regs *),
 			  unsigned long irqflags,  const char * devname,
 			  void *dev_id);
+extern int init_aio_irq(int irq, char *name, 
+			irqreturn_t (*handler)(int, void *, struct pt_regs *));
 
 #endif
 
Index: test/arch/um/kernel/irq.c
===================================================================
--- test.orig/arch/um/kernel/irq.c	2005-09-01 16:02:46.000000000 -0400
+++ test/arch/um/kernel/irq.c	2005-09-01 17:09:18.000000000 -0400
@@ -31,7 +31,7 @@
 #include "kern_util.h"
 #include "irq_user.h"
 #include "irq_kern.h"
-
+#include "os.h"
 
 /*
  * Generic, controller-independent functions:
@@ -168,13 +168,32 @@
 	}
 }
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
+int init_aio_irq(int irq, char *name, irqreturn_t (*handler)(int, void *, 
+							     struct pt_regs *))
+{
+	int fds[2], err;
+
+	err = os_pipe(fds, 1, 1);
+	if(err){
+		printk("init_aio_irq - os_pipe failed, err = %d\n", -err);
+		goto out;
+	}
+
+	err = um_request_irq(irq, fds[0], IRQ_READ, handler,
+			     SA_INTERRUPT | SA_SAMPLE_RANDOM, name, 
+			     (void *) (long) fds[0]);
+	if(err){
+		printk("init_aio_irq - : um_request_irq failed, err = %d\n",
+		       err);
+		goto out_close;
+	}
+
+	err = fds[1];
+	goto out;
+	
+ out_close:
+	os_close_file(fds[0]);
+	os_close_file(fds[1]);
+ out:
+	return(err);
+}
Index: test/arch/um/os-Linux/Makefile
===================================================================
--- test.orig/arch/um/os-Linux/Makefile	2005-06-17 15:48:29.000000000 -0400
+++ test/arch/um/os-Linux/Makefile	2005-09-01 17:09:05.000000000 -0400
@@ -3,11 +3,15 @@
 # Licensed under the GPL
 #
 
-obj-y = elf_aux.o file.o process.o signal.o time.o tty.o user_syms.o drivers/ \
-	sys-$(SUBARCH)/
+obj-y = aio.o elf_aux.o file.o process.o signal.o time.o tty.o user_syms.o \
+	drivers/ sys-$(SUBARCH)/
 
-USER_OBJS := elf_aux.o file.o process.o signal.o time.o tty.o
+USER_OBJS := aio.o elf_aux.o file.o process.o signal.o time.o tty.o
 
 CFLAGS_user_syms.o += -DSUBARCH_$(SUBARCH)
 
+HAVE_AIO_ABI := $(shell [ -r /usr/include/linux/aio_abi.h ] && \
+	echo -DHAVE_AIO_ABI )
+CFLAGS_aio.o += $(HAVE_AIO_ABI)
+
 include arch/um/scripts/Makefile.rules
Index: test/arch/um/os-Linux/aio.c
===================================================================
--- test.orig/arch/um/os-Linux/aio.c	2005-09-01 07:45:10.520901648 -0400
+++ test/arch/um/os-Linux/aio.c	2005-09-01 17:09:05.000000000 -0400
@@ -0,0 +1,398 @@
+/* 
+ * Copyright (C) 2004 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL
+ */
+
+#include <stdlib.h>
+#include <unistd.h>
+#include <signal.h>
+#include <errno.h>
+#include <sched.h>
+#include <sys/syscall.h>
+#include "os.h"
+#include "helper.h"
+#include "aio.h"
+#include "init.h"
+#include "user.h"
+#include "mode.h"
+
+struct aio_thread_req {
+        enum aio_type type;
+        int io_fd;
+        unsigned long long offset;
+        char *buf;
+        int len;
+        struct aio_context *aio;
+};
+
+static int aio_req_fd_r = -1;
+static int aio_req_fd_w = -1;
+
+#if defined(HAVE_AIO_ABI)
+#include <linux/aio_abi.h>
+
+/* If we have the headers, we are going to build with AIO enabled.
+ * If we don't have aio in libc, we define the necessary stubs here.
+ */
+
+#if !defined(HAVE_AIO_LIBC)
+
+static long io_setup(int n, aio_context_t *ctxp)
+{
+        return syscall(__NR_io_setup, n, ctxp);
+}
+
+static long io_submit(aio_context_t ctx, long nr, struct iocb **iocbpp)
+{
+        return syscall(__NR_io_submit, ctx, nr, iocbpp);
+}
+
+static long io_getevents(aio_context_t ctx_id, long min_nr, long nr,
+                         struct io_event *events, struct timespec *timeout)
+{
+        return syscall(__NR_io_getevents, ctx_id, min_nr, nr, events, timeout);
+}
+
+#endif
+
+/* The AIO_MMAP cases force the mmapped page into memory here
+ * rather than in whatever place first touches the data.  I used
+ * to do this by touching the page, but that's delicate because
+ * gcc is prone to optimizing that away.  So, what's done here
+ * is we read from the descriptor from which the page was 
+ * mapped.  The caller is required to pass an offset which is
+ * inside the page that was mapped.  Thus, when the read 
+ * returns, we know that the page is in the page cache, and
+ * that it now backs the mmapped area.
+ */
+
+static int do_aio(aio_context_t ctx, enum aio_type type, int fd, char *buf, 
+                  int len, unsigned long long offset, struct aio_context *aio)
+{
+        struct iocb iocb, *iocbp = &iocb;
+        char c;
+        int err;
+
+        iocb = ((struct iocb) { .aio_data 	= (unsigned long) aio,
+                                .aio_reqprio	= 0,
+                                .aio_fildes	= fd,
+                                .aio_buf	= (unsigned long) buf,
+                                .aio_nbytes	= len,
+                                .aio_offset	= offset,
+                                .aio_reserved1	= 0,
+                                .aio_reserved2	= 0,
+                                .aio_reserved3	= 0 });
+
+        switch(type){
+        case AIO_READ:
+                iocb.aio_lio_opcode = IOCB_CMD_PREAD;
+                err = io_submit(ctx, 1, &iocbp);
+                break;
+        case AIO_WRITE:
+                iocb.aio_lio_opcode = IOCB_CMD_PWRITE;
+                err = io_submit(ctx, 1, &iocbp);
+                break;
+        case AIO_MMAP:
+                iocb.aio_lio_opcode = IOCB_CMD_PREAD;
+                iocb.aio_buf = (unsigned long) &c;
+                iocb.aio_nbytes = sizeof(c);
+                err = io_submit(ctx, 1, &iocbp);
+                break;
+        default:
+                printk("Bogus op in do_aio - %d\n", type);
+                err = -EINVAL;
+                break;
+        }
+        if(err > 0)
+                err = 0;
+
+        return err;
+}
+
+static aio_context_t ctx = 0;
+
+static int aio_thread(void *arg)
+{
+        struct aio_thread_reply reply;
+        struct io_event event;
+        int err, n, reply_fd;
+
+        signal(SIGWINCH, SIG_IGN);
+
+        while(1){
+                n = io_getevents(ctx, 1, 1, &event, NULL);
+                if(n < 0){
+                        if(errno == EINTR)
+                                continue;
+                        printk("aio_thread - io_getevents failed, "
+                               "errno = %d\n", errno);
+                }
+                else {
+                        reply = ((struct aio_thread_reply) 
+                                { .data = (void *) (long) event.data,
+                                  .err	= event.res });
+                        reply_fd = ((struct aio_context *) reply.data)->reply_fd;
+                        err = os_write_file(reply_fd, &reply, sizeof(reply));
+                        if(err != sizeof(reply))
+                                printk("not_aio_thread - write failed, "
+                                       "fd = %d, err = %d\n", 
+                                       aio_req_fd_r, -err);
+                }
+        }
+        return 0;
+}
+
+#endif
+
+static int do_not_aio(struct aio_thread_req *req)
+{
+        char c;
+        int err;
+
+        switch(req->type){
+        case AIO_READ:
+                err = os_seek_file(req->io_fd, req->offset);
+                if(err)
+                        goto out;
+
+                err = os_read_file(req->io_fd, req->buf, req->len);
+                break;
+        case AIO_WRITE:
+                err = os_seek_file(req->io_fd, req->offset);
+                if(err)
+                        goto out;
+
+                err = os_write_file(req->io_fd, req->buf, req->len);
+                break;
+        case AIO_MMAP:
+                err = os_seek_file(req->io_fd, req->offset);
+                if(err)
+                        goto out;
+
+                err = os_read_file(req->io_fd, &c, sizeof(c));
+                break;
+        default:
+                printk("do_not_aio - bad request type : %d\n", req->type);
+                err = -EINVAL;
+                break;
+        }
+
+ out:
+        return err;
+}
+
+static int not_aio_thread(void *arg)
+{
+        struct aio_thread_req req;
+        struct aio_thread_reply reply;
+        int err;
+
+        signal(SIGWINCH, SIG_IGN);
+        while(1){
+                err = os_read_file(aio_req_fd_r, &req, sizeof(req));
+                if(err != sizeof(req)){
+                        if(err < 0)
+                                printk("not_aio_thread - read failed, "
+                                       "fd = %d, err = %d\n", aio_req_fd_r, 
+                                       -err);
+                        else {
+                                printk("not_aio_thread - short read, fd = %d, "
+                                       "length = %d\n", aio_req_fd_r, err);
+                        }
+                        continue;
+                }
+                err = do_not_aio(&req);
+                reply = ((struct aio_thread_reply) { .data 	= req.aio,
+                                                     .err	= err });
+                err = os_write_file(req.aio->reply_fd, &reply, sizeof(reply));
+                if(err != sizeof(reply))
+                        printk("not_aio_thread - write failed, fd = %d, "
+                               "err = %d\n", aio_req_fd_r, -err);
+        }
+}
+
+static int aio_pid = -1;
+
+static int init_aio_24(void)
+{
+        unsigned long stack;
+        int fds[2], err;
+
+        err = os_pipe(fds, 1, 1);
+        if(err)
+                goto out;
+
+        aio_req_fd_w = fds[0];
+        aio_req_fd_r = fds[1];
+        err = run_helper_thread(not_aio_thread, NULL, 
+                                CLONE_FILES | CLONE_VM | SIGCHLD, &stack, 0);
+        if(err < 0)
+                goto out_close_pipe;
+
+        aio_pid = err;
+        goto out;
+
+ out_close_pipe:
+        os_close_file(fds[0]);
+        os_close_file(fds[1]);
+        aio_req_fd_w = -1;
+        aio_req_fd_r = -1;	
+ out:
+#ifndef HAVE_AIO_ABI
+	printk("/usr/include/linux/aio_abi.h not present during build\n");
+#endif
+	printk("2.6 host AIO support not used - falling back to I/O "
+	       "thread\n");
+        return 0;
+}
+
+#ifdef HAVE_AIO_ABI
+#define DEFAULT_24_AIO 0
+static int init_aio_26(void)
+{
+        unsigned long stack;
+        int err;
+
+        if(io_setup(256, &ctx)){
+                printk("aio_thread failed to initialize context, err = %d\n",
+                       errno);
+                return -errno;
+        }
+
+        err = run_helper_thread(aio_thread, NULL, 
+                                CLONE_FILES | CLONE_VM | SIGCHLD, &stack, 0);
+        if(err < 0)
+                return -errno;
+
+        aio_pid = err;
+
+	printk("Using 2.6 host AIO\n");
+        return 0;
+}
+
+static int submit_aio_26(enum aio_type type, int io_fd, char *buf, int len, 
+			 unsigned long long offset, struct aio_context *aio)
+{
+        struct aio_thread_reply reply;
+        int err;
+
+        err = do_aio(ctx, type, io_fd, buf, len, offset, aio);
+        if(err){
+                reply = ((struct aio_thread_reply) { .data = aio,
+                                                     .err  = err });
+                err = os_write_file(aio->reply_fd, &reply, sizeof(reply));
+                if(err != sizeof(reply))
+                        printk("submit_aio_26 - write failed, "
+                               "fd = %d, err = %d\n", aio->reply_fd, -err);
+                else err = 0;
+        }
+
+        return err;
+}
+
+#else
+#define DEFAULT_24_AIO 1
+static int init_aio_26(void)
+{
+        return -ENOSYS;
+}
+
+static int submit_aio_26(enum aio_type type, int io_fd, char *buf, int len, 
+			 unsigned long long offset, struct aio_context *aio)
+{
+        return -ENOSYS;
+}
+#endif
+
+static int aio_24 = DEFAULT_24_AIO;
+
+static int __init set_aio_24(char *name, int *add)
+{
+        aio_24 = 1;
+        return 0;
+}
+
+__uml_setup("aio=2.4", set_aio_24,
+"aio=2.4\n"
+"    This is used to force UML to use 2.4-style AIO even when 2.6 AIO is\n"
+"    available.  2.4 AIO is a single thread that handles one request at a\n"
+"    time, synchronously.  2.6 AIO is a thread which uses the 2.6 AIO \n"
+"    interface to handle an arbitrary number of pending requests.  2.6 AIO \n"
+"    is not available in tt mode, on 2.4 hosts, or when UML is built with\n"
+"    /usr/include/linux/aio_abi.h not available.  Many distributions don't\n"
+"    include aio_abi.h, so you will need to copy it from a kernel tree to\n"
+"    your /usr/include/linux in order to build an AIO-capable UML\n\n"
+);
+
+static int init_aio(void)
+{
+        int err;
+
+        CHOOSE_MODE(({ 
+                if(!aio_24){ 
+                        printk("Disabling 2.6 AIO in tt mode\n");
+                        aio_24 = 1;
+                } }), (void) 0);
+
+        if(!aio_24){
+                err = init_aio_26();
+                if(err && (errno == ENOSYS)){
+                        printk("2.6 AIO not supported on the host - "
+                               "reverting to 2.4 AIO\n");
+                        aio_24 = 1;
+                }
+                else return err;
+        }
+
+        if(aio_24)
+                return init_aio_24();
+
+        return 0;
+}
+
+/* The reason for the __initcall/__uml_exitcall asymmetry is that init_aio
+ * needs to be called when the kernel is running because it calls run_helper,
+ * which needs get_free_page.  exit_aio is a __uml_exitcall because the generic
+ * kernel does not run __exitcalls on shutdown, and can't because many of them
+ * break when called outside of module unloading.
+ */
+__initcall(init_aio);
+
+static void exit_aio(void)
+{
+        if(aio_pid != -1)
+                os_kill_process(aio_pid, 1);
+}
+
+__uml_exitcall(exit_aio);
+
+static int submit_aio_24(enum aio_type type, int io_fd, char *buf, int len, 
+			 unsigned long long offset, struct aio_context *aio)
+{
+        struct aio_thread_req req = { .type 		= type,
+                                      .io_fd		= io_fd,
+                                      .offset		= offset,
+                                      .buf		= buf,
+                                      .len		= len,
+                                      .aio		= aio,
+        };
+        int err;
+
+        err = os_write_file(aio_req_fd_w, &req, sizeof(req));
+        if(err == sizeof(req))
+                err = 0;
+
+        return err;
+}
+
+int submit_aio(enum aio_type type, int io_fd, char *buf, int len, 
+               unsigned long long offset, int reply_fd, 
+               struct aio_context *aio)
+{
+        aio->reply_fd = reply_fd;
+        if(aio_24)
+                return submit_aio_24(type, io_fd, buf, len, offset, aio);
+        else {
+                return submit_aio_26(type, io_fd, buf, len, offset, aio);
+        }
+}

