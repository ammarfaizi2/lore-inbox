Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311957AbSCQHxz>; Sun, 17 Mar 2002 02:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311954AbSCQHxg>; Sun, 17 Mar 2002 02:53:36 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:26810 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S311952AbSCQHx2>; Sun, 17 Mar 2002 02:53:28 -0500
Date: Sun, 17 Mar 2002 09:36:39 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] wdt_pci update
Message-ID: <Pine.LNX.4.44.0203170933560.6387-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also ended up removing references to ISA e.g. specifying IRQ/IO, 
__setup, and some comments.

	Zwane

Diffed against 2.4.19-pre2-ac3

--- linux-2.4.19-work/drivers/char/wdt_pci.c.orig	Sun Mar 17 06:56:31 2002
+++ linux-2.4.19-work/drivers/char/wdt_pci.c	Sun Mar 17 08:36:08 2002
@@ -31,6 +31,7 @@
  *		Jeff Garzik	:	PCI cleanups
  *		Tigran Aivazian	:	Restructured wdtpci_init_one() to handle failures
  *		Joel Becker	:	Added WDIOC_GET/SETTIMEOUT
+ *		Zwane Mwaikambo :	Magic char closing, locking changes, cleanups
  */
 
 #include <linux/config.h>
@@ -53,7 +54,8 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
-#include <linux/smp_lock.h>
+#include <linux/spinlock.h>
+#include <asm/semaphore.h>
 
 #include <linux/pci.h>
 
@@ -72,52 +74,19 @@
 #define PCI_DEVICE_ID_WDG_CSM 0x22c0
 #endif
 
-static int wdt_is_open;
+static struct semaphore open_sem;
+static spinlock_t wdtpci_lock;
+static int expect_close = 0;
 
-/*
- *	You must set these - there is no sane way to probe for this board.
- *	You can use wdt=x,y to set these now.
- */
- 
-static int io=0x240;
-static int irq=11;
+static int io;
+static int irq;
 
 /* Default timeout */
 #define WD_TIMO (100*60)		/* 1 minute */
+#define WD_TIMO_MAX (WD_TIMO*60)	/* 1 hour(?) */
 
 static int wd_margin = WD_TIMO;
 
-#ifndef MODULE
-
-/**
- *	wdtpci_setup:
- *	@str: command line string
- *
- *	Setup options. The board isn't really probe-able so we have to
- *	get the user to tell us the configuration. Sane people build it 
- *	modular but the others come here.
- */
- 
-static int __init wdtpci_setup(char *str)
-{
-	int ints[4];
-
-	str = get_options (str, ARRAY_SIZE(ints), ints);
-
-	if (ints[0] > 0)
-	{
-		io = ints[1];
-		if(ints[0] > 1)
-			irq = ints[2];
-	}
-
-	return 1;
-}
-
-__setup("wdt=", wdtpci_setup);
-
-#endif /* !MODULE */
- 
 /*
  *	Programming support
  */
@@ -233,11 +202,15 @@
  
 static void wdtpci_ping(void)
 {
+	unsigned long flags;
+
 	/* Write a watchdog value */
+	spin_lock_irqsave(&wdtpci_lock, flags);
 	inb_p(WDT_DC);
 	wdtpci_ctr_mode(1,2);
 	wdtpci_ctr_load(1,wd_margin);		/* Timeout */
 	outb_p(0, WDT_DC);
+	spin_unlock_irqrestore(&wdtpci_lock, flags);
 }
 
 /**
@@ -257,12 +230,21 @@
 	if (ppos != &file->f_pos)
 		return -ESPIPE;
 
-	if(count)
-	{
+	if (count) {
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+		size_t i;
+
+		expect_close = 0;
+
+		for (i = 0; i != count; i++) {
+			if (buf[i] == 'V')
+				expect_close = 1;
+		}
+#endif
 		wdtpci_ping();
-		return 1;
 	}
-	return 0;
+
+	return count;
 }
 
 /**
@@ -343,13 +325,14 @@
 			if (get_user(new_margin, (int *)arg))
 				return -EFAULT;
 			/* Arbitrary, can't find the card's limits */
-			if ((new_margin < 0) || (new_margin > 60))
+			new_margin *= 100;
+			if ((new_margin < 0) || (new_margin > WD_TIMO_MAX))
 				return -EINVAL;
-			wd_margin = new_margin * 100;
+			wd_margin = new_margin;
 			wdtpci_ping();
 			/* Fall */
 		case WDIOC_GETTIMEOUT:
-			return put_user(wd_margin, (int *)arg);
+			return put_user(wd_margin / 100, (int *)arg);
 	}
 }
 
@@ -367,20 +350,22 @@
  
 static int wdtpci_open(struct inode *inode, struct file *file)
 {
+	unsigned long flags;
+
 	switch(MINOR(inode->i_rdev))
 	{
 		case WATCHDOG_MINOR:
-			if(wdt_is_open)
-				return -EBUSY;
+			 if (down_trylock(&open_sem))
+                        	return -EBUSY;
+
 #ifdef CONFIG_WATCHDOG_NOWAYOUT	
 			MOD_INC_USE_COUNT;
 #endif
 			/*
 			 *	Activate 
 			 */
-	 
-			wdt_is_open=1;
-
+			spin_lock_irqsave(&wdtpci_lock, flags);
+			
 			inb_p(WDT_DC);		/* Disable */
 
 			/*
@@ -405,6 +390,7 @@
 			wdtpci_ctr_load(1,wd_margin);/* Timeout 60 seconds */
 			/* DO NOT LOAD CTR2 on PCI card! -- JPN */
 			outb_p(0, WDT_DC);	/* Enable */
+			spin_unlock_irqrestore(&wdtpci_lock, flags);
 			return 0;
 		case TEMP_MINOR:
 			return 0;
@@ -427,15 +413,21 @@
  
 static int wdtpci_release(struct inode *inode, struct file *file)
 {
-	if(MINOR(inode->i_rdev)==WATCHDOG_MINOR)
-	{
-		lock_kernel();
-#ifndef CONFIG_WATCHDOG_NOWAYOUT	
-		inb_p(WDT_DC);		/* Disable counters */
-		wdtpci_ctr_load(2,0);	/* 0 length reset pulses now */
+
+	if (MINOR(inode->i_rdev)==WATCHDOG_MINOR) {
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+		unsigned long flags;
+		if (expect_close) {
+			spin_lock_irqsave(&wdtpci_lock, flags);
+			inb_p(WDT_DC);		/* Disable counters */
+			wdtpci_ctr_load(2,0);	/* 0 length reset pulses now */
+			spin_unlock_irqrestore(&wdtpci_lock, flags);
+		} else {
+			printk(KERN_CRIT PFX "Unexpected close, not stopping timer!");
+			wdtpci_ping();
+		}
 #endif		
-		wdt_is_open=0;
-		unlock_kernel();
+		up(&open_sem);
 	}
 	return 0;
 }
@@ -455,11 +447,14 @@
 static int wdtpci_notify_sys(struct notifier_block *this, unsigned long code,
 	void *unused)
 {
-	if(code==SYS_DOWN || code==SYS_HALT)
-	{
+	unsigned long flags;
+
+	if (code==SYS_DOWN || code==SYS_HALT) {
 		/* Turn the card off */
+		spin_lock_irqsave(&wdtpci_lock, flags);
 		inb_p(WDT_DC);
 		wdtpci_ctr_load(2,0);
+		spin_unlock_irqrestore(&wdtpci_lock, flags);
 	}
 	return NOTIFY_DONE;
 }
@@ -520,6 +515,9 @@
 			"this driver only supports 1 device\n");
 		return -ENODEV;
 	}
+	
+	sema_init(&open_sem, 1);
+	spin_lock_init(&wdtpci_lock);
 
 	irq = dev->irq;
 	io = pci_resource_start (dev, 2);

