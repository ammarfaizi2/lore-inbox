Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316992AbSFAHHg>; Sat, 1 Jun 2002 03:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316995AbSFAHHf>; Sat, 1 Jun 2002 03:07:35 -0400
Received: from inet-mail2.oracle.com ([148.87.2.202]:21141 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S316992AbSFAHHG>; Sat, 1 Jun 2002 03:07:06 -0400
Date: Sat, 1 Jun 2002 00:06:52 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Radez <rob@osinvestor.com>,
        Matt Domsch <Matt_Domsch@dell.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Watchdog Stuff (4/4)
Message-ID: <20020601070647.GC10159@insight.us.oracle.com>
In-Reply-To: <20020601064309.GA10222@insight.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Patch number four, adding the "magic close character" to the
rest of the drivers that can support it.

diff -uNr linux-2.4.19-pre9-magicclose-fix/drivers/char/acquirewdt.c linux-2.4.19-pre9-magicclose/drivers/char/acquirewdt.c
--- linux-2.4.19-pre9-magicclose-fix/drivers/char/acquirewdt.c	Thu May 30 17:11:42 2002
+++ linux-2.4.19-pre9-magicclose/drivers/char/acquirewdt.c	Fri May 31 14:57:31 2002
@@ -45,6 +45,7 @@
 
 static int acq_is_open;
 static spinlock_t acq_lock;
+static int expect_close = 0;
 
 /*
  *	You must set these - there is no sane way to probe for this board.
@@ -81,6 +82,21 @@
 
 	if(count)
 	{
+		if (!nowayout)
+		{
+			size_t i;
+
+			expect_close = 0;
+
+			for (i = 0; i != count; i++) {
+				char c;
+				if (get_user(c, buf + i))
+					return -EFAULT;
+				if (c == 'V')
+					expect_close = 1;
+			}
+		}
+
 		acq_ping();
 		return 1;
 	}
@@ -99,7 +115,7 @@
 {
 	static struct watchdog_info ident=
 	{
-		WDIOF_KEEPALIVEPING, 1, "Acquire WDT"
+		WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE, 1, "Acquire WDT"
 	};
 	
 	switch(cmd)
@@ -156,9 +172,14 @@
 	if(MINOR(inode->i_rdev)==WATCHDOG_MINOR)
 	{
 		spin_lock(&acq_lock);
-		if (!nowayout) {
+		if (expect_close)
+		{
 			inb_p(WDT_STOP);
 		}
+		else
+		{
+			printk(KERN_CRIT "WDT closed unexpectedly.  WDT will not stop!\n");
+		}
 		acq_is_open=0;
 		spin_unlock(&acq_lock);
 	}
diff -uNr linux-2.4.19-pre9-magicclose-fix/drivers/char/advantechwdt.c linux-2.4.19-pre9-magicclose/drivers/char/advantechwdt.c
--- linux-2.4.19-pre9-magicclose-fix/drivers/char/advantechwdt.c	Fri May 31 13:24:10 2002
+++ linux-2.4.19-pre9-magicclose/drivers/char/advantechwdt.c	Fri May 31 15:52:49 2002
@@ -143,7 +143,7 @@
 {
 	int new_margin;
 	static struct watchdog_info ident = {
-		options:		WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+		options:		WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 		firmware_version:	0,
 		identity:		"Advantech WDT"
 	};
diff -uNr linux-2.4.19-pre9-magicclose-fix/drivers/char/alim7101_wdt.c linux-2.4.19-pre9-magicclose/drivers/char/alim7101_wdt.c
--- linux-2.4.19-pre9-magicclose-fix/drivers/char/alim7101_wdt.c	Fri May 31 13:23:52 2002
+++ linux-2.4.19-pre9-magicclose/drivers/char/alim7101_wdt.c	Fri May 31 15:53:11 2002
@@ -221,7 +221,7 @@
 {
 	static struct watchdog_info ident=
 	{
-		0,
+		WDIOF_MAGICCLOSE,
 		1,
 		"ALiM7101"
 	};
diff -uNr linux-2.4.19-pre9-magicclose-fix/drivers/char/eurotechwdt.c linux-2.4.19-pre9-magicclose/drivers/char/eurotechwdt.c
--- linux-2.4.19-pre9-magicclose-fix/drivers/char/eurotechwdt.c	Fri May 31 13:23:38 2002
+++ linux-2.4.19-pre9-magicclose/drivers/char/eurotechwdt.c	Fri May 31 15:53:34 2002
@@ -265,7 +265,7 @@
         unsigned int cmd, unsigned long arg)
 {
    static struct watchdog_info ident = {
-      options		: WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+      options		: WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
       firmware_version	: 0,
       identity		: "WDT Eurotech CPU-1220/1410"
    };
diff -uNr linux-2.4.19-pre9-magicclose-fix/drivers/char/i810-tco.c linux-2.4.19-pre9-magicclose/drivers/char/i810-tco.c
--- linux-2.4.19-pre9-magicclose-fix/drivers/char/i810-tco.c	Tue May 28 18:51:38 2002
+++ linux-2.4.19-pre9-magicclose/drivers/char/i810-tco.c	Fri May 31 14:54:31 2002
@@ -64,6 +64,7 @@
 
 static unsigned int ACPIBASE;
 static spinlock_t tco_lock;	/* Guards the hardware */
+static int expect_close = 0;
 
 static int i810_margin = TIMER_MARGIN;	/* steps of 0.6sec */
 
@@ -204,10 +205,15 @@
 	/*
 	 *      Shut off the timer.
 	 */
-	if (nowayout) {
-		tco_timer_stop ();
-		timer_alive = 0;
+	if (MINOR(inode->i_rdev) == WATCHDOG_MINOR)
+	{
+		if (expect_close) {
+			tco_timer_stop ();
+		} else {
+			printk(KERN_CRIT TCO_MODULE_NAME ": WDT closed unexpectedly.  WDT will not stop!\n");
+		}
 	}
+	timer_alive = 0;
 	return 0;
 }
 
@@ -222,6 +228,20 @@
 	 *      Refresh the timer.
 	 */
 	if (len) {
+		if (!nowayout) {
+			size_t i;
+
+			/* In case it was set long ago */
+			expect_close = 0;
+
+			for (i = 0; i != len; i++) {
+				char c;
+				if (get_user(c, data + i))
+					return -EFAULT;
+				if (c == 'V')
+					expect_close = 1;
+			}
+		}
 		tco_timer_reload ();
 		return 1;
 	}
@@ -234,7 +254,9 @@
 	int new_margin, u_margin;
 
 	static struct watchdog_info ident = {
-		WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+		WDIOF_SETTIMEOUT |
+		WDIOF_KEEPALIVEPING |
+		WDIOF_MAGICCLOSE,
 		0,
 		"i810 TCO timer"
 	};
diff -uNr linux-2.4.19-pre9-magicclose-fix/drivers/char/ib700wdt.c linux-2.4.19-pre9-magicclose/drivers/char/ib700wdt.c
--- linux-2.4.19-pre9-magicclose-fix/drivers/char/ib700wdt.c	Thu May 30 17:25:50 2002
+++ linux-2.4.19-pre9-magicclose/drivers/char/ib700wdt.c	Fri May 31 14:54:55 2002
@@ -50,6 +50,7 @@
 
 static int ibwdt_is_open;
 static spinlock_t ibwdt_lock;
+static int expect_close = 0;
 
 /*
  *
@@ -143,6 +144,20 @@
 		return -ESPIPE;
 
 	if (count) {
+		if (!nowayout) {
+			size_t i;
+
+			/* In case it was set long ago */
+			expect_close = 0;
+
+			for (i = 0; i != count; i++) {
+				char c;
+				if (get_user(c, buf + i))
+					return -EFAULT;
+				if (c == 'V')
+					expect_close = 1;
+			}
+		}
 		ibwdt_ping();
 		return 1;
 	}
@@ -162,7 +177,10 @@
 	int i, new_margin;
 
 	static struct watchdog_info ident = {
-		WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT, 1, "IB700 WDT"
+		WDIOF_KEEPALIVEPING |
+		WDIOF_SETTIMEOUT |
+		WDIOF_MAGICCLOSE,
+		1, "IB700 WDT"
 	};
 
 	switch (cmd) {
@@ -231,8 +249,10 @@
 	lock_kernel();
 	if (MINOR(inode->i_rdev) == WATCHDOG_MINOR) {
 		spin_lock(&ibwdt_lock);
-		if (!nowayout) {
+		if (expect_close) {
 			outb_p(wd_times[wd_margin], WDT_STOP);
+		} else {
+			printk(KERN_CRIT "WDT device closed unexpectedly.  WDT will not stop!\n");
 		}
 		ibwdt_is_open = 0;
 		spin_unlock(&ibwdt_lock);
diff -uNr linux-2.4.19-pre9-magicclose-fix/drivers/char/indydog.c linux-2.4.19-pre9-magicclose/drivers/char/indydog.c
--- linux-2.4.19-pre9-magicclose-fix/drivers/char/indydog.c	Thu May 30 17:27:27 2002
+++ linux-2.4.19-pre9-magicclose/drivers/char/indydog.c	Fri May 31 14:56:48 2002
@@ -26,6 +26,7 @@
 
 static unsigned long indydog_alive;
 static struct sgimc_misc_ctrl *mcmisc_regs; 
+static int expect_close = 0;
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 static int nowayout = 1;
@@ -74,13 +75,17 @@
 	 *	Shut off the timer.
 	 * 	Lock it in if it's a module and we set nowayout.
 	 */
-	if (!nowayout)
+	if (expect_close)
 	{
 		u32 mc_ctrl0 = mcmisc_regs->cpuctrl0; 
 		mc_ctrl0 &= ~SGIMC_CCTRL0_WDOG;
 		mcmisc_regs->cpuctrl0 = mc_ctrl0;
 		printk("Stopped watchdog timer.\n");
 	}
+	else
+	{
+		printk(KERN_CRIT "WDT device closed unexpectedly.  WDT will not stop!\n");
+	}
 	clear_bit(0,&indydog_alive);
 	return 0;
 }
@@ -95,6 +100,20 @@
 	 *	Refresh the timer.
 	 */
 	if(len) {
+		if (!nowayout) {
+			size_t i;
+
+			/* In case it was set long ago */
+			expect_close = 0;
+
+			for (i = 0; i != len; i++) {
+				char c;
+				if (get_user(c, data + i))
+					return -EFAULT;
+				if (c == 'V')
+					expect_close = 1;
+			}
+		}
 		indydog_ping();
 		return 1;
 	}
@@ -105,6 +124,7 @@
 	unsigned int cmd, unsigned long arg)
 {
 	static struct watchdog_info ident = {
+		options: WDIOF_MAGICCLOSE,
 		identity: "Hardware Watchdog for SGI IP22",
 	};
 	switch (cmd) {
diff -uNr linux-2.4.19-pre9-magicclose-fix/drivers/char/machzwd.c linux-2.4.19-pre9-magicclose/drivers/char/machzwd.c
--- linux-2.4.19-pre9-magicclose-fix/drivers/char/machzwd.c	Fri May 31 13:24:22 2002
+++ linux-2.4.19-pre9-magicclose/drivers/char/machzwd.c	Fri May 31 15:54:11 2002
@@ -117,7 +117,7 @@
 #define PFX "machzwd"
 
 static struct watchdog_info zf_info = {
-	options:		WDIOF_KEEPALIVEPING, 
+	options:		WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE, 
 	firmware_version:	1, 
 	identity:		"ZF-Logic watchdog"
 };
diff -uNr linux-2.4.19-pre9-magicclose-fix/drivers/char/mixcomwd.c linux-2.4.19-pre9-magicclose/drivers/char/mixcomwd.c
--- linux-2.4.19-pre9-magicclose-fix/drivers/char/mixcomwd.c	Thu May 30 17:39:02 2002
+++ linux-2.4.19-pre9-magicclose/drivers/char/mixcomwd.c	Fri May 31 15:55:07 2002
@@ -63,6 +63,7 @@
 
 static int mixcomwd_timer_alive;
 static struct timer_list mixcomwd_timer;
+static int expect_close = 0;
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 static int nowayout = 1;
@@ -111,7 +112,7 @@
 {
 
 	lock_kernel();
-	if (!nowayout) {
+	if (expect_close) {
 		if(mixcomwd_timer_alive) {
 			printk(KERN_ERR "mixcomwd: release called while internal timer alive");
 			unlock_kernel();
@@ -123,6 +124,8 @@
 		mixcomwd_timer.data=0;
 		mixcomwd_timer_alive=1;
 		add_timer(&mixcomwd_timer);
+	} else {
+		printk(KERN_CRIT "mixcomwd: WDT device closed unexpectedly.  WDT will not stop!\n");
 	}
 
 	clear_bit(0,&mixcomwd_opened);
@@ -139,6 +142,20 @@
 
 	if(len)
 	{
+		if (!nowayout) {
+			size_t i;
+
+			/* In case it was set long ago */
+			expect_close = 0;
+
+			for (i = 0; i != len; i++) {
+				char c;
+				if (get_user(c, data + i))
+					return -EFAULT;
+				if (c == 'V')
+					expect_close = 1;
+			}
+		}
 		mixcomwd_ping();
 		return 1;
 	}
@@ -150,7 +167,8 @@
 {
 	int status;
         static struct watchdog_info ident = {
-		WDIOF_KEEPALIVEPING, 1, "MixCOM watchdog"
+		WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+		1, "MixCOM watchdog"
 	};
                                         
 	switch(cmd)
diff -uNr linux-2.4.19-pre9-magicclose-fix/drivers/char/pcwd.c linux-2.4.19-pre9-magicclose/drivers/char/pcwd.c
--- linux-2.4.19-pre9-magicclose-fix/drivers/char/pcwd.c	Thu May 30 17:41:55 2002
+++ linux-2.4.19-pre9-magicclose/drivers/char/pcwd.c	Fri May 31 15:34:35 2002
@@ -115,6 +115,7 @@
 static atomic_t open_allowed = ATOMIC_INIT(1);
 static int initial_status, supports_temp, mode_debug;
 static spinlock_t io_lock;
+static int expect_close = 0;
 
 /*
  * PCWD_CHECKCARD
@@ -253,7 +254,7 @@
 	int cdat, rv;
 	static struct watchdog_info ident=
 	{
-		WDIOF_OVERHEAT|WDIOF_CARDRESET,
+		WDIOF_OVERHEAT|WDIOF_CARDRESET|WDIOF_MAGICCLOSE,
 		1,
 		"PCWD"
 	};
@@ -405,6 +406,20 @@
 
 	if (len)
 	{
+		if (!nowayout) {
+			size_t i;
+
+			/* In case it was set long ago */
+			expect_close = 0;
+
+			for (i = 0; i != len; i++) {
+				char c;
+				if (get_user(c, buf + i))
+					return -EFAULT;
+				if (c == 'V')
+					expect_close = 1;
+			}
+		}
 		pcwd_send_heartbeat();
 		return 1;
 	}
@@ -467,7 +482,7 @@
 {
 	if (MINOR(ino->i_rdev)==WATCHDOG_MINOR)
 	{
-		if (!nowayout) {
+		if (expect_close) {
 			/*  Disable the board  */
 			if (revision == PCWD_REVISION_C) {
 				spin_lock(&io_lock);
@@ -475,6 +490,8 @@
 				outb_p(0xA5, current_readport + 3);
 				spin_unlock(&io_lock);
 			}
+		} else {
+			printk(KERN_CRIT "pcwd: WDT device closed unexpectedly.  WDT will not stop!\n");
 		}
 		atomic_inc(&open_allowed);
 	}
diff -uNr linux-2.4.19-pre9-magicclose-fix/drivers/char/sbc60xxwdt.c linux-2.4.19-pre9-magicclose/drivers/char/sbc60xxwdt.c
--- linux-2.4.19-pre9-magicclose-fix/drivers/char/sbc60xxwdt.c	Thu Sep 13 15:21:32 2001
+++ linux-2.4.19-pre9-magicclose/drivers/char/sbc60xxwdt.c	Fri May 31 15:55:36 2002
@@ -234,7 +234,7 @@
 {
 	static struct watchdog_info ident=
 	{
-		0,
+		WDIOF_MAGICCLOSE,
 		1,
 		"SB60xx"
 	};
diff -uNr linux-2.4.19-pre9-magicclose-fix/drivers/char/sc1200wdt.c linux-2.4.19-pre9-magicclose/drivers/char/sc1200wdt.c
--- linux-2.4.19-pre9-magicclose-fix/drivers/char/sc1200wdt.c	Fri May 31 14:08:20 2002
+++ linux-2.4.19-pre9-magicclose/drivers/char/sc1200wdt.c	Fri May 31 15:56:00 2002
@@ -171,7 +171,7 @@
 {
 	int new_timeout;
 	static struct watchdog_info ident = {
-		options:		WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+		options:		WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 		firmware_version:	0,
 		identity:		"PC87307/PC97307"
 	};
diff -uNr linux-2.4.19-pre9-magicclose-fix/drivers/char/sc520_wdt.c linux-2.4.19-pre9-magicclose/drivers/char/sc520_wdt.c
--- linux-2.4.19-pre9-magicclose-fix/drivers/char/sc520_wdt.c	Fri May 31 14:33:47 2002
+++ linux-2.4.19-pre9-magicclose/drivers/char/sc520_wdt.c	Fri May 31 15:56:21 2002
@@ -269,7 +269,7 @@
 {
 	static struct watchdog_info ident=
 	{
-		0,
+		WDIOF_MAGICCLOSE,
 		1,
 		"SC520"
 	};
diff -uNr linux-2.4.19-pre9-magicclose-fix/drivers/char/shwdt.c linux-2.4.19-pre9-magicclose/drivers/char/shwdt.c
--- linux-2.4.19-pre9-magicclose-fix/drivers/char/shwdt.c	Fri May 31 13:26:05 2002
+++ linux-2.4.19-pre9-magicclose/drivers/char/shwdt.c	Fri May 31 15:57:03 2002
@@ -347,7 +347,7 @@
 };
 
 static struct watchdog_info sh_wdt_info = {
-	options:		WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+	options:		WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 	firmware_version:	0,
 	identity:		"SH WDT",
 };
diff -uNr linux-2.4.19-pre9-magicclose-fix/drivers/char/softdog.c linux-2.4.19-pre9-magicclose/drivers/char/softdog.c
--- linux-2.4.19-pre9-magicclose-fix/drivers/char/softdog.c	Thu May 30 17:57:02 2002
+++ linux-2.4.19-pre9-magicclose/drivers/char/softdog.c	Fri May 31 15:03:00 2002
@@ -51,6 +51,7 @@
 
 #define TIMER_MARGIN	60		/* (secs) Default is 1 minute */
 
+static int expect_close = 0;
 static int soft_margin = TIMER_MARGIN;	/* in seconds */
 #ifdef ONLY_TESTING
 static int soft_noboot = 1;
@@ -123,8 +124,10 @@
 	 *	Shut off the timer.
 	 * 	Lock it in if it's a module and we set nowayout
 	 */
-	if (!nowayout) {
+	if (expect_close) {
 		del_timer(&watchdog_ticktock);
+	} else {
+		printk(KERN_CRIT "SOFTDOG: WDT device closed unexpectedly.  WDT will not stop!\n");
 	}
 	clear_bit(0, &timer_alive);
 	return 0;
@@ -140,6 +143,20 @@
 	 *	Refresh the timer.
 	 */
 	if(len) {
+		if (!nowayout) {
+			size_t i;
+
+			/* In case it was set long ago */
+			expect_close = 0;
+
+			for (i = 0; i != len; i++) {
+				char c;
+				if (get_user(c, data + i))
+					return -EFAULT;
+				if (c == 'V')
+					expect_close = 1;
+			}
+		}
 		mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
 		return 1;
 	}
@@ -151,7 +168,7 @@
 {
 	int new_margin;
 	static struct watchdog_info ident = {
-		WDIOF_SETTIMEOUT,
+		WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 		0,
 		"Software Watchdog"
 	};
diff -uNr linux-2.4.19-pre9-magicclose-fix/drivers/char/w83877f_wdt.c linux-2.4.19-pre9-magicclose/drivers/char/w83877f_wdt.c
--- linux-2.4.19-pre9-magicclose-fix/drivers/char/w83877f_wdt.c	Fri May 31 13:26:53 2002
+++ linux-2.4.19-pre9-magicclose/drivers/char/w83877f_wdt.c	Fri May 31 15:57:25 2002
@@ -251,7 +251,7 @@
 {
 	static struct watchdog_info ident=
 	{
-		0,
+		WDIOF_MAGICCLOSE,
 		1,
 		"W83877F"
 	};
diff -uNr linux-2.4.19-pre9-magicclose-fix/drivers/char/wafer5823wdt.c linux-2.4.19-pre9-magicclose/drivers/char/wafer5823wdt.c
--- linux-2.4.19-pre9-magicclose-fix/drivers/char/wafer5823wdt.c	Thu May 30 17:47:41 2002
+++ linux-2.4.19-pre9-magicclose/drivers/char/wafer5823wdt.c	Fri May 31 15:05:58 2002
@@ -40,6 +40,7 @@
 
 static unsigned long wafwdt_is_open;
 static spinlock_t wafwdt_lock;
+static int expect_close = 0;
 
 /*
  *	You must set these - there is no sane way to probe for this board.
@@ -95,6 +96,20 @@
 		return -ESPIPE;
 
 	if (count) {
+		if (!nowayout) {
+			size_t i;
+
+			/* In case it was set long ago */
+			expect_close = 0;
+
+			for (i = 0; i != count; i++) {
+				char c;
+				if (get_user(c, buf + i))
+					return -EFAULT;
+				if (c == 'V')
+					expect_close = 1;
+			}
+		}
 		wafwdt_ping();
 		return 1;
 	}
@@ -106,7 +121,9 @@
 {
 	int new_margin;
 	static struct watchdog_info ident = {
-		WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+		WDIOF_KEEPALIVEPING |
+		WDIOF_SETTIMEOUT |
+		WDIOF_MAGICCLOSE,
 		1, "Wafer 5823 WDT"
 	};
 	int one=1;
@@ -157,8 +174,10 @@
 wafwdt_close(struct inode *inode, struct file *file)
 {
 	clear_bit(0, &wafwdt_is_open);
-	if (!nowayout) {
+	if (expect_close) {
         	wafwdt_stop();
+	} else {
+		printk(KERN_CRIT "WDT device closed unexpectedly.  WDT will not stop!\n");
 	}
 	return 0;
 }
diff -uNr linux-2.4.19-pre9-magicclose-fix/drivers/char/wdt.c linux-2.4.19-pre9-magicclose/drivers/char/wdt.c
--- linux-2.4.19-pre9-magicclose-fix/drivers/char/wdt.c	Thu May 30 17:52:12 2002
+++ linux-2.4.19-pre9-magicclose/drivers/char/wdt.c	Fri May 31 15:13:31 2002
@@ -53,6 +53,7 @@
 #include <linux/init.h>
 
 static unsigned long wdt_is_open;
+static int expect_close;
 
 /*
  *	You must set these - there is no sane way to probe for this board.
@@ -253,6 +254,20 @@
 
 	if(count)
 	{
+		if (!nowayout) {
+			size_t i;
+
+			/* In case it was set long ago */
+			expect_close = 0;
+
+			for (i = 0; i != count; i++) {
+				char c;
+				if (get_user(c, buf + i))
+					return -EFAULT;
+				if (c == 'V')
+					expect_close = 1;
+			}
+		}
 		wdt_ping();
 		return 1;
 	}
@@ -314,7 +329,7 @@
 	{
 		WDIOF_OVERHEAT|WDIOF_POWERUNDER|WDIOF_POWEROVER
 			|WDIOF_EXTERN1|WDIOF_EXTERN2|WDIOF_FANFAULT
-			|WDIOF_SETTIMEOUT,
+			|WDIOF_SETTIMEOUT|WDIOF_MAGICCLOSE,
 		1,
 		"WDT500/501"
 	};
@@ -404,9 +419,11 @@
 {
 	if(MINOR(inode->i_rdev)==WATCHDOG_MINOR)
 	{
-		if (!nowayout) {
+		if (expect_close) {
 			inb_p(WDT_DC);		/* Disable counters */
 			wdt_ctr_load(2,0);	/* 0 length reset pulses now */
+		} else {
+			printk(KERN_CRIT "wdt: WDT device closed unexpectedly.  WDT will not stop!\n");
 		}
 		clear_bit(0, &wdt_is_open);
 	}
diff -uNr linux-2.4.19-pre9-magicclose-fix/drivers/char/wdt977.c linux-2.4.19-pre9-magicclose/drivers/char/wdt977.c
--- linux-2.4.19-pre9-magicclose-fix/drivers/char/wdt977.c	Thu May 30 17:50:23 2002
+++ linux-2.4.19-pre9-magicclose/drivers/char/wdt977.c	Fri May 31 15:10:59 2002
@@ -33,6 +33,7 @@
 static	int timeout = 3;
 static	int timer_alive;
 static	int testmode;
+static	int expect_close = 0;
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 static int nowayout = 1;
@@ -103,48 +104,64 @@
 	 *	Shut off the timer.
 	 * 	Lock it in if it's a module and we set nowayout
 	 */
-	if (!nowayout) { /* FIXME: not fixing indentation */
 	lock_kernel();
+	if (expect_close) {
 
-	// unlock the SuperIO chip
-	outb(0x87,0x370); 
-	outb(0x87,0x370); 
-	
-	//select device Aux2 (device=8) and set watchdog regs F2,F3 and F4
-	//F3 is reset to its default state
-	//F4 can clear the TIMEOUT'ed state (bit 0) - back to default
-	//We can not use GP17 as a PowerLed, as we use its usage as a RedLed
+		// unlock the SuperIO chip
+		outb(0x87,0x370); 
+		outb(0x87,0x370); 
+	
+		//select device Aux2 (device=8) and set watchdog regs F2,F3 and F4
+		//F3 is reset to its default state
+		//F4 can clear the TIMEOUT'ed state (bit 0) - back to default
+		//We can not use GP17 as a PowerLed, as we use its usage as a RedLed
 	
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
 	
-	//at last select device Aux1 (dev=7) and set GP16 as a watchdog output
-	outb(0x07,0x370);
-	outb(0x07,0x371);
-	outb(0xE6,0x370);
-	outb(0x08,0x371);
+		//at last select device Aux1 (dev=7) and set GP16 as a watchdog output
+		outb(0x07,0x370);
+		outb(0x07,0x371);
+		outb(0xE6,0x370);
+		outb(0x08,0x371);
 	
-	// lock the SuperIO chip
-	outb(0xAA,0x370);
+		// lock the SuperIO chip
+		outb(0xAA,0x370);
+		printk(KERN_INFO "Watchdog: shutdown.\n");
+	} else {
+		printk(KERN_CRIT "WDT device closed unexpectedly.  WDT will not stop!\n");
+	}
 
 	timer_alive=0;
 	unlock_kernel();
 
-	printk(KERN_INFO "Watchdog: shutdown.\n");
-	}
 	return 0;
 }
 
 static ssize_t wdt977_write(struct file *file, const char *data, size_t len, loff_t *ppos)
 {
+	if (!nowayout) {
+		size_t i;
+
+		/* In case it was set long ago */
+		expect_close = 0;
+
+		for (i = 0; i != len; i++) {
+			char c;
+			if (get_user(c, data + i))
+				return -EFAULT;
+			if (c == 'V')
+				expect_close = 1;
+		}
+	}
 
 	//max timeout value = 255 minutes (0xFF). Write 0 to disable WatchDog.
 	if (timeout>255)
diff -uNr linux-2.4.19-pre9-magicclose-fix/drivers/char/wdt_pci.c linux-2.4.19-pre9-magicclose/drivers/char/wdt_pci.c
--- linux-2.4.19-pre9-magicclose-fix/drivers/char/wdt_pci.c	Fri May 31 14:33:39 2002
+++ linux-2.4.19-pre9-magicclose/drivers/char/wdt_pci.c	Fri May 31 15:59:04 2002
@@ -314,7 +314,7 @@
 	{
 		WDIOF_OVERHEAT|WDIOF_POWERUNDER|WDIOF_POWEROVER
 			|WDIOF_EXTERN1|WDIOF_EXTERN2|WDIOF_FANFAULT
-			|WDIOF_SETTIMEOUT,
+			|WDIOF_SETTIMEOUT|WDIOF_MAGICCLOSE,
 		1,
 		"WDT500/501PCI"
 	};
diff -uNr linux-2.4.19-pre9-magicclose-fix/include/linux/watchdog.h linux-2.4.19-pre9-magicclose/include/linux/watchdog.h
--- linux-2.4.19-pre9-magicclose-fix/include/linux/watchdog.h	Thu May 30 15:19:48 2002
+++ linux-2.4.19-pre9-magicclose/include/linux/watchdog.h	Fri May 31 14:56:22 2002
@@ -39,6 +39,7 @@
 #define	WDIOF_CARDRESET		0x0020	/* Card previously reset the CPU */
 #define WDIOF_POWEROVER		0x0040	/* Power over voltage */
 #define WDIOF_SETTIMEOUT	0x0080  /* Set timeout (in seconds) */
+#define WDIOF_MAGICCLOSE	0x0100	/* Supports magic close char */
 #define	WDIOF_KEEPALIVEPING	0x8000	/* Keep alive ping reply */
 
 #define	WDIOS_DISABLECARD	0x0001	/* Turn off the watchdog timer */

-- 

"Glory is fleeting, but obscurity is forever."  
         - Napoleon Bonaparte

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
