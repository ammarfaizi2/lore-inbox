Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293362AbSBYJ1v>; Mon, 25 Feb 2002 04:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293361AbSBYJ1o>; Mon, 25 Feb 2002 04:27:44 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:46216 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S293362AbSBYJ10>; Mon, 25 Feb 2002 04:27:26 -0500
Date: Mon, 25 Feb 2002 11:14:46 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Christer Weinigel <wingel@acolyte.hack.org>
Subject: [PATCH] SC1200 Watchdog driver
In-Reply-To: <Pine.LNX.4.30.0202222030570.11804-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.44.0202251025040.8317-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002, Roy Sigurd Karlsbakk wrote:

> On Fri, 22 Feb 2002, Zwane Mwaikambo wrote:
> > Here's a finalised version, with the recommended changes (including
> > probe). ISAPNP to follow shortly. Alan, regarding that race in ioctl,
> > read/write. Wouldn't the open semaphore protect against that in this case.
> > Otherwise irq safe spinlocks could be added to read/write.
> 
> Can anyone make a patch out of this?

Heres what i currently have, i'm providing this so that Christer can use 
it if he'd like something which is more generalised. ISAPNP support 
framework is in, but i haven't a clue what their vendor id is. And i think 
i may be using the ISAPNP_FUNCTION macro incorrectly.

Regards,
	Zwane

Patch is really against 2.4.18-rc4

diff -urN linux-2.4.18-rc1/Documentation/Configure.help linux-2.4.18-rc1-zm1/Documentation/Configure.help
--- linux-2.4.18-rc1/Documentation/Configure.help	Mon Feb 25 10:50:28 2002
+++ linux-2.4.18-rc1-zm1/Documentation/Configure.help	Mon Feb 25 11:05:05 2002
@@ -17439,6 +17439,18 @@
   The module is called machzwd.o.  If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt>.
 
+CONFIG_SC1200_WDT
+  This is a driver for National Semiconductor PC87307/PC97307 hardware
+  watchdog cards as found on the SC1200. This watchdog is mainly used
+  for power management purposes and can be used to power down the device
+  during inactivity periods (includes interrupt activity monitoring).
+
+  This driver is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module is called sc1200wdt.o.  If you want to compile it as a
+  module, say M here and read <file:Documentation/modules.txt>.  Most
+  people will say N.
+
 SuperH 3/4 Watchdog
 CONFIG_SH_WDT
   This driver adds watchdog support for the integrated watchdog in the
diff -urN linux-2.4.18-rc1/MAINTAINERS linux-2.4.18-rc1-zm1/MAINTAINERS
--- linux-2.4.18-rc1/MAINTAINERS	Mon Feb 25 10:50:28 2002
+++ linux-2.4.18-rc1-zm1/MAINTAINERS	Mon Feb 25 11:05:05 2002
@@ -1319,6 +1319,11 @@
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
+SC1200 WDT DRIVER
+P:      Zwane Mwaikambo
+M:      zwane@commfireservices.com
+S:      Maintained
+
 SCSI CDROM DRIVER
 P:	Jens Axboe
 M:	axboe@suse.de
diff -urN linux-2.4.18-rc1/drivers/char/Config.in linux-2.4.18-rc1-zm1/drivers/char/Config.in
--- linux-2.4.18-rc1/drivers/char/Config.in	Mon Feb 25 10:50:39 2002
+++ linux-2.4.18-rc1-zm1/drivers/char/Config.in	Mon Feb 25 11:05:05 2002
@@ -169,6 +169,8 @@
    tristate '  Intel i810 TCO timer / Watchdog' CONFIG_I810_TCO
    tristate '  Mixcom Watchdog' CONFIG_MIXCOMWD 
    tristate '  SBC-60XX Watchdog Timer' CONFIG_60XX_WDT
+   dep_tristate '  SC1200 Watchdog Timer (EXPERIMENTAL)' CONFIG_SC1200_WDT $CONFIG_EXPERIMENTAL
+
    tristate '  W83877F (EMACS) Watchdog Timer' CONFIG_W83877F_WDT
    tristate '  ZF MachZ Watchdog' CONFIG_MACHZ_WDT
 fi
diff -urN linux-2.4.18-rc1/drivers/char/Makefile linux-2.4.18-rc1-zm1/drivers/char/Makefile
--- linux-2.4.18-rc1/drivers/char/Makefile	Mon Feb 25 10:50:39 2002
+++ linux-2.4.18-rc1-zm1/drivers/char/Makefile	Mon Feb 25 11:05:05 2002
@@ -234,6 +234,7 @@
 obj-$(CONFIG_SH_WDT) += shwdt.o
 obj-$(CONFIG_EUROTECH_WDT) += eurotechwdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
+obj-$(CONFIG_SC1200_WDT) += sc1200wdt.o
 
 subdir-$(CONFIG_MWAVE) += mwave
 ifeq ($(CONFIG_MWAVE),y)
diff -urN linux-2.4.18-rc1/drivers/char/sc1200wdt.c linux-2.4.18-rc1-zm1/drivers/char/sc1200wdt.c
--- linux-2.4.18-rc1/drivers/char/sc1200wdt.c	Thu Jan  1 02:00:00 1970
+++ linux-2.4.18-rc1-zm1/drivers/char/sc1200wdt.c	Mon Feb 25 11:05:05 2002
@@ -0,0 +1,416 @@
+/*
+ *	National Semiconductor PC87307/PC97307 (ala SC1200) WDT driver
+ *	(c) Copyright 2002 Zwane Mwaikambo <zwane@commfireservices.com>,
+ *			All Rights Reserved.
+ *	Based on wdt.c and wdt977.c by Alan Cox and Woody Suwalski respectively.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ *	The author(s) of this software shall not be held liable for damages
+ *	of any nature resulting due to the use of this software. This
+ *	software is provided AS-IS with no warranties.
+ *
+ *	Changelog:
+ *	20020220 Zwane Mwaikambo	Code based on datasheet, no hardware.
+ *	20020221 Zwane Mwaikambo	Cleanups as suggested by Jeff Garzik and Alan Cox.
+ *	20020222 Zwane Mwaikambo	Added probing.
+ *	20020225 Zwane Mwaikambo	Added ISAPNP support.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/ioport.h>
+#include <linux/spinlock.h>
+#include <linux/ioport.h>
+#include <asm/semaphore.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/isapnp.h>
+
+#define SC1200_MODULE_VER	"build 20020225"
+#define SC1200_MODULE_NAME	"sc1200wdt"
+#define PFX			SC1200_MODULE_NAME ": "
+
+#define	MAX_TIMEOUT	255	/* 255 minutes */
+#define PMIR		(io)	/* Power Management Index Register */
+#define PMDR		(io+1)	/* Power Management Data Register */
+
+/* Data Register indexes */
+#define FER1		0x00	/* Function enable register 1 */
+#define FER2		0x01	/* Function enable register 2 */
+#define PMC1		0x02	/* Power Management Ctrl 1 */
+#define PMC2		0x03	/* Power Management Ctrl 2 */
+#define PMC3		0x04	/* Power Management Ctrl 3 */
+#define WDTO		0x05	/* Watchdog timeout register */
+#define	WDCF		0x06	/* Watchdog config register */
+#define WDST		0x07	/* Watchdog status register */
+
+/* WDO Status */
+#define WDO_ENABLED	0x00	
+#define WDO_DISABLED	0x01	
+
+/* WDCF bitfields - which devices assert WDO */
+#define KBC_IRQ		0x01	/* Keyboard Controller */
+#define MSE_IRQ		0x02	/* Mouse */
+#define UART1_IRQ	0x03	/* Serial0 */
+#define UART2_IRQ	0x04	/* Serial1 */
+/* 5 -7 are reserved */
+
+static char banner[] __initdata = KERN_INFO PFX SC1200_MODULE_VER;
+static int timeout = 1;
+static int io = -1;
+static int io_len = 2;		/* for non plug and play */
+struct semaphore open_sem;
+spinlock_t sc1200wdt_lock;	/* io port access serialisation */
+
+#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+static int isapnp = 1;
+static struct pci_dev *wdt_dev;
+#endif
+
+MODULE_PARM(io, "i");
+MODULE_PARM_DESC(io, "io port");
+MODULE_PARM(timeout, "i");
+MODULE_PARM_DESC(timeout, "range is 0-255 minutes, default is 1");
+
+#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+MODULE_PARM(isapnp, "i");
+MODULE_PARM_DESC(isapnp, "When set to 0 driver ISA PnP support will be disabled");
+#endif
+
+
+/* Read from Data Register */
+static inline void sc1200wdt_read_data(unsigned char index, unsigned char *data)
+{
+	spin_lock(&sc1200wdt_lock);
+	outb_p(index, PMIR);
+	*data = inb(PMDR);
+	spin_unlock(&sc1200wdt_lock);
+}
+
+
+/* Write to Data Register */
+static inline void sc1200wdt_write_data(unsigned char index, unsigned char data)
+{
+	spin_lock(&sc1200wdt_lock);
+	outb_p(index, PMIR);
+	outb(data, PMDR);
+	spin_unlock(&sc1200wdt_lock);
+}
+
+
+/* This returns the status of the WDO signal, inactive high.
+ * returns WDO_ENABLED or WDO_DISABLED
+ */
+static inline int sc1200wdt_status(void)
+{
+	unsigned char ret;
+
+	sc1200wdt_read_data(WDST, &ret);
+	return (ret & 0x01);		/* bits 1 - 7 are undefined */
+}
+
+
+static int sc1200wdt_open(struct inode *inode, struct file *file)
+{
+	unsigned char reg;
+
+	/* allow one at a time */
+	if (down_trylock(&open_sem))
+		return -EBUSY;
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT	
+	MOD_INC_USE_COUNT;
+#endif
+
+	if (timeout > MAX_TIMEOUT)
+		timeout = MAX_TIMEOUT;
+
+	sc1200wdt_read_data(WDCF, &reg);
+	/* assert WDO when any of the following interrupts are triggered too */
+	reg |= (KBC_IRQ | MSE_IRQ | UART1_IRQ | UART2_IRQ);
+	sc1200wdt_write_data(WDCF, reg);
+	/* set the timeout and get the ball rolling */
+	sc1200wdt_write_data(WDTO, timeout);
+	printk(KERN_INFO PFX "Watchdog enabled, timeout = %d min(s)", timeout);
+	
+	return 0;
+}
+
+
+static int sc1200wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int new_timeout;
+	static struct watchdog_info ident = {
+		options:		WDIOF_SETTIMEOUT,
+		identity:		"PC87307/PC97307"
+	};
+
+	switch (cmd) {
+		default:
+			return -ENOTTY;	/* Keep Pavel Machek amused ;) */
+
+		case WDIOC_GETSUPPORT:
+			if (copy_to_user((struct watchdog_info *)arg, &ident, sizeof ident))
+				return -EFAULT;
+			return 0;
+
+		case WDIOC_GETSTATUS:
+			return put_user(sc1200wdt_status(), (int *)arg);
+	
+		case WDIOC_KEEPALIVE:
+			sc1200wdt_write_data(WDTO, timeout);
+			return 0;
+
+		case WDIOC_SETTIMEOUT:
+			if (get_user(new_timeout, (int *)arg))
+				return -EFAULT;
+
+			/* the API states this is given in secs */
+			new_timeout /= 60;
+			if (new_timeout < 0 || new_timeout > MAX_TIMEOUT)
+				return -EINVAL;
+
+			timeout = new_timeout;
+			sc1200wdt_write_data(WDTO, timeout);
+			/* fall through and return the new timeout */
+
+		case WDIOC_GETTIMEOUT:
+			return put_user(timeout * 60, (int *)arg);
+	}
+}
+
+
+static int sc1200wdt_release(struct inode *inode, struct file *file)
+{
+#ifndef CONFIG_WATCHDOG_NOWAYOUT	
+	/* Disable it on the way out */
+	sc1200wdt_write_data(WDTO, 0);
+	printk(KERN_INFO PFX "Watchdog disabled\n");
+#endif
+	up(&open_sem);
+
+	return 0;
+}
+
+
+static ssize_t sc1200wdt_write(struct file *file, const char *data, size_t len, loff_t *ppos)
+{
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	if (len) {
+		sc1200wdt_write_data(WDTO, timeout);
+		return 1;
+	}
+		
+	return 0;
+}
+
+
+static int sc1200wdt_notify_sys(struct notifier_block *this, unsigned long code, void *unused)
+{
+	if (code == SYS_DOWN || code == SYS_HALT)
+		sc1200wdt_write_data(WDTO, 0);
+
+	return NOTIFY_DONE;
+}
+
+
+static struct notifier_block sc1200wdt_notifier =
+{
+	notifier_call:	sc1200wdt_notify_sys
+};
+
+static struct file_operations sc1200wdt_fops =
+{
+	owner:		THIS_MODULE,
+	write:		sc1200wdt_write,
+	ioctl:		sc1200wdt_ioctl,
+	open:		sc1200wdt_open,
+	release:	sc1200wdt_release
+};
+
+static struct miscdevice sc1200wdt_miscdev =
+{
+	minor:		WATCHDOG_MINOR,
+	name:		"watchdog",
+	fops:		&sc1200wdt_fops
+};
+
+
+static int __init sc1200wdt_probe(void)
+{
+	/* The probe works by reading the PMC3 register's default value of 0x0e
+	 * there is one caveat, if the device disables the parallel port or any
+	 * of the UARTs we won't be able to detect it.
+	 * Nb. This could be done with accuracy by reading the SID registers, but
+	 * we don't have access to those io regions.
+	 */
+	
+	unsigned char reg;
+
+	sc1200wdt_read_data(PMC3, &reg);
+	reg &= 0x0f;				/* we don't want the UART busy bits */
+	return (reg == 0x0e) ? 0 : -ENODEV;
+}
+
+
+#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+
+static int __init sc1200wdt_isapnp_probe(void)
+{
+	int ret;
+
+	/* The WDT is logical device 8 on the main device */
+	wdt_dev = isapnp_find_dev(NULL, ISAPNP_VENDOR('N','S','C'), ISAPNP_FUNCTION(0x08), NULL);
+	if (!wdt_dev)
+		return -ENODEV;
+	
+	if (wdt_dev->prepare(wdt_dev) < 0) {
+		printk(KERN_ERR PFX "ISA PnP found device that could not be autoconfigured\n");
+		return -EAGAIN;
+	}
+
+	if (!(pci_resource_flags(wdt_dev, 0) & IORESOURCE_IO)) {
+		printk(KERN_ERR PFX "ISA PnP could not find io ports\n");
+		return -ENODEV;
+	}
+
+	ret = wdt_dev->activate(wdt_dev);
+	if (ret && (ret != -EBUSY))
+		return -ENOMEM;
+
+	/* io port resource overriding support? */
+	io = pci_resource_start(wdt_dev, 0);
+	io_len = pci_resource_len(wdt_dev, 0);
+
+	printk(KERN_DEBUG PFX "ISA PnP found device at io port %#x/%d\n", io, io_len);
+	return 0;
+}
+
+#endif /* CONFIG_ISAPNP */
+
+
+static int __init sc1200wdt_init(void)
+{
+	int ret;
+
+	printk(banner);
+
+	spin_lock_init(&sc1200wdt_lock);
+	sema_init(&open_sem, 1);
+
+#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+	if (isapnp) {
+		ret = sc1200wdt_isapnp_probe();
+		if (ret)
+			goto out_clean;
+	}
+#endif
+
+	if (io == -1) {
+		printk(KERN_ERR PFX "io parameter must be specified\n");
+		ret = -EINVAL;
+		goto out_clean;
+	}
+
+	if (!request_region(io, io_len, SC1200_MODULE_NAME)) {
+		printk(KERN_ERR PFX "Unable to register IO port %#x\n", io);
+		ret = -EBUSY;
+		goto out_pnp;
+	}
+
+	ret = sc1200wdt_probe();
+	if (ret)
+		goto out_io;
+
+	ret = register_reboot_notifier(&sc1200wdt_notifier);
+	if (ret) {
+		printk(KERN_ERR PFX "Unable to register reboot notifier err = %d\n", ret);
+		goto out_io;
+	}
+
+	ret = misc_register(&sc1200wdt_miscdev);
+	if (ret) {
+		printk(KERN_ERR PFX "Unable to register miscdev on minor %d\n", WATCHDOG_MINOR);
+		goto out_rbt;
+	}
+
+	/* ret = 0 */
+
+out_clean:
+	return ret;
+
+out_rbt:
+	unregister_reboot_notifier(&sc1200wdt_notifier);
+
+out_io:
+	release_region(io, io_len);
+
+out_pnp:
+#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+	if (isapnp && wdt_dev)
+		wdt_dev->deactivate(wdt_dev);
+#endif
+	goto out_clean;
+}	
+
+
+static void __exit sc1200wdt_exit(void)
+{
+	misc_deregister(&sc1200wdt_miscdev);
+	unregister_reboot_notifier(&sc1200wdt_notifier);
+
+#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+	if(isapnp && wdt_dev)
+		wdt_dev->deactivate(wdt_dev);
+#endif
+
+	release_region(io, io_len);
+}
+
+
+#ifndef MODULE
+static int __init sc1200wdt_setup(char *str)
+{
+	int ints[4];
+
+	str = get_options (str, ARRAY_SIZE(ints), ints);
+
+	if (ints[0] > 0) {
+		io = ints[1];
+		if (ints[0] > 1)
+			timeout = ints[2];
+
+#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+		if (ints[0] > 2)
+			isapnp = ints[3];
+#endif
+	}
+
+	return 1;
+}
+
+__setup("sc1200wdt=", sc1200wdt_setup);
+#endif /* MODULE */
+
+
+module_init(sc1200wdt_init);
+module_exit(sc1200wdt_exit);
+
+MODULE_AUTHOR("Zwane Mwaikambo <zwane@commfireservices.com>");
+MODULE_DESCRIPTION("Driver for National Semiconductor PC87307/PC97307 watchdog component");
+MODULE_LICENSE("GPL");
+EXPORT_NO_SYMBOLS;
+

