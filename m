Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263066AbUC2SsX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 13:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263063AbUC2SsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 13:48:23 -0500
Received: from adicia.telenet-ops.be ([195.130.132.56]:8381 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263066AbUC2Sqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 13:46:38 -0500
Date: Mon, 29 Mar 2004 20:46:09 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] v2.6.5-rc2 pcwd.c-patches
Message-ID: <20040329204609.Z30061@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog

This will update the following files:

 drivers/char/watchdog/pcwd.c |  935 +++++++++++++++++++++++++------------------
 1 files changed, 557 insertions(+), 378 deletions(-)

through these ChangeSets:

<wim@iguana.be> (04/03/26 1.1693)
   [WATCHDOG] v2.6.5-rc2 pcwd.c-patch2
   
   * Extracted the get_status code to a seperate function (pcwd_get_status)
   * Re-used the pcwd_get_status code for the initial/boot status
   
   Tested on pcwd card with temperature option

<wim@iguana.be> (04/03/27 1.1694)
   [WATCHDOG] v2.6.5-rc2 pcwd.c-patch3
   
   Version 0.15 of pcwd.c - Changes that were made are:
   * Rewrote code for exchanging commands with the ISA-PC Watchdog card
   * Restructured + rewrote the init and exit code
   * Added option_switches info
   * Use the option_switches info to find out what the cards heartbeat is
   * Added notifier support
   
   Tested on pcwd card with temperature option

<wim@iguana.be> (04/03/27 1.1695)
   [WATCHDOG] v2.6.5-rc2 pcwd.c-patch4
   
   Version 0.16 of pcwd.c - Changes that were made are:
   * Changed the driver so that it uses an internal timer to do
     the actual watchdog pinging. This way the watchdog's emulated
     'heartbeat' is usuable as a module parameter. The watchdog's
     heartbeat can now vary from 2 till 7200 seconds
   
   Tested on pcwd card with temperature option


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/pcwd.c b/drivers/char/watchdog/pcwd.c
--- a/drivers/char/watchdog/pcwd.c	Sat Mar 27 17:36:12 2004
+++ b/drivers/char/watchdog/pcwd.c	Sat Mar 27 17:36:12 2004
@@ -44,6 +44,11 @@
  *              Added timeout module option to override default
  */
 
+/*
+ *	A bells and whistles driver is available from http://www.pcwd.de/
+ *	More info available at http://www.berkprod.com/ or http://www.pcwatchdog.com/
+ */
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
@@ -71,7 +76,7 @@
  */
 static int pcwd_ioports[] = { 0x270, 0x350, 0x370, 0x000 };
 
-#define WD_VER                  "1.14 (03/12/2004)"
+#define WD_VER                  "1.14 (03/26/2004)"
 
 /*
  * It should be noted that PCWD_REVISION_B was removed because A and B
@@ -86,7 +91,6 @@
 #define	WD_TIMEOUT		4	/* 2 seconds for a timeout */
 static int timeout_val = WD_TIMEOUT;
 static int timeout = 2;
-static char expect_close;
 
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default=2)");
@@ -102,7 +106,8 @@
 
 
 /*
- * These are the defines for the PC Watchdog card, revision A.
+ * These are the defines that describe the control status bits for the
+ * PC Watchdog card, revision A.
  */
 #define WD_WDRST                0x01	/* Previously reset state */
 #define WD_T110                 0x02	/* Temperature overheat sense */
@@ -110,8 +115,17 @@
 #define WD_RLY2                 0x08	/* External relay triggered */
 #define WD_SRLY2                0x80	/* Software external relay triggered */
 
+/*
+ * These are the defines that describe the control status bits for the
+ * PC Watchdog card, revision C.
+ */
+#define WD_REVC_WTRP            0x01	/* Watchdog Trip status */
+#define WD_REVC_HRBT            0x02	/* Watchdog Heartbeat */
+#define WD_REVC_TTRP            0x04	/* Temperature Trip status */
+
 static int current_readport, revision, temp_panic;
 static atomic_t open_allowed = ATOMIC_INIT(1);
+static char expect_close;
 static int initial_status, supports_temp, mode_debug;
 static spinlock_t io_lock;
 
@@ -187,46 +201,6 @@
 	return((found) ? 1 : 0);
 }
 
-void pcwd_showprevstate(void)
-{
-	int card_status = 0x0000;
-
-	if (revision == PCWD_REVISION_A)
-		initial_status = card_status = inb(current_readport);
-	else {
-		initial_status = card_status = inb(current_readport + 1);
-		outb_p(0x00, current_readport + 1); /* clear reset status */
-	}
-
-	if (revision == PCWD_REVISION_A) {
-		if (card_status & WD_WDRST)
-			printk(KERN_INFO "pcwd: Previous reboot was caused by the card.\n");
-
-		if (card_status & WD_T110) {
-			printk(KERN_EMERG "pcwd: Card senses a CPU Overheat.  Panicking!\n");
-			printk(KERN_EMERG "pcwd: CPU Overheat.\n");
-			machine_power_off();
-		}
-
-		if ((!(card_status & WD_WDRST)) &&
-		    (!(card_status & WD_T110)))
-			printk(KERN_INFO "pcwd: Cold boot sense.\n");
-	} else {
-		if (card_status & 0x01)
-			printk(KERN_INFO "pcwd: Previous reboot was caused by the card.\n");
-
-		if (card_status & 0x04) {
-			printk(KERN_EMERG "pcwd: Card senses a CPU Overheat.  Panicking!\n");
-			printk(KERN_EMERG "pcwd: CPU Overheat.\n");
-			machine_power_off();
-		}
-
-		if ((!(card_status & 0x01)) &&
-		    (!(card_status & 0x04)))
-			printk(KERN_INFO "pcwd: Cold boot sense.\n");
-	}
-}
-
 static int pcwd_start(void)
 {
 	int stat_reg;
@@ -281,6 +255,64 @@
 		outb_p(wdrst_stat, current_readport);
 }
 
+static int pcwd_get_status(int *status)
+{
+	int card_status;
+
+	*status=0;
+	spin_lock(&io_lock);
+	if (revision == PCWD_REVISION_A)
+		/* Rev A cards return status information from
+		 * the base register, which is used for the
+		 * temperature in other cards. */
+		card_status = inb(current_readport);
+	else {
+		/* Rev C cards return card status in the base
+		 * address + 1 register. And use different bits
+		 * to indicate a card initiated reset, and an
+		 * over-temperature condition. And the reboot
+		 * status can be reset. */
+		card_status = inb(current_readport + 1);
+	}
+	spin_unlock(&io_lock);
+
+	if (revision == PCWD_REVISION_A) {
+		if (card_status & WD_WDRST)
+			*status |= WDIOF_CARDRESET;
+
+		if (card_status & WD_T110) {
+			*status |= WDIOF_OVERHEAT;
+			if (temp_panic) {
+				printk (KERN_INFO "pcwd: Temperature overheat trip!\n");
+				machine_power_off();
+			}
+		}
+	} else {
+		if (card_status & WD_REVC_WTRP)
+			*status |= WDIOF_CARDRESET;
+
+		if (card_status & WD_REVC_TTRP) {
+			*status |= WDIOF_OVERHEAT;
+			if (temp_panic) {
+				printk (KERN_INFO "pcwd: Temperature overheat trip!\n");
+				machine_power_off();
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int pcwd_clear_status(void)
+{
+	if (revision == PCWD_REVISION_C) {
+		spin_lock(&io_lock);
+		outb_p(0x00, current_readport + 1); /* clear reset status */
+		spin_unlock(&io_lock);
+	}
+	return 0;
+}
+
 static int pcwd_get_temperature(int *temperature)
 {
 	/* check that port 0 gives temperature info and no command results */
@@ -309,7 +341,8 @@
 static int pcwd_ioctl(struct inode *inode, struct file *file,
 		      unsigned int cmd, unsigned long arg)
 {
-	int cdat, rv;
+	int rv;
+	int status;
 	int temperature;
 	static struct watchdog_info ident=
 	{
@@ -330,75 +363,13 @@
 		return 0;
 
 	case WDIOC_GETSTATUS:
-		spin_lock(&io_lock);
-		if (revision == PCWD_REVISION_A)
-			cdat = inb(current_readport);
-		else
-			cdat = inb(current_readport + 1 );
-		spin_unlock(&io_lock);
-		rv = WDIOF_MAGICCLOSE;
-
-		if (revision == PCWD_REVISION_A)
-		{
-			if (cdat & WD_WDRST)
-				rv |= WDIOF_CARDRESET;
-
-			if (cdat & WD_T110)
-			{
-				rv |= WDIOF_OVERHEAT;
-
-				if (temp_panic) {
-					printk (KERN_INFO "pcwd: Temperature overheat trip!\n");
-					machine_power_off();
-				}
-			}
-		}
-		else
-		{
-			if (cdat & 0x01)
-				rv |= WDIOF_CARDRESET;
-
-			if (cdat & 0x04)
-			{
-				rv |= WDIOF_OVERHEAT;
-
-				if (temp_panic) {
-					printk (KERN_INFO "pcwd: Temperature overheat trip!\n");
-					machine_power_off();
-				}
-			}
-		}
-
-		if(put_user(rv, (int *) arg))
-			return -EFAULT;
-		return 0;
+		pcwd_get_status(&status);
+		return put_user(status, (int *) arg);
 
 	case WDIOC_GETBOOTSTATUS:
-		rv = 0;
-
-		if (revision == PCWD_REVISION_A)
-		{
-			if (initial_status & WD_WDRST)
-				rv |= WDIOF_CARDRESET;
-
-			if (initial_status & WD_T110)
-				rv |= WDIOF_OVERHEAT;
-		}
-		else
-		{
-			if (initial_status & 0x01)
-				rv |= WDIOF_CARDRESET;
-
-			if (initial_status & 0x04)
-				rv |= WDIOF_OVERHEAT;
-		}
-
-		if(put_user(rv, (int *) arg))
-			return -EFAULT;
-		return 0;
+		return put_user(initial_status, (int *) arg);
 
 	case WDIOC_GETTEMP:
-
 		if (pcwd_get_temperature(&temperature))
 			return -EFAULT;
 
@@ -483,9 +454,9 @@
 	if (expect_close == 42) {
 		pcwd_stop();
 		atomic_inc( &open_allowed );
-        } else {
-                printk(KERN_CRIT "pcwd: Unexpected close, not stopping watchdog!\n");
-                pcwd_send_heartbeat();
+	} else {
+		printk(KERN_CRIT "pcwd: Unexpected close, not stopping watchdog!\n");
+		pcwd_send_heartbeat();
 	}
 	expect_close = 0;
 	return 0;
@@ -675,6 +646,12 @@
 	get_support();
 	revision = get_revision();
 
+	/* get the boot_status */
+	pcwd_get_status(&initial_status);
+
+	/* clear the "card caused reboot" flag */
+	pcwd_clear_status();
+
 	if (revision == PCWD_REVISION_A)
 		printk(KERN_INFO "pcwd: PC Watchdog (REV.A) detected at port 0x%03x\n", current_readport);
 	else if (revision == PCWD_REVISION_C) {
@@ -688,12 +665,21 @@
 		return -1;
 	}
 
+	debug_off();
+
 	if (supports_temp)
 		printk(KERN_INFO "pcwd: Temperature Option Detected.\n");
 
-	debug_off();
+	if (initial_status & WDIOF_CARDRESET)
+		printk(KERN_INFO "pcwd: Previous reboot was caused by the card.\n");
+
+	if (initial_status & WDIOF_OVERHEAT) {
+		printk(KERN_EMERG "pcwd: Card senses a CPU Overheat.  Panicking!\n");
+		printk(KERN_EMERG "pcwd: CPU Overheat.\n");
+	}
 
-	pcwd_showprevstate();
+	if (initial_status == 0)
+		printk(KERN_INFO "pcwd: No previous trip detected - Cold boot or reset\n");
 
 	/*  Disable the board  */
 	if (revision == PCWD_REVISION_C) {
diff -Nru a/drivers/char/watchdog/pcwd.c b/drivers/char/watchdog/pcwd.c
--- a/drivers/char/watchdog/pcwd.c	Sat Mar 27 17:36:35 2004
+++ b/drivers/char/watchdog/pcwd.c	Sat Mar 27 17:36:35 2004
@@ -61,6 +61,7 @@
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
+#include <linux/notifier.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/reboot.h>
@@ -68,15 +69,8 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
-/*
- * These are the auto-probe addresses available.
- *
- * Revision A only uses ports 0x270 and 0x370.  Revision C introduced 0x350.
- * Revision A has an address range of 2 addresses, while Revision C has 3.
- */
-static int pcwd_ioports[] = { 0x270, 0x350, 0x370, 0x000 };
-
-#define WD_VER                  "1.14 (03/26/2004)"
+#define WD_VER                  "1.15 (03/27/2004)"
+#define PFX			"pcwd: "
 
 /*
  * It should be noted that PCWD_REVISION_B was removed because A and B
@@ -88,23 +82,6 @@
 #define	PCWD_REVISION_A		1
 #define	PCWD_REVISION_C		2
 
-#define	WD_TIMEOUT		4	/* 2 seconds for a timeout */
-static int timeout_val = WD_TIMEOUT;
-static int timeout = 2;
-
-module_param(timeout, int, 0);
-MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default=2)");
-
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
-
-module_param(nowayout, int, 0);
-MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
-
-
 /*
  * These are the defines that describe the control status bits for the
  * PC Watchdog card, revision A.
@@ -123,82 +100,108 @@
 #define WD_REVC_HRBT            0x02	/* Watchdog Heartbeat */
 #define WD_REVC_TTRP            0x04	/* Temperature Trip status */
 
+/* max. time we give an ISA watchdog card to process a command */
+/* 500ms for each 4 bit response (according to spec.) */
+#define ISA_COMMAND_TIMEOUT     1000
+
+/* Watchdog's internal commands */
+#define CMD_ISA_IDLE                    0x00
+#define CMD_ISA_VERSION_INTEGER         0x01
+#define CMD_ISA_VERSION_TENTH           0x02
+#define CMD_ISA_VERSION_HUNDRETH        0x03
+#define CMD_ISA_VERSION_MINOR           0x04
+#define CMD_ISA_SWITCH_SETTINGS         0x05
+#define CMD_ISA_DELAY_TIME_2SECS        0x0A
+#define CMD_ISA_DELAY_TIME_4SECS        0x0B
+#define CMD_ISA_DELAY_TIME_8SECS        0x0C
+
+/* We can only use 1 card due to the /dev/watchdog restriction */
+static int cards_found;
+
+/* internal variables */
 static int current_readport, revision, temp_panic;
 static atomic_t open_allowed = ATOMIC_INIT(1);
 static char expect_close;
-static int initial_status, supports_temp, mode_debug;
+static int supports_temp;		/* Wether or not the card has a temperature device */
+static int command_mode;		/* Wether or not the card is in command mode */
+static int initial_status;		/* The card's boot status */
 static spinlock_t io_lock;
+static int heartbeat;
 
-/*
- * PCWD_CHECKCARD
- *
- * This routine checks the "current_readport" to see if the card lies there.
- * If it does, it returns accordingly.
- */
-static int __init pcwd_checkcard(void)
-{
-	int card_dat, prev_card_dat, found = 0, count = 0, done = 0;
-
-	card_dat = 0x00;
-	prev_card_dat = 0x00;
-
-	prev_card_dat = inb(current_readport);
-	if (prev_card_dat == 0xFF)
-		return 0;
+/* module parameters */
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
 
-	while(count < timeout_val) {
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
-	/* Read the raw card data from the port, and strip off the
-	   first 4 bits */
+/*
+ *	Internal functions
+ */
 
-		card_dat = inb_p(current_readport);
-		card_dat &= 0x000F;
+static int send_isa_command(int cmd)
+{
+	int i;
+	int control_status;
+	int port0, last_port0;	/* Double read for stabilising */
 
-	/* Sleep 1/2 second (or 500000 microseconds :) */
+	/* The WCMD bit must be 1 and the command is only 4 bits in size */
+	control_status = (cmd & 0x0F) | 0x80;
+	outb_p(control_status, current_readport + 2);
+	udelay(ISA_COMMAND_TIMEOUT);
 
-		mdelay(500);
-		done = 0;
+	port0 = inb_p(current_readport);
+	for (i = 0; i < 25; ++i) {
+		last_port0 = port0;
+		port0 = inb_p(current_readport);
 
-	/* If there's a heart beat in both instances, then this means we
-	   found our card.  This also means that either the card was
-	   previously reset, or the computer was power-cycled. */
+		if (port0 == last_port0)
+			break;	/* Data is stable */
 
-		if ((card_dat & WD_HRTBT) && (prev_card_dat & WD_HRTBT) &&
-			(!done)) {
-			found = 1;
-			done = 1;
-			break;
-		}
+		udelay (250);
+	}
 
-	/* If the card data is exactly the same as the previous card data,
-	   it's safe to assume that we should check again.  The manual says
-	   that the heart beat will change every second (or the bit will
-	   toggle), and this can be used to see if the card is there.  If
-	   the card was powered up with a cold boot, then the card will
-	   not start blinking until 2.5 minutes after a reboot, so this
-	   bit will stay at 1. */
+	return port0;
+}
 
-		if ((card_dat == prev_card_dat) && (!done)) {
-			count++;
-			done = 1;
-		}
+static int set_command_mode(void)
+{
+	int i, found=0, count=0;
 
-	/* If the card data is toggling any bits, this means that the heart
-	   beat was detected, or something else about the card is set. */
+	/* Set the card into command mode */
+	spin_lock(&io_lock);
+	while ((!found) && (count < 3)) {
+		i = send_isa_command(CMD_ISA_IDLE);
 
-		if ((card_dat != prev_card_dat) && (!done)) {
-			done = 1;
+		if (i == 0x00)
 			found = 1;
-			break;
+		else if (i == 0xF3) {
+			/* Card does not like what we've done to it */
+			outb_p(0x00, current_readport + 2);
+			udelay(1200);	/* Spec says wait 1ms */
+			outb_p(0x00, current_readport + 2);
+			udelay(ISA_COMMAND_TIMEOUT);
 		}
+		count++;
+	}
+	spin_unlock(&io_lock);
+	command_mode = found;
 
-	/* Otherwise something else strange happened. */
+	return(found);
+}
 
-		if (!done)
-			count++;
-	}
+static void unset_command_mode(void)
+{
+	/* Set the card into normal mode */
+	spin_lock(&io_lock);
+	outb_p(0x00, current_readport + 2);
+	udelay(ISA_COMMAND_TIMEOUT);
+	spin_unlock(&io_lock);
 
-	return((found) ? 1 : 0);
+	command_mode = 0;
 }
 
 static int pcwd_start(void)
@@ -213,7 +216,7 @@
 		spin_unlock(&io_lock);
 		if (stat_reg & 0x10)
 		{
-			printk(KERN_INFO "pcwd: Could not start watchdog.\n");
+			printk(KERN_INFO PFX "Could not start watchdog\n");
 			return -EIO;
 		}
 	}
@@ -233,7 +236,7 @@
 		spin_unlock(&io_lock);
 		if ((stat_reg & 0x10) == 0)
 		{
-			printk(KERN_INFO "pcwd: Could not stop watchdog.\n");
+			printk(KERN_INFO PFX "Could not stop watchdog\n");
 			return -EIO;
 		}
 	}
@@ -283,7 +286,7 @@
 		if (card_status & WD_T110) {
 			*status |= WDIOF_OVERHEAT;
 			if (temp_panic) {
-				printk (KERN_INFO "pcwd: Temperature overheat trip!\n");
+				printk (KERN_INFO PFX "Temperature overheat trip!\n");
 				machine_power_off();
 			}
 		}
@@ -294,7 +297,7 @@
 		if (card_status & WD_REVC_TTRP) {
 			*status |= WDIOF_OVERHEAT;
 			if (temp_panic) {
-				printk (KERN_INFO "pcwd: Temperature overheat trip!\n");
+				printk (KERN_INFO PFX "Temperature overheat trip!\n");
 				machine_power_off();
 			}
 		}
@@ -316,7 +319,7 @@
 static int pcwd_get_temperature(int *temperature)
 {
 	/* check that port 0 gives temperature info and no command results */
-	if (mode_debug)
+	if (command_mode)
 		return -1;
 
 	*temperature = 0;
@@ -348,6 +351,7 @@
 	{
 		.options =		WDIOF_OVERHEAT |
 					WDIOF_CARDRESET |
+					WDIOF_KEEPALIVEPING |
 					WDIOF_MAGICCLOSE,
 		.firmware_version =	1,
 		.identity =		"PCWD",
@@ -401,6 +405,9 @@
 	case WDIOC_KEEPALIVE:
 		pcwd_send_heartbeat();
 		return 0;
+
+	case WDIOC_GETTIMEOUT:
+		return put_user(heartbeat, (int *)arg);
 	}
 
 	return 0;
@@ -455,7 +462,7 @@
 		pcwd_stop();
 		atomic_inc( &open_allowed );
 	} else {
-		printk(KERN_CRIT "pcwd: Unexpected close, not stopping watchdog!\n");
+		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
 		pcwd_send_heartbeat();
 	}
 	expect_close = 0;
@@ -471,7 +478,7 @@
 {
 	int temperature;
 
-	/*  Can't seek (pread) on this device  */
+	/* Can't seek (pread) on this device */
 	if (ppos != &file->f_pos)
 		return -ESPIPE;
 
@@ -497,80 +504,23 @@
 	return 0;
 }
 
-static inline void get_support(void)
-{
-	if (inb(current_readport) != 0xF0)
-		supports_temp = 1;
-}
-
-static inline int get_revision(void)
-{
-	int r = PCWD_REVISION_C;
-
-	spin_lock(&io_lock);
-	if ((inb(current_readport + 2) == 0xFF) ||
-	    (inb(current_readport + 3) == 0xFF))
-		r=PCWD_REVISION_A;
-	spin_unlock(&io_lock);
-
-	return r;
-}
-
-static int __init send_command(int cmd)
-{
-	int i;
-
-	outb_p(cmd, current_readport + 2);
-	mdelay(1);
-
-	i = inb(current_readport);
-	i = inb(current_readport);
-
-	return(i);
-}
+/*
+ *	Notify system
+ */
 
-static inline char *get_firmware(void)
+static int pcwd_notify_sys(struct notifier_block *this, unsigned long code, void *unused)
 {
-	int i, found = 0, count = 0, one, ten, hund, minor;
-	char *ret;
-
-	ret = kmalloc(6, GFP_KERNEL);
-	if(ret == NULL)
-		return NULL;
-
-	while((count < 3) && (!found)) {
-		outb_p(0x80, current_readport + 2);
-		i = inb(current_readport);
-
-		if (i == 0x00)
-			found = 1;
-		else if (i == 0xF3)
-			outb_p(0x00, current_readport + 2);
-
-		udelay(400L);
-		count++;
-	}
-
-	if (found) {
-		mode_debug = 1;
-
-		one = send_command(0x81);
-		ten = send_command(0x82);
-		hund = send_command(0x83);
-		minor = send_command(0x84);
-		sprintf(ret, "%c.%c%c%c", one, ten, hund, minor);
+	if (code==SYS_DOWN || code==SYS_HALT) {
+		/* Turn the WDT off */
+		pcwd_stop();
 	}
-	else
-		sprintf(ret, "ERROR");
 
-	return(ret);
+	return NOTIFY_DONE;
 }
 
-static void debug_off(void)
-{
-	outb_p(0x00, current_readport + 2);
-	mode_debug = 0;
-}
+/*
+ *	Kernel Interfaces
+ */
 
 static struct file_operations pcwd_fops = {
 	.owner		= THIS_MODULE,
@@ -601,137 +551,306 @@
 	.fops =		&pcwd_temp_fops,
 };
 
-static void __init pcwd_validate_timeout(void)
+static struct notifier_block pcwd_notifier = {
+	.notifier_call =	pcwd_notify_sys,
+};
+
+/*
+ *	Init & exit routines
+ */
+
+static inline void get_support(void)
 {
-	timeout_val = timeout * 2;
+	if (inb(current_readport) != 0xF0)
+		supports_temp = 1;
 }
 
-static int __init pcwatchdog_init(void)
+static inline int get_revision(void)
 {
-	char *firmware;
-	int i, found = 0;
-	pcwd_validate_timeout();
-	spin_lock_init(&io_lock);
+	int r = PCWD_REVISION_C;
 
-	revision = PCWD_REVISION_A;
+	spin_lock(&io_lock);
+	/* REV A cards use only 2 io ports; test
+	 * presumes a floating bus reads as 0xff. */
+	if ((inb(current_readport + 2) == 0xFF) ||
+	    (inb(current_readport + 3) == 0xFF))
+		r=PCWD_REVISION_A;
+	spin_unlock(&io_lock);
 
-	printk(KERN_INFO "pcwd: v%s Ken Hollis (kenji@bitgate.com)\n", WD_VER);
+	return r;
+}
 
-	/* Initial variables */
-	supports_temp = 0;
-	mode_debug = 0;
-	temp_panic = 0;
-	initial_status = 0x0000;
+static inline char *get_firmware(void)
+{
+	int one, ten, hund, minor;
+	char *ret;
 
-#ifndef	PCWD_BLIND
-	for (i = 0; pcwd_ioports[i] != 0; i++) {
-		current_readport = pcwd_ioports[i];
+	ret = kmalloc(6, GFP_KERNEL);
+	if(ret == NULL)
+		return NULL;
 
-		if (pcwd_checkcard()) {
-			found = 1;
-			break;
-		}
+	if (set_command_mode()) {
+		one = send_isa_command(CMD_ISA_VERSION_INTEGER);
+		ten = send_isa_command(CMD_ISA_VERSION_TENTH);
+		hund = send_isa_command(CMD_ISA_VERSION_HUNDRETH);
+		minor = send_isa_command(CMD_ISA_VERSION_MINOR);
+		sprintf(ret, "%c.%c%c%c", one, ten, hund, minor);
 	}
+	else
+		sprintf(ret, "ERROR");
 
-	if (!found) {
-		printk(KERN_INFO "pcwd: No card detected, or port not available.\n");
-		return(-EIO);
+	unset_command_mode();
+	return(ret);
+}
+
+static inline int get_option_switches(void)
+{
+	int rv=0;
+
+	if (set_command_mode()) {
+		/* Get switch settings */
+		rv = send_isa_command(CMD_ISA_SWITCH_SETTINGS);
 	}
-#endif
 
-#ifdef	PCWD_BLIND
-	current_readport = PCWD_BLIND;
-#endif
+	unset_command_mode();
+	return(rv);
+}
 
-	get_support();
+static int __devinit pcwatchdog_init(int base_addr)
+{
+	int ret;
+	char *firmware;
+	int option_switches;
+
+	cards_found++;
+	if (cards_found == 1)
+		printk(KERN_INFO PFX "v%s Ken Hollis (kenji@bitgate.com)\n", WD_VER);
+
+	if (cards_found > 1) {
+		printk(KERN_ERR PFX "This driver only supports 1 device\n");
+		return -ENODEV;
+	}
+
+	if (base_addr == 0x0000) {
+		printk(KERN_ERR PFX "No I/O-Address for card detected\n");
+		return -ENODEV;
+	}
+	current_readport = base_addr;
+
+	/* Check card's revision */
 	revision = get_revision();
 
+	if (!request_region(current_readport, (revision == PCWD_REVISION_A) ? 2 : 4, "PCWD")) {
+		printk(KERN_ERR PFX "I/O address 0x%04x already in use\n",
+			current_readport);
+		current_readport = 0x0000;
+		return -EIO;
+	}
+
+	/* Initial variables */
+	supports_temp = 0;
+	temp_panic = 0;
+	initial_status = 0x0000;
+	heartbeat = 0;
+
 	/* get the boot_status */
 	pcwd_get_status(&initial_status);
 
 	/* clear the "card caused reboot" flag */
 	pcwd_clear_status();
 
+	/*  Disable the board  */
+	pcwd_stop();
+
+	/*  Check whether or not the card supports the temperature device */
+	get_support();
+
+	/* Get some extra info from the hardware (in command/debug/diag mode) */
 	if (revision == PCWD_REVISION_A)
-		printk(KERN_INFO "pcwd: PC Watchdog (REV.A) detected at port 0x%03x\n", current_readport);
+		printk(KERN_INFO PFX "ISA-PC Watchdog (REV.A) detected at port 0x%04x\n", current_readport);
 	else if (revision == PCWD_REVISION_C) {
 		firmware = get_firmware();
-		printk(KERN_INFO "pcwd: PC Watchdog (REV.C) detected at port 0x%03x (Firmware version: %s)\n",
+		printk(KERN_INFO PFX "ISA-PC Watchdog (REV.C) detected at port 0x%04x (Firmware version: %s)\n",
 			current_readport, firmware);
 		kfree(firmware);
+		option_switches = get_option_switches();
+		switch (option_switches & 0x07) {
+			case 0: heartbeat = 20; break;
+			case 1: heartbeat = 40; break;
+			case 2: heartbeat = 60; break;
+			case 3: heartbeat = 300; break;
+			case 4: heartbeat = 600; break;
+			case 5: heartbeat = 1800; break;
+			case 6: heartbeat = 3600; break;
+			case 7: heartbeat = 7200; break;
+		}
+		printk(KERN_INFO PFX "Option switches (0x%02x): Temperature Reset Enable=%s, Power On Delay=%s\n",
+			option_switches,
+			((option_switches & 0x10) ? "ON" : "OFF"),
+			((option_switches & 0x08) ? "ON" : "OFF"));
 	} else {
 		/* Should NEVER happen, unless get_revision() fails. */
-		printk("pcwd: Unable to get revision.\n");
+		printk(KERN_INFO PFX "Unable to get revision\n");
+		release_region(current_readport, (revision == PCWD_REVISION_A) ? 2 : 4);
+		current_readport = 0x0000;
 		return -1;
 	}
 
-	debug_off();
-
 	if (supports_temp)
-		printk(KERN_INFO "pcwd: Temperature Option Detected.\n");
+		printk(KERN_INFO PFX "Temperature Option Detected\n");
 
 	if (initial_status & WDIOF_CARDRESET)
-		printk(KERN_INFO "pcwd: Previous reboot was caused by the card.\n");
+		printk(KERN_INFO PFX "Previous reboot was caused by the card\n");
 
 	if (initial_status & WDIOF_OVERHEAT) {
-		printk(KERN_EMERG "pcwd: Card senses a CPU Overheat.  Panicking!\n");
-		printk(KERN_EMERG "pcwd: CPU Overheat.\n");
+		printk(KERN_EMERG PFX "Card senses a CPU Overheat. Panicking!\n");
+		printk(KERN_EMERG PFX "CPU Overheat\n");
 	}
 
 	if (initial_status == 0)
-		printk(KERN_INFO "pcwd: No previous trip detected - Cold boot or reset\n");
+		printk(KERN_INFO PFX "No previous trip detected - Cold boot or reset\n");
 
-	/*  Disable the board  */
-	if (revision == PCWD_REVISION_C) {
-		outb_p(0xA5, current_readport + 3);
-		outb_p(0xA5, current_readport + 3);
+	ret = register_reboot_notifier(&pcwd_notifier);
+	if (ret) {
+		printk(KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
+			ret);
+		release_region(current_readport, (revision == PCWD_REVISION_A) ? 2 : 4);
+		current_readport = 0x0000;
+		return ret;
+	}
+
+	if (supports_temp) {
+		ret = misc_register(&temp_miscdev);
+		if (ret) {
+			printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
+				TEMP_MINOR, ret);
+			unregister_reboot_notifier(&pcwd_notifier);
+			release_region(current_readport, (revision == PCWD_REVISION_A) ? 2 : 4);
+			current_readport = 0x0000;
+			return ret;
+		}
 	}
 
-	if (misc_register(&pcwd_miscdev))
-		return -ENODEV;
+	ret = misc_register(&pcwd_miscdev);
+	if (ret) {
+		printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
+			WATCHDOG_MINOR, ret);
+		if (supports_temp)
+			misc_deregister(&temp_miscdev);
+		unregister_reboot_notifier(&pcwd_notifier);
+		release_region(current_readport, (revision == PCWD_REVISION_A) ? 2 : 4);
+		current_readport = 0x0000;
+		return ret;
+	}
+
+	printk(KERN_INFO PFX "initialized. heartbeat=%d sec (nowayout=%d)\n",
+		heartbeat, nowayout);
+
+	return 0;
+}
 
+static void __devexit pcwatchdog_exit(void)
+{
+	/*  Disable the board  */
+	if (!nowayout)
+		pcwd_stop();
+
+	/* Deregister */
+	misc_deregister(&pcwd_miscdev);
 	if (supports_temp)
-		if (misc_register(&temp_miscdev)) {
-			misc_deregister(&pcwd_miscdev);
-			return -ENODEV;
-		}
+		misc_deregister(&temp_miscdev);
+	unregister_reboot_notifier(&pcwd_notifier);
+	release_region(current_readport, (revision == PCWD_REVISION_A) ? 2 : 4);
+	current_readport = 0x0000;
+}
 
+/*
+ *  The ISA cards have a heartbeat bit in one of the registers, which
+ *  register is card dependent.  The heartbeat bit is monitored, and if
+ *  found, is considered proof that a Berkshire card has been found.
+ *  The initial rate is once per second at board start up, then twice
+ *  per second for normal operation.
+ */
+static int __init pcwd_checkcard(int base_addr)
+{
+	int port0, last_port0;	/* Reg 0, in case it's REV A */
+	int port1, last_port1;	/* Register 1 for REV C cards */
+	int i;
+	int retval;
 
-	if (revision == PCWD_REVISION_A) {
-		if (!request_region(current_readport, 2, "PCWD Rev.A (Berkshire)")) {
-			misc_deregister(&pcwd_miscdev);
-			if (supports_temp)
-				misc_deregister(&pcwd_miscdev);
-			return -EIO;
-		}
+	if (!request_region (base_addr, 4, "PCWD")) {
+		printk (KERN_INFO PFX "Port 0x%04x unavailable\n", base_addr);
+		return 0;
 	}
-	else
-		if (!request_region(current_readport, 4, "PCWD Rev.C (Berkshire)")) {
-			misc_deregister(&pcwd_miscdev);
-			if (supports_temp)
-				misc_deregister(&pcwd_miscdev);
-			return -EIO;
+
+	retval = 0;
+
+	port0 = inb_p(base_addr);	/* For REV A boards */
+	port1 = inb_p(base_addr + 1);	/* For REV C boards */
+	if (port0 != 0xff || port1 != 0xff) {
+		/* Not an 'ff' from a floating bus, so must be a card! */
+		for (i = 0; i < 4; ++i) {
+
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(HZ / 2);
+
+			last_port0 = port0;
+			last_port1 = port1;
+
+			port0 = inb_p(base_addr);
+			port1 = inb_p(base_addr + 1);
+
+			/* Has either hearbeat bit changed?  */
+			if ((port0 ^ last_port0) & WD_HRTBT ||
+			    (port1 ^ last_port1) & WD_REVC_HRBT) {
+				retval = 1;
+				break;
+			}
 		}
+	}
+	release_region (base_addr, 4);
 
-	return 0;
+	return retval;
 }
 
-static void __exit pcwatchdog_exit(void)
+/*
+ * These are the auto-probe addresses available.
+ *
+ * Revision A only uses ports 0x270 and 0x370.  Revision C introduced 0x350.
+ * Revision A has an address range of 2 addresses, while Revision C has 4.
+ */
+static int pcwd_ioports[] = { 0x270, 0x350, 0x370, 0x000 };
+
+static int __init pcwd_init_module(void)
 {
-	misc_deregister(&pcwd_miscdev);
-	/*  Disable the board  */
-	if (revision == PCWD_REVISION_C) {
-		outb_p(0xA5, current_readport + 3);
-		outb_p(0xA5, current_readport + 3);
+	int i, found = 0;
+
+	spin_lock_init(&io_lock);
+
+	for (i = 0; pcwd_ioports[i] != 0; i++) {
+		if (pcwd_checkcard(pcwd_ioports[i])) {
+			if (!(pcwatchdog_init(pcwd_ioports[i])))
+				found++;
+		}
 	}
-	if (supports_temp)
-		misc_deregister(&temp_miscdev);
 
-	release_region(current_readport, (revision == PCWD_REVISION_A) ? 2 : 4);
+	if (!found) {
+		printk (KERN_INFO PFX "No card detected, or port not available\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void __exit pcwd_cleanup_module(void)
+{
+	if (current_readport)
+		pcwatchdog_exit();
+	return;
 }
 
-module_init(pcwatchdog_init);
-module_exit(pcwatchdog_exit);
+module_init(pcwd_init_module);
+module_exit(pcwd_cleanup_module);
 
 MODULE_AUTHOR("Ken Hollis <kenji@bitgate.com>");
 MODULE_DESCRIPTION("Berkshire ISA-PC Watchdog driver");
diff -Nru a/drivers/char/watchdog/pcwd.c b/drivers/char/watchdog/pcwd.c
--- a/drivers/char/watchdog/pcwd.c	Sat Mar 27 17:36:58 2004
+++ b/drivers/char/watchdog/pcwd.c	Sat Mar 27 17:36:58 2004
@@ -53,6 +53,7 @@
 #include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/timer.h>
+#include <linux/jiffies.h>
 #include <linux/config.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
@@ -69,7 +70,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
-#define WD_VER                  "1.15 (03/27/2004)"
+#define WD_VER                  "1.16 (03/27/2004)"
 #define PFX			"pcwd: "
 
 /*
@@ -115,20 +116,36 @@
 #define CMD_ISA_DELAY_TIME_4SECS        0x0B
 #define CMD_ISA_DELAY_TIME_8SECS        0x0C
 
+/*
+ * We are using an kernel timer to do the pinging of the watchdog
+ * every ~500ms. We try to set the internal heartbeat of the
+ * watchdog to 2 ms.
+ */
+
+#define WDT_INTERVAL (HZ/2+1)
+
 /* We can only use 1 card due to the /dev/watchdog restriction */
 static int cards_found;
 
 /* internal variables */
-static int current_readport, revision, temp_panic;
 static atomic_t open_allowed = ATOMIC_INIT(1);
 static char expect_close;
+static struct timer_list timer;
+static unsigned long next_heartbeat;
+static int temp_panic;
+static int revision;			/* The card's revision */
 static int supports_temp;		/* Wether or not the card has a temperature device */
 static int command_mode;		/* Wether or not the card is in command mode */
 static int initial_status;		/* The card's boot status */
+static int current_readport;		/* The cards I/O address */
 static spinlock_t io_lock;
-static int heartbeat;
 
 /* module parameters */
+#define WATCHDOG_HEARTBEAT 60		/* 60 sec default heartbeat */
+static int heartbeat = WATCHDOG_HEARTBEAT;
+module_param(heartbeat, int, 0);
+MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. (2<=heartbeat<=7200, default=" __MODULE_STRING(WATCHDOG_HEARTBEAT) ")");
+
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 static int nowayout = 1;
 #else
@@ -204,18 +221,53 @@
 	command_mode = 0;
 }
 
+static void pcwd_timer_ping(unsigned long data)
+{
+	int wdrst_stat;
+
+	/* If we got a heartbeat pulse within the WDT_INTERVAL
+	 * we agree to ping the WDT */
+	if(time_before(jiffies, next_heartbeat)) {
+		/* Ping the watchdog */
+		spin_lock(&io_lock);
+		if (revision == PCWD_REVISION_A) {
+			/*  Rev A cards are reset by setting the WD_WDRST bit in register 1 */
+			wdrst_stat = inb_p(current_readport);
+			wdrst_stat &= 0x0F;
+			wdrst_stat |= WD_WDRST;
+
+			outb_p(wdrst_stat, current_readport + 1);
+		} else {
+			/* Re-trigger watchdog by writing to port 0 */
+			outb_p(0x00, current_readport);
+		}
+
+		/* Re-set the timer interval */
+		mod_timer(&timer, jiffies + WDT_INTERVAL);
+
+		spin_unlock(&io_lock);
+	} else {
+		printk(KERN_WARNING PFX "Heartbeat lost! Will not ping the watchdog\n");
+	}
+}
+
 static int pcwd_start(void)
 {
 	int stat_reg;
 
-	/*  Enable the port  */
+	next_heartbeat = jiffies + (heartbeat * HZ);
+
+	/* Start the timer */
+	mod_timer(&timer, jiffies + WDT_INTERVAL);
+
+	/* Enable the port */
 	if (revision == PCWD_REVISION_C) {
 		spin_lock(&io_lock);
 		outb_p(0x00, current_readport + 3);
+		udelay(ISA_COMMAND_TIMEOUT);
 		stat_reg = inb_p(current_readport + 2);
 		spin_unlock(&io_lock);
-		if (stat_reg & 0x10)
-		{
+		if (stat_reg & 0x10) {
 			printk(KERN_INFO PFX "Could not start watchdog\n");
 			return -EIO;
 		}
@@ -227,15 +279,19 @@
 {
 	int stat_reg;
 
+	/* Stop the timer */
+	del_timer(&timer);
+
 	/*  Disable the board  */
 	if (revision == PCWD_REVISION_C) {
 		spin_lock(&io_lock);
 		outb_p(0xA5, current_readport + 3);
+		udelay(ISA_COMMAND_TIMEOUT);
 		outb_p(0xA5, current_readport + 3);
+		udelay(ISA_COMMAND_TIMEOUT);
 		stat_reg = inb_p(current_readport + 2);
 		spin_unlock(&io_lock);
-		if ((stat_reg & 0x10) == 0)
-		{
+		if ((stat_reg & 0x10) == 0) {
 			printk(KERN_INFO PFX "Could not stop watchdog\n");
 			return -EIO;
 		}
@@ -243,19 +299,19 @@
 	return 0;
 }
 
-static void pcwd_send_heartbeat(void)
+static void pcwd_keepalive(void)
 {
-	int wdrst_stat;
-
-	wdrst_stat = inb_p(current_readport);
-	wdrst_stat &= 0x0F;
+	/* user land ping */
+	next_heartbeat = jiffies + (heartbeat * HZ);
+}
 
-	wdrst_stat |= WD_WDRST;
+static int pcwd_set_heartbeat(int t)
+{
+	if ((t < 2) || (t > 7200)) /* arbitrary upper limit */
+		return -EINVAL;
 
-	if (revision == PCWD_REVISION_A)
-		outb_p(wdrst_stat, current_readport + 1);
-	else
-		outb_p(wdrst_stat, current_readport);
+	heartbeat = t;
+	return 0;
 }
 
 static int pcwd_get_status(int *status)
@@ -347,11 +403,12 @@
 	int rv;
 	int status;
 	int temperature;
-	static struct watchdog_info ident=
-	{
+	int new_heartbeat;
+	static struct watchdog_info ident = {
 		.options =		WDIOF_OVERHEAT |
 					WDIOF_CARDRESET |
 					WDIOF_KEEPALIVEPING |
+					WDIOF_SETTIMEOUT |
 					WDIOF_MAGICCLOSE,
 		.firmware_version =	1,
 		.identity =		"PCWD",
@@ -403,9 +460,19 @@
 		return -EINVAL;
 
 	case WDIOC_KEEPALIVE:
-		pcwd_send_heartbeat();
+		pcwd_keepalive();
 		return 0;
 
+	case WDIOC_SETTIMEOUT:
+		if (get_user(new_heartbeat, (int *) arg))
+			return -EFAULT;
+
+		if (pcwd_set_heartbeat(new_heartbeat))
+			return -EINVAL;
+
+		pcwd_keepalive();
+		/* Fall */
+
 	case WDIOC_GETTIMEOUT:
 		return put_user(heartbeat, (int *)arg);
 	}
@@ -436,7 +503,7 @@
 					expect_close = 42;
 			}
 		}
-		pcwd_send_heartbeat();
+		pcwd_keepalive();
 	}
 	return len;
 }
@@ -453,6 +520,7 @@
 
 	/* Activate */
 	pcwd_start();
+	pcwd_keepalive();
 	return(0);
 }
 
@@ -463,7 +531,7 @@
 		atomic_inc( &open_allowed );
 	} else {
 		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
-		pcwd_send_heartbeat();
+		pcwd_keepalive();
 	}
 	expect_close = 0;
 	return 0;
@@ -651,7 +719,6 @@
 	supports_temp = 0;
 	temp_panic = 0;
 	initial_status = 0x0000;
-	heartbeat = 0;
 
 	/* get the boot_status */
 	pcwd_get_status(&initial_status);
@@ -659,6 +726,10 @@
 	/* clear the "card caused reboot" flag */
 	pcwd_clear_status();
 
+	init_timer(&timer);
+	timer.function = pcwd_timer_ping;
+	timer.data = 0;
+
 	/*  Disable the board  */
 	pcwd_stop();
 
@@ -674,20 +745,16 @@
 			current_readport, firmware);
 		kfree(firmware);
 		option_switches = get_option_switches();
-		switch (option_switches & 0x07) {
-			case 0: heartbeat = 20; break;
-			case 1: heartbeat = 40; break;
-			case 2: heartbeat = 60; break;
-			case 3: heartbeat = 300; break;
-			case 4: heartbeat = 600; break;
-			case 5: heartbeat = 1800; break;
-			case 6: heartbeat = 3600; break;
-			case 7: heartbeat = 7200; break;
-		}
 		printk(KERN_INFO PFX "Option switches (0x%02x): Temperature Reset Enable=%s, Power On Delay=%s\n",
 			option_switches,
 			((option_switches & 0x10) ? "ON" : "OFF"),
 			((option_switches & 0x08) ? "ON" : "OFF"));
+
+		/* Reprogram internal heartbeat to 2 seconds */
+		if (set_command_mode()) {
+			send_isa_command(CMD_ISA_DELAY_TIME_2SECS);
+			unset_command_mode();
+		}
 	} else {
 		/* Should NEVER happen, unless get_revision() fails. */
 		printk(KERN_INFO PFX "Unable to get revision\n");
@@ -709,6 +776,13 @@
 
 	if (initial_status == 0)
 		printk(KERN_INFO PFX "No previous trip detected - Cold boot or reset\n");
+
+	/* Check that the heartbeat value is within it's range ; if not reset to the default */
+        if (pcwd_set_heartbeat(heartbeat)) {
+                pcwd_set_heartbeat(WATCHDOG_HEARTBEAT);
+                printk(KERN_INFO PFX "heartbeat value must be 2<=heartbeat<=7200, using %d\n",
+                        WATCHDOG_HEARTBEAT);
+	}
 
 	ret = register_reboot_notifier(&pcwd_notifier);
 	if (ret) {
