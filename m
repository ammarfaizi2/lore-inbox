Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWBLOST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWBLOST (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 09:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWBLOST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 09:18:19 -0500
Received: from outmx007.isp.belgacom.be ([195.238.5.234]:33217 "EHLO
	outmx007.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1750764AbWBLOSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 09:18:18 -0500
Date: Sun, 12 Feb 2006 15:17:57 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] sa1100_wdt.c + pcwd.c patches
Message-ID: <20060212141757.GB4218@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

updates on the sparse annotations for sa1100_wdt.c &
updates of the pcwd.c code (to get it more in line with the code
of the 2 other pc-watchdog cards. Tested it on my own ISA card).
The code was in the -mm tree for testing as well, no remarks received.

please pull from 'master' branch of
master.kernel.org:/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git

This will update the following files:

 drivers/char/watchdog/pcwd.c       |  450 +++++++++++++++++++------------------
 drivers/char/watchdog/sa1100_wdt.c |   12 
 2 files changed, 239 insertions(+), 223 deletions(-)

with these Changes:

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Mon Jan 9 22:07:22 2006 +0100

    [WATCHDOG] pcwd.c - update module version info
    
    Update the module version defines.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Mon Jan 9 22:03:41 2006 +0100

    [WATCHDOG] pcwd.c show card info patch
    
    Put all code for showing the card's boot info in
    one sub-routine.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Mon Jan 9 21:59:39 2006 +0100

    [WATCHDOG] pcwd.c move get_support to pcwd_check_temperature_support
    
    Rename get_support function to pcwd_check_temperature_support
    so that it is clearer what the function does.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Mon Jan 9 21:56:09 2006 +0100

    [WATCHDOG] pcwd.c Control Status #2 patch
    
    Add Control Status #2 bits (with defines)
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Mon Jan 9 21:53:33 2006 +0100

    [WATCHDOG] pcwd.c private data struct patch
    
    more private data of the card to one struct.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sat Dec 10 14:36:24 2005 +0100

    [WATCHDOG] pcwd.c card_found-- fix.
    
    When doing a __devexit from a card we should also
    decrement the cards_found counter.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sat Dec 10 14:22:37 2005 +0100

    [WATCHDOG] pcwd.c add comments + tabs
    
    add extra comments for the include files
    changes spaces by tabs where it is appropriate.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Ian Campbell <icampbell@arcom.com>
Date:   Mon Nov 7 10:21:24 2005 +0000

    [WATCHDOG] sa1100_wdt.c sparse clean (2)
    
    The following makes drivers/char/watchdog/sa1100_wdt.c sparse clean.
    (similar to the other watchdog drivers)
    
    Signed-off-by: Ian Campbell <icampbell@arcom.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    


The Changes can also be looked at on:
	http://www.kernel.org/git/?p=linux/kernel/git/wim/linux-2.6-watchdog.git;a=summary

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/drivers/char/watchdog/pcwd.c b/drivers/char/watchdog/pcwd.c
index 37c9e13..8d6b249 100644
--- a/drivers/char/watchdog/pcwd.c
+++ b/drivers/char/watchdog/pcwd.c
@@ -49,29 +49,37 @@
  *	More info available at http://www.berkprod.com/ or http://www.pcwatchdog.com/
  */
 
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/types.h>
-#include <linux/timer.h>
-#include <linux/jiffies.h>
-#include <linux/config.h>
-#include <linux/wait.h>
-#include <linux/slab.h>
-#include <linux/ioport.h>
-#include <linux/delay.h>
-#include <linux/fs.h>
-#include <linux/miscdevice.h>
-#include <linux/watchdog.h>
-#include <linux/notifier.h>
-#include <linux/init.h>
-#include <linux/spinlock.h>
-#include <linux/reboot.h>
+#include <linux/config.h>	/* For CONFIG_WATCHDOG_NOWAYOUT/... */
+#include <linux/module.h>	/* For module specific items */
+#include <linux/moduleparam.h>	/* For new moduleparam's */
+#include <linux/types.h>	/* For standard types (like size_t) */
+#include <linux/errno.h>	/* For the -ENODEV/... values */
+#include <linux/kernel.h>	/* For printk/panic/... */
+#include <linux/delay.h>	/* For mdelay function */
+#include <linux/timer.h>	/* For timer related operations */
+#include <linux/jiffies.h>	/* For jiffies stuff */
+#include <linux/miscdevice.h>	/* For MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR) */
+#include <linux/watchdog.h>	/* For the watchdog specific items */
+#include <linux/notifier.h>	/* For notifier support */
+#include <linux/reboot.h>	/* For reboot_notifier stuff */
+#include <linux/init.h>		/* For __init/__exit/... */
+#include <linux/fs.h>		/* For file operations */
+#include <linux/ioport.h>	/* For io-port access */
+#include <linux/spinlock.h>	/* For spin_lock/spin_unlock/... */
 #include <linux/sched.h>	/* TASK_INTERRUPTIBLE, set_current_state() and friends */
-#include <asm/uaccess.h>
-#include <asm/io.h>
+#include <linux/slab.h>		/* For kmalloc */
 
-#define WD_VER                  "1.16 (06/12/2004)"
-#define PFX			"pcwd: "
+#include <asm/uaccess.h>	/* For copy_to_user/put_user/... */
+#include <asm/io.h>		/* For inb/outb/... */
+
+/* Module and version information */
+#define WATCHDOG_VERSION "1.16"
+#define WATCHDOG_DATE "03 Jan 2006"
+#define WATCHDOG_DRIVER_NAME "ISA-PC Watchdog"
+#define WATCHDOG_NAME "pcwd"
+#define PFX WATCHDOG_NAME ": "
+#define DRIVER_VERSION WATCHDOG_DRIVER_NAME " driver, v" WATCHDOG_VERSION " (" WATCHDOG_DATE ")\n"
+#define WD_VER WATCHDOG_VERSION " (" WATCHDOG_DATE ")"
 
 /*
  * It should be noted that PCWD_REVISION_B was removed because A and B
@@ -85,36 +93,38 @@
 
 /*
  * These are the defines that describe the control status bits for the
- * PC Watchdog card, revision A.
- */
+ * PCI-PC Watchdog card.
+*/
+/* Port 1 : Control Status #1 for the PC Watchdog card, revision A. */
 #define WD_WDRST                0x01	/* Previously reset state */
 #define WD_T110                 0x02	/* Temperature overheat sense */
 #define WD_HRTBT                0x04	/* Heartbeat sense */
 #define WD_RLY2                 0x08	/* External relay triggered */
 #define WD_SRLY2                0x80	/* Software external relay triggered */
-
-/*
- * These are the defines that describe the control status bits for the
- * PC Watchdog card, revision C.
- */
+/* Port 1 : Control Status #1 for the PC Watchdog card, revision C. */
 #define WD_REVC_WTRP            0x01	/* Watchdog Trip status */
 #define WD_REVC_HRBT            0x02	/* Watchdog Heartbeat */
 #define WD_REVC_TTRP            0x04	/* Temperature Trip status */
+/* Port 2 : Control Status #2 */
+#define WD_WDIS			0x10	/* Watchdog Disabled */
+#define WD_ENTP			0x20	/* Watchdog Enable Temperature Trip */
+#define WD_SSEL			0x40	/* Watchdog Switch Select (1:SW1 <-> 0:SW2) */
+#define WD_WCMD			0x80	/* Watchdog Command Mode */
 
 /* max. time we give an ISA watchdog card to process a command */
 /* 500ms for each 4 bit response (according to spec.) */
 #define ISA_COMMAND_TIMEOUT     1000
 
 /* Watchdog's internal commands */
-#define CMD_ISA_IDLE                    0x00
-#define CMD_ISA_VERSION_INTEGER         0x01
-#define CMD_ISA_VERSION_TENTH           0x02
-#define CMD_ISA_VERSION_HUNDRETH        0x03
-#define CMD_ISA_VERSION_MINOR           0x04
-#define CMD_ISA_SWITCH_SETTINGS         0x05
-#define CMD_ISA_DELAY_TIME_2SECS        0x0A
-#define CMD_ISA_DELAY_TIME_4SECS        0x0B
-#define CMD_ISA_DELAY_TIME_8SECS        0x0C
+#define CMD_ISA_IDLE			0x00
+#define CMD_ISA_VERSION_INTEGER		0x01
+#define CMD_ISA_VERSION_TENTH		0x02
+#define CMD_ISA_VERSION_HUNDRETH	0x03
+#define CMD_ISA_VERSION_MINOR		0x04
+#define CMD_ISA_SWITCH_SETTINGS		0x05
+#define CMD_ISA_DELAY_TIME_2SECS	0x0A
+#define CMD_ISA_DELAY_TIME_4SECS	0x0B
+#define CMD_ISA_DELAY_TIME_8SECS	0x0C
 
 /*
  * We are using an kernel timer to do the pinging of the watchdog
@@ -130,15 +140,17 @@ static int cards_found;
 /* internal variables */
 static atomic_t open_allowed = ATOMIC_INIT(1);
 static char expect_close;
-static struct timer_list timer;
-static unsigned long next_heartbeat;
 static int temp_panic;
-static int revision;			/* The card's revision */
-static int supports_temp;		/* Wether or not the card has a temperature device */
-static int command_mode;		/* Wether or not the card is in command mode */
-static int initial_status;		/* The card's boot status */
-static int current_readport;		/* The cards I/O address */
-static spinlock_t io_lock;
+static struct {				/* this is private data for each ISA-PC watchdog card */
+	int revision;			/* The card's revision */
+	int supports_temp;		/* Wether or not the card has a temperature device */
+	int command_mode;		/* Wether or not the card is in command mode */
+	int boot_status;		/* The card's boot status */
+	int io_addr;			/* The cards I/O address */
+	spinlock_t io_lock;		/* the lock for io operations */
+	struct timer_list timer;	/* The timer that pings the watchdog */
+	unsigned long next_heartbeat;	/* the next_heartbeat for the timer */
+} pcwd_private;
 
 /* module parameters */
 #define WATCHDOG_HEARTBEAT 60		/* 60 sec default heartbeat */
@@ -161,14 +173,14 @@ static int send_isa_command(int cmd)
 	int port0, last_port0;	/* Double read for stabilising */
 
 	/* The WCMD bit must be 1 and the command is only 4 bits in size */
-	control_status = (cmd & 0x0F) | 0x80;
-	outb_p(control_status, current_readport + 2);
+	control_status = (cmd & 0x0F) | WD_WCMD;
+	outb_p(control_status, pcwd_private.io_addr + 2);
 	udelay(ISA_COMMAND_TIMEOUT);
 
-	port0 = inb_p(current_readport);
+	port0 = inb_p(pcwd_private.io_addr);
 	for (i = 0; i < 25; ++i) {
 		last_port0 = port0;
-		port0 = inb_p(current_readport);
+		port0 = inb_p(pcwd_private.io_addr);
 
 		if (port0 == last_port0)
 			break;	/* Data is stable */
@@ -184,7 +196,7 @@ static int set_command_mode(void)
 	int i, found=0, count=0;
 
 	/* Set the card into command mode */
-	spin_lock(&io_lock);
+	spin_lock(&pcwd_private.io_lock);
 	while ((!found) && (count < 3)) {
 		i = send_isa_command(CMD_ISA_IDLE);
 
@@ -192,15 +204,15 @@ static int set_command_mode(void)
 			found = 1;
 		else if (i == 0xF3) {
 			/* Card does not like what we've done to it */
-			outb_p(0x00, current_readport + 2);
+			outb_p(0x00, pcwd_private.io_addr + 2);
 			udelay(1200);	/* Spec says wait 1ms */
-			outb_p(0x00, current_readport + 2);
+			outb_p(0x00, pcwd_private.io_addr + 2);
 			udelay(ISA_COMMAND_TIMEOUT);
 		}
 		count++;
 	}
-	spin_unlock(&io_lock);
-	command_mode = found;
+	spin_unlock(&pcwd_private.io_lock);
+	pcwd_private.command_mode = found;
 
 	return(found);
 }
@@ -208,12 +220,95 @@ static int set_command_mode(void)
 static void unset_command_mode(void)
 {
 	/* Set the card into normal mode */
-	spin_lock(&io_lock);
-	outb_p(0x00, current_readport + 2);
+	spin_lock(&pcwd_private.io_lock);
+	outb_p(0x00, pcwd_private.io_addr + 2);
 	udelay(ISA_COMMAND_TIMEOUT);
-	spin_unlock(&io_lock);
+	spin_unlock(&pcwd_private.io_lock);
+
+	pcwd_private.command_mode = 0;
+}
+
+static inline void pcwd_check_temperature_support(void)
+{
+	if (inb(pcwd_private.io_addr) != 0xF0)
+		pcwd_private.supports_temp = 1;
+}
+
+static inline char *get_firmware(void)
+{
+	int one, ten, hund, minor;
+	char *ret;
+
+	ret = kmalloc(6, GFP_KERNEL);
+	if(ret == NULL)
+		return NULL;
+
+	if (set_command_mode()) {
+		one = send_isa_command(CMD_ISA_VERSION_INTEGER);
+		ten = send_isa_command(CMD_ISA_VERSION_TENTH);
+		hund = send_isa_command(CMD_ISA_VERSION_HUNDRETH);
+		minor = send_isa_command(CMD_ISA_VERSION_MINOR);
+		sprintf(ret, "%c.%c%c%c", one, ten, hund, minor);
+	}
+	else
+		sprintf(ret, "ERROR");
+
+	unset_command_mode();
+	return(ret);
+}
+
+static inline int pcwd_get_option_switches(void)
+{
+	int option_switches=0;
+
+	if (set_command_mode()) {
+		/* Get switch settings */
+		option_switches = send_isa_command(CMD_ISA_SWITCH_SETTINGS);
+	}
+
+	unset_command_mode();
+	return(option_switches);
+}
+
+static void pcwd_show_card_info(void)
+{
+	char *firmware;
+	int option_switches;
+
+	/* Get some extra info from the hardware (in command/debug/diag mode) */
+	if (pcwd_private.revision == PCWD_REVISION_A)
+		printk(KERN_INFO PFX "ISA-PC Watchdog (REV.A) detected at port 0x%04x\n", pcwd_private.io_addr);
+	else if (pcwd_private.revision == PCWD_REVISION_C) {
+		firmware = get_firmware();
+		printk(KERN_INFO PFX "ISA-PC Watchdog (REV.C) detected at port 0x%04x (Firmware version: %s)\n",
+			pcwd_private.io_addr, firmware);
+		kfree(firmware);
+		option_switches = pcwd_get_option_switches();
+		printk(KERN_INFO PFX "Option switches (0x%02x): Temperature Reset Enable=%s, Power On Delay=%s\n",
+			option_switches,
+			((option_switches & 0x10) ? "ON" : "OFF"),
+			((option_switches & 0x08) ? "ON" : "OFF"));
+
+		/* Reprogram internal heartbeat to 2 seconds */
+		if (set_command_mode()) {
+			send_isa_command(CMD_ISA_DELAY_TIME_2SECS);
+			unset_command_mode();
+		}
+	}
+
+	if (pcwd_private.supports_temp)
+		printk(KERN_INFO PFX "Temperature Option Detected\n");
+
+	if (pcwd_private.boot_status & WDIOF_CARDRESET)
+		printk(KERN_INFO PFX "Previous reboot was caused by the card\n");
+
+	if (pcwd_private.boot_status & WDIOF_OVERHEAT) {
+		printk(KERN_EMERG PFX "Card senses a CPU Overheat. Panicking!\n");
+		printk(KERN_EMERG PFX "CPU Overheat\n");
+	}
 
-	command_mode = 0;
+	if (pcwd_private.boot_status == 0)
+		printk(KERN_INFO PFX "No previous trip detected - Cold boot or reset\n");
 }
 
 static void pcwd_timer_ping(unsigned long data)
@@ -222,25 +317,25 @@ static void pcwd_timer_ping(unsigned lon
 
 	/* If we got a heartbeat pulse within the WDT_INTERVAL
 	 * we agree to ping the WDT */
-	if(time_before(jiffies, next_heartbeat)) {
+	if(time_before(jiffies, pcwd_private.next_heartbeat)) {
 		/* Ping the watchdog */
-		spin_lock(&io_lock);
-		if (revision == PCWD_REVISION_A) {
+		spin_lock(&pcwd_private.io_lock);
+		if (pcwd_private.revision == PCWD_REVISION_A) {
 			/*  Rev A cards are reset by setting the WD_WDRST bit in register 1 */
-			wdrst_stat = inb_p(current_readport);
+			wdrst_stat = inb_p(pcwd_private.io_addr);
 			wdrst_stat &= 0x0F;
 			wdrst_stat |= WD_WDRST;
 
-			outb_p(wdrst_stat, current_readport + 1);
+			outb_p(wdrst_stat, pcwd_private.io_addr + 1);
 		} else {
 			/* Re-trigger watchdog by writing to port 0 */
-			outb_p(0x00, current_readport);
+			outb_p(0x00, pcwd_private.io_addr);
 		}
 
 		/* Re-set the timer interval */
-		mod_timer(&timer, jiffies + WDT_INTERVAL);
+		mod_timer(&pcwd_private.timer, jiffies + WDT_INTERVAL);
 
-		spin_unlock(&io_lock);
+		spin_unlock(&pcwd_private.io_lock);
 	} else {
 		printk(KERN_WARNING PFX "Heartbeat lost! Will not ping the watchdog\n");
 	}
@@ -250,19 +345,19 @@ static int pcwd_start(void)
 {
 	int stat_reg;
 
-	next_heartbeat = jiffies + (heartbeat * HZ);
+	pcwd_private.next_heartbeat = jiffies + (heartbeat * HZ);
 
 	/* Start the timer */
-	mod_timer(&timer, jiffies + WDT_INTERVAL);
+	mod_timer(&pcwd_private.timer, jiffies + WDT_INTERVAL);
 
 	/* Enable the port */
-	if (revision == PCWD_REVISION_C) {
-		spin_lock(&io_lock);
-		outb_p(0x00, current_readport + 3);
+	if (pcwd_private.revision == PCWD_REVISION_C) {
+		spin_lock(&pcwd_private.io_lock);
+		outb_p(0x00, pcwd_private.io_addr + 3);
 		udelay(ISA_COMMAND_TIMEOUT);
-		stat_reg = inb_p(current_readport + 2);
-		spin_unlock(&io_lock);
-		if (stat_reg & 0x10) {
+		stat_reg = inb_p(pcwd_private.io_addr + 2);
+		spin_unlock(&pcwd_private.io_lock);
+		if (stat_reg & WD_WDIS) {
 			printk(KERN_INFO PFX "Could not start watchdog\n");
 			return -EIO;
 		}
@@ -275,18 +370,18 @@ static int pcwd_stop(void)
 	int stat_reg;
 
 	/* Stop the timer */
-	del_timer(&timer);
+	del_timer(&pcwd_private.timer);
 
 	/*  Disable the board  */
-	if (revision == PCWD_REVISION_C) {
-		spin_lock(&io_lock);
-		outb_p(0xA5, current_readport + 3);
+	if (pcwd_private.revision == PCWD_REVISION_C) {
+		spin_lock(&pcwd_private.io_lock);
+		outb_p(0xA5, pcwd_private.io_addr + 3);
 		udelay(ISA_COMMAND_TIMEOUT);
-		outb_p(0xA5, current_readport + 3);
+		outb_p(0xA5, pcwd_private.io_addr + 3);
 		udelay(ISA_COMMAND_TIMEOUT);
-		stat_reg = inb_p(current_readport + 2);
-		spin_unlock(&io_lock);
-		if ((stat_reg & 0x10) == 0) {
+		stat_reg = inb_p(pcwd_private.io_addr + 2);
+		spin_unlock(&pcwd_private.io_lock);
+		if ((stat_reg & WD_WDIS) == 0) {
 			printk(KERN_INFO PFX "Could not stop watchdog\n");
 			return -EIO;
 		}
@@ -297,7 +392,7 @@ static int pcwd_stop(void)
 static int pcwd_keepalive(void)
 {
 	/* user land ping */
-	next_heartbeat = jiffies + (heartbeat * HZ);
+	pcwd_private.next_heartbeat = jiffies + (heartbeat * HZ);
 	return 0;
 }
 
@@ -315,23 +410,23 @@ static int pcwd_get_status(int *status)
 	int card_status;
 
 	*status=0;
-	spin_lock(&io_lock);
-	if (revision == PCWD_REVISION_A)
+	spin_lock(&pcwd_private.io_lock);
+	if (pcwd_private.revision == PCWD_REVISION_A)
 		/* Rev A cards return status information from
 		 * the base register, which is used for the
 		 * temperature in other cards. */
-		card_status = inb(current_readport);
+		card_status = inb(pcwd_private.io_addr);
 	else {
 		/* Rev C cards return card status in the base
 		 * address + 1 register. And use different bits
 		 * to indicate a card initiated reset, and an
 		 * over-temperature condition. And the reboot
 		 * status can be reset. */
-		card_status = inb(current_readport + 1);
+		card_status = inb(pcwd_private.io_addr + 1);
 	}
-	spin_unlock(&io_lock);
+	spin_unlock(&pcwd_private.io_lock);
 
-	if (revision == PCWD_REVISION_A) {
+	if (pcwd_private.revision == PCWD_REVISION_A) {
 		if (card_status & WD_WDRST)
 			*status |= WDIOF_CARDRESET;
 
@@ -360,10 +455,10 @@ static int pcwd_get_status(int *status)
 
 static int pcwd_clear_status(void)
 {
-	if (revision == PCWD_REVISION_C) {
-		spin_lock(&io_lock);
-		outb_p(0x00, current_readport + 1); /* clear reset status */
-		spin_unlock(&io_lock);
+	if (pcwd_private.revision == PCWD_REVISION_C) {
+		spin_lock(&pcwd_private.io_lock);
+		outb_p(0x00, pcwd_private.io_addr + 1); /* clear reset status */
+		spin_unlock(&pcwd_private.io_lock);
 	}
 	return 0;
 }
@@ -371,20 +466,20 @@ static int pcwd_clear_status(void)
 static int pcwd_get_temperature(int *temperature)
 {
 	/* check that port 0 gives temperature info and no command results */
-	if (command_mode)
+	if (pcwd_private.command_mode)
 		return -1;
 
 	*temperature = 0;
-	if (!supports_temp)
+	if (!pcwd_private.supports_temp)
 		return -ENODEV;
 
 	/*
 	 * Convert celsius to fahrenheit, since this was
 	 * the decided 'standard' for this return value.
 	 */
-	spin_lock(&io_lock);
-	*temperature = ((inb(current_readport)) * 9 / 5) + 32;
-	spin_unlock(&io_lock);
+	spin_lock(&pcwd_private.io_lock);
+	*temperature = ((inb(pcwd_private.io_addr)) * 9 / 5) + 32;
+	spin_unlock(&pcwd_private.io_lock);
 
 	return 0;
 }
@@ -425,7 +520,7 @@ static int pcwd_ioctl(struct inode *inod
 		return put_user(status, argp);
 
 	case WDIOC_GETBOOTSTATUS:
-		return put_user(initial_status, argp);
+		return put_user(pcwd_private.boot_status, argp);
 
 	case WDIOC_GETTEMP:
 		if (pcwd_get_temperature(&temperature))
@@ -434,7 +529,7 @@ static int pcwd_ioctl(struct inode *inod
 		return put_user(temperature, argp);
 
 	case WDIOC_SETOPTIONS:
-		if (revision == PCWD_REVISION_C)
+		if (pcwd_private.revision == PCWD_REVISION_C)
 		{
 			if(copy_from_user(&rv, argp, sizeof(int)))
 				return -EFAULT;
@@ -550,7 +645,7 @@ static ssize_t pcwd_temp_read(struct fil
 
 static int pcwd_temp_open(struct inode *inode, struct file *file)
 {
-	if (!supports_temp)
+	if (!pcwd_private.supports_temp)
 		return -ENODEV;
 
 	return nonseekable_open(inode, file);
@@ -616,68 +711,24 @@ static struct notifier_block pcwd_notifi
  *	Init & exit routines
  */
 
-static inline void get_support(void)
-{
-	if (inb(current_readport) != 0xF0)
-		supports_temp = 1;
-}
-
 static inline int get_revision(void)
 {
 	int r = PCWD_REVISION_C;
 
-	spin_lock(&io_lock);
+	spin_lock(&pcwd_private.io_lock);
 	/* REV A cards use only 2 io ports; test
 	 * presumes a floating bus reads as 0xff. */
-	if ((inb(current_readport + 2) == 0xFF) ||
-	    (inb(current_readport + 3) == 0xFF))
+	if ((inb(pcwd_private.io_addr + 2) == 0xFF) ||
+	    (inb(pcwd_private.io_addr + 3) == 0xFF))
 		r=PCWD_REVISION_A;
-	spin_unlock(&io_lock);
+	spin_unlock(&pcwd_private.io_lock);
 
 	return r;
 }
 
-static inline char *get_firmware(void)
-{
-	int one, ten, hund, minor;
-	char *ret;
-
-	ret = kmalloc(6, GFP_KERNEL);
-	if(ret == NULL)
-		return NULL;
-
-	if (set_command_mode()) {
-		one = send_isa_command(CMD_ISA_VERSION_INTEGER);
-		ten = send_isa_command(CMD_ISA_VERSION_TENTH);
-		hund = send_isa_command(CMD_ISA_VERSION_HUNDRETH);
-		minor = send_isa_command(CMD_ISA_VERSION_MINOR);
-		sprintf(ret, "%c.%c%c%c", one, ten, hund, minor);
-	}
-	else
-		sprintf(ret, "ERROR");
-
-	unset_command_mode();
-	return(ret);
-}
-
-static inline int get_option_switches(void)
-{
-	int rv=0;
-
-	if (set_command_mode()) {
-		/* Get switch settings */
-		rv = send_isa_command(CMD_ISA_SWITCH_SETTINGS);
-	}
-
-	unset_command_mode();
-	return(rv);
-}
-
 static int __devinit pcwatchdog_init(int base_addr)
 {
 	int ret;
-	char *firmware;
-	int option_switches;
 
 	cards_found++;
 	if (cards_found == 1)
@@ -692,104 +743,66 @@ static int __devinit pcwatchdog_init(int
 		printk(KERN_ERR PFX "No I/O-Address for card detected\n");
 		return -ENODEV;
 	}
-	current_readport = base_addr;
+	pcwd_private.io_addr = base_addr;
 
 	/* Check card's revision */
-	revision = get_revision();
+	pcwd_private.revision = get_revision();
 
-	if (!request_region(current_readport, (revision == PCWD_REVISION_A) ? 2 : 4, "PCWD")) {
+	if (!request_region(pcwd_private.io_addr, (pcwd_private.revision == PCWD_REVISION_A) ? 2 : 4, "PCWD")) {
 		printk(KERN_ERR PFX "I/O address 0x%04x already in use\n",
-			current_readport);
-		current_readport = 0x0000;
+			pcwd_private.io_addr);
+		pcwd_private.io_addr = 0x0000;
 		return -EIO;
 	}
 
 	/* Initial variables */
-	supports_temp = 0;
+	pcwd_private.supports_temp = 0;
 	temp_panic = 0;
-	initial_status = 0x0000;
+	pcwd_private.boot_status = 0x0000;
 
 	/* get the boot_status */
-	pcwd_get_status(&initial_status);
+	pcwd_get_status(&pcwd_private.boot_status);
 
 	/* clear the "card caused reboot" flag */
 	pcwd_clear_status();
 
-	init_timer(&timer);
-	timer.function = pcwd_timer_ping;
-	timer.data = 0;
+	init_timer(&pcwd_private.timer);
+	pcwd_private.timer.function = pcwd_timer_ping;
+	pcwd_private.timer.data = 0;
 
 	/*  Disable the board  */
 	pcwd_stop();
 
 	/*  Check whether or not the card supports the temperature device */
-	get_support();
-
-	/* Get some extra info from the hardware (in command/debug/diag mode) */
-	if (revision == PCWD_REVISION_A)
-		printk(KERN_INFO PFX "ISA-PC Watchdog (REV.A) detected at port 0x%04x\n", current_readport);
-	else if (revision == PCWD_REVISION_C) {
-		firmware = get_firmware();
-		printk(KERN_INFO PFX "ISA-PC Watchdog (REV.C) detected at port 0x%04x (Firmware version: %s)\n",
-			current_readport, firmware);
-		kfree(firmware);
-		option_switches = get_option_switches();
-		printk(KERN_INFO PFX "Option switches (0x%02x): Temperature Reset Enable=%s, Power On Delay=%s\n",
-			option_switches,
-			((option_switches & 0x10) ? "ON" : "OFF"),
-			((option_switches & 0x08) ? "ON" : "OFF"));
-
-		/* Reprogram internal heartbeat to 2 seconds */
-		if (set_command_mode()) {
-			send_isa_command(CMD_ISA_DELAY_TIME_2SECS);
-			unset_command_mode();
-		}
-	} else {
-		/* Should NEVER happen, unless get_revision() fails. */
-		printk(KERN_INFO PFX "Unable to get revision\n");
-		release_region(current_readport, (revision == PCWD_REVISION_A) ? 2 : 4);
-		current_readport = 0x0000;
-		return -1;
-	}
+	pcwd_check_temperature_support();
 
-	if (supports_temp)
-		printk(KERN_INFO PFX "Temperature Option Detected\n");
-
-	if (initial_status & WDIOF_CARDRESET)
-		printk(KERN_INFO PFX "Previous reboot was caused by the card\n");
-
-	if (initial_status & WDIOF_OVERHEAT) {
-		printk(KERN_EMERG PFX "Card senses a CPU Overheat. Panicking!\n");
-		printk(KERN_EMERG PFX "CPU Overheat\n");
-	}
-
-	if (initial_status == 0)
-		printk(KERN_INFO PFX "No previous trip detected - Cold boot or reset\n");
+	/* Show info about the card itself */
+	pcwd_show_card_info();
 
 	/* Check that the heartbeat value is within it's range ; if not reset to the default */
-        if (pcwd_set_heartbeat(heartbeat)) {
-                pcwd_set_heartbeat(WATCHDOG_HEARTBEAT);
-                printk(KERN_INFO PFX "heartbeat value must be 2<=heartbeat<=7200, using %d\n",
-                        WATCHDOG_HEARTBEAT);
+	if (pcwd_set_heartbeat(heartbeat)) {
+		pcwd_set_heartbeat(WATCHDOG_HEARTBEAT);
+		printk(KERN_INFO PFX "heartbeat value must be 2<=heartbeat<=7200, using %d\n",
+			WATCHDOG_HEARTBEAT);
 	}
 
 	ret = register_reboot_notifier(&pcwd_notifier);
 	if (ret) {
 		printk(KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
 			ret);
-		release_region(current_readport, (revision == PCWD_REVISION_A) ? 2 : 4);
-		current_readport = 0x0000;
+		release_region(pcwd_private.io_addr, (pcwd_private.revision == PCWD_REVISION_A) ? 2 : 4);
+		pcwd_private.io_addr = 0x0000;
 		return ret;
 	}
 
-	if (supports_temp) {
+	if (pcwd_private.supports_temp) {
 		ret = misc_register(&temp_miscdev);
 		if (ret) {
 			printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
 				TEMP_MINOR, ret);
 			unregister_reboot_notifier(&pcwd_notifier);
-			release_region(current_readport, (revision == PCWD_REVISION_A) ? 2 : 4);
-			current_readport = 0x0000;
+			release_region(pcwd_private.io_addr, (pcwd_private.revision == PCWD_REVISION_A) ? 2 : 4);
+			pcwd_private.io_addr = 0x0000;
 			return ret;
 		}
 	}
@@ -798,11 +811,11 @@ static int __devinit pcwatchdog_init(int
 	if (ret) {
 		printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
 			WATCHDOG_MINOR, ret);
-		if (supports_temp)
+		if (pcwd_private.supports_temp)
 			misc_deregister(&temp_miscdev);
 		unregister_reboot_notifier(&pcwd_notifier);
-		release_region(current_readport, (revision == PCWD_REVISION_A) ? 2 : 4);
-		current_readport = 0x0000;
+		release_region(pcwd_private.io_addr, (pcwd_private.revision == PCWD_REVISION_A) ? 2 : 4);
+		pcwd_private.io_addr = 0x0000;
 		return ret;
 	}
 
@@ -820,11 +833,12 @@ static void __devexit pcwatchdog_exit(vo
 
 	/* Deregister */
 	misc_deregister(&pcwd_miscdev);
-	if (supports_temp)
+	if (pcwd_private.supports_temp)
 		misc_deregister(&temp_miscdev);
 	unregister_reboot_notifier(&pcwd_notifier);
-	release_region(current_readport, (revision == PCWD_REVISION_A) ? 2 : 4);
-	current_readport = 0x0000;
+	release_region(pcwd_private.io_addr, (pcwd_private.revision == PCWD_REVISION_A) ? 2 : 4);
+	pcwd_private.io_addr = 0x0000;
+	cards_found--;
 }
 
 /*
@@ -887,7 +901,7 @@ static int __init pcwd_init_module(void)
 {
 	int i, found = 0;
 
-	spin_lock_init(&io_lock);
+	spin_lock_init(&pcwd_private.io_lock);
 
 	for (i = 0; pcwd_ioports[i] != 0; i++) {
 		if (pcwd_checkcard(pcwd_ioports[i])) {
@@ -906,7 +920,7 @@ static int __init pcwd_init_module(void)
 
 static void __exit pcwd_cleanup_module(void)
 {
-	if (current_readport)
+	if (pcwd_private.io_addr)
 		pcwatchdog_exit();
 	return;
 }
diff --git a/drivers/char/watchdog/sa1100_wdt.c b/drivers/char/watchdog/sa1100_wdt.c
index b474ea5..522a937 100644
--- a/drivers/char/watchdog/sa1100_wdt.c
+++ b/drivers/char/watchdog/sa1100_wdt.c
@@ -93,23 +93,25 @@ static int sa1100dog_ioctl(struct inode 
 {
 	int ret = -ENOIOCTLCMD;
 	int time;
+	void __user *argp = (void __user *)arg;
+	int __user *p = argp;
 
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
-		ret = copy_to_user((struct watchdog_info __user *)arg, &ident,
+		ret = copy_to_user(argp, &ident,
 				   sizeof(ident)) ? -EFAULT : 0;
 		break;
 
 	case WDIOC_GETSTATUS:
-		ret = put_user(0, (int __user *)arg);
+		ret = put_user(0, p);
 		break;
 
 	case WDIOC_GETBOOTSTATUS:
-		ret = put_user(boot_status, (int __user *)arg);
+		ret = put_user(boot_status, p);
 		break;
 
 	case WDIOC_SETTIMEOUT:
-		ret = get_user(time, (int __user *)arg);
+		ret = get_user(time, p);
 		if (ret)
 			break;
 
@@ -123,7 +125,7 @@ static int sa1100dog_ioctl(struct inode 
 		/*fall through*/
 
 	case WDIOC_GETTIMEOUT:
-		ret = put_user(pre_margin / OSCR_FREQ, (int __user *)arg);
+		ret = put_user(pre_margin / OSCR_FREQ, p);
 		break;
 
 	case WDIOC_KEEPALIVE:
