Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbUCHJou (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 04:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbUCHJou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 04:44:50 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:44251 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262434AbUCHJkL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 04:40:11 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: kgdb for mainline kernel: core-lite [patch 1/3]
Date: Mon, 8 Mar 2004 15:09:10 +0530
User-Agent: KMail/1.5
Cc: Tom Rini <trini@kernel.crashing.org>, George Anzinger <george@mvista.com>,
       Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Message-Id: <200403081504.30840.amitkale@emsyssoft.com>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+8DTAkqHLfeCzf4"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_+8DTAkqHLfeCzf4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Andrew,

Here is kgdb for mainline kernel in three patches. This is a lite 
version of kgdb available from kgdb.sourceforge.net. I believe that all of us 
agree on this lite kgdb.

It supports basic debugging of i386 architecture and debugging over a serial 
line. Contents of these patches are as follows:

[1] core-lite.patch: architecture indepndent code
[2] i386-lite.patch: i386 architecture dependent code
[3] 8250.patch: support for generic serial driver

Thanks.
-Amit



--Boundary-00=_+8DTAkqHLfeCzf4
Content-Type: text/x-diff;
  charset="us-ascii";
  name="core-lite.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="core-lite.patch"

Index: linux-2.6.4-rc2-bk3-kgdb/Makefile
===================================================================
--- linux-2.6.4-rc2-bk3-kgdb.orig/Makefile	2004-03-08 14:30:27.382791896 +0530
+++ linux-2.6.4-rc2-bk3-kgdb/Makefile	2004-03-08 14:31:42.813324712 +0530
@@ -440,6 +440,8 @@
 
 ifndef CONFIG_FRAME_POINTER
 CFLAGS		+= -fomit-frame-pointer
+else
+CFLAGS		+= -fno-omit-frame-pointer
 endif
 
 ifdef CONFIG_DEBUG_INFO
Index: linux-2.6.4-rc2-bk3-kgdb/include/linux/debugger.h
===================================================================
--- linux-2.6.4-rc2-bk3-kgdb.orig/include/linux/debugger.h	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.4-rc2-bk3-kgdb/include/linux/debugger.h	2004-03-08 14:31:42.814324560 +0530
@@ -0,0 +1,70 @@
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
+void kgdb_entry(void);
+static inline void debugger_entry(void)
+{
+	kgdb_entry();
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
+static inline void debugger_entry(void)
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
Index: linux-2.6.4-rc2-bk3-kgdb/include/linux/kgdb.h
===================================================================
--- linux-2.6.4-rc2-bk3-kgdb.orig/include/linux/kgdb.h	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.4-rc2-bk3-kgdb/include/linux/kgdb.h	2004-03-08 14:31:42.814324560 +0530
@@ -0,0 +1,128 @@
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
+#ifndef KGDB_MAX_NO_CPUS
+#if CONFIG_NR_CPUS > 8
+#error KGDB can handle max 8 CPUs
+#endif
+#define KGDB_MAX_NO_CPUS 8
+#endif
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
+/* These are functions that the arch specific code can, and in some cases
+ * must, provide. */
+extern int kgdb_arch_init(void);
+extern void regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs);
+extern void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs,
+					struct task_struct *p);
+extern void gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs);
+extern void kgdb_printexceptioninfo(int exceptionNo, int errorcode,
+				    char *buffer);
+extern void kgdb_disable_hw_debug(struct pt_regs *regs);
+extern void kgdb_post_master_code(struct pt_regs *regs, int eVector,
+				  int err_code);
+extern int kgdb_arch_handle_exception(int vector, int signo, int err_code,
+				      char *InBuffer, char *outBuffer,
+				      struct pt_regs *regs);
+extern int kgdb_arch_set_break(unsigned long addr, int type);
+extern int kgdb_arch_remove_break(unsigned long addr, int type);
+extern void kgdb_correct_hw_break(void);
+extern void kgdb_shadowinfo(struct pt_regs *regs, char *buffer,
+			    unsigned threadid);
+extern struct task_struct *kgdb_get_shadow_thread(struct pt_regs *regs,
+						  int threadid);
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
+struct kgdb_serial {
+	int (*read_char) (void);
+	void (*write_char) (int);
+	void (*flush) (void);
+	int (*hook) (void);
+};
+
+extern struct kgdb_serial *kgdb_serial;
+extern struct kgdb_arch arch_kgdb_ops;
+extern int kgdb_initialized;
+
+struct uart_port;
+
+extern void kgdb8250_add_port(int i, struct uart_port *serial_req);
+
+int kgdb_hex2long(char **ptr, long *longValue);
+char *kgdb_mem2hex(char *mem, char *buf, int count);
+char *kgdb_hex2mem(char *buf, char *mem, int count);
+int kgdb_get_mem(char *addr, unsigned char *buf, int count);
+
+#else
+#define kgdb_process_breakpoint()      do {} while(0)
+#endif /* KGDB && !__ASSEMBLY__ */
+#endif				/* _KGDB_H_ */
Index: linux-2.6.4-rc2-bk3-kgdb/init/main.c
===================================================================
--- linux-2.6.4-rc2-bk3-kgdb.orig/init/main.c	2004-03-08 14:30:27.283806944 +0530
+++ linux-2.6.4-rc2-bk3-kgdb/init/main.c	2004-03-08 14:31:42.815324408 +0530
@@ -39,6 +39,7 @@
 #include <linux/writeback.h>
 #include <linux/cpu.h>
 #include <linux/efi.h>
+#include <linux/debugger.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -581,6 +582,7 @@
 
 	smp_init();
 	do_basic_setup();
+	debugger_entry();
 
 	prepare_namespace();
 
Index: linux-2.6.4-rc2-bk3-kgdb/kernel/Makefile
===================================================================
--- linux-2.6.4-rc2-bk3-kgdb.orig/kernel/Makefile	2004-03-08 14:30:26.920862120 +0530
+++ linux-2.6.4-rc2-bk3-kgdb/kernel/Makefile	2004-03-08 14:31:42.815324408 +0530
@@ -19,6 +19,7 @@
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_IKCONFIG_PROC) += configs.o
+obj-$(CONFIG_KGDB) += kgdb.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: linux-2.6.4-rc2-bk3-kgdb/kernel/kgdb.c
===================================================================
--- linux-2.6.4-rc2-bk3-kgdb.orig/kernel/kgdb.c	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.4-rc2-bk3-kgdb/kernel/kgdb.c	2004-03-08 14:31:42.818323952 +0530
@@ -0,0 +1,1275 @@
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
+#include <asm/system.h>
+#include <asm/ptrace.h>
+#include <asm/uaccess.h>
+#include <linux/kgdb.h>
+#include <asm/atomic.h>
+#include <linux/notifier.h>
+#include <linux/module.h>
+#include <asm/cacheflush.h>
+#ifdef CONFIG_KGDB_CONSOLE
+#include <linux/console.h>
+#endif
+#include <linux/init.h>
+
+extern int pid_max;
+
+#define BUF_THREAD_ID_SIZE 16
+
+/*
+ * kgdb_initialized indicates that kgdb is setup and is all ready to serve
+ * breakpoints and other kernel exceptions. kgdb_connected indicates that kgdb
+ * has connected to kgdb.
+ */
+int kgdb_initialized = 0;
+volatile int kgdb_connected;
+
+/* If non-zero, wait for a gdb connection when kgdb_entry is called */
+int kgdb_enter = 0;
+
+/* Set to 1 to make kgdb allow access to user addresses. Can be set from gdb
+ * also at runtime. */
+int kgdb_useraccess = 0;
+
+struct kgdb_serial *kgdb_serial;
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
+static spinlock_t slavecpulocks[KGDB_MAX_NO_CPUS];
+static volatile int procindebug[KGDB_MAX_NO_CPUS];
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
+static char remcom_in_buffer[BUFMAX];
+static char remcom_out_buffer[BUFMAX];
+
+/*
+ * The following are the stub functions for code which is arch specific
+ * and can be omitted on some arches
+ * This function will handle the initalization of any architecture specific
+ * hooks.  If there is a suitable early output driver, kgdb_serial
+ * can be pointed at it now.
+ */
+int __attribute__ ((weak))
+    kgdb_arch_init(void)
+{
+	return 0;
+}
+
+void __attribute__ ((weak))
+    regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+}
+
+void __attribute__ ((weak))
+    sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
+{
+}
+
+void __attribute__ ((weak))
+    gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+}
+
+void __attribute__ ((weak))
+    kgdb_printexceptioninfo(int exceptionNo, int errorcode, char *buffer)
+{
+}
+
+void __attribute__ ((weak))
+    kgdb_disable_hw_debug(struct pt_regs *regs)
+{
+}
+
+void __attribute__ ((weak))
+    kgdb_post_master_code(struct pt_regs *regs, int eVector, int err_code)
+{
+}
+
+/*
+ * Handle any additional commands.  This must handle the 'c' and 's'
+ * command packets.
+ * Return -1 to loop over other commands, and 0 to exit from KGDB
+ */
+int __attribute__ ((weak))
+    kgdb_arch_handle_exception(int vector, int signo, int err_code, char *InBuffer,
+			   char *outBuffer, struct pt_regs *regs)
+{
+	return 0;
+}
+
+int __attribute__ ((weak))
+    kgdb_arch_set_break(unsigned long addr, int type)
+{
+	return 0;
+}
+
+int __attribute__ ((weak))
+    kgdb_arch_remove_break(unsigned long addr, int type)
+{
+	return 0;
+}
+
+void __attribute__ ((weak))
+    kgdb_correct_hw_break(void)
+{
+}
+
+void __attribute__ ((weak))
+    kgdb_shadowinfo(struct pt_regs *regs, char *buffer, unsigned threadid)
+{
+}
+
+struct task_struct __attribute__ ((weak))
+    * kgdb_get_shadow_thread(struct pt_regs *regs, int threadid)
+{
+	return NULL;
+}
+
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
+	int i;
+	int count;
+	char ch;
+
+	do {
+		/* wait around for the start character, ignore all other
+		 * characters */
+		while ((ch = (kgdb_serial->read_char() & 0x7f)) != '$')
+			;	/* Spin. */
+		kgdb_connected = 1;
+		checksum = 0;
+		xmitcsum = -1;
+
+		count = 0;
+
+		/* now, read until a # or end of buffer is found */
+		while (count < (BUFMAX - 1)) {
+			ch = kgdb_serial->read_char() & 0x7f;
+			if (ch == '#')
+				break;
+			checksum = checksum + ch;
+			buffer[count] = ch;
+			count = count + 1;
+		}
+		buffer[count] = 0;
+
+		if (ch == '#') {
+			xmitcsum = hex(kgdb_serial->read_char() & 0x7f) << 4;
+			xmitcsum += hex(kgdb_serial->read_char() & 0x7f);
+
+			if (checksum != xmitcsum)
+				kgdb_serial->write_char('-');	/* failed checksum */
+			else
+				kgdb_serial->write_char('+');	/* successful transfer */
+			if (kgdb_serial->flush)
+				kgdb_serial->flush();
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
+		kgdb_serial->write_char('$');
+		checksum = 0;
+		count = 0;
+
+		while ((ch = buffer[count])) {
+			kgdb_serial->write_char(ch);
+			checksum += ch;
+			count++;
+		}
+
+		kgdb_serial->write_char('#');
+		kgdb_serial->write_char(hexchars[checksum >> 4]);
+		kgdb_serial->write_char(hexchars[checksum % 16]);
+		if (kgdb_serial->flush)
+			kgdb_serial->flush();
+
+		/* Now see what we get in reply. */
+		ch = kgdb_serial->read_char();
+
+		if (ch == 3)
+			ch = kgdb_serial->read_char();
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
+			kgdb_serial->write_char('-');
+			if (kgdb_serial->flush)
+				kgdb_serial->flush();
+			return;
+		}
+	}
+}
+
+static int get_char(char *addr, unsigned char *data)
+{
+	mm_segment_t fs;
+	int ret = 0;
+
+	if (!kgdb_useraccess && (unsigned long)addr < TASK_SIZE) {
+		return -EINVAL;
+	}
+	wmb();
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+
+	if (get_user(*data, addr) != 0) {
+		ret = -EFAULT;
+	}
+
+	set_fs(fs);
+	return ret;
+}
+
+static int set_char(char *addr, int data)
+{
+	mm_segment_t fs;
+	int ret = 0;
+
+	if (!kgdb_useraccess && (unsigned long)addr < TASK_SIZE) {
+		return -EINVAL;
+	}
+	wmb();
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+
+	if (put_user(data, addr) != 0) {
+		ret = -EFAULT;
+	}
+
+	set_fs(fs);
+	return ret;
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
+	int error;
+
+	for (i = 0; i < count; i++) {
+
+		if ((error = get_char(mem++, &ch)) < 0)
+			return ERR_PTR(error);
+
+		*buf++ = hexchars[ch >> 4];
+		*buf++ = hexchars[ch % 16];
+	}
+	*buf = 0;
+	return (buf);
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
+	int error;
+
+	for (i = 0; i < count; i++) {
+		ch = hex(*buf++) << 4;
+		ch = ch + hex(*buf++);
+		if ((error = set_char(mem++, ch)) < 0)
+			return ERR_PTR(error);
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
+	struct list_head *l;
+	struct task_struct *p;
+	struct pid *pid;
+
+	if (tid >= pid_max + num_online_cpus() + kgdb_ops->shadowth) {
+		return NULL;
+	}
+	if (tid >= pid_max + num_online_cpus()) {
+		return kgdb_get_shadow_thread(regs, tid - pid_max -
+					      num_online_cpus());
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
+	/* Wait till master processor goes completely into the debugger.
+	 * FIXME: this looks racy */
+	while (!procindebug[atomic_read(&debugger_active) - 1]) {
+		int i = 10;	/* an arbitrary number */
+
+		while (--i)
+			asm volatile ("nop":::"memory");
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
+int kgdb_get_mem(char *addr, unsigned char *buf, int count)
+{
+	int error;
+	while (count) {
+		if ((error = get_char(addr++, buf)) < 0)
+			return error;
+		buf++;
+		count--;
+	}
+	return 0;
+}
+
+static int set_mem(char *addr, unsigned char *buf, int count)
+{
+	int error;
+	while (count) {
+		if ((error = set_char(addr++, *buf++)) < 0)
+			return error;
+		count--;
+	}
+	return 0;
+}
+
+static int set_break(unsigned long addr)
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
+	if ((error = kgdb_get_mem((char *)addr, kgdb_break[breakno].saved_instr,
+				  BREAK_INSTR_SIZE)) < 0)
+		return error;
+
+	if ((error = set_mem((char *)addr, kgdb_ops->gdb_bpt_instr,
+			     BREAK_INSTR_SIZE)) < 0)
+		return error;
+	flush_cache_range(current->mm, addr, addr + BREAK_INSTR_SIZE);
+	flush_icache_range(addr, addr + BREAK_INSTR_SIZE);
+
+	kgdb_break[breakno].state = bp_enabled;
+	kgdb_break[breakno].type = bp_breakpoint;
+	kgdb_break[breakno].bpt_addr = addr;
+
+	return 0;
+}
+
+static int remove_break(unsigned long addr)
+{
+	int i;
+	int error;
+
+	for (i = 0; i < MAX_BREAKPOINTS; i++) {
+		if ((kgdb_break[i].state == bp_enabled) &&
+		    (kgdb_break[i].bpt_addr == addr)) {
+			if ((error =
+			     set_mem((char *)addr, kgdb_break[i].saved_instr,
+				     BREAK_INSTR_SIZE)) < 0)
+				return error;
+			flush_cache_range(current->mm, addr,
+					  addr + BREAK_INSTR_SIZE);
+			flush_icache_range(addr, addr + BREAK_INSTR_SIZE);
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
+	for (i = 0; i < MAX_BREAKPOINTS; i++) {
+		if (kgdb_break[i].state == bp_enabled) {
+			unsigned long addr = kgdb_break[i].bpt_addr;
+			if ((error =
+			     set_mem((char *)addr, kgdb_break[i].saved_instr,
+				     BREAK_INSTR_SIZE)) < 0)
+				return error;
+			flush_cache_range(current->mm, addr,
+					  addr + BREAK_INSTR_SIZE);
+			flush_icache_range(addr, addr + BREAK_INSTR_SIZE);
+		}
+		kgdb_break[i].state = bp_disabled;
+	}
+	return 0;
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
+			  struct pt_regs *linux_regs)
+{
+	unsigned long length, addr;
+	char *ptr;
+	unsigned long flags;
+	unsigned long gdb_regs[NUMREGBYTES / sizeof(unsigned long)];
+	int i;
+	long threadid;
+	threadref thref;
+	struct task_struct *thread = NULL;
+	unsigned procid;
+	static char tmpstr[256];
+	int numshadowth = num_online_cpus() + kgdb_ops->shadowth;
+	long kgdb_usethreadid = 0;
+	int error = 0;
+	struct pt_regs *shadowregs;
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
+			asm volatile ("nop":::"memory");
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
+	memset(remcom_out_buffer, 0, sizeof(remcom_out_buffer));
+
+	/* Master processor is completely in the debugger */
+	kgdb_post_master_code(linux_regs, exVector, err_code);
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
+	kgdb_usethread = current;
+	kgdb_usethreadid = shadow_pid(current->pid);
+
+	while (1) {
+		int bpt_type = 0;
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
+			if (!thread)
+				thread = current;
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
+			} else if (thread->thread.debuggerinfo) {
+				if ((error =
+				     get_char(thread->thread.debuggerinfo,
+					      (unsigned char *)gdb_regs)) < 0) {
+					error_packet(remcom_out_buffer, error);
+					break;
+				}
+				regs_to_gdb_regs(gdb_regs, (struct pt_regs *)
+						 thread->thread.debuggerinfo);
+			} else {
+				/* Pull stuff saved during 
+				 * switch_to; nothing else is
+				 * accessible (or even particularly relevant).
+				 * This should be enough for a stack trace. */
+				sleeping_thread_to_gdb_regs(gdb_regs, thread);
+			}
+
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
+				gdb_regs_to_regs(gdb_regs, (struct pt_regs *)
+						 current->thread.debuggerinfo);
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
+			/* MAA..AA,LLLL: Write LLLL bytes at address AA.AA return OK */
+		case 'M':
+			ptr = &remcom_in_buffer[1];
+			if (kgdb_hex2long(&ptr, &addr) > 0 && *(ptr++) == ','
+			    && kgdb_hex2long(&ptr, &length) > 0 &&
+			    *(ptr++) == ':') {
+				if (IS_ERR(ptr = kgdb_hex2mem(ptr, (char *)addr,
+							      length)))
+					error_packet(remcom_out_buffer,
+						     PTR_ERR(ptr));
+			} else
+				error_packet(remcom_out_buffer, -EINVAL);
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
+
+			case 'E':
+				/* Print exception info */
+				kgdb_printexceptioninfo(exVector, err_code,
+							remcom_out_buffer);
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
+					kgdb_contthread = 0;
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
+		case 'z':
+		case 'Z':
+			ptr = &remcom_in_buffer[2];
+			if (*(ptr++) != ',') {
+				error_packet(remcom_out_buffer, -EINVAL);
+				break;
+			}
+			kgdb_hex2long(&ptr, &addr);
+
+			bpt_type = remcom_in_buffer[1];
+			if (bpt_type != bp_breakpoint) {
+				if (bpt_type == bp_hardware_breakpoint &&
+				    !(kgdb_ops->flags & KGDB_HW_BREAKPOINT))
+					break;
+
+				/* if set_break is not defined, then
+				 * remove_break does not matter
+				 */
+				if (!(kgdb_ops->flags & KGDB_HW_BREAKPOINT))
+					break;
+			}
+
+			if (remcom_in_buffer[0] == 'Z') {
+				if (bpt_type == bp_breakpoint)
+					error = set_break(addr);
+				else
+					error = kgdb_arch_set_break(addr,
+								    bpt_type);
+			} else {
+				if (bpt_type == bp_breakpoint)
+					error = remove_break(addr);
+				else
+					error = kgdb_arch_remove_break(addr,
+								       bpt_type);
+			}
+
+			if (error == 0)
+				strcpy(remcom_out_buffer, "OK");
+			else
+				error_packet(remcom_out_buffer, error);
+
+			break;
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
+			int j = 10;	/* an arbitrary number */
+
+			while (--j) {
+				asm volatile ("nop":::"memory");
+			}
+			barrier();
+		}
+	}
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
+/* This function will generate a breakpoint exception.  It is used at the
+   beginning of a program to sync up with a debugger and can be used
+   otherwise as a quick means to stop program execution and "break" into
+   the debugger. */
+
+void breakpoint(void)
+{
+	if (!kgdb_initialized) {
+		kgdb_enter = 1;
+		kgdb_entry();
+		if (!kgdb_initialized) {
+			printk("kgdb not enabled. Cannot do breakpoint\n");
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
+	int i;
+
+	if (kgdb_initialized) {
+		/* KGDB was initialized */
+		return;
+	}
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
+	/* Let the arch do any initalization it needs to, including
+	 * pointing to a suitable early output device. */
+	kgdb_arch_init();
+
+	/* We can't do much if this fails */
+	register_module_notifier(&kgdb_module_load_nb);
+
+	atomic_set(&kgdb_setting_breakpoint, 0);
+
+	if (!kgdb_serial || kgdb_serial->hook() < 0) {
+		/* KGDB interface isn't ready yet */
+		return;
+	}
+	kgdb_initialized = 1;
+	if (!kgdb_enter) {
+		return;
+	}
+	/*
+	 * Call the breakpoint() routine in GDB to start the debugging
+	 * session
+	 */
+	printk(KERN_CRIT "Waiting for connection from remote gdb... ");
+	breakpoint();
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
+	  * to avoid reentrancy issues
+	 */
+	if (kgdb_need_breakpoint[smp_processor_id()]) {
+		 kgdb_need_breakpoint[smp_processor_id()] = 0;
+		 breakpoint();
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
+		put_packet(kgdbconbuf);
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
+
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
Index: linux-2.6.4-rc2-bk3-kgdb/kernel/sched.c
===================================================================
--- linux-2.6.4-rc2-bk3-kgdb.orig/kernel/sched.c	2004-03-08 14:30:26.958856344 +0530
+++ linux-2.6.4-rc2-bk3-kgdb/kernel/sched.c	2004-03-08 14:31:42.819323800 +0530
@@ -37,6 +37,7 @@
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
 #include <linux/percpu.h>
+#include <linux/debugger.h>
 
 #ifdef CONFIG_NUMA
 #define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
@@ -2961,6 +2962,8 @@
 #if defined(in_atomic)
 	static unsigned long prev_jiffy;	/* ratelimiting */
 
+	if (atomic_read(&debugger_active))
+		return;
 	if ((in_atomic() || irqs_disabled()) && system_running) {
 		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
 			return;
Index: linux-2.6.4-rc2-bk3-kgdb/kernel/Kconfig.kgdb
===================================================================
--- linux-2.6.4-rc2-bk3-kgdb.orig/kernel/Kconfig.kgdb	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.4-rc2-bk3-kgdb/kernel/Kconfig.kgdb	2004-03-08 14:31:42.820323648 +0530
@@ -0,0 +1,13 @@
+config KGDB
+	bool "KGDB: kernel debugging with remote gdb"
+	depends on DEBUG_KERNEL
+	select DEBUG_INFO
+	select FRAME_POINTER
+	help
+	  If you say Y here, it will be possible to remotely debug the
+	  kernel using gdb. This enlarges your kernel image disk size by
+	  several megabytes and requires a machine with more than 128 MB
+	  RAM to avoid excessive linking time. 
+	  Documentation of kernel debugger available at
+	  http://kgdb.sourceforge.net
+	  This is only useful for kernel hackers. If unsure, say N.
Index: linux-2.6.4-rc2-bk3-kgdb/Documentation/kgdb.txt
===================================================================
--- linux-2.6.4-rc2-bk3-kgdb.orig/Documentation/kgdb.txt	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.4-rc2-bk3-kgdb/Documentation/kgdb.txt	2004-03-08 14:31:42.820323648 +0530
@@ -0,0 +1,49 @@
+KGDB Linux kernel source level debugger
+
+Amit S. Kale <amitkale@emsyssoft.com>
+Last updated March 2004.
+
+Introduction:
+kgdb is a source level debugger for linux kernel. It is used along with gdb to
+debug a linux kernel. Kernel developers can debug a kernel similar to
+application programs with the use of kgdb. It makes it possible to place
+breakpoints in kernel code, step through the code and observe variables.
+
+Two machines are required for using kgdb. One of these machines is a
+development machine and the other is a test machine. The machines are
+connected through a serial line, a null-modem cable which connects their
+serial ports. The kernel to be debugged runs on the test machine. gdb runs on
+the development machine. The serial line is used by gdb to communicate to the
+kernel being debugged.
+
+This version of kgdb is a lite version. It is available on i386 platform uses
+a serial line for communicating to gdb. Full kgdb containing more features and
+supporting more architecture is available along with plenty of documentation
+at http://kgdb.sourceforge.net/
+
+Compiling a kernel:
+Enable Kernel hacking -> Kernel Debugging -> KGDB: kernel debugging with
+remote gdb
+
+Only generic serial port (8250) is supported in the lite version. Configure
+8250 options.
+
+Booting the kernel:
+Kernel command line option "kgdbwait" makes kgdb wait for gdb connection
+during booting of a kernel. If you have configured simple serial port, the
+port number and speed can be overriden on command line by using option
+"kgdb8250=portnumber,speed", where port numbers are 0-3 for COM1 to COM4
+respectively and supported speeds are 9600, 19200, 38400, 57600, 115200.
+Example: kgdbwait kgdb8250=0,115200
+
+Connecting gdb:
+If you have used "kgdbwait", kgdb prints a message "Waiting for connection
+from remote gdb..." on the console and waits for connection from gdb. At this
+point you connect gdb to kgdb.
+Example: 
+   % gdb ./vmlinux
+   (gdb) set remotebaud 115200
+   (gdb) target remote /dev/ttyS0
+
+Once connected, you can debug a kernel the way you would debug an application
+program.

--Boundary-00=_+8DTAkqHLfeCzf4--

