Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279376AbRJWLXm>; Tue, 23 Oct 2001 07:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279374AbRJWLX1>; Tue, 23 Oct 2001 07:23:27 -0400
Received: from hermes.domdv.de ([193.102.202.1]:19972 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S279375AbRJWLVg>;
	Tue, 23 Oct 2001 07:21:36 -0400
Message-ID: <XFMail.20011023132049.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.4.6-3.Linux:20011023132005:5243=_"
Date: Tue, 23 Oct 2001 13:20:49 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Quancom ISA Watchdog 1/2 (2.4.13pre6)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format
--_=XFMail.1.4.6-3.Linux:20011023132005:5243=_
Content-Type: text/plain; charset=us-ascii

The attached patch is a driver for the Quancom ISA Watchdog cards 1 and 2.

Vendor information:

http://www.quancom.de/qprod01/eng/pb/watchdog1.htm
http://www.quancom.de/qprod01/eng/pb/watchdog2.htm

Quancom did ship (quite a while ago) the cards with a 2.2.x driver for Watchdog
1/2/3 based on wdt.c, thus the driver is GPL. As I don't have the Watchdog 3
version (Watchdog 1 and 2 are the same from the driver's view) I did strip down
the driver to Watchdog 1/2 and ported it to 2.4.x.


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

--_=XFMail.1.4.6-3.Linux:20011023132005:5243=_
Content-Disposition: attachment; filename="quancom.patch"
Content-Transfer-Encoding: 7bit
Content-Description: quancom.patch
Content-Type: text/plain; charset=us-ascii; name=quancom.patch; SizeOnDisk=7333

diff -rNu linux/drivers/char/Config.in linux-fixed/drivers/char/Config.in
--- linux/drivers/char/Config.in	Tue Oct 23 12:57:58 2001
+++ linux-fixed/drivers/char/Config.in	Tue Oct 23 13:12:07 2001
@@ -167,6 +167,7 @@
       fi
    fi
    tristate '  ZF MachZ Watchdog' CONFIG_MACHZ_WDT
+   tristate '  Quancom Watchdog1/2' CONFIG_QUANCOM
 fi
 endmenu
 
diff -rNu linux/drivers/char/Makefile linux-fixed/drivers/char/Makefile
--- linux/drivers/char/Makefile	Tue Oct 23 12:57:59 2001
+++ linux-fixed/drivers/char/Makefile	Tue Oct 23 13:12:07 2001
@@ -229,6 +229,7 @@
 obj-$(CONFIG_977_WATCHDOG) += wdt977.o
 obj-$(CONFIG_I810_TCO) += i810-tco.o
 obj-$(CONFIG_MACHZ_WDT) += machzwd.o
+obj-$(CONFIG_QUANCOM) += quancom.o
 obj-$(CONFIG_SH_WDT) += shwdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
 
diff -rNu linux/drivers/char/quancom.c linux-fixed/drivers/char/quancom.c
--- linux/drivers/char/quancom.c	Thu Jan  1 01:00:00 1970
+++ linux-fixed/drivers/char/quancom.c	Tue Oct 23 13:12:07 2001
@@ -0,0 +1,285 @@
+/*
+ * Quancom WATCHDOG1/2 driver (www.quancom.de)
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <linux/fcntl.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+
+static int wdog_is_open=0;
+
+/*
+ *	You must set these - there is no sane way to probe for this board.
+ *	You can use wdt=x to set these now.
+ */
+ 
+static int io=0x1d0;
+
+#define DRIVER_VERSION 1
+#define DRIVER_REVISION 02
+
+#ifndef MODULE
+
+/**
+ *	wdog_setup:
+ *	@str: command line string
+ *
+ *	Setup options. The board isn't really probe-able so we have to
+ *	get the user to tell us the configuration. Sane people build it 
+ *	modular but the others come here.
+ */
+ 
+static int __init wdog_setup(char *str)
+{
+	int ints[4];
+
+	str = get_options (str, ARRAY_SIZE(ints), ints);
+
+	if (ints[0] > 0)
+	{
+		io = ints[1];
+	}
+
+	return 1;
+}
+
+__setup("wdt=", wdog_setup);
+
+#endif /* !MODULE */
+
+MODULE_PARM(io, "i");
+MODULE_PARM_DESC(io, "WDT io port (default=0x1d0)");
+ 
+/*
+ *	Kernel methods.
+ */
+
+static ssize_t wdog_read(struct file * file, char * buf, size_t count,
+	loff_t * ppos)
+{
+	/* No can do */
+	return -EINVAL;
+}
+
+static int wdog_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+	unsigned long arg) 
+{
+	/* No can do */
+	return -EINVAL;
+}
+
+/**
+ *	wdog_write:
+ *	@file: file handle to the watchdog
+ *	@buf: buffer to write (unused as data does not matter here 
+ *	@count: count of bytes
+ *	@ppos: pointer to the position to write. No seeks allowed
+ *
+ *	A write to a watchdog device is defined as a keepalive signal. Any
+ *	write of data will do, as we we don't define content meaning.
+ */
+ 
+static ssize_t wdog_write(struct file *file, const char *buf, size_t count, lof
f_t *ppos)
+{
+	/*  Can't seek (pwrite) on this device  */
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	if(count)
+	{
+		outb_p(0x00,io);
+		return 1;
+	}
+	return 0;
+}
+
+/**
+ *	wdog_open:
+ *	@inode: inode of device
+ *	@file: file handle to device
+ *
+ *	One of our two misc devices has been opened. The watchdog device is
+ *	single open and on opening we load the counters. Counter zero is a 
+ *	100Hz cascade, into counter 1 which downcounts to reboot. When the
+ *	counter triggers counter 2 downcounts the length of the reset pulse
+ *	which set set to be as long as possible. 
+ */
+ 
+static int wdog_open(struct inode *inode, struct file *file)
+{
+	switch(MINOR(inode->i_rdev))
+	{
+		case WATCHDOG_MINOR:
+			if(wdog_is_open)
+				return -EBUSY;
+			/*
+			 *	Activate 
+			 */
+	 
+			wdog_is_open=1;
+			outb_p(0x00,io);
+			return 0;
+		default:
+			return -ENODEV;
+	}
+}
+
+/**
+ *	wdog_close:
+ *	@inode: inode to board
+ *	@file: file handle to board
+ *
+ *	The watchdog has a configurable API. There is a religious dispute 
+ *	between people who want their watchdog to be able to shut down and 
+ *	those who want to be sure if the watchdog manager dies the machine
+ *	reboots. In the former case we disable the counters, in the latter
+ *	case you have to open it again very soon.
+ */
+ 
+static int wdog_release(struct inode *inode, struct file *file)
+{
+	lock_kernel();
+	if(MINOR(inode->i_rdev)==WATCHDOG_MINOR)
+	{
+#ifndef CONFIG_WATCHDOG_NOWAYOUT	
+		outb_p(0x00,io+1);
+#endif		
+		wdog_is_open=0;
+	}
+	unlock_kernel();
+	return 0;
+}
+
+/**
+ *	notify_sys:
+ *	@this: our notifier block
+ *	@code: the event being reported
+ *	@unused: unused
+ *
+ *	Our notifier is called on system shutdowns. We want to turn the card
+ *	off at reboot otherwise the machine will reboot again during memory
+ *	test or worse yet during the following fsck. This would suck, in fact
+ *	trust me - if it happens it does suck.
+ */
+
+static int wdog_notify_sys(struct notifier_block *this, unsigned long code,
+	void *unused)
+{
+	if(code==SYS_DOWN || code==SYS_HALT)
+	{
+		outb_p(0x00,io+1);
+	}
+	return NOTIFY_DONE;
+}
+ 
+/*
+ *	Kernel Interfaces
+ */
+ 
+ 
+static struct file_operations wdog_fops = {
+	owner:		THIS_MODULE,
+	llseek:		no_llseek,
+	read:		wdog_read,
+	write:		wdog_write,
+	ioctl:		wdog_ioctl,
+	open:		wdog_open,
+	release:	wdog_release,
+};
+
+static struct miscdevice wdog_miscdev=
+{
+	WATCHDOG_MINOR,
+	"watchdog",
+	&wdog_fops
+};
+
+/*
+ *	The WDT card needs to learn about soft shutdowns in order to
+ *	turn the timebomb registers off. 
+ */
+ 
+static struct notifier_block wdog_notifier=
+{
+	wdog_notify_sys,
+	NULL,
+	0
+};
+
+/**
+ *	cleanup_module:
+ *
+ *	Unload the watchdog. You cannot do this with any file handles open.
+ *	If your watchdog is set to continue ticking on close and you unload
+ *	it, well it keeps ticking. We won't get the interrupt but the board
+ *	will not touch PC memory so all is fine. You just have to load a new
+ *	module in 60 seconds or reboot.
+ */
+ 
+static void __exit wdog_exit(void)
+{
+	misc_deregister(&wdog_miscdev);
+	unregister_reboot_notifier(&wdog_notifier);
+	release_region(io,16);
+}
+
+/**
+ * 	wdog_init:
+ *
+ *	Set up the WDT watchdog board. All we have to do is grab the
+ *	resources we require and bitch if anyone beat us to them.
+ *	The open() function will actually kick the board off.
+ */
+ 
+static int __init wdog_init(void)
+{
+	int ret;
+
+	ret = misc_register(&wdog_miscdev);
+	if (ret) {
+		printk(KERN_ERR "wdt: can't misc_register on minor=%d\n", WATCHDOG_MINOR);
+		goto out;
+	}
+	if (!request_region(io, 16, "Watchdog1/2")) {
+		printk(KERN_ERR "wdt: IO %X is not free.\n", io);
+		ret = -EBUSY;
+		goto outmisc;
+	}
+	ret = register_reboot_notifier(&wdog_notifier);
+	if(ret) {
+		printk(KERN_ERR "wdt: can't register reboot notifier (err=%d)\n", ret);
+		goto outreg;
+	}
+
+	ret = 0;
+	printk(KERN_INFO "Quancom Watchdog1/2 driver v%d.%02d at 0x%X\n",
+		DRIVER_VERSION, DRIVER_REVISION, io);
+out:
+	return ret;
+
+outreg:
+	release_region(io,16);
+outmisc:
+	misc_deregister(&wdog_miscdev);
+	goto out;
+}
+
+module_init(wdog_init);
+module_exit(wdog_exit);
+

--_=XFMail.1.4.6-3.Linux:20011023132005:5243=_--
End of MIME message
