Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUCUTvr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 14:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbUCUTvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 14:51:47 -0500
Received: from astra.telenet-ops.be ([195.130.132.58]:8131 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261162AbUCUTt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 14:49:27 -0500
Date: Sun, 21 Mar 2004 20:48:57 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] v2.6.5-rc2 watchdog-patches
Message-ID: <20040321204857.W30061@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog

This will update the following files:

 drivers/char/watchdog/pcwd.c    |  220 +++++++++------
 drivers/char/watchdog/softdog.c |  137 +++++++--
 drivers/char/watchdog/wd501p.h  |   59 ----
 drivers/char/watchdog/wdt.c     |  467 ++++++++++++++++++++-------------
 drivers/char/watchdog/wdt_pci.c |  560 ++++++++++++++++++++++++----------------
 5 files changed, 866 insertions(+), 577 deletions(-)

through these ChangeSets:

<wim@iguana.be> (04/03/21 1.1828)
   [WATCHDOG] v2.6.5-rc2 wdt.c-patch
   
   Version 0.10 of wdt.c - Changes that were made are:
   * Extract the start code in a seperate function (wdt_start)
   * Extract the stop code in a seperate function (wdt_stop)
   * Convert wdt_ping so that it return an int value (0=succes).
   * Extract the get_temperature code in a seperate function (wdt_get_temperature)
   * Make /dev/watchdog and /dev/temperature to different misc devices with their own fops.
   * Reorganize init and exit functions
   * Make heartbeat (the emulated heartbeat) a module parameter
   * Rewrite status flag code so that we could add a new tachometer module parameter
   * Small clean-up's

<wim@iguana.be> (04/03/21 1.1829)
   [WATCHDOG] v2.6.5-rc2 wdt_pci.c-patch
   
   Version 0.10 of wdt_pci.c - Changes that were made are:
   * Extract the start code in a seperate function (wdtpci_start)
   * Extract the stop code in a seperate function (wdtpci_stop)
   * Convert wdtpci_ping so that it return an int value (0=succes).
   * Extract the get_temperature code in a seperate function (wdtpci_get_temperature)
   * Make /dev/watchdog and /dev/temperature to different misc devices with their own fops.
   * Reorganize init and exit functions
   * Make heartbeat (the emulated heartbeat) a module parameter
   * Rewrite status flag code so that we could add a new tachometer module parameter
      + make clear distinction between PCI-WDT500 and PCI-WDT501.
   * Small clean-up's

<wim@iguana.be> (04/03/21 1.1830)
   [WATCHDOG] v2.6.5-rc2 wd501p.h-patch
   
   Cleanup header file after changes to wdt.c and wdt_pci.c

<wim@iguana.be> (04/03/21 1.1831)
   [WATCHDOG] v2.6.5-rc2 softdog.c-patch
   
   Version 0.07 of softdog.c - Changes that were made are:
   * Extract the start/keepalive code in a seperate function (softdog_keepalive)
   * Extract the stop code in a seperate function (softdog_stop)
   * Add notifier support
   * Extract softdog_set_heartbeat code to seperate subroutine
   * Small clean-up's

<wim@iguana.be> (04/03/21 1.1832)
   [WATCHDOG] v2.6.5-rc2 pcwd.c-patch1
   
   Version 1.14 of pcwd.c - Changes that were made are:
   * Extract the start code in a seperate function (pcwd_start)
   * Extract the stop code in a seperate function (pcwd_stop)
   * Extract the get_temperature code in a seperate function (pcwd_get_temperature)
   * Make /dev/watchdog and /dev/temperature to different misc devices with their own fops
   * Small clean-up's
   
   Tested on pcwd card with temperature option.


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/wdt.c b/drivers/char/watchdog/wdt.c
--- a/drivers/char/watchdog/wdt.c	Sun Mar 21 20:40:34 2004
+++ b/drivers/char/watchdog/wdt.c	Sun Mar 21 20:40:34 2004
@@ -1,5 +1,5 @@
 /*
- *	Industrial Computer Source WDT500/501 driver for Linux 2.1.x
+ *	Industrial Computer Source WDT500/501 driver
  *
  *	(c) Copyright 1996-1997 Alan Cox <alan@redhat.com>, All Rights Reserved.
  *				http://www.redhat.com
@@ -15,7 +15,7 @@
  *
  *	(c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
  *
- *	Release 0.09.
+ *	Release 0.10.
  *
  *	Fixes
  *		Dave Gregorich	:	Modularisation and minor bugs
@@ -53,17 +53,15 @@
 static char expect_close;
 
 /*
- *	You must set these - there is no sane way to probe for this board.
- *	You can use wdt=x,y to set these now.
+ *	Module parameters
  */
 
-static int io=0x240;
-static int irq=11;
+#define WD_TIMO 60			/* Default heartbeat = 60 seconds */
 
-/* Default margin */
-#define WD_TIMO (100*60)		/* 1 minute */
-
-static int wd_margin = WD_TIMO;
+static int heartbeat = WD_TIMO;
+static int wd_heartbeat;
+module_param(heartbeat, int, 0);
+MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. (0<heartbeat<65536, default=" __MODULE_STRING(WD_TIMO) ")");
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 static int nowayout = 1;
@@ -74,11 +72,23 @@
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
+/* You must set these - there is no sane way to probe for this board. */
+static int io=0x240;
+static int irq=11;
+
 module_param(io, int, 0);
 MODULE_PARM_DESC(io, "WDT io port (default=0x240)");
 module_param(irq, int, 0);
 MODULE_PARM_DESC(irq, "WDT irq (default=11)");
 
+#ifdef CONFIG_WDT_501
+/* Support for the Fan Tachometer on the WDT501-P */
+static int tachometer;
+
+module_param(tachometer, int, 0);
+MODULE_PARM_DESC(tachometer, "WDT501-P Fan Tachometer support (0=disable, default=0)");
+#endif /* CONFIG_WDT_501 */
+
 /*
  *	Programming support
  */
@@ -97,13 +107,77 @@
 	outb_p(val>>8, WDT_COUNT0+ctr);
 }
 
-/*
- *	Kernel methods.
+/**
+ *	wdt_start:
+ *
+ *	Start the watchdog driver.
+ */
+
+static int wdt_start(void)
+{
+	inb_p(WDT_DC);			/* Disable watchdog */
+	wdt_ctr_mode(0,3);		/* Program CTR0 for Mode 3: Square Wave Generator */
+	wdt_ctr_mode(1,2);		/* Program CTR1 for Mode 2: Rate Generator */
+	wdt_ctr_mode(2,0);		/* Program CTR2 for Mode 0: Pulse on Terminal Count */
+	wdt_ctr_load(0, 8948);		/* Count at 100Hz */
+	wdt_ctr_load(1,wd_heartbeat);	/* Heartbeat */
+	wdt_ctr_load(2,65535);		/* Length of reset pulse */
+	outb_p(0, WDT_DC);		/* Enable watchdog */
+	return 0;
+}
+
+/**
+ *	wdt_stop:
+ *
+ *	Stop the watchdog driver.
+ */
+
+static int wdt_stop (void)
+{
+	/* Turn the card off */
+	inb_p(WDT_DC);			/* Disable watchdog */
+	wdt_ctr_load(2,0);		/* 0 length reset pulses now */
+	return 0;
+}
+
+/**
+ *	wdt_ping:
+ *
+ *	Reload counter one with the watchdog heartbeat. We don't bother reloading
+ *	the cascade counter.
  */
 
+static int wdt_ping(void)
+{
+	/* Write a watchdog value */
+	inb_p(WDT_DC);			/* Disable watchdog */
+	wdt_ctr_mode(1,2);		/* Re-Program CTR1 for Mode 2: Rate Generator */
+	wdt_ctr_load(1,wd_heartbeat);	/* Heartbeat */
+	outb_p(0, WDT_DC);		/* Enable watchdog */
+	return 0;
+}
 
 /**
- *	wdt_status:
+ *	wdt_set_heartbeat:
+ *	@t:		the new heartbeat value that needs to be set.
+ *
+ *	Set a new heartbeat value for the watchdog device. If the heartbeat value is
+ *	incorrect we keep the old value and return -EINVAL. If successfull we
+ *	return 0.
+ */
+static int wdt_set_heartbeat(int t)
+{
+	if ((t < 1) || (t > 65535))
+		return -EINVAL;
+
+	heartbeat = t;
+	wd_heartbeat = t * 100;
+	return 0;
+}
+
+/**
+ *	wdt_get_status:
+ *	@status:		the new status.
  *
  *	Extract the status information from a WDT watchdog device. There are
  *	several board variants so we have to know which bits are valid. Some
@@ -112,31 +186,46 @@
  *	we then map the bits onto the status ioctl flags.
  */
 
-static int wdt_status(void)
+static int wdt_get_status(int *status)
 {
-	/*
-	 *	Status register to bit flags
-	 */
+	unsigned char new_status=inb_p(WDT_SR);
 
-	int flag=0;
-	unsigned char status=inb_p(WDT_SR);
-	status|=FEATUREMAP1;
-	status&=~FEATUREMAP2;
+	*status=0;
+	if (new_status & WDC_SR_ISOI0)
+		*status |= WDIOF_EXTERN1;
+	if (new_status & WDC_SR_ISII1)
+		*status |= WDIOF_EXTERN2;
+#ifdef CONFIG_WDT_501
+	if (!(new_status & WDC_SR_TGOOD))
+		*status |= WDIOF_OVERHEAT;
+	if (!(new_status & WDC_SR_PSUOVER))
+		*status |= WDIOF_POWEROVER;
+	if (!(new_status & WDC_SR_PSUUNDR))
+		*status |= WDIOF_POWERUNDER;
+	if (tachometer) {
+		if (!(new_status & WDC_SR_FANGOOD))
+			*status |= WDIOF_FANFAULT;
+	}
+#endif /* CONFIG_WDT_501 */
+	return 0;
+}
 
-	if(!(status&WDC_SR_TGOOD))
-		flag|=WDIOF_OVERHEAT;
-	if(!(status&WDC_SR_PSUOVER))
-		flag|=WDIOF_POWEROVER;
-	if(!(status&WDC_SR_PSUUNDR))
-		flag|=WDIOF_POWERUNDER;
-	if(!(status&WDC_SR_FANGOOD))
-		flag|=WDIOF_FANFAULT;
-	if(status&WDC_SR_ISOI0)
-		flag|=WDIOF_EXTERN1;
-	if(status&WDC_SR_ISII1)
-		flag|=WDIOF_EXTERN2;
-	return flag;
+#ifdef CONFIG_WDT_501
+/**
+ *	wdt_get_temperature:
+ *
+ *	Reports the temperature in degrees Fahrenheit. The API is in
+ *	farenheit. It was designed by an imperial measurement luddite.
+ */
+
+static int wdt_get_temperature(int *temperature)
+{
+	unsigned short c=inb_p(WDT_RT);
+
+	*temperature = (c * 11 / 15) + 7;
+	return 0;
 }
+#endif /* CONFIG_WDT_501 */
 
 /**
  *	wdt_interrupt:
@@ -155,23 +244,23 @@
 	 *	Read the status register see what is up and
 	 *	then printk it.
 	 */
-
 	unsigned char status=inb_p(WDT_SR);
 
-	status|=FEATUREMAP1;
-	status&=~FEATUREMAP2;
-
 	printk(KERN_CRIT "WDT status %d\n", status);
 
-	if(!(status&WDC_SR_TGOOD))
+#ifdef CONFIG_WDT_501
+	if (!(status & WDC_SR_TGOOD))
 		printk(KERN_CRIT "Overheat alarm.(%d)\n",inb_p(WDT_RT));
-	if(!(status&WDC_SR_PSUOVER))
+	if (!(status & WDC_SR_PSUOVER))
 		printk(KERN_CRIT "PSU over voltage.\n");
-	if(!(status&WDC_SR_PSUUNDR))
+	if (!(status & WDC_SR_PSUUNDR))
 		printk(KERN_CRIT "PSU under voltage.\n");
-	if(!(status&WDC_SR_FANGOOD))
-		printk(KERN_CRIT "Possible fan fault.\n");
-	if(!(status&WDC_SR_WCCR))
+	if (tachometer) {
+		if (!(status & WDC_SR_FANGOOD))
+			printk(KERN_CRIT "Possible fan fault.\n");
+	}
+#endif /* CONFIG_WDT_501 */
+	if (!(status & WDC_SR_WCCR))
 #ifdef SOFTWARE_REBOOT
 #ifdef ONLY_TESTING
 		printk(KERN_CRIT "Would Reboot.\n");
@@ -187,22 +276,6 @@
 
 
 /**
- *	wdt_ping:
- *
- *	Reload counter one with the watchdog timeout. We don't bother reloading
- *	the cascade counter.
- */
-
-static void wdt_ping(void)
-{
-	/* Write a watchdog value */
-	inb_p(WDT_DC);
-	wdt_ctr_mode(1,2);
-	wdt_ctr_load(1,wd_margin);		/* Timeout */
-	outb_p(0, WDT_DC);
-}
-
-/**
  *	wdt_write:
  *	@file: file handle to the watchdog
  *	@buf: buffer to write (unused as data does not matter here
@@ -240,40 +313,6 @@
 }
 
 /**
- *	wdt_read:
- *	@file: file handle to the watchdog board
- *	@buf: buffer to write 1 byte into
- *	@count: length of buffer
- *	@ptr: offset (no seek allowed)
- *
- *	Read reports the temperature in degrees Fahrenheit. The API is in
- *	farenheit. It was designed by an imperial measurement luddite.
- */
-
-static ssize_t wdt_read(struct file *file, char *buf, size_t count, loff_t *ptr)
-{
-	unsigned short c=inb_p(WDT_RT);
-	unsigned char cp;
-
-	/*  Can't seek (pread) on this device  */
-	if (ptr != &file->f_pos)
-		return -ESPIPE;
-
-	switch(iminor(file->f_dentry->d_inode))
-	{
-		case TEMP_MINOR:
-			c*=11;
-			c/=15;
-			cp=c+7;
-			if(copy_to_user(buf,&cp,1))
-				return -EFAULT;
-			return 1;
-		default:
-			return -EINVAL;
-	}
-}
-
-/**
  *	wdt_ioctl:
  *	@inode: inode of the device
  *	@file: file handle to the device
@@ -288,18 +327,25 @@
 static int wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 	unsigned long arg)
 {
-	int new_margin;
+	int new_heartbeat;
+	int status;
 
-	static struct watchdog_info ident=
-	{
-		.options = WDIOF_OVERHEAT|WDIOF_POWERUNDER|WDIOF_POWEROVER
-					|WDIOF_EXTERN1|WDIOF_EXTERN2|WDIOF_FANFAULT
-					|WDIOF_SETTIMEOUT|WDIOF_MAGICCLOSE,
-		.firmware_version = 1,
-		.identity = "WDT500/501",
+	static struct watchdog_info ident = {
+		.options =		WDIOF_SETTIMEOUT|
+					WDIOF_MAGICCLOSE|
+					WDIOF_KEEPALIVEPING,
+		.firmware_version =	1,
+		.identity =		"WDT500/501",
 	};
 
-	ident.options&=WDT_OPTION_MASK;	/* Mask down to the card we have */
+	/* Add options according to the card we have */
+	ident.options |= (WDIOF_EXTERN1|WDIOF_EXTERN2);
+#ifdef CONFIG_WDT_501
+	ident.options |= (WDIOF_OVERHEAT|WDIOF_POWERUNDER|WDIOF_POWEROVER);
+	if (tachometer)
+		ident.options |= WDIOF_FANFAULT;
+#endif /* CONFIG_WDT_501 */
+
 	switch(cmd)
 	{
 		default:
@@ -308,23 +354,24 @@
 			return copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident))?-EFAULT:0;
 
 		case WDIOC_GETSTATUS:
-			return put_user(wdt_status(),(int *)arg);
+			wdt_get_status(&status);
+			return put_user(status,(int *)arg);
 		case WDIOC_GETBOOTSTATUS:
 			return put_user(0, (int *)arg);
 		case WDIOC_KEEPALIVE:
 			wdt_ping();
 			return 0;
 		case WDIOC_SETTIMEOUT:
-			if (get_user(new_margin, (int *)arg))
+			if (get_user(new_heartbeat, (int *)arg))
 				return -EFAULT;
-			/* Arbitrary, can't find the card's limits */
-			if ((new_margin < 0) || (new_margin > 60))
+
+			if (wdt_set_heartbeat(new_heartbeat))
 				return -EINVAL;
-			wd_margin = new_margin * 100;
+
 			wdt_ping();
 			/* Fall */
 		case WDIOC_GETTIMEOUT:
-			return put_user(wd_margin / 100, (int *)arg);
+			return put_user(heartbeat, (int *)arg);
 	}
 }
 
@@ -333,43 +380,26 @@
  *	@inode: inode of device
  *	@file: file handle to device
  *
- *	One of our two misc devices has been opened. The watchdog device is
- *	single open and on opening we load the counters. Counter zero is a
- *	100Hz cascade, into counter 1 which downcounts to reboot. When the
- *	counter triggers counter 2 downcounts the length of the reset pulse
- *	which set set to be as long as possible.
+ *	The watchdog device has been opened. The watchdog device is single
+ *	open and on opening we load the counters. Counter zero is a 100Hz
+ *	cascade, into counter 1 which downcounts to reboot. When the counter
+ *	triggers counter 2 downcounts the length of the reset pulse which
+ *	set set to be as long as possible.
  */
 
 static int wdt_open(struct inode *inode, struct file *file)
 {
-	switch(iminor(inode))
-	{
-		case WATCHDOG_MINOR:
-			if(test_and_set_bit(0, &wdt_is_open))
-				return -EBUSY;
-			/*
-			 *	Activate
-			 */
-
-			wdt_is_open=1;
-			inb_p(WDT_DC);		/* Disable */
-			wdt_ctr_mode(0,3);
-			wdt_ctr_mode(1,2);
-			wdt_ctr_mode(2,0);
-			wdt_ctr_load(0, 8948);		/* count at 100Hz */
-			wdt_ctr_load(1,wd_margin);	/* Timeout 120 seconds */
-			wdt_ctr_load(2,65535);
-			outb_p(0, WDT_DC);	/* Enable */
-			return 0;
-		case TEMP_MINOR:
-			return 0;
-		default:
-			return -ENODEV;
-	}
+	if(test_and_set_bit(0, &wdt_is_open))
+		return -EBUSY;
+	/*
+	 *	Activate
+	 */
+	wdt_start();
+	return 0;
 }
 
 /**
- *	wdt_close:
+ *	wdt_release:
  *	@inode: inode to board
  *	@file: file handle to board
  *
@@ -382,21 +412,74 @@
 
 static int wdt_release(struct inode *inode, struct file *file)
 {
-	if(iminor(inode)==WATCHDOG_MINOR)
-	{
-		if (expect_close == 42) {
-			inb_p(WDT_DC);		/* Disable counters */
-			wdt_ctr_load(2,0);	/* 0 length reset pulses now */
-		} else {
-			printk(KERN_CRIT "wdt: WDT device closed unexpectedly.  WDT will not stop!\n");
-		}
+	if (expect_close == 42) {
+		wdt_stop();
 		clear_bit(0, &wdt_is_open);
-		expect_close = 0;
+	} else {
+		printk(KERN_CRIT "wdt: WDT device closed unexpectedly.  WDT will not stop!\n");
+		wdt_ping();
 	}
+	expect_close = 0;
+	return 0;
+}
+
+#ifdef CONFIG_WDT_501
+/**
+ *	wdt_temp_read:
+ *	@file: file handle to the watchdog board
+ *	@buf: buffer to write 1 byte into
+ *	@count: length of buffer
+ *	@ptr: offset (no seek allowed)
+ *
+ *	Temp_read reports the temperature in degrees Fahrenheit. The API is in
+ *	farenheit. It was designed by an imperial measurement luddite.
+ */
+
+static ssize_t wdt_temp_read(struct file *file, char *buf, size_t count, loff_t *ptr)
+{
+	int temperature;
+
+	/*  Can't seek (pread) on this device  */
+	if (ptr != &file->f_pos)
+		return -ESPIPE;
+
+	if (wdt_get_temperature(&temperature))
+		return -EFAULT;
+
+	if (copy_to_user (buf, &temperature, 1))
+		return -EFAULT;
+
+	return 1;
+}
+
+/**
+ *	wdt_temp_open:
+ *	@inode: inode of device
+ *	@file: file handle to device
+ *
+ *	The temperature device has been opened.
+ */
+
+static int wdt_temp_open(struct inode *inode, struct file *file)
+{
 	return 0;
 }
 
 /**
+ *	wdt_temp_release:
+ *	@inode: inode to board
+ *	@file: file handle to board
+ *
+ *	The temperature device has been closed.
+ */
+
+static int wdt_temp_release(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+#endif /* CONFIG_WDT_501 */
+
+/**
  *	notify_sys:
  *	@this: our notifier block
  *	@code: the event being reported
@@ -411,11 +494,9 @@
 static int wdt_notify_sys(struct notifier_block *this, unsigned long code,
 	void *unused)
 {
-	if(code==SYS_DOWN || code==SYS_HALT)
-	{
+	if(code==SYS_DOWN || code==SYS_HALT) {
 		/* Turn the card off */
-		inb_p(WDT_DC);
-		wdt_ctr_load(2,0);
+		wdt_stop();
 	}
 	return NOTIFY_DONE;
 }
@@ -428,36 +509,40 @@
 static struct file_operations wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.read		= wdt_read,
 	.write		= wdt_write,
 	.ioctl		= wdt_ioctl,
 	.open		= wdt_open,
 	.release	= wdt_release,
 };
 
-static struct miscdevice wdt_miscdev=
-{
+static struct miscdevice wdt_miscdev = {
 	.minor	= WATCHDOG_MINOR,
 	.name	= "watchdog",
 	.fops	= &wdt_fops,
 };
 
 #ifdef CONFIG_WDT_501
-static struct miscdevice temp_miscdev=
-{
+static struct file_operations wdt_temp_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= wdt_temp_read,
+	.open		= wdt_temp_open,
+	.release	= wdt_temp_release,
+};
+
+static struct miscdevice temp_miscdev = {
 	.minor	= TEMP_MINOR,
 	.name	= "temperature",
-	.fops	= &wdt_fops,
+	.fops	= &wdt_temp_fops,
 };
-#endif
+#endif /* CONFIG_WDT_501 */
 
 /*
  *	The WDT card needs to learn about soft shutdowns in order to
  *	turn the timebomb registers off.
  */
 
-static struct notifier_block wdt_notifier=
-{
+static struct notifier_block wdt_notifier = {
 	.notifier_call = wdt_notify_sys,
 };
 
@@ -476,10 +561,10 @@
 	misc_deregister(&wdt_miscdev);
 #ifdef CONFIG_WDT_501
 	misc_deregister(&temp_miscdev);
-#endif
+#endif /* CONFIG_WDT_501 */
 	unregister_reboot_notifier(&wdt_notifier);
-	release_region(io,8);
 	free_irq(irq, NULL);
+	release_region(io,8);
 }
 
 /**
@@ -494,51 +579,67 @@
 {
 	int ret;
 
-	ret = misc_register(&wdt_miscdev);
-	if (ret) {
-		printk(KERN_ERR "wdt: can't misc_register on minor=%d\n", WATCHDOG_MINOR);
+	/* Check that the heartbeat value is within it's range ; if not reset to the default */
+	if (wdt_set_heartbeat(heartbeat)) {
+		wdt_set_heartbeat(WD_TIMO);
+		printk(KERN_INFO "wdt: heartbeat value must be 0<heartbeat<65536, using %d\n",
+			WD_TIMO);
+	}
+
+	if (!request_region(io, 8, "wdt501p")) {
+		printk(KERN_ERR "wdt: I/O address 0x%04x already in use\n", io);
+		ret = -EBUSY;
 		goto out;
 	}
+
 	ret = request_irq(irq, wdt_interrupt, SA_INTERRUPT, "wdt501p", NULL);
 	if(ret) {
 		printk(KERN_ERR "wdt: IRQ %d is not free.\n", irq);
-		goto outmisc;
-	}
-	if (!request_region(io, 8, "wdt501p")) {
-		printk(KERN_ERR "wdt: IO %X is not free.\n", io);
-		ret = -EBUSY;
-		goto outirq;
+		goto outreg;
 	}
+
 	ret = register_reboot_notifier(&wdt_notifier);
 	if(ret) {
-		printk(KERN_ERR "wdt: can't register reboot notifier (err=%d)\n", ret);
-		goto outreg;
+		printk(KERN_ERR "wdt: cannot register reboot notifier (err=%d)\n", ret);
+		goto outirq;
 	}
 
 #ifdef CONFIG_WDT_501
 	ret = misc_register(&temp_miscdev);
 	if (ret) {
-		printk(KERN_ERR "wdt: can't misc_register (temp) on minor=%d\n", TEMP_MINOR);
+		printk(KERN_ERR "wdt: cannot register miscdev on minor=%d (err=%d)\n",
+			TEMP_MINOR, ret);
 		goto outrbt;
 	}
-#endif
+#endif /* CONFIG_WDT_501 */
+
+	ret = misc_register(&wdt_miscdev);
+	if (ret) {
+		printk(KERN_ERR "wdt: cannot register miscdev on minor=%d (err=%d)\n",
+			WATCHDOG_MINOR, ret);
+		goto outmisc;
+	}
 
 	ret = 0;
-	printk(KERN_INFO "WDT500/501-P driver 0.07 at %X (Interrupt %d)\n", io, irq);
+	printk(KERN_INFO "WDT500/501-P driver 0.10 at 0x%04x (Interrupt %d). heartbeat=%d sec (nowayout=%d)\n",
+		io, irq, heartbeat, nowayout);
+#ifdef CONFIG_WDT_501
+	printk(KERN_INFO "wdt: Fan Tachometer is %s\n", (tachometer ? "Enabled" : "Disabled"));
+#endif /* CONFIG_WDT_501 */
+
 out:
 	return ret;
 
+outmisc:
 #ifdef CONFIG_WDT_501
+	misc_deregister(&temp_miscdev);
+#endif /* CONFIG_WDT_501 */
 outrbt:
 	unregister_reboot_notifier(&wdt_notifier);
-#endif
-
-outreg:
-	release_region(io,8);
 outirq:
 	free_irq(irq, NULL);
-outmisc:
-	misc_deregister(&wdt_miscdev);
+outreg:
+	release_region(io,8);
 	goto out;
 }
 
diff -Nru a/drivers/char/watchdog/wdt_pci.c b/drivers/char/watchdog/wdt_pci.c
--- a/drivers/char/watchdog/wdt_pci.c	Sun Mar 21 20:40:57 2004
+++ b/drivers/char/watchdog/wdt_pci.c	Sun Mar 21 20:40:57 2004
@@ -1,5 +1,5 @@
 /*
- *	Industrial Computer Source WDT500/501 driver for Linux 2.1.x
+ *	Industrial Computer Source PCI-WDT500/501 driver
  *
  *	(c) Copyright 1996-1997 Alan Cox <alan@redhat.com>, All Rights Reserved.
  *				http://www.redhat.com
@@ -15,7 +15,7 @@
  *
  *	(c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
  *
- *	Release 0.09.
+ *	Release 0.10.
  *
  *	Fixes
  *		Dave Gregorich	:	Modularisation and minor bugs
@@ -46,6 +46,7 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/fs.h>
 #include <linux/pci.h>
 
 #include <asm/io.h>
@@ -70,6 +71,9 @@
 #define PCI_DEVICE_ID_WDG_CSM 0x22c0
 #endif
 
+/* We can only use 1 card due to the /dev/watchdog restriction */
+static int dev_count;
+
 static struct semaphore open_sem;
 static spinlock_t wdtpci_lock;
 static char expect_close;
@@ -78,10 +82,12 @@
 static int irq;
 
 /* Default timeout */
-#define WD_TIMO (100*60)		/* 1 minute */
-#define WD_TIMO_MAX (WD_TIMO*60)	/* 1 hour(?) */
+#define WD_TIMO 60			/* Default heartbeat = 60 seconds */
 
-static int wd_margin = WD_TIMO;
+static int heartbeat = WD_TIMO;
+static int wd_heartbeat;
+module_param(heartbeat, int, 0);
+MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. (0<heartbeat<65536, default=" __MODULE_STRING(WD_TIMO) ")");
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 static int nowayout = 1;
@@ -92,6 +98,14 @@
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
+#ifdef CONFIG_WDT_501_PCI
+/* Support for the Fan Tachometer on the PCI-WDT501 */
+static int tachometer;
+
+module_param(tachometer, int, 0);
+MODULE_PARM_DESC(tachometer, "PCI-WDT501 Fan Tachometer support (0=disable, default=0)");
+#endif /* CONFIG_WDT_501_PCI */
+
 /*
  *	Programming support
  */
@@ -110,13 +124,105 @@
 	outb_p(val>>8, WDT_COUNT0+ctr);
 }
 
-/*
- *	Kernel methods.
+/**
+ *	wdtpci_start:
+ *
+ *	Start the watchdog driver.
  */
 
+static int wdtpci_start(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdtpci_lock, flags);
+
+	/*
+	 * "pet" the watchdog, as Access says.
+	 * This resets the clock outputs.
+	 */
+	inb_p(WDT_DC);			/* Disable watchdog */
+	wdtpci_ctr_mode(2,0);		/* Program CTR2 for Mode 0: Pulse on Terminal Count */
+	outb_p(0, WDT_DC);		/* Enable watchdog */
+
+	inb_p(WDT_DC);			/* Disable watchdog */
+	outb_p(0, WDT_CLOCK);		/* 2.0833MHz clock */
+	inb_p(WDT_BUZZER);		/* disable */
+	inb_p(WDT_OPTONOTRST);		/* disable */
+	inb_p(WDT_OPTORST);		/* disable */
+	inb_p(WDT_PROGOUT);		/* disable */
+	wdtpci_ctr_mode(0,3);		/* Program CTR0 for Mode 3: Square Wave Generator */
+	wdtpci_ctr_mode(1,2);		/* Program CTR1 for Mode 2: Rate Generator */
+	wdtpci_ctr_mode(2,1);		/* Program CTR2 for Mode 1: Retriggerable One-Shot */
+	wdtpci_ctr_load(0,20833);	/* count at 100Hz */
+	wdtpci_ctr_load(1,wd_heartbeat);/* Heartbeat */
+	/* DO NOT LOAD CTR2 on PCI card! -- JPN */
+	outb_p(0, WDT_DC);		/* Enable watchdog */
+
+	spin_unlock_irqrestore(&wdtpci_lock, flags);
+	return 0;
+}
+
+/**
+ *	wdtpci_stop:
+ *
+ *	Stop the watchdog driver.
+ */
+
+static int wdtpci_stop (void)
+{
+	unsigned long flags;
+
+	/* Turn the card off */
+	spin_lock_irqsave(&wdtpci_lock, flags);
+	inb_p(WDT_DC);			/* Disable watchdog */
+	wdtpci_ctr_load(2,0);		/* 0 length reset pulses now */
+	spin_unlock_irqrestore(&wdtpci_lock, flags);
+	return 0;
+}
+
+/**
+ *	wdtpci_ping:
+ *
+ *	Reload counter one with the watchdog heartbeat. We don't bother reloading
+ *	the cascade counter.
+ */
+
+static int wdtpci_ping(void)
+{
+	unsigned long flags;
+
+	/* Write a watchdog value */
+	spin_lock_irqsave(&wdtpci_lock, flags);
+	inb_p(WDT_DC);			/* Disable watchdog */
+	wdtpci_ctr_mode(1,2);		/* Re-Program CTR1 for Mode 2: Rate Generator */
+	wdtpci_ctr_load(1,wd_heartbeat);/* Heartbeat */
+	outb_p(0, WDT_DC);		/* Enable watchdog */
+	spin_unlock_irqrestore(&wdtpci_lock, flags);
+	return 0;
+}
+
+/**
+ *	wdtpci_set_heartbeat:
+ *	@t:		the new heartbeat value that needs to be set.
+ *
+ *	Set a new heartbeat value for the watchdog device. If the heartbeat value is
+ *	incorrect we keep the old value and return -EINVAL. If successfull we
+ *	return 0.
+ */
+static int wdtpci_set_heartbeat(int t)
+{
+	/* Arbitrary, can't find the card's limits */
+	if ((t < 1) || (t > 65535))
+		return -EINVAL;
+
+	heartbeat = t;
+	wd_heartbeat = t * 100;
+	return 0;
+}
 
 /**
- *	wdtpci_status:
+ *	wdtpci_get_status:
+ *	@status:		the new status.
  *
  *	Extract the status information from a WDT watchdog device. There are
  *	several board variants so we have to know which bits are valid. Some
@@ -125,31 +231,46 @@
  *	we then map the bits onto the status ioctl flags.
  */
 
-static int wdtpci_status(void)
+static int wdtpci_get_status(int *status)
 {
-	/*
-	 *	Status register to bit flags
-	 */
+	unsigned char new_status=inb_p(WDT_SR);
 
-	int flag=0;
-	unsigned char status=inb_p(WDT_SR);
-	status|=FEATUREMAP1;
-	status&=~FEATUREMAP2;
+	*status=0;
+	if (new_status & WDC_SR_ISOI0)
+		*status |= WDIOF_EXTERN1;
+	if (new_status & WDC_SR_ISII1)
+		*status |= WDIOF_EXTERN2;
+#ifdef CONFIG_WDT_501_PCI
+	if (!(new_status & WDC_SR_TGOOD))
+		*status |= WDIOF_OVERHEAT;
+	if (!(new_status & WDC_SR_PSUOVER))
+		*status |= WDIOF_POWEROVER;
+	if (!(new_status & WDC_SR_PSUUNDR))
+		*status |= WDIOF_POWERUNDER;
+	if (tachometer) {
+		if (!(new_status & WDC_SR_FANGOOD))
+			*status |= WDIOF_FANFAULT;
+	}
+#endif /* CONFIG_WDT_501_PCI */
+	return 0;
+}
 
-	if(!(status&WDC_SR_TGOOD))
-		flag|=WDIOF_OVERHEAT;
-	if(!(status&WDC_SR_PSUOVER))
-		flag|=WDIOF_POWEROVER;
-	if(!(status&WDC_SR_PSUUNDR))
-		flag|=WDIOF_POWERUNDER;
-	if(!(status&WDC_SR_FANGOOD))
-		flag|=WDIOF_FANFAULT;
-	if(status&WDC_SR_ISOI0)
-		flag|=WDIOF_EXTERN1;
-	if(status&WDC_SR_ISII1)
-		flag|=WDIOF_EXTERN2;
-	return flag;
+#ifdef CONFIG_WDT_501_PCI
+/**
+ *	wdtpci_get_temperature:
+ *
+ *	Reports the temperature in degrees Fahrenheit. The API is in
+ *	farenheit. It was designed by an imperial measurement luddite.
+ */
+
+static int wdtpci_get_temperature(int *temperature)
+{
+	unsigned short c=inb_p(WDT_RT);
+
+	*temperature = (c * 11 / 15) + 7;
+	return 0;
 }
+#endif /* CONFIG_WDT_501_PCI */
 
 /**
  *	wdtpci_interrupt:
@@ -168,58 +289,38 @@
 	 *	Read the status register see what is up and
 	 *	then printk it.
 	 */
-
 	unsigned char status=inb_p(WDT_SR);
 
-	status|=FEATUREMAP1;
-	status&=~FEATUREMAP2;
-
-	printk(KERN_CRIT "WDT status %d\n", status);
+	printk(KERN_CRIT PFX "status %d\n", status);
 
-	if(!(status&WDC_SR_TGOOD))
-		printk(KERN_CRIT "Overheat alarm.(%d)\n",inb_p(WDT_RT));
-	if(!(status&WDC_SR_PSUOVER))
-		printk(KERN_CRIT "PSU over voltage.\n");
-	if(!(status&WDC_SR_PSUUNDR))
-		printk(KERN_CRIT "PSU under voltage.\n");
-	if(!(status&WDC_SR_FANGOOD))
-		printk(KERN_CRIT "Possible fan fault.\n");
-	if(!(status&WDC_SR_WCCR))
+#ifdef CONFIG_WDT_501_PCI
+	if (!(status & WDC_SR_TGOOD))
+ 		printk(KERN_CRIT PFX "Overheat alarm.(%d)\n",inb_p(WDT_RT));
+	if (!(status & WDC_SR_PSUOVER))
+ 		printk(KERN_CRIT PFX "PSU over voltage.\n");
+	if (!(status & WDC_SR_PSUUNDR))
+ 		printk(KERN_CRIT PFX "PSU under voltage.\n");
+	if (tachometer) {
+		if (!(status & WDC_SR_FANGOOD))
+			printk(KERN_CRIT PFX "Possible fan fault.\n");
+	}
+#endif /* CONFIG_WDT_501_PCI */
+	if (!(status&WDC_SR_WCCR))
 #ifdef SOFTWARE_REBOOT
 #ifdef ONLY_TESTING
-		printk(KERN_CRIT "Would Reboot.\n");
+		printk(KERN_CRIT PFX "Would Reboot.\n");
 #else
-		printk(KERN_CRIT "Initiating system reboot.\n");
+		printk(KERN_CRIT PFX "Initiating system reboot.\n");
 		machine_restart(NULL);
 #endif
 #else
-		printk(KERN_CRIT "Reset in 5ms.\n");
+		printk(KERN_CRIT PFX "Reset in 5ms.\n");
 #endif
 	return IRQ_HANDLED;
 }
 
 
 /**
- *	wdtpci_ping:
- *
- *	Reload counter one with the watchdog timeout. We don't bother reloading
- *	the cascade counter.
- */
-
-static void wdtpci_ping(void)
-{
-	unsigned long flags;
-
-	/* Write a watchdog value */
-	spin_lock_irqsave(&wdtpci_lock, flags);
-	inb_p(WDT_DC);
-	wdtpci_ctr_mode(1,2);
-	wdtpci_ctr_load(1,wd_margin);		/* Timeout */
-	outb_p(0, WDT_DC);
-	spin_unlock_irqrestore(&wdtpci_lock, flags);
-}
-
-/**
  *	wdtpci_write:
  *	@file: file handle to the watchdog
  *	@buf: buffer to write (unused as data does not matter here
@@ -257,40 +358,6 @@
 }
 
 /**
- *	wdtpci_read:
- *	@file: file handle to the watchdog board
- *	@buf: buffer to write 1 byte into
- *	@count: length of buffer
- *	@ptr: offset (no seek allowed)
- *
- *	Read reports the temperature in degrees Fahrenheit. The API is in
- *	fahrenheit. It was designed by an imperial measurement luddite.
- */
-
-static ssize_t wdtpci_read(struct file *file, char *buf, size_t count, loff_t *ptr)
-{
-	unsigned short c=inb_p(WDT_RT);
-	unsigned char cp;
-
-	/*  Can't seek (pread) on this device  */
-	if (ptr != &file->f_pos)
-		return -ESPIPE;
-
-	switch(iminor(file->f_dentry->d_inode))
-	{
-		case TEMP_MINOR:
-			c*=11;
-			c/=15;
-			cp=c+7;
-			if(copy_to_user(buf,&cp,1))
-				return -EFAULT;
-			return 1;
-		default:
-			return -EINVAL;
-	}
-}
-
-/**
  *	wdtpci_ioctl:
  *	@inode: inode of the device
  *	@file: file handle to the device
@@ -305,17 +372,25 @@
 static int wdtpci_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 	unsigned long arg)
 {
-	int new_margin;
+	int new_heartbeat;
+	int status;
+
 	static struct watchdog_info ident = {
-		.options	= WDIOF_OVERHEAT  | WDIOF_POWERUNDER |
-				  WDIOF_POWEROVER | WDIOF_EXTERN1 |
-				  WDIOF_EXTERN2   | WDIOF_FANFAULT |
-				  WDIOF_SETTIMEOUT|WDIOF_MAGICCLOSE,
-		.firmware_version = 1,
-		.identity	  = "WDT500/501PCI",
+		.options =		WDIOF_SETTIMEOUT|
+					WDIOF_MAGICCLOSE|
+					WDIOF_KEEPALIVEPING,
+		.firmware_version =	1,
+		.identity =		"PCI-WDT500/501",
 	};
 
-	ident.options&=WDT_OPTION_MASK;	/* Mask down to the card we have */
+	/* Add options according to the card we have */
+	ident.options |= (WDIOF_EXTERN1|WDIOF_EXTERN2);
+#ifdef CONFIG_WDT_501_PCI
+	ident.options |= (WDIOF_OVERHEAT|WDIOF_POWERUNDER|WDIOF_POWEROVER);
+	if (tachometer)
+		ident.options |= WDIOF_FANFAULT;
+#endif /* CONFIG_WDT_501_PCI */
+
 	switch(cmd)
 	{
 		default:
@@ -324,24 +399,24 @@
 			return copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident))?-EFAULT:0;
 
 		case WDIOC_GETSTATUS:
-			return put_user(wdtpci_status(),(int *)arg);
+			wdtpci_get_status(&status);
+			return put_user(status,(int *)arg);
 		case WDIOC_GETBOOTSTATUS:
 			return put_user(0, (int *)arg);
 		case WDIOC_KEEPALIVE:
 			wdtpci_ping();
 			return 0;
 		case WDIOC_SETTIMEOUT:
-			if (get_user(new_margin, (int *)arg))
+			if (get_user(new_heartbeat, (int *)arg))
 				return -EFAULT;
-			/* Arbitrary, can't find the card's limits */
-			new_margin *= 100;
-			if ((new_margin < 0) || (new_margin > WD_TIMO_MAX))
+
+			if (wdtpci_set_heartbeat(new_heartbeat))
 				return -EINVAL;
-			wd_margin = new_margin;
+
 			wdtpci_ping();
 			/* Fall */
 		case WDIOC_GETTIMEOUT:
-			return put_user(wd_margin / 100, (int *)arg);
+			return put_user(heartbeat, (int *)arg);
 	}
 }
 
@@ -350,66 +425,30 @@
  *	@inode: inode of device
  *	@file: file handle to device
  *
- *	One of our two misc devices has been opened. The watchdog device is
- *	single open and on opening we load the counters. Counter zero is a
- *	100Hz cascade, into counter 1 which downcounts to reboot. When the
- *	counter triggers counter 2 downcounts the length of the reset pulse
- *	which set set to be as long as possible.
+ *	The watchdog device has been opened. The watchdog device is single
+ *	open and on opening we load the counters. Counter zero is a 100Hz
+ *	cascade, into counter 1 which downcounts to reboot. When the counter
+ *	triggers counter 2 downcounts the length of the reset pulse which
+ *	set set to be as long as possible.
  */
 
 static int wdtpci_open(struct inode *inode, struct file *file)
 {
-	unsigned long flags;
+	if (down_trylock(&open_sem))
+		return -EBUSY;
 
-	switch(iminor(inode))
-	{
-		case WATCHDOG_MINOR:
-			if (down_trylock(&open_sem))
-				return -EBUSY;
-
-			if (nowayout) {
-				__module_get(THIS_MODULE);
-			}
-			/*
-			 *	Activate
-			 */
-			spin_lock_irqsave(&wdtpci_lock, flags);
-
-			inb_p(WDT_DC);		/* Disable */
-
-			/*
-			 * "pet" the watchdog, as Access says.
-			 * This resets the clock outputs.
-			 */
-
-			wdtpci_ctr_mode(2,0);
-			outb_p(0, WDT_DC);
-
-			inb_p(WDT_DC);
-
-			outb_p(0, WDT_CLOCK);	/* 2.0833MHz clock */
-			inb_p(WDT_BUZZER);	/* disable */
-			inb_p(WDT_OPTONOTRST);	/* disable */
-			inb_p(WDT_OPTORST);	/* disable */
-			inb_p(WDT_PROGOUT);	/* disable */
-			wdtpci_ctr_mode(0,3);
-			wdtpci_ctr_mode(1,2);
-			wdtpci_ctr_mode(2,1);
-			wdtpci_ctr_load(0,20833);	/* count at 100Hz */
-			wdtpci_ctr_load(1,wd_margin);/* Timeout 60 seconds */
-			/* DO NOT LOAD CTR2 on PCI card! -- JPN */
-			outb_p(0, WDT_DC);	/* Enable */
-			spin_unlock_irqrestore(&wdtpci_lock, flags);
-			return 0;
-		case TEMP_MINOR:
-			return 0;
-		default:
-			return -ENODEV;
+	if (nowayout) {
+		__module_get(THIS_MODULE);
 	}
+	/*
+	 *	Activate
+	 */
+	wdtpci_start();
+	return 0;
 }
 
 /**
- *	wdtpci_close:
+ *	wdtpci_release:
  *	@inode: inode to board
  *	@file: file handle to board
  *
@@ -422,24 +461,73 @@
 
 static int wdtpci_release(struct inode *inode, struct file *file)
 {
-
-	if (iminor(inode)==WATCHDOG_MINOR) {
-		unsigned long flags;
-		if (expect_close == 42) {
-			spin_lock_irqsave(&wdtpci_lock, flags);
-			inb_p(WDT_DC);		/* Disable counters */
-			wdtpci_ctr_load(2,0);	/* 0 length reset pulses now */
-			spin_unlock_irqrestore(&wdtpci_lock, flags);
-		} else {
-			printk(KERN_CRIT PFX "Unexpected close, not stopping timer!");
-			wdtpci_ping();
-		}
-		expect_close = 0;
-		up(&open_sem);
+	if (expect_close == 42) {
+		wdtpci_stop();
+	} else {
+		printk(KERN_CRIT PFX "Unexpected close, not stopping timer!");
+		wdtpci_ping();
 	}
+	expect_close = 0;
+	up(&open_sem);
 	return 0;
 }
 
+#ifdef CONFIG_WDT_501_PCI
+/**
+ *	wdtpci_temp_read:
+ *	@file: file handle to the watchdog board
+ *	@buf: buffer to write 1 byte into
+ *	@count: length of buffer
+ *	@ptr: offset (no seek allowed)
+ *
+ *	Read reports the temperature in degrees Fahrenheit. The API is in
+ *	fahrenheit. It was designed by an imperial measurement luddite.
+ */
+
+static ssize_t wdtpci_temp_read(struct file *file, char *buf, size_t count, loff_t *ptr)
+{
+	int temperature;
+
+	/*  Can't seek (pread) on this device  */
+	if (ptr != &file->f_pos)
+		return -ESPIPE;
+
+	if (wdtpci_get_temperature(&temperature))
+		return -EFAULT;
+
+	if (copy_to_user (buf, &temperature, 1))
+		return -EFAULT;
+
+	return 1;
+}
+
+/**
+ *	wdtpci_temp_open:
+ *	@inode: inode of device
+ *	@file: file handle to device
+ *
+ *	The temperature device has been opened.
+ */
+
+static int wdtpci_temp_open(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+/**
+ *	wdtpci_temp_release:
+ *	@inode: inode to board
+ *	@file: file handle to board
+ *
+ *	The temperature device has been closed.
+ */
+
+static int wdtpci_temp_release(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+#endif /* CONFIG_WDT_501_PCI */
+
 /**
  *	notify_sys:
  *	@this: our notifier block
@@ -455,14 +543,9 @@
 static int wdtpci_notify_sys(struct notifier_block *this, unsigned long code,
 	void *unused)
 {
-	unsigned long flags;
-
 	if (code==SYS_DOWN || code==SYS_HALT) {
 		/* Turn the card off */
-		spin_lock_irqsave(&wdtpci_lock, flags);
-		inb_p(WDT_DC);
-		wdtpci_ctr_load(2,0);
-		spin_unlock_irqrestore(&wdtpci_lock, flags);
+		wdtpci_stop();
 	}
 	return NOTIFY_DONE;
 }
@@ -475,7 +558,6 @@
 static struct file_operations wdtpci_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.read		= wdtpci_read,
 	.write		= wdtpci_write,
 	.ioctl		= wdtpci_ioctl,
 	.open		= wdtpci_open,
@@ -489,12 +571,20 @@
 };
 
 #ifdef CONFIG_WDT_501_PCI
+static struct file_operations wdtpci_temp_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= wdtpci_temp_read,
+	.open		= wdtpci_temp_open,
+	.release	= wdtpci_temp_release,
+};
+
 static struct miscdevice temp_miscdev = {
 	.minor	= TEMP_MINOR,
 	.name	= "temperature",
-	.fops	= &wdtpci_fops,
+	.fops	= &wdtpci_temp_fops,
 };
-#endif
+#endif /* CONFIG_WDT_501_PCI */
 
 /*
  *	The WDT card needs to learn about soft shutdowns in order to
@@ -509,71 +599,96 @@
 static int __devinit wdtpci_init_one (struct pci_dev *dev,
 				   const struct pci_device_id *ent)
 {
-	static int dev_count = 0;
 	int ret = -EIO;
 
 	dev_count++;
 	if (dev_count > 1) {
-		printk (KERN_ERR PFX
-			"this driver only supports 1 device\n");
+		printk (KERN_ERR PFX "this driver only supports 1 device\n");
 		return -ENODEV;
 	}
 
-	if (pci_enable_device (dev))
-		goto out;
+	if (pci_enable_device (dev)) {
+		printk (KERN_ERR PFX "Not possible to enable PCI Device\n");
+		return -ENODEV;
+	}
+
+	if (pci_resource_start (dev, 2) == 0x0000) {
+		printk (KERN_ERR PFX "No I/O-Address for card detected\n");
+		ret = -ENODEV;
+		goto out_pci;
+	}
 
 	sema_init(&open_sem, 1);
 	spin_lock_init(&wdtpci_lock);
 
 	irq = dev->irq;
 	io = pci_resource_start (dev, 2);
-	printk ("WDT501-P(PCI-WDG-CSM) driver 0.07 at %X "
-		"(Interrupt %d)\n", io, irq);
 
-	if (request_region (io, 16, "wdt-pci") == NULL) {
-		printk (KERN_ERR PFX "I/O %d is not free.\n", io);
-		goto out;
+	if (request_region (io, 16, "wdt_pci") == NULL) {
+		printk (KERN_ERR PFX "I/O address 0x%04x already in use\n", io);
+		goto out_pci;
 	}
 
 	if (request_irq (irq, wdtpci_interrupt, SA_INTERRUPT | SA_SHIRQ,
-			 "wdt-pci", &wdtpci_miscdev)) {
-		printk (KERN_ERR PFX "IRQ %d is not free.\n", irq);
+			 "wdt_pci", &wdtpci_miscdev)) {
+		printk (KERN_ERR PFX "IRQ %d is not free\n", irq);
 		goto out_reg;
 	}
 
-	ret = misc_register (&wdtpci_miscdev);
-	if (ret) {
-		printk (KERN_ERR PFX "can't misc_register on minor=%d\n", WATCHDOG_MINOR);
-		goto out_irq;
+	printk ("PCI-WDT500/501 (PCI-WDG-CSM) driver 0.10 at 0x%04x (Interrupt %d)\n",
+		io, irq);
+
+	/* Check that the heartbeat value is within it's range ; if not reset to the default */
+	if (wdtpci_set_heartbeat(heartbeat)) {
+		wdtpci_set_heartbeat(WD_TIMO);
+		printk(KERN_INFO PFX "heartbeat value must be 0<heartbeat<65536, using %d\n",
+			WD_TIMO);
 	}
 
 	ret = register_reboot_notifier (&wdtpci_notifier);
 	if (ret) {
-		printk (KERN_ERR PFX "can't misc_register on minor=%d\n", WATCHDOG_MINOR);
-		goto out_misc;
+		printk (KERN_ERR PFX "cannot register reboot notifier (err=%d)\n", ret);
+		goto out_irq;
 	}
+
 #ifdef CONFIG_WDT_501_PCI
 	ret = misc_register (&temp_miscdev);
 	if (ret) {
-		printk (KERN_ERR PFX "can't misc_register (temp) on minor=%d\n", TEMP_MINOR);
+		printk (KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
+			TEMP_MINOR, ret);
 		goto out_rbt;
 	}
-#endif
+#endif /* CONFIG_WDT_501_PCI */
+
+	ret = misc_register (&wdtpci_miscdev);
+	if (ret) {
+		printk (KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
+			WATCHDOG_MINOR, ret);
+		goto out_misc;
+	}
+
+	printk(KERN_INFO PFX "initialized. heartbeat=%d sec (nowayout=%d)\n",
+		heartbeat, nowayout);
+#ifdef CONFIG_WDT_501_PCI
+	printk(KERN_INFO "wdt: Fan Tachometer is %s\n", (tachometer ? "Enabled" : "Disabled"));
+#endif /* CONFIG_WDT_501_PCI */
 
 	ret = 0;
 out:
 	return ret;
 
+out_misc:
 #ifdef CONFIG_WDT_501_PCI
+	misc_deregister(&temp_miscdev);
+#endif /* CONFIG_WDT_501_PCI */
 out_rbt:
 	unregister_reboot_notifier(&wdtpci_notifier);
-#endif
-out_misc:
-	misc_deregister(&wdtpci_miscdev);
 out_irq:
 	free_irq(irq, &wdtpci_miscdev);
 out_reg:
 	release_region (io, 16);
+out_pci:
+	pci_disable_device(dev);
 	goto out;
 }
 
@@ -582,13 +697,15 @@
 {
 	/* here we assume only one device will ever have
 	 * been picked up and registered by probe function */
-	unregister_reboot_notifier(&wdtpci_notifier);
+	misc_deregister(&wdtpci_miscdev);
 #ifdef CONFIG_WDT_501_PCI
 	misc_deregister(&temp_miscdev);
-#endif
-	misc_deregister(&wdtpci_miscdev);
+#endif /* CONFIG_WDT_501_PCI */
+	unregister_reboot_notifier(&wdtpci_notifier);
 	free_irq(irq, &wdtpci_miscdev);
 	release_region(io, 16);
+	pci_disable_device(pdev);
+	dev_count--;
 }
 
 
@@ -605,7 +722,7 @@
 
 
 static struct pci_driver wdtpci_driver = {
-	.name		= "wdt-pci",
+	.name		= "wdt_pci",
 	.id_table	= wdtpci_pci_tbl,
 	.probe		= wdtpci_init_one,
 	.remove		= __devexit_p(wdtpci_remove_one),
@@ -619,7 +736,7 @@
  *	If your watchdog is set to continue ticking on close and you unload
  *	it, well it keeps ticking. We won't get the interrupt but the board
  *	will not touch PC memory so all is fine. You just have to load a new
- *	module in 60 seconds or reboot.
+ *	module in xx seconds or reboot.
  */
 
 static void __exit wdtpci_cleanup(void)
@@ -638,12 +755,7 @@
 
 static int __init wdtpci_init(void)
 {
-	int rc = pci_register_driver (&wdtpci_driver);
-
-	if (rc < 1)
-		return -ENODEV;
-
-	return 0;
+	return pci_register_driver (&wdtpci_driver);
 }
 
 
@@ -651,7 +763,7 @@
 module_exit(wdtpci_cleanup);
 
 MODULE_AUTHOR("JP Nollmann, Alan Cox");
-MODULE_DESCRIPTION("Driver for the ICS PCI watchdog cards");
+MODULE_DESCRIPTION("Driver for the ICS PCI-WDT500/501 watchdog cards");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
 MODULE_ALIAS_MISCDEV(TEMP_MINOR);
diff -Nru a/drivers/char/watchdog/wd501p.h b/drivers/char/watchdog/wd501p.h
--- a/drivers/char/watchdog/wd501p.h	Sun Mar 21 20:41:21 2004
+++ b/drivers/char/watchdog/wd501p.h	Sun Mar 21 20:41:21 2004
@@ -1,5 +1,5 @@
 /*
- *	Industrial Computer Source WDT500/501 driver for Linux 1.3.x
+ *	Industrial Computer Source WDT500/501 driver
  *
  *	(c) Copyright 1995	CymruNET Ltd
  *				Innovation Centre
@@ -40,52 +40,13 @@
 /* programmable outputs: */
 #define WDT_PROGOUT		(io+15)	/* wr=enable, rd=disable */
 
-#define WDC_SR_WCCR		1	/* Active low */
-#define WDC_SR_TGOOD		2
-#define WDC_SR_ISOI0		4
-#define WDC_SR_ISII1		8
-#define WDC_SR_FANGOOD		16
-#define WDC_SR_PSUOVER		32	/* Active low */
-#define WDC_SR_PSUUNDR		64	/* Active low */
-#define WDC_SR_IRQ		128	/* Active low */
+								/* FAN 501 500 */
+#define WDC_SR_WCCR		1	/* Active low */	/*  X   X   X  */
+#define WDC_SR_TGOOD		2				/*  X   X   -  */
+#define WDC_SR_ISOI0		4				/*  X   X   X  */
+#define WDC_SR_ISII1		8				/*  X   X   X  */
+#define WDC_SR_FANGOOD		16				/*  X   -   -  */
+#define WDC_SR_PSUOVER		32	/* Active low */	/*  X   X   -  */
+#define WDC_SR_PSUUNDR		64	/* Active low */	/*  X   X   -  */
+#define WDC_SR_IRQ		128	/* Active low */	/*  X   X   X  */
 
-#ifndef WDT_IS_PCI
-
-/*
- *	Feature Map 1 is the active high inputs not supported on your card.
- *	Feature Map 2 is the active low inputs not supported on your card.
- */
- 
-#ifdef CONFIG_WDT_501		/* Full board */
-
-#ifdef CONFIG_WDT501_FAN	/* Full board, Fan has no tachometer */
-#define FEATUREMAP1		0
-#define WDT_OPTION_MASK		(WDIOF_OVERHEAT|WDIOF_POWERUNDER|WDIOF_POWEROVER|WDIOF_EXTERN1|WDIOF_EXTERN2|WDIOF_FANFAULT)
-#else
-#define FEATUREMAP1		WDC_SR_FANGOOD
-#define WDT_OPTION_MASK		(WDIOF_OVERHEAT|WDIOF_POWERUNDER|WDIOF_POWEROVER|WDIOF_EXTERN1|WDIOF_EXTERN2)
-#endif
-
-#define FEATUREMAP2		0
-#endif
-
-#ifndef CONFIG_WDT_501
-#define CONFIG_WDT_500
-#endif
-
-#ifdef CONFIG_WDT_500		/* Minimal board */
-#define FEATUREMAP1		(WDC_SR_TGOOD|WDC_SR_FANGOOD)
-#define FEATUREMAP2		(WDC_SR_PSUOVER|WDC_SR_PSUUNDR)
-#define WDT_OPTION_MASK		(WDIOF_OVERHEAT)
-#endif
-
-#else
-
-#define FEATUREMAP1		(WDC_SR_TGOOD|WDC_SR_FANGOOD)
-#define FEATUREMAP2		(WDC_SR_PSUOVER|WDC_SR_PSUUNDR)
-#define WDT_OPTION_MASK		(WDIOF_OVERHEAT)
-#endif
-
-#ifndef FEATUREMAP1
-#error "Config option not set"
-#endif
diff -Nru a/drivers/char/watchdog/softdog.c b/drivers/char/watchdog/softdog.c
--- a/drivers/char/watchdog/softdog.c	Sun Mar 21 20:41:45 2004
+++ b/drivers/char/watchdog/softdog.c	Sun Mar 21 20:41:45 2004
@@ -1,5 +1,5 @@
 /*
- *	SoftDog	0.06:	A Software Watchdog Device
+ *	SoftDog	0.07:	A Software Watchdog Device
  *
  *	(c) Copyright 1996 Alan Cox <alan@redhat.com>, All Rights Reserved.
  *				http://www.redhat.com
@@ -40,26 +40,21 @@
 #include <linux/moduleparam.h>
 #include <linux/config.h>
 #include <linux/types.h>
+#include <linux/timer.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/fs.h>
+#include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <asm/uaccess.h>
 
-#define TIMER_MARGIN	60		/* (secs) Default is 1 minute */
+#define PFX "SoftDog: "
 
-static char expect_close;
+#define TIMER_MARGIN	60		/* Default is 60 seconds */
 static int soft_margin = TIMER_MARGIN;	/* in seconds */
-#ifdef ONLY_TESTING
-static int soft_noboot = 1;
-#else
-static int soft_noboot = 0;
-#endif  /* ONLY_TESTING */
-
 module_param(soft_margin, int, 0);
-module_param(soft_noboot, int, 0);
-MODULE_LICENSE("GPL");
+MODULE_PARM_DESC(soft_margin, "Watchdog soft_margin in seconds. (0<soft_margin<65536, default=" __MODULE_STRING(TIMER_MARGIN) ")");
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 static int nowayout = 1;
@@ -70,6 +65,15 @@
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
+#ifdef ONLY_TESTING
+static int soft_noboot = 1;
+#else
+static int soft_noboot = 0;
+#endif  /* ONLY_TESTING */
+
+module_param(soft_noboot, int, 0);
+MODULE_PARM_DESC(soft_noboot, "Softdog action, set to 1 to ignore reboots, 0 to reboot (default depends on ONLY_TESTING)");
+
 /*
  *	Our timer
  */
@@ -79,6 +83,7 @@
 static struct timer_list watchdog_ticktock =
 		TIMER_INITIALIZER(watchdog_fire, 0, 0);
 static unsigned long timer_alive;
+static char expect_close;
 
 
 /*
@@ -88,17 +93,42 @@
 static void watchdog_fire(unsigned long data)
 {
 	if (soft_noboot)
-		printk(KERN_CRIT "SOFTDOG: Triggered - Reboot ignored.\n");
+		printk(KERN_CRIT PFX "Triggered - Reboot ignored.\n");
 	else
 	{
-		printk(KERN_CRIT "SOFTDOG: Initiating system reboot.\n");
+		printk(KERN_CRIT PFX "Initiating system reboot.\n");
 		machine_restart(NULL);
-		printk("SOFTDOG: Reboot didn't ?????\n");
+		printk(KERN_CRIT PFX "Reboot didn't ?????\n");
 	}
 }
 
 /*
- *	Allow only one person to hold it open
+ *	Softdog operations
+ */
+
+static int softdog_keepalive(void)
+{
+	mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
+	return 0;
+}
+
+static int softdog_stop(void)
+{
+	del_timer(&watchdog_ticktock);
+	return 0;
+}
+
+static int softdog_set_heartbeat(int t)
+{
+	if ((t < 0x0001) || (t > 0xFFFF))
+		return -EINVAL;
+
+	soft_margin = t;
+	return 0;
+}
+
+/*
+ *	/dev/watchdog handling
  */
 
 static int softdog_open(struct inode *inode, struct file *file)
@@ -110,7 +140,7 @@
 	/*
 	 *	Activate timer
 	 */
-	mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
+	softdog_keepalive();
 	return 0;
 }
 
@@ -121,9 +151,10 @@
 	 * 	Lock it in if it's a module and we set nowayout
 	 */
 	if (expect_close == 42) {
-		del_timer(&watchdog_ticktock);
+		softdog_stop();
 	} else {
-		printk(KERN_CRIT "SOFTDOG: WDT device closed unexpectedly.  WDT will not stop!\n");
+		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
+		softdog_keepalive();
 	}
 	clear_bit(0, &timer_alive);
 	expect_close = 0;
@@ -155,7 +186,7 @@
 					expect_close = 42;
 			}
 		}
-		mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
+		softdog_keepalive();
 	}
 	return len;
 }
@@ -165,37 +196,57 @@
 {
 	int new_margin;
 	static struct watchdog_info ident = {
-		.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
-		.identity = "Software Watchdog",
+		.options =		WDIOF_SETTIMEOUT |
+					WDIOF_KEEPALIVEPING |
+					WDIOF_MAGICCLOSE,
+		.firmware_version =	0,
+		.identity =		"Software Watchdog",
 	};
 	switch (cmd) {
 		default:
 			return -ENOIOCTLCMD;
 		case WDIOC_GETSUPPORT:
-			if(copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident)))
-				return -EFAULT;
-			return 0;
+			return copy_to_user((struct watchdog_info *)arg, &ident,
+				sizeof(ident)) ? -EFAULT : 0;
 		case WDIOC_GETSTATUS:
 		case WDIOC_GETBOOTSTATUS:
 			return put_user(0,(int *)arg);
 		case WDIOC_KEEPALIVE:
-			mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
+			softdog_keepalive();
 			return 0;
 		case WDIOC_SETTIMEOUT:
 			if (get_user(new_margin, (int *)arg))
 				return -EFAULT;
-			if (new_margin < 1)
+			if (softdog_set_heartbeat(new_margin))
 				return -EINVAL;
-			soft_margin = new_margin;
-			mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
+			softdog_keepalive();
 			/* Fall */
 		case WDIOC_GETTIMEOUT:
 			return put_user(soft_margin, (int *)arg);
 	}
 }
 
+/*
+ *	Notifier for system down
+ */
+
+static int softdog_notify_sys(struct notifier_block *this, unsigned long code,
+	void *unused)
+{
+	if(code==SYS_DOWN || code==SYS_HALT) {
+		/* Turn the WDT off */
+		softdog_stop();
+	}
+	return NOTIFY_DONE;
+}
+
+/*
+ *	Kernel Interfaces
+ */
+
 static struct file_operations softdog_fops = {
 	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
 	.write		= softdog_write,
 	.ioctl		= softdog_ioctl,
 	.open		= softdog_open,
@@ -208,18 +259,39 @@
 	.fops		= &softdog_fops,
 };
 
-static char banner[] __initdata = KERN_INFO "Software Watchdog Timer: 0.06, soft_margin: %d sec, nowayout: %d\n";
+static struct notifier_block softdog_notifier = {
+	.notifier_call	= softdog_notify_sys,
+};
+
+static char banner[] __initdata = KERN_INFO "Software Watchdog Timer: 0.07 initialized. soft_noboot=%d soft_margin=%d sec (nowayout= %d)\n";
 
 static int __init watchdog_init(void)
 {
 	int ret;
 
-	ret = misc_register(&softdog_miscdev);
+	/* Check that the soft_margin value is within it's range ; if not reset to the default */
+	if (softdog_set_heartbeat(soft_margin)) {
+		softdog_set_heartbeat(TIMER_MARGIN);
+		printk(KERN_INFO PFX "soft_margin value must be 0<soft_margin<65536, using %d\n",
+			TIMER_MARGIN);
+	}
 
-	if (ret)
+	ret = register_reboot_notifier(&softdog_notifier);
+	if (ret) {
+		printk (KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
+			ret);
 		return ret;
+	}
+
+	ret = misc_register(&softdog_miscdev);
+	if (ret) {
+		printk (KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
+			WATCHDOG_MINOR, ret);
+		unregister_reboot_notifier(&softdog_notifier);
+		return ret;
+	}
 
-	printk(banner, soft_margin, nowayout);
+	printk(banner, soft_noboot, soft_margin, nowayout);
 
 	return 0;
 }
@@ -227,6 +299,7 @@
 static void __exit watchdog_exit(void)
 {
 	misc_deregister(&softdog_miscdev);
+	unregister_reboot_notifier(&softdog_notifier);
 }
 
 module_init(watchdog_init);
diff -Nru a/drivers/char/watchdog/pcwd.c b/drivers/char/watchdog/pcwd.c
--- a/drivers/char/watchdog/pcwd.c	Sun Mar 21 20:42:09 2004
+++ b/drivers/char/watchdog/pcwd.c	Sun Mar 21 20:42:09 2004
@@ -71,7 +71,7 @@
  */
 static int pcwd_ioports[] = { 0x270, 0x350, 0x370, 0x000 };
 
-#define WD_VER                  "1.12 (12/14/2001)"
+#define WD_VER                  "1.14 (03/12/2004)"
 
 /*
  * It should be noted that PCWD_REVISION_B was removed because A and B
@@ -227,6 +227,45 @@
 	}
 }
 
+static int pcwd_start(void)
+{
+	int stat_reg;
+
+	/*  Enable the port  */
+	if (revision == PCWD_REVISION_C) {
+		spin_lock(&io_lock);
+		outb_p(0x00, current_readport + 3);
+		stat_reg = inb_p(current_readport + 2);
+		spin_unlock(&io_lock);
+		if (stat_reg & 0x10)
+		{
+			printk(KERN_INFO "pcwd: Could not start watchdog.\n");
+			return -EIO;
+		}
+	}
+	return 0;
+}
+
+static int pcwd_stop(void)
+{
+	int stat_reg;
+
+	/*  Disable the board  */
+	if (revision == PCWD_REVISION_C) {
+		spin_lock(&io_lock);
+		outb_p(0xA5, current_readport + 3);
+		outb_p(0xA5, current_readport + 3);
+		stat_reg = inb_p(current_readport + 2);
+		spin_unlock(&io_lock);
+		if ((stat_reg & 0x10) == 0)
+		{
+			printk(KERN_INFO "pcwd: Could not stop watchdog.\n");
+			return -EIO;
+		}
+	}
+	return 0;
+}
+
 static void pcwd_send_heartbeat(void)
 {
 	int wdrst_stat;
@@ -242,13 +281,41 @@
 		outb_p(wdrst_stat, current_readport);
 }
 
+static int pcwd_get_temperature(int *temperature)
+{
+	/* check that port 0 gives temperature info and no command results */
+	if (mode_debug)
+		return -1;
+
+	*temperature = 0;
+	if (!supports_temp)
+		return -ENODEV;
+
+	/*
+	 * Convert celsius to fahrenheit, since this was
+	 * the decided 'standard' for this return value.
+	 */
+	spin_lock(&io_lock);
+	*temperature = ((inb(current_readport)) * 9 / 5) + 32;
+	spin_unlock(&io_lock);
+
+	return 0;
+}
+
+/*
+ *	/dev/watchdog handling
+ */
+
 static int pcwd_ioctl(struct inode *inode, struct file *file,
 		      unsigned int cmd, unsigned long arg)
 {
 	int cdat, rv;
+	int temperature;
 	static struct watchdog_info ident=
 	{
-		.options =		WDIOF_OVERHEAT|WDIOF_CARDRESET,
+		.options =		WDIOF_OVERHEAT |
+					WDIOF_CARDRESET |
+					WDIOF_MAGICCLOSE,
 		.firmware_version =	1,
 		.identity =		"PCWD",
 	};
@@ -332,17 +399,10 @@
 
 	case WDIOC_GETTEMP:
 
-		rv = 0;
-		if ((supports_temp) && (mode_debug == 0))
-		{
-			spin_lock(&io_lock);
-			rv = inb(current_readport);
-			spin_unlock(&io_lock);
-			if(put_user(rv, (int*) arg))
-				return -EFAULT;
-		} else if(put_user(rv, (int*) arg))
-				return -EFAULT;
-		return 0;
+		if (pcwd_get_temperature(&temperature))
+			return -EFAULT;
+
+		return put_user(temperature, (int *) arg);
 
 	case WDIOC_SETOPTIONS:
 		if (revision == PCWD_REVISION_C)
@@ -352,32 +412,12 @@
 
 			if (rv & WDIOS_DISABLECARD)
 			{
-				spin_lock(&io_lock);
-				outb_p(0xA5, current_readport + 3);
-				outb_p(0xA5, current_readport + 3);
-				cdat = inb_p(current_readport + 2);
-				spin_unlock(&io_lock);
-				if ((cdat & 0x10) == 0)
-				{
-					printk(KERN_INFO "pcwd: Could not disable card.\n");
-					return -EIO;
-				}
-
-				return 0;
+				return pcwd_stop();
 			}
 
 			if (rv & WDIOS_ENABLECARD)
 			{
-				spin_lock(&io_lock);
-				outb_p(0x00, current_readport + 3);
-				cdat = inb_p(current_readport + 2);
-				spin_unlock(&io_lock);
-				if (cdat & 0x10)
-				{
-					printk(KERN_INFO "pcwd: Could not enable card.\n");
-					return -EIO;
-				}
-				return 0;
+				return pcwd_start();
 			}
 
 			if (rv & WDIOS_TEMPPANIC)
@@ -423,72 +463,66 @@
 	return len;
 }
 
-static int pcwd_open(struct inode *ino, struct file *filep)
+static int pcwd_open(struct inode *inode, struct file *file)
 {
-	switch (iminor(ino)) {
-	case WATCHDOG_MINOR:
-		if (!atomic_dec_and_test(&open_allowed) ) {
-			atomic_inc( &open_allowed );
-			return -EBUSY;
-		}
+	if (!atomic_dec_and_test(&open_allowed) ) {
+		atomic_inc( &open_allowed );
+		return -EBUSY;
+	}
+
+	if (nowayout)
 		__module_get(THIS_MODULE);
-		/*  Enable the port  */
-		if (revision == PCWD_REVISION_C) {
-			spin_lock(&io_lock);
-			outb_p(0x00, current_readport + 3);
-			spin_unlock(&io_lock);
-		}
-		return(0);
 
-	case TEMP_MINOR:
-		return(0);
-	default:
-		return (-ENODEV);
+	/* Activate */
+	pcwd_start();
+	return(0);
+}
+
+static int pcwd_close(struct inode *inode, struct file *file)
+{
+	if (expect_close == 42) {
+		pcwd_stop();
+		atomic_inc( &open_allowed );
+        } else {
+                printk(KERN_CRIT "pcwd: Unexpected close, not stopping watchdog!\n");
+                pcwd_send_heartbeat();
 	}
+	expect_close = 0;
+	return 0;
 }
 
-static ssize_t pcwd_read(struct file *file, char *buf, size_t count,
+/*
+ *	/dev/temperature handling
+ */
+
+static ssize_t pcwd_temp_read(struct file *file, char *buf, size_t count,
 			 loff_t *ppos)
 {
-	unsigned short c;
-	unsigned char cp;
+	int temperature;
 
 	/*  Can't seek (pread) on this device  */
 	if (ppos != &file->f_pos)
 		return -ESPIPE;
-	switch(iminor(file->f_dentry->d_inode))
-	{
-		case TEMP_MINOR:
-			/*
-			 * Convert metric to Fahrenheit, since this was
-			 * the decided 'standard' for this return value.
-			 */
-
-			c = inb(current_readport);
-			cp = (c * 9 / 5) + 32;
-			if(copy_to_user(buf, &cp, 1))
-				return -EFAULT;
-			return 1;
-		default:
-			return -EINVAL;
-	}
+
+	if (pcwd_get_temperature(&temperature))
+		return -EFAULT;
+
+	if (copy_to_user(buf, &temperature, 1))
+		return -EFAULT;
+
+	return 1;
 }
 
-static int pcwd_close(struct inode *ino, struct file *filep)
-{
-	if (iminor(ino)==WATCHDOG_MINOR) {
-		if (expect_close == 42) {
-			/*  Disable the board  */
-			if (revision == PCWD_REVISION_C) {
-				spin_lock(&io_lock);
-				outb_p(0xA5, current_readport + 3);
-				outb_p(0xA5, current_readport + 3);
-				spin_unlock(&io_lock);
-			}
-			atomic_inc( &open_allowed );
-		}
-	}
-	expect_close = 0;
+static int pcwd_temp_open(struct inode *inode, struct file *file)
+{
+	if (!supports_temp)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int pcwd_temp_close(struct inode *inode, struct file *file)
+{
 	return 0;
 }
 
@@ -569,7 +603,7 @@
 
 static struct file_operations pcwd_fops = {
 	.owner		= THIS_MODULE,
-	.read		= pcwd_read,
+	.llseek		= no_llseek,
 	.write		= pcwd_write,
 	.ioctl		= pcwd_ioctl,
 	.open		= pcwd_open,
@@ -582,10 +616,18 @@
 	.fops =		&pcwd_fops,
 };
 
+static struct file_operations pcwd_temp_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= pcwd_temp_read,
+	.open		= pcwd_temp_open,
+	.release	= pcwd_temp_close,
+};
+
 static struct miscdevice temp_miscdev = {
 	.minor =	TEMP_MINOR,
 	.name =		"temperature",
-	.fops =		&pcwd_fops,
+	.fops =		&pcwd_temp_fops,
 };
 
 static void __init pcwd_validate_timeout(void)
