Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290135AbSAKWEu>; Fri, 11 Jan 2002 17:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290136AbSAKWEh>; Fri, 11 Jan 2002 17:04:37 -0500
Received: from smtp3.us.dell.com ([143.166.224.253]:1288 "EHLO
	smtp3.us.dell.com") by vger.kernel.org with ESMTP
	id <S290135AbSAKWEV>; Fri, 11 Jan 2002 17:04:21 -0500
Date: Fri, 11 Jan 2002 16:01:53 -0600 (CST)
From: Matt Domsch <Matt_Domsch@dell.com>
X-X-Sender: <mdomsch@localhost.localdomain>
Reply-To: Matt Domsch <Matt_Domsch@dell.com>
To: "'Marcelo Tosatti'" <marcelo@conectiva.com.br>
cc: <alan@redhat.com>, <nils@kernelconcepts.de>, <giometti@ascensit.com>,
        <pb@nexus.co.uk>, <chowes@vsol.net>, <gorgo@itc.hu>, <info@itc.hu>,
        <lethal@chaoticdreams.org>, <woody@netwinder.org>,
        <khollis@bitgate.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.18-pre3: watchdog nowayout and timeout module paramet
 ers
Message-ID: <71714C04806CD511935200902728921702E3A4-100000@ausxmrr502.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I needed a way to set the software watchdog timer to use a runtime-set
"no way out" value instead of only CONFIG_WATCHDOG_NOWAYOUT.  Rather
than modify only softdog.o, Alan Cox suggested I modify all the
watchdog drivers.  Accordingly, the patch is below and posted to
http://domsch.com/linux/patches/linux-2.4.18-pre3-watchdog-nowayout-2002
0111.patch.gz.

Most drivers were modified to add a 'nowayout=[01]' module parameter
which defaults to CONFIG_WATCHDOG_NOWAYOUT if not passed.  wdt285.c
wasn't written to allow a way out at all, so it wasn't modified.

To the following drivers was also added a 'timeout=X' module
parameter, where timeout is specified in seconds.  Only drivers for
which no similar parm was already present were modified:
advantechwdt.c (marekm@linux.org.pl)
eurotechwdt.c  (giometti@ascensit.com)
ib700wdt.c     (chowes@vsol.net)
pcwd.c         (khollis@bitgate.com)
wdt.c		   (alan@redhat.com)
wdt_pci.c	   (alan@redhat.com)
wdt977.c   (woody@netwinder.org made the changes himself, also added set
timeout via ioctl)

These already offer a timeout parm:
i810-tco.c (nils@kernelconcepts.de)
softdog.c  (alan@redhat.com)
wdt285.o   (pb@nexus.co.uk)

These didn't get a timeout parm because it wasn't obvious if or how it
could be done:
acquirewdt.c (alan@redhat.com)
machzwd.c  (fuganti@conectiva.com.br - does not exist)
mixcomwd.c (gorgo@itc.hu, info@itc.hu)
shwdt.c    (lethal@chaoticdreams.org)

I'm sending the corresponding patch to Linus to apply to 2.5.2-pre11
as well.  Marcelo, please apply.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
#1 US Linux Server provider with 24.5% (IDC Dec 2001)
#2 Worldwide Linux Server provider with 18.2% (IDC Dec 2001)


 acquirewdt.c   |   21 ++-
 advantechwdt.c |   42 +++++--
 eurotechwdt.c  |   49 ++++++--
 i810-tco.c     |   32 ++++-
 ib700wdt.c     |   39 +++++-
 machzwd.c      |   48 +++++---
 mixcomwd.c     |   75 +++++++-----
 pcwd.c         |   45 +++++--
 sbc60xxwdt.c   |   14 ++
 shwdt.c        |   21 +++
 softdog.c      |   33 +++--
 wdt.c          |   41 +++++-
 wdt977.c       |  341 +++++++++++++++++++++++++++++++++++++-----------------
 wdt_pci.c      |   43 +++++--
 14 files changed, 619 insertions(+), 225 deletions(-)

diff -BurNp --exclude-from=/home/mdomsch/excludes linux-2.4.18-pre3/drivers/char/acquirewdt.c linux/drivers/char/acquirewdt.c
--- linux-2.4.18-pre3/drivers/char/acquirewdt.c	Thu Sep 13 17:21:32 2001
+++ linux/drivers/char/acquirewdt.c	Fri Jan 11 15:20:07 2002
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
-		inb_p(WDT_STOP);
-#endif		
+		if (!nowayout) {
+			inb_p(WDT_STOP);
+		}
 		acq_is_open=0;
 		spin_unlock(&acq_lock);
 	}
diff -BurNp --exclude-from=/home/mdomsch/excludes linux-2.4.18-pre3/drivers/char/advantechwdt.c linux/drivers/char/advantechwdt.c
--- linux-2.4.18-pre3/drivers/char/advantechwdt.c	Thu Sep 13 17:21:32 2001
+++ linux/drivers/char/advantechwdt.c	Fri Jan 11 15:20:07 2002
@@ -19,7 +19,10 @@
  *	"AS-IS" and at no charge.	
  *
  *	(c) Copyright 1995    Alan Cox <alan@redhat.com>
- *
+ * 
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
-		inb_p(WDT_STOP);
-#endif		
+		if (!nowayout) {
+			inb_p(WDT_STOP);
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
diff -BurNp --exclude-from=/home/mdomsch/excludes linux-2.4.18-pre3/drivers/char/eurotechwdt.c linux/drivers/char/eurotechwdt.c
--- linux-2.4.18-pre3/drivers/char/eurotechwdt.c	Thu Oct 25 15:53:47 2001
+++ linux/drivers/char/eurotechwdt.c	Fri Jan 11 15:20:07 2002
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
-      eurwdt_disable_timer();
-#endif
-      eurwdt_is_open = 0;
+	   if (!nowayout) {
+		   eurwdt_disable_timer();
+	   }
+	   eurwdt_is_open = 0;
 
-      MOD_DEC_USE_COUNT;
+	   MOD_DEC_USE_COUNT;
    }
-
    return 0;
 }
  
@@ -422,7 +447,9 @@ static void __exit eurwdt_exit(void)
 static int __init eurwdt_init(void)
 {
    int ret;
- 
+
+   eurwdt_validate_timeout();
+
    ret = misc_register(&eurwdt_miscdev);
    if (ret) {
       printk(KERN_ERR "eurwdt: can't misc_register on minor=%d\n",
diff -BurNp --exclude-from=/home/mdomsch/excludes linux-2.4.18-pre3/drivers/char/i810-tco.c linux/drivers/char/i810-tco.c
--- linux-2.4.18-pre3/drivers/char/i810-tco.c	Thu Sep 13 17:21:32 2001
+++ linux/drivers/char/i810-tco.c	Fri Jan 11 15:20:07 2002
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
-	tco_timer_stop ();
-	timer_alive = 0;
-#endif	
+	if (nowayout) {
+		tco_timer_stop ();
+		timer_alive = 0;
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
 
diff -BurNp --exclude-from=/home/mdomsch/excludes linux-2.4.18-pre3/drivers/char/ib700wdt.c linux/drivers/char/ib700wdt.c
--- linux-2.4.18-pre3/drivers/char/ib700wdt.c	Thu Oct 11 11:07:00 2001
+++ linux/drivers/char/ib700wdt.c	Fri Jan 11 15:20:07 2002
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
diff -BurNp --exclude-from=/home/mdomsch/excludes linux-2.4.18-pre3/drivers/char/machzwd.c linux/drivers/char/machzwd.c
--- linux-2.4.18-pre3/drivers/char/machzwd.c	Thu Sep 13 17:21:32 2001
+++ linux/drivers/char/machzwd.c	Fri Jan 11 15:20:07 2002
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
@@ -307,23 +319,23 @@ static ssize_t zf_write(struct file *fil
  * no need to check for close confirmation
  * no way to disable watchdog ;)
  */
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
-		size_t ofs;
-
-		/* 
-		 * note: just in case someone wrote the magic character
-		 * five months ago...
-		 */
-		zf_expect_close = 0;
-
-		/* now scan */
-		for(ofs = 0; ofs != count; ofs++){
-			if(buf[ofs] == 'V'){
-				zf_expect_close = 1;
-				dprintk("zf_expect_close 1\n");
+		if (!nowayout) {
+			size_t ofs;
+			
+			/* 
+			 * note: just in case someone wrote the magic character
+			 * five months ago...
+			 */
+			zf_expect_close = 0;
+			
+			/* now scan */
+			for(ofs = 0; ofs != count; ofs++){
+				if(buf[ofs] == 'V'){
+					zf_expect_close = 1;
+					dprintk("zf_expect_close 1\n");
+				}
 			}
 		}
-#endif
 		/*
 		 * Well, anyhow someone wrote to us,
 		 * we should return that favour
@@ -386,9 +398,9 @@ static int zf_open(struct inode *inode, 
 				return -EBUSY;
 			}
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-			MOD_INC_USE_COUNT;
-#endif
+			if (nowayout) {
+				MOD_INC_USE_COUNT;
+			}
 			zf_is_open = 1;
 
 			spin_unlock(&zf_lock);
diff -BurNp --exclude-from=/home/mdomsch/excludes linux-2.4.18-pre3/drivers/char/mixcomwd.c linux/drivers/char/mixcomwd.c
--- linux-2.4.18-pre3/drivers/char/mixcomwd.c	Thu Sep 13 17:21:32 2001
+++ linux/drivers/char/mixcomwd.c	Fri Jan 11 15:20:07 2002
@@ -27,10 +27,13 @@
  *
  * Version 0.4 (99/11/15):
  *		- support for one more type board
+ *
+ * Version 0.5 (2001/12/14) Matt Domsch <Matt_Domsch@dell.com>
+ *              - added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
  *	
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
-	if(mixcomwd_timer_alive) {
-		del_timer(&mixcomwd_timer);
-		mixcomwd_timer_alive=0;
-	} 
-#endif
+	if (nowayout) {
+		MOD_INC_USE_COUNT;
+	} else {
+		if(mixcomwd_timer_alive) {
+			del_timer(&mixcomwd_timer);
+			mixcomwd_timer_alive=0;
+		}
+	}
 	return 0;
 }
 
@@ -102,19 +111,19 @@ static int mixcomwd_release(struct inode
 {
 
 	lock_kernel();
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
-	if(mixcomwd_timer_alive) {
-		printk(KERN_ERR "mixcomwd: release called while internal timer alive");
-		unlock_kernel();
-		return -EBUSY;
+	if (!nowayout) {
+		if(mixcomwd_timer_alive) {
+			printk(KERN_ERR "mixcomwd: release called while internal timer alive");
+			unlock_kernel();
+			return -EBUSY;
+		}
+		init_timer(&mixcomwd_timer);
+		mixcomwd_timer.expires=jiffies + 5 * HZ;
+		mixcomwd_timer.function=mixcomwd_timerfun;
+		mixcomwd_timer.data=0;
+		mixcomwd_timer_alive=1;
+		add_timer(&mixcomwd_timer);
 	}
-	init_timer(&mixcomwd_timer);
-	mixcomwd_timer.expires=jiffies + 5 * HZ;
-	mixcomwd_timer.function=mixcomwd_timerfun;
-	mixcomwd_timer.data=0;
-	mixcomwd_timer_alive=1;
-	add_timer(&mixcomwd_timer);
-#endif
 
 	clear_bit(0,&mixcomwd_opened);
 	unlock_kernel();
@@ -148,9 +157,9 @@ static int mixcomwd_ioctl(struct inode *
 	{
 		case WDIOC_GETSTATUS:
 			status=mixcomwd_opened;
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
-			status|=mixcomwd_timer_alive;
-#endif
+			if (!nowayout) {
+				status|=mixcomwd_timer_alive;
+			}
 			if (copy_to_user((int *)arg, &status, sizeof(int))) {
 				return -EFAULT;
 			}
@@ -255,14 +264,14 @@ static int __init mixcomwd_init(void)
 
 static void __exit mixcomwd_exit(void)
 {
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
-	if(mixcomwd_timer_alive) {
-		printk(KERN_WARNING "mixcomwd: I quit now, hardware will"
-			" probably reboot!\n");
-		del_timer(&mixcomwd_timer);
-		mixcomwd_timer_alive=0;
+	if (!nowayout) {
+		if(mixcomwd_timer_alive) {
+			printk(KERN_WARNING "mixcomwd: I quit now, hardware will"
+			       " probably reboot!\n");
+			del_timer(&mixcomwd_timer);
+			mixcomwd_timer_alive=0;
+		}
 	}
-#endif
 	release_region(watchdog_port,1);
 	misc_deregister(&mixcomwd_miscdev);
 }
diff -BurNp --exclude-from=/home/mdomsch/excludes linux-2.4.18-pre3/drivers/char/pcwd.c linux/drivers/char/pcwd.c
--- linux-2.4.18-pre3/drivers/char/pcwd.c	Thu Sep 13 17:21:32 2001
+++ linux/drivers/char/pcwd.c	Fri Jan 11 15:20:07 2002
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
@@ -454,15 +471,15 @@ static int pcwd_close(struct inode *ino,
 	{
 		lock_kernel();
 	        is_open = 0;
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
-		/*  Disable the board  */
-		if (revision == PCWD_REVISION_C) {
-			spin_lock(&io_lock);
-			outb_p(0xA5, current_readport + 3);
-			outb_p(0xA5, current_readport + 3);
-			spin_unlock(&io_lock);
+		if (!nowayout) {
+			/*  Disable the board  */
+			if (revision == PCWD_REVISION_C) {
+				spin_lock(&io_lock);
+				outb_p(0xA5, current_readport + 3);
+				outb_p(0xA5, current_readport + 3);
+				spin_unlock(&io_lock);
+			}
 		}
-#endif
 		unlock_kernel();
 	}
 	return 0;
@@ -563,10 +580,16 @@ static struct miscdevice temp_miscdev = 
 	"temperature",
 	&pcwd_fops
 };
+
+static void __init pcwd_validate_timeout(void)
+{
+	timeout_val = timeout * 2;
+}
  
 static int __init pcwatchdog_init(void)
 {
 	int i, found = 0;
+	pcwd_validate_timeout();
 	spin_lock_init(&io_lock);
 	
 	revision = PCWD_REVISION_A;
diff -BurNp --exclude-from=/home/mdomsch/excludes linux-2.4.18-pre3/drivers/char/sbc60xxwdt.c linux/drivers/char/sbc60xxwdt.c
--- linux-2.4.18-pre3/drivers/char/sbc60xxwdt.c	Thu Sep 13 17:21:32 2001
+++ linux/drivers/char/sbc60xxwdt.c	Fri Jan 11 15:20:07 2002
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
diff -BurNp --exclude-from=/home/mdomsch/excludes linux-2.4.18-pre3/drivers/char/shwdt.c linux/drivers/char/shwdt.c
--- linux-2.4.18-pre3/drivers/char/shwdt.c	Fri Jan 11 15:18:01 2002
+++ linux/drivers/char/shwdt.c	Fri Jan 11 15:20:07 2002
@@ -9,6 +9,9 @@
  * under the terms of the GNU General Public License as published by the
  * Free Software Foundation; either version 2 of the License, or (at your
  * option) any later version.
+ *
+ * 14-Dec-2001 Matt Domsch <Matt_Domsch@dell.com>
+ *     Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
  */
 #include <linux/config.h>
 #include <linux/module.h>
@@ -60,6 +63,15 @@
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
@@ -136,6 +148,9 @@ static int sh_wdt_open(struct inode *ino
 			if (sh_is_open) {
 				return -EBUSY;
 			}
+			if (nowayout) {
+				MOD_INC_USE_COUNT;
+			}
 
 			sh_is_open = 1;
 			sh_wdt_start();
@@ -161,9 +176,9 @@ static int sh_wdt_close(struct inode *in
 	lock_kernel();
 	
 	if (MINOR(inode->i_rdev) == WATCHDOG_MINOR) {
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
-		sh_wdt_stop();
-#endif
+		if (!nowayout) {
+			sh_wdt_stop();
+		}
 		sh_is_open = 0;
 	}
 	
diff -BurNp --exclude-from=/home/mdomsch/excludes linux-2.4.18-pre3/drivers/char/softdog.c linux/drivers/char/softdog.c
--- linux-2.4.18-pre3/drivers/char/softdog.c	Sun Sep 30 14:26:05 2001
+++ linux/drivers/char/softdog.c	Fri Jan 11 15:20:07 2002
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
-	MOD_INC_USE_COUNT;
-#endif	
+	if (nowayout) {
+		MOD_INC_USE_COUNT;
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
-	del_timer(&watchdog_ticktock);
-#endif	
+	 if(!nowayout) {
+		 del_timer(&watchdog_ticktock);
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
diff -BurNp --exclude-from=/home/mdomsch/excludes linux-2.4.18-pre3/drivers/char/wdt.c linux/drivers/char/wdt.c
--- linux-2.4.18-pre3/drivers/char/wdt.c	Fri Sep  7 11:28:38 2001
+++ linux/drivers/char/wdt.c	Fri Jan 11 15:20:07 2002
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
-		inb_p(WDT_DC);		/* Disable counters */
-		wdt_ctr_load(2,0);	/* 0 length reset pulses now */
-#endif		
+		if (!nowayout) {
+			inb_p(WDT_DC);		/* Disable counters */
+			wdt_ctr_load(2,0);	/* 0 length reset pulses now */
+		}
 		wdt_is_open=0;
 	}
 	unlock_kernel();
@@ -486,7 +510,8 @@ static void __exit wdt_exit(void)
 static int __init wdt_init(void)
 {
 	int ret;
-
+	
+	wdt_validate_timeout();
 	ret = misc_register(&wdt_miscdev);
 	if (ret) {
 		printk(KERN_ERR "wdt: can't misc_register on minor=%d\n", WATCHDOG_MINOR);
diff -BurNp --exclude-from=/home/mdomsch/excludes linux-2.4.18-pre3/drivers/char/wdt977.c linux/drivers/char/wdt977.c
--- linux-2.4.18-pre3/drivers/char/wdt977.c	Fri Sep  7 11:28:38 2001
+++ linux/drivers/char/wdt977.c	Fri Jan 11 15:21:29 2002
@@ -1,5 +1,5 @@
 /*
- *	Wdt977	0.01:	A Watchdog Device for Netwinder W83977AF chip
+ *	Wdt977	0.02:	A Watchdog Device for Netwinder W83977AF chip
  *
  *	(c) Copyright 1998 Rebel.com (Woody Suwalski <woody@netwinder.org>)
  *
@@ -11,8 +11,13 @@
  *	2 of the License, or (at your option) any later version.
  *
  *			-----------------------
+ *      14-Dec-2001 Matt Domsch <Matt_Domsch@dell.com>
+ *           Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
+ *	19-Dec-2001 Woody Suwalski: Netwinder fixes, ioctl interface
+ *	06-Jan-2002 Woody Suwalski: For compatibility, convert all timeouts
+ *				    from minutes to seconds.
  */
- 
+
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/types.h>
@@ -21,56 +26,123 @@
 #include <linux/miscdevice.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
+#include <linux/watchdog.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/mach-types.h>
+#include <asm/uaccess.h>
 
 #define WATCHDOG_MINOR	130
 
-static	int timeout = 3;
+#define	DEFAULT_TIMEOUT	1	/* default timeout = 1 minute */
+
+static	int timeout = DEFAULT_TIMEOUT*60;	/* TO in seconds from user */
+static	int timeoutM = DEFAULT_TIMEOUT;		/* timeout in minutes */
 static	int timer_alive;
 static	int testmode;
 
+MODULE_PARM(timeout, "i");
+MODULE_PARM_DESC(timeout,"Watchdog timeout in seconds (60..15300), default=60");
+MODULE_PARM(testmode, "i");
+MODULE_PARM_DESC(testmode,"Watchdog testmode (1 = no reboot), default=0");
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
+
+/* This is kicking the watchdog by simply re-writing the timeout to reg. 0xF2 */
+int kick_wdog(void)
+{
+	/*
+	 *	Refresh the timer.
+	 */
+
+	/* unlock the SuperIO chip */
+	outb(0x87,0x370);
+	outb(0x87,0x370);
+
+	/* select device Aux2 (device=8) and kicks watchdog reg F2 */
+	/* F2 has the timeout in minutes */
+
+	outb(0x07,0x370);
+	outb(0x08,0x371);
+	outb(0xF2,0x370);
+	outb(timeoutM,0x371);
+
+	/* lock the SuperIO chip */
+	outb(0xAA,0x370);
+
+	return 0;
+}
+
+
 /*
  *	Allow only one person to hold it open
  */
- 
+
 static int wdt977_open(struct inode *inode, struct file *file)
 {
+
 	if(timer_alive)
 		return -EBUSY;
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-	MOD_INC_USE_COUNT;
-#endif
+
+	/* convert seconds to minutes, rounding up */
+	timeoutM = timeout + 59;
+	timeoutM /= 60;
+
+	if (nowayout)
+	{
+		MOD_INC_USE_COUNT;
+
+		/* do not permit disabling the watchdog by writing 0 to reg. 0xF2 */
+		if (!timeoutM) timeoutM = DEFAULT_TIMEOUT;
+	}
 	timer_alive++;
 
-	//max timeout value = 255 minutes (0xFF). Write 0 to disable WatchDog.
-	if (timeout>255)
-	    timeout = 255;
-
-	printk(KERN_INFO "Watchdog: active, current timeout %d min.\n",timeout);
-
-	// unlock the SuperIO chip
-	outb(0x87,0x370); 
-	outb(0x87,0x370); 
-	
-	//select device Aux2 (device=8) and set watchdog regs F2, F3 and F4
-	//F2 has the timeout in minutes
-	//F3 could be set to the POWER LED blink (with GP17 set to PowerLed)
-	//   at timeout, and to reset timer on kbd/mouse activity (not now)
-	//F4 is used to just clear the TIMEOUT'ed state (bit 0)
-	
+	if (machine_is_netwinder())
+	{
+		/* we have a hw bug somewhere, so each 977 minute is actually only 30sec
+		 *  this limits the max timeout to half of device max of 255 minutes...
+		 */
+		timeoutM += timeoutM;
+	}
+
+	/* max timeout value = 255 minutes (0xFF). Write 0 to disable WatchDog. */
+	if (timeoutM > 255) timeoutM = 255;
+
+	/* convert seconds to minutes */
+	printk(KERN_INFO "Wdt977 Watchdog activated: timeout = %d sec, nowayout = %i, testmode = %i.\n",
+		machine_is_netwinder() ? (timeoutM>>1)*60 : timeoutM*60,
+		nowayout, testmode);
+
+	/* unlock the SuperIO chip */
+	outb(0x87,0x370);
+	outb(0x87,0x370);
+
+	/* select device Aux2 (device=8) and set watchdog regs F2, F3 and F4
+	 * F2 has the timeout in minutes
+	 * F3 could be set to the POWER LED blink (with GP17 set to PowerLed)
+	 *   at timeout, and to reset timer on kbd/mouse activity (not impl.)
+	 * F4 is used to just clear the TIMEOUT'ed state (bit 0)
+	 */
 	outb(0x07,0x370);
 	outb(0x08,0x371);
 	outb(0xF2,0x370);
-	outb(timeout,0x371);
+	outb(timeoutM,0x371);
 	outb(0xF3,0x370);
-	outb(0x00,0x371);	//another setting is 0E for kbd/mouse/LED
+	outb(0x00,0x371);	/* another setting is 0E for kbd/mouse/LED */
 	outb(0xF4,0x370);
 	outb(0x00,0x371);
-	
-	//at last select device Aux1 (dev=7) and set GP16 as a watchdog output
+
+	/* at last select device Aux1 (dev=7) and set GP16 as a watchdog output */
+	/* in test mode watch the bit 1 on F4 to indicate "triggered" */
 	if (!testmode)
 	{
 		outb(0x07,0x370);
@@ -78,9 +150,9 @@ static int wdt977_open(struct inode *ino
 		outb(0xE6,0x370);
 		outb(0x08,0x371);
 	}
-		
-	// lock the SuperIO chip
-	outb(0xAA,0x370); 
+
+	/* lock the SuperIO chip */
+	outb(0xAA,0x370);
 
 	return 0;
 }
@@ -89,82 +161,158 @@ static int wdt977_release(struct inode *
 {
 	/*
 	 *	Shut off the timer.
-	 * 	Lock it in if it's a module and we defined ...NOWAYOUT
+	 * 	Lock it in if it's a module and we set nowayout
 	 */
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
-	lock_kernel();
+	if (!nowayout)
+	{
+		lock_kernel();
 
-	// unlock the SuperIO chip
-	outb(0x87,0x370); 
-	outb(0x87,0x370); 
-	
-	//select device Aux2 (device=8) and set watchdog regs F2,F3 and F4
-	//F3 is reset to its default state
-	//F4 can clear the TIMEOUT'ed state (bit 0) - back to default
-	//We can not use GP17 as a PowerLed, as we use its usage as a RedLed
-	
-	outb(0x07,0x370);
-	outb(0x08,0x371);
-	outb(0xF2,0x370);
-	outb(0xFF,0x371);
-	outb(0xF3,0x370);
-	outb(0x00,0x371);
-	outb(0xF4,0x370);
-	outb(0x00,0x371);
-	outb(0xF2,0x370);
-	outb(0x00,0x371);
-	
-	//at last select device Aux1 (dev=7) and set GP16 as a watchdog output
-	outb(0x07,0x370);
-	outb(0x07,0x371);
-	outb(0xE6,0x370);
-	outb(0x08,0x371);
-	
-	// lock the SuperIO chip
-	outb(0xAA,0x370);
+		/* unlock the SuperIO chip */
+		outb(0x87,0x370);
+		outb(0x87,0x370);
+
+		/* select device Aux2 (device=8) and set watchdog regs F2,F3 and F4
+		* F3 is reset to its default state
+		* F4 can clear the TIMEOUT'ed state (bit 0) - back to default
+		* We can not use GP17 as a PowerLed, as we use its usage as a RedLed
+		*/
+		outb(0x07,0x370);
+		outb(0x08,0x371);
+		outb(0xF2,0x370);
+		outb(0xFF,0x371);
+		outb(0xF3,0x370);
+		outb(0x00,0x371);
+		outb(0xF4,0x370);
+		outb(0x00,0x371);
+		outb(0xF2,0x370);
+		outb(0x00,0x371);
 
-	timer_alive=0;
-	unlock_kernel();
+		/* at last select device Aux1 (dev=7) and set GP16 as a watchdog output */
+		outb(0x07,0x370);
+		outb(0x07,0x371);
+		outb(0xE6,0x370);
+		outb(0x08,0x371);
 
-	printk(KERN_INFO "Watchdog: shutdown.\n");
-#endif
+		/* lock the SuperIO chip */
+		outb(0xAA,0x370);
+
+		timer_alive=0;
+		unlock_kernel();
+
+		printk(KERN_INFO "Wdt977 Watchdog: shutdown\n");
+	}
 	return 0;
 }
 
-static ssize_t wdt977_write(struct file *file, const char *data, size_t len, loff_t *ppos)
+
+/*
+ *      wdt977_write:
+ *      @file: file handle to the watchdog
+ *      @buf: buffer to write (unused as data does not matter here
+ *      @count: count of bytes
+ *      @ppos: pointer to the position to write. No seeks allowed
+ *
+ *      A write to a watchdog device is defined as a keepalive signal. Any
+ *      write of data will do, as we we don't define content meaning.
+ */
+
+static ssize_t wdt977_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
 {
+	/*  Can't seek (pwrite) on this device  */
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
 
-	//max timeout value = 255 minutes (0xFF). Write 0 to disable WatchDog.
-	if (timeout>255)
-	    timeout = 255;
+	if(count)
+	{
+		kick_wdog();
+		return 1;
+	}
+	return 0;
+}
 
-	/*
-	 *	Refresh the timer.
-	 */
-		
-	//we have a hw bug somewhere, so each 977 minute is actually only 30sec
-	//as such limit the max timeout to half of max of 255 minutes...
-//	if (timeout>126)
-//	    timeout = 126;
-	
-	// unlock the SuperIO chip
-	outb(0x87,0x370); 
-	outb(0x87,0x370); 
-	
-	//select device Aux2 (device=8) and kicks watchdog reg F2
-	//F2 has the timeout in minutes
-	
-	outb(0x07,0x370);
-	outb(0x08,0x371);
-	outb(0xF2,0x370);
-	outb(timeout,0x371);
-	
-	// lock the SuperIO chip
-	outb(0xAA,0x370); 
-	
-	return 1;
+/*
+ *      wdt977_ioctl:
+ *      @inode: inode of the device
+ *      @file: file handle to the device
+ *      @cmd: watchdog command
+ *      @arg: argument pointer
+ *
+ *      The watchdog API defines a common set of functions for all watchdogs
+ *      according to their available features.
+ */
+
+static int wdt977_ioctl(struct inode *inode, struct file *file,
+         unsigned int cmd, unsigned long arg)
+{
+static struct watchdog_info ident = {
+	identity	: "Winbond 83977"
+};
+
+int temp;
+
+	switch(cmd)
+	{
+	default:
+		return -ENOTTY;
+
+	case WDIOC_GETSUPPORT:
+	    return copy_to_user((struct watchdog_info *)arg, &ident,
+			sizeof(ident)) ? -EFAULT : 0;
+
+	case WDIOC_GETBOOTSTATUS:
+		return put_user(0, (int *) arg);
+
+	case WDIOC_GETSTATUS:
+		/* unlock the SuperIO chip */
+		outb(0x87,0x370);
+		outb(0x87,0x370);
+
+		/* select device Aux2 (device=8) and read watchdog reg F4 */
+		outb(0x07,0x370);
+		outb(0x08,0x371);
+		outb(0xF4,0x370);
+		temp = inb(0x371);
+
+		/* lock the SuperIO chip */
+		outb(0xAA,0x370);
+
+		/* return info if "expired" in test mode */
+		return put_user(temp & 1, (int *) arg);
+
+	case WDIOC_KEEPALIVE:
+		kick_wdog();
+		return 0;
+
+	case WDIOC_SETTIMEOUT:
+		if (copy_from_user(&temp, (int *) arg, sizeof(int)))
+			return -EFAULT;
+
+		/* convert seconds to minutes, rounding up */
+		temp += 59;
+		temp /= 60;
+
+		/* we have a hw bug somewhere, so each 977 minute is actually only 30sec
+		*  this limits the max timeout to half of device max of 255 minutes...
+		*/
+		if (machine_is_netwinder())
+		{
+		    temp += temp;
+		}
+
+		/* Sanity check */
+		if (temp < 0 || temp > 255)
+			return -EINVAL;
+
+		if (!temp && nowayout)
+			return -EINVAL;
+
+		timeoutM = temp;
+		kick_wdog();
+		return 0;
+	}
 }
 
+
 static struct file_operations wdt977_fops=
 {
 	owner:		THIS_MODULE,
@@ -169,6 +317,7 @@ static struct file_operations wdt977_fop
 {
 	owner:		THIS_MODULE,
 	write:		wdt977_write,
+	ioctl:		wdt977_ioctl,
 	open:		wdt977_open,
 	release:	wdt977_release,
 };
@@ -186,9 +335,9 @@ static int __init nwwatchdog_init(void)
 		return -ENODEV;
 
 	misc_register(&wdt977_miscdev);
-	printk(KERN_INFO "NetWinder Watchdog sleeping.\n");
+	printk(KERN_INFO "Wdt977 Watchdog sleeping.\n");
 	return 0;
-}	
+}
 
 static void __exit nwwatchdog_exit(void)
 {
diff -BurNp --exclude-from=/home/mdomsch/excludes linux-2.4.18-pre3/drivers/char/wdt_pci.c linux/drivers/char/wdt_pci.c
--- linux-2.4.18-pre3/drivers/char/wdt_pci.c	Fri Sep  7 11:28:38 2001
+++ linux/drivers/char/wdt_pci.c	Fri Jan 11 15:20:07 2002
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
-			MOD_INC_USE_COUNT;
-#endif
+			if (nowayout) {
+				MOD_INC_USE_COUNT;
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
-		inb_p(WDT_DC);		/* Disable counters */
-		wdtpci_ctr_load(2,0);	/* 0 length reset pulses now */
-#endif		
+		if (!nowayout) {
+			inb_p(WDT_DC);		/* Disable counters */
+			wdtpci_ctr_load(2,0);	/* 0 length reset pulses now */
+		}
 		wdt_is_open=0;
 		unlock_kernel();
 	}
@@ -619,6 +640,8 @@ static int __init wdtpci_init(void)
 	
 	if (rc < 1)
 		return -ENODEV;
+
+	wdtpci_validate_timeout();
 	
 	return 0;
 }


