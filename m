Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267098AbTBQNvH>; Mon, 17 Feb 2003 08:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267091AbTBQNtu>; Mon, 17 Feb 2003 08:49:50 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:18304 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267076AbTBQNri>; Mon, 17 Feb 2003 08:47:38 -0500
Date: Mon, 17 Feb 2003 22:56:03 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.61 (5/26) char device
Message-ID: <20030217135603.GE4799@yuzuki.cinet.co.jp>
References: <20030217134333.GA4734@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217134333.GA4734@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.61 (5/26).

Real time clock driver and printer driver for PC98.

diff -Nru linux-2.5.61/drivers/char/Kconfig linux98-2.5.61/drivers/char/Kconfig
--- linux-2.5.61/drivers/char/Kconfig	2003-02-15 08:51:08.000000000 +0900
+++ linux98-2.5.61/drivers/char/Kconfig	2003-02-16 17:19:03.000000000 +0900
@@ -575,6 +575,17 @@
 	  console. This driver allows each pSeries partition to have a console
 	  which is accessed via the HMC.
 
+config PC9800_OLDLP
+	tristate "NEC PC-9800 old-style printer port support"
+	depends on X86_PC9800 && !PARPORT
+	---help---
+	  If you intend to attach a printer to the parallel port of NEC PC-9801
+	  /PC-9821 with OLD compatibility mode, Say Y.
+
+config PC9800_OLDLP_CONSOLE
+	bool "Support for console on line printer"
+	depends on PC9800_OLDLP
+
 source "drivers/i2c/Kconfig"
 
 
@@ -774,7 +785,7 @@
 
 config RTC
 	tristate "Enhanced Real Time Clock Support"
-	depends on !PPC32 && !PARISC && !IA64
+	depends on !PPC32 && !PARISC && !IA64 && !X86_PC9800
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -833,6 +844,15 @@
 	bool "EFI Real Time Clock Services"
 	depends on IA64
 
+config RTC98
+	tristate "NEC PC-9800 Real Time Clock Support"
+	depends on X86_PC9800
+	default y
+	---help---
+	  If you say Y here and create a character special file /dev/rtc with
+	  major number 10 and minor number 135 using mknod ("man mknod"), you
+	  will get access to the real time clock (or hardware clock) built
+
 config H8
 	bool "Tadpole ANA H8 Support (OBSOLETE)"
 	depends on OBSOLETE && ALPHA_BOOK1
diff -Nru linux-2.5.60/drivers/char/Makefile linux98-2.5.60/drivers/char/Makefile
--- linux-2.5.60/drivers/char/Makefile	2003-02-11 03:38:54.000000000 +0900
+++ linux98-2.5.60/drivers/char/Makefile	2003-02-11 11:19:09.000000000 +0900
@@ -44,6 +44,7 @@
 
 obj-$(CONFIG_PRINTER) += lp.o
 obj-$(CONFIG_TIPAR) += tipar.o
+obj-$(CONFIG_PC9800_OLDLP) += lp_old98.o
 
 obj-$(CONFIG_BUSMOUSE) += busmouse.o
 obj-$(CONFIG_DTLK) += dtlk.o
@@ -51,6 +52,7 @@
 obj-$(CONFIG_APPLICOM) += applicom.o
 obj-$(CONFIG_SONYPI) += sonypi.o
 obj-$(CONFIG_RTC) += rtc.o
+obj-$(CONFIG_RTC98) += upd4990a.o
 obj-$(CONFIG_GEN_RTC) += genrtc.o
 obj-$(CONFIG_EFI_RTC) += efirtc.o
 ifeq ($(CONFIG_PPC),)
diff -Nru linux-2.5.61/drivers/char/lp_old98.c linux98-2.5.61/drivers/char/lp_old98.c
--- linux-2.5.61/drivers/char/lp_old98.c	1970-01-01 09:00:00.000000000 +0900
+++ linux98-2.5.61/drivers/char/lp_old98.c	2003-02-17 19:10:26.000000000 +0900
@@ -0,0 +1,555 @@
+/*
+ *	linux/drivers/char/lp_old98.c
+ *
+ * printer port driver for ancient PC-9800s with no bidirectional port support
+ *
+ * Copyright (C)  1998,99  Kousuke Takai <tak@kmc.kyoto-u.ac.jp>,
+ *			   Kyoto University Microcomputer Club
+ *
+ * This driver is based on and has compatibility with `lp.c',
+ * generic PC printer port driver.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/major.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/ioport.h>
+#include <linux/fcntl.h>
+#include <linux/delay.h>
+#include <linux/console.h>
+#include <linux/version.h>
+#include <linux/fs.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+
+#include <linux/lp.h>
+
+/*
+ *  I/O port numbers
+ */
+#define	LP_PORT_DATA	0x40
+#define	LP_PORT_STATUS	(LP_PORT_DATA + 2)
+#define	LP_PORT_STROBE	(LP_PORT_DATA + 4)
+#define LP_PORT_CONTROL	(LP_PORT_DATA + 6)
+
+#define	LP_PORT_H98MODE	0x0448
+#define	LP_PORT_EXTMODE	0x0149
+
+/*
+ *  bit mask for I/O
+ */
+#define	LP_MASK_nBUSY	(1 << 2)
+#define	LP_MASK_nSTROBE	(1 << 7)
+
+#define LP_CONTROL_ASSERT_STROBE	(0x0e)
+#define LP_CONTROL_NEGATE_STROBE	(0x0f)
+
+/*
+ *  Acceptable maximum value for non-privileged user for LPCHARS ioctl.
+ */
+#define LP_CHARS_NOPRIV_MAX	65535
+
+#define	DC1	'\x11'
+#define	DC3	'\x13'
+
+/* PC-9800s have at least and at most one old-style printer port. */
+static struct lp_struct lp = {
+	/* Following `TAG: INITIALIZER' notations are GNU CC extension. */
+	.flags	= LP_EXIST | LP_ABORTOPEN,
+	.chars	= LP_INIT_CHAR,
+	.time	= LP_INIT_TIME,
+	.wait	= LP_INIT_WAIT,
+};
+
+static	int	dc1_check	= 0;
+static spinlock_t lp_old98_lock = SPIN_LOCK_UNLOCKED;
+
+
+#undef LP_OLD98_DEBUG
+
+#ifdef CONFIG_PC9800_OLDLP_CONSOLE
+static struct console lp_old98_console;		/* defined later */
+static __typeof__(lp_old98_console.flags) saved_console_flags;
+#endif
+
+static DECLARE_WAIT_QUEUE_HEAD (lp_old98_waitq);
+
+static void lp_old98_timer_function(unsigned long data);
+
+static void lp_old98_timer_function(unsigned long data)
+{
+	if (inb(LP_PORT_STATUS) & LP_MASK_nBUSY)
+		wake_up_interruptible(&lp_old98_waitq);
+	else {
+		struct timer_list *t = (struct timer_list *) data;
+
+		t->expires = jiffies + 1;
+		add_timer(t);
+	}
+}
+
+static inline int lp_old98_wait_ready(void)
+{
+	struct timer_list timer;
+
+	init_timer(&timer);
+	timer.function = lp_old98_timer_function;
+	timer.expires = jiffies + 1;
+	timer.data = (unsigned long)&timer;
+	add_timer(&timer);
+	interruptible_sleep_on(&lp_old98_waitq);
+	del_timer(&timer);
+	return signal_pending(current);
+}
+
+static inline int lp_old98_char(char lpchar)
+{
+	unsigned long count = 0;
+#ifdef LP_STATS
+	int tmp;
+#endif
+
+	while (!(inb(LP_PORT_STATUS) & LP_MASK_nBUSY)) {
+		count++;
+		if (count >= lp.chars)
+			return 0;
+	}
+
+	outb(lpchar, LP_PORT_DATA);
+
+#ifdef LP_STATS
+	/*
+	 *  Update lp statsistics here (and between next two outb()'s).
+	 *  Time to compute it is part of storobe delay.
+	 */
+	if (count > lp.stats.maxwait) {
+#ifdef LP_OLD98_DEBUG
+		printk(KERN_DEBUG "lp_old98: success after %d counts.\n",
+		       count);
+#endif
+		lp.stats.maxwait = count;
+	}
+	count *= 256;
+	tmp = count - lp.stats.meanwait;
+	if (tmp < 0)
+		tmp = -tmp;
+#endif
+	__const_udelay(lp.wait * 4);
+    
+	/* negate PSTB# (activate strobe)	*/
+	outb(LP_CONTROL_ASSERT_STROBE, LP_PORT_CONTROL);
+
+#ifdef LP_STATS
+	lp.stats.meanwait = (255 * lp.stats.meanwait + count + 128) / 256;
+	lp.stats.mdev = (127 * lp.stats.mdev + tmp + 64) / 128;
+	lp.stats.chars ++;
+#endif
+
+	__const_udelay(lp.wait * 4);
+
+	/* assert PSTB# (deactivate strobe)	*/
+	outb(LP_CONTROL_NEGATE_STROBE, LP_PORT_CONTROL);
+
+	return 1;
+}
+
+#if LINUX_VERSION_CODE < 0x20200
+static long lp_old98_write(struct inode * inode, struct file * file,
+			   const char * buf, unsigned long count)
+#else
+static ssize_t lp_old98_write(struct file * file,
+			      const char * buf, size_t count,
+			      loff_t *dummy)
+#endif    
+{
+	unsigned long total_bytes_written = 0;
+
+	if (!access_ok(VERIFY_READ, buf, count))
+		return -EFAULT;
+
+#ifdef LP_STATS
+	if (jiffies - lp.lastcall > lp.time)
+		lp.runchars = 0;
+	lp.lastcall = jiffies;
+#endif
+
+	do {
+		unsigned long bytes_written = 0;
+		unsigned long copy_size
+			= (count < LP_BUFFER_SIZE ? count : LP_BUFFER_SIZE);
+
+		if (__copy_from_user(lp.lp_buffer, buf, copy_size))
+			return -EFAULT;
+
+		while (bytes_written < copy_size) {
+			if (lp_old98_char(lp.lp_buffer[bytes_written]))
+				bytes_written ++;
+			else {
+#ifdef LP_STATS
+				int rc = lp.runchars + bytes_written;
+
+				if (rc > lp.stats.maxrun)
+					lp.stats.maxrun = rc;
+
+				lp.stats.sleeps ++;
+#endif
+#ifdef LP_OLD98_DEBUG
+				printk(KERN_DEBUG
+				       "lp_old98: sleeping at %d characters"
+				       " for %d jiffies\n",
+				       lp.runchars, lp.time);
+				lp.runchars = 0;
+#endif
+				if (lp_old98_wait_ready())
+					return ((total_bytes_written
+						 + bytes_written)
+						? : -EINTR);
+			}
+		}
+		total_bytes_written += bytes_written;
+		buf += bytes_written;
+#ifdef LP_STATS
+		lp.runchars += bytes_written;
+#endif
+		count -= bytes_written;
+	} while (count > 0);
+
+	return total_bytes_written;
+}
+
+static int lp_old98_open(struct inode * inode, struct file * file)
+{
+	if (minor(inode->i_rdev) != 0)
+		return -ENXIO;
+
+	if (!try_module_get(THIS_MODULE))
+		return -EBUSY;
+
+	if (lp.flags & LP_BUSY)
+		return -EBUSY;
+
+	if (dc1_check && (lp.flags & LP_ABORTOPEN)
+	    && !(file->f_flags & O_NONBLOCK)) {
+		/*
+		 *  Check whether printer is on-line.
+		 *  PC-9800's old style port have only BUSY# as status input,
+		 *  so that it is impossible to distinguish that the printer is
+		 *  ready and that the printer is off-line or not connected
+		 *  (in both case BUSY# is in the same state). So:
+		 *
+		 *    (1) output DC1 (0x11) to printer port and do strobe.
+		 *    (2) watch BUSY# line for a while. If BUSY# is pulled
+		 *	  down, the printer will be ready. Otherwise,
+		 *	  it will be off-line (or not connected, or power-off,
+		 *	   ...).
+		 *
+		 *  The source of this procedure:
+		 *	Terumasa KODAKA, Kazufumi SHIMIZU, Yu HAYAMI:
+		 *		`PC-9801 Super Technique', Ascii, 1992.
+		 */
+		int count;
+		unsigned long flags;
+
+		/* interrupts while check is fairly bad */
+		spin_lock_irqsave(&lp_old98_lock, flags);
+
+		if (!lp_old98_char(DC1)) {
+			spin_unlock_irqrestore(&lp_old98_lock, flags);
+			return -EBUSY;
+		}
+		count = (unsigned int)dc1_check > 10000 ? 10000 : dc1_check;
+		while (inb(LP_PORT_STATUS) & LP_MASK_nBUSY) {
+			if (--count == 0) {
+				spin_unlock_irqrestore(&lp_old98_lock, flags);
+				return -ENODEV;
+			}
+		}
+		spin_unlock_irqrestore(&lp_old98_lock, flags);
+	}
+
+	if ((lp.lp_buffer = kmalloc(LP_BUFFER_SIZE, GFP_KERNEL)) == NULL)
+		return -ENOMEM;
+
+	lp.flags |= LP_BUSY;
+
+#ifdef CONFIG_PC9800_OLDLP_CONSOLE
+	saved_console_flags = lp_old98_console.flags;
+	lp_old98_console.flags &= ~CON_ENABLED;
+#endif
+	return 0;
+}
+
+static int lp_old98_release(struct inode * inode, struct file * file)
+{
+	kfree(lp.lp_buffer);
+	lp.lp_buffer = NULL;
+	lp.flags &= ~LP_BUSY;
+#ifdef CONFIG_PC9800_OLDLP_CONSOLE
+	lp_old98_console.flags = saved_console_flags;
+#endif
+	module_put(THIS_MODULE);
+	return 0;
+}
+
+static int lp_old98_init_device(void)
+{
+	unsigned char data;
+
+	if ((data = inb(LP_PORT_EXTMODE)) != 0xFF && (data & 0x10)) {
+		printk(KERN_INFO
+		       "lp_old98: shutting down extended parallel port mode...\n");
+		outb(data & ~0x10, LP_PORT_EXTMODE);
+	}
+#ifdef	PC98_HW_H98
+	if ((pc98_hw_flags & PC98_HW_H98)
+	    && ((data = inb(LP_PORT_H98MODE)) & 0x01)) {
+		printk(KERN_INFO
+		       "lp_old98: shutting down H98 full centronics mode...\n");
+		outb(data & ~0x01, LP_PORT_H98MODE);
+	}
+#endif
+	return 0;
+}
+
+static int lp_old98_ioctl(struct inode *inode, struct file *file,
+			  unsigned int command, unsigned long arg)
+{
+	int retval = 0;
+
+	switch (command) {
+	case LPTIME:
+		lp.time = arg * HZ/100;
+		break;
+	case LPCHAR:
+		lp.chars = arg;
+		break;
+	case LPABORT:
+		if (arg)
+			lp.flags |= LP_ABORT;
+		else
+			lp.flags &= ~LP_ABORT;
+		break;
+	case LPABORTOPEN:
+		if (arg)
+			lp.flags |= LP_ABORTOPEN;
+		else
+			lp.flags &= ~LP_ABORTOPEN;
+		break;
+	case LPCAREFUL:
+		/* do nothing */
+		break;
+	case LPWAIT:
+		lp.wait = arg;
+		break;
+	case LPGETIRQ:
+		retval = put_user(0, (int *)arg);
+		break;
+	case LPGETSTATUS:
+		/*
+		 * convert PC-9800's status to IBM PC's one, so that tunelp(8)
+		 * works in the same way on this driver.
+		 */
+		retval = put_user((inb(LP_PORT_STATUS) & LP_MASK_nBUSY)
+					? (LP_PBUSY | LP_PERRORP) : LP_PERRORP,
+					(int *)arg);
+		break;
+	case LPRESET:
+		retval = lp_old98_init_device();
+		break;
+#ifdef LP_STATS
+	case LPGETSTATS:
+		if (copy_to_user((struct lp_stats *)arg, &lp.stats,
+				 sizeof(struct lp_stats)))
+			retval = -EFAULT;
+		else if (suser())
+			memset(&lp.stats, 0, sizeof(struct lp_stats));
+		break;
+#endif
+	case LPGETFLAGS:
+		retval = put_user(lp.flags, (int *)arg);
+		break;
+	case LPSETIRQ: 
+	default:
+		retval = -EINVAL;
+	}
+	return retval;
+}
+
+static struct file_operations lp_old98_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= NULL,
+	.write		= lp_old98_write,
+	.ioctl		= lp_old98_ioctl,
+	.open		= lp_old98_open,
+	.release	= lp_old98_release,
+};
+
+/*
+ *  Support for console on lp_old98
+ */
+#ifdef CONFIG_PC9800_OLDLP_CONSOLE
+
+static inline void io_delay(void)
+{
+	unsigned char dummy;	/* actually not output */
+
+	asm volatile ("out%B0 %0,%1" : "=a"(dummy) : "N"(0x5f));
+}
+
+static void lp_old98_console_write(struct console *console,
+				    const char *s, unsigned int count)
+{
+	int i;
+	static unsigned int timeout_run = 0;
+
+	while (count) {
+		/* wait approx 1.2 seconds */
+		for (i = 2000000;
+		     !(inb(LP_PORT_STATUS) & LP_MASK_nBUSY);
+		     io_delay())
+			if (!--i) {
+				if (++timeout_run >= 10)
+					/* disable forever... */
+					console->flags &= ~CON_ENABLED;
+				return;
+			}
+
+		timeout_run = 0;
+
+		if (*s == '\n') {
+			outb('\r', LP_PORT_DATA);
+			io_delay();
+			io_delay();
+			outb(LP_CONTROL_ASSERT_STROBE, LP_PORT_CONTROL);
+			io_delay();
+			io_delay();
+			outb(LP_CONTROL_NEGATE_STROBE, LP_PORT_CONTROL);
+			io_delay();
+			io_delay();
+			for (i = 1000000;
+			     !(inb(LP_PORT_STATUS) & LP_MASK_nBUSY);
+			     io_delay())
+				if (!--i)
+					return;
+		}
+
+		outb(*s++, LP_PORT_DATA);
+		io_delay();
+		io_delay();
+		outb(LP_CONTROL_ASSERT_STROBE, LP_PORT_CONTROL);
+		io_delay();
+		io_delay();
+		outb(LP_CONTROL_NEGATE_STROBE, LP_PORT_CONTROL);
+		io_delay();
+		io_delay();
+
+		--count;
+	}
+}
+
+static kdev_t lp_old98_console_device(struct console *console)
+{
+	return mk_kdev(LP_MAJOR, 0);
+}
+
+static struct console lp_old98_console = {
+	.name	= "lp_old98",
+	.write	= lp_old98_console_write,
+	.device	= lp_old98_console_device,
+	.flags	= CON_PRINTBUFFER,
+	.index	= -1,
+};
+
+#endif	/* console on lp_old98 */
+
+static int __init lp_old98_init(void)
+{
+#ifdef	PC98_HW_H98
+	if (pc98_hw_flags & PC98_HW_H98)
+	    if (!request_region(LP_PORT_H98MODE, 1, "lp_old98") {
+		printk(KERN_ERR
+		       "lp_old98: I/O ports for H98 already occupied.\n");
+		return -EBUSY;
+	    }
+#endif
+	if (request_region(LP_PORT_DATA,   1, "lp_old98")) {
+	    if (request_region(LP_PORT_STATUS, 1, "lp_old98")) {
+		if (request_region(LP_PORT_STROBE, 1, "lp_old98")) {
+		    if (request_region(LP_PORT_EXTMODE, 1, "lp_old98")) {
+			if (register_chrdev(LP_MAJOR, "lp", &lp_old98_fops)) {
+			    printk(KERN_ERR
+				   "lp_old98: unable to get major %d\n",
+				   LP_MAJOR);
+			} else {
+#ifdef CONFIG_PC9800_OLDLP_CONSOLE
+			    register_console(&lp_old98_console);
+			    printk(KERN_INFO "lp_old98: console ready\n");
+#endif
+			    /*
+			     * rest are not needed by this driver,
+			     * but for locking out other printer drivers...
+			     */
+			    lp_old98_init_device();
+			    return 0;
+			}
+		    }
+		    release_region(LP_PORT_STROBE, 1);
+		}
+		release_region(LP_PORT_STATUS, 1);
+	    }
+	    release_region(LP_PORT_DATA, 1);
+	}
+#ifdef	PC98_HW_H98
+	if (pc98_hw_flags & PC98_HW_H98)
+	    release_region(LP_PORT_H98MODE, 1);
+#endif
+	printk(KERN_ERR "lp_old98: I/O ports already occupied, giving up.\n");
+	return -EBUSY;
+}
+
+static void __exit lp_old98_exit(void)
+{
+#ifdef CONFIG_PC9800_OLDLP_CONSOLE
+	unregister_console(&lp_old98_console);
+#endif
+	unregister_chrdev(LP_MAJOR, "lp");
+
+	release_region(LP_PORT_DATA,   1);
+	release_region(LP_PORT_STATUS, 1);
+	release_region(LP_PORT_STROBE, 1);
+#ifdef	PC98_HW_H98
+	if (pc98_hw_flags & PC98_HW_H98)
+		release_region(LP_PORT_H98MODE, 1);
+#endif
+	release_region(LP_PORT_EXTMODE, 1);
+}
+
+#ifndef MODULE
+static int __init lp_old98_setup(char *str)
+{
+        int ints[4];
+
+        str = get_options(str, ARRAY_SIZE(ints), ints);
+        if (ints[0] > 0)
+		dc1_check = ints[1];
+        return 1;
+}
+__setup("lp_old98_dc1_check=", lp_old98_setup);
+#endif
+
+MODULE_PARM(dc1_check, "i");
+MODULE_AUTHOR("Kousuke Takai <tak@kmc.kyoto-u.ac.jp>");
+MODULE_DESCRIPTION("PC-9800 old printer port driver");
+MODULE_LICENSE("GPL");
+
+module_init(lp_old98_init);
+module_exit(lp_old98_exit);
diff -Nru linux-2.5.61/drivers/char/upd4990a.c linux98-2.5.61/drivers/char/upd4990a.c
--- linux-2.5.61/drivers/char/upd4990a.c	1970-01-01 09:00:00.000000000 +0900
+++ linux98-2.5.61/drivers/char/upd4990a.c	2003-02-16 17:19:03.000000000 +0900
@@ -0,0 +1,429 @@
+/*
+ * NEC PC-9800 Real Time Clock interface for Linux	
+ *
+ * Copyright (C) 1997-2001  Linux/98 project,
+ *			    Kyoto University Microcomputer Club.
+ *
+ * Based on:
+ *	drivers/char/rtc.c by Paul Gortmaker
+ *
+ * Changes:
+ *  2001-02-09	Call check_region on rtc_init and do not request I/O 0033h.
+ *		Call del_timer and release_region on rtc_exit. -- tak
+ *  2001-07-14	Rewrite <linux/upd4990a.h> and split to <linux/upd4990a.h>
+ *		and <asm-i386/upd4990a.h>.
+ *		Introduce a lot of spin_lock/unlock (&rtc_lock).
+ */
+
+#define RTC98_VERSION	"1.2"
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/miscdevice.h>
+#include <linux/ioport.h>
+#include <linux/fcntl.h>
+#include <linux/rtc.h>
+#include <linux/upd4990a.h>
+#include <linux/init.h>
+#include <linux/poll.h>
+#include <linux/proc_fs.h>
+#include <linux/spinlock.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+
+#define BCD_TO_BINARY(val)	(((val) >> 4) * 10 + ((val) & 0xF))
+#define BINARY_TO_BCD(val)	((((val) / 10) << 4) | ((val) % 10))
+
+/*
+ *	We sponge a minor off of the misc major. No need slurping
+ *	up another valuable major dev number for this. If you add
+ *	an ioctl, make sure you don't conflict with SPARC's RTC
+ *	ioctls.
+ */
+
+static struct fasync_struct *rtc_async_queue;
+
+static DECLARE_WAIT_QUEUE_HEAD(rtc_wait);
+
+static struct timer_list rtc_uie_timer;
+static u8 old_refclk;
+
+static int rtc_ioctl(struct inode *inode, struct file *file,
+			unsigned int cmd, unsigned long arg);
+
+static int rtc_read_proc(char *page, char **start, off_t off,
+			  int count, int *eof, void *data);
+
+/*
+ *	Bits in rtc_status. (5 bits of room for future expansion)
+ */
+
+#define RTC_IS_OPEN		0x01	/* means /dev/rtc is in use	*/
+#define RTC_TIMER_ON            0x02    /* not used */
+#define RTC_UIE_TIMER_ON        0x04	/* UIE emulation timer is active */
+
+/*
+ * rtc_status is never changed by rtc_interrupt, and ioctl/open/close is
+ * protected by the big kernel lock. However, ioctl can still disable the timer
+ * in rtc_status and then with del_timer after the interrupt has read
+ * rtc_status but before mod_timer is called, which would then reenable the
+ * timer (but you would need to have an awful timing before you'd trip on it)
+ */
+static unsigned char rtc_status;	/* bitmapped status byte.	*/
+static unsigned long rtc_irq_data;	/* our output to the world	*/
+
+static const unsigned char days_in_mo[] = 
+{31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
+
+extern spinlock_t rtc_lock;	/* defined in arch/i386/kernel/time.c */
+
+static void rtc_uie_intr(unsigned long data)
+{
+	u8 refclk, tmp;
+
+	/* Kernel timer does del_timer internally before calling
+	   each timer entry, so this is unnecessary.
+	   del_timer(&rtc_uie_timer);  */
+	spin_lock(&rtc_lock);
+
+	/* Detect rising edge of 1Hz reference clock.  */
+	refclk = UPD4990A_READ_DATA();
+	tmp = old_refclk & refclk;
+	old_refclk = ~refclk;
+	if (!(tmp & 1))
+		rtc_irq_data += 0x100;
+
+	spin_unlock(&rtc_lock);
+
+	if (!(tmp & 1)) {
+		/* Now do the rest of the actions */
+		wake_up_interruptible(&rtc_wait);
+		kill_fasync(&rtc_async_queue, SIGIO, POLL_IN);
+	}
+
+	rtc_uie_timer.expires = jiffies + 1;
+	add_timer(&rtc_uie_timer);
+}
+
+/*
+ *	Now all the various file operations that we export.
+ */
+
+static ssize_t rtc_read(struct file *file, char *buf,
+			size_t count, loff_t *ppos)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	unsigned long data;
+	ssize_t retval = 0;
+	
+	if (count < sizeof(unsigned long))
+		return -EINVAL;
+
+	add_wait_queue(&rtc_wait, &wait);
+
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	do {
+		/* First make it right. Then make it fast. Putting this whole
+		 * block within the parentheses of a while would be too
+		 * confusing. And no, xchg() is not the answer. */
+		spin_lock_irq(&rtc_lock);
+		data = rtc_irq_data;
+		rtc_irq_data = 0;
+		spin_unlock_irq(&rtc_lock);
+
+		if (data != 0)
+			break;
+
+		if (file->f_flags & O_NONBLOCK) {
+			retval = -EAGAIN;
+			goto out;
+		}
+		if (signal_pending(current)) {
+			retval = -ERESTARTSYS;
+			goto out;
+		}
+		schedule();
+	} while (1);
+
+	retval = put_user(data, (unsigned long *)buf);
+	if (!retval)
+		retval = sizeof(unsigned long); 
+ out:
+	set_current_state(TASK_RUNNING);
+	remove_wait_queue(&rtc_wait, &wait);
+
+	return retval;
+}
+
+static int rtc_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+		     unsigned long arg)
+{
+	struct rtc_time wtime; 
+	struct upd4990a_raw_data raw;
+
+	switch (cmd) {
+	case RTC_UIE_OFF:	/* Mask ints from RTC updates.	*/
+		spin_lock_irq(&rtc_lock);
+		if (rtc_status & RTC_UIE_TIMER_ON) {
+			rtc_status &= ~RTC_UIE_TIMER_ON;
+			del_timer(&rtc_uie_timer);
+		}
+		spin_unlock_irq(&rtc_lock);
+		return 0;
+
+	case RTC_UIE_ON:	/* Allow ints for RTC updates.	*/
+		spin_lock_irq(&rtc_lock);
+		rtc_irq_data = 0;
+		if (!(rtc_status & RTC_UIE_TIMER_ON)){
+			rtc_status |= RTC_UIE_TIMER_ON;
+			rtc_uie_timer.expires = jiffies + 1;
+			add_timer(&rtc_uie_timer);
+		}
+		/* Just in case... */
+		upd4990a_serial_command(UPD4990A_REGISTER_HOLD);
+		old_refclk = ~UPD4990A_READ_DATA();
+		spin_unlock_irq(&rtc_lock);
+		return 0;
+
+	case RTC_RD_TIME:	/* Read the time/date from RTC	*/
+		spin_lock_irq(&rtc_lock);
+		upd4990a_get_time(&raw, 0);
+		spin_unlock_irq(&rtc_lock);
+
+		wtime.tm_sec	= BCD_TO_BINARY(raw.sec);
+		wtime.tm_min	= BCD_TO_BINARY(raw.min);
+		wtime.tm_hour	= BCD_TO_BINARY(raw.hour);
+		wtime.tm_mday	= BCD_TO_BINARY(raw.mday);
+		wtime.tm_mon	= raw.mon - 1; /* convert to 0-base */
+		wtime.tm_wday	= raw.wday;
+
+		/*
+		 * Account for differences between how the RTC uses the values
+		 * and how they are defined in a struct rtc_time;
+		 */
+		if ((wtime.tm_year = BCD_TO_BINARY(raw.year)) < 95)
+			wtime.tm_year += 100;
+
+		wtime.tm_isdst = 0;
+		break;
+
+	case RTC_SET_TIME:	/* Set the RTC */
+	{
+		int leap_yr;
+
+		if (!capable(CAP_SYS_TIME))
+			return -EACCES;
+
+		if (copy_from_user(&wtime, (struct rtc_time *) arg,
+				    sizeof (struct rtc_time)))
+			return -EFAULT;
+
+		/* Valid year is 1995 - 2094, inclusive.  */
+		if (wtime.tm_year < 95 || wtime.tm_year > 194)
+			return -EINVAL;
+
+		if (wtime.tm_mon > 11 || wtime.tm_mday == 0)
+			return -EINVAL;
+
+		/* For acceptable year domain (1995 - 2094),
+		   this IS sufficient.  */
+		leap_yr = !(wtime.tm_year % 4);
+
+		if (wtime.tm_mday > (days_in_mo[wtime.tm_mon]
+				     + (wtime.tm_mon == 2 && leap_yr)))
+			return -EINVAL;
+			
+		if (wtime.tm_hour >= 24
+		    || wtime.tm_min >= 60 || wtime.tm_sec >= 60)
+			return -EINVAL;
+
+		if (wtime.tm_wday > 6)
+			return -EINVAL;
+
+		raw.sec  = BINARY_TO_BCD(wtime.tm_sec);
+		raw.min  = BINARY_TO_BCD(wtime.tm_min);
+		raw.hour = BINARY_TO_BCD(wtime.tm_hour);
+		raw.mday = BINARY_TO_BCD(wtime.tm_mday);
+		raw.mon  = wtime.tm_mon + 1;
+		raw.wday = wtime.tm_wday;
+		raw.year = BINARY_TO_BCD(wtime.tm_year % 100);
+
+		spin_lock_irq(&rtc_lock);
+		upd4990a_set_time(&raw, 0);
+		spin_unlock_irq(&rtc_lock);
+
+		return 0;
+	}
+	default:
+		return -EINVAL;
+	}
+	return copy_to_user((void *)arg, &wtime, sizeof wtime) ? -EFAULT : 0;
+}
+
+/*
+ *	We enforce only one user at a time here with the open/close.
+ *	Also clear the previous interrupt data on an open, and clean
+ *	up things on a close.
+ */
+
+static int rtc_open(struct inode *inode, struct file *file)
+{
+	spin_lock_irq(&rtc_lock);
+
+	if(rtc_status & RTC_IS_OPEN)
+		goto out_busy;
+
+	rtc_status |= RTC_IS_OPEN;
+
+	rtc_irq_data = 0;
+	spin_unlock_irq(&rtc_lock);
+	return 0;
+
+ out_busy:
+	spin_unlock_irq(&rtc_lock);
+	return -EBUSY;
+}
+
+static int rtc_fasync(int fd, struct file *filp, int on)
+{
+	return fasync_helper(fd, filp, on, &rtc_async_queue);
+}
+
+static int rtc_release(struct inode *inode, struct file *file)
+{
+	del_timer(&rtc_uie_timer);
+
+	if (file->f_flags & FASYNC)
+		rtc_fasync(-1, file, 0);
+
+	rtc_irq_data = 0;
+
+	/* No need for locking -- nobody else can do anything until this rmw is
+	 * committed, and no timer is running. */
+	rtc_status &= ~(RTC_IS_OPEN | RTC_UIE_TIMER_ON);
+	return 0;
+}
+
+static unsigned int rtc_poll(struct file *file, poll_table *wait)
+{
+	unsigned long l;
+
+	poll_wait(file, &rtc_wait, wait);
+
+	spin_lock_irq(&rtc_lock);
+	l = rtc_irq_data;
+	spin_unlock_irq(&rtc_lock);
+
+	if (l != 0)
+		return POLLIN | POLLRDNORM;
+	return 0;
+}
+
+/*
+ *	The various file operations we support.
+ */
+
+static struct file_operations rtc_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= rtc_read,
+	.poll		= rtc_poll,
+	.ioctl		= rtc_ioctl,
+	.open		= rtc_open,
+	.release	= rtc_release,
+	.fasync		= rtc_fasync,
+};
+
+static struct miscdevice rtc_dev=
+{
+	RTC_MINOR,
+	"rtc",
+	&rtc_fops
+};
+
+static int __init rtc_init(void)
+{
+	if (!request_region(UPD4990A_IO, 1, "rtc")) {
+		printk(KERN_ERR "upd4990a: could not acquire I/O port %#x\n",
+			UPD4990A_IO);
+		return -EBUSY;
+	}
+
+#if 0
+	printk(KERN_INFO "\xB6\xDA\xDD\xC0\xDE \xC4\xDE\xB9\xB2 Driver\n");  /* Calender Clock Driver */
+#else
+	printk(KERN_INFO
+	       "Real Time Clock driver for NEC PC-9800 v" RTC98_VERSION "\n");
+#endif
+	misc_register(&rtc_dev);
+	create_proc_read_entry("driver/rtc", 0, NULL, rtc_read_proc, NULL);
+
+	init_timer(&rtc_uie_timer);
+	rtc_uie_timer.function = rtc_uie_intr;
+
+	return 0;
+}
+
+module_init (rtc_init);
+
+#ifdef MODULE
+static void __exit rtc_exit(void)
+{
+	del_timer(&rtc_uie_timer);
+	release_region(UPD4990A_IO, 1);
+	remove_proc_entry("driver/rtc", NULL);
+	misc_deregister(&rtc_dev);
+}
+
+module_exit (rtc_exit);
+#endif
+
+/*
+ *	Info exported via "/proc/driver/rtc".
+ */
+
+static inline int rtc_get_status(char *buf)
+{
+	char *p;
+	unsigned int year;
+	struct upd4990a_raw_data data;
+
+	p = buf;
+
+	upd4990a_get_time(&data, 0);
+
+	/*
+	 * There is no way to tell if the luser has the RTC set for local
+	 * time or for Universal Standard Time (GMT). Probably local though.
+	 */
+	if ((year = BCD_TO_BINARY(data.year) + 1900) < 1995)
+		year += 100;
+	p += sprintf(p,
+		     "rtc_time\t: %02d:%02d:%02d\n"
+		     "rtc_date\t: %04d-%02d-%02d\n",
+		     BCD_TO_BINARY(data.hour), BCD_TO_BINARY(data.min),
+		     BCD_TO_BINARY(data.sec),
+		     year, data.mon, BCD_TO_BINARY(data.mday));
+
+	return  p - buf;
+}
+
+static int rtc_read_proc(char *page, char **start, off_t off,
+			 int count, int *eof, void *data)
+{
+	int len = rtc_get_status(page);
+
+	if (len <= off + count)
+		*eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len > count)
+		len = count;
+	if (len < 0)
+		len = 0;
+	return len;
+}
diff -Nru linux-2.5.61/include/asm-i386/upd4990a.h linux98-2.5.61/include/asm-i386/upd4990a.h
--- linux-2.5.61/include/asm-i386/upd4990a.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98-2.5.61/include/asm-i386/upd4990a.h	2003-02-16 17:19:03.000000000 +0900
@@ -0,0 +1,52 @@
+/*
+ *  Architecture dependent definitions
+ *  for NEC uPD4990A serial I/O real-time clock.
+ *
+ *  Copyright 2001  TAKAI Kousuke <tak@kmc.kyoto-u.ac.jp>
+ *		    Kyoto University Microcomputer Club (KMC).
+ *
+ *  References:
+ *	uPD4990A serial I/O real-time clock users' manual (Japanese)
+ *	No. S12828JJ4V0UM00 (4th revision), NEC Corporation, 1999.
+ */
+
+#ifndef _ASM_I386_uPD4990A_H
+#define _ASM_I386_uPD4990A_H
+
+#include <asm/io.h>
+
+#define UPD4990A_IO		(0x0020)
+#define UPD4990A_IO_DATAOUT	(0x0033)
+
+#define UPD4990A_OUTPUT_DATA_CLK(data, clk)		\
+	outb((((data) & 1) << 5) | (((clk) & 1) << 4)	\
+	      | UPD4990A_PAR_SERIAL_MODE, UPD4990A_IO)
+
+#define UPD4990A_OUTPUT_CLK(clk)	UPD4990A_OUTPUT_DATA_CLK(0, (clk))
+
+#define UPD4990A_OUTPUT_STROBE(stb) \
+	outb(((stb) << 3) | UPD4990A_PAR_SERIAL_MODE, UPD4990A_IO)
+
+/*
+ * Note: udelay() is *not* usable for UPD4990A_DELAY because
+ *	 the Linux kernel reads uPD4990A to set up system clock
+ *	 before calibrating delay...
+ */
+#define UPD4990A_DELAY(usec)						\
+	do {								\
+		if (__builtin_constant_p((usec)) && (usec) < 5)	\
+			__asm__ (".rept %c1\n\toutb %%al,%0\n\t.endr"	\
+				 : : "N" (0x5F),			\
+				     "i" (((usec) * 10 + 5) / 6));	\
+		else {							\
+			int _count = ((usec) * 10 + 5) / 6;		\
+			__asm__ volatile ("1: outb %%al,%1\n\tloop 1b"	\
+					  : "=c" (_count)		\
+					  : "N" (0x5F), "0" (_count));	\
+		}							\
+	} while (0)
+
+/* Caller should ignore all bits except bit0 */
+#define UPD4990A_READ_DATA()	inb(UPD4990A_IO_DATAOUT)
+
+#endif
diff -Nru linux-2.5.61/include/linux/upd4990a.h linux98-2.5.61/include/linux/upd4990a.h
--- linux-2.5.61/include/linux/upd4990a.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98-2.5.61/include/linux/upd4990a.h	2002-10-31 15:06:03.000000000 +0000
@@ -0,0 +1,140 @@
+/*
+ *  Constant and architecture independent procedures
+ *  for NEC uPD4990A serial I/O real-time clock.
+ *
+ *  Copyright 2001  TAKAI Kousuke <tak@kmc.kyoto-u.ac.jp>
+ *		    Kyoto University Microcomputer Club (KMC).
+ *
+ *  References:
+ *	uPD4990A serial I/O real-time clock users' manual (Japanese)
+ *	No. S12828JJ4V0UM00 (4th revision), NEC Corporation, 1999.
+ */
+
+#ifndef _LINUX_uPD4990A_H
+#define _LINUX_uPD4990A_H
+
+#include <asm/byteorder.h>
+
+#include <asm/upd4990a.h>
+
+/* Serial commands (4 bits) */
+#define UPD4990A_REGISTER_HOLD			(0x0)
+#define UPD4990A_REGISTER_SHIFT			(0x1)
+#define UPD4990A_TIME_SET_AND_COUNTER_HOLD	(0x2)
+#define UPD4990A_TIME_READ			(0x3)
+#define UPD4990A_TP_64HZ			(0x4)
+#define UPD4990A_TP_256HZ			(0x5)
+#define UPD4990A_TP_2048HZ			(0x6)
+#define UPD4990A_TP_4096HZ			(0x7)
+#define UPD4990A_TP_1S				(0x8)
+#define UPD4990A_TP_10S				(0x9)
+#define UPD4990A_TP_30S				(0xA)
+#define UPD4990A_TP_60S				(0xB)
+#define UPD4990A_INTERRUPT_RESET		(0xC)
+#define UPD4990A_INTERRUPT_TIMER_START		(0xD)
+#define UPD4990A_INTERRUPT_TIMER_STOP		(0xE)
+#define UPD4990A_TEST_MODE_SET			(0xF)
+
+/* Parallel commands (3 bits)
+   0-6 are same with serial commands.  */
+#define UPD4990A_PAR_SERIAL_MODE		7
+
+#ifndef UPD4990A_DELAY
+# include <linux/delay.h>
+# define UPD4990A_DELAY(usec)	udelay((usec))
+#endif
+#ifndef UPD4990A_OUTPUT_DATA
+# define UPD4990A_OUTPUT_DATA(bit)			\
+	do {						\
+		UPD4990A_OUTPUT_DATA_CLK((bit), 0);	\
+		UPD4990A_DELAY(1); /* t-DSU */		\
+		UPD4990A_OUTPUT_DATA_CLK((bit), 1);	\
+		UPD4990A_DELAY(1); /* t-DHLD */	\
+	} while (0)
+#endif
+
+static __inline__ void upd4990a_serial_command(int command)
+{
+	UPD4990A_OUTPUT_DATA(command >> 0);
+	UPD4990A_OUTPUT_DATA(command >> 1);
+	UPD4990A_OUTPUT_DATA(command >> 2);
+	UPD4990A_OUTPUT_DATA(command >> 3);
+	UPD4990A_DELAY(1);	/* t-HLD */
+	UPD4990A_OUTPUT_STROBE(1);
+	UPD4990A_DELAY(1);	/* t-STB & t-d1 */
+	UPD4990A_OUTPUT_STROBE(0);
+	/* 19 microseconds extra delay is needed
+	   iff previous mode is TIME READ command  */
+}
+
+struct upd4990a_raw_data {
+	u8	sec;		/* BCD */
+	u8	min;		/* BCD */
+	u8	hour;		/* BCD */
+	u8	mday;		/* BCD */
+#if   defined __LITTLE_ENDIAN_BITFIELD
+	unsigned wday :4;	/* 0-6 */
+	unsigned mon :4;	/* 1-based */
+#elif defined __BIG_ENDIAN_BITFIELD
+	unsigned mon :4;	/* 1-based */
+	unsigned wday :4;	/* 0-6 */
+#else
+# error Unknown bitfield endian!
+#endif
+	u8	year;		/* BCD */
+};
+
+static __inline__ void upd4990a_get_time(struct upd4990a_raw_data *buf,
+					  int leave_register_hold)
+{
+	int byte;
+
+	upd4990a_serial_command(UPD4990A_TIME_READ);
+	upd4990a_serial_command(UPD4990A_REGISTER_SHIFT);
+	UPD4990A_DELAY(19);	/* t-d2 - t-d1 */
+
+	for (byte = 0; byte < 6; byte++) {
+		u8 tmp;
+		int bit;
+
+		for (tmp = 0, bit = 0; bit < 8; bit++) {
+			tmp = (tmp | (UPD4990A_READ_DATA() << 8)) >> 1;
+			UPD4990A_OUTPUT_CLK(1);
+			UPD4990A_DELAY(1);
+			UPD4990A_OUTPUT_CLK(0);
+			UPD4990A_DELAY(1);
+		}
+		((u8 *) buf)[byte] = tmp;
+	}
+
+	/* The uPD4990A users' manual says that we should issue `Register
+	   Hold' command after each data retrieval, or next `Time Read'
+	   command may not work correctly.  */
+	if (!leave_register_hold)
+		upd4990a_serial_command(UPD4990A_REGISTER_HOLD);
+}
+
+static __inline__ void upd4990a_set_time(const struct upd4990a_raw_data *data,
+					  int time_set_only)
+{
+	int byte;
+
+	if (!time_set_only)
+		upd4990a_serial_command(UPD4990A_REGISTER_SHIFT);
+
+	for (byte = 0; byte < 6; byte++) {
+		int bit;
+		u8 tmp = ((const u8 *) data)[byte];
+
+		for (bit = 0; bit < 8; bit++, tmp >>= 1)
+			UPD4990A_OUTPUT_DATA(tmp);
+	}
+
+	upd4990a_serial_command(UPD4990A_TIME_SET_AND_COUNTER_HOLD);
+
+	/* Release counter hold and start the clock.  */
+	if (!time_set_only)
+		upd4990a_serial_command(UPD4990A_REGISTER_HOLD);
+}
+
+#endif /* _LINUX_uPD4990A_H */
