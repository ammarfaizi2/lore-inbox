Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316437AbSFDSmO>; Tue, 4 Jun 2002 14:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316477AbSFDSmN>; Tue, 4 Jun 2002 14:42:13 -0400
Received: from medelec.uia.ac.be ([143.169.17.1]:24583 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S316437AbSFDSl5>;
	Tue, 4 Jun 2002 14:41:57 -0400
Date: Tue, 4 Jun 2002 20:41:12 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] linux-2.4.19-pre10 - i8xx series chipsets patches (patch 4)
Message-ID: <20020604204112.A14663@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I redid my i8xx series patches for v2.4.19-pre10 . They include support for the 82801DB and 82801E 
I/O Controller Hubs for various modules.

Patch 4 is an upgrade of the i810-tco watchdog module. It contains the following:
# Fix possible timer_alive race, add expect close support,
# clean up ioctls (WDIOC_GETSTATUS, WDIOC_GETBOOTSTATUS and
# WDIOC_SETOPTIONS), made i810tco_getdevice __init,
# removed boot_status, removed tco_timer_read,
# added support for 82801DB and 82801E chipset, general cleanup.

Greetings,
Wim.


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.540   -> 1.541  
#	drivers/char/i810-tco.c	1.10    -> 1.11   
#	drivers/char/i810-tco.h	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/04	wim@iguana.be	1.541
# [PATCH] 2.4.19-pre10 - i8xx series chipsets patches (patch 4)
# 
# i810-tco: Upgrade to version 0.05 .
# Fix possible timer_alive race, add expect close support,
# clean up ioctls (WDIOC_GETSTATUS, WDIOC_GETBOOTSTATUS and
# WDIOC_SETOPTIONS), made i810tco_getdevice __init,
# removed boot_status, removed tco_timer_read,
# added support for 82801DB and 82801E chipset, general cleanup.
# --------------------------------------------
#
diff -Nru a/drivers/char/i810-tco.c b/drivers/char/i810-tco.c
--- a/drivers/char/i810-tco.c	Tue Jun  4 20:00:55 2002
+++ b/drivers/char/i810-tco.c	Tue Jun  4 20:00:55 2002
@@ -1,5 +1,5 @@
 /*
- *	i810-tco 0.04:	TCO timer driver for i8xx chipsets
+ *	i810-tco 0.05:	TCO timer driver for i8xx chipsets
  *
  *	(c) Copyright 2000 kernel concepts <nils@kernelconcepts.de>, All Rights Reserved.
  *				http://www.kernelconcepts.de
@@ -9,9 +9,9 @@
  *	as published by the Free Software Foundation; either version
  *	2 of the License, or (at your option) any later version.
  *	
- *	Neither kernel concepts nor Nils Faerber admit liability nor provide 
- *	warranty for any of this software. This material is provided 
- *	"AS-IS" and at no charge.	
+ *	Neither kernel concepts nor Nils Faerber admit liability nor provide
+ *	warranty for any of this software. This material is provided
+ *	"AS-IS" and at no charge.
  *
  *	(c) Copyright 2000	kernel concepts <nils@kernelconcepts.de>
  *				developed for
@@ -24,18 +24,25 @@
  *	(See the intel documentation on http://developer.intel.com.)
  *	82801AA & 82801AB  chip : document number 290655-003, 290677-004,
  *	82801BA & 82801BAM chip : document number 290687-002, 298242-005,
- *	82801CA & 82801CAM chip : document number 290716-001, 290718-001
+ *	82801CA & 82801CAM chip : document number 290716-001, 290718-001,
+ *	82801DB & 82801E   chip : document number 290744-001, 273599-001
  *
  *  20000710 Nils Faerber
  *	Initial Version 0.01
  *  20000728 Nils Faerber
- *      0.02 Fix for SMI_EN->TCO_EN bit, some cleanups
+ *	0.02 Fix for SMI_EN->TCO_EN bit, some cleanups
  *  20011214 Matt Domsch <Matt_Domsch@dell.com>
  *	0.03 Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
  *	     Didn't add timeout option as i810_margin already exists.
  *  20020224 Joel Becker, Wim Van Sebroeck
  *	0.04 Support for 82801CA(M) chipset, timer margin needs to be > 3,
  *	     add support for WDIOC_SETTIMEOUT and WDIOC_GETTIMEOUT.
+ *  20020412 Rob Radez <rob@osinvestor.com>, Wim Van Sebroeck
+ *	0.05 Fix possible timer_alive race, add expect close support,
+ *	     clean up ioctls (WDIOC_GETSTATUS, WDIOC_GETBOOTSTATUS and
+ *	     WDIOC_SETOPTIONS), made i810tco_getdevice __init,
+ *	     removed boot_status, removed tco_timer_read,
+ *	     added support for 82801DB and 82801E chipset, general cleanup.
  */
  
 #include <linux/module.h>
@@ -55,9 +62,9 @@
 
 
 /* Module and version information */
-#define TCO_VERSION "0.04"
+#define TCO_VERSION "0.05"
 #define TCO_MODULE_NAME "i810 TCO timer"
-#define TCO_DRIVER_NAME   TCO_MODULE_NAME " , " TCO_VERSION
+#define TCO_DRIVER_NAME   TCO_MODULE_NAME ", v" TCO_VERSION
 
 /* Default expire timeout */
 #define TIMER_MARGIN	50	/* steps of 0.6sec, 3<n<64. Default is 30 seconds */
@@ -67,9 +74,8 @@
 
 static int i810_margin = TIMER_MARGIN;	/* steps of 0.6sec */
 
-MODULE_PARM (i810_margin, "i");
-MODULE_PARM_DESC(i810_margin, "Watchdog timeout in steps of 0.6sec, 3<n<64. Default = 50 (30 seconds)");
-
+MODULE_PARM(i810_margin, "i");
+MODULE_PARM_DESC(i810_margin, "i810-tco timeout in steps of 0.6sec, 3<n<64. Default = 50 (30 seconds)");
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 static int nowayout = 1;
@@ -85,8 +91,8 @@
  *	Timer active flag
  */
 
-static int timer_alive;
-static int boot_status;
+static unsigned long timer_alive;
+static char tco_expect_close;
 
 /*
  * Some TCO specific functions
@@ -170,32 +176,19 @@
 }
 
 /*
- * Read the current timer value
- */
-static unsigned char tco_timer_read (void)
-{
-	return (inb (TCO1_RLD));
-}
-
-
-/*
  *	Allow only one person to hold it open
  */
 
 static int i810tco_open (struct inode *inode, struct file *file)
 {
-	if (timer_alive)
+	if (test_and_set_bit(0, &timer_alive))
 		return -EBUSY;
 
-	if (nowayout) {
-		MOD_INC_USE_COUNT;
-	}
 	/*
 	 *      Reload and activate timer
 	 */
 	tco_timer_reload ();
 	tco_timer_start ();
-	timer_alive = 1;
 	return 0;
 }
 
@@ -204,10 +197,14 @@
 	/*
 	 *      Shut off the timer.
 	 */
-	if (nowayout) {
+	if (tco_expect_close == 42 && !nowayout) {
 		tco_timer_stop ();
-		timer_alive = 0;
+	} else {
+		tco_timer_reload ();
+		printk(KERN_CRIT TCO_MODULE_NAME ": Unexpected close, not stopping watchdog!\n");
 	}
+	clear_bit(0, &timer_alive);
+	tco_expect_close = 0;
 	return 0;
 }
 
@@ -218,10 +215,19 @@
 	if (ppos != &file->f_pos)
 		return -ESPIPE;
 
-	/*
-	 *      Refresh the timer.
-	 */
+	/* See if we got the magic character 'V' and reload the timer */
 	if (len) {
+		size_t i;
+
+		tco_expect_close = 0;
+
+		/* scan to see wether or not we got the magic character */
+		for (i = 0; i != len; i++) {
+			if (data[i] == 'V')
+				tco_expect_close = 42;
+		}
+
+		/* someone wrote to us, we should reload the timer */
 		tco_timer_reload ();
 		return 1;
 	}
@@ -232,41 +238,53 @@
 			  unsigned int cmd, unsigned long arg)
 {
 	int new_margin, u_margin;
+	int options, retval = -EINVAL;
 
 	static struct watchdog_info ident = {
-		WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
-		0,
-		"i810 TCO timer"
+		options:		WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+		firmware_version:	0,
+		identity:		"i810 TCO timer",
 	};
 	switch (cmd) {
-	default:
-		return -ENOTTY;
-	case WDIOC_GETSUPPORT:
-		if (copy_to_user
-		    ((struct watchdog_info *) arg, &ident, sizeof (ident)))
-			return -EFAULT;
-		return 0;
-	case WDIOC_GETSTATUS:
-		return put_user (tco_timer_read (),
-				 (unsigned int *) (int) arg);
-	case WDIOC_GETBOOTSTATUS:
-		return put_user (boot_status, (int *) arg);
-	case WDIOC_KEEPALIVE:
-		tco_timer_reload ();
-		return 0;
-	case WDIOC_SETTIMEOUT:
-		if (get_user(u_margin, (int *) arg))
-			return -EFAULT;
-		new_margin = (u_margin * 10 + 5) / 6;
-		if ((new_margin < 4) || (new_margin > 63))
-			return -EINVAL;
-		if (tco_timer_settimer((unsigned char)new_margin))
-		    return -EINVAL;
-		i810_margin = new_margin;
-		tco_timer_reload();
-		/* Fall */
-	case WDIOC_GETTIMEOUT:
-		return put_user((int)(i810_margin * 6 / 10), (int *) arg);
+		default:
+			return -ENOTTY;
+		case WDIOC_GETSUPPORT:
+			if (copy_to_user
+			    ((struct watchdog_info *) arg, &ident, sizeof (ident)))
+				return -EFAULT;
+			return 0;
+		case WDIOC_GETSTATUS:
+		case WDIOC_GETBOOTSTATUS:
+			return put_user (0, (int *) arg);
+		case WDIOC_SETOPTIONS:
+			if (get_user (options, (int *) arg))
+				return -EFAULT;
+			if (options & WDIOS_DISABLECARD) {
+				tco_timer_stop ();
+				retval = 0;
+			}
+			if (options & WDIOS_ENABLECARD) {
+				tco_timer_reload ();
+				tco_timer_start ();
+				retval = 0;
+			}
+			return retval;
+		case WDIOC_KEEPALIVE:
+			tco_timer_reload ();
+			return 0;
+		case WDIOC_SETTIMEOUT:
+			if (get_user (u_margin, (int *) arg))
+				return -EFAULT;
+			new_margin = (u_margin * 10 + 5) / 6;
+			if ((new_margin < 4) || (new_margin > 63))
+				return -EINVAL;
+			if (tco_timer_settimer ((unsigned char) new_margin))
+			    return -EINVAL;
+			i810_margin = new_margin;
+			tco_timer_reload ();
+			/* Fall */
+		case WDIOC_GETTIMEOUT:
+			return put_user ((int)(i810_margin * 6 / 10), (int *) arg);
 	}
 }
 
@@ -285,13 +303,15 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0,	PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE (pci, i810tco_pci_tbl);
 
 static struct pci_dev *i810tco_pci;
 
-static unsigned char i810tco_getdevice (void)
+static unsigned char __init i810tco_getdevice (void)
 {
 	struct pci_dev *dev;
 	u8 val1, val2;
@@ -341,7 +361,6 @@
 		outb (val1, SMI_EN + 1);
 		/* Clear out the (probably old) status */
 		outb (0, TCO1_STS);
-		boot_status = (int) inb (TCO2_STS);
 		outb (3, TCO2_STS);
 		return 1;
 	}
@@ -357,9 +376,9 @@
 };
 
 static struct miscdevice i810tco_miscdev = {
-	WATCHDOG_MINOR,
-	"watchdog",
-	&i810tco_fops
+	minor:		WATCHDOG_MINOR,
+	name:		"watchdog",
+	fops:		&i810tco_fops,
 };
 
 static int __init watchdog_init (void)
@@ -382,8 +401,8 @@
 	tco_timer_reload ();
 
 	printk (KERN_INFO TCO_DRIVER_NAME
-		": timer margin: %d sec (0x%04x)\n",
-		(int) (i810_margin * 6 / 10), TCOBASE);
+		": timer margin: %d sec (0x%04x) (nowayout=%d)\n",
+		(int) (i810_margin * 6 / 10), TCOBASE, nowayout);
 	return 0;
 }
 
@@ -404,4 +423,7 @@
 module_init(watchdog_init);
 module_exit(watchdog_cleanup);
 
+MODULE_AUTHOR("Nils Faerber");
+MODULE_DESCRIPTION("TCO timer driver for i8xx chipsets");
 MODULE_LICENSE("GPL");
+EXPORT_NO_SYMBOLS;
diff -Nru a/drivers/char/i810-tco.h b/drivers/char/i810-tco.h
--- a/drivers/char/i810-tco.h	Tue Jun  4 20:00:55 2002
+++ b/drivers/char/i810-tco.h	Tue Jun  4 20:00:55 2002
@@ -1,5 +1,5 @@
 /*
- *	i810-tco 0.04:	TCO timer driver for i8xx chipsets
+ *	i810-tco 0.05:	TCO timer driver for i8xx chipsets
  *
  *	(c) Copyright 2000 kernel concepts <nils@kernelconcepts.de>, All Rights Reserved.
  *				http://www.kernelconcepts.de
@@ -9,9 +9,9 @@
  *	as published by the Free Software Foundation; either version
  *	2 of the License, or (at your option) any later version.
  *	
- *	Neither kernel concepts nor Nils Faerber admit liability nor provide 
- *	warranty for any of this software. This material is provided 
- *	"AS-IS" and at no charge.	
+ *	Neither kernel concepts nor Nils Faerber admit liability nor provide
+ *	warranty for any of this software. This material is provided
+ *	"AS-IS" and at no charge.
  *
  *	(c) Copyright 2000	kernel concepts <nils@kernelconcepts.de>
  *				developed for
@@ -20,13 +20,8 @@
  *	TCO timer driver for i8xx chipsets
  *	based on softdog.c by Alan Cox <alan@redhat.com>
  *
- *	The TCO timer is implemented in the following I/O controller hubs:
- *	(See the intel documentation on http://developer.intel.com.)
- *	82801AA & 82801AB  chip : document number 290655-003, 290677-004,
- *	82801BA & 82801BAM chip : document number 290687-002, 298242-005,
- *	82801CA & 82801CAM chip : document number 290716-001, 290718-001
- *
- *	For history see i810-tco.c
+ *	For history and the complete list of supported I/O Controller Hub's
+ *	see i810-tco.c
  */
 
 
