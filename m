Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136664AbREGUsY>; Mon, 7 May 2001 16:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136665AbREGUsO>; Mon, 7 May 2001 16:48:14 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:11152 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S136664AbREGUsC>;
	Mon, 7 May 2001 16:48:02 -0400
Message-ID: <3AF709F1.D9EDFFBD@mandrakesoft.com>
Date: Mon, 07 May 2001 16:47:45 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PATCH 2.4.5.1: 8139too net drvr fix
Content-Type: multipart/mixed;
 boundary="------------7D82F6FCAC627ADBA114B75B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7D82F6FCAC627ADBA114B75B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The attached patch, against 2.4.5-pre1, fixes a chipset wakeup bug which
occurred on a popular 8139 chip.
-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
--------------7D82F6FCAC627ADBA114B75B
Content-Type: text/plain; charset=us-ascii;
 name="8139too-2.4.5.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8139too-2.4.5.1.patch"

Index: linux_2_4/drivers/net/8139too.c
diff -u linux_2_4/drivers/net/8139too.c:1.1.1.34 linux_2_4/drivers/net/8139too.c:1.1.1.34.24.2
--- linux_2_4/drivers/net/8139too.c:1.1.1.34	Thu Apr 19 03:07:47 2001
+++ linux_2_4/drivers/net/8139too.c	Mon May  7 13:44:15 2001
@@ -149,7 +149,7 @@
 #include <asm/io.h>
 
 
-#define RTL8139_VERSION "0.9.16"
+#define RTL8139_VERSION "0.9.17"
 #define MODNAME "8139too"
 #define RTL8139_DRIVER_NAME   MODNAME " Fast Ethernet driver " RTL8139_VERSION
 #define PFX MODNAME ": "
@@ -728,7 +728,7 @@
 	struct rtl8139_private *tp;
 	u8 tmp8;
 	int rc;
-	unsigned int i, have_pci_pm = 1;
+	unsigned int i;
 	u32 pio_start, pio_end, pio_flags, pio_len;
 	unsigned long mmio_start, mmio_end, mmio_flags, mmio_len;
 	u32 tmp;
@@ -770,10 +770,6 @@
 	DPRINTK("PIO region size == 0x%02X\n", pio_len);
 	DPRINTK("MMIO region size == 0x%02lX\n", mmio_len);
 
-	/* ugly hueristic, but it's a chicken-and-egg problem */
-	if (pio_len < RTL8139B_IO_SIZE)
-		have_pci_pm = 0;
-	
 #ifdef USE_IO_OPS
 	/* make sure PCI base addr 0 is PIO */
 	if (!(pio_flags & IORESOURCE_IO)) {
@@ -824,30 +820,7 @@
 #endif /* USE_IO_OPS */
 
 	/* Bring old chips out of low-power mode. */
-	if (have_pci_pm) {
-		u8 new_tmp8 = tmp8 = RTL_R8 (Config1);
-		if ((rtl_chip_info[tp->chipset].flags & HasLWake) &&
-		    (tmp8 & LWAKE))
-			new_tmp8 &= ~LWAKE;
-		new_tmp8 |= Cfg1_PM_Enable;
-		if (new_tmp8 != tmp8) {
-			RTL_W8 (Cfg9346, Cfg9346_Unlock);
-			RTL_W8 (Config1, tmp8);
-			RTL_W8 (Cfg9346, Cfg9346_Lock);
-		}
-		if (rtl_chip_info[tp->chipset].flags & HasLWake) {
-			tmp8 = RTL_R8 (Config4);
-			if (tmp8 & LWPTN)
-				RTL_W8 (Config4, tmp8 & ~LWPTN);
-		}
-	} else {
-		RTL_W8 (HltClk, 'R');
-		tmp8 = RTL_R8 (Config1);
-		tmp8 &= ~(SLEEP | PWRDN);
-		RTL_W8 (Config1, tmp8);
-	}
-
-	rtl8139_chip_reset (ioaddr);
+	RTL_W8 (HltClk, 'R');
 
 	/* check for missing/broken hardware */
 	if (RTL_R32 (TxConfig) == 0xFFFFFFFF) {
@@ -877,6 +850,32 @@
 		tp->chipset,
 		rtl_chip_info[tp->chipset].name);
 
+	if (tp->chipset >= CH_8139B) {
+		u8 new_tmp8 = tmp8 = RTL_R8 (Config1);
+		DPRINTK("PCI PM wakeup\n");
+		if ((rtl_chip_info[tp->chipset].flags & HasLWake) &&
+		    (tmp8 & LWAKE))
+			new_tmp8 &= ~LWAKE;
+		new_tmp8 |= Cfg1_PM_Enable;
+		if (new_tmp8 != tmp8) {
+			RTL_W8 (Cfg9346, Cfg9346_Unlock);
+			RTL_W8 (Config1, tmp8);
+			RTL_W8 (Cfg9346, Cfg9346_Lock);
+		}
+		if (rtl_chip_info[tp->chipset].flags & HasLWake) {
+			tmp8 = RTL_R8 (Config4);
+			if (tmp8 & LWPTN)
+				RTL_W8 (Config4, tmp8 & ~LWPTN);
+		}
+	} else {
+		DPRINTK("Old chip wakeup\n");
+		tmp8 = RTL_R8 (Config1);
+		tmp8 &= ~(SLEEP | PWRDN);
+		RTL_W8 (Config1, tmp8);
+	}
+
+	rtl8139_chip_reset (ioaddr);
+
 	DPRINTK ("EXIT, returning 0\n");
 	*dev_out = dev;
 	return 0;
@@ -1358,11 +1357,16 @@
 		else if ((mii_reg5 & 0x0100) == 0x0100
 				 || (mii_reg5 & 0x00C0) == 0x0040)
 			tp->full_duplex = 1;
-		printk(KERN_INFO"%s: Setting %s%s-duplex based on"
+		if (mii_reg5) {
+			printk(KERN_INFO"%s: Setting %s%s-duplex based on"
 			   " auto-negotiated partner ability %4.4x.\n", dev->name,
 			   mii_reg5 == 0 ? "" :
 			   (mii_reg5 & 0x0180) ? "100mbps " : "10mbps ",
 			   tp->full_duplex ? "full" : "half", mii_reg5);
+		} else {
+			printk(KERN_INFO"%s: media is unconnected, link down, or incompatible connection\n",
+			       dev->name);
+		}
 	}
 
 	if (tp->chipset >= CH_8139B) {
@@ -1542,11 +1546,18 @@
 		    || (mii_reg5 & 0x01C0) == 0x0040;
 		if (tp->full_duplex != duplex) {
 			tp->full_duplex = duplex;
-			printk (KERN_INFO
-				"%s: Setting %s-duplex based on MII #%d link"
-				" partner ability of %4.4x.\n", dev->name,
-				tp->full_duplex ? "full" : "half",
-				tp->phys[0], mii_reg5);
+
+			if (mii_reg5) {
+				printk (KERN_INFO
+					"%s: Setting %s-duplex based on MII #%d link"
+					" partner ability of %4.4x.\n",
+					dev->name,
+					tp->full_duplex ? "full" : "half",
+					tp->phys[0], mii_reg5);
+			} else {
+				printk(KERN_INFO"%s: media is unconnected, link down, or incompatible connection\n",
+				       dev->name);
+			}
 #if 0
 			RTL_W8 (Cfg9346, Cfg9346_Unlock);
 			RTL_W8 (Config1, tp->full_duplex ? 0x60 : 0x20);
Index: linux_2_4/Documentation/networking/8139too.txt
diff -u linux_2_4/Documentation/networking/8139too.txt:1.1.1.19 linux_2_4/Documentation/networking/8139too.txt:1.1.1.19.20.1
--- linux_2_4/Documentation/networking/8139too.txt:1.1.1.19	Thu Apr 19 18:09:50 2001
+++ linux_2_4/Documentation/networking/8139too.txt	Mon May  7 13:44:15 2001
@@ -185,6 +185,13 @@
 Change History
 --------------
 
+Version 0.9.17 - May 7, 2001
+
+* Fix chipset wakeup bug which prevent media connection for 8139B
+* Print out "media is unconnected..." instead of 
+  "partner ability 0000"
+
+
 Version 0.9.16 - April 14, 2001
 
 * Complete MMIO audit, disable read-after-every-write

--------------7D82F6FCAC627ADBA114B75B--

