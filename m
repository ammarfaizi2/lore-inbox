Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317034AbSHHAQd>; Wed, 7 Aug 2002 20:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317059AbSHHAQd>; Wed, 7 Aug 2002 20:16:33 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:62206 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S317034AbSHHAPq>; Wed, 7 Aug 2002 20:15:46 -0400
Date: Wed, 7 Aug 2002 17:19:17 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: linux-kernel@vger.kernel.org, Rob Radez <rob@osinvestor.com>,
       Matt Domsch <Matt_Domsch@dell.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       marcelo@conectiva.com.br
Subject: [PATCH] [2.4.20-pre1] Watchdog Stuff (4/4)
Message-ID: <20020808001916.GE1038@nic1-pc.us.oracle.com>
References: <20020808001238.GB1038@nic1-pc.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020808001238.GB1038@nic1-pc.us.oracle.com>
User-Agent: Mutt/1.3.28i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The fourth patch, adding magicclose to the drivers that seem
able to support it.

Joel

diff -uNr linux-2.4.20-pre1-magicclose-fix/drivers/char/acquirewdt.c linux-2.4.20-pre1-magicclose/drivers/char/acquirewdt.c
--- linux-2.4.20-pre1-magicclose-fix/drivers/char/acquirewdt.c	Wed Aug  7 15:30:18 2002
+++ linux-2.4.20-pre1-magicclose/drivers/char/acquirewdt.c	Wed Aug  7 15:59:19 2002
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
@@ -156,8 +172,13 @@
 	if(MINOR(inode->i_rdev)==WATCHDOG_MINOR)
 	{
 		spin_lock(&acq_lock);
-		if (!nowayout) {
+		if (expect_close)
+		{
 			inb_p(WDT_STOP);
+		}
+		else
+		{
+			printk(KERN_CRIT "WDT closed unexpectedly.  WDT will not stop!\n");
 		}
 		acq_is_open=0;
 		spin_unlock(&acq_lock);
diff -uNr linux-2.4.20-pre1-magicclose-fix/drivers/char/advantechwdt.c linux-2.4.20-pre1-magicclose/drivers/char/advantechwdt.c
--- linux-2.4.20-pre1-magicclose-fix/drivers/char/advantechwdt.c	Wed Aug  7 15:40:06 2002
+++ linux-2.4.20-pre1-magicclose/drivers/char/advantechwdt.c	Wed Aug  7 15:59:19 2002
@@ -143,7 +143,7 @@
 {
 	int new_margin;
 	static struct watchdog_info ident = {
-		options:		WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+		options:		WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 		firmware_version:	0,
 		identity:		"Advantech WDT"
 	};
diff -uNr linux-2.4.20-pre1-magicclose-fix/drivers/char/alim7101_wdt.c linux-2.4.20-pre1-magicclose/drivers/char/alim7101_wdt.c
--- linux-2.4.20-pre1-magicclose-fix/drivers/char/alim7101_wdt.c	Wed Aug  7 15:40:06 2002
+++ linux-2.4.20-pre1-magicclose/drivers/char/alim7101_wdt.c	Wed Aug  7 15:59:19 2002
@@ -221,7 +221,7 @@
 {
 	static struct watchdog_info ident=
 	{
-		0,
+		WDIOF_MAGICCLOSE,
 		1,
 		"ALiM7101"
 	};
diff -uNr linux-2.4.20-pre1-magicclose-fix/drivers/char/eurotechwdt.c linux-2.4.20-pre1-magicclose/drivers/char/eurotechwdt.c
--- linux-2.4.20-pre1-magicclose-fix/drivers/char/eurotechwdt.c	Wed Aug  7 15:40:06 2002
+++ linux-2.4.20-pre1-magicclose/drivers/char/eurotechwdt.c	Wed Aug  7 15:59:19 2002
@@ -265,7 +265,7 @@
         unsigned int cmd, unsigned long arg)
 {
    static struct watchdog_info ident = {
-      options		: WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+      options		: WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
       firmware_version	: 0,
       identity		: "WDT Eurotech CPU-1220/1410"
    };
diff -uNr linux-2.4.20-pre1-magicclose-fix/drivers/char/i810-tco.c linux-2.4.20-pre1-magicclose/drivers/char/i810-tco.c
--- linux-2.4.20-pre1-magicclose-fix/drivers/char/i810-tco.c	Fri Aug  2 17:39:43 2002
+++ linux-2.4.20-pre1-magicclose/drivers/char/i810-tco.c	Wed Aug  7 15:53:37 2002
@@ -241,7 +241,9 @@
 	int options, retval = -EINVAL;
 
 	static struct watchdog_info ident = {
-		options:		WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+		options:		WDIOF_SETTIMEOUT |
+					WDIOF_KEEPALIVEPING |
+					WDIOF_MAGICCLOSE,
 		firmware_version:	0,
 		identity:		"i810 TCO timer",
 	};
diff -uNr linux-2.4.20-pre1-magicclose-fix/drivers/char/ib700wdt.c linux-2.4.20-pre1-magicclose/drivers/char/ib700wdt.c
--- linux-2.4.20-pre1-magicclose-fix/drivers/char/ib700wdt.c	Wed Aug  7 15:30:18 2002
+++ linux-2.4.20-pre1-magicclose/drivers/char/ib700wdt.c	Wed Aug  7 15:59:19 2002
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
diff -uNr linux-2.4.20-pre1-magicclose-fix/drivers/char/indydog.c linux-2.4.20-pre1-magicclose/drivers/char/indydog.c
--- linux-2.4.20-pre1-magicclose-fix/drivers/char/indydog.c	Wed Aug  7 15:30:18 2002
+++ linux-2.4.20-pre1-magicclose/drivers/char/indydog.c	Wed Aug  7 15:59:19 2002
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
diff -uNr linux-2.4.20-pre1-magicclose-fix/drivers/char/machzwd.c linux-2.4.20-pre1-magicclose/drivers/char/machzwd.c
--- linux-2.4.20-pre1-magicclose-fix/drivers/char/machzwd.c	Wed Aug  7 15:40:06 2002
+++ linux-2.4.20-pre1-magicclose/drivers/char/machzwd.c	Wed Aug  7 15:59:19 2002
@@ -117,7 +117,7 @@
 #define PFX "machzwd"
 
 static struct watchdog_info zf_info = {
-	options:		WDIOF_KEEPALIVEPING, 
+	options:		WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE, 
 	firmware_version:	1, 
 	identity:		"ZF-Logic watchdog"
 };
diff -uNr linux-2.4.20-pre1-magicclose-fix/drivers/char/mixcomwd.c linux-2.4.20-pre1-magicclose/drivers/char/mixcomwd.c
--- linux-2.4.20-pre1-magicclose-fix/drivers/char/mixcomwd.c	Wed Aug  7 15:30:18 2002
+++ linux-2.4.20-pre1-magicclose/drivers/char/mixcomwd.c	Wed Aug  7 15:59:19 2002
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
diff -uNr linux-2.4.20-pre1-magicclose-fix/drivers/char/pcwd.c linux-2.4.20-pre1-magicclose/drivers/char/pcwd.c
--- linux-2.4.20-pre1-magicclose-fix/drivers/char/pcwd.c	Wed Aug  7 15:35:44 2002
+++ linux-2.4.20-pre1-magicclose/drivers/char/pcwd.c	Wed Aug  7 15:58:40 2002
@@ -88,6 +88,7 @@
 
 static int timeout_val;
 static int timeout = 2;
+static int expect_close = 0;
 
 MODULE_PARM (timeout, "i");
 MODULE_PARM_DESC (timeout, "Watchdog timeout in seconds (default=2)");
@@ -213,7 +214,7 @@
 	spin_unlock (&io_lock);
 
 	/* Transform the card register to the ioctl bits we use internally */
-	retval = 0;
+	retval = WDIOF_MAGICCLOSE;
 	if (status & WD_WDRST)
 		retval |= WDIOF_CARDRESET;
 	if (status & WD_T110)
@@ -385,6 +386,20 @@
 		return -ESPIPE;
 
 	if (len) {
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
 		pcwd_info.card_info->wd_tickle ();
 		return 1;
 	}
@@ -450,7 +465,7 @@
 {
 	switch (MINOR (ino->i_rdev)) {
 	case WATCHDOG_MINOR:
-		if (!nowayout)
+		if (expect_close)
 			pcwd_info.card_info->enable_card (0);
 
 		atomic_inc (&pcwd_info.open_allowed);
diff -uNr linux-2.4.20-pre1-magicclose-fix/drivers/char/sbc60xxwdt.c linux-2.4.20-pre1-magicclose/drivers/char/sbc60xxwdt.c
--- linux-2.4.20-pre1-magicclose-fix/drivers/char/sbc60xxwdt.c	Thu Sep 13 15:21:32 2001
+++ linux-2.4.20-pre1-magicclose/drivers/char/sbc60xxwdt.c	Wed Aug  7 15:59:19 2002
@@ -234,7 +234,7 @@
 {
 	static struct watchdog_info ident=
 	{
-		0,
+		WDIOF_MAGICCLOSE,
 		1,
 		"SB60xx"
 	};
diff -uNr linux-2.4.20-pre1-magicclose-fix/drivers/char/sc1200wdt.c linux-2.4.20-pre1-magicclose/drivers/char/sc1200wdt.c
--- linux-2.4.20-pre1-magicclose-fix/drivers/char/sc1200wdt.c	Wed Aug  7 15:40:06 2002
+++ linux-2.4.20-pre1-magicclose/drivers/char/sc1200wdt.c	Wed Aug  7 15:59:19 2002
@@ -171,7 +171,7 @@
 {
 	int new_timeout;
 	static struct watchdog_info ident = {
-		options:		WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+		options:		WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 		firmware_version:	0,
 		identity:		"PC87307/PC97307"
 	};
diff -uNr linux-2.4.20-pre1-magicclose-fix/drivers/char/sc520_wdt.c linux-2.4.20-pre1-magicclose/drivers/char/sc520_wdt.c
--- linux-2.4.20-pre1-magicclose-fix/drivers/char/sc520_wdt.c	Wed Aug  7 15:40:06 2002
+++ linux-2.4.20-pre1-magicclose/drivers/char/sc520_wdt.c	Wed Aug  7 15:59:19 2002
@@ -269,7 +269,7 @@
 {
 	static struct watchdog_info ident=
 	{
-		0,
+		WDIOF_MAGICCLOSE,
 		1,
 		"SC520"
 	};
diff -uNr linux-2.4.20-pre1-magicclose-fix/drivers/char/shwdt.c linux-2.4.20-pre1-magicclose/drivers/char/shwdt.c
--- linux-2.4.20-pre1-magicclose-fix/drivers/char/shwdt.c	Wed Aug  7 15:40:06 2002
+++ linux-2.4.20-pre1-magicclose/drivers/char/shwdt.c	Wed Aug  7 15:59:19 2002
@@ -347,7 +347,7 @@
 };
 
 static struct watchdog_info sh_wdt_info = {
-	options:		WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+	options:		WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 	firmware_version:	0,
 	identity:		"SH WDT",
 };
diff -uNr linux-2.4.20-pre1-magicclose-fix/drivers/char/softdog.c linux-2.4.20-pre1-magicclose/drivers/char/softdog.c
--- linux-2.4.20-pre1-magicclose-fix/drivers/char/softdog.c	Wed Aug  7 15:30:18 2002
+++ linux-2.4.20-pre1-magicclose/drivers/char/softdog.c	Wed Aug  7 15:59:19 2002
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
diff -uNr linux-2.4.20-pre1-magicclose-fix/drivers/char/w83877f_wdt.c linux-2.4.20-pre1-magicclose/drivers/char/w83877f_wdt.c
--- linux-2.4.20-pre1-magicclose-fix/drivers/char/w83877f_wdt.c	Wed Aug  7 15:40:06 2002
+++ linux-2.4.20-pre1-magicclose/drivers/char/w83877f_wdt.c	Wed Aug  7 15:59:19 2002
@@ -251,7 +251,7 @@
 {
 	static struct watchdog_info ident=
 	{
-		0,
+		WDIOF_MAGICCLOSE,
 		1,
 		"W83877F"
 	};
diff -uNr linux-2.4.20-pre1-magicclose-fix/drivers/char/wafer5823wdt.c linux-2.4.20-pre1-magicclose/drivers/char/wafer5823wdt.c
--- linux-2.4.20-pre1-magicclose-fix/drivers/char/wafer5823wdt.c	Wed Aug  7 15:30:18 2002
+++ linux-2.4.20-pre1-magicclose/drivers/char/wafer5823wdt.c	Wed Aug  7 15:59:19 2002
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
diff -uNr linux-2.4.20-pre1-magicclose-fix/drivers/char/wdt.c linux-2.4.20-pre1-magicclose/drivers/char/wdt.c
--- linux-2.4.20-pre1-magicclose-fix/drivers/char/wdt.c	Wed Aug  7 15:30:18 2002
+++ linux-2.4.20-pre1-magicclose/drivers/char/wdt.c	Wed Aug  7 15:59:19 2002
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
diff -uNr linux-2.4.20-pre1-magicclose-fix/drivers/char/wdt977.c linux-2.4.20-pre1-magicclose/drivers/char/wdt977.c
--- linux-2.4.20-pre1-magicclose-fix/drivers/char/wdt977.c	Wed Aug  7 15:30:18 2002
+++ linux-2.4.20-pre1-magicclose/drivers/char/wdt977.c	Wed Aug  7 15:59:19 2002
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
diff -uNr linux-2.4.20-pre1-magicclose-fix/drivers/char/wdt_pci.c linux-2.4.20-pre1-magicclose/drivers/char/wdt_pci.c
--- linux-2.4.20-pre1-magicclose-fix/drivers/char/wdt_pci.c	Wed Aug  7 15:40:06 2002
+++ linux-2.4.20-pre1-magicclose/drivers/char/wdt_pci.c	Wed Aug  7 15:59:19 2002
@@ -314,7 +314,7 @@
 	{
 		WDIOF_OVERHEAT|WDIOF_POWERUNDER|WDIOF_POWEROVER
 			|WDIOF_EXTERN1|WDIOF_EXTERN2|WDIOF_FANFAULT
-			|WDIOF_SETTIMEOUT,
+			|WDIOF_SETTIMEOUT|WDIOF_MAGICCLOSE,
 		1,
 		"WDT500/501PCI"
 	};

-- 

"You don't make the poor richer by making the rich poorer."
	- Sir Winston Churchill

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
