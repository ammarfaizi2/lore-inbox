Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266639AbUBQWJj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 17:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266686AbUBQWJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:09:38 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:24735 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S266639AbUBQWCw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:02:52 -0500
Date: Tue, 17 Feb 2004 15:02:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][1/6] A different KGDB stub
Message-ID: <20040217220249.GB16881@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is the core bits to this KGDB stub.

 Makefile                 |    2 
 drivers/char/sysrq.c     |   22 
 include/linux/debugger.h |   72 ++
 include/linux/kgdb.h     |  127 ++++
 include/linux/sched.h    |   13 
 init/main.c              |    2 
 kernel/Kconfig.kgdb      |  141 +++++
 kernel/Makefile          |    1 
 kernel/kgdbstub.c        | 1300 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/module.c          |   10 
 kernel/sched.c           |   22 
 11 files changed, 1709 insertions(+), 3 deletions(-)
--- linux-2.6.3-rc4/Makefile	2004-02-17 09:53:13.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/Makefile	2004-02-17 11:34:07.454848329 -0700
@@ -440,6 +440,8 @@ endif
 
 ifndef CONFIG_FRAME_POINTER
 CFLAGS		+= -fomit-frame-pointer
+else
+CFLAGS		+= -fno-omit-frame-pointer
 endif
 
 ifdef CONFIG_DEBUG_INFO
--- linux-2.6.3-rc4/drivers/char/sysrq.c	2004-02-17 09:53:54.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/drivers/char/sysrq.c	2004-02-17 11:34:22.042537555 -0700
@@ -31,6 +31,7 @@
 #include <linux/suspend.h>
 #include <linux/writeback.h>
 #include <linux/buffer_head.h>		/* for fsync_bdev() */
+#include <linux/kgdb.h>			/* for breakpoint() */
 
 #include <linux/spinlock.h>
 
@@ -44,6 +45,25 @@ int sysrq_enabled = 1;
 /* Machine specific power off function */
 void (*sysrq_power_off)(void);
 
+/* Make a breakpoint() right now. */
+#ifdef CONFIG_KGDB
+#define  GDB_OP &kgdb_op
+static void kgdb_sysrq(int key, struct pt_regs *pt_regs, struct tty_struct *tty)
+{
+	printk("kgdb sysrq\n");
+	breakpoint();
+}
+
+static struct sysrq_key_op kgdb_op = {
+	.handler	= kgdb_sysrq,
+	.help_msg	= "kGdb|Fgdb",
+	.action_msg	= "Debug breakpoint\n",
+};
+
+#else
+#define  GDB_OP NULL
+#endif
+
 /* Loglevel sysrq handler */
 static void sysrq_handle_loglevel(int key, struct pt_regs *pt_regs,
 				  struct tty_struct *tty) 
@@ -239,7 +259,7 @@ static struct sysrq_key_op *sysrq_key_ta
 /* d */	NULL,
 /* e */	&sysrq_term_op,
 /* f */	NULL,
-/* g */	NULL,
+/* g */	GDB_OP,
 /* h */	NULL,
 /* i */	&sysrq_kill_op,
 /* j */	NULL,
--- linux-2.6.3-rc4/include/linux/debugger.h	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/include/linux/debugger.h	2004-02-17 11:34:22.828359208 -0700
@@ -0,0 +1,72 @@
+#ifndef _DEBUGGER_H_
+#define _DEBUGGER_H_
+
+/*
+ * Copyright (C) 2003-2004 Amit S. Kale
+ *
+ * Definition switchout for debuggers
+ */
+
+/*
+ * KGDB
+ */
+#ifdef CONFIG_KGDB
+
+typedef int gdb_debug_hook(int exVector, int signo, int err_code,
+                            struct pt_regs *regs);
+extern gdb_debug_hook  *linux_debug_hook;
+#define	CHK_DEBUGGER(trapnr,signr,error_code,regs,after)			\
+    {									\
+	if (linux_debug_hook != (gdb_debug_hook *) NULL && !user_mode(regs)) \
+	{								\
+		(*linux_debug_hook)(trapnr, signr, error_code, regs) ;	\
+		after;							\
+	}								\
+    }
+
+void kgdb_nmihook(int cpu, void *regs);
+static inline void debugger_nmihook(int cpu, void *regs)
+{
+	kgdb_nmihook(cpu, regs);
+}
+
+void kgdb_entry(void);
+static inline void debugger_entry(void)
+{
+	kgdb_entry();
+}
+
+extern int debugger_step;
+extern atomic_t debugger_active;
+extern volatile int debugger_memerr_expected;
+
+/*
+ * No debugger in the kernel
+ */
+#else
+
+#define	CHK_DEBUGGER(trapnr,signr,error_code,regs,after)	\
+{								\
+	if (0)							\
+		after;						\
+}
+
+
+static inline void debugger_nmihook(int cpu, void *regs)
+{
+	/* Do nothing */
+}
+
+static inline void debugger_entry(void)
+{
+	/* Do nothing */
+}
+
+#define debugger_step 0
+static const atomic_t debugger_active = { 0 };
+#define debugger_memerr_expected 0
+
+#endif
+
+
+#endif /* _DEBUGGER_H_ */
--- linux-2.6.3-rc4/include/linux/kgdb.h	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/include/linux/kgdb.h	2004-02-17 11:33:51.575452295 -0700
@@ -0,0 +1,127 @@
+#ifndef _KGDB_H_
+#define _KGDB_H_
+
+/*
+ * Copyright (C) 2001-2004 Amit S. Kale
+ */
+
+#include <linux/ptrace.h>
+#include <asm/kgdb.h>
+#include <linux/spinlock.h>
+#include <asm/atomic.h>
+#include <linux/debugger.h>
+
+/*
+ * This file should not include ANY others.  This makes it usable
+ * most anywhere without the fear of include order or inclusion.
+ * TODO: Make it so!
+ *
+ * This file may be included all the time.  It is only active if
+ * CONFIG_KGDB is defined, otherwise it stubs out all the macros
+ * and entry points.
+ */
+
+#if defined(CONFIG_KGDB) && !defined(__ASSEMBLY__)
+/* To enter the debugger explicitly. */
+extern void breakpoint(void);
+extern void kgdb_schedule_breakpoint(void);
+extern void kgdb_process_breakpoint(void);
+extern volatile int kgdb_connected;
+
+extern atomic_t kgdb_setting_breakpoint;
+extern atomic_t debugger_active;
+
+#ifndef KGDB_MAX_NO_CPUS
+#if CONFIG_NR_CPUS > 8
+#error KGDB can handle max 8 CPUs
+#endif
+#define KGDB_MAX_NO_CPUS 8
+#endif
+
+
+extern struct task_struct *kgdb_usethread, *kgdb_contthread;
+
+enum gdb_bptype
+{
+	bp_breakpoint = '0',
+	bp_hardware_breakpoint,
+	bp_write_watchpoint,
+	bp_read_watchpoint,
+	bp_access_watchpoint
+};
+
+enum gdb_bpstate
+{
+       bp_disabled,
+       bp_enabled
+};
+
+#ifndef BREAK_INSTR_SIZE
+#error BREAK_INSTR_SIZE  needed by kgdb
+#endif
+
+struct gdb_breakpoint
+{
+       unsigned long            bpt_addr;
+       unsigned char           saved_instr[BREAK_INSTR_SIZE];
+       enum gdb_bptype         type;
+       enum gdb_bpstate        state;
+};
+
+typedef struct gdb_breakpoint gdb_breakpoint_t;
+
+#ifndef MAX_BREAKPOINTS
+#define MAX_BREAKPOINTS        16
+#endif
+
+#define KGDB_HW_BREAKPOINT          1
+
+/* These are functions that the arch specific code can, and in some cases
+ * must, provide. */
+extern int kgdb_arch_init(void);
+extern void regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs);
+extern void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs,struct task_struct *p);
+extern void gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs);
+extern void kgdb_printexceptioninfo(int exceptionNo, int errorcode,
+		char *buffer);
+extern void kgdb_disable_hw_debug(struct pt_regs *regs);
+extern void kgdb_post_master_code(struct pt_regs *regs, int eVector,
+		int err_code);
+extern int kgdb_arch_handle_exception(int vector, int signo, int err_code,
+		char *InBuffer, char *outBuffer, struct pt_regs *regs);
+extern int kgdb_arch_set_break(unsigned long addr, int type);
+extern int kgdb_arch_remove_break(unsigned long addr, int type);
+extern void kgdb_correct_hw_break(void);
+extern void kgdb_shadowinfo(struct pt_regs *regs, char *buffer, unsigned threadid);
+extern struct task_struct *kgdb_get_shadow_thread(struct pt_regs *regs,
+		int threadid);
+extern struct pt_regs *kgdb_shadow_regs(struct pt_regs *regs, int threadid);
+
+struct kgdb_arch {
+	unsigned char gdb_bpt_instr[BREAK_INSTR_SIZE];
+	unsigned long flags;
+	unsigned shadowth;
+};			
+
+/* Thread reference */
+typedef unsigned char threadref[8];
+
+extern int kgdb_get_debug_char(void);
+extern void kgdb_put_debug_char(int ch);
+extern void kgdb_flush_debug_char(void);
+extern int kgdb_hook_io(void);
+
+extern struct kgdb_arch arch_kgdb_ops;
+extern int kgdb_initialized;
+
+struct uart_port;
+
+extern void kgdb8250_add_port(int i, struct uart_port *serial_req);
+
+int kgdb_hex2long(char **ptr, long *longValue);
+char *kgdb_mem2hex(char *mem, char *buf, int count, int can_fault);
+
+#else
+#define kgdb_process_breakpoint()	do {} while(0)
+#endif /* KGDB && !__ASSEMBLY__ */
+#endif /* _KGDB_H_ */
--- linux-2.6.3-rc4/include/linux/sched.h	2004-02-17 09:51:05.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/include/linux/sched.h	2004-02-17 11:33:49.531916096 -0700
@@ -173,7 +173,9 @@ extern unsigned long cache_decay_ticks;
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
-asmlinkage void schedule(void);
+asmlinkage void do_schedule(void);
+asmlinkage void kern_schedule(void);
+asmlinkage void kern_do_schedule(struct pt_regs);
 
 struct namespace;
 
@@ -907,6 +909,15 @@ static inline void set_task_cpu(struct t
 
 #endif /* CONFIG_SMP */
 
+static inline void schedule(void)
+{
+#ifdef CONFIG_KGDB_THREAD
+	kern_schedule();
+#else
+	do_schedule();
+#endif
+}
+
 #endif /* __KERNEL__ */
 
 #endif
--- linux-2.6.3-rc4/init/main.c	2004-02-17 09:51:19.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/init/main.c	2004-02-17 11:33:51.854388988 -0700
@@ -39,6 +39,7 @@
 #include <linux/writeback.h>
 #include <linux/cpu.h>
 #include <linux/efi.h>
+#include <linux/debugger.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -581,6 +582,7 @@ static int init(void * unused)
 
 	smp_init();
 	do_basic_setup();
+	debugger_entry();
 
 	prepare_namespace();
 
--- linux-2.6.3-rc4/kernel/Kconfig.kgdb	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/kernel/Kconfig.kgdb	2004-02-17 11:34:00.111514958 -0700
@@ -0,0 +1,141 @@
+config KGDB
+	bool "KGDB: kernel debugging with remote gdb"
+	depends on DEBUG_KERNEL
+	select DEBUG_INFO
+	select FRAME_POINTER
+	# XXX: Doesn't work w/o this right now
+	select KGDB_THREAD if PPC32
+	help
+	  If you say Y here, it will be possible to remotely debug the
+	  kernel using gdb. This enlarges your kernel image disk size by
+	  several megabytes and requires a machine with more than 128 MB
+	  RAM to avoid excessive linking time. 
+	  Documentation of kernel debugger available at
+	  http://kgdb.sourceforge.net
+	  This is only useful for kernel hackers. If unsure, say N.
+
+choice
+	prompt "Method for KGDB communication"
+	depends on KGDB
+	default PPC_SIMPLE_SERIAL if PPC32 && (8xx || 8260)
+	default KGDB_8250
+	help
+	  There are a number of different ways in which you can communicate
+	  with KGDB.  The oldest is using a serial driver.  A newer method
+	  is to use UDP packets and a special network driver.
+
+config KGDB_8250
+	bool "KGDB: On generic serial port (8250)"
+	help
+	  Uses generic serial port (8250) for kgdb. This is independent of the
+	  option 9250/16550 and compatible serial port.
+
+config KGDB_ETH
+	bool "KGDB: On ethernet"
+	select NETPOLL
+	select NETPOLL_TRAP
+	select NETPOLL_RX
+	help
+	  Uses ethernet interface for kgdb.
+
+config PPC_SIMPLE_SERIAL 
+	bool "KGDB: On any serial port"
+	depends on PPC32
+	help
+	  Use a very simple, and not necessarily feature complete serial
+	  driver.  This is the only serial option currently for MPC8xx or
+	  MPC82xx based ports that do not offer an 8250-style UART.
+
+endchoice
+
+config KGDB_SIMPLE_SERIAL
+	bool "Simple selection of KGDB serial port"
+	depends on KGDB_8250 || PPC_SIMPLE_SERIAL
+	help
+	  If you say Y here, you will only have to pick the baud rate
+	  and serial port (ttyS) that you wish to use for KGDB.  If you
+	  say N, you will have provide the I/O port and IRQ number.  Note
+	  that if your serial ports are iomapped, then you must say Y here.
+	  If in doubt, say Y.
+
+choice
+	depends on KGDB_8250 || PPC_SIMPLE_SERIAL
+    	prompt "Debug serial port BAUD"
+	default KGDB_115200BAUD
+	help
+	  Gdb and the kernel stub need to agree on the baud rate to be
+	  used.  Some systems (x86 family at this writing) allow this to
+	  be configured.
+
+config KGDB_9600BAUD
+	bool "9600"
+
+config KGDB_19200BAUD
+	bool "19200"
+
+config KGDB_38400BAUD
+	bool "38400"
+
+config KGDB_57600BAUD
+	bool "57600"
+
+config KGDB_115200BAUD
+	bool "115200"
+endchoice
+
+choice
+	prompt "Serial port for KGDB"
+	depends on KGDB_SIMPLE_SERIAL
+	default KGDB_TTYS0
+
+config KGDB_TTYS0
+	bool "ttyS0"
+
+config KGDB_TTYS1
+	bool "ttyS1"
+
+config KGDB_TTYS2
+	bool "ttyS2"
+
+config KGDB_TTYS3
+	bool "ttyS3"
+
+endchoice
+
+config KGDB_PORT
+	hex "hex I/O port address of the debug serial port"
+	depends on !KGDB_SIMPLE_SERIAL && (KGDB_8250 || PPC_SIMPLE_SERIAL)
+	default  3f8
+	help
+	  Some systems (x86 family at this writing) allow the port
+	  address to be configured.  The number entered is assumed to be
+	  hex, don't put 0x in front of it.  The standard address are:
+	  COM1 3f8 , irq 4 and COM2 2f8 irq 3.  Setserial /dev/ttySx
+	  will tell you what you have.  It is good to test the serial
+	  connection with a live system before trying to debug.
+
+config KGDB_IRQ
+	int "IRQ of the debug serial port"
+	depends on !KGDB_SIMPLE_SERIAL && (KGDB_8250 || PPC_SIMPLE_SERIAL)
+	default 4
+	help
+	  This is the irq for the debug port.  If everything is working
+	  correctly and the kernel has interrupts on a control C to the
+	  port should cause a break into the kernel debug stub.
+
+config KGDB_THREAD
+	bool "KGDB: Thread analysis"
+	depends on KGDB
+	help
+	  With thread analysis enabled, gdb can talk to kgdb stub to list
+	  threads and to get stack trace for a thread. This option also enables
+	  some code which helps gdb get exact status of thread. Thread analysis
+	  adds some overhead to schedule and down functions. You can disable
+	  this option if you do not want to compromise on speed.
+
+config KGDB_CONSOLE
+	bool "KGDB: Console messages through gdb"
+	depends on KGDB
+	help
+	  If you say Y here, console messages will appear through gdb.
+	  Other consoles such as tty or ttyS will continue to work as usual.
--- linux-2.6.3-rc4/kernel/Makefile	2004-02-17 09:51:25.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/kernel/Makefile	2004-02-17 11:33:52.879156407 -0700
@@ -19,6 +19,7 @@ obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_IKCONFIG_PROC) += configs.o
+obj-$(CONFIG_KGDB) += kgdbstub.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
--- linux-2.6.3-rc4/kernel/kgdbstub.c	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/kernel/kgdbstub.c	2004-02-17 11:34:00.171501343 -0700
@@ -0,0 +1,1300 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+/*
+ * Copyright (C) 2000-2001 VERITAS Software Corporation.
+ * Copyright (C) 2002-2004 Timesys Corporation
+ * Copyright (C) 2003-2004 Amit S. Kale
+ * Copyright (C) 2004 Pavel Machek <pavel@suse.cz>
+ *
+ * Restructured KGDB for 2.6 kernels.
+ * thread support, support for multiple processors,support for ia-32(x86) 
+ * hardware debugging, Console support, handling nmi watchdog
+ * - Amit S. Kale ( amitkale@emsyssoft.com )
+ *
+ * Several enhancements by George Anzinger <george@mvista.com>
+ * Generic KGDB Support
+ * Implemented by Anurekh Saxena (anurekh.saxena@timesys.com)
+ * 
+ * Contributor:     Lake Stevens Instrument Division
+ * Written by:      Glenn Engel
+ *  
+ * Modified for 386 by Jim Kingdon, Cygnus Support.
+ * Origianl kgdb, compatibility with 2.1.xx kernel by David Grothe <dave@gcom.com>
+ * Integrated into 2.2.5 kernel by Tigran Aivazian <tigran@sco.com>
+ */
+
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+#include <linux/mm.h>
+#include <asm/system.h>
+#include <asm/ptrace.h>		/* for linux pt_regs struct */
+#include <asm/uaccess.h>
+#include <linux/kgdb.h>
+#include <asm/atomic.h>
+#include <linux/notifier.h>
+#include <linux/module.h>
+#include <asm/cacheflush.h>
+#include <linux/netpoll.h>
+
+#ifdef CONFIG_KGDB_CONSOLE
+#include <linux/console.h>
+#endif
+ 
+#include <linux/init.h>
+
+/*
+ * The following are the stub functions for code which is arch specific
+ * and can be omitted on some arches
+ */
+
+/*
+ * This function will handle the initalization of any architecture specific
+ * hooks.
+ */
+int __attribute__ ((weak))
+kgdb_arch_init(void)
+{
+	return 0;
+}
+
+void __attribute__ ((weak))
+regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+}
+
+void __attribute__ ((weak))
+sleeping_thread_to_gdb_regs(unsigned long *gdb_regs,struct task_struct *p)
+{
+}
+
+void __attribute__ ((weak))
+gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+}
+
+void __attribute__ ((weak))
+kgdb_printexceptioninfo(int exceptionNo, int errorcode, char *buffer)
+{
+}
+
+void __attribute__ ((weak))
+kgdb_disable_hw_debug(struct pt_regs *regs)
+{
+}
+
+void __attribute__ ((weak))
+kgdb_post_master_code(struct pt_regs *regs, int eVector, int err_code)
+{
+}
+
+/*
+ * Handle any additional commands.  This must handle the 'c' and 's'
+ * command packets.
+ * Return -1 to loop over other commands, and 0 to exit from KGDB
+ */
+int __attribute__ ((weak))
+kgdb_arch_handle_exception(int vector, int signo, int err_code, char *InBuffer,
+		char *outBuffer, struct pt_regs *regs)
+{
+	return -1;	/* Do not exit from the handler. */
+}
+
+int __attribute__ ((weak))
+kgdb_arch_set_break(unsigned long addr, int type)
+{
+	return 0;
+}
+
+int __attribute__ ((weak))
+kgdb_arch_remove_break(unsigned long addr, int type)
+{
+	return 0;
+}
+
+void __attribute__ ((weak))
+kgdb_correct_hw_break(void)
+{
+}
+
+void __attribute__ ((weak))
+kgdb_shadowinfo(struct pt_regs *regs, char *buffer, unsigned threadid)
+{
+}
+
+struct task_struct __attribute__ ((weak))
+*kgdb_get_shadow_thread(struct pt_regs *regs, int threadid)
+{
+	return NULL;
+}
+
+struct pt_regs __attribute__ ((weak))
+*kgdb_shadow_regs(struct pt_regs *regs, int threadid)
+{
+	return NULL;
+}
+
+/*
+ * The following is a stub IO driver.  Not all IO drivers will find it
+ * necessary to provide all of these functions.
+ */
+/* Get the next character in the packet. */
+int __attribute__ ((weak))
+kgdb_get_debug_char(void)
+{
+	return 0;
+}
+
+/* Write, or at least buffer, a single debug character. */
+void __attribute__ ((weak))
+kgdb_put_debug_char(int ch)
+{
+	return;
+}
+
+/* Make sure any pending characters are out there. */
+void __attribute__ ((weak))
+kgdb_flush_io(void)
+{
+	return;
+}
+
+/* Do any setup that is required to run. */
+int __attribute__ ((weak))
+kgdb_hook_io(void)
+{
+	return 0;
+}
+
+struct kgdb_arch *kgdb_ops = &arch_kgdb_ops;
+gdb_breakpoint_t kgdb_break[MAX_BREAKPOINTS];
+extern int pid_max;
+
+int kgdb_initialized = 0;
+int kgdb_enter = 0;
+static const char hexchars[] = "0123456789abcdef";
+
+static int get_char(char *addr, unsigned char *data, int can_fault);
+static int set_char(char *addr, int data, int can_fault);
+
+spinlock_t slavecpulocks[KGDB_MAX_NO_CPUS];
+static volatile int procindebug[KGDB_MAX_NO_CPUS];
+atomic_t kgdb_setting_breakpoint;
+volatile int kgdb_connected;
+struct task_struct *kgdb_usethread, *kgdb_contthread;
+
+int debugger_step;
+atomic_t debugger_active;
+
+/* 
+ * Indicate to caller of kgdb_mem2hex or hex2mem that there has been an
+ * error.  
+ */
+volatile int kgdb_memerr = 0;
+volatile int debugger_memerr_expected = 0;
+
+/* This will point to kgdb_handle_exception by default.
+ * The architecture code can override this in its init function
+ */
+gdb_debug_hook *linux_debug_hook;
+
+
+static char remcomInBuffer[BUFMAX];
+static char remcomOutBuffer[BUFMAX];
+static short error;
+
+static int module_event(struct notifier_block * self, unsigned long val,
+		void * data);
+
+static struct notifier_block kgdb_module_load_nb = {
+	.notifier_call = module_event,
+};
+
+static int
+hex(char ch)
+{
+	if ((ch >= 'a') && (ch <= 'f'))
+		return (ch - 'a' + 10);
+	if ((ch >= '0') && (ch <= '9'))
+		return (ch - '0');
+	if ((ch >= 'A') && (ch <= 'F'))
+		return (ch - 'A' + 10);
+	return (-1);
+}
+
+
+/* scan for the sequence $<data>#<checksum>	*/
+static void
+getpacket(char *buffer)
+{
+	unsigned char checksum;
+	unsigned char xmitcsum;
+	int count;
+	char ch;
+
+	do {
+	/* wait around for the start character, ignore all other characters */
+		while ((ch = (kgdb_get_debug_char() & 0x7f)) != '$')
+			;	/* Spin */
+		kgdb_connected = 1;
+		checksum = 0;
+		xmitcsum = -1;
+
+		count = 0;
+
+		/* now, read until a # or end of buffer is found */
+		while (count < BUFMAX) {
+			ch = kgdb_get_debug_char() & 0x7f;
+			if (ch == '#')
+				break;
+			checksum = checksum + ch;
+			buffer[count] = ch;
+			count = count + 1;
+		}
+		buffer[count] = 0;
+
+		if (ch == '#') {
+			xmitcsum = hex(kgdb_get_debug_char() & 0x7f) << 4;
+			xmitcsum += hex(kgdb_get_debug_char() & 0x7f);
+
+			if (checksum != xmitcsum)
+				/* Retransmit. */
+				kgdb_put_debug_char('-');
+			else
+				/* ACK. */
+				kgdb_put_debug_char('+');
+
+			kgdb_flush_io();
+		}
+	} while (checksum != xmitcsum);
+}
+
+
+/*
+ * Send the packet in buffer.
+ * Check for gdb connection if asked for.
+ */
+static void
+putpacket(char *buffer)
+{
+	unsigned char checksum;
+	int count;
+	char ch;
+
+	/*  $<packet info>#<checksum>. */
+	do {
+		checksum = 0;
+		count = 0;
+
+		/* Write out the packet. */
+		kgdb_put_debug_char('$');
+		while ((ch = buffer[count])) {
+			kgdb_put_debug_char(ch);
+			checksum += ch;
+			count++;
+		}
+
+		kgdb_put_debug_char('#');
+		kgdb_put_debug_char(hexchars[checksum >> 4]);
+		kgdb_put_debug_char(hexchars[checksum % 16]);
+		kgdb_flush_io();
+	} while ((kgdb_get_debug_char() & 0x7f) != '+');
+}
+
+/*
+ * convert the memory pointed to by mem into hex, placing result in buf
+ * return a pointer to the last char put in buf (null)
+ * If MAY_FAULT is non-zero, then we should set kgdb_memerr in response to
+ * a fault; if zero treat a fault like any other fault in the stub.
+ */
+char *kgdb_mem2hex(char *mem, char *buf, int count, int can_fault)
+{
+	int i;
+	unsigned char ch;
+	
+	for (i = 0; i < count; i++) {
+
+		if (get_char(mem++, &ch, can_fault) < 0) 
+			break;
+		
+		*buf++ = hexchars[ch >> 4];
+		*buf++ = hexchars[ch % 16];
+	}
+	*buf = 0;
+	return (buf);
+}
+
+/* convert the hex array pointed to by buf into binary to be placed in mem */
+/* return a pointer to the character AFTER the last byte written */
+
+char *hex2mem(char *buf, char *mem, int count, int can_fault)
+{
+	int i;
+	unsigned char ch;
+	
+	for (i = 0; i < count; i++) {
+		ch = hex(*buf++) << 4;
+		ch = ch + hex(*buf++);
+		if (set_char(mem++, ch, can_fault) < 0) 
+			break;
+	}
+	return (mem);
+}
+
+/*
+ * While we find nice hex chars, build a longValue.
+ * Return number of chars processed.
+ */
+int kgdb_hex2long(char **ptr, long *longValue)
+{
+	int numChars = 0;
+	int hexValue;
+
+	*longValue = 0;
+
+	while (**ptr) {
+		hexValue = hex(**ptr);
+		if (hexValue >= 0) {
+			*longValue = (*longValue << 4) | hexValue;
+			numChars++;
+		} else
+			break;
+
+		(*ptr)++;
+	}
+
+	return (numChars);
+}
+
+static inline char *pack_hex_byte(char *pkt, int byte)
+{
+	*pkt++ = hexchars[(byte >> 4) & 0xf];
+	*pkt++ = hexchars[(byte & 0xf)];
+	return pkt;
+}
+
+#define BUF_THREAD_ID_SIZE 16
+
+static char *pack_threadid(char *pkt, threadref *id)
+{
+	char *limit;
+	unsigned char *altid;
+
+	altid = (unsigned char *) id;
+	limit = pkt + BUF_THREAD_ID_SIZE;
+	while (pkt < limit)
+		pkt = pack_hex_byte(pkt, *altid++);
+
+	return pkt;
+}
+
+void int_to_threadref(threadref *id, int value)
+{
+	unsigned char *scan;
+
+	scan = (unsigned char *) id;
+	{
+		int i = 4;
+		while (i--)
+			*scan++ = 0;
+	}
+	*scan++ = (value >> 24) & 0xff;
+	*scan++ = (value >> 16) & 0xff;
+	*scan++ = (value >> 8) & 0xff;
+	*scan++ = (value & 0xff);
+}
+
+static struct task_struct *getthread(struct pt_regs *regs,int tid)
+{
+	int i;
+	struct list_head *l;
+	struct task_struct *p;
+	struct pid *pid;
+
+	if (tid >= pid_max + num_online_cpus() + kgdb_ops->shadowth) {
+		return NULL;
+	}
+	if (tid >= pid_max + num_online_cpus()) {
+		return kgdb_get_shadow_thread(regs, tid - pid_max -
+				num_online_cpus());
+	}
+	if (tid >= pid_max) {
+		i = 0;
+		for_each_task_pid(0, PIDTYPE_PID, p, l, pid) {
+			if (tid == pid_max + i) {
+				return p;
+			}
+			i++;
+		}
+		return NULL;
+	}
+	if (!tid) {
+		return NULL;
+	}
+	return find_task_by_pid(tid);
+}
+
+#ifdef CONFIG_SMP
+void kgdb_wait(struct pt_regs *regs)
+{
+	unsigned long flags;
+	int processor;
+
+	local_irq_save(flags);
+	processor = smp_processor_id();
+	procindebug[processor] = 1;
+	current->thread.debuggerinfo = regs;
+
+	/* Wait till master processor goes completely into the debugger. FIXME: this looks racy */
+	while (!procindebug[atomic_read(&debugger_active) - 1]) {
+		int i = 10;	/* an arbitrary number */
+
+		while (--i)
+			asm volatile ("nop": : : "memory");
+		barrier();
+	}
+
+	/* Wait till master processor is done with debugging */
+	spin_lock(slavecpulocks + processor);
+
+	/* This has been taken from x86 kgdb implementation and
+	 * will be needed by architectures that have SMP support
+	 */
+	kgdb_correct_hw_break();
+
+	/* Signal the master processor that we are done */
+	procindebug[processor] = 0;
+	spin_unlock(slavecpulocks + processor);
+	local_irq_restore(flags);
+}
+#endif
+
+static void get_mem (char *addr, unsigned char *buf, int count)
+{
+	while (count) {
+		if(get_char(addr++, buf, 1) <  0) 
+			return;
+		buf++;
+		count--;
+	}
+}
+
+static void set_mem (char *addr,unsigned char *buf, int count)
+{
+	while (count) {
+		if (set_char(addr++,*buf++, 1) < 0) 
+			return;
+		count--;
+	}
+}
+
+static int set_break (unsigned long addr)
+{
+	int i, breakno = -1;
+
+	for (i = 0; i < MAX_BREAKPOINTS; i++) {
+		if ((kgdb_break[i].state == bp_enabled) &&
+		    (kgdb_break[i].bpt_addr == addr)) {
+			breakno = -1;
+			break;
+		}
+
+		if (kgdb_break[i].state == bp_disabled) {
+			if ((breakno == -1) || (kgdb_break[i].bpt_addr == addr))
+				breakno = i;
+		}
+	}
+	if (breakno == -1)
+		return -1;
+
+	get_mem((char *)addr, kgdb_break[breakno].saved_instr, BREAK_INSTR_SIZE);
+	if (kgdb_memerr)
+		return -1;
+
+	set_mem((char *)addr, kgdb_ops->gdb_bpt_instr, BREAK_INSTR_SIZE);
+	flush_cache_range (current->mm, addr, addr + BREAK_INSTR_SIZE);
+	flush_icache_range (addr, addr + BREAK_INSTR_SIZE);
+	if (kgdb_memerr)
+		return -1;
+
+	kgdb_break[breakno].state = bp_enabled;
+	kgdb_break[breakno].type = bp_breakpoint;
+	kgdb_break[breakno].bpt_addr = addr;
+	
+	return 0;
+}	
+
+static int remove_break (unsigned long addr)
+{
+	int i;
+
+	for (i=0; i < MAX_BREAKPOINTS; i++) {
+		if ((kgdb_break[i].state == bp_enabled) &&
+		   (kgdb_break[i].bpt_addr == addr)) {
+			set_mem((char *)addr, kgdb_break[i].saved_instr,
+			        BREAK_INSTR_SIZE);
+			flush_cache_range (current->mm, addr, addr + BREAK_INSTR_SIZE);
+			flush_icache_range (addr, addr + BREAK_INSTR_SIZE);
+			if (kgdb_memerr)
+				return -1;
+			kgdb_break[i].state = bp_disabled;
+			return 0;
+		}
+	}
+	return -1;
+}
+
+int remove_all_break(void)
+{
+	int i;
+	for (i=0; i < MAX_BREAKPOINTS; i++) {
+		if(kgdb_break[i].state == bp_enabled) {
+			unsigned long addr = kgdb_break[i].bpt_addr;
+			set_mem((char *)addr, kgdb_break[i].saved_instr,
+			       BREAK_INSTR_SIZE);
+			flush_cache_range (current->mm, addr, addr + BREAK_INSTR_SIZE);
+			flush_icache_range (addr, addr + BREAK_INSTR_SIZE);
+		}
+		kgdb_break[i].state = bp_disabled;
+	}
+	return 0;
+}
+		
+int get_char(char *addr, unsigned char *data, int can_fault)
+{
+	mm_segment_t fs;
+	int ret = 0;
+	
+	kgdb_memerr = 0;
+	
+	if (can_fault)
+		debugger_memerr_expected = 1;
+	wmb();
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+	
+	if (get_user(*data, addr) != 0) {
+		ret = -EFAULT;
+		kgdb_memerr = 1;
+	}
+	
+	debugger_memerr_expected = 0;	
+	set_fs(fs);
+	return ret;
+}
+
+int set_char(char *addr, int data, int can_fault)
+{
+	mm_segment_t fs;
+	int ret = 0;
+	
+	kgdb_memerr = 0;
+	
+	if (can_fault)
+		debugger_memerr_expected = 1;
+	wmb();
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+
+	if (put_user(data, addr) != 0) {
+		ret = -EFAULT;
+		kgdb_memerr = 1;
+	}
+	
+	debugger_memerr_expected = 0;
+	set_fs(fs);
+	return ret;
+}
+
+static inline int shadow_pid(int realpid)
+{
+	if (realpid) {
+		return realpid;
+	}
+	return pid_max + smp_processor_id();
+}
+
+/*
+ * This function does all command procesing for interfacing to gdb.
+ *
+ * Locking hierarchy:
+ *	interface locks, if any (begin_session)
+ *	kgdb lock (debugger_active)
+ *
+ */
+int kgdb_handle_exception(int exVector, int signo, int err_code, 
+                     struct pt_regs *linux_regs)
+{
+	unsigned long length, addr;
+	char *ptr;
+	unsigned long flags;
+	unsigned long gdb_regs[NUMREGBYTES / sizeof (unsigned long)];
+	int i;
+	long threadid;
+	threadref thref;
+	struct task_struct *thread = NULL;
+	unsigned procid;
+	int ret = 0;
+	static char tmpstr[256];
+	int numshadowth = num_online_cpus() + kgdb_ops->shadowth;
+	long kgdb_usethreadid = 0;
+
+	/* Panic on recursive debugger calls. */
+	if (atomic_read(&debugger_active) == smp_processor_id() + 1) {
+		return 0;
+	}
+
+	/* 
+	 * Interrupts will be restored by the 'trap return' code, except when
+	 * single stepping.
+	 */
+	local_irq_save(flags);
+	
+	/* Hold debugger_active */
+	procid = smp_processor_id();
+	while (cmpxchg(&atomic_read(&debugger_active), 0, (procid + 1)) != 0) {
+		int i = 25;	/* an arbitrary number */
+
+		while (--i)
+			asm volatile ("nop": : : "memory");
+	}
+	
+	debugger_step = 0;
+
+	current->thread.debuggerinfo = linux_regs;
+
+	kgdb_disable_hw_debug(linux_regs);
+
+	for (i = 0; i < num_online_cpus(); i++) {
+		spin_lock(&slavecpulocks[i]);
+	}
+
+	/* spin_lock code is good enough as a barrier so we don't
+	 * need one here */
+	procindebug[smp_processor_id()] = 1;
+
+	/* Clear the out buffer. */
+	memset(remcomOutBuffer, 0, sizeof(remcomOutBuffer));
+
+	/* Master processor is completely in the debugger */
+	kgdb_post_master_code(linux_regs, exVector, err_code);
+
+	/* If kgdb is connected, then an exception has occured, and
+	 * we need to pass something back to GDB. */
+	if (kgdb_connected) {
+		ptr = remcomOutBuffer;
+		*ptr++ = 'T';
+		*ptr++ = hexchars[(signo >> 4) % 16];
+		*ptr++ = hexchars[signo % 16];
+		*ptr++ = hexchars[(PC_REGNUM >> 4) % 16];
+		*ptr++ = hexchars[PC_REGNUM % 16];
+		*ptr++ = ':';
+		ptr = kgdb_mem2hex((char *)&linux_regs->PTRACE_PC, ptr, 4, 0);
+		*ptr++ = ';';
+		*ptr++ = hexchars[SP_REGNUM >> 4];
+		*ptr++ = hexchars[SP_REGNUM & 0xf];
+		*ptr++ = ':';
+		ptr = kgdb_mem2hex(((char *)linux_regs) + SP_REGNUM * 4, ptr,
+				4, 0);
+		*ptr++ = ';';
+		ptr += strlen(strcpy(ptr, "thread:"));
+		int_to_threadref(&thref, shadow_pid(current->pid));
+		ptr = pack_threadid(ptr, &thref);
+		*ptr++ = ';';
+
+		putpacket(remcomOutBuffer);
+	}
+
+	kgdb_usethread = current;
+	kgdb_usethreadid = shadow_pid(current->pid);
+
+	while (1) {
+		int bpt_type = 0;
+		error = 0;
+
+		/* Clear the out buffer. */
+		memset(remcomOutBuffer, 0, sizeof(remcomOutBuffer));
+
+		getpacket(remcomInBuffer);
+
+#if KGDB_DEBUG
+		bust_spinlocks(1);
+		printk("CPU%d pid%d GDB packet: %s\n", 
+		       smp_processor_id(), current->pid, remcomInBuffer);
+		bust_spinlocks(0);
+#endif
+		switch (remcomInBuffer[0]) {
+		case '?':
+			/* reply to host that an exception has occurred */
+			ptr = remcomOutBuffer;
+			*ptr++ = 'T';
+			*ptr++ = hexchars[(signo >> 4) % 16];
+			*ptr++ = hexchars[signo % 16];
+			*ptr++ = hexchars[(PC_REGNUM >> 4) % 16];
+			*ptr++ = hexchars[PC_REGNUM % 16];
+			*ptr++ = ':';
+			ptr = kgdb_mem2hex((char *)&linux_regs->PTRACE_PC, ptr,
+					4, 0);
+			*ptr++ = ';';
+			*ptr++ = hexchars[SP_REGNUM >> 4];
+			*ptr++ = hexchars[SP_REGNUM & 0xf];
+			*ptr++ = ':';
+			ptr = kgdb_mem2hex(((char *)linux_regs) + SP_REGNUM * 4,
+					ptr, 4, 0);
+			*ptr++ = ';';
+			ptr += strlen(strcpy(ptr, "thread:"));
+			int_to_threadref(&thref, shadow_pid(current->pid));
+			ptr = pack_threadid(ptr, &thref);
+			*ptr++ = ';';
+			break;
+		case 'g':	/* return the value of the CPU registers */
+			thread = kgdb_usethread;
+				
+			if (!thread)
+				thread = current;
+			
+			/* All threads that don't have debuggerinfo should be
+			   in __schedule() sleeping, since all other CPUs
+			   are in kgdb_wait, and thus have debuggerinfo. */
+			   
+			if (kgdb_usethreadid >= pid_max + num_online_cpus()) {
+				regs_to_gdb_regs(gdb_regs,
+					kgdb_shadow_regs(linux_regs,
+						kgdb_usethreadid - pid_max -
+						num_online_cpus()));
+			} else if (thread->thread.debuggerinfo) {
+				if (get_char(thread->thread.debuggerinfo,
+					(unsigned char *)gdb_regs, 1)) {
+					strcpy(remcomOutBuffer, "E10");
+					break;
+				}
+				regs_to_gdb_regs(gdb_regs,
+					(struct pt_regs *)
+					thread->thread.debuggerinfo);
+			} else {
+				/* Pull stuff saved during 
+				 * switch_to; nothing else is
+				 * accessible (or even particularly relevant).
+				 * This should be enough for a stack trace. */
+				sleeping_thread_to_gdb_regs(gdb_regs, thread);
+			}
+				
+			kgdb_mem2hex((char *) gdb_regs, remcomOutBuffer, NUMREGBYTES, 0);
+			break;
+
+		case 'G':	/* set the value of the CPU registers - return OK */
+			hex2mem(&remcomInBuffer[1], (char *) gdb_regs,
+				NUMREGBYTES, 0);
+				
+			if (kgdb_usethread && kgdb_usethread != current)
+				strcpy(remcomOutBuffer, "E00");
+			else {
+				gdb_regs_to_regs(gdb_regs,
+					(struct pt_regs *)
+					current->thread.debuggerinfo);
+				strcpy(remcomOutBuffer, "OK");
+			}
+
+			break;
+
+			/* mAA..AA,LLLL  Read LLLL bytes at address AA..AA */
+		case 'm':
+			/* TRY TO READ %x,%x.  IF SUCCEED, SET PTR = 0 */
+			ptr = &remcomInBuffer[1];
+			if (kgdb_hex2long(&ptr, &addr) && *ptr++ == ',' &&
+			    kgdb_hex2long(&ptr, &length)) {
+				ptr = 0;
+				kgdb_mem2hex((char *) addr, remcomOutBuffer, length, 1);
+				if (kgdb_memerr)
+					strcpy(remcomOutBuffer, "E03");
+					
+			}
+
+			if (ptr) 
+				strcpy(remcomOutBuffer, "E01");
+			break;
+
+		/* MAA..AA,LLLL: Write LLLL bytes at address AA.AA return OK */
+		case 'M':
+			/* TRY TO READ '%x,%x:'.  IF SUCCEED, SET PTR = 0 */
+			ptr = &remcomInBuffer[1];
+			if (kgdb_hex2long(&ptr, &addr) && *(ptr++) == ',' && 
+			    kgdb_hex2long(&ptr, &length) && *(ptr++) == ':') {
+				hex2mem(ptr, (char *)addr, length, 1);
+				if (kgdb_memerr)
+					strcpy(remcomOutBuffer, "E09");
+				else
+					strcpy(remcomOutBuffer, "OK");
+				ptr = 0;
+			}
+			if (ptr) {
+				strcpy(remcomOutBuffer, "E02");
+			}
+			break;
+		/* GDB has told us it is detaching.  So we'll remove all of
+		 * our breakpoints and get back to 'normal'. */
+		case 'D':
+			strcpy(remcomOutBuffer, "OK");
+			putpacket(remcomOutBuffer);
+			/* fall through. */
+		/* GDB is telling us to 'kill' the running process.  We'll
+		 * just stop debugging. */
+		case 'k':
+			remove_all_break();
+			kgdb_connected = 0;
+			goto kgdb_exit;
+		/* query */
+		case 'q':
+			switch (remcomInBuffer[1]) {
+			case 's':
+			case 'f':
+				if (memcmp(remcomInBuffer+2, "ThreadInfo",10))
+				{
+					strcpy(remcomOutBuffer, "E04");
+					break;
+				}
+				if (remcomInBuffer[1] == 'f') {
+					threadid = 1;
+				}
+				remcomOutBuffer[0] = 'm';
+				ptr = remcomOutBuffer + 1;
+				for (i = 0; i < 32 && threadid < pid_max + numshadowth;
+						threadid++) {
+					thread = getthread(linux_regs, threadid);
+					if (thread) {
+						int_to_threadref(&thref,
+								threadid);
+						pack_threadid(ptr, &thref);
+						ptr += 16;
+						*(ptr++) = ',';
+						i++;
+					}
+				}
+				break;
+
+			case 'C':
+				/* Current thread id */
+				strcpy(remcomOutBuffer, "QC");
+
+				threadid = shadow_pid(current->pid);
+				
+				int_to_threadref(&thref, threadid);
+				pack_threadid(remcomOutBuffer + 2, &thref);
+				break;
+
+			case 'E':
+				/* Print exception info */
+				kgdb_printexceptioninfo(exVector, err_code,
+						remcomOutBuffer);
+				break;
+			case 'T':
+				if (memcmp(remcomInBuffer+1, "ThreadExtraInfo,",16))
+				{
+					strcpy(remcomOutBuffer, "E05");
+					break;
+				}
+				threadid = 0;
+				ptr = remcomInBuffer+17;
+				kgdb_hex2long(&ptr, &threadid);
+				if (!getthread(linux_regs, threadid)) {
+					sprintf(tmpstr, "invalid pid %d",
+							(int) threadid);
+					kgdb_mem2hex(tmpstr, remcomOutBuffer,
+							strlen(tmpstr), 0);
+					break;
+				}
+				if (threadid < pid_max) {
+					kgdb_mem2hex(getthread(linux_regs, threadid)->comm,
+							remcomOutBuffer, 16, 0);
+				} else if (threadid >= pid_max +
+						num_online_cpus()) {
+					kgdb_shadowinfo(linux_regs,
+						remcomOutBuffer,
+						threadid - pid_max -
+						num_online_cpus());
+				} else {
+					sprintf(tmpstr, "Shadow task %d for pid 0",
+							(int)(threadid -
+							      pid_max));
+					kgdb_mem2hex(tmpstr, remcomOutBuffer,
+							strlen(tmpstr), 0);
+				}
+				break;
+			}
+			break;
+
+			/* task related */
+		case 'H':
+			switch (remcomInBuffer[1]) {
+			case 'g':
+				ptr = &remcomInBuffer[2];
+				kgdb_hex2long(&ptr, &threadid);
+				thread = getthread(linux_regs, threadid);
+				if (!thread && threadid > 0) {
+					remcomOutBuffer[0] = 'E';
+					break;
+				}
+				kgdb_usethread = thread;
+				kgdb_usethreadid = threadid;
+				strcpy(remcomOutBuffer, "OK");
+				break;
+
+			case 'c':
+				ptr = &remcomInBuffer[2];
+				kgdb_hex2long(&ptr, &threadid);
+				if (!threadid) {
+					kgdb_contthread = 0;
+				} else {
+					thread = getthread(linux_regs, threadid);
+					if (!thread && threadid > 0) {
+						remcomOutBuffer[0] = 'E';
+						break;
+					}
+					kgdb_contthread = thread;
+				}
+				strcpy(remcomOutBuffer, "OK");
+				break;
+			}
+			break;
+
+			/* Query thread status */
+		case 'T':
+			ptr = &remcomInBuffer[1];
+			kgdb_hex2long(&ptr, &threadid);
+			thread = getthread(linux_regs, threadid);
+			if (thread)
+				strcpy(remcomOutBuffer, "OK");
+			else
+				remcomOutBuffer[0] = 'E';
+			break;
+		case 'z':
+		case 'Z':
+			ptr = &remcomInBuffer[2];
+			if (*(ptr++) != ',') {
+				strcpy(remcomOutBuffer, "E07");
+				break;
+			}
+			kgdb_hex2long(&ptr, &addr);
+			
+			bpt_type = remcomInBuffer[1];
+			if (bpt_type != bp_breakpoint) {
+				if (bpt_type == bp_hardware_breakpoint && 
+				    !(kgdb_ops->flags & KGDB_HW_BREAKPOINT))
+					break;
+
+				/* if set_break is not defined, then
+				 * remove_break does not matter
+				 */
+				if(!(kgdb_ops->flags & KGDB_HW_BREAKPOINT))
+					break;
+			}
+			
+			if (remcomInBuffer[0] == 'Z') {
+				if (bpt_type == bp_breakpoint)
+					ret = set_break(addr);
+				else
+					ret = kgdb_arch_set_break(addr,
+							bpt_type);
+			}
+			else {
+				if (bpt_type == bp_breakpoint)
+					ret = remove_break(addr);
+				else
+					ret = kgdb_arch_remove_break(addr,
+							bpt_type);
+			}
+			
+			if (ret == 0)
+				strcpy(remcomOutBuffer, "OK");
+			else
+				strcpy(remcomOutBuffer, "E08");
+			
+			break;
+
+		default:
+			if (kgdb_arch_handle_exception(exVector, signo,
+						err_code, remcomInBuffer,
+						remcomOutBuffer,
+						linux_regs) >= 0)
+				/* Get out of here. */
+				goto kgdb_exit;
+		}		/* switch */
+#if KGDB_DEBUG
+		bust_spinlocks(1);
+		printk("Response to GDB: %s\n", remcomOutBuffer);
+		bust_spinlocks(0);
+#endif
+
+		/* reply to the request */
+		putpacket(remcomOutBuffer);
+	}
+
+kgdb_exit:
+	procindebug[smp_processor_id()] = 0;	
+	
+	for (i = 0; i < num_online_cpus(); i++) {
+		spin_unlock(&slavecpulocks[i]);
+	}
+	/* Wait till all the processors have quit
+	 * from the debugger 
+	 */
+	for (i = 0; i < num_online_cpus(); i++) { 
+		while (procindebug[i]) {
+			int j = 10; /* an arbitrary number */
+
+			while (--j) {
+				asm volatile ("nop" : : : "memory");
+			}
+			barrier();
+		}
+	}
+
+	/* Free debugger_active */
+	atomic_set(&debugger_active, 0);
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+/*
+ * GDB places a breakpoint at this function to know dynamically
+ * loaded objects. It's not defined static so that only one instance with this
+ * name exists in the kernel.
+ */
+
+int module_event(struct notifier_block * self, unsigned long val, void * data)
+{
+	return 0;
+}
+
+/* this function is used to set up exception handlers for tracing and
+   breakpoints */
+static void set_debug_traps(void)
+{
+	int i;
+	
+	for (i = 0; i < KGDB_MAX_NO_CPUS; i++) 
+		spin_lock_init(&slavecpulocks[i]);
+
+	/* Free debugger_active */
+	atomic_set(&debugger_active, 0);
+
+	for (i = 0; i < MAX_BREAKPOINTS; i++) 
+		kgdb_break[i].state = bp_disabled;
+
+	linux_debug_hook = kgdb_handle_exception;
+
+	/* We can't do much if this fails */
+	register_module_notifier(&kgdb_module_load_nb);
+
+#ifdef CONFIG_KGDB_ETH
+	/* Tell netpoll our client might need ARP */
+	netpoll_set_trap(1);
+#endif
+
+	kgdb_initialized = 1;
+
+	atomic_set(&kgdb_setting_breakpoint, 0);
+}
+
+/* This function will generate a breakpoint exception.  It is used at the
+   beginning of a program to sync up with a debugger and can be used
+   otherwise as a quick means to stop program execution and "break" into
+   the debugger. */
+
+void breakpoint(void)
+{
+	if (!kgdb_initialized)
+		set_debug_traps();
+
+	atomic_set(&kgdb_setting_breakpoint, 1);
+	wmb();
+	BREAKPOINT();
+	wmb();
+	atomic_set(&kgdb_setting_breakpoint, 0);
+}
+
+void kgdb_nmihook(int cpu, void *regs)
+{
+#ifdef CONFIG_SMP
+	if (!procindebug[cpu] && atomic_read(&debugger_active) != (cpu + 1)) {
+		kgdb_wait((struct pt_regs *)regs);
+	}
+#endif
+}
+
+void kgdb_entry(void)
+{
+	if (kgdb_initialized) {
+		/* KGDB was initialized */
+		return;
+	}
+	if (!kgdb_enter) {
+		return;
+	}
+
+	/* Let the arch do any initalization it needs to, including
+	 * pointing to a suitable early output device. */
+	kgdb_arch_init();
+
+	if (kgdb_hook_io()) {
+		/* KGDB interface isn't ready yet */
+		return;
+	}
+	
+	/*
+	 * Call GDB routine to setup the exception vectors for the debugger
+	 */
+	set_debug_traps();
+
+	/*
+	 * Call the breakpoint() routine in GDB to start the debugging
+	 * session
+	 */
+	printk(KERN_CRIT "Waiting for connection from remote gdb... ");
+	breakpoint() ;
+	printk("Connected.\n");
+}
+
+/*
+ * Sometimes we need to schedule a breakpoint because we can't break
+ * right where we are.
+ */
+static int kgdb_need_breakpoint[NR_CPUS];
+
+void kgdb_schedule_breakpoint(void)
+{
+	kgdb_need_breakpoint[smp_processor_id()] = 1;
+}
+
+void kgdb_process_breakpoint(void)
+{
+	/*
+	 * Handle a breakpoint queued from inside network driver code
+         * to avoid reentrancy issues
+	 */
+	if (kgdb_need_breakpoint[smp_processor_id()]) {
+		kgdb_need_breakpoint[smp_processor_id()] = 0;
+		breakpoint();
+	}
+}
+
+#ifdef CONFIG_KGDB_CONSOLE
+char kgdbconbuf[BUFMAX];
+
+void kgdb_console_write(struct console *co, const char *s, unsigned count)
+{
+	int i;
+	int wcount;
+	char *bufptr;
+	unsigned long flags;
+
+	if (!kgdb_connected) {
+		return;
+	}
+	local_irq_save(flags);
+
+	kgdbconbuf[0] = 'O';
+	bufptr = kgdbconbuf + 1;
+	while (count > 0) {
+		if ((count << 1) > (BUFMAX - 2)) {
+			wcount = (BUFMAX - 2) >> 1;
+		} else {
+			wcount = count;
+		}
+		count -= wcount;
+		for (i = 0; i < wcount; i++) {
+			bufptr = pack_hex_byte(bufptr, s[i]);
+		}
+		*bufptr = '\0';
+		s += wcount;
+
+		putpacket(kgdbconbuf);
+
+	}
+	local_irq_restore(flags);
+}
+
+/* Always fail so that kgdb console doesn't become the default console */
+static int __init kgdb_console_setup(struct console *co, char *options)
+{
+	return -1;
+}
+
+static struct console kgdbcons = {
+	.name = "kgdb",
+	.write = kgdb_console_write,
+	.setup = kgdb_console_setup,
+	.flags = CON_PRINTBUFFER | CON_ENABLED,
+	.index = -1,
+};
+
+static int __init kgdb_console_init(void)
+{
+	register_console(&kgdbcons);
+	return 0;
+}
+console_initcall(kgdb_console_init);
+#endif
+
+EXPORT_SYMBOL(breakpoint);
+#ifdef CONFIG_KGDB_THREAD
+EXPORT_SYMBOL(kern_schedule);
+#endif
+
+static int __init opt_kgdb_enter(char *str)
+{
+	kgdb_enter = 1;
+	return 1;
+}
+
+static int __init opt_gdb(char *str)
+{
+	kgdb_enter = 1;
+	return 1;
+}
+
+/*
+ * These options have been deprecated and are present only to maintain
+ * compatibility with kgdb for 2.4 and earlier kernels.
+ */
+#ifdef CONFIG_KGDB_8250
+extern int kgdb8250_baud;
+extern int kgdb8250_ttyS;
+static int __init opt_gdbttyS(char *str)
+{
+	kgdb8250_ttyS = simple_strtoul(str, NULL, 10);
+	return 1;
+}
+static int __init opt_gdbbaud(char *str)
+{
+	kgdb8250_baud = simple_strtoul(str, NULL, 10);
+	return 1;
+}
+#endif
+
+/*
+ *
+ * Sequence of following lines has to be maintained because gdb option is a
+ * prefix of the other two options
+ */
+
+#ifdef CONFIG_KGDB_8250
+__setup("gdbttyS=", opt_gdbttyS);
+__setup("gdbbaud=", opt_gdbbaud);
+#endif
+__setup("gdb", opt_gdb);
+__setup("kgdbwait", opt_kgdb_enter);
--- linux-2.6.3-rc4/kernel/module.c	2004-02-17 09:53:25.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/kernel/module.c	2004-02-17 11:34:09.018493448 -0700
@@ -727,6 +727,11 @@ sys_delete_module(const char __user *nam
 	mod->state = MODULE_STATE_GOING;
 	restart_refcounts();
 
+	down(&notify_mutex);
+	notifier_call_chain(&module_notify_list, MODULE_STATE_GOING,
+				mod);
+	up(&notify_mutex);
+
 	/* Never wait if forced. */
 	if (!forced && module_refcount(mod) != 0)
 		wait_for_zero_refcount(mod);
@@ -1758,7 +1763,12 @@ sys_init_module(void __user *umod,
 	if (ret < 0) {
 		/* Init routine failed: abort.  Try to protect us from
                    buggy refcounters. */
+
 		mod->state = MODULE_STATE_GOING;
+		down(&notify_mutex);
+		notifier_call_chain(&module_notify_list, MODULE_STATE_GOING,
+					mod);
+		up(&notify_mutex);
 		synchronize_kernel();
 		if (mod->unsafe)
 			printk(KERN_ERR "%s: module is now stuck!\n",
--- linux-2.6.3-rc4/kernel/sched.c	2004-02-17 09:53:44.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/kernel/sched.c	2004-02-17 11:34:11.756871953 -0700
@@ -37,6 +37,7 @@
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
 #include <linux/percpu.h>
+#include <linux/debugger.h>
 
 #ifdef CONFIG_NUMA
 #define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
@@ -1591,7 +1592,7 @@ void scheduling_functions_start_here(voi
 /*
  * schedule() is the main scheduler function.
  */
-asmlinkage void schedule(void)
+asmlinkage void do_schedule(void)
 {
 	long *switch_count;
 	task_t *prev, *next;
@@ -1763,6 +1764,23 @@ int default_wake_function(wait_queue_t *
 
 EXPORT_SYMBOL(default_wake_function);
 
+asmlinkage void user_schedule(void)
+{
+#ifdef CONFIG_KGDB_THREAD
+	current->thread.debuggerinfo = NULL;
+#endif
+	do_schedule();
+}
+
+#ifdef CONFIG_KGDB_THREAD
+asmlinkage void kern_do_schedule(struct pt_regs regs)
+{
+	current->thread.debuggerinfo = &regs;
+	do_schedule();
+	current->thread.debuggerinfo = NULL;
+}
+#endif
+
 /*
  * The core wakeup function.  Non-exclusive wakeups (nr_exclusive == 0) just
  * wake everything up.  If it's an exclusive wakeup (nr_exclusive == small +ve
@@ -2961,6 +2979,8 @@ void __might_sleep(char *file, int line)
 #if defined(in_atomic)
 	static unsigned long prev_jiffy;	/* ratelimiting */
 
+	if (atomic_read(&debugger_active))
+		return;
 	if ((in_atomic() || irqs_disabled()) && system_running) {
 		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
 			return;

-- 
Tom Rini
http://gate.crashing.org/~trini/
