Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262993AbTCSMST>; Wed, 19 Mar 2003 07:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262997AbTCSMST>; Wed, 19 Mar 2003 07:18:19 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:56199 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S262993AbTCSMQ6>;
	Wed, 19 Mar 2003 07:16:58 -0500
Date: Wed, 19 Mar 2003 13:27:43 +0100 (MET)
Message-Id: <200303191227.h2JCRhq00895@vervain.sonytel.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Genrtc updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Genrtc: Sync generic RTC driver with 2.4.x.

--- linux-2.5.x/drivers/char/genrtc.c	Tue Feb 25 10:21:06 2003
+++ linux-m68k-2.5.x/drivers/char/genrtc.c	Sun Mar  2 16:34:59 2003
@@ -1,5 +1,8 @@
 /*
- *	Real Time Clock interface for q40 and other m68k machines
+ *	Real Time Clock interface for
+ *		- q40 and other m68k machines,
+ *		- HP PARISC machines
+ *		- PowerPC machines
  *      emulate some RTC irq capabilities in software
  *
  *      Copyright (C) 1999 Richard Zidlicky
@@ -13,7 +16,7 @@
  *	pseudo-file for status information.
  *
  *	The ioctls can be used to set the interrupt behaviour where
- *  supported.
+ *	supported.
  *
  *	The /dev/rtc interface will block on reads until an interrupt
  *	has been received. If a RTC interrupt has already happened,
@@ -34,9 +37,10 @@
  *      1.04 removed useless timer code       rz@linux-m68k.org
  *      1.05 portable RTC_UIE emulation       rz@linux-m68k.org
  *      1.06 set_rtc_time can return an error trini@kernel.crashing.org
+ *      1.07 ported to HP PARISC (hppa)	      Helge Deller <deller@gmx.de>
  */
 
-#define RTC_VERSION	"1.06"
+#define RTC_VERSION	"1.07"
 
 #include <linux/module.h>
 #include <linux/config.h>
@@ -63,20 +67,17 @@
 
 static DECLARE_WAIT_QUEUE_HEAD(gen_rtc_wait);
 
-static int gen_rtc_ioctl(struct inode *inode, struct file *file,
-		     unsigned int cmd, unsigned long arg);
-
 /*
  *	Bits in gen_rtc_status.
  */
 
 #define RTC_IS_OPEN		0x01	/* means /dev/rtc is in use	*/
 
-unsigned char gen_rtc_status;		/* bitmapped status byte.	*/
-unsigned long gen_rtc_irq_data;		/* our output to the world	*/
+static unsigned char gen_rtc_status;	/* bitmapped status byte.	*/
+static unsigned long gen_rtc_irq_data;	/* our output to the world	*/
 
 /* months start at 0 now */
-unsigned char days_in_mo[] =
+static unsigned char days_in_mo[] =
 {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
 
 static int irq_active;
@@ -89,18 +90,20 @@
 static int lostint;
 static int tt_exp;
 
-void gen_rtc_timer(unsigned long data);
+static void gen_rtc_timer(unsigned long data);
 
 static volatile int stask_active;              /* schedule_work */
 static volatile int ttask_active;              /* timer_task */
 static int stop_rtc_timers;                    /* don't requeue tasks */
 static spinlock_t gen_rtc_lock = SPIN_LOCK_UNLOCKED;
 
+static void gen_rtc_interrupt(unsigned long arg);
+
 /*
  * Routine to poll RTC seconds field for change as often as possible,
  * after first RTC_UIE use timer to reduce polling
  */
-void genrtc_troutine(void *data)
+static void genrtc_troutine(void *data)
 {
 	unsigned int tmp = get_rtc_ss();
 	
@@ -124,7 +127,7 @@
 		stask_active = 0;
 }
 
-void gen_rtc_timer(unsigned long data)
+static void gen_rtc_timer(unsigned long data)
 {
 	lostint = get_rtc_ss() - oldsecs ;
 	if (lostint<0) 
@@ -145,7 +148,7 @@
  * from some routine that periodically (eg 100HZ) monitors
  * whether RTC_SECS changed
  */
-void gen_rtc_interrupt(unsigned long arg)
+static void gen_rtc_interrupt(unsigned long arg)
 {
 	/*  We store the status in the low byte and the number of
 	 *	interrupts received since the last read in the remainder
@@ -175,7 +178,7 @@
 	unsigned long data;
 	ssize_t retval;
 
-        if (count != sizeof (unsigned int) && count != sizeof (unsigned long))
+	if (count != sizeof (unsigned int) && count != sizeof (unsigned long))
 		return -EINVAL;
 
 	if (file->f_flags & O_NONBLOCK && !gen_rtc_irq_data)
@@ -385,24 +388,24 @@
  */
 
 static struct file_operations gen_rtc_fops = {
-	.owner =	THIS_MODULE,
+	.owner		= THIS_MODULE,
 #ifdef CONFIG_GEN_RTC_X
-	.read =		gen_rtc_read,
-	.poll =		gen_rtc_poll,
+	.read		= gen_rtc_read,
+	.poll		= gen_rtc_poll,
 #endif
-	.ioctl =	gen_rtc_ioctl,
-	.open =		gen_rtc_open,
-	.release =	gen_rtc_release
+	.ioctl		= gen_rtc_ioctl,
+	.open		= gen_rtc_open,
+	.release	= gen_rtc_release,
 };
 
 static struct miscdevice rtc_gen_dev =
 {
-	RTC_MINOR,
-	"rtc",
-	&gen_rtc_fops
+	.minor		= RTC_MINOR,
+	.name		= "rtc",
+	.fops		= &gen_rtc_fops,
 };
 
-int __init rtc_generic_init(void)
+static int __init rtc_generic_init(void)
 {
 	int retval;
 
@@ -436,16 +439,18 @@
  *	Info exported via "/proc/rtc".
  */
 
-int gen_rtc_proc_output(char *buf)
+#ifdef CONFIG_PROC_FS
+
+static int gen_rtc_proc_output(char *buf)
 {
 	char *p;
 	struct rtc_time tm;
-	unsigned tmp;
+	unsigned int flags;
 	struct rtc_pll_info pll;
 
 	p = buf;
 
-	get_rtc_time(&tm);
+	flags = get_rtc_time(&tm);
 
 	p += sprintf(p,
 		     "rtc_time\t: %02d:%02d:%02d\n"
@@ -454,7 +459,7 @@
 		     tm.tm_hour, tm.tm_min, tm.tm_sec,
 		     tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, 1900);
 
-	tm.tm_hour=0;tm.tm_min=0;tm.tm_sec=0;
+	tm.tm_hour = tm.tm_min = tm.tm_sec = 0;
 
 	p += sprintf(p, "alarm\t\t: ");
 	if (tm.tm_hour <= 24)
@@ -472,7 +477,6 @@
 	else
 		p += sprintf(p, "**\n");
 
-	tmp= RTC_24H ;
 	p += sprintf(p,
 		     "DST_enable\t: %s\n"
 		     "BCD\t\t: %s\n"
@@ -483,15 +487,15 @@
 		     "periodic_IRQ\t: %s\n"
 		     "periodic_freq\t: %ld\n"
 		     "batt_status\t: %s\n",
-		     (tmp & RTC_DST_EN) ? "yes" : "no",
-		     (tmp & RTC_DM_BINARY) ? "no" : "yes",
-		     (tmp & RTC_24H) ? "yes" : "no",
-		     (tmp & RTC_SQWE) ? "yes" : "no",
-		     (tmp & RTC_AIE) ? "yes" : "no",
+		     (flags & RTC_DST_EN) ? "yes" : "no",
+		     (flags & RTC_DM_BINARY) ? "no" : "yes",
+		     (flags & RTC_24H) ? "yes" : "no",
+		     (flags & RTC_SQWE) ? "yes" : "no",
+		     (flags & RTC_AIE) ? "yes" : "no",
 		     irq_active ? "yes" : "no",
-		     (tmp & RTC_PIE) ? "yes" : "no",
+		     (flags & RTC_PIE) ? "yes" : "no",
 		     0L /* freq */,
-		     "okay" );
+		     (flags & RTC_BATT_BAD) ? "bad" : "okay");
 	if (!get_rtc_pll(&pll))
 	    p += sprintf(p,
 			 "PLL adjustment\t: %d\n"
@@ -506,7 +510,7 @@
 			 pll.pll_posmult,
 			 pll.pll_negmult,
 			 pll.pll_clock);
-	return  p - buf;
+	return p - buf;
 }
 
 static int gen_rtc_read_proc(char *page, char **start, off_t off,
@@ -521,6 +525,9 @@
 	return len;
 }
 
+#endif /* CONFIG_PROC_FS */
+
 
 MODULE_AUTHOR("Richard Zidlicky");
 MODULE_LICENSE("GPL");
+
--- linux-2.5.x/include/asm-m68k/rtc.h	Sun Mar  9 22:40:15 2003
+++ linux-m68k-2.5.x/include/asm-m68k/rtc.h	Sun Mar  2 18:06:06 2003
@@ -13,24 +13,22 @@
 
 #ifdef __KERNEL__
 
 #include <linux/rtc.h>
+#include <asm/errno.h>
 #include <asm/machdep.h>
 
-/* a few implementation details for the emulation : */
-
 #define RTC_PIE 0x40		/* periodic interrupt enable */
 #define RTC_AIE 0x20		/* alarm interrupt enable */
 #define RTC_UIE 0x10		/* update-finished interrupt enable */
 
-extern void gen_rtc_interrupt(unsigned long);
-
 /* some dummy definitions */
+#define RTC_BATT_BAD 0x100	/* battery bad */
 #define RTC_SQWE 0x08		/* enable square-wave output */
 #define RTC_DM_BINARY 0x04	/* all time/date values are BCD if clear */
 #define RTC_24H 0x02		/* 24 hour mode - else hours bit 7 means pm */
 #define RTC_DST_EN 0x01	        /* auto switch DST - works f. USA only */
 
-static inline void get_rtc_time(struct rtc_time *time)
+static inline unsigned int get_rtc_time(struct rtc_time *time)
 {
 	/*
 	 * Only the values that we read from the RTC are set. We leave
@@ -40,6 +37,7 @@
 	 * by the RTC when initially set to a non-zero value.
 	 */
 	mach_hwclk(0, time);
+	return RTC_24H;
 }
 
 static inline int set_rtc_time(struct rtc_time *time)
@@ -53,7 +51,7 @@
 		return mach_get_ss();
 	else{
 		struct rtc_time h;
-
+		
 		get_rtc_time(&h);
 		return h.tm_sec;
 	}
@@ -73,7 +71,6 @@
 	else
 		return -EINVAL;
 }
-
 #endif /* __KERNEL__ */
 
 #endif /* _ASM__RTC_H */
--- linux-2.5.x/include/linux/rtc.h	Tue Feb 18 10:08:44 2003
+++ linux-m68k-2.5.x/include/linux/rtc.h	Sun Mar  2 16:31:53 2003
@@ -63,7 +63,7 @@
 };
 
 /*
- * ioctl calls that are permitted to the /dev/rtc interface, if 
+ * ioctl calls that are permitted to the /dev/rtc interface, if
  * any of the RTC drivers are enabled.
  */
 
@@ -87,6 +87,7 @@
 
 #define RTC_WKALM_SET	_IOW('p', 0x0f, struct rtc_wkalrm)/* Set wakeup alarm*/
 #define RTC_WKALM_RD	_IOR('p', 0x10, struct rtc_wkalrm)/* Get wakeup alarm*/
+
 #define RTC_PLL_GET	_IOR('p', 0x11, struct rtc_pll_info)  /* Get PLL correction */
 #define RTC_PLL_SET	_IOW('p', 0x12, struct rtc_pll_info)  /* Set PLL correction */
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
