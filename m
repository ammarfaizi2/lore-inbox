Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTGOGq5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 02:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263952AbTGOGq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 02:46:57 -0400
Received: from [66.212.224.118] ([66.212.224.118]:6414 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S263930AbTGOGqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 02:46:52 -0400
Date: Tue, 15 Jul 2003 02:50:19 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Ion Badulescu <ionut@badula.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Zwane Mwaikambo <zwane@holomorphy.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fix for lockup when using the amd7xx_tco watchdog driver in
 2.4.xx
In-Reply-To: <Pine.LNX.4.44.0307142317240.20400-100000@moisil.badula.org>
Message-ID: <Pine.LNX.4.53.0307150246060.32541@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0307142317240.20400-100000@moisil.badula.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003, Ion Badulescu wrote:

> Hey, whatever works, and thanks a lot for the effort you put into this 
> driver. I'm just surprised I haven't seen any other reports of this, since 
> it locks up so reliably for me on every single Tyan S2468 box I have.

Well not locking up your box is a good start =) The one in 2.4 was ancient 
anyway and Dave Jones had taken a patch to update it a while ago for 2.5. 
The driver will get the timer going but some boxes refuse to do the final 
reboot.

> It should be ok to include this update in 2.4.22, right?

Yes please, i've attached what i tried sending to Alan at some point, but 
your patch is preferred if it's a 2.5 backport.

> > Stuff like EXPORT_NO_SYMBOLS are fine for 2.4.
> 
> True. I missed that -- although it doesn't matter, everything is already 
> marked as static.

Indeed.

Thanks,
	Zwane

Index: linux-2.4.20-rc1-ac4/drivers/char/amd7xx_tco.c
===================================================================
RCS file: /build/cvsroot/linux-2.4.20-rc1-ac4/drivers/char/amd7xx_tco.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 amd7xx_tco.c
--- linux-2.4.20-rc1-ac4/drivers/char/amd7xx_tco.c	18 Nov 2002 01:39:12 -0000	1.1.1.1
+++ linux-2.4.20-rc1-ac4/drivers/char/amd7xx_tco.c	22 Nov 2002 12:53:51 -0000
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
+static char banner[] __initdata = KERN_INFO PFX AMDTCO_MODULE_VER "\n";
 static int timeout = 38;
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
 
@@ -150,10 +157,12 @@
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
@@ -202,7 +211,7 @@
 
 		case WDIOC_GETTIMEOUT:
 			return put_user(amdtco_gettimeout(), (int *)arg);
-	
+		
 		case WDIOC_SETOPTIONS:
 			if (copy_from_user(&tmp, (int *)arg, sizeof tmp))
                                 return -EFAULT;
@@ -225,7 +234,7 @@
 		printk(KERN_INFO PFX "Watchdog disabled\n");
 	} else {
 		amdtco_ping();
-		printk(KERN_CRIT PFX "Unexpected close!, timeout in %d seconds)\n", timeout);
+		printk(KERN_CRIT PFX "Unexpected close!, timeout in %d seconds\n", timeout);
 	}	
 	
 	up(&open_sem);
@@ -253,10 +262,9 @@
 		}
 #endif
 		amdtco_ping();
-		return len;
 	}
 
-	return 0;
+	return len;
 }
 
 
@@ -291,7 +299,6 @@
 };
 
 static struct pci_device_id amdtco_pci_tbl[] __initdata = {
-	/* AMD 766 PCI_IDs here */
 	{ 0x1022, 0x7443, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, }
 };
@@ -361,6 +368,9 @@
 	if (ints[0] > 0)
 		timeout = ints[1];
 
+	if (!timeout || timeout > 38)
+		timeout = MAX_TIMEOUT;
+
 	return 1;
 }
 
@@ -370,7 +380,7 @@
 module_init(amdtco_init);
 module_exit(amdtco_exit);
 
-MODULE_AUTHOR("Zwane Mwaikambo <zwane@commfireservices.com>");
+MODULE_AUTHOR("Zwane Mwaikambo <zwane@holomorphy.com>");
 MODULE_DESCRIPTION("AMD 766/768 TCO Timer Driver");
 MODULE_LICENSE("GPL");
 EXPORT_NO_SYMBOLS;
