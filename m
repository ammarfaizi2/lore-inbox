Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316933AbSHHAOM>; Wed, 7 Aug 2002 20:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316928AbSHHAOM>; Wed, 7 Aug 2002 20:14:12 -0400
Received: from inet-mail2.oracle.com ([148.87.2.202]:48820 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S316933AbSHHAOE>; Wed, 7 Aug 2002 20:14:04 -0400
Date: Wed, 7 Aug 2002 17:17:33 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: linux-kernel@vger.kernel.org, Rob Radez <rob@osinvestor.com>,
       Matt Domsch <Matt_Domsch@dell.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       marcelo@conectiva.com.br
Subject: [PATCH] [2.4.20-pre1] Watchdog Stuff (2/4)
Message-ID: <20020808001732.GC1038@nic1-pc.us.oracle.com>
References: <20020808001238.GB1038@nic1-pc.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020808001238.GB1038@nic1-pc.us.oracle.com>
User-Agent: Mutt/1.3.28i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The second part of the patch, adding Matt Domsch's nowayout code
to various watchdog drivers.

Joel

diff -uNr linux-2.4.20-pre1-settimeout/drivers/char/acquirewdt.c linux-2.4.20-pre1-nowayout/drivers/char/acquirewdt.c
--- linux-2.4.20-pre1-settimeout/drivers/char/acquirewdt.c	Fri Aug  2 17:39:43 2002
+++ linux-2.4.20-pre1-nowayout/drivers/char/acquirewdt.c	Wed Aug  7 15:30:18 2002
@@ -17,6 +17,9 @@
  *
  *	(c) Copyright 1995    Alan Cox <alan@redhat.com>
  *
+ *      14-Dec-2001 Matt Domsch <Matt_Domsch@dell.com>
+ *          Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
+ *          Can't add timeout - driver doesn't allow changing value
  */
 
 #include <linux/config.h>
@@ -50,8 +53,14 @@
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
@@ -126,10 +135,12 @@
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
@@ -145,9 +156,9 @@
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
diff -uNr linux-2.4.20-pre1-settimeout/drivers/char/advantechwdt.c linux-2.4.20-pre1-nowayout/drivers/char/advantechwdt.c
--- linux-2.4.20-pre1-settimeout/drivers/char/advantechwdt.c	Fri Aug  2 17:39:43 2002
+++ linux-2.4.20-pre1-nowayout/drivers/char/advantechwdt.c	Wed Aug  7 15:30:18 2002
@@ -20,6 +20,8 @@
  *
  *	(c) Copyright 1995    Alan Cox <alan@redhat.com>
  *
+ *	14-Dec-2001 Matt Domsch <Matt_Domsch@dell.com>
+ *	    Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
  */
 
 #include <linux/config.h>
@@ -57,6 +59,15 @@
 
 static int wd_margin = 60; /* 60 sec default timeout */
 
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
@@ -108,16 +119,16 @@
 		return -ESPIPE;
 
 	if (count) {
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
-		size_t i;
+		if (!nowayout) {
+			size_t i;
 
-		adv_expect_close = 0;
+			adv_expect_close = 0;
 
-		for (i = 0; i != count; i++) {
-			if (buf[i] == 'V')
-				adv_expect_close = 42;
+			for (i = 0; i != count; i++) {
+				if (buf[i] == 'V')
+					adv_expect_close = 42;
+			}
 		}
-#endif
 		advwdt_ping();
 	}
 	return count;
diff -uNr linux-2.4.20-pre1-settimeout/drivers/char/alim7101_wdt.c linux-2.4.20-pre1-nowayout/drivers/char/alim7101_wdt.c
--- linux-2.4.20-pre1-settimeout/drivers/char/alim7101_wdt.c	Fri Aug  2 17:39:43 2002
+++ linux-2.4.20-pre1-nowayout/drivers/char/alim7101_wdt.c	Wed Aug  7 15:30:18 2002
@@ -79,6 +79,15 @@
 static int wdt_expect_close;
 static struct pci_dev *alim7101_pmu;
 
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
@@ -157,16 +166,18 @@
 	/* See if we got the magic character */
 	if(count) 
 	{
-		size_t ofs;
+		if (!nowayout) {
+			size_t ofs;
 
-		/* note: just in case someone wrote the magic character
-		 * five months ago... */
-		wdt_expect_close = 0;
-
-		/* now scan */
-		for(ofs = 0; ofs != count; ofs++)
-			if(buf[ofs] == 'V')
-				wdt_expect_close = 1;
+			/* note: just in case someone wrote the magic
+			 * character five months ago... */
+			wdt_expect_close = 0;
+
+			/* now scan */
+			for(ofs = 0; ofs != count; ofs++)
+				if(buf[ofs] == 'V')
+					wdt_expect_close = 1;
+		}
 
 		/* someone wrote to us, we should restart timer */
 		next_heartbeat = jiffies + WDT_HEARTBEAT;
@@ -193,15 +204,11 @@
 
 static int fop_close(struct inode * inode, struct file * file)
 {
-#ifdef CONFIG_WDT_NOWAYOUT
 	if(wdt_expect_close)
 		wdt_turnoff();
 	else {
 		printk(OUR_NAME ": device file closed unexpectedly. Will not stop the WDT!\n");
 	}
-#else
-	wdt_turnoff();
-#endif
 	clear_bit(0, &wdt_is_open);
 	return 0;
 }
diff -uNr linux-2.4.20-pre1-settimeout/drivers/char/eurotechwdt.c linux-2.4.20-pre1-nowayout/drivers/char/eurotechwdt.c
--- linux-2.4.20-pre1-settimeout/drivers/char/eurotechwdt.c	Fri Aug  2 17:39:43 2002
+++ linux-2.4.20-pre1-nowayout/drivers/char/eurotechwdt.c	Wed Aug  7 15:30:18 2002
@@ -35,6 +35,9 @@
  *
  * 2001 - Rodolfo Giometti
  *	Initial release
+ *
+ * 2002.05.30 - Joel Becker <joel.becker@oracle.com>
+ * 	Added Matt Domsch's nowayout module option.
  */
 
 #include <linux/config.h>
@@ -68,6 +71,14 @@
  
 #define WDT_TIMEOUT		60                /* 1 minute */
 
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
+MODULE_PARM(nowayout,"i");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 /*
  * Some symbolic names 
@@ -220,16 +231,16 @@
       return -ESPIPE;
  
    if (count) {
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
-      size_t i;
+      if (!nowayout) {
+         size_t i;
 
-      eur_expect_close = 0;
+         eur_expect_close = 0;
 
-      for (i = 0; i != count; i++) {
-         if (buf[i] == 'V')
-            eur_expect_close = 42;
+         for (i = 0; i != count; i++) {
+            if (buf[i] == 'V')
+               eur_expect_close = 42;
+         }
       }
-#endif
       eurwdt_ping();   /* the default timeout */
    }
 
diff -uNr linux-2.4.20-pre1-settimeout/drivers/char/ib700wdt.c linux-2.4.20-pre1-nowayout/drivers/char/ib700wdt.c
--- linux-2.4.20-pre1-settimeout/drivers/char/ib700wdt.c	Mon Feb 25 11:37:57 2002
+++ linux-2.4.20-pre1-nowayout/drivers/char/ib700wdt.c	Wed Aug  7 15:30:18 2002
@@ -114,6 +114,15 @@
 
 static int wd_margin = WD_TIMO;
 
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
@@ -222,9 +231,9 @@
 	lock_kernel();
 	if (MINOR(inode->i_rdev) == WATCHDOG_MINOR) {
 		spin_lock(&ibwdt_lock);
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
-		outb_p(wd_times[wd_margin], WDT_STOP);
-#endif
+		if (!nowayout) {
+			outb_p(wd_times[wd_margin], WDT_STOP);
+		}
 		ibwdt_is_open = 0;
 		spin_unlock(&ibwdt_lock);
 	}
diff -uNr linux-2.4.20-pre1-settimeout/drivers/char/indydog.c linux-2.4.20-pre1-nowayout/drivers/char/indydog.c
--- linux-2.4.20-pre1-settimeout/drivers/char/indydog.c	Fri Aug  2 17:39:43 2002
+++ linux-2.4.20-pre1-nowayout/drivers/char/indydog.c	Wed Aug  7 15:30:18 2002
@@ -27,6 +27,15 @@
 static unsigned long indydog_alive;
 static struct sgimc_misc_ctrl *mcmisc_regs; 
 
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
+MODULE_PARM(nowayout,"i");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
 static void indydog_ping()
 {
 	mcmisc_regs->watchdogt = 0;
@@ -43,9 +52,9 @@
 	
 	if( test_and_set_bit(0,&indydog_alive) )
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
@@ -63,16 +72,15 @@
 {
 	/*
 	 *	Shut off the timer.
-	 * 	Lock it in if it's a module and we defined ...NOWAYOUT
+	 * 	Lock it in if it's a module and we set nowayout.
 	 */
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
+	if (!nowayout)
 	{
-	u32 mc_ctrl0 = mcmisc_regs->cpuctrl0; 
-	mc_ctrl0 &= ~SGIMC_CCTRL0_WDOG;
-	mcmisc_regs->cpuctrl0 = mc_ctrl0;
-	printk("Stopped watchdog timer.\n");
+		u32 mc_ctrl0 = mcmisc_regs->cpuctrl0; 
+		mc_ctrl0 &= ~SGIMC_CCTRL0_WDOG;
+		mcmisc_regs->cpuctrl0 = mc_ctrl0;
+		printk("Stopped watchdog timer.\n");
 	}
-#endif
 	clear_bit(0,&indydog_alive);
 	return 0;
 }
diff -uNr linux-2.4.20-pre1-settimeout/drivers/char/machzwd.c linux-2.4.20-pre1-nowayout/drivers/char/machzwd.c
--- linux-2.4.20-pre1-settimeout/drivers/char/machzwd.c	Fri Aug  2 17:39:43 2002
+++ linux-2.4.20-pre1-nowayout/drivers/char/machzwd.c	Wed Aug  7 15:30:18 2002
@@ -24,6 +24,8 @@
  *  a system RESET and it starts wd#2 that unconditionaly will RESET 
  *  the system when the counter reaches zero.
  *
+ *  14-Dec-2001 Matt Domsch <Matt_Domsch@dell.com>
+ * 	Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
  */
 
 #include <linux/config.h>
@@ -103,6 +105,15 @@
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
 #define PFX "machzwd"
 
 static struct watchdog_info zf_info = {
@@ -303,27 +314,27 @@
 	/* See if we got the magic character */
 	if(count){
 
-/*
- * no need to check for close confirmation
- * no way to disable watchdog ;)
- */
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
-		size_t ofs;
-
-		/* 
-		 * note: just in case someone wrote the magic character
-		 * five months ago...
+		/*
+		 * no need to check for close confirmation
+		 * no way to disable watchdog ;)
 		 */
-		zf_expect_close = 0;
+		if (!nowayout) {
+			size_t ofs;
 
-		/* now scan */
-		for(ofs = 0; ofs != count; ofs++){
-			if(buf[ofs] == 'V'){
-				zf_expect_close = 1;
-				dprintk("zf_expect_close 1\n");
+			/* 
+			 * note: just in case someone wrote the magic
+			 * character five months ago...
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
@@ -381,9 +392,9 @@
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
diff -uNr linux-2.4.20-pre1-settimeout/drivers/char/mixcomwd.c linux-2.4.20-pre1-nowayout/drivers/char/mixcomwd.c
--- linux-2.4.20-pre1-settimeout/drivers/char/mixcomwd.c	Thu Sep 13 15:21:32 2001
+++ linux-2.4.20-pre1-nowayout/drivers/char/mixcomwd.c	Wed Aug  7 15:30:18 2002
@@ -27,10 +27,13 @@
  *
  * Version 0.4 (99/11/15):
  *		- support for one more type board
+ *
+ * Version 0.5 (2001/12/14) Matt Domsch <Matt_Domsch@dell.com>
+ * 		- added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
  *	
  */
 
-#define VERSION "0.4" 
+#define VERSION "0.5" 
   
 #include <linux/module.h>
 #include <linux/config.h>
@@ -58,25 +61,30 @@
 
 static int watchdog_port;
 
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
@@ -89,12 +97,13 @@
 	}
 	mixcomwd_ping();
 	
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
+	if (nowayout) {
+		MOD_INC_USE_COUNT;
+	}
 	if(mixcomwd_timer_alive) {
 		del_timer(&mixcomwd_timer);
 		mixcomwd_timer_alive=0;
 	} 
-#endif
 	return 0;
 }
 
@@ -102,19 +111,19 @@
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
@@ -148,9 +157,9 @@
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
@@ -255,14 +264,14 @@
 
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
+				" probably reboot!\n");
+			del_timer(&mixcomwd_timer);
+			mixcomwd_timer_alive=0;
+		}
 	}
-#endif
 	release_region(watchdog_port,1);
 	misc_deregister(&mixcomwd_miscdev);
 }
diff -uNr linux-2.4.20-pre1-settimeout/drivers/char/sc1200wdt.c linux-2.4.20-pre1-nowayout/drivers/char/sc1200wdt.c
--- linux-2.4.20-pre1-settimeout/drivers/char/sc1200wdt.c	Fri Aug  2 17:39:43 2002
+++ linux-2.4.20-pre1-nowayout/drivers/char/sc1200wdt.c	Wed Aug  7 15:30:18 2002
@@ -22,6 +22,8 @@
  *		 <rob@osinvestor.com>	Return proper status instead of temperature warning
  *					Add WDIOC_GETBOOTSTATUS and WDIOC_SETOPTIONS ioctls
  *					Fix CONFIG_WATCHDOG_NOWAYOUT
+ *	20020530 Joel Becker		Add Matt Domsch's nowayout
+ *					module option
  */
 
 #include <linux/config.h>
@@ -86,6 +88,14 @@
 MODULE_PARM(timeout, "i");
 MODULE_PARM_DESC(timeout, "range is 0-255 minutes, default is 1");
 
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
+MODULE_PARM(nowayout,"i");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 
 /* Read from Data Register */
@@ -246,17 +256,17 @@
 		return -ESPIPE;
 	
 	if (len) {
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
-		size_t i;
+		if (!nowayout) {
+			size_t i;
 
-		expect_close = 0;
+			expect_close = 0;
 
-		for (i = 0; i != len; i++)
-		{
-			if (data[i] == 'V')
-				expect_close = 42;
+			for (i = 0; i != len; i++)
+			{
+				if (data[i] == 'V')
+					expect_close = 42;
+			}
 		}
-#endif
 		sc1200wdt_write_data(WDTO, timeout);
 		return len;
 	}
diff -uNr linux-2.4.20-pre1-settimeout/drivers/char/sc520_wdt.c linux-2.4.20-pre1-nowayout/drivers/char/sc520_wdt.c
--- linux-2.4.20-pre1-settimeout/drivers/char/sc520_wdt.c	Fri Aug  2 17:39:43 2002
+++ linux-2.4.20-pre1-nowayout/drivers/char/sc520_wdt.c	Wed Aug  7 15:30:18 2002
@@ -110,6 +110,15 @@
 static unsigned long wdt_is_open;
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
 static spinlock_t wdt_spinlock;
 /*
  *	Whack the dog
@@ -172,12 +181,12 @@
 
 static void wdt_turnoff(void)
 {
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
-	/* Stop the timer */
-	del_timer(&timer);
-	wdt_config(0);
-	printk(OUR_NAME ": Watchdog timer is now disabled...\n");
-#endif
+	if (!nowayout) {
+		/* Stop the timer */
+		del_timer(&timer);
+		wdt_config(0);
+		printk(OUR_NAME ": Watchdog timer is now disabled...\n");
+	}
 }
 
 
@@ -222,9 +231,9 @@
 				return -EBUSY;
 			/* Good, fire up the show */
 			wdt_startup();
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-			MOD_INC_USE_COUNT;
-#endif	
+			if (nowayout) {
+				MOD_INC_USE_COUNT;
+			}
 			return 0;
 		default:
 			return -ENODEV;
diff -uNr linux-2.4.20-pre1-settimeout/drivers/char/softdog.c linux-2.4.20-pre1-nowayout/drivers/char/softdog.c
--- linux-2.4.20-pre1-settimeout/drivers/char/softdog.c	Fri Aug  2 17:39:43 2002
+++ linux-2.4.20-pre1-nowayout/drivers/char/softdog.c	Wed Aug  7 15:30:18 2002
@@ -31,6 +31,9 @@
  *	Added soft_noboot; Allows testing the softdog trigger without 
  *	requiring a recompile.
  *	Added WDIOC_GETTIMEOUT and WDIOC_SETTIMOUT.
+ *
+ *  20020530 Joel Becker <joel.becker@oracle.com>
+ *  	Added Matt Domsch's nowayout module option.
  */
  
 #include <linux/module.h>
@@ -59,6 +62,15 @@
 MODULE_PARM(soft_noboot,"i");
 MODULE_LICENSE("GPL");
 
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
  *	Our timer
  */
@@ -95,9 +107,9 @@
 {
 	if(test_and_set_bit(0, &timer_alive))
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
@@ -109,11 +121,11 @@
 {
 	/*
 	 *	Shut off the timer.
-	 * 	Lock it in if it's a module and we defined ...NOWAYOUT
+	 * 	Lock it in if it's a module and we set nowayout
 	 */
-#ifndef CONFIG_WATCHDOG_NOWAYOUT	 
-	del_timer(&watchdog_ticktock);
-#endif	
+	if (!nowayout) {
+		del_timer(&watchdog_ticktock);
+	}
 	clear_bit(0, &timer_alive);
 	return 0;
 }
diff -uNr linux-2.4.20-pre1-settimeout/drivers/char/wafer5823wdt.c linux-2.4.20-pre1-nowayout/drivers/char/wafer5823wdt.c
--- linux-2.4.20-pre1-settimeout/drivers/char/wafer5823wdt.c	Wed Aug  7 15:24:03 2002
+++ linux-2.4.20-pre1-nowayout/drivers/char/wafer5823wdt.c	Wed Aug  7 15:30:18 2002
@@ -56,6 +56,15 @@
 #define WD_TIMO 60		/* 1 minute */
 static int wd_margin = WD_TIMO;
 
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
+MODULE_PARM(nowayout,"i");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
 static void wafwdt_ping(void)
 {
 	/* pat watchdog */
@@ -148,9 +157,9 @@
 wafwdt_close(struct inode *inode, struct file *file)
 {
 	clear_bit(0, &wafwdt_is_open);
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
-        wafwdt_stop();
-#endif
+	if (!nowayout) {
+        	wafwdt_stop();
+	}
 	return 0;
 }
 
diff -uNr linux-2.4.20-pre1-settimeout/drivers/char/wdt.c linux-2.4.20-pre1-nowayout/drivers/char/wdt.c
--- linux-2.4.20-pre1-settimeout/drivers/char/wdt.c	Fri Aug  2 17:39:43 2002
+++ linux-2.4.20-pre1-nowayout/drivers/char/wdt.c	Wed Aug  7 15:30:18 2002
@@ -28,6 +28,7 @@
  *					Parameterized timeout
  *		Tigran Aivazian	:	Restructured wdt_init() to handle failures
  *		Joel Becker	:	Added WDIOC_GET/SETTIMEOUT
+ *		Matt Domsch	:	Added nowayout module option
  */
 
 #include <linux/config.h>
@@ -66,6 +67,15 @@
 
 static int wd_margin = WD_TIMO;
 
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
+MODULE_PARM(nowayout,"i");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
 #ifndef MODULE
 
 /**
@@ -394,10 +404,10 @@
 {
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
 		clear_bit(0, &wdt_is_open);
 	}
 	return 0;
diff -uNr linux-2.4.20-pre1-settimeout/drivers/char/wdt977.c linux-2.4.20-pre1-nowayout/drivers/char/wdt977.c
--- linux-2.4.20-pre1-settimeout/drivers/char/wdt977.c	Fri Sep  7 09:28:38 2001
+++ linux-2.4.20-pre1-nowayout/drivers/char/wdt977.c	Wed Aug  7 15:30:18 2002
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
@@ -32,6 +34,16 @@
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
@@ -40,9 +52,9 @@
 {
 	if(timer_alive)
 		return -EBUSY;
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-	MOD_INC_USE_COUNT;
-#endif
+	if (nowayout) {
+		MOD_INC_USE_COUNT;
+	}
 	timer_alive++;
 
 	//max timeout value = 255 minutes (0xFF). Write 0 to disable WatchDog.
@@ -89,9 +101,9 @@
 {
 	/*
 	 *	Shut off the timer.
-	 * 	Lock it in if it's a module and we defined ...NOWAYOUT
+	 * 	Lock it in if it's a module and we set nowayout
 	 */
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
+	if (!nowayout) { /* FIXME: not fixing indentation */
 	lock_kernel();
 
 	// unlock the SuperIO chip
@@ -127,7 +139,7 @@
 	unlock_kernel();
 
 	printk(KERN_INFO "Watchdog: shutdown.\n");
-#endif
+	}
 	return 0;
 }
 
diff -uNr linux-2.4.20-pre1-settimeout/drivers/char/wdt_pci.c linux-2.4.20-pre1-nowayout/drivers/char/wdt_pci.c
--- linux-2.4.20-pre1-settimeout/drivers/char/wdt_pci.c	Fri Aug  2 17:39:43 2002
+++ linux-2.4.20-pre1-nowayout/drivers/char/wdt_pci.c	Wed Aug  7 15:30:18 2002
@@ -32,6 +32,7 @@
  *		Tigran Aivazian	:	Restructured wdtpci_init_one() to handle failures
  *		Joel Becker	:	Added WDIOC_GET/SETTIMEOUT
  *		Zwane Mwaikambo :	Magic char closing, locking changes, cleanups
+ *		Matt Domsch	:	nowayout module option
  */
 
 #include <linux/config.h>
@@ -87,6 +88,15 @@
 
 static int wd_margin = WD_TIMO;
 
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
  *	Programming support
  */
@@ -231,16 +241,16 @@
 		return -ESPIPE;
 
 	if (count) {
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
-		size_t i;
+		if (!nowayout) {
+			size_t i;
 
-		expect_close = 0;
+			expect_close = 0;
 
-		for (i = 0; i != count; i++) {
-			if (buf[i] == 'V')
-				expect_close = 1;
+			for (i = 0; i != count; i++) {
+				if (buf[i] == 'V')
+					expect_close = 1;
+			}
 		}
-#endif
 		wdtpci_ping();
 	}
 
@@ -355,12 +365,12 @@
 	switch(MINOR(inode->i_rdev))
 	{
 		case WATCHDOG_MINOR:
-			 if (down_trylock(&open_sem))
-                        	return -EBUSY;
+			if (down_trylock(&open_sem))
+				return -EBUSY;
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT	
-			MOD_INC_USE_COUNT;
-#endif
+			if (nowayout) {
+				MOD_INC_USE_COUNT;
+			}
 			/*
 			 *	Activate 
 			 */
@@ -415,7 +425,6 @@
 {
 
 	if (MINOR(inode->i_rdev)==WATCHDOG_MINOR) {
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
 		unsigned long flags;
 		if (expect_close) {
 			spin_lock_irqsave(&wdtpci_lock, flags);
@@ -426,7 +435,6 @@
 			printk(KERN_CRIT PFX "Unexpected close, not stopping timer!");
 			wdtpci_ping();
 		}
-#endif		
 		up(&open_sem);
 	}
 	return 0;

-- 

"Sometimes one pays most for the things one gets for nothing."
        - Albert Einstein

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
