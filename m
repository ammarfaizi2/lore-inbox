Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWB1Srk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWB1Srk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 13:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWB1Srk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 13:47:40 -0500
Received: from outmx018.isp.belgacom.be ([195.238.4.117]:49819 "EHLO
	outmx018.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1751260AbWB1Srj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 13:47:39 -0500
Date: Tue, 28 Feb 2006 19:47:14 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] pcwd.c git patches
Message-ID: <20060228184714.GA6507@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from 'master' branch of
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git

This will update the following files:

 drivers/char/watchdog/pcwd.c |  137 ++++++++++++++++++++++++++++++++-----------
 1 files changed, 102 insertions(+), 35 deletions(-)

with these Changes:

Merge: e51f895d253bb4de39039c555996dbfecaae1b9b b9756c047ce6b60e3b96aa3c5db958acbdacedde
Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Tue Feb 28 19:36:04 2006 +0100

    Merge branch 'master' of rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sun Feb 12 17:44:57 2006 +0100

    [WATCHDOG] pcwd.c general clean-up after patches
    
    removal of includes (since we don't use kmalloc and
    TASK_INTERRUPTABLE anymore).
    Addition of missing commands.
    Printk that lets the user know when the module was
    unloaded.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sun Feb 12 17:12:55 2006 +0100

    [WATCHDOG] pcwd.c add debug info
    
    Add debugging info for the pcwd.c module.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sun Feb 12 16:51:34 2006 +0100

    [WATCHDOG] pcwd.c pcwd_cleanup_module patch
    
    static void pcwd_cleanup_module doesn't need a return;
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sun Feb 12 16:47:34 2006 +0100

    [WATCHDOG] pcwd.c firmware-info patch
    
    Get the firmware version into the private data struct
    of the ISA-PC watchdog card.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sun Feb 12 16:37:36 2006 +0100

    [WATCHDOG] pcwd.c control status patch
    
    Clean-up the control status code (insert tabs where relevant),
    Add new Control Status defines, Make sure that the R2DS bit
    stays the same.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>


The Changes can also be looked at on:
	http://www.kernel.org/git/?p=linux/kernel/git/wim/linux-2.6-watchdog.git;a=summary

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/drivers/char/watchdog/pcwd.c b/drivers/char/watchdog/pcwd.c
index 8d6b249..28a404a 100644
--- a/drivers/char/watchdog/pcwd.c
+++ b/drivers/char/watchdog/pcwd.c
@@ -66,15 +66,13 @@
 #include <linux/fs.h>		/* For file operations */
 #include <linux/ioport.h>	/* For io-port access */
 #include <linux/spinlock.h>	/* For spin_lock/spin_unlock/... */
-#include <linux/sched.h>	/* TASK_INTERRUPTIBLE, set_current_state() and friends */
-#include <linux/slab.h>		/* For kmalloc */
 
 #include <asm/uaccess.h>	/* For copy_to_user/put_user/... */
 #include <asm/io.h>		/* For inb/outb/... */
 
 /* Module and version information */
-#define WATCHDOG_VERSION "1.16"
-#define WATCHDOG_DATE "03 Jan 2006"
+#define WATCHDOG_VERSION "1.17"
+#define WATCHDOG_DATE "12 Feb 2006"
 #define WATCHDOG_DRIVER_NAME "ISA-PC Watchdog"
 #define WATCHDOG_NAME "pcwd"
 #define PFX WATCHDOG_NAME ": "
@@ -96,15 +94,19 @@
  * PCI-PC Watchdog card.
 */
 /* Port 1 : Control Status #1 for the PC Watchdog card, revision A. */
-#define WD_WDRST                0x01	/* Previously reset state */
-#define WD_T110                 0x02	/* Temperature overheat sense */
-#define WD_HRTBT                0x04	/* Heartbeat sense */
-#define WD_RLY2                 0x08	/* External relay triggered */
-#define WD_SRLY2                0x80	/* Software external relay triggered */
+#define WD_WDRST		0x01	/* Previously reset state */
+#define WD_T110			0x02	/* Temperature overheat sense */
+#define WD_HRTBT		0x04	/* Heartbeat sense */
+#define WD_RLY2			0x08	/* External relay triggered */
+#define WD_SRLY2		0x80	/* Software external relay triggered */
 /* Port 1 : Control Status #1 for the PC Watchdog card, revision C. */
-#define WD_REVC_WTRP            0x01	/* Watchdog Trip status */
-#define WD_REVC_HRBT            0x02	/* Watchdog Heartbeat */
-#define WD_REVC_TTRP            0x04	/* Temperature Trip status */
+#define WD_REVC_WTRP		0x01	/* Watchdog Trip status */
+#define WD_REVC_HRBT		0x02	/* Watchdog Heartbeat */
+#define WD_REVC_TTRP		0x04	/* Temperature Trip status */
+#define WD_REVC_RL2A		0x08	/* Relay 2 activated by on-board processor */
+#define WD_REVC_RL1A		0x10	/* Relay 1 active */
+#define WD_REVC_R2DS		0x40	/* Relay 2 disable */
+#define WD_REVC_RLY2		0x80	/* Relay 2 activated? */
 /* Port 2 : Control Status #2 */
 #define WD_WDIS			0x10	/* Watchdog Disabled */
 #define WD_ENTP			0x20	/* Watchdog Enable Temperature Trip */
@@ -122,9 +124,14 @@
 #define CMD_ISA_VERSION_HUNDRETH	0x03
 #define CMD_ISA_VERSION_MINOR		0x04
 #define CMD_ISA_SWITCH_SETTINGS		0x05
+#define CMD_ISA_RESET_PC		0x06
+#define CMD_ISA_ARM_0			0x07
+#define CMD_ISA_ARM_30			0x08
+#define CMD_ISA_ARM_60			0x09
 #define CMD_ISA_DELAY_TIME_2SECS	0x0A
 #define CMD_ISA_DELAY_TIME_4SECS	0x0B
 #define CMD_ISA_DELAY_TIME_8SECS	0x0C
+#define CMD_ISA_RESET_RELAYS		0x0D
 
 /*
  * We are using an kernel timer to do the pinging of the watchdog
@@ -142,6 +149,7 @@ static atomic_t open_allowed = ATOMIC_IN
 static char expect_close;
 static int temp_panic;
 static struct {				/* this is private data for each ISA-PC watchdog card */
+	char fw_ver_str[6];		/* The cards firmware version */
 	int revision;			/* The card's revision */
 	int supports_temp;		/* Wether or not the card has a temperature device */
 	int command_mode;		/* Wether or not the card is in command mode */
@@ -153,6 +161,13 @@ static struct {				/* this is private da
 } pcwd_private;
 
 /* module parameters */
+#define QUIET	0	/* Default */
+#define VERBOSE	1	/* Verbose */
+#define DEBUG	2	/* print fancy stuff too */
+static int debug = QUIET;
+module_param(debug, int, 0);
+MODULE_PARM_DESC(debug, "Debug level: 0=Quiet, 1=Verbose, 2=Debug (default=0)");
+
 #define WATCHDOG_HEARTBEAT 60		/* 60 sec default heartbeat */
 static int heartbeat = WATCHDOG_HEARTBEAT;
 module_param(heartbeat, int, 0);
@@ -172,6 +187,10 @@ static int send_isa_command(int cmd)
 	int control_status;
 	int port0, last_port0;	/* Double read for stabilising */
 
+	if (debug >= DEBUG)
+		printk(KERN_DEBUG PFX "sending following data cmd=0x%02x\n",
+			cmd);
+
 	/* The WCMD bit must be 1 and the command is only 4 bits in size */
 	control_status = (cmd & 0x0F) | WD_WCMD;
 	outb_p(control_status, pcwd_private.io_addr + 2);
@@ -188,6 +207,10 @@ static int send_isa_command(int cmd)
 		udelay (250);
 	}
 
+	if (debug >= DEBUG)
+		printk(KERN_DEBUG PFX "received following data for cmd=0x%02x: port0=0x%02x last_port0=0x%02x\n",
+			cmd, port0, last_port0);
+
 	return port0;
 }
 
@@ -214,6 +237,10 @@ static int set_command_mode(void)
 	spin_unlock(&pcwd_private.io_lock);
 	pcwd_private.command_mode = found;
 
+	if (debug >= DEBUG)
+		printk(KERN_DEBUG PFX "command_mode=%d\n",
+				pcwd_private.command_mode);
+
 	return(found);
 }
 
@@ -226,6 +253,10 @@ static void unset_command_mode(void)
 	spin_unlock(&pcwd_private.io_lock);
 
 	pcwd_private.command_mode = 0;
+
+	if (debug >= DEBUG)
+		printk(KERN_DEBUG PFX "command_mode=%d\n",
+				pcwd_private.command_mode);
 }
 
 static inline void pcwd_check_temperature_support(void)
@@ -234,27 +265,22 @@ static inline void pcwd_check_temperatur
 		pcwd_private.supports_temp = 1;
 }
 
-static inline char *get_firmware(void)
+static inline void pcwd_get_firmware(void)
 {
 	int one, ten, hund, minor;
-	char *ret;
 
-	ret = kmalloc(6, GFP_KERNEL);
-	if(ret == NULL)
-		return NULL;
+	sprintf(pcwd_private.fw_ver_str, "ERROR");
 
 	if (set_command_mode()) {
 		one = send_isa_command(CMD_ISA_VERSION_INTEGER);
 		ten = send_isa_command(CMD_ISA_VERSION_TENTH);
 		hund = send_isa_command(CMD_ISA_VERSION_HUNDRETH);
 		minor = send_isa_command(CMD_ISA_VERSION_MINOR);
-		sprintf(ret, "%c.%c%c%c", one, ten, hund, minor);
+		sprintf(pcwd_private.fw_ver_str, "%c.%c%c%c", one, ten, hund, minor);
 	}
-	else
-		sprintf(ret, "ERROR");
-
 	unset_command_mode();
-	return(ret);
+
+	return;
 }
 
 static inline int pcwd_get_option_switches(void)
@@ -272,17 +298,15 @@ static inline int pcwd_get_option_switch
 
 static void pcwd_show_card_info(void)
 {
-	char *firmware;
 	int option_switches;
 
 	/* Get some extra info from the hardware (in command/debug/diag mode) */
 	if (pcwd_private.revision == PCWD_REVISION_A)
 		printk(KERN_INFO PFX "ISA-PC Watchdog (REV.A) detected at port 0x%04x\n", pcwd_private.io_addr);
 	else if (pcwd_private.revision == PCWD_REVISION_C) {
-		firmware = get_firmware();
+		pcwd_get_firmware();
 		printk(KERN_INFO PFX "ISA-PC Watchdog (REV.C) detected at port 0x%04x (Firmware version: %s)\n",
-			pcwd_private.io_addr, firmware);
-		kfree(firmware);
+			pcwd_private.io_addr, pcwd_private.fw_ver_str);
 		option_switches = pcwd_get_option_switches();
 		printk(KERN_INFO PFX "Option switches (0x%02x): Temperature Reset Enable=%s, Power On Delay=%s\n",
 			option_switches,
@@ -362,6 +386,10 @@ static int pcwd_start(void)
 			return -EIO;
 		}
 	}
+
+	if (debug >= VERBOSE)
+		printk(KERN_DEBUG PFX "Watchdog started\n");
+
 	return 0;
 }
 
@@ -386,6 +414,10 @@ static int pcwd_stop(void)
 			return -EIO;
 		}
 	}
+
+	if (debug >= VERBOSE)
+		printk(KERN_DEBUG PFX "Watchdog stopped\n");
+
 	return 0;
 }
 
@@ -393,6 +425,10 @@ static int pcwd_keepalive(void)
 {
 	/* user land ping */
 	pcwd_private.next_heartbeat = jiffies + (heartbeat * HZ);
+
+	if (debug >= DEBUG)
+		printk(KERN_DEBUG PFX "Watchdog keepalive signal send\n");
+
 	return 0;
 }
 
@@ -402,12 +438,17 @@ static int pcwd_set_heartbeat(int t)
 		return -EINVAL;
 
 	heartbeat = t;
+
+	if (debug >= VERBOSE)
+		printk(KERN_DEBUG PFX "New heartbeat: %d\n",
+		       heartbeat);
+
 	return 0;
 }
 
 static int pcwd_get_status(int *status)
 {
-	int card_status;
+	int control_status;
 
 	*status=0;
 	spin_lock(&pcwd_private.io_lock);
@@ -415,37 +456,39 @@ static int pcwd_get_status(int *status)
 		/* Rev A cards return status information from
 		 * the base register, which is used for the
 		 * temperature in other cards. */
-		card_status = inb(pcwd_private.io_addr);
+		control_status = inb(pcwd_private.io_addr);
 	else {
 		/* Rev C cards return card status in the base
 		 * address + 1 register. And use different bits
 		 * to indicate a card initiated reset, and an
 		 * over-temperature condition. And the reboot
 		 * status can be reset. */
-		card_status = inb(pcwd_private.io_addr + 1);
+		control_status = inb(pcwd_private.io_addr + 1);
 	}
 	spin_unlock(&pcwd_private.io_lock);
 
 	if (pcwd_private.revision == PCWD_REVISION_A) {
-		if (card_status & WD_WDRST)
+		if (control_status & WD_WDRST)
 			*status |= WDIOF_CARDRESET;
 
-		if (card_status & WD_T110) {
+		if (control_status & WD_T110) {
 			*status |= WDIOF_OVERHEAT;
 			if (temp_panic) {
 				printk (KERN_INFO PFX "Temperature overheat trip!\n");
 				kernel_power_off();
+				/* or should we just do a: panic(PFX "Temperature overheat trip!\n"); */
 			}
 		}
 	} else {
-		if (card_status & WD_REVC_WTRP)
+		if (control_status & WD_REVC_WTRP)
 			*status |= WDIOF_CARDRESET;
 
-		if (card_status & WD_REVC_TTRP) {
+		if (control_status & WD_REVC_TTRP) {
 			*status |= WDIOF_OVERHEAT;
 			if (temp_panic) {
 				printk (KERN_INFO PFX "Temperature overheat trip!\n");
 				kernel_power_off();
+				/* or should we just do a: panic(PFX "Temperature overheat trip!\n"); */
 			}
 		}
 	}
@@ -455,9 +498,25 @@ static int pcwd_get_status(int *status)
 
 static int pcwd_clear_status(void)
 {
+	int control_status;
+
 	if (pcwd_private.revision == PCWD_REVISION_C) {
 		spin_lock(&pcwd_private.io_lock);
-		outb_p(0x00, pcwd_private.io_addr + 1); /* clear reset status */
+
+		if (debug >= VERBOSE)
+			printk(KERN_INFO PFX "clearing watchdog trip status\n");
+
+		control_status = inb_p(pcwd_private.io_addr + 1);
+
+		if (debug >= DEBUG) {
+			printk(KERN_DEBUG PFX "status was: 0x%02x\n", control_status);
+			printk(KERN_DEBUG PFX "sending: 0x%02x\n",
+				(control_status & WD_REVC_R2DS));
+		}
+
+		/* clear reset status & Keep Relay 2 disable state as it is */
+		outb_p((control_status & WD_REVC_R2DS), pcwd_private.io_addr + 1);
+
 		spin_unlock(&pcwd_private.io_lock);
 	}
 	return 0;
@@ -481,6 +540,11 @@ static int pcwd_get_temperature(int *tem
 	*temperature = ((inb(pcwd_private.io_addr)) * 9 / 5) + 32;
 	spin_unlock(&pcwd_private.io_lock);
 
+	if (debug >= DEBUG) {
+		printk(KERN_DEBUG PFX "temperature is: %d F\n",
+			*temperature);
+	}
+
 	return 0;
 }
 
@@ -599,6 +663,8 @@ static ssize_t pcwd_write(struct file *f
 static int pcwd_open(struct inode *inode, struct file *file)
 {
 	if (!atomic_dec_and_test(&open_allowed) ) {
+		if (debug >= VERBOSE)
+			printk(KERN_ERR PFX "Attempt to open already opened device.\n");
 		atomic_inc( &open_allowed );
 		return -EBUSY;
 	}
@@ -922,7 +988,8 @@ static void __exit pcwd_cleanup_module(v
 {
 	if (pcwd_private.io_addr)
 		pcwatchdog_exit();
-	return;
+
+	printk(KERN_INFO PFX "Watchdog Module Unloaded.\n");
 }
 
 module_init(pcwd_init_module);
