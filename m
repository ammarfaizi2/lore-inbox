Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUBKOqY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 09:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUBKOqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 09:46:23 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:51908 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S263775AbUBKOpV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 09:45:21 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: kgdb ChangeLog and interdiff for core.patch
Date: Wed, 11 Feb 2004 20:14:37 +0530
User-Agent: KMail/1.5
Cc: George Anzinger <george@mvista.com>, Tom Rini <trini@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402112014.42502.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is an interdiff of the file core.patch wrt kgdb 2.1.0 for review. Diffs 
for other files will following in separate emails.

ChangeLog:
2004-02-11 Amit S. Kale <amitkale@emsyssoft.com>
	* Removed pc and sp in exception reporting to gdb

2004-02-10 Amit S. Kale <amitkale@emsyssoft.com>
	* Changed several functions to return negative error number instead of
	-1 to be consistent with the kernel
	* Removed use of a global to detect memory access errors in kgdb by
	preventing kgdb from accessing user addresses
	* Cleanups
	* From someone - Fixed a buffer overflow in getpacket.

2004-02-05 Tom Rini <trini@kernel.crashing.org>
	* Go back to kgdb_serial fn pointer.
	* Fixes to kgdb over ethernet

2004-01-30 Tom Rini <trini@kernel.crashing.org>
	* Change *kgdb_serial into kgdb_serial_driver.  We will now have
	only one serial driver.
	* PPC32: Add KGDB support to the Motorola Sandpoint.

2004-01-30 Pavel Machek <pavel@suse.cz>
	* Convert the kgdb ethernet driver over to netpoll.

2004-01-27 Tom Rini <trini@kernel.crashing.org>
	* Send a 'T' packet initially, not an 'S' followed by 'p'
	* On PPC32, try to pass in the correct signal back.
	* Cleanups
	* Remove the function pointers from kgdb_ops. Most have become
	kgdb_foo, instead of foo. The exceptions are the gdb/kgdb register
	fiddling functions.

--- archive/2.1.0/linux-2.6.1-kgdb-2.1.0/core.patch	2004-01-21 
22:03:53.000000000 +0530
+++ cvs/kgdb-2/core.patch	2004-02-11 20:09:49.000000000 +0530
@@ -1,6 +1,6 @@
-diff -Naurp linux-2.6.1/include/linux/bitops.h 
linux-2.6.1-kgdb-2.1.0-core/include/linux/bitops.h
---- linux-2.6.1/include/linux/bitops.h	2003-11-24 07:03:19.000000000 +0530
-+++ linux-2.6.1-kgdb-2.1.0-core/include/linux/bitops.h	2004-01-12 
19:11:04.000000000 +0530
+diff -Naurp linux-2.6.2/include/linux/bitops.h 
linux-2.6.2-kgdb-core/include/linux/bitops.h
+--- linux-2.6.2/include/linux/bitops.h	2003-11-24 07:03:19.000000000 +0530
++++ linux-2.6.2-kgdb-core/include/linux/bitops.h	2004-02-10 
13:10:36.000000000 +0530
 @@ -108,7 +108,7 @@ static inline unsigned int generic_hweig
          return (res & 0x0F) + ((res >> 4) & 0x0F);
  }
@@ -20,10 +20,10 @@
  #endif
  }
  
-diff -Naurp linux-2.6.1/include/linux/debugger.h 
linux-2.6.1-kgdb-2.1.0-core/include/linux/debugger.h
---- linux-2.6.1/include/linux/debugger.h	1970-01-01 05:30:00.000000000 +0530
-+++ linux-2.6.1-kgdb-2.1.0-core/include/linux/debugger.h	2004-01-13 
14:21:47.000000000 +0530
-@@ -0,0 +1,67 @@
+diff -Naurp linux-2.6.2/include/linux/debugger.h 
linux-2.6.2-kgdb-core/include/linux/debugger.h
+--- linux-2.6.2/include/linux/debugger.h	1970-01-01 05:30:00.000000000 +0530
++++ linux-2.6.2-kgdb-core/include/linux/debugger.h	2004-02-10 
15:04:44.000000000 +0530
+@@ -0,0 +1,66 @@
 +#ifndef _DEBUGGER_H_
 +#define _DEBUGGER_H_
 +
@@ -64,7 +64,6 @@
 +
 +extern int debugger_step;
 +extern atomic_t debugger_active;
-+extern volatile int debugger_memerr_expected;
 +
 +/*
 + * No debugger in the kernel
@@ -91,10 +90,10 @@
 +
 +
 +#endif /* _DEBUGGER_H_ */
-diff -Naurp linux-2.6.1/include/linux/kgdb.h 
linux-2.6.1-kgdb-2.1.0-core/include/linux/kgdb.h
---- linux-2.6.1/include/linux/kgdb.h	1970-01-01 05:30:00.000000000 +0530
-+++ linux-2.6.1-kgdb-2.1.0-core/include/linux/kgdb.h	2004-01-21 
21:53:49.000000000 +0530
-@@ -0,0 +1,113 @@
+diff -Naurp linux-2.6.2/include/linux/kgdb.h 
linux-2.6.2-kgdb-core/include/linux/kgdb.h
+--- linux-2.6.2/include/linux/kgdb.h	1970-01-01 05:30:00.000000000 +0530
++++ linux-2.6.2-kgdb-core/include/linux/kgdb.h	2004-02-11 11:18:57.000000000 
+0530
+@@ -0,0 +1,112 @@
 +#ifndef _KGDB_H_
 +#define _KGDB_H_
 +
@@ -121,10 +120,10 @@
 +extern atomic_t kgdb_setting_breakpoint;
 +extern atomic_t kgdb_killed_or_detached;
 +extern atomic_t kgdb_might_be_resumed;
-+	
++
 +extern struct task_struct *kgdb_usethread, *kgdb_contthread;
 +
-+enum gdb_bptype
++enum kgdb_bptype
 +{
 +	bp_breakpoint = '0',
 +	bp_hardware_breakpoint,
@@ -133,25 +132,23 @@
 +	bp_access_watchpoint
 +};
 +
-+enum gdb_bpstate
++enum kgdb_bpstate
 +{
 +       bp_disabled,
 +       bp_enabled
 +};
 +
-+#ifndef BREAK_INSTR_SIZE
-+#error BREAK_INSTR_SIZE  needed by kgdb
-+#endif
-+
-+struct gdb_breakpoint
++struct kgdb_bkpt
 +{
-+       unsigned long            bpt_addr;
-+       unsigned char           saved_instr[BREAK_INSTR_SIZE];
-+       enum gdb_bptype         type;
-+       enum gdb_bpstate        state;
++       unsigned long		bpt_addr;
++       unsigned char		saved_instr[BREAK_INSTR_SIZE];
++       enum kgdb_bptype		type;
++       enum kgdb_bpstate	state;
 +};
 +
-+typedef struct gdb_breakpoint gdb_breakpoint_t;
++#ifndef BREAK_INSTR_SIZE
++#error BREAK_INSTR_SIZE  needed by kgdb
++#endif
 +
 +#ifndef MAX_BREAKPOINTS
 +#define MAX_BREAKPOINTS        16
@@ -159,41 +156,41 @@
 +
 +#define KGDB_HW_BREAKPOINT          1
 +
++/* These are functions that the arch specific code can, and in some cases
++ * must, provide. */
++extern int kgdb_arch_init(void);
++extern void regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs);
++extern void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs,struct 
task_struct *p);
++extern void gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs);
++extern void kgdb_printexceptioninfo(int exceptionNo, int errorcode,
++		char *buffer);
++extern void kgdb_disable_hw_debug(struct pt_regs *regs);
++extern void kgdb_post_master_code(struct pt_regs *regs, int eVector,
++		int err_code);
++extern int kgdb_arch_handle_exception(int vector, int signo, int err_code,
++		char *InBuffer, char *outBuffer, struct pt_regs *regs);
++extern int kgdb_arch_set_break(unsigned long addr, int type);
++extern int kgdb_arch_remove_break(unsigned long addr, int type);
++extern void kgdb_correct_hw_break(void);
++extern void kgdb_shadowinfo(struct pt_regs *regs, char *buffer, unsigned 
threadid);
++extern struct task_struct *kgdb_get_shadow_thread(struct pt_regs *regs,
++		int threadid);
++extern struct pt_regs *kgdb_shadow_regs(struct pt_regs *regs, int threadid);
++
 +struct kgdb_arch {
 +	unsigned char gdb_bpt_instr[BREAK_INSTR_SIZE];
 +	unsigned long flags;
 +	unsigned shadowth;
-+	
-+	int  (*kgdb_init) (void);
-+	void (*regs_to_gdb_regs)(unsigned long *gdb_regs, struct pt_regs *regs);
-+	void (*sleeping_thread_to_gdb_regs)(unsigned long *gdb_regs,struct 
task_struct *p);
-+	void (*gdb_regs_to_regs)(unsigned long *gdb_regs, struct pt_regs *regs);
-+	void (*printexceptioninfo)(int exceptionNo, int errorcode, char *buffer);
-+	void (*disable_hw_debug) (struct pt_regs *regs);
-+	void (*post_master_code) (struct pt_regs *regs, int eVector, int err_code);
-+	int  (*handle_exception) (int vector, int signo, int err_code,
-+			       char *InBuffer, char *outBuffer,
-+			       struct pt_regs *regs);
-+	int  (*set_break) (unsigned long addr, int type);
-+	int  (*remove_break) (unsigned long addr, int type);
-+	void (*correct_hw_break) (void);
-+	void (*handler_exit) (void);
-+	void (*shadowinfo)(struct pt_regs *regs, char *buffer, unsigned threadid);
-+	struct task_struct *(*get_shadow_thread)(struct pt_regs *regs, int 
threadid);
-+	struct pt_regs *(*shadow_regs)(struct pt_regs *regs, int threadid);
 +};			
 +
 +/* Thread reference */
 +typedef unsigned char threadref[8];
 +
 +struct kgdb_serial {
-+	int chunksize;
 +	int (*read_char)(void);
 +	void (*write_char)(int);
 +	void (*flush)(void);
 +	int (*hook)(void);
-+	void (*begin_session)(void);
-+	void (*end_session)(void);
 +};
 +
 +extern struct kgdb_serial *kgdb_serial;
@@ -205,12 +202,13 @@
 +extern void kgdb8250_add_port(int i, struct uart_port *serial_req);
 +
 +int kgdb_hexToLong(char **ptr, long *longValue);
-+char *kgdb_mem2hex(char *mem, char *buf, int count, int can_fault);
++char *kgdb_mem2hex(char *mem, char *buf, int count);
++char *kgdb_hex2mem(char *buf, char *mem, int count);
 +
 +#endif /* _KGDB_H_ */
-diff -Naurp linux-2.6.1/include/linux/sched.h 
linux-2.6.1-kgdb-2.1.0-core/include/linux/sched.h
---- linux-2.6.1/include/linux/sched.h	2004-01-10 11:01:50.000000000 +0530
-+++ linux-2.6.1-kgdb-2.1.0-core/include/linux/sched.h	2004-01-12 
19:11:04.000000000 +0530
+diff -Naurp linux-2.6.2/include/linux/sched.h 
linux-2.6.2-kgdb-core/include/linux/sched.h
+--- linux-2.6.2/include/linux/sched.h	2004-02-10 13:01:29.000000000 +0530
++++ linux-2.6.2-kgdb-core/include/linux/sched.h	2004-02-10 13:10:36.000000000 
+0530
 @@ -173,7 +173,9 @@ extern unsigned long cache_decay_ticks;
  
  #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
@@ -222,7 +220,7 @@
  
  struct namespace;
  
-@@ -905,6 +907,15 @@ static inline void set_task_cpu(struct t
+@@ -906,6 +908,15 @@ static inline void set_task_cpu(struct t
  
  #endif /* CONFIG_SMP */
  
@@ -238,9 +236,9 @@
  #endif /* __KERNEL__ */
  
  #endif
-diff -Naurp linux-2.6.1/init/main.c linux-2.6.1-kgdb-2.1.0-core/init/main.c
---- linux-2.6.1/init/main.c	2004-01-10 11:01:50.000000000 +0530
-+++ linux-2.6.1-kgdb-2.1.0-core/init/main.c	2004-01-12 19:11:04.000000000 
+0530
+diff -Naurp linux-2.6.2/init/main.c linux-2.6.2-kgdb-core/init/main.c
+--- linux-2.6.2/init/main.c	2004-02-10 13:01:30.000000000 +0530
++++ linux-2.6.2-kgdb-core/init/main.c	2004-02-10 13:10:36.000000000 +0530
 @@ -39,6 +39,7 @@
  #include <linux/writeback.h>
  #include <linux/cpu.h>
@@ -249,7 +247,7 @@
  
  #include <asm/io.h>
  #include <asm/bugs.h>
-@@ -578,6 +579,7 @@ static int init(void * unused)
+@@ -580,6 +581,7 @@ static int init(void * unused)
  	do_pre_smp_initcalls();
  
  	smp_init();
@@ -257,10 +255,10 @@
  	do_basic_setup();
  
  	prepare_namespace();
-diff -Naurp linux-2.6.1/kernel/kgdbstub.c 
linux-2.6.1-kgdb-2.1.0-core/kernel/kgdbstub.c
---- linux-2.6.1/kernel/kgdbstub.c	1970-01-01 05:30:00.000000000 +0530
-+++ linux-2.6.1-kgdb-2.1.0-core/kernel/kgdbstub.c	2004-01-20 
11:44:09.000000000 +0530
-@@ -0,0 +1,1236 @@
+diff -Naurp linux-2.6.2/kernel/kgdbstub.c 
linux-2.6.2-kgdb-core/kernel/kgdbstub.c
+--- linux-2.6.2/kernel/kgdbstub.c	1970-01-01 05:30:00.000000000 +0530
++++ linux-2.6.2-kgdb-core/kernel/kgdbstub.c	2004-02-11 12:16:35.000000000 
+0530
+@@ -0,0 +1,1271 @@
 +/*
 + * This program is free software; you can redistribute it and/or modify it
 + * under the terms of the GNU General Public License as published by the
@@ -304,70 +302,157 @@
 +#include <linux/delay.h>
 +#include <linux/mm.h>
 +#include <asm/system.h>
-+#include <asm/ptrace.h>		/* for linux pt_regs struct */
++#include <asm/ptrace.h>
 +#include <asm/uaccess.h>
 +#include <linux/kgdb.h>
 +#include <asm/atomic.h>
 +#include <linux/notifier.h>
 +#include <linux/module.h>
 +#include <asm/cacheflush.h>
-+
 +#ifdef CONFIG_KGDB_CONSOLE
 +#include <linux/console.h>
 +#endif
-+ 
 +#include <linux/init.h>
 +
-+
-+
-+struct kgdb_arch *kgdb_ops = &arch_kgdb_ops;
-+gdb_breakpoint_t kgdb_break[MAX_BREAKPOINTS];
 +extern int pid_max;
 +
-+struct kgdb_serial *kgdb_serial;
++#define BUF_THREAD_ID_SIZE 16
 +
++/*
++ * kgdb_initialized indicates that kgdb is setup and is all ready to serve
++ * breakpoints and other kernel exceptions. kgdb_connected indicates that 
kgdb
++ * has connected to kgdb.
++ */
 +int kgdb_initialized = 0;
++static volatile int kgdb_connected;
++
++/* If non-zero, wait for a gdb connection when kgdb_entry is called */
 +int kgdb_enter = 0;
-+static const char hexchars[] = "0123456789abcdef";
 +
-+int get_char(char *addr, unsigned char *data, int can_fault);
-+int set_char(char *addr, int data, int can_fault);
++/* Set to 1 to make kgdb allow access to user addresses. Can be set from gdb
++ * also at runtime. */
++int kgdb_useraccess = 0;
++
++struct kgdb_serial *kgdb_serial;
++
++/*
++ * Holds information about breakpoints in a kernel. These breakpoints are
++ * added and removed by gdb.
++ */
++struct kgdb_bkpt kgdb_break[MAX_BREAKPOINTS];
++
++struct kgdb_arch *kgdb_ops = &arch_kgdb_ops;
++
++static const char hexchars[] = "0123456789abcdef";
 +
-+spinlock_t slavecpulocks[KGDB_MAX_NO_CPUS];
-+volatile int procindebug[KGDB_MAX_NO_CPUS];
++static spinlock_t slavecpulocks[KGDB_MAX_NO_CPUS];
++static volatile int procindebug[KGDB_MAX_NO_CPUS];
 +atomic_t kgdb_setting_breakpoint;
 +atomic_t kgdb_killed_or_detached;
 +atomic_t kgdb_might_be_resumed;
-+volatile int kgdb_connected;
 +struct task_struct *kgdb_usethread, *kgdb_contthread;
 +
 +int debugger_step;
 +atomic_t debugger_active;
 +
-+/* 
-+ * Indicate to caller of kgdb_mem2hex or hex2mem that there has been an
-+ * error.  
-+ */
-+volatile int kgdb_memerr = 0;
-+volatile int debugger_memerr_expected = 0;
-+
 +/* This will point to kgdb_handle_exception by default.
 + * The architecture code can override this in its init function
 + */
 +gdb_debug_hook *linux_debug_hook;
 +
-+
 +static char remcomInBuffer[BUFMAX];
 +static char remcomOutBuffer[BUFMAX];
-+static short error;
 +
-+int module_event(struct notifier_block * self, unsigned long val, void * 
data);
++/*
++ * The following are the stub functions for code which is arch specific
++ * and can be omitted on some arches
++ * This function will handle the initalization of any architecture specific
++ * hooks.  If there is a suitable early output driver, kgdb_serial
++ * can be pointed at it now.
++ */
++int __attribute__ ((weak))
++kgdb_arch_init(void)
++{
++	return 0;
++}
 +
-+static struct notifier_block kgdb_module_load_nb = {
-+	.notifier_call = module_event,
-+};
++void __attribute__ ((weak))
++regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
++{
++}
++
++void __attribute__ ((weak))
++sleeping_thread_to_gdb_regs(unsigned long *gdb_regs,struct task_struct *p)
++{
++}
++
++void __attribute__ ((weak))
++gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs)
++{
++}
++
++void __attribute__ ((weak))
++kgdb_printexceptioninfo(int exceptionNo, int errorcode, char *buffer)
++{
++}
++
++void __attribute__ ((weak))
++kgdb_disable_hw_debug(struct pt_regs *regs)
++{
++}
 +
-+int hex(char ch)
++void __attribute__ ((weak))
++kgdb_post_master_code(struct pt_regs *regs, int eVector, int err_code)
++{
++}
++
++/*
++ * Handle any additional commands.  This must handle the 'c' and 's'
++ * command packets.
++ * Return -1 to loop over other commands, and 0 to exit from KGDB
++ */
++int __attribute__ ((weak))
++kgdb_arch_handle_exception(int vector, int signo, int err_code, char 
*InBuffer,
++		char *outBuffer, struct pt_regs *regs)
++{
++	return 0;
++}
++
++int __attribute__ ((weak))
++kgdb_arch_set_break(unsigned long addr, int type)
++{
++	return 0;
++}
++
++int __attribute__ ((weak))
++kgdb_arch_remove_break(unsigned long addr, int type)
++{
++	return 0;
++}
++
++void __attribute__ ((weak))
++kgdb_correct_hw_break(void)
++{
++}
++
++void __attribute__ ((weak))
++kgdb_shadowinfo(struct pt_regs *regs, char *buffer, unsigned threadid)
++{
++}
++
++struct task_struct __attribute__ ((weak))
++*kgdb_get_shadow_thread(struct pt_regs *regs, int threadid)
++{
++	return NULL;
++}
++
++struct pt_regs __attribute__ ((weak))
++*kgdb_shadow_regs(struct pt_regs *regs, int threadid)
++{
++	return NULL;
++}
++
++static int hex(char ch)
 +{
 +	if ((ch >= 'a') && (ch <= 'f'))
 +		return (ch - 'a' + 10);
@@ -378,10 +463,8 @@
 +	return (-1);
 +}
 +
-+
 +/* scan for the sequence $<data>#<checksum>	*/
-+
-+void getpacket(char *buffer)
++static void getpacket(char *buffer)
 +{
 +	unsigned char checksum;
 +	unsigned char xmitcsum;
@@ -398,7 +481,7 @@
 +		count = 0;
 +
 +		/* now, read until a # or end of buffer is found */
-+		while (count < BUFMAX) {
++		while (count < (BUFMAX - 1)) {
 +			ch = kgdb_serial->read_char() & 0x7f;
 +			if (ch == '#')
 +				break;
@@ -430,15 +513,13 @@
 +				kgdb_serial->flush();
 +		}
 +	} while (checksum != xmitcsum);
-+
 +}
 +
-+
 +/*
 + * Send the packet in buffer.
 + * Check for gdb connection if asked for.
 + */
-+void putpacket(char *buffer, int checkconnect)
++static void putpacket(char *buffer, int checkconnect)
 +{
 +	unsigned char checksum;
 +	int count;
@@ -455,12 +536,6 @@
 +		send_count = 0;
 +
 +		while ((ch = buffer[count])) {
-+			if (kgdb_serial->chunksize &&
-+			    send_count >= kgdb_serial->chunksize) {
-+				if (kgdb_serial->flush)
-+					kgdb_serial->flush();
-+				send_count = 0;
-+			}
 +			kgdb_serial->write_char(ch);
 +			checksum += ch;
 +			count ++;
@@ -499,21 +574,60 @@
 +
 +}
 +
++static int get_char(char *addr, unsigned char *data)
++{
++	mm_segment_t fs;
++	int ret = 0;
++	
++	if (!kgdb_useraccess && (unsigned long)addr < TASK_SIZE) {
++		return -EINVAL;
++	}
++	wmb();
++	fs = get_fs();
++	set_fs(KERNEL_DS);
++	
++	if (get_user(*data, addr) != 0) {
++		ret = -EFAULT;
++	}
++	
++	set_fs(fs);
++	return ret;
++}
++
++static int set_char(char *addr, int data)
++{
++	mm_segment_t fs;
++	int ret = 0;
++	
++	if (!kgdb_useraccess && (unsigned long)addr < TASK_SIZE) {
++		return -EINVAL;
++	}
++	wmb();
++	fs = get_fs();
++	set_fs(KERNEL_DS);
++
++	if (put_user(data, addr) != 0) {
++		ret = -EFAULT;
++	}
++	
++	set_fs(fs);
++	return ret;
++}
++
 +/*
 + * convert the memory pointed to by mem into hex, placing result in buf
-+ * return a pointer to the last char put in buf (null)
-+ * If MAY_FAULT is non-zero, then we should set kgdb_memerr in response to
-+ * a fault; if zero treat a fault like any other fault in the stub.
++ * return a pointer to the last char put in buf (null). May return an error.
 + */
-+char *kgdb_mem2hex(char *mem, char *buf, int count, int can_fault)
++char *kgdb_mem2hex(char *mem, char *buf, int count)
 +{
 +	int i;
 +	unsigned char ch;
++	int error;
 +	
 +	for (i = 0; i < count; i++) {
 +
-+		if (get_char(mem++, &ch, can_fault) < 0) 
-+			break;
++		if ((error = get_char(mem++, &ch)) < 0)
++			return ERR_PTR(error);
 +		
 +		*buf++ = hexchars[ch >> 4];
 +		*buf++ = hexchars[ch % 16];
@@ -522,19 +636,22 @@
 +	return (buf);
 +}
 +
-+/* convert the hex array pointed to by buf into binary to be placed in mem 
*/
-+/* return a pointer to the character AFTER the last byte written */
-+
-+char *hex2mem(char *buf, char *mem, int count, int can_fault)
++/*
++ * convert the hex array pointed to by buf into binary to be placed in mem
++ * return a pointer to the character AFTER the last byte written
++ * May return an error.
++ */
++char *kgdb_hex2mem(char *buf, char *mem, int count)
 +{
 +	int i;
 +	unsigned char ch;
++	int error;
 +	
 +	for (i = 0; i < count; i++) {
 +		ch = hex(*buf++) << 4;
 +		ch = ch + hex(*buf++);
-+		if (set_char(mem++, ch, can_fault) < 0) 
-+			break;
++		if ((error = set_char(mem++, ch)) < 0) 
++			return ERR_PTR(error);
 +	}
 +	return (mem);
 +}
@@ -571,7 +688,19 @@
 +	return pkt;
 +}
 +
-+#define BUF_THREAD_ID_SIZE 16
++static inline void error_packet(char *pkt, int error)
++{
++	error = -error;
++	pkt[0] = 'E';
++	pkt[1] = hexchars[(error / 10)];
++	pkt[2] = hexchars[(error % 10)];
++	pkt[3] = '\0';
++}
++
++static void ok_packet(char *pkt)
++{
++	strcpy(pkt, "OK");
++}
 +
 +static char *pack_threadid(char *pkt, threadref *id)
 +{
@@ -613,7 +742,7 @@
 +		return NULL;
 +	}
 +	if (tid >= pid_max + num_online_cpus()) {
-+		return kgdb_ops->get_shadow_thread(regs, tid - pid_max -
++		return kgdb_get_shadow_thread(regs, tid - pid_max -
 +				num_online_cpus());
 +	}
 +	if (tid >= pid_max) {
@@ -658,8 +787,7 @@
 +	/* This has been taken from x86 kgdb implementation and
 +	 * will be needed by architectures that have SMP support
 +	 */
-+	if (kgdb_ops->correct_hw_break)
-+		kgdb_ops->correct_hw_break();
++	kgdb_correct_hw_break();
 +
 +	/* Signal the master processor that we are done */
 +	procindebug[processor] = 0;
@@ -668,34 +796,38 @@
 +}
 +#endif
 +
-+static void get_mem (char *addr, unsigned char *buf, int count)
++static int get_mem (char *addr, unsigned char *buf, int count)
 +{
++	int error;
 +	while (count) {
-+		if(get_char(addr++, buf, 1) <  0) 
-+			return;
++		if((error = get_char(addr++, buf)) <  0) 
++			return error;
 +		buf++;
 +		count--;
 +	}
++	return 0;
 +}
 +
-+static void set_mem (char *addr,unsigned char *buf, int count)
++static int set_mem (char *addr,unsigned char *buf, int count)
 +{
++	int error;
 +	while (count) {
-+		if (set_char(addr++,*buf++, 1) < 0) 
-+			return;
++		if ((error = set_char(addr++,*buf++)) < 0) 
++			return error;
 +		count--;
 +	}
++	return 0;
 +}
 +
 +static int set_break (unsigned long addr)
 +{
 +	int i, breakno = -1;
++	int error;
 +
 +	for (i = 0; i < MAX_BREAKPOINTS; i++) {
 +		if ((kgdb_break[i].state == bp_enabled) &&
 +		    (kgdb_break[i].bpt_addr == addr)) {
-+			breakno = -1;
-+			break;
++			return -EEXIST;
 +		}
 +
 +		if (kgdb_break[i].state == bp_disabled) {
@@ -704,17 +836,17 @@
 +		}
 +	}
 +	if (breakno == -1)
-+		return -1;
++		return -E2BIG;
 +
-+	get_mem((char *)addr, kgdb_break[breakno].saved_instr, BREAK_INSTR_SIZE);
-+	if (kgdb_memerr)
-+		return -1;
-+
-+	set_mem((char *)addr, kgdb_ops->gdb_bpt_instr, BREAK_INSTR_SIZE);
++	if ((error = get_mem((char *)addr, kgdb_break[breakno].saved_instr,
++				BREAK_INSTR_SIZE)) < 0)
++		return error;
++
++	if ((error = set_mem((char *)addr, kgdb_ops->gdb_bpt_instr,
++					BREAK_INSTR_SIZE)) < 0)
++		return error;
 +	flush_cache_range (current->mm, addr, addr + BREAK_INSTR_SIZE);
 +	flush_icache_range (addr, addr + BREAK_INSTR_SIZE);
-+	if (kgdb_memerr)
-+		return -1;
 +
 +	kgdb_break[breakno].state = bp_enabled;
 +	kgdb_break[breakno].type = bp_breakpoint;
@@ -726,31 +858,33 @@
 +static int remove_break (unsigned long addr)
 +{
 +	int i;
++	int error;
 +
 +	for (i=0; i < MAX_BREAKPOINTS; i++) {
 +		if ((kgdb_break[i].state == bp_enabled) &&
 +		   (kgdb_break[i].bpt_addr == addr)) {
-+			set_mem((char *)addr, kgdb_break[i].saved_instr,
-+			        BREAK_INSTR_SIZE);
++			if ((error =set_mem((char *)addr, kgdb_break[i].saved_instr,
++			        BREAK_INSTR_SIZE)) < 0)
++				return error;
 +			flush_cache_range (current->mm, addr, addr + BREAK_INSTR_SIZE);
 +			flush_icache_range (addr, addr + BREAK_INSTR_SIZE);
-+			if (kgdb_memerr)
-+				return -1;
 +			kgdb_break[i].state = bp_disabled;
 +			return 0;
 +		}
 +	}
-+	return -1;
++	return -ENOENT;
 +}
 +
 +int remove_all_break(void)
 +{
 +	int i;
++	int error;
 +	for (i=0; i < MAX_BREAKPOINTS; i++) {
 +		if(kgdb_break[i].state == bp_enabled) {
 +			unsigned long addr = kgdb_break[i].bpt_addr;
-+			set_mem((char *)addr, kgdb_break[i].saved_instr,
-+			       BREAK_INSTR_SIZE);
++			if ((error = set_mem((char *)addr, kgdb_break[i].saved_instr,
++			       BREAK_INSTR_SIZE)) < 0)
++				return error;
 +			flush_cache_range (current->mm, addr, addr + BREAK_INSTR_SIZE);
 +			flush_icache_range (addr, addr + BREAK_INSTR_SIZE);
 +		}
@@ -759,52 +893,6 @@
 +	return 0;
 +}
 +		
-+int get_char(char *addr, unsigned char *data, int can_fault)
-+{
-+	mm_segment_t fs;
-+	int ret = 0;
-+	
-+	kgdb_memerr = 0;
-+	
-+	if (can_fault)
-+		debugger_memerr_expected = 1;
-+	wmb();
-+	fs = get_fs();
-+	set_fs(KERNEL_DS);
-+	
-+	if (get_user(*data, addr) != 0) {
-+		ret = -EFAULT;
-+		kgdb_memerr = 1;
-+	}
-+	
-+	debugger_memerr_expected = 0;	
-+	set_fs(fs);
-+	return ret;
-+}
-+
-+int set_char(char *addr, int data, int can_fault)
-+{
-+	mm_segment_t fs;
-+	int ret = 0;
-+	
-+	kgdb_memerr = 0;
-+	
-+	if (can_fault)
-+		debugger_memerr_expected = 1;
-+	wmb();
-+	fs = get_fs();
-+	set_fs(KERNEL_DS);
-+
-+	if (put_user(data, addr) != 0) {
-+		ret = -EFAULT;
-+		kgdb_memerr = 1;
-+	}
-+	
-+	debugger_memerr_expected = 0;
-+	set_fs(fs);
-+	return ret;
-+}
-+
 +static inline int shadow_pid(int realpid)
 +{
 +	if (realpid) {
@@ -833,20 +921,16 @@
 +	threadref thref;
 +	struct task_struct *thread = NULL;
 +	unsigned procid;
-+	int ret = 0;
 +	static char tmpstr[256];
 +	int numshadowth = num_online_cpus() + kgdb_ops->shadowth;
 +	long kgdb_usethreadid = 0;
++	int error = 0;
 +
 +	/* Panic on recursive debugger calls. */
 +	if (atomic_read(&debugger_active) == smp_processor_id() + 1) {
 +		return 0;
 +	}
 +
-+	/* Grab interface locks first */
-+	if (kgdb_serial->begin_session)
-+		kgdb_serial->begin_session();
-+
 +	/* 
 +	 * Interrupts will be restored by the 'trap return' code, except when
 +	 * single stepping.
@@ -866,10 +950,8 @@
 +
 +	current->thread.debuggerinfo = linux_regs;
 +
-+	if (kgdb_ops->disable_hw_debug)
-+		kgdb_ops->disable_hw_debug(linux_regs);
-+	
-+	
++	kgdb_disable_hw_debug(linux_regs);
++
 +	for (i = 0; i < num_online_cpus(); i++) {
 +		spin_lock(&slavecpulocks[i]);
 +	}
@@ -878,33 +960,36 @@
 +	 * need one here */
 +	procindebug[smp_processor_id()] = 1;
 +
++	/* Clear the out buffer. */
++	memset(remcomOutBuffer, 0, sizeof(remcomOutBuffer));
++
 +	/* Master processor is completely in the debugger */
-+	if (kgdb_ops->post_master_code)
-+		kgdb_ops->post_master_code(linux_regs, exVector, err_code);
++	kgdb_post_master_code(linux_regs, exVector, err_code);
++
 +	if (atomic_read(&kgdb_killed_or_detached) &&
 +	    atomic_read(&kgdb_might_be_resumed)) {
 +		getpacket(remcomInBuffer);
 +		if(remcomInBuffer[0] == 'H' && remcomInBuffer[1] =='c') {
 +			remove_all_break();
 +			atomic_set(&kgdb_killed_or_detached, 0);
-+			remcomOutBuffer[0] = 'O';
-+			remcomOutBuffer[1] = 'K';
-+			remcomOutBuffer[2] = 0;
++			ok_packet(remcomOutBuffer);
 +		}
 +		else
 +			return 1;
-+	}
-+	else {
++	} else {
 +
 +		/* reply to host that an exception has occurred */
-+		remcomOutBuffer[0] = 'S';
-+		remcomOutBuffer[1] = hexchars[signo >> 4];
-+		remcomOutBuffer[2] = hexchars[signo % 16];
-+		remcomOutBuffer[3] = 'p';
-+
++		ptr = remcomOutBuffer;
++		*ptr++ = 'T';
++		*ptr++ = hexchars[(signo >> 4) % 16];
++		*ptr++ = hexchars[signo % 16];
++		ptr += strlen(strcpy(ptr, "thread:"));
 +		int_to_threadref(&thref, shadow_pid(current->pid));
-+		*pack_threadid(remcomOutBuffer + 4, &thref) = 0;
++		ptr = pack_threadid(ptr, &thref);
++		*ptr++ = ';';
++		*ptr = '\0';
 +	}		
++
 +	putpacket(remcomOutBuffer, 0);
 +	kgdb_connected = 1;
 +	
@@ -914,22 +999,17 @@
 +	while (1) {
 +		int bpt_type = 0;
 +		error = 0;
-+		remcomOutBuffer[0] = 0;
-+		remcomOutBuffer[1] = 0;
++
++		/* Clear the out buffer. */
++		memset(remcomOutBuffer, 0, sizeof(remcomOutBuffer));
++
 +		getpacket(remcomInBuffer);
 +
-+#if KGDB_DEBUG
-+		bust_spinlocks(1);
-+		printk("CPU%d pid%d GDB packet: %s\n", 
-+		       smp_processor_id(), current->pid, remcomInBuffer);
-+		bust_spinlocks(0);
-+#endif
 +		switch (remcomInBuffer[0]) {
 +		case '?':
 +			remcomOutBuffer[0] = 'S';
 +			remcomOutBuffer[1] = hexchars[signo >> 4];
 +			remcomOutBuffer[2] = hexchars[signo % 16];
-+			remcomOutBuffer[3] = 0;
 +			break;
 +
 +		case 'g':	/* return the value of the CPU registers */
@@ -943,99 +1023,88 @@
 +			   are in kgdb_wait, and thus have debuggerinfo. */
 +			   
 +			if (kgdb_usethreadid >= pid_max + num_online_cpus()) {
-+				kgdb_ops->regs_to_gdb_regs(gdb_regs,
-+					kgdb_ops->shadow_regs(linux_regs,
++				regs_to_gdb_regs(gdb_regs,
++					kgdb_shadow_regs(linux_regs,
 +						kgdb_usethreadid - pid_max -
 +						num_online_cpus()));
 +			} else if (thread->thread.debuggerinfo) {
-+				if (get_char(thread->thread.debuggerinfo,
-+					(unsigned char *)gdb_regs, 1)) {
-+					strcpy(remcomOutBuffer, "E10");
++				if ((error = get_char(thread->thread.debuggerinfo,
++					(unsigned char *)gdb_regs)) < 0) {
++					error_packet(remcomOutBuffer, error);
 +					break;
 +				}
-+				kgdb_ops->regs_to_gdb_regs(gdb_regs,
++				regs_to_gdb_regs(gdb_regs,
 +					(struct pt_regs *)
 +					thread->thread.debuggerinfo);
 +			} else {
 +				/* Pull stuff saved during 
 +				 * switch_to; nothing else is
-+				   accessible (or even particularly relevant).
-+				   This should be enough for a stack trace. */
-+				kgdb_ops->sleeping_thread_to_gdb_regs(gdb_regs, thread);
++				 * accessible (or even particularly relevant).
++				 * This should be enough for a stack trace. */
++				sleeping_thread_to_gdb_regs(gdb_regs, thread);
 +			}
 +				
-+			kgdb_mem2hex((char *) gdb_regs, remcomOutBuffer, NUMREGBYTES, 0);
++			kgdb_mem2hex((char *) gdb_regs, remcomOutBuffer, NUMREGBYTES);
 +			break;
 +
 +		case 'G':	/* set the value of the CPU registers - return OK */
-+			hex2mem(&remcomInBuffer[1], (char *) gdb_regs,
-+				NUMREGBYTES, 0);
++			kgdb_hex2mem(&remcomInBuffer[1], (char *) gdb_regs,
++				NUMREGBYTES);
 +				
 +			if (kgdb_usethread && kgdb_usethread != current)
-+				strcpy(remcomOutBuffer, "E00");
++				error_packet(remcomOutBuffer, -EINVAL);
 +			else {
-+				kgdb_ops->gdb_regs_to_regs(gdb_regs,
++				gdb_regs_to_regs(gdb_regs,
 +					(struct pt_regs *)
 +					current->thread.debuggerinfo);
-+				strcpy(remcomOutBuffer, "OK");
++				ok_packet(remcomOutBuffer);
 +			}
 +
 +			break;
 +
 +			/* mAA..AA,LLLL  Read LLLL bytes at address AA..AA */
 +		case 'm':
-+			/* TRY TO READ %x,%x.  IF SUCCEED, SET PTR = 0 */
 +			ptr = &remcomInBuffer[1];
-+			if (kgdb_hexToLong(&ptr, &addr) && *ptr++ == ',' &&
-+			    kgdb_hexToLong(&ptr, &length)) {
-+				ptr = 0;
-+				kgdb_mem2hex((char *) addr, remcomOutBuffer, length, 1);
-+				if (kgdb_memerr)
-+					strcpy(remcomOutBuffer, "E03");
-+					
-+			}
-+
-+			if (ptr) 
-+				strcpy(remcomOutBuffer, "E01");
++			if (kgdb_hexToLong(&ptr, &addr) > 0 && *ptr++ == ',' &&
++			    kgdb_hexToLong(&ptr, &length) > 0) {
++				if (IS_ERR(ptr = kgdb_mem2hex((char *) addr,
++							remcomOutBuffer,
++							length)))
++					error_packet(remcomOutBuffer,
++							PTR_ERR(ptr));
++			} else
++				error_packet(remcomOutBuffer, -EINVAL);
 +			break;
 +
 +		/* MAA..AA,LLLL: Write LLLL bytes at address AA.AA return OK */
 +		case 'M':
-+			/* TRY TO READ '%x,%x:'.  IF SUCCEED, SET PTR = 0 */
 +			ptr = &remcomInBuffer[1];
-+			if (kgdb_hexToLong(&ptr, &addr) && *(ptr++) == ',' && 
-+			    kgdb_hexToLong(&ptr, &length) && *(ptr++) == ':') {
-+				hex2mem(ptr, (char *)addr, length, 1);
-+				if (kgdb_memerr)
-+					strcpy(remcomOutBuffer, "E09");
-+				else
-+					strcpy(remcomOutBuffer, "OK");
-+				ptr = 0;
-+			}
-+			if (ptr) {
-+				strcpy(remcomOutBuffer, "E02");
-+			}
++			if (kgdb_hexToLong(&ptr, &addr) > 0 && *(ptr++) == ','
++				&& kgdb_hexToLong(&ptr, &length) > 0 &&
++				*(ptr++) == ':') {
++				if (IS_ERR(ptr = kgdb_hex2mem(ptr, (char *)addr,
++							length)))
++					error_packet(remcomOutBuffer,
++							PTR_ERR(ptr));
++			} else
++				error_packet(remcomOutBuffer, -EINVAL);
 +			break;
 +
-+			
-+			/* Continue and Single Step are Architecture specific
-+			 * and will not be handled by the generic code.
-+			 */
-+
-+
-+			/* kill the program. KGDB should treat this like a 
++			/* kill or detach. KGDB should treat this like a 
 +			 * continue.
 +			 */
 +		case 'D':
-+			remcomOutBuffer[0] = 'O';
-+			remcomOutBuffer[1] = 'K';
-+			remcomOutBuffer[2] = '\0';
-+			remove_all_break();
++			if ((error = remove_all_break()) < 0) {
++				error_packet(remcomOutBuffer, error);
++			} else {
++				ok_packet(remcomOutBuffer);
++				kgdb_connected = 0;
++			}
 +			putpacket(remcomOutBuffer, 0);
-+			kgdb_connected = 0;
 +			goto default_handle;
 +
 +		case 'k':
++			/* Don't care about error from remove_all_break */
 +			remove_all_break();
 +			kgdb_connected = 0;
 +			goto default_handle;
@@ -1047,7 +1116,8 @@
 +			case 'f':
 +				if (memcmp(remcomInBuffer+2, "ThreadInfo",10))
 +				{
-+					strcpy(remcomOutBuffer, "E04");
++					error_packet(remcomOutBuffer,
++							-EINVAL);
 +					break;
 +				}
 +				if (remcomInBuffer[1] == 'f') {
@@ -1055,9 +1125,10 @@
 +				}
 +				remcomOutBuffer[0] = 'm';
 +				ptr = remcomOutBuffer + 1;
-+				for (i = 0; i < 32 && threadid < pid_max + numshadowth;
-+						threadid++) {
-+					thread = getthread(linux_regs, threadid);
++				for (i = 0; i < 32 && threadid < pid_max +
++						numshadowth; threadid++) {
++					thread = getthread(linux_regs,
++							threadid);
 +					if (thread) {
 +						int_to_threadref(&thref,
 +								threadid);
@@ -1067,60 +1138,53 @@
 +						i++;
 +					}
 +				}
-+				*(--ptr) = '\0';
 +				break;
 +
 +			case 'C':
 +				/* Current thread id */
-+				remcomOutBuffer[0] = 'Q';
-+				remcomOutBuffer[1] = 'C';
++				strcpy(remcomOutBuffer, "QC");
 +
 +				threadid = shadow_pid(current->pid);
 +				
 +				int_to_threadref(&thref, threadid);
 +				pack_threadid(remcomOutBuffer + 2, &thref);
-+				remcomOutBuffer[18] = '\0';
 +				break;
 +
 +			case 'E':
 +				/* Print exception info */
-+				if (kgdb_ops->printexceptioninfo)
-+					kgdb_ops->printexceptioninfo(exVector,
-+                   			                       err_code,
-+					                       remcomOutBuffer);
++				kgdb_printexceptioninfo(exVector, err_code,
++						remcomOutBuffer);
 +				break;
 +			case 'T':
-+				if (memcmp(remcomInBuffer+1, "ThreadExtraInfo,",16))
++				if (memcmp(remcomInBuffer+1,
++					"ThreadExtraInfo,",16))
 +				{
-+					remcomOutBuffer[0] = 0;
-+					strcpy(remcomOutBuffer, "E05");
++					error_packet(remcomOutBuffer, -EINVAL);
 +					break;
 +				}
 +				threadid = 0;
 +				ptr = remcomInBuffer+17;
 +				kgdb_hexToLong(&ptr, &threadid);
 +				if (!getthread(linux_regs, threadid)) {
-+					sprintf(tmpstr, "invalid pid %d",
-+							(int) threadid);
-+					kgdb_mem2hex(tmpstr, remcomOutBuffer,
-+							strlen(tmpstr), 0);
++					error_packet(remcomOutBuffer, -EINVAL);
 +					break;
 +				}
 +				if (threadid < pid_max) {
-+					kgdb_mem2hex(getthread(linux_regs, threadid)->comm,
-+							remcomOutBuffer, 16, 0);
++					kgdb_mem2hex(getthread(linux_regs,
++						threadid)->comm,
++						remcomOutBuffer, 16);
 +				} else if (threadid >= pid_max +
 +						num_online_cpus()) {
-+					kgdb_ops->shadowinfo(linux_regs,
++					kgdb_shadowinfo(linux_regs,
 +						remcomOutBuffer,
 +						threadid - pid_max -
 +						num_online_cpus());
 +				} else {
-+					sprintf(tmpstr, "Shadow task %d for pid 0",
-+							(int)(threadid -
-+							      pid_max));
++					sprintf(tmpstr, "Shadow task %d"
++						" for pid 0",
++						(int)(threadid - pid_max));
 +					kgdb_mem2hex(tmpstr, remcomOutBuffer,
-+							strlen(tmpstr), 0);
++							strlen(tmpstr));
 +				}
 +				break;
 +			}
@@ -1134,15 +1198,12 @@
 +				kgdb_hexToLong(&ptr, &threadid);
 +				thread = getthread(linux_regs, threadid);
 +				if (!thread && threadid > 0) {
-+					remcomOutBuffer[0] = 'E';
-+					remcomOutBuffer[1] = '\0';
++					error_packet(remcomOutBuffer, -EINVAL);
 +					break;
 +				}
 +				kgdb_usethread = thread;
 +				kgdb_usethreadid = threadid;
-+				remcomOutBuffer[0] = 'O';
-+				remcomOutBuffer[1] = 'K';
-+				remcomOutBuffer[2] = '\0';
++				ok_packet(remcomOutBuffer);
 +				break;
 +
 +			case 'c':
@@ -1154,15 +1215,13 @@
 +				} else {
 +					thread = getthread(linux_regs, threadid);
 +					if (!thread && threadid > 0) {
-+						remcomOutBuffer[0] = 'E';
-+						remcomOutBuffer[1] = '\0';
++						error_packet(remcomOutBuffer,
++								-EINVAL);
 +						break;
 +					}
 +					kgdb_contthread = thread;
 +				}
-+				remcomOutBuffer[0] = 'O';
-+				remcomOutBuffer[1] = 'K';
-+				remcomOutBuffer[2] = '\0';
++				ok_packet(remcomOutBuffer);
 +				break;
 +			}
 +			break;
@@ -1172,20 +1231,16 @@
 +			ptr = &remcomInBuffer[1];
 +			kgdb_hexToLong(&ptr, &threadid);
 +			thread = getthread(linux_regs, threadid);
-+			if (thread) {
-+				remcomOutBuffer[0] = 'O';
-+				remcomOutBuffer[1] = 'K';
-+				remcomOutBuffer[2] = '\0';
-+			} else {
-+				remcomOutBuffer[0] = 'E';
-+				remcomOutBuffer[1] = '\0';
-+			}
++			if (thread)
++				ok_packet(remcomOutBuffer);
++			else
++				error_packet(remcomOutBuffer, -EINVAL);
 +			break;
 +		case 'z':
 +		case 'Z':
 +			ptr = &remcomInBuffer[2];
 +			if (*(ptr++) != ',') {
-+				strcpy(remcomOutBuffer, "E07");
++				error_packet(remcomOutBuffer, -EINVAL);
 +				break;
 +			}
 +			kgdb_hexToLong(&ptr, &addr);
@@ -1199,58 +1254,50 @@
 +				/* if set_break is not defined, then
 +				 * remove_break does not matter
 +				 */
-+				if(!kgdb_ops->set_break)
++				if(!(kgdb_ops->flags & KGDB_HW_BREAKPOINT))
 +					break;
 +			}
 +			
 +			if (remcomInBuffer[0] == 'Z') {
 +				if (bpt_type == bp_breakpoint)
-+					ret = set_break(addr);
++					error = set_break(addr);
 +				else
-+					ret = kgdb_ops->set_break(addr, bpt_type);
++					error = kgdb_arch_set_break(addr,
++							bpt_type);
 +			}
 +			else {
 +				if (bpt_type == bp_breakpoint)
-+					ret = remove_break(addr);
++					error = remove_break(addr);
 +				else
-+					ret = kgdb_ops->remove_break(addr, bpt_type);
++					error = kgdb_arch_remove_break(addr,
++							bpt_type);
 +			}
 +			
-+			if (ret == 0)
-+				strcpy(remcomOutBuffer, "OK");
++			if (error == 0)
++				ok_packet(remcomOutBuffer);
 +			else
-+				strcpy(remcomOutBuffer, "E08");
++				error_packet(remcomOutBuffer, error);
 +			
 +			break;
 +
 +		default:
 +		default_handle:
-+			ret = 0;
-+			if (kgdb_ops->handle_exception)
-+				ret= kgdb_ops->handle_exception(exVector, signo, 
-+				                             err_code,
-+				                             remcomInBuffer,
-+				                             remcomOutBuffer,
-+				                             linux_regs);
-+			if(ret >= 0 || remcomInBuffer[0] == 'D' ||
++			error = kgdb_arch_handle_exception(exVector, signo,
++					err_code, remcomInBuffer,
++					remcomOutBuffer, linux_regs);
++
++			if(error >= 0 || remcomInBuffer[0] == 'D' ||
 +			    remcomInBuffer[0] == 'k')
 +				goto kgdb_exit;
 +
 +
-+		}		/* switch */
-+#if KGDB_DEBUG
-+		bust_spinlocks(1);
-+		printk("Response to GDB: %s\n", remcomOutBuffer);
-+		bust_spinlocks(0);
-+#endif
++		} /* switch */
 +
 +		/* reply to the request */
 +		putpacket(remcomOutBuffer, 0);
 +	}
++
 +kgdb_exit:
-+	
-+	if(kgdb_ops->handler_exit)
-+		kgdb_ops->handler_exit();
 +	procindebug[smp_processor_id()] = 0;	
 +	
 +	for (i = 0; i < num_online_cpus(); i++) {
@@ -1275,11 +1322,7 @@
 +	atomic_set(&debugger_active, 0);
 +	local_irq_restore(flags);
 +
-+	/* Release interface locks */
-+	if (kgdb_serial->end_session)
-+		kgdb_serial->end_session();
-+	
-+	return ret;
++	return error;
 +}
 +
 +/*
@@ -1293,12 +1336,51 @@
 +	return 0;
 +}
 +
-+/* this function is used to set up exception handlers for tracing and
-+   breakpoints */
-+static void set_debug_traps(void)
++static struct notifier_block kgdb_module_load_nb = {
++	.notifier_call = module_event,
++};
++
++/* This function will generate a breakpoint exception.  It is used at the
++   beginning of a program to sync up with a debugger and can be used
++   otherwise as a quick means to stop program execution and "break" into
++   the debugger. */
++
++void breakpoint(void)
++{
++	if (!kgdb_initialized) {
++		kgdb_enter = 1;
++		kgdb_entry();
++		if (!kgdb_initialized) {
++			printk("kgdb not enabled. Cannot do breakpoint\n");
++			return;
++		}
++	}
++
++	atomic_set(&kgdb_setting_breakpoint, 1);
++	wmb();
++	BREAKPOINT();
++	wmb();
++	atomic_set(&kgdb_setting_breakpoint, 0);
++}
++
++void kgdb_nmihook(int cpu, void *regs)
++{
++#ifdef CONFIG_SMP
++	if (!procindebug[cpu] && atomic_read(&debugger_active) != (cpu + 1)) {
++		kgdb_wait((struct pt_regs *)regs);
++	}
++#endif
++}
++
++void kgdb_entry(void)
 +{
 +	int i;
 +	
++	if (kgdb_initialized) {
++		/* KGDB was initialized */
++		return;
++	}
++
 +	for (i = 0; i < KGDB_MAX_NO_CPUS; i++) 
 +		spin_lock_init(&slavecpulocks[i]);
 +
@@ -1314,81 +1396,32 @@
 +	for (i = 0; i < MAX_BREAKPOINTS; i++) 
 +		kgdb_break[i].state = bp_disabled;
 +
-+	
-+	/*
-+	 * In case GDB is started before us, ack any packets (presumably
-+	 * "$?#xx") sitting there.  */
-+	kgdb_serial->write_char('+');
-+
 +	linux_debug_hook = kgdb_handle_exception;
 +	
-+	if (kgdb_ops->kgdb_init)
-+		kgdb_ops->kgdb_init();
++	/* Let the arch do any initalization it needs to, including
++	 * pointing to a suitable early output device. */
++	kgdb_arch_init();
 +
 +	/* We can't do much if this fails */
 +	register_module_notifier(&kgdb_module_load_nb);
 +
-+	kgdb_initialized = 1;
-+
 +	atomic_set(&kgdb_setting_breakpoint, 0);
-+}
-+
-+/* This function will generate a breakpoint exception.  It is used at the
-+   beginning of a program to sync up with a debugger and can be used
-+   otherwise as a quick means to stop program execution and "break" into
-+   the debugger. */
-+
-+void breakpoint(void)
-+{
-+	if (kgdb_initialized) {
-+		atomic_set(&kgdb_setting_breakpoint, 1);
-+		wmb();
-+		BREAKPOINT();
-+		wmb();
-+		atomic_set(&kgdb_setting_breakpoint, 0);
-+	}
-+}
-+
-+void kgdb_nmihook(int cpu, void *regs)
-+{
-+#ifdef CONFIG_SMP
-+	if (!procindebug[cpu] && atomic_read(&debugger_active) != (cpu + 1)) {
-+		kgdb_wait((struct pt_regs *)regs);
-+	}
-+#endif
-+}
 +
-+void kgdb_entry(void)
-+{
-+	if (kgdb_initialized) {
-+		/* KGDB was initialized */
++	if (!kgdb_serial || kgdb_serial->hook() < 0) {
++		/* KGDB interface isn't ready yet */
 +		return;
 +	}
++	kgdb_initialized = 1;
 +	if (!kgdb_enter) {
 +		return;
 +	}
-+	if (!kgdb_serial) {
-+		printk("KGDB: no gdb interface available.\n"
-+		       "kgdb can't be enabled\n");
-+		return;
-+	}
-+	if (kgdb_serial->hook()) {
-+		/* KGDB interface isn't ready yet */
-+		return;
-+	}
-+	
-+	/*
-+	 * Call GDB routine to setup the exception vectors for the debugger
-+	 */
-+	set_debug_traps();
-+
 +	/*
 +	 * Call the breakpoint() routine in GDB to start the debugging
-+	 * session.
++	 * session
 +	 */
 +	printk(KERN_CRIT "Waiting for connection from remote gdb... ");
 +	breakpoint() ;
-+	printk(KERN_CRIT "Connected.\n");
++	printk("Connected.\n");
 +}
 +
 +#ifdef CONFIG_KGDB_CONSOLE
@@ -1497,9 +1530,9 @@
 +#endif
 +__setup("gdb", opt_gdb);
 +__setup("kgdbwait", opt_kgdb_enter);
-diff -Naurp linux-2.6.1/kernel/Makefile 
linux-2.6.1-kgdb-2.1.0-core/kernel/Makefile
---- linux-2.6.1/kernel/Makefile	2003-11-24 07:01:15.000000000 +0530
-+++ linux-2.6.1-kgdb-2.1.0-core/kernel/Makefile	2004-01-12 19:11:04.000000000 
+0530
+diff -Naurp linux-2.6.2/kernel/Makefile linux-2.6.2-kgdb-core/kernel/Makefile
+--- linux-2.6.2/kernel/Makefile	2003-11-24 07:01:15.000000000 +0530
++++ linux-2.6.2-kgdb-core/kernel/Makefile	2004-02-10 13:10:36.000000000 +0530
 @@ -19,6 +19,7 @@ obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
  obj-$(CONFIG_COMPAT) += compat.o
  obj-$(CONFIG_IKCONFIG) += configs.o
@@ -1508,9 +1541,9 @@
  
  ifneq ($(CONFIG_IA64),y)
  # According to Alan Modra <alan@linuxcare.com.au>, the 
-fno-omit-frame-pointer is
-diff -Naurp linux-2.6.1/kernel/module.c 
linux-2.6.1-kgdb-2.1.0-core/kernel/module.c
---- linux-2.6.1/kernel/module.c	2004-01-10 11:01:50.000000000 +0530
-+++ linux-2.6.1-kgdb-2.1.0-core/kernel/module.c	2004-01-12 19:11:04.000000000 
+0530
+diff -Naurp linux-2.6.2/kernel/module.c linux-2.6.2-kgdb-core/kernel/module.c
+--- linux-2.6.2/kernel/module.c	2004-02-10 13:01:30.000000000 +0530
++++ linux-2.6.2-kgdb-core/kernel/module.c	2004-02-10 13:10:36.000000000 +0530
 @@ -727,6 +727,11 @@ sys_delete_module(const char __user *nam
  	mod->state = MODULE_STATE_GOING;
  	restart_refcounts();
@@ -1523,7 +1556,7 @@
  	/* Never wait if forced. */
  	if (!forced && module_refcount(mod) != 0)
  		wait_for_zero_refcount(mod);
-@@ -1744,7 +1749,12 @@ sys_init_module(void __user *umod,
+@@ -1758,7 +1763,12 @@ sys_init_module(void __user *umod,
  	if (ret < 0) {
  		/* Init routine failed: abort.  Try to protect us from
                     buggy refcounters. */
@@ -1536,9 +1569,9 @@
  		synchronize_kernel();
  		if (mod->unsafe)
  			printk(KERN_ERR "%s: module is now stuck!\n",
-diff -Naurp linux-2.6.1/kernel/sched.c 
linux-2.6.1-kgdb-2.1.0-core/kernel/sched.c
---- linux-2.6.1/kernel/sched.c	2004-01-10 11:01:50.000000000 +0530
-+++ linux-2.6.1-kgdb-2.1.0-core/kernel/sched.c	2004-01-14 17:05:11.000000000 
+0530
+diff -Naurp linux-2.6.2/kernel/sched.c linux-2.6.2-kgdb-core/kernel/sched.c
+--- linux-2.6.2/kernel/sched.c	2004-02-10 13:01:30.000000000 +0530
++++ linux-2.6.2-kgdb-core/kernel/sched.c	2004-02-10 13:10:36.000000000 +0530
 @@ -37,6 +37,7 @@
  #include <linux/rcupdate.h>
  #include <linux/cpu.h>
@@ -1547,7 +1580,7 @@
  
  #ifdef CONFIG_NUMA
  #define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
-@@ -1470,7 +1471,7 @@ void scheduling_functions_start_here(voi
+@@ -1588,7 +1589,7 @@ void scheduling_functions_start_here(voi
  /*
   * schedule() is the main scheduler function.
   */
@@ -1556,7 +1589,7 @@
  {
  	long *switch_count;
  	task_t *prev, *next;
-@@ -1641,6 +1642,23 @@ int default_wake_function(wait_queue_t *
+@@ -1760,6 +1761,23 @@ int default_wake_function(wait_queue_t *
  
  EXPORT_SYMBOL(default_wake_function);
  
@@ -1580,7 +1613,7 @@
  /*
   * The core wakeup function.  Non-exclusive wakeups (nr_exclusive == 0) just
   * wake everything up.  If it's an exclusive wakeup (nr_exclusive == small 
+ve
-@@ -2851,6 +2869,8 @@ void __might_sleep(char *file, int line)
+@@ -2958,6 +2976,8 @@ void __might_sleep(char *file, int line)
  #if defined(in_atomic)
  	static unsigned long prev_jiffy;	/* ratelimiting */
  
@@ -1589,10 +1622,10 @@
  	if ((in_atomic() || irqs_disabled()) && system_running) {
  		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
  			return;
-diff -Naurp linux-2.6.1/Makefile linux-2.6.1-kgdb-2.1.0-core/Makefile
---- linux-2.6.1/Makefile	2004-01-10 11:01:35.000000000 +0530
-+++ linux-2.6.1-kgdb-2.1.0-core/Makefile	2004-01-12 19:11:05.000000000 +0530
-@@ -439,6 +439,8 @@ endif
+diff -Naurp linux-2.6.2/Makefile linux-2.6.2-kgdb-core/Makefile
+--- linux-2.6.2/Makefile	2004-02-10 13:01:22.000000000 +0530
++++ linux-2.6.2-kgdb-core/Makefile	2004-02-10 13:10:36.000000000 +0530
+@@ -440,6 +440,8 @@ endif
  
  ifndef CONFIG_FRAME_POINTER
  CFLAGS		+= -fomit-frame-pointer

