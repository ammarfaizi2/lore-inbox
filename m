Return-Path: <linux-kernel-owner+w=401wt.eu-S964794AbWLLXHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWLLXHk (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 18:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWLLXHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 18:07:40 -0500
Received: from outmx008.isp.belgacom.be ([195.238.5.235]:56777 "EHLO
	outmx008.isp.belgacom.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964794AbWLLXHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 18:07:38 -0500
Date: Wed, 13 Dec 2006 00:07:18 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Thomas Koeller <thomas.koeller@baslerweb.com>,
       Andrew Victor <andrew@sanpeople.com>,
       David Brownell <david-b@pacbell.net>
Subject: [WATCHDOG] fixes for v2.6.19+
Message-ID: <20061212230718.GA18046@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please pull from 'master' branch of
	git://git.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git

This will update the following files:

 drivers/char/watchdog/at91rm9200_wdt.c |    6 ++--
 drivers/char/watchdog/mpcore_wdt.c     |    2 -
 drivers/char/watchdog/omap_wdt.c       |    2 -
 drivers/char/watchdog/pcwd_usb.c       |    5 ---
 drivers/char/watchdog/rm9k_wdt.c       |   44 ++++++++++++++++-----------------
 5 files changed, 28 insertions(+), 31 deletions(-)

with these Changes:

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Tue Dec 12 23:46:47 2006 +0100

    [WATCHDOG] pcwd_usb.c generic HID include file
    
    Now that the generic HID layer created include/linux/hid.h
    we can use the HID_REQ_SET_REPORT and HID_DT_REPORT defines
    directly from that include file.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Andrew Victor <andrew@sanpeople.com>
Date:   Mon Dec 4 15:56:18 2006 +0200

    [WATCHDOG] watchdog miscdevice patch
    
    It looks like the recent changes to 'struct miscdevice' have impacted
    some of the Watchdog drivers.
    
    at91rm9200_wdt.c:205: error: 'struct miscdevice' has no member named 'dev'
    
    For the AT91RM9200 driver I just replaced "miscdevice.dev" with
    "miscdevice.parent".
    
    The mpcore_wdt.c and omap_wdt.c seem similarly affected.
    
    Signed-off-by: Andrew Victor <andrew@sanpeople.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Thomas Koeller <thomas.koeller@baslerweb.com>
Date:   Wed Dec 6 01:45:39 2006 +0100

    [WATCHDOG] rm9k_wdt: fix interrupt handler arguments
    
    Removed 'struct pt_regs *' from interrupt handler arguments.
    
    Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Thomas Koeller <thomas.koeller@baslerweb.com>
Date:   Wed Dec 6 01:45:26 2006 +0100

    [WATCHDOG] rm9k_wdt: fix compilation
    
    Driver did not compile any more. Someone moved the definition
    of 'struct miscdevice miscdev' to a place near the end of the
    file, after some code that was refering to this variable.
    
    Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

The Changes can also be looked at on:
	http://www.kernel.org/git/?p=linux/kernel/git/wim/linux-2.6-watchdog.git;a=summary

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/drivers/char/watchdog/at91rm9200_wdt.c b/drivers/char/watchdog/at91rm9200_wdt.c
index cb86967..38bd373 100644
--- a/drivers/char/watchdog/at91rm9200_wdt.c
+++ b/drivers/char/watchdog/at91rm9200_wdt.c
@@ -203,9 +203,9 @@ static int __init at91wdt_probe(struct p
 {
 	int res;
 
-	if (at91wdt_miscdev.dev)
+	if (at91wdt_miscdev.parent)
 		return -EBUSY;
-	at91wdt_miscdev.dev = &pdev->dev;
+	at91wdt_miscdev.parent = &pdev->dev;
 
 	res = misc_register(&at91wdt_miscdev);
 	if (res)
@@ -221,7 +221,7 @@ static int __exit at91wdt_remove(struct 
 
 	res = misc_deregister(&at91wdt_miscdev);
 	if (!res)
-		at91wdt_miscdev.dev = NULL;
+		at91wdt_miscdev.parent = NULL;
 
 	return res;
 }
diff --git a/drivers/char/watchdog/mpcore_wdt.c b/drivers/char/watchdog/mpcore_wdt.c
index 3404a9c..e88947f 100644
--- a/drivers/char/watchdog/mpcore_wdt.c
+++ b/drivers/char/watchdog/mpcore_wdt.c
@@ -347,7 +347,7 @@ static int __devinit mpcore_wdt_probe(st
 		goto err_free;
 	}
 
-	mpcore_wdt_miscdev.dev = &dev->dev;
+	mpcore_wdt_miscdev.parent = &dev->dev;
 	ret = misc_register(&mpcore_wdt_miscdev);
 	if (ret) {
 		dev_printk(KERN_ERR, _dev, "cannot register miscdev on minor=%d (err=%d)\n",
diff --git a/drivers/char/watchdog/omap_wdt.c b/drivers/char/watchdog/omap_wdt.c
index 5dbd7dc..6c6f973 100644
--- a/drivers/char/watchdog/omap_wdt.c
+++ b/drivers/char/watchdog/omap_wdt.c
@@ -290,7 +290,7 @@ static int __init omap_wdt_probe(struct 
 	omap_wdt_disable();
 	omap_wdt_adjust_timeout(timer_margin);
 
-	omap_wdt_miscdev.dev = &pdev->dev;
+	omap_wdt_miscdev.parent = &pdev->dev;
 	ret = misc_register(&omap_wdt_miscdev);
 	if (ret)
 		goto fail;
diff --git a/drivers/char/watchdog/pcwd_usb.c b/drivers/char/watchdog/pcwd_usb.c
index 6113872..2da5ac9 100644
--- a/drivers/char/watchdog/pcwd_usb.c
+++ b/drivers/char/watchdog/pcwd_usb.c
@@ -42,6 +42,7 @@ #include <linux/completion.h>
 #include <asm/uaccess.h>
 #include <linux/usb.h>
 #include <linux/mutex.h>
+#include <linux/hid.h>		/* For HID_REQ_SET_REPORT & HID_DT_REPORT */
 
 
 #ifdef CONFIG_USB_DEBUG
@@ -109,10 +110,6 @@ #define CMD_WRITE_WATCHDOG_TIMEOUT	0x19	
 #define CMD_ENABLE_WATCHDOG		0x30	/* Enable / Disable Watchdog */
 #define CMD_DISABLE_WATCHDOG		CMD_ENABLE_WATCHDOG
 
-/* Some defines that I like to be somewhere else like include/linux/usb_hid.h */
-#define HID_REQ_SET_REPORT		0x09
-#define HID_DT_REPORT			(USB_TYPE_CLASS | 0x02)
-
 /* We can only use 1 card due to the /dev/watchdog restriction */
 static int cards_found;
 
diff --git a/drivers/char/watchdog/rm9k_wdt.c b/drivers/char/watchdog/rm9k_wdt.c
index ec39093..7576a13 100644
--- a/drivers/char/watchdog/rm9k_wdt.c
+++ b/drivers/char/watchdog/rm9k_wdt.c
@@ -47,7 +47,7 @@ #define CPGIG1ER               0x0054
 
 
 /* Function prototypes */
-static irqreturn_t wdt_gpi_irqhdl(int, void *, struct pt_regs *);
+static irqreturn_t wdt_gpi_irqhdl(int, void *);
 static void wdt_gpi_start(void);
 static void wdt_gpi_stop(void);
 static void wdt_gpi_set_timeout(unsigned int);
@@ -94,8 +94,28 @@ module_param(nowayout, bool, 0444);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be disabled once started");
 
 
+/* Kernel interfaces */
+static struct file_operations fops = {
+	.owner		= THIS_MODULE,
+	.open		= wdt_gpi_open,
+	.release	= wdt_gpi_release,
+	.write		= wdt_gpi_write,
+	.unlocked_ioctl	= wdt_gpi_ioctl,
+};
+
+static struct miscdevice miscdev = {
+	.minor		= WATCHDOG_MINOR,
+	.name		= wdt_gpi_name,
+	.fops		= &fops,
+};
+
+static struct notifier_block wdt_gpi_shutdown = {
+	.notifier_call	= wdt_gpi_notify,
+};
+
+
 /* Interrupt handler */
-static irqreturn_t wdt_gpi_irqhdl(int irq, void *ctxt, struct pt_regs *regs)
+static irqreturn_t wdt_gpi_irqhdl(int irq, void *ctxt)
 {
 	if (!unlikely(__raw_readl(wd_regs + 0x0008) & 0x1))
 		return IRQ_NONE;
@@ -312,26 +332,6 @@ wdt_gpi_notify(struct notifier_block *th
 }
 
 
-/* Kernel interfaces */
-static struct file_operations fops = {
-	.owner		= THIS_MODULE,
-	.open		= wdt_gpi_open,
-	.release	= wdt_gpi_release,
-	.write		= wdt_gpi_write,
-	.unlocked_ioctl	= wdt_gpi_ioctl,
-};
-
-static struct miscdevice miscdev = {
-	.minor		= WATCHDOG_MINOR,
-	.name		= wdt_gpi_name,
-	.fops		= &fops,
-};
-
-static struct notifier_block wdt_gpi_shutdown = {
-	.notifier_call	= wdt_gpi_notify,
-};
-
-
 /* Init & exit procedures */
 static const struct resource *
 wdt_gpi_get_resource(struct platform_device *pdv, const char *name,
