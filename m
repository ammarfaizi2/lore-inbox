Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbUJ2Stv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbUJ2Stv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 14:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUJ2Stv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 14:49:51 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:38360 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S263480AbUJ2ScW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:32:22 -0400
Subject: [patch 1/8] A different KGDB stub for -mm
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
       kgdb-bugreport@lists.sourceforge.net, amitkale@linsyssoft.com,
       mithlesh@linsyssoft.com, ak@suse.de, ralf@linux-mips.org,
       davidm@hpl.hp.com
From: Tom Rini <trini@kernel.crashing.org>
Message-Id: <1.29102004.trini@kernel.crashing.org>
Date: Fri, 29 Oct 2004 11:32:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cc: <trini1@cox.net>, <tom.rini@gmail.com>
The following series of patches adds (or in some cases, replaces) KGDB
support for i386, ppc32, ia64, x86_64 and mips (both 32 and 64bit
tested).  This version of KGDB can be used either via serial or ethernet.

Some useful features, such as a descriptive 'info threads' are supported
by a series of GDB patches which Amit is working on getting merged
upstream.  These can be found in CVS on kgdb.sourceforge.net in the
gdb module and currently only work on i386.  I've sent these patches to
Andrew, who will put them up on kernel.org for easier access.

It is my hope that these patches can be merged into the -mm tree at
this point.

This version of KGDB has a common back-end with hooks for architectures to
what they need to and can't be generalized.  Similarly, there are hooks for
I/O so that it can be done by 8250 uart, ethernet via netpoll, or
board-specific UART (e.g. the one found on MIPS SiByte 1250-swarm boards).

kgdb can be told to wait for the system via kgdbwait, or you can just connect
to a running system.  Or if you have SysRq, 'g' will drop into KGDB.  8250 can
be configured at compile time or boot time.  kgdboe must be configured at
boot-time.

A whole lot of people have helped to get this working, and to avoid an Oscars
moment, I'd like to thank everyone and leave it at that. :)

---

 linux-2.6.10-rc1-trini/Documentation/DocBook/Makefile  |    2 
 linux-2.6.10-rc1-trini/Documentation/DocBook/kgdb.tmpl |  175 ++
 linux-2.6.10-rc1-trini/Makefile                        |    2 
 linux-2.6.10-rc1-trini/include/linux/debugger.h        |   59 
 linux-2.6.10-rc1-trini/include/linux/kgdb.h            |  212 ++
 linux-2.6.10-rc1-trini/kernel/Makefile                 |    1 
 linux-2.6.10-rc1-trini/kernel/kgdb.c                   | 1390 +++++++++++++++++
 linux-2.6.10-rc1-trini/kernel/pid.c                    |   11 
 linux-2.6.10-rc1-trini/kernel/sched.c                  |    7 
 linux-2.6.10-rc1-trini/lib/Kconfig.debug               |   14 
 10 files changed, 1871 insertions(+), 2 deletions(-)

diff -puN Documentation/DocBook/Makefile~core-lite Documentation/DocBook/Makefile
--- linux-2.6.10-rc1/Documentation/DocBook/Makefile~core-lite	2004-10-29 11:10:47.734122614 -0700
+++ linux-2.6.10-rc1-trini/Documentation/DocBook/Makefile	2004-10-29 11:10:47.751118625 -0700
@@ -11,7 +11,7 @@ DOCBOOKS := wanbook.sgml z8530book.sgml 
 	    mousedrivers.sgml deviceiobook.sgml procfs-guide.sgml \
 	    tulip-user.sgml writing_usb_driver.sgml scsidrivers.sgml \
 	    sis900.sgml kernel-api.sgml journal-api.sgml lsm.sgml usb.sgml \
-	    gadget.sgml libata.sgml mtdnand.sgml librs.sgml
+	    gadget.sgml libata.sgml mtdnand.sgml librs.sgml kgdb.sgml
 
 ###
 # The build process is as follows (targets):
diff -puN /dev/null Documentation/DocBook/kgdb.tmpl
--- /dev/null	2004-10-25 00:35:20.587727328 -0700
+++ linux-2.6.10-rc1-trini/Documentation/DocBook/kgdb.tmpl	2004-10-29 11:10:47.852094923 -0700
@@ -0,0 +1,175 @@
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[]>
+
+<book id="kgdbInternals">
+ <bookinfo>
+  <title>KGDB Internals</title>
+
+  <authorgroup>
+   <author>
+    <firstname>Tom</firstname>
+    <surname>Rini</surname>
+    <affiliation>
+     <address>
+      <email>trini@kernel.crashing.org</email>
+     </address>
+    </affiliation>
+   </author>
+  </authorgroup>
+
+  <authorgroup>
+   <author>
+    <firstname>Amit S.</firstname>
+    <surname>Kale</surname>
+    <affiliation>
+     <address>
+      <email>amitkale@emsyssoft.com</email>
+     </address>
+    </affiliation>
+   </author>
+  </authorgroup>
+
+  <copyright>
+   <year>2004</year>
+   <holder>MontaVista Software, Inc.</holder>
+  </copyright>
+  <copyright>
+   <year>2004</year>
+   <holder>Amit S. Kale</holder>
+  </copyright>
+
+  <legalnotice>
+   <para>
+   This file is licensed under the terms of the GNU General Public License
+   version 2. This program is licensed "as is" without any warranty of any
+   kind, whether express or implied.
+   </para>
+
+  </legalnotice>
+ </bookinfo>
+
+<toc></toc>
+  <chapter id="Introduction">
+    <title>Introduction</title>
+    <para>
+    kgdb is a source level debugger for linux kernel. It is used along
+    with gdb to debug a linux kernel. Kernel developers can debug a kernel
+    similar to application programs with the use of kgdb. It makes it
+    possible to place breakpoints in kernel code, step through the code
+    and observe variables.
+    </para>
+    <para>
+    Two machines are required for using kgdb. One of these machines is a
+    development machine and the other is a test machine. The machines are
+    typically connected through a serial line, a null-modem cable which connects
+    their serial ports.  It is also possible however, to use an ethernet connection
+    between the machines.  The kernel to be debugged runs on the test machine.
+    gdb runs on the development machine. The serial line or ethernet connection is
+    used by gdb to communicate to the kernel being debugged.
+    </para>
+  </chapter>
+  <chapter id="CompilingAKernel">
+    <title>Compiling a kernel</title>
+    <para>
+    To enable <symbol>CONFIG_KGDB</symbol>, look under the "Kernel debugging"
+    and then select "KGDB: kernel debugging with remote gdb".
+    </para>
+    <para>
+    The first choice for I/O is <symbol>CONFIG_KGDB_8250</symbol>.  This has
+    sub-options such as <symbol>CONFIG_KGDB_SIMPLE_SERIAL</symbol> which
+    toggles choosing the serial port by ttyS number or by specifying a port
+    and IRQ number.
+    </para>
+    <para>
+    The second choice on most systems for I/O is <symbol>CONFIG_KGDB_ETH</symbol>.
+    This requires that the machine to be debugged has an ethernet card which supports
+    the netpoll API, such as the cards supported by <symbol>CONFIG_E100</symbol>.  There
+    are no sub-options for this, but a kernel command line option is required.
+  </chapter>
+  <chapter id="BootingTheKernel">
+    <title>Booting the kernel</title>
+    <para>
+    The Kernel command line option <constant>kgdbwait</constant> makes kgdb wait for
+    gdb connection during booting of a kernel.  If the <symbol>CONFIG_KGDB_8250</symbol>
+    driver is used (or if applicable, another serial driver) this breakpoint will
+    happen very early on, before console output.  If you wish to change serial port
+    information and you have enabled both <symbol>CONFIG_KGDB_8250</symbol> and
+    <symbol>CONFIG_KGDB_SIMPLE_SERIAL</symbol> then you must pass the option
+    <constant>kgdb8250=portnumber,speed</constant> or on IA64
+    <constant>kgdb8250=portnumber,speed,irq,iomembase</constant> before
+    <constant>kgdbwait</constant>.  The values for portnumber are 0-3 and correspond
+    to ttyS0 to ttyS3 respectively.  The supported speeds are <constant>9600</constant>,
+    <constant>19200</constant>, <constant>38400</constant>, <constant>57600</constant>,
+    and <constant>115200</constant>.
+    </para>
+    <para>
+    To have KGDB stop the kernel and wait, with the compiled values for the serial
+    driver, pass in: <constant>kgdbwait</constant>.
+    </para>
+    <para>
+    To specify the values of the serial port at boot:
+    <constant>kgdb8250=0,115200</constant>.
+    On IA64 this could also be:
+    <constant>kgdb8250=1,115200,74,0xc0000000ff5e0000</constant>
+    And to have KGDB also stop the kernel and wait for GDB to connect, pass in
+    <constant>kgdbwait</constant> after this arguement.
+    </para>
+    <para>
+    To configure the <symbol>CONFIG_KGDB_ETH</symbol> driver, pass in
+    <constant>kgdboe=[src-port]@&lt;src-ip&gt;/[dev],[tgt-port]@&lt;tgt-ip&gt;/[tgt-macaddr]</constant>
+    where:
+    <itemizedlist>
+      <listitem><para>src-port (optional): source for UDP packets (defaults to <constant>6443</constant>)</para></listitem>
+      <listitem><para>src-ip: source IP to use (interface address)</para></listitem>
+      <listitem><para>dev (optional): network interface (<constant>eth0</constant>)</para></listitem>
+      <listitem><para>tgt-port (optional): port GDB will use (defaults to <constant>6442</constant>)</para></listitem>
+      <listitem><para>tgt-ip: IP address GDB will be connecting from</para></listitem>
+      <listitem><para>tgt-macaddr (optional): ethernet MAC address for logging agent (default is broadcast)</para></listitem>
+    </itemizedlist>
+    </para>
+  </chapter>
+  <chapter id="ConnectingGDB">
+  <title>Connecting gdb</title>
+    <para>
+    If you have used any of the methods to have KGDB stop and create
+    an initial breakpoint described in the previous chapter, kgdb prints
+    the message "Waiting for connection from remote gdb..." on the console
+    and waits for connection from gdb. At this point you connect gdb to kgdb.
+    </para>
+    <para>
+    Example (serial):
+    </para>
+    <programlisting>
+    % gdb ./vmlinux
+    (gdb) set remotebaud 115200
+    (gdb) target remote /dev/ttyS0
+    </programlisting>
+    <para>
+    Example (ethernet):
+    </para>
+    <programlisting>
+    % gdb ./vmlinux
+    (gdb) target remote udp:192.168.2.2:6443
+    </programlisting>
+    <para>
+    Once connected, you can debug a kernel the way you would debug an
+    application program.
+    </para>
+  </chapter>
+  <chapter id="CommonBackEndReq">
+    <title>The common backend (required)</title>
+      <para>
+      These are the functions of the common backend, found in kernel/kgdb.c
+      which must be supplied by the architecture-specific backend.
+      </para>
+!Iinclude/linux/kgdb.h
+  </chapter>
+  <chapter id="CommonBackEndOpt">
+    <title>The common backend (optional)</title>
+      <para>
+      These functions are part of the common backend, found in kernel/kgdb.c
+      and are optionally implemented.  Some functions (with _hw_ in the name)
+      end up being required on arches which use hardware breakpoints.
+      </para>
+!Ikernel/kgdb.c
+  </chapter>
+</book>
diff -puN Makefile~core-lite Makefile
--- linux-2.6.10-rc1/Makefile~core-lite	2004-10-29 11:10:47.737121910 -0700
+++ linux-2.6.10-rc1-trini/Makefile	2004-10-29 11:10:47.853094689 -0700
@@ -488,6 +488,8 @@ endif
 
 ifndef CONFIG_FRAME_POINTER
 CFLAGS		+= -fomit-frame-pointer
+else
+CFLAGS		+= -fno-omit-frame-pointer
 endif
 
 ifdef CONFIG_DEBUG_INFO
diff -puN /dev/null include/linux/debugger.h
--- /dev/null	2004-10-25 00:35:20.587727328 -0700
+++ linux-2.6.10-rc1-trini/include/linux/debugger.h	2004-10-29 11:10:47.854094454 -0700
@@ -0,0 +1,59 @@
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
+			   struct pt_regs *regs);
+extern gdb_debug_hook *linux_debug_hook;
+#define CHK_DEBUGGER(trapnr,signr,error_code,regs,after)			\
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
+extern int debugger_step;
+extern atomic_t debugger_active;
+
+/*
+ * No debugger in the kernel
+ */
+#else
+
+#define CHK_DEBUGGER(trapnr,signr,error_code,regs,after)	\
+{									\
+	if (0)								\
+		after;							\
+}
+
+static inline void debugger_nmihook(int cpu, void *regs)
+{
+	/* Do nothing */
+}
+
+#define debugger_step 0
+static const atomic_t debugger_active = { 0 };
+
+#define debugger_memerr_expected 0
+
+#endif
+
+#endif				/* _DEBUGGER_H_ */
diff -puN /dev/null include/linux/kgdb.h
--- /dev/null	2004-10-25 00:35:20.587727328 -0700
+++ linux-2.6.10-rc1-trini/include/linux/kgdb.h	2004-10-29 11:10:47.854094454 -0700
@@ -0,0 +1,212 @@
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
+extern int kgdb_connected;
+
+extern atomic_t kgdb_setting_breakpoint;
+
+extern struct task_struct *kgdb_usethread, *kgdb_contthread;
+
+enum kgdb_bptype {
+	bp_breakpoint = '0',
+	bp_hardware_breakpoint,
+	bp_write_watchpoint,
+	bp_read_watchpoint,
+	bp_access_watchpoint
+};
+
+enum kgdb_bpstate {
+	bp_disabled,
+	bp_enabled
+};
+
+struct kgdb_bkpt {
+	unsigned long bpt_addr;
+	unsigned char saved_instr[BREAK_INSTR_SIZE];
+	enum kgdb_bptype type;
+	enum kgdb_bpstate state;
+};
+
+#ifndef BREAK_INSTR_SIZE
+#error BREAK_INSTR_SIZE  needed by kgdb
+#endif
+
+#ifndef MAX_BREAKPOINTS
+#define MAX_BREAKPOINTS        16
+#endif
+
+#define KGDB_HW_BREAKPOINT          1
+
+/* Required functions. */
+/**
+ *	regs_to_gdb_regs - Convert ptrace regs to GDB regs
+ *	@gdb_regs: A pointer to hold the registers in the order GDB wants.
+ *	@regs: The &struct pt_regs of the current process.
+ *
+ *	Convert the pt_regs in @regs into the format for registers that
+ *	GDB expects, stored in @gdb_regs.
+ */
+extern void regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs);
+
+/**
+ *	sleeping_regs_to_gdb_regs - Convert ptrace regs to GDB regs
+ *	@gdb_regs: A pointer to hold the registers in the order GDB wants.
+ *	@p: The &struct task_struct of the desired process.
+ *
+ *	Convert the register values of the sleeping process in @p to
+ *	the format that GDB expects.
+ *	This function is called when kgdb does not have access to the
+ *	&struct pt_regs and therefore it should fill the gdb registers
+ *	@gdb_regs with what has	been saved in &struct thread_struct
+ *	thread field during switch_to.
+ */
+extern void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs,
+					struct task_struct *p);
+
+/**
+ *	gdb_regs_to_regs - Convert GDB regs to ptrace regs.
+ *	@gdb_regs: A pointer to hold the registers we've recieved from GDB.
+ *	@regs: A pointer to a &struct pt_regs to hold these values in.
+ *
+ *	Convert the GDB regs in @gdb_regs into the pt_regs, and store them
+ *	in @regs.
+ */
+extern void gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs);
+
+/**
+ *	kgdb_arch_handle_exception - Handle architecture specific GDB packets.
+ *	@vector: The error vector of the exception that happened.
+ *	@signo: The signal number of the exception that happened.
+ *	@err_code: The error code of the exception that happened.
+ *	@InBuffer: The buffer of the packet we have read.
+ *	@outBuffer: The buffer, of %BUFMAX to write a packet into.
+ *	@regs: The &struct pt_regs of the current process.
+ *
+ *	This function MUST handle the 'c' and 's' command packets,
+ *	as well packets to set / remove a hardware breakpoint, if used.
+ *	If there are additional packets which the hardware needs to handle,
+ *	they are handled here.  The code should return -1 if it wants to
+ *	process more packets, and a %0 or %1 if it wants to exit from the
+ *	kgdb hook.
+ */
+extern int kgdb_arch_handle_exception(int vector, int signo, int err_code,
+				      char *InBuffer, char *outBuffer,
+				      struct pt_regs *regs);
+
+/* Optional functions. */
+extern int kgdb_arch_init(void);
+extern void kgdb_disable_hw_debug(struct pt_regs *regs);
+extern void kgdb_post_master_code(struct pt_regs *regs, int eVector,
+				  int err_code);
+extern int kgdb_set_hw_break(unsigned long addr);
+extern int kgdb_remove_hw_break(unsigned long addr);
+extern void kgdb_remove_all_hw_break(void);
+extern void kgdb_correct_hw_break(void);
+extern void kgdb_shadowinfo(struct pt_regs *regs, char *buffer,
+			    unsigned threadid);
+extern struct task_struct *kgdb_get_shadow_thread(struct pt_regs *regs,
+						  int threadid);
+extern struct pt_regs *kgdb_shadow_regs(struct pt_regs *regs, int threadid);
+
+/**
+ * struct kgdb_arch - Desribe architecture specific values.
+ * @gdb_bpt_instr: The instruction to trigger a breakpoint.
+ * @flags: Flags for the breakpoint, currently just %KGDB_HW_BREAKPOINT.
+ * @shadowth: A value of %1 indicates we shadow information on processes.
+ * @set_breakpoint: Allow an architecture to specify how to set a software
+ * breakpoint.
+ * @remove_breakpoint: Allow an architecture to specify how to remove a
+ * software breakpoint.
+ * @set_hw_breakpoint: Allow an architecture to specify how to set a hardware
+ * breakpoint.
+ * @remove_hw_breakpoint: Allow an architecture to specify how to remove a
+ * hardware breakpoint.
+ *
+ * The @shadowth flag is an option to shadow information not retrievable by
+ * gdb otherwise.  This is deprecated in favor of a binutils which supports
+ * CFI macros.
+ */
+struct kgdb_arch {
+	unsigned char gdb_bpt_instr[BREAK_INSTR_SIZE];
+	unsigned long flags;
+	unsigned shadowth;
+	int (*set_breakpoint) (unsigned long, char *);
+	int (*remove_breakpoint)(unsigned long, char *);
+	int (*set_hw_breakpoint)(unsigned long, int, enum kgdb_bptype);
+	int (*remove_hw_breakpoint)(unsigned long, int, enum kgdb_bptype);
+};
+
+/* Thread reference */
+typedef unsigned char threadref[8];
+
+/**
+ * struct kgdb_io - Desribe the interface for an I/O driver to talk with KGDB.
+ * @read_char: Pointer to a function that will return one char.
+ * @write_char: Pointer to a function that will write one char.
+ * @flush: Pointer to a function that will flush any pending writes.
+ * @init: Pointer to a function that will initialize the device.
+ * @late_init: Pointer to a function that will do any setup that has
+ * other dependencies.
+ *
+ * The @init and @late_init function pointers allow for an I/O driver
+ * such as a serial driver to fully initialize the port with @init and
+ * be called very early, yet safely call request_irq() later in the boot
+ * sequence.
+ *
+ * @init is allowed to return a non-0 return value to indicate failure.
+ * If this is called early on, then KGDB will try again when it would call
+ * @late_init.  If it has failed later in boot as well, the user will be
+ * notified.
+ */
+struct kgdb_io {
+	int (*read_char) (void);
+	void (*write_char) (int);
+	void (*flush) (void);
+	int (*init) (void);
+	void (*late_init) (void);
+};
+
+extern struct kgdb_io kgdb_io_ops;
+extern struct kgdb_arch arch_kgdb_ops;
+extern int kgdb_initialized;
+
+struct uart_port;
+
+extern void kgdb8250_add_port(int i, struct uart_port *serial_req);
+extern int init_kgdboe(void);
+
+int kgdb_hex2long(char **ptr, long *longValue);
+char *kgdb_mem2hex(char *mem, char *buf, int count);
+char *kgdb_hex2mem(char *buf, char *mem, int count);
+int kgdb_get_mem(char *addr, unsigned char *buf, int count);
+int kgdb_set_mem(char *addr, unsigned char *buf, int count);
+
+#else
+#define kgdb_process_breakpoint()      do {} while(0)
+#endif /* KGDB && !__ASSEMBLY__ */
+#endif				/* _KGDB_H_ */
diff -puN kernel/Makefile~core-lite kernel/Makefile
--- linux-2.6.10-rc1/kernel/Makefile~core-lite	2004-10-29 11:10:47.740121206 -0700
+++ linux-2.6.10-rc1-trini/kernel/Makefile	2004-10-29 11:10:47.855094219 -0700
@@ -24,6 +24,7 @@ obj-$(CONFIG_STOP_MACHINE) += stop_machi
 obj-$(CONFIG_AUDIT) += audit.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
 obj-$(CONFIG_KPROBES) += kprobes.o
+obj-$(CONFIG_KGDB) += kgdb.o
 obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 
diff -puN /dev/null kernel/kgdb.c
--- /dev/null	2004-10-25 00:35:20.587727328 -0700
+++ linux-2.6.10-rc1-trini/kernel/kgdb.c	2004-10-29 11:10:56.536056614 -0700
@@ -0,0 +1,1390 @@
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
+ * Copyright (C) 2004 Tom Rini <trini@kernel.crashing.org>
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
+#include <linux/threads.h>
+#include <asm/system.h>
+#include <asm/ptrace.h>
+#include <asm/uaccess.h>
+#include <linux/kgdb.h>
+#include <asm/atomic.h>
+#include <linux/notifier.h>
+#include <linux/module.h>
+#include <asm/cacheflush.h>
+#include <linux/init.h>
+#include <linux/sysrq.h>
+
+extern int pid_max;
+extern int pidhash_init_done;
+
+#define BUF_THREAD_ID_SIZE 16
+
+/*
+ * kgdb_initialized with a value of 1 indicates that kgdb is setup and is
+ * all ready to serve breakpoints and other kernel exceptions.  A value of
+ * -1 indicates that we have tried to initialize early, and need to try
+ * again later.
+ */
+int kgdb_initialized = 0;
+/* Is a host GDB connected to us? */
+int kgdb_connected;
+
+/*
+ * Holds information about breakpoints in a kernel. These breakpoints are
+ * added and removed by gdb.
+ */
+struct kgdb_bkpt kgdb_break[MAX_BREAKPOINTS];
+
+struct kgdb_arch *kgdb_ops = &arch_kgdb_ops;
+
+static const char hexchars[] = "0123456789abcdef";
+
+static spinlock_t slavecpulocks[NR_CPUS];
+static volatile int procindebug[NR_CPUS];
+atomic_t kgdb_setting_breakpoint;
+struct task_struct *kgdb_usethread, *kgdb_contthread;
+
+int debugger_step;
+atomic_t debugger_active;
+
+/* This will point to kgdb_handle_exception by default.
+ * The architecture code can override this in its init function
+ */
+gdb_debug_hook *linux_debug_hook;
+
+/* Our I/O buffers. */
+static char remcom_in_buffer[BUFMAX];
+static char remcom_out_buffer[BUFMAX];
+/* Storage for the registers, in GDB format. */
+static unsigned long gdb_regs[NUMREGBYTES / sizeof(unsigned long)];
+
+struct debuggerinfo_struct{
+	void *debuggerinfo;
+	struct task_struct *task;
+} kgdb_info[NR_CPUS];
+
+/* to keep track of the CPU which is doing the single stepping*/
+atomic_t cpu_doing_single_step;
+
+/**
+ *	kgdb_arch_init - Perform any architecture specific initalization.
+ *
+ *	RETURN:
+ *	The return value is ignored.
+ *
+ *	This function will handle the initalization of any architecture
+ *	specific hooks.
+ */
+int __attribute__ ((weak))
+    kgdb_arch_init(void)
+{
+	return 0;
+}
+
+/**
+ *	kgdb_disable_hw_debug - Disable hardware debugging while we in kgdb.
+ *	@regs: Current &struct pt_regs.
+ *
+ *	This function will be called if the particular architecture must
+ *	disable hardware debugging while it is processing gdb packets or
+ *	handling exception.
+ */
+void __attribute__ ((weak))
+    kgdb_disable_hw_debug(struct pt_regs *regs)
+{
+}
+
+/**
+ *	kgdb_set_hw_break - Set a hardware breakpoint at @addr.
+ *	@addr: The address to set a hardware breakpoint at.
+ */
+int __attribute__ ((weak))
+    kgdb_set_hw_break(unsigned long addr)
+{
+	return 0;
+}
+
+/**
+ *	kgdb_remove_hw_break - Remove a hardware breakpoint at @addr.
+ *	@addr: The address to remove a hardware breakpoint from.
+ */
+int __attribute__ ((weak))
+    kgdb_remove_hw_break(unsigned long addr)
+{
+	return 0;
+}
+
+/**
+ *	kgdb_remove_all_hw_break - Clear all hardware breakpoints.
+ */
+void __attribute__ ((weak))
+     kgdb_remove_all_hw_break(void)
+{
+}
+
+/**
+ *	kgdb_correct_hw_break - Correct hardware breakpoints.
+ *
+ *	A hook to allow for changes to the hardware breakpoint, called
+ *	after a single step (s) or continue (c) packet, and once we're about
+ *	to let the kernel continue running.
+ *
+ *	This is used to set the hardware breakpoint registers for all the
+ *	slave cpus on an SMP configuration. This must be called after any
+ *	changes are made to the hardware breakpoints (such as by a single
+ *	step (s) or continue (c) packet. This is only required on
+ *	architectures that support SMP and every processor has its own set
+ *	of breakpoint registers.
+ */
+void __attribute__ ((weak))
+    kgdb_correct_hw_break(void)
+{
+}
+
+/**
+ *	kgdb_post_master_code - Save error vector/code numbers.
+ *	@regs: Original pt_regs.
+ *	@eVector: Original error vector.
+ *	@err_code: Original error code.
+ *
+ *	This is needed on architectures which support SMP and KGDB.
+ *	This function is called after all the slave cpus have been put
+ *	to a know spin state and the master CPU has control over KGDB.
+ */
+
+void __attribute__ ((weak))
+    kgdb_post_master_code(struct pt_regs *regs, int eVector, int err_code)
+{
+}
+
+/**
+ *	kgdb_shadowinfo - Get shadowed information on @threadid.
+ *	@regs: The &struct pt_regs of the current process.
+ *	@buffer: A buffer of %BUFMAX size.
+ *	@threadid: The thread id of the shadowed process to get information on.
+ */
+void __attribute__ ((weak))
+    kgdb_shadowinfo(struct pt_regs *regs, char *buffer, unsigned threadid)
+{
+}
+
+/**
+ *	kgdb_get_shadow_thread - Get the shadowed &task_struct of @threadid.
+ *	@regs: The &struct pt_regs of the current thread.
+ *	@threadid: The thread id of the shadowed process to get information on.
+ *
+ *	RETURN:
+ *	This returns a pointer to the &struct task_struct of the shadowed
+ *	thread, @threadid.
+ */
+struct task_struct __attribute__ ((weak))
+    * kgdb_get_shadow_thread(struct pt_regs *regs, int threadid)
+{
+	return NULL;
+}
+
+/**
+ *	kgdb_shadow_regs - Return the shadowed registers of @threadid.
+ *	@regs: The &struct pt_regs of the current thread.
+ *	@threadid: The thread id we want the &struct pt_regs for.
+ *
+ *	RETURN:
+ *	The a pointer to the &struct pt_regs of the shadowed thread @threadid.
+ */
+struct pt_regs __attribute__ ((weak))
+    * kgdb_shadow_regs(struct pt_regs *regs, int threadid)
+{
+	return NULL;
+}
+
+static int hex(char ch)
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
+/* scan for the sequence $<data>#<checksum>	*/
+static void get_packet(char *buffer)
+{
+	unsigned char checksum;
+	unsigned char xmitcsum;
+	int count;
+	char ch;
+
+	do {
+		/* wait around for the start character, ignore all other
+		 * characters */
+		while ((ch = (kgdb_io_ops.read_char())) != '$')
+			;	/* Spin. */
+		kgdb_connected = 1;
+		checksum = 0;
+		xmitcsum = -1;
+
+		count = 0;
+
+		/* now, read until a # or end of buffer is found */
+		while (count < (BUFMAX - 1)) {
+			ch = kgdb_io_ops.read_char();
+			if (ch == '#')
+				break;
+			checksum = checksum + ch;
+			buffer[count] = ch;
+			count = count + 1;
+		}
+		buffer[count] = 0;
+
+		if (ch == '#') {
+			xmitcsum = hex(kgdb_io_ops.read_char()) << 4;
+			xmitcsum += hex(kgdb_io_ops.read_char());
+
+			if (checksum != xmitcsum)
+				kgdb_io_ops.write_char('-');	/* failed checksum */
+			else
+				kgdb_io_ops.write_char('+');	/* successful transfer */
+			if (kgdb_io_ops.flush)
+				kgdb_io_ops.flush();
+		}
+	} while (checksum != xmitcsum);
+}
+
+/*
+ * Send the packet in buffer.
+ * Check for gdb connection if asked for.
+ */
+static void put_packet(char *buffer)
+{
+	unsigned char checksum;
+	int count;
+	char ch;
+
+	/*  $<packet info>#<checksum>. */
+	while (1) {
+		kgdb_io_ops.write_char('$');
+		checksum = 0;
+		count = 0;
+
+		while ((ch = buffer[count])) {
+			kgdb_io_ops.write_char(ch);
+			checksum += ch;
+			count++;
+		}
+
+		kgdb_io_ops.write_char('#');
+		kgdb_io_ops.write_char(hexchars[checksum >> 4]);
+		kgdb_io_ops.write_char(hexchars[checksum % 16]);
+		if (kgdb_io_ops.flush)
+			kgdb_io_ops.flush();
+
+		/* Now see what we get in reply. */
+		ch = kgdb_io_ops.read_char();
+
+		if (ch == 3)
+			ch = kgdb_io_ops.read_char();
+
+		/* If we get an ACK, we are done. */
+		if (ch == '+')
+			return;
+
+		/* If we get the start of another packet, this means
+		 * that GDB is attempting to reconnect.  We will NAK
+		 * the packet being sent, and stop trying to send this
+		 * packet. */
+		if (ch == '$') {
+			kgdb_io_ops.write_char('-');
+			if (kgdb_io_ops.flush)
+				kgdb_io_ops.flush();
+			return;
+		}
+	}
+}
+
+/*
+ * convert the memory pointed to by mem into hex, placing result in buf
+ * return a pointer to the last char put in buf (null). May return an error.
+ */
+char *kgdb_mem2hex(char *mem, char *buf, int count)
+{
+	int i;
+	unsigned char ch;
+
+	for (i = 0; i < count; i++) {
+		if ((unsigned long)mem < TASK_SIZE)
+			return ERR_PTR(-EINVAL);
+		ch = *mem++;
+		*buf++ = hexchars[ch >> 4];
+		*buf++ = hexchars[ch % 16];
+	}
+	*buf = 0;
+	return (buf);
+}
+
+/*
+ * Copy the binary array pointed to by buf into mem.  Fix $, #, and
+ * 0x7d escaped with 0x7d.  Return a pointer to the character after
+ * the last byte written.
+ */
+static char *kgdb_ebin2mem(char *buf, char *mem, int count)
+{
+	for (; count > 0; count--, buf++) {
+		if ((unsigned long)mem < TASK_SIZE)
+			return ERR_PTR(-EINVAL);
+		if (*buf == 0x7d)
+			*mem++ = *(++buf) ^ 0x20;
+		else
+			*mem++ = *buf;
+	}
+	return mem;
+}
+
+/*
+ * convert the hex array pointed to by buf into binary to be placed in mem
+ * return a pointer to the character AFTER the last byte written
+ * May return an error.
+ */
+char *kgdb_hex2mem(char *buf, char *mem, int count)
+{
+	int i;
+	unsigned char ch;
+
+	for (i = 0; i < count; i++) {
+		ch = hex(*buf++) << 4;
+		ch = ch + hex(*buf++);
+		if ((unsigned long)mem < TASK_SIZE)
+			return ERR_PTR(-EINVAL);
+		*mem++ = ch;
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
+/* Write memory due to an 'M' or 'X' packet. */
+static char *write_mem_msg(int binary)
+{
+	char *ptr = &remcom_in_buffer[1];
+	unsigned long addr, length;
+
+	if (kgdb_hex2long(&ptr, &addr) > 0 && *(ptr++) == ',' &&
+			kgdb_hex2long(&ptr, &length) > 0 && *(ptr++) == ':') {
+		if (binary)
+			ptr = kgdb_ebin2mem(ptr, (char *)addr, length);
+		else
+			ptr = kgdb_hex2mem(ptr, (char *)addr, length);
+		flush_icache_range(addr, addr + length + 1);
+		if (IS_ERR(ptr))
+			return ptr;
+		return NULL;
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
+static inline char *pack_hex_byte(char *pkt, int byte)
+{
+	*pkt++ = hexchars[(byte >> 4) & 0xf];
+	*pkt++ = hexchars[(byte & 0xf)];
+	return pkt;
+}
+
+static inline void error_packet(char *pkt, int error)
+{
+	error = -error;
+	pkt[0] = 'E';
+	pkt[1] = hexchars[(error / 10)];
+	pkt[2] = hexchars[(error % 10)];
+	pkt[3] = '\0';
+}
+
+static char *pack_threadid(char *pkt, threadref * id)
+{
+	char *limit;
+	unsigned char *altid;
+
+	altid = (unsigned char *)id;
+	limit = pkt + BUF_THREAD_ID_SIZE;
+	while (pkt < limit)
+		pkt = pack_hex_byte(pkt, *altid++);
+
+	return pkt;
+}
+
+void int_to_threadref(threadref * id, int value)
+{
+	unsigned char *scan;
+
+	scan = (unsigned char *)id;
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
+static struct task_struct *getthread(struct pt_regs *regs, int tid)
+{
+	int i;
+	struct task_struct *p;
+
+	if (!pidhash_init_done)
+		return current;
+
+	if (tid >= pid_max + num_online_cpus() + kgdb_ops->shadowth)
+		return NULL;
+
+	if (tid >= pid_max + num_online_cpus())
+		return kgdb_get_shadow_thread(regs, tid - pid_max -
+					      num_online_cpus());
+
+	if (tid >= pid_max) {
+		i = 0;
+		do_each_task_pid(0, PIDTYPE_PGID, p) {
+			if (tid == pid_max + i)
+				return p;
+			i++;
+		} while_each_task_pid(0, PIDTYPE_PGID, p);
+		return NULL;
+	}
+
+	if (!tid)
+		return NULL;
+
+	return find_task_by_pid(tid);
+}
+
+#ifdef CONFIG_SMP
+static void kgdb_wait(struct pt_regs *regs)
+{
+	unsigned long flags;
+	int processor;
+
+	local_irq_save(flags);
+	processor = smp_processor_id();
+	procindebug[processor] = 1;
+	kgdb_info[processor].debuggerinfo = regs;
+	kgdb_info[processor].task = current;
+
+	/* Wait till master processor goes completely into the debugger.
+	 * FIXME: this looks racy */
+	while (!procindebug[atomic_read(&debugger_active) - 1]) {
+		int i = 10;	/* an arbitrary number */
+
+		while (--i)
+			cpu_relax();
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
+	kgdb_info[processor].debuggerinfo = NULL;
+	kgdb_info[processor].task = NULL;
+
+	/* Signal the master processor that we are done */
+	procindebug[processor] = 0;
+	spin_unlock(slavecpulocks + processor);
+	local_irq_restore(flags);
+}
+#endif
+
+int kgdb_get_mem(char *addr, unsigned char *buf, int count)
+{
+	while (count) {
+		if ((unsigned long)addr < TASK_SIZE)
+			return -EINVAL;
+		*buf++ = *addr++;
+		count--;
+	}
+	return 0;
+}
+
+int kgdb_set_mem(char *addr, unsigned char *buf, int count)
+{
+	while (count) {
+		if ((unsigned long)addr < TASK_SIZE)
+			return -EINVAL;
+		*addr++ = *buf++;
+		count--;
+	}
+	return 0;
+}
+
+static int kgdb_set_sw_break(unsigned long addr)
+{
+	int i, breakno = -1;
+	int error;
+
+	for (i = 0; i < MAX_BREAKPOINTS; i++) {
+		if ((kgdb_break[i].state == bp_enabled) &&
+		    (kgdb_break[i].bpt_addr == addr)) {
+			return -EEXIST;
+		}
+
+		if (kgdb_break[i].state == bp_disabled) {
+			if ((breakno == -1) || (kgdb_break[i].bpt_addr == addr))
+				breakno = i;
+		}
+	}
+	if (breakno == -1)
+		return -E2BIG;
+
+	if (kgdb_ops->set_breakpoint) {
+		if ((error = kgdb_ops->set_breakpoint(addr, kgdb_break[breakno].saved_instr)) < 0)
+			return error;
+	} else {
+		if ((error = kgdb_get_mem((char *)addr, kgdb_break[breakno].saved_instr,
+					  BREAK_INSTR_SIZE)) < 0)
+			return error;
+
+		if ((error = kgdb_set_mem((char *)addr, kgdb_ops->gdb_bpt_instr,
+				     BREAK_INSTR_SIZE)) < 0)
+			return error;
+	}
+	if (current->mm && addr < TASK_SIZE)
+		flush_cache_range(current->mm->mmap_cache, addr, addr + BREAK_INSTR_SIZE);
+	else
+		flush_icache_range(addr, addr + BREAK_INSTR_SIZE);
+
+	kgdb_break[breakno].state = bp_enabled;
+	kgdb_break[breakno].type = bp_breakpoint;
+	kgdb_break[breakno].bpt_addr = addr;
+
+	return 0;
+}
+
+static int kgdb_remove_sw_break(unsigned long addr)
+{
+	int i;
+	int error;
+
+	for (i = 0; i < MAX_BREAKPOINTS; i++) {
+		if ((kgdb_break[i].state == bp_enabled) &&
+		    (kgdb_break[i].bpt_addr == addr)) {
+			if (kgdb_ops->remove_breakpoint) {
+				if ((error = kgdb_ops->remove_breakpoint(addr,
+					kgdb_break[i].saved_instr)) < 0)
+					return error;
+			} else if ((error =
+			     kgdb_set_mem((char *)addr,
+				     kgdb_break[i].saved_instr,
+				     BREAK_INSTR_SIZE)) < 0)
+				return error;
+			if (current->mm && addr < TASK_SIZE)
+				flush_cache_range(current->mm->mmap_cache, addr,
+					addr + BREAK_INSTR_SIZE);
+			else
+				flush_icache_range(addr,
+					addr + BREAK_INSTR_SIZE);
+			kgdb_break[i].state = bp_disabled;
+			return 0;
+		}
+	}
+	return -ENOENT;
+}
+
+int remove_all_break(void)
+{
+	int i;
+	int error;
+
+	/* Clear memory breakpoints. */
+	for (i = 0; i < MAX_BREAKPOINTS; i++) {
+		if (kgdb_break[i].state == bp_enabled) {
+			unsigned long addr = kgdb_break[i].bpt_addr;
+			if ((error =
+			     kgdb_set_mem((char *)addr,
+				     kgdb_break[i].saved_instr,
+				     BREAK_INSTR_SIZE)) < 0)
+				return error;
+			if (current->mm && addr < TASK_SIZE)
+				flush_cache_range(current->mm->mmap_cache, addr,
+					addr + BREAK_INSTR_SIZE);
+			else
+				flush_icache_range(addr,
+					addr + BREAK_INSTR_SIZE);
+		}
+		kgdb_break[i].state = bp_disabled;
+	}
+
+	/* Clear hardware breakpoints. */
+	kgdb_remove_all_hw_break();
+
+	return 0;
+}
+
+static inline int shadow_pid(int realpid)
+{
+	if (realpid) {
+		return realpid;
+	}
+	if(!pidhash_init_done)
+		return 0;
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
+			  struct pt_regs *linux_regs)
+{
+	unsigned long length, addr;
+	char *ptr;
+	unsigned long flags;
+	int i;
+	long threadid;
+	threadref thref;
+	struct task_struct *thread = NULL;
+	unsigned procid;
+	int numshadowth = num_online_cpus() + kgdb_ops->shadowth;
+	long kgdb_usethreadid = 0;
+	int error = 0;
+	struct pt_regs *shadowregs;
+	int processor = smp_processor_id();
+	void * local_debuggerinfo;
+
+	/* Panic on recursive debugger calls. */
+	if (atomic_read(&debugger_active) == smp_processor_id() + 1) {
+		return 0;
+	}
+
+acquirelock:
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
+			cpu_relax();
+	}
+        /*
+         * Don't enter if the last instance of the exception handler wanted to
+         * come into the debugger again.
+         */
+        if (atomic_read(&cpu_doing_single_step) != -1 &&
+                atomic_read(&cpu_doing_single_step) != procid) {
+                atomic_set(&debugger_active, 0);
+                goto acquirelock;
+        }
+
+	kgdb_info[processor].debuggerinfo  = linux_regs;
+	kgdb_info[processor].task = current;
+
+	kgdb_disable_hw_debug(linux_regs);
+
+	if(!debugger_step || !kgdb_contthread ){
+               for (i = 0; i < num_online_cpus(); i++) {
+                       spin_lock(&slavecpulocks[i]);
+               }
+	}
+
+	/* spin_lock code is good enough as a barrier so we don't
+	 * need one here */
+	procindebug[smp_processor_id()] = 1;
+
+	/* Clear the out buffer. */
+	memset(remcom_out_buffer, 0, sizeof(remcom_out_buffer));
+
+	/* Master processor is completely in the debugger */
+	kgdb_post_master_code(linux_regs, exVector, err_code);
+
+	debugger_step = 0;
+        kgdb_contthread = NULL;
+
+	if (kgdb_connected) {
+		/* reply to host that an exception has occurred */
+		ptr = remcom_out_buffer;
+		*ptr++ = 'T';
+		*ptr++ = hexchars[(signo >> 4) % 16];
+		*ptr++ = hexchars[signo % 16];
+		ptr += strlen(strcpy(ptr, "thread:"));
+		int_to_threadref(&thref, shadow_pid(current->pid));
+		ptr = pack_threadid(ptr, &thref);
+		*ptr++ = ';';
+
+		put_packet(remcom_out_buffer);
+	}
+
+	kgdb_usethread = kgdb_info[processor].task;
+	kgdb_usethreadid = shadow_pid(kgdb_info[processor].task->pid);
+
+	while (1) {
+		char *bpt_type;
+		error = 0;
+
+		/* Clear the out buffer. */
+		memset(remcom_out_buffer, 0, sizeof(remcom_out_buffer));
+
+		get_packet(remcom_in_buffer);
+
+		switch (remcom_in_buffer[0]) {
+		case '?':
+			/* We know that this packet is only sent
+			 * during initial connect.  So to be safe,
+			 * we clear out our breakpoints now incase
+			 * GDB is reconnecting. */
+			remove_all_break();
+			remcom_out_buffer[0] = 'S';
+			remcom_out_buffer[1] = hexchars[signo >> 4];
+			remcom_out_buffer[2] = hexchars[signo % 16];
+			break;
+
+		case 'g':	/* return the value of the CPU registers */
+			thread = kgdb_usethread;
+
+			if (!thread){
+				thread = kgdb_info[processor].task;
+				local_debuggerinfo = kgdb_info[processor].debuggerinfo;
+			}
+			else{
+				local_debuggerinfo = NULL;
+				for_each_online_cpu (i) {
+					/* Try to find the task on some other or
+					 * possibly this node if we do not find the
+					 * matching task then we try to approximate the
+					 * results
+					 */
+					if (thread == kgdb_info[i].task)
+						local_debuggerinfo =
+							kgdb_info[i].debuggerinfo;
+				}
+			}
+
+			/* All threads that don't have debuggerinfo should be
+			   in __schedule() sleeping, since all other CPUs
+			   are in kgdb_wait, and thus have debuggerinfo. */
+
+			if (kgdb_usethreadid >= pid_max + num_online_cpus()) {
+				shadowregs = kgdb_shadow_regs(linux_regs,
+							      kgdb_usethreadid -
+							      pid_max -
+							      num_online_cpus
+							      ());
+				if (!shadowregs) {
+					error_packet(remcom_out_buffer,
+						     -EINVAL);
+					break;
+				}
+				regs_to_gdb_regs(gdb_regs, shadowregs);
+			} else if (local_debuggerinfo)
+				regs_to_gdb_regs(gdb_regs, local_debuggerinfo);
+			else {
+				/* Pull stuff saved during
+				 * switch_to; nothing else is
+				 * accessible (or even particularly relevant).
+				 * This should be enough for a stack trace. */
+				sleeping_thread_to_gdb_regs(gdb_regs, thread);
+			}
+			kgdb_mem2hex((char *)gdb_regs, remcom_out_buffer,
+				     NUMREGBYTES);
+			break;
+
+		case 'G':	/* set the value of the CPU registers - return OK */
+			kgdb_hex2mem(&remcom_in_buffer[1], (char *)gdb_regs,
+				     NUMREGBYTES);
+
+			if (kgdb_usethread && kgdb_usethread != current)
+				error_packet(remcom_out_buffer, -EINVAL);
+			else {
+				gdb_regs_to_regs(gdb_regs, linux_regs);
+				strcpy(remcom_out_buffer, "OK");
+			}
+
+			break;
+
+			/* mAA..AA,LLLL  Read LLLL bytes at address AA..AA */
+		case 'm':
+			ptr = &remcom_in_buffer[1];
+			if (kgdb_hex2long(&ptr, &addr) > 0 && *ptr++ == ',' &&
+			    kgdb_hex2long(&ptr, &length) > 0) {
+				if (IS_ERR(ptr = kgdb_mem2hex((char *)addr,
+							      remcom_out_buffer,
+							      length)))
+					error_packet(remcom_out_buffer,
+						     PTR_ERR(ptr));
+			} else
+				error_packet(remcom_out_buffer, -EINVAL);
+			break;
+
+			/* MAA..AA,LLLL: Write LLLL bytes at address AA..AA */
+		case 'M':
+			if (IS_ERR(ptr = write_mem_msg(0)))
+				error_packet(remcom_out_buffer, PTR_ERR(ptr));
+			else
+				strcpy(remcom_out_buffer, "OK");
+			break;
+			/* XAA..AA,LLLL: Write LLLL bytes at address AA..AA */
+		case 'X':
+			if (IS_ERR(ptr = write_mem_msg(1)))
+				error_packet(remcom_out_buffer, PTR_ERR(ptr));
+			else
+				strcpy(remcom_out_buffer, "OK");
+			break;
+
+			/* kill or detach. KGDB should treat this like a
+			 * continue.
+			 */
+		case 'D':
+			if ((error = remove_all_break()) < 0) {
+				error_packet(remcom_out_buffer, error);
+			} else {
+				strcpy(remcom_out_buffer, "OK");
+				kgdb_connected = 0;
+			}
+			put_packet(remcom_out_buffer);
+			goto default_handle;
+
+		case 'k':
+			/* Don't care about error from remove_all_break */
+			remove_all_break();
+			kgdb_connected = 0;
+			goto default_handle;
+
+			/* query */
+		case 'q':
+			switch (remcom_in_buffer[1]) {
+			case 's':
+			case 'f':
+				if (memcmp
+				    (remcom_in_buffer + 2, "ThreadInfo", 10)) {
+					error_packet(remcom_out_buffer,
+						     -EINVAL);
+					break;
+				}
+				if (remcom_in_buffer[1] == 'f') {
+					threadid = 1;
+				}
+				remcom_out_buffer[0] = 'm';
+				ptr = remcom_out_buffer + 1;
+				for (i = 0; i < 32 && threadid < pid_max +
+				     numshadowth; threadid++) {
+					thread = getthread(linux_regs,
+							   threadid);
+					if (thread) {
+						int_to_threadref(&thref,
+								 threadid);
+						pack_threadid(ptr, &thref);
+						ptr += 16;
+						*(ptr++) = ',';
+						i++;
+					}
+				}
+				*(--ptr) = '\0';
+				break;
+
+			case 'C':
+				/* Current thread id */
+				strcpy(remcom_out_buffer, "QC");
+
+				threadid = shadow_pid(current->pid);
+
+				int_to_threadref(&thref, threadid);
+				pack_threadid(remcom_out_buffer + 2, &thref);
+				break;
+			case 'T':
+				if (memcmp(remcom_in_buffer + 1,
+					   "ThreadExtraInfo,", 16)) {
+					error_packet(remcom_out_buffer,
+						     -EINVAL);
+					break;
+				}
+				threadid = 0;
+				ptr = remcom_in_buffer + 17;
+				kgdb_hex2long(&ptr, &threadid);
+				if (!getthread(linux_regs, threadid)) {
+					error_packet(remcom_out_buffer,
+						     -EINVAL);
+					break;
+				}
+				if (threadid < pid_max) {
+					kgdb_mem2hex(getthread(linux_regs,
+							       threadid)->comm,
+						     remcom_out_buffer, 16);
+				} else if (threadid >= pid_max +
+					   num_online_cpus()) {
+					kgdb_shadowinfo(linux_regs,
+							remcom_out_buffer,
+							threadid - pid_max -
+							num_online_cpus());
+				} else {
+					static char tmpstr[23 + BUF_THREAD_ID_SIZE];
+					sprintf(tmpstr, "Shadow task %d"
+						" for pid 0",
+						(int)(threadid - pid_max));
+					kgdb_mem2hex(tmpstr, remcom_out_buffer,
+						     strlen(tmpstr));
+				}
+				break;
+			}
+			break;
+
+			/* task related */
+		case 'H':
+			switch (remcom_in_buffer[1]) {
+			case 'g':
+				ptr = &remcom_in_buffer[2];
+				kgdb_hex2long(&ptr, &threadid);
+				thread = getthread(linux_regs, threadid);
+				if (!thread && threadid > 0) {
+					error_packet(remcom_out_buffer,
+						     -EINVAL);
+					break;
+				}
+				kgdb_usethread = thread;
+				kgdb_usethreadid = threadid;
+				strcpy(remcom_out_buffer, "OK");
+				break;
+
+			case 'c':
+				ptr = &remcom_in_buffer[2];
+				kgdb_hex2long(&ptr, &threadid);
+				if (!threadid) {
+					kgdb_contthread = NULL;
+				} else {
+					thread =
+					    getthread(linux_regs, threadid);
+					if (!thread && threadid > 0) {
+						error_packet(remcom_out_buffer,
+							     -EINVAL);
+						break;
+					}
+					kgdb_contthread = thread;
+				}
+				strcpy(remcom_out_buffer, "OK");
+				break;
+			}
+			break;
+
+			/* Query thread status */
+		case 'T':
+			ptr = &remcom_in_buffer[1];
+			kgdb_hex2long(&ptr, &threadid);
+			thread = getthread(linux_regs, threadid);
+			if (thread)
+				strcpy(remcom_out_buffer, "OK");
+			else
+				error_packet(remcom_out_buffer, -EINVAL);
+			break;
+		/* Since GDB-5.3, it's been drafted that '0' is a software
+		 * breakpoint, '1' is a hardware breakpoint, so let's do
+		 * that.
+		 */
+		case 'z':
+		case 'Z':
+			bpt_type = &remcom_in_buffer[1];
+			ptr = &remcom_in_buffer[2];
+
+
+			if (kgdb_ops->set_hw_breakpoint && *bpt_type >= '1') {
+				/* Unsupported */
+				if (*bpt_type > '4')
+					break;
+			}
+			else if (*bpt_type != '0' && *bpt_type != '1')
+				/* Unsupported. */
+				break;
+			/* Test if this is a hardware breakpoint, and
+			 * if we support it. */
+			if ((*bpt_type == '1' ||
+				(*bpt_type >= '1' && kgdb_ops->set_hw_breakpoint)) &&
+				!(kgdb_ops->flags & KGDB_HW_BREAKPOINT))
+				/* Unsupported. */
+				break;
+
+			if (*(ptr++) != ',') {
+				error_packet(remcom_out_buffer, -EINVAL);
+				break;
+			}
+			else if (kgdb_hex2long(&ptr, &addr)) {
+				if (*(ptr++) != ',' || !kgdb_hex2long(&ptr, &length)) {
+					error_packet(remcom_out_buffer, -EINVAL);
+					break;
+				}
+			}
+			else {
+				error_packet(remcom_out_buffer, -EINVAL);
+				break;
+			}
+
+			if (remcom_in_buffer[0] == 'Z' && *bpt_type == '0')
+				error = kgdb_set_sw_break(addr);
+			else if (remcom_in_buffer[0] == 'Z' && *bpt_type == '1')
+				error = kgdb_set_hw_break(addr);
+			else if (remcom_in_buffer[0] == 'z' && *bpt_type == '0')
+				error = kgdb_remove_sw_break(addr);
+			else if (remcom_in_buffer[0] == 'z' && *bpt_type == '1')
+				error = kgdb_remove_hw_break(addr);
+			else if (remcom_in_buffer[0] == 'Z')
+				error = kgdb_ops->set_hw_breakpoint(addr,
+					(int) length, *bpt_type);
+			else if (remcom_in_buffer[0] == 'z')
+				error = kgdb_ops->remove_hw_breakpoint(addr,
+					(int) length, *bpt_type);
+
+			if (error == 0)
+				strcpy(remcom_out_buffer, "OK");
+			else
+				error_packet(remcom_out_buffer, error);
+
+			break;
+
+                case 'c':
+                case 's':
+                        if (kgdb_contthread && kgdb_contthread != current) {
+                                /* Can't switch threads in kgdb */
+                                error_packet(remcom_out_buffer, -EINVAL);
+                                break;
+                        }
+
+                        /* Followthrough to default processing */
+
+		default:
+		      default_handle:
+			error = kgdb_arch_handle_exception(exVector, signo,
+							   err_code,
+							   remcom_in_buffer,
+							   remcom_out_buffer,
+							   linux_regs);
+
+			if (error >= 0 || remcom_in_buffer[0] == 'D' ||
+			    remcom_in_buffer[0] == 'k')
+				goto kgdb_exit;
+
+		}		/* switch */
+
+		/* reply to the request */
+		put_packet(remcom_out_buffer);
+	}
+
+      kgdb_exit:
+	kgdb_info[processor].debuggerinfo = NULL;
+	kgdb_info[processor].task = NULL;
+	procindebug[smp_processor_id()] = 0;
+
+	if(!debugger_step || !kgdb_contthread){
+               for (i = 0; i < num_online_cpus(); i++) {
+                       spin_unlock(&slavecpulocks[i]);
+               }
+               /* Wait till all the processors have quit
+                * from the debugger
+               */
+               for_each_online_cpu (i) {
+                       while (procindebug[i]) {
+                               int j = 10;     /* an arbitrary number */
+
+                               while (--j)
+                                       cpu_relax();
+                               barrier();
+                       }
+                }
+        }
+
+	/* Free debugger_active */
+	atomic_set(&debugger_active, 0);
+	local_irq_restore(flags);
+
+	return error;
+}
+
+/*
+ * GDB places a breakpoint at this function to know dynamically
+ * loaded objects. It's not defined static so that only one instance with this
+ * name exists in the kernel.
+ */
+
+int module_event(struct notifier_block *self, unsigned long val, void *data)
+{
+	return 0;
+}
+
+static struct notifier_block kgdb_module_load_nb = {
+	.notifier_call = module_event,
+};
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
+	 * to avoid reentrancy issues
+	 */
+	if (kgdb_need_breakpoint[smp_processor_id()]) {
+		kgdb_need_breakpoint[smp_processor_id()] = 0;
+		breakpoint();
+	}
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
+/*
+ * Initialization that needs to be done in either of our entry points.
+ */
+static void __init kgdb_internal_init(void)
+{
+	int i;
+
+	/* Initialize our spinlocks. */
+	for (i = 0; i < NR_CPUS; i++)
+		spin_lock_init(&slavecpulocks[i]);
+
+	for (i = 0; i < MAX_BREAKPOINTS; i++)
+		kgdb_break[i].state = bp_disabled;
+
+	linux_debug_hook = kgdb_handle_exception;
+
+	/* We can't do much if this fails */
+	register_module_notifier(&kgdb_module_load_nb);
+
+	/* Clear things. */
+	atomic_set(&debugger_active, 0);
+	atomic_set(&kgdb_setting_breakpoint, 0);
+	memset(kgdb_need_breakpoint, 0, sizeof(kgdb_need_breakpoint));
+
+	kgdb_initialized = 1;
+}
+
+/*
+ * This function can be called very early, either via early_param() or
+ * an explicit breakpoint() early on.
+ */
+static void __init kgdb_early_entry(void)
+{
+	int ret;
+
+	/*
+	 * Don't try and do anything until the architecture is able to
+	 * setup the exception tables, if needed.  If they aren't ready
+	 * yet, we'll do a special case and call kgdb_schedule_breakpoint()
+	 * as at that point, this test must be true.
+	 */
+	if(!CHECK_EXCEPTION_STACK()) {
+		kgdb_schedule_breakpoint();
+		return;
+	}
+
+	/* Let the architecture do any setup that it needs to. */
+	kgdb_arch_init();
+
+        atomic_set(&cpu_doing_single_step,-1);
+
+	/* Now try the I/O. */
+	ret = kgdb_io_ops.init();
+	printk("Got back %d\n", ret);
+	if (ret) {
+		/* Try again later. */
+		kgdb_initialized = -1;
+		printk("Going away\n");
+		return;
+	}
+
+	/* Finish up. */
+	kgdb_internal_init();
+}
+
+/*
+ * This function will always be invoked to make sure that KGDB will grab
+ * what it needs to so that if something happens while the system is
+ * running, KGDB will get involved.  If kgdb_early_entry() has already
+ * been invoked, there is little we need to do.
+ */
+static int __init kgdb_late_entry(void)
+{
+	int need_break = 0;
+
+	/* If kgdb_initialized is -1 then we were passed kgdbwait. */
+	if (kgdb_initialized == -1)
+		need_break = 1;
+
+	/*
+	 * If we haven't tried to initialize KGDB yet, we need to call
+	 * kgdb_arch_init before moving onto the I/O.
+	 */
+	if (!kgdb_initialized)
+		kgdb_arch_init();
+
+	if (kgdb_initialized != 1) {
+		if (kgdb_io_ops.init()) {
+			printk(KERN_ERR "Could not setup I/O for KGDB.\n");
+			return -1;
+		}
+		kgdb_internal_init();
+	}
+
+	/* Now do any late init of the I/O. */
+	if (kgdb_io_ops.late_init)
+		kgdb_io_ops.late_init();
+
+	if (need_break) {
+		printk(KERN_CRIT "Waiting for connection from remote gdb...\n");
+		breakpoint();
+	}
+
+	return 0;
+}
+late_initcall(kgdb_late_entry);
+
+/*
+ * This function will generate a breakpoint exception.  It is used at the
+ * beginning of a program to sync up with a debugger and can be used
+ * otherwise as a quick means to stop program execution and "break" into
+ * the debugger.
+ */
+void breakpoint(void)
+{
+	if (kgdb_initialized != 1) {
+		kgdb_early_entry();
+		if (kgdb_initialized == 1)
+			printk(KERN_CRIT "Waiting for connection from remote "
+					"gdb...\n");
+		else {
+			printk(KERN_CRIT "KGDB cannot initialize I/O yet.\n");
+			return;
+		}
+	}
+
+	atomic_set(&kgdb_setting_breakpoint, 1);
+	wmb();
+	BREAKPOINT();
+	wmb();
+	atomic_set(&kgdb_setting_breakpoint, 0);
+}
+EXPORT_SYMBOL(breakpoint);
+
+#ifdef CONFIG_MAGIC_SYSRQ
+static void sysrq_handle_gdb(int key, struct pt_regs *pt_regs,
+			     struct tty_struct *tty)
+{
+	printk("Entering GDB stub\n");
+	breakpoint();
+}
+static struct sysrq_key_op sysrq_gdb_op = {
+        .handler        = sysrq_handle_gdb,
+        .help_msg       = "Gdb",
+        .action_msg     = "GDB",
+};
+
+static int gdb_register_sysrq(void)
+{
+	printk("Registering GDB sysrq handler\n");
+	register_sysrq_key('g', &sysrq_gdb_op);
+	return 0;
+}
+module_init(gdb_register_sysrq);
+#endif
+
+static int __init opt_kgdb_enter(char *str)
+{
+	/* We've already done this by an explicit breakpoint() call. */
+	if (kgdb_initialized)
+		return 0;
+
+	/* Call breakpoint() which will take care of init. */
+	breakpoint();
+
+	return 0;
+}
+early_param("kgdbwait", opt_kgdb_enter);
diff -puN kernel/pid.c~core-lite kernel/pid.c
--- linux-2.6.10-rc1/kernel/pid.c~core-lite	2004-10-29 11:10:47.742120737 -0700
+++ linux-2.6.10-rc1-trini/kernel/pid.c	2004-10-29 11:10:47.857093750 -0700
@@ -250,8 +250,13 @@ void switch_exec_pids(task_t *leader, ta
 /*
  * The pid hash table is scaled according to the amount of memory in the
  * machine.  From a minimum of 16 slots up to 4096 slots at one gigabyte or
- * more.
+ * more.  KGDB needs to know if this function has been called already,
+ * since we might have entered KGDB very early.
  */
+#ifdef CONFIG_KGDB
+int pidhash_init_done;
+#endif
+
 void __init pidhash_init(void)
 {
 	int i, j, pidhash_size;
@@ -273,6 +278,10 @@ void __init pidhash_init(void)
 		for (j = 0; j < pidhash_size; j++)
 			INIT_HLIST_HEAD(&pid_hash[i][j]);
 	}
+
+#ifdef CONFIG_KGDB
+	pidhash_init_done = 1;
+#endif
 }
 
 void __init pidmap_init(void)
diff -puN kernel/sched.c~core-lite kernel/sched.c
--- linux-2.6.10-rc1/kernel/sched.c~core-lite	2004-10-29 11:10:47.745120033 -0700
+++ linux-2.6.10-rc1-trini/kernel/sched.c	2004-10-29 11:10:47.861092811 -0700
@@ -44,6 +44,7 @@
 #include <linux/seq_file.h>
 #include <linux/syscalls.h>
 #include <linux/times.h>
+#include <linux/debugger.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
@@ -4567,6 +4568,12 @@ void __might_sleep(char *file, int line)
 #if defined(in_atomic)
 	static unsigned long prev_jiffy;	/* ratelimiting */
 
+	if (atomic_read(&debugger_active))
+		return;
+
+	if (atomic_read(&debugger_active))
+		return;
+
 	if ((in_atomic() || irqs_disabled()) &&
 	    system_state == SYSTEM_RUNNING) {
 		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
diff -puN lib/Kconfig.debug~core-lite lib/Kconfig.debug
--- linux-2.6.10-rc1/lib/Kconfig.debug~core-lite	2004-10-29 11:10:47.747119563 -0700
+++ linux-2.6.10-rc1-trini/lib/Kconfig.debug	2004-10-29 11:11:06.512714888 -0700
@@ -82,6 +82,7 @@ config DEBUG_BUGVERBOSE
 config DEBUG_INFO
 	bool "Compile the kernel with debug info"
 	depends on DEBUG_KERNEL && (ALPHA || CRIS || X86 || IA64 || M68K || MIPS || PARISC || PPC32 || PPC64 || ARCH_S390 || (SUPERH && !SUPERH64) || SPARC64 || V850 || X86_64)
+	default y if KGDB
 	help
           If you say Y here the resulting kernel image will include
 	  debugging info resulting in a larger kernel image.
@@ -104,9 +105,22 @@ if !X86_64
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
 	depends on X86 || CRIS || M68KNOMMU || PARISC
+	default y if KGDB
 	help
 	  If you say Y here the resulting kernel image will be slightly larger
 	  and slower, but it will give very useful debugging information.
 	  If you don't debug the kernel, you can say N, but we may not be able
 	  to solve problems without frame pointers.
 endif
+
+config KGDB
+	bool "KGDB: kernel debugging with remote gdb"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, it will be possible to remotely debug the
+	  kernel using gdb. This enlarges your kernel image disk size by
+	  several megabytes and requires a machine with more than 128 MB
+	  RAM to avoid excessive linking time.
+	  Documentation of kernel debugger available at
+	  http://kgdb.sourceforge.net
+	  This is only useful for kernel hackers. If unsure, say N.
_
