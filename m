Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290815AbSAYV1E>; Fri, 25 Jan 2002 16:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290814AbSAYV0z>; Fri, 25 Jan 2002 16:26:55 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:29826 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S290811AbSAYV0m>;
	Fri, 25 Jan 2002 16:26:42 -0500
Message-ID: <3C51CD91.7020703@acm.org>
Date: Fri, 25 Jan 2002 15:26:41 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Patches to include/linux/watchdog.h to document the functions
Content-Type: multipart/mixed;
 boundary="------------090604070309020601070809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090604070309020601070809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The include/linux/watchdog.h is, well, a little hard to read and 
understand.  I have attached a patch that documents this as best as I 
can understand it.  It also add a few small things.  It would be nice to 
get all the watchdogs to conform to one interface for things like 
setting the timeout, they all seem to have their own unique ways of 
doing a lot of things.

-Corey

--------------090604070309020601070809
Content-Type: text/plain;
 name="linux-watchdog.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-watchdog.diff"

--- ./drivers/char/pcwd.c.watchdog	Fri Jan 25 11:17:52 2002
+++ ./drivers/char/pcwd.c	Fri Jan 25 11:20:52 2002
@@ -250,6 +250,8 @@
 		return -ENOTTY;
 
 	case WDIOC_GETSUPPORT:
+		if (supports_temp)
+			ident.options |= WDIOF_GETTEMP;
 		i = copy_to_user((void*)arg, &ident, sizeof(ident));
 		return i ? -EFAULT : 0;
 
--- ./include/linux/watchdog.h.watchdog	Fri Jan 25 09:36:24 2002
+++ ./include/linux/watchdog.h	Fri Jan 25 11:17:21 2002
@@ -14,22 +14,53 @@
 #define	WATCHDOG_IOCTL_BASE	'W'
 
 struct watchdog_info {
-	__u32 options;		/* Options the card/driver supports */
+	__u32 options;		/* Options the card/driver supports, see
+				   WDIOF_xxx below. */
 	__u32 firmware_version;	/* Firmware version of the card */
 	__u8  identity[32];	/* Identity of the board */
 };
 
-#define	WDIOC_GETSUPPORT	_IOR(WATCHDOG_IOCTL_BASE, 0, struct watchdog_info)
-#define	WDIOC_GETSTATUS		_IOR(WATCHDOG_IOCTL_BASE, 1, int)
-#define	WDIOC_GETBOOTSTATUS	_IOR(WATCHDOG_IOCTL_BASE, 2, int)
-#define	WDIOC_GETTEMP		_IOR(WATCHDOG_IOCTL_BASE, 3, int)
-#define	WDIOC_SETOPTIONS	_IOR(WATCHDOG_IOCTL_BASE, 4, int)
-#define	WDIOC_KEEPALIVE		_IOR(WATCHDOG_IOCTL_BASE, 5, int)
-#define	WDIOC_SETTIMEOUT        _IOW(WATCHDOG_IOCTL_BASE, 6, int)
+/* Get information about what the watchdog timer supports. */
+#define	WDIOC_GETSUPPORT     _IOR(WATCHDOG_IOCTL_BASE, 0, struct watchdog_info)
+
+/* Return the current status of the watchdog. */
+#define	WDIOC_GETSTATUS	     _IOR(WATCHDOG_IOCTL_BASE, 1, int)
+
+/* Return the status of the watchdog when the driver was started.
+   This will have set WFIOF_CARDRESET if the last reset was due to a
+   watchdog, and if the watchdog had an alternate reason (besides
+   timeout) for the reset, then one of the reason bits from the
+   WDIOF_xxx will be set. */
+#define	WDIOC_GETBOOTSTATUS  _IOR(WATCHDOG_IOCTL_BASE, 2, int)
+
+/* Return the current temperature (only for cards that have a
+   temperature probe). */
+#define	WDIOC_GETTEMP	     _IOR(WATCHDOG_IOCTL_BASE, 3, int)
+
+/* Set options (see WDIOS_xxx for options). */
+#define	WDIOC_SETOPTIONS     _IOR(WATCHDOG_IOCTL_BASE, 4, int)
+
+/* Ping the keepalive to keep us alive for another timeout. */
+#define	WDIOC_KEEPALIVE	     _IOR(WATCHDOG_IOCTL_BASE, 5, int)
+
+/* Set the timeout for the watchdog.  The parameter is generally an
+   integer number of milliseconds, the watchdog timer will be set to
+   the first value larger than the given time.  It will return EINVAL
+   if the timeout is beyond the capability of the watchdog timer.  For
+   some boards, it is a custom timeout that is board dependent.  Note
+   that this function will automatically does the keepalive for the
+   watchdog. */
+#define	WDIOC_SETTIMEOUT     _IOW(WATCHDOG_IOCTL_BASE, 6, int)
 
 #define	WDIOF_UNKNOWN		-1	/* Unknown flag error */
 #define	WDIOS_UNKNOWN		-1	/* Unknown status error */
 
+/* Various options a card may support returned by GETSUPPORT, and also
+   status returned by GETSTATUS.  If the bit is set in the options
+   field returned by GETSUPPORT, then the value may be returned by
+   GETSTATUS.  The SETTIMEOUT and GETTEMP are the only real
+   exceptions, they is returned by GETSUPPORT, indicating the card is
+   capable, but set by separate SETTIMEOUT and GETTEMP ioctls. */
 #define	WDIOF_OVERHEAT		0x0001	/* Reset due to CPU overheat */
 #define	WDIOF_FANFAULT		0x0002	/* Fan failed */
 #define	WDIOF_EXTERN1		0x0004	/* External relay 1 */
@@ -37,9 +68,22 @@
 #define	WDIOF_POWERUNDER	0x0010	/* Power bad/power fault */
 #define	WDIOF_CARDRESET		0x0020	/* Card previously reset the CPU */
 #define WDIOF_POWEROVER		0x0040	/* Power over voltage */
+#define WDIOF_SETTIMEOUT	0x0080	/* Can the timeout be set? */
+#define WDIOF_GETTEMP		0x0100	/* Can the temperature be read? */
 #define	WDIOF_KEEPALIVEPING	0x8000	/* Keep alive ping reply */
 
-#define	WDIOS_DISABLECARD	0x0001	/* Turn off the watchdog timer */
+/* The following are options that may be set by WDIOC_SETOPTIONS. */
+#define	WDIOS_DISABLECARD	0x0001	/* Turn off the watchdog
+					   timer. If the watchdog is
+					   set to go off even if the
+					   device gets closed, the
+					   application can disable the
+					   watchdog to prevent it from
+					   resetting the card if the
+					   reboot is not wanted.  Note
+					   that setting the timeout or
+					   re-opening the driver will
+					   re-enable the watchdog. */
 #define	WDIOS_ENABLECARD	0x0002	/* Turn on the watchdog timer */
 #define	WDIOS_TEMPPANIC		0x0004	/* Kernel panic on temperature trip */
 

--------------090604070309020601070809--

