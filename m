Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281895AbRLQSf6>; Mon, 17 Dec 2001 13:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281910AbRLQSfp>; Mon, 17 Dec 2001 13:35:45 -0500
Received: from smtp3.us.dell.com ([143.166.224.253]:38151 "EHLO
	smtp3.us.dell.com") by vger.kernel.org with ESMTP
	id <S281895AbRLQSfQ>; Mon, 17 Dec 2001 13:35:16 -0500
Date: Mon, 17 Dec 2001 12:32:59 -0600 (CST)
From: Matt Domsch <mdomsch@lists.us.dell.com>
X-X-Sender: <mdomsch@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <alan@redhat.com>, <kenji@bitgate.com>, <nils@kernelconcepts.de>,
        <fuganti@conectiva.com.br>, <giometti@ascensit.com>,
        <support@ascensit.com>, <pb@nexus.co.uk>, <chowes@vsol.net>,
        <gorgo@itc.hu>, <info@itc.hu>, <lethal@chaoticdreams.org>,
        <woody@netwinder.org>, <johnsonm@redhat.com>
Subject: [CFT][PATCH] watchdog nowayout and timeout module parameters
Message-ID: <Pine.LNX.4.33.0112171116140.19932-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-ID: <Pine.LNX.4.33.0112171116142.19932@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I needed a way to set the software watchdog timer to use a runtime-set
"no way out" value instead of only CONFIG_WATCHDOG_NOWAYOUT.  Rather
than modify only softdog.o, Alan Cox suggested I modify all the watchdog
drivers.  Accordingly, the patch is below and posted to
http://domsch.com/linux/patches/linux-2.4.17-rc1-watchdog-nowayout-20011
217.patch.  I'm cc:ing all the listed maintainers.  Please respond to me
privately with your approval or suggested changes per driver.  I don't
have any of this hardware to test with myself.

Most drivers were modified to add a 'nowayout=[01]' module parameter
which defaults to CONFIG_WATCHDOG_NOWAYOUT if not passed.  wdt285.c
wasn't written to allow a way out at all, so it wasn't modified.

To the following drivers was also added a 'timeout=X' module parameter,
where timeout is specified in seconds.  Only drivers for which no
similar parm was already present were modified:
advantechwdt.c (marekm@linux.org.pl)
eurotechwdt.c  (giometti@ascensit.com, support@ascensit.com)
ib700wdt.c     (chowes@vsol.net)
pcwd.c         (kenji@bitgate.com)
wdt.c		   (alan@redhat.com)
wdt_pci.c	   (alan@redhat.com)

These already offer a timeout parm:
i810-tco.c (nils@kernelconcepts.de)
softdog.c  (alan@redhat.com)
wdt285.o   (pb@nexus.co.uk)

These didn't get a timeout parm because it wasn't obvious if or how it
could be done:
machzwd.c  (fuganti@conectiva.com.br)
mixcomwd.c (gorgo@itc.hu, info@itc.hu)
shwdt.c    (lethal@chaoticdreams.org)
wdt977.c   (woody@netwinder.org)


Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
#1 US Linux Server provider with 24% (IDC Sept 2001)
#2 Worldwide Linux Server provider with 17% (IDC Sept 2001)
#3 Unix provider with 18% in the US (Dataquest)!


diff -burNp --exclude-from=/home/mdomsch/excludes linux-2.4.17-rc1/drivers/char/acquirewdt.c linux/drivers/char/acquirewdt.c
--- linux-2.4.17-rc1/drivers/char/acquirewdt.c	Thu Sep 13 17:21:32 2001
+++ linux/drivers/char/acquirewdt.c	Mon Dec 17 11:39:51 2001
@@ -17,6 +17,9 @@
  *
  *	(c) Copyright 1995    Alan Cox <alan@redhat.com>
  *
+ *      14-Dec-2001 Matt Domsch <Matt_Domsch@dell.com>
+ *          Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
+ *          Can't add timeout - driver doesn't allow changing value
  */
 
 #include <linux/config.h>
@@ -50,8 +53,14 @@ static spinlock_t acq_lock;
 #define WDT_STOP 0x43
 #define WDT_START 0x443
 
-#define WD_TIMO (100*60)		/* 1 minute */
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
 
+MODULE_PARM(nowayout,"i");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 /*
  *	Kernel methods.
@@ -126,10 +135,12 @@ static int acq_open(struct inode *inode,
 				spin_unlock(&acq_lock);
 				return -EBUSY;
 			}
+			if (nowayout) {
+				MOD_INC_USE_COUNT;
+			}
 			/*
 			 *	Activate 
 			 */
-	 
 			acq_is_open=1;
 			inb_p(WDT_START);      
 			spin_unlock(&acq_lock);
@@ -145,9 +156,9 @@ static int acq_close(struct inode *inode
 	if(MINOR(inode->i_rdev)==WATCHDOG_MINOR)
 	{
 		spin_lock(&acq_lock);
-#ifndef CONFIG_WATCHDOG_NOWAYOUT	
+		if (!nowayout) {
 		inb_p(WDT_STOP);
-#endif		
+		}
 		acq_is_open=0;
 		spin_unlock(&acq_lock);
 	}
diff -burNp --exclude-from=/home/mdomsch/excludes linux-2.4.17-rc1/drivers/char/advantechwdt.c linux/drivers/char/advantechwdt.c
--- linux-2.4.17-rc1/drivers/char/advantechwdt.c	Thu Sep 13 17:21:32 2001
+++ linux/drivers/char/advantechwdt.c	Mon Dec 17 11:40:00 2001
@@ -20,6 +20,9 @@
  *
  *	(c) Copyright 1995    Alan Cox <alan@redhat.com>
  *
+ *      14-Dec-2001 Matt Domsch <Matt_Domsch@dell.com>
+ *          Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
+ *          Added timeout module option to override default
  */
 
 #include <linux/config.h>
@@ -56,8 +59,7 @@ static spinlock_t advwdt_lock;
  *	the manual says WDT_STOP is 0x43, not 0x443).
  *	(0x43 is also a write-only control register for the 8254 timer!)
  *
- *	TODO: module parameters to set the I/O port addresses and NOWAYOUT
- *	option at load time.
+ *	TODO: module parameters to set the I/O port addresses
  */
  
 #define WDT_STOP 0x443
@@ -65,6 +67,19 @@ static spinlock_t advwdt_lock;
 
 #define WD_TIMO 60		/* 1 minute */
 
+static int timeout = WD_TIMO;	/* in seconds */
+MODULE_PARM(timeout,"i");
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default=60)"); 
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
+MODULE_PARM(nowayout,"i");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
 /*
  *	Kernel methods.
  */
@@ -73,7 +88,7 @@ static void
 advwdt_ping(void)
 {
 	/* Write a watchdog value */
-	outb_p(WD_TIMO, WDT_START);
+	outb_p(timeout, WDT_START);
 }
 
 static ssize_t
@@ -135,6 +150,9 @@ advwdt_open(struct inode *inode, struct 
 				spin_unlock(&advwdt_lock);
 				return -EBUSY;
 			}
+			if (nowayout) {
+				MOD_INC_USE_COUNT;
+			}
 			/*
 			 *	Activate 
 			 */
@@ -154,9 +172,9 @@ advwdt_close(struct inode *inode, struct
 	lock_kernel();
 	if (MINOR(inode->i_rdev) == WATCHDOG_MINOR) {
 		spin_lock(&advwdt_lock);
-#ifndef CONFIG_WATCHDOG_NOWAYOUT	
+		if (!nowayout) {
 		inb_p(WDT_STOP);
-#endif		
+		}
 		advwdt_is_open = 0;
 		spin_unlock(&advwdt_lock);
 	}
@@ -209,11 +227,21 @@ static struct notifier_block advwdt_noti
 	0
 };
 
+static void __init
+advwdt_validate_timeout(void)
+{
+	if (timeout < 1 || timeout > 63) {
+		timeout = WD_TIMO;
+		printk(KERN_INFO "advantechwdt: timeout value must be 1 <= x <= 63, using %d\n", timeout);
+	}
+}
+
 static int __init
 advwdt_init(void)
 {
 	printk("WDT driver for Advantech single board computer initialising.\n");
 
+	advwdt_validate_timeout();
 	spin_lock_init(&advwdt_lock);
 	misc_register(&advwdt_miscdev);
 #if WDT_START != WDT_STOP
diff -burNp --exclude-from=/home/mdomsch/excludes linux-2.4.17-rc1/drivers/char/eurotechwdt.c linux/drivers/char/eurotechwdt.c
--- linux-2.4.17-rc1/drivers/char/eurotechwdt.c	Thu Oct 25 15:53:47 2001
+++ linux/drivers/char/eurotechwdt.c	Mon Dec 17 11:41:11 2001
@@ -20,6 +20,10 @@
  *      "AS-IS" and at no charge.
  *
  *      (c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>*
+ *
+ *      14-Dec-2001 Matt Domsch <Matt_Domsch@dell.com>
+ *          Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
+ *          Added timeout module option to override default
  */
 
 #include <linux/config.h>
@@ -45,7 +49,6 @@
 #include <linux/smp_lock.h>
 
 static int eurwdt_is_open;
-static int eurwdt_timeout; 
 static spinlock_t eurwdt_lock;
  
 /*
@@ -58,6 +61,18 @@ static int irq = 10;
 static char *ev = "int";
  
 #define WDT_TIMEOUT		60                /* 1 minute */
+static int timeout = WDT_TIMEOUT;
+
+MODULE_PARM(timeout,"i");
+MODULE_PARM_DESC(timeout, "Eurotech WDT timeout in seconds (default=60)"); 
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+MODULE_PARM(nowayout,"i");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 
 /*
@@ -116,6 +131,15 @@ MODULE_PARM_DESC(ev, "Eurotech WDT event
  *      Programming support
  */
 
+static void __init eurwdt_validate_timeout(void)
+{
+	if (timeout < 0 || timeout > 255) {
+		timeout = WDT_TIMEOUT;
+		printk(KERN_INFO "eurwdt: timeout must be 0 < x < 255, using %d\n",
+		       timeout);
+	}
+}
+
 static inline void eurwdt_write_reg(u8 index, u8 data)
 {
    outb(index, io);
@@ -189,7 +213,7 @@ void eurwdt_interrupt(int irq, void *dev
 static void eurwdt_ping(void)
 {
    /* Write the watchdog default value */
-   eurwdt_set_timeout(eurwdt_timeout);
+   eurwdt_set_timeout(timeout);
 }
  
 /**
@@ -263,7 +287,7 @@ static int eurwdt_ioctl(struct inode *in
          if (time < 0 || time > 255)
             return -EINVAL;
 
-         eurwdt_timeout = time; 
+         timeout = time; 
          eurwdt_set_timeout(time); 
          return 0;
    }
@@ -287,9 +311,11 @@ static int eurwdt_open(struct inode *ino
             spin_unlock(&eurwdt_lock);
             return -EBUSY;
          }
+	 if (nowayout) {
+		 MOD_INC_USE_COUNT;
+	 }
 
          eurwdt_is_open = 1;
-         eurwdt_timeout = WDT_TIMEOUT;   /* initial timeout */
 
          /* Activate the WDT */
          eurwdt_activate_timer(); 
@@ -323,14 +349,13 @@ static int eurwdt_open(struct inode *ino
 static int eurwdt_release(struct inode *inode, struct file *file)
 {
    if (MINOR(inode->i_rdev) == WATCHDOG_MINOR) {
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
+	   if (!nowayout) {
       eurwdt_disable_timer();
-#endif
+	   }
       eurwdt_is_open = 0;
 
       MOD_DEC_USE_COUNT;
    }
-
    return 0;
 }
  
@@ -423,6 +448,8 @@ static int __init eurwdt_init(void)
 {
    int ret;
  
+   eurwdt_validate_timeout();
+
    ret = misc_register(&eurwdt_miscdev);
    if (ret) {
       printk(KERN_ERR "eurwdt: can't misc_register on minor=%d\n",
diff -burNp --exclude-from=/home/mdomsch/excludes linux-2.4.17-rc1/drivers/char/i810-tco.c linux/drivers/char/i810-tco.c
--- linux-2.4.17-rc1/drivers/char/i810-tco.c	Thu Sep 13 17:21:32 2001
+++ linux/drivers/char/i810-tco.c	Mon Dec 17 11:41:40 2001
@@ -1,5 +1,5 @@
 /*
- *	i810-tco 0.02:	TCO timer driver for i810 chipsets
+ *	i810-tco 0.03:	TCO timer driver for i810 chipsets
  *
  *	(c) Copyright 2000 kernel concepts <nils@kernelconcepts.de>, All Rights Reserved.
  *				http://www.kernelconcepts.de
@@ -28,6 +28,9 @@
  *	Initial Version 0.01
  *  20000728 Nils Faerber
  *      0.02 Fix for SMI_EN->TCO_EN bit, some cleanups
+ *  20011214 Matt Domsch <Matt_Domsch@dell.com>
+ *      0.03 Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
+ *           Didn't add timeout option as i810_margin already exists.
  */
  
 #include <linux/module.h>
@@ -60,6 +63,18 @@ static spinlock_t tco_lock;	/* Guards th
 static int i810_margin = TIMER_MARGIN;	/* steps of 0.6sec */
 
 MODULE_PARM (i810_margin, "i");
+MODULE_PARM_DESC(i810_margin, "Watchdog timeout in steps of 0.6sec, 2<n<64. Default = 50 (30 seconds)");
+
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
+MODULE_PARM(nowayout,"i");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
 
 /*
  *	Timer active flag
@@ -167,6 +182,9 @@ static int i810tco_open (struct inode *i
 	if (timer_alive)
 		return -EBUSY;
 
+	if (nowayout) {
+		MOD_INC_USE_COUNT;
+	}
 	/*
 	 *      Reload and activate timer
 	 */
@@ -181,10 +199,10 @@ static int i810tco_release (struct inode
 	/*
 	 *      Shut off the timer.
 	 */
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
+	if (nowayout) {
 	tco_timer_stop ();
 	timer_alive = 0;
-#endif	
+	}
 	return 0;
 }
 
@@ -342,8 +360,8 @@ static int __init watchdog_init (void)
 	tco_timer_reload ();
 
 	printk (KERN_INFO
-		"i810 TCO timer: V0.02, timer margin: %d sec (0x%04x)\n",
-		(int) (i810_margin * 6 / 10), TCOBASE);
+		"i810 TCO timer: V0.03, timer margin: %d sec (0x%04x), nowayout: %d\n",
+		(int) (i810_margin * 6 / 10), TCOBASE, nowayout);
 	return 0;
 }
 
diff -burNp --exclude-from=/home/mdomsch/excludes linux-2.4.17-rc1/drivers/char/ib700wdt.c linux/drivers/char/ib700wdt.c
--- linux-2.4.17-rc1/drivers/char/ib700wdt.c	Thu Oct 11 11:07:00 2001
+++ linux/drivers/char/ib700wdt.c	Mon Dec 17 11:42:26 2001
@@ -25,6 +25,10 @@
  *
  *	(c) Copyright 1995    Alan Cox <alan@redhat.com>
  *
+ *      14-Dec-2001 Matt Domsch <Matt_Domsch@dell.com>
+ *           Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
+ *           Added timeout module option to override default
+ * 
  */
 
 #include <linux/config.h>
@@ -92,15 +96,36 @@ static spinlock_t ibwdt_lock;
 
 #define WD_TIMO 0		/* 30 seconds +/- 20%, from table */
 
+static int timeout_val = WD_TIMO;	/* value in table */
+static int timeout = 30;	        /* in seconds */
+MODULE_PARM(timeout,"i");
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds, 0 < n < 30, must be even (default=30)");
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
+MODULE_PARM(nowayout,"i");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
 /*
  *	Kernel methods.
  */
 
+static void __init
+ibwdt_validate_timeout(void)
+{
+	timeout_val = (30 - timeout) / 2;
+	if (timeout_val < 0 || timeout_val > 0xF) timeout_val = WD_TIMO;
+}
+
 static void
 ibwdt_ping(void)
 {
 	/* Write a watchdog value */
-	outb_p(WD_TIMO, WDT_START);
+	outb_p(timeout_val, WDT_START);
 }
 
 static ssize_t
@@ -162,6 +187,9 @@ ibwdt_open(struct inode *inode, struct f
 				spin_unlock(&ibwdt_lock);
 				return -EBUSY;
 			}
+			if (nowayout) {
+				MOD_INC_USE_COUNT;
+			}
 			/*
 			 *	Activate
 			 */
@@ -181,9 +209,9 @@ ibwdt_close(struct inode *inode, struct 
 	lock_kernel();
 	if (MINOR(inode->i_rdev) == WATCHDOG_MINOR) {
 		spin_lock(&ibwdt_lock);
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
-		outb_p(WD_TIMO, WDT_STOP);
-#endif
+		if (!nowayout) {
+			outb_p(timeout_val, WDT_STOP);
+		}
 		ibwdt_is_open = 0;
 		spin_unlock(&ibwdt_lock);
 	}
@@ -201,7 +229,7 @@ ibwdt_notify_sys(struct notifier_block *
 {
 	if (code == SYS_DOWN || code == SYS_HALT) {
 		/* Turn the WDT off */
-		outb_p(WD_TIMO, WDT_STOP);
+		outb_p(timeout_val, WDT_STOP);
 	}
 	return NOTIFY_DONE;
 }
@@ -241,6 +269,7 @@ ibwdt_init(void)
 {
 	printk("WDT driver for IB700 single board computer initialising.\n");
 
+	ibwdt_validate_timeout();
 	spin_lock_init(&ibwdt_lock);
 	misc_register(&ibwdt_miscdev);
 #if WDT_START != WDT_STOP
diff -burNp --exclude-from=/home/mdomsch/excludes linux-2.4.17-rc1/drivers/char/machzwd.c linux/drivers/char/machzwd.c
--- linux-2.4.17-rc1/drivers/char/machzwd.c	Thu Sep 13 17:21:32 2001
+++ linux/drivers/char/machzwd.c	Mon Dec 17 11:23:31 2001
@@ -24,6 +24,8 @@
  *  a system RESET and it starts wd#2 that unconditionaly will RESET 
  *  the system when the counter reaches zero.
  *
+ *  14-Dec-2001 Matt Domsch <Matt_Domsch@dell.com>
+ *      Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
  */
 
 #include <linux/config.h>
@@ -103,6 +105,16 @@ MODULE_LICENSE("GPL");
 MODULE_PARM(action, "i");
 MODULE_PARM_DESC(action, "after watchdog resets, generate: 0 = RESET(*)  1 = SMI  2 = NMI  3 = SCI");
 
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
+MODULE_PARM(nowayout,"i");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
+
 #define PFX "machzwd"
 
 static struct watchdog_info zf_info = {
@@ -307,7 +319,7 @@ static ssize_t zf_write(struct file *fil
  * no need to check for close confirmation
  * no way to disable watchdog ;)
  */
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
+		if (!nowayout) {
 		size_t ofs;
 
 		/* 
@@ -323,7 +335,7 @@ static ssize_t zf_write(struct file *fil
 				dprintk("zf_expect_close 1\n");
 			}
 		}
-#endif
+		}
 		/*
 		 * Well, anyhow someone wrote to us,
 		 * we should return that favour
@@ -386,9 +398,9 @@ static int zf_open(struct inode *inode, 
 				return -EBUSY;
 			}
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
+			if (nowayout) {
 			MOD_INC_USE_COUNT;
-#endif
+			}
 			zf_is_open = 1;
 
 			spin_unlock(&zf_lock);
diff -burNp --exclude-from=/home/mdomsch/excludes linux-2.4.17-rc1/drivers/char/mixcomwd.c linux/drivers/char/mixcomwd.c
--- linux-2.4.17-rc1/drivers/char/mixcomwd.c	Thu Sep 13 17:21:32 2001
+++ linux/drivers/char/mixcomwd.c	Mon Dec 17 11:44:09 2001
@@ -28,9 +28,12 @@
  * Version 0.4 (99/11/15):
  *		- support for one more type board
  *	
+ * Version 0.5 (2001/12/14) Matt Domsch <Matt_Domsch@dell.com>
+ *              - added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
+ *	
  */
 
-#define VERSION "0.4" 
+#define VERSION "0.5" 
   
 #include <linux/module.h>
 #include <linux/config.h>
@@ -57,26 +60,30 @@ static int mixcomwd_ioports[] = { 0x180,
 static long mixcomwd_opened; /* long req'd for setbit --RR */
 
 static int watchdog_port;
-
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
 static int mixcomwd_timer_alive;
 static struct timer_list mixcomwd_timer;
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
 #endif
 
+MODULE_PARM(nowayout,"i");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
 static void mixcomwd_ping(void)
 {
 	outb_p(55,watchdog_port);
 	return;
 }
 
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
 static void mixcomwd_timerfun(unsigned long d)
 {
 	mixcomwd_ping();
 	
 	mod_timer(&mixcomwd_timer,jiffies+ 5*HZ);
 }
-#endif
 
 /*
  *	Allow only one person to hold it open
@@ -89,12 +96,14 @@ static int mixcomwd_open(struct inode *i
 	}
 	mixcomwd_ping();
 	
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
+	if (nowayout) {
+		MOD_INC_USE_COUNT;
+	} else {
 	if(mixcomwd_timer_alive) {
 		del_timer(&mixcomwd_timer);
 		mixcomwd_timer_alive=0;
 	} 
-#endif
+	}
 	return 0;
 }
 
@@ -102,7 +111,7 @@ static int mixcomwd_release(struct inode
 {
 
 	lock_kernel();
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
+	if (!nowayout) {
 	if(mixcomwd_timer_alive) {
 		printk(KERN_ERR "mixcomwd: release called while internal timer alive");
 		unlock_kernel();
@@ -114,7 +123,7 @@ static int mixcomwd_release(struct inode
 	mixcomwd_timer.data=0;
 	mixcomwd_timer_alive=1;
 	add_timer(&mixcomwd_timer);
-#endif
+	}
 
 	clear_bit(0,&mixcomwd_opened);
 	unlock_kernel();
@@ -148,9 +157,9 @@ static int mixcomwd_ioctl(struct inode *
 	{
 		case WDIOC_GETSTATUS:
 			status=mixcomwd_opened;
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
+			if (!nowayout) {
 			status|=mixcomwd_timer_alive;
-#endif
+			}
 			if (copy_to_user((int *)arg, &status, sizeof(int))) {
 				return -EFAULT;
 			}
@@ -255,14 +264,14 @@ static int __init mixcomwd_init(void)
 
 static void __exit mixcomwd_exit(void)
 {
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
+	if (!nowayout) {
 	if(mixcomwd_timer_alive) {
 		printk(KERN_WARNING "mixcomwd: I quit now, hardware will"
 			" probably reboot!\n");
 		del_timer(&mixcomwd_timer);
 		mixcomwd_timer_alive=0;
 	}
-#endif
+	}
 	release_region(watchdog_port,1);
 	misc_deregister(&mixcomwd_miscdev);
 }
diff -burNp --exclude-from=/home/mdomsch/excludes linux-2.4.17-rc1/drivers/char/pcwd.c linux/drivers/char/pcwd.c
--- linux-2.4.17-rc1/drivers/char/pcwd.c	Thu Sep 13 17:21:32 2001
+++ linux/drivers/char/pcwd.c	Mon Dec 17 11:45:36 2001
@@ -40,6 +40,8 @@
  *		fairly useless proc entry.
  * 990610	removed said useless proc code for the merge <alan>
  * 000403	Removed last traces of proc code. <davej>
+ * 011214	Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT <Matt_Domsch@dell.com>
+ *              Added timeout module option to override default
  */
 
 #include <linux/module.h>
@@ -76,7 +78,7 @@
  */
 static int pcwd_ioports[] = { 0x270, 0x350, 0x370, 0x000 };
 
-#define WD_VER                  "1.10 (06/05/99)"
+#define WD_VER                  "1.12 (12/14/2001)"
 
 /*
  * It should be noted that PCWD_REVISION_B was removed because A and B
@@ -88,7 +90,22 @@ static int pcwd_ioports[] = { 0x270, 0x3
 #define	PCWD_REVISION_A		1
 #define	PCWD_REVISION_C		2
 
-#define	WD_TIMEOUT		3	/* 1 1/2 seconds for a timeout */
+#define	WD_TIMEOUT		4	/* 2 seconds for a timeout */
+static int timeout_val = WD_TIMEOUT;
+static int timeout = 2;
+
+MODULE_PARM(timeout,"i");
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default=2)"); 
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
+MODULE_PARM(nowayout,"i");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
 
 /*
  * These are the defines for the PC Watchdog card, revision A.
@@ -126,7 +143,7 @@ static int __init pcwd_checkcard(void)
 	if (prev_card_dat == 0xFF)
 		return 0;
 
-	while(count < WD_TIMEOUT) {
+	while(count < timeout_val) {
 
 	/* Read the raw card data from the port, and strip off the
 	   first 4 bits */
@@ -454,7 +471,7 @@ static int pcwd_close(struct inode *ino,
 	{
 		lock_kernel();
 	        is_open = 0;
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
+		if (!nowayout) {
 		/*  Disable the board  */
 		if (revision == PCWD_REVISION_C) {
 			spin_lock(&io_lock);
@@ -462,7 +479,7 @@ static int pcwd_close(struct inode *ino,
 			outb_p(0xA5, current_readport + 3);
 			spin_unlock(&io_lock);
 		}
-#endif
+		}
 		unlock_kernel();
 	}
 	return 0;
@@ -564,9 +581,15 @@ static struct miscdevice temp_miscdev = 
 	&pcwd_fops
 };
  
+static void __init pcwd_validate_timeout(void)
+{
+	timeout_val = timeout * 2;
+}
+ 
 static int __init pcwatchdog_init(void)
 {
 	int i, found = 0;
+	pcwd_validate_timeout();
 	spin_lock_init(&io_lock);
 	
 	revision = PCWD_REVISION_A;
diff -burNp --exclude-from=/home/mdomsch/excludes linux-2.4.17-rc1/drivers/char/sbc60xxwdt.c linux/drivers/char/sbc60xxwdt.c
--- linux-2.4.17-rc1/drivers/char/sbc60xxwdt.c	Thu Sep 13 17:21:32 2001
+++ linux/drivers/char/sbc60xxwdt.c	Mon Dec 17 11:45:54 2001
@@ -109,6 +109,15 @@ static unsigned long next_heartbeat;
 static int wdt_is_open;
 static int wdt_expect_close;
 
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
+MODULE_PARM(nowayout,"i");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
 /*
  *	Whack the dog
  */
@@ -202,6 +211,9 @@ static int fop_open(struct inode * inode
 			/* Just in case we're already talking to someone... */
 			if(wdt_is_open)
 				return -EBUSY;
+			if (nowayout) {
+				MOD_INC_USE_COUNT;
+			}
 			/* Good, fire up the show */
 			wdt_is_open = 1;
 			wdt_startup();
@@ -217,7 +229,7 @@ static int fop_close(struct inode * inod
 	lock_kernel();
 	if(MINOR(inode->i_rdev) == WATCHDOG_MINOR) 
 	{
-		if(wdt_expect_close)
+		if(wdt_expect_close && !nowayout)
 			wdt_turnoff();
 		else {
 			del_timer(&timer);
diff -burNp --exclude-from=/home/mdomsch/excludes linux-2.4.17-rc1/drivers/char/shwdt.c linux/drivers/char/shwdt.c
--- linux-2.4.17-rc1/drivers/char/shwdt.c	Mon Oct 15 15:36:48 2001
+++ linux/drivers/char/shwdt.c	Mon Dec 17 11:46:24 2001
@@ -9,6 +9,9 @@
  * under the terms of the GNU General Public License as published by the
  * Free Software Foundation; either version 2 of the License, or (at your
  * option) any later version.
+ *
+ * 14-Dec-2001 Matt Domsch <Matt_Domsch@dell.com>
+ *     Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
  */
 
 #include <linux/config.h>
@@ -61,6 +64,15 @@
 static int sh_is_open = 0;
 static struct watchdog_info sh_wdt_info;
 
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
+MODULE_PARM(nowayout,"i");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
 /**
  *	sh_wdt_write_cnt - Write to Counter
  *
@@ -137,6 +149,9 @@ static int sh_wdt_open(struct inode *ino
 			if (sh_is_open) {
 				return -EBUSY;
 			}
+			if (nowayout) {
+				MOD_INC_USE_COUNT;
+			}
 
 			sh_is_open = 1;
 			sh_wdt_start();
@@ -162,9 +177,9 @@ static int sh_wdt_close(struct inode *in
 	lock_kernel();
 	
 	if (MINOR(inode->i_rdev) == WATCHDOG_MINOR) {
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
+		if (!nowayout) {
 		sh_wdt_stop();
-#endif
+		}
 		sh_is_open = 0;
 	}
 	
diff -burNp --exclude-from=/home/mdomsch/excludes linux-2.4.17-rc1/drivers/char/softdog.c linux/drivers/char/softdog.c
--- linux-2.4.17-rc1/drivers/char/softdog.c	Sun Sep 30 14:26:05 2001
+++ linux/drivers/char/softdog.c	Mon Dec 17 10:12:29 2001
@@ -1,5 +1,5 @@
 /*
- *	SoftDog	0.05:	A Software Watchdog Device
+ *	SoftDog	0.06:	A Software Watchdog Device
  *
  *	(c) Copyright 1996 Alan Cox <alan@redhat.com>, All Rights Reserved.
  *				http://www.redhat.com
@@ -26,6 +26,10 @@
  *
  *  19980911 Alan Cox
  *	Made SMP safe for 2.3.x
+ *
+ *  20011214 Matt Domsch <Matt_Domsch@dell.com>
+ *      Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
+ *      Didn't add timeout option, as soft_margin option already exists.
  */
  
 #include <linux/module.h>
@@ -46,6 +50,15 @@
 static int soft_margin = TIMER_MARGIN;	/* in seconds */
 
 MODULE_PARM(soft_margin,"i");
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
+MODULE_PARM(nowayout,"i");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 MODULE_LICENSE("GPL");
 
 /*
@@ -83,9 +96,9 @@ static int softdog_open(struct inode *in
 {
 	if(timer_alive)
 		return -EBUSY;
-#ifdef CONFIG_WATCHDOG_NOWAYOUT	 
+	if (nowayout) {
 	MOD_INC_USE_COUNT;
-#endif	
+	}
 	/*
 	 *	Activate timer
 	 */
@@ -98,12 +111,12 @@ static int softdog_release(struct inode 
 {
 	/*
 	 *	Shut off the timer.
-	 * 	Lock it in if it's a module and we defined ...NOWAYOUT
+	 * 	Lock it in if it's a module and we set nowayout
 	 */
 	 lock_kernel();
-#ifndef CONFIG_WATCHDOG_NOWAYOUT	 
+	 if(!nowayout) {
 	del_timer(&watchdog_ticktock);
-#endif	
+	 }
 	timer_alive=0;
 	unlock_kernel();
 	return 0;
@@ -161,7 +174,7 @@ static struct miscdevice softdog_miscdev
 	fops:		&softdog_fops,
 };
 
-static char banner[] __initdata = KERN_INFO "Software Watchdog Timer: 0.05, timer margin: %d sec\n";
+static char banner[] __initdata = KERN_INFO "Software Watchdog Timer: 0.06, soft_margin: %d sec, nowayout: %d\n";
 
 static int __init watchdog_init(void)
 {
@@ -172,7 +185,7 @@ static int __init watchdog_init(void)
 	if (ret)
 		return ret;
 
-	printk(banner, soft_margin);
+	printk(banner, soft_margin, nowayout);
 
 	return 0;
 }
diff -burNp --exclude-from=/home/mdomsch/excludes linux-2.4.17-rc1/drivers/char/wdt.c linux/drivers/char/wdt.c
--- linux-2.4.17-rc1/drivers/char/wdt.c	Fri Sep  7 11:28:38 2001
+++ linux/drivers/char/wdt.c	Mon Dec 17 11:47:30 2001
@@ -15,7 +15,7 @@
  *
  *	(c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
  *
- *	Release 0.08.
+ *	Release 0.09.
  *
  *	Fixes
  *		Dave Gregorich	:	Modularisation and minor bugs
@@ -27,6 +27,7 @@
  *		Tim Hockin	:	Added insmod parameters, comment cleanup
  *					Parameterized timeout
  *		Tigran Aivazian	:	Restructured wdt_init() to handle failures
+ *		Matt Domsch	:	added nowayout and timeout module options
  */
 
 #include <linux/config.h>
@@ -62,6 +63,26 @@ static int irq=11;
 
 #define WD_TIMO (100*60)		/* 1 minute */
 
+static int timeout_val = WD_TIMO;	/* value passed to card */
+static int timeout = 60;	        /* in seconds */
+MODULE_PARM(timeout,"i");
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default=60)");
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
+MODULE_PARM(nowayout,"i");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
+static void __init
+wdt_validate_timeout(void)
+{
+	timeout_val = timeout * 100;
+}
+
 #ifndef MODULE
 
 /**
@@ -216,7 +237,7 @@ static void wdt_ping(void)
 	/* Write a watchdog value */
 	inb_p(WDT_DC);
 	wdt_ctr_mode(1,2);
-	wdt_ctr_load(1,WD_TIMO);		/* Timeout */
+	wdt_ctr_load(1,timeout_val);		/* Timeout */
 	outb_p(0, WDT_DC);
 }
 
@@ -339,6 +360,9 @@ static int wdt_open(struct inode *inode,
 		case WATCHDOG_MINOR:
 			if(wdt_is_open)
 				return -EBUSY;
+			if (nowayout) {
+				MOD_INC_USE_COUNT;
+			}
 			/*
 			 *	Activate 
 			 */
@@ -349,7 +373,7 @@ static int wdt_open(struct inode *inode,
 			wdt_ctr_mode(1,2);
 			wdt_ctr_mode(2,0);
 			wdt_ctr_load(0, 8948);		/* count at 100Hz */
-			wdt_ctr_load(1,WD_TIMO);	/* Timeout 120 seconds */
+			wdt_ctr_load(1,timeout_val);	/* Timeout */
 			wdt_ctr_load(2,65535);
 			outb_p(0, WDT_DC);	/* Enable */
 			return 0;
@@ -377,10 +401,10 @@ static int wdt_release(struct inode *ino
 	lock_kernel();
 	if(MINOR(inode->i_rdev)==WATCHDOG_MINOR)
 	{
-#ifndef CONFIG_WATCHDOG_NOWAYOUT	
+		if (!nowayout) {
 		inb_p(WDT_DC);		/* Disable counters */
 		wdt_ctr_load(2,0);	/* 0 length reset pulses now */
-#endif		
+		}
 		wdt_is_open=0;
 	}
 	unlock_kernel();
@@ -487,6 +511,7 @@ static int __init wdt_init(void)
 {
 	int ret;
 
+	wdt_validate_timeout();
 	ret = misc_register(&wdt_miscdev);
 	if (ret) {
 		printk(KERN_ERR "wdt: can't misc_register on minor=%d\n", WATCHDOG_MINOR);
diff -burNp --exclude-from=/home/mdomsch/excludes linux-2.4.17-rc1/drivers/char/wdt977.c linux/drivers/char/wdt977.c
--- linux-2.4.17-rc1/drivers/char/wdt977.c	Fri Sep  7 11:28:38 2001
+++ linux/drivers/char/wdt977.c	Fri Dec 14 16:15:45 2001
@@ -1,5 +1,5 @@
 /*
- *	Wdt977	0.01:	A Watchdog Device for Netwinder W83977AF chip
+ *	Wdt977	0.02:	A Watchdog Device for Netwinder W83977AF chip
  *
  *	(c) Copyright 1998 Rebel.com (Woody Suwalski <woody@netwinder.org>)
  *
@@ -11,6 +11,8 @@
  *	2 of the License, or (at your option) any later version.
  *
  *			-----------------------
+ *      14-Dec-2001 Matt Domsch <Matt_Domsch@dell.com>
+ *           Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
  */
  
 #include <linux/module.h>
@@ -32,6 +34,16 @@ static	int timeout = 3;
 static	int timer_alive;
 static	int testmode;
 
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
+MODULE_PARM(nowayout,"i");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
+
 /*
  *	Allow only one person to hold it open
  */
@@ -40,9 +52,9 @@ static int wdt977_open(struct inode *ino
 {
 	if(timer_alive)
 		return -EBUSY;
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
+	if (nowayout) {
 	MOD_INC_USE_COUNT;
-#endif
+	}
 	timer_alive++;
 
 	//max timeout value = 255 minutes (0xFF). Write 0 to disable WatchDog.
@@ -89,9 +101,9 @@ static int wdt977_release(struct inode *
 {
 	/*
 	 *	Shut off the timer.
-	 * 	Lock it in if it's a module and we defined ...NOWAYOUT
+	 * 	Lock it in if it's a module and we set nowayout
 	 */
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
+	if (!nowayout) {
 	lock_kernel();
 
 	// unlock the SuperIO chip
@@ -127,7 +139,7 @@ static int wdt977_release(struct inode *
 	unlock_kernel();
 
 	printk(KERN_INFO "Watchdog: shutdown.\n");
-#endif
+	}
 	return 0;
 }
 
diff -burNp --exclude-from=/home/mdomsch/excludes linux-2.4.17-rc1/drivers/char/wdt_pci.c linux/drivers/char/wdt_pci.c
--- linux-2.4.17-rc1/drivers/char/wdt_pci.c	Fri Sep  7 11:28:38 2001
+++ linux/drivers/char/wdt_pci.c	Mon Dec 17 11:37:08 2001
@@ -15,7 +15,7 @@
  *
  *	(c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
  *
- *	Release 0.08.
+ *	Release 0.09.
  *
  *	Fixes
  *		Dave Gregorich	:	Modularisation and minor bugs
@@ -30,6 +30,7 @@
  *		Alan Cox	:	Split ISA and PCI cards into two drivers
  *		Jeff Garzik	:	PCI cleanups
  *		Tigran Aivazian	:	Restructured wdtpci_init_one() to handle failures
+ *		Matt Domsch	:	added nowayout and timeout module options
  */
 
 #include <linux/config.h>
@@ -83,6 +84,26 @@ static int irq=11;
 
 #define WD_TIMO (100*60)		/* 1 minute */
 
+static int timeout_val = WD_TIMO;	/* value passed to card */
+static int timeout = 60;	        /* in seconds */
+MODULE_PARM(timeout,"i");
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default=60)");
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
+MODULE_PARM(nowayout,"i");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
+static void __init
+wdtpci_validate_timeout(void)
+{
+	timeout_val = timeout * 100;
+}
+
 #ifndef MODULE
 
 /**
@@ -232,7 +253,7 @@ static void wdtpci_ping(void)
 	/* Write a watchdog value */
 	inb_p(WDT_DC);
 	wdtpci_ctr_mode(1,2);
-	wdtpci_ctr_load(1,WD_TIMO);		/* Timeout */
+	wdtpci_ctr_load(1,timeout_val);		/* Timeout */
 	outb_p(0, WDT_DC);
 }
 
@@ -355,9 +376,9 @@ static int wdtpci_open(struct inode *ino
 		case WATCHDOG_MINOR:
 			if(wdt_is_open)
 				return -EBUSY;
-#ifdef CONFIG_WATCHDOG_NOWAYOUT	
+			if (nowayout) {
 			MOD_INC_USE_COUNT;
-#endif
+			}
 			/*
 			 *	Activate 
 			 */
@@ -385,7 +406,7 @@ static int wdtpci_open(struct inode *ino
 			wdtpci_ctr_mode(1,2);
 			wdtpci_ctr_mode(2,1);
 			wdtpci_ctr_load(0,20833);	/* count at 100Hz */
-			wdtpci_ctr_load(1,WD_TIMO);/* Timeout 60 seconds */
+			wdtpci_ctr_load(1,timeout_val); /* Timeout */
 			/* DO NOT LOAD CTR2 on PCI card! -- JPN */
 			outb_p(0, WDT_DC);	/* Enable */
 			return 0;
@@ -413,10 +434,10 @@ static int wdtpci_release(struct inode *
 	if(MINOR(inode->i_rdev)==WATCHDOG_MINOR)
 	{
 		lock_kernel();
-#ifndef CONFIG_WATCHDOG_NOWAYOUT	
+		if (!nowayout) {
 		inb_p(WDT_DC);		/* Disable counters */
 		wdtpci_ctr_load(2,0);	/* 0 length reset pulses now */
-#endif		
+		}
 		wdt_is_open=0;
 		unlock_kernel();
 	}
@@ -620,6 +641,8 @@ static int __init wdtpci_init(void)
 	if (rc < 1)
 		return -ENODEV;
 	
+	wdtpci_validate_timeout();
+	
 	return 0;
 }
 

