Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261385AbSKBSMa>; Sat, 2 Nov 2002 13:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261384AbSKBSM3>; Sat, 2 Nov 2002 13:12:29 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:65363 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261376AbSKBSMG>; Sat, 2 Nov 2002 13:12:06 -0500
Date: Sun, 3 Nov 2002 03:18:17 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [RFC][Patchset 16/20] Support for PC-9800 (RTC)
Message-ID: <20021103031817.G1536@precia.cinet.co.jp>
References: <20021103023345.A1536@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: =?iso-8859-1?Q?=3C20021103023345=2EA1536?=
	=?iso-8859-1?B?QHByZWNpYS5jaW5ldC5jby5qcD47IGZyb20gdG9taXRhQGNpbmV0LmNv?=
	=?iso-8859-1?B?LmpwIG9uIMb8LCAxMbfu?= 03, 2002 at 02:33:45 +0900
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 16/20 of patchset for add support NEC PC-9800 architecture,
against 2.5.45.

Summary:
  PC-9800 standard real time clock driver.(add new files)

diffstat:
  drivers/char/upd4990a.c     |  438 ++++++++++++++++++++++++++++++++++++++++++++
  include/asm-i386/upd4990a.h |   58 +++++
  include/linux/upd4990a.h    |  140 ++++++++++++++
  3 files changed, 636 insertions(+)

patch:
diff -urN linux/drivers/char/upd4990a.c linux98/drivers/char/upd4990a.c
--- linux/drivers/char/upd4990a.c	Thu Jan  1 09:00:00 1970
+++ linux98/drivers/char/upd4990a.c	Fri Aug 17 21:50:17 2001
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
+static const unsigned char days_in_mo[] = +{31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
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
+		retval = sizeof(unsigned long); + out:
+	set_current_state(TASK_RUNNING);
+	remove_wait_queue(&rtc_wait, &wait);
+
+	return retval;
+}
+
+static int rtc_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+		     unsigned long arg)
+{
+	struct rtc_time wtime; +	struct upd4990a_raw_data raw;
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
diff -urN linux/include/asm-i386/upd4990a.h linux98/include/asm-i386/upd4990a.h
--- linux/include/asm-i386/upd4990a.h	Thu Jan  1 09:00:00 1970
+++ linux98/include/asm-i386/upd4990a.h	Fri Aug 17 22:15:17 2001
@@ -0,0 +1,58 @@
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
+#include <linux/config.h>
+
+#ifdef CONFIG_PC9800
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
+#endif /* CONFIG_PC9800 */
+
+#endif
diff -urN linux/include/linux/upd4990a.h linux98/include/linux/upd4990a.h
--- linux/include/linux/upd4990a.h	Thu Jan  1 09:00:00 1970
+++ linux98/include/linux/upd4990a.h	Fri Aug 17 22:15:48 2001
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
