Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbVANUUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVANUUV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 15:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVANURE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 15:17:04 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:6642 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262043AbVANUOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:14:19 -0500
Date: Fri, 14 Jan 2005 12:14:05 -0800
From: Dave Jiang <dave.jiang@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux@arm.linux.org.uk, smaurer@teja.com, dsaxena@plexity.net,
       drew.moseley@intel.com, mporter@kernel.crashing.org, greg@kroah.com
Subject: [PATCH 4/5] resource: arm arch updates for u64 resource
Message-ID: <20050114201405.GB19681@plexity.net>
Reply-To: dave.jiang@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Corp.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ARM arch changes for converting resources to u64 from unsigned long. 

Signed-off-by: Dave Jiang <dave.jiang@gmail.com>


diff -Naur linux-2.6.11-rc1/arch/arm/kernel/bios32.c linux-2.6.11-rc1-u64/arch/arm/kernel/bios32.c
--- linux-2.6.11-rc1/arch/arm/kernel/bios32.c	2004-12-24 14:34:31.000000000 -0700
+++ linux-2.6.11-rc1-u64/arch/arm/kernel/bios32.c	2005-01-13 11:45:41.829462928 -0700
@@ -304,7 +304,7 @@
 static void __devinit
 pdev_fixup_device_resources(struct pci_sys_data *root, struct pci_dev *dev)
 {
-	unsigned long offset;
+	u64 offset;
 	int i;
 
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
@@ -619,9 +619,9 @@
  * which might be mirrored at 0x0100-0x03ff..
  */
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    u64 size, u64 align)
 {
-	unsigned long start = res->start;
+	u64 start = res->start;
 
 	if (res->flags & IORESOURCE_IO && start & 0x300)
 		start = (start + 0x3ff) & ~0x3ff;
diff -Naur linux-2.6.11-rc1/arch/arm/kernel/setup.c linux-2.6.11-rc1-u64/arch/arm/kernel/setup.c
--- linux-2.6.11-rc1/arch/arm/kernel/setup.c	2005-01-13 14:39:40.197589768 -0700
+++ linux-2.6.11-rc1-u64/arch/arm/kernel/setup.c	2005-01-13 11:45:41.830462776 -0700
@@ -115,9 +115,23 @@
  * Standard memory resources
  */
 static struct resource mem_res[] = {
-	{ "Video RAM",   0,     0,     IORESOURCE_MEM			},
-	{ "Kernel text", 0,     0,     IORESOURCE_MEM			},
-	{ "Kernel data", 0,     0,     IORESOURCE_MEM			}
+	{ 
+		.name = "Video RAM",   
+		.start = 0,     
+		.end = 0,     
+		.flags = IORESOURCE_MEM			
+	},
+	{ 
+		.name = "Kernel text", 
+		.start = 0,     
+		.end = 0,     
+		.flags = IORESOURCE_MEM			
+	},
+	{ 
+		.name = "Kernel data", 
+		.start = 0,     
+		.end = 0,     
+		.flags = IORESOURCE_MEM			}
 };
 
 #define video_ram   mem_res[0]
@@ -125,9 +139,24 @@
 #define kernel_data mem_res[2]
 
 static struct resource io_res[] = {
-	{ "reserved",    0x3bc, 0x3be, IORESOURCE_IO | IORESOURCE_BUSY },
-	{ "reserved",    0x378, 0x37f, IORESOURCE_IO | IORESOURCE_BUSY },
-	{ "reserved",    0x278, 0x27f, IORESOURCE_IO | IORESOURCE_BUSY }
+	{ 
+		.name = "reserved",    
+		.start = 0x3bc, 
+		.end = 0x3be, 
+		.flags = IORESOURCE_IO | IORESOURCE_BUSY 
+	},
+	{ 
+		.name = "reserved",    
+		.start = 0x378, 
+		.end = 0x37f, 
+		.flags = IORESOURCE_IO | IORESOURCE_BUSY 
+	},
+	{ 
+		.name = "reserved",    
+		.start = 0x278, 
+		.end = 0x27f, 
+		.flags = IORESOURCE_IO | IORESOURCE_BUSY 
+	}
 };
 
 #define lp0 io_res[0]

diff -Naur linux-2.6.11-rc1/include/asm-arm/mach/pci.h linux-2.6.11-rc1-u64/include/asm-arm/mach/pci.h
--- linux-2.6.11-rc1/include/asm-arm/mach/pci.h	2004-12-24 14:34:45.000000000 -0700
+++ linux-2.6.11-rc1-u64/include/asm-arm/mach/pci.h	2005-01-13 11:45:41.843460800 -0700
@@ -28,7 +28,7 @@
 struct pci_sys_data {
 	struct list_head node;
 	int		busnr;		/* primary bus number			*/
-	unsigned long	mem_offset;	/* bus->cpu memory mapping offset	*/
+	u64		mem_offset;	/* bus->cpu memory mapping offset	*/
 	unsigned long	io_offset;	/* bus->cpu IO mapping offset		*/
 	struct pci_bus	*bus;		/* PCI bus				*/
 	struct resource *resource[3];	/* Primary PCI bus resources		*/
