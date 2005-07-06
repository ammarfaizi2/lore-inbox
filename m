Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbVGFVam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVGFVam (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 17:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVGFV1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 17:27:39 -0400
Received: from fmr19.intel.com ([134.134.136.18]:41877 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262524AbVGFVZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 17:25:26 -0400
From: Mark Gross <mgross@linux.intel.com>
Organization: Intel
To: Willy Tarreau <willy@w.ods.org>, Pekka J Enberg <penberg@cs.helsinki.fi>
Subject: Re: Patch of a new driver for kernel 2.4.x that need review
Date: Wed, 6 Jul 2005 14:11:55 -0700
User-Agent: KMail/1.5.4
Cc: Pekka Enberg <penberg@gmail.com>,
       "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Lorenzini, Mario" <mario.lorenzini@ca.kontron.com>
References: <5009AD9521A8D41198EE00805F85F18F067F6A36@sembo111.teknor.com> <courier.42BA3791.000006F9@courier.cs.helsinki.fi> <20050623044952.GA21017@alpha.home.local>
In-Reply-To: <20050623044952.GA21017@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507061411.57725.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 June 2005 21:49, Willy Tarreau wrote:
> Hi Pekka,
>
> On Thu, Jun 23, 2005 at 07:16:17AM +0300, Pekka J Enberg wrote:
> > Hi Willy,
> >
> > Willy Tarreau writes:
> > >I dont agree with you here : enums are good to simply specify an
> > >ordering.
> > >But they must not be used to specify static mapping. Eg: if REG4 *must*
> > >be
> > >equal to BASE+4, you should not use enums, otherwise it will render the
> > >code unreadable. I personnaly don't want to count the position of REG7
> > > in the enum to discover that it's at BASE+7.
> >
> > Sorry, what do you have to count with the following?
> >
> > enum {
> >       TLCLK_REG0 = TLCLK_BASE,
> >       TLCLK_REG1 = TLCLK_BASE+1,
> >       TLCLK_REG2 = TLCLK_BASE+2,
> > };
>
> Sorry for the noise, I replied in a second mail that I was perfectly OK
> with this usage. What I though you wanted to propose was the simplest for
> of enum where only the first value is specified, and which is a nightmare
> to debug afterwards. Bill Gatliff also suggested that gdb can display and
> use the symbolic values while it's not the case on defines.
>
> Regards,
> Willy
>

I'm helping out Sebastien a bit with maintaining this driver attached is an update that attempts to 
address the commens from this thread.  The 2.6 version of this driver will be posted separately.

--mgross

diff -urN -X dontdiff_osdl vanilla/linux-2.4.31/drivers/char/Config.in linux-2.4/drivers/char/Config.in
--- vanilla/linux-2.4.31/drivers/char/Config.in	2004-08-07 16:26:04.000000000 -0700
+++ linux-2.4/drivers/char/Config.in	2005-07-06 12:30:28.000000000 -0700
@@ -401,4 +401,6 @@
    dep_tristate 'HP OB600 C/CT Pop-up mouse support' CONFIG_OBMOUSE $CONFIG_INPUT_MOUSEDEV
 fi
 
+tristate 'Telecom clock support' CONFIG_TELCLOCK
+
 endmenu
diff -urN -X dontdiff_osdl vanilla/linux-2.4.31/drivers/char/Makefile linux-2.4/drivers/char/Makefile
--- vanilla/linux-2.4.31/drivers/char/Makefile	2004-08-07 16:26:04.000000000 -0700
+++ linux-2.4/drivers/char/Makefile	2005-07-06 12:30:28.000000000 -0700
@@ -323,6 +323,7 @@
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
 obj-$(CONFIG_INDYDOG) += indydog.o
 obj-$(CONFIG_8xx_WDT) += mpc8xx_wdt.o
+obj-$(CONFIG_TELCLOCK) += tlclk.o
 
 subdir-$(CONFIG_MWAVE) += mwave
 ifeq ($(CONFIG_MWAVE),y)
diff -urN -X dontdiff_osdl vanilla/linux-2.4.31/drivers/char/tlclk.c linux-2.4/drivers/char/tlclk.c
--- vanilla/linux-2.4.31/drivers/char/tlclk.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.4/drivers/char/tlclk.c	2005-07-06 13:21:24.000000000 -0700
@@ -0,0 +1,459 @@
+/*
+ * Telecom Clock driver for Wainwright board
+ *
+ * Copyright (C) 2005 Kontron Canada
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <sebastien.bouchard@ca.kontron.com>
+ *
+ * Description : This is the TELECOM CLOCK module driver for the ATCA platform.
+ */
+#ifndef __KERNEL__
+#  define __KERNEL__
+#endif
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>	/* printk() */
+#include <linux/fs.h>		/* everything... */
+#include <linux/errno.h>	/* error codes */
+#include <linux/delay.h>	/* udelay */
+#include <asm/uaccess.h>
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <linux/devfs_fs_kernel.h>	/* Devfs support */
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <linux/tqueue.h>	/* interrupt task */
+#include <asm/io.h>		/* inb/outb */
+
+#include "tlclk.h"	/* TELECOM IOCTL DEFINE */
+
+MODULE_AUTHOR("Sebastien Bouchard <sebastien.bouchard@ca.kontron.com>");
+MODULE_LICENSE("GPL");
+
+/* Telecom clock I/O register definition */
+#define TLCLK_BASE 0xa08            
+#define TLCLK_REG0 TLCLK_BASE
+#define TLCLK_REG1 (TLCLK_BASE+1)
+#define TLCLK_REG2 (TLCLK_BASE+2)
+#define TLCLK_REG3 (TLCLK_BASE+3)
+#define TLCLK_REG4 (TLCLK_BASE+4)
+#define TLCLK_REG5 (TLCLK_BASE+5)
+#define TLCLK_REG6 (TLCLK_BASE+6)
+#define TLCLK_REG7 (TLCLK_BASE+7)
+
+#define SET_PORT_BITS(port, mask, val) outb(((inb(port) & mask) | val), port)
+
+/* 0 = Dynamic allocation of the major device number */
+#define TLCLK_MAJOR 252
+
+/* Contain the interrupt used for telecom clock */
+static int telclk_interrupt; 
+
+static int int_events;		/* Event that generate a interrupt */
+static int got_event;		/* if events processing have been done */
+
+static struct timer_list switchover_timer;
+
+struct tlclk_alarms *alarm_events;
+
+spinlock_t event_lock = SPIN_LOCK_UNLOCKED;
+
+/* DEVFS support or not */
+#ifdef CONFIG_DEVFS_FS
+devfs_handle_t devfs_handle;
+#else
+static int tlclk_major = TLCLK_MAJOR;
+#endif
+
+static void switchover_timeout(unsigned long data);
+void tlclk_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+
+DECLARE_WAIT_QUEUE_HEAD(wq);
+/*
+*  Function : Module I/O functions
+*  Description : Almost all the control stuff is done here, check I/O dn for
+*  help.
+*/
+static int
+tlclk_ioctl(struct inode *inode,
+	    struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	unsigned long flags;
+	unsigned char val;
+	val = (unsigned char) arg;
+
+	if (_IOC_TYPE(cmd) != TLCLK_IOC_MAGIC)
+		return -ENOTTY;
+
+	if (_IOC_NR(cmd) > TLCLK_IOC_MAXNR)
+		return -ENOTTY;
+
+	switch (cmd) {
+	case IOCTL_RESET:
+		SET_PORT_BITS(TLCLK_REG4, 0xfd, val);
+		break;
+	case IOCTL_MODE_SELECT:
+		SET_PORT_BITS(TLCLK_REG0, 0xcf, val);
+		break;
+	case IOCTL_REFALIGN:
+		/* GENERATING 0 to 1 transistion */
+		SET_PORT_BITS(TLCLK_REG0, 0xf7, 0);
+		udelay(2);
+		SET_PORT_BITS(TLCLK_REG0, 0xf7, 0x08);
+		udelay(2);
+		SET_PORT_BITS(TLCLK_REG0, 0xf7, 0);
+		break;
+	case IOCTL_HARDWARE_SWITCHING:
+		SET_PORT_BITS(TLCLK_REG0, 0x7f, val);
+		break;
+	case IOCTL_HARDWARE_SWITCHING_MODE:
+		SET_PORT_BITS(TLCLK_REG0, 0xbf, val);
+		break;
+	case IOCTL_FILTER_SELECT:
+		SET_PORT_BITS(TLCLK_REG0, 0xfb, val);
+		break;
+	case IOCTL_SELECT_REF_FREQUENCY:
+		spin_lock_irqsave(&event_lock, flags);
+		SET_PORT_BITS(TLCLK_REG1, 0xfd, val);
+		spin_unlock_irqrestore(&event_lock, flags);
+		break;
+	case IOCTL_SELECT_REDUNDANT_CLOCK:
+		spin_lock_irqsave(&event_lock, flags);
+		SET_PORT_BITS(TLCLK_REG1, 0xfe, val);
+		spin_unlock_irqrestore(&event_lock, flags);
+		break;
+	case IOCTL_SELECT_AMCB1_TRANSMIT_CLOCK:
+		if ((val == CLK_8kHz) || (val == CLK_16_384MHz)) {
+			SET_PORT_BITS(TLCLK_REG3, 0xf8, 0x5);
+			SET_PORT_BITS(TLCLK_REG1, 0xfb, ~val);
+		} else if (val >= CLK_8_592MHz) {
+			SET_PORT_BITS(TLCLK_REG3, 0xf8, 0x7);
+			switch (val) {
+			case CLK_8_592MHz:
+				SET_PORT_BITS(TLCLK_REG0, 0xfc, 1);
+				break;
+			case CLK_11_184MHz:
+				SET_PORT_BITS(TLCLK_REG0, 0xfc, 0);
+				break;
+			case CLK_34_368MHz:
+				SET_PORT_BITS(TLCLK_REG0, 0xfc, 3);
+				break;
+			case CLK_44_736MHz:
+				SET_PORT_BITS(TLCLK_REG0, 0xfc, 2);
+				break;
+			}
+		} else
+			SET_PORT_BITS(TLCLK_REG3, 0xf8, val);
+		break;
+	case IOCTL_SELECT_AMCB2_TRANSMIT_CLOCK:
+		if ((val == CLK_8kHz) || (val == CLK_16_384MHz)) {
+			SET_PORT_BITS(TLCLK_REG3, 0xc7, 0x28);
+			SET_PORT_BITS(TLCLK_REG1, 0xfb, ~val);
+		} else if (val >= CLK_8_592MHz) {
+			SET_PORT_BITS(TLCLK_REG3, 0xc7, 0x38);
+			switch (val) {
+			case CLK_8_592MHz:
+				SET_PORT_BITS(TLCLK_REG0, 0xfc, 1);
+				break;
+			case CLK_11_184MHz:
+				SET_PORT_BITS(TLCLK_REG0, 0xfc, 0);
+				break;
+			case CLK_34_368MHz:
+				SET_PORT_BITS(TLCLK_REG0, 0xfc, 3);
+				break;
+			case CLK_44_736MHz:
+				SET_PORT_BITS(TLCLK_REG0, 0xfc, 2);
+				break;
+			}
+		} else
+			SET_PORT_BITS(TLCLK_REG3, 0xc7, val << 3);
+		break;
+	case IOCTL_TEST_MODE:
+		SET_PORT_BITS(TLCLK_REG4, 0xfd, 2);
+		break;
+	case IOCTL_ENABLE_CLKA0_OUTPUT:
+		SET_PORT_BITS(TLCLK_REG2, 0xfe, val);
+		break;
+	case IOCTL_ENABLE_CLKB0_OUTPUT:
+		SET_PORT_BITS(TLCLK_REG2, 0xfd, val << 1);
+		break;
+	case IOCTL_ENABLE_CLKA1_OUTPUT:
+		SET_PORT_BITS(TLCLK_REG2, 0xfb, val << 2);
+		break;
+	case IOCTL_ENABLE_CLKB1_OUTPUT:
+		SET_PORT_BITS(TLCLK_REG2, 0xf7, val << 3);
+		break;
+	case IOCTL_ENABLE_CLK3A_OUTPUT:
+		SET_PORT_BITS(TLCLK_REG3, 0xbf, val << 6);
+		break;
+	case IOCTL_ENABLE_CLK3B_OUTPUT:
+		SET_PORT_BITS(TLCLK_REG3, 0x7f, val << 7);
+		break;
+	case IOCTL_READ_ALARMS:
+		return (inb(TLCLK_REG2) & 0xf0);
+		break;
+	case IOCTL_READ_INTERRUPT_SWITCH:
+		return inb(TLCLK_REG6);
+		break;
+	case IOCTL_READ_CURRENT_REF:
+		return ((inb(TLCLK_REG1) & 0x08) >> 3);
+		break;
+	}
+
+	return 0;
+}
+
+/*
+*  Function : Module Opening
+*  Description : Called when a program open the 
+*  /dev/telclock file related to the module.
+*/
+static int
+tlclk_open(struct inode *inode, struct file *filp)
+{
+	int result;
+#ifdef MODULE
+	if (!MOD_IN_USE) {
+		MOD_INC_USE_COUNT;
+#endif
+		/* Make sure there is no interrupt pending will 
+		   *  initialising interrupt handler */
+		inb(TLCLK_REG6);
+
+		result = request_irq(telclk_interrupt, &tlclk_interrupt,
+					SA_SHIRQ, "telclock", tlclk_interrupt);
+		printk("\ntelclock: Reserving IRQ%d...\n", telclk_interrupt);
+		if (result == -EBUSY) {
+			printk(KERN_ERR
+				"telclock: Interrupt can't be reserved!\n");
+			return -EBUSY;
+		}
+		inb(TLCLK_REG6);	/* Clear interrupt events */
+#ifdef MODULE
+	} else
+		return -EBUSY;
+#endif
+	return 0;
+}
+
+/*
+*  Function : Module Releasing
+*  Description : Called when a program stop using the module.
+*/
+static int
+tlclk_release(struct inode *inode, struct file *filp)
+{
+	MOD_DEC_USE_COUNT;
+	if (!MOD_IN_USE)
+		free_irq(telclk_interrupt, tlclk_interrupt);
+	return 0;
+}
+
+ssize_t
+tlclk_read(struct file * filp, char *buf, size_t count, loff_t * f_pos)
+{
+	int count0 = sizeof(struct tlclk_alarms);
+	wait_event_interruptible(wq, got_event);
+	if (copy_to_user(buf, alarm_events, sizeof(struct tlclk_alarms)))
+		return -EFAULT;
+
+	memset(alarm_events, 0, sizeof(struct tlclk_alarms));
+	got_event = 0;
+	
+	return count0;
+}
+
+ssize_t
+tlclk_write(struct file * filp, const char *buf, size_t count, loff_t * f_pos)
+{
+	return 0;
+}
+
+/*
+* This is where you set what function is called when an action is done to your
+*  /dev file.
+*/
+static struct file_operations tlclk_fops = {
+	.read = tlclk_read,
+	.write = tlclk_write,
+	.ioctl = tlclk_ioctl,
+	.open = tlclk_open,
+	.release = tlclk_release,
+
+};
+/*
+* Function : Module Initialisation                      
+* Description : Called at module loading, 
+* all the OS registering stuff is her
+*/
+static int __init
+tlclk_init(void)
+{
+/* DEVFS or NOT? */
+#ifdef CONFIG_DEVFS_FS
+	devfs_handle = devfs_register(NULL, "telclock",
+					DEVFS_FL_AUTO_DEVNUM, TLCLK_MAJOR,
+					0,
+					S_IFCHR | S_IRUGO | S_IWUGO,
+					&tlclk_fops, NULL);
+	if (!devfs_handle)
+		goto out1;
+#else
+	tlclk_major = register_chrdev(tlclk_major, "telclock", &tlclk_fops);
+
+	if (tlclk_major < 0) {
+		printk(KERN_ERR "telclock: can't get major! %d\n", tlclk_major);
+		return tlclk_major;
+	}
+#endif
+
+	alarm_events = kmalloc(sizeof(struct tlclk_alarms), GFP_KERNEL);
+	
+	if (!alarm_events)
+		goto out1;
+	
+	memset(alarm_events, 0, sizeof(struct tlclk_alarms));
+
+/* Read telecom clock IRQ number (Set by BIOS) */
+
+	printk(KERN_WARNING "telclock: Reserving I/O region...\n");
+
+	if ( !request_region(TLCLK_BASE, 8, "telclock") ) {
+		printk(KERN_ERR "telclock: request_region failed!\n");
+			goto out2;
+	}
+	telclk_interrupt = (inb(TLCLK_REG7) & 0x0f);
+
+	init_timer(&switchover_timer);
+	switchover_timer.function = switchover_timeout;
+	switchover_timer.data = 0;
+
+	return 0;
+out2:
+	kfree(alarm_events);
+out1:
+	return -EBUSY;
+}
+
+/*
+*  Function : Module Cleaning 
+*  Description : Called when unloading the module
+*/
+static void __exit
+tlclk_cleanup(void)
+{
+#ifdef CONFIG_DEVFS_FS
+	devfs_unregister(devfs_handle);
+#else
+	unregister_chrdev(tlclk_major, "telclock");
+#endif
+	release_region(TLCLK_BASE, 8);
+	del_timer_sync(&switchover_timer);
+	kfree(alarm_events);
+	
+}
+static void
+switchover_timeout(unsigned long data)
+{
+	if ((data & 1)) {
+		if ((inb(TLCLK_REG1) & 0x08) != (data & 0x08))
+			alarm_events->switchover_primary++;
+	} else {
+		if ((inb(TLCLK_REG1) & 0x08) != (data & 0x08))
+			alarm_events->switchover_secondary++;
+	}
+
+	/* Alarm processing is done, wake up read task */
+	del_timer(&switchover_timer);
+	got_event = 1;
+	wake_up(&wq);
+}
+/*
+*  Function : Interrupt Handler 
+*  Description :
+*  Handling of alarms interrupt.
+*  
+*/
+void
+tlclk_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&event_lock, flags);
+	/* Read and clear interrupt events */
+	int_events = inb(TLCLK_REG6);
+	spin_unlock_irqrestore(&event_lock, flags);
+	
+	/* Primary_Los changed from 0 to 1 ? */
+	if (int_events & PRI_LOS_01_MASK) {
+		if (inb(TLCLK_REG2) & SEC_LOST_MASK)
+			alarm_events->lost_clocks++;
+		else
+			alarm_events->lost_primary_clock++;
+	}
+
+	/* Primary_Los changed from 1 to 0 ? */
+	if (int_events & PRI_LOS_10_MASK) {
+		alarm_events->primary_clock_back++;
+		spin_lock_irqsave(&event_lock, flags);
+		SET_PORT_BITS(TLCLK_REG1, 0xFE, 1);
+		spin_unlock_irqrestore(&event_lock, flags);
+	}
+	/* Secondary_Los changed from 0 to 1 ? */
+	if (int_events & SEC_LOS_01_MASK) {
+		if (inb(TLCLK_REG2) & PRI_LOST_MASK)
+			alarm_events->lost_clocks++;
+		else
+			alarm_events->lost_secondary_clock++;
+	}
+	/* Secondary_Los changed from 1 to 0 ? */
+	if (int_events & SEC_LOS_10_MASK) {
+		alarm_events->secondary_clock_back++;
+		spin_lock_irqsave(&event_lock, flags);
+		SET_PORT_BITS(TLCLK_REG1, 0xFE, 0);
+		spin_unlock_irqrestore(&event_lock, flags);
+	}
+	if (int_events & HOLDOVER_10_MASK)
+		alarm_events->pll_end_holdover++;
+
+	if (int_events & UNLOCK_01_MASK)
+		alarm_events->pll_lost_sync++;
+
+	if (int_events & UNLOCK_10_MASK)
+		alarm_events->pll_sync++;
+
+	/* Holdover changed from 0 to 1 ? */
+	if (int_events & HOLDOVER_01_MASK) {
+		alarm_events->pll_holdover++;
+
+		switchover_timer.expires = jiffies + 1;	/* TIMEOUT in ~10ms */
+		switchover_timer.data = inb(TLCLK_REG1);
+		add_timer(&switchover_timer);
+	} else {
+		got_event = 1;
+		wake_up(&wq);
+	}
+}
+
+module_init(tlclk_init);
+module_exit(tlclk_cleanup);
diff -urN -X dontdiff_osdl vanilla/linux-2.4.31/drivers/char/tlclk.h linux-2.4/drivers/char/tlclk.h
--- vanilla/linux-2.4.31/drivers/char/tlclk.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.4/drivers/char/tlclk.h	2005-07-06 12:30:28.000000000 -0700
@@ -0,0 +1,167 @@
+/*
+ * Telecom Clock driver for Wainwright board
+ *
+ * Copyright (C) 2005 Kontron Canada
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <sebastien.bouchard@ca.kontron.com>
+ *
+ */
+ 
+/* Ioctl definitions  */
+
+/* Use 0xA1 as magic number */
+#define TLCLK_IOC_MAGIC 0xA1
+
+/*Hardware Reset of the PLL */
+
+#define RESET_ON 0x00
+#define RESET_OFF 0x01
+#define IOCTL_RESET _IO(TLCLK_IOC_MAGIC,  1)
+
+#define IOCTL_REFALIGN _IO(TLCLK_IOC_MAGIC,  2)
+
+/* MODE SELECT */
+
+#define NORMAL_MODE 0x00
+#define HOLDOVER_MODE 0x10
+#define FREERUN_MODE 0x20
+
+#define IOCTL_MODE_SELECT _IOR(TLCLK_IOC_MAGIC,  3, char)
+
+/* FILTER SELECT */
+
+#define FILTER_6HZ 0x04
+#define FILTER_12HZ 0x00
+
+#define IOCTL_FILTER_SELECT _IOR(TLCLK_IOC_MAGIC,  4, char)
+
+/* SELECT REFERENCE FREQUENCY */
+
+#define REF_CLK1_8kHz 0x00
+#define REF_CLK2_19_44MHz 0x02
+
+#define IOCTL_SELECT_REF_FREQUENCY _IOR(TLCLK_IOC_MAGIC,  6, char)
+
+/* Select primary or secondary redundant clock */
+
+#define PRIMARY_CLOCK 0x00
+#define SECONDARY_CLOCK 0x01
+#define IOCTL_SELECT_REDUNDANT_CLOCK _IOR(TLCLK_IOC_MAGIC,  7, char)
+
+/* CLOCK TRANSMISSION DEFINE */
+
+#define CLK_8kHz 0xff
+#define CLK_16_384MHz 0xfb
+
+#define CLK_1_544MHz 0x00
+#define CLK_2_048MHz 0x01
+#define CLK_4_096MHz 0x02
+#define CLK_6_312MHz 0x03
+#define CLK_8_192MHz 0x04
+#define CLK_19_440MHz 0x06
+
+#define CLK_8_592MHz 0x08
+#define CLK_11_184MHz 0x09
+#define CLK_34_368MHz 0x0b
+#define CLK_44_736MHz 0x0a
+
+#define IOCTL_SELECT_AMCB1_TRANSMIT_CLOCK _IOR(TLCLK_IOC_MAGIC,  9, char)
+#define IOCTL_SELECT_AMCB2_TRANSMIT_CLOCK _IOR(TLCLK_IOC_MAGIC,  10, char)
+
+/* RECEIVED REFERENCE */
+
+#define AMC_B1 0
+#define AMC_B2 1
+
+#define IOCTL_SELECT_RECEIVED_REF_CLK3A _IOR(TLCLK_IOC_MAGIC,  11, char)
+#define IOCTL_SELECT_RECEIVED_REF_CLK3B _IOR(TLCLK_IOC_MAGIC,  12, char)
+
+/* OEM COMMAND - NOT IN FINAL VERSION */
+
+#define IOCTL_TEST_MODE _IO(TLCLK_IOC_MAGIC,  13)
+
+/* HARDWARE SWITCHING DEFINE */
+
+#define HW_ENABLE 0x80
+#define HW_DISABLE 0x00
+
+#define IOCTL_HARDWARE_SWITCHING _IOR(TLCLK_IOC_MAGIC,  14, char)
+
+/* HARDWARE SWITCHING MODE DEFINE */
+
+#define PLL_HOLDOVER 0x40
+#define LOST_CLOCK 0x00
+
+#define IOCTL_HARDWARE_SWITCHING_MODE _IOR(TLCLK_IOC_MAGIC,  15, char)
+
+/* CLOCK OUTPUT DEFINE */
+
+#define IOCTL_ENABLE_CLKA0_OUTPUT _IOR(TLCLK_IOC_MAGIC,  16, char)
+#define IOCTL_ENABLE_CLKB0_OUTPUT _IOR(TLCLK_IOC_MAGIC,  17, char)
+#define IOCTL_ENABLE_CLKA1_OUTPUT _IOR(TLCLK_IOC_MAGIC,  18, char)
+#define IOCTL_ENABLE_CLKB1_OUTPUT _IOR(TLCLK_IOC_MAGIC,  19, char)
+
+#define IOCTL_ENABLE_CLK3A_OUTPUT _IOR(TLCLK_IOC_MAGIC,  20, char)
+#define IOCTL_ENABLE_CLK3B_OUTPUT _IOR(TLCLK_IOC_MAGIC,  21, char)
+
+/* ALARMS DEFINE */
+
+#define UNLOCK_MASK 0x10
+#define HOLDOVER_MASK 0x20
+#define SEC_LOST_MASK 0x40
+#define PRI_LOST_MASK 0x80
+
+#define IOCTL_READ_ALARMS _IO(TLCLK_IOC_MAGIC,  22)
+
+/* INTERRUPT CAUSE DEFINE */
+
+#define PRI_LOS_01_MASK 0x01
+#define PRI_LOS_10_MASK 0x02
+
+#define SEC_LOS_01_MASK 0x04
+#define SEC_LOS_10_MASK 0x08
+
+#define HOLDOVER_01_MASK 0x10
+#define HOLDOVER_10_MASK 0x20
+
+#define UNLOCK_01_MASK 0x40
+#define UNLOCK_10_MASK 0x80
+
+#define IOCTL_READ_INTERRUPT_SWITCH _IO(TLCLK_IOC_MAGIC,  23)
+
+#define IOCTL_READ_CURRENT_REF _IO(TLCLK_IOC_MAGIC,  25)
+
+/* MAX NUMBER OF IOCTL */
+#define TLCLK_IOC_MAXNR 25
+
+struct tlclk_alarms {
+	unsigned int lost_clocks;
+	unsigned int lost_primary_clock;
+	unsigned int lost_secondary_clock;
+	unsigned int primary_clock_back;
+	unsigned int secondary_clock_back;
+	unsigned int switchover_primary;
+	unsigned int switchover_secondary;
+	unsigned int pll_holdover;
+	unsigned int pll_end_holdover;
+	unsigned int pll_lost_sync;
+	unsigned int pll_sync;
+};
+

