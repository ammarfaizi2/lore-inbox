Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267277AbTBLOAM>; Wed, 12 Feb 2003 09:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267160AbTBLOAL>; Wed, 12 Feb 2003 09:00:11 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:41600 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267277AbTBLN7q>; Wed, 12 Feb 2003 08:59:46 -0500
Date: Wed, 12 Feb 2003 23:08:24 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.60 (23/34) lp-update
Message-ID: <20030212140824.GX1551@yuzuki.cinet.co.jp>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212131737.GA1551@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.60 (23/34).

Updates bakward comptible printer driver for PC98 in 2.5.50-ac1.

- Osamu Tomita

diff -Nru linux-2.5.50-ac1/drivers/char/lp_old98.c linux98-2.5.54/drivers/char/lp_old98.c
--- linux-2.5.50-ac1/drivers/char/lp_old98.c	2002-12-17 22:33:32.000000000 +0900
+++ linux98-2.5.54/drivers/char/lp_old98.c	2003-01-04 13:31:13.000000000 +0900
@@ -10,45 +10,35 @@
  * generic PC printer port driver.
  */
 
-#include <linux/init.h>
 #include <linux/module.h>
+#include <linux/init.h>
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/sched.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/ioport.h>
 #include <linux/fcntl.h>
 #include <linux/delay.h>
 #include <linux/console.h>
 #include <linux/version.h>
+#include <linux/fs.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
-#if !defined(CONFIG_PC9800) && !defined(CONFIG_PC98)
-#error This driver works only for NEC PC-9800 series
-#endif
-
-#if LINUX_VERSION_CODE < 0x20200
-# define LP_STATS
-#endif
-
-#if LINUX_VERSION_CODE >= 0x2030b
-# define CONFIG_RESOURCE98
-#endif
-
 #include <linux/lp.h>
 
 /*
  *  I/O port numbers
  */
 #define	LP_PORT_DATA	0x40
-#define	LP_PORT_STATUS	(LP_PORT_DATA+2)
-#define	LP_PORT_STROBE	(LP_PORT_DATA+4)
-#define LP_PORT_CONTROL	(LP_PORT_DATA+6)
+#define	LP_PORT_STATUS	(LP_PORT_DATA + 2)
+#define	LP_PORT_STROBE	(LP_PORT_DATA + 4)
+#define LP_PORT_CONTROL	(LP_PORT_DATA + 6)
 
 #define	LP_PORT_H98MODE	0x0448
 #define	LP_PORT_EXTMODE	0x0149
@@ -73,27 +63,27 @@
 /* PC-9800s have at least and at most one old-style printer port. */
 static struct lp_struct lp = {
 	/* Following `TAG: INITIALIZER' notations are GNU CC extension. */
-	flags:	LP_EXIST | LP_ABORTOPEN,
-	chars:	LP_INIT_CHAR,
-	time:	LP_INIT_TIME,
-	wait:	LP_INIT_WAIT,
+	.flags	= LP_EXIST | LP_ABORTOPEN,
+	.chars	= LP_INIT_CHAR,
+	.time	= LP_INIT_TIME,
+	.wait	= LP_INIT_WAIT,
 };
 
 static	int	dc1_check	= 1000;
+static spinlock_t lp_old98_lock = SPIN_LOCK_UNLOCKED;
 
-#undef LP_OLD98_DEBUG
 
-#ifndef __udelay_val
-# define __udelay_val current_cpu_data.loops_per_sec
-#endif
+#undef LP_OLD98_DEBUG
 
 static inline void nanodelay(unsigned long nanosecs)	/* Evil ? */
 {
-	if( nanosecs ) {
-		nanosecs *= (unsigned long)((1ULL << 40) / 1000000000ULL);
-		__asm__("mul%L2 %2"
-			: "=d"(nanosecs) : "a"(nanosecs), "g"(__udelay_val));
-		__delay(nanosecs >> 8);
+	if (nanosecs) {
+		int d0;
+		nanosecs = (nanosecs * 512UL) / 119UL;
+		__asm__("mull %0"
+			:"=d" (nanosecs), "=&a" (d0)
+			:"1" (nanosecs),"0" (current_cpu_data.loops_per_jiffy));
+        	__delay(nanosecs * HZ);
 	}
 }
 
@@ -118,15 +108,14 @@
 	}
 }
 
-static inline int
-lp_old98_wait_ready(void)
+static inline int lp_old98_wait_ready(void)
 {
 	struct timer_list timer;
 
 	init_timer(&timer);
 	timer.function = lp_old98_timer_function;
 	timer.expires = jiffies + 1;
-	timer.data = (unsigned long) &timer;
+	timer.data = (unsigned long)&timer;
 	add_timer(&timer);
 	interruptible_sleep_on(&lp_old98_waitq);
 	del_timer(&timer);
@@ -140,7 +129,7 @@
 	int tmp;
 #endif
 
-	while( !(inb(LP_PORT_STATUS) & LP_MASK_nBUSY) ) {
+	while (!(inb(LP_PORT_STATUS) & LP_MASK_nBUSY)) {
 		count++;
 		if (count >= lp.chars)
 			return 0;
@@ -153,7 +142,7 @@
 	 *  Update lp statsistics here (and between next two outb()'s).
 	 *  Time to compute it is part of storobe delay.
 	 */
-	if( count > lp.stats.maxwait ) {
+	if (count > lp.stats.maxwait) {
 #ifdef LP_OLD98_DEBUG
 		printk(KERN_DEBUG "lp_old98: success after %d counts.\n",
 		       count);
@@ -162,7 +151,7 @@
 	}
 	count *= 256;
 	tmp = count - lp.stats.meanwait;
-	if( tmp < 0 )
+	if (tmp < 0)
 		tmp = -tmp;
 #endif
 	nanodelay(lp.wait);
@@ -173,7 +162,7 @@
 #ifdef LP_STATS
 	lp.stats.meanwait = (255 * lp.stats.meanwait + count + 128) / 256;
 	lp.stats.mdev = (127 * lp.stats.mdev + tmp + 64) / 128;
-	lp.stats.chars++;
+	lp.stats.chars ++;
 #endif
 
 	nanodelay(lp.wait);
@@ -199,7 +188,7 @@
 		return -EFAULT;
 
 #ifdef LP_STATS
-	if( jiffies - lp.lastcall > lp.time )
+	if (jiffies - lp.lastcall > lp.time)
 		lp.runchars = 0;
 	lp.lastcall = jiffies;
 #endif
@@ -212,17 +201,17 @@
 		if (__copy_from_user(lp.lp_buffer, buf, copy_size))
 			return -EFAULT;
 
-		while( bytes_written < copy_size ) {
-			if( lp_old98_char(lp.lp_buffer[bytes_written]) )
-				bytes_written++;
+		while (bytes_written < copy_size) {
+			if (lp_old98_char(lp.lp_buffer[bytes_written]))
+				bytes_written ++;
 			else {
 #ifdef LP_STATS
 				int rc = lp.runchars + bytes_written;
 
-				if( rc > lp.stats.maxrun )
+				if (rc > lp.stats.maxrun)
 					lp.stats.maxrun = rc;
 
-				lp.stats.sleeps++;
+				lp.stats.sleeps ++;
 #endif
 #ifdef LP_OLD98_DEBUG
 				printk(KERN_DEBUG
@@ -243,7 +232,7 @@
 		lp.runchars += bytes_written;
 #endif
 		count -= bytes_written;
-	} while( count > 0 );
+	} while (count > 0);
 
 	return total_bytes_written;
 }
@@ -256,16 +245,16 @@
 
 static int lp_old98_open(struct inode * inode, struct file * file)
 {
-	if( MINOR(inode->i_rdev) != 0 )
+	if (minor(inode->i_rdev) != 0)
 		return -ENXIO;
-	if( lp.flags & LP_BUSY )
+	if (lp.flags & LP_BUSY)
 		return -EBUSY;
 
 	if ((lp.lp_buffer = kmalloc(LP_BUFFER_SIZE, GFP_KERNEL)) == NULL)
 		return -ENOMEM;
 
 	if (dc1_check && (lp.flags & LP_ABORTOPEN)
-	    && !(file->f_flags & O_NONBLOCK) ) {
+	    && !(file->f_flags & O_NONBLOCK)) {
 		/*
 		 *  Check whether printer is on-line.
 		 *  PC-9800's old style port have only BUSY# as status input,
@@ -284,22 +273,22 @@
 		 *		`PC-9801 Super Technique', Ascii, 1992.
 		 */
 		int count;
-		unsigned long eflags;
+		unsigned long flags;
 
-		save_flags(eflags);
-		cli();		/* interrupts while check is fairly bad */
+		/* interrupts while check is fairly bad */
+		spin_lock_irqsave(&lp_old98_lock, flags);
 
 		if (!lp_old98_char(DC1)) {
-			restore_flags(eflags);
+			spin_unlock_irqrestore(&lp_old98_lock, flags);
 			return -EBUSY;
 		}
 		count = (unsigned int)dc1_check > 10000 ? 10000 : dc1_check;
-		while( inb(LP_PORT_STATUS) & LP_MASK_nBUSY )
-			if( --count == 0 ) {
-				restore_flags(eflags);
+		while (inb(LP_PORT_STATUS) & LP_MASK_nBUSY)
+			if (--count == 0) {
+				spin_unlock_irqrestore(&lp_old98_lock, flags);
 				return -ENODEV;
 			}
-		restore_flags(eflags);
+		spin_unlock_irqrestore(&lp_old98_lock, flags);
 	}
 
 	lp.flags |= LP_BUSY;
@@ -329,14 +318,14 @@
 {
 	unsigned char data;
 
-	if( (data = inb(LP_PORT_EXTMODE)) != 0xFF && (data & 0x10) ) {
+	if ((data = inb(LP_PORT_EXTMODE)) != 0xFF && (data & 0x10)) {
 		printk(KERN_INFO
 		       "lp_old98: shutting down extended parallel port mode...\n");
 		outb(data & ~0x10, LP_PORT_EXTMODE);
 	}
 #ifdef	PC98_HW_H98
-	if( (pc98_hw_flags & PC98_HW_H98)
-	    && ((data = inb(LP_PORT_H98MODE)) & 0x01) ) {
+	if ((pc98_hw_flags & PC98_HW_H98)
+	    && ((data = inb(LP_PORT_H98MODE)) & 0x01)) {
 		printk(KERN_INFO
 		       "lp_old98: shutting down H98 full centronics mode...\n");
 		outb(data & ~0x01, LP_PORT_H98MODE);
@@ -358,7 +347,7 @@
 {
 	int retval = 0;
 
-	switch ( command ) {
+	switch (command) {
 	case LPTIME:
 		lp.time = arg * HZ/100;
 		break;
@@ -366,13 +355,13 @@
 		lp.chars = arg;
 		break;
 	case LPABORT:
-		if( arg )
+		if (arg)
 			lp.flags |= LP_ABORT;
 		else
 			lp.flags &= ~LP_ABORT;
 		break;
 	case LPABORTOPEN:
-		if( arg )
+		if (arg)
 			lp.flags |= LP_ABORTOPEN;
 		else
 			lp.flags &= ~LP_ABORTOPEN;
@@ -402,8 +391,8 @@
 		break;
 #ifdef LP_STATS
 	case LPGETSTATS:
-		if( copy_to_user((struct lp_stats *)arg, &lp.stats,
-				 sizeof(struct lp_stats)) )
+		if (copy_to_user((struct lp_stats *)arg, &lp.stats,
+				 sizeof(struct lp_stats)))
 			retval = -EFAULT;
 		else if (suser())
 			memset(&lp.stats, 0, sizeof(struct lp_stats));
@@ -420,13 +409,13 @@
 }
 
 static struct file_operations lp_old98_fops = {
-	owner:	THIS_MODULE,
-	llseek:	lp_old98_llseek,
-	read:	NULL,
-	write:	lp_old98_write,
-	ioctl:	lp_old98_ioctl,
-	open:	lp_old98_open,
-	release:lp_old98_release,
+	.owner		= THIS_MODULE,
+	.llseek		= lp_old98_llseek,
+	.read		= NULL,
+	.write		= lp_old98_write,
+	.ioctl		= lp_old98_ioctl,
+	.open		= lp_old98_open,
+	.release	= lp_old98_release,
 };
 
 /*
@@ -494,15 +483,15 @@
 
 static kdev_t lp_old98_console_device(struct console *console)
 {
-	return MKDEV(LP_MAJOR, 0);
+	return mk_kdev(LP_MAJOR, 0);
 }
 
 static struct console lp_old98_console = {
-	name:	"lp_old98",
-	write:	lp_old98_console_write,
-	device:	lp_old98_console_device,
-	flags:	CON_PRINTBUFFER,
-	index:	-1,
+	.name	= "lp_old98",
+	.write	= lp_old98_console_write,
+	.device	= lp_old98_console_device,
+	.flags	= CON_PRINTBUFFER,
+	.index	= -1,
 };
 
 #endif	/* console on lp_old98 */
@@ -544,7 +533,7 @@
 	 * but for locking out other printer drivers...
 	 */
 #ifdef	PC98_HW_H98
-	if( pc98_hw_flags & PC98_HW_H98 )
+	if (pc98_hw_flags & PC98_HW_H98)
 		request_region(LP_PORT_H98MODE, 1, "lp_old98");
 #endif
 	request_region(LP_PORT_EXTMODE, 1, "lp_old98");
@@ -565,7 +554,7 @@
 	release_region(LP_PORT_STATUS, 1);
 	release_region(LP_PORT_STROBE, 1);
 #ifdef	PC98_HW_H98
-	if( pc98_hw_flags & PC98_HW_H98 )
+	if (pc98_hw_flags & PC98_HW_H98)
 		release_region(LP_PORT_H98MODE, 1);
 #endif
 	release_region(LP_PORT_EXTMODE, 1);
@@ -573,5 +562,7 @@
 
 MODULE_PARM(dc1_check, "1i");
 MODULE_AUTHOR("Kousuke Takai <tak@kmc.kyoto-u.ac.jp>");
+MODULE_DESCRIPTION("PC-9800 old printer port driver");
+MODULE_LICENSE("GPL");
 
 #endif
