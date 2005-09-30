Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbVI3Kzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbVI3Kzv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 06:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbVI3Kzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 06:55:51 -0400
Received: from asia.telenet-ops.be ([195.130.137.74]:60639 "EHLO
	asia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1030197AbVI3Kzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 06:55:50 -0400
Date: Fri, 30 Sep 2005 12:55:40 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] pcwd_pci.c patches
Message-ID: <20050930105540.GI19487@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please do a

	git pull rsync://rsync.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git

This will update the following files:

 drivers/char/watchdog/pcwd_pci.c |  239 ++++++++++++++++++++++++++++-----------
 1 files changed, 172 insertions(+), 67 deletions(-)

with these Changes:

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Thu Sep 29 16:22:30 2005 +0200

    [WATCHDOG] pcwd_pci.c add debug module_param
    
    Add debugging code for the pcwd_pci driver.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Thu Sep 29 16:21:50 2005 +0200

    [WATCHDOG] pcwd_pci.c control status + boot-code clean-up
    
    * Clean-up control status code (use control status defines +
      change pcipcwd_clear_status)
    * Clean-up boot-code (move card info to pcipcwd_show_card_info() )
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>


The Changes can also be looked at on:
	http://www.kernel.org/git/?p=linux/kernel/git/wim/linux-2.6-watchdog.git;a=summary

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/drivers/char/watchdog/pcwd_pci.c b/drivers/char/watchdog/pcwd_pci.c
--- a/drivers/char/watchdog/pcwd_pci.c
+++ b/drivers/char/watchdog/pcwd_pci.c
@@ -50,8 +50,8 @@
 #include <asm/io.h>		/* For inb/outb/... */
 
 /* Module and version information */
-#define WATCHDOG_VERSION "1.01"
-#define WATCHDOG_DATE "02 Sep 2005"
+#define WATCHDOG_VERSION "1.02"
+#define WATCHDOG_DATE "03 Sep 2005"
 #define WATCHDOG_DRIVER_NAME "PCI-PC Watchdog"
 #define WATCHDOG_NAME "pcwd_pci"
 #define PFX WATCHDOG_NAME ": "
@@ -70,19 +70,30 @@
  * These are the defines that describe the control status bits for the
  * PCI-PC Watchdog card.
  */
-#define WD_PCI_WTRP             0x01	/* Watchdog Trip status */
-#define WD_PCI_HRBT             0x02	/* Watchdog Heartbeat */
-#define WD_PCI_TTRP             0x04	/* Temperature Trip status */
+/* Port 1 : Control Status #1 */
+#define WD_PCI_WTRP		0x01	/* Watchdog Trip status */
+#define WD_PCI_HRBT		0x02	/* Watchdog Heartbeat */
+#define WD_PCI_TTRP		0x04	/* Temperature Trip status */
+#define WD_PCI_RL2A		0x08	/* Relay 2 Active */
+#define WD_PCI_RL1A		0x10	/* Relay 1 Active */
+#define WD_PCI_R2DS		0x40	/* Relay 2 Disable Temperature-trip/reset */
+#define WD_PCI_RLY2		0x80	/* Activate Relay 2 on the board */
+/* Port 2 : Control Status #2 */
+#define WD_PCI_WDIS		0x10	/* Watchdog Disable */
+#define WD_PCI_ENTP		0x20	/* Enable Temperature Trip Reset */
+#define WD_PCI_WRSP		0x40	/* Watchdog wrote response */
+#define WD_PCI_PCMD		0x80	/* PC has sent command */
 
 /* according to documentation max. time to process a command for the pci
  * watchdog card is 100 ms, so we give it 150 ms to do it's job */
 #define PCI_COMMAND_TIMEOUT	150
 
 /* Watchdog's internal commands */
-#define CMD_GET_STATUS			0x04
-#define CMD_GET_FIRMWARE_VERSION	0x08
-#define CMD_READ_WATCHDOG_TIMEOUT	0x18
-#define CMD_WRITE_WATCHDOG_TIMEOUT	0x19
+#define CMD_GET_STATUS				0x04
+#define CMD_GET_FIRMWARE_VERSION		0x08
+#define CMD_READ_WATCHDOG_TIMEOUT		0x18
+#define CMD_WRITE_WATCHDOG_TIMEOUT		0x19
+#define CMD_GET_CLEAR_RESET_COUNT		0x84
 
 /* We can only use 1 card due to the /dev/watchdog restriction */
 static int cards_found;
@@ -91,15 +102,22 @@ static int cards_found;
 static int temp_panic;
 static unsigned long is_active;
 static char expect_release;
-static struct {
-	int supports_temp;	/* Wether or not the card has a temperature device */
-	int boot_status;	/* The card's boot status */
-	unsigned long io_addr;	/* The cards I/O address */
-	spinlock_t io_lock;
-	struct pci_dev *pdev;
+static struct {				/* this is private data for each PCI-PC watchdog card */
+	int supports_temp;		/* Wether or not the card has a temperature device */
+	int boot_status;		/* The card's boot status */
+	unsigned long io_addr;		/* The cards I/O address */
+	spinlock_t io_lock;		/* the lock for io operations */
+	struct pci_dev *pdev;		/* the PCI-device */
 } pcipcwd_private;
 
 /* module parameters */
+#define QUIET	0	/* Default */
+#define VERBOSE	1	/* Verbose */
+#define DEBUG	2	/* print fancy stuff too */
+static int debug = QUIET;
+module_param(debug, int, 0);
+MODULE_PARM_DESC(debug, "Debug level: 0=Quiet, 1=Verbose, 2=Debug (default=0)");
+
 #define WATCHDOG_HEARTBEAT 2	/* 2 sec default heartbeat */
 static int heartbeat = WATCHDOG_HEARTBEAT;
 module_param(heartbeat, int, 0);
@@ -117,6 +135,10 @@ static int send_command(int cmd, int *ms
 {
 	int got_response, count;
 
+	if (debug >= DEBUG)
+		printk(KERN_DEBUG PFX "sending following data cmd=0x%02x msb=0x%02x lsb=0x%02x\n",
+		cmd, *msb, *lsb);
+
 	spin_lock(&pcipcwd_private.io_lock);
 	/* If a command requires data it should be written first.
 	 * Data for commands with 8 bits of data should be written to port 4.
@@ -131,10 +153,19 @@ static int send_command(int cmd, int *ms
 	/* wait till the pci card processed the command, signaled by
 	 * the WRSP bit in port 2 and give it a max. timeout of
 	 * PCI_COMMAND_TIMEOUT to process */
-	got_response = inb_p(pcipcwd_private.io_addr + 2) & 0x40;
+	got_response = inb_p(pcipcwd_private.io_addr + 2) & WD_PCI_WRSP;
 	for (count = 0; (count < PCI_COMMAND_TIMEOUT) && (!got_response); count++) {
 		mdelay(1);
-		got_response = inb_p(pcipcwd_private.io_addr + 2) & 0x40;
+		got_response = inb_p(pcipcwd_private.io_addr + 2) & WD_PCI_WRSP;
+	}
+
+	if (debug >= DEBUG) {
+		if (got_response) {
+			printk(KERN_DEBUG PFX "time to process command was: %d ms\n",
+				count);
+		} else {
+			printk(KERN_DEBUG PFX "card did not respond on command!\n");
+		}
 	}
 
 	if (got_response) {
@@ -144,12 +175,66 @@ static int send_command(int cmd, int *ms
 
 		/* clear WRSP bit */
 		inb_p(pcipcwd_private.io_addr + 6);
+
+		if (debug >= DEBUG)
+			printk(KERN_DEBUG PFX "received following data for cmd=0x%02x: msb=0x%02x lsb=0x%02x\n",
+				cmd, *msb, *lsb);
 	}
+
 	spin_unlock(&pcipcwd_private.io_lock);
 
 	return got_response;
 }
 
+static inline void pcipcwd_check_temperature_support(void)
+{
+	if (inb_p(pcipcwd_private.io_addr) != 0xF0)
+		pcipcwd_private.supports_temp = 1;
+}
+
+static int pcipcwd_get_option_switches(void)
+{
+	int option_switches;
+
+	option_switches = inb_p(pcipcwd_private.io_addr + 3);
+	return option_switches;
+}
+
+static void pcipcwd_show_card_info(void)
+{
+	int got_fw_rev, fw_rev_major, fw_rev_minor;
+	char fw_ver_str[20];		/* The cards firmware version */
+	int option_switches;
+
+	got_fw_rev = send_command(CMD_GET_FIRMWARE_VERSION, &fw_rev_major, &fw_rev_minor);
+	if (got_fw_rev) {
+		sprintf(fw_ver_str, "%u.%02u", fw_rev_major, fw_rev_minor);
+	} else {
+		sprintf(fw_ver_str, "<card no answer>");
+	}
+
+	/* Get switch settings */
+	option_switches = pcipcwd_get_option_switches();
+
+	printk(KERN_INFO PFX "Found card at port 0x%04x (Firmware: %s) %s temp option\n",
+		(int) pcipcwd_private.io_addr, fw_ver_str,
+		(pcipcwd_private.supports_temp ? "with" : "without"));
+
+	printk(KERN_INFO PFX "Option switches (0x%02x): Temperature Reset Enable=%s, Power On Delay=%s\n",
+		option_switches,
+		((option_switches & 0x10) ? "ON" : "OFF"),
+		((option_switches & 0x08) ? "ON" : "OFF"));
+
+	if (pcipcwd_private.boot_status & WDIOF_CARDRESET)
+		printk(KERN_INFO PFX "Previous reset was caused by the Watchdog card\n");
+
+	if (pcipcwd_private.boot_status & WDIOF_OVERHEAT)
+		printk(KERN_INFO PFX "Card sensed a CPU Overheat\n");
+
+	if (pcipcwd_private.boot_status == 0)
+		printk(KERN_INFO PFX "No previous trip detected - Cold boot or reset\n");
+}
+
 static int pcipcwd_start(void)
 {
 	int stat_reg;
@@ -161,11 +246,14 @@ static int pcipcwd_start(void)
 	stat_reg = inb_p(pcipcwd_private.io_addr + 2);
 	spin_unlock(&pcipcwd_private.io_lock);
 
-	if (stat_reg & 0x10) {
+	if (stat_reg & WD_PCI_WDIS) {
 		printk(KERN_ERR PFX "Card timer not enabled\n");
 		return -1;
 	}
 
+	if (debug >= VERBOSE)
+		printk(KERN_DEBUG PFX "Watchdog started\n");
+
 	return 0;
 }
 
@@ -183,18 +271,25 @@ static int pcipcwd_stop(void)
 	stat_reg = inb_p(pcipcwd_private.io_addr + 2);
 	spin_unlock(&pcipcwd_private.io_lock);
 
-	if (!(stat_reg & 0x10)) {
+	if (!(stat_reg & WD_PCI_WDIS)) {
 		printk(KERN_ERR PFX "Card did not acknowledge disable attempt\n");
 		return -1;
 	}
 
+	if (debug >= VERBOSE)
+		printk(KERN_DEBUG PFX "Watchdog stopped\n");
+
 	return 0;
 }
 
 static int pcipcwd_keepalive(void)
 {
 	/* Re-trigger watchdog by writing to port 0 */
-	outb_p(0x42, pcipcwd_private.io_addr);
+	outb_p(0x42, pcipcwd_private.io_addr);	/* send out any data */
+
+	if (debug >= DEBUG)
+		printk(KERN_DEBUG PFX "Watchdog keepalive signal send\n");
+
 	return 0;
 }
 
@@ -210,29 +305,64 @@ static int pcipcwd_set_heartbeat(int t)
 	send_command(CMD_WRITE_WATCHDOG_TIMEOUT, &t_msb, &t_lsb);
 
 	heartbeat = t;
+	if (debug >= VERBOSE)
+		printk(KERN_DEBUG PFX "New heartbeat: %d\n",
+		       heartbeat);
+
 	return 0;
 }
 
 static int pcipcwd_get_status(int *status)
 {
-	int new_status;
+	int control_status;
 
 	*status=0;
-	new_status = inb_p(pcipcwd_private.io_addr + 1);
-	if (new_status & WD_PCI_WTRP)
+	control_status = inb_p(pcipcwd_private.io_addr + 1);
+	if (control_status & WD_PCI_WTRP)
 		*status |= WDIOF_CARDRESET;
-	if (new_status & WD_PCI_TTRP) {
+	if (control_status & WD_PCI_TTRP) {
 		*status |= WDIOF_OVERHEAT;
 		if (temp_panic)
 			panic(PFX "Temperature overheat trip!\n");
 	}
 
+	if (debug >= DEBUG)
+		printk(KERN_DEBUG PFX "Control Status #1: 0x%02x\n",
+		       control_status);
+
 	return 0;
 }
 
 static int pcipcwd_clear_status(void)
 {
-	outb_p(0x01, pcipcwd_private.io_addr + 1);
+	int control_status;
+	int msb;
+	int reset_counter;
+
+	if (debug >= VERBOSE)
+		printk(KERN_INFO PFX "clearing watchdog trip status & LED\n");
+
+	control_status = inb_p(pcipcwd_private.io_addr + 1);
+
+	if (debug >= DEBUG) {
+		printk(KERN_DEBUG PFX "status was: 0x%02x\n", control_status);
+		printk(KERN_DEBUG PFX "sending: 0x%02x\n",
+		       (control_status & WD_PCI_R2DS) | WD_PCI_WTRP);
+	}
+
+	/* clear trip status & LED and keep mode of relay 2 */
+	outb_p((control_status & WD_PCI_R2DS) | WD_PCI_WTRP, pcipcwd_private.io_addr + 1);
+
+	/* clear reset counter */
+	msb=0;
+	reset_counter=0xff;
+	send_command(CMD_GET_CLEAR_RESET_COUNT, &msb, &reset_counter);
+
+	if (debug >= DEBUG) {
+		printk(KERN_DEBUG PFX "reset count was: 0x%02x\n",
+		       reset_counter);
+	}
+
 	return 0;
 }
 
@@ -242,11 +372,18 @@ static int pcipcwd_get_temperature(int *
 	if (!pcipcwd_private.supports_temp)
 		return -ENODEV;
 
+	*temperature = inb_p(pcipcwd_private.io_addr);
+
 	/*
 	 * Convert celsius to fahrenheit, since this was
 	 * the decided 'standard' for this return value.
 	 */
-	*temperature = ((inb_p(pcipcwd_private.io_addr)) * 9 / 5) + 32;
+	*temperature = (*temperature * 9 / 5) + 32;
+
+	if (debug >= DEBUG) {
+		printk(KERN_DEBUG PFX "temperature is: %d F\n",
+		       *temperature);
+	}
 
 	return 0;
 }
@@ -256,7 +393,7 @@ static int pcipcwd_get_temperature(int *
  */
 
 static ssize_t pcipcwd_write(struct file *file, const char __user *data,
-			      size_t len, loff_t *ppos)
+			     size_t len, loff_t *ppos)
 {
 	/* See if we got the magic character 'V' and reload the timer */
 	if (len) {
@@ -381,8 +518,11 @@ static int pcipcwd_ioctl(struct inode *i
 static int pcipcwd_open(struct inode *inode, struct file *file)
 {
 	/* /dev/watchdog can only be opened once */
-	if (test_and_set_bit(0, &is_active))
+	if (test_and_set_bit(0, &is_active)) {
+		if (debug >= VERBOSE)
+			printk(KERN_ERR PFX "Attempt to open already opened device.\n");
 		return -EBUSY;
+	}
 
 	/* Activate */
 	pcipcwd_start();
@@ -492,19 +632,10 @@ static struct notifier_block pcipcwd_not
  *	Init & exit routines
  */
 
-static inline void check_temperature_support(void)
-{
-	if (inb_p(pcipcwd_private.io_addr) != 0xF0)
-		pcipcwd_private.supports_temp = 1;
-}
-
 static int __devinit pcipcwd_card_init(struct pci_dev *pdev,
 		const struct pci_device_id *ent)
 {
 	int ret = -EIO;
-	int got_fw_rev, fw_rev_major, fw_rev_minor;
-	char fw_ver_str[20];
-	char option_switches;
 
 	cards_found++;
 	if (cards_found == 1)
@@ -546,36 +677,10 @@ static int __devinit pcipcwd_card_init(s
 	pcipcwd_stop();
 
 	/* Check whether or not the card supports the temperature device */
-	check_temperature_support();
-
-	/* Get the Firmware Version */
-	got_fw_rev = send_command(CMD_GET_FIRMWARE_VERSION, &fw_rev_major, &fw_rev_minor);
-	if (got_fw_rev) {
-		sprintf(fw_ver_str, "%u.%02u", fw_rev_major, fw_rev_minor);
-	} else {
-		sprintf(fw_ver_str, "<card no answer>");
-	}
+	pcipcwd_check_temperature_support();
 
-	/* Get switch settings */
-	option_switches = inb_p(pcipcwd_private.io_addr + 3);
-
-	printk(KERN_INFO PFX "Found card at port 0x%04x (Firmware: %s) %s temp option\n",
-		(int) pcipcwd_private.io_addr, fw_ver_str,
-		(pcipcwd_private.supports_temp ? "with" : "without"));
-
-	printk(KERN_INFO PFX "Option switches (0x%02x): Temperature Reset Enable=%s, Power On Delay=%s\n",
-		option_switches,
-		((option_switches & 0x10) ? "ON" : "OFF"),
-		((option_switches & 0x08) ? "ON" : "OFF"));
-
-	if (pcipcwd_private.boot_status & WDIOF_CARDRESET)
-		printk(KERN_INFO PFX "Previous reset was caused by the Watchdog card\n");
-
-	if (pcipcwd_private.boot_status & WDIOF_OVERHEAT)
-		printk(KERN_INFO PFX "Card sensed a CPU Overheat\n");
-
-	if (pcipcwd_private.boot_status == 0)
-		printk(KERN_INFO PFX "No previous trip detected - Cold boot or reset\n");
+	/* Show info about the card itself */
+	pcipcwd_show_card_info();
 
 	/* Check that the heartbeat value is within it's range ; if not reset to the default */
 	if (pcipcwd_set_heartbeat(heartbeat)) {
@@ -656,7 +761,7 @@ static struct pci_driver pcipcwd_driver 
 
 static int __init pcipcwd_init_module(void)
 {
-	spin_lock_init (&pcipcwd_private.io_lock);
+	spin_lock_init(&pcipcwd_private.io_lock);
 
 	return pci_register_driver(&pcipcwd_driver);
 }
