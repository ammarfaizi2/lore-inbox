Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129741AbQLTQbw>; Wed, 20 Dec 2000 11:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129846AbQLTQbn>; Wed, 20 Dec 2000 11:31:43 -0500
Received: from jalon.able.es ([212.97.163.2]:25507 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129741AbQLTQba>;
	Wed, 20 Dec 2000 11:31:30 -0500
Date: Wed, 20 Dec 2000 17:00:53 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Donald Becker <becker@scyld.com>
Subject: [PATCH] ne2k-pci
Message-ID: <20001220170053.A4716@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry if this message is dup. I sent it to the list but did not see it,
so I think this was a problem with my mailer or ISP]

This is a port of the new 1.02 features of the ne2k-pci driver to kernel
2.2.18. Reviewed by Donald Becker, and tested on 2.2.18, 19-pre1 and pre2.
New features:
- module info
- full duplex support in RealTek and Holtek cards. Must be activated
  on module load with full_duplex=1, (up to 6 cards).

The patch does not use the pci stuff that D.Becker included in the scyld
drivers ===> Question: is there any similar pci stuff in 2.2.18 and
a driver to look at its use ?

Thanks.ñ

==================== patch-ne2k-pci
--- linux/drivers/net/ne2k-pci.c.org	Sun Dec 17 01:51:04 2000
+++ linux/drivers/net/ne2k-pci.c	Tue Dec 19 01:48:00 2000
@@ -12,19 +12,31 @@
 	This software may be used and distributed according to the terms
 	of the GNU Public License, incorporated herein by reference.
 
-	The author may be reached as becker@CESDIS.gsfc.nasa.gov, or C/O
-	Center of Excellence in Space Data and Information Sciences
-	Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+	Drivers based on or derived from this code fall under the GPL and must
+	retain the authorship, copyright and license notice.  This file is not
+	a complete program and may only be used when the entire operating
+	system is licensed under the GPL.
+
+	The author may be reached as becker@scyld.com, or C/O
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
+	Annapolis MD 21403
 
+	Issues remaining:
 	People are making PCI ne2000 clones! Oh the horror, the horror...
+	Limited full-duplex support.
 
-	Issues remaining:
-	No full-duplex support.
+	ChangeLog:
+
+	12/15/2000 Merged Scyld v1.02 into 2.2.18
+									J.A. Magallon <jamagallon@able.es>
 */
 
-/* Our copyright info must remain in the binary. */
-static const char *version =
-"ne2k-pci.c:vpre-1.00e 5/27/99 D. Becker/P. Gortmaker
http://cesdis.gsfc.nasa.gov/linux/drivers/ne2k-pci.html\n";
+/* These identify the driver base version and may not be removed. */
+static const char version1[] =
+"ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker\n";
+static const char version2[] =
+"  http://www.scyld.com/network/ne2k-pci.html\n";
 
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -49,7 +61,18 @@
 #endif
 
 /* Set statically or when loading the driver module. */
-static int debug = 1;
+static int debug = 1; /* 1 normal messages, 0 quiet .. 7 verbose. */
+/* More are supported, limit only on options */
+#define MAX_UNITS 6
+/* Used to pass the full-duplex flag, etc. */
+static int full_duplex[MAX_UNITS] = {0, };
+static int options[MAX_UNITS] = {0, };
+
+MODULE_AUTHOR("Donald Becker / Paul Gortmaker");
+MODULE_DESCRIPTION("PCI NE2000 clone driver");
+MODULE_PARM(debug, "i");
+MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
+MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
 
 /* Some defines that people can play with if so inclined. */
 
@@ -62,12 +85,13 @@
 /* Do we have a non std. amount of memory? (in units of 256 byte pages) */
 /* #define PACKETBUF_MEMSIZE	0x40 */
 
-#define ne2k_flags reg0			/* Rename an existing field to
store flags! */
-
-/* Only the low 8 bits are usable for non-init-time flags! */
+/* Flags.  We rename an existing ei_status field to store flags! */
+/* Thus only the low 8 bits are usable for non-init-time flags. */
+#define ne2k_flags reg0
 enum {
-	HOLTEK_FDX=1, 		/* Full duplex -> set 0x80 at offset
0x20. */
-	ONLY_16BIT_IO=2, ONLY_32BIT_IO=4,	/* Chip can do only 16/32-bit
xfers. */
+	ONLY_16BIT_IO=8, ONLY_32BIT_IO=4,   /* Chip can do only 16/32-bit
xfers. */
+	FORCE_FDX=0x20,                     /* User override. */
+	REALTEK_FDX=0x40, HOLTEK_FDX=0x80,
 	STOP_PG_0x60=0x100,
 };
 
@@ -79,18 +103,17 @@
 	int flags;
 }
 pci_clone_list[] __initdata = {
-	{0x10ec, 0x8029, "RealTek RTL-8029", 0},
-	{0x1050, 0x0940, "Winbond 89C940", 0},
-	{0x11f6, 0x1401, "Compex RL2000", 0},
-	{0x8e2e, 0x3000, "KTI ET32P2", 0},
-	{0x4a14, 0x5000, "NetVin NV5000SC", 0},
-	{0x1106, 0x0926, "Via 86C926", ONLY_16BIT_IO},
-	{0x10bd, 0x0e34, "SureCom NE34", 0},
-	{0x1050, 0x5a5a, "Winbond", 0},
-	{0x12c3, 0x0058, "Holtek HT80232", ONLY_16BIT_IO | HOLTEK_FDX},
-	{0x12c3, 0x5598, "Holtek HT80229",
-	 ONLY_32BIT_IO | HOLTEK_FDX | STOP_PG_0x60 },
-	{0,}
+{0x10ec, 0x8029, "RealTek RTL-8029", REALTEK_FDX},
+{0x1050, 0x0940, "Winbond 89C940", 0},
+{0x1050, 0x5a5a, "Winbond w89c940", 0},
+{0x8e2e, 0x3000, "KTI ET32P2", 0},
+{0x4a14, 0x5000, "NetVin NV5000SC", 0},
+{0x1106, 0x0926, "Via 86C926", ONLY_16BIT_IO},
+{0x10bd, 0x0e34, "SureCom NE34", 0},
+{0x12c3, 0x0058, "Holtek HT80232", ONLY_16BIT_IO|HOLTEK_FDX},
+{0x12c3, 0x5598, "Holtek HT80229", ONLY_32BIT_IO|HOLTEK_FDX|STOP_PG_0x60 },
+{0x11f6, 0x1401, "Compex RL2000", 0},
+{0,}
 };
 
 /* ---- No user-serviceable parts below ---- */
@@ -119,7 +142,7 @@
 static void ne2k_pci_block_output(struct device *dev, const int count,
 		const unsigned char *buf, const int start_page);
 
-
+
 
 /* No room in the standard 8390 structure for extra info we need. */
 struct ne2k_pci_card {
@@ -137,7 +160,7 @@
 {
 	/* We must emit version information. */
 	if (debug)
-		printk(KERN_INFO "%s", version);
+		printk(KERN_INFO "%s" KERN_INFO "%s", version1, version2);
 
 	if (ne2k_pci_probe(0)) {
 		printk(KERN_NOTICE "ne2k-pci.c: No useable cards found, driver
NOT installed.\n");
@@ -220,7 +243,7 @@
 		{
 			static unsigned version_printed = 0;
 			if (version_printed++ == 0)
-				printk(KERN_INFO "%s", version);
+				printk(KERN_INFO "%s" KERN_INFO "%s", version1,
version2);
 		}
 #endif
 
@@ -263,8 +286,8 @@
 	return cards_found ? 0 : -ENODEV;
 }
 
-__initfunc (static struct device *ne2k_pci_probe1(struct device *dev, long
ioaddr, int irq,
-									  int chip_idx))
+__initfunc (static struct device *ne2k_pci_probe1(struct device *dev,
+			long ioaddr, int irq, int chip_idx))
 {
 	int i;
 	unsigned char SA_prom[32];
@@ -291,6 +314,8 @@
 
 	dev = init_etherdev(dev, 0);
 
+	if (!dev) return 0;
+
 	/* Reset card. Who knows what dain-bramaged state it was left in. */
 	{
 		unsigned long reset_start_time = jiffies;
@@ -342,7 +367,7 @@
 	/* Note: all PCI cards have at least 16 bit access, so we don't have
 	   to check for 8 bit cards.  Most cards permit 32 bit access. */
 	if (pci_clone_list[chip_idx].flags & ONLY_32BIT_IO) {
-		for (i = 0; i < 4 ; i++)
+		for (i = 0; i < 8 ; i++)
 			((u32 *)SA_prom)[i] = le32_to_cpu(inl(ioaddr +
NE_DATAPORT));
 	} else
 		for(i = 0; i < 32 /*sizeof(SA_prom)*/; i++)
@@ -379,6 +404,10 @@
 	ei_status.stop_page = stop_page;
 	ei_status.word16 = 1;
 	ei_status.ne2k_flags = pci_clone_list[chip_idx].flags;
+	if (chip_idx < MAX_UNITS) {
+		if (full_duplex[chip_idx]  ||  (options[chip_idx] & FORCE_FDX))
+			ei_status.ne2k_flags |= FORCE_FDX;
+	}
 
 	ei_status.rx_start_page = start_page + TX_PAGES;
 #ifdef PACKETBUF_MEMSIZE
@@ -401,8 +430,17 @@
 {
 	if (request_irq(dev->irq, ei_interrupt, SA_SHIRQ, dev->name, dev))
 		return -EAGAIN;
-	ei_open(dev);
 	MOD_INC_USE_COUNT;
+	/* Set full duplex for the chips that we know about. */
+	if (ei_status.ne2k_flags & FORCE_FDX) {
+		long ioaddr = dev->base_addr;
+		if (ei_status.ne2k_flags & REALTEK_FDX) {
+			outb(0xC0 + E8390_NODMA, ioaddr + NE_CMD); /* Page 3 */
+			outb(inb(ioaddr + 0x20) | 0x80, ioaddr + 0x20);
+		} else if (ei_status.ne2k_flags & HOLTEK_FDX)
+			outb(inb(ioaddr + 0x20) | 0x80, ioaddr + 0x20);
+	}
+	ei_open(dev);
 	return 0;
 }
 

==================== patch-ne2k-pci

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux werewolf 2.2.19-pre2 #2 SMP Sun Dec 17 00:51:15 CET 2000 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
