Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbTCEJle>; Wed, 5 Mar 2003 04:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbTCEJle>; Wed, 5 Mar 2003 04:41:34 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:24339
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262038AbTCEJla>; Wed, 5 Mar 2003 04:41:30 -0500
Date: Wed, 5 Mar 2003 04:49:55 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Dave Jones <davej@suse.de>
Subject: [PATCH][2.5] Small amd7xx_tco update
Message-ID: <Pine.LNX.4.50.0303050447100.1110-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,
	Thanks for merging the whole lot into 2.5, would it be ok for me 
to send this through you?

Regards,
	Zwane

Index: linux-2.5.64/drivers/char/watchdog/amd7xx_tco.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/drivers/char/watchdog/amd7xx_tco.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 amd7xx_tco.c
--- linux-2.5.64/drivers/char/watchdog/amd7xx_tco.c	5 Mar 2003 05:07:40 -0000	1.1.1.1
+++ linux-2.5.64/drivers/char/watchdog/amd7xx_tco.c	5 Mar 2003 09:13:31 -0000
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
 
@@ -146,10 +153,12 @@
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
@@ -198,7 +207,7 @@
 
 		case WDIOC_GETTIMEOUT:
 			return put_user(amdtco_gettimeout(), (int *)arg);
-	
+		
 		case WDIOC_SETOPTIONS:
 			if (copy_from_user(&tmp, (int *)arg, sizeof tmp))
                                 return -EFAULT;
@@ -221,7 +230,7 @@
 		printk(KERN_INFO PFX "Watchdog disabled\n");
 	} else {
 		amdtco_ping();
-		printk(KERN_CRIT PFX "Unexpected close!, timeout in %d seconds)\n", timeout);
+		printk(KERN_CRIT PFX "Unexpected close!, timeout in %d seconds\n", timeout);
 	}	
 	
 	up(&open_sem);
@@ -249,10 +258,9 @@
 		}
 #endif
 		amdtco_ping();
-		return len;
 	}
 
-	return 0;
+	return len;
 }
 
 
@@ -357,6 +365,9 @@
 	if (ints[0] > 0)
 		timeout = ints[1];
 
+	if (!timeout || timeout > MAX_TIMEOUT)
+		timeout = MAX_TIMEOUT;
+
 	return 1;
 }
 
@@ -366,7 +377,7 @@
 module_init(amdtco_init);
 module_exit(amdtco_exit);
 
-MODULE_AUTHOR("Zwane Mwaikambo <zwane@commfireservices.com>");
+MODULE_AUTHOR("Zwane Mwaikambo <zwane@holomorphy.com>");
 MODULE_DESCRIPTION("AMD 766/768 TCO Timer Driver");
 MODULE_LICENSE("GPL");
 EXPORT_NO_SYMBOLS;
