Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269920AbTGOXGb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 19:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269923AbTGOXGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 19:06:31 -0400
Received: from rj.SGI.COM ([192.82.208.96]:58554 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S269920AbTGOXFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 19:05:13 -0400
Date: Tue, 15 Jul 2003 16:19:39 -0700
From: Christopher Wedgwood <cw@sgi.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, Alan Cox <alan@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Wild Wild Wild OS <wildos@sgi.com>
Subject: [PATCH] (2.4.22-pre6 BK) New (console) Driver for SGI Altix
Message-ID: <20030715231938.GA10605@taniwha.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

This patch is against the BK tree of an hour or two ago.  It should
apply with minimal effort to almost any tree though.

There doesn't seem to be a maintainer for console-only things so
hoepfully this will do.  This patch adds support for the SGI Altix
(SN2) console driver.

No generic/non-sn2 code paths should be affected by this.

 Documentation/Configure.help |   15
 MAINTAINERS                  |    5
 drivers/char/Config.in       |    3
 drivers/char/Makefile        |    1
 drivers/char/sn_serial.c     |  912 +++++++++++++++++++++++++++++++++
 drivers/char/tty_io.c        |    8
 6 files changed, 929 insertions(+), 15 deletions(-)

Pending any nasties please apply!


Thanks,
  --cw


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1123  -> 1.1124 
#	drivers/char/Config.in	1.47    -> 1.48   
#	drivers/char/tty_io.c	1.25    -> 1.26   
#	         MAINTAINERS	1.102   -> 1.103  
#	Documentation/Configure.help	1.170   -> 1.171  
#	drivers/char/Makefile	1.34    -> 1.35   
#	               (new)	        -> 1.1     drivers/char/sn_serial.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/07/15	cw@taniwha.engr.sgi.com	1.1124
# Add SGI Altix (SN2) console driver
# --------------------------------------------
#
diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Tue Jul 15 16:15:34 2003
+++ b/Documentation/Configure.help	Tue Jul 15 16:15:34 2003
@@ -26203,12 +26203,6 @@
   IRIX PCIBA-inspired user mode PCI interface for the SGI SN (Scalable
   NUMA) platform for IA64.  Unless you are compiling a kernel for an              SGI SN IA64 box, say N.
 
-Enable protocol mode for the L1 console
-SERIAL_SGI_L1_PROTOCOL
-  Uses protocol mode instead of raw mode for the level 1 console on the
-  SGI SN (Scalable NUMA) platform for IA64.  If you are compiling for
-  an SGI SN box then Y is the recommended value, otherwise say N.
-
 Directly Connected Compact Flash support
 CONFIG_CF_ENABLER
   Compact Flash is a small, removable mass storage device introduced
@@ -26857,11 +26851,10 @@
   Say Y here to support tuning the ITE8172's IDE interface.  This makes
   it possible to set DMA channel or PIO opration and the transfer rate.
 
-Enable protocol mode for the L1 console
-CONFIG_SERIAL_SGI_L1_PROTOCOL
-  Uses protocol mode instead of raw mode for the level 1 console on the
-  SGI SN (Scalable NUMA) platform for IA64.  If you are compiling for
-  an SGI SN box then Y is the recommended value, otherwise say N.
+SGI Altix (SN2) Console Support
+CONFIG_SGI_SN_SERIAL_CONSOLE
+  Enables Console support for SGI Altix (SN2) machines.  If you have
+  an Altix you almost certainly want this --- otherwise choose N.
 
 New bus configuration (EXPERIMENTAL)  
 CONFIG_TULIP_MWI
diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	Tue Jul 15 16:15:34 2003
+++ b/MAINTAINERS	Tue Jul 15 16:15:34 2003
@@ -1547,6 +1547,11 @@
 M:	mingo@redhat.com
 S:	Maintained
 
+SGI Altix (SN2) Console Driver
+P:	Chad Talbott
+M:	chadt@sgi.com
+S:	Maintained
+
 SIS 5513 IDE CONTROLLER DRIVER
 P:      Lionel Bouton
 M:      Lionel.Bouton@inet6.fr
diff -Nru a/drivers/char/Config.in b/drivers/char/Config.in
--- a/drivers/char/Config.in	Tue Jul 15 16:15:34 2003
+++ b/drivers/char/Config.in	Tue Jul 15 16:15:34 2003
@@ -104,6 +104,9 @@
        fi
      fi
   fi
+  if [ "$CONFIG_IA64" = "y" ]; then
+    bool '    SGI Altix (SN2) Console support' CONFIG_SGI_SN_SERIAL_CONSOLE
+  fi
 fi
 if [ "$CONFIG_EXPERIMENTAL" = "y" -a "$CONFIG_ZORRO" = "y" ]; then
    tristate 'Commodore A2232 serial support (EXPERIMENTAL)' CONFIG_A2232
diff -Nru a/drivers/char/Makefile b/drivers/char/Makefile
--- a/drivers/char/Makefile	Tue Jul 15 16:15:34 2003
+++ b/drivers/char/Makefile	Tue Jul 15 16:15:34 2003
@@ -211,6 +211,7 @@
 obj-$(CONFIG_HVC_CONSOLE) += hvc_console.o
 obj-$(CONFIG_SERIAL_TX3912) += generic_serial.o serial_tx3912.o
 obj-$(CONFIG_TXX927_SERIAL) += serial_txx927.o
+obj-$(CONFIG_SGI_SN_SERIAL) += sn_serial.o
 
 subdir-$(CONFIG_RIO) += rio
 subdir-$(CONFIG_INPUT) += joystick
diff -Nru a/drivers/char/sn_serial.c b/drivers/char/sn_serial.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/char/sn_serial.c	Tue Jul 15 16:15:34 2003
@@ -0,0 +1,912 @@
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
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/console.h>
+#ifdef CONFIG_MAGIC_SYSRQ
+#include <linux/sysrq.h>
+#endif
+#include <linux/circ_buf.h>
+#include <asm/irq.h>
+
+#include <asm/system.h>
+#include <asm/sn/sn_sal.h>
+#include <asm/sn/nodepda.h>
+#include <asm/sn/simulator.h>
+#include <asm/sn/sn2/sn_private.h>
+#include <asm/sn/uart16550.h>
+
+#define	GMSH_DEBUG(_a, _b)
+#define	GMSH_DEBUG_BUF(_a, _b)
+
+#ifndef NR_NODES
+/* This should be removed once all the header file changes have propigated */
+#define NR_NODES 1024
+#endif
+
+#if defined(CONFIG_SGI_SN_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+static char sysrq_serial_str[] = "\eSYS";
+static char *sysrq_serial_ptr = sysrq_serial_str;
+static unsigned long sysrq_requested;
+#endif	/* CONFIG_SGI_SN_SERIAL_CONSOLE && CONFIG_MAGIC_SYSRQ */
+
+static char *serial_name = "SGI SN SAL Console Serial driver";
+static char *serial_version = "1.0";
+static char *serial_revdate = "2003-07-15";
+
+static struct tty_struct *sal_cons_tty;
+static struct console sal_console;
+static struct tq_struct tq;
+static struct circ_buf xmit;
+static struct timer_list sal_cons_timer_list;
+static int sal_cons_event; /* event type for task queue */
+static int sal_cons_refcount;
+static char *sal_tmp_buffer;
+static int sal_cons_irq;
+static spinlock_t sal_cons_lock;
+static int tx_count;
+static int rx_count;
+
+static struct tty_struct *sal_cons_table;
+static struct termios *sal_cons_termios;
+static struct termios *sal_cons_termios_locked;
+
+static DECLARE_TASK_QUEUE(tq_serial);
+
+/* driver subtype - what does this mean? */
+#define SAL_CONS_SUBTYPE 1
+
+/* minor device number */
+#define SAL_CONS_MINOR 64
+
+/* number of characters left in xmit buffer before we ask for more */
+#define WAKEUP_CHARS 256
+
+/* number of characters we can transmit to the SAL console at a time */
+#define SAL_CONS_MAX_CHARS 120
+
+/* event types for our task queue -- so far just one */
+#define SAL_CONS_EVENT_WRITE_WAKEUP	0
+
+#define CONSOLE_RESTART 1
+
+#if CONSOLE_RESTART
+#  define TIMER_WAIT_TIME		20*HZ
+#else
+#  define TIMER_WAIT_TIME		2*HZ/100
+#endif
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
+	if (master_node_bedrock_address != 0l) {
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
+ * as inline and folded into sal_cons_interrupt.
+ */
+
+static inline void
+sal_cons_sched_event(int event)
+{
+	sal_cons_event |= (1 << event);
+	queue_task(&tq, &tq_serial);
+	mark_bh(SERIAL_BH);
+}
+
+
+static inline void
+receive_chars(struct tty_struct *tty, int *status, struct pt_regs *regs)
+{
+	unsigned char ch;
+
+	do {
+		if (IS_RUNNING_ON_SIMULATOR()) {
+			extern u64 master_node_bedrock_address;
+			ch = readb((unsigned long)master_node_bedrock_address + (REG_DAT << 3));
+		} else {
+			if (sal_cons_irq) {
+				ch = (unsigned char) ia64_sn_console_readc();
+			} else {
+				if (ia64_sn_console_getc((int *)&ch))
+					break;
+			}
+		}
+
+#if defined(CONFIG_SGI_SN_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+		if (sysrq_requested) {
+			unsigned long sysrq_timeout = sysrq_requested + HZ*5;
+			sysrq_requested = 0;
+			if (ch && time_before(jiffies, sysrq_timeout)) {
+				handle_sysrq(ch, regs, NULL, NULL);
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
+#endif	/* CONFIG_SGI_SN_SERIAL_CONSOLE && CONFIG_MAGIC_SYSRQ */
+
+		*tty->flip.char_buf_ptr = ch;
+		tty->flip.char_buf_ptr++;
+		tty->flip.count++;
+		rx_count++;
+
+#if defined(CONFIG_SGI_SN_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+	ignore_char:
+#endif
+		if (sal_cons_irq)
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
+	spin_lock_irqsave(&sal_cons_lock, flags);
+
+	head = xmit.head;
+	tail = xmit.tail;
+	start = (char *)&xmit.buf[tail];
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
+				if (sal_cons_irq)
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
+				start = (char *)&xmit.buf[tail];
+			}
+		}
+	}
+	spin_unlock_irqrestore(&sal_cons_lock, flags);
+
+	if (CIRC_CNT(xmit.head, xmit.tail, SERIAL_XMIT_SIZE) < WAKEUP_CHARS) {
+		/* There's few enough characters left in the xmit buffer
+		 * that we could stand for the upper layer to send us some
+		 * more.  Ask for it.
+		 */
+		sal_cons_sched_event(SAL_CONS_EVENT_WRITE_WAKEUP);
+	}
+}
+
+
+static void
+sal_cons_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	int status;
+
+	if (irq) {
+		status = ia64_sn_console_intr_status();
+
+		if (status & SAL_CONSOLE_INTR_RECV) {
+			receive_chars(sal_cons_tty, &status, regs);
+		}
+
+		if (status & SAL_CONSOLE_INTR_XMIT) {
+			transmit_chars(sal_cons_tty);
+		}
+	} else {
+		/* Polling */
+		int input;
+
+		if (IS_RUNNING_ON_SIMULATOR()) {
+			extern u64 master_node_bedrock_address;
+                        input = readb((unsigned long)master_node_bedrock_address + (REG_LSR << 3));
+                        if (input & LSR_RCA)
+				receive_chars(sal_cons_tty, &status, regs);
+
+		} else {
+			status = ia64_sn_console_check(&input);
+			if (!status && input)
+				receive_chars(sal_cons_tty, &status, regs);
+		}
+		transmit_chars(sal_cons_tty);
+	}
+}
+
+
+static void
+sal_cons_connect_interrupt(void)
+{
+	cpuid_t intr_cpuid;
+	unsigned int intr_cpuloc;
+	nasid_t console_nasid;
+	unsigned int console_irq;
+	int result;
+
+#if defined(CONSOLE_POLLING_ONLY)
+	sal_cons_irq = 0;
+#else
+	/* if it is an old prom, run in poll mode */
+	if (((sn_sal_rev_major() <= 1) && (sn_sal_rev_minor() <= 3))
+	    || (IS_RUNNING_ON_SIMULATOR())) {
+		/* before version 1.06 doesn't work */
+		printk("========== OLD prom version %x.%x - run in polled mode\n",
+		       sn_sal_rev_major(), sn_sal_rev_minor());
+		sal_cons_irq = 0;	/* Make sure */
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
+	if (result != SGI_UART_VECTOR) {
+		if (result < 0) GMSH_DEBUG("intr_connect_level failed", result);
+		else GMSH_DEBUG("intr_connect_level returns wrong bit", result);
+		return;
+	}
+
+	result = request_irq(console_irq, sal_cons_interrupt,
+			     SA_INTERRUPT,  "SAL console driver",
+			     &sal_cons_tty);
+	if (result < 0) {
+		GMSH_DEBUG("request_irq failed", result);
+		return;
+	}
+
+	/* sal_cons_irq is a global variable.  When it's set to a non-zero
+	 * value, the console driver stops polling for input (since interrupts
+	 * should now be enabled).
+	 */
+	sal_cons_irq = console_irq;
+
+	/* ask SAL to turn on interrupts in the UART itself */
+	ia64_sn_console_intr_enable(SAL_CONSOLE_INTR_RECV);
+	/* xmit interrupts are enabled by SAL as necessary */
+#endif	/* CONSOLE_POLLING_ONLY */
+}
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
+ * [sal_cons_interrupt()] has returned, BUT WITH INTERRUPTS TURNED ON.  This
+ * is where time-consuming activities which can not be done in the
+ * interrupt driver proper are done; the interrupt driver schedules
+ * them using [sal_cons_sched_event()], and they get done here."
+ */
+static void
+do_sal_cons_bh(void)
+{
+	run_task_queue(&tq_serial);
+}
+
+static void
+do_softint(void *data)
+{
+	struct tty_struct *tty;
+
+	if (!(tty = sal_cons_tty))
+		return;
+
+	if (test_and_clear_bit(SAL_CONS_EVENT_WRITE_WAKEUP, &sal_cons_event)) {
+		if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) && tty->ldisc.write_wakeup)
+			(tty->ldisc.write_wakeup)(tty);
+
+		wake_up_interruptible(&tty->write_wait);
+#ifdef SERIAL_HAVE_POLL_WAIT
+		wake_up_interruptible(&tty->poll_wait);
+#endif
+	}
+}
+
+
+/*
+ * This function handles polled mode.
+ */
+static void
+sal_cons_timer(unsigned long dummy)
+{
+	if (sal_cons_irq == 0) {
+		sal_cons_interrupt(0, NULL, NULL);
+		mod_timer(&sal_cons_timer_list, jiffies + TIMER_WAIT_TIME);
+		return;
+	}
+
+#if CONSOLE_RESTART
+	sal_cons_interrupt(1, NULL, NULL);
+	mod_timer(&sal_cons_timer_list, jiffies + TIMER_WAIT_TIME);
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
+sal_cons_open(struct tty_struct *tty, struct file *filp)
+{
+	if (!sal_cons_tty)
+		sal_cons_tty = tty;
+
+	if (sal_cons_irq == 0 || CONSOLE_RESTART)
+		mod_timer(&sal_cons_timer_list, jiffies + TIMER_WAIT_TIME);
+
+	return 0;
+}
+
+
+/* We're keeping all our resources.  We're keeping interrupts turned
+ * on.  Maybe just let the tty layer finish its stuff...? GMSH
+ */
+static void
+sal_cons_close(struct tty_struct *tty, struct file * filp)
+{
+	tty->closing = 1;
+	if (tty->driver.flush_buffer)
+		tty->driver.flush_buffer(tty);
+	if (tty->ldisc.flush_buffer)
+		tty->ldisc.flush_buffer(tty);
+	tty->closing = 0;
+
+	return;
+}
+
+
+static int
+sal_cons_write(struct tty_struct *tty, int from_user,
+	       const unsigned char *buf, int count)
+{
+	int c, ret = 0;
+	unsigned long flags;
+
+#if 0 /* GMSH */
+	/* This code just reads and prints the value of the UART
+	 * interrupt control register to ensure that SAL actually
+	 * set the bits as requested.
+	 */
+	if (strncmp(buf, "@CheckUART", strlen("@CheckUART")) == 0) {
+		unsigned long long icr;
+		icr = LOCAL_HUB_L(SH_JUNK_BUS_UART1);
+		GMSH_DEBUG("ICR reg value", icr);
+	}
+#endif
+
+	if (!tty || !xmit.buf || !sal_tmp_buffer) {
+		GMSH_DEBUG("sal_cons_write ran into trouble", 0);
+		if (!tty) GMSH_DEBUG("tty", tty);
+		if (!xmit.buf) GMSH_DEBUG("xmit.buf", xmit.buf);
+		if (!sal_tmp_buffer) GMSH_DEBUG("sal_tmp_buffer", sal_tmp_buffer);
+		GMSH_DEBUG_BUF(buf, count);
+		return 0;
+	}
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
+			spin_lock_irqsave(&sal_cons_lock, flags);
+			c1 = CIRC_SPACE_TO_END(xmit.head, xmit.tail,
+					       SERIAL_XMIT_SIZE);
+
+			if (c1 < c)
+				c = c1;
+
+			memcpy(xmit.buf + xmit.head, sal_tmp_buffer, c);
+			xmit.head = ((xmit.head + c) & (SERIAL_XMIT_SIZE - 1));
+			spin_unlock_irqrestore(&sal_cons_lock, flags);
+
+			buf += c;
+			count -= c;
+			ret += c;
+		}
+	} else {
+		/* The buffer passed in isn't coming from userland,
+		 * so cut out the middleman (sal_tmp_buffer).
+		 */
+		spin_lock_irqsave(&sal_cons_lock, flags);
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
+		spin_unlock_irqrestore(&sal_cons_lock, flags);
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
+sal_cons_put_char(struct tty_struct *tty, unsigned char ch)
+{
+	unsigned long flags;
+
+	if (!tty || !xmit.buf)
+		return;
+
+	spin_lock_irqsave(&sal_cons_lock, flags);
+	if (CIRC_SPACE(xmit.head, xmit.tail, SERIAL_XMIT_SIZE) == 0) {
+		spin_unlock_irqrestore(&sal_cons_lock, flags);
+		return;
+	}
+
+	xmit.buf[xmit.head] = ch;
+	xmit.head = (xmit.head + 1) & (SERIAL_XMIT_SIZE-1);
+	spin_unlock_irqrestore(&sal_cons_lock, flags);
+}
+
+
+static void
+sal_cons_flush_chars(struct tty_struct *tty)
+{
+	if (CIRC_CNT(xmit.head, xmit.tail, SERIAL_XMIT_SIZE))
+		transmit_chars(tty);
+}
+
+
+static int
+sal_cons_write_room(struct tty_struct *tty)
+{
+	return CIRC_SPACE(xmit.head, xmit.tail, SERIAL_XMIT_SIZE);
+}
+
+
+static int
+sal_cons_chars_in_buffer(struct tty_struct *tty)
+{
+	return CIRC_CNT(xmit.head, xmit.tail, SERIAL_XMIT_SIZE);
+}
+
+
+static int
+sal_cons_ioctl(struct tty_struct *tty, struct file *file,
+	       unsigned int cmd, unsigned long arg)
+{
+	/* nothing supported*/
+	return -ENOIOCTLCMD;
+}
+
+
+static void
+sal_cons_set_termios(struct tty_struct *tty, struct termios *old_termios)
+{
+ 	/* don't care about termios */
+	return;
+}
+
+
+static void
+sal_cons_flush_buffer(struct tty_struct *tty)
+{
+	unsigned long flags;
+
+	/* drop everything */
+	spin_lock_irqsave(&sal_cons_lock, flags);
+	xmit.head = xmit.tail = 0;
+	spin_unlock_irqrestore(&sal_cons_lock, flags);
+
+	/* wake up tty level */
+	wake_up_interruptible(&tty->write_wait);
+#ifdef SERIAL_HAVE_POLL_WAIT
+	wake_up_interruptible(&tty->poll_wait);
+#endif
+	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) && tty->ldisc.write_wakeup)
+		(tty->ldisc.write_wakeup)(tty);
+}
+
+
+static void
+sal_cons_hangup(struct tty_struct *tty)
+{
+	sal_cons_flush_buffer(tty);
+}
+
+
+static void
+sal_cons_wait_until_sent(struct tty_struct *tty, int timeout)
+{
+	/* this is SAL's problem */
+	return;
+}
+
+
+/*
+ * sal_cons_read_proc
+ *
+ * Console /proc interface
+ */
+
+static int
+sal_cons_read_proc(char *page, char **start, off_t off, int count,
+		   int *eof, void *data)
+{
+	int len = 0;
+	off_t	begin = 0;
+	extern nasid_t get_console_nasid(void);
+
+	len += sprintf(page, "sal_cons: %s 1.0 driver:%s revision:%s console nasid %d : irq %d tx/rx %d/%d\n",
+		       serial_name, serial_version, serial_revdate, get_console_nasid(), sal_cons_irq,
+		       tx_count, rx_count);
+	*eof = 1;
+
+	if (off >= len+begin)
+		return 0;
+	*start = page + (off-begin);
+
+	return ((count < begin+len-off) ? count : begin+len-off);
+}
+
+
+static struct tty_driver sal_cons_driver = {
+	.magic = TTY_DRIVER_MAGIC,
+	.driver_name = "SALconsole",
+#if defined(CONFIG_DEVFS_FS)
+	.name = "tts/%d",
+#else
+	.name = "ttyS",
+#endif
+	.major = TTY_MAJOR,
+	.minor_start = SAL_CONS_MINOR,
+	.num = 1,
+	.type = TTY_DRIVER_TYPE_SERIAL,
+	.subtype = SAL_CONS_SUBTYPE,
+	.flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS,
+	.refcount = &sal_cons_refcount,
+	/* proc_entry omitted */
+	/* other omitted */
+	.table = &sal_cons_table,
+	.termios = &sal_cons_termios,
+	.termios_locked = &sal_cons_termios_locked,
+
+	.open = sal_cons_open,
+	.close = sal_cons_close,
+	.write = sal_cons_write,
+	.put_char = sal_cons_put_char,
+	.flush_chars = sal_cons_flush_chars,
+	.write_room = sal_cons_write_room,
+	.chars_in_buffer = sal_cons_chars_in_buffer,
+	.ioctl = sal_cons_ioctl,
+	.set_termios = sal_cons_set_termios,
+	.hangup = sal_cons_hangup,
+	.wait_until_sent = sal_cons_wait_until_sent,
+	.read_proc = sal_cons_read_proc,
+};
+
+/* sal_cons_init wishlist:
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
+sal_cons_init(void)
+{
+	if (!ia64_platform_is("sn2"))
+		return -ENODEV;
+
+	init_bh(SERIAL_BH, do_sal_cons_bh);
+
+	sal_cons_driver.init_termios = tty_std_termios;
+	sal_cons_driver.init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+
+	if (tty_register_driver(&sal_cons_driver))
+		panic("Couldn't register SALconsole driver\n");
+
+	tty_register_devfs(&sal_cons_driver, 0, sal_cons_driver.minor_start);
+
+	/* initialize xmit */
+	xmit.buf = (char *)get_zeroed_page(GFP_KERNEL);
+	if (!xmit.buf)
+		panic("Couldn't allocate xmit buffer for SALconsole driver\n");
+	xmit.head = 0;
+	xmit.tail = 0;
+
+	sal_cons_lock = SPIN_LOCK_UNLOCKED;
+
+	/* allocate a temporary buffer for copying data from user land */
+	sal_tmp_buffer = (char *)get_zeroed_page(GFP_KERNEL);
+	if (!sal_tmp_buffer)
+		panic("Couldn't allocate temp buffer for SALconsole driver\n");
+
+	/* turn on interrupts */
+	sal_cons_connect_interrupt();
+
+	/* Without interrupts, we have to rely on a timer to poll the
+	 * SAL console driver.
+	 */
+	if (sal_cons_irq == 0 || CONSOLE_RESTART) {
+		init_timer(&sal_cons_timer_list);
+		sal_cons_timer_list.function = sal_cons_timer;
+		mod_timer(&sal_cons_timer_list, jiffies + TIMER_WAIT_TIME);
+	}
+
+	/* task queue initialization */
+	tq.routine = do_softint;
+	tq.data = NULL;
+
+	return 0;
+}
+
+
+static void __exit
+sal_cons_fini(void)
+{
+	unsigned long flags;
+	int e;
+
+	del_timer_sync(&sal_cons_timer_list);
+	spin_lock_irqsave(&sal_cons_lock, flags);
+	remove_bh(SERIAL_BH);
+
+	if ((e = tty_unregister_driver(&sal_cons_driver)))
+		printk("SALconsole: failed to unregister driver (%d)\n", e);
+
+	spin_unlock_irqrestore(&sal_cons_lock, flags);
+
+	if (sal_tmp_buffer) {
+		unsigned long pg = (unsigned long) sal_tmp_buffer;
+		sal_tmp_buffer = NULL;
+		free_page(pg);
+	}
+}
+
+module_init(sal_cons_init);
+module_exit(sal_cons_fini);
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
+sal_cons_console_write(struct console *co, const char *s, unsigned count)
+{
+	if (IS_RUNNING_ON_SIMULATOR())
+		sim_write(s, count);
+	else
+		ia64_sn_console_putb(s, count);
+}
+
+#if defined(CONFIG_IA64_EARLY_PRINTK_SGI_SN)
+void
+sal_cons_console_out(const char *s, unsigned count)
+{
+	/* Need to setup SAL calls so the PROM calls will work */
+	static int inited;
+	void early_sn_setup(void);
+	if (!inited) {
+		if (!ia64_platform_is("sn2"))
+			return;
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
+static kdev_t
+sal_cons_console_device(struct console *c)
+{
+	return MKDEV(TTY_MAJOR, 64 + c->index);
+}
+
+
+static int __init
+sal_cons_console_setup(struct console *co, char *options)
+{
+	return 0;
+}
+
+
+static struct console sal_console = {
+	name:	"ttyS",
+	write:	sal_cons_console_write,
+	device:	sal_cons_console_device,
+	setup:	sal_cons_console_setup,
+	flags:	0,
+	index:	-1
+};
+
+/*
+ *
+ * End of kernel console definitions.
+ *********************************************************************/
+
+
+
+#ifdef CONFIG_SGI_SN_SERIAL_CONSOLE
+/*
+ *	Register console.
+ */
+void __init
+sgi_sn_serial_console_init(void)
+{
+	if (ia64_platform_is("sn2"))
+		register_console(&sal_console);
+}
+
+#endif /* CONFIG_SGI_SN_SERIAL_CONSOLE */
diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Tue Jul 15 16:15:34 2003
+++ b/drivers/char/tty_io.c	Tue Jul 15 16:15:34 2003
@@ -152,7 +152,7 @@
 extern void tub3270_init(void);
 extern void rs285_console_init(void);
 extern void sa1100_rs_console_init(void);
-extern void sgi_serial_console_init(void);
+extern void sgi_sn_serial_console_init(void);
 extern void sci_console_init(void);
 extern void tx3912_console_init(void);
 extern void tx3912_rs_init(void);
@@ -2238,6 +2238,9 @@
 #ifdef CONFIG_AU1000_SERIAL_CONSOLE
 	au1000_serial_console_init();
 #endif
+#ifdef CONFIG_SGI_SN_SERIAL_CONSOLE
+	sgi_sn_serial_console_init();
+#endif
 #ifdef CONFIG_SERIAL_CONSOLE
 #if (defined(CONFIG_8xx) || defined(CONFIG_8260))
 	console_8xx_init();
@@ -2253,9 +2256,6 @@
 #elif defined(CONFIG_SERIAL)
 	serial_console_init();
 #endif /* CONFIG_8xx */
-#ifdef CONFIG_SGI_SERIAL
-	sgi_serial_console_init();
-#endif
 #if defined(CONFIG_MVME162_SCC) || defined(CONFIG_BVME6000_SCC) || defined(CONFIG_MVME147_SCC)
 	vme_scc_console_init();
 #endif
