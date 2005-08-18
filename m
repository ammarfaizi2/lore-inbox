Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbVHRRwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbVHRRwH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 13:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbVHRRwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 13:52:07 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:61688 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932353AbVHRRwG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 13:52:06 -0400
Message-Id: <200508181752.j7IHq2Qq001692@d03av02.boulder.ibm.com>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Subject: [PATCH 3/4] ppc64: add RTAS console driver
Date: Thu, 18 Aug 2005 19:40:56 +0200
User-Agent: KMail/1.7.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <200508181931.43481.arnd@arndb.de>
In-Reply-To: <200508181931.43481.arnd@arndb.de>
X-KMail-CryptoFormat: 15
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The RTAS console driver can be used by all machines that abstract
the system console through the {get,put}-term-char interface.
It replaces the hvconsole on BPA, because we don't run under
a hypervisor.

This driver needs to be redone as a special case of hvconsole,
so there is no point in applying the patch to generic kernels.
You will however need it if you intend to run on present Cell
hardware.

From: Utz Bacher <utz.bacher@de.ibm.com>
Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--- linux-cg.orig/drivers/char/Kconfig	2005-08-18 17:09:44.971886072 -0400
+++ linux-cg/drivers/char/Kconfig	2005-08-18 17:30:54.496933408 -0400
@@ -560,6 +560,12 @@ config HVC_CONSOLE
 	  console. This driver allows each pSeries partition to have a console
 	  which is accessed via the HMC.
 
+config RTASCONS
+        bool "RTAS firmware console support"
+        depends on PPC_RTAS
+        help
+          RTAS console support.
+
 config HVCS
 	tristate "IBM Hypervisor Virtual Console Server support"
 	depends on PPC_PSERIES
--- linux-cg.orig/drivers/char/Makefile	2005-08-18 17:09:44.974885616 -0400
+++ linux-cg/drivers/char/Makefile	2005-08-18 17:30:54.497933256 -0400
@@ -40,6 +40,7 @@ obj-$(CONFIG_N_HDLC)		+= n_hdlc.o
 obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
 obj-$(CONFIG_SX)		+= sx.o generic_serial.o
 obj-$(CONFIG_RIO)		+= rio/ generic_serial.o
+obj-$(CONFIG_RTASCONS)		+= rtascons.o
 obj-$(CONFIG_HVC_CONSOLE)	+= hvc_console.o hvc_vio.o hvsi.o
 obj-$(CONFIG_RAW_DRIVER)	+= raw.o
 obj-$(CONFIG_SGI_SNSC)		+= snsc.o snsc_event.o
--- linux-cg.orig/drivers/char/rtascons.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/drivers/char/rtascons.c	2005-08-18 17:31:21.912892064 -0400
@@ -0,0 +1,339 @@
+/*
+ * console driver using RTAS calls
+ *
+ * (C) Copyright IBM Corp. 2004
+ * RTAS console driver
+ *
+ * Author: Utz Bacher <utz.bacher@de.ibm.com>
+ *
+ *    inspired by drivers/char/hvc_console.c
+ *    written by Anton Blanchard and Paul Mackerras
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/* The whole driver assumes we only have one RTAS console. This makes
+ * things pretty easy. */
+
+#include <linux/console.h>
+#include <linux/cpumask.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/major.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/sysrq.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <asm/atomic.h>
+#include <asm/rtas.h>
+#include <asm/uaccess.h>
+
+
+#define RTASCONS_MAJOR		229
+#define RTASCONS_MINOR		0
+
+#define RTASCONS_SYSRQ_KEY	'\x0f'
+
+#define RTASCONS_PUT_ATTEMPTS	16
+#define RTASCONS_PUT_DELAY	100
+#define RTASCONS_BUFFER_SIZE	4096
+
+#define RTASCONS_MAX_POLL	50
+#define RTASCONS_WRITE_ROOM	200
+
+#define RTASCONS_TIMEOUT	((HZ + 99) / 100)
+
+
+static struct tty_driver *rtascons_ttydriver;
+
+static atomic_t rtascons_usecount = ATOMIC_INIT(0);
+static struct tty_struct *rtascons_tty;
+
+static int rtascons_put_char_token;
+static int rtascons_get_char_token;
+
+static spinlock_t rtascons_buffer_lock = SPIN_LOCK_UNLOCKED;
+static char rtascons_buffer[RTASCONS_BUFFER_SIZE];
+static int rtascons_buffer_head = 0;
+static int rtascons_buffer_used = 0;
+
+static int
+rtascons_get_char(void)
+{
+	int result;
+
+	if (rtas_call(rtascons_get_char_token, 0, 2, &result))
+		result = -1;
+
+	return result;
+}
+
+/* assumes that rtascons_buffer_lock is held */
+static void
+rtascons_flush_chars(void)
+{
+	int result;
+	int attempts = RTASCONS_PUT_ATTEMPTS;
+
+	/* if there is more than one character to be displayed, wait a bit */
+	for (; rtascons_buffer_used && attempts; udelay(RTASCONS_PUT_DELAY)) {
+		attempts--;
+		result = rtas_call(rtascons_put_char_token, 1, 1, NULL,
+				   rtascons_buffer[rtascons_buffer_head]);
+
+		if (!result) {
+			rtascons_buffer_head = (rtascons_buffer_head + 1) %
+				RTASCONS_BUFFER_SIZE;
+			rtascons_buffer_used--;
+		}
+	}
+}
+
+static void
+rtascons_put_char(char c)
+{
+	spin_lock(&rtascons_buffer_lock);
+
+	if (rtascons_buffer_used >= (RTASCONS_BUFFER_SIZE / 2))
+		udelay(RTASCONS_PUT_DELAY); /* slow down if buffer tends
+					       to get full */
+
+	if (rtascons_buffer_used >= RTASCONS_BUFFER_SIZE)
+		goto out; /* we're loosing characters. */
+
+	/* enqueue character */
+	rtascons_buffer[(rtascons_buffer_head + rtascons_buffer_used) %
+		RTASCONS_BUFFER_SIZE] = c;
+	rtascons_buffer_used++;
+out:
+	rtascons_flush_chars();
+
+	spin_unlock(&rtascons_buffer_lock);
+}
+
+static void
+rtascons_print_str(const char *buf, int count)
+{
+	int i = 0;
+	while (i < count) {
+		rtascons_put_char(buf[i]);
+		if (buf[i] == '\n')
+			rtascons_put_char('\r');
+		i++;
+	}
+}
+
+static int
+rtascons_open(struct tty_struct *tty, struct file *filp)
+{
+	/* only one console */
+	if (tty->index) {
+		/* close will be called and that decrement */
+		atomic_inc(&rtascons_usecount);
+		return -ENODEV;
+	}
+
+	if (atomic_inc_return(&rtascons_usecount) == 1) {
+		rtascons_tty = tty;
+	}
+
+	tty->driver_data = &rtascons_ttydriver;
+
+	return 0;
+}
+
+static void
+rtascons_close(struct tty_struct *tty, struct file * filp)
+{
+	atomic_dec(&rtascons_usecount);
+}
+
+static void
+rtascons_hangup(struct tty_struct *tty)
+{
+}
+
+static int
+rtascons_write(struct tty_struct *tty, const unsigned char *buf, int count)
+{
+	if (!atomic_read(&rtascons_usecount))
+		return 0;
+
+	rtascons_print_str(buf, count);
+
+	return count;
+}
+
+static int
+rtascons_write_room(struct tty_struct *tty)
+{
+	return RTASCONS_WRITE_ROOM;
+}
+
+static int
+rtascons_chars_in_buffer(struct tty_struct *tty)
+{
+	return 0;
+}
+
+static void
+rtascons_poll(void)
+{
+	int i;
+	int do_poll = RTASCONS_MAX_POLL;
+#ifdef CONFIG_MAGIC_SYSRQ
+	static int sysrq_pressed = 0;
+#endif /* CONFIG_MAGIC_SYSRQ */
+
+	if (!atomic_read(&rtascons_usecount))
+		return;
+
+	while (do_poll--) {
+		i = rtascons_get_char();
+		if (i < 0)
+			break;
+
+#ifdef CONFIG_MAGIC_SYSRQ
+		if (i == RTASCONS_SYSRQ_KEY) {
+			sysrq_pressed = 1;
+			continue;
+		} else if (sysrq_pressed) {
+			handle_sysrq(i, NULL, rtascons_tty);
+			sysrq_pressed = 0;
+			continue;
+		}
+#endif /* CONFIG_MAGIC_SYSRQ */
+
+		tty_insert_flip_char(rtascons_tty, (unsigned char) i, 0);
+	}
+
+	tty_flip_buffer_push(rtascons_tty);
+}
+
+#if defined(CONFIG_XMON) && defined(CONFIG_SMP)
+extern cpumask_t cpus_in_xmon;
+#else
+static const cpumask_t cpus_in_xmon = CPU_MASK_NONE;
+#endif
+
+static int
+krtasconsd(void *unused)
+{
+	daemonize("krtasconsd");
+
+	for (;;) {
+		if (cpus_empty(cpus_in_xmon)) {
+			rtascons_poll();
+			/* no need for atomic access */
+			if (rtascons_buffer_used) {
+				spin_lock(&rtascons_buffer_lock);
+				rtascons_flush_chars();
+				spin_unlock(&rtascons_buffer_lock);
+			}
+		}
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(RTASCONS_TIMEOUT);
+	}
+}
+
+static struct tty_operations rtascons_ops = {
+	.open = rtascons_open,
+	.close = rtascons_close,
+	.write = rtascons_write,
+	.hangup = rtascons_hangup,
+	.write_room = rtascons_write_room,
+	.chars_in_buffer = rtascons_chars_in_buffer,
+};
+
+static int __init
+rtascons_init(void)
+{
+	rtascons_ttydriver = alloc_tty_driver(1);
+	if (!rtascons_ttydriver)
+		return -ENOMEM;
+
+	rtascons_ttydriver->owner = THIS_MODULE;
+	rtascons_ttydriver->devfs_name = "rtascons/";
+	rtascons_ttydriver->driver_name = "rtascons";
+	rtascons_ttydriver->name = "rtascons";
+	rtascons_ttydriver->major = RTASCONS_MAJOR;
+	rtascons_ttydriver->minor_start = RTASCONS_MINOR;
+	rtascons_ttydriver->type = TTY_DRIVER_TYPE_SYSTEM;
+	rtascons_ttydriver->subtype = SYSTEM_TYPE_CONSOLE;
+	rtascons_ttydriver->init_termios = tty_std_termios;
+	rtascons_ttydriver->flags = TTY_DRIVER_REAL_RAW;
+	tty_set_operations(rtascons_ttydriver, &rtascons_ops);
+
+	if (tty_register_driver(rtascons_ttydriver))
+		panic("Couldn't register RTAS console driver\n");
+
+	kernel_thread(krtasconsd, NULL, CLONE_KERNEL);
+
+	return 0;
+}
+
+static void __exit
+rtascons_exit(void)
+{
+}
+
+static void
+rtascons_print(struct console *con, const char *buf, unsigned count)
+{
+	rtascons_print_str(buf, count);
+}
+
+static struct tty_driver *rtascons_device(struct console *con, int *index)
+{
+	*index = con->index;
+	return rtascons_ttydriver;
+}
+
+static int __init
+rtascons_setup(struct console *con, char *options)
+{
+	return (con->index);
+}
+
+struct console rtascons_driver = {
+	.name		= "rtas",
+	.write		= rtascons_print,
+	.device		= rtascons_device,
+	.setup		= rtascons_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+};
+
+static int __init
+rtascons_register(void)
+{
+	rtascons_put_char_token = rtas_token("put-term-char");
+	if (rtascons_put_char_token == -1)
+		return -EIO;
+	rtascons_get_char_token = rtas_token("get-term-char");
+	if (rtascons_get_char_token == -1)
+		return -EIO;
+
+	register_console(&rtascons_driver);
+	return 0;
+}
+
+console_initcall(rtascons_register);
+
+module_init(rtascons_init);
+module_exit(rtascons_exit);

