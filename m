Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWCVGp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWCVGp2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbWCVGo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:44:58 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:52864 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750881AbWCVGh6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:37:58 -0500
Message-Id: <20060322063804.956561000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
Date: Tue, 21 Mar 2006 22:31:09 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 29/35] Add the Xen virtual console driver.
Content-Disposition: inline; filename=28-xen-console
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This provides a bootstrap and ongoing emergency console which is
intended to be available from very early during boot and at all times
thereafter, in contrast with alternatives such as UDP-based syslogd,
or logging in via ssh. The protocol is based on a simple shared-memory
ring buffer.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/Makefile                   |    1 
 drivers/char/tty_io.c              |    7 
 drivers/xen/Makefile               |    2 
 drivers/xen/console/Makefile       |    2 
 drivers/xen/console/console.c      |  633 +++++++++++++++++++++++++++++++++++++
 drivers/xen/console/xencons_ring.c |  115 ++++++
 include/xen/xencons.h              |   14 
 7 files changed, 773 insertions(+), 1 deletion(-)

--- xen-subarch-2.6.orig/drivers/Makefile
+++ xen-subarch-2.6/drivers/Makefile
@@ -34,6 +34,7 @@ obj-y				+= base/ block/ misc/ mfd/ net/
 obj-$(CONFIG_NUBUS)		+= nubus/
 obj-$(CONFIG_ATM)		+= atm/
 obj-$(CONFIG_PPC_PMAC)		+= macintosh/
+obj-$(CONFIG_XEN)		+= xen/
 obj-$(CONFIG_IDE)		+= ide/
 obj-$(CONFIG_FC4)		+= fc4/
 obj-$(CONFIG_SCSI)		+= scsi/
--- xen-subarch-2.6.orig/drivers/char/tty_io.c
+++ xen-subarch-2.6/drivers/char/tty_io.c
@@ -132,6 +132,8 @@ LIST_HEAD(tty_drivers);			/* linked list
    vt.c for deeply disgusting hack reasons */
 DECLARE_MUTEX(tty_sem);
 
+int console_use_vt = 1;
+
 #ifdef CONFIG_UNIX98_PTYS
 extern struct tty_driver *ptm_driver;	/* Unix98 pty masters; for /dev/ptmx */
 extern int pty_limit;		/* Config limit on Unix98 ptys */
@@ -2054,7 +2056,7 @@ retry_open:
 		goto got_driver;
 	}
 #ifdef CONFIG_VT
-	if (device == MKDEV(TTY_MAJOR,0)) {
+	if (console_use_vt && (device == MKDEV(TTY_MAJOR,0))) {
 		extern struct tty_driver *console_driver;
 		driver = console_driver;
 		index = fg_console;
@@ -3237,6 +3239,8 @@ static int __init tty_init(void)
 #endif
 
 #ifdef CONFIG_VT
+	if (!console_use_vt)
+		goto out_vt;
 	cdev_init(&vc0_cdev, &console_fops);
 	if (cdev_add(&vc0_cdev, MKDEV(TTY_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/vc/0") < 0)
@@ -3245,6 +3249,7 @@ static int __init tty_init(void)
 	class_device_create(tty_class, NULL, MKDEV(TTY_MAJOR, 0), NULL, "tty0");
 
 	vty_init();
+ out_vt:
 #endif
 	return 0;
 }
--- /dev/null
+++ xen-subarch-2.6/drivers/xen/Makefile
@@ -0,0 +1,2 @@
+
+obj-y	+= console/
--- /dev/null
+++ xen-subarch-2.6/drivers/xen/console/Makefile
@@ -0,0 +1,2 @@
+
+obj-y	:= console.o xencons_ring.o
--- /dev/null
+++ xen-subarch-2.6/drivers/xen/console/console.c
@@ -0,0 +1,633 @@
+/******************************************************************************
+ * console.c
+ * 
+ * Virtual console driver.
+ * 
+ * Copyright (c) 2002-2004, K A Fraser.
+ * 
+ * This file may be distributed separately from the Linux kernel, or
+ * incorporated into other software packages, subject to the following license:
+ * 
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this source file (the "Software"), to deal in the Software without
+ * restriction, including without limitation the rights to use, copy, modify,
+ * merge, publish, distribute, sublicense, and/or sell copies of the Software,
+ * and to permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ * 
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ * 
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ */
+
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/serial.h>
+#include <linux/major.h>
+#include <linux/ptrace.h>
+#include <linux/ioport.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/bootmem.h>
+#include <linux/sysrq.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+#include <xen/interface/xen.h>
+#include <xen/interface/event_channel.h>
+#include <asm/hypervisor.h>
+#include <xen/evtchn.h>
+#include <xen/xencons.h>
+
+/*
+ * Modes:
+ *  'xencons=off'  [XC_OFF]:     Console is disabled.
+ *  'xencons=tty'  [XC_TTY]:     Console attached to '/dev/tty[0-9]+'.
+ *  'xencons=ttyS' [XC_SERIAL]:  Console attached to '/dev/ttyS[0-9]+'.
+ *                 [XC_DEFAULT]: DOM0 -> XC_SERIAL ; all others -> XC_TTY.
+ * 
+ * NB. In mode XC_TTY, we create dummy consoles for tty2-63. This suppresses
+ * warnings from standard distro startup scripts.
+ */
+static enum { XC_OFF, XC_DEFAULT, XC_TTY, XC_SERIAL } xc_mode = XC_DEFAULT;
+static int xc_num = -1;
+
+#ifdef CONFIG_MAGIC_SYSRQ
+static unsigned long sysrq_requested;
+extern int sysrq_enabled;
+#endif
+
+static int __init xencons_setup(char *str)
+{
+	char *q;
+	int n;
+
+	if (!strncmp(str, "ttyS", 4))
+		xc_mode = XC_SERIAL;
+	else if (!strncmp(str, "tty", 3))
+		xc_mode = XC_TTY;
+	else if (!strncmp(str, "off", 3))
+		xc_mode = XC_OFF;
+
+	switch (xc_mode) {
+	case XC_SERIAL:
+		n = simple_strtol(str+4, &q, 10);
+		if (q > (str + 4))
+			xc_num = n;
+		break;
+	case XC_TTY:
+		n = simple_strtol(str+3, &q, 10);
+		if (q > (str + 3))
+			xc_num = n;
+		break;
+	default:
+		break;
+	}
+
+	return 1;
+}
+__setup("xencons=", xencons_setup);
+
+/* The kernel and user-land drivers share a common transmit buffer. */
+static unsigned int wbuf_size = 4096;
+#define WBUF_MASK(_i) ((_i)&(wbuf_size-1))
+static char *wbuf;
+static unsigned int wc, wp; /* write_cons, write_prod */
+
+static int __init xencons_bufsz_setup(char *str)
+{
+	unsigned int goal;
+	goal = simple_strtoul(str, NULL, 0);
+	while (wbuf_size < goal)
+		wbuf_size <<= 1;
+	return 1;
+}
+__setup("xencons_bufsz=", xencons_bufsz_setup);
+
+/* This lock protects accesses to the common transmit buffer. */
+static spinlock_t xencons_lock = SPIN_LOCK_UNLOCKED;
+
+/* Common transmit-kick routine. */
+static void __xencons_tx_flush(void);
+
+static struct tty_driver *xencons_driver;
+
+/******************** Kernel console driver ********************************/
+
+static void kcons_write(
+	struct console *c, const char *s, unsigned int count)
+{
+	int           i = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&xencons_lock, flags);
+
+	while (i < count) {
+		for (; i < count; i++) {
+			if ((wp - wc) >= (wbuf_size - 1))
+				break;
+			if ((wbuf[WBUF_MASK(wp++)] = s[i]) == '\n')
+				wbuf[WBUF_MASK(wp++)] = '\r';
+		}
+
+		__xencons_tx_flush();
+	}
+
+	spin_unlock_irqrestore(&xencons_lock, flags);
+}
+
+static void kcons_write_dom0(
+	struct console *c, const char *s, unsigned int count)
+{
+	int rc;
+
+	while ((count > 0) &&
+	       ((rc = HYPERVISOR_console_io(
+			CONSOLEIO_write, count, (char *)s)) > 0)) {
+		count -= rc;
+		s += rc;
+	}
+}
+
+static struct tty_driver *kcons_device(struct console *c, int *index)
+{
+	*index = 0;
+	return xencons_driver;
+}
+
+static struct console kcons_info = {
+	.device	= kcons_device,
+	.flags	= CON_PRINTBUFFER,
+	.index	= -1,
+};
+
+#define __RETCODE 0
+static int __init xen_console_init(void)
+{
+	if (xen_init() < 0)
+		return __RETCODE;
+
+	if (xen_start_info->flags & SIF_INITDOMAIN) {
+		if (xc_mode == XC_DEFAULT)
+			xc_mode = XC_SERIAL;
+		kcons_info.write = kcons_write_dom0;
+		if (xc_mode == XC_SERIAL)
+			kcons_info.flags |= CON_ENABLED;
+	} else {
+		if (xc_mode == XC_DEFAULT)
+			xc_mode = XC_TTY;
+		kcons_info.write = kcons_write;
+	}
+
+	switch (xc_mode) {
+	case XC_SERIAL:
+		strcpy(kcons_info.name, "ttyS");
+		if (xc_num == -1)
+			xc_num = 0;
+		break;
+
+	case XC_TTY:
+		strcpy(kcons_info.name, "tty");
+		if (xc_num == -1)
+			xc_num = 1;
+		break;
+
+	default:
+		return __RETCODE;
+	}
+
+	wbuf = alloc_bootmem(wbuf_size);
+
+	register_console(&kcons_info);
+
+	return __RETCODE;
+}
+console_initcall(xen_console_init);
+
+/*** Useful function for console debugging -- goes straight to Xen. ***/
+asmlinkage int xprintk(const char *fmt, ...)
+{
+	va_list args;
+	int printk_len;
+	static char printk_buf[1024];
+
+	/* Emit the output into the temporary buffer */
+	va_start(args, fmt);
+	printk_len = vsnprintf(printk_buf, sizeof(printk_buf), fmt, args);
+	va_end(args);
+
+	/* Send the processed output directly to Xen. */
+	kcons_write_dom0(NULL, printk_buf, printk_len);
+
+	return 0;
+}
+
+/*** Forcibly flush console data before dying. ***/
+void xencons_force_flush(void)
+{
+	int sz;
+
+	/* Emergency console is synchronous, so there's nothing to flush. */
+	if (xen_start_info->flags & SIF_INITDOMAIN)
+		return;
+
+	/* Spin until console data is flushed through to the daemon. */
+	while (wc != wp) {
+		int sent = 0;
+		if ((sz = wp - wc) == 0)
+			continue;
+		sent = xencons_ring_send(&wbuf[WBUF_MASK(wc)], sz);
+		if (sent > 0)
+			wc += sent;
+	}
+}
+
+
+/******************** User-space console driver (/dev/console) ************/
+
+#define DRV(_d)         (_d)
+#define TTY_INDEX(_tty) ((_tty)->index)
+
+static struct termios *xencons_termios[MAX_NR_CONSOLES];
+static struct termios *xencons_termios_locked[MAX_NR_CONSOLES];
+static struct tty_struct *xencons_tty;
+static int xencons_priv_irq;
+static char x_char;
+
+void xencons_rx(char *buf, unsigned len, struct pt_regs *regs)
+{
+	int           i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&xencons_lock, flags);
+	if (xencons_tty == NULL)
+		goto out;
+
+	for (i = 0; i < len; i++) {
+#ifdef CONFIG_MAGIC_SYSRQ
+		if (sysrq_enabled) {
+			if (buf[i] == '\x0f') { /* ^O */
+				sysrq_requested = jiffies;
+				continue; /* don't print the sysrq key */
+			} else if (sysrq_requested) {
+				unsigned long sysrq_timeout =
+					sysrq_requested + HZ*2;
+				sysrq_requested = 0;
+				if (time_before(jiffies, sysrq_timeout)) {
+					spin_unlock_irqrestore(
+						&xencons_lock, flags);
+					handle_sysrq(
+						buf[i], regs, xencons_tty);
+					spin_lock_irqsave(
+						&xencons_lock, flags);
+					continue;
+				}
+			}
+		}
+#endif
+		tty_insert_flip_char(xencons_tty, buf[i], 0);
+	}
+	tty_flip_buffer_push(xencons_tty);
+
+ out:
+	spin_unlock_irqrestore(&xencons_lock, flags);
+}
+
+static void __xencons_tx_flush(void)
+{
+	int sent, sz, work_done = 0;
+
+	if (x_char) {
+		if (xen_start_info->flags & SIF_INITDOMAIN)
+			kcons_write_dom0(NULL, &x_char, 1);
+		else
+			while (x_char)
+				if (xencons_ring_send(&x_char, 1) == 1)
+					break;
+		x_char = 0;
+		work_done = 1;
+	}
+
+	while (wc != wp) {
+		sz = wp - wc;
+		if (sz > (wbuf_size - WBUF_MASK(wc)))
+			sz = wbuf_size - WBUF_MASK(wc);
+		if (xen_start_info->flags & SIF_INITDOMAIN) {
+			kcons_write_dom0(NULL, &wbuf[WBUF_MASK(wc)], sz);
+			wc += sz;
+		} else {
+			sent = xencons_ring_send(&wbuf[WBUF_MASK(wc)], sz);
+			if (sent == 0)
+				break;
+			wc += sent;
+		}
+		work_done = 1;
+	}
+
+	if (work_done && (xencons_tty != NULL)) {
+		wake_up_interruptible(&xencons_tty->write_wait);
+		if ((xencons_tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
+		    (xencons_tty->ldisc.write_wakeup != NULL))
+			(xencons_tty->ldisc.write_wakeup)(xencons_tty);
+	}
+}
+
+void xencons_tx(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&xencons_lock, flags);
+	__xencons_tx_flush();
+	spin_unlock_irqrestore(&xencons_lock, flags);
+}
+
+/* Privileged receive callback and transmit kicker. */
+static irqreturn_t xencons_priv_interrupt(int irq, void *dev_id,
+                                          struct pt_regs *regs)
+{
+	static char rbuf[16];
+	int         l;
+
+	while ((l = HYPERVISOR_console_io(CONSOLEIO_read, 16, rbuf)) > 0)
+		xencons_rx(rbuf, l, regs);
+
+	xencons_tx();
+
+	return IRQ_HANDLED;
+}
+
+static int xencons_write_room(struct tty_struct *tty)
+{
+	return wbuf_size - (wp - wc);
+}
+
+static int xencons_chars_in_buffer(struct tty_struct *tty)
+{
+	return wp - wc;
+}
+
+static void xencons_send_xchar(struct tty_struct *tty, char ch)
+{
+	unsigned long flags;
+
+	if (TTY_INDEX(tty) != 0)
+		return;
+
+	spin_lock_irqsave(&xencons_lock, flags);
+	x_char = ch;
+	__xencons_tx_flush();
+	spin_unlock_irqrestore(&xencons_lock, flags);
+}
+
+static void xencons_throttle(struct tty_struct *tty)
+{
+	if (TTY_INDEX(tty) != 0)
+		return;
+
+	if (I_IXOFF(tty))
+		xencons_send_xchar(tty, STOP_CHAR(tty));
+}
+
+static void xencons_unthrottle(struct tty_struct *tty)
+{
+	if (TTY_INDEX(tty) != 0)
+		return;
+
+	if (I_IXOFF(tty)) {
+		if (x_char != 0)
+			x_char = 0;
+		else
+			xencons_send_xchar(tty, START_CHAR(tty));
+	}
+}
+
+static void xencons_flush_buffer(struct tty_struct *tty)
+{
+	unsigned long flags;
+
+	if (TTY_INDEX(tty) != 0)
+		return;
+
+	spin_lock_irqsave(&xencons_lock, flags);
+	wc = wp = 0;
+	spin_unlock_irqrestore(&xencons_lock, flags);
+}
+
+static inline int __xencons_put_char(int ch)
+{
+	char _ch = (char)ch;
+	if ((wp - wc) == wbuf_size)
+		return 0;
+	wbuf[WBUF_MASK(wp++)] = _ch;
+	return 1;
+}
+
+static int xencons_write(
+	struct tty_struct *tty,
+	const unsigned char *buf,
+	int count)
+{
+	int i;
+	unsigned long flags;
+
+	if (TTY_INDEX(tty) != 0)
+		return count;
+
+	spin_lock_irqsave(&xencons_lock, flags);
+
+	for (i = 0; i < count; i++)
+		if (!__xencons_put_char(buf[i]))
+			break;
+
+	if (i != 0)
+		__xencons_tx_flush();
+
+	spin_unlock_irqrestore(&xencons_lock, flags);
+
+	return i;
+}
+
+static void xencons_put_char(struct tty_struct *tty, u_char ch)
+{
+	unsigned long flags;
+
+	if (TTY_INDEX(tty) != 0)
+		return;
+
+	spin_lock_irqsave(&xencons_lock, flags);
+	(void)__xencons_put_char(ch);
+	spin_unlock_irqrestore(&xencons_lock, flags);
+}
+
+static void xencons_flush_chars(struct tty_struct *tty)
+{
+	unsigned long flags;
+
+	if (TTY_INDEX(tty) != 0)
+		return;
+
+	spin_lock_irqsave(&xencons_lock, flags);
+	__xencons_tx_flush();
+	spin_unlock_irqrestore(&xencons_lock, flags);
+}
+
+static void xencons_wait_until_sent(struct tty_struct *tty, int timeout)
+{
+	unsigned long orig_jiffies = jiffies;
+
+	if (TTY_INDEX(tty) != 0)
+		return;
+
+	while (DRV(tty->driver)->chars_in_buffer(tty)) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(1);
+		if (signal_pending(current))
+			break;
+		if (timeout && time_after(jiffies, orig_jiffies + timeout))
+			break;
+	}
+
+	set_current_state(TASK_RUNNING);
+}
+
+static int xencons_open(struct tty_struct *tty, struct file *filp)
+{
+	unsigned long flags;
+
+	if (TTY_INDEX(tty) != 0)
+		return 0;
+
+	spin_lock_irqsave(&xencons_lock, flags);
+	tty->driver_data = NULL;
+	if (xencons_tty == NULL)
+		xencons_tty = tty;
+	__xencons_tx_flush();
+	spin_unlock_irqrestore(&xencons_lock, flags);
+
+	return 0;
+}
+
+static void xencons_close(struct tty_struct *tty, struct file *filp)
+{
+	unsigned long flags;
+
+	if (TTY_INDEX(tty) != 0)
+		return;
+
+	if (tty->count == 1) {
+		tty->closing = 1;
+		tty_wait_until_sent(tty, 0);
+		if (DRV(tty->driver)->flush_buffer != NULL)
+			DRV(tty->driver)->flush_buffer(tty);
+		if (tty->ldisc.flush_buffer != NULL)
+			tty->ldisc.flush_buffer(tty);
+		tty->closing = 0;
+		spin_lock_irqsave(&xencons_lock, flags);
+		xencons_tty = NULL;
+		spin_unlock_irqrestore(&xencons_lock, flags);
+	}
+}
+
+static struct tty_operations xencons_ops = {
+	.open = xencons_open,
+	.close = xencons_close,
+	.write = xencons_write,
+	.write_room = xencons_write_room,
+	.put_char = xencons_put_char,
+	.flush_chars = xencons_flush_chars,
+	.chars_in_buffer = xencons_chars_in_buffer,
+	.send_xchar = xencons_send_xchar,
+	.flush_buffer = xencons_flush_buffer,
+	.throttle = xencons_throttle,
+	.unthrottle = xencons_unthrottle,
+	.wait_until_sent = xencons_wait_until_sent,
+};
+
+static int __init xencons_init(void)
+{
+	int rc;
+
+	if (xen_init() < 0)
+		return -ENODEV;
+
+	if (xc_mode == XC_OFF)
+		return 0;
+
+	xencons_ring_init();
+
+	xencons_driver = alloc_tty_driver((xc_mode == XC_SERIAL) ?
+					  1 : MAX_NR_CONSOLES);
+	if (xencons_driver == NULL)
+		return -ENOMEM;
+
+	DRV(xencons_driver)->name            = "xencons";
+	DRV(xencons_driver)->major           = TTY_MAJOR;
+	DRV(xencons_driver)->type            = TTY_DRIVER_TYPE_SERIAL;
+	DRV(xencons_driver)->subtype         = SERIAL_TYPE_NORMAL;
+	DRV(xencons_driver)->init_termios    = tty_std_termios;
+	DRV(xencons_driver)->flags           =
+		TTY_DRIVER_REAL_RAW |
+		TTY_DRIVER_RESET_TERMIOS |
+		TTY_DRIVER_NO_DEVFS;
+	DRV(xencons_driver)->termios         = xencons_termios;
+	DRV(xencons_driver)->termios_locked  = xencons_termios_locked;
+
+	if (xc_mode == XC_SERIAL) {
+		DRV(xencons_driver)->name        = "ttyS";
+		DRV(xencons_driver)->minor_start = 64 + xc_num;
+		DRV(xencons_driver)->name_base   = 0 + xc_num;
+	} else {
+		DRV(xencons_driver)->name        = "tty";
+		DRV(xencons_driver)->minor_start = xc_num;
+		DRV(xencons_driver)->name_base   = xc_num;
+	}
+
+	tty_set_operations(xencons_driver, &xencons_ops);
+
+	if ((rc = tty_register_driver(DRV(xencons_driver))) != 0) {
+		printk("WARNING: Failed to register Xen virtual "
+		       "console driver as '%s%d'\n",
+		       DRV(xencons_driver)->name,
+		       DRV(xencons_driver)->name_base);
+		put_tty_driver(xencons_driver);
+		xencons_driver = NULL;
+		return rc;
+	}
+
+	tty_register_device(xencons_driver, 0, NULL);
+
+	if (xen_start_info->flags & SIF_INITDOMAIN) {
+		xencons_priv_irq = bind_virq_to_irqhandler(
+			VIRQ_CONSOLE,
+			0,
+			xencons_priv_interrupt,
+			0,
+			"console",
+			NULL);
+		BUG_ON(xencons_priv_irq < 0);
+	}
+
+	printk("Xen virtual console successfully installed as %s%d\n",
+	       DRV(xencons_driver)->name,
+	       DRV(xencons_driver)->name_base );
+
+	return 0;
+}
+
+module_init(xencons_init);
--- /dev/null
+++ xen-subarch-2.6/drivers/xen/console/xencons_ring.c
@@ -0,0 +1,115 @@
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/serial.h>
+#include <linux/major.h>
+#include <linux/ptrace.h>
+#include <linux/ioport.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+
+#include <asm/hypervisor.h>
+#include <xen/evtchn.h>
+#include <xen/xencons.h>
+#include <linux/wait.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <linux/err.h>
+#include <xen/interface/io/console.h>
+
+static int xencons_irq;
+
+static inline struct xencons_interface *xencons_interface(void)
+{
+	return mfn_to_virt(xen_start_info->console_mfn);
+}
+
+static inline void notify_daemon(void)
+{
+	/* Use evtchn: this is called early, before irq is set up. */
+	notify_remote_via_evtchn(xen_start_info->console_evtchn);
+}
+
+int xencons_ring_send(const char *data, unsigned len)
+{
+	int sent = 0;
+	struct xencons_interface *intf = xencons_interface();
+	XENCONS_RING_IDX cons, prod;
+
+	cons = intf->out_cons;
+	prod = intf->out_prod;
+	mb();
+	BUG_ON((prod - cons) > sizeof(intf->out));
+
+	while ((sent < len) && ((prod - cons) < sizeof(intf->out)))
+		intf->out[MASK_XENCONS_IDX(prod++, intf->out)] = data[sent++];
+
+	wmb();
+	intf->out_prod = prod;
+
+	notify_daemon();
+
+	return sent;
+}
+
+static irqreturn_t handle_input(int irq, void *unused, struct pt_regs *regs)
+{
+	struct xencons_interface *intf = xencons_interface();
+	XENCONS_RING_IDX cons, prod;
+
+	cons = intf->in_cons;
+	prod = intf->in_prod;
+	mb();
+	BUG_ON((prod - cons) > sizeof(intf->in));
+
+	while (cons != prod) {
+		xencons_rx(intf->in+MASK_XENCONS_IDX(cons,intf->in), 1, regs);
+		cons++;
+	}
+
+	mb();
+	intf->in_cons = cons;
+
+	notify_daemon();
+
+	xencons_tx();
+
+	return IRQ_HANDLED;
+}
+
+int xencons_ring_init(void)
+{
+	int err;
+
+	if (xencons_irq)
+		unbind_from_irqhandler(xencons_irq, NULL);
+	xencons_irq = 0;
+
+	if (!xen_start_info->console_evtchn)
+		return 0;
+
+	err = bind_evtchn_to_irqhandler(
+		xen_start_info->console_evtchn,
+		handle_input, 0, "xencons", NULL);
+	if (err <= 0) {
+		printk(KERN_ERR "XEN console request irq failed %i\n", err);
+		return err;
+	}
+
+	xencons_irq = err;
+
+	/* In case we have in-flight data after save/restore... */
+	notify_daemon();
+
+	return 0;
+}
+
+void xencons_resume(void)
+{
+	(void)xencons_ring_init();
+}
--- /dev/null
+++ xen-subarch-2.6/include/xen/xencons.h
@@ -0,0 +1,14 @@
+#ifndef __ASM_XENCONS_H__
+#define __ASM_XENCONS_H__
+
+void xencons_force_flush(void);
+void xencons_resume(void);
+
+/* Interrupt work hooks. Receive data, or kick data out. */
+void xencons_rx(char *buf, unsigned len, struct pt_regs *regs);
+void xencons_tx(void);
+
+int xencons_ring_init(void);
+int xencons_ring_send(const char *data, unsigned len);
+
+#endif /* __ASM_XENCONS_H__ */

--
