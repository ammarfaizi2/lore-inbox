Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265020AbSKFM6s>; Wed, 6 Nov 2002 07:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265021AbSKFM6s>; Wed, 6 Nov 2002 07:58:48 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:49418 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S265020AbSKFM6q>; Wed, 6 Nov 2002 07:58:46 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15817.5010.452973.283613@laputa.namesys.com>
Date: Wed, 6 Nov 2002 16:05:22 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Jeff Dike <jdike@karaya.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: [PATCH]: make UML working with initramfs updates
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
Microsoft: Making the world a better place... for Microsoft.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Jeff, 

this patch syncs UML with recent initramfs updates, plus fixes
compilation warning, and missed sys_swap{on,off} in
arch/um/kernel/sys_call_table.c

I also changed __per_cpu_start to be aligned to 32 bits in
arch/um/uml.lds.S (like in i386).

Nikita.
===== arch/um/Makefile 1.14 vs edited =====
--- 1.14/arch/um/Makefile	Mon Oct 21 11:16:56 2002
+++ edited/arch/um/Makefile	Wed Nov  6 14:55:59 2002
@@ -66,6 +66,7 @@
 
 
 LDFLAGS_vmlinux = -r $(ARCH_DIR)/main.o
+LDFLAGS_BLOB	:= --format binary --oformat elf32-i386
 
 vmlinux: $(ARCH_DIR)/main.o 
 
===== arch/um/uml.lds.S 1.8 vs edited =====
--- 1.8/arch/um/uml.lds.S	Thu Oct 17 11:31:48 2002
+++ edited/arch/um/uml.lds.S	Wed Nov  6 15:26:52 2002
@@ -67,6 +67,7 @@
   __setup_start = .;
   .init.setup : { *(.init.setup) }
   __setup_end = .;
+  . = ALIGN(32);
   __per_cpu_start = . ; 
   .data.percpu : { *(.data.percpu) }
   __per_cpu_end = . ; 
@@ -84,6 +85,10 @@
   __uml_initcall_start = .;
   .uml.initcall.init : { *(.uml.initcall.init) }
   __uml_initcall_end = .;
+  . = ALIGN(4096);
+  __initramfs_start = .;
+  .init.ramfs : { *(.init.ramfs) }
+  __initramfs_end = .;
   __init_end = .;
   __exitcall_begin = .;
   .exitcall : { *(.exitcall.exit) }
===== arch/um/drivers/chan_kern.c 1.4 vs edited =====
--- 1.4/arch/um/drivers/chan_kern.c	Wed Oct  9 09:54:07 2002
+++ edited/arch/um/drivers/chan_kern.c	Wed Nov  6 15:11:43 2002
@@ -17,6 +17,14 @@
 #include "sigio.h"
 #include "line.h"
 
+#if defined(CONFIG_FD_CHAN) && defined(CONFIG_NULL_CHAN) && defined(CONFIG_PORT_CHAN) && defined(CONFIG_PTY_CHAN) && defined(CONFIG_TTY_CHAN) && defined(CONFIG_XTERM_CHAN)
+
+/* do not define not_configged_* here */
+
+#else
+
+/* something is not configured */
+
 static void *not_configged_init(char *str, int device, struct chan_opts *opts)
 {
 	printk(KERN_ERR "Using a channel type which is configured out of "
@@ -84,6 +92,7 @@
 	free:		not_configged_free,
 	winch:		0,
 };
+#endif
 
 static void tty_receive_char(struct tty_struct *tty, char ch)
 {
===== arch/um/kernel/sys_call_table.c 1.4 vs edited =====
--- 1.4/arch/um/kernel/sys_call_table.c	Thu Oct 17 11:29:34 2002
+++ edited/arch/um/kernel/sys_call_table.c	Wed Nov  6 15:01:42 2002
@@ -86,6 +86,8 @@
 extern syscall_handler_t sys_lstat;
 extern syscall_handler_t sys_readlink;
 extern syscall_handler_t sys_uselib;
+extern syscall_handler_t sys_swapon;
+extern syscall_handler_t sys_swapoff;
 extern syscall_handler_t sys_reboot;
 extern syscall_handler_t old_readdir;
 extern syscall_handler_t sys_munmap;
===== include/asm-um/unistd.h 1.2 vs edited =====
--- 1.2/include/asm-um/unistd.h	Sat Oct  5 00:54:32 2002
+++ edited/include/asm-um/unistd.h	Wed Nov  6 16:02:23 2002
@@ -23,7 +23,7 @@
 		       struct timeval *tvp);
 extern long sys_lseek(unsigned int fildes, unsigned long offset, int whence);
 extern long sys_read(unsigned int fildes, char *buf, int len);
-extern long sys_write(unsigned int fildes, char *buf, int len);
+extern long sys_write(int fildes, const char *buf, size_t len);
 
 #ifdef __KERNEL_SYSCALLS__
 
