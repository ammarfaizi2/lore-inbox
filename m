Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262396AbTCIEDn>; Sat, 8 Mar 2003 23:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262395AbTCIEDm>; Sat, 8 Mar 2003 23:03:42 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:37504 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262391AbTCIEDh>; Sat, 8 Mar 2003 23:03:37 -0500
Date: Sun, 9 Mar 2003 13:13:43 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] PC-9800 subarch. support for 2.5.64-ac3 (2/20) char dev update
Message-ID: <20030309041343.GC1231@yuzuki.cinet.co.jp>
References: <20030309035245.GA1231@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309035245.GA1231@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.64-ac3. (2/20)

Updates real time clock driver and printer driver for PC98.
 - drivers/char/lp_old98.c
    used 'ndelay()' and some small cleanup.
 - drivers/char/upd4990a.c
    remove own BCD macros by using 'linux/bcd.h'.
    C99 intializer.

Regards,
Osamu Tomita

diff -Nru linux-2.5.64-ac1/drivers/char/lp_old98.c linux98-2.5.64/drivers/char/lp_old98.c
--- linux-2.5.64-ac1/drivers/char/lp_old98.c	2003-03-07 08:52:01.000000000 +0900
+++ linux98-2.5.64/drivers/char/lp_old98.c	2003-03-05 13:23:48.000000000 +0900
@@ -68,7 +68,7 @@
 	.wait	= LP_INIT_WAIT,
 };
 
-static	int	dc1_check	= 0;
+static	int	dc1_check;
 static spinlock_t lp_old98_lock = SPIN_LOCK_UNLOCKED;
 
 
@@ -139,7 +139,7 @@
 	if (tmp < 0)
 		tmp = -tmp;
 #endif
-	__const_udelay(lp.wait * 4);
+	ndelay(lp.wait);
     
 	/* negate PSTB# (activate strobe)	*/
 	outb(LP_CONTROL_ASSERT_STROBE, LP_PORT_CONTROL);
@@ -150,7 +150,7 @@
 	lp.stats.chars ++;
 #endif
 
-	__const_udelay(lp.wait * 4);
+	ndelay(lp.wait);
 
 	/* assert PSTB# (deactivate strobe)	*/
 	outb(LP_CONTROL_NEGATE_STROBE, LP_PORT_CONTROL);
@@ -488,18 +488,18 @@
 		errmsg = "unable to register device";
 
 	release_region(LP_PORT_EXTMODE, 1);
-	err5:
+err5:
 	release_region(LP_PORT_STROBE, 1);
-	err4:
+err4:
 	release_region(LP_PORT_STATUS, 1);
-	err3:
+err3:
 	release_region(LP_PORT_DATA, 1);
-	err2:
+err2:
 #ifdef	PC98_HW_H98
 	if (pc98_hw_flags & PC98_HW_H98)
 	    release_region(LP_PORT_H98MODE, 1);
 
-	err1:
+err1:
 #endif
 	printk(KERN_ERR "lp_old98: %s\n", errmsg);
 	return -EBUSY;
diff -Nru linux-2.5.64-ac1/drivers/char/upd4990a.c linux98-2.5.64/drivers/char/upd4990a.c
--- linux-2.5.64-ac1/drivers/char/upd4990a.c	2003-03-07 08:52:02.000000000 +0900
+++ linux98-2.5.64/drivers/char/upd4990a.c	2003-03-05 13:23:48.000000000 +0900
@@ -24,6 +24,7 @@
 #include <linux/ioport.h>
 #include <linux/fcntl.h>
 #include <linux/rtc.h>
+#include <linux/bcd.h>
 #include <linux/upd4990a.h>
 #include <linux/init.h>
 #include <linux/poll.h>
@@ -34,9 +35,6 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
-#define BCD_TO_BINARY(val)	(((val) >> 4) * 10 + ((val) & 0xF))
-#define BINARY_TO_BCD(val)	((((val) / 10) << 4) | ((val) % 10))
-
 /*
  *	We sponge a minor off of the misc major. No need slurping
  *	up another valuable major dev number for this. If you add
@@ -137,7 +135,6 @@
 
 		if (data != 0)
 			break;
-
 		if (file->f_flags & O_NONBLOCK) {
 			retval = -EAGAIN;
 			goto out;
@@ -178,7 +175,7 @@
 	case RTC_UIE_ON:	/* Allow ints for RTC updates.	*/
 		spin_lock_irq(&rtc_lock);
 		rtc_irq_data = 0;
-		if (!(rtc_status & RTC_UIE_TIMER_ON)){
+		if (!(rtc_status & RTC_UIE_TIMER_ON)) {
 			rtc_status |= RTC_UIE_TIMER_ON;
 			rtc_uie_timer.expires = jiffies + 1;
 			add_timer(&rtc_uie_timer);
@@ -194,10 +191,10 @@
 		upd4990a_get_time(&raw, 0);
 		spin_unlock_irq(&rtc_lock);
 
-		wtime.tm_sec	= BCD_TO_BINARY(raw.sec);
-		wtime.tm_min	= BCD_TO_BINARY(raw.min);
-		wtime.tm_hour	= BCD_TO_BINARY(raw.hour);
-		wtime.tm_mday	= BCD_TO_BINARY(raw.mday);
+		wtime.tm_sec	= BCD2BIN(raw.sec);
+		wtime.tm_min	= BCD2BIN(raw.min);
+		wtime.tm_hour	= BCD2BIN(raw.hour);
+		wtime.tm_mday	= BCD2BIN(raw.mday);
 		wtime.tm_mon	= raw.mon - 1; /* convert to 0-base */
 		wtime.tm_wday	= raw.wday;
 
@@ -205,7 +202,7 @@
 		 * Account for differences between how the RTC uses the values
 		 * and how they are defined in a struct rtc_time;
 		 */
-		if ((wtime.tm_year = BCD_TO_BINARY(raw.year)) < 95)
+		if ((wtime.tm_year = BCD2BIN(raw.year)) < 95)
 			wtime.tm_year += 100;
 
 		wtime.tm_isdst = 0;
@@ -244,13 +241,13 @@
 		if (wtime.tm_wday > 6)
 			return -EINVAL;
 
-		raw.sec  = BINARY_TO_BCD(wtime.tm_sec);
-		raw.min  = BINARY_TO_BCD(wtime.tm_min);
-		raw.hour = BINARY_TO_BCD(wtime.tm_hour);
-		raw.mday = BINARY_TO_BCD(wtime.tm_mday);
+		raw.sec  = BIN2BCD(wtime.tm_sec);
+		raw.min  = BIN2BCD(wtime.tm_min);
+		raw.hour = BIN2BCD(wtime.tm_hour);
+		raw.mday = BIN2BCD(wtime.tm_mday);
 		raw.mon  = wtime.tm_mon + 1;
 		raw.wday = wtime.tm_wday;
-		raw.year = BINARY_TO_BCD(wtime.tm_year % 100);
+		raw.year = BIN2BCD(wtime.tm_year % 100);
 
 		spin_lock_irq(&rtc_lock);
 		upd4990a_set_time(&raw, 0);
@@ -329,7 +326,6 @@
 
 static struct file_operations rtc_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
 	.read		= rtc_read,
 	.poll		= rtc_poll,
 	.ioctl		= rtc_ioctl,
@@ -340,9 +336,9 @@
 
 static struct miscdevice rtc_dev=
 {
-	RTC_MINOR,
-	"rtc",
-	&rtc_fops
+	.minor	= RTC_MINOR,
+	.name	= "rtc",
+	.fops	= &rtc_fops,
 };
 
 static int __init rtc_init(void)
@@ -370,7 +366,6 @@
 
 module_init (rtc_init);
 
-#ifdef MODULE
 static void __exit rtc_exit(void)
 {
 	del_timer(&rtc_uie_timer);
@@ -380,7 +375,6 @@
 }
 
 module_exit (rtc_exit);
-#endif
 
 /*
  *	Info exported via "/proc/driver/rtc".
@@ -400,14 +394,14 @@
 	 * There is no way to tell if the luser has the RTC set for local
 	 * time or for Universal Standard Time (GMT). Probably local though.
 	 */
-	if ((year = BCD_TO_BINARY(data.year) + 1900) < 1995)
+	if ((year = BCD2BIN(data.year) + 1900) < 1995)
 		year += 100;
 	p += sprintf(p,
 		     "rtc_time\t: %02d:%02d:%02d\n"
 		     "rtc_date\t: %04d-%02d-%02d\n",
-		     BCD_TO_BINARY(data.hour), BCD_TO_BINARY(data.min),
-		     BCD_TO_BINARY(data.sec),
-		     year, data.mon, BCD_TO_BINARY(data.mday));
+		     BCD2BIN(data.hour), BCD2BIN(data.min),
+		     BCD2BIN(data.sec),
+		     year, data.mon, BCD2BIN(data.mday));
 
 	return  p - buf;
 }
