Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWF1Tfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWF1Tfs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWF1Tfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:35:48 -0400
Received: from outmx018.isp.belgacom.be ([195.238.4.117]:10410 "EHLO
	outmx018.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1751084AbWF1Tfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:35:47 -0400
Date: Wed, 28 Jun 2006 21:31:45 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [WATCHDOG] v2.6.17 watchdog patches
Message-ID: <20060628193145.GA2738@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from 'master' branch of
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git

This will update the following files:

 Documentation/watchdog/pcwd-watchdog.txt     |   75 ------------------------
 Documentation/watchdog/src/watchdog-simple.c |   15 ++++
 Documentation/watchdog/src/watchdog-test.c   |   68 ++++++++++++++++++++++
 Documentation/watchdog/watchdog-api.txt      |   56 ++++++++++++------
 Documentation/watchdog/watchdog.txt          |   23 -------
 drivers/char/watchdog/at91_wdt.c             |   82 +++++++++++++++++++++++----
 drivers/char/watchdog/i8xx_tco.c             |   28 ++++++++-
 drivers/char/watchdog/pcwd_pci.c             |   30 +++++++++
 drivers/char/watchdog/pcwd_usb.c             |   23 +++++++
 include/linux/watchdog.h                     |   10 ++-
 10 files changed, 283 insertions(+), 127 deletions(-)

with these Changes:

Author: Randy Dunlap <rdunlap@xenotime.net>
Date:   Sun May 21 20:58:10 2006 -0700

    [WATCHDOG] Documentation/watchdog update
    
    Documentation/watchdog/:
    Expose example and tool source files in the Documentation/ directory in
    their own files instead of being buried (almost hidden) in readme/txt files.
    
    This will make them more visible/usable to users who may need
    to use them, to developers who may need to test with them, and
    to janitors who would update them if they were more visible.
    
    Also, if any of these possibly should not be in the kernel tree at
    all, it will be clearer that they are here and we can discuss if
    they should be removed.
    
    Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

Author: Andrew Victor <andrew@sanpeople.com>
Date:   Sun May 21 15:32:59 2006 +0200

    [WATCHDOG] convert AT91RM9200 watchdog to platform driver
    
    Converted to a platform driver.
    Added suspend/resume support - the watchdog is disabled during the
    sleep states.
    
    Original patch from David Brownell.
    
    Signed-off-by: Andrew Victor <andrew@sanpeople.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sun May 21 12:48:44 2006 +0200

    [WATCHDOG] add WDIOC_GETTIMELEFT ioctl
    
    Some watchdog drivers have the ability to report the remaining time
    before the system will reboot. With the WDIOC_GETTIMELEFT ioctl
    you can now read the time left before the watchdog would reboot
    your system.
    
    The following drivers support this new IOCTL:
    i8xx_tco.c, pcwd_pci.c and pcwd_usb.c .
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

Author: Corey Minyard <minyard@acm.org>
Date:   Wed Apr 19 22:40:53 2006 +0200

    [WATCHDOG] Pre-Timeout flags
    
    Some watchdog timers support the concept of a "pretimeout" which
    occurs some time before the real timeout.  The pretimeout can
    be delivered via an interrupt or NMI and can be used to panic
    the system when it occurs (so you get useful information instead
    of a blind reboot).
    
    Signed-off-by: Corey Minyard <minyard@acm.org>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

The Changes can also be looked at on:
	http://www.kernel.org/git/?p=linux/kernel/git/wim/linux-2.6-watchdog.git;a=summary

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/Documentation/watchdog/pcwd-watchdog.txt b/Documentation/watchdog/pcwd-watchdog.txt
index 12187a3..d9ee633 100644
--- a/Documentation/watchdog/pcwd-watchdog.txt
+++ b/Documentation/watchdog/pcwd-watchdog.txt
@@ -22,78 +22,9 @@
  to run the program with an "&" to run it in the background!)
 
  If you want to write a program to be compatible with the PC Watchdog
- driver, simply do the following:
-
--- Snippet of code --
-/*
- * Watchdog Driver Test Program
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/ioctl.h>
-#include <linux/types.h>
-#include <linux/watchdog.h>
-
-int fd;
-
-/*
- * This function simply sends an IOCTL to the driver, which in turn ticks
- * the PC Watchdog card to reset its internal timer so it doesn't trigger
- * a computer reset.
- */
-void keep_alive(void)
-{
-    int dummy;
-
-    ioctl(fd, WDIOC_KEEPALIVE, &dummy);
-}
-
-/*
- * The main program.  Run the program with "-d" to disable the card,
- * or "-e" to enable the card.
- */
-int main(int argc, char *argv[])
-{
-    fd = open("/dev/watchdog", O_WRONLY);
-
-    if (fd == -1) {
-	fprintf(stderr, "Watchdog device not enabled.\n");
-	fflush(stderr);
-	exit(-1);
-    }
-
-    if (argc > 1) {
-	if (!strncasecmp(argv[1], "-d", 2)) {
-	    ioctl(fd, WDIOC_SETOPTIONS, WDIOS_DISABLECARD);
-	    fprintf(stderr, "Watchdog card disabled.\n");
-	    fflush(stderr);
-	    exit(0);
-	} else if (!strncasecmp(argv[1], "-e", 2)) {
-	    ioctl(fd, WDIOC_SETOPTIONS, WDIOS_ENABLECARD);
-	    fprintf(stderr, "Watchdog card enabled.\n");
-	    fflush(stderr);
-	    exit(0);
-	} else {
-	    fprintf(stderr, "-d to disable, -e to enable.\n");
-	    fprintf(stderr, "run by itself to tick the card.\n");
-	    fflush(stderr);
-	    exit(0);
-	}
-    } else {
-	fprintf(stderr, "Watchdog Ticking Away!\n");
-	fflush(stderr);
-    }
-
-    while(1) {
-	keep_alive();
-	sleep(1);
-    }
-}
--- End snippet --
+ driver, simply use of modify the watchdog test program:
+ Documentation/watchdog/src/watchdog-test.c
+
 
  Other IOCTL functions include:
 
diff --git a/Documentation/watchdog/src/watchdog-simple.c b/Documentation/watchdog/src/watchdog-simple.c
new file mode 100644
index 0000000..85cf17c
--- /dev/null
+++ b/Documentation/watchdog/src/watchdog-simple.c
@@ -0,0 +1,15 @@
+#include <stdlib.h>
+#include <fcntl.h>
+
+int main(int argc, const char *argv[]) {
+	int fd = open("/dev/watchdog", O_WRONLY);
+	if (fd == -1) {
+		perror("watchdog");
+		exit(1);
+	}
+	while (1) {
+		write(fd, "\0", 1);
+		fsync(fd);
+		sleep(10);
+	}
+}
diff --git a/Documentation/watchdog/src/watchdog-test.c b/Documentation/watchdog/src/watchdog-test.c
new file mode 100644
index 0000000..65f6c19
--- /dev/null
+++ b/Documentation/watchdog/src/watchdog-test.c
@@ -0,0 +1,68 @@
+/*
+ * Watchdog Driver Test Program
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
+
+int fd;
+
+/*
+ * This function simply sends an IOCTL to the driver, which in turn ticks
+ * the PC Watchdog card to reset its internal timer so it doesn't trigger
+ * a computer reset.
+ */
+void keep_alive(void)
+{
+    int dummy;
+
+    ioctl(fd, WDIOC_KEEPALIVE, &dummy);
+}
+
+/*
+ * The main program.  Run the program with "-d" to disable the card,
+ * or "-e" to enable the card.
+ */
+int main(int argc, char *argv[])
+{
+    fd = open("/dev/watchdog", O_WRONLY);
+
+    if (fd == -1) {
+	fprintf(stderr, "Watchdog device not enabled.\n");
+	fflush(stderr);
+	exit(-1);
+    }
+
+    if (argc > 1) {
+	if (!strncasecmp(argv[1], "-d", 2)) {
+	    ioctl(fd, WDIOC_SETOPTIONS, WDIOS_DISABLECARD);
+	    fprintf(stderr, "Watchdog card disabled.\n");
+	    fflush(stderr);
+	    exit(0);
+	} else if (!strncasecmp(argv[1], "-e", 2)) {
+	    ioctl(fd, WDIOC_SETOPTIONS, WDIOS_ENABLECARD);
+	    fprintf(stderr, "Watchdog card enabled.\n");
+	    fflush(stderr);
+	    exit(0);
+	} else {
+	    fprintf(stderr, "-d to disable, -e to enable.\n");
+	    fprintf(stderr, "run by itself to tick the card.\n");
+	    fflush(stderr);
+	    exit(0);
+	}
+    } else {
+	fprintf(stderr, "Watchdog Ticking Away!\n");
+	fflush(stderr);
+    }
+
+    while(1) {
+	keep_alive();
+	sleep(1);
+    }
+}
diff --git a/Documentation/watchdog/watchdog-api.txt b/Documentation/watchdog/watchdog-api.txt
index 21ed511..958ff3d 100644
--- a/Documentation/watchdog/watchdog-api.txt
+++ b/Documentation/watchdog/watchdog-api.txt
@@ -34,22 +34,7 @@ activates as soon as /dev/watchdog is op
 the watchdog is pinged within a certain time, this time is called the
 timeout or margin.  The simplest way to ping the watchdog is to write
 some data to the device.  So a very simple watchdog daemon would look
-like this:
-
-#include <stdlib.h>
-#include <fcntl.h>
-
-int main(int argc, const char *argv[]) {
-	int fd=open("/dev/watchdog",O_WRONLY);
-	if (fd==-1) {
-		perror("watchdog");
-		exit(1);
-	}
-	while(1) {
-		write(fd, "\0", 1);
-		sleep(10);
-	}
-}
+like this source file:  see Documentation/watchdog/src/watchdog-simple.c
 
 A more advanced driver could for example check that a HTTP server is
 still responding before doing the write call to ping the watchdog.
@@ -110,7 +95,40 @@ current timeout using the GETTIMEOUT ioc
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
+Get the number of seconds before reboot:
+
+Some watchdog drivers have the ability to report the remaining time
+before the system will reboot. The WDIOC_GETTIMELEFT is the ioctl
+that returns the number of seconds before reboot.
+
+    ioctl(fd, WDIOC_GETTIMELEFT, &timeleft);
+    printf("The timeout was is %d seconds\n", timeleft);
+
+Environmental monitoring:
 
 All watchdog drivers are required return more information about the system,
 some do temperature, fan and power level monitoring, some can tell you
@@ -169,6 +187,10 @@ The watchdog saw a keepalive ping since 
 
 	WDIOF_SETTIMEOUT	Can set/get the timeout
 
+The watchdog can do pretimeouts.
+
+	WDIOF_PRETIMEOUT	Pretimeout (in seconds), get/set
+
 
 For those drivers that return any bits set in the option field, the
 GETSTATUS and GETBOOTSTATUS ioctls can be used to ask for the current
diff --git a/Documentation/watchdog/watchdog.txt b/Documentation/watchdog/watchdog.txt
index dffda29..4b1ff69 100644
--- a/Documentation/watchdog/watchdog.txt
+++ b/Documentation/watchdog/watchdog.txt
@@ -65,28 +65,7 @@ The external event interfaces on the WDT
 Minor numbers are however allocated for it.
 
 
-Example Watchdog Driver
------------------------
-
-#include <stdio.h>
-#include <unistd.h>
-#include <fcntl.h>
-
-int main(int argc, const char *argv[])
-{
-	int fd=open("/dev/watchdog",O_WRONLY);
-	if(fd==-1)
-	{
-		perror("watchdog");
-		exit(1);
-	}
-	while(1)
-	{
-		write(fd,"\0",1);
-		fsync(fd);
-		sleep(10);
-	}
-}
+Example Watchdog Driver:  see Documentation/watchdog/src/watchdog-simple.c
 
 
 Contact Information
diff --git a/drivers/char/watchdog/at91_wdt.c b/drivers/char/watchdog/at91_wdt.c
index ac83bc4..0008065 100644
--- a/drivers/char/watchdog/at91_wdt.c
+++ b/drivers/char/watchdog/at91_wdt.c
@@ -17,14 +17,15 @@ #include <linux/kernel.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/platform_device.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 
 
-#define WDT_DEFAULT_TIME	5	/* 5 seconds */
-#define WDT_MAX_TIME		256	/* 256 seconds */
+#define WDT_DEFAULT_TIME	5	/* seconds */
+#define WDT_MAX_TIME		256	/* seconds */
 
 static int wdt_time = WDT_DEFAULT_TIME;
 static int nowayout = WATCHDOG_NOWAYOUT;
@@ -32,8 +33,10 @@ static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(wdt_time, int, 0);
 MODULE_PARM_DESC(wdt_time, "Watchdog time in seconds. (default="__MODULE_STRING(WDT_DEFAULT_TIME) ")");
 
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+#endif
 
 
 static unsigned long at91wdt_busy;
@@ -138,7 +141,7 @@ static int at91_wdt_ioctl(struct inode *
 		case WDIOC_SETTIMEOUT:
 			if (get_user(new_value, p))
 				return -EFAULT;
-				
+
 			if (at91_wdt_settimeout(new_value))
 				return -EINVAL;
 
@@ -196,27 +199,84 @@ static struct miscdevice at91wdt_miscdev
 	.fops		= &at91wdt_fops,
 };
 
-static int __init at91_wdt_init(void)
+static int __init at91wdt_probe(struct platform_device *pdev)
 {
 	int res;
 
-	/* Check that the heartbeat value is within range; if not reset to the default */
-	if (at91_wdt_settimeout(wdt_time)) {
-		at91_wdt_settimeout(WDT_DEFAULT_TIME);
-		printk(KERN_INFO "at91_wdt: wdt_time value must be 1 <= wdt_time <= 256, using %d\n", wdt_time);
-	}
+	if (at91wdt_miscdev.dev)
+		return -EBUSY;
+	at91wdt_miscdev.dev = &pdev->dev;
 
 	res = misc_register(&at91wdt_miscdev);
 	if (res)
 		return res;
 
-	printk("AT91 Watchdog Timer enabled (%d seconds, nowayout=%d)\n", wdt_time, nowayout);
+	printk("AT91 Watchdog Timer enabled (%d seconds%s)\n", wdt_time, nowayout ? ", nowayout" : "");
 	return 0;
 }
 
+static int __exit at91wdt_remove(struct platform_device *pdev)
+{
+	int res;
+
+	res = misc_deregister(&at91wdt_miscdev);
+	if (!res)
+		at91wdt_miscdev.dev = NULL;
+
+	return res;
+}
+
+static void at91wdt_shutdown(struct platform_device *pdev)
+{
+	at91_wdt_stop();
+}
+
+#ifdef CONFIG_PM
+
+static int at91wdt_suspend(struct platform_device *pdev, pm_message_t message)
+{
+	at91_wdt_stop();
+	return 0;
+}
+
+static int at91wdt_resume(struct platform_device *pdev)
+{
+	if (at91wdt_busy)
+		at91_wdt_start();
+		return 0;
+}
+
+#else
+#define at91wdt_suspend NULL
+#define at91wdt_resume	NULL
+#endif
+
+static struct platform_driver at91wdt_driver = {
+	.probe		= at91wdt_probe,
+	.remove		= __exit_p(at91wdt_remove),
+	.shutdown	= at91wdt_shutdown,
+	.suspend	= at91wdt_suspend,
+	.resume		= at91wdt_resume,
+	.driver		= {
+		.name	= "at91_wdt",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init at91_wdt_init(void)
+{
+	/* Check that the heartbeat value is within range; if not reset to the default */
+	if (at91_wdt_settimeout(wdt_time)) {
+		at91_wdt_settimeout(WDT_DEFAULT_TIME);
+		pr_info("at91_wdt: wdt_time value must be 1 <= wdt_time <= 256, using %d\n", wdt_time);
+	}
+
+	return platform_driver_register(&at91wdt_driver);
+}
+
 static void __exit at91_wdt_exit(void)
 {
-	misc_deregister(&at91wdt_miscdev);
+	platform_driver_unregister(&at91wdt_driver);
 }
 
 module_init(at91_wdt_init);
diff --git a/drivers/char/watchdog/i8xx_tco.c b/drivers/char/watchdog/i8xx_tco.c
index fa2ba9e..bfbdbbf 100644
--- a/drivers/char/watchdog/i8xx_tco.c
+++ b/drivers/char/watchdog/i8xx_tco.c
@@ -205,6 +205,23 @@ static int tco_timer_set_heartbeat (int 
 	return 0;
 }
 
+static int tco_timer_get_timeleft (int *time_left)
+{
+	unsigned char val;
+
+	spin_lock(&tco_lock);
+
+	/* read the TCO Timer */
+	val = inb (TCO1_RLD);
+	val &= 0x3f;
+
+	spin_unlock(&tco_lock);
+
+	*time_left = (int)((val * 6) / 10);
+
+	return 0;
+}
+
 /*
  *	/dev/watchdog handling
  */
@@ -272,6 +289,7 @@ static int i8xx_tco_ioctl (struct inode 
 {
 	int new_options, retval = -EINVAL;
 	int new_heartbeat;
+	int time_left;
 	void __user *argp = (void __user *)arg;
 	int __user *p = argp;
 	static struct watchdog_info ident = {
@@ -320,7 +338,7 @@ static int i8xx_tco_ioctl (struct inode 
 				return -EFAULT;
 
 			if (tco_timer_set_heartbeat(new_heartbeat))
-			    return -EINVAL;
+				return -EINVAL;
 
 			tco_timer_keepalive ();
 			/* Fall */
@@ -329,6 +347,14 @@ static int i8xx_tco_ioctl (struct inode 
 		case WDIOC_GETTIMEOUT:
 			return put_user(heartbeat, p);
 
+		case WDIOC_GETTIMELEFT:
+		{
+			if (tco_timer_get_timeleft(&time_left))
+				return -EINVAL;
+
+			return put_user(time_left, p);
+		}
+
 		default:
 			return -ENOIOCTLCMD;
 	}
diff --git a/drivers/char/watchdog/pcwd_pci.c b/drivers/char/watchdog/pcwd_pci.c
index 2451edb..1f40ece 100644
--- a/drivers/char/watchdog/pcwd_pci.c
+++ b/drivers/char/watchdog/pcwd_pci.c
@@ -21,7 +21,7 @@
  */
 
 /*
- *	A bells and whistles driver is available from: 
+ *	A bells and whistles driver is available from:
  *	http://www.kernel.org/pub/linux/kernel/people/wim/pcwd/pcwd_pci/
  *
  *	More info available at http://www.berkprod.com/ or http://www.pcwatchdog.com/
@@ -390,6 +390,24 @@ static int pcipcwd_get_temperature(int *
 	return 0;
 }
 
+static int pcipcwd_get_timeleft(int *time_left)
+{
+	int msb;
+	int lsb;
+
+	/* Read the time that's left before rebooting */
+	/* Note: if the board is not yet armed then we will read 0xFFFF */
+	send_command(CMD_READ_WATCHDOG_TIMEOUT, &msb, &lsb);
+
+	*time_left = (msb << 8) + lsb;
+
+	if (debug >= VERBOSE)
+		printk(KERN_DEBUG PFX "Time left before next reboot: %d\n",
+		       *time_left);
+
+	return 0;
+}
+
 /*
  *	/dev/watchdog handling
  */
@@ -512,6 +530,16 @@ static int pcipcwd_ioctl(struct inode *i
 		case WDIOC_GETTIMEOUT:
 			return put_user(heartbeat, p);
 
+		case WDIOC_GETTIMELEFT:
+		{
+			int time_left;
+
+			if (pcipcwd_get_timeleft(&time_left))
+				return -EFAULT;
+
+			return put_user(time_left, p);
+		}
+
 		default:
 			return -ENOIOCTLCMD;
 	}
diff --git a/drivers/char/watchdog/pcwd_usb.c b/drivers/char/watchdog/pcwd_usb.c
index 3fdfda9..0d072be 100644
--- a/drivers/char/watchdog/pcwd_usb.c
+++ b/drivers/char/watchdog/pcwd_usb.c
@@ -317,6 +317,19 @@ static int usb_pcwd_get_temperature(stru
 	return 0;
 }
 
+static int usb_pcwd_get_timeleft(struct usb_pcwd_private *usb_pcwd, int *time_left)
+{
+	unsigned char msb, lsb;
+
+	/* Read the time that's left before rebooting */
+	/* Note: if the board is not yet armed then we will read 0xFFFF */
+	usb_pcwd_send_command(usb_pcwd, CMD_READ_WATCHDOG_TIMEOUT, &msb, &lsb);
+
+	*time_left = (msb << 8) + lsb;
+
+	return 0;
+}
+
 /*
  *	/dev/watchdog handling
  */
@@ -422,6 +435,16 @@ static int usb_pcwd_ioctl(struct inode *
 		case WDIOC_GETTIMEOUT:
 			return put_user(heartbeat, p);
 
+		case WDIOC_GETTIMELEFT:
+		{
+			int time_left;
+
+			if (usb_pcwd_get_timeleft(usb_pcwd_device, &time_left))
+				return -EFAULT;
+
+			return put_user(time_left, p);
+		}
+
 		default:
 			return -ENOIOCTLCMD;
 	}
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 1192ed8..011bcfe 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -28,6 +28,9 @@ #define	WDIOC_SETOPTIONS	_IOR(WATCHDOG_I
 #define	WDIOC_KEEPALIVE		_IOR(WATCHDOG_IOCTL_BASE, 5, int)
 #define	WDIOC_SETTIMEOUT        _IOWR(WATCHDOG_IOCTL_BASE, 6, int)
 #define	WDIOC_GETTIMEOUT        _IOR(WATCHDOG_IOCTL_BASE, 7, int)
+#define	WDIOC_SETPRETIMEOUT	_IOWR(WATCHDOG_IOCTL_BASE, 8, int)
+#define	WDIOC_GETPRETIMEOUT	_IOR(WATCHDOG_IOCTL_BASE, 9, int)
+#define	WDIOC_GETTIMELEFT	_IOR(WATCHDOG_IOCTL_BASE, 10, int)
 
 #define	WDIOF_UNKNOWN		-1	/* Unknown flag error */
 #define	WDIOS_UNKNOWN		-1	/* Unknown status error */
@@ -38,9 +41,10 @@ #define	WDIOF_EXTERN1		0x0004	/* Externa
 #define	WDIOF_EXTERN2		0x0008	/* External relay 2 */
 #define	WDIOF_POWERUNDER	0x0010	/* Power bad/power fault */
 #define	WDIOF_CARDRESET		0x0020	/* Card previously reset the CPU */
-#define WDIOF_POWEROVER		0x0040	/* Power over voltage */
-#define WDIOF_SETTIMEOUT	0x0080  /* Set timeout (in seconds) */
-#define WDIOF_MAGICCLOSE	0x0100	/* Supports magic close char */
+#define	WDIOF_POWEROVER		0x0040	/* Power over voltage */
+#define	WDIOF_SETTIMEOUT	0x0080  /* Set timeout (in seconds) */
+#define	WDIOF_MAGICCLOSE	0x0100	/* Supports magic close char */
+#define	WDIOF_PRETIMEOUT	0x0200  /* Pretimeout (in seconds), get/set */
 #define	WDIOF_KEEPALIVEPING	0x8000	/* Keep alive ping reply */
 
 #define	WDIOS_DISABLECARD	0x0001	/* Turn off the watchdog timer */
