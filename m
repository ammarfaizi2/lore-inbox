Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbTAJT7B>; Fri, 10 Jan 2003 14:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266115AbTAJT7B>; Fri, 10 Jan 2003 14:59:01 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:63713 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S265667AbTAJT6j>;
	Fri, 10 Jan 2003 14:58:39 -0500
Date: Fri, 10 Jan 2003 21:05:55 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, parisc-linux@parisc-linux.org,
       Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Generic RTC driver in 2.4.x
In-Reply-To: <Pine.GSO.4.21.0301051535430.10519-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.4.21.0301102104190.18440-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Unfortunately I didn't receive any feedback from the pa-risc and ppc people
after my previous posting last Sunday.

Alan, I'm explicitly sending it to you for inclusion in your ac tree.
I intend to send it to Marcelo after the weekend.

Changes since last Sunday:
  - fix spelling of `automatically' (from Geoffrey Lee <glee@gnupilgrims.org>)
  - misc_register() and create_proc_read_entry() can fail
    (from mikal@stillhq.com in 2.5.x)
  - create_proc_read_entry() depends on CONFIG_PROC_FS
    (from mikal@stillhq.com in 2.5.x)


The following patch adds the generic RTC driver to 2.4.20 (applies fine to
2.4.21-pre3). This driver provides a /dev/rtc-compatible interface to the real
time clock on machines without a PC-style RTC chip. It is used as the primary
RTC driver on m68k, pa-risc, and ppc. This driver is already present in 2.5.x.

Pa-risc and ppc people (any other users?), please send me your enhancements (or
just ack if none are necessary), so I can send genrtc to Marcelo.

Thanks!

 Documentation/Configure.help  |   28 ++
 arch/m68k/config.in           |    5 
 arch/m68k/kernel/m68k_ksyms.c |    5 
 arch/m68k/kernel/setup.c      |    3 
 arch/m68k/q40/config.c        |   41 +++
 drivers/char/Makefile         |    1 
 drivers/char/genrtc.c         |  533 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-m68k/machdep.h    |    4 
 include/asm-m68k/rtc.h        |   44 +++
 include/linux/rtc.h           |   28 ++
 10 files changed, 687 insertions(+), 5 deletions(-)

--- linux-2.4.20/Documentation/Configure.help	Tue Oct 29 18:40:45 2002
+++ linux-genrtc-2.4.20/Documentation/Configure.help	Fri Jan 10 20:54:52 2003
@@ -18959,6 +18959,34 @@
   The module is called rtc.o. If you want to compile it as a module,
   say M here and read <file:Documentation/modules.txt>.
 
+Generic Real Time Clock Support
+CONFIG_GEN_RTC
+  If you say Y here and create a character special file /dev/rtc with
+  major number 10 and minor number 135 using mknod ("man mknod"), you
+  will get access to the real time clock (or hardware clock) built
+  into your computer.
+
+  In 2.4 and later kernels this is the only way to set and get rtc
+  time on m68k systems so it is highly recommended.
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
+  module automatically add 'alias char-major-10-135 genrtc' to your
+  /etc/modules.conf
+
+Extended RTC operation
+CONFIG_GEN_RTC_X
+  Provides an emulation for RTC_UIE which is required by some programs 
+  and may improve precision of the generic RTC support in some cases.
+
 Tadpole ANA H8 Support
 CONFIG_H8
   The Hitachi H8/337 is a microcontroller used to deal with the power
--- linux-2.4.20/arch/m68k/config.in	Fri Sep 13 10:14:59 2002
+++ linux-genrtc-2.4.20/arch/m68k/config.in	Fri Jan 10 20:54:25 2003
@@ -517,8 +517,11 @@
    if [ "$CONFIG_SUN3" = "y" ]; then
       define_bool CONFIG_GEN_RTC y
    else
-      bool 'Generic /dev/rtc emulation' CONFIG_GEN_RTC
+      tristate 'Generic /dev/rtc emulation' CONFIG_GEN_RTC      
    fi
+fi
+if [ "$CONFIG_GEN_RTC" != "n" ]; then
+   bool '   Extended RTC operation' CONFIG_GEN_RTC_X
 fi
 bool 'Unix98 PTY support' CONFIG_UNIX98_PTYS
 if [ "$CONFIG_UNIX98_PTYS" = "y" ]; then
--- linux-2.4.20/arch/m68k/kernel/m68k_ksyms.c	Thu Jan  4 22:00:55 2001
+++ linux-genrtc-2.4.20/arch/m68k/kernel/m68k_ksyms.c	Fri Jan 10 20:54:25 2003
@@ -18,6 +18,7 @@
 #include <asm/checksum.h>
 #include <asm/hardirq.h>
 #include <asm/softirq.h>
+#include <asm/rtc.h>
 
 asmlinkage long long __ashldi3 (long long, int);
 asmlinkage long long __ashrdi3 (long long, int);
@@ -49,6 +50,10 @@
 EXPORT_SYMBOL(kernel_set_cachemode);
 #endif /* !CONFIG_SUN3 */
 EXPORT_SYMBOL(m68k_debug_device);
+EXPORT_SYMBOL(mach_hwclk);
+EXPORT_SYMBOL(mach_get_ss);
+EXPORT_SYMBOL(mach_get_rtc_pll);
+EXPORT_SYMBOL(mach_set_rtc_pll);
 EXPORT_SYMBOL(dump_fpu);
 EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(strnlen);
--- linux-2.4.20/arch/m68k/kernel/setup.c	Fri Sep 13 10:15:01 2002
+++ linux-genrtc-2.4.20/arch/m68k/kernel/setup.c	Fri Jan 10 20:54:25 2003
@@ -90,6 +90,9 @@
 void (*mach_gettod) (int*, int*, int*, int*, int*, int*);
 int (*mach_hwclk) (int, struct rtc_time*) = NULL;
 int (*mach_set_clock_mmss) (unsigned long) = NULL;
+unsigned int (*mach_get_ss)(void) = NULL;
+int (*mach_get_rtc_pll)(struct rtc_pll_info *) = NULL;
+int (*mach_set_rtc_pll)(struct rtc_pll_info *) = NULL;
 void (*mach_reset)( void );
 void (*mach_halt)( void ) = NULL;
 void (*mach_power_off)( void ) = NULL;
--- linux-2.4.20/arch/m68k/q40/config.c	Fri Sep 13 10:15:02 2002
+++ linux-genrtc-2.4.20/arch/m68k/q40/config.c	Fri Jan 10 20:54:25 2003
@@ -58,7 +58,10 @@
 extern void q40_gettod (int *year, int *mon, int *day, int *hour,
                            int *min, int *sec);
 extern int q40_hwclk (int, struct rtc_time *);
+extern unsigned int q40_get_ss (void);
 extern int q40_set_clock_mmss (unsigned long);
+static int q40_get_rtc_pll(struct rtc_pll_info *pll);
+static int q40_set_rtc_pll(struct rtc_pll_info *pll);
 extern void q40_reset (void);
 void q40_halt(void);
 extern void q40_waitbut(void);
@@ -196,6 +199,9 @@
     mach_gettimeoffset   = q40_gettimeoffset; 
     mach_gettod  	 = q40_gettod;
     mach_hwclk           = q40_hwclk; 
+    mach_get_ss          = q40_get_ss; 
+    mach_get_rtc_pll     = q40_get_rtc_pll; 
+    mach_set_rtc_pll     = q40_set_rtc_pll; 
     mach_set_clock_mmss	 = q40_set_clock_mmss;
 
     mach_reset		 = q40_reset;
@@ -331,6 +337,11 @@
 	return 0;
 }
 
+unsigned int q40_get_ss()
+{
+	return bcd2bin(Q40_RTC_SECS);
+}
+
 /*
  * Set the minutes and seconds from seconds value 'nowtime'.  Fail if
  * clock is out by > 30 minutes.  Logic lifted from atari code.
@@ -362,3 +373,33 @@
 	return retval;
 }
 
+
+/* get and set PLL calibration of RTC clock */
+#define Q40_RTC_PLL_MASK ((1<<5)-1)
+#define Q40_RTC_PLL_SIGN (1<<5)
+
+static int q40_get_rtc_pll(struct rtc_pll_info *pll)
+{
+      int tmp=Q40_RTC_CTRL;
+      pll->pll_value = tmp & Q40_RTC_PLL_MASK;
+      if (tmp & Q40_RTC_PLL_SIGN) 
+	  pll->pll_value = -pll->pll_value;
+      pll->pll_max=31;
+      pll->pll_min=-31;
+      pll->pll_posmult=512;
+      pll->pll_negmult=256;
+      pll->pll_clock=125829120;
+      return 0;
+  }
+
+static int q40_set_rtc_pll(struct rtc_pll_info *pll)
+{
+  if (!pll->pll_ctrl){
+      /* the docs are a bit unclear so I am doublesetting RTC_WRITE here ... */
+      int tmp=(pll->pll_value & 31) | (pll->pll_value<0 ? 32 : 0) | Q40_RTC_WRITE;
+      Q40_RTC_CTRL |= Q40_RTC_WRITE;
+      Q40_RTC_CTRL = tmp;
+      Q40_RTC_CTRL &= ~(Q40_RTC_WRITE);
+      return 0;
+  } else return -EINVAL;
+}
--- linux-2.4.20/drivers/char/Makefile	Wed Nov 27 11:02:06 2002
+++ linux-genrtc-2.4.20/drivers/char/Makefile	Fri Jan 10 20:54:25 2003
@@ -222,6 +222,7 @@
 obj-$(CONFIG_PC110_PAD) += pc110pad.o
 obj-$(CONFIG_MK712_MOUSE) += mk712.o
 obj-$(CONFIG_RTC) += rtc.o
+obj-$(CONFIG_GEN_RTC) += genrtc.o
 obj-$(CONFIG_EFI_RTC) += efirtc.o
 ifeq ($(CONFIG_PPC),)
   obj-$(CONFIG_NVRAM) += nvram.o
--- linux-2.4.20/drivers/char/genrtc.c	Thu Jan  1 01:00:00 1970
+++ linux-genrtc-2.4.20/drivers/char/genrtc.c	Fri Jan 10 20:54:52 2003
@@ -0,0 +1,533 @@
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
+ *      1.06 set_rtc_time can return an error trini@kernel.crashing.org
+ */
+
+#define RTC_VERSION	"1.06"
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
+	if (time_after(jiffies, tt_exp))
+		printk(KERN_INFO "genrtc: timer task delayed by %ld jiffies\n",
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
+	if (count != sizeof (unsigned int) && count != sizeof (unsigned long))
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
+	/* first test allows optimizer to nuke this case for 32-bit machines */
+	if (sizeof (int) != sizeof (long) && count == sizeof (unsigned int)) {
+		unsigned int uidata = data;
+		retval = put_user(uidata, (unsigned long *)buf);
+	}
+	else {
+		retval = put_user(data, (unsigned long *)buf);
+	}
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
+		return set_rtc_time(&wtime);
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
+	int retval;
+
+	printk(KERN_INFO "Generic RTC Driver v%s\n", RTC_VERSION);
+
+	retval = misc_register(&rtc_gen_dev);
+	if(retval < 0)
+		return retval;
+
+#ifdef CONFIG_PROC_FS
+	if((create_proc_read_entry ("driver/rtc", 0, 0, gen_rtc_read_proc, NULL)) == NULL){
+		misc_deregister(&rtc_gen_dev);
+		return -ENOMEM;
+	}
+#endif
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
--- linux-2.4.20/include/asm-m68k/machdep.h	Wed May 29 10:14:12 2002
+++ linux-genrtc-2.4.20/include/asm-m68k/machdep.h	Fri Jan 10 20:54:25 2003
@@ -5,6 +5,7 @@
 struct kbd_repeat;
 struct mktime;
 struct rtc_time;
+struct rtc_pll_info;
 struct gendisk;
 struct buffer_head;
 
@@ -29,6 +30,9 @@
 extern void (*mach_gettod)(int *year, int *mon, int *day, int *hour,
 			   int *min, int *sec);
 extern int (*mach_hwclk)(int, struct rtc_time*);
+extern unsigned int (*mach_get_ss)(void);
+extern int (*mach_get_rtc_pll)(struct rtc_pll_info *);
+extern int (*mach_set_rtc_pll)(struct rtc_pll_info *);
 extern int (*mach_set_clock_mmss)(unsigned long);
 extern void (*mach_reset)( void );
 extern void (*mach_halt)( void );
--- linux-2.4.20/include/asm-m68k/rtc.h	Wed May 29 10:14:13 2002
+++ linux-genrtc-2.4.20/include/asm-m68k/rtc.h	Fri Jan 10 20:54:25 2003
@@ -13,9 +13,8 @@
 
 #ifdef __KERNEL__
 
-#include <linux/config.h>
 #include <linux/rtc.h>
-#include <linux/delay.h>
+#include <asm/errno.h>
 #include <asm/machdep.h>
 
 #define RTC_PIE 0x40		/* periodic interrupt enable */
@@ -30,7 +29,48 @@
 #define RTC_24H 0x02		/* 24 hour mode - else hours bit 7 means pm */
 #define RTC_DST_EN 0x01	        /* auto switch DST - works f. USA only */
 
+static inline void get_rtc_time(struct rtc_time *time)
+{
+	/*
+	 * Only the values that we read from the RTC are set. We leave
+	 * tm_wday, tm_yday and tm_isdst untouched. Even though the
+	 * RTC has RTC_DAY_OF_WEEK, we ignore it, as it is only updated
+	 * by the RTC when initially set to a non-zero value.
+	 */
+	mach_hwclk(0, time);
+}
 
+static inline int set_rtc_time(struct rtc_time *time)
+{
+	return mach_hwclk(1, time);
+}
+
+static inline unsigned int get_rtc_ss(void)
+{
+	if (mach_get_ss)
+		return mach_get_ss();
+	else{
+		struct rtc_time h;
+		
+		get_rtc_time(&h);
+		return h.tm_sec;
+	}
+}
+
+static inline int get_rtc_pll(struct rtc_pll_info *pll)
+{
+	if (mach_get_rtc_pll)
+		return mach_get_rtc_pll(pll);
+	else
+		return -EINVAL;
+}
+static inline int set_rtc_pll(struct rtc_pll_info *pll)
+{
+	if (mach_set_rtc_pll)
+		return mach_set_rtc_pll(pll);
+	else
+		return -EINVAL;
+}
 #endif /* __KERNEL__ */
 
 #endif /* _ASM__RTC_H */
--- linux-2.4.20/include/linux/rtc.h	Mon Feb 19 09:47:19 2001
+++ linux-genrtc-2.4.20/include/linux/rtc.h	Fri Jan 10 20:54:25 2003
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
- * ioctl calls that are permitted to the /dev/rtc interface, if 
- * CONFIG_RTC/CONFIG_EFI_RTC was enabled.
+ * ioctl calls that are permitted to the /dev/rtc interface, if
+ * any of the RTC drivers are enabled.
  */
 
 #define RTC_AIE_ON	_IO('p', 0x01)	/* Alarm int. enable on		*/
@@ -66,4 +88,6 @@
 #define RTC_WKALM_SET	_IOW('p', 0x0f, struct rtc_wkalrm)/* Set wakeup alarm*/
 #define RTC_WKALM_RD	_IOR('p', 0x10, struct rtc_wkalrm)/* Get wakeup alarm*/
 
+#define RTC_PLL_GET	_IOR('p', 0x11, struct rtc_pll_info)  /* Get PLL correction */
+#define RTC_PLL_SET	_IOW('p', 0x12, struct rtc_pll_info)  /* Set PLL correction */
 #endif /* _LINUX_RTC_H_ */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

