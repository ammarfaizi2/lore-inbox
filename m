Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263517AbUDEXbx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 19:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbUDEXbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 19:31:53 -0400
Received: from ip68-230-241-29.sd.sd.cox.net ([68.230.241.29]:19118 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S263517AbUDEXbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 19:31:01 -0400
Date: Mon, 5 Apr 2004 16:30:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: kgdb-bugreport@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>, ganzinger@mvista.com
Subject: [KGDB] Make kgdb get in sync with it's I/O drivers for the breakpoint
Message-ID: <20040405233058.GV31152@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  The following interdiff, vs current kgdb-2 CVS makes kgdb core
and I/O drivers get in sync in order to cause a breakpoint.  This kills
off the init/main.c change, and makes way for doing things much earlier,
if other support exists.  What would be left, tangentally, is some sort
of queue to register with, so we can handle the case of KGDBOE on a
pcmcia card.  George? Amit? Comments ?

--- linux-2.6.5/include/linux/debugger.h	2004-04-05 10:03:11.429663281 -0700
+++ linux-2.6.5/include/linux/debugger.h	2004-04-05 16:09:43.006246583 -0700
@@ -30,12 +30,6 @@
 	kgdb_nmihook(cpu, regs);
 }
 
-void kgdb_entry(void);
-static inline void debugger_entry(void)
-{
-	kgdb_entry();
-}
-
 extern int debugger_step;
 extern atomic_t debugger_active;
 
@@ -55,11 +49,6 @@
 	/* Do nothing */
 }
 
-static inline void debugger_entry(void)
-{
-	/* Do nothing */
-}
-
 #define debugger_step 0
 static const atomic_t debugger_active = { 0 };
 
--- linux-2.6.5/include/linux/kgdb.h	2004-04-05 10:03:11.429663281 -0700
+++ linux-2.6.5/include/linux/kgdb.h	2004-04-05 16:09:43.007246355 -0700
@@ -101,6 +94,7 @@
 /* Thread reference */
 typedef unsigned char threadref[8];
 
+/* Interface stuff. */
 struct kgdb_serial {
 	int (*read_char) (void);
 	void (*write_char) (int);
@@ -111,10 +105,12 @@
 extern struct kgdb_serial *kgdb_serial;
 extern struct kgdb_arch arch_kgdb_ops;
 extern int kgdb_initialized;
+extern int kgdb_break_early;
 
 struct uart_port;
 
 extern void kgdb8250_add_port(int i, struct uart_port *serial_req);
+extern int init_kgdboe(void);
 
 int kgdb_hex2long(char **ptr, long *longValue);
 char *kgdb_mem2hex(char *mem, char *buf, int count);
--- linux-2.6.5/init/main.c	2004-04-05 10:03:11.430663060 -0700
+++ linux-2.6.5.orig/init/main.c	2004-04-03 20:36:25.000000000 -0700
@@ -42,7 +42,6 @@
 #include <linux/cpu.h>
 #include <linux/efi.h>
 #include <linux/unistd.h>
-#include <linux/debugger.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -604,7 +603,6 @@
 
 	smp_init();
 	do_basic_setup();
-	debugger_entry();
 
 	prepare_namespace();
 
--- linux-2.6.5/kernel/kgdb.c	2004-04-05 10:51:40.772168280 -0700
+++ linux-2.6.5/kernel/kgdb.c	2004-04-05 16:21:16.982056111 -0700
@@ -41,6 +41,7 @@
 #include <linux/spinlock.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
+#include <linux/threads.h>
 #include <asm/system.h>
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>
@@ -63,8 +64,8 @@
 int kgdb_initialized = 0;
 volatile int kgdb_connected;
 
-/* If non-zero, wait for a gdb connection when kgdb_entry is called */
-int kgdb_enter = 0;
+/* If set to 1, then we want to cause a breakpoint ASAP. */
+int kgdb_break_early;
 
 /* Set to 1 to make kgdb allow access to user addresses. Can be set from gdb
  * also at runtime. */
@@ -1061,29 +1062,28 @@
 	.notifier_call = module_event,
 };
 
-/* This function will generate a breakpoint exception.  It is used at the
-   beginning of a program to sync up with a debugger and can be used
-   otherwise as a quick means to stop program execution and "break" into
-   the debugger. */
+/*
+ * Sometimes we need to schedule a breakpoint because we can't break
+ * right where we are.
+ */
+static int kgdb_need_breakpoint[NR_CPUS];
 
-void breakpoint(void)
+void kgdb_schedule_breakpoint(void)
 {
-	if (!kgdb_initialized) {
-		kgdb_enter = 1;
-		kgdb_entry();
-		if (!kgdb_initialized) {
-			printk("kgdb not enabled. Cannot do breakpoint\n");
-			return;
-		}
-	}
+	kgdb_need_breakpoint[smp_processor_id()] = 1;
+}
 
-	atomic_set(&kgdb_setting_breakpoint, 1);
-	wmb();
-	BREAKPOINT();
-	wmb();
-	atomic_set(&kgdb_setting_breakpoint, 0);
+void kgdb_process_breakpoint(void)
+{
+	/*
+	 * Handle a breakpoint queued from inside network driver code
+	 * to avoid reentrancy issues
+	 */
+	if (kgdb_serial && kgdb_need_breakpoint[smp_processor_id()]) {
+		kgdb_need_breakpoint[smp_processor_id()] = 0;
+		breakpoint();
+	}
 }
-EXPORT_SYMBOL(breakpoint);
 
 void kgdb_nmihook(int cpu, void *regs)
 {
@@ -1094,7 +1094,7 @@
 #endif
 }
 
-void kgdb_entry(void)
+static void kgdb_entry(void)
 {
 	int i;
 
@@ -1103,76 +1103,85 @@
 		return;
 	}
 
-	for (i = 0; i < KGDB_MAX_NO_CPUS; i++)
+	for (i = 0; i < NR_CPUS; i++)
 		spin_lock_init(&slavecpulocks[i]);
 
-	/* Free debugger_active */
-	atomic_set(&debugger_active, 0);
-
 	for (i = 0; i < MAX_BREAKPOINTS; i++)
 		kgdb_break[i].state = bp_disabled;
 
 	linux_debug_hook = kgdb_handle_exception;
 
-	/* Let the arch do any initalization it needs to, including
-	 * pointing to a suitable early output device. */
+	/* Let the arch do any initalization it needs do. */
 	kgdb_arch_init();
 
+	/* Ethernet might be ready now */
+#ifdef CONFIG_KGDB_ETH
+	if (!kgdb_serial)
+		init_kgdboe();
+#endif
+	if (!kgdb_serial || kgdb_serial->hook() < 0) {
+		/* KGDB interface isn't ready yet */
+		return;
+	}
+
 	/* We can't do much if this fails */
 	register_module_notifier(&kgdb_module_load_nb);
 
+	/* Clear things. */
+	atomic_set(&debugger_active, 0);
 	atomic_set(&kgdb_setting_breakpoint, 0);
+	kgdb_break_early = 0;
+	memset(kgdb_need_breakpoint, 0, sizeof(kgdb_need_breakpoint));
 
-	if (!kgdb_serial || kgdb_serial->hook() < 0) {
-		/* KGDB interface isn't ready yet */
-		return;
-	}
 	kgdb_initialized = 1;
-	if (!kgdb_enter) {
-		return;
-	}
-	/*
-	 * Call the breakpoint() routine in GDB to start the debugging
-	 * session
-	 */
-	printk(KERN_CRIT "Waiting for connection from remote gdb... ");
-	breakpoint();
-	printk("Connected.\n");
 }
 
 /*
- * Sometimes we need to schedule a breakpoint because we can't break
- * right where we are.
+ * This function will generate a breakpoint exception.  It is used at the
+ * beginning of a program to sync up with a debugger and can be used
+ * otherwise as a quick means to stop program execution and "break" into
+ * the debugger.
  */
-static int kgdb_need_breakpoint[NR_CPUS];
-
-void kgdb_schedule_breakpoint(void)
+void breakpoint(void)
 {
-	kgdb_need_breakpoint[smp_processor_id()] = 1;
+	if (!kgdb_initialized) {
+		kgdb_entry();
+		if (!kgdb_initialized) {
+			printk(KERN_CRIT "KGDB cannot initialize, cannot "
+					"performa breakpoint.\n");
+			return;
+		} else
+			printk(KERN_CRIT "Waiting for connection from remote "
+					"gdb...\n");
+	}
+
+	atomic_set(&kgdb_setting_breakpoint, 1);
+	wmb();
+	BREAKPOINT();
+	wmb();
+	atomic_set(&kgdb_setting_breakpoint, 0);
 }
+EXPORT_SYMBOL(breakpoint);
 
-void kgdb_process_breakpoint(void)
+static int __init opt_kgdb_enter(char *str)
 {
 	/*
-	 * Handle a breakpoint queued from inside network driver code
-	  * to avoid reentrancy issues
+	 * We want to break in early.  If kgdb_serial is set, we break now.
+	 * Otherwise we say we want to break early.
 	 */
-	if (kgdb_need_breakpoint[smp_processor_id()]) {
-		 kgdb_need_breakpoint[smp_processor_id()] = 0;
-		 breakpoint();
+	if (kgdb_serial)
+		breakpoint();
+	else {
+		kgdb_break_early = 1;
+		kgdb_schedule_breakpoint();
 	}
-}
 
-static int __init opt_kgdb_enter(char *str)
-{
-	kgdb_enter = 1;
-	return 1;
+	return 0;
 }
 
 static int __init opt_gdb(char *str)
 {
-	kgdb_enter = 1;
-	return 1;
+	return opt_kgdb_enter(str);
 }
 
 /*
--- linux-2.6.5/drivers/net/kgdb_eth.c	2004-04-05 10:52:26.642563102 -0700
+++ linux-2.6.5/drivers/net/kgdb_eth.c	2004-04-05 16:11:41.671220810 -0700
@@ -38,7 +38,7 @@
 static char in_buf[IN_BUF_SIZE], out_buf[OUT_BUF_SIZE];
 static int in_head, in_tail, out_count;
 static atomic_t in_count;
-int kgdboe = 0;			/* Default to tty mode */
+static int configured;
 
 static void rx_hook(struct netpoll *np, int port, char *msg, int len);
 
@@ -50,9 +50,8 @@
 	.remote_port = 6442,
 	.remote_mac = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
 };
-static int configured;
 
-int eth_getDebugChar(void)
+static int eth_getDebugChar(void)
 {
 	int chr;
 
@@ -65,7 +64,7 @@
 	return chr;
 }
 
-void eth_flushDebugChar(void)
+static void eth_flushDebugChar(void)
 {
 	if (out_count && np.dev) {
 		netpoll_send_udp(&np, out_buf, out_count);
@@ -74,7 +73,7 @@
 	}
 }
 
-void eth_putDebugChar(int chr)
+static void eth_putDebugChar(int chr)
 {
 	out_buf[out_count++] = chr;
 	if (out_count == OUT_BUF_SIZE)
@@ -110,18 +109,18 @@
 	}
 }
 
+/* We must be passed configuration options. */
 static int option_setup(char *opt)
 {
 	configured = !netpoll_parse_options(&np, opt);
-	return !configured;
+	return 0;
 }
-
 __setup("kgdboe=", option_setup);
 
 static int hook(void)
 {
-	/* Un-initalized, don't go further. */
-	if (kgdboe != 1)
+	/* We haven't been configured, giveup. */
+	if (!configured)
 		return 1;
 
 	netpoll_set_trap(1);
@@ -138,14 +137,13 @@
 
-static int init_kgdboe(void)
+int init_kgdboe(void)
 {
 	if (!configured || netpoll_setup(&np))
 		return 1;
 
-	kgdb_serial = &kgdbeth_serial;
-	kgdboe = 1;
+	if (!kgdb_serial)
+		kgdb_serial = &kgdbeth_serial;
 	printk(KERN_INFO "kgdb: debugging over ethernet enabled\n");
 
 	return 0;
 }
-
 module_init(init_kgdboe);
--- linux-2.6.5/drivers/serial/kgdb_8250.c	2004-04-05 10:52:22.332559676 -0700
+++ linux-2.6.5/drivers/serial/kgdb_8250.c	2004-04-05 16:09:43.134217369 -0700
@@ -90,15 +90,19 @@
 /* Do we need to look in the rs_table? */
 static int serial_from_rs_table = 0;
 
+/* If 1, then we can hook up our interrupt handler. */
+static int kgdb8250_can_hookup_irq;
+
 static void (*serial_outb) (unsigned char val, unsigned long addr);
 static unsigned long (*serial_inb) (unsigned long addr);
 
 int serial8250_release_irq(int irq);
 
+static int kgdb8250_local_init(void);
 static int kgdb8250_init(void);
 static unsigned long kgdb8250_port;
 
-static int initialized = -1;
+static int initialized;
 
 static unsigned long
 direct_inb(unsigned long addr)
@@ -317,10 +321,15 @@
 	return 0;
 }
 
-int
-kgdb_hook_io(void)
+/*
+ * Perform static initalization tasks which we need to always do,
+ * even if KGDB isn't going to be invoked immediately.
+ */
+static int
+kgdb8250_local_init(void)
 {
-	int retval;
+	if (initialized)
+		return 0;
 
 	/* Setup any serial port information we may need to */
 #ifdef CONFIG_KGDB_SIMPLE_SERIAL
@@ -361,6 +370,38 @@
 	gdb_async_info.line = gdb_async_info.state->irq = CONFIG_KGDB_IRQ;
 #endif
 
+	/* If someone haven't set kgdb_serial, do that. */
+	if (!kgdb_serial)
+		kgdb_serial = &kgdb8250_serial_driver;
+
+	return 0;
+}
+module_init(kgdb8250_local_init);
+
+/*
+ * Hookup our IRQ line, once we sanely can.
+ */
+static int __init kgdb8250_hookup_irq(void)
+{
+	if (initialized)
+		request_irq(gdb_async_info.line, kgdb8250_interrupt,
+			SA_INTERRUPT, "GDB-stub", NULL);
+	else
+		kgdb8250_can_hookup_irq = 1;
+
+	return 0;
+}
+module_init(kgdb8250_hookup_irq);
+
+int
+kgdb_hook_io(void)
+{
+	/* If we've already been initialized, return. */
+	if (initialized)
+		return 0;
+
+	kgdb8250_local_init();
+
 #ifdef CONFIG_SERIAL_8250
 	if (serial8250_release_irq(gdb_async_info.line))
 		return -1;
@@ -369,12 +410,10 @@
 	if (kgdb8250_init() == -1)
 		return -1;
 
-	retval = request_irq(gdb_async_info.line, kgdb8250_interrupt,
-			     SA_INTERRUPT, "GDB-stub", NULL);
-	if (retval == 0)
-		initialized = 1;
-	else
-		initialized = 0;
+	initialized = 1;
+
+	if (kgdb8250_can_hookup_irq)
+		kgdb8250_hookup_irq();
 
 	return 0;
 }
@@ -402,7 +441,6 @@
  * Syntax for this cmdline option is
  * kgdb8250=ttyno,baudrate
  */
-
 static int __init
 kgdb8250_opt(char *str)
 {
@@ -424,11 +462,14 @@
 
 	kgdb_serial = &kgdb8250_serial_driver;
 
-	return 1;
+	if (kgdb_break_early)
+		breakpoint();
 
-      errout:
-	printk("Invalid syntax for option kgdb8250=\n");
 	return 0;
+
+      errout:
+	printk(KERN_ERR "Invalid syntax for option kgdb8250=\n");
+	return 1;
 }
 
 __setup("kgdb8250=", kgdb8250_opt);

-- 
Tom Rini
http://gate.crashing.org/~trini/
