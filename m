Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265961AbSKFSf4>; Wed, 6 Nov 2002 13:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265963AbSKFSf4>; Wed, 6 Nov 2002 13:35:56 -0500
Received: from precia.cinet.co.jp ([210.166.75.133]:46976 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S265961AbSKFSf3>; Wed, 6 Nov 2002 13:35:29 -0500
Message-ID: <3DC96278.E7F82315@cinet.co.jp>
Date: Thu, 07 Nov 2002 03:42:00 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.45-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCHSET 12/17] support PC-9800 against 2.5.45-ac1 (parport)
References: <3DC94C7B.79DE5EBC@cinet.co.jp>
Content-Type: multipart/mixed;
 boundary="------------AFD9DF04F53B1B1383848BBA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------AFD9DF04F53B1B1383848BBA
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

This patch adds support for stardard parallel port for PC-9800.

diffstat:
 drivers/char/Kconfig         |   21 +
 drivers/char/lp_old98.c      |  577 +++++++++++++++++++++++++++++++++++++++++++  drivers/parport/parport_pc.c |   68 ++++-
 include/linux/parport_pc.h   |   10 
 4 files changed, 671 insertions(+), 5 deletions(-)

-- 
Osamu Tomita
--------------AFD9DF04F53B1B1383848BBA
Content-Type: text/plain; charset=iso-2022-jp;
 name="parport.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="parport.patch"

diff -urN linux/drivers/parport/parport_pc.c linux98/drivers/parport/parport_pc.c
--- linux/drivers/parport/parport_pc.c	Sat Oct 19 13:01:52 2002
+++ linux98/drivers/parport/parport_pc.c	Sat Oct 26 17:01:09 2002
@@ -85,6 +85,8 @@
 #define DPRINTK(stuff...)
 #endif
 
+/* Indicates PC-9800 architecture  No:0 Yes:1 */
+extern int pc98;
 
 #define NR_SUPERIOS 3
 static struct superio_struct {	/* For Super-IO chips autodetection */
@@ -332,7 +334,10 @@
 
 unsigned char parport_pc_read_status(struct parport *p)
 {
-	return inb (STATUS (p));
+	if (pc98 && p->base == 0x40)
+		return ((inb(0x42) & 0x04) << 5) | PARPORT_STATUS_ERROR;
+	else
+		return inb (STATUS (p));
 }
 
 void parport_pc_disable_irq(struct parport *p)
@@ -1644,6 +1649,8 @@
 {
 	unsigned char r, w;
 
+	if (pc98 && pb->base == 0x40)
+		return PARPORT_MODE_PCSPP;
 	/*
 	 * first clear an eventually pending EPP timeout 
 	 * I (sailer@ife.ee.ethz.ch) have an SMSC chipset
@@ -1777,6 +1784,9 @@
 {
 	int ok = 0;
   
+	if (pc98 && pb->base == 0x40)
+		return 0;  /* never support */
+
 	clear_epp_timeout(pb);
 
 	/* try to tri-state the buffer */
@@ -1908,6 +1918,9 @@
 			config & 0x80 ? "Level" : "Pulses");
 
 		configb = inb (CONFIGB (pb));
+		if (pc98 && (CONFIGB(pb) == 0x14d) && ((configb & 0x38) == 0x30))
+			configb = (configb & ~0x38) | 0x28; /* IRQ 14 */
+
 		printk (KERN_DEBUG "0x%lx: ECP port cfgA=0x%02x cfgB=0x%02x\n",
 			pb->base, config, configb);
 		printk (KERN_DEBUG "0x%lx: ECP settings irq=", pb->base);
@@ -2048,6 +2061,9 @@
 	ECR_WRITE (pb, ECR_CNF << 5); /* Configuration MODE */
 
 	intrLine = (inb (CONFIGB (pb)) >> 3) & 0x07;
+	if (pc98 && (CONFIGB(pb) == 0x14d) && (intrLine == 6))
+		intrLine = 5; /* IRQ 14 */
+
 	irq = lookup[intrLine];
 
 	ECR_WRITE (pb, oecr);
@@ -2212,7 +2228,14 @@
 	struct parport tmp;
 	struct parport *p = &tmp;
 	int probedirq = PARPORT_IRQ_NONE;
-	if (check_region(base, 3)) return NULL;
+	if (pc98 && base == 0x40) {
+		int i;
+		for (i = 0; i < 8; i += 2)
+			if (check_region(base + i, 1)) return NULL;
+	} else {
+		if (check_region(base, 3)) return NULL;
+	}
+
 	priv = kmalloc (sizeof (struct parport_pc_private), GFP_KERNEL);
 	if (!priv) {
 		printk (KERN_DEBUG "parport (0x%lx): no memory!\n", base);
@@ -2245,7 +2268,7 @@
 	if (base_hi && !check_region(base_hi,3))
 		parport_ECR_present(p);
 
-	if (base != 0x3bc) {
+	if (!pc98 && base != 0x3bc) {
 		if (!check_region(base+0x3, 5)) {
 			if (!parport_EPP_supported(p))
 				parport_ECPEPP_supported(p);
@@ -2343,7 +2366,12 @@
 		printk(KERN_INFO "%s: irq %d detected\n", p->name, probedirq);
 	parport_proc_register(p);
 
-	request_region (p->base, 3, p->name);
+	if (pc98 && p->base == 0x40) {
+		int i;
+		for (i = 0; i < 8; i += 2)
+			request_region(p->base + i, 1, p->name);
+	} else
+		request_region (p->base, 3, p->name);
 	if (p->size > 3)
 		request_region (p->base + 3, p->size - 3, p->name);
 	if (p->modes & PARPORT_MODE_ECP)
@@ -2413,7 +2441,13 @@
 		free_dma(p->dma);
 	if (p->irq != PARPORT_IRQ_NONE)
 		free_irq(p->irq, p);
-	release_region(p->base, 3);
+	if (pc98 && p->base == 0x40) {
+		int i;
+		for (i = 0; i < 8; i += 2)
+			release_region(p->base + i, 1);
+	} else
+		release_region(p->base, 3);
+
 	if (p->size > 3)
 		release_region(p->base + 3, p->size - 3);
 	if (p->modes & PARPORT_MODE_ECP)
@@ -2994,6 +3028,30 @@
 {
 	int count = 0;
 
+	if (pc98) {
+		/* Set default resource settings for old style parport */
+		int	base = 0x40;
+		int	base_hi = 0;
+		int	irq = PARPORT_IRQ_NONE;
+		int	dma = PARPORT_DMA_NONE;
+
+		/* Check PC9800 old style parport */
+		outb(inb(0x149) & ~0x10, 0x149); /* disable IEEE1284 */
+		if (!(inb(0x149) & 0x10)) {  /* IEEE1284 disabled ? */
+			outb(inb(0x149) | 0x10, 0x149); /* enable IEEE1284 */
+			if (inb(0x149) & 0x10) {  /* IEEE1284 enabled ? */
+				/* Set default settings for IEEE1284 parport */
+				base = 0x140;
+				base_hi = 0x14c;
+				irq = 14;
+				/* dma = PARPORT_DMA_NONE; */
+			}
+		}
+
+		if (parport_pc_probe_port(base, base_hi, irq, dma, NULL))
+			count++;
+	}
+
 	if (parport_pc_probe_port(0x3bc, 0x7bc, autoirq, autodma, NULL))
 		count++;
 	if (parport_pc_probe_port(0x378, 0x778, autoirq, autodma, NULL))
diff -urN linux/include/linux/parport_pc.h linux98/include/linux/parport_pc.h
--- linux/include/linux/parport_pc.h	Tue Jun 12 11:15:27 2001
+++ linux98/include/linux/parport_pc.h	Sun Aug 19 14:13:09 2001
@@ -119,6 +119,11 @@
 #endif
 	ctr = (ctr & ~mask) ^ val;
 	ctr &= priv->ctr_writable; /* only write writable bits. */
+#ifdef CONFIG_PC9800
+	if (p->base == 0x40 && ((priv->ctr) ^ ctr) & 0x01)
+		outb(0x0e | ((ctr & 0x01) ^ 0x01), 0x46);
+	else
+#endif /* CONFIG_PC9800 */
 	outb (ctr, CONTROL (p));
 	priv->ctr = ctr;	/* Update soft copy */
 	return ctr;
@@ -191,6 +196,11 @@
 
 extern __inline__ unsigned char parport_pc_read_status(struct parport *p)
 {
+#ifdef CONFIG_PC9800
+	if (p->base == 0x40)
+		return ((inb(0x42) & 0x04) << 5) | PARPORT_STATUS_ERROR;
+	else
+#endif /* CONFIG_PC9800 */
 	return inb(STATUS(p));
 }
 
diff -urN linux/drivers/char/Kconfig linux98/drivers/char/Kconfig
--- linux/drivers/char/Kconfig	Thu Oct 31 13:23:11 2002
+++ linux98/drivers/char/Kconfig	Thu Oct 31 19:17:02 2002
@@ -574,6 +574,17 @@
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
 
 
@@ -1053,6 +1064,7 @@
 
 config RTC
 	tristate "Enhanced Real Time Clock Support"
+	depends on !PC9800
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -1111,6 +1123,15 @@
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
diff -urN linux/drivers/char/lp_old98.c linux98/drivers/char/lp_old98.c
--- linux/drivers/char/lp_old98.c	Thu Jan  1 09:00:00 1970
+++ linux98/drivers/char/lp_old98.c	Sat Oct 26 17:13:23 2002
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

--------------AFD9DF04F53B1B1383848BBA--

