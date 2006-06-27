Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbWF0SV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbWF0SV6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWF0SV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:21:58 -0400
Received: from sccrmhc14.comcast.net ([63.240.77.84]:23026 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932519AbWF0SV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:21:57 -0400
Date: Tue, 27 Jun 2006 13:22:25 -0500
From: minyard@acm.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH] watchdog: add pretimeout ioctl
Message-ID: <20060627182225.GD10805@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some watchdog timers support the concept of a "pretimeout" which
occurs some time before the real timeout.  The pretimeout can
be delivered via an interrupt or NMI and can be used to panic
the system when it occurs (so you get useful information instead
of a blind reboot).

The IPMI watchdog has had this built in, but this creates a standard
mechanism for all watchdogs and switches the IPMI driver over to it.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.16/Documentation/watchdog/watchdog-api.txt
===================================================================
--- linux-2.6.16.orig/Documentation/watchdog/watchdog-api.txt
+++ linux-2.6.16/Documentation/watchdog/watchdog-api.txt
@@ -107,7 +107,31 @@ current timeout using the GETTIMEOUT ioc
     ioctl(fd, WDIOC_GETTIMEOUT, &timeout);
     printf("The timeout was is %d seconds\n", timeout);
 
-Envinronmental monitoring:
+Pretimeouts:
+
+Some watchdog timers can be set to have a trigger go off before the
+actual time they will reset the system.  This can be done with an NMI,
+interrupt, or other mechanism.  This allows Linux to record useful
+information (like panic information and kernel coredumps) before it
+resets.
+
+    pretimeout = 10;
+    ioctl(fd, WDIOC_SETPRETIMEOUT, &pretimeout);
+
+Note that the pretimeout is the number of seconds before the time
+when the timeout will go off.  It is not the number of seconds until
+the pretimeout.  So, for instance, if you set the timeout to 60 seconds
+and the pretimeout to 10 seconds, the pretimout will go of in 50
+seconds.  Setting a pretimeout to zero disables it.
+
+There is also a get function for getting the pretimeout:
+
+    ioctl(fd, WDIOC_GETPRETIMEOUT, &timeout);
+    printf("The pretimeout was is %d seconds\n", timeout);
+
+Not all watchdog drivers will support a pretimeout.
+
+Environmental monitoring:
 
 All watchdog drivers are required return more information about the system,
 some do temperature, fan and power level monitoring, some can tell you
@@ -166,6 +190,10 @@ The watchdog saw a keepalive ping since 
 
 	WDIOF_SETTIMEOUT	Can set/get the timeout
 
+The watchdog can do pretimeouts.
+
+	WDIOF_PRETIMEOUT	Pretimeout (in seconds), get/set
+
 
 For those drivers that return any bits set in the option field, the
 GETSTATUS and GETBOOTSTATUS ioctls can be used to ask for the current
Index: linux-2.6.16/drivers/char/ipmi/ipmi_watchdog.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_watchdog.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_watchdog.c
@@ -122,16 +122,9 @@
 #define IPMI_WDOG_SET_TIMER		0x24
 #define IPMI_WDOG_GET_TIMER		0x25
 
-/* These are here until the real ones get into the watchdog.h interface. */
-#ifndef WDIOC_GETTIMEOUT
-#define	WDIOC_GETTIMEOUT        _IOW(WATCHDOG_IOCTL_BASE, 20, int)
-#endif
-#ifndef WDIOC_SET_PRETIMEOUT
-#define	WDIOC_SET_PRETIMEOUT     _IOW(WATCHDOG_IOCTL_BASE, 21, int)
-#endif
-#ifndef WDIOC_GET_PRETIMEOUT
-#define	WDIOC_GET_PRETIMEOUT     _IOW(WATCHDOG_IOCTL_BASE, 22, int)
-#endif
+/* These are here for backwards compatability for a while. */
+#define	WDIOC_OLD_IPMI_SET_PRETIMEOUT     _IOW(WATCHDOG_IOCTL_BASE, 21, int)
+#define	WDIOC_OLD_IPMI_GET_PRETIMEOUT     _IOW(WATCHDOG_IOCTL_BASE, 22, int)
 
 static int nowayout = WATCHDOG_NOWAYOUT;
 
@@ -598,7 +591,8 @@ static void panic_halt_ipmi_heartbeat(vo
 
 static struct watchdog_info ident =
 {
-	.options	= 0,	/* WDIOF_SETTIMEOUT, */
+	.options	= (WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE
+			   | WDIOF_PRETIMEOUT),
 	.firmware_version = 1,
 	.identity	= "IPMI"
 };
@@ -628,14 +622,16 @@ static int ipmi_ioctl(struct inode *inod
 			return -EFAULT;
 		return 0;
 
-	case WDIOC_SET_PRETIMEOUT:
+	case WDIOC_OLD_IPMI_SET_PRETIMEOUT:
+	case WDIOC_SETPRETIMEOUT:
 		i = copy_from_user(&val, argp, sizeof(int));
 		if (i)
 			return -EFAULT;
 		pretimeout = val;
 		return ipmi_set_timeout(IPMI_SET_TIMEOUT_HB_IF_NECESSARY);
 
-	case WDIOC_GET_PRETIMEOUT:
+	case WDIOC_OLD_IPMI_GET_PRETIMEOUT:
+	case WDIOC_GETPRETIMEOUT:
 		i = copy_to_user(argp, &pretimeout, sizeof(pretimeout));
 		if (i)
 			return -EFAULT;
Index: linux-2.6.16/include/linux/watchdog.h
===================================================================
--- linux-2.6.16.orig/include/linux/watchdog.h
+++ linux-2.6.16/include/linux/watchdog.h
@@ -28,6 +28,8 @@ struct watchdog_info {
 #define	WDIOC_KEEPALIVE		_IOR(WATCHDOG_IOCTL_BASE, 5, int)
 #define	WDIOC_SETTIMEOUT        _IOWR(WATCHDOG_IOCTL_BASE, 6, int)
 #define	WDIOC_GETTIMEOUT        _IOR(WATCHDOG_IOCTL_BASE, 7, int)
+#define	WDIOC_SETPRETIMEOUT     _IOWR(WATCHDOG_IOCTL_BASE, 8, int)
+#define	WDIOC_GETPRETIMEOUT     _IOR(WATCHDOG_IOCTL_BASE, 9, int)
 
 #define	WDIOF_UNKNOWN		-1	/* Unknown flag error */
 #define	WDIOS_UNKNOWN		-1	/* Unknown status error */
@@ -41,6 +43,7 @@ struct watchdog_info {
 #define WDIOF_POWEROVER		0x0040	/* Power over voltage */
 #define WDIOF_SETTIMEOUT	0x0080  /* Set timeout (in seconds) */
 #define WDIOF_MAGICCLOSE	0x0100	/* Supports magic close char */
+#define WDIOF_PRETIMEOUT	0x0200  /* Pretimeout (in seconds), get/set */
 #define	WDIOF_KEEPALIVEPING	0x8000	/* Keep alive ping reply */
 
 #define	WDIOS_DISABLECARD	0x0001	/* Turn off the watchdog timer */
