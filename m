Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbUCZUpA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 15:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUCZUpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 15:45:00 -0500
Received: from astra.telenet-ops.be ([195.130.132.58]:56260 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261214AbUCZUos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 15:44:48 -0500
Date: Fri, 26 Mar 2004 21:44:21 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ken Hollis <kenji@bitgate.com>
Subject: [WATCHDOG] v2.6.5-rc2 pcwd.c-patch2
Message-ID: <20040326214421.Y30061@infomag.infomag.iguana.be>
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

 drivers/char/watchdog/pcwd.c |  214 ++++++++++++++++++++-----------------------
 1 files changed, 100 insertions(+), 114 deletions(-)

through these ChangeSets:

<wim@iguana.be> (04/03/26 1.1693)
   [WATCHDOG] v2.6.5-rc2 pcwd.c-patch2
   
   * Extracted the get_status code to a seperate function (pcwd_get_status)
   * Re-used the pcwd_get_status code for the initial/boot status
   
   Tested on pcwd card with temperature option


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/pcwd.c b/drivers/char/watchdog/pcwd.c
--- a/drivers/char/watchdog/pcwd.c	Fri Mar 26 21:43:46 2004
+++ b/drivers/char/watchdog/pcwd.c	Fri Mar 26 21:43:46 2004
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
