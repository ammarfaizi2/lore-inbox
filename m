Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317742AbSGVQpJ>; Mon, 22 Jul 2002 12:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317743AbSGVQpI>; Mon, 22 Jul 2002 12:45:08 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:14767
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S317742AbSGVQou>; Mon, 22 Jul 2002 12:44:50 -0400
Date: Mon, 22 Jul 2002 09:47:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][RESEND x2] A generic RTC driver
Message-ID: <20020722164737.GC692@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is the m68k generic rtc driver, slightly updated for 2.5.

This has been in the m68k tree for a number of years now, so the general
code behind it is quite sound.  This has also been abstracted to the
point where it works on other archs (mainly due to m68k/PPC hybrid
machines).  This is quite useful since a number of archs cannot use
drivers/char/rtc.c because they have very different hardware, or other
issues.

This also includes include/asm-ppc/rtc.h, which makes
drivers/char/genrtc.c work on all[1] PPC32 systems.  This has been in
the PPC 2.5 tree for a while now and has been approved by Paul.

This should also be useful on MIPS, who at one point in the past were
about to copy the PPC rtc driver (drivers/macintosh/rtc.c) and quite
probably useful on other archs as well.

This is the 3rd time I've sent this driver, with the only feedback
being that (in a private mail) one if the ia64 developers said they had
done something similar to work with Intel's Multimedia Timer Spec, and
in the end agreeing that the extra functionality in his driver could be
adapted to this driver, and it's more important to get this driver
accepted as well).  So in addition to PPC32, m68k (and quite probably
PPC64, MIPS, MIPS64) this will also have a use on ia64.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
[1]: With the exception of the m68k/PPC hybrid machines which had to do
'interesting' things previously to get the genrtc driver to work.

diff -Nru a/drivers/char/Config.help b/drivers/char/Config.help
--- a/drivers/char/Config.help	Tue Jul  9 13:02:51 2002
+++ b/drivers/char/Config.help	Tue Jul  9 13:02:51 2002
@@ -1058,6 +1058,31 @@
   The module is called rtc.o. If you want to compile it as a module,
   say M here and read <file:Documentation/modules.txt>.
 
+Generic Real Time Clock Support
+CONFIG_GEN_RTC
+  If you say Y here and create a character special file /dev/rtc with
+  major number 10 and minor number 135 using mknod ("man mknod"), you
+  will get access to the real time clock (or hardware clock) built
+  into your computer.
+
+  It reports status information via the file /proc/driver/rtc and its
+  behaviour is set by various ioctls on /dev/rtc. If you enable the
+  "extended RTC operation" below it will also provide an emulation
+  for RTC_UIE which is required by some programs and may improve
+  precision in some cases.
+
+  This driver is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module is called genrtc.o. If you want to compile it as a module,
+  say M here and read <file:Documentation/modules.txt>. To load the
+  module automaticaly add 'alias char-major-10-135 genrtc' to your
+  /etc/modules.conf
+
+Extended RTC operation
+CONFIG_GEN_RTC_X
+  Provides an emulation for RTC_UIE which is required by some programs
+  and may improve precision of the generic RTC support in some cases.
+
 CONFIG_H8
   The Hitachi H8/337 is a microcontroller used to deal with the power
   and thermal environment. If you say Y here, you will be able to
diff -Nru a/drivers/char/Config.in b/drivers/char/Config.in
--- a/drivers/char/Config.in	Tue Jul  9 13:02:51 2002
+++ b/drivers/char/Config.in	Tue Jul  9 13:02:51 2002
@@ -188,6 +188,12 @@
 dep_tristate 'Intel i8x0 Random Number Generator support' CONFIG_INTEL_RNG $CONFIG_PCI
 tristate '/dev/nvram support' CONFIG_NVRAM
 tristate 'Enhanced Real Time Clock Support' CONFIG_RTC
+if [ "$CONFIG_RTC" != "y" ]; then
+   tristate 'Generic /dev/rtc emulation' CONFIG_GEN_RTC      
+   if [ "$CONFIG_GEN_RTC" != "n" ]; then
+      bool '   Extended RTC operation' CONFIG_GEN_RTC_X
+   fi
+fi
 if [ "$CONFIG_IA64" = "y" ]; then
    bool 'EFI Real Time Clock Services' CONFIG_EFI_RTC
 fi
diff -Nru a/drivers/char/genrtc.c b/drivers/char/genrtc.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/char/genrtc.c	Tue Jul  9 13:02:51 2002
@@ -0,0 +1,518 @@
+/*
+ *	Real Time Clock interface for q40 and other m68k machines
+ *      emulate some RTC irq capabilities in software
+ *
+ *      Copyright (C) 1999 Richard Zidlicky
+ *
+ *	based on Paul Gortmaker's rtc.c device and
+ *           Sam Creasey Generic rtc driver
+ *
+ *	This driver allows use of the real time clock (built into
+ *	nearly all computers) from user space. It exports the /dev/rtc
+ *	interface supporting various ioctl() and also the /proc/dev/rtc
+ *	pseudo-file for status information.
+ *
+ *	The ioctls can be used to set the interrupt behaviour where
+ *  supported.
+ *
+ *	The /dev/rtc interface will block on reads until an interrupt
+ *	has been received. If a RTC interrupt has already happened,
+ *	it will output an unsigned long and then block. The output value
+ *	contains the interrupt status in the low byte and the number of
+ *	interrupts since the last read in the remaining high bytes. The
+ *	/dev/rtc interface can also be used with the select(2) call.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+
+ *      1.01 fix for 2.3.X                    rz@linux-m68k.org
+ *      1.02 merged with code from genrtc.c   rz@linux-m68k.org
+ *      1.03 make it more portable            zippel@linux-m68k.org
+ *      1.04 removed useless timer code       rz@linux-m68k.org
+ *      1.05 portable RTC_UIE emulation       rz@linux-m68k.org
+ */
+
+#define RTC_VERSION	"1.05"
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/miscdevice.h>
+#include <linux/fcntl.h>
+
+#include <linux/rtc.h>
+#include <linux/init.h>
+#include <linux/poll.h>
+#include <linux/proc_fs.h>
+#include <linux/tqueue.h>
+
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <asm/rtc.h>
+
+/*
+ *	We sponge a minor off of the misc major. No need slurping
+ *	up another valuable major dev number for this. If you add
+ *	an ioctl, make sure you don't conflict with SPARC's RTC
+ *	ioctls.
+ */
+
+static DECLARE_WAIT_QUEUE_HEAD(gen_rtc_wait);
+
+static int gen_rtc_ioctl(struct inode *inode, struct file *file,
+		     unsigned int cmd, unsigned long arg);
+
+/*
+ *	Bits in gen_rtc_status.
+ */
+
+#define RTC_IS_OPEN		0x01	/* means /dev/rtc is in use	*/
+
+unsigned char gen_rtc_status;		/* bitmapped status byte.	*/
+unsigned long gen_rtc_irq_data;		/* our output to the world	*/
+
+/* months start at 0 now */
+unsigned char days_in_mo[] =
+{31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
+
+static int irq_active;
+
+#ifdef CONFIG_GEN_RTC_X
+struct tq_struct genrtc_task;
+static struct timer_list timer_task;
+
+static unsigned int oldsecs;
+static int lostint;
+static int tt_exp;
+
+void gen_rtc_timer(unsigned long data);
+
+static volatile int stask_active;              /* schedule_task */
+static volatile int ttask_active;              /* timer_task */
+static int stop_rtc_timers;                    /* don't requeue tasks */
+static spinlock_t gen_rtc_lock = SPIN_LOCK_UNLOCKED;
+
+/*
+ * Routine to poll RTC seconds field for change as often as posible,
+ * after first RTC_UIE use timer to reduce polling
+ */
+void genrtc_troutine(void *data)
+{
+	unsigned int tmp = get_rtc_ss();
+	
+	if (stop_rtc_timers) {
+		stask_active = 0;
+		return;
+	}
+
+	if (oldsecs != tmp){
+		oldsecs = tmp;
+
+		timer_task.function = gen_rtc_timer;
+		timer_task.expires = jiffies + HZ - (HZ/10);
+		tt_exp=timer_task.expires;
+		ttask_active=1;
+		stask_active=0;
+		add_timer(&timer_task);
+
+		gen_rtc_interrupt(0);
+	} else if (schedule_task(&genrtc_task) == 0)
+		stask_active = 0;
+}
+
+void gen_rtc_timer(unsigned long data)
+{
+	lostint = get_rtc_ss() - oldsecs ;
+	if (lostint<0) 
+		lostint = 60 - lostint;
+	if (jiffies-tt_exp>1)
+		printk("genrtc: timer task delayed by %ld jiffies\n",
+		       jiffies-tt_exp);
+	ttask_active=0;
+	stask_active=1;
+	if ((schedule_task(&genrtc_task) == 0))
+		stask_active = 0;
+}
+
+/* 
+ * call gen_rtc_interrupt function to signal an RTC_UIE,
+ * arg is unused.
+ * Could be invoked either from a real interrupt handler or
+ * from some routine that periodically (eg 100HZ) monitors
+ * whether RTC_SECS changed
+ */
+void gen_rtc_interrupt(unsigned long arg)
+{
+	/*  We store the status in the low byte and the number of
+	 *	interrupts received since the last read in the remainder
+	 *	of rtc_irq_data.  */
+
+	gen_rtc_irq_data += 0x100;
+	gen_rtc_irq_data &= ~0xff;
+	gen_rtc_irq_data |= RTC_UIE;
+
+	if (lostint){
+		printk("genrtc: system delaying clock ticks?\n");
+		/* increment count so that userspace knows something is wrong */
+		gen_rtc_irq_data += ((lostint-1)<<8);
+		lostint = 0;
+	}
+
+	wake_up_interruptible(&gen_rtc_wait);
+}
+
+/*
+ *	Now all the various file operations that we export.
+ */
+static ssize_t gen_rtc_read(struct file *file, char *buf,
+			size_t count, loff_t *ppos)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	unsigned long data;
+	ssize_t retval;
+
+	if (count < sizeof(unsigned long))
+		return -EINVAL;
+
+	if (file->f_flags & O_NONBLOCK && !gen_rtc_irq_data)
+		return -EAGAIN;
+
+	add_wait_queue(&gen_rtc_wait, &wait);
+	retval = -ERESTARTSYS;
+
+	while (1) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		data = xchg(&gen_rtc_irq_data, 0);
+		if (data)
+			break;
+		if (signal_pending(current))
+			goto out;
+		schedule();
+	}
+
+	retval = put_user(data, (unsigned long *)buf);
+	if (!retval)
+		retval = sizeof(unsigned long);
+ out:
+	current->state = TASK_RUNNING;
+	remove_wait_queue(&gen_rtc_wait, &wait);
+
+	return retval;
+}
+
+static unsigned int gen_rtc_poll(struct file *file,
+				 struct poll_table_struct *wait)
+{
+	poll_wait(file, &gen_rtc_wait, wait);
+	if (gen_rtc_irq_data != 0)
+		return POLLIN | POLLRDNORM;
+	return 0;
+}
+
+#endif
+
+/*
+ * Used to disable/enable interrupts, only RTC_UIE supported
+ * We also clear out any old irq data after an ioctl() that
+ * meddles with the interrupt enable/disable bits.
+ */
+
+static inline void gen_clear_rtc_irq_bit(unsigned char bit)
+{
+#ifdef CONFIG_GEN_RTC_X
+	stop_rtc_timers = 1;
+	if (ttask_active){
+		del_timer_sync(&timer_task);
+		ttask_active = 0;
+	}
+	while (stask_active)
+		schedule();
+
+	spin_lock(&gen_rtc_lock);
+	irq_active = 0;
+	spin_unlock(&gen_rtc_lock);
+#endif
+}
+
+static inline int gen_set_rtc_irq_bit(unsigned char bit)
+{
+#ifdef CONFIG_GEN_RTC_X
+	spin_lock(&gen_rtc_lock);
+	if ( !irq_active ) {
+		irq_active = 1;
+		stop_rtc_timers = 0;
+		lostint = 0;
+		genrtc_task.routine = genrtc_troutine;
+		oldsecs = get_rtc_ss();
+		init_timer(&timer_task);
+
+		stask_active = 1;
+		if (schedule_task(&genrtc_task) == 0){
+			stask_active = 0;
+		}
+	}
+	spin_unlock(&gen_rtc_lock);
+	gen_rtc_irq_data = 0;
+	return 0;
+#else
+	return -EINVAL;
+#endif
+}
+
+static int gen_rtc_ioctl(struct inode *inode, struct file *file,
+			 unsigned int cmd, unsigned long arg)
+{
+	struct rtc_time wtime;
+	struct rtc_pll_info pll;
+
+	switch (cmd) {
+
+	case RTC_PLL_GET:
+	    if (get_rtc_pll(&pll))
+	 	    return -EINVAL;
+	    else
+		    return copy_to_user((void *)arg, &pll, sizeof pll) ? -EFAULT : 0;
+
+	case RTC_PLL_SET:
+		if (!capable(CAP_SYS_TIME))
+			return -EACCES;
+		if (copy_from_user(&pll, (struct rtc_pll_info*)arg,
+				   sizeof(pll)))
+			return -EFAULT;
+	    return set_rtc_pll(&pll);
+
+	case RTC_UIE_OFF:	/* disable ints from RTC updates.	*/
+		gen_clear_rtc_irq_bit(RTC_UIE);
+		return 0;
+
+	case RTC_UIE_ON:	/* enable ints for RTC updates.	*/
+	        return gen_set_rtc_irq_bit(RTC_UIE);
+
+	case RTC_RD_TIME:	/* Read the time/date from RTC	*/
+		/* this doesn't get week-day, who cares */
+		memset(&wtime, 0, sizeof(wtime));
+		get_rtc_time(&wtime);
+
+		return copy_to_user((void *)arg, &wtime, sizeof(wtime)) ? -EFAULT : 0;
+
+	case RTC_SET_TIME:	/* Set the RTC */
+	    {
+		int year;
+		unsigned char leap_yr;
+
+		if (!capable(CAP_SYS_TIME))
+			return -EACCES;
+
+		if (copy_from_user(&wtime, (struct rtc_time *)arg,
+				   sizeof(wtime)))
+			return -EFAULT;
+
+		year = wtime.tm_year + 1900;
+		leap_yr = ((!(year % 4) && (year % 100)) ||
+			   !(year % 400));
+
+		if ((wtime.tm_mon < 0 || wtime.tm_mon > 11) || (wtime.tm_mday < 1))
+			return -EINVAL;
+
+		if (wtime.tm_mday < 0 || wtime.tm_mday >
+		    (days_in_mo[wtime.tm_mon] + ((wtime.tm_mon == 1) && leap_yr)))
+			return -EINVAL;
+
+		if (wtime.tm_hour < 0 || wtime.tm_hour >= 24 ||
+		    wtime.tm_min < 0 || wtime.tm_min >= 60 ||
+		    wtime.tm_sec < 0 || wtime.tm_sec >= 60)
+			return -EINVAL;
+
+		set_rtc_time(&wtime);
+		return 0;
+	    }
+	}
+
+	return -EINVAL;
+}
+
+/*
+ *	We enforce only one user at a time here with the open/close.
+ *	Also clear the previous interrupt data on an open, and clean
+ *	up things on a close.
+ */
+
+static int gen_rtc_open(struct inode *inode, struct file *file)
+{
+	if (gen_rtc_status & RTC_IS_OPEN)
+		return -EBUSY;
+
+	MOD_INC_USE_COUNT;
+
+	gen_rtc_status |= RTC_IS_OPEN;
+	gen_rtc_irq_data = 0;
+	irq_active = 0;
+
+	return 0;
+}
+
+static int gen_rtc_release(struct inode *inode, struct file *file)
+{
+	/*
+	 * Turn off all interrupts once the device is no longer
+	 * in use and clear the data.
+	 */
+
+	gen_clear_rtc_irq_bit(RTC_PIE|RTC_AIE|RTC_UIE);
+
+	gen_rtc_status &= ~RTC_IS_OPEN;
+	MOD_DEC_USE_COUNT;
+
+	return 0;
+}
+
+static int gen_rtc_read_proc(char *page, char **start, off_t off,
+			     int count, int *eof, void *data);
+
+
+/*
+ *	The various file operations we support.
+ */
+
+static struct file_operations gen_rtc_fops = {
+	owner:		THIS_MODULE,
+#ifdef CONFIG_GEN_RTC_X
+	read:		gen_rtc_read,
+	poll:		gen_rtc_poll,
+#endif
+	ioctl:		gen_rtc_ioctl,
+	open:		gen_rtc_open,
+	release:	gen_rtc_release
+};
+
+static struct miscdevice rtc_gen_dev =
+{
+	RTC_MINOR,
+	"rtc",
+	&gen_rtc_fops
+};
+
+int __init rtc_generic_init(void)
+{
+
+		printk(KERN_INFO "Generic RTC Driver v%s\n", RTC_VERSION);
+
+	misc_register(&rtc_gen_dev);
+	create_proc_read_entry ("driver/rtc", 0, 0, gen_rtc_read_proc, NULL);
+
+	return 0;
+}
+
+static void __exit rtc_generic_exit(void)
+{
+	remove_proc_entry ("driver/rtc", NULL);
+	misc_deregister(&rtc_gen_dev);
+}
+
+module_init(rtc_generic_init);
+module_exit(rtc_generic_exit);
+EXPORT_NO_SYMBOLS;
+
+
+/*
+ *	Info exported via "/proc/rtc".
+ */
+
+int gen_rtc_proc_output(char *buf)
+{
+	char *p;
+	struct rtc_time tm;
+	unsigned tmp;
+	struct rtc_pll_info pll;
+
+	p = buf;
+
+	get_rtc_time(&tm);
+
+	p += sprintf(p,
+		     "rtc_time\t: %02d:%02d:%02d\n"
+		     "rtc_date\t: %04d-%02d-%02d\n"
+		     "rtc_epoch\t: %04u\n",
+		     tm.tm_hour, tm.tm_min, tm.tm_sec,
+		     tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, 1900);
+
+	tm.tm_hour=0;tm.tm_min=0;tm.tm_sec=0;
+
+	p += sprintf(p, "alarm\t\t: ");
+	if (tm.tm_hour <= 24)
+		p += sprintf(p, "%02d:", tm.tm_hour);
+	else
+		p += sprintf(p, "**:");
+
+	if (tm.tm_min <= 59)
+		p += sprintf(p, "%02d:", tm.tm_min);
+	else
+		p += sprintf(p, "**:");
+
+	if (tm.tm_sec <= 59)
+		p += sprintf(p, "%02d\n", tm.tm_sec);
+	else
+		p += sprintf(p, "**\n");
+
+	tmp= RTC_24H ;
+	p += sprintf(p,
+		     "DST_enable\t: %s\n"
+		     "BCD\t\t: %s\n"
+		     "24hr\t\t: %s\n"
+		     "square_wave\t: %s\n"
+		     "alarm_IRQ\t: %s\n"
+		     "update_IRQ\t: %s\n"
+		     "periodic_IRQ\t: %s\n"
+		     "periodic_freq\t: %ld\n"
+		     "batt_status\t: %s\n",
+		     (tmp & RTC_DST_EN) ? "yes" : "no",
+		     (tmp & RTC_DM_BINARY) ? "no" : "yes",
+		     (tmp & RTC_24H) ? "yes" : "no",
+		     (tmp & RTC_SQWE) ? "yes" : "no",
+		     (tmp & RTC_AIE) ? "yes" : "no",
+		     irq_active ? "yes" : "no",
+		     (tmp & RTC_PIE) ? "yes" : "no",
+		     0L /* freq */,
+		     "okay" );
+	if (!get_rtc_pll(&pll))
+	    p += sprintf(p,
+			 "PLL adjustment\t: %d\n"
+			 "PLL max +ve adjustment\t: %d\n"
+			 "PLL max -ve adjustment\t: %d\n"
+			 "PLL +ve adjustment factor\t: %d\n"
+			 "PLL -ve adjustment factor\t: %d\n"
+			 "PLL frequency\t: %ld\n",
+			 pll.pll_value,
+			 pll.pll_max,
+			 pll.pll_min,
+			 pll.pll_posmult,
+			 pll.pll_negmult,
+			 pll.pll_clock);
+	return  p - buf;
+}
+
+static int gen_rtc_read_proc(char *page, char **start, off_t off,
+			     int count, int *eof, void *data)
+{
+	int len = gen_rtc_proc_output (page);
+        if (len <= off+count) *eof = 1;
+	*start = page + off;
+	len -= off;
+        if (len>count) len = count;
+        if (len<0) len = 0;
+	return len;
+}
+
+
+MODULE_AUTHOR("Richard Zidlicky");
+MODULE_LICENSE("GPL");
+
+/*
+ * Local variables:
+ * compile-command: "m68k-linux-gcc -D__KERNEL__ -I../../include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -pipe -fno-strength-reduce -ffixed-a2 -c -o genrtc.o genrtc.c"
+ * End:
+ */
+
diff -Nru a/include/asm-ppc/rtc.h b/include/asm-ppc/rtc.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-ppc/rtc.h	Tue Jul  9 13:02:51 2002
@@ -0,0 +1,92 @@
+/* 
+ * inclue/asm-ppc/rtc.h
+ *
+ * Copyright 2002 MontaVista Software Inc.
+ * Author: Tom Rini <trini@mvista.com>
+ *
+ * Based on:
+ * include/asm-m68k/rtc.h
+ *
+ * Copyright Richard Zidlicky
+ * implementation details for genrtc/q40rtc driver
+ *
+ * And the old drivers/macintosh/rtc.c which was heavily based on:
+ * Linux/SPARC Real Time Clock Driver
+ * Copyright (C) 1996 Thomas K. Dyas (tdyas@eden.rutgers.edu)
+ *
+ * With additional work by Paul Mackerras and Franz Sirl.
+ */
+/* permission is hereby granted to copy, modify and redistribute this code
+ * in terms of the GNU Library General Public License, Version 2 or later,
+ * at your option.
+ */
+
+#ifndef __ASM_RTC_H__
+#define __ASM_RTC_H__
+
+#ifdef __KERNEL__
+
+#include <linux/rtc.h>
+
+#include <asm/machdep.h>
+#include <asm/time.h>
+
+#define RTC_PIE 0x40		/* periodic interrupt enable */
+#define RTC_AIE 0x20		/* alarm interrupt enable */
+#define RTC_UIE 0x10		/* update-finished interrupt enable */
+
+extern void gen_rtc_interrupt(unsigned long);
+
+/* some dummy definitions */
+#define RTC_SQWE 0x08		/* enable square-wave output */
+#define RTC_DM_BINARY 0x04	/* all time/date values are BCD if clear */
+#define RTC_24H 0x02		/* 24 hour mode - else hours bit 7 means pm */
+#define RTC_DST_EN 0x01	        /* auto switch DST - works f. USA only */
+
+static inline void get_rtc_time(struct rtc_time *time)
+{
+	if (ppc_md.get_rtc_time) {
+		unsigned long nowtime;
+
+		nowtime = (ppc_md.get_rtc_time)();
+
+		to_tm(nowtime, time);
+
+		time->tm_year -= 1900;
+		time->tm_mon -= 1; /* Make sure userland has a 0-based month */
+	}
+}
+
+/* Set the current date and time in the real time clock. */
+static inline void set_rtc_time(struct rtc_time *time)
+{
+	if (ppc_md.get_rtc_time) {
+		unsigned long nowtime;
+
+		nowtime = mktime(time->tm_year+1900, time->tm_mon+1,
+				time->tm_mday, time->tm_hour, time->tm_min,
+				time->tm_sec);
+
+		(ppc_md.set_rtc_time)(nowtime);
+	}
+}
+
+static inline unsigned int get_rtc_ss(void)
+{
+	struct rtc_time h;
+
+	get_rtc_time(&h);
+	return h.tm_sec;
+}
+
+static inline int get_rtc_pll(struct rtc_pll_info *pll)
+{
+	return -EINVAL;
+}
+static inline int set_rtc_pll(struct rtc_pll_info *pll)
+{
+	return -EINVAL;
+}
+
+#endif /* __KERNEL__ */
+#endif /* __ASM_RTC_H__ */
diff -Nru a/include/linux/rtc.h b/include/linux/rtc.h
--- a/include/linux/rtc.h	Tue Jul  9 13:02:51 2002
+++ b/include/linux/rtc.h	Tue Jul  9 13:02:51 2002
@@ -39,10 +39,32 @@
 	struct rtc_time time;	/* time the alarm is set to */
 };
 
+/*
+ * Data structure to control PLL correction some better RTC feature
+ * pll_value is used to get or set current value of correction,
+ * the rest of the struct is used to query HW capabilities.
+ * This is modeled after the RTC used in Q40/Q60 computers but
+ * should be sufficiently flexible for other devices
+ *
+ * +ve pll_value means clock will run faster by
+ *   pll_value*pll_posmult/pll_clock
+ * -ve pll_value means clock will run slower by
+ *   pll_value*pll_negmult/pll_clock
+ */ 
+
+struct rtc_pll_info {
+	int pll_ctrl;       /* placeholder for fancier control */
+	int pll_value;      /* get/set correction value */
+	int pll_max;        /* max +ve (faster) adjustment value */
+	int pll_min;        /* max -ve (slower) adjustment value */
+	int pll_posmult;    /* factor for +ve corection */
+	int pll_negmult;    /* factor for -ve corection */
+	long pll_clock;     /* base PLL frequency */
+};
 
 /*
  * ioctl calls that are permitted to the /dev/rtc interface, if 
- * CONFIG_RTC/CONFIG_EFI_RTC was enabled.
+ * any of the RTC drivers are enabled.
  */
 
 #define RTC_AIE_ON	_IO('p', 0x01)	/* Alarm int. enable on		*/
@@ -65,6 +87,8 @@
 
 #define RTC_WKALM_SET	_IOW('p', 0x0f, struct rtc_wkalrm)/* Set wakeup alarm*/
 #define RTC_WKALM_RD	_IOR('p', 0x10, struct rtc_wkalrm)/* Get wakeup alarm*/
+#define RTC_PLL_GET	_IOR('p', 0x11, struct rtc_pll_info)  /* Get PLL correction */
+#define RTC_PLL_SET	_IOW('p', 0x12, struct rtc_pll_info)  /* Set PLL correction */
 
 #ifdef __KERNEL__
 

