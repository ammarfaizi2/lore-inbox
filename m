Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267117AbTBLNUp>; Wed, 12 Feb 2003 08:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267102AbTBLNUo>; Wed, 12 Feb 2003 08:20:44 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:24448 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267117AbTBLNRd>; Wed, 12 Feb 2003 08:17:33 -0500
Date: Wed, 12 Feb 2003 22:25:49 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.60 (3/34) AC#3
Message-ID: <20030212132549.GD1551@yuzuki.cinet.co.jp>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212131737.GA1551@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.60 (3/34).

   PC98 support patch in 2.5.50-ac1 with minimum changes
   to apply 2.5.60. (drivers/*)

- Osamu Tomita

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60/drivers/block/Makefile linux98-2.5.60-ac1/drivers/block/Makefile
--- linux-2.5.60/drivers/block/Makefile	2003-02-11 03:38:49.000000000 +0900
+++ linux98-2.5.60-ac1/drivers/block/Makefile	2003-02-11 09:47:18.000000000 +0900
@@ -11,7 +11,11 @@
 obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o deadline-iosched.o
 
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
+ifneq ($(CONFIG_PC9800),y)
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
+else
+obj-$(CONFIG_BLK_DEV_FD)	+= floppy98.o
+endif
 obj-$(CONFIG_AMIGA_FLOPPY)	+= amiflop.o
 obj-$(CONFIG_ATARI_FLOPPY)	+= ataflop.o
 obj-$(CONFIG_BLK_DEV_SWIM_IOP)	+= swim_iop.o
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.58/drivers/char/Kconfig linux98-2.5.58/drivers/char/Kconfig
--- linux-2.5.58/drivers/char/Kconfig	2003-01-14 14:58:04.000000000 +0900
+++ linux98-2.5.58/drivers/char/Kconfig	2003-01-14 22:18:18.000000000 +0900
@@ -575,6 +575,17 @@
 	  console. This driver allows each pSeries partition to have a console
 	  which is accessed via the HMC.
 
+config PC9800_OLDLP
+	tristate "NEC PC-9800 old-style printer port support"
+	depends on PC9800 && !PARPORT
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
+	depends on !PPC32 && !PARISC && !IA64 && !PC9800
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -833,6 +844,15 @@
 	bool "EFI Real Time Clock Services"
 	depends on IA64
 
+config RTC98
+	tristate "NEC PC-9800 Real Time Clock Support"
+	depends on PC9800
+	default y
+	---help---
+	  If you say Y here and create a character special file /dev/rtc with
+	  major number 10 and minor number 135 using mknod ("man mknod"), you
+	  will get access to the real time clock (or hardware clock) built
+
 config H8
 	bool "Tadpole ANA H8 Support (OBSOLETE)"
 	depends on OBSOLETE && ALPHA_BOOK1
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.50/drivers/char/lp_old98.c linux.50-ac1/drivers/char/lp_old98.c
--- linux.50/drivers/char/lp_old98.c	1970-01-01 01:00:00.000000000 +0100
+++ linux.50-ac1/drivers/char/lp_old98.c	2002-11-15 16:00:49.000000000 +0000
@@ -0,0 +1,577 @@
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
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/major.h>
+#include <linux/sched.h>
+#include <linux/malloc.h>
+#include <linux/ioport.h>
+#include <linux/fcntl.h>
+#include <linux/delay.h>
+#include <linux/console.h>
+#include <linux/version.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+
+#if !defined(CONFIG_PC9800) && !defined(CONFIG_PC98)
+#error This driver works only for NEC PC-9800 series
+#endif
+
+#if LINUX_VERSION_CODE < 0x20200
+# define LP_STATS
+#endif
+
+#if LINUX_VERSION_CODE >= 0x2030b
+# define CONFIG_RESOURCE98
+#endif
+
+#include <linux/lp.h>
+
+/*
+ *  I/O port numbers
+ */
+#define	LP_PORT_DATA	0x40
+#define	LP_PORT_STATUS	(LP_PORT_DATA+2)
+#define	LP_PORT_STROBE	(LP_PORT_DATA+4)
+#define LP_PORT_CONTROL	(LP_PORT_DATA+6)
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
+	flags:	LP_EXIST | LP_ABORTOPEN,
+	chars:	LP_INIT_CHAR,
+	time:	LP_INIT_TIME,
+	wait:	LP_INIT_WAIT,
+};
+
+static	int	dc1_check	= 1000;
+
+#undef LP_OLD98_DEBUG
+
+#ifndef __udelay_val
+# define __udelay_val current_cpu_data.loops_per_sec
+#endif
+
+static inline void nanodelay(unsigned long nanosecs)	/* Evil ? */
+{
+	if( nanosecs ) {
+		nanosecs *= (unsigned long)((1ULL << 40) / 1000000000ULL);
+		__asm__("mul%L2 %2"
+			: "=d"(nanosecs) : "a"(nanosecs), "g"(__udelay_val));
+		__delay(nanosecs >> 8);
+	}
+}
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
+static inline int
+lp_old98_wait_ready(void)
+{
+	struct timer_list timer;
+
+	init_timer(&timer);
+	timer.function = lp_old98_timer_function;
+	timer.expires = jiffies + 1;
+	timer.data = (unsigned long) &timer;
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
+	while( !(inb(LP_PORT_STATUS) & LP_MASK_nBUSY) ) {
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
+	if( count > lp.stats.maxwait ) {
+#ifdef LP_OLD98_DEBUG
+		printk(KERN_DEBUG "lp_old98: success after %d counts.\n",
+		       count);
+#endif
+		lp.stats.maxwait = count;
+	}
+	count *= 256;
+	tmp = count - lp.stats.meanwait;
+	if( tmp < 0 )
+		tmp = -tmp;
+#endif
+	nanodelay(lp.wait);
+    
+	/* negate PSTB# (activate strobe)	*/
+	outb(LP_CONTROL_ASSERT_STROBE, LP_PORT_CONTROL);
+
+#ifdef LP_STATS
+	lp.stats.meanwait = (255 * lp.stats.meanwait + count + 128) / 256;
+	lp.stats.mdev = (127 * lp.stats.mdev + tmp + 64) / 128;
+	lp.stats.chars++;
+#endif
+
+	nanodelay(lp.wait);
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
+	if( jiffies - lp.lastcall > lp.time )
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
+		while( bytes_written < copy_size ) {
+			if( lp_old98_char(lp.lp_buffer[bytes_written]) )
+				bytes_written++;
+			else {
+#ifdef LP_STATS
+				int rc = lp.runchars + bytes_written;
+
+				if( rc > lp.stats.maxrun )
+					lp.stats.maxrun = rc;
+
+				lp.stats.sleeps++;
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
+	} while( count > 0 );
+
+	return total_bytes_written;
+}
+
+static long long lp_old98_llseek(struct file * file,
+				long long offset, int whence)
+{
+	return -ESPIPE;	/* cannot seek like pipe */
+}
+
+static int lp_old98_open(struct inode * inode, struct file * file)
+{
+	if( MINOR(inode->i_rdev) != 0 )
+		return -ENXIO;
+	if( lp.flags & LP_BUSY )
+		return -EBUSY;
+
+	if ((lp.lp_buffer = kmalloc(LP_BUFFER_SIZE, GFP_KERNEL)) == NULL)
+		return -ENOMEM;
+
+	if (dc1_check && (lp.flags & LP_ABORTOPEN)
+	    && !(file->f_flags & O_NONBLOCK) ) {
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
+		unsigned long eflags;
+
+		save_flags(eflags);
+		cli();		/* interrupts while check is fairly bad */
+
+		if (!lp_old98_char(DC1)) {
+			restore_flags(eflags);
+			return -EBUSY;
+		}
+		count = (unsigned int)dc1_check > 10000 ? 10000 : dc1_check;
+		while( inb(LP_PORT_STATUS) & LP_MASK_nBUSY )
+			if( --count == 0 ) {
+				restore_flags(eflags);
+				return -ENODEV;
+			}
+		restore_flags(eflags);
+	}
+
+	lp.flags |= LP_BUSY;
+
+#ifdef CONFIG_PC9800_OLDLP_CONSOLE
+	saved_console_flags = lp_old98_console.flags;
+	lp_old98_console.flags &= ~CON_ENABLED;
+#endif
+
+	MOD_INC_USE_COUNT;
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
+	MOD_DEC_USE_COUNT;
+	return 0;
+}
+
+static int lp_old98_init_device(void)
+{
+	unsigned char data;
+
+	if( (data = inb(LP_PORT_EXTMODE)) != 0xFF && (data & 0x10) ) {
+		printk(KERN_INFO
+		       "lp_old98: shutting down extended parallel port mode...\n");
+		outb(data & ~0x10, LP_PORT_EXTMODE);
+	}
+#ifdef	PC98_HW_H98
+	if( (pc98_hw_flags & PC98_HW_H98)
+	    && ((data = inb(LP_PORT_H98MODE)) & 0x01) ) {
+		printk(KERN_INFO
+		       "lp_old98: shutting down H98 full centronics mode...\n");
+		outb(data & ~0x01, LP_PORT_H98MODE);
+	}
+#endif
+	return 0;
+}
+
+/*
+ *  Many use of `put_user' macro enlarge code size...
+ */
+static /* not inline */ int lp_old98_put_user(int val, int *addr)
+{
+	return put_user(val, addr);
+}
+
+static int lp_old98_ioctl(struct inode *inode, struct file *file,
+			  unsigned int command, unsigned long arg)
+{
+	int retval = 0;
+
+	switch ( command ) {
+	case LPTIME:
+		lp.time = arg * HZ/100;
+		break;
+	case LPCHAR:
+		lp.chars = arg;
+		break;
+	case LPABORT:
+		if( arg )
+			lp.flags |= LP_ABORT;
+		else
+			lp.flags &= ~LP_ABORT;
+		break;
+	case LPABORTOPEN:
+		if( arg )
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
+		retval = lp_old98_put_user(0, (int *)arg);
+		break;
+	case LPGETSTATUS:
+		/*
+		 * convert PC-9800's status to IBM PC's one, so that tunelp(8)
+		 * works in the same way on this driver.
+		 */
+		retval = lp_old98_put_user((inb(LP_PORT_STATUS)
+					    & LP_MASK_nBUSY)
+					   ? (LP_PBUSY | LP_PERRORP)
+					   : LP_PERRORP,
+					   (int *)arg);
+		break;
+	case LPRESET:
+		retval = lp_old98_init_device();
+		break;
+#ifdef LP_STATS
+	case LPGETSTATS:
+		if( copy_to_user((struct lp_stats *)arg, &lp.stats,
+				 sizeof(struct lp_stats)) )
+			retval = -EFAULT;
+		else if (suser())
+			memset(&lp.stats, 0, sizeof(struct lp_stats));
+		break;
+#endif
+	case LPGETFLAGS:
+		retval = lp_old98_put_user(lp.flags, (int *)arg);
+		break;
+	case LPSETIRQ: 
+	default:
+		retval = -EINVAL;
+	}
+	return retval;
+}
+
+static struct file_operations lp_old98_fops = {
+	owner:	THIS_MODULE,
+	llseek:	lp_old98_llseek,
+	read:	NULL,
+	write:	lp_old98_write,
+	ioctl:	lp_old98_ioctl,
+	open:	lp_old98_open,
+	release:lp_old98_release,
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
+	return MKDEV(LP_MAJOR, 0);
+}
+
+static struct console lp_old98_console = {
+	name:	"lp_old98",
+	write:	lp_old98_console_write,
+	device:	lp_old98_console_device,
+	flags:	CON_PRINTBUFFER,
+	index:	-1,
+};
+
+#endif	/* console on lp_old98 */
+
+#ifdef MODULE
+#define lp_old98_init init_module
+#endif
+
+int __init lp_old98_init(void)
+{
+	if (check_region(LP_PORT_DATA, 1) || check_region(LP_PORT_STATUS, 1)
+	    || check_region(LP_PORT_STROBE, 1)
+#ifdef	PC98_HW_H98
+	    || ((pc98_hw_flags & PC98_HW_H98)
+		&& check_region(LP_PORT_H98MODE, 1))
+#endif
+	    || check_region(LP_PORT_EXTMODE, 1)) {
+		printk(KERN_ERR
+		       "lp_old98: I/O ports already occupied, giving up.\n");
+		return -EBUSY;
+	}
+	if (register_chrdev(LP_MAJOR, "lp", &lp_old98_fops)) {
+		printk(KERN_ERR "lp_old98: unable to get major %d\n",
+		       LP_MAJOR);
+		return -EBUSY;
+	}
+
+#ifdef CONFIG_PC9800_OLDLP_CONSOLE
+	register_console(&lp_old98_console);
+	printk(KERN_INFO "lp_old98: console ready\n");
+#endif
+
+	request_region(LP_PORT_DATA,   1, "lp_old98");
+	request_region(LP_PORT_STATUS, 1, "lp_old98");
+	request_region(LP_PORT_STROBE, 1, "lp_old98");
+
+	/*
+	 * rest are not needed by this driver,
+	 * but for locking out other printer drivers...
+	 */
+#ifdef	PC98_HW_H98
+	if( pc98_hw_flags & PC98_HW_H98 )
+		request_region(LP_PORT_H98MODE, 1, "lp_old98");
+#endif
+	request_region(LP_PORT_EXTMODE, 1, "lp_old98");
+	lp_old98_init_device();
+
+	return 0;
+}
+
+#ifdef MODULE
+void cleanup_module(void)
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
+	if( pc98_hw_flags & PC98_HW_H98 )
+		release_region(LP_PORT_H98MODE, 1);
+#endif
+	release_region(LP_PORT_EXTMODE, 1);
+}
+
+MODULE_PARM(dc1_check, "1i");
+MODULE_AUTHOR("Kousuke Takai <tak@kmc.kyoto-u.ac.jp>");
+
+#endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.50/drivers/char/upd4990a.c linux.50-ac1/drivers/char/upd4990a.c
--- linux.50/drivers/char/upd4990a.c	1970-01-01 01:00:00.000000000 +0100
+++ linux.50-ac1/drivers/char/upd4990a.c	2002-10-31 15:05:31.000000000 +0000
@@ -0,0 +1,438 @@
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
+static long long rtc_llseek(struct file *file, loff_t offset, int origin);
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
+static long long rtc_llseek(struct file *file, loff_t offset, int origin)
+{
+	return -ESPIPE;
+}
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
+	owner:		THIS_MODULE,
+	llseek:		rtc_llseek,
+	read:		rtc_read,
+	poll:		rtc_poll,
+	ioctl:		rtc_ioctl,
+	open:		rtc_open,
+	release:	rtc_release,
+	fasync:		rtc_fasync,
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
+EXPORT_NO_SYMBOLS;
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.50/drivers/input/keyboard/98kbd.c linux.50-ac1/drivers/input/keyboard/98kbd.c
--- linux.50/drivers/input/keyboard/98kbd.c	1970-01-01 01:00:00.000000000 +0100
+++ linux.50-ac1/drivers/input/keyboard/98kbd.c	2002-11-15 15:57:45.000000000 +0000
@@ -0,0 +1,379 @@
+/*
+ *  drivers/input/keyboard/98kbd.c
+ *
+ *  PC-9801 keyboard driver for Linux
+ *
+ *    Based on atkbd.c and xtkbd.c written by Vojtech Pavlik
+ *
+ *  Copyright (c) 2002 Osamu Tomita
+ *  Copyright (c) 1999-2001 Vojtech Pavlik
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or 
+ * (at your option) any later version.
+ * 
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ * 
+ */
+
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/init.h>
+#include <linux/serio.h>
+
+#include <asm/io.h>
+#include <asm/pc9800.h>
+
+MODULE_AUTHOR("Osamu Tomita <tomita@cinet.co.jp>");
+MODULE_DESCRIPTION("PC-9801 keyboard driver");
+MODULE_LICENSE("GPL");
+
+#define KBD98_KEY	0x7f
+#define KBD98_RELEASE	0x80
+
+static unsigned char kbd98_keycode[256] = {	 
+	  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 43, 14, 15,
+	 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 41, 26, 28, 30, 31, 32,
+	 33, 34, 35, 36, 37, 38, 39, 40, 27, 44, 45, 46, 47, 48, 49, 50,
+	 51, 52, 53, 12, 57,184,109,104,110,111,103,105,106,108,102,107,
+	 74, 98, 71, 72, 73, 55, 75, 76, 77, 78, 79, 80, 81,117, 82,124,
+	 83,185, 87, 88, 85, 89, 90,  0,  0,  0,  0,  0,  0,  0,102,  0,
+	 99,133, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68,  0,  0,  0,  0,
+	 54, 58, 42, 56, 29
+};
+
+struct jis_kbd_conv {
+	unsigned char scancode;
+	struct {
+		unsigned char shift;
+		unsigned char keycode;
+	} emul[2];
+};
+
+static struct jis_kbd_conv kbd98_jis[] = {
+	{0x02, {{0,   3}, {1,  40}}},
+	{0x06, {{0,   7}, {1,   8}}},
+	{0x07, {{0,   8}, {0,  40}}},
+	{0x08, {{0,   9}, {1,  10}}},
+	{0x09, {{0,  10}, {1,  11}}},
+	{0x0a, {{0,  11}, {1, 255}}},
+	{0x0b, {{0,  12}, {0,  13}}},
+	{0x0c, {{1,   7}, {0,  41}}},
+	{0x1a, {{1,   3}, {1,  41}}},
+	{0x26, {{0,  39}, {1,  13}}},
+	{0x27, {{1,  39}, {1,   9}}},
+	{0x33, {{0, 255}, {1,  12}}},
+	{0xff, {{0, 255}, {1, 255}}}	/* terminater */
+};
+
+#define KBD98_CMD_SETEXKEY	0x1095	/* Enable/Disable Windows, Appli key */
+#define KBD98_CMD_SETRATE	0x109c	/* Set typematic rate */
+#define KBD98_CMD_SETLEDS	0x109d	/* Set keyboard leds */
+#define KBD98_CMD_GETLEDS	0x119d	/* Get keyboard leds */
+#define KBD98_CMD_GETID		0x019f
+
+#define KBD98_RET_ACK		0xfa
+#define KBD98_RET_NAK		0xfc	/* Command NACK, send the cmd again */
+
+#define KBD98_KEY_JIS_EMUL	253
+#define KBD98_KEY_UNKNOWN	254
+#define KBD98_KEY_NULL		255
+
+static char *kbd98_name = "PC-9801 Keyboard";
+
+struct kbd98 {
+	unsigned char keycode[256];
+	struct input_dev dev;
+	struct serio *serio;
+	char phys[32];
+	unsigned char cmdbuf[4];
+	unsigned char cmdcnt;
+	signed char ack;
+	unsigned char shift;
+	struct {
+		unsigned char scancode;
+		unsigned char keycode;
+	} emul;
+	struct jis_kbd_conv jis[16];
+};
+
+void kbd98_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
+{
+	struct kbd98 *kbd98 = serio->private;
+	unsigned char scancode, keycode;
+	int press, i;
+
+	switch (data) {
+		case KBD98_RET_ACK:
+			kbd98->ack = 1;
+			return;
+		case KBD98_RET_NAK:
+			kbd98->ack = -1;
+			return;
+	}
+
+	if (kbd98->cmdcnt) {
+		kbd98->cmdbuf[--kbd98->cmdcnt] = data;
+		return;
+	}
+
+	scancode = data & KBD98_KEY;
+	keycode = kbd98->keycode[scancode];
+	press = !(data & KBD98_RELEASE);
+	if (kbd98->emul.scancode != KBD98_KEY_UNKNOWN
+	    && scancode != kbd98->emul.scancode) {
+		input_report_key(&kbd98->dev, kbd98->emul.keycode, 0);
+		kbd98->emul.scancode = KBD98_KEY_UNKNOWN;
+	}
+
+	if (keycode == KEY_RIGHTSHIFT)
+		kbd98->shift = press;
+
+	switch (keycode) {
+		case KEY_2:
+		case KEY_6:
+		case KEY_7:
+		case KEY_8:
+		case KEY_9:
+		case KEY_0:
+		case KEY_MINUS:
+		case KEY_EQUAL:
+		case KEY_GRAVE:
+		case KEY_SEMICOLON:
+		case KEY_APOSTROPHE:
+			/* emulation: JIS keyboard to US101 keyboard */
+			i = 0;
+			while (kbd98->jis[i].scancode != 0xff) {
+				if (scancode == kbd98->jis[i].scancode)
+					break;
+				i ++;
+			}
+
+			keycode = kbd98->jis[i].emul[kbd98->shift].keycode;
+			if (keycode == KBD98_KEY_NULL)
+				return;
+
+			if (press) {
+				kbd98->emul.scancode = scancode;
+				kbd98->emul.keycode = keycode;
+				if (kbd98->jis[i].emul[kbd98->shift].shift
+								!= kbd98->shift)
+					input_report_key(&kbd98->dev,
+							KEY_RIGHTSHIFT,
+							!(kbd98->shift));
+			}
+
+			input_report_key(&kbd98->dev, keycode, press);
+			if (!press) {
+				if (kbd98->jis[i].emul[kbd98->shift].shift
+								!= kbd98->shift)
+					input_report_key(&kbd98->dev,
+							KEY_RIGHTSHIFT,
+							kbd98->shift);
+				kbd98->emul.scancode = KBD98_KEY_UNKNOWN;
+			}
+
+			input_sync(&kbd98->dev);
+			return;
+
+		case KBD98_KEY_NULL:
+			return;
+
+		case 0:
+			printk(KERN_WARNING "kbd98.c: Unknown key (scancode %#x) %s.\n",
+				data & KBD98_KEY, data & KBD98_RELEASE ? "released" : "pressed");
+			return;
+
+		default:
+			input_report_key(&kbd98->dev, keycode, press);
+			input_sync(&kbd98->dev);
+		}
+}
+
+/*
+ * kbd98_sendbyte() sends a byte to the keyboard, and waits for
+ * acknowledge. It doesn't handle resends according to the keyboard
+ * protocol specs, because if these are needed, the keyboard needs
+ * replacement anyway, and they only make a mess in the protocol.
+ */
+
+static int kbd98_sendbyte(struct kbd98 *kbd98, unsigned char byte)
+{
+	int timeout = 10000; /* 100 msec */
+	kbd98->ack = 0;
+
+	if (serio_write(kbd98->serio, byte))
+		return -1;
+
+	while (!kbd98->ack && timeout--) udelay(10);
+
+	return -(kbd98->ack <= 0);
+}
+
+/*
+ * kbd98_command() sends a command, and its parameters to the keyboard,
+ * then waits for the response and puts it in the param array.
+ */
+
+static int kbd98_command(struct kbd98 *kbd98, unsigned char *param, int command)
+{
+	int timeout = 50000; /* 500 msec */
+	int send = (command >> 12) & 0xf;
+	int receive = (command >> 8) & 0xf;
+	int i;
+
+	kbd98->cmdcnt = receive;
+	
+	if (command & 0xff)
+		if (kbd98_sendbyte(kbd98, command & 0xff))
+			return (kbd98->cmdcnt = 0) - 1;
+
+	for (i = 0; i < send; i++)
+		if (kbd98_sendbyte(kbd98, param[i]))
+			return (kbd98->cmdcnt = 0) - 1;
+
+	while (kbd98->cmdcnt && timeout--) udelay(10);
+
+	if (param)
+		for (i = 0; i < receive; i++)
+			param[i] = kbd98->cmdbuf[(receive - 1) - i];
+
+	if (kbd98->cmdcnt) 
+		return (kbd98->cmdcnt = 0) - 1;
+
+	return 0;
+}
+
+/*
+ * Event callback from the input module. Events that change the state of
+ * the hardware are processed here.
+ */
+
+static int kbd98_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+{
+	struct kbd98 *kbd98 = dev->private;
+	char param[2];
+
+	switch (type) {
+
+		case EV_LED:
+
+			if (__PC9800SCA_TEST_BIT(0x481, 3)) {
+				/* 98note with Num Lock key */
+				/* keep Num Lock status     */
+				*param = 0x60;
+				if (kbd98_command(kbd98, param,
+							KBD98_CMD_GETLEDS))
+					printk(KERN_DEBUG
+						"kbd98: Get keyboard LED"
+						" status Error\n");
+
+				*param &= 1;
+			} else {
+				/* desktop PC-9801 */
+				*param = 1;	/* Allways set Num Lock */
+			}
+
+			*param |= 0x70
+			       | (test_bit(LED_CAPSL,   dev->led) ? 4 : 0)
+			       | (test_bit(LED_KANA,    dev->led) ? 8 : 0);
+		        kbd98_command(kbd98, param, KBD98_CMD_SETLEDS);
+
+			return 0;
+	}
+
+	return -1;
+}
+
+void kbd98_connect(struct serio *serio, struct serio_dev *dev)
+{
+	struct kbd98 *kbd98;
+	int i;
+
+	if ((serio->type & SERIO_TYPE) != SERIO_PC9800)
+		return;
+
+	if (!(kbd98 = kmalloc(sizeof(struct kbd98), GFP_KERNEL)))
+		return;
+
+	memset(kbd98, 0, sizeof(struct kbd98));
+	kbd98->emul.scancode = KBD98_KEY_UNKNOWN;
+	
+	kbd98->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP);
+	kbd98->dev.ledbit[0] = BIT(LED_NUML) | BIT(LED_CAPSL) | BIT(LED_KANA);
+
+	kbd98->serio = serio;
+
+	init_input_dev(&kbd98->dev);
+	kbd98->dev.keycode = kbd98->keycode;
+	kbd98->dev.keycodesize = sizeof(unsigned char);
+	kbd98->dev.keycodemax = ARRAY_SIZE(kbd98_keycode);
+	kbd98->dev.event = kbd98_event;
+	kbd98->dev.private = kbd98;
+
+	serio->private = kbd98;
+
+	if (serio_open(serio, dev)) {
+		kfree(kbd98);
+		return;
+	}
+
+	memcpy(kbd98->jis, kbd98_jis, sizeof(kbd98_jis));
+	memcpy(kbd98->keycode, kbd98_keycode, sizeof(kbd98->keycode));
+	for (i = 0; i < 255; i++)
+		set_bit(kbd98->keycode[i], kbd98->dev.keybit);
+	clear_bit(0, kbd98->dev.keybit);
+
+	sprintf(kbd98->phys, "%s/input0", serio->phys);
+
+	kbd98->dev.name = kbd98_name;
+	kbd98->dev.phys = kbd98->phys;
+	kbd98->dev.id.bustype = BUS_XTKBD;
+	kbd98->dev.id.vendor = 0x0002;
+	kbd98->dev.id.product = 0x0001;
+	kbd98->dev.id.version = 0x0100;
+
+	input_register_device(&kbd98->dev);
+
+	printk(KERN_INFO "input: %s on %s\n", kbd98_name, serio->phys);
+}
+
+void kbd98_disconnect(struct serio *serio)
+{
+	struct kbd98 *kbd98 = serio->private;
+	input_unregister_device(&kbd98->dev);
+	serio_close(serio);
+	kfree(kbd98);
+}
+
+struct serio_dev kbd98_dev = {
+	.interrupt =	kbd98_interrupt,
+	.connect =	kbd98_connect,
+	.disconnect =	kbd98_disconnect
+};
+
+int __init kbd98_init(void)
+{
+	serio_register_device(&kbd98_dev);
+	return 0;
+}
+
+void __exit kbd98_exit(void)
+{
+	serio_unregister_device(&kbd98_dev);
+}
+
+module_init(kbd98_init);
+module_exit(kbd98_exit);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60/drivers/input/keyboard/Kconfig linux98-2.5.60-ac1/drivers/input/keyboard/Kconfig
--- linux-2.5.60/drivers/input/keyboard/Kconfig	2003-02-11 03:38:54.000000000 +0900
+++ linux98-2.5.60-ac1/drivers/input/keyboard/Kconfig	2003-02-11 09:47:18.000000000 +0900
@@ -90,3 +90,15 @@
 	  The module will be called amikbd. If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.
 
+config KEYBOARD_98KBD
+	tristate "NEC PC-9800 Keyboard support"
+	depends on PC9800 && INPUT && INPUT_KEYBOARD && SERIO
+	help
+	  Say Y here if you want to use the NEC PC-9801/PC-9821 keyboard (or
+	  compatible) on your system. 
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called xtkbd.o. If you want to compile it as a
+	  module, say M here and read <file:Documentation/modules.txt>.
+
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.52/drivers/input/keyboard/Makefile linux98-2.5.52/drivers/input/keyboard/Makefile
--- linux-2.5.52/drivers/input/keyboard/Makefile	2002-12-16 11:07:54.000000000 +0900
+++ linux98-2.5.52/drivers/input/keyboard/Makefile	2002-12-16 21:28:54.000000000 +0900
@@ -10,3 +10,4 @@
 obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
 obj-$(CONFIG_KEYBOARD_AMIGA)		+= amikbd.o
 obj-$(CONFIG_KEYBOARD_NEWTON)		+= newtonkbd.o
+obj-$(CONFIG_KEYBOARD_98KBD)		+= 98kbd.o
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.50/drivers/input/mouse/98busmouse.c linux.50-ac1/drivers/input/mouse/98busmouse.c
--- linux.50/drivers/input/mouse/98busmouse.c	1970-01-01 01:00:00.000000000 +0100
+++ linux.50-ac1/drivers/input/mouse/98busmouse.c	2002-11-15 15:58:41.000000000 +0000
@@ -0,0 +1,201 @@
+/*
+ *
+ *  Copyright (c) 2002 Osamu Tomita
+ *
+ *  Based on the work of:
+ *	James Banks		Matthew Dillon
+ *	David Giller		Nathan Laredo
+ *	Linus Torvalds		Johan Myreen
+ *	Cliff Matthews		Philip Blundell
+ *	Russell King		Vojtech Pavlik
+ */
+
+/*
+ * NEC PC-9801 Bus Mouse Driver for Linux
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or 
+ * (at your option) any later version.
+ * 
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ * 
+ */
+
+#include <asm/io.h>
+#include <asm/irq.h>
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/input.h>
+
+MODULE_AUTHOR("Osamu Tomita <tomita@cinet.co.jp>");
+MODULE_DESCRIPTION("PC-9801 busmouse driver");
+MODULE_LICENSE("GPL");
+
+#define	PC98BM_BASE		0x7fd9
+#define	PC98BM_DATA_PORT	PC98BM_BASE + 0
+/*	PC98BM_SIGNATURE_PORT	does not exist */
+#define	PC98BM_CONTROL_PORT	PC98BM_BASE + 4
+/*	PC98BM_INTERRUPT_PORT	does not exist */
+#define	PC98BM_CONFIG_PORT	PC98BM_BASE + 6
+
+#define	PC98BM_ENABLE_IRQ	0x00
+#define	PC98BM_DISABLE_IRQ	0x10
+#define	PC98BM_READ_X_LOW	0x80
+#define	PC98BM_READ_X_HIGH	0xa0
+#define	PC98BM_READ_Y_LOW	0xc0
+#define	PC98BM_READ_Y_HIGH	0xe0
+
+#define PC98BM_DEFAULT_MODE	0x93
+/*	PC98BM_CONFIG_BYTE	is not used */
+/*	PC98BM_SIGNATURE_BYTE	is not used */
+
+#define PC98BM_TIMER_PORT	0xbfdb
+#define PC98BM_DEFAULT_TIMER_VAL	0x00
+
+#define PC98BM_IRQ		13
+
+MODULE_PARM(pc98bm_irq, "i");
+
+static int pc98bm_irq = PC98BM_IRQ;
+static int pc98bm_used = 0;
+
+static void pc98bm_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+
+static int pc98bm_open(struct input_dev *dev)
+{
+	if (pc98bm_used++)
+		return 0;
+	if (request_irq(pc98bm_irq, pc98bm_interrupt, 0, "98busmouse", NULL)) {
+		pc98bm_used--;
+		printk(KERN_ERR "98busmouse.c: Can't allocate irq %d\n", pc98bm_irq);
+		return -EBUSY;
+	}
+	outb(PC98BM_ENABLE_IRQ, PC98BM_CONTROL_PORT);
+	return 0;
+}
+
+static void pc98bm_close(struct input_dev *dev)
+{
+	if (--pc98bm_used)
+		return;
+	outb(PC98BM_DISABLE_IRQ, PC98BM_CONTROL_PORT);
+	free_irq(pc98bm_irq, NULL);
+}
+
+static struct input_dev pc98bm_dev = {
+	.evbit	= { BIT(EV_KEY) | BIT(EV_REL) },
+	.keybit = { [LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT) },
+	.relbit	= { BIT(REL_X) | BIT(REL_Y) },
+	.open	= pc98bm_open,
+	.close	= pc98bm_close,
+	.name	= "PC-9801 bus mouse",
+	.phys	= "isa7fd9/input0",
+	.id	= {
+		.bustype = BUS_ISA,
+		.vendor  = 0x0004,
+		.product = 0x0001,
+		.version = 0x0100,
+	},
+};
+
+static void pc98bm_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	char dx, dy;
+	unsigned char buttons;
+
+	outb(PC98BM_READ_X_LOW, PC98BM_CONTROL_PORT);
+	dx = (inb(PC98BM_DATA_PORT) & 0xf);
+	outb(PC98BM_READ_X_HIGH, PC98BM_CONTROL_PORT);
+	dx |= (inb(PC98BM_DATA_PORT) & 0xf) << 4;
+	outb(PC98BM_READ_Y_LOW, PC98BM_CONTROL_PORT);
+	dy = (inb(PC98BM_DATA_PORT) & 0xf);
+	outb(PC98BM_READ_Y_HIGH, PC98BM_CONTROL_PORT);
+	buttons = inb(PC98BM_DATA_PORT);
+	dy |= (buttons & 0xf) << 4;
+	buttons = ~buttons >> 5;
+
+	input_report_rel(&pc98bm_dev, REL_X, dx);
+	input_report_rel(&pc98bm_dev, REL_Y, dy);
+	input_report_key(&pc98bm_dev, BTN_RIGHT,  buttons & 1);
+	input_report_key(&pc98bm_dev, BTN_MIDDLE, buttons & 2);
+	input_report_key(&pc98bm_dev, BTN_LEFT,   buttons & 4);
+	input_sync(&pc98bm_dev);
+
+	outb(PC98BM_ENABLE_IRQ, PC98BM_CONTROL_PORT);
+}
+
+#ifndef MODULE
+static int __init pc98bm_setup(char *str)
+{
+        int ints[4];
+        str = get_options(str, ARRAY_SIZE(ints), ints);
+        if (ints[0] > 0) pc98bm_irq = ints[1];
+        return 1;
+}
+__setup("pc98bm_irq=", pc98bm_setup);
+#endif
+
+static int __init pc98bm_init(void)
+{
+	int i;
+
+	for (i = 0; i <= 6; i += 2) {
+		if (!request_region(PC98BM_BASE + i, 1, "98busmouse")) {
+			printk(KERN_ERR "98busmouse.c: Can't allocate ports at %#x\n", PC98BM_BASE + i);
+			while (i > 0) {
+				i -= 2;
+				release_region(PC98BM_BASE + i, 1);
+			}
+
+			return -EBUSY;
+		}
+
+	}
+
+	if (!request_region(PC98BM_TIMER_PORT, 1, "98busmouse")) {
+		printk(KERN_ERR "98busmouse.c: Can't allocate ports at %#x\n", PC98BM_TIMER_PORT);
+		for (i = 0; i <= 6; i += 2)
+			release_region(PC98BM_BASE + i, 1);
+
+		return -EBUSY;
+	}
+
+	outb(PC98BM_DEFAULT_MODE, PC98BM_CONFIG_PORT);
+	outb(PC98BM_DISABLE_IRQ, PC98BM_CONTROL_PORT);
+
+	outb(PC98BM_DEFAULT_TIMER_VAL, PC98BM_TIMER_PORT);
+
+	input_register_device(&pc98bm_dev);
+	
+	printk(KERN_INFO "input: PC-9801 bus mouse at %#x irq %d\n", PC98BM_BASE, pc98bm_irq);
+
+	return 0;
+}
+
+static void __exit pc98bm_exit(void)
+{
+	int i;
+
+	input_unregister_device(&pc98bm_dev);
+	for (i = 0; i <= 6; i += 2)
+		release_region(PC98BM_BASE + i, 1);
+
+	release_region(PC98BM_TIMER_PORT, 1);
+}
+
+module_init(pc98bm_init);
+module_exit(pc98bm_exit);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60/drivers/input/mouse/Kconfig linux98-2.5.60/drivers/input/mouse/Kconfig
--- linux-2.5.60/drivers/input/mouse/Kconfig	2003-02-11 03:38:50.000000000 +0900
+++ linux98-2.5.60/drivers/input/mouse/Kconfig	2003-02-11 09:47:18.000000000 +0900
@@ -121,3 +121,15 @@
 	  The module will be called rpcmouse. If you want to compile it as a
 	  module, say M here and read <file.:Documentation/modules.txt>.
 
+config MOUSE_PC9800
+	tristate "NEC PC-9800 busmouse"
+	depends on PC9800 && INPUT && INPUT_MOUSE && ISA
+	help
+	  Say Y here if you have NEC PC-9801/PC-9821 computer and want its
+	  native mouse supported.
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called logibm.o. If you want to compile it as a
+	  module, say M here and read <file.:Documentation/modules.txt>.
+
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.52/drivers/input/mouse/Makefile linux98-2.5.52/drivers/input/mouse/Makefile
--- linux-2.5.52/drivers/input/mouse/Makefile	2002-12-16 11:07:49.000000000 +0900
+++ linux98-2.5.52/drivers/input/mouse/Makefile	2002-12-16 21:34:16.000000000 +0900
@@ -10,5 +10,6 @@
 obj-$(CONFIG_MOUSE_LOGIBM)	+= logibm.o
 obj-$(CONFIG_MOUSE_MAPLE)	+= maplemouse.o
 obj-$(CONFIG_MOUSE_PC110PAD)	+= pc110pad.o
+obj-$(CONFIG_MOUSE_PC9800)	+= 98busmouse.o
 obj-$(CONFIG_MOUSE_PS2)		+= psmouse.o
 obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.50/drivers/input/serio/98kbd-io.c linux.50-ac1/drivers/input/serio/98kbd-io.c
--- linux.50/drivers/input/serio/98kbd-io.c	1970-01-01 01:00:00.000000000 +0100
+++ linux.50-ac1/drivers/input/serio/98kbd-io.c	2002-11-15 15:58:41.000000000 +0000
@@ -0,0 +1,181 @@
+/*
+ *  NEC PC-9801 keyboard controller driver for Linux
+ *
+ *  Copyright (c) 1999-2002 Osamu Tomita <tomita@cinet.co.jp>
+ *    Based on i8042.c written by Vojtech Pavlik
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <asm/io.h>
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/ioport.h>
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/serio.h>
+#include <linux/sched.h>
+
+MODULE_AUTHOR("Osamu Tomita <tomita@cinet.co.jp>");
+MODULE_DESCRIPTION("NEC PC-9801 keyboard controller driver");
+MODULE_LICENSE("GPL");
+
+/*
+ * Names.
+ */
+
+#define KBD98_PHYS_DESC "isa0041/serio0"
+
+/*
+ * IRQs.
+ */
+
+#define KBD98_IRQ	1
+
+/*
+ * Register numbers.
+ */
+
+#define KBD98_COMMAND_REG	0x43	
+#define KBD98_STATUS_REG	0x43	
+#define KBD98_DATA_REG		0x41
+
+spinlock_t kbd98io_lock = SPIN_LOCK_UNLOCKED;
+
+static struct serio kbd98_port;
+extern struct pt_regs *kbd_pt_regs;
+
+static void kbd98io_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+
+/*
+ * kbd98_flush() flushes all data that may be in the keyboard buffers
+ */
+
+static int kbd98_flush(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&kbd98io_lock, flags);
+
+	while (inb(KBD98_STATUS_REG) & 0x02) /* RxRDY */
+		inb(KBD98_DATA_REG);
+
+	if (inb(KBD98_STATUS_REG) & 0x38)
+		printk("98kbd-io: Keyboard error!\n");
+
+	spin_unlock_irqrestore(&kbd98io_lock, flags);
+
+	return 0;
+}
+
+/*
+ * kbd98_write() sends a byte out through the keyboard interface.
+ */
+
+static int kbd98_write(struct serio *port, unsigned char c)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&kbd98io_lock, flags);
+
+	outb(0, 0x5f);			/* wait */
+	outb(0x17, KBD98_COMMAND_REG);	/* enable send command */
+	outb(0, 0x5f);			/* wait */
+	outb(c, KBD98_DATA_REG);
+	outb(0, 0x5f);			/* wait */
+	outb(0x16, KBD98_COMMAND_REG);	/* disable send command */
+	outb(0, 0x5f);			/* wait */
+
+	spin_unlock_irqrestore(&kbd98io_lock, flags);
+
+	return 0;
+}
+
+/*
+ * kbd98_open() is called when a port is open by the higher layer.
+ * It allocates the interrupt and enables in in the chip.
+ */
+
+static int kbd98_open(struct serio *port)
+{
+	kbd98_flush();
+
+	if (request_irq(KBD98_IRQ, kbd98io_interrupt, 0, "kbd98", NULL)) {
+		printk(KERN_ERR "98kbd-io.c: Can't get irq %d for %s, unregistering the port.\n", KBD98_IRQ, "KBD");
+		serio_unregister_port(port);
+		return -1;
+	}
+
+	return 0;
+}
+
+static void kbd98_close(struct serio *port)
+{
+	free_irq(KBD98_IRQ, NULL);
+
+	kbd98_flush();
+}
+
+/*
+ * Structures for registering the devices in the serio.c module.
+ */
+
+static struct serio kbd98_port =
+{
+	.type =		SERIO_PC9800,
+	.write =	kbd98_write,
+	.open =		kbd98_open,
+	.close =	kbd98_close,
+	.driver =	NULL,
+	.name =		"PC-9801 Kbd Port",
+	.phys =		KBD98_PHYS_DESC,
+};
+
+/*
+ * kbd98io_interrupt() is the most important function in this driver -
+ * it handles the interrupts from keyboard, and sends incoming bytes
+ * to the upper layers.
+ */
+
+static void kbd98io_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	unsigned long flags;
+	unsigned char data;
+
+#ifdef CONFIG_VT
+	kbd_pt_regs = regs;
+#endif
+
+	spin_lock_irqsave(&kbd98io_lock, flags);
+
+	data = inb(KBD98_DATA_REG);
+	spin_unlock_irqrestore(&kbd98io_lock, flags);
+	serio_interrupt(&kbd98_port, data, 0);
+
+}
+
+int __init kbd98io_init(void)
+{
+	serio_register_port(&kbd98_port);
+
+	printk(KERN_INFO "serio: PC-9801 %s port at %#lx,%#lx irq %d\n",
+	       "KBD",
+	       (unsigned long) KBD98_DATA_REG,
+	       (unsigned long) KBD98_COMMAND_REG,
+	       KBD98_IRQ);
+
+	return 0;
+}
+
+void __exit kbd98io_exit(void)
+{
+	serio_unregister_port(&kbd98_port);
+}
+
+module_init(kbd98io_init);
+module_exit(kbd98io_exit);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.57/drivers/input/serio/Kconfig linux98-2.5.57/drivers/input/serio/Kconfig
--- linux-2.5.57/drivers/input/serio/Kconfig	2003-01-14 09:31:48.000000000 +0900
+++ linux98-2.5.57/drivers/input/serio/Kconfig	2003-01-14 09:33:34.000000000 +0900
@@ -107,3 +107,15 @@
 	tristate "Intel SA1111 keyboard controller"
 	depends on SA1111 && SERIO
 
+config SERIO_98KBD
+	tristate "NEC PC-9800 keyboard controller"
+	depends on PC9800 && SERIO
+	help
+	  Say Y here if you have the NEC PC-9801/PC-9821 and want to use its
+	  standard keyboard connected to its keyboard controller.
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called rpckbd.o. If you want to compile it as a
+	  module, say M here and read <file:Documentation/modules.txt>.
+
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60/drivers/input/serio/Makefile linux98-2.5.60/drivers/input/serio/Makefile
--- linux-2.5.60/drivers/input/serio/Makefile	2003-02-11 03:37:57.000000000 +0900
+++ linux98-2.5.60/drivers/input/serio/Makefile	2003-02-11 09:47:18.000000000 +0900
@@ -13,3 +13,4 @@
 obj-$(CONFIG_SERIO_SA1111)	+= sa1111ps2.o
 obj-$(CONFIG_SERIO_AMBAKMI)	+= ambakmi.o
 obj-$(CONFIG_SERIO_Q40KBD)	+= q40kbd.o
+obj-$(CONFIG_SERIO_98KBD)	+= 98kbd-io.o
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.51/drivers/video/console/gdccon.c linux98-2.5.51/drivers/video/console/gdccon.c
--- linux-2.5.51/drivers/video/console/gdccon.c	1970-01-01 01:00:00.000000000 +0100
+++ linux98-2.5.51/drivers/video/console/gdccon.c	2002-10-31 15:05:24.000000000 +0000
@@ -0,0 +1,834 @@
+/*
+ * linux/drivers/video/gdccon.c
+ * Low level GDC based console driver for NEC PC-9800 series
+ *
+ * Created 24 Dec 1998 by Linux/98 project
+ *
+ * based on:
+ * linux/drivers/video/vgacon.c in Linux 2.1.131 by Geert Uytterhoeven
+ * linux/char/gdc.c in Linux/98 2.1.57 by Linux/98 project
+ * linux/char/console.c in Linux/98 2.1.57 by Linux/98 project
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/tty.h>
+#include <linux/console.h>
+#include <linux/console_struct.h>
+#include <linux/string.h>
+#include <linux/kd.h>
+#include <linux/slab.h>
+#include <linux/vt_kern.h>
+#include <linux/selection.h>
+#include <linux/spinlock.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/pc9800.h>
+
+static spinlock_t gdc_lock = SPIN_LOCK_UNLOCKED;
+
+static char str_gdc_master[] = "GDC (master)";
+static char str_gdc_slave[] = "GDC (slave)";
+static char str_crtc[] = "crtc";
+static struct resource gdc_console_resources[] = {
+    {str_gdc_master, 0x60, 0x60, 0},
+    {str_gdc_master, 0x62, 0x62, 0},
+    {str_gdc_master, 0x64, 0x64, 0},
+    {str_gdc_master, 0x66, 0x66, 0},
+    {str_gdc_master, 0x68, 0x68, 0},
+    {str_gdc_master, 0x6a, 0x6a, 0},
+    {str_gdc_master, 0x6c, 0x6c, 0},
+    {str_gdc_master, 0x6e, 0x6e, 0},
+    {str_crtc, 0x70, 0x70, 0},
+    {str_crtc, 0x72, 0x72, 0},
+    {str_crtc, 0x74, 0x74, 0},
+    {str_crtc, 0x76, 0x76, 0},
+    {str_crtc, 0x78, 0x78, 0},
+    {str_crtc, 0x7a, 0x7a, 0},
+    {str_gdc_slave, 0xa0, 0xa0, 0},
+    {str_gdc_slave, 0xa2, 0xa2, 0},
+    {str_gdc_slave, 0xa4, 0xa4, 0},
+    {str_gdc_slave, 0xa6, 0xa6, 0},
+};
+
+#define GDC_CONSOLE_RESOURCES (sizeof(gdc_console_resources)/sizeof(struct resource))
+
+#define BLANK 0x0020
+#define BLANK_ATTR 0x00e1
+
+/* GDC/GGDC port# */
+#define GDC_COMMAND 0x62
+#define GDC_PARAM 0x60
+#define GDC_STAT 0x60
+#define GDC_DATA 0x62
+
+#define MODE_FF1	(0x0068)	/* mode F/F register 1 */
+
+#define  MODE_FF1_ATR_SEL	(0x00)	/* 0: vertical line 1: 8001 graphic */
+#define  MODE_FF1_GRAPHIC_MODE	(0x02)	/* 0: color 1: mono */
+#define  MODE_FF1_COLUMN_WIDTH	(0x04)	/* 0: 80col 1: 40col */
+#define  MODE_FF1_FONT_SEL	(0x06)	/* 0: 6x8 1: 7x13 */
+#define  MODE_FF1_GRP_MODE	(0x08)	/* 0: display odd-y raster 1: not */
+#define  MODE_FF1_KAC_MODE	(0x0a)	/* 0: code access 1: dot access */
+#define  MODE_FF1_NVMW_PERMIT	(0x0c)	/* 0: protect 1: permit */
+#define  MODE_FF1_DISP_ENABLE	(0x0e)	/* 0: enable 1: disable */
+
+#define GGDC_COMMAND 0xa2
+#define GGDC_PARAM 0xa0
+#define GGDC_STAT 0xa0
+#define GGDC_DATA 0xa2
+
+/* GDC status */
+#define GDC_DATA_READY		(1 << 0)
+#define GDC_FIFO_FULL		(1 << 1)
+#define GDC_FIFO_EMPTY		(1 << 2)
+#define GGDC_FIFO_EMPTY		GDC_FIFO_EMPTY
+#define GDC_DRAWING		(1 << 3)
+#define GDC_DMA_EXECUTE		(1 << 4)	/* nonsense on 98 */
+#define GDC_VERTICAL_SYNC	(1 << 5)
+#define GDC_HORIZONTAL_BLANK	(1 << 6)
+#define GDC_LIGHTPEN_DETECT	(1 << 7)	/* nonsense on 98 */
+
+#define ATTR_G		(1U << 7)
+#define ATTR_R		(1U << 6)
+#define ATTR_B		(1U << 5)
+#define ATTR_GRAPHIC	(1U << 4)
+#define ATTR_VERTBAR	ATTR_GRAPHIC	/* vertical bar */
+#define ATTR_UNDERLINE	(1U << 3)
+#define ATTR_REVERSE	(1U << 2)
+#define ATTR_BLINK	(1U << 1)
+#define ATTR_NOSECRET	(1U << 0)
+#define AMASK_NOCOLOR	(ATTR_GRAPHIC | ATTR_UNDERLINE | ATTR_REVERSE \
+			 | ATTR_BLINK | ATTR_NOSECRET)
+
+/*
+ *  Interface used by the world
+ */
+static const char *gdccon_startup(void);
+static void gdccon_init(struct vc_data *c, int init);
+static void gdccon_deinit(struct vc_data *c);
+static void gdccon_cursor(struct vc_data *c, int mode);
+static int gdccon_switch(struct vc_data *c);
+static int gdccon_blank(struct vc_data *c, int blank);
+static int gdccon_scrolldelta(struct vc_data *c, int lines);
+static int gdccon_set_origin(struct vc_data *c);
+static void gdccon_save_screen(struct vc_data *c);
+static int gdccon_scroll(struct vc_data *c, int t, int b, int dir, int lines);
+static u8 gdccon_build_attr(struct vc_data *c, u8 color, u8 intensity, u8 blink, u8 underline, u8 reverse);
+static void gdccon_invert_region(struct vc_data *c, u16 *p, int count);
+static unsigned long gdccon_uni_pagedir[2];
+
+/* Description of the hardware situation */
+static unsigned long   gdc_vram_base;		/* Base of video memory */
+static unsigned long   gdc_vram_end;		/* End of video memory */
+static unsigned int    gdc_video_num_columns = 80;
+						/* Number of text columns */
+static unsigned int    gdc_video_num_lines = 25;
+						/* Number of text lines */
+static int	       gdc_can_do_color = 1;	/* Do we support colors? */
+static unsigned char   gdc_video_type;		/* Card type */
+static unsigned char   gdc_hardscroll_enabled;
+static unsigned char   gdc_hardscroll_user_enable = 1;
+static int	       gdc_vesa_blanked = 0;
+static unsigned int    gdc_rolled_over = 0;
+
+#define DISP_FREQ_AUTO 0
+#define DISP_FREQ_25k  1
+#define DISP_FREQ_31k  2
+
+static unsigned int    gdc_disp_freq = DISP_FREQ_AUTO;
+
+#define gdc_attr_offset(x) ((typeof(x))((unsigned long)(x)+0x2000))
+
+#define	gdc_outb(val, port)	outb_p((val), (port))
+#define	gdc_inb(port)		inb_p(port)
+
+#define __gdc_write_command(cmd)	gdc_outb((cmd), GDC_COMMAND)
+#define __gdc_write_param(param)	gdc_outb((param), GDC_PARAM)
+
+static const char * __init gdccon_startup(void)
+{
+	const char *display_desc = NULL;
+	unsigned long hdots = gdc_video_num_lines * 16;
+	int i;
+
+	while (!(inb_p(GDC_STAT) & GDC_FIFO_EMPTY));
+	while (!(inb_p(GGDC_STAT) & GDC_FIFO_EMPTY));
+	spin_lock_irq(&gdc_lock);	
+	outb_p(0x0c, GDC_COMMAND);	/* STOP */
+	outb_p(0x0c, GGDC_COMMAND);	/* STOP */
+	if (PC9800_9821_P() && gdc_disp_freq == DISP_FREQ_AUTO) {
+		if (gdc_video_num_lines >= 30 || (inb(0x9a8) & 0x01)) {
+			gdc_disp_freq = DISP_FREQ_31k;
+		}
+	}
+
+	if (PC9800_9821_P() && gdc_disp_freq == DISP_FREQ_31k) {
+		outb_p(0x01, 0x9a8);   /* 31.47KHz */
+		outb_p(0x0e, GDC_COMMAND);  /* SYNC, DE deny */
+		outb_p(0x00, GDC_PARAM);  /* CHR, F, I, D, G, S = 0 */
+		outb_p(0x4e, GDC_PARAM);  /* C/R = 78 (80 chars) */
+		outb_p(0x4b, GDC_PARAM);  /* VSL = 2(3) ; HS = 11 */
+		outb_p(0x0c, GDC_PARAM);  /* HFP = 3    ; VSH = 0(VS=2) */
+		outb_p(0x03, GDC_PARAM);  /* DS, PH = 0 ; HBP = 3 */
+		outb_p(0x06, GDC_PARAM);  /* VH, VL = 0 ; VFP = 6 */
+		outb_p(hdots & 0xff, GDC_PARAM);  /* LFL */
+		outb_p(0x94 | ((hdots >> 8) & 0x03), GDC_PARAM);
+						/* VBP = 37   ; LFH */
+		outb_p(0x47, GDC_COMMAND);  /* PITCH */
+		outb_p(0x50, GDC_PARAM);
+
+		outb_p(0x70, GDC_COMMAND);  /* SCROLL */
+		outb_p(0x00, GDC_PARAM);
+		outb_p(0x00, GDC_PARAM);
+		outb_p((hdots << 4) & 0xf0, GDC_PARAM);  /* SL1=592 (0x250) */
+		outb_p((hdots >> 4) & 0x3f, GDC_PARAM);
+
+		outb_p(0x0e, GGDC_COMMAND);  /* SYNC, DE deny */
+		outb_p(0x00, GGDC_PARAM);  /* CHR, F, I, D, G, S = 0 */
+		outb_p(0x4e, GGDC_PARAM);  /* C/R = 78 (80 chars) */
+		outb_p(0x4b, GGDC_PARAM);  /* VSL = 2(3) ; HS = 11 */
+		outb_p(0x0c, GGDC_PARAM);  /* HFP = 3    ; VSH = 0(VS=2) */
+		outb_p(0x03, GGDC_PARAM);  /* DS, PH = 0 ; HBP = 3 */
+		outb_p(0x06, GGDC_PARAM);  /* VH, VL = 0 ; VFP = 6 */
+		outb_p(hdots & 0xff, GGDC_PARAM);  /* LFL */
+		outb_p(0x94 | ((hdots >> 8) & 0x03), GGDC_PARAM);
+						/* VBP = 37   ; LFH */
+	} else {
+		outb_p(0x00, 0x9a8);   /* 24.83 KHz */
+		outb_p(0x0e, GDC_COMMAND);  /* SYNC, DE deny */
+		outb_p(0x00, GDC_PARAM);  /* CHR, F, I, D, G, S = 0 */
+		outb_p(0x4e, GDC_PARAM);  /* C/R = 78 (80 chars) */
+		outb_p(0x07, GDC_PARAM);  /* VSL = 0(3) ; HS = 7 */
+		outb_p(0x25, GDC_PARAM);  /* HFP = 9    ; VSH = 1(VS=8) */
+		outb_p(0x07, GDC_PARAM);  /* DS, PH = 0 ; HBP = 7 */
+		outb_p(0x07, GDC_PARAM);  /* VH, VL = 0 ; VFP = 7 */
+		outb_p(hdots & 0xff, GDC_PARAM);  /* LFL */
+		outb_p(0x64 | ((hdots >> 8) & 0x03), GDC_PARAM);
+						/* VBP = 25   ; LFH */
+		outb_p(0x47, GDC_COMMAND);  /* PITCH */
+		outb_p(0x50, GDC_PARAM);
+
+		outb_p(0x70, GDC_COMMAND);  /* SCROLL */
+		outb_p(0x00, GDC_PARAM);
+		outb_p(0x00, GDC_PARAM);
+		outb_p((hdots << 4) & 0xf0, GDC_PARAM);  /* SL1=592 (0x250) */
+		outb_p((hdots >> 4) & 0x3f, GDC_PARAM);
+
+		outb_p(0x0e, GGDC_COMMAND);  /* SYNC */
+		outb_p(0x00, GGDC_PARAM);
+		outb_p(0x4e, GGDC_PARAM);
+		outb_p(0x07, GGDC_PARAM);
+		outb_p(0x25, GGDC_PARAM);
+		outb_p(0x07, GGDC_PARAM);
+		outb_p(0x07, GGDC_PARAM);
+		outb_p(hdots & 0xff, GGDC_PARAM);  /* LFL */
+		outb_p(0x64 | ((hdots >> 8) & 0x03), GGDC_PARAM);
+						/* VBP = 25   ; LFH */
+	}
+
+	outb_p(0x47, GGDC_COMMAND);  /* PITCH */ 
+	outb_p(0x28, GGDC_PARAM);
+
+	outb_p(0x0d, GDC_COMMAND);	/* START */
+	outb_p(0x0d, GGDC_COMMAND);	/* START */
+	spin_unlock_irq(&gdc_lock);	
+
+	gdc_vram_base = (unsigned long)phys_to_virt(0xa0000);
+	/* Last few bytes of text VRAM area are for NVRAM. */
+	gdc_vram_end = gdc_vram_base + 0x1fe0;
+
+	if (!PC9800_HIGHRESO_P()) {
+		gdc_video_type = VIDEO_TYPE_98NORMAL;
+		display_desc = "NEC PC-9800 Normal";
+	} else {
+		gdc_video_type = VIDEO_TYPE_98HIRESO;
+		display_desc = "NEC PC-9800 High Resolution";
+	}
+
+	gdc_hardscroll_enabled = gdc_hardscroll_user_enable;
+	
+	for (i = 0; i < GDC_CONSOLE_RESOURCES; i++)
+		request_resource(&ioport_resource, gdc_console_resources + i);
+
+	return display_desc;
+}
+
+static void gdccon_init(struct vc_data *c, int init)
+{
+	unsigned long p;
+	
+	/* We cannot be loaded as a module, therefore init is always 1 */
+	c->vc_can_do_color = gdc_can_do_color;
+	c->vc_cols = gdc_video_num_columns;
+	c->vc_rows = gdc_video_num_lines;
+	c->vc_complement_mask = ATTR_REVERSE << 8;
+	p = *c->vc_uni_pagedir_loc;
+	if (c->vc_uni_pagedir_loc == &c->vc_uni_pagedir
+	    || !--c->vc_uni_pagedir_loc[1])
+		con_free_unimap(c->vc_num);
+
+	c->vc_uni_pagedir_loc = gdccon_uni_pagedir;
+	gdccon_uni_pagedir[1]++;
+	if (!gdccon_uni_pagedir[0] && p)
+		con_set_default_unimap(c->vc_num);
+}
+
+static inline void gdc_set_mem_top(struct vc_data *c)
+{
+	unsigned long flags;
+	unsigned long origin = (c->vc_visible_origin - gdc_vram_base) / 2;
+
+	spin_lock_irqsave(&gdc_lock, flags);
+	while (!(inb_p(GDC_STAT) & GDC_FIFO_EMPTY));
+	__gdc_write_command(0x70);			/* SCROLL */
+	__gdc_write_param(origin);			/* SAD1 (L) */
+	__gdc_write_param((origin >> 8) & 0x1f);	/* SAD1 (H) */
+	spin_unlock_irqrestore(&gdc_lock, flags);
+}
+
+static void gdccon_deinit(struct vc_data *c)
+{
+	/* When closing the last console, reset video origin */
+	if (!--gdccon_uni_pagedir[1]) {
+		c->vc_visible_origin = gdc_vram_base;
+		gdc_set_mem_top(c);
+		con_free_unimap(c->vc_num);
+	}
+
+	c->vc_uni_pagedir_loc = &c->vc_uni_pagedir;
+	con_set_default_unimap(c->vc_num);
+}
+
+#if 0
+/* Translate ANSI terminal color code to GDC color code.  */
+#define BGR_TO_GRB(bgr)	((((bgr) & 4) >> 2) | (((bgr) & 3) << 1))
+#else
+#define RGB_TO_GRB(rgb)	((((rgb) & 4) >> 1) | (((rgb) & 2) << 1) | ((rgb) & 1))
+#endif
+
+static const u8 gdccon_color_table[] = {
+#define C(color)	((RGB_TO_GRB (color) << 5) | ATTR_NOSECRET)
+	C(0), C(1), C(2), C(3), C(4), C(5), C(6), C(7)
+#undef C
+};
+
+static u8 gdccon_build_attr(struct vc_data *c, u8 color, u8 intensity, u8 blink, u8 underline, u8 reverse)
+{
+	u8 attr = gdccon_color_table[color & 0x07];
+
+	if (!gdc_can_do_color)
+		attr = (intensity == 0 ? 0x61
+			: intensity == 2 ? 0xe1 : 0xa1);
+
+	if (underline)
+		attr |= 0x08;
+
+	/* ignore intensity */
+#if 0
+	if(intensity == 0)
+		;
+	else if (intensity == 2)
+		attr |= 0x10; /* virtical line */
+#else
+	if (intensity == 0) {
+		if (attr == c->vc_def_attr)
+			attr = c->vc_half_attr;
+		else
+			attr |= c->vc_half_attr & AMASK_NOCOLOR;
+	} else if (intensity == 2) {
+		if (attr == c->vc_def_attr)
+			attr = c->vc_bold_attr;
+		else
+			attr |= c->vc_bold_attr & AMASK_NOCOLOR;
+	}
+#endif
+	if (reverse)
+		attr |= ATTR_REVERSE;
+
+	if ((color & 0x07) == 0) {	/* foreground color == black */
+		/* Fake background color by reversed character
+		   as GDC cannot set background color.  */
+		attr |= gdccon_color_table[(color >> 4) & 0x07];
+		attr ^= ATTR_REVERSE;
+	}
+
+	if (blink)
+		attr |= ATTR_BLINK;
+
+	return attr;
+}
+
+static void gdccon_invert_region(struct vc_data *c, u16 *p, int count)
+{
+	while (count--) {
+		*((u16 *)(gdc_attr_offset(p))) ^= ATTR_REVERSE;
+		p++;
+	}
+}
+
+static u8 gdc_csrform_lr = 15;			/* Lines/Row */
+static u16 gdc_csrform_bl_bd = ((12 << 6)	/* BLinking Rate */
+				| (0 << 5));	/* Blinking Disable */
+
+static inline void gdc_hide_cursor(void)
+{
+    __gdc_write_command(0x4b);		/* CSRFORM */
+    __gdc_write_param(gdc_csrform_lr);	/* CS = 0, CE = 0, L/R = ? */
+}
+
+static inline void gdc_show_cursor(int cursor_start, int cursor_finish)
+{
+    __gdc_write_command(0x4b);		/* CSRFORM */
+    __gdc_write_param(0x80 | gdc_csrform_lr);		/* CS = 1 */
+    __gdc_write_param(cursor_start | gdc_csrform_bl_bd);
+    __gdc_write_param((cursor_finish << 3) | (gdc_csrform_bl_bd >> 8));
+}
+
+static void gdccon_cursor(struct vc_data *c, int mode)
+{
+    unsigned long flags;
+    u16 ead;
+
+    if (c->vc_origin != c->vc_visible_origin)
+	gdccon_scrolldelta(c, 0);
+
+    spin_lock_irqsave(&gdc_lock, flags);
+    while (!(inb_p(GDC_STAT) & GDC_FIFO_EMPTY));
+    spin_unlock_irqrestore(&gdc_lock, flags);
+    switch (mode) {
+	case CM_ERASE:
+	    gdc_hide_cursor();
+	    break;
+
+	case CM_MOVE:
+	case CM_DRAW:
+	    switch (c->vc_cursor_type & 0x0f) {
+		case CUR_UNDERLINE:
+		    gdc_show_cursor(14, 15);	/* XXX font height */
+		    break;
+
+		case CUR_TWO_THIRDS:
+		    gdc_show_cursor(5, 15);	/* XXX */
+		    break;
+
+		case CUR_LOWER_THIRD:
+		    gdc_show_cursor(11, 15);	/* XXX */
+		    break;
+
+		case CUR_LOWER_HALF:
+		    gdc_show_cursor(8, 15);	/* XXX */
+		    break;
+
+		case CUR_NONE:
+		    gdc_hide_cursor();
+		    break;
+
+          	default:
+		    gdc_show_cursor(0, 15);	/* XXX */
+		    break;
+	    }
+
+	    spin_lock_irqsave(&gdc_lock, flags);
+	    __gdc_write_command(0x49);		/* CSRW */
+	    ead = (c->vc_pos - gdc_vram_base) >> 1;
+	    __gdc_write_param(ead);
+	    __gdc_write_param((ead >> 8) & 0x1f);
+	    spin_unlock_irqrestore(&gdc_lock, flags);
+	    break;
+    }
+
+}
+
+static int gdccon_switch(struct vc_data *c)
+{
+	/*
+	 * We need to save screen size here as it's the only way
+	 * we can spot the screen has been resized and we need to
+	 * set size of freshly allocated screens ourselves.
+	 */
+	gdc_video_num_columns = c->vc_cols;
+	gdc_video_num_lines = c->vc_rows;
+	if (c->vc_origin != (unsigned long)c->vc_screenbuf
+	    && gdc_vram_base <= c->vc_origin && c->vc_origin < gdc_vram_end) {
+		_scr_memcpyw_to((u16 *)c->vc_origin,
+				(u16 *)c->vc_screenbuf,
+				c->vc_screenbuf_size);
+		_scr_memcpyw_to((u16 *)gdc_attr_offset(c->vc_origin),
+				(u16 *)((char *)c->vc_screenbuf
+					 + c->vc_screenbuf_size),
+				c->vc_screenbuf_size);
+	} else
+		printk(KERN_WARNING
+			"gdccon: switch (vc #%d) called on origin=%lx\n",
+			c->vc_num, c->vc_origin);
+
+	return 0;	/* Redrawing not needed */
+}
+
+static int gdccon_set_palette(struct vc_data *c, unsigned char *table)
+{
+	return -EINVAL;
+}
+
+#define RELAY0		0x01
+#define RELAY0_GDC	0x00
+#define RELAY0_ACCEL	0x01
+#define RELAY1		0x02
+#define RELAY1_INTERNAL	0x00
+#define RELAY1_EXTERNAL	0x02
+#define IO_RELAY	0x0fac
+#define IO_DPMS		0x09a2
+static unsigned char relay_mode = RELAY0_GDC | RELAY1_INTERNAL;
+
+static void gdc_vesa_blank(int mode)
+{
+    unsigned char stat;
+
+    spin_lock_irq(&gdc_lock);
+
+    relay_mode = inb_p(IO_RELAY);
+    if ((relay_mode & (RELAY0 | RELAY1)) != (RELAY0_GDC | RELAY1_INTERNAL)) {
+#ifdef CONFIG_DONTTOUCHRELAY
+	spin_unlock_irq(&gdc_lock);
+	return;
+#else
+	outb_p((relay_mode & ~(RELAY0 | RELAY1)) |
+	       RELAY0_GDC | RELAY1_INTERNAL , IO_RELAY);
+#endif
+    }
+
+    if (mode & VESA_VSYNC_SUSPEND) {
+	stat = inb_p(IO_DPMS);
+	outb_p(stat | 0x80, IO_DPMS);
+    }
+    if (mode & VESA_HSYNC_SUSPEND) {
+	stat = inb_p(IO_DPMS);
+	outb_p(stat | 0x40, IO_DPMS);
+    }
+
+    spin_unlock_irq(&gdc_lock);
+}
+
+static void gdc_vesa_unblank(void)
+{
+    unsigned char stat;
+
+#ifdef CONFIG_DONTTOUCHRELAY
+    if (relay_mode & (RELAY0 | RELAY1))
+	return;
+#endif
+
+    spin_lock_irq(&gdc_lock);
+
+    stat = inb_p(0x09a2);
+    outb_p(stat & ~0xc0, IO_DPMS);
+    if (relay_mode & (RELAY0 | RELAY1))
+	outb_p(relay_mode, IO_RELAY);
+
+    spin_unlock_irq(&gdc_lock);
+}
+
+static int gdccon_blank(struct vc_data *c, int blank)
+{
+	switch (blank) {
+	case 0:				/* Unblank */
+		if (gdc_vesa_blanked) {
+			gdc_vesa_unblank();
+			gdc_vesa_blanked = 0;
+		}
+
+		outb(MODE_FF1_DISP_ENABLE | 1, MODE_FF1);
+
+		/* Tell console.c that it need not to restore the screen */
+		return 0;
+
+	case 1:				/* Normal blanking */
+		/* Disable displaying */
+		outb(MODE_FF1_DISP_ENABLE | 0, MODE_FF1);
+
+		/* Tell console.c that it need not to reset origin */
+		return 0;
+
+	case -1:			/* Entering graphic mode */
+		return 1;
+
+	default:			/* VESA blanking */
+		if (gdc_video_type == VIDEO_TYPE_98NORMAL
+		    || gdc_video_type == VIDEO_TYPE_9840
+		    || gdc_video_type == VIDEO_TYPE_98HIRESO) {
+			gdc_vesa_blank(blank - 1);
+			gdc_vesa_blanked = blank;
+		}
+
+		return 0;
+	}
+}
+
+static int gdccon_font_op(struct vc_data *c, struct console_font_op *op)
+{
+	return -ENOSYS;
+}
+
+static int gdccon_scrolldelta(struct vc_data *c, int lines)
+{
+	if (!lines)			/* Turn scrollback off */
+		c->vc_visible_origin = c->vc_origin;
+	else {
+		int vram_size = gdc_vram_end - gdc_vram_base;
+		int margin = c->vc_size_row /* * 4 */;
+		int ul, we, p, st;
+
+		if (gdc_rolled_over > c->vc_scr_end - gdc_vram_base + margin) {
+			ul = c->vc_scr_end - gdc_vram_base;
+			we = gdc_rolled_over + c->vc_size_row;
+		} else {
+			ul = 0;
+			we = vram_size;
+		}
+
+		p = (c->vc_visible_origin - gdc_vram_base - ul + we)
+			% we + lines * c->vc_size_row;
+		st = (c->vc_origin - gdc_vram_base - ul + we) % we;
+		if (p < margin)
+			p = 0;
+
+		if (p > st - margin)
+			p = st;
+		c->vc_visible_origin = gdc_vram_base + (p + ul) % we;
+	}
+
+	gdc_set_mem_top(c);
+	return 1;
+}
+
+static int gdccon_set_origin(struct vc_data *c)
+{
+	c->vc_origin = c->vc_visible_origin = gdc_vram_base;
+	gdc_set_mem_top(c);
+	gdc_rolled_over = 0;
+	return 1;
+}
+
+static void gdccon_save_screen(struct vc_data *c)
+{
+	static int gdc_bootup_console = 0;
+
+	if (!gdc_bootup_console) {
+		/* This is a gross hack, but here is the only place we can
+		 * set bootup console parameters without messing up generic
+		 * console initialization routines.
+		 */
+		gdc_bootup_console = 1;
+		c->vc_x = ORIG_X;
+		c->vc_y = ORIG_Y;
+	}
+
+	_scr_memcpyw_from((u16 *)c->vc_screenbuf,
+				(u16 *)c->vc_origin, c->vc_screenbuf_size);
+	_scr_memcpyw_from((u16 *)((char *)c->vc_screenbuf + c->vc_screenbuf_size), (u16 *)gdc_attr_offset(c->vc_origin), c->vc_screenbuf_size);
+}
+
+static int gdccon_scroll(struct vc_data *c, int t, int b, int dir, int lines)
+{
+	unsigned long oldo;
+	unsigned int delta;
+
+	if (t || b != c->vc_rows)
+		return 0;
+
+	if (c->vc_origin != c->vc_visible_origin)
+		gdccon_scrolldelta(c, 0);
+
+	if (!gdc_hardscroll_enabled || lines >= c->vc_rows / 2)
+		return 0;
+
+	oldo = c->vc_origin;
+	delta = lines * c->vc_size_row;
+	if (dir == SM_UP) {
+		if (c->vc_scr_end + delta >= gdc_vram_end) {
+			_scr_memcpyw((u16 *)gdc_vram_base,
+				    (u16 *)(oldo + delta),
+				    c->vc_screenbuf_size - delta);
+			_scr_memcpyw((u16 *)gdc_attr_offset(gdc_vram_base),
+				    (u16 *)gdc_attr_offset(oldo + delta),
+				    c->vc_screenbuf_size - delta);
+			c->vc_origin = gdc_vram_base;
+			gdc_rolled_over = oldo - gdc_vram_base;
+		} else
+			c->vc_origin += delta;
+
+		_scr_memsetw((u16 *)(c->vc_origin + c->vc_screenbuf_size - delta), c->vc_video_erase_char & 0xff, delta);
+		_scr_memsetw((u16 *)gdc_attr_offset(c->vc_origin + c->vc_screenbuf_size - delta), c->vc_video_erase_char >> 8, delta);
+	} else {
+		if (oldo - delta < gdc_vram_base) {
+			_scr_memmovew((u16 *)(gdc_vram_end - c->vc_screenbuf_size + delta), (u16 *)oldo, c->vc_screenbuf_size - delta);
+			_scr_memmovew((u16 *)gdc_attr_offset(gdc_vram_end - c->vc_screenbuf_size + delta), (u16 *)gdc_attr_offset(oldo), c->vc_screenbuf_size - delta);
+			c->vc_origin = gdc_vram_end - c->vc_screenbuf_size;
+			gdc_rolled_over = 0;
+		} else
+			c->vc_origin -= delta;
+
+		c->vc_scr_end = c->vc_origin + c->vc_screenbuf_size;
+		_scr_memsetw((u16 *)(c->vc_origin), c->vc_video_erase_char & 0xff, delta);
+		_scr_memsetw((u16 *)gdc_attr_offset(c->vc_origin), c->vc_video_erase_char >> 8, delta);
+	}
+
+	c->vc_scr_end = c->vc_origin + c->vc_screenbuf_size;
+	c->vc_visible_origin = c->vc_origin;
+	gdc_set_mem_top(c);
+	c->vc_pos = (c->vc_pos - oldo) + c->vc_origin;
+	return 1;
+}
+
+static int gdccon_setterm_command(struct vc_data *c)
+{
+	switch (c->vc_par[0]) {
+	case 1: /* set attr for underline mode */
+		if (c->vc_npar < 2) {
+			if (c->vc_par[1] < 16)
+				c->vc_ul_attr = gdccon_color_table[color_table[c->vc_par[1]] & 7];
+		} else {
+			if (c->vc_par[2] < 256)
+				c->vc_ul_attr = c->vc_par[2];
+		}
+
+		if (c->vc_underline)
+			goto update_attr;
+
+		return 1;
+
+	case 2:	/* set attr for half intensity mode */
+		if (c->vc_npar < 2) {
+			if (c->vc_par[1] < 16)
+				c->vc_half_attr = gdccon_color_table[color_table[c->vc_par[1]] & 7];
+		}
+		else {
+			if (c->vc_par[2] < 256)
+				c->vc_half_attr = c->vc_par[2];
+		}
+
+		if (c->vc_intensity == 0)
+			goto update_attr;
+
+		return 1;
+
+	case 3: /* set color for bold mode */
+		if (c->vc_npar < 2) {
+			if (c->vc_par[1] < 16)
+				c->vc_bold_attr = gdccon_color_table[color_table[c->vc_par[1]] & 7];
+		} else {
+			if (c->vc_par[2] < 256)
+				c->vc_bold_attr = c->vc_par[2];
+		}
+
+		if (c->vc_intensity == 2)
+			goto update_attr;
+
+		return 1;
+	}
+
+	return 0;
+
+update_attr:
+	c->vc_attr = gdccon_build_attr(c,
+					c->vc_color, c->vc_intensity,
+					c->vc_blink, c->vc_underline,
+					c->vc_reverse);
+	return 1;
+}
+
+/*
+ *  The console `switch' structure for the GDC based console
+ */
+
+static int gdccon_dummy(struct vc_data *c)
+{
+	return 0;
+}
+
+#define DUMMY (void *) gdccon_dummy
+
+const struct consw gdc_con = {
+	.con_startup =		gdccon_startup,
+	.con_init =		gdccon_init,
+	.con_deinit =		gdccon_deinit,
+	.con_clear =		DUMMY,
+	.con_putc =		DUMMY,
+	.con_putcs =		DUMMY,
+	.con_cursor =		gdccon_cursor,
+	.con_scroll =		gdccon_scroll,
+	.con_bmove =		DUMMY,
+	.con_switch =		gdccon_switch,
+	.con_blank =		gdccon_blank,
+	.con_font_op =		gdccon_font_op,
+	.con_set_palette =	gdccon_set_palette,
+	.con_scrolldelta =	gdccon_scrolldelta,
+	.con_set_origin =	gdccon_set_origin,
+	.con_save_screen =	gdccon_save_screen,
+	.con_build_attr =	gdccon_build_attr,
+	.con_invert_region =	gdccon_invert_region,
+	.con_setterm_command =	gdccon_setterm_command
+};
+
+static int __init gdc_setup(char *str)
+{
+	unsigned long tmp_ulong;
+	char *opt, *orig_opt, *endp;
+
+	while ((opt = strsep(&str, ",")) != NULL) {
+		int force = 0;
+
+		orig_opt = opt;
+		if (!strncmp(opt, "force", 5)) {
+			force = 1;
+			opt += 5;
+		}
+
+		if (!strcmp(opt, "mono"))
+			gdc_can_do_color = 0;
+		else if ((tmp_ulong = simple_strtoul(opt, &endp, 0)) > 0) {
+			if (!strcmp(endp, "lines")
+			    || (!strcmp(endp, "linesforce") && (force == 1))) {
+				if (!force
+				    && (tmp_ulong < 20
+					|| (!PC9800_9821_P()
+					    && 25 < tmp_ulong)
+					|| 37 < tmp_ulong))
+					printk(KERN_ERR
+						"gdccon: %d is out of bound"
+						" for number of lines\n",
+						(int)tmp_ulong);
+				else
+					gdc_video_num_lines = tmp_ulong;
+			} else if (!strcmp(endp, "kHz")) {
+				if (tmp_ulong == 24 || tmp_ulong == 25)
+					gdc_disp_freq = DISP_FREQ_25k;
+				else
+					printk(KERN_ERR "gdccon: `%s' ignored\n",
+						orig_opt);
+			} else
+				printk(KERN_ERR "gdccon: unknown option `%s'\n",
+					orig_opt);
+		} else
+			printk(KERN_ERR "gdccon: unknown option `%s'\n",
+				orig_opt);
+	}
+
+	return 1; 
+}
+
+__setup("gdccon=", gdc_setup);
+
+/*
+ * We will follow Linus's indenting style...
+ *
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60/drivers/video/console/Makefile linux98-2.5.60/drivers/video/console/Makefile
--- linux-2.5.60/drivers/video/console/Makefile	2003-02-11 03:38:30.000000000 +0900
+++ linux98-2.5.60/drivers/video/console/Makefile	2003-02-11 09:47:18.000000000 +0900
@@ -19,6 +19,7 @@
 # Each configuration option enables a list of files.
 
 obj-$(CONFIG_DUMMY_CONSOLE)       += dummycon.o
+obj-$(CONFIG_GDC_CONSOLE)         += gdccon.o
 obj-$(CONFIG_SGI_NEWPORT_CONSOLE) += newport_con.o
 obj-$(CONFIG_PROM_CONSOLE)        += promcon.o promcon_tbl.o
 obj-$(CONFIG_STI_CONSOLE)         += sticon.o sticore.o
