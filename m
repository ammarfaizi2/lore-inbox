Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932688AbWFMAd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688AbWFMAd4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 20:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbWFMAdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 20:33:55 -0400
Received: from mail.suse.de ([195.135.220.2]:41678 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932688AbWFMAdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 20:33:54 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 01/16] 64bit resource: C99 changes for struct resource declarations
Reply-To: Greg KH <greg@kroah.com>
Date: Mon, 12 Jun 2006 17:31:03 -0700
Message-Id: <11501586781628-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <20060613003033.GA10717@kroah.com>
References: <20060613003033.GA10717@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Based on an original patch from Ralf Baechle <ralf@linux-mips.org> and
Vivek Goyal <vgoyal@in.ibm.com>.  This is needed in order to prepare for
changing the size of resources.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/arm/kernel/setup.c                     |   42 ++++++++-
 arch/mips/au1000/common/pci.c               |   16 ++-
 arch/mips/cobalt/setup.c                    |   41 +++++++--
 arch/mips/ddb5xxx/ddb5476/setup.c           |   37 +++++++-
 arch/mips/ite-boards/generic/it8172_setup.c |   74 +++++++++++++---
 arch/mips/jmr3927/rbhma3100/setup.c         |   59 ++++++++++---
 arch/mips/pci/ops-it8172.c                  |   34 +++----
 arch/mips/pci/pci-ddb5074.c                 |   16 ++-
 arch/mips/pci/pci-ddb5476.c                 |   16 ++-
 arch/mips/pci/pci-ddb5477.c                 |   32 +++----
 arch/mips/pci/pci-jmr3927.c                 |   16 ++-
 arch/mips/pci/pci-ocelot.c                  |    8 +-
 arch/mips/pci/pci-yosemite.c                |   10 ++
 arch/mips/philips/pnx8550/common/pci.c      |   16 ++-
 arch/mips/philips/pnx8550/common/setup.c    |   25 +++++
 arch/mips/sni/setup.c                       |  126 +++++++++++++++++++++++----
 arch/mips/tx4938/toshiba_rbtx4938/setup.c   |    5 +
 17 files changed, 424 insertions(+), 149 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index d5a04b6..7b2d9b7 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -389,7 +389,7 @@ #endif
 		vga_video_port_val = VGA_CRT_DM;
 		if ((ORIG_VIDEO_EGA_BX & 0xff) != 0x10) {
 			static struct resource ega_console_resource =
-			    { "ega", 0x3B0, 0x3BF };
+			    { .name = "ega", .start = 0x3B0, .end = 0x3BF };
 			vga_video_type = VIDEO_TYPE_EGAM;
 			vga_vram_end = 0xb8000;
 			display_desc = "EGA+";
@@ -397,9 +397,9 @@ #endif
 					 &ega_console_resource);
 		} else {
 			static struct resource mda1_console_resource =
-			    { "mda", 0x3B0, 0x3BB };
+			    { .name = "mda", .start = 0x3B0, .end = 0x3BB };
 			static struct resource mda2_console_resource =
-			    { "mda", 0x3BF, 0x3BF };
+			    { .name = "mda", .start = 0x3BF, .end = 0x3BF };
 			vga_video_type = VIDEO_TYPE_MDA;
 			vga_vram_end = 0xb2000;
 			display_desc = "*MDA";
@@ -422,14 +422,14 @@ #endif
 
 			if (!ORIG_VIDEO_ISVGA) {
 				static struct resource ega_console_resource
-				    = { "ega", 0x3C0, 0x3DF };
+				    = { .name = "ega", .start = 0x3C0, .end = 0x3DF };
 				vga_video_type = VIDEO_TYPE_EGAC;
 				display_desc = "EGA";
 				request_resource(&ioport_resource,
 						 &ega_console_resource);
 			} else {
 				static struct resource vga_console_resource
-				    = { "vga+", 0x3C0, 0x3DF };
+				    = { .name = "vga+", .start = 0x3C0, .end = 0x3DF };
 				vga_video_type = VIDEO_TYPE_VGAC;
 				display_desc = "VGA+";
 				request_resource(&ioport_resource,
@@ -473,7 +473,7 @@ #endif
 			}
 		} else {
 			static struct resource cga_console_resource =
-			    { "cga", 0x3D4, 0x3D5 };
+			    { .name = "cga", .start = 0x3D4, .end = 0x3D5 };
 			vga_video_type = VIDEO_TYPE_CGA;
 			vga_vram_end = 0xba000;
 			display_desc = "*CGA";
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 9fc9af8..d694127 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -119,9 +119,24 @@ DEFINE_PER_CPU(struct cpuinfo_arm, cpu_d
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
+		.flags = IORESOURCE_MEM
+	}
 };
 
 #define video_ram   mem_res[0]
@@ -129,9 +144,24 @@ #define kernel_code mem_res[1]
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
diff --git a/arch/mips/au1000/common/pci.c b/arch/mips/au1000/common/pci.c
index 4e5a6e1..b1392ab 100644
--- a/arch/mips/au1000/common/pci.c
+++ b/arch/mips/au1000/common/pci.c
@@ -40,17 +40,17 @@ #include <asm/mach-au1x00/au1000.h>
 
 /* TBD */
 static struct resource pci_io_resource = {
-	"pci IO space",
-	(u32)PCI_IO_START,
-	(u32)PCI_IO_END,
-	IORESOURCE_IO
+	.start	= PCI_IO_START,
+	.end	= PCI_IO_END,
+	.name	= "PCI IO space",
+	.flags	= IORESOURCE_IO
 };
 
 static struct resource pci_mem_resource = {
-	"pci memory space",
-	(u32)PCI_MEM_START,
-	(u32)PCI_MEM_END,
-	IORESOURCE_MEM
+	.start	= PCI_MEM_START,
+	.end	= PCI_MEM_END,
+	.name	= "PCI memory space",
+	.flags	= IORESOURCE_MEM
 };
 
 extern struct pci_ops au1x_pci_ops;
diff --git a/arch/mips/cobalt/setup.c b/arch/mips/cobalt/setup.c
index 4f9ea12..928431a 100644
--- a/arch/mips/cobalt/setup.c
+++ b/arch/mips/cobalt/setup.c
@@ -68,19 +68,46 @@ static void __init cobalt_timer_setup(st
 extern struct pci_ops gt64111_pci_ops;
 
 static struct resource cobalt_mem_resource = {
-	"PCI memory", GT64111_MEM_BASE, GT64111_MEM_END, IORESOURCE_MEM
+	.start	= GT64111_MEM_BASE,
+	.end	= GT64111_MEM_END,
+	.name	= "PCI memory",
+	.flags	= IORESOURCE_MEM
 };
 
 static struct resource cobalt_io_resource = {
-	"PCI I/O", 0x1000, 0xffff, IORESOURCE_IO
+	.start	= 0x1000,
+	.end	= 0xffff,
+	.name	= "PCI I/O",
+	.flags	= IORESOURCE_IO
 };
 
 static struct resource cobalt_io_resources[] = {
-	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
-	{ "timer", 0x40, 0x5f, IORESOURCE_BUSY },
-	{ "keyboard", 0x60, 0x6f, IORESOURCE_BUSY },
-	{ "dma page reg", 0x80, 0x8f, IORESOURCE_BUSY },
-	{ "dma2", 0xc0, 0xdf, IORESOURCE_BUSY },
+	{
+		.start	= 0x00,
+		.end	= 0x1f,
+		.name	= "dma1",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x40,
+		.end	= 0x5f,
+		.name	= "timer",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x60,
+		.end	= 0x6f,
+		.name	= "keyboard",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x80,
+		.end	= 0x8f,
+		.name	= "dma page reg",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0xc0,
+		.end	= 0xdf,
+		.name	= "dma2",
+		.flags	= IORESOURCE_BUSY
+	},
 };
 
 #define COBALT_IO_RESOURCES (sizeof(cobalt_io_resources)/sizeof(struct resource))
diff --git a/arch/mips/ddb5xxx/ddb5476/setup.c b/arch/mips/ddb5xxx/ddb5476/setup.c
index c902ade..fc8d8bb 100644
--- a/arch/mips/ddb5xxx/ddb5476/setup.c
+++ b/arch/mips/ddb5xxx/ddb5476/setup.c
@@ -109,17 +109,42 @@ static struct {
 	struct resource dma2;
 } ddb5476_ioport = {
 	{
-	"dma1", 0x00, 0x1f, IORESOURCE_BUSY}, {
-	"timer", 0x40, 0x5f, IORESOURCE_BUSY}, {
-	"rtc", 0x70, 0x7f, IORESOURCE_BUSY}, {
-	"dma page reg", 0x80, 0x8f, IORESOURCE_BUSY}, {
-	"dma2", 0xc0, 0xdf, IORESOURCE_BUSY}
+		.start	= 0x00,
+		.end	= 0x1f,
+		.name	= "dma1",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x40,
+		.end	= 0x5f,
+		.name	= "timer",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x70,
+		.end	= 0x7f,
+		.name	= "rtc",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x80,
+		.end	= 0x8f,
+		.name	= "dma page reg",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0xc0,
+		.end	= 0xdf,
+		.name	= "dma2",
+		.flags	= IORESOURCE_BUSY
+	}
 };
 
 static struct {
 	struct resource nile4;
 } ddb5476_iomem = {
-	{ "Nile 4", DDB_BASE, DDB_BASE + DDB_SIZE - 1, IORESOURCE_BUSY}
+	{
+		.start	= DDB_BASE,
+		.end	= DDB_BASE + DDB_SIZE - 1,
+		.name	= "Nile 4",
+		.flags	= IORESOURCE_BUSY
+	}
 };
 
 
diff --git a/arch/mips/ite-boards/generic/it8172_setup.c b/arch/mips/ite-boards/generic/it8172_setup.c
index fc73c8d..00844e6 100644
--- a/arch/mips/ite-boards/generic/it8172_setup.c
+++ b/arch/mips/ite-boards/generic/it8172_setup.c
@@ -72,11 +72,29 @@ struct {
     struct resource flash;
     struct resource boot;
 } it8172_resources = {
-    { "RAM",           0,          0,          IORESOURCE_MEM }, /* to be initted */
-    { "PCI Mem",       0x10000000, 0x13FFFFFF, IORESOURCE_MEM },
-    { "PCI I/O",       0x14000000, 0x17FFFFFF                 },
-    { "Flash",         0x08000000, 0x0CFFFFFF                 },
-    { "Boot ROM",      0x1FC00000, 0x1FFFFFFF                 }
+	{
+		.start	= 0,				/* to be initted */
+		.end	= 0,
+		.name	= "RAM",
+		.flags	= IORESOURCE_MEM
+	}, {
+		.start	= 0x10000000,
+		.end	= 0x13FFFFFF,
+		.name	= "PCI Mem",
+		.flags	= IORESOURCE_MEM
+	}, {
+		.start	= 0x14000000,
+		.end	= 0x17FFFFFF
+		.name	= "PCI I/O",
+	}, {
+		.start	= 0x08000000,
+		.end	= 0x0CFFFFFF
+		.name	= "Flash",
+	}, {
+		.start	= 0x1FC00000,
+		.end	= 0x1FFFFFFF
+		.name	= "Boot ROM",
+	}
 };
 #else
 struct {
@@ -89,14 +107,44 @@ struct {
     struct resource flash;
     struct resource boot;
 } it8172_resources = {
-    { "RAM",           0,          0,          IORESOURCE_MEM }, /* to be initted */
-    { "PCI Mem0",      0x0C000000, 0x0FFFFFFF, IORESOURCE_MEM },
-    { "PCI Mem1",      0x10000000, 0x13FFFFFF, IORESOURCE_MEM },
-    { "PCI I/O",       0x14000000, 0x17FFFFFF                 },
-    { "PCI Mem2",      0x1A000000, 0x1BFFFFFF, IORESOURCE_MEM },
-    { "PCI Mem3",      0x1C000000, 0x1FBFFFFF, IORESOURCE_MEM },
-    { "Flash",         0x08000000, 0x0CFFFFFF                 },
-    { "Boot ROM",      0x1FC00000, 0x1FFFFFFF                 }
+	{
+		.start	= 0,				/* to be initted */
+		.end	= 0,
+		.name	= "RAM",
+		.flags	= IORESOURCE_MEM
+	}, {
+		.start	= 0x0C000000,
+		.end	= 0x0FFFFFFF,
+		.name	= "PCI Mem0",
+		.flags	= IORESOURCE_MEM
+	 }, {
+		.start	= 0x10000000,
+		.end	= 0x13FFFFFF,
+		.name	= "PCI Mem1",
+		.flags	= IORESOURCE_MEM
+	 }, {
+		.start	= 0x14000000,
+		.end	= 0x17FFFFFF
+		.name	= "PCI I/O",
+	}, {
+		.start	= 0x1A000000,
+		.end	= 0x1BFFFFFF,
+		.name	= "PCI Mem2",
+		.flags	= IORESOURCE_MEM
+	}, {
+		.start	= 0x1C000000,
+		.end	= 0x1FBFFFFF,
+		.name	= "PCI Mem3",
+		.flags	= IORESOURCE_MEM
+	}, {
+		.start	= 0x08000000,
+		.end	= 0x0CFFFFFF
+		.name	= "Flash",
+	}, {
+		.start	= 0x1FC00000,
+		.end	= 0x1FFFFFFF
+		.name	= "Boot ROM",
+	}
 };
 #endif
 
diff --git a/arch/mips/jmr3927/rbhma3100/setup.c b/arch/mips/jmr3927/rbhma3100/setup.c
index 9359cc4..1f13655 100644
--- a/arch/mips/jmr3927/rbhma3100/setup.c
+++ b/arch/mips/jmr3927/rbhma3100/setup.c
@@ -82,17 +82,54 @@ struct {
     struct resource sio0;
     struct resource sio1;
 } jmr3927_resources = {
-    { "RAM0",           0,         0x01FFFFFF,  IORESOURCE_MEM },
-    { "RAM1",          0x02000000, 0x03FFFFFF,  IORESOURCE_MEM },
-    { "PCIMEM",        0x08000000, 0x07FFFFFF,  IORESOURCE_MEM },
-    { "IOB",           0x10000000, 0x13FFFFFF                  },
-    { "IOC",           0x14000000, 0x14FFFFFF                  },
-    { "PCIIO",         0x15000000, 0x15FFFFFF                  },
-    { "JMY1394",       0x1D000000, 0x1D3FFFFF                  },
-    { "ROM1",          0x1E000000, 0x1E3FFFFF                  },
-    { "ROM0",          0x1FC00000, 0x1FFFFFFF                  },
-    { "SIO0",          0xFFFEF300, 0xFFFEF3FF                  },
-    { "SIO1",          0xFFFEF400, 0xFFFEF4FF                  },
+	{
+		.start	= 0,
+		.end	= 0x01FFFFFF,
+		.name	= "RAM0",
+		.flags = IORESOURCE_MEM
+	}, {
+		.start	= 0x02000000,
+		.end	= 0x03FFFFFF,
+		.name	= "RAM1",
+		.flags = IORESOURCE_MEM
+	}, {
+		.start	= 0x08000000,
+		.end	= 0x07FFFFFF,
+		.name	= "PCIMEM",
+		.flags = IORESOURCE_MEM
+	}, {
+		.start	= 0x10000000,
+		.end	= 0x13FFFFFF,
+		.name	= "IOB"
+	}, {
+		.start	= 0x14000000,
+		.end	= 0x14FFFFFF,
+		.name	= "IOC"
+	}, {
+		.start	= 0x15000000,
+		.end	= 0x15FFFFFF,
+		.name	= "PCIIO"
+	}, {
+		.start	= 0x1D000000,
+		.end	= 0x1D3FFFFF,
+		.name	= "JMY1394"
+	}, {
+		.start	= 0x1E000000,
+		.end	= 0x1E3FFFFF,
+		.name	= "ROM1"
+	}, {
+		.start	= 0x1FC00000,
+		.end	= 0x1FFFFFFF,
+		.name	= "ROM0"
+	}, {
+		.start	= 0xFFFEF300,
+		.end	= 0xFFFEF3FF,
+		.name	= "SIO0"
+	}, {
+		.start	= 0xFFFEF400,
+		.end	= 0xFFFEF4FF,
+		.name	= "SIO1"
+	},
 };
 
 /* don't enable - see errata */
diff --git a/arch/mips/pci/ops-it8172.c b/arch/mips/pci/ops-it8172.c
index b7a8b9a..ba83285 100644
--- a/arch/mips/pci/ops-it8172.c
+++ b/arch/mips/pci/ops-it8172.c
@@ -50,30 +50,28 @@ #endif
 static struct resource pci_mem_resource_1;
 
 static struct resource pci_io_resource = {
-	"io pci IO space",
-	0x14018000,
-	0x17FFFFFF,
-	IORESOURCE_IO
+	.start	= 0x14018000,
+	.end	= 0x17FFFFFF,
+	.name	= "io pci IO space",
+	.flags	= IORESOURCE_IO
 };
 
 static struct resource pci_mem_resource_0 = {
-	"ext pci memory space 0/1",
-	0x10101000,
-	0x13FFFFFF,
-	IORESOURCE_MEM,
-	&pci_mem_resource_0,
-	NULL,
-	&pci_mem_resource_1
+	.start	= 0x10101000,
+	.end	= 0x13FFFFFF,
+	.name	= "ext pci memory space 0/1",
+	.flags	= IORESOURCE_MEM,
+	.parent	= &pci_mem_resource_0,
+	.sibling = NULL,
+	.child	= &pci_mem_resource_1
 };
 
 static struct resource pci_mem_resource_1 = {
-	"ext pci memory space 2/3",
-	0x1A000000,
-	0x1FBFFFFF,
-	IORESOURCE_MEM,
-	&pci_mem_resource_0,
-	NULL,
-	NULL
+	.start	= 0x1A000000,
+	.end	= 0x1FBFFFFF,
+	.name	= "ext pci memory space 2/3",
+	.flags	= IORESOURCE_MEM,
+	.parent	= &pci_mem_resource_0
 };
 
 extern struct pci_ops it8172_pci_ops;
diff --git a/arch/mips/pci/pci-ddb5074.c b/arch/mips/pci/pci-ddb5074.c
index 73f9cee..b74158d 100644
--- a/arch/mips/pci/pci-ddb5074.c
+++ b/arch/mips/pci/pci-ddb5074.c
@@ -8,17 +8,17 @@ #include <asm/debug.h>
 #include <asm/ddb5xxx/ddb5xxx.h>
 
 static struct resource extpci_io_resource = {
-	"pci IO space",
-	0x1000,			/* leave some room for ISA bus */
-	DDB_PCI_IO_SIZE - 1,
-	IORESOURCE_IO
+	.start	= 0x1000,		/* leave some room for ISA bus */
+	.end	= DDB_PCI_IO_SIZE - 1,
+	.name	= "pci IO space",
+	.flags	= IORESOURCE_IO
 };
 
 static struct resource extpci_mem_resource = {
-	"pci memory space",
-	DDB_PCI_MEM_BASE + 0x00100000,	/* leave 1 MB for RTC */
-	DDB_PCI_MEM_BASE + DDB_PCI_MEM_SIZE - 1,
-	IORESOURCE_MEM
+	.start	= DDB_PCI_MEM_BASE + 0x00100000,	/* leave 1 MB for RTC */
+	.end	= DDB_PCI_MEM_BASE + DDB_PCI_MEM_SIZE - 1,
+	.name	= "pci memory space",
+	.flags	= IORESOURCE_MEM
 };
 
 extern struct pci_ops ddb5476_ext_pci_ops;
diff --git a/arch/mips/pci/pci-ddb5476.c b/arch/mips/pci/pci-ddb5476.c
index 90dd495..2f44c0b 100644
--- a/arch/mips/pci/pci-ddb5476.c
+++ b/arch/mips/pci/pci-ddb5476.c
@@ -8,17 +8,17 @@ #include <asm/debug.h>
 #include <asm/ddb5xxx/ddb5xxx.h>
 
 static struct resource extpci_io_resource = {
-	"pci IO space",
-	0x1000,			/* leave some room for ISA bus */
-	DDB_PCI_IO_SIZE - 1,
-	IORESOURCE_IO
+	.start	= 0x1000,		/* leave some room for ISA bus */
+	.end	= DDB_PCI_IO_SIZE - 1,
+	.name	= "pci IO space",
+	.flags	= IORESOURCE_IO
 };
 
 static struct resource extpci_mem_resource = {
-	"pci memory space",
-	DDB_PCI_MEM_BASE + 0x00100000,	/* leave 1 MB for RTC */
-	DDB_PCI_MEM_BASE + DDB_PCI_MEM_SIZE - 1,
-	IORESOURCE_MEM
+	.start	= DDB_PCI_MEM_BASE + 0x00100000,	/* leave 1 MB for RTC */
+	.end	= DDB_PCI_MEM_BASE + DDB_PCI_MEM_SIZE - 1,
+	.name	= "pci memory space",
+	.flags	= IORESOURCE_MEM
 };
 
 extern struct pci_ops ddb5476_ext_pci_ops;
diff --git a/arch/mips/pci/pci-ddb5477.c b/arch/mips/pci/pci-ddb5477.c
index 826d653..d071bc3 100644
--- a/arch/mips/pci/pci-ddb5477.c
+++ b/arch/mips/pci/pci-ddb5477.c
@@ -22,31 +22,31 @@ #include <asm/debug.h>
 #include <asm/ddb5xxx/ddb5xxx.h>
 
 static struct resource extpci_io_resource = {
-	"ext pci IO space",
-	DDB_PCI0_IO_BASE - DDB_PCI_IO_BASE + 0x4000,
-	DDB_PCI0_IO_BASE - DDB_PCI_IO_BASE + DDB_PCI0_IO_SIZE - 1,
-	IORESOURCE_IO
+	.start	= DDB_PCI0_IO_BASE - DDB_PCI_IO_BASE + 0x4000,
+	.end	= DDB_PCI0_IO_BASE - DDB_PCI_IO_BASE + DDB_PCI0_IO_SIZE - 1,
+	.name	= "ext pci IO space",
+	.flags	= IORESOURCE_IO
 };
 
 static struct resource extpci_mem_resource = {
-	"ext pci memory space",
-	DDB_PCI0_MEM_BASE + 0x100000,
-	DDB_PCI0_MEM_BASE + DDB_PCI0_MEM_SIZE - 1,
-	IORESOURCE_MEM
+	.start	= DDB_PCI0_MEM_BASE + 0x100000,
+	.end	= DDB_PCI0_MEM_BASE + DDB_PCI0_MEM_SIZE - 1,
+	.name	= "ext pci memory space",
+	.flags	= IORESOURCE_MEM
 };
 
 static struct resource iopci_io_resource = {
-	"io pci IO space",
-	DDB_PCI1_IO_BASE - DDB_PCI_IO_BASE,
-	DDB_PCI1_IO_BASE - DDB_PCI_IO_BASE + DDB_PCI1_IO_SIZE - 1,
-	IORESOURCE_IO
+	.start	= DDB_PCI1_IO_BASE - DDB_PCI_IO_BASE,
+	.end	= DDB_PCI1_IO_BASE - DDB_PCI_IO_BASE + DDB_PCI1_IO_SIZE - 1,
+	.name	= "io pci IO space",
+	.flags	= IORESOURCE_IO
 };
 
 static struct resource iopci_mem_resource = {
-	"ext pci memory space",
-	DDB_PCI1_MEM_BASE,
-	DDB_PCI1_MEM_BASE + DDB_PCI1_MEM_SIZE - 1,
-	IORESOURCE_MEM
+	.start	= DDB_PCI1_MEM_BASE,
+	.end	= DDB_PCI1_MEM_BASE + DDB_PCI1_MEM_SIZE - 1,
+	.name	= "ext pci memory space",
+	.flags	= IORESOURCE_MEM
 };
 
 extern struct pci_ops ddb5477_ext_pci_ops;
diff --git a/arch/mips/pci/pci-jmr3927.c b/arch/mips/pci/pci-jmr3927.c
index f02ef6e..cb84f4e 100644
--- a/arch/mips/pci/pci-jmr3927.c
+++ b/arch/mips/pci/pci-jmr3927.c
@@ -35,17 +35,17 @@ #include <asm/jmr3927/jmr3927.h>
 #include <asm/debug.h>
 
 struct resource pci_io_resource = {
-	"IO MEM",
-	0x1000,			/* reserve regacy I/O space */
-	0x1000 + JMR3927_PCIIO_SIZE - 1,
-	IORESOURCE_IO
+	.name	= "IO MEM",
+	.start	= 0x1000,			/* reserve regacy I/O space */
+	.end	= 0x1000 + JMR3927_PCIIO_SIZE - 1,
+	.flags	= IORESOURCE_IO
 };
 
 struct resource pci_mem_resource = {
-	"PCI MEM",
-	JMR3927_PCIMEM,
-	JMR3927_PCIMEM + JMR3927_PCIMEM_SIZE - 1,
-	IORESOURCE_MEM
+	.name	= "PCI MEM",
+	.start	= JMR3927_PCIMEM,
+	.end	= JMR3927_PCIMEM + JMR3927_PCIMEM_SIZE - 1,
+	.flags	= IORESOURCE_MEM
 };
 
 extern struct pci_ops jmr3927_pci_ops;
diff --git a/arch/mips/pci/pci-ocelot.c b/arch/mips/pci/pci-ocelot.c
index 3da8a4e..2b9495d 100644
--- a/arch/mips/pci/pci-ocelot.c
+++ b/arch/mips/pci/pci-ocelot.c
@@ -71,13 +71,13 @@ static inline void pci0WriteConfigReg(un
 }
 
 static struct resource ocelot_mem_resource = {
-	iomem_resource.start = GT_PCI_MEM_BASE;
-	iomem_resource.end = GT_PCI_MEM_BASE + GT_PCI_MEM_BASE - 1;
+	start	= GT_PCI_MEM_BASE;
+	end	= GT_PCI_MEM_BASE + GT_PCI_MEM_BASE - 1;
 };
 
 static struct resource ocelot_io_resource = {
-	ioport_resource.start = GT_PCI_IO_BASE;
-	ioport_resource.end = GT_PCI_IO_BASE + GT_PCI_IO_SIZE - 1;
+	start	= GT_PCI_IO_BASE;
+	end	= GT_PCI_IO_BASE + GT_PCI_IO_SIZE - 1;
 };
 
 static struct pci_controller ocelot_pci_controller = {
diff --git a/arch/mips/pci/pci-yosemite.c b/arch/mips/pci/pci-yosemite.c
index dac9ed4..0357946 100644
--- a/arch/mips/pci/pci-yosemite.c
+++ b/arch/mips/pci/pci-yosemite.c
@@ -14,7 +14,10 @@ #include <asm/titan_dep.h>
 extern struct pci_ops titan_pci_ops;
 
 static struct resource py_mem_resource = {
-	"Titan PCI MEM", 0xe0000000UL, 0xe3ffffffUL, IORESOURCE_MEM
+	.start	= 0xe0000000UL,
+	.end	= 0xe3ffffffUL,
+	.name	= "Titan PCI MEM",
+	.flags	= IORESOURCE_MEM
 };
 
 /*
@@ -26,7 +29,10 @@ #define TITAN_IO_SIZE	0x0000ffffUL
 #define TITAN_IO_BASE	0xe8000000UL
 
 static struct resource py_io_resource = {
-	"Titan IO MEM", 0x00001000UL, TITAN_IO_SIZE - 1, IORESOURCE_IO,
+	.start	= 0x00001000UL,
+	.end	= TITAN_IO_SIZE - 1,
+	.name	= "Titan IO MEM",
+	.flags	= IORESOURCE_IO,
 };
 
 static struct pci_controller py_controller = {
diff --git a/arch/mips/philips/pnx8550/common/pci.c b/arch/mips/philips/pnx8550/common/pci.c
index baa6905..eee4f3d 100644
--- a/arch/mips/philips/pnx8550/common/pci.c
+++ b/arch/mips/philips/pnx8550/common/pci.c
@@ -27,17 +27,17 @@ #include <glb.h>
 #include <nand.h>
 
 static struct resource pci_io_resource = {
-	"pci IO space",
-	(u32)(PNX8550_PCIIO + 0x1000),	/* reserve regacy I/O space */
-	(u32)(PNX8550_PCIIO + PNX8550_PCIIO_SIZE),
-	IORESOURCE_IO
+	.start	= PNX8550_PCIIO + 0x1000,	/* reserve regacy I/O space */
+	.end	= PNX8550_PCIIO + PNX8550_PCIIO_SIZE,
+	.name	= "pci IO space",
+	.flags	= IORESOURCE_IO
 };
 
 static struct resource pci_mem_resource = {
-	"pci memory space",
-	(u32)(PNX8550_PCIMEM),
-	(u32)(PNX8550_PCIMEM + PNX8550_PCIMEM_SIZE - 1),
-	IORESOURCE_MEM
+	.start	= PNX8550_PCIMEM,
+	.end	= PNX8550_PCIMEM + PNX8550_PCIMEM_SIZE - 1,
+	.name	= "pci memory space",
+	.flags	= IORESOURCE_MEM
 };
 
 extern struct pci_ops pnx8550_pci_ops;
diff --git a/arch/mips/philips/pnx8550/common/setup.c b/arch/mips/philips/pnx8550/common/setup.c
index 0d8a776..2b199f3 100644
--- a/arch/mips/philips/pnx8550/common/setup.c
+++ b/arch/mips/philips/pnx8550/common/setup.c
@@ -58,10 +58,27 @@ extern void prom_printf(char *fmt, ...);
 extern char *prom_getcmdline(void);
 
 struct resource standard_io_resources[] = {
-	{"dma1", 0x00, 0x1f, IORESOURCE_BUSY},
-	{"timer", 0x40, 0x5f, IORESOURCE_BUSY},
-	{"dma page reg", 0x80, 0x8f, IORESOURCE_BUSY},
-	{"dma2", 0xc0, 0xdf, IORESOURCE_BUSY},
+	{
+		.start	= .0x00,
+		.end	= 0x1f,
+		.name	= "dma1",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x40,
+		.end	= 0x5f,
+		.name	= "timer",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x80,
+		.end	= 0x8f,
+		.name	= "dma page reg",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0xc0,
+		.end	= 0xdf,
+		.name	= "dma2",
+		.flags	= IORESOURCE_BUSY
+	},
 };
 
 #define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct resource))
diff --git a/arch/mips/sni/setup.c b/arch/mips/sni/setup.c
index 01ba6c5..c33cb9d 100644
--- a/arch/mips/sni/setup.c
+++ b/arch/mips/sni/setup.c
@@ -92,20 +92,51 @@ #endif
 }
 
 static struct resource sni_io_resource = {
-	"PCIMT IO MEM", 0x00001000UL, 0x03bfffffUL, IORESOURCE_IO,
+	.start	= 0x00001000UL,
+	.end	= 0x03bfffffUL,
+	.name	= "PCIMT IO MEM",
+	.flags	= IORESOURCE_IO,
 };
 
 static struct resource pcimt_io_resources[] = {
-	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
-	{ "timer", 0x40, 0x5f, IORESOURCE_BUSY },
-	{ "keyboard", 0x60, 0x6f, IORESOURCE_BUSY },
-	{ "dma page reg", 0x80, 0x8f, IORESOURCE_BUSY },
-	{ "dma2", 0xc0, 0xdf, IORESOURCE_BUSY },
-	{ "PCI config data", 0xcfc, 0xcff, IORESOURCE_BUSY }
+	{
+		.start	= 0x00,
+		.end	= 0x1f,
+		.name	= "dma1",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	=  0x40,
+		.end	= 0x5f,
+		.name	= "timer",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	=  0x60,
+		.end	= 0x6f,
+		.name	= "keyboard",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	=  0x80,
+		.end	= 0x8f,
+		.name	= "dma page reg",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	=  0xc0,
+		.end	= 0xdf,
+		.name	= "dma2",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	=  0xcfc,
+		.end	= 0xcff,
+		.name	= "PCI config data",
+		.flags	= IORESOURCE_BUSY
+	}
 };
 
 static struct resource sni_mem_resource = {
-	"PCIMT PCI MEM", 0x10000000UL, 0xffffffffUL, IORESOURCE_MEM
+	.start	= 0x10000000UL,
+	.end	= 0xffffffffUL,
+	.name	= "PCIMT PCI MEM",
+	.flags	= IORESOURCE_MEM
 };
 
 /*
@@ -122,19 +153,72 @@ static struct resource sni_mem_resource 
  * 0xa0000000 - 0xffffffff (1.5GB) PCI/EISA Bus Memory
  */
 static struct resource pcimt_mem_resources[] = {
-	{ "Video RAM area", 0x100a0000, 0x100bffff, IORESOURCE_BUSY },
-	{ "ISA Reserved", 0x100c0000, 0x100fffff, IORESOURCE_BUSY },
-	{ "PCI IO", 0x14000000, 0x17bfffff, IORESOURCE_BUSY },
-	{ "Cache Replacement Area", 0x17c00000, 0x17ffffff, IORESOURCE_BUSY},
-	{ "PCI INT Acknowledge", 0x1a000000, 0x1a000003, IORESOURCE_BUSY },
-	{ "Boot PROM", 0x1fc00000, 0x1fc7ffff, IORESOURCE_BUSY},
-	{ "Diag PROM", 0x1fc80000, 0x1fcfffff, IORESOURCE_BUSY},
-	{ "X-Bus", 0x1fd00000, 0x1fdfffff, IORESOURCE_BUSY},
-	{ "BIOS map", 0x1fe00000, 0x1fefffff, IORESOURCE_BUSY},
-	{ "NVRAM / EEPROM", 0x1ff00000, 0x1ff7ffff, IORESOURCE_BUSY},
-	{ "ASIC PCI", 0x1fff0000, 0x1fffefff, IORESOURCE_BUSY},
-	{ "MP Agent", 0x1ffff000, 0x1fffffff, IORESOURCE_BUSY},
-	{ "Main Memory", 0x20000000, 0x9fffffff, IORESOURCE_BUSY}
+	{
+		.start	= 0x100a0000,
+		.end	= 0x100bffff,
+		.name	= "Video RAM area",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x100c0000,
+		.end	= 0x100fffff,
+		.name	= "ISA Reserved",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x14000000,
+		.end	= 0x17bfffff,
+		.name	= "PCI IO",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x17c00000,
+		.end	= 0x17ffffff,
+		.name	= "Cache Replacement Area",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x1a000000,
+		.end	= 0x1a000003,
+		.name	= "PCI INT Acknowledge",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x1fc00000,
+		.end	= 0x1fc7ffff,
+		.name	= "Boot PROM",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x1fc80000,
+		.end	= 0x1fcfffff,
+		.name	= "Diag PROM",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x1fd00000,
+		.end	= 0x1fdfffff,
+		.name	= "X-Bus",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x1fe00000,
+		.end	= 0x1fefffff,
+		.name	= "BIOS map",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x1ff00000,
+		.end	= 0x1ff7ffff,
+		.name	= "NVRAM / EEPROM",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x1fff0000,
+		.end	= 0x1fffefff,
+		.name	= "ASIC PCI",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x1ffff000,
+		.end	= 0x1fffffff,
+		.name	= "MP Agent",
+		.flags	= IORESOURCE_BUSY
+	}, {
+		.start	= 0x20000000,
+		.end	= 0x9fffffff,
+		.name	= "Main Memory",
+		.flags	= IORESOURCE_BUSY
+	}
 };
 
 static void __init sni_resource_init(void)
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/setup.c b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
index 9166cd4..96e833c 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
@@ -664,7 +664,10 @@ static struct resource rbtx4938_fpga_res
 
 static char pcode_str[8];
 static struct resource tx4938_reg_resource = {
-	pcode_str, TX4938_REG_BASE, TX4938_REG_BASE+TX4938_REG_SIZE, IORESOURCE_MEM
+	.start	= TX4938_REG_BASE,
+	.end	= TX4938_REG_BASE + TX4938_REG_SIZE,
+	.name	= pcode_str,
+	.flags	= IORESOURCE_MEM
 };
 
 void __init tx4938_board_setup(void)
-- 
1.4.0

