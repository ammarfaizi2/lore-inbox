Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316161AbSFAGny>; Sat, 1 Jun 2002 02:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316889AbSFAGnx>; Sat, 1 Jun 2002 02:43:53 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:18375 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S316161AbSFAGnx>; Sat, 1 Jun 2002 02:43:53 -0400
Date: Fri, 31 May 2002 23:43:36 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Radez <rob@osinvestor.com>, Matt Domsch <Matt_Domsch@dell.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Watchdog Stuff (1/4)
Message-ID: <20020601064309.GA10222@insight.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Here are four patches for the watchdog drivers.  These patches
are against 2.4.19-pre9.
	The first patch (this one) adds WDIOC_SETTIMEOUT support to
wafer5823wdt.c.  The second patch adds Matt Domsch's 'nowayout' module
option to the drivers that currently don't have it.  The third patch
fixes a bug where most of the "magic close character" capable drivers
don't use get_user().  The fourth patch adds "magic close character"
support to almost all of the remaining drivers.  It also adds
WDIOF_MAGICCLOSE to the driver info flags.


--- linux-2.4.19-pre9/drivers/char/wafer5823wdt.c	Tue May 28 18:51:38 2002
+++ linux-2.4.19-pre9-nowayout/drivers/char/wafer5823wdt.c	Thu May 30 15:34:14 2002
@@ -54,6 +54,7 @@
 #define WDT_STOP 0x843
 
 #define WD_TIMO 60		/* 1 minute */
+static int wd_margin = WD_TIMO;
 
 static void wafwdt_ping(void)
 {
@@ -67,7 +68,7 @@
 static void wafwdt_start(void)
 {
 	/* start up watchdog */
-	outb_p(WD_TIMO, WDT_START);
+	outb_p(wd_margin, WDT_START);
 	inb_p(WDT_START);
 }
 
@@ -94,8 +95,10 @@
 static int wafwdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 	     unsigned long arg)
 {
+	int new_margin;
 	static struct watchdog_info ident = {
-		WDIOF_KEEPALIVEPING, 1, "Wafer 5823 WDT"
+		WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+		1, "Wafer 5823 WDT"
 	};
 	int one=1;
 
@@ -115,6 +118,18 @@
 		wafwdt_ping();
 		break;
 
+	case WDIOC_SETTIMEOUT:
+		if (get_user(new_margin, (int *)arg))
+			return -EFAULT;
+		if ((new_margin < 1) || (new_margin > 255))
+			return -EINVAL;
+		wd_margin = new_margin;
+		wafwdt_stop();
+		wafwdt_start();
+		/* Fall */
+	case WDIOC_GETTIMEOUT:
+		return put_user(wd_margin, (int *)arg);
+
 	default:
 		return -ENOTTY;
 	}

-- 

"There are only two ways to live your life. One is as though nothing
 is a miracle. The other is as though everything is a miracle."
        - Albert Einstein

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
