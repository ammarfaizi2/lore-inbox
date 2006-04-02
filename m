Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWDBREH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWDBREH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 13:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWDBREH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 13:04:07 -0400
Received: from outmx010.isp.belgacom.be ([195.238.5.233]:21688 "EHLO
	outmx010.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S932361AbWDBREF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 13:04:05 -0400
Date: Sun, 2 Apr 2006 19:03:46 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [WATCHDOG] v2.6.16 watchdog patches - pcwd.c pcwd_usb.c & at91_wdt.c
Message-ID: <20060402170346.GA5195@infomag.infomag.iguana.be>
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

 drivers/char/watchdog/Kconfig    |    7 +
 drivers/char/watchdog/Makefile   |    1 
 drivers/char/watchdog/at91_wdt.c |  228 +++++++++++++++++++++++++++++++++++++++
 drivers/char/watchdog/pcwd.c     |  137 +++++++++++++++++------
 drivers/char/watchdog/pcwd_usb.c |    3 
 5 files changed, 340 insertions(+), 36 deletions(-)

with these Changes:

Author: Andrew Victor <andrew@sanpeople.com>
Date:   Tue Mar 14 11:11:04 2006 +0200

    [WATCHDOG] at91_wdt.c - Atmel AT91RM9200 watchdog driver
    
    Watchdog driver for the Atmel AT91RM9200 processor.
    
    Signed-off-by: Andrew Victor <andrew@sanpeople.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

Author: Adrian Bunk <bunk@stusta.de>
Date:   Fri Mar 10 19:04:38 2006 +0100

    [WATCHDOG] pcwd_usb.c: fix a NULL pointer dereference
    
    The Coverity checker noted that this resulted in a NULL pointer
    reference if we were coming from
    
            if (usb_pcwd == NULL) {
                    printk(KERN_ERR PFX "Out of memory\n");
                        goto error;
            }
    
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Thu Mar 2 20:05:16 2006 +0100

    [WATCHDOG] pcwd.c sprintf/strcpy fix
    
    change sprintf(pcwd_private.fw_ver_str, "ERROR");
    to strcpy... as pointed out by Andrew Morton.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

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
diff --git a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
index 16e99db..d53f664 100644
--- a/drivers/char/watchdog/Kconfig
+++ b/drivers/char/watchdog/Kconfig
@@ -60,6 +60,13 @@ config SOFT_WATCHDOG
 
 # ARM Architecture
 
+config AT91_WATCHDOG
+	tristate "AT91RM9200 watchdog"
+	depends on WATCHDOG && ARCH_AT91RM9200
+	help
+	  Watchdog timer embedded into AT91RM9200 chips. This will reboot your
+	  system when the timeout is reached.
+
 config 21285_WATCHDOG
 	tristate "DC21285 watchdog"
 	depends on WATCHDOG && FOOTBRIDGE
diff --git a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
index d6f27fd..6ab77b6 100644
--- a/drivers/char/watchdog/Makefile
+++ b/drivers/char/watchdog/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_WDTPCI) += wdt_pci.o
 obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
 
 # ARM Architecture
+obj-$(CONFIG_AT91_WATCHDOG) += at91_wdt.o
 obj-$(CONFIG_21285_WATCHDOG) += wdt285.o
 obj-$(CONFIG_977_WATCHDOG) += wdt977.o
 obj-$(CONFIG_IXP2000_WATCHDOG) += ixp2000_wdt.o
diff --git a/drivers/char/watchdog/at91_wdt.c b/drivers/char/watchdog/at91_wdt.c
new file mode 100644
index 0000000..ac83bc4
--- /dev/null
+++ b/drivers/char/watchdog/at91_wdt.c
@@ -0,0 +1,228 @@
+/*
+ * Watchdog driver for Atmel AT91RM9200 (Thunder)
+ *
+ *  Copyright (C) 2003 SAN People (Pty) Ltd
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
+#include <asm/bitops.h>
+#include <asm/uaccess.h>
+
+
+#define WDT_DEFAULT_TIME	5	/* 5 seconds */
+#define WDT_MAX_TIME		256	/* 256 seconds */
+
+static int wdt_time = WDT_DEFAULT_TIME;
+static int nowayout = WATCHDOG_NOWAYOUT;
+
+module_param(wdt_time, int, 0);
+MODULE_PARM_DESC(wdt_time, "Watchdog time in seconds. (default="__MODULE_STRING(WDT_DEFAULT_TIME) ")");
+
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+
+static unsigned long at91wdt_busy;
+
+/* ......................................................................... */
+
+/*
+ * Disable the watchdog.
+ */
+static void inline at91_wdt_stop(void)
+{
+	at91_sys_write(AT91_ST_WDMR, AT91_ST_EXTEN);
+}
+
+/*
+ * Enable and reset the watchdog.
+ */
+static void inline at91_wdt_start(void)
+{
+	at91_sys_write(AT91_ST_WDMR, AT91_ST_EXTEN | AT91_ST_RSTEN | (((65536 * wdt_time) >> 8) & AT91_ST_WDV));
+	at91_sys_write(AT91_ST_CR, AT91_ST_WDRST);
+}
+
+/*
+ * Reload the watchdog timer.  (ie, pat the watchdog)
+ */
+static void inline at91_wdt_reload(void)
+{
+	at91_sys_write(AT91_ST_CR, AT91_ST_WDRST);
+}
+
+/* ......................................................................... */
+
+/*
+ * Watchdog device is opened, and watchdog starts running.
+ */
+static int at91_wdt_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(0, &at91wdt_busy))
+		return -EBUSY;
+
+	at91_wdt_start();
+	return nonseekable_open(inode, file);
+}
+
+/*
+ * Close the watchdog device.
+ * If CONFIG_WATCHDOG_NOWAYOUT is NOT defined then the watchdog is also
+ *  disabled.
+ */
+static int at91_wdt_close(struct inode *inode, struct file *file)
+{
+	if (!nowayout)
+		at91_wdt_stop();	/* Disable the watchdog when file is closed */
+
+	clear_bit(0, &at91wdt_busy);
+	return 0;
+}
+
+/*
+ * Change the watchdog time interval.
+ */
+static int at91_wdt_settimeout(int new_time)
+{
+	/*
+	 * All counting occurs at SLOW_CLOCK / 128 = 0.256 Hz
+	 *
+	 * Since WDV is a 16-bit counter, the maximum period is
+	 * 65536 / 0.256 = 256 seconds.
+	 */
+	if ((new_time <= 0) || (new_time > WDT_MAX_TIME))
+		return -EINVAL;
+
+	/* Set new watchdog time. It will be used when at91_wdt_start() is called. */
+	wdt_time = new_time;
+	return 0;
+}
+
+static struct watchdog_info at91_wdt_info = {
+	.identity	= "at91 watchdog",
+	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+};
+
+/*
+ * Handle commands from user-space.
+ */
+static int at91_wdt_ioctl(struct inode *inode, struct file *file,
+		unsigned int cmd, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	int __user *p = argp;
+	int new_value;
+
+	switch(cmd) {
+		case WDIOC_KEEPALIVE:
+			at91_wdt_reload();	/* pat the watchdog */
+			return 0;
+
+		case WDIOC_GETSUPPORT:
+			return copy_to_user(argp, &at91_wdt_info, sizeof(at91_wdt_info)) ? -EFAULT : 0;
+
+		case WDIOC_SETTIMEOUT:
+			if (get_user(new_value, p))
+				return -EFAULT;
+				
+			if (at91_wdt_settimeout(new_value))
+				return -EINVAL;
+
+			/* Enable new time value */
+			at91_wdt_start();
+
+			/* Return current value */
+			return put_user(wdt_time, p);
+
+		case WDIOC_GETTIMEOUT:
+			return put_user(wdt_time, p);
+
+		case WDIOC_GETSTATUS:
+		case WDIOC_GETBOOTSTATUS:
+			return put_user(0, p);
+
+		case WDIOC_SETOPTIONS:
+			if (get_user(new_value, p))
+				return -EFAULT;
+
+			if (new_value & WDIOS_DISABLECARD)
+				at91_wdt_stop();
+			if (new_value & WDIOS_ENABLECARD)
+				at91_wdt_start();
+			return 0;
+
+		default:
+			return -ENOIOCTLCMD;
+	}
+}
+
+/*
+ * Pat the watchdog whenever device is written to.
+ */
+static ssize_t at91_wdt_write(struct file *file, const char *data, size_t len, loff_t *ppos)
+{
+	at91_wdt_reload();		/* pat the watchdog */
+	return len;
+}
+
+/* ......................................................................... */
+
+static struct file_operations at91wdt_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= at91_wdt_ioctl,
+	.open		= at91_wdt_open,
+	.release	= at91_wdt_close,
+	.write		= at91_wdt_write,
+};
+
+static struct miscdevice at91wdt_miscdev = {
+	.minor		= WATCHDOG_MINOR,
+	.name		= "watchdog",
+	.fops		= &at91wdt_fops,
+};
+
+static int __init at91_wdt_init(void)
+{
+	int res;
+
+	/* Check that the heartbeat value is within range; if not reset to the default */
+	if (at91_wdt_settimeout(wdt_time)) {
+		at91_wdt_settimeout(WDT_DEFAULT_TIME);
+		printk(KERN_INFO "at91_wdt: wdt_time value must be 1 <= wdt_time <= 256, using %d\n", wdt_time);
+	}
+
+	res = misc_register(&at91wdt_miscdev);
+	if (res)
+		return res;
+
+	printk("AT91 Watchdog Timer enabled (%d seconds, nowayout=%d)\n", wdt_time, nowayout);
+	return 0;
+}
+
+static void __exit at91_wdt_exit(void)
+{
+	misc_deregister(&at91wdt_miscdev);
+}
+
+module_init(at91_wdt_init);
+module_exit(at91_wdt_exit);
+
+MODULE_AUTHOR("Andrew Victor");
+MODULE_DESCRIPTION("Watchdog driver for Atmel AT91RM9200");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
diff --git a/drivers/char/watchdog/pcwd.c b/drivers/char/watchdog/pcwd.c
index 8d6b249..6d44ca6 100644
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
+	strcpy(pcwd_private.fw_ver_str, "ERROR");
 
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
diff --git a/drivers/char/watchdog/pcwd_usb.c b/drivers/char/watchdog/pcwd_usb.c
index 2700c5c..3fdfda9 100644
--- a/drivers/char/watchdog/pcwd_usb.c
+++ b/drivers/char/watchdog/pcwd_usb.c
@@ -705,7 +705,8 @@ err_out_misc_deregister:
 err_out_unregister_reboot:
 	unregister_reboot_notifier(&usb_pcwd_notifier);
 error:
-	usb_pcwd_delete (usb_pcwd);
+	if (usb_pcwd)
+		usb_pcwd_delete(usb_pcwd);
 	usb_pcwd_device = NULL;
 	return retval;
 }
