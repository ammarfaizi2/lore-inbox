Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbTIYQob (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 12:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbTIYQob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 12:44:31 -0400
Received: from tolkor.SGI.COM ([198.149.18.6]:9630 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S261426AbTIYQnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 12:43:49 -0400
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200309251643.h8PGhAiN177937@fsgi900.americas.sgi.com>
Subject: SGI linux 2.4 console driver patch - again ...
To: marcelo.tosatti@cyclades.com.br
Date: Thu, 25 Sep 2003 11:43:10 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry - I'll try again.

Most of this is code clean up-type things....




# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1121  -> 1.1122 
#	drivers/char/Config.in	1.57    -> 1.58   
#	drivers/char/sn_serial.c	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/25	pfg@attica.americas.sgi.com	1.1122
# Mods for 2.4 serial console driver - mostly code cleanup
# --------------------------------------------
#
diff -Nru a/drivers/char/Config.in b/drivers/char/Config.in
--- a/drivers/char/Config.in	Thu Sep 25 07:35:55 2003
+++ b/drivers/char/Config.in	Thu Sep 25 07:35:55 2003
@@ -104,11 +104,14 @@
        fi
      fi
   fi
-fi
-if [ "$CONFIG_IA64_GENERIC" = "y" -o "$CONFIG_IA64_SGI_SN2" = "y" ] ; then
-  bool 'SGI SN2 l1 serial port support' CONFIG_SGI_L1_SERIAL
-  if [ "$CONFIG_SGI_L1_SERIAL" = "y" ]; then
-    bool '  SGI SN2 l1 Console support' CONFIG_SGI_L1_SERIAL_CONSOLE
+  if [ "$CONFIG_IA64" = "y" ]; then
+    bool '  SGI SN2 l1 serial port support' CONFIG_SGI_L1_SERIAL
+    if [ "$CONFIG_SGI_L1_SERIAL" = "y" ]; then
+      bool '    SGI SN2 l1 Console support' CONFIG_SGI_L1_SERIAL_CONSOLE
+    fi
+    if [ "$CONFIG_IA64_GENERIC" = "y" -o "$CONFIG_IA64_SGI_SN2" = "y" ]; then
+      bool '  SGI SN2 IOC4 serial port support' CONFIG_SGI_IOC4_SERIAL
+    fi
   fi
 fi
 if [ "$CONFIG_EXPERIMENTAL" = "y" -a "$CONFIG_ZORRO" = "y" ]; then
diff -Nru a/drivers/char/sn_serial.c b/drivers/char/sn_serial.c
--- a/drivers/char/sn_serial.c	Thu Sep 25 07:35:55 2003
+++ b/drivers/char/sn_serial.c	Thu Sep 25 07:35:55 2003
@@ -38,27 +38,19 @@
  */
 
 #include <linux/config.h>
-#include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/tty.h>
 #include <linux/serial.h>
 #include <linux/console.h>
 #include <linux/module.h>
-#ifdef CONFIG_MAGIC_SYSRQ
 #include <linux/sysrq.h>
-#endif
-#include <linux/string.h>
 #include <linux/circ_buf.h>
 #include <linux/serial_reg.h>
-#include <asm/irq.h>
-#include <asm/system.h>
-#include <asm/io.h>
+#include <asm/uaccess.h>
 #include <asm/sn/sn_sal.h>
-#include <asm/sn/nodepda.h>
+#include <asm/sn/pci/pciio.h>		/* this is needed for get_console_nasid */
 #include <asm/sn/simulator.h>
-#include <asm/sn/sn2/intr.h>
 #include <asm/sn/sn2/sn_private.h>
-#include <asm/sn/clksupport.h>
 
 #if defined(CONFIG_SGI_L1_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 static char sysrq_serial_str[] = "\eSYS";
@@ -66,60 +58,53 @@
 static unsigned long sysrq_requested;
 #endif /* CONFIG_SGI_L1_SERIAL_CONSOLE && CONFIG_MAGIC_SYSRQ */
 
-static char *serial_revdate = "2003-07-31";
-
-/* driver subtype - what does this mean? */
-#define SN_SAL_SUBTYPE 1
-
 /* minor device number */
 #define SN_SAL_MINOR 64
 
+#define SN_SAL_SUBTYPE	1
+
 /* number of characters left in xmit buffer before we ask for more */
 #define WAKEUP_CHARS 128
 
 /* number of characters we can transmit to the SAL console at a time */
 #define SN_SAL_MAX_CHARS 120
 
-/* event types for our task queue -- so far just one */
 #define SN_SAL_EVENT_WRITE_WAKEUP 0
 
 #define CONSOLE_RESTART 1
 
+
 /* 64K, when we're asynch, it must be at least printk's LOG_BUF_LEN to
  * avoid losing chars, (always has to be a power of 2) */
-#if 1
 #define SN_SAL_BUFFER_SIZE (64 * (1 << 10))
-#else
-#define SN_SAL_BUFFER_SIZE (64)
-#endif
 
 #define SN_SAL_UART_FIFO_DEPTH 16
 #define SN_SAL_UART_FIFO_SPEED_CPS 9600/10
 
 /* we don't kmalloc/get_free_page these as we want them available
  * before either of those are initialized */
-static volatile char xmit_buff_mem[SN_SAL_BUFFER_SIZE];
+static char sn_xmit_buff_mem[SN_SAL_BUFFER_SIZE];
 
 struct volatile_circ_buf {
-	volatile char *buf;
-	int head;
-	int tail;
+	char *cb_buf;
+	int cb_head;
+	int cb_tail;
 };
 
-static volatile struct volatile_circ_buf xmit = { .buf = xmit_buff_mem };
-static char sal_tmp_buffer[SN_SAL_BUFFER_SIZE];
+static struct volatile_circ_buf xmit = { .cb_buf = sn_xmit_buff_mem };
+static char sn_tmp_buffer[SN_SAL_BUFFER_SIZE];
 
-static volatile struct tty_struct *sn_sal_tty;
+static struct tty_struct *sn_sal_tty;
 
 static struct timer_list sn_sal_timer;
 static int sn_sal_event; /* event type for task queue */
 static int sn_sal_refcount;
 
-static volatile int sn_sal_is_asynch;
-static volatile int sn_sal_irq;
+static int sn_sal_is_asynch;
+static int sn_sal_irq;
 static spinlock_t sn_sal_lock = SPIN_LOCK_UNLOCKED;
-static volatile int tx_count;
-static volatile int rx_count;
+static int sn_total_tx_count;
+static int sn_total_rx_count;
 
 static struct tty_struct *sn_sal_table;
 static struct termios *sn_sal_termios;
@@ -128,32 +113,63 @@
 static void sn_sal_tasklet_action(unsigned long data);
 static DECLARE_TASKLET(sn_sal_tasklet, sn_sal_tasklet_action, 0);
 
-static volatile unsigned long interrupt_timeout;
+static unsigned long sn_interrupt_timeout;
 
 extern u64 master_node_bedrock_address;
 
-int debug_printf(const char *fmt, ...);
+static int sn_debug_printf(const char *fmt, ...);
 
 #undef DEBUG
 #ifdef DEBUG
-#define DPRINTF(x...) debug_printf(x)
+#define DPRINTF(x...) sn_debug_printf(x)
 #else
 #define DPRINTF(x...) do { } while (0)
 #endif
 
-static void intr_transmit_chars(void);
-static void poll_transmit_chars(void);
-static int sn_sal_write(struct tty_struct *tty, int from_user,
-			const unsigned char *buf, int count);
-
 struct sn_sal_ops {
-	int (*puts)(const char *s, int len);
-	int (*getc)(void);
-	int (*input_pending)(void);
-	void (*wakeup_transmit)(void);
+	int (*sal_puts)(const char *s, int len);
+	int (*sal_getc)(void);
+	int (*sal_input_pending)(void);
+	void (*sal_wakeup_transmit)(void);
 };
 
-static volatile struct sn_sal_ops *sn_sal_ops;
+/* This is the pointer used. It is assigned to point to one of
+ * the tables below.
+ */
+static struct sn_sal_ops *sn_func;
+
+/* Prototypes */
+static int snt_hw_puts(const char *, int);
+static int snt_poll_getc(void);
+static int snt_poll_input_pending(void);
+static int snt_sim_puts(const char *, int);
+static int snt_sim_getc(void);
+static int snt_sim_input_pending(void);
+static int snt_intr_getc(void);
+static int snt_intr_input_pending(void);
+static void sn_intr_transmit_chars(void);
+
+/* A table for polling */
+static struct sn_sal_ops poll_ops = {
+	.sal_puts		= snt_hw_puts,
+	.sal_getc 		= snt_poll_getc,
+	.sal_input_pending	= snt_poll_input_pending
+};
+
+/* A table for the simulator */
+static struct sn_sal_ops sim_ops = {
+	.sal_puts		= snt_sim_puts,
+	.sal_getc		= snt_sim_getc,
+	.sal_input_pending	= snt_sim_input_pending
+};
+
+/* A table for interrupts enabled */
+static struct sn_sal_ops intr_ops = {
+	.sal_puts		= snt_hw_puts,
+	.sal_getc		= snt_intr_getc,
+	.sal_input_pending	= snt_intr_input_pending,
+	.sal_wakeup_transmit	= sn_intr_transmit_chars
+};
 
 
 /* the console does output in two distinctly different ways:
@@ -170,7 +186,8 @@
 
 /* routines for running the console in polling mode */
 
-static int hw_puts(const char *s, int len)
+static int
+snt_hw_puts(const char *s, int len)
 {
 	/* looking at the PROM source code, putb calls the flush
 	 * routine, so if we send characters in FIFO sized chunks, it
@@ -178,14 +195,16 @@
 	return ia64_sn_console_putb(s, len);
 }
 
-static int poll_getc(void)
+static int
+snt_poll_getc(void)
 {
 	int ch;
 	ia64_sn_console_getc(&ch);
 	return ch;
 }
 
-static int poll_input_pending(void)
+static int
+snt_poll_input_pending(void)
 {
 	int status, input;
 
@@ -193,16 +212,11 @@
 	return !status && input;
 }
 
-static struct sn_sal_ops poll_ops = {
-	.puts = hw_puts,
-	.getc = poll_getc,
-	.input_pending = poll_input_pending
-};
-
 
 /* routines for running the console on the simulator */
 
-static int sim_puts(const char *str, int count)
+static int
+snt_sim_puts(const char *str, int count)
 {
 	int counter = count;
 
@@ -223,65 +237,64 @@
 	return count;
 }
 
-static int sim_getc(void)
+static int
+snt_sim_getc(void)
 {
 	return readb(master_node_bedrock_address + (UART_RX << 3));
 }
 
-static int sim_input_pending(void)
+static int
+snt_sim_input_pending(void)
 {
 	return readb(master_node_bedrock_address + (UART_LSR << 3)) & UART_LSR_DR;
 }
 
-static struct sn_sal_ops sim_ops = {
-	.puts = sim_puts,
-	.getc = sim_getc,
-	.input_pending = sim_input_pending
-};
-
 
 /* routines for an interrupt driven console (normal) */
 
-static int intr_getc(void)
+static int
+snt_intr_getc(void)
 {
 	return ia64_sn_console_readc();
 }
 
-static int intr_input_pending(void)
+static int
+snt_intr_input_pending(void)
 {
 	return ia64_sn_console_intr_status() & SAL_CONSOLE_INTR_RECV;
 }
 
-static struct sn_sal_ops intr_ops = {
-	.puts = hw_puts,
-	.getc = intr_getc,
-	.input_pending = intr_input_pending,
-	.wakeup_transmit = intr_transmit_chars
-};
-
-extern void early_sn_setup(void);
+/* The early printk (possible setup) and function call */
 
 void
 early_printk_sn_sal(const char *s, unsigned count)
 {
-	if (!sn_sal_ops) {
+#if defined(CONFIG_IA64_EARLY_PRINTK_SGI_SN) || defined(CONFIG_IA64_SGI_SN_SIM)
+	extern void early_sn_setup(void);
+#endif
+
+	if (!sn_func) {
 		if (IS_RUNNING_ON_SIMULATOR())
-			sn_sal_ops = &sim_ops;
+			sn_func = &sim_ops;
 		else
-			sn_sal_ops = &poll_ops;
+			sn_func = &poll_ops;
 
+#if defined(CONFIG_IA64_EARLY_PRINTK_SGI_SN) || defined(CONFIG_IA64_SGI_SN_SIM)
 		early_sn_setup();
+#endif
 	}
-	sn_sal_ops->puts(s, count);
+	sn_func->sal_puts(s, count);
 }
 
 /* this is as "close to the metal" as we can get, used when the driver
  * itself may be broken */
-int debug_printf(const char *fmt, ...)
+static int
+sn_debug_printf(const char *fmt, ...)
 {
 	static char printk_buf[1024];
 	int printed_len;
 	va_list args;
+
 	va_start(args, fmt);
 	printed_len = vsnprintf(printk_buf, sizeof(printk_buf), fmt, args);
 	early_printk_sn_sal(printk_buf, printed_len);
@@ -289,7 +302,7 @@
 	return printed_len;
 }
 
-/*********************************************************************
+/*
  * Interrupt handling routines.
  */
 
@@ -300,29 +313,29 @@
 	tasklet_schedule(&sn_sal_tasklet);
 }
 
-/* receive_chars can be called before sn_sal_tty is initialized.  in
+/* sn_receive_chars can be called before sn_sal_tty is initialized.  in
  * that case, its only use is to trigger sysrq and kdb */
 static void
-receive_chars(struct pt_regs *regs)
+sn_receive_chars(struct pt_regs *regs, unsigned long *flags)
 {
 	int ch;
 
-	while (sn_sal_ops->input_pending()) {
-		ch = sn_sal_ops->getc();
+	while (sn_func->sal_input_pending()) {
+		ch = sn_func->sal_getc();
 		if (ch < 0) {
 			printk(KERN_ERR "sn_serial: An error occured while "
 			       "obtaining data from the console (0x%0x)\n", ch);
 			break;
 		}
-
 #if defined(CONFIG_SGI_L1_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 		if (sysrq_requested) {
 			unsigned long sysrq_timeout = sysrq_requested + HZ*5;
+
 			sysrq_requested = 0;
 			if (ch && time_before(jiffies, sysrq_timeout)) {
-				spin_unlock(&sn_sal_lock);
+				spin_unlock_irqrestore(&sn_sal_lock, *flags);
 				handle_sysrq(ch, regs, NULL, NULL);
-				spin_lock(&sn_sal_lock);
+				spin_lock_irqsave(&sn_sal_lock, *flags);
 				/* don't record this char */
 				continue;
 			}
@@ -344,11 +357,11 @@
 			if (sn_sal_tty->flip.count == TTY_FLIPBUF_SIZE)
 				break;
 		}
-		rx_count++;
+		sn_total_rx_count++;
 	}
 
 	if (sn_sal_tty)
-		tty_flip_buffer_push(sn_sal_tty);
+		tty_flip_buffer_push((struct tty_struct *)sn_sal_tty);
 }
 
 
@@ -360,43 +373,40 @@
 	int result;
 	char *start;
 
-	if (xmit.head == xmit.tail)
-		/* Nothing to do. */
-		return;
+	if (xmit.cb_head == xmit.cb_tail)
+		return; /* Nothing to do. */
 
-	head = xmit.head;
-	tail = xmit.tail;
-	start = &xmit.buf[tail];
+	head = xmit.cb_head;
+	tail = xmit.cb_tail;
+	start = &xmit.cb_buf[tail];
 
 	/* twice around gets the tail to the end of the buffer and
 	 * then to the head, if needed */
 	loops = (head < tail) ? 2 : 1;
 
 	for (ii = 0; ii < loops; ii++) {
-		xmit_count = (head < tail) ?
-			(SN_SAL_BUFFER_SIZE - tail) : (head - tail);
+		xmit_count = (head < tail) ?  (SN_SAL_BUFFER_SIZE - tail) : (head - tail);
 
 		if (xmit_count > 0) {
-			result = sn_sal_ops->puts(start, xmit_count);
+			result = sn_func->sal_puts((char *)start, xmit_count);
 			if (!result)
-				debug_printf("\n*** synch_flush_xmit failed to flush\n");
+				sn_debug_printf("\n*** synch_flush_xmit failed to flush\n");
 			if (result > 0) {
 				xmit_count -= result;
-				tx_count += result;
+				sn_total_tx_count += result;
 				tail += result;
 				tail &= SN_SAL_BUFFER_SIZE - 1;
-				xmit.tail = tail;
-				start = &xmit.buf[tail];
+				xmit.cb_tail = tail;
+				start = (char *)&xmit.cb_buf[tail];
 			}
 		}
 	}
-
 }
 
 /* must be called with a lock protecting the circular buffer and
  * sn_sal_tty */
 static void
-poll_transmit_chars(void)
+sn_poll_transmit_chars(void)
 {
 	int xmit_count, tail, head;
 	int result;
@@ -404,44 +414,40 @@
 
 	BUG_ON(!sn_sal_is_asynch);
 
-	if (xmit.head == xmit.tail ||
+	if (xmit.cb_head == xmit.cb_tail ||
 	    (sn_sal_tty && (sn_sal_tty->stopped || sn_sal_tty->hw_stopped))) {
 		/* Nothing to do. */
 		return;
 	}
 
-	head = xmit.head;
-	tail = xmit.tail;
-	start = &xmit.buf[tail];
+	head = xmit.cb_head;
+	tail = xmit.cb_tail;
+	start = &xmit.cb_buf[tail];
 
-	xmit_count = (head < tail) ?
-		(SN_SAL_BUFFER_SIZE - tail) : (head - tail);
+	xmit_count = (head < tail) ?  (SN_SAL_BUFFER_SIZE - tail) : (head - tail);
 
 	if (xmit_count == 0)
-		debug_printf("\n*** empty xmit_count\n");
+		sn_debug_printf("\n*** empty xmit_count\n");
 
-	if (xmit_count > SN_SAL_UART_FIFO_DEPTH)
-		xmit_count = SN_SAL_UART_FIFO_DEPTH;
-	
 	/* use the ops, as we could be on the simulator */
-	result = sn_sal_ops->puts(start, xmit_count);
+	result = sn_func->sal_puts((char *)start, xmit_count);
 	if (!result)
-		debug_printf("\n*** error in synchronous puts\n");
+		sn_debug_printf("\n*** error in synchronous sal_puts\n");
 	/* XXX chadt clean this up */
 	if (result > 0) {
 		xmit_count -= result;
-		tx_count += result;
+		sn_total_tx_count += result;
 		tail += result;
 		tail &= SN_SAL_BUFFER_SIZE - 1;
-		xmit.tail = tail;
-		start = &xmit.buf[tail];
+		xmit.cb_tail = tail;
+		start = &xmit.cb_buf[tail];
 	}
 
 	/* if there's few enough characters left in the xmit buffer
 	 * that we could stand for the upper layer to send us some
 	 * more, ask for it. */
 	if (sn_sal_tty)
-		if (CIRC_CNT(xmit.head, xmit.tail, SN_SAL_BUFFER_SIZE) < WAKEUP_CHARS)
+		if (CIRC_CNT(xmit.cb_head, xmit.cb_tail, SN_SAL_BUFFER_SIZE) < WAKEUP_CHARS)
 			sn_sal_sched_event(SN_SAL_EVENT_WRITE_WAKEUP);
 }
 
@@ -449,7 +455,7 @@
 /* must be called with a lock protecting the circular buffer and
  * sn_sal_tty */
 static void
-intr_transmit_chars(void)
+sn_intr_transmit_chars(void)
 {
 	int xmit_count, tail, head, loops, ii;
 	int result;
@@ -457,15 +463,15 @@
 
 	BUG_ON(!sn_sal_is_asynch);
 
-	if (xmit.head == xmit.tail ||
+	if (xmit.cb_head == xmit.cb_tail ||
 	    (sn_sal_tty && (sn_sal_tty->stopped || sn_sal_tty->hw_stopped))) {
 		/* Nothing to do. */
 		return;
 	}
 
-	head = xmit.head;
-	tail = xmit.tail;
-	start = &xmit.buf[tail];
+	head = xmit.cb_head;
+	tail = xmit.cb_tail;
+	start = &xmit.cb_buf[tail];
 
 	/* twice around gets the tail to the end of the buffer and
 	 * then to the head, if needed */
@@ -476,18 +482,18 @@
 			(SN_SAL_BUFFER_SIZE - tail) : (head - tail);
 
 		if (xmit_count > 0) {
-			result = ia64_sn_console_xmit_chars(start, xmit_count);
+			result = ia64_sn_console_xmit_chars((char *)start, xmit_count);
 #ifdef DEBUG
 			if (!result)
-				debug_printf("`");
+				sn_debug_printf("`");
 #endif
 			if (result > 0) {
 				xmit_count -= result;
-				tx_count += result;
+				sn_total_tx_count += result;
 				tail += result;
 				tail &= SN_SAL_BUFFER_SIZE - 1;
-				xmit.tail = tail;
-				start = &xmit.buf[tail];
+				xmit.cb_tail = tail;
+				start = &xmit.cb_buf[tail];
 			}
 		}
 	}
@@ -496,7 +502,7 @@
 	 * that we could stand for the upper layer to send us some
 	 * more, ask for it. */
 	if (sn_sal_tty)
-		if (CIRC_CNT(xmit.head, xmit.tail, SN_SAL_BUFFER_SIZE) < WAKEUP_CHARS)
+		if (CIRC_CNT(xmit.cb_head, xmit.cb_tail, SN_SAL_BUFFER_SIZE) < WAKEUP_CHARS)
 			sn_sal_sched_event(SN_SAL_EVENT_WRITE_WAKEUP);
 }
 
@@ -508,13 +514,14 @@
 	 * SAL, since it doesn't intercept the UART interrupts
 	 * itself */
 	int status = ia64_sn_console_intr_status();
+	unsigned long flags;
 
-	spin_lock(&sn_sal_lock);
+	spin_lock_irqsave(&sn_sal_lock, flags);
 	if (status & SAL_CONSOLE_INTR_RECV)
-		receive_chars(regs);
+		sn_receive_chars(regs, &flags);
 	if (status & SAL_CONSOLE_INTR_XMIT)
-		intr_transmit_chars();
-	spin_unlock(&sn_sal_lock);
+		sn_intr_transmit_chars();
+	spin_unlock_irqrestore(&sn_sal_lock, flags);
 }
 
 
@@ -539,17 +546,15 @@
 	}
 
 	console_nasid = ia64_sn_get_console_nasid();
-	intr_cpuid = NODEPDA(NASID_TO_COMPACT_NODEID(console_nasid))
-		->node_first_cpu;
+	intr_cpuid = NODEPDA(NASID_TO_COMPACT_NODEID(console_nasid))->node_first_cpu;
 	intr_cpuloc = cpu_physical_id(intr_cpuid);
 	console_irq = CPU_VECTOR_TO_IRQ(intr_cpuloc, SGI_UART_VECTOR);
 
-	result = intr_connect_level(intr_cpuid, SGI_UART_VECTOR,
-				    0 /*not used*/, 0 /*not used*/);
+	result = intr_connect_level(intr_cpuid, SGI_UART_VECTOR, 0 /*not used*/, 0 /*not used*/);
 	BUG_ON(result != SGI_UART_VECTOR);
 
-	result = request_irq(console_irq, sn_sal_interrupt,
-			     SA_INTERRUPT,  "SAL console driver", &sn_sal_tty);
+	result = request_irq(console_irq, sn_sal_interrupt, SA_INTERRUPT,
+		       			"SAL console driver", &sn_sal_tty);
 	if (result >= 0)
 		return console_irq;
 
@@ -557,11 +562,6 @@
 	return 0;
 }
 
-/*
- * End of the interrupt routines.
- *********************************************************************/
-
-
 static void
 sn_sal_tasklet_action(unsigned long data)
 {
@@ -569,13 +569,14 @@
 
 	if (sn_sal_tty) {
 		spin_lock_irqsave(&sn_sal_lock, flags);
-		if (sn_sal_tty)
+		if (sn_sal_tty) {
 			if (test_and_clear_bit(SN_SAL_EVENT_WRITE_WAKEUP, &sn_sal_event)) {
-				if ((sn_sal_tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
-				    sn_sal_tty->ldisc.write_wakeup)
-					(sn_sal_tty->ldisc.write_wakeup)(sn_sal_tty);
-				wake_up_interruptible(&sn_sal_tty->write_wait);
+				if ((sn_sal_tty->flags & (1 << TTY_DO_WRITE_WAKEUP))
+							&& sn_sal_tty->ldisc.write_wakeup)
+					(sn_sal_tty->ldisc.write_wakeup)((struct tty_struct *)sn_sal_tty);
+				wake_up_interruptible((wait_queue_head_t *)&sn_sal_tty->write_wait);
 			}
+		}
 		spin_unlock_irqrestore(&sn_sal_lock, flags);
 	}
 }
@@ -587,12 +588,14 @@
 static void
 sn_sal_timer_poll(unsigned long dummy)
 {
+	unsigned long flags;
+
 	if (!sn_sal_irq) {
-		spin_lock(&sn_sal_lock);
-		receive_chars(NULL);
-		poll_transmit_chars();
-		spin_unlock(&sn_sal_lock);
-		mod_timer(&sn_sal_timer, jiffies + interrupt_timeout);
+		spin_lock_irqsave(&sn_sal_lock, flags);
+		sn_receive_chars(NULL, &flags);
+		sn_poll_transmit_chars();
+		spin_unlock_irqrestore(&sn_sal_lock, flags);
+		mod_timer(&sn_sal_timer, jiffies + sn_interrupt_timeout);
 	}
 }
 
@@ -604,15 +607,10 @@
 	local_irq_save(flags);
 	sn_sal_interrupt(0, NULL, NULL);
 	local_irq_restore(flags);
-	mod_timer(&sn_sal_timer, jiffies + interrupt_timeout);
+	mod_timer(&sn_sal_timer, jiffies + sn_interrupt_timeout);
 }
 
 /*
- * End of "sofware interrupt" routines.
- *********************************************************************/
-
-
-/*********************************************************************
  * User-level console routines
  */
 
@@ -639,7 +637,7 @@
 static void
 sn_sal_close(struct tty_struct *tty, struct file * filp)
 {
-	if (atomic_read(&tty->count) == 1) {
+	if (tty->count == 1) {
 		unsigned long flags;
 		tty->closing = 1;
 		if (tty->driver.flush_buffer)
@@ -664,7 +662,7 @@
 	if (from_user) {
 		while (1) {
 			int c1;
-			c = CIRC_SPACE_TO_END(xmit.head, xmit.tail,
+			c = CIRC_SPACE_TO_END(xmit.cb_head, xmit.cb_tail,
 					      SN_SAL_BUFFER_SIZE);
 
 			if (count < c)
@@ -672,7 +670,7 @@
 			if (c <= 0)
 				break;
 
-			c -= copy_from_user(sal_tmp_buffer, buf, c);
+			c -= copy_from_user(sn_tmp_buffer, buf, c);
 			if (!c) {
 				if (!ret)
 					ret = -EFAULT;
@@ -683,14 +681,13 @@
 			 * moved since the last time we looked.
 			 */
 			spin_lock_irqsave(&sn_sal_lock, flags);
-			c1 = CIRC_SPACE_TO_END(xmit.head, xmit.tail,
-					       SN_SAL_BUFFER_SIZE);
+			c1 = CIRC_SPACE_TO_END(xmit.cb_head, xmit.cb_tail, SN_SAL_BUFFER_SIZE);
 
 			if (c1 < c)
 				c = c1;
 
-			memcpy(xmit.buf + xmit.head, sal_tmp_buffer, c);
-			xmit.head = ((xmit.head + c) & (SN_SAL_BUFFER_SIZE - 1));
+			memcpy(xmit.cb_buf + xmit.cb_head, sn_tmp_buffer, c);
+			xmit.cb_head = ((xmit.cb_head + c) & (SN_SAL_BUFFER_SIZE - 1));
 			spin_unlock_irqrestore(&sn_sal_lock, flags);
 
 			buf += c;
@@ -699,20 +696,19 @@
 		}
 	} else {
 		/* The buffer passed in isn't coming from userland,
-		 * so cut out the middleman (sal_tmp_buffer).
+		 * so cut out the middleman (sn_tmp_buffer).
 		 */
 		spin_lock_irqsave(&sn_sal_lock, flags);
 		while (1) {
-			c = CIRC_SPACE_TO_END(xmit.head, xmit.tail,
-					      SN_SAL_BUFFER_SIZE);
+			c = CIRC_SPACE_TO_END(xmit.cb_head, xmit.cb_tail, SN_SAL_BUFFER_SIZE);
 
 			if (count < c)
 				c = count;
 			if (c <= 0) {
 				break;
 			}
-			memcpy(xmit.buf + xmit.head, buf, c);
-			xmit.head = ((xmit.head + c) & (SN_SAL_BUFFER_SIZE - 1));
+			memcpy(xmit.cb_buf + xmit.cb_head, buf, c);
+			xmit.cb_head = ((xmit.cb_head + c) & (SN_SAL_BUFFER_SIZE - 1));
 			buf += c;
 			count -= c;
 			ret += c;
@@ -721,10 +717,9 @@
 	}
 
 	spin_lock_irqsave(&sn_sal_lock, flags);
-	if (xmit.head != xmit.tail &&
-	    !(tty && (tty->stopped || tty->hw_stopped)))
-		if (sn_sal_ops->wakeup_transmit)
-			sn_sal_ops->wakeup_transmit();
+	if (xmit.cb_head != xmit.cb_tail && !(tty && (tty->stopped || tty->hw_stopped)))
+		if (sn_func->sal_wakeup_transmit)
+			sn_func->sal_wakeup_transmit();
 	spin_unlock_irqrestore(&sn_sal_lock, flags);
 
 	return ret;
@@ -737,10 +732,11 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&sn_sal_lock, flags);
-	if (CIRC_SPACE(xmit.head, xmit.tail, SN_SAL_BUFFER_SIZE) != 0) {
-		xmit.buf[xmit.head] = ch;
-		xmit.head = (xmit.head + 1) & (SN_SAL_BUFFER_SIZE-1);
-		sn_sal_ops->wakeup_transmit();
+	if (CIRC_SPACE(xmit.cb_head, xmit.cb_tail, SN_SAL_BUFFER_SIZE) != 0) {
+		xmit.cb_buf[xmit.cb_head] = ch;
+		xmit.cb_head = (xmit.cb_head + 1) & (SN_SAL_BUFFER_SIZE-1);
+		if ( sn_func->sal_wakeup_transmit )
+			sn_func->sal_wakeup_transmit();
 	}
 	spin_unlock_irqrestore(&sn_sal_lock, flags);
 }
@@ -752,9 +748,9 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&sn_sal_lock, flags);
-	if (CIRC_CNT(xmit.head, xmit.tail, SN_SAL_BUFFER_SIZE))
-		if (sn_sal_ops->wakeup_transmit)
-			sn_sal_ops->wakeup_transmit();
+	if (CIRC_CNT(xmit.cb_head, xmit.cb_tail, SN_SAL_BUFFER_SIZE))
+		if (sn_func->sal_wakeup_transmit)
+			sn_func->sal_wakeup_transmit();
 	spin_unlock_irqrestore(&sn_sal_lock, flags);
 }
 
@@ -766,7 +762,7 @@
 	int space;
 
 	spin_lock_irqsave(&sn_sal_lock, flags);
-	space = CIRC_SPACE(xmit.head, xmit.tail, SN_SAL_BUFFER_SIZE);
+	space = CIRC_SPACE(xmit.cb_head, xmit.cb_tail, SN_SAL_BUFFER_SIZE);
 	spin_unlock_irqrestore(&sn_sal_lock, flags);
 	return space;
 }
@@ -779,23 +775,13 @@
 	int space;
 
 	spin_lock_irqsave(&sn_sal_lock, flags);
-	space = CIRC_CNT(xmit.head, xmit.tail, SN_SAL_BUFFER_SIZE);
+	space = CIRC_CNT(xmit.cb_head, xmit.cb_tail, SN_SAL_BUFFER_SIZE);
 	DPRINTF("<%d>", space);
 	spin_unlock_irqrestore(&sn_sal_lock, flags);
 	return space;
 }
 
 
-static int
-sn_sal_ioctl(struct tty_struct *tty, struct file *file,
-	       unsigned int cmd, unsigned long arg)
-{
-	/* nothing supported */
-
-	return -ENOIOCTLCMD;
-}
-
-
 static void
 sn_sal_flush_buffer(struct tty_struct *tty)
 {
@@ -803,13 +789,12 @@
 
 	/* drop everything */
 	spin_lock_irqsave(&sn_sal_lock, flags);
-	xmit.head = xmit.tail = 0;
+	xmit.cb_head = xmit.cb_tail = 0;
 	spin_unlock_irqrestore(&sn_sal_lock, flags);
 
 	/* wake up tty level */
 	wake_up_interruptible(&tty->write_wait);
-	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
-	    tty->ldisc.write_wakeup)
+	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) && tty->ldisc.write_wakeup)
 		(tty->ldisc.write_wakeup)(tty);
 }
 
@@ -841,11 +826,10 @@
 {
 	int len = 0;
 	off_t	begin = 0;
-	extern nasid_t get_console_nasid(void);
 
-	len += sprintf(page, "sn_serial: revision:%s nasid:%d irq:%d tx:%d rx:%d\n",
-		       serial_revdate, get_console_nasid(), sn_sal_irq,
-		       tx_count, rx_count);
+	len += sprintf(page, "sn_serial: nasid:%d irq:%d tx:%d rx:%d\n",
+		       snia_get_console_nasid(), sn_sal_irq,
+		       sn_total_tx_count, sn_total_rx_count);
 	*eof = 1;
 
 	if (off >= len+begin)
@@ -857,39 +841,38 @@
 
 
 static struct tty_driver sn_sal_driver = {
-	.magic = TTY_DRIVER_MAGIC,
-	.driver_name = "sn_serial",
+	.magic		= TTY_DRIVER_MAGIC,
+	.driver_name	= "sn_serial",
 #if defined(CONFIG_DEVFS_FS)
-	.name = "tts/%d",
+	.name		= "tts/%d",
 #else
-	.name = "ttyS",
+	.name		= "ttyS",
 #endif
-	.major = TTY_MAJOR,
-	.minor_start = SN_SAL_MINOR,
-	.num = 1,
-	.type = TTY_DRIVER_TYPE_SERIAL,
-	.subtype = SN_SAL_SUBTYPE,
-	.flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS,
-	.refcount = &sn_sal_refcount,
-	.table = &sn_sal_table,
-	.termios = &sn_sal_termios,
+	.major		= TTY_MAJOR,
+	.minor_start	= SN_SAL_MINOR,
+	.num		= 1,
+	.type		= TTY_DRIVER_TYPE_SERIAL,
+	.subtype	= SN_SAL_SUBTYPE,
+	.flags		= TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS,
+	.refcount	= &sn_sal_refcount,
+	.table		= &sn_sal_table,
+	.termios	= &sn_sal_termios,
 	.termios_locked = &sn_sal_termios_locked,
 
-	.open = sn_sal_open,
-	.close = sn_sal_close,
-	.write = sn_sal_write,
-	.put_char = sn_sal_put_char,
-	.flush_chars = sn_sal_flush_chars,
-	.write_room = sn_sal_write_room,
+	.open		= sn_sal_open,
+	.close		= sn_sal_close,
+	.write		= sn_sal_write,
+	.put_char	= sn_sal_put_char,
+	.flush_chars	= sn_sal_flush_chars,
+	.write_room	= sn_sal_write_room,
 	.chars_in_buffer = sn_sal_chars_in_buffer,
-	.ioctl = sn_sal_ioctl,
-	.hangup = sn_sal_hangup,
+	.hangup		= sn_sal_hangup,
 	.wait_until_sent = sn_sal_wait_until_sent,
-	.read_proc = sn_sal_read_proc,
+	.read_proc	= sn_sal_read_proc,
 };
 
 /* sn_sal_init wishlist:
- * - allocate sal_tmp_buffer
+ * - allocate sn_tmp_buffer
  * - fix up the tty_driver struct
  * - turn on receive interrupts
  * - do any termios twiddling once and for all
@@ -902,19 +885,21 @@
 static void __init
 sn_sal_switch_to_asynch(void)
 {
-	debug_printf("sn_serial: about to switch to asynchronous console\n");
+	unsigned long flags;
+
+	sn_debug_printf("sn_serial: about to switch to asynchronous console\n");
 
 	/* without early_printk, we may be invoked late enough to race
 	 * with other cpus doing console IO at this point, however
 	 * console interrupts will never be enabled */
-	spin_lock(&sn_sal_lock);
+	spin_lock_irqsave(&sn_sal_lock, flags);
 
 	/* early_printk invocation may have done this for us */
-	if (!sn_sal_ops) {
+	if (!sn_func) {
 		if (IS_RUNNING_ON_SIMULATOR())
-			sn_sal_ops = &sim_ops;
+			sn_func = &sim_ops;
 		else
-			sn_sal_ops = &poll_ops;
+			sn_func = &poll_ops;
 	}
 
 	/* we can't turn on the console interrupt (as request_irq
@@ -926,17 +911,17 @@
 	sn_sal_timer.function = sn_sal_timer_poll;
 
 	if (IS_RUNNING_ON_SIMULATOR())
-		interrupt_timeout = 6;
-	else
+		sn_interrupt_timeout = 6;
+	else {
 		/* 960cps / 16 char FIFO = 60HZ 
-		   HZ / (SN_SAL_FIFO_SPEED_CPS / SN_SAL_FIFO_DEPTH) */
-		interrupt_timeout = HZ * SN_SAL_UART_FIFO_DEPTH / 
-			SN_SAL_UART_FIFO_SPEED_CPS;
-
-	mod_timer(&sn_sal_timer, jiffies + interrupt_timeout);
+		 * HZ / (SN_SAL_FIFO_SPEED_CPS / SN_SAL_FIFO_DEPTH) */
+		sn_interrupt_timeout = HZ * SN_SAL_UART_FIFO_DEPTH
+					/ SN_SAL_UART_FIFO_SPEED_CPS;
+	}
+	mod_timer(&sn_sal_timer, jiffies + sn_interrupt_timeout);
 
 	sn_sal_is_asynch = 1;
-	spin_unlock(&sn_sal_lock);
+	spin_unlock_irqrestore(&sn_sal_lock, flags);
 }
 
 static void __init
@@ -944,17 +929,19 @@
 {
 	int irq;
 
-	debug_printf("sn_serial: switching to interrupt driven console\n");
+	sn_debug_printf("sn_serial: switching to interrupt driven console\n");
 
 	irq = sn_sal_connect_interrupt();
 	if (irq) {
 		unsigned long flags;
 		spin_lock_irqsave(&sn_sal_lock, flags);
+
 		/* sn_sal_irq is a global variable.  When it's set to
 		 * a non-zero value, we stop polling for input (since
 		 * interrupts should now be enabled). */
 		sn_sal_irq = irq;
-		sn_sal_ops = &intr_ops;
+		sn_func = &intr_ops;
+
 		/* turn on receive interrupts */
 		ia64_sn_console_intr_enable(SAL_CONSOLE_INTR_RECV);
 
@@ -965,9 +952,9 @@
 		if (CONSOLE_RESTART) {
 			/* kick the console every once in a while in
 			 * case we miss an interrupt */
-			interrupt_timeout = 20*HZ;
+			sn_interrupt_timeout = 20*HZ;
 			sn_sal_timer.function = sn_sal_timer_restart;
-			mod_timer(&sn_sal_timer, jiffies + interrupt_timeout);
+			mod_timer(&sn_sal_timer, jiffies + sn_interrupt_timeout);
 		}
 		spin_unlock_irqrestore(&sn_sal_lock, flags);
 	}
@@ -989,8 +976,7 @@
 	if (!sn_sal_is_asynch)
 		sn_sal_switch_to_asynch();
 
-	/* at this point (module_init) we can try to turn on
-	 * interrupts */
+	/* at this point (module_init) we can try to turn on interrupts */
 	if (!IS_RUNNING_ON_SIMULATOR())
 	    sn_sal_switch_to_interrupts();
 
@@ -1011,26 +997,14 @@
 static void __exit
 sn_sal_module_exit(void)
 {
-	unsigned long flags;
-	int e;
-
 	del_timer_sync(&sn_sal_timer);
-	spin_lock_irqsave(&sn_sal_lock, flags);
-	if ((e = tty_unregister_driver(&sn_sal_driver)))
-		printk(KERN_ERR "sn_serial: failed to unregister driver (%d)\n", e);
-
-	spin_unlock_irqrestore(&sn_sal_lock, flags);
+	tty_unregister_driver(&sn_sal_driver);
 }
 
 module_init(sn_sal_module_init);
 module_exit(sn_sal_module_exit);
 
 /*
- * End of user-level console routines.
- *********************************************************************/
-
-
-/*********************************************************************
  * Kernel console definitions
  */
 
@@ -1042,24 +1016,33 @@
 static void
 sn_sal_console_write(struct console *co, const char *s, unsigned count)
 {
-	BUG_ON(!sn_sal_is_asynch);
+	unsigned long flags;
 
-	if (count > CIRC_SPACE_TO_END(xmit.head, xmit.tail,
+	if (count > CIRC_SPACE_TO_END(xmit.cb_head, xmit.cb_tail,
 				      SN_SAL_BUFFER_SIZE))
-		debug_printf("\n*** SN_SAL_BUFFER_SIZE too small, lost chars\n");
+		sn_debug_printf("\n*** SN_SAL_BUFFER_SIZE too small, lost chars\n");
 
 	/* somebody really wants this output, might be an
 	 * oops, kdb, panic, etc.  make sure they get it. */
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 	if (spin_is_locked(&sn_sal_lock)) {
 		synch_flush_xmit();
-		sn_sal_ops->puts(s, count);
-	} else if (in_interrupt()) {
-		spin_lock(&sn_sal_lock);
-		synch_flush_xmit();
-		spin_unlock(&sn_sal_lock);
-		sn_sal_ops->puts(s, count);
+		sn_func->sal_puts(s, count);
 	} else
+#endif
+	if (in_interrupt()) {
+		spin_lock_irqsave(&sn_sal_lock, flags);
+		synch_flush_xmit();
+		spin_unlock_irqrestore(&sn_sal_lock, flags);
+		sn_func->sal_puts(s, count);
+	} else {
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 		sn_sal_write(NULL, 0, s, count);
+#else
+		synch_flush_xmit();
+		sn_func->sal_puts(s, count);
+#endif
+	}
 }
 
 static kdev_t
@@ -1076,17 +1059,12 @@
 
 
 static struct console sal_console = {
-	.name = "ttyS",
-	.write = sn_sal_console_write,
-	.device = sn_sal_console_device,
-	.setup = sn_sal_console_setup,
-	.index = -1
+	.name	= "ttyS",
+	.write	= sn_sal_console_write,
+	.device	= sn_sal_console_device,
+	.setup	= sn_sal_console_setup,
+	.index	= -1
 };
-
-/*
- * End of kernel console definitions.
- *********************************************************************/
-
 
 void __init
 sn_sal_serial_console_init(void)
