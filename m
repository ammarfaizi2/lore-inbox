Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265025AbTF1AfQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 20:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265023AbTF1AfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 20:35:16 -0400
Received: from zok.sgi.com ([204.94.215.101]:26754 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S265055AbTF1Ach (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 20:32:37 -0400
To: torvalds@transmeta.com
Subject: [PATCH] SGI SN2 serial console driver
Cc: linux-kernel@vger.kernel.org
From: Chad Talbott <chadt@sgi.com>
Date: 27 Jun 2003 17:46:46 -0700
Message-ID: <6eoel1fdo5l.fsf@sgi.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Here is a driver for the SGI SN2 (Altix, http://www.sgi.com/altix )
serial console.  It uses SAL calls to do it's work, so it is not based
on the core UART code.  I've included a hunk for the MAINTAINERS file
since I will be looking after it.

Thanks,
Chad


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=console-driver-2.5.diff

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1341  -> 1.1343 
#	drivers/char/Kconfig	1.14    -> 1.15   
#	         MAINTAINERS	1.148   -> 1.149  
#	drivers/char/Makefile	1.58    -> 1.59   
#	               (new)	        -> 1.13    drivers/char/sn_serial.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/26	chadt@tomahawk.engr.sgi.com	1.1342
# Add sn_serial.c driver
# --------------------------------------------
# 03/06/27	chadt@tomahawk.engr.sgi.com	1.1343
# Port SGI SN2 console driver to 2.5
# --------------------------------------------
#
diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	Fri Jun 27 17:37:36 2003
+++ b/MAINTAINERS	Fri Jun 27 17:37:36 2003
@@ -1626,6 +1626,12 @@
 W:	http://www.weinigel.se
 S:	Supported
 
+SGI SN-IA64 (Altix) SERIAL CONSOLE DRIVER
+P:	Chad Talbott
+M:	chadt@sgi.com
+L:	linux-ia64@vger.kernel.org
+S:	Supported
+
 SGI VISUAL WORKSTATION 320 AND 540
 P:	Andrey Panin
 M:	pazke@orbita1.ru
diff -Nru a/drivers/char/Kconfig b/drivers/char/Kconfig
--- a/drivers/char/Kconfig	Fri Jun 27 17:37:36 2003
+++ b/drivers/char/Kconfig	Fri Jun 27 17:37:36 2003
@@ -391,6 +391,22 @@
 	  If you have an Alchemy AU1000 processor (MIPS based) and you want
 	  to use a console on a serial port, say Y.  Otherwise, say N.
 
+config SGI_L1_SERIAL
+	bool "SGI SN2 L1 serial port support"
+	depends on SERIAL_NONSTANDARD && IA64
+	help
+	  If you have an SGI SN2 and you want to use the serial port
+	  connected to the system controller (you want this!), say Y.
+	  Otherwise, say N.
+
+config SGI_L1_SERIAL_CONSOLE
+	bool "SGI SN2 L1 serial console support"
+	depends on SGI_L1_SERIAL
+	help
+	  If you have an SGI SN2 and you would like to use the system
+	  controller serial port as your console (you want this!), 
+	  say Y.  Otherwise, say N.
+
 config QTRONIX_KEYBOARD
 	bool "Enable Qtronix 990P Keyboard Support"
 	depends on IT8712
diff -Nru a/drivers/char/Makefile b/drivers/char/Makefile
--- a/drivers/char/Makefile	Fri Jun 27 17:37:36 2003
+++ b/drivers/char/Makefile	Fri Jun 27 17:37:36 2003
@@ -41,6 +41,7 @@
 obj-$(CONFIG_SERIAL_TX3912) += generic_serial.o serial_tx3912.o
 obj-$(CONFIG_HVC_CONSOLE) += hvc_console.o
 obj-$(CONFIG_RAW_DRIVER) += raw.o
+obj-$(CONFIG_SGI_L1_SERIAL) += sn_serial.o
 
 obj-$(CONFIG_PRINTER) += lp.o
 obj-$(CONFIG_TIPAR) += tipar.o
diff -Nru a/drivers/char/sn_serial.c b/drivers/char/sn_serial.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/char/sn_serial.c	Fri Jun 27 17:37:36 2003
@@ -0,0 +1,870 @@
+/*
+ * C-Brick Serial Port (and console) driver for SGI Altix machines.
+ *
+ * This driver is NOT suitable for talking to the l1-controller for
+ * anything other than 'console activities' --- please use the l1
+ * driver for that.
+ *
+ *
+ * Copyright (c) 2003 Silicon Graphics, Inc.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program with
+ * other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Contact information:  Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
+ * Mountain View, CA  94043, or:
+ *
+ * http://www.sgi.com
+ *
+ * For further information regarding this notice, see:
+ *
+ * http://oss.sgi.com/projects/GenInfo/NoticeExplan
+ */
+
+
+
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/console.h>
+#include <linux/module.h>
+#ifdef CONFIG_MAGIC_SYSRQ
+#include <linux/sysrq.h>
+#endif
+#include <linux/circ_buf.h>
+#include <asm/irq.h>
+#include <asm/system.h>
+#include <asm/sn/sn_sal.h>
+#include <asm/sn/nodepda.h>
+#include <asm/sn/simulator.h>
+#include <asm/sn/sn2/intr.h>
+#include <asm/sn/sn2/sn_private.h>
+#include <asm/sn/uart16550.h>
+
+#if defined(CONFIG_SGI_L1_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+static char sysrq_serial_str[] = "\eSYS";
+static char *sysrq_serial_ptr = sysrq_serial_str;
+static unsigned long sysrq_requested;
+#endif	/* CONFIG_SGI_L1_SERIAL_CONSOLE && CONFIG_MAGIC_SYSRQ */
+
+static char *serial_name = "SGI SN SAL Console Serial driver";
+static char *serial_version = "1.0";
+static char *serial_revdate = "2003-03-17";
+
+static struct tty_driver *sn_sal_driver;
+static struct tty_struct *sn_sal_tty;
+static struct console sal_console;
+static struct circ_buf xmit;
+static struct timer_list sn_sal_timer_list;
+static int sn_sal_event; /* event type for task queue */
+static char *sal_tmp_buffer;
+static int sn_sal_irq;
+static spinlock_t sn_sal_lock;
+static int tx_count;
+static int rx_count;
+
+static struct termios *sn_sal_termios;
+static struct termios *sn_sal_termios_locked;
+
+static void sn_sal_tasklet_action(unsigned long data);
+static DECLARE_TASKLET(sn_sal_tasklet, sn_sal_tasklet_action, 0);
+
+/* driver subtype - what does this mean? */
+#define SN_SAL_SUBTYPE 1
+
+/* minor device number */
+#define SN_SAL_MINOR 64
+
+/* number of characters left in xmit buffer before we ask for more */
+#define WAKEUP_CHARS 256
+
+/* number of characters we can transmit to the SAL console at a time */
+#define SN_SAL_MAX_CHARS 120
+
+/* event types for our task queue -- so far just one */
+#define SN_SAL_EVENT_WRITE_WAKEUP	0
+
+#define CONSOLE_RESTART 1
+
+#define RESTART_TIMEOUT	20*HZ
+#define POLL_TIMEOUT	2*HZ/100
+
+static unsigned long interrupt_timeout;
+
+/*
+ * sim_write() - general purpose console func when running the simulator
+ */
+
+static inline int
+sim_write(const char *str, int count)
+{
+	extern u64 master_node_bedrock_address;
+	void early_sn_setup(void);
+	int counter = count;
+
+	if (!master_node_bedrock_address)
+		early_sn_setup();
+
+	if (master_node_bedrock_address) {
+#ifdef FLAG_DIRECT_CONSOLE_WRITES
+		/* This is an easy way to pre-pend the output to know whether the output
+ 		 * was done via sal or directly */
+		writeb('[', (unsigned long)master_node_bedrock_address + (REG_DAT << 3));
+		writeb('+', (unsigned long)master_node_bedrock_address + (REG_DAT << 3));
+		writeb(']', (unsigned long)master_node_bedrock_address + (REG_DAT << 3));
+		writeb(' ', (unsigned long)master_node_bedrock_address + (REG_DAT << 3));
+#endif	/* FLAG_DIRECT_CONSOLE_WRITES */
+		while (counter > 0) {
+			writeb(*str, (unsigned long)master_node_bedrock_address + (REG_DAT << 3));
+			counter--;
+			str++;
+		}
+	}
+	return count;
+}
+
+/*********************************************************************
+ *
+ * Interrupt handling routines.  Individual subroutines are declared
+ * as inline and folded into sn_sal_interrupt.
+ */
+
+static inline void
+sn_sal_sched_event(int event)
+{
+	sn_sal_event |= (1 << event);
+	tasklet_schedule(&sn_sal_tasklet);
+}
+
+
+static inline void
+receive_chars(struct tty_struct *tty, int *status, struct pt_regs *regs)
+{
+	int ch;
+
+	do {
+		if (IS_RUNNING_ON_SIMULATOR()) {
+			extern u64 master_node_bedrock_address;
+			ch = readb((unsigned long)master_node_bedrock_address + (REG_DAT << 3));
+		} else {
+			if (sn_sal_irq) {
+				ch = ia64_sn_console_readc();
+			} else {
+				if (ia64_sn_console_getc(&ch))
+					break;
+			}
+		}
+
+#if defined(CONFIG_SGI_L1_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+		if (sysrq_requested) {
+			unsigned long sysrq_timeout = sysrq_requested + HZ*5;
+			sysrq_requested = 0;
+			if (ch && time_before(jiffies, sysrq_timeout)) {
+				handle_sysrq(ch, regs, tty);
+				goto ignore_char;
+			}
+		}
+		if (ch == *sysrq_serial_ptr) {
+			if (!(*++sysrq_serial_ptr)) {
+				sysrq_requested = jiffies;
+				sysrq_serial_ptr = sysrq_serial_str;
+			}
+		} else
+			sysrq_serial_ptr = sysrq_serial_str;
+#endif	/* CONFIG_SGI_L1_SERIAL_CONSOLE && CONFIG_MAGIC_SYSRQ */
+
+		*tty->flip.char_buf_ptr = ch;
+		tty->flip.char_buf_ptr++;
+		tty->flip.count++;
+		rx_count++;
+
+#if defined(CONFIG_SGI_L1_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+	ignore_char:
+#endif
+		if (sn_sal_irq)
+			*status = ia64_sn_console_intr_status();
+		else {
+			int sal_call_status, input;
+
+			if (IS_RUNNING_ON_SIMULATOR()) {
+				extern u64 master_node_bedrock_address;
+				sal_call_status = readb((unsigned long)master_node_bedrock_address + (REG_LSR << 3));
+				if (sal_call_status & LSR_RCA)
+					*status = SAL_CONSOLE_INTR_RECV;
+			} else {
+				sal_call_status = ia64_sn_console_check(&input);
+				if (!sal_call_status && input) {
+					/* input pending */
+					*status = SAL_CONSOLE_INTR_RECV;
+				}
+			}
+		}
+	} while (*status & SAL_CONSOLE_INTR_RECV);
+
+	tty_flip_buffer_push(tty);
+}
+
+
+static inline void
+transmit_chars(struct tty_struct *tty)
+{
+	int xmit_count, tail, head, loops, ii;
+	int result;
+	unsigned long flags;
+	char *start;
+
+	if (xmit.head == xmit.tail || tty->stopped || tty->hw_stopped) {
+		/* Nothing to do. */
+		return;
+	}
+
+	/* Make sure no one gets here until we have drained the buffer */
+
+	spin_lock_irqsave(&sn_sal_lock, flags);
+
+	head = xmit.head;
+	tail = xmit.tail;
+	start = &xmit.buf[tail];
+
+	/* twice around gets the tail to the end of the buffer and then to the head, if needed */
+	loops = (head < tail) ? 2 : 1;
+
+	for (ii = 0; ii < loops; ii++) {
+		xmit_count = (head < tail) ? (SERIAL_XMIT_SIZE - tail) : (head - tail);
+
+		if (xmit_count > 0) {
+			if (IS_RUNNING_ON_SIMULATOR())
+				result = sim_write(start, xmit_count);
+			else {
+				if (sn_sal_irq)
+					result = ia64_sn_console_xmit_chars(start, xmit_count);
+				else
+					result = ia64_sn_console_putb(start, xmit_count);
+			}
+			if (result > 0) {
+				xmit_count -= result;
+				tx_count += result;
+				tail += result;
+				tail &= SERIAL_XMIT_SIZE - 1;
+				xmit.tail = tail;
+				start = &xmit.buf[tail];
+			}
+		}
+	}
+	spin_unlock_irqrestore(&sn_sal_lock, flags);
+
+	if (CIRC_CNT(xmit.head, xmit.tail, SERIAL_XMIT_SIZE) < WAKEUP_CHARS) {
+		/* There's few enough characters left in the xmit buffer
+		 * that we could stand for the upper layer to send us some
+		 * more.  Ask for it.
+		 */
+		sn_sal_sched_event(SN_SAL_EVENT_WRITE_WAKEUP);
+	}
+}
+
+
+irqreturn_t
+sn_sal_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	int status;
+
+	if (irq) {
+		status = ia64_sn_console_intr_status();
+
+		if (status & SAL_CONSOLE_INTR_RECV) {
+			receive_chars(sn_sal_tty, &status, regs);
+		}
+	
+		if (status & SAL_CONSOLE_INTR_XMIT) {
+			transmit_chars(sn_sal_tty);
+		}
+	} else {
+		/* Polling */
+		int input;
+
+		if (IS_RUNNING_ON_SIMULATOR()) {
+			extern u64 master_node_bedrock_address;
+                        input = readb((unsigned long)master_node_bedrock_address + (REG_LSR << 3));
+                        if (input & LSR_RCA)
+				receive_chars(sn_sal_tty, &status, regs);
+
+		} else {
+			status = ia64_sn_console_check(&input);
+			if (!status && input)
+				receive_chars(sn_sal_tty, &status, regs);
+		}
+		transmit_chars(sn_sal_tty);
+	}
+
+	return IRQ_HANDLED;
+}
+
+
+#ifdef CONSOLE_POLLING_ONLY
+#define sn_sal_connect_interrupt() do { } while (0)
+#else
+static void
+sn_sal_connect_interrupt(void)
+{
+	cpuid_t intr_cpuid;
+	unsigned int intr_cpuloc;
+	nasid_t console_nasid;
+	unsigned int console_irq;
+	int result;
+
+	/* if it is an old prom, run in poll mode */
+	if (((sn_sal_rev_major() <= 1) && (sn_sal_rev_minor() <= 3))
+	    || (IS_RUNNING_ON_SIMULATOR())) {
+		/* before version 1.06 doesn't work */
+		printk("========== OLD prom version %x.%x - run in polled mode\n",
+		       sn_sal_rev_major(), sn_sal_rev_minor());
+		sn_sal_irq = 0;	/* Make sure */
+		return ;
+	}
+
+	console_nasid = ia64_sn_get_console_nasid();
+	intr_cpuid = NODEPDA(NASID_TO_COMPACT_NODEID(console_nasid))
+		-> node_first_cpu;
+	intr_cpuloc = cpu_physical_id(intr_cpuid);
+	console_irq = CPU_VECTOR_TO_IRQ(intr_cpuloc, SGI_UART_VECTOR);
+
+	result = intr_connect_level(intr_cpuid, SGI_UART_VECTOR,
+				    0 /*not used*/, 0 /*not used*/);
+	BUG_ON(result != SGI_UART_VECTOR);
+
+	result = request_irq(console_irq, sn_sal_interrupt,
+			     SA_INTERRUPT,  "SAL console driver",
+			     &sn_sal_tty);
+	if (result >= 0) {
+		/* sn_sal_irq is a global variable.  When it's set to a non-zero
+		 * value, the console driver stops polling for input (since interrupts
+		 * should now be enabled).
+		 */
+		sn_sal_irq = console_irq;
+
+		/* ask SAL to turn on interrupts in the UART itself */
+		ia64_sn_console_intr_enable(SAL_CONSOLE_INTR_RECV);
+		/* xmit interrupts are enabled by SAL as necessary */
+	} else
+		printk("Console proceeding in polled mode\n");
+}
+#endif	/* CONSOLE_POLLING_ONLY */
+
+
+/*
+ *
+ * End of the interrupt routines.
+ *********************************************************************/
+
+
+/*********************************************************************
+ * From drivers/char/serial.c:
+ *
+ * "This routine is used to handle the "bottom half" processing for the
+ * serial driver, known also the "software interrupt" processing.
+ * This processing is done at the kernel interrupt level, after the
+ * [sn_sal_interrupt()] has returned, BUT WITH INTERRUPTS TURNED ON.  This
+ * is where time-consuming activities which can not be done in the
+ * interrupt driver proper are done; the interrupt driver schedules
+ * them using [sn_sal_sched_event()], and they get done here."
+ */
+static void
+sn_sal_tasklet_action(unsigned long data)
+{
+	struct tty_struct *tty;
+
+	if (!(tty = sn_sal_tty))
+		return;
+
+	if (test_and_clear_bit(SN_SAL_EVENT_WRITE_WAKEUP, &sn_sal_event)) {
+		if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
+		    tty->ldisc.write_wakeup)
+			(tty->ldisc.write_wakeup)(tty);
+		wake_up_interruptible(&tty->write_wait);
+	}
+}
+
+
+/*
+ * This function handles polled mode.
+ */
+static void
+sn_sal_timer(unsigned long dummy)
+{
+	if (sn_sal_irq == 0) {
+		sn_sal_interrupt(0, NULL, NULL);
+		mod_timer(&sn_sal_timer_list, jiffies + interrupt_timeout);
+		return;
+	}
+
+#if CONSOLE_RESTART
+	sn_sal_interrupt(1, NULL, NULL);
+	mod_timer(&sn_sal_timer_list, jiffies + interrupt_timeout);
+#endif
+}
+
+
+/*
+ *
+ * End of "sofware interrupt" routines.
+ *********************************************************************/
+
+
+
+/*********************************************************************
+ *
+ * User-level console routines
+ *
+ */
+
+static int
+sn_sal_open(struct tty_struct *tty, struct file *filp)
+{
+	if (!sn_sal_tty)
+		sn_sal_tty = tty;
+
+	if (sn_sal_irq == 0 || CONSOLE_RESTART)
+		mod_timer(&sn_sal_timer_list, jiffies + interrupt_timeout);
+
+	return 0;
+}
+
+
+/* We're keeping all our resources.  We're keeping interrupts turned
+ * on.  Maybe just let the tty layer finish its stuff...? GMSH
+ */
+static void
+sn_sal_close(struct tty_struct *tty, struct file * filp)
+{
+	tty->closing = 1;
+	if (tty->driver->flush_buffer)
+		tty->driver->flush_buffer(tty);
+	if (tty->ldisc.flush_buffer)
+		tty->ldisc.flush_buffer(tty);
+	tty->closing = 0;
+    
+	return;
+}
+
+
+static int
+sn_sal_write(struct tty_struct *tty, int from_user,
+	       const unsigned char *buf, int count)
+{
+	int c, ret = 0;
+	unsigned long flags;
+
+	if (from_user) {
+		while (1) {
+			int c1;
+			c = CIRC_SPACE_TO_END(xmit.head, xmit.tail,
+					      SERIAL_XMIT_SIZE);
+
+			if (count < c)
+				c = count;
+			if (c <= 0)
+				break;
+
+			c -= copy_from_user(sal_tmp_buffer, buf, c);
+			if (!c) {
+				if (!ret)
+					ret = -EFAULT;
+				break;
+			}
+
+			/* Turn off interrupts and see if the xmit buffer has
+			 * moved since the last time we looked.
+			 */
+			spin_lock_irqsave(&sn_sal_lock, flags);
+			c1 = CIRC_SPACE_TO_END(xmit.head, xmit.tail,
+					       SERIAL_XMIT_SIZE);
+
+			if (c1 < c)
+				c = c1;
+
+			memcpy(xmit.buf + xmit.head, sal_tmp_buffer, c);
+			xmit.head = ((xmit.head + c) & (SERIAL_XMIT_SIZE - 1));
+			spin_unlock_irqrestore(&sn_sal_lock, flags);
+
+			buf += c;
+			count -= c;
+			ret += c;
+		}
+	} else {
+		/* The buffer passed in isn't coming from userland,
+		 * so cut out the middleman (sal_tmp_buffer).
+		 */
+		spin_lock_irqsave(&sn_sal_lock, flags);
+		while (1) {
+			c = CIRC_SPACE_TO_END(xmit.head, xmit.tail,
+					      SERIAL_XMIT_SIZE);
+
+			if (count < c)
+				c = count;
+			if (c <= 0) {
+				break;
+			}
+			memcpy(xmit.buf + xmit.head, buf, c);
+			xmit.head = ((xmit.head + c) & (SERIAL_XMIT_SIZE - 1));
+			buf += c;
+			count -= c;
+			ret += c;
+		}
+		spin_unlock_irqrestore(&sn_sal_lock, flags);
+	}
+
+	if ((xmit.head != xmit.tail) && !tty->stopped && !tty->hw_stopped)
+		transmit_chars(tty);
+
+	return ret;
+}
+
+
+static void
+sn_sal_put_char(struct tty_struct *tty, unsigned char ch)
+{
+	unsigned long flags;
+
+	if (!tty || !xmit.buf)
+		return;
+
+	spin_lock_irqsave(&sn_sal_lock, flags);
+	if (CIRC_SPACE(xmit.head, xmit.tail, SERIAL_XMIT_SIZE) == 0) {
+		spin_unlock_irqrestore(&sn_sal_lock, flags);
+		return;
+	}
+
+	xmit.buf[xmit.head] = ch;
+	xmit.head = (xmit.head + 1) & (SERIAL_XMIT_SIZE-1);
+	spin_unlock_irqrestore(&sn_sal_lock, flags);
+}
+
+
+static void
+sn_sal_flush_chars(struct tty_struct *tty)
+{
+	if (CIRC_CNT(xmit.head, xmit.tail, SERIAL_XMIT_SIZE))
+		transmit_chars(tty);
+}
+
+
+static int
+sn_sal_write_room(struct tty_struct *tty)
+{
+	return CIRC_SPACE(xmit.head, xmit.tail, SERIAL_XMIT_SIZE);
+}
+
+
+static int
+sn_sal_chars_in_buffer(struct tty_struct *tty)
+{
+	return CIRC_CNT(xmit.head, xmit.tail, SERIAL_XMIT_SIZE);
+}
+
+
+static int
+sn_sal_ioctl(struct tty_struct *tty, struct file *file,
+	       unsigned int cmd, unsigned long arg)
+{
+	/* nothing supported*/
+	return -ENOIOCTLCMD;
+}
+
+
+static void
+sn_sal_set_termios(struct tty_struct *tty, struct termios *old_termios)
+{
+ 	/* don't care about termios */
+	return;
+}
+
+
+static void
+sn_sal_flush_buffer(struct tty_struct *tty)
+{
+	unsigned long flags;
+
+	/* drop everything */
+	spin_lock_irqsave(&sn_sal_lock, flags);
+	xmit.head = xmit.tail = 0;
+	spin_unlock_irqrestore(&sn_sal_lock, flags);
+
+	/* wake up tty level */
+	wake_up_interruptible(&tty->write_wait);
+	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
+	    tty->ldisc.write_wakeup)
+		(tty->ldisc.write_wakeup)(tty);
+}
+
+
+static void
+sn_sal_hangup(struct tty_struct *tty)
+{
+	sn_sal_flush_buffer(tty);
+}
+
+
+static void
+sn_sal_wait_until_sent(struct tty_struct *tty, int timeout)
+{
+	/* this is SAL's problem */
+	return;
+}
+
+
+/*
+ * sn_sal_read_proc
+ *
+ * Console /proc interface
+ */
+
+static int
+sn_sal_read_proc(char *page, char **start, off_t off, int count,
+		   int *eof, void *data)
+{
+	int len = 0;
+	off_t	begin = 0;
+	extern nasid_t get_console_nasid(void);
+
+	len += sprintf(page, "sal_cons: %s 1.0 driver:%s revision:%s console nasid %d : irq %d tx/rx %d/%d\n",
+		       serial_name, serial_version, serial_revdate, get_console_nasid(), sn_sal_irq,
+		       tx_count, rx_count);
+	*eof = 1;
+
+	if (off >= len+begin)
+		return 0;
+	*start = page + (off-begin);
+
+	return count < begin+len-off ? count : begin+len-off;
+}
+
+
+static struct tty_operations sn_sal_ops = {
+	.open = sn_sal_open,
+	.close = sn_sal_close,
+	.write = sn_sal_write,
+	.put_char = sn_sal_put_char,
+	.flush_chars = sn_sal_flush_chars,
+	.write_room = sn_sal_write_room,
+	.chars_in_buffer = sn_sal_chars_in_buffer,
+	.ioctl = sn_sal_ioctl,
+	.set_termios = sn_sal_set_termios,
+	.hangup = sn_sal_hangup,
+	.wait_until_sent = sn_sal_wait_until_sent,
+	.read_proc = sn_sal_read_proc,
+};
+
+/* sn_sal_init wishlist:
+ * - allocate sal_tmp_buffer
+ * - fix up the tty_driver struct
+ * - turn on receive interrupts
+ * - do any termios twiddling once and for all
+ */
+
+/*
+ * Boot-time initialization code
+ */
+static int __init
+sn_sal_init(void)
+{
+	int retval = 0;
+
+	if (!ia64_platform_is("sn2"))
+		return -ENODEV;
+
+	sn_sal_driver = alloc_tty_driver(1);
+	if (!sn_sal_driver)
+		return -ENOMEM;
+
+	sn_sal_driver->owner = THIS_MODULE;
+	sn_sal_driver->driver_name = "SALconsole",
+	sn_sal_driver->name = "ttyS",
+	sn_sal_driver->major = TTY_MAJOR,
+	sn_sal_driver->minor_start = SN_SAL_MINOR,
+	sn_sal_driver->type = TTY_DRIVER_TYPE_SERIAL,
+	sn_sal_driver->subtype = SN_SAL_SUBTYPE,
+	sn_sal_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS,
+	sn_sal_driver->termios = &sn_sal_termios,
+	sn_sal_driver->termios_locked = &sn_sal_termios_locked,
+	sn_sal_driver->init_termios = tty_std_termios;
+	sn_sal_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+
+	tty_set_operations(sn_sal_driver, &sn_sal_ops);
+	if ((retval = tty_register_driver(sn_sal_driver)))
+		goto free_driver;
+
+	/* initialize xmit */
+	xmit.buf = (char *)get_zeroed_page(GFP_KERNEL);
+	if (!xmit.buf) {
+		retval = -ENOMEM;
+		goto free_driver;
+	}
+
+	xmit.head = 0;
+	xmit.tail = 0;
+
+	sn_sal_lock = SPIN_LOCK_UNLOCKED;
+
+	/* allocate a temporary buffer for copying data from user land */
+	sal_tmp_buffer = (char *)get_zeroed_page(GFP_KERNEL);
+	if (!sal_tmp_buffer) {
+		retval = -ENOMEM;
+		goto free_xmit;
+	}
+
+	/* turn on interrupts */
+	sn_sal_connect_interrupt();
+
+	/* Without interrupts, we have to rely on a timer to poll the
+	 * SAL console driver.
+	 */
+	if (sn_sal_irq == 0 || CONSOLE_RESTART) {
+		init_timer(&sn_sal_timer_list);
+		sn_sal_timer_list.function = sn_sal_timer;
+		if (sn_sal_irq == 1 && CONSOLE_RESTART)
+			interrupt_timeout = RESTART_TIMEOUT;
+		else
+			interrupt_timeout = POLL_TIMEOUT;
+		mod_timer(&sn_sal_timer_list, jiffies + interrupt_timeout);
+	}
+
+	return 0;
+
+free_xmit:
+	free_page((unsigned long)xmit.buf);
+free_driver:
+	put_tty_driver(sn_sal_driver);
+	return retval;
+}
+
+
+static void __exit
+sn_sal_fini(void)
+{
+	unsigned long flags;
+	int e;
+
+	del_timer_sync(&sn_sal_timer_list);
+
+	spin_lock_irqsave(&sn_sal_lock, flags);
+	if ((e = tty_unregister_driver(sn_sal_driver)))
+		printk("SALconsole: failed to unregister driver (%d)\n", e);
+	spin_unlock_irqrestore(&sn_sal_lock, flags);
+
+	free_page((unsigned long)xmit.buf);
+	free_page((unsigned long)sal_tmp_buffer);
+	put_tty_driver(sn_sal_driver);
+}
+
+module_init(sn_sal_init);
+module_exit(sn_sal_fini);
+
+/*
+ *
+ * End of user-level console routines.
+ *********************************************************************/
+
+
+
+/*********************************************************************
+ *
+ * Kernel console definitions
+ *
+ */
+
+/*
+ * Print a string to the SAL console.  The console_lock must be held
+ * when we get here.
+ */
+static void
+sn_sal_console_write(struct console *co, const char *s, unsigned count)
+{
+	if (IS_RUNNING_ON_SIMULATOR())
+		sim_write(s, count);
+	else
+		ia64_sn_console_putb(s, count);
+}
+
+#if defined(CONFIG_IA64_EARLY_PRINTK_SGI_SN)
+void
+sn_sal_console_out(const char *s, unsigned count)
+{
+	/* Need to setup SAL calls so the PROM calls will work */
+	static int inited;
+	void early_sn_setup(void);
+	if (!inited) {
+		inited=1;
+		early_sn_setup();
+	}
+
+	if (IS_RUNNING_ON_SIMULATOR())
+		sim_write(s, count);
+	else
+    		ia64_sn_console_putb(s, count);
+}
+#endif	/* CONFIG_IA64_EARLY_PRINTK_SGI_SN */
+
+static struct tty_driver *
+sn_sal_console_device(struct console *c, int *index)
+{
+	*index = c->index;
+	return sn_sal_driver;
+}
+
+static int __init
+sn_sal_console_setup(struct console *co, char *options)
+{
+	return 0;
+}
+
+
+static struct console sal_console = {
+	.name = "ttyS",
+	.write = sn_sal_console_write,
+	.device = sn_sal_console_device,
+	.setup = sn_sal_console_setup,
+	.flags = CON_PRINTBUFFER,
+	.index = -1
+};
+
+/*
+ *
+ * End of kernel console definitions.
+ *********************************************************************/
+
+
+
+#ifdef CONFIG_SGI_L1_SERIAL_CONSOLE
+/*
+ *	Register console.
+ */
+int __init
+sgi_l1_serial_console_init(void)
+{
+	if (ia64_platform_is("sn2"))
+		register_console(&sal_console);
+
+	return 0;
+}
+
+console_initcall(sgi_l1_serial_console_init);
+
+#endif /* CONFIG_SGI_L1_SERIAL_CONSOLE */

--=-=-=--
