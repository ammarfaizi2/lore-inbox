Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270870AbTGNVcp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 17:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270852AbTGNVbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 17:31:47 -0400
Received: from ip64-48-93-2.z93-48-64.customer.algx.net ([64.48.93.2]:58629
	"EHLO ns1.limegroup.com") by vger.kernel.org with ESMTP
	id S270846AbTGNV3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 17:29:41 -0400
Date: Mon, 14 Jul 2003 17:44:00 -0400 (EDT)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@guppy.limebrokerage.com
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Zwane Mwaikambo <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>
Subject: Fix for lockup when using the amd7xx_tco watchdog driver in 2.4.xx
Message-ID: <Pine.LNX.4.44.0307141727510.9118-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

The amd7xx_tco watchdog driver (which only works with AMD 768 south
bridges, despite its description) locks up hard (reset button time) on all
my dual-Athlon machines with Tyan S2468 motherboards, when /dev/watchdog
is opened. Since the AMD 768 SB is only used as part of the AMD 760MPX
chipset on dual-Athlon motherboards, I suspect that this bug makes it
rather useless for everyone...

The patch below, which is essentially a diff between amd7xx_tco.c in
2.4.21 and 2.5.75, fixes the problem and allows the opening of
/dev/watchdog without those annoying lockups. I suspect (but I haven't
tested) that the real fix is in this small portion of the patch:

+       amdtco_disable();
        amdtco_settimeout(timeout);
        amdtco_global_enable();
+       amdtco_enable();

but the rest of the patch looks good so we might as well bring the 2.4 and 
2.5 versions of the driver in sync.

Please apply.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

--------------------------------------------
--- linux-2.4.21/drivers/char/amd7xx_tco.c	Wed Jan  8 14:39:28 2003
+++ linux-2.4.21/drivers/char/amd7xx_tco.c	Thu Jul 10 16:06:03 2003
@@ -1,6 +1,6 @@
 /*
  *	AMD 766/768 TCO Timer Driver
- *	(c) Copyright 2002 Zwane Mwaikambo <zwane@commfireservices.com>
+ *	(c) Copyright 2002 Zwane Mwaikambo <zwane@holomorphy.com>
  *	All Rights Reserved.
  *
  *	Parts from;
@@ -34,35 +34,48 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 
-#define AMDTCO_MODULE_VER	"build 20020601"
+#define AMDTCO_MODULE_VER	"build 20021116"
 #define AMDTCO_MODULE_NAME	"amd7xx_tco"
 #define PFX			AMDTCO_MODULE_NAME ": "
 
-#define	MAX_TIMEOUT	38	/* max of 38 seconds */
+#define	MAX_TIMEOUT	38	/* max of 38 seconds, although the system will only
+				 * reset itself after the second timeout */
 
 /* pmbase registers */
-#define GLOBAL_SMI_REG	0x2a
-#define TCO_EN		(1 << 1)	/* bit 1 in global SMI register */
 #define TCO_RELOAD_REG	0x40		/* bits 0-5 are current count, 6-7 are reserved */
 #define TCO_INITVAL_REG	0x41		/* bits 0-5 are value to load, 6-7 are reserved */
 #define TCO_TIMEOUT_MASK	0x3f
+#define TCO_STATUS1_REG 0x44
 #define TCO_STATUS2_REG	0x46
 #define NDTO_STS2	(1 << 1)	/* we're interested in the second timeout */ 
 #define BOOT_STS	(1 << 2)	/* will be set if NDTO_STS2 was set before reboot */
 #define TCO_CTRL1_REG	0x48
 #define TCO_HALT	(1 << 11)
+#define NO_REBOOT	(1 << 10)	/* in DevB:3x48 */
 
-static char banner[] __initdata = KERN_INFO PFX AMDTCO_MODULE_VER;
-static int timeout = 38;
+static char banner[] __initdata = KERN_INFO PFX AMDTCO_MODULE_VER "\n";
+static int timeout = MAX_TIMEOUT;
 static u32 pmbase;		/* PMxx I/O base */
 static struct pci_dev *dev;
 static struct semaphore open_sem;
-spinlock_t amdtco_lock;	/* only for device access */
+static spinlock_t amdtco_lock;	/* only for device access */
 static int expect_close = 0;
 
 MODULE_PARM(timeout, "i");
 MODULE_PARM_DESC(timeout, "range is 0-38 seconds, default is 38");
 
+static inline u8 seconds_to_ticks(int seconds)
+{
+	/* the internal timer is stored as ticks which decrement
+	 * every 0.6 seconds */
+	return (seconds * 10) / 6;
+}
+
+static inline int ticks_to_seconds(u8 ticks)
+{
+	return (ticks * 6) / 10;
+}
+
 static inline int amdtco_status(void)
 {
 	u16 reg;
@@ -81,28 +94,19 @@
 
 static inline void amdtco_ping(void)
 {
-	u8 reg;
-
-	spin_lock(&amdtco_lock);
-	reg = inb(pmbase+TCO_RELOAD_REG);
-	outb(1 | reg, pmbase+TCO_RELOAD_REG);
-	spin_unlock(&amdtco_lock);
+	outb(1, pmbase+TCO_RELOAD_REG);
 }
 
 static inline int amdtco_gettimeout(void)
 {
-	return inb(TCO_RELOAD_REG) & TCO_TIMEOUT_MASK;
+	u8 reg = inb(pmbase+TCO_RELOAD_REG) & TCO_TIMEOUT_MASK;
+	return ticks_to_seconds(reg);
 }
 
 static inline void amdtco_settimeout(unsigned int timeout)
 {
-	u8 reg;
-
-	spin_lock(&amdtco_lock);
-	reg = inb(pmbase+TCO_INITVAL_REG);
-	reg |= timeout & TCO_TIMEOUT_MASK;
+	u8 reg = seconds_to_ticks(timeout) & TCO_TIMEOUT_MASK;
 	outb(reg, pmbase+TCO_INITVAL_REG);
-	spin_unlock(&amdtco_lock);
 }
 
 static inline void amdtco_global_enable(void)
@@ -110,9 +114,12 @@
 	u16 reg;
 
 	spin_lock(&amdtco_lock);
-	reg = inw(pmbase+GLOBAL_SMI_REG);
-	reg |= TCO_EN;
-	outw(reg, pmbase+GLOBAL_SMI_REG);
+
+	/* clear NO_REBOOT on DevB:3x48 p97 */
+	pci_read_config_word(dev, 0x48, &reg);
+	reg &= ~NO_REBOOT;
+	pci_write_config_word(dev, 0x48, reg);
+
 	spin_unlock(&amdtco_lock);
 }
 
@@ -143,17 +150,15 @@
 	if (down_trylock(&open_sem))
 		return -EBUSY;
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT	
-	MOD_INC_USE_COUNT;
-#endif
-
 	if (timeout > MAX_TIMEOUT)
 		timeout = MAX_TIMEOUT;
 
+	amdtco_disable();
 	amdtco_settimeout(timeout);	
 	amdtco_global_enable();
+	amdtco_enable();
 	amdtco_ping();
-	printk(KERN_INFO PFX "Watchdog enabled, timeout = %d/%d seconds",
+	printk(KERN_INFO PFX "Watchdog enabled, timeout = %ds of %ds\n",
 		amdtco_gettimeout(), timeout);
 	
 	return 0;
@@ -166,8 +171,8 @@
 	int tmp;
 
 	static struct watchdog_info ident = {
-		options:	WDIOF_SETTIMEOUT | WDIOF_CARDRESET,
-		identity:	"AMD 766/768"
+		.options	= WDIOF_SETTIMEOUT | WDIOF_CARDRESET,
+		.identity	= "AMD 766/768"
 	};
 
 	switch (cmd) {
@@ -202,7 +207,7 @@
 
 		case WDIOC_GETTIMEOUT:
 			return put_user(amdtco_gettimeout(), (int *)arg);
-	
+		
 		case WDIOC_SETOPTIONS:
 			if (copy_from_user(&tmp, (int *)arg, sizeof tmp))
                                 return -EFAULT;
@@ -225,7 +230,7 @@
 		printk(KERN_INFO PFX "Watchdog disabled\n");
 	} else {
 		amdtco_ping();
-		printk(KERN_CRIT PFX "Unexpected close!, timeout in %d seconds)\n", timeout);
+		printk(KERN_CRIT PFX "Unexpected close!, timeout in %d seconds\n", timeout);
 	}	
 	
 	up(&open_sem);
@@ -253,10 +258,9 @@
 		}
 #endif
 		amdtco_ping();
-		return len;
 	}
 
-	return 0;
+	return len;
 }
 
 
@@ -271,28 +275,28 @@
 
 static struct notifier_block amdtco_notifier =
 {
-	notifier_call:	amdtco_notify_sys
+	.notifier_call = amdtco_notify_sys
 };
 
 static struct file_operations amdtco_fops =
 {
-	owner:		THIS_MODULE,
-	write:		amdtco_fop_write,
-	ioctl:		amdtco_fop_ioctl,
-	open:		amdtco_fop_open,
-	release:	amdtco_fop_release
+	.owner		= THIS_MODULE,
+	.write		= amdtco_fop_write,
+	.ioctl		= amdtco_fop_ioctl,
+	.open		= amdtco_fop_open,
+	.release	= amdtco_fop_release
 };
 
 static struct miscdevice amdtco_miscdev =
 {
-	minor:		WATCHDOG_MINOR,
-	name:		"watchdog",
-	fops:		&amdtco_fops
+	.minor	= WATCHDOG_MINOR,
+	.name	= "watchdog",
+	.fops	= &amdtco_fops
 };
 
 static struct pci_device_id amdtco_pci_tbl[] __initdata = {
 	/* AMD 766 PCI_IDs here */
-	{ 0x1022, 0x7443, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_OPUS_7443, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, }
 };
 
@@ -305,7 +309,8 @@
 	sema_init(&open_sem, 1);
 	spin_lock_init(&amdtco_lock);
 
-	pci_for_each_dev(dev) {
+	dev = NULL;
+	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		if (pci_match_device (amdtco_pci_tbl, dev) != NULL)
 			goto found_one;
 	}
@@ -361,6 +366,9 @@
 	if (ints[0] > 0)
 		timeout = ints[1];
 
+	if (!timeout || timeout > MAX_TIMEOUT)
+		timeout = MAX_TIMEOUT;
+
 	return 1;
 }
 
@@ -370,8 +378,7 @@
 module_init(amdtco_init);
 module_exit(amdtco_exit);
 
-MODULE_AUTHOR("Zwane Mwaikambo <zwane@commfireservices.com>");
+MODULE_AUTHOR("Zwane Mwaikambo <zwane@holomorphy.com>");
 MODULE_DESCRIPTION("AMD 766/768 TCO Timer Driver");
 MODULE_LICENSE("GPL");
-EXPORT_NO_SYMBOLS;
 


