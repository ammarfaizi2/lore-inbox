Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285150AbRLFQvV>; Thu, 6 Dec 2001 11:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285164AbRLFQvR>; Thu, 6 Dec 2001 11:51:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13585 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S285150AbRLFQuu>;
	Thu, 6 Dec 2001 11:50:50 -0500
Date: Thu, 6 Dec 2001 16:50:49 +0000
From: Joel Becker <jlbec@evilplan.org>
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: WDIOC_SETTIMEOUT
Message-ID: <20011206165049.N31706@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Folks,
	I had been discussing an ioctl to set watchdogtimeouts with a
few folks.  Lo-and-behold, we already have it in 2.4.16 (WDIOC_SETTIMOUT).
Yay!.  Here's a patch adding it to all the drivers that support modifiable
timeouts.  The passed timeout is in seconds.  WDIOC_SETTIMEOUT writes to
the passed location the actual timeout set (which is the submitted timout
or rounded up if the card can't do that exact value).  WDIOC_GETTIMEOUT is
also included for completeness.  The WDIOF_SETTIMEOUT flag has been
added to the options returned by WDIOC_GETSUPPORT.  If WDIOF_SETTMEOUT
is set, then WDIOC_{GET,SET}TIMEOUT are available.

Joel

-- 

Life's Little Instruction Book #252

	"Take good care of those you love."

			http://www.jlbec.org/
			jlbec@evilplan.org

--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="wdtimeout.patch"

diff -uNr linux-2.4.16/drivers/char/advantechwdt.c linux-2.4.16-settimout/drivers/char/advantechwdt.c
--- linux-2.4.16/drivers/char/advantechwdt.c	Thu Sep 13 15:21:32 2001
+++ linux-2.4.16-settimout/drivers/char/advantechwdt.c	Mon Dec  3 13:44:45 2001
@@ -64,6 +64,7 @@
 #define WDT_START 0x443
 
 #define WD_TIMO 60		/* 1 minute */
+static int wd_margin = WD_TIMO;
 
 /*
  *	Kernel methods.
@@ -73,7 +74,7 @@
 advwdt_ping(void)
 {
 	/* Write a watchdog value */
-	outb_p(WD_TIMO, WDT_START);
+	outb_p(wd_margin, WDT_START);
 }
 
 static ssize_t
@@ -100,8 +101,9 @@
 advwdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 	  unsigned long arg)
 {
+	int new_margin;
 	static struct watchdog_info ident = {
-		WDIOF_KEEPALIVEPING, 1, "Advantech WDT"
+		WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT, 1, "Advantech WDT"
 	};
 	
 	switch (cmd) {
@@ -117,6 +119,19 @@
 
 	case WDIOC_KEEPALIVE:
 	  advwdt_ping();
+	  break;
+
+	case WDIOC_SETTIMEOUT:
+	  if (get_user(new_margin, (int *)arg))
+		  return -EFAULT;
+	  if ((new_margin < 1) || (new_margin > 63))
+		  return -EINVAL;
+	  wd_margin = new_margin;
+	  advwdt_ping();
+	  /* Fall */
+
+	case WDIOC_GETTIMEOUT:
+	  return put_user(wd_margin, (int *)arg);
 	  break;
 
 	default:
diff -uNr linux-2.4.16/drivers/char/eurotechwdt.c linux-2.4.16-settimout/drivers/char/eurotechwdt.c
--- linux-2.4.16/drivers/char/eurotechwdt.c	Thu Oct 25 13:53:47 2001
+++ linux-2.4.16-settimout/drivers/char/eurotechwdt.c	Mon Dec  3 13:53:00 2001
@@ -233,7 +233,7 @@
         unsigned int cmd, unsigned long arg)
 {
    static struct watchdog_info ident = {
-      options		: WDIOF_CARDRESET,
+      options		: WDIOF_CARDRESET | WDIOF_SETTIMEOUT,
       firmware_version	: 1,
       identity		: "WDT Eurotech CPU-1220/1410"
    };
@@ -265,7 +265,10 @@
 
          eurwdt_timeout = time; 
          eurwdt_set_timeout(time); 
-         return 0;
+	 /* Fall */
+
+      case WDIOC_GETTIMEOUT:
+	 return put_user(eurwdt_timeout, (int *)arg);
    }
 }
 
diff -uNr linux-2.4.16/drivers/char/i810-tco.c linux-2.4.16-settimout/drivers/char/i810-tco.c
--- linux-2.4.16/drivers/char/i810-tco.c	Thu Sep 13 15:21:32 2001
+++ linux-2.4.16-settimout/drivers/char/i810-tco.c	Mon Dec  3 13:44:45 2001
@@ -181,7 +181,7 @@
 	/*
 	 *      Shut off the timer.
 	 */
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
 	tco_timer_stop ();
 	timer_alive = 0;
 #endif	
@@ -208,8 +208,10 @@
 static int i810tco_ioctl (struct inode *inode, struct file *file,
 			  unsigned int cmd, unsigned long arg)
 {
+	int new_margin, u_margin;
+
 	static struct watchdog_info ident = {
-		0,
+		WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
 		0,
 		"i810 TCO timer"
 	};
@@ -229,6 +231,19 @@
 	case WDIOC_KEEPALIVE:
 		tco_timer_reload ();
 		return 0;
+	case WDIOC_SETTIMEOUT:
+		if (get_user(u_margin, (int *) arg))
+			return -EFAULT;
+		new_margin = (u_margin * 10 + 5) / 6;
+		if ((new_margin < 3) || (new_margin > 63))
+			return -EINVAL;
+		if (tco_timer_settimer((unsigned char)new_margin))
+		    return -EINVAL;
+		i810_margin = new_margin;
+		tco_timer_reload();
+		/* Fall */
+	case WDIOC_GETTIMEOUT:
+		return put_user((int)(i810_margin * 6 / 10), (int *) arg);
 	}
 }
 
diff -uNr linux-2.4.16/drivers/char/ib700wdt.c linux-2.4.16-settimout/drivers/char/ib700wdt.c
--- linux-2.4.16/drivers/char/ib700wdt.c	Thu Oct 11 09:07:00 2001
+++ linux-2.4.16-settimout/drivers/char/ib700wdt.c	Mon Dec  3 13:44:45 2001
@@ -87,11 +87,34 @@
  *
  */
 
+static int wd_times[] = {
+	30,	/* 0x0 */
+	28,	/* 0x1 */
+	26,	/* 0x2 */
+	24,	/* 0x3 */
+	22,	/* 0x4 */
+	20,	/* 0x5 */
+	18,	/* 0x6 */
+	16,	/* 0x7 */
+	14,	/* 0x8 */
+	12,	/* 0x9 */
+	10,	/* 0xA */
+	8,	/* 0xB */
+	6,	/* 0xC */
+	4,	/* 0xD */
+	2,	/* 0xE */
+	0,	/* 0xF */
+};
+
 #define WDT_STOP 0x441
 #define WDT_START 0x443
 
+/* Default timeout */
 #define WD_TIMO 0		/* 30 seconds +/- 20%, from table */
 
+static int wd_margin = WD_TIMO;
+
+
 /*
  *	Kernel methods.
  */
@@ -100,7 +123,7 @@
 ibwdt_ping(void)
 {
 	/* Write a watchdog value */
-	outb_p(WD_TIMO, WDT_START);
+	outb_p(wd_times[wd_margin], WDT_START);
 }
 
 static ssize_t
@@ -127,8 +150,10 @@
 ibwdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 	  unsigned long arg)
 {
+	int i, new_margin;
+
 	static struct watchdog_info ident = {
-		WDIOF_KEEPALIVEPING, 1, "IB700 WDT"
+		WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT, 1, "IB700 WDT"
 	};
 
 	switch (cmd) {
@@ -146,6 +171,22 @@
 	  ibwdt_ping();
 	  break;
 
+	case WDIOC_SETTIMEOUT:
+	  if (get_user(new_margin, (int *)arg))
+		  return -EFAULT;
+	  if ((new_margin < 0) || (new_margin > 30))
+		  return -EINVAL;
+	  for (i = 0x0F; i > -1; i--)
+		  if (wd_times[i] > new_margin)
+			  break;
+	  wd_margin = i;
+	  ibwdt_ping();
+	  /* Fall */
+
+	case WDIOC_GETTIMEOUT:
+	  return put_user(wd_times[wd_margin], (int *)arg);
+	  break;
+
 	default:
 	  return -ENOTTY;
 	}
@@ -182,7 +223,7 @@
 	if (MINOR(inode->i_rdev) == WATCHDOG_MINOR) {
 		spin_lock(&ibwdt_lock);
 #ifndef CONFIG_WATCHDOG_NOWAYOUT
-		outb_p(WD_TIMO, WDT_STOP);
+		outb_p(wd_times[wd_margin], WDT_STOP);
 #endif
 		ibwdt_is_open = 0;
 		spin_unlock(&ibwdt_lock);
@@ -201,7 +242,7 @@
 {
 	if (code == SYS_DOWN || code == SYS_HALT) {
 		/* Turn the WDT off */
-		outb_p(WD_TIMO, WDT_STOP);
+		outb_p(wd_times[wd_margin], WDT_STOP);
 	}
 	return NOTIFY_DONE;
 }
diff -uNr linux-2.4.16/drivers/char/softdog.c linux-2.4.16-settimout/drivers/char/softdog.c
--- linux-2.4.16/drivers/char/softdog.c	Sun Sep 30 12:26:05 2001
+++ linux-2.4.16-settimout/drivers/char/softdog.c	Mon Dec  3 13:48:48 2001
@@ -26,6 +26,11 @@
  *
  *  19980911 Alan Cox
  *	Made SMP safe for 2.3.x
+ *
+ *  20011127 Joel Becker (jlbec@evilplan.org>
+ *	Added soft_noboot; Allows testing the softdog trigger without 
+ *	requiring a recompile.
+ *	Added WDIOC_GETTIMEOUT and WDIOC_SETTIMOUT.
  */
  
 #include <linux/module.h>
@@ -44,8 +49,14 @@
 #define TIMER_MARGIN	60		/* (secs) Default is 1 minute */
 
 static int soft_margin = TIMER_MARGIN;	/* in seconds */
+#ifdef ONLY_TESTING
+static int soft_noboot = 1;
+#else
+static int soft_noboot = 0;
+#endif  /* ONLY_TESTING */
 
 MODULE_PARM(soft_margin,"i");
+MODULE_PARM(soft_noboot,"i");
 MODULE_LICENSE("GPL");
 
 /*
@@ -66,13 +77,14 @@
  
 static void watchdog_fire(unsigned long data)
 {
-#ifdef ONLY_TESTING
-		printk(KERN_CRIT "SOFTDOG: Would Reboot.\n");
-#else
-	printk(KERN_CRIT "SOFTDOG: Initiating system reboot.\n");
-	machine_restart(NULL);
-	printk("WATCHDOG: Reboot didn't ?????\n");
-#endif
+	if (soft_noboot)
+		printk(KERN_CRIT "SOFTDOG: Triggered - Reboot ignored.\n");
+	else
+	{
+		printk(KERN_CRIT "SOFTDOG: Initiating system reboot.\n");
+		machine_restart(NULL);
+		printk("SOFTDOG: Reboot didn't ?????\n");
+	}
 }
 
 /*
@@ -128,8 +140,11 @@
 static int softdog_ioctl(struct inode *inode, struct file *file,
 	unsigned int cmd, unsigned long arg)
 {
+	int new_margin;
 	static struct watchdog_info ident = {
-		identity: "Software Watchdog",
+		WDIOF_SETTIMEOUT,
+		0,
+		"Software Watchdog"
 	};
 	switch (cmd) {
 		default:
@@ -144,6 +159,16 @@
 		case WDIOC_KEEPALIVE:
 			mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
 			return 0;
+		case WDIOC_SETTIMEOUT:
+			if (get_user(new_margin, (int *)arg))
+				return -EFAULT;
+			if (new_margin < 1)
+				return -EINVAL;
+			soft_margin = new_margin;
+			mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
+			/* Fall */
+		case WDIOC_GETTIMEOUT:
+			return put_user(soft_margin, (int *)arg);
 	}
 }
 
diff -uNr linux-2.4.16/drivers/char/wdt.c linux-2.4.16-settimout/drivers/char/wdt.c
--- linux-2.4.16/drivers/char/wdt.c	Fri Sep  7 09:28:38 2001
+++ linux-2.4.16-settimout/drivers/char/wdt.c	Mon Dec  3 13:44:45 2001
@@ -27,6 +27,7 @@
  *		Tim Hockin	:	Added insmod parameters, comment cleanup
  *					Parameterized timeout
  *		Tigran Aivazian	:	Restructured wdt_init() to handle failures
+ *		Joel Becker	:	Added WDIOC_GET/SETTIMEOUT
  */
 
 #include <linux/config.h>
@@ -60,8 +61,11 @@
 static int io=0x240;
 static int irq=11;
 
+/* Default margin */
 #define WD_TIMO (100*60)		/* 1 minute */
 
+static int wd_margin = WD_TIMO;
+
 #ifndef MODULE
 
 /**
@@ -216,7 +220,7 @@
 	/* Write a watchdog value */
 	inb_p(WDT_DC);
 	wdt_ctr_mode(1,2);
-	wdt_ctr_load(1,WD_TIMO);		/* Timeout */
+	wdt_ctr_load(1,wd_margin);		/* Timeout */
 	outb_p(0, WDT_DC);
 }
 
@@ -294,10 +298,13 @@
 static int wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 	unsigned long arg)
 {
+	int new_margin;
+
 	static struct watchdog_info ident=
 	{
 		WDIOF_OVERHEAT|WDIOF_POWERUNDER|WDIOF_POWEROVER
-			|WDIOF_EXTERN1|WDIOF_EXTERN2|WDIOF_FANFAULT,
+			|WDIOF_EXTERN1|WDIOF_EXTERN2|WDIOF_FANFAULT
+			|WDIOF_SETTIMEOUT,
 		1,
 		"WDT500/501"
 	};
@@ -317,6 +324,17 @@
 		case WDIOC_KEEPALIVE:
 			wdt_ping();
 			return 0;
+		case WDIOC_SETTIMEOUT:
+			if (get_user(new_margin, (int *)arg))
+				return -EFAULT;
+			/* Arbitrary, can't find the card's limits */
+			if ((new_margin < 0) || (new_margin > 60))
+				return -EINVAL;
+			wd_margin = new_margin * 100;
+			wdt_ping();
+			/* Fall */
+		case WDIOC_GETTIMEOUT:
+			return put_user(wd_margin / 100, (int *)arg);
 	}
 }
 
@@ -349,7 +367,7 @@
 			wdt_ctr_mode(1,2);
 			wdt_ctr_mode(2,0);
 			wdt_ctr_load(0, 8948);		/* count at 100Hz */
-			wdt_ctr_load(1,WD_TIMO);	/* Timeout 120 seconds */
+			wdt_ctr_load(1,wd_margin);	/* Timeout 120 seconds */
 			wdt_ctr_load(2,65535);
 			outb_p(0, WDT_DC);	/* Enable */
 			return 0;
diff -uNr linux-2.4.16/drivers/char/wdt285.c linux-2.4.16-settimout/drivers/char/wdt285.c
--- linux-2.4.16/drivers/char/wdt285.c	Fri Sep  7 09:28:38 2001
+++ linux-2.4.16-settimout/drivers/char/wdt285.c	Mon Dec  3 13:44:45 2001
@@ -126,10 +126,10 @@
 static int watchdog_ioctl(struct inode *inode, struct file *file,
 	unsigned int cmd, unsigned long arg)
 {
-	int i;
+	int i, new_margin;
 	static struct watchdog_info ident=
 	{
-		0,
+		WDIOF_SETTIMEOUT,
 		0,
 		"Footbridge Watchdog"
 	};
@@ -149,6 +149,17 @@
 		case WDIOC_KEEPALIVE:
 			watchdog_ping();
 			return 0;
+		case WDIOC_SETTIMEOUT:
+			if (get_user(new_margin, (int *)arg))
+				return -EFAULT;
+			/* Arbitrary, can't find the card's limits */
+			if ((new_marg < 0) || (new_margin > 60))
+				return -EINVAL;
+			soft_margin = new_margin;
+			watchdog_ping();
+			/* Fall */
+		case WDIOC_GETTIMEOUT:
+			return put_user(soft_margin, (int *)arg);
 	}
 }
 
diff -uNr linux-2.4.16/drivers/char/wdt_pci.c linux-2.4.16-settimout/drivers/char/wdt_pci.c
--- linux-2.4.16/drivers/char/wdt_pci.c	Fri Sep  7 09:28:38 2001
+++ linux-2.4.16-settimout/drivers/char/wdt_pci.c	Mon Dec  3 13:44:45 2001
@@ -30,6 +30,7 @@
  *		Alan Cox	:	Split ISA and PCI cards into two drivers
  *		Jeff Garzik	:	PCI cleanups
  *		Tigran Aivazian	:	Restructured wdtpci_init_one() to handle failures
+ *		Joel Becker	:	Added WDIOC_GET/SETTIMEOUT
  */
 
 #include <linux/config.h>
@@ -81,8 +82,11 @@
 static int io=0x240;
 static int irq=11;
 
+/* Default timeout */
 #define WD_TIMO (100*60)		/* 1 minute */
 
+static int wd_margin = WD_TIMO;
+
 #ifndef MODULE
 
 /**
@@ -232,7 +236,7 @@
 	/* Write a watchdog value */
 	inb_p(WDT_DC);
 	wdtpci_ctr_mode(1,2);
-	wdtpci_ctr_load(1,WD_TIMO);		/* Timeout */
+	wdtpci_ctr_load(1,wd_margin);		/* Timeout */
 	outb_p(0, WDT_DC);
 }
 
@@ -310,10 +314,12 @@
 static int wdtpci_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 	unsigned long arg)
 {
+	int new_margin;
 	static struct watchdog_info ident=
 	{
 		WDIOF_OVERHEAT|WDIOF_POWERUNDER|WDIOF_POWEROVER
-			|WDIOF_EXTERN1|WDIOF_EXTERN2|WDIOF_FANFAULT,
+			|WDIOF_EXTERN1|WDIOF_EXTERN2|WDIOF_FANFAULT
+			|WDIOF_SETTIMEOUT,
 		1,
 		"WDT500/501PCI"
 	};
@@ -333,6 +339,17 @@
 		case WDIOC_KEEPALIVE:
 			wdtpci_ping();
 			return 0;
+		case WDIOC_SETTIMEOUT:
+			if (get_user(new_margin, (int *)arg))
+				return -EFAULT;
+			/* Arbitrary, can't find the card's limits */
+			if ((new_margin < 0) || (new_margin > 60))
+				return -EINVAL;
+			wd_margin = new_margin * 100;
+			wdtpci_ping();
+			/* Fall */
+		case WDIOC_GETTIMEOUT:
+			return put_user(wd_margin, (int *)arg);
 	}
 }
 
@@ -385,7 +402,7 @@
 			wdtpci_ctr_mode(1,2);
 			wdtpci_ctr_mode(2,1);
 			wdtpci_ctr_load(0,20833);	/* count at 100Hz */
-			wdtpci_ctr_load(1,WD_TIMO);/* Timeout 60 seconds */
+			wdtpci_ctr_load(1,wd_margin);/* Timeout 60 seconds */
 			/* DO NOT LOAD CTR2 on PCI card! -- JPN */
 			outb_p(0, WDT_DC);	/* Enable */
 			return 0;
diff -uNr linux-2.4.16/drivers/sbus/char/riowatchdog.c linux-2.4.16-settimout/drivers/sbus/char/riowatchdog.c
--- linux-2.4.16/drivers/sbus/char/riowatchdog.c	Wed Oct 10 23:42:47 2001
+++ linux-2.4.16-settimout/drivers/sbus/char/riowatchdog.c	Mon Dec  3 13:44:45 2001
@@ -127,7 +127,9 @@
 static int riowd_ioctl(struct inode *inode, struct file *filp,
 		       unsigned int cmd, unsigned long arg)
 {
-	static struct watchdog_info info = { 0, 0, "Natl. Semiconductor PC97317" };
+	static struct watchdog_info info = {
+	       	WDIOF_SETTIMEOUT, 0, "Natl. Semiconductor PC97317"
+	};
 	unsigned int options;
 
 	switch (cmd) {
@@ -158,6 +160,18 @@
 			return -EINVAL;
 
 		break;
+
+	case WDIOC_SETTIMEOUT:
+		if (get_user(new_margin, (int *)arg))
+			return -EFAULT;
+		if ((new_margin < 60) || (new_margin > (255 * 60)))
+		    return -EINVAL;
+		riowd_timeout = (new_margin + 59) / 60;
+		riowd_pingtimer();
+		/* Fall */
+
+	case WDIOC_GETTIMEOUT:
+		return put_user(riowd_timeout * 60, (int *)arg);
 
 	default:
 		return -EINVAL;
diff -uNr linux-2.4.16/include/linux/watchdog.h linux-2.4.16-settimout/include/linux/watchdog.h
--- linux-2.4.16/include/linux/watchdog.h	Fri Nov  9 14:11:15 2001
+++ linux-2.4.16-settimout/include/linux/watchdog.h	Mon Dec  3 13:55:42 2001
@@ -25,7 +25,8 @@
 #define	WDIOC_GETTEMP		_IOR(WATCHDOG_IOCTL_BASE, 3, int)
 #define	WDIOC_SETOPTIONS	_IOR(WATCHDOG_IOCTL_BASE, 4, int)
 #define	WDIOC_KEEPALIVE		_IOR(WATCHDOG_IOCTL_BASE, 5, int)
-#define	WDIOC_SETTIMEOUT        _IOW(WATCHDOG_IOCTL_BASE, 6, int)
+#define	WDIOC_SETTIMEOUT        _IOWR(WATCHDOG_IOCTL_BASE, 6, int)
+#define	WDIOC_GETTIMEOUT        _IOR(WATCHDOG_IOCTL_BASE, 7, int)
 
 #define	WDIOF_UNKNOWN		-1	/* Unknown flag error */
 #define	WDIOS_UNKNOWN		-1	/* Unknown status error */
@@ -37,6 +38,7 @@
 #define	WDIOF_POWERUNDER	0x0010	/* Power bad/power fault */
 #define	WDIOF_CARDRESET		0x0020	/* Card previously reset the CPU */
 #define WDIOF_POWEROVER		0x0040	/* Power over voltage */
+#define WDIOF_SETTIMEOUT	0x0080  /* Set timeout (in seconds) */
 #define	WDIOF_KEEPALIVEPING	0x8000	/* Keep alive ping reply */
 
 #define	WDIOS_DISABLECARD	0x0001	/* Turn off the watchdog timer */

--zbGR4y+acU1DwHSi--
