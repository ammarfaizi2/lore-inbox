Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVHBVKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVHBVKI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 17:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVHBVHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 17:07:25 -0400
Received: from crl-mail-dmz.crl.hpl.hp.com ([192.58.210.9]:59623 "EHLO
	crl-mailb.crl.dec.com") by vger.kernel.org with ESMTP
	id S261773AbVHBVFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 17:05:16 -0400
From: <jamey@crl.dec.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] platform-device driver for MQ11xx graphics chip
Message-Id: <20050802192041.C09C5B4262@lspace.crl.dec.com>
Date: Tue,  2 Aug 2005 15:20:41 -0400 (EDT)
X-HPLC-MailScanner-Information: Please contact the ISP for more information
X-HPLC-MailScanner: Found to be clean
X-HPLC-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.752,
	required 5, BAYES_00 -4.90, DOMAIN_BODY 2.20, NO_REAL_NAME 0.16,
	REMOVE_REMOVAL_NEAR 0.79, UPPERCASE_25_50 0.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds platform_device driver for MQ11xx system-on-chip
graphics chip.  This chip is used in several non-PCI ARM and MIPS
platforms such as the iPAQ H5550.  Two subsequent patches add
support for the framebuffer and USB gadget subdevices.  This patch
adds the toplevel driver to drivers/platform because it does not
provide any specific functionality (e.g., framebuffer) and it not tied
to a named physical bus.  In these platforms, the MQ11xx is tied
directly to the host bus.


Signed-off-by: Jamey Hicks <jamey@handhelds.org>
Signed-off-by: Andrew Zabolotny <anpaza@mail.ru>

---
commit d1144b4da9a00634c14dfed3a56f8491749b9f01
tree 66014fccdb508b698e326bbf8158d40161a39226
parent 5f367e62a65136321593c193391a186f56f81b93
author <jamey@lspace.crl.dec.com> Tue, 02 Aug 2005 11:24:55 -0400
committer <jamey@lspace.crl.dec.com> Tue, 02 Aug 2005 11:24:55 -0400

 arch/arm/Kconfig                               |    2 
 drivers/Kconfig                                |    2 
 drivers/Makefile                               |    2 
 drivers/platform/.tmp_versions/mq11xx_base.mod |    2 
 drivers/platform/Kconfig                       |   23 
 drivers/platform/Makefile                      |    5 
 drivers/platform/mq11xx.h                      |  925 ++++++++++++++++
 drivers/platform/mq11xx_base.c                 | 1390 ++++++++++++++++++++++++
 8 files changed, 2350 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -764,6 +764,8 @@ source "drivers/usb/Kconfig"
 
 source "drivers/mmc/Kconfig"
 
+source "drivers/platform/Kconfig"
+
 endmenu
 
 source "fs/Kconfig"
diff --git a/drivers/Kconfig b/drivers/Kconfig
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -58,6 +58,8 @@ source "drivers/usb/Kconfig"
 
 source "drivers/mmc/Kconfig"
 
+source "drivers/platform/Kconfig"
+
 source "drivers/infiniband/Kconfig"
 
 source "drivers/sn/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -7,7 +7,7 @@
 
 obj-$(CONFIG_PCI)		+= pci/
 obj-$(CONFIG_PARISC)		+= parisc/
-obj-y				+= video/
+obj-y				+= video/ platform/
 obj-$(CONFIG_ACPI_BOOT)		+= acpi/
 # PnP must come after ACPI since it will eventually need to check if acpi
 # was used and do nothing if so
diff --git a/drivers/platform/.tmp_versions/mq11xx_base.mod b/drivers/platform/.tmp_versions/mq11xx_base.mod
new file mode 100644
--- /dev/null
+++ b/drivers/platform/.tmp_versions/mq11xx_base.mod
@@ -0,0 +1,2 @@
+drivers/platform/mq11xx_base.ko
+drivers/platform/mq11xx_base.o
diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
new file mode 100644
--- /dev/null
+++ b/drivers/platform/Kconfig
@@ -0,0 +1,23 @@
+#
+# Platform devices
+#
+
+menu "Platform devices"
+
+config PLATFORM_MQ11XX
+	tristate "MediaQ 1100/32/68/78/88 SoC support"
+	---help---
+	  MediaQ 1100/32/68/78/88 are system-on-chips that implement a
+	  graphics engine, flat panel controller, USB function controller,
+	  OHCI-compliant USB host controller (1132 only), I2S and SPI
+	  controllers (also 1132 only).
+
+	  This driver implements only the basic support for MediaQ chips;
+	  after you select this option the subdevice drivers will appear
+	  in the respective submenus: MediaQ 1100/32/68/78/88 framebuffer
+	  support, Dell Axim X5 LCD support and so on.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mq11xx_base.o.
+
+endmenu
diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
new file mode 100644
--- /dev/null
+++ b/drivers/platform/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for platform device drivers.
+#
+
+obj-$(CONFIG_PLATFORM_MQ11XX)        += mq11xx_base.o
diff --git a/drivers/platform/mq11xx.h b/drivers/platform/mq11xx.h
new file mode 100644
--- /dev/null
+++ b/drivers/platform/mq11xx.h
@@ -0,0 +1,925 @@
+/*
+ * drivers/misc/soc/mq11xx.h
+ *
+ * Copyright (C) 2003 Andrew Zabolotny <anpaza@mail.ru>
+ * Portions copyright (C) 2003 Keith Packard
+ *
+ * This file contains some definitions for the MediaQ 1100/1132.
+ * These definitions are made public because drivers for
+ * MediaQ subdevices need them.
+ */
+
+#ifndef _PLATFORM_MEDIAQ11XX
+#define _PLATFORM_MEDIAQ11XX
+
+#define MQ11xx_REG_SIZE		(8*1024)
+#define MQ11xx_FB_SIZE		(256*1024)
+#define MQ11xx_NUMIRQS		20
+
+/* MediaQ 1100/1132/1168/1178/1188 subdevices */
+#define MEDIAQ_11XX_FB_DEVICE_ID	0x00000301
+#define MEDIAQ_11XX_FP_DEVICE_ID	0x00000302
+#define MEDIAQ_11XX_UDC_DEVICE_ID	0x00000303
+#define MEDIAQ_11XX_UHC_DEVICE_ID	0x00000304
+#define MEDIAQ_11XX_SPI_DEVICE_ID	0x00000305
+#define MEDIAQ_11XX_I2S_DEVICE_ID	0x00000306
+
+/* Interrupt handling for the MediaQ chip is quite tricky.
+ * The chip has 20 internal interrupt sources (numbered from 0 to 19,
+ * see the constants below) which are demultiplexed to a single output
+ * pin which is usually connected to a single IRQ on the mainboard.
+ * Thus the driver has to multiplex it somehow again into twenty
+ * different IRQs.
+ *
+ * Unfortunately, the mechanisms required for this are missing (as of today)
+ * on all platforms except ARM. Let's hope one day they will be supported on
+ * all platforms; for now no platforms except ARM supports MediaQ interrupts.
+ *
+ * The following contants are IRQ offsets relative to the base IRQ number
+ * (driver allocates a range of IRQs).
+ */
+
+#if defined CONFIG_ARM
+#  define MQ_IRQ_MULTIPLEX
+#endif
+
+#define IRQ_MQ_VSYNC_RISING			0
+#define IRQ_MQ_VSYNC_FALLING			1
+#define IRQ_MQ_VENABLE_RISING			2
+#define IRQ_MQ_VENABLE_FALLING			3
+#define IRQ_MQ_BUS_CYCLE_ABORT			4
+#define IRQ_MQ_GPIO_0				5
+#define IRQ_MQ_GPIO_1				6
+#define IRQ_MQ_GPIO_2				7
+#define IRQ_MQ_COMMAND_FIFO_HALF_EMPTY    	8
+#define IRQ_MQ_COMMAND_FIFO_EMPTY		9
+#define IRQ_MQ_SOURCE_FIFO_HALF_EMPTY		10
+#define IRQ_MQ_SOURCE_FIFO_EMPTY		11
+#define IRQ_MQ_GRAPHICS_ENGINE_IDLE		12
+#define IRQ_MQ_UHC_GLOBAL_SUSPEND_MODE		13
+#define IRQ_MQ_UHC_REMOTE_WAKE_UP		14
+#define IRQ_MQ_UHC				15
+#define IRQ_MQ_UDC				16
+#define IRQ_MQ_I2S				17
+#define IRQ_MQ_SPI				18
+#define IRQ_MQ_UDC_WAKE_UP			19
+
+/* This union uses unnamed structs. This is a gcc extension, but what the
+ * hell, the kernel is not compilable by anything else anyway...
+ */
+struct mediaq11xx_regs {
+	/*
+	 * CPU Interface (CC) Module	    0x000
+	 */
+	union {
+		struct {
+			u32 cpu_control;
+#define MQ_CPU_CONTROL_MIU_READ_REQUEST_GENERATOR_ON	(1 << 0)
+#define MQ_CPU_CONTROL_DISBABLE_FB_READ_CACHE		(1 << 1)
+#define MQ_CPU_CONTROL_ENABLE_CLKRUN			(1 << 3)
+#define MQ_CPU_CONTROL_GPIO_SOURCE_DATA_SELECT		(3 << 4)
+#define MQ_CPU_CONTROL_CPU_INTERFACE_GPIO_DATA		(3 << 6)
+			u32 fifo_status;
+#define MQ_CPU_COMMAND_FIFO(s)				(((s) >> 0) & 0x1f)
+#define MQ_CPU_SOURCE_FIFO(s)				(((s) >> 8) & 0x1f)
+#define MQ_CPU_GE_BUSY					(1 << 16)
+			u32 gpio_control_0;
+			u32 gpio_control_1;
+			u32 cpu_test_mode;
+		};
+		u32 a[6];
+		u8 size[128];
+	} CC;
+	/*
+	 * Memory Interface Unit Controller    0x080
+	 */
+	union {
+		struct {
+			u32	miu_0;
+#define MQ_MIU_ENABLE					(1 << 0)
+#define MQ_MIU_RESET_ENABLE				(1 << 1)
+			u32	miu_1;
+#define MQ_MIU_MEMORY_CLOCK_SOURCE_BUS			(1 << 0)
+#define MQ_MIU_MEMORY_CLOCK_DIVIDER			(7 << 2)
+#define MQ_MIU_MEMORY_CLOCK_DIVIDER_1			(0 << 2)
+#define MQ_MIU_MEMORY_CLOCK_DIVIDER_1_5			(1 << 2)
+#define MQ_MIU_MEMORY_CLOCK_DIVIDER_2			(2 << 2)
+#define MQ_MIU_MEMORY_CLOCK_DIVIDER_2_5			(3 << 2)
+#define MQ_MIU_MEMORY_CLOCK_DIVIDER_3			(4 << 2)
+#define MQ_MIU_MEMORY_CLOCK_DIVIDER_4			(5 << 2)
+#define MQ_MIU_MEMORY_CLOCK_DIVIDER_5			(6 << 2)
+#define MQ_MIU_MEMORY_CLOCK_DIVIDER_6			(7 << 2)
+#define MQ_MIU_DISPLAY_BURST_MASK			(3 << 5)
+#define MQ_MIU_DISPLAY_BURST_COUNT_2			(0 << 5)
+#define MQ_MIU_DISPLAY_BURST_COUNT_4			(1 << 5)
+#define MQ_MIU_DISPLAY_BURST_COUNT_6			(2 << 5)
+#define MQ_MIU_DISPLAY_BURST_COUNT_8			(3 << 5)
+#define MQ_MIU_GRAPHICS_ENGINE_BURST_MASK	    	(3 << 7)
+#define MQ_MIU_GRAPHICS_ENGINE_BURST_COUNT_2	    	(0 << 7)
+#define MQ_MIU_GRAPHICS_ENGINE_BURST_COUNT_4	    	(1 << 7)
+#define MQ_MIU_GRAPHICS_ENGINE_BURST_COUNT_6	    	(2 << 7)
+#define MQ_MIU_GRAPHICS_ENGINE_BURST_COUNT_8	    	(3 << 7)
+#define MQ_MIU_CPU_BURST_MASK				(3 << 9)
+#define MQ_MIU_CPU_BURST_COUNT_2	    		(0 << 9)
+#define MQ_MIU_CPU_BURST_COUNT_4	    		(1 << 9)
+#define MQ_MIU_CPU_BURST_COUNT_6	    		(2 << 9)
+#define MQ_MIU_CPU_BURST_COUNT_8	    		(3 << 9)
+#define MQ_MIU_I2S_BURST_MASK				(3 << 11)
+#define MQ_MIU_I2S_BURST_COUNT_2    			(0 << 11)
+#define MQ_MIU_I2S_BURST_COUNT_4    			(1 << 11)
+#define MQ_MIU_I2S_BURST_COUNT_6    			(2 << 11)
+#define MQ_MIU_I2S_BURST_COUNT_8    			(3 << 11)
+#define MQ_MIU_UDC_BURST_MASK				(3 << 13)
+#define MQ_MIU_UDC_BURST_COUNT_2    			(0 << 13)
+#define MQ_MIU_UDC_BURST_COUNT_4    			(1 << 13)
+#define MQ_MIU_UDC_BURST_COUNT_6    			(2 << 13)
+#define MQ_MIU_UDC_BURST_COUNT_8    			(3 << 13)
+#define MQ_MIU_GCI_FIFO_THRESHOLD			(0xf << 16)
+#define MQ_MIU_GCI_FIFO_THRESHOLD_(v)			((v) << 16)
+#define MQ_MIU_GRAPHICS_ENGINE_SRC_READ_THRESHOLD	(7 << 20)
+#define MQ_MIU_GRAPHICS_ENGINE_SRC_READ_THRESHOLD_(v)	((v) << 20)
+#define MQ_MIU_GRAPHICS_ENGINE_DST_READ_THRESHOLD	(7 << 23)
+#define MQ_MIU_GRAPHICS_ENGINE_DST_READ_THRESHOLD_(v)	((v) << 23)
+#define MQ_MIU_I2S_TRANSMIT_THRESHOLD			(7 << 26)
+#define MQ_MIU_I2S_TRANSMIT_THRESHOLD_(v)    		((v) << 26)
+			u32	miu_test_control;
+			u32	mq1178_unknown1;
+			u32	mq1178_unknown2;
+		};
+		u32 a[8];
+		u8 size[128];
+	} MIU;
+	/*
+	 * Interrupt Controller	    0x100
+	 */
+	union {
+		struct {
+			u32 control;
+#define MQ_INTERRUPT_CONTROL_INTERRUPT_ENABLE		(1 << 0)
+#define MQ_INTERRUPT_CONTROL_INTERRUPT_POLARITY		(1 << 1)
+#define MQ_INTERRUPT_CONTROL_GPIO_0_INTERRUPT_POLARITY	(1 << 2)
+#define MQ_INTERRUPT_CONTROL_GPIO_1_INTERRUPT_POLARITY	(1 << 3)
+#define MQ_INTERRUPT_CONTROL_GPIO_2_INTERRUPT_POLARITY	(1 << 4)
+			u32 interrupt_mask;
+#define MQ_INTERRUPT_MASK_VSYNC_RISING			(1 << 0)
+#define MQ_INTERRUPT_MASK_VSYNC_FALLING			(1 << 1)
+#define MQ_INTERRUPT_MASK_VENABLE_RISING		(1 << 2)
+#define MQ_INTERRUPT_MASK_VENABLE_FALLING		(1 << 3)
+#define MQ_INTERRUPT_MASK_BUS_CYCLE_ABORT		(1 << 4)
+#define MQ_INTERRUPT_MASK_GPIO_0			(1 << 5)
+#define MQ_INTERRUPT_MASK_GPIO_1			(1 << 6)
+#define MQ_INTERRUPT_MASK_GPIO_2			(1 << 7)
+#define MQ_INTERRUPT_MASK_COMMAND_FIFO_HALF_EMPTY    	(1 << 8)
+#define MQ_INTERRUPT_MASK_COMMAND_FIFO_EMPTY		(1 << 9)
+#define MQ_INTERRUPT_MASK_SOURCE_FIFO_HALF_EMPTY	(1 << 10)
+#define MQ_INTERRUPT_MASK_SOURCE_FIFO_EMPTY		(1 << 11)
+#define MQ_INTERRUPT_MASK_GRAPHICS_ENGINE_IDLE		(1 << 12)
+#define MQ_INTERRUPT_MASK_UHC_GLOBAL_SUSPEND_MODE	(1 << 13)
+#define MQ_INTERRUPT_MASK_UHC_REMOTE_WAKE_UP    	(1 << 14)
+#define MQ_INTERRUPT_MASK_UHC				(1 << 15)
+#define MQ_INTERRUPT_MASK_UDC				(1 << 16)
+#define MQ_INTERRUPT_MASK_I2S				(1 << 17)
+#define MQ_INTERRUPT_MASK_SPI				(1 << 18)
+#define MQ_INTERRUPT_MASK_UDC_WAKE_UP			(1 << 19)
+			u32 interrupt_status;
+#define MQ_INTERRUPT_STATUS_VSYNC_RISING		(1 << 0)
+#define MQ_INTERRUPT_STATUS_VSYNC_FALLING		(1 << 1)
+#define MQ_INTERRUPT_STATUS_VENABLE_RISING		(1 << 2)
+#define MQ_INTERRUPT_STATUS_VENABLE_FALLING		(1 << 3)
+#define MQ_INTERRUPT_STATUS_BUS_CYCLE_ABORT		(1 << 4)
+#define MQ_INTERRUPT_STATUS_GPIO_0			(1 << 5)
+#define MQ_INTERRUPT_STATUS_GPIO_1			(1 << 6)
+#define MQ_INTERRUPT_STATUS_GPIO_2			(1 << 7)
+#define MQ_INTERRUPT_STATUS_COMMAND_FIFO_HALF_EMPTY    	(1 << 8)
+#define MQ_INTERRUPT_STATUS_COMMAND_FIFO_EMPTY		(1 << 9)
+#define MQ_INTERRUPT_STATUS_SOURCE_FIFO_HALF_EMPTY	(1 << 10)
+#define MQ_INTERRUPT_STATUS_SOURCE_FIFO_EMPTY		(1 << 11)
+#define MQ_INTERRUPT_STATUS_GRAPHICS_ENGINE_IDLE	(1 << 12)
+#define MQ_INTERRUPT_STATUS_UHC_GLOBAL_SUSPEND_MODE	(1 << 13)
+#define MQ_INTERRUPT_STATUS_UHC_REMOTE_WAKE_UP    	(1 << 14)
+#define MQ_INTERRUPT_STATUS_UHC				(1 << 15)
+#define MQ_INTERRUPT_STATUS_UDC				(1 << 16)
+#define MQ_INTERRUPT_STATUS_I2S				(1 << 17)
+#define MQ_INTERRUPT_STATUS_SPI				(1 << 18)
+#define MQ_INTERRUPT_STATUS_UDC_WAKE_UP			(1 << 19)
+			u32 interrupt_raw_status;
+#define MQ_INTERRUPT_RAWSTATUS_VSYNC			(1 << 0)
+#define MQ_INTERRUPT_RAWSTATUS_VENABLE			(1 << 1)
+#define MQ_INTERRUPT_RAWSTATUS_SCC			(1 << 2)
+#define MQ_INTERRUPT_RAWSTATUS_SPI			(1 << 3)
+#define MQ_INTERRUPT_RAWSTATUS_GPIO_0			(1 << 4)
+#define MQ_INTERRUPT_RAWSTATUS_GPIO_1			(1 << 5)
+#define MQ_INTERRUPT_RAWSTATUS_GPIO_2			(1 << 6)
+#define MQ_INTERRUPT_RAWSTATUS_GRAPHICS_ENGINE_BUSY	(1 << 8)
+#define MQ_INTERRUPT_RAWSTATUS_SOURCE_FIFO_EMPTY	(1 << 9)
+#define MQ_INTERRUPT_RAWSTATUS_SOURCE_FIFO_HALF_EMPTY	(1 << 10)
+#define MQ_INTERRUPT_RAWSTATUS_COMMAND_FIFO_EMPTY	(1 << 11)
+#define MQ_INTERRUPT_RAWSTATUS_COMMAND_FIFO_HALF_EMPTY	(1 << 12)
+#define MQ_INTERRUPT_RAWSTATUS_UHC			(1 << 13)
+#define MQ_INTERRUPT_RAWSTATUS_UHC_GLOBAL_SUSPEND	(1 << 14)
+#define MQ_INTERRUPT_RAWSTATUS_UHC_REMOTE_WAKE_UP	(1 << 15)
+#define MQ_INTERRUPT_RAWSTATUS_UDC			(1 << 16)
+#define MQ_INTERRUPT_RAWSTATUS_UDC_WAKE_UP		(1 << 17)
+		};
+		u32 a[4];
+		u8 size[128];
+	} IC;
+	/*
+	 * Graphics Controller	    0x180
+	 */
+	union {
+		struct {
+			u32 control;
+#define MQ_GC_CONTROL_ENABLE				(1 << 0)
+#define MQ_GC_HORIZONTAL_COUNTER_RESET			(1 << 1)
+#define MQ_GC_VERTICAL_COUNTER_RESET			(1 << 2)
+#define MQ_GC_IMAGE_WINDOW_ENABLE			(1 << 3)
+#define MQ_GC_DEPTH					(0xf << 4)
+#define MQ_GC_DEPTH_PSEUDO_1				(0x0 << 4)
+#define MQ_GC_DEPTH_PSEUDO_2				(0x1 << 4)
+#define MQ_GC_DEPTH_PSEUDO_4				(0x2 << 4)
+#define MQ_GC_DEPTH_PSEUDO_8				(0x3 << 4)
+#define MQ_GC_DEPTH_GRAY_1				(0x8 << 4)
+#define MQ_GC_DEPTH_GRAY_2				(0x9 << 4)
+#define MQ_GC_DEPTH_GRAY_4				(0xa << 4)
+#define MQ_GC_DEPTH_GRAY_8				(0xb << 4)
+#define MQ_GC_DEPTH_TRUE_16				(0xc << 4)
+#define MQ_GC_HARDWARE_CURSOR_ENABLE			(1 << 8)
+#define MQ_GC_DOUBLE_BUFFER_CONTROL			(3 << 10)
+#define MQ_GC_X_SCANNING_DIRECTION			(1 << 12)
+#define MQ_GC_LINE_SCANNING_DIRECTION			(1 << 13)
+#define MQ_GC_HORIZONTAL_DOUBLING			(1 << 14)
+#define MQ_GC_VERTICAL_DOUBLING				(1 << 15)
+#define MQ_GC_GRCLK_SOURCE				(3 << 16)
+#define MQ_GC_GRCLK_SOURCE_BUS				(0 << 16)
+#define MQ_GC_GRCLK_SOURCE_FIRST    			(1 << 16)
+#define MQ_GC_GRCLK_SOURCE_SECON    			(2 << 16)
+#define MQ_GC_GRCLK_SOURCE_THIRD    			(3 << 16)
+#define MQ_GC_ENABLE_TEST_MODE				(1 << 18)
+#define MQ_GC_ENABLE_POLY_SI_TFT			(1 << 19)
+#define MQ_GC_GMCLK_FIRST_DIVISOR			(7 << 20)
+#define MQ_GC_GMCLK_FIRST_DIVISOR_1			(0 << 20)
+#define MQ_GC_GMCLK_FIRST_DIVISOR_1_5			(1 << 20)
+#define MQ_GC_GMCLK_FIRST_DIVISOR_2_5			(2 << 20)
+#define MQ_GC_GMCLK_FIRST_DIVISOR_3_5			(3 << 20)
+#define MQ_GC_GMCLK_FIRST_DIVISOR_4_5			(4 << 20)
+#define MQ_GC_GMCLK_FIRST_DIVISOR_5_5			(5 << 20)
+#define MQ_GC_GMCLK_FIRST_DIVISOR_6_5			(6 << 20)
+#define MQ_GC_GMCLK_SECOND_DIVISOR			(0xf << 24)
+#define MQ_GC_GMCLK_SECOND_DIVISOR_(v)			((v) << 24)
+#define MQ_GC_SHARP_160x160_HR_TFT_ENABLE    		(1 << 31)
+			u32 power_sequencing;
+#define MQ_GC_POWER_UP_INTERVAL				(7 << 0)
+#define MQ_GC_POWER_UP_INTERVAL_1	    		(0 << 0)
+#define MQ_GC_POWER_UP_INTERVAL_2	    		(1 << 0)
+#define MQ_GC_POWER_UP_INTERVAL_4	    		(2 << 0)
+#define MQ_GC_POWER_UP_INTERVAL_8	    		(3 << 0)
+#define MQ_GC_POWER_UP_INTERVAL_16    			(4 << 0)
+#define MQ_GC_POWER_UP_INTERVAL_32    			(5 << 0)
+#define MQ_GC_POWER_UP_INTERVAL_48    			(6 << 0)
+#define MQ_GC_POWER_UP_INTERVAL_64    			(7 << 0)
+#define MQ_GC_FAST_POWER_UP				(1 << 3)
+#define MQ_GC_POWER_DOWN_INTERVAL			(1 << 4)
+#define MQ_GC_POWER_DOWN_INTERVAL_1	    		(0 << 4)
+#define MQ_GC_POWER_DOWN_INTERVAL_2	    		(1 << 4)
+#define MQ_GC_POWER_DOWN_INTERVAL_4	    		(2 << 4)
+#define MQ_GC_POWER_DOWN_INTERVAL_8	    		(3 << 4)
+#define MQ_GC_POWER_DOWN_INTERVAL_16    		(4 << 4)
+#define MQ_GC_POWER_DOWN_INTERVAL_32    		(5 << 4)
+#define MQ_GC_POWER_DOWN_INTERVAL_48    		(6 << 4)
+#define MQ_GC_POWER_DOWN_INTERVAL_64    		(7 << 4)
+#define MQ_GC_FAST_POWER_DOWN				(1 << 7)
+			u32 horizontal_display;
+#define MQ_GC_HORIZONTAL_DISPLAY_TOTAL			(0x7ff << 0)
+#define MQ_GC_HORIZONTAL_DISPLAY_TOTAL_(s)    		((s) << 0)
+#define MQ_GC_HORIZONTAL_DISPLAY_END			(0x7ff << 16)
+#define MQ_GC_HORIZONTAL_DISPLAY_END_(s)    		((s) << 16)
+			u32 vertical_display;
+#define MQ_GC_VERTICAL_DISPLAY_TOTAL			(0x3ff << 0)
+#define MQ_GC_VERTICAL_DISPLAY_TOTAL_(s)		((s) << 0)
+#define MQ_GC_VERTICAL_DISPLAY_END			(0x3ff << 16)
+#define MQ_GC_VERTICAL_DISPLAY_END_(s)			((s) << 16)
+			u32 horizontal_sync;
+#define MQ_GC_HORIZONTAL_SYNC_START			(0x7ff << 0)
+#define MQ_GC_HORIZONTAL_SYNC_START_(s)			((s) << 0)
+#define MQ_GC_HORIZONTAL_SYNC_END			(0x7ff << 16)
+#define MQ_GC_HORIZONTAL_SYNC_END_(s)			((s) << 16)
+			u32 vertical_sync;
+#define MQ_GC_VERTICAL_SYNC_START			(0x3ff << 0)
+#define MQ_GC_VERTICAL_SYNC_START_(s)			((s) << 0)
+#define MQ_GC_VERTICAL_SYNC_END				(0x3ff << 16)
+#define MQ_GC_VERTICAL_SYNC_END_(s)			((s) << 16)
+			u32 horizontal_counter_init;	/* set to 0 */
+			u32 vertical_counter_init;	/* set to 0 */
+			u32 horizontal_window;
+#define MQ_GC_HORIZONTAL_WINDOW_START			(0x7ff << 0)
+#define MQ_GC_HORIZONTAL_WINDOW_START_(s)		((s) << 0)
+#define MQ_GC_HORIZONTAL_WINDOW_WIDTH			(0x7ff << 16)
+#define MQ_GC_HORIZONTAL_WINDOW_WIDTH_(s)		((s) << 16)
+                        u32 vertical_window;
+#define MQ_GC_VERTICAL_WINDOW_START			(0x3ff << 0)
+#define MQ_GC_VERTICAL_WINDOW_START_(s)			((s) << 0)
+#define MQ_GC_VERTICAL_WINDOW_HEIGHT			(0x3ff << 16)
+#define MQ_GC_VERTICAL_WINDOW_HEIGHT_(s)		((s) << 16)
+			u32 reserved_28;
+			u32 line_clock;
+#define MQ_GC_LINE_CLOCK_START				(0x7ff << 0)
+#define MQ_GC_LINE_CLOCK_START_(s)			((s) << 0)
+#define MQ_GC_LINE_CLOCK_END				(0x7ff << 16)
+#define MQ_GC_LINE_CLOCK_END_(s)			((s) << 16)
+			u32 window_start_address;
+			u32 alternate_window_start_address;
+			u32 window_stride;
+			u32 reserved_3c;
+			u32 cursor_position;
+#define MQ_GC_HORIZONTAL_CURSOR_START			(0x7ff << 0)
+#define MQ_GC_HORIZONTAL_CURSOR_START_(s)		((s) << 0)
+#define MQ_GC_VERTICAL_CURSOR_START			(0x3ff << 16)
+#define MQ_GC_VERTICAL_CURSOR_START_(s)			((s) << 16)
+			u32 cursor_start_address;
+#define MQ_GC_CURSOR_START_ADDRESS			(0xff << 0)
+#define MQ_GC_CURSOR_START_ADDRESS_(s)			((s) << 0)
+#define MQ_GC_HORIZONTAL_CURSOR_OFFSET			(0x3f << 16)
+#define MQ_GC_HORIZONTAL_CURSOR_OFFSET_(s)		((s) << 16)
+#define MQ_GC_VERTICAL_CURSOR_OFFSET			(0x3f << 24)
+#define MQ_GC_VERTICAL_CURSOR_OFFSET_(s)		((s) << 24)
+			u32 cursor_foreground;
+			u32 cursor_background;
+			u32 reserved_50_64[6];
+			u32 frame_clock_control;
+#define MQ_GC_FRAME_CLOCK_START				(0x3ff << 0)
+#define MQ_GC_FRAME_CLOCK_START_(s)	    		((s) << 0)
+#define MQ_GC_FRAME_CLOCK_END				(0x3ff << 16)
+#define MQ_GC_FRAME_CLOCK_END_(s)	    		((s) << 16)
+			u32 misc_signals;
+			u32 horizonal_parameter;
+			u32 vertical_parameter;
+			u32 window_line_start_address;
+			u32 cursor_line_start_address;
+		};
+		u32 a[0x20];
+		u8 size[128];
+	} GC;
+	/*
+	 * Graphics Engine			0x200
+	 */
+	union {
+		u32 a[0x14];
+		u8 size[128];
+	} GE;
+	/*
+	 * Synchronous Serial Controller	0x280
+	 */
+	union {
+		u32 a[16];
+		u8 size[128];
+	} SSC;
+	/*
+	 * Serial Peripheral Interface		0x300
+	 */
+	union {
+		struct {
+			u32 control;
+			u32 status;
+			u32 data;
+			u32 time_gap;
+			u32 gpio_mode;
+                        u32 count;
+			u32 fifo_threshold;
+			u32 led_control;
+			u32 blue_gpio_mode;
+		};
+		u32 a[9];
+		u8 size[128];
+	} SPI;
+	/*
+	 * Device Configuration Space		0x380
+	 */
+	union {
+		struct {
+			u32 config_0;
+#define MQ_CONFIG_LITTLE_ENDIAN_ENABLE			(1 << 0)
+#define MQ_CONFIG_BYTE_SWAPPING				(1 << 1)
+			u32 config_1;
+#define MQ_CONFIG_18_OSCILLATOR				(3 << 0)
+#define MQ_CONFIG_18_OSCILLATOR_DISABLED    		(0 << 0)
+#define MQ_CONFIG_18_OSCILLATOR_OSCFO			(1 << 0)
+#define MQ_CONFIG_18_OSCILLATOR_INTERNAL    		(3 << 0)
+#define MQ_CONFIG_CPU_CLOCK_DIVISOR			(1 << 8)
+#define MQ_CONFIG_DTACK_CONTROL				(1 << 9)
+#define MQ_CONFIG_INTERFACE_SYNCHRONIZER_CONTROL    	(1 << 10)
+#define MQ_CONFIG_WRITE_DATA_LATCH    			(1 << 11)
+#define MQ_CONFIG_CPU_TEST_MODE				(1 << 12)
+#define MQ_CONFIG_SOFTWARE_CHIP_RESET			(1 << 16)
+#define MQ_CONFIG_WEAK_PULL_DOWN_FMOD			(1 << 28)
+#define MQ_CONFIG_WEAK_PULL_DOWN_FLCLK			(1 << 29)
+#define MQ_CONFIG_WEAK_PULL_DOWN_PWM0			(1 << 30)
+#define MQ_CONFIG_WEAK_PULL_DOWN_PWM1			(1 << 31)
+                        u32 config_2;
+#define MQ_CONFIG_CC_MODULE_ENABLE			(1 << 0)
+                        u32 config_3;
+#define MQ_CONFIG_BUS_INTERFACE_MODE			(0x7f << 0)
+#define MQ_CONFIG_BUS_INTERFACE_MODE_SH7750    		(0x01 << 0)
+#define MQ_CONFIG_BUS_INTERFACE_MODE_SH7709    		(0x02 << 0)
+#define MQ_CONFIG_BUS_INTERFACE_MODE_VR4111    		(0x04 << 0)
+#define MQ_CONFIG_BUS_INTERFACE_MODE_SA1110    		(0x08 << 0)
+#define MQ_CONFIG_BUS_INTERFACE_MODE_PCI    		(0x20 << 0)
+#define MQ_CONFIG_BUS_INTERFACE_MODE_DRAGONBALL_EZ    	(0x40 << 0)
+			u32 config_4;
+#define MQ_CONFIG_GE_FORCE_BUSY_GLOBAL			(1 << 0)
+#define MQ_CONFIG_GE_FORCE_BUSY_LOCAL			(1 << 1)
+#define MQ_CONFIG_GE_CLOCK_SELECT    			(1 << 2)
+#define MQ_CONFIG_GE_CLOCK_DIVIDER    			(7 << 3)
+#define MQ_CONFIG_GE_CLOCK_DIVIDER_1			(0 << 3)
+#define MQ_CONFIG_GE_CLOCK_DIVIDER_1_5			(1 << 3)
+#define MQ_CONFIG_GE_CLOCK_DIVIDER_2			(2 << 3)
+#define MQ_CONFIG_GE_CLOCK_DIVIDER_2_5			(3 << 3)
+#define MQ_CONFIG_GE_CLOCK_DIVIDER_3			(4 << 3)
+#define MQ_CONFIG_GE_CLOCK_DIVIDER_4			(5 << 3)
+#define MQ_CONFIG_GE_CLOCK_DIVIDER_5			(6 << 3)
+#define MQ_CONFIG_GE_CLOCK_DIVIDER_6			(7 << 3)
+#define MQ_CONFIG_GE_FIFO_RESET				(1 << 6)
+#define MQ_CONFIG_GE_SOURCE_FIFO_RESET			(1 << 7)
+#define MQ_CONFIG_USB_SE0_DETECT    			(1 << 8)
+#define MQ_CONFIG_UHC_DYNAMIC_POWER 	   		(1 << 9)
+#define MQ_CONFIG_USB_COUNTER_SCALE_ENABLE    		(1 << 10)
+#define MQ_CONFIG_UHC_READ_TEST_ENABLE    		(1 << 11)
+#define MQ_CONFIG_UHC_TEST_MODE_DATA    		(0xf << 12)
+#define MQ_CONFIG_UHC_TRANSCEIVER_TEST_ENABLE		(1 << 16)
+#define MQ_CONFIG_UHC_OVER_CURRENT_DETECT  	  	(1 << 17)
+#define MQ_CONFIG_UDC_DYNAMIC_POWER_ENABLE    		(1 << 18)
+#define MQ_CONFIG_UHC_TRANSCEIVER_ENABLE    		(1 << 19)
+#define MQ_CONFIG_UDC_TRANSCEIVER_ENABLE		(1 << 20)
+#define MQ_CONFIG_USB_TEST_VECTOR_GENERATION_ENABLE    	(1 << 21)
+			u32 config_5;
+#define MQ_CONFIG_GE_ENABLE				(1 << 0)
+#define MQ_CONFIG_UHC_CLOCK_ENABLE			(1 << 1)
+#define MQ_CONFIG_UDC_CLOCK_ENABLE   	 		(1 << 2)
+			u32 config_6;
+			u32 config_7;
+			u32 config_8;
+		};
+		u32 a[9];
+		u8 size[128];
+	} DC;
+	/*
+	 * PCI Configuration Header
+	 */
+	union {
+		/* little endian */
+		struct {
+			u16 vendor_id;
+#define MQ_PCI_VENDORID					0x4d51
+                        u16 device_id;
+// This is a wild guess
+#define MQ_PCI_DEVICEID_1100				0x0100
+#define MQ_PCI_DEVICEID_1132				0x0120
+// No confirmation of this IDs yet
+#define MQ_PCI_DEVICEID_1168				0x0168
+// No confirmation of this IDs yet
+#define MQ_PCI_DEVICEID_1178				0x0178
+#define MQ_PCI_DEVICEID_1188				0x0188
+			u16 command;
+			u16 status;
+			u32 revision_class;
+			u8 cache_line_size;
+			u8 latency_timer;
+			u8 header_type;
+			u8 BIST;
+			u32 bar0;
+			u32 bar1;
+			u32 pad0[4];
+			u32 cardbus_cis;
+			u16 subsystem_vendor_id;
+			u16 subsystem_id;
+			u32 expansion_rom;
+			u8 cap_ptr;
+			u8 pad1[3];
+			u8 interrupt_line;
+			u8 interrupt_pin;
+			u8 min_gnt;
+			u8 max_lat;
+			u8 capability_id;
+			u8 next_item_ptr;
+			u16 power_management_capabilities;
+			u16 power_management_control_status;
+			u8 PMCSR_BSE_bridge;
+			u8 data;
+		};
+		u8 size[256];
+	} PCI;
+	/*
+	 * USB Host Controller (0x500)
+	 */
+	union {
+		u32 a[23];
+		u8 size[256];
+	} UHC;
+	/*
+	 * Flat Panel Controller (0x600)
+	 */
+	union {
+		struct {
+			u32 control;
+#define MQ_FP_PANEL_TYPE				(0xf << 0)
+#define MQ_FP_PANEL_TYPE_TFT				(0x0 << 0)
+#define MQ_FP_PANEL_TYPE_STN				(0x4 << 0)
+#define MQ_FP_MONOCHROME_SELECT				(1 << 4)
+#define MQ_FP_FLAT_PANEL_INTERFACE    			(7 << 5)
+#define MQ_FP_FLAT_PANEL_INTERFACE_4_BIT    		(0 << 5)
+#define MQ_FP_FLAT_PANEL_INTERFACE_6_BIT    		(1 << 5)
+#define MQ_FP_FLAT_PANEL_INTERFACE_8_BIT    		(2 << 5)
+#define MQ_FP_FLAT_PANEL_INTERFACE_16_BIT    		(3 << 5)
+#define MQ_FP_DITHER_PATTERN				(3 << 8)
+#define MQ_FP_DITHER_PATTERN_1				(1 << 8)
+#define MQ_FP_DITHER_BASE_COLOR				(7 << 12)
+#define MQ_FP_DITHER_BASE_COLOR_DISABLE			(7 << 12)
+#define MQ_FP_DITHER_BASE_COLOR_3_BITS			(3 << 12)
+#define MQ_FP_DITHER_BASE_COLOR_4_BITS			(4 << 12)
+#define MQ_FP_DITHER_BASE_COLOR_5_BITS			(5 << 12)
+#define MQ_FP_DITHER_BASE_COLOR_6_BITS			(6 << 12)
+#define MQ_FP_ALTERNATE_WINDOW_CONTROL			(1 << 15)
+#define MQ_FP_FRC_CONTROL				(3 << 16)
+#define MQ_FP_FRC_CONTROL_2_LEVEL    			(0 << 16)
+#define MQ_FP_FRC_CONTROL_4_LEVEL    			(1 << 16)
+#define MQ_FP_FRC_CONTROL_8_LEVEL    			(2 << 16)
+#define MQ_FP_FRC_CONTROL_16_LEVEL    			(3 << 16)
+#define MQ_FP_POLY_SI_TFT_ENABLE    			(1 << 19)
+#define MQ_FP_POLY_SI_TFT_FIRST_LINE			(1 << 20)
+#define MQ_FP_POLY_SI_TFT_DISPLAY_DATA_CONTROL		(1 << 21)
+#define MQ_FP_APP_NOTE_SAYS_SET_THIS			(1 << 22)
+			u32 pin_control_1;
+#define MQ_FP_DISABLE_FLAT_PANEL_PINS			(1 << 0)
+#define MQ_FP_DISPLAY_ENABLE				(1 << 2)
+#define MQ_FP_AC_MODULATION_ENABLE    			(1 << 3)
+#define MQ_FP_PWM_CLOCK_ENABLE				(1 << 5)
+#define MQ_FP_TFT_SHIFT_CLOCK_SELECT			(1 << 6)
+#define MQ_FP_SHIFT_CLOCK_MASK				(1 << 7)
+#define MQ_FP_FHSYNC_CONTROL				(1 << 8)
+#define MQ_FP_STN_SHIFT_CLOCK_CONTROL			(1 << 9)
+#define MQ_FP_STN_EXTRA_LP_ENABLE    			(1 << 10)
+#define MQ_FP_TFT_DISPLAY_ENABLE_SELECT			(3 << 12)
+#define MQ_FP_TFT_DISPLAY_ENABLE_SELECT_00    		(0 << 12)
+#define MQ_FP_TFT_DISPLAY_ENABLE_SELECT_01    		(1 << 12)
+#define MQ_FP_TFT_DISPLAY_ENABLE_SELECT_10    		(2 << 12)
+#define MQ_FP_TFT_DISPLAY_ENABLE_SELECT_11    		(3 << 12)
+#define MQ_FP_TFT_HORIZONTAL_SYNC_SELECT    		(3 << 14)
+#define MQ_FP_TFT_HORIZONTAL_SYNC_SELECT_00    		(0 << 14)
+#define MQ_FP_TFT_HORIZONTAL_SYNC_SELECT_01    		(1 << 14)
+#define MQ_FP_TFT_HORIZONTAL_SYNC_SELECT_10    		(2 << 14)
+#define MQ_FP_TFT_HORIZONTAL_SYNC_SELECT_11    		(3 << 14)
+#define MQ_FP_TFT_VERTICAL_SYNC_SELECT    		(3 << 16)
+#define MQ_FP_TFT_VERTICAL_SYNC_SELECT_00    		(0 << 16)
+#define MQ_FP_TFT_VERTICAL_SYNC_SELECT_01    		(1 << 16)
+#define MQ_FP_TFT_VERTICAL_SYNC_SELECT_10    		(2 << 16)
+#define MQ_FP_TFT_VERTICAL_SYNC_SELECT_11    		(3 << 16)
+#define MQ_FP_LINE_CLOCK_CONTROL    			(1 << 18)
+#define MQ_FP_ALTERNATE_LINE_CLOCK_CONTROL    		(1 << 19)
+#define MQ_FP_FMOD_CLOCK_CONTROL    			(1 << 20)
+#define MQ_FP_FMOD_FRAME_INVERSION    			(1 << 21)
+#define MQ_FP_FMOD_FREQUENCY_CONTROL 			(1 << 22)
+#define MQ_FP_FMOD_SYNCHRONOUS_RESET  			(1 << 23)
+#define MQ_FP_SHIFT_CLOCK_DELAY   			(7 << 24)
+#define MQ_FP_EXTENDED_LINE_CLOCK_CONTROL    		(1 << 27)
+			u32 output_control;
+			u32 input_control;
+#define MQ_FP_ENVDD					(1 << 0)
+#define MQ_FP_ENVEE					(1 << 1)
+#define MQ_FP_FD2					(1 << 2)
+#define MQ_FP_FD3					(1 << 3)
+#define MQ_FP_FD4					(1 << 4)
+#define MQ_FP_FD5					(1 << 5)
+#define MQ_FP_FD6					(1 << 6)
+#define MQ_FP_FD7					(1 << 7)
+#define MQ_FP_FD10					(1 << 10)
+#define MQ_FP_FD11					(1 << 11)
+#define MQ_FP_FD12					(1 << 12)
+#define MQ_FP_FD13					(1 << 13)
+#define MQ_FP_FD14					(1 << 14)
+#define MQ_FP_FD15					(1 << 15)
+#define MQ_FP_FD18					(1 << 18)
+#define MQ_FP_FD19					(1 << 19)
+#define MQ_FP_FD20					(1 << 20)
+#define MQ_FP_FD21					(1 << 21)
+#define MQ_FP_FD22					(1 << 22)
+#define MQ_FP_FD23					(1 << 23)
+#define MQ_FP_FSCLK					(1 << 24)
+#define MQ_FP_FDE					(1 << 25)
+#define MQ_FP_FHSYNC					(1 << 26)
+#define MQ_FP_FVSYNC					(1 << 27)
+#define MQ_FP_FMOD					(1 << 28)
+#define MQ_FP_FLCLK					(1 << 29)
+#define MQ_FP_PWM0					(1 << 30)
+#define MQ_FP_PWM1					(1 << 31)
+			u32 stn_panel_control;
+			u32 polarity_control;
+			u32 pin_output_select_0;
+			u32 pin_output_select_1;
+			u32 pin_output_data;
+			u32 pin_input_data;
+			u32 pin_weak_pull_down;
+			u32 additional_pin_output_select;
+			u32 dummy1;
+			u32 dummy2;
+			u32 test_control;
+			u32 pulse_width_mod_control;
+			u32 frc_pattern[32];
+			u32 frc_weight;
+			u32 pwm_clock_selector_c8;
+			u32 pwm_clock_selector_cc;
+			u32 pwm_clock_selector_d0;
+			u32 pwm_clock_selector_d4;
+			u32 frc_weight_d8;
+			u32 frc_weight_dc;
+		};
+		u32 a[0x80];
+		u8 size[512];
+	} FP;
+	/*
+	 * Color Palette (0x800)
+	 */
+	union {
+		struct {
+			u32 palette[256];
+		};
+		u32 a[256];
+		u8 size[1024];
+	} CMAP;
+	/*
+	 * Source FIFO Space (0xc00)
+	 */
+	union {
+                u32 a[256];
+		u8 size[1024];
+	} FIFO;
+	/*
+	 * USB Device Controller (0x1000)
+	 */
+	union {
+		struct {
+			u32 control;
+#define MQ_UDC_SUSPEND_ENABLE				(1 << 0)
+#define MQ_UDC_REMOTEHOST_WAKEUP_ENABLE			(1 << 3)
+#define MQ_UDC_EP2_ISOCHRONOUS				(1 << 5)
+#define MQ_UDC_EP3_ISOCHRONOUS				(1 << 6)
+#define MQ_UDC_WAKEUP_USBHOST				(1 << 8)
+#define MQ_UDC_IEN_SOF					(1 << 16)
+#define MQ_UDC_IEN_EP0_TX				(1 << 17)
+#define MQ_UDC_IEN_EP0_RX				(1 << 18)
+#define MQ_UDC_IEN_EP1_TX				(1 << 19)
+#define MQ_UDC_IEN_EP2_TX_EOT				(1 << 20)
+#define MQ_UDC_IEN_EP3_RX_EOT				(1 << 21)
+#define MQ_UDC_IEN_DMA_TX				(1 << 22)
+#define MQ_UDC_IEN_DMA_RX				(1 << 23)
+#define MQ_UDC_IEN_DMA_RX_EOT				(1 << 24)
+#define MQ_UDC_IEN_GLOBAL_SUSPEND			(1 << 25)
+#define MQ_UDC_IEN_WAKEUP				(1 << 26)
+#define MQ_UDC_IEN_RESET				(1 << 27)
+			u32 address;
+#define MQ_UDC_ADDRESS_MASK				(127)
+			u32 frame_number;
+#define MQ_UDC_FRAME_MASK				(2047)
+#define MQ_UDC_FRAME_CORRUPTED				(1 << 11)
+#define MQ_UDC_FRAME_NEW				(1 << 12)
+#define MQ_UDC_FRAME_MISSING				(1 << 13)
+#define MQ_UDC_EP2_DATA_MISSING				(1 << 14)
+#define MQ_UDC_EP3_DATA_MISSING				(1 << 15)
+			u32 ep0txcontrol;
+#define MQ_UDC_TX_EDT					(1 << 1)
+#define MQ_UDC_STALL					(1 << 2)
+#define MQ_UDC_TX_PID_DATA1				(1 << 3)
+#define MQ_UDC_TX_LAST_ENABLE_SHIFT			(4)
+#define MQ_UDC_TX_LAST_ENABLE_MASK			(15 << MQ_UDC_TX_LAST_ENABLE_SHIFT)
+#define MQ_UDC_TX_LAST_ENABLE(x)  			(((1 << (1 + (((x) - 1) & 3))) - 1) << MQ_UDC_TX_LAST_ENABLE_SHIFT)
+#define MQ_UDC_CLEAR_FIFO				(1 << 8)
+			u32 ep0txstatus;
+#define MQ_UDC_ACK					(1 << 0)
+#define MQ_UDC_ERR					(1 << 1)
+#define MQ_UDC_TIMEOUT					(1 << 2)
+#define MQ_UDC_EOT					(1 << 3)
+#define MQ_UDC_FIFO_OVERRUN				(1 << 6)
+#define MQ_UDC_NAK					(1 << 7)
+#define MQ_UDC_FIFO_SHIFT				(9)
+#define MQ_UDC_FIFO_MASK				(7)
+#define MQ_UDC_FIFO(x)					(((x) >> MQ_UDC_FIFO_SHIFT) & MQ_UDC_FIFO_MASK)
+#define MQ_UDC_FIFO_DEPTH				(4)
+			u32 ep0rxcontrol;
+			/* Most bitmasks shared with txstatus */
+			u32 ep0rxstatus;
+#define MQ_UDC_RX_PID_DATA1				(1 << 4)
+#define MQ_UDC_RX_TOKEN_SETUP				(1 << 5)
+#define MQ_UDC_RX_VALID_BYTES_SHIFT			(12)
+#define MQ_UDC_RX_VALID_BYTES_MASK			(3)
+#define MQ_UDC_RX_VALID_BYTES(x)			(((x) >> MQ_UDC_RX_VALID_BYTES_SHIFT) & MQ_UDC_RX_VALID_BYTES_MASK)
+			u32 ep0rxfifo;
+			u32 ep0txfifo;
+			/* Most bitmasks shared with ep0txcontrol */
+			u32 ep1control;
+#define MQ_UDC_EP_ENABLE				(1 << 0)
+			/* Most bitmasks shared with ep0txstatus */
+			u32 ep1status;
+			u32 ep1fifo;
+			/* Most bitmasks shared with ep0txcontrol */
+			u32 ep2control;
+#define MQ_UDC_FORCE_DATA0				(1 << 3)
+#define MQ_UDC_FIFO_THRESHOLD_SHIFT			(9)
+#define MQ_UDC_FIFO_THRESHOLD_MASK			(7 << MQ_UDC_FIFO_THRESHOLD_SHIFT)
+#define MQ_UDC_FIFO_THRESHOLD(x)			((x) << MQ_UDC_FIFO_THRESHOLD_SHIFT)
+			/* Most bitmasks shared with ep0txstatus */
+			u32 ep2status;
+			/* Most bitmasks shared with ep0rxcontrol */
+			u32 ep3control;
+			/* Most bitmasks shared with ep0rxstatus */
+			u32 ep3status;
+			u32 intstatus;
+#define MQ_UDC_INT_SOF					(1 << 0)
+#define MQ_UDC_INT_EP0_TX				(1 << 1)
+#define MQ_UDC_INT_EP0_RX				(1 << 2)
+#define MQ_UDC_INT_EP1_TX				(1 << 3)
+#define MQ_UDC_INT_EP2_TX_EOT				(1 << 4)
+#define MQ_UDC_INT_EP3_RX_EOT				(1 << 5)
+#define MQ_UDC_INT_DMA_TX				(1 << 6)
+#define MQ_UDC_INT_DMA_RX				(1 << 7)
+#define MQ_UDC_INT_DMA_RX_EOT				(1 << 8)
+#define MQ_UDC_INT_GLOBAL_SUSPEND			(1 << 9)
+#define MQ_UDC_INT_WAKEUP				(1 << 10)
+#define MQ_UDC_INT_RESET				(1 << 11)
+#define MQ_UDC_INT_EP0		(MQ_UDC_INT_EP0_TX | MQ_UDC_INT_EP0_RX)
+#define MQ_UDC_INT_EP1		(MQ_UDC_INT_EP1_TX)
+#define MQ_UDC_INT_EP2		(MQ_UDC_INT_EP2_TX_EOT | MQ_UDC_INT_DMA_TX)
+#define MQ_UDC_INT_EP3		(MQ_UDC_INT_EP3_RX_EOT | MQ_UDC_INT_DMA_RX | \
+				 MQ_UDC_INT_DMA_RX_EOT)
+			u32 testcontrol1;
+			u32 testcontrol2;
+			u32 unused [5];
+			/* This is for endpoint 2 */
+			u32 dmatxcontrol;
+#define MQ_UDC_DMA_ENABLE				(1 << 0)
+#define MQ_UDC_DMA_PINGPONG				(1 << 1)
+#define MQ_UDC_DMA_NUMBUFF_SHIFT			(2)
+#define MQ_UDC_DMA_NUMBUFF_MASK				(3 << MQ_UDC_DMA_NUMBUFF_SHIFT)
+#define MQ_UDC_DMA_NUMBUFF(x)				((x - 1) << MQ_UDC_DMA_NUMBUFF_SHIFT)
+#define MQ_UDC_DMA_BUFF1_OWNER				(1 << 8)
+#define MQ_UDC_DMA_BUFF2_OWNER				(1 << 9)
+#define MQ_UDC_DMA_BUFF1_EOT				(1 << 10)
+#define MQ_UDC_DMA_BUFF2_EOT				(1 << 11)
+			u32 dmatxdesc1;
+#define MQ_UDC_DMA_BUFFER_ADDR_SHIFT			(0)
+#define MQ_UDC_DMA_BUFFER_ADDR_MASK			(32767)
+#define MQ_UDC_DMA_BUFFER_ADDR(x)			(((x) >> 3) << MQ_UDC_DMA_BUFFER_ADDR_SHIFT)
+#define MQ_UDC_DMA_BUFFER_SIZE_SHIFT			(16)
+#define MQ_UDC_DMA_BUFFER_SIZE_MASK			(4095)
+#define MQ_UDC_DMA_BUFFER_SIZE(x)			((x - 1) << MQ_UDC_DMA_BUFFER_SIZE_SHIFT)
+#define MQ_UDC_DMA_BUFFER_LAST				(1 << 28)
+			u32 dmatxdesc2;
+			/* This shares bitmasks with dmatxcontrol, but refers to endpoint 3 */
+			u32 dmarxcontrol;
+#define MQ_UDC_ISO_TRANSFER_END				(1 << 16)
+			u32 dmarxdesc1;
+#define MQ_UDC_DMA_BUFFER_EADDR_SHIFT			(16)
+#define MQ_UDC_DMA_BUFFER_EADDR_MASK			(32767)
+#define MQ_UDC_DMA_BUFFER_EADDR(x)			(((x - 1) >> 3) << MQ_UDC_DMA_BUFFER_EADDR_SHIFT)
+			u32 dmarxdesc2;
+			u32 dmabuff1size;
+			u32 dmabuff2size;
+		};
+		u32 a[19];
+		u8 size[128];
+	} UDC;
+};
+
+/*
+ * Instead of attempting to figure out how to program this device,
+ * just use canned values for the known display types.
+ */
+struct mediaq11xx_init_data {
+	u32 DC[0x6];
+	u32 CC[0x5];
+	u32 MIU[0x7];
+	u32 GC[0x1b];
+	u32 FP[0x80];
+        u32 GE[0x14];
+        u32 SPI[0x9];
+	void (*set_power) (int on);
+};
+
+/* Chip flavour */
+enum
+{
+	CHIP_MEDIAQ_1100,
+	CHIP_MEDIAQ_1132,
+	CHIP_MEDIAQ_1168,
+	CHIP_MEDIAQ_1178,
+	CHIP_MEDIAQ_1188
+};
+
+/* This structure is used by the basic MediaQ SoC driver to allow client
+ * drivers to use its functionality. Rather than doing a bunch of
+ * EXPORT_SYMBOL's we're storing a pointer to this structure in every
+ * device->platform_data, and the device_driver receives it with
+ * every call.
+ */
+struct mediaq11xx_base {
+	/* Memory that is serialized between CPU and gfx engine */
+	u8 *gfxram;
+	/* Memory that is not synchronized between CPU and GE.
+	 * WARNING: NEVER TOUCH MEMORY ALLOCATED WITH THE 'gfx' FLAG
+	 * (SEE BELOW) VIA THE "ram" POINTER!!! SUCH ADDRESSES CAN BE
+	 * BOGUS AND POSSIBLY BELONG TO OTHER PROCESS OR DRIVER!!!
+	 */
+	volatile u8 *ram;
+	/* MediaQ registers */
+	volatile struct mediaq11xx_regs *regs;
+	/* Chip flavour */
+	int chip;
+	/* Chip name (1132, 1178 etc) */
+	const char *chipname;
+	/* The physical address of MediaQ registers */
+	u32 paddr_regs;
+	/* Physical address of serialized & non-serialized RAM */
+	u32 paddr_gfxram, paddr_ram;
+#ifdef MQ_IRQ_MULTIPLEX
+	/* Base IRQ number of our allocated interval of IRQs */
+	int irq_base;
+#endif
+
+	/* Set the MediaQ GPIO to given state. Of course only those GPIOs
+	 * are supported that exist (see MediaQ specs).
+	 */
+	int (*set_GPIO) (struct mediaq11xx_base *zis, int num, int state);
+/* Change GPIO input/output mode */
+#define MQ_GPIO_CHMODE	0x00000010
+/* Disable GPIO pin */
+#define MQ_GPIO_NONE	0x00000000
+/* Enable GPIO input */
+#define MQ_GPIO_IN	0x00000001
+/* Enable GPIO output */
+#define MQ_GPIO_OUT	0x00000002
+/* Output a '0' on the GPIO pin (if OE is set) */
+#define MQ_GPIO_0	0x00000020
+/* Output a '1' on the GPIO pin (if OE is set) */
+#define MQ_GPIO_1	0x00000040
+/* Enable the pullup register (works only for GPIOs 50-53) */
+#define MQ_GPIO_PULLUP	0x00000080
+/* Handy shortcut - set some GPIO pin to output a '0' */
+#define MQ_GPIO_OUT0	(MQ_GPIO_CHMODE | MQ_GPIO_OUT | MQ_GPIO_0)
+/* Handy shortcut - set some GPIO pin to output an '1' */
+#define MQ_GPIO_OUT1	(MQ_GPIO_CHMODE | MQ_GPIO_OUT | MQ_GPIO_1)
+/* Set the MediaQ GPIO to input mode */
+#define MQ_GPIO_INPUT	(MQ_GPIO_CHMODE | MQ_GPIO_IN)
+
+	/* Get the state of a GPIO pin. If pin is in output mode, it
+	 * returns the pin output value; if pin is in input mode it
+	 * reads the logical level on the pin.
+	 */
+	int (*get_GPIO) (struct mediaq11xx_base *zis, int num);
+
+	/* Apply/remove power to a subdevice.
+	 * The base SoC driver keeps a count poweron requests for every
+	 * subdevice; when a specific counter reaches zero the subdevice
+	 * is powered off. For a list of subdev_id's see the MEDIAQ_11XX_XXX
+         * constants in soc-device.h. When all counts for all subdevices
+         * reaches zero, the MediaQ chip is totally powered off.
+	 */
+	void (*set_power) (struct mediaq11xx_base *zis, int subdev_id, int enable);
+
+	/* Query the power on count of a subdevice (0 - off, >0 - on) */
+	int (*get_power) (struct mediaq11xx_base *zis, int subdev_id);
+
+	/* Allocate a portion of MediaQ RAM. The returned pointer is a
+	 * a memory offset from the start of MediaQ RAM; to get a virtual
+	 * address you must add it to either "gfxram" or "ram" pointers.
+	 * If there is not enough free memory, function returns (u32)-1.
+	 * Memory allocated with the 'gfx=1' flag should be always accessed 
+	 * via the 'gfxram' pointer; however the reverse (accessing 'gfx=0'
+	 * memory via the 'gfxram' pointer) is allowed. This is a MediaQ 11xx
+	 * limitation: it doesn't allow access to first 8K of RAM via the
+	 * graphics-engine-unsynchronized window.
+	 */
+	u32 (*alloc) (struct mediaq11xx_base *zis, unsigned bytes, int gfx);
+
+	/* Free a portion of MediaQ RAM, previously allocated by malloc() */
+	void (*free) (struct mediaq11xx_base *zis, u32 addr, unsigned bytes);
+};
+
+/**
+ * Increment the reference counter of the MediaQ base driver module.
+ * You must call this before enumerating MediaQ drivers; otherwise you
+ * can end with a pointer that points to nowhere in the case when driver
+ * is unloaded between mq_driver_enum() and when you use it.
+ */
+extern int mq_driver_get (void);
+
+/**
+ * Decrement mediaq base SoC driver reference counter.
+ */
+extern void mq_driver_put (void);
+
+/**
+ * Query a list of all MediaQ device drivers.
+ * You must lock the driver in memory by calling mq_driver_get() before
+ * calling this function.
+ */
+extern int mq_device_enum (struct mediaq11xx_base **list, int list_size);
+
+#endif  /* _PLATFORM_MEDIAQ11XX */
diff --git a/drivers/platform/mq11xx_base.c b/drivers/platform/mq11xx_base.c
new file mode 100644
--- /dev/null
+++ b/drivers/platform/mq11xx_base.c
@@ -0,0 +1,1390 @@
+/*
+ * System-on-Chip (SoC) driver for MediaQ 1100/1132 chips.
+ *
+ * Copyright (C) 2003 Andrew Zabolotny <anpaza@mail.ru>
+ * Portions copyright (C) 2003 Keith Packard
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/config.h>
+#include <linux/device.h>
+#include <linux/platform.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <asm/io.h>
+
+#include "mq11xx.h"
+
+#ifdef MQ_IRQ_MULTIPLEX
+#  include <asm/irq.h>
+#  include <asm/mach/irq.h>
+#endif
+
+#if 0
+#  define debug(s, args...) printk (KERN_INFO s, ##args)
+#else
+#  define debug(s, args...)
+#endif
+#define debug_func(s, args...) debug ("%s: " s, __FUNCTION__, ##args)
+
+/* Bitmasks for distinguishing resources for different sets of MediaQ chips */
+#define MQ_MASK_1100		(1 << CHIP_MEDIAQ_1100)
+#define MQ_MASK_1132		(1 << CHIP_MEDIAQ_1132)
+#define MQ_MASK_1168		(1 << CHIP_MEDIAQ_1168)
+#define MQ_MASK_1178		(1 << CHIP_MEDIAQ_1178)
+#define MQ_MASK_1188		(1 << CHIP_MEDIAQ_1188)
+#define MQ_MASK_ALL		(MQ_MASK_1100 | MQ_MASK_1132 | MQ_MASK_1168 | \
+				 MQ_MASK_1178 | MQ_MASK_1188)
+
+struct mq11xx_subdevice_id {
+	int id;
+};
+
+struct mq_block
+{
+        struct mq11xx_subdevice_id id;
+	const char *name;
+	unsigned start, end;
+	unsigned mask;
+};
+
+#define MQ_SUBDEVS_COUNT	ARRAY_SIZE(mq_blocks)
+#define MQ_SUBDEVS_REAL_COUNT	(MQ_SUBDEVS_COUNT - 2)
+static const struct mq_block mq_blocks[] = {
+	{
+                /* Graphics Controller */
+		{ MEDIAQ_11XX_FB_DEVICE_ID },
+		"mq11xx_fb",
+		0x100, 0x17f,
+		MQ_MASK_ALL
+	},
+	{
+		/* Graphics Engine -- tied to framebuffer subdevice */
+		{ MEDIAQ_11XX_FB_DEVICE_ID },
+		NULL,
+		0x200, 0x27f,
+		MQ_MASK_ALL
+	},
+	{
+		/* Palette Registers -- tied to framebuffer subdevice */
+		{ MEDIAQ_11XX_FB_DEVICE_ID },
+		NULL,
+		0x800, 0xbff,
+		MQ_MASK_ALL
+	},
+	{
+		/* Flat Panel control interface */
+		{ MEDIAQ_11XX_FP_DEVICE_ID },
+		"mq11xx_lcd",
+		0x600, 0x7ff,
+		MQ_MASK_ALL
+	},
+	{
+		/* USB Function subdevice */
+		{ MEDIAQ_11XX_UDC_DEVICE_ID },
+		"mq11xx_udc",
+		0x1000, 0x107f,
+		MQ_MASK_ALL
+	},
+	{
+		/* USB Host subdevice */
+		{ MEDIAQ_11XX_UHC_DEVICE_ID },
+		"mq11xx_uhc",
+		0x500, 0x5ff,
+		MQ_MASK_1132 | MQ_MASK_1188
+	},
+	{
+		/* Serial Port Interface */
+		{ MEDIAQ_11XX_SPI_DEVICE_ID },
+		"mq11xx_spi",
+		0x300, 0x37f,
+		MQ_MASK_1132
+	},
+	{
+		/* Synchronous Serial Channel (I2S) */
+		{ MEDIAQ_11XX_I2S_DEVICE_ID },
+		"mq11xx_i2s",
+		0x280, 0x2ff,
+		MQ_MASK_1132
+	},
+};
+
+static struct {
+	int id;
+	int chip;
+	const char *name;
+} mq_device_id [] =
+{
+	{ MQ_PCI_DEVICEID_1100, CHIP_MEDIAQ_1100, "1100" },
+	{ MQ_PCI_DEVICEID_1132, CHIP_MEDIAQ_1132, "1132" },
+	{ MQ_PCI_DEVICEID_1168, CHIP_MEDIAQ_1168, "1168" },
+	{ MQ_PCI_DEVICEID_1178, CHIP_MEDIAQ_1178, "1178" },
+	{ MQ_PCI_DEVICEID_1188, CHIP_MEDIAQ_1188, "1188" }
+};
+
+/* Keep free block list no less than this value (minimal slab is 32 bytes) */
+#define MEMBLOCK_MINCOUNT	(32 / sizeof (struct mq_freemem_list))
+/* Align MediaQ memory blocks by this amount (MediaQ DMA limitation) */
+#define MEMBLOCK_ALIGN		64
+
+struct mq_freemem_list {
+	u32 addr;
+	u32 size;
+} __attribute__((packed));
+
+struct mq_data
+{
+	/* The exported parameters */
+	struct mediaq11xx_base base;
+	/* MediaQ initialization register data */
+	struct mediaq11xx_init_data *mq_init;
+	/* Number of subdevices */
+	int ndevices;
+	/* The list of subdevices */
+	struct platform_device *devices;
+	/* MediaQ interrupt number */
+	int irq_nr;
+	/* Count the number of poweron requests to every subdevice */
+	u8 power_on [MQ_SUBDEVS_REAL_COUNT];
+	/* Number of free block descriptors */
+	int nfreeblocks, maxfreeblocks;
+	/* The list of free blocks */
+	struct mq_freemem_list *freelist;
+	/* The lock on the free blocks list */
+	spinlock_t mem_lock;
+	/* The amount of RAM at the beginning of address space that
+	   is not accessible through the unsynced window */
+	int unsynced_ram_skip;
+};
+
+/* Pointer to initialized devices.
+ * This is a bad practice, but if you don't need too much from the
+ * MediaQ device (such as turning on/off a couple of GPIOs) you can
+ * use the mq_get_device (int index) to get a pointer to one of
+ * available MediaQ device structures.
+ */
+#define MAX_MQ11XX_DEVICES	8
+static struct mediaq11xx_base *mq_device_list [MAX_MQ11XX_DEVICES];
+static spinlock_t mq_device_list_lock = SPIN_LOCK_UNLOCKED;
+
+#define to_mq_data(n) container_of(n, struct mq_data, base)
+
+/* For PCI & DragonBall register mapping is as described in the specs sheet;
+ * for other microprocessor buses some addresses are tossed (what a perversion).
+ * Worse than that, on MQ1168 and later, the registers are always as normal.
+ */
+#if defined __arm__
+// || defined NEC41xx || defined HITACHI 77xx
+#define MQ_MASK_REGSET1		(MQ_MASK_1168 | MQ_MASK_1178 | MQ_MASK_1188)
+#define MQ_MASK_REGSET2		(MQ_MASK_1100 | MQ_MASK_1132)
+#else
+#define MQ_MASK_REGSET1		MQ_MASK_ALL
+#define MQ_MASK_REGSET2		0
+#endif
+
+static struct mediaq11xx_init_data mqInitValid = {
+    /* DC */
+    {
+	/* dc00 */		0,
+	/* dc01 */		MQ_MASK_ALL,
+	/* dc02 */		MQ_MASK_ALL,
+	/* dc03 */		0,
+	/* dc04 */		MQ_MASK_ALL,
+	/* dc05 */		MQ_MASK_ALL,
+    },
+    /* CC */
+    {
+	/* cc00 */		MQ_MASK_ALL,
+	/* cc01 */		MQ_MASK_ALL,
+	/* cc02 */		MQ_MASK_ALL,
+	/* cc03 */		MQ_MASK_ALL,
+	/* cc04 */		MQ_MASK_ALL,
+    },
+    /* MIU */
+    {
+	/* mm00 */		MQ_MASK_ALL,
+	/* mm01 */		MQ_MASK_ALL,
+	/* mm02 */		MQ_MASK_ALL,
+	/* mm03 */		MQ_MASK_ALL,
+	/* mm04 */		MQ_MASK_ALL,
+	/* mm05 */		MQ_MASK_1168 | MQ_MASK_1178 | MQ_MASK_1188,
+	/* mm06 */		MQ_MASK_1168 | MQ_MASK_1178 | MQ_MASK_1188,
+    },
+    /* GC */
+    {
+	/* gc00 */		MQ_MASK_ALL,
+	/* gc01 */		MQ_MASK_ALL,
+	/* gc02 */		MQ_MASK_ALL,
+	/* gc03 */		MQ_MASK_ALL,
+	/* gc04 */		MQ_MASK_ALL,
+	/* gc05 */		MQ_MASK_ALL,
+	/* gc06 NOT SET */	0,
+	/* gc07 NOT SET */	0,
+	/* gc08 */		MQ_MASK_ALL,
+	/* gc09 */		MQ_MASK_ALL,
+	/* gc0a */		MQ_MASK_ALL,
+	/* gc0b */		MQ_MASK_ALL,
+	/* gc0c */		MQ_MASK_ALL,
+	/* gc0d */		MQ_MASK_ALL,
+	/* gc0e */		MQ_MASK_ALL,
+	/* gc0f NOT SET */	0,
+	/* gc10 */		MQ_MASK_ALL,
+	/* gc11 */		MQ_MASK_ALL,
+	/* gc12 NOT SET */	0,
+	/* gc13 NOT SET */	0,
+	/* gc14 */		MQ_MASK_ALL,
+	/* gc15 */		MQ_MASK_ALL,
+	/* gc16 */		MQ_MASK_ALL,
+	/* gc17 */		MQ_MASK_ALL,
+	/* gc18 */		MQ_MASK_ALL,
+	/* gc19 */		MQ_MASK_ALL,
+	/* gc1a */		MQ_MASK_ALL,
+    },
+    /* FP */
+    {
+	/* fp00 */		MQ_MASK_ALL,
+	/* fp01 */		MQ_MASK_ALL,
+	/* fp02 */		MQ_MASK_ALL,
+	/* fp03 */		MQ_MASK_ALL,
+	/* fp04 */		MQ_MASK_ALL,
+	/* fp05 */		MQ_MASK_ALL,
+	/* fp06 */		MQ_MASK_ALL,
+	/* fp07 */		MQ_MASK_ALL,
+	/* fp08 */		MQ_MASK_ALL,
+	/* fp09 NOT SET */	0,
+	/* fp0a */		MQ_MASK_ALL,
+	/* fp0b */		MQ_MASK_ALL,
+	/* fp0c */		MQ_MASK_1168 | MQ_MASK_1178 | MQ_MASK_1188,
+	/* fp0d NOT SET */	0,
+	/* fp0e NOT SET */	0,
+	/* fp0f */		MQ_MASK_ALL,
+	/* fp10 */		MQ_MASK_ALL,
+	/* fp11 */		MQ_MASK_ALL,
+	/* fp12 */		MQ_MASK_ALL,
+	/* fp13 */		MQ_MASK_ALL,
+	/* fp14 */		MQ_MASK_ALL,
+	/* fp15 */		MQ_MASK_ALL,
+	/* fp16 */		MQ_MASK_ALL,
+	/* fp17 */		MQ_MASK_ALL,
+	/* fp18 */		MQ_MASK_ALL,
+	/* fp19 */		MQ_MASK_ALL,
+	/* fp1a */		MQ_MASK_ALL,
+	/* fp1b */		MQ_MASK_ALL,
+	/* fp1c */		MQ_MASK_ALL,
+	/* fp1d */		MQ_MASK_ALL,
+	/* fp1e */		MQ_MASK_ALL,
+	/* fp1f */		MQ_MASK_ALL,
+	/* fp20 */		MQ_MASK_REGSET1,
+	/* fp21 */		MQ_MASK_REGSET1,
+	/* fp22 */		MQ_MASK_REGSET1,
+	/* fp23 */		MQ_MASK_REGSET1,
+	/* fp24 */		MQ_MASK_REGSET1,
+	/* fp25 */		MQ_MASK_REGSET1,
+	/* fp26 */		MQ_MASK_REGSET1,
+	/* fp27 */		MQ_MASK_REGSET1,
+	/* fp28 */		MQ_MASK_REGSET1,
+	/* fp29 */		MQ_MASK_REGSET1,
+	/* fp2a */		MQ_MASK_REGSET1,
+	/* fp2b */		MQ_MASK_REGSET1,
+	/* fp2c */		MQ_MASK_REGSET1,
+	/* fp2d */		MQ_MASK_REGSET1,
+	/* fp2e */		MQ_MASK_REGSET1,
+	/* fp2f */		MQ_MASK_REGSET1,
+	/* fp30 */		MQ_MASK_ALL,
+	/* fp31 */		MQ_MASK_ALL,
+	/* fp32 */		MQ_MASK_ALL,
+	/* fp33 */		MQ_MASK_ALL,
+	/* fp34 */		MQ_MASK_ALL,
+	/* fp35 */		MQ_MASK_ALL,
+	/* fp36 */		MQ_MASK_ALL,
+	/* fp37 */		MQ_MASK_ALL,
+	/* fp38 */		MQ_MASK_ALL,
+	/* fp39 */		MQ_MASK_ALL,
+	/* fp3a */		MQ_MASK_ALL,
+	/* fp3b */		MQ_MASK_ALL,
+	/* fp3c */		MQ_MASK_ALL,
+	/* fp3d */		MQ_MASK_ALL,
+	/* fp3e */		MQ_MASK_ALL,
+	/* fp3f */		MQ_MASK_ALL,
+	/* fp40 */		0,
+	/* fp41 */		0,
+	/* fp42 */		0,
+	/* fp43 */		0,
+	/* fp44 */		0,
+	/* fp45 */		0,
+	/* fp46 */		0,
+	/* fp47 */		0,
+	/* fp48 */		0,
+	/* fp49 */		0,
+	/* fp4a */		0,
+	/* fp4b */		0,
+	/* fp4c */		0,
+	/* fp4d */		0,
+	/* fp4e */		0,
+	/* fp4f */		0,
+	/* fp50 */		0,
+	/* fp51 */		0,
+	/* fp52 */		0,
+	/* fp53 */		0,
+	/* fp54 */		0,
+	/* fp55 */		0,
+	/* fp56 */		0,
+	/* fp57 */		0,
+	/* fp58 */		0,
+	/* fp59 */		0,
+	/* fp5a */		0,
+	/* fp5b */		0,
+	/* fp5c */		0,
+	/* fp5d */		0,
+	/* fp5e */		0,
+	/* fp5f */		0,
+	/* fp60 */		0,
+	/* fp61 */		0,
+	/* fp62 */		0,
+	/* fp63 */		0,
+	/* fp64 */		0,
+	/* fp65 */		0,
+	/* fp66 */		0,
+	/* fp67 */		0,
+	/* fp68 */		0,
+	/* fp69 */		0,
+	/* fp6a */		0,
+	/* fp6b */		0,
+	/* fp6c */		0,
+	/* fp6d */		0,
+	/* fp6e */		0,
+	/* fp6f */		0,
+	/* fp70 */		MQ_MASK_REGSET2,
+	/* fp71 */		MQ_MASK_REGSET2,
+	/* fp72 */		MQ_MASK_REGSET2,
+	/* fp73 */		MQ_MASK_REGSET2,
+	/* fp74 */		MQ_MASK_REGSET2,
+	/* fp75 */		MQ_MASK_REGSET2,
+	/* fp76 */		MQ_MASK_REGSET2,
+	/* fp77 */		MQ_MASK_REGSET2,
+    },
+    /* GE */
+    {
+	/* ge00 NOT SET */	0,
+	/* ge01 NOT SET */	0,
+	/* ge02 NOT SET */	0,
+	/* ge03 NOT SET */	0,
+	/* ge04 NOT SET */	0,
+	/* ge05 NOT SET */	0,
+	/* ge06 NOT SET */	0,
+	/* ge07 NOT SET */	0,
+	/* ge08 NOT SET */	0,
+	/* ge09 NOT SET */	0,
+	/* ge0a */		MQ_MASK_ALL,
+	/* ge0b */		MQ_MASK_ALL,
+	/* ge0c NOT SET */      0x0,
+	/* ge0d NOT SET */      0x0,
+	/* ge0e NOT SET */      0x0,
+	/* ge0f NOT SET */      0x0,
+	/* ge10 NOT SET */      0x0,
+	/* ge11 NOT SET */      MQ_MASK_1168 | MQ_MASK_1178 | MQ_MASK_1188,
+	/* ge12 NOT SET */      0x0,
+	/* ge13 NOT SET */      0x0,
+    },
+    /* SPI */
+    {
+      /* sp00 */		MQ_MASK_1132,
+      /* sp01 */		0,
+      /* sp02 NOT SET */	0,
+      /* sp03 NOT SET */	0,
+      /* sp04 */		MQ_MASK_1132,
+      /* sp05 NOT SET */	0,
+      /* sp06 NOT SET */	0,
+      /* sp07 */		MQ_MASK_1132,
+      /* sp08 */		MQ_MASK_1132,
+    },
+};
+
+static int
+mq11xx_loadvals (char *name, int chipmask, volatile u32 *reg,
+		 u32 *src, u32 *valid, int n)
+{
+	int t;
+
+        for (t = 0; t < n; t++){
+		if (valid[t] & chipmask) {
+			int tries;
+			for (tries = 0; tries < 10; tries++) {
+				reg[t] = src[t];
+				if (reg[t] == src[t])
+					break;
+				mdelay (1);
+			}
+			if (tries == 10) {
+				debug ("mq11xx_loadvals %s%02x %08x FAILED (got %08x)\n", name, t, src[t], reg[t]);
+				return -ENODEV;
+			}
+                }
+        }
+	return 0;
+}
+
+static int
+mq11xx_init (struct mq_data *mqdata)
+{
+	int i, chipmask;
+	u16 endian;
+
+	if (mqdata->mq_init->set_power)
+		mqdata->mq_init->set_power(1);
+
+	/* Set up chip endianness - see mq docs for notes on special care
+	   when writing to this register */
+	endian = mqdata->mq_init->DC [0] & 3;
+	endian = endian | (endian << 2);
+	endian = endian | (endian << 4);
+	endian = endian | (endian << 8);
+	*((u16 *)&mqdata->base.regs->DC.config_0) = endian;
+	/* First of all, enable the oscillator clock */
+	mqdata->base.regs->DC.config_1 = mqdata->mq_init->DC [1];
+	/* Wait for oscillator to run - 30ms doesnt suffice */
+	mdelay (100);
+	/* Enable power to CPU Configuration module */
+	mqdata->base.regs->DC.config_2 = mqdata->mq_init->DC [2];
+	mdelay (10);
+	/* Needed for MediaQ 1178/88 on h2200. */
+	mqdata->base.regs->DC.config_8 = 0x86098609;
+	/* Enable the MQ1132 MIU */
+	mqdata->base.regs->MIU.miu_0 |= MQ_MIU_ENABLE;
+	/* Disable the interrupt controller */
+	mqdata->base.regs->IC.control = 0;
+
+	/* See if it's actually a MediaQ chip */
+	if (mqdata->base.regs->PCI.vendor_id != MQ_PCI_VENDORID) {
+unkchip:	printk (KERN_ERR "%s:%d Unknown device ID (%04x:%04x)\n",
+			__FILE__, __LINE__,
+			mqdata->base.regs->PCI.vendor_id,
+			mqdata->base.regs->PCI.device_id);
+		return -ENODEV;
+	}
+
+	for (i = 0; i < ARRAY_SIZE (mq_device_id); i++)
+		if (mqdata->base.regs->PCI.device_id == mq_device_id [i].id) {
+			mqdata->base.chip = mq_device_id [i].chip;
+			mqdata->base.chipname = mq_device_id [i].name;
+			break;
+		}
+
+	if (!mqdata->base.chipname)
+		goto unkchip;
+
+	chipmask = 1 << mqdata->base.chip;
+
+#define INIT_REGS(id) \
+	if (mq11xx_loadvals (#id, chipmask, mqdata->base.regs->id.a, \
+		mqdata->mq_init->id, mqInitValid.id, \
+		ARRAY_SIZE (mqdata->mq_init->id))) \
+		return -ENODEV
+
+	INIT_REGS (DC);
+	INIT_REGS (CC);
+	INIT_REGS (MIU);
+
+	/* XXX Move this stuff to mq1100fb driver some day */
+	INIT_REGS (GC);
+	INIT_REGS (FP);
+	INIT_REGS (GE);
+
+#undef INIT_REGS
+
+	return 0;
+}
+
+static void
+mq_release (struct device *dev)
+{
+}
+
+/* This is kind of ugly and complex... well, this is the way GPIOs are
+ * programmed on MediaQ... what a mess...
+ */
+static int
+mq_set_GPIO (struct mediaq11xx_base *zis, int num, int state)
+{
+	u32 andmask = 0, ormask = 0;
+
+	debug ("mq_set_GPIO (num:%d state:%x)\n", num, state);
+
+	if ((num <= 7) || ((num >= 20) && (num <= 25))) {
+		andmask = 4;
+		if (state & MQ_GPIO_CHMODE) {
+			andmask |= 3;
+			if (state & MQ_GPIO_IN)
+				ormask |= 1;
+			if (state & MQ_GPIO_OUT)
+				ormask |= 2;
+		}
+		if (state & MQ_GPIO_0)
+			andmask |= 8;
+		if (state & MQ_GPIO_1)
+			ormask |= 8;
+		if (num <= 7) {
+			andmask <<= num * 4;
+			ormask <<= num * 4;
+			zis->regs->CC.gpio_control_0 =
+				(zis->regs->CC.gpio_control_0 & ~andmask) | ormask;
+		} else {
+			andmask <<= (num - 18) * 4;
+			ormask <<= (num - 18) * 4;
+			zis->regs->CC.gpio_control_1 =
+				(zis->regs->CC.gpio_control_1 & ~andmask) | ormask;
+		}
+	} else if (num >= 50 && num <= 55) {
+		int shft;
+
+		/* Uhh.... what a mess */
+		if (state & MQ_GPIO_CHMODE) {
+			shft = (num <= 53) ? num - 48 : num - 45;
+			andmask |= 3 << shft;
+			if (state & MQ_GPIO_OUT)
+				ormask |= (1 << (shft * 2));
+			if (state & MQ_GPIO_IN)
+				ormask |= (2 << (shft * 2));
+		}
+
+		if (num == 50)
+			shft = 3;
+		else if (num <= 53)
+			shft = (num - 51);
+		else
+			shft = (num - 38);
+
+		if (state & MQ_GPIO_0)
+			andmask |= (1 << shft);
+		if (state & MQ_GPIO_1)
+			ormask |= (1 << shft);
+		if ((state & MQ_GPIO_PULLUP) && (num <= 53))
+                        ormask |= 0x1000 << (num - 50);
+		zis->regs->SPI.gpio_mode =
+			(zis->regs->SPI.gpio_mode & ~andmask) | ormask;
+	} else if (num >= 60 && num <= 66) {
+		int shft = (num - 60);
+		if (state & MQ_GPIO_0)
+			andmask |= (1 << shft);
+		if (state & MQ_GPIO_1)
+			ormask |= (1 << shft);
+		shft *= 2;
+		if (state & MQ_GPIO_CHMODE) {
+			andmask |= (0x300 << shft);
+			if (state & MQ_GPIO_OUT)
+				ormask |= (0x100 << shft);
+			if (state & MQ_GPIO_IN)
+				ormask |= (0x200 << shft);
+		}
+		zis->regs->SPI.blue_gpio_mode =
+			(zis->regs->SPI.blue_gpio_mode & ~andmask) | ormask;
+	} else
+		return -ENODEV;
+
+	return 0;
+}
+
+static int
+mq_get_GPIO (struct mediaq11xx_base *zis, int num)
+{
+        u32 val;
+
+	if (num <= 7)
+		val = zis->regs->CC.gpio_control_0 & (8 << (num * 4));
+	else if ((num >= 20) && (num <= 25))
+		val = zis->regs->CC.gpio_control_1 & (8 << ((num - 18) * 4));
+	else if (num == 50)
+		val = zis->regs->SPI.gpio_mode & 0x8;
+	else if ((num >= 51) && (num <= 53))
+		val = zis->regs->SPI.gpio_mode & (0x1 << (num - 51));
+	else if ((num >= 54) && (num <= 55))
+		val = zis->regs->SPI.gpio_mode & (0x1 << (num - 38));
+	else if (num >= 60 && num <= 66)
+		val = zis->regs->SPI.blue_gpio_mode & (1 << (num - 60));
+	else
+		val = 0;
+
+	if (val) val = 1;
+
+	return val;
+}
+
+static int
+global_power (struct mq_data *mqdata)
+{
+	int i;
+	for (i = 0; i < sizeof (mqdata->power_on); i++)
+		if (mqdata->power_on [i])
+			return 1;
+	return 0;
+}
+
+static void
+mq_power_on (struct mediaq11xx_base *zis, int subdev_id)
+{
+	/* The device IDs lower 4 bits contains the subdevice index
+	 * (counting from 1). Take care to keep all MEDIAQ_11XX_XXX
+	 * contstants with sequential values in their lower 4 bits!
+	 */
+	unsigned idx = (subdev_id & 0x0f) - 1;
+	struct mq_data *mqdata = to_mq_data (zis);
+
+	debug_func ("subdev:%x curstate:%d\n", subdev_id, mqdata->power_on [idx]);
+
+	/* Check if MediaQ is not totally turned off */
+	if (!global_power (mqdata)) {
+		debug ("-*- Global POWER ON to the MediaQ chip -*-\n");
+		mq11xx_init (mqdata);
+	}
+
+	if (!mqdata->power_on [idx])
+		switch (subdev_id) {
+		case MEDIAQ_11XX_FB_DEVICE_ID:
+			zis->regs->GC.control |= MQ_GC_CONTROL_ENABLE;
+			/* Enable the graphics engine power */
+			zis->regs->DC.config_5 |= MQ_CONFIG_GE_ENABLE;
+			break;
+		case MEDIAQ_11XX_FP_DEVICE_ID:
+			/* Enable flat panel pin outputs */
+			//zis->regs->FP.pin_control_1 &= ~MQ_FP_DISABLE_FLAT_PANEL_PINS;
+			zis->regs->FP.output_control = mqdata->mq_init->FP [2];
+			break;
+		case MEDIAQ_11XX_UDC_DEVICE_ID:
+			/* Enable power to USB function */
+			zis->regs->DC.config_5 |= MQ_CONFIG_UDC_CLOCK_ENABLE;
+			break;
+		case MEDIAQ_11XX_UHC_DEVICE_ID:
+			/* Enable power to USB host */
+			zis->regs->DC.config_5 |= MQ_CONFIG_UHC_CLOCK_ENABLE;
+			break;
+		case MEDIAQ_11XX_SPI_DEVICE_ID:
+		case MEDIAQ_11XX_I2S_DEVICE_ID:
+			/* There's no explicit way to do it */
+			break;
+		}
+	mqdata->power_on [idx]++;
+}
+
+static void
+mq_power_off (struct mediaq11xx_base *zis, int subdev_id)
+{
+	unsigned idx = (subdev_id & 0x0f) - 1;
+	struct mq_data *mqdata = to_mq_data (zis);
+
+	debug_func ("subdev:%x curstate:%d\n", subdev_id, mqdata->power_on [idx]);
+
+	if (!mqdata->power_on [idx]) {
+		printk (KERN_ERR "mq11xx: mismatch power on/off request count for subdevice %x\n",
+			subdev_id);
+		return;
+	}
+
+	switch (subdev_id) {
+	case MEDIAQ_11XX_FB_DEVICE_ID:
+		zis->regs->GC.control &= ~MQ_GC_CONTROL_ENABLE;
+		/* Disable the graphics engine power */
+		zis->regs->DC.config_5 &= ~MQ_CONFIG_GE_ENABLE;
+		break;
+	case MEDIAQ_11XX_FP_DEVICE_ID:
+		/* Disable flat panel pin outputs */
+		zis->regs->FP.output_control = 0;
+		//zis->regs->FP.pin_control_1 |= MQ_FP_DISABLE_FLAT_PANEL_PINS;
+		break;
+	case MEDIAQ_11XX_UDC_DEVICE_ID:
+		/* Disable power to USB function */
+		zis->regs->DC.config_5 &= ~MQ_CONFIG_UDC_CLOCK_ENABLE;
+		break;
+	case MEDIAQ_11XX_UHC_DEVICE_ID:
+		/* Disable power to USB host */
+		zis->regs->DC.config_5 &= ~MQ_CONFIG_UHC_CLOCK_ENABLE;
+		break;
+	case MEDIAQ_11XX_SPI_DEVICE_ID:
+	case MEDIAQ_11XX_I2S_DEVICE_ID:
+		/* There's no explicit way to do it */
+		break;
+	}
+
+	mqdata->power_on [idx]--;
+
+	/* Check if we have to totally power off MediaQ */
+	if (!global_power (mqdata)) {
+		debug ("-*- Global POWER OFF to MediaQ chip -*-\n");
+		/* Disable the MQ1132 MIU */
+		zis->regs->MIU.miu_0 &= ~MQ_MIU_ENABLE;
+		/* Disable power to CPU Configuration module */
+		zis->regs->DC.config_2 &= ~MQ_CONFIG_CC_MODULE_ENABLE;
+		/* Disable the oscillator clock */
+		zis->regs->DC.config_1 &= ~MQ_CONFIG_18_OSCILLATOR;
+
+		if (mqdata->mq_init->set_power)
+			mqdata->mq_init->set_power(0);
+	}
+}
+
+static void
+mq_set_power (struct mediaq11xx_base *zis, int subdev_id, int state)
+{
+	if (state)
+		mq_power_on (zis, subdev_id);
+	else
+		mq_power_off (zis, subdev_id);
+}
+
+static int
+mq_get_power (struct mediaq11xx_base *zis, int subdev_id)
+{
+	unsigned idx = (subdev_id & 0x0f) - 1;
+	struct mq_data *mqdata = to_mq_data (zis);
+	return mqdata->power_on [idx];
+}
+
+/********************************************* On-chip memory management ******/
+
+/**
+ * Since the internal chip RAM may be shared amongst several subdevices
+ * (framebuffer, graphics engine, SPI, UDC and other), we have to implement
+ * a general memory management mechanism to prevent conflicts between drivers
+ * trying to use this resource.
+ *
+ * We could use the "chained free blocks" scheme used in many simple memory
+ * managers, where a { free block size; next free block; } structure is
+ * stuffed directly into the free block itself, to conserve memory. However,
+ * this mechanism is less reliable since it is susceptible to overwrites
+ * past the bounds of an allocated block (because it breaks the free blocks
+ * chain). Of course, a buggy driver is always a bad idea, but we should try
+ * to be as reliable as possible. Thus, the free block chain is kept in kernel
+ * memory (in the device-specific structure), and everything else is done like
+ * in the mentioned scheme.
+ */
+
+static void
+mq_setfreeblocks (struct mq_data *mqdata, int nblocks)
+{
+	void *temp;
+	int newmax;
+
+	/* Increase maximum number of free memory descriptors in power-of-two
+	   steps. This is due to the fact, that Linux allocates memory in
+	   power-of-two chunks, and the minimal chunk (slab) size is 32b.
+	   Allocating anything but power-of-two sized memory blocks is just
+	   a waste of memory. In fact, in most circumstances we have a small
+	   number of free block descriptors. */
+	newmax = (nblocks > 0) ? (1 << fls (nblocks - 1)) : 1;
+	if (likely (newmax < MEMBLOCK_MINCOUNT))
+		newmax = MEMBLOCK_MINCOUNT;
+
+	if (mqdata->maxfreeblocks != newmax) {
+		int nfb = mqdata->nfreeblocks;
+		if (nfb > nblocks) nfb = nblocks;
+		temp = kmalloc (newmax * sizeof (struct mq_freemem_list),
+				GFP_KERNEL);
+		memcpy (temp, mqdata->freelist, nfb * sizeof (struct mq_freemem_list));
+		kfree (mqdata->freelist);
+		mqdata->freelist = temp;
+		mqdata->maxfreeblocks = newmax;
+	}
+
+	mqdata->nfreeblocks = nblocks;
+}
+
+/* Check if memory block is suitable for uses other than graphics. */
+static int mq_suitable_ram (struct mq_data *mqdata, int fbn, unsigned size)
+{
+	int n, delta;
+
+	delta = mqdata->unsynced_ram_skip - mqdata->freelist [fbn].addr;
+	if (delta <= 0)
+		return 1;
+
+	if (mqdata->freelist [fbn].size < size + delta)
+		return 0;
+
+	/* Ok, split the free block into two */
+	n = mqdata->nfreeblocks;
+	mq_setfreeblocks (mqdata, n + 1);
+	mqdata->freelist [n].addr = mqdata->freelist [fbn].addr;
+	mqdata->freelist [n].size = delta;
+	mqdata->freelist [fbn].addr += delta;
+	mqdata->freelist [fbn].size -= delta;
+
+	return 1;
+}
+
+/* Not too optimal (just finds the first free block of equal or larger size
+ * than requested) but usually there are a few blocks in MediaQ RAM anyway...
+ * usually a block of 320x240x2 bytes is eaten by the framebuffer, and we
+ * have just 256k total.
+ */
+static u32
+mq_alloc (struct mediaq11xx_base *zis, unsigned size, int gfx)
+{
+	struct mq_data *mqdata = to_mq_data (zis);
+	int i;
+
+        size = (size + MEMBLOCK_ALIGN - 1) & ~(MEMBLOCK_ALIGN - 1);
+
+        spin_lock (&mqdata->mem_lock);
+
+	for (i = mqdata->nfreeblocks - 1; i >= 0; i--) {
+		if ((mqdata->freelist [i].size >= size) &&
+		    (gfx || mq_suitable_ram (mqdata, i, size))) {
+			u32 addr = mqdata->freelist [i].addr;
+			mqdata->freelist [i].size -= size;
+			if (mqdata->freelist [i].size)
+				mqdata->freelist [i].addr += size;
+			else {
+				memcpy (mqdata->freelist + i, mqdata->freelist + i + 1,
+					(mqdata->nfreeblocks - 1 - i) * sizeof (struct mq_freemem_list));
+				mq_setfreeblocks (mqdata, mqdata->nfreeblocks - 1);
+			}
+			spin_unlock (&mqdata->mem_lock);
+                        return addr;
+		}
+	}
+
+	spin_unlock (&mqdata->mem_lock);
+
+	return (u32)-1;
+}
+
+static void
+mq_free (struct mediaq11xx_base *zis, u32 addr, unsigned size)
+{
+	int i, j;
+	u32 eaddr;
+	struct mq_data *mqdata = to_mq_data (zis);
+
+	size = (size + MEMBLOCK_ALIGN - 1) & ~(MEMBLOCK_ALIGN - 1);
+	eaddr = addr + size;
+
+	spin_lock (&mqdata->mem_lock);
+
+	/* Look for a free block that starts at the end of the block to free */
+	for (i = mqdata->nfreeblocks - 1; i >= 0; i--)
+		if (mqdata->freelist [i].addr == eaddr) {
+			mqdata->freelist [i].size += size;
+			mqdata->freelist [i].addr = addr;
+			/* Now look for a block that ends where we start */
+			for (j = mqdata->nfreeblocks - 1; j >= 0; j--) {
+				if (mqdata->freelist [j].addr + mqdata->freelist [j].size == addr) {
+					/* Ok, concatenate the two free blocks */
+					mqdata->freelist [i].addr = mqdata->freelist [j].addr;
+					mqdata->freelist [i].size += mqdata->freelist [j].size;
+					memcpy (mqdata->freelist + j, mqdata->freelist + j + 1,
+						(mqdata->nfreeblocks - 1 - j) * sizeof (struct mq_freemem_list));
+					mq_setfreeblocks (mqdata, mqdata->nfreeblocks - 1);
+					break;
+				}
+			}
+			spin_unlock (&mqdata->mem_lock);
+			return;
+		}
+
+	for (i = mqdata->nfreeblocks - 1; i >= 0; i--)
+		if (mqdata->freelist [i].addr + mqdata->freelist [i].size == addr) {
+			mqdata->freelist [i].size += size;
+			spin_unlock (&mqdata->mem_lock);
+			return;
+		}
+
+	/* Ok, we have to add a new free block entry */
+	i = mqdata->nfreeblocks;
+	mq_setfreeblocks (mqdata, i + 1);
+	mqdata->freelist [i].addr = addr;
+	mqdata->freelist [i].size = size;
+
+	spin_unlock (&mqdata->mem_lock);
+}
+
+/**************************** IRQ handling using interrupt multiplexing ******/
+
+#ifdef MQ_IRQ_MULTIPLEX
+
+static void
+mq_irq_demux (unsigned int irq, struct irqdesc *desc, struct pt_regs *regs)
+{
+	u32 mask, orig_mask;
+	int i, mq_irq, timeout;
+	struct mq_data *mqdata;
+
+	mqdata = desc->data;
+
+	mqdata->base.regs->IC.control &= ~MQ_INTERRUPT_CONTROL_INTERRUPT_ENABLE;
+
+	debug ("mq_irq_demux ENTER\n");
+
+	/* An IRQ is a expensive operation, thus we're handling here
+	 * as much interrupt sources as we can (rather than returning
+	 * from interrupt just to get caught once again). On the other
+	 * hand, we can't process too much of them since some IRQ may be
+	 * continuously triggered. Thus, we'll set an arbitrary upper limit
+	 * on the number of interrupts we can handle at once. Note that,
+	 * for example, if PCMCIA IRQ is connected to MediaQ, this number
+	 * can be very large, e.g. one interrupt for every read sector
+	 * from a memory card.
+	 */
+	timeout = 1024;
+
+	/* Read the IRQ status register */
+	while (timeout-- &&
+	       (mask = orig_mask = mqdata->base.regs->IC.interrupt_status)) {
+		irq = 0;
+		while ((i = ffs (mask))) {
+			irq += i - 1;
+			mq_irq = mqdata->base.irq_base + irq;
+			desc = irq_desc + mq_irq;
+			debug ("mq_irq_demux (irq:%d)\n", mq_irq);
+			desc->handle (mq_irq, desc, regs);
+			mask >>= i;
+		}
+	}
+
+	if (!timeout)
+		printk (KERN_ERR "mq11xx: IRQ continuously triggered, mask %08x\n", mask);
+
+	debug ("mq_irq_demux LEAVE\n");
+
+	mqdata->base.regs->IC.control |= MQ_INTERRUPT_CONTROL_INTERRUPT_ENABLE;
+}
+
+/* Acknowledge, clear _AND_ disable the interrupt. */
+static void
+mq_irq_ack (unsigned int irq)
+{
+	struct mq_data *mqdata = get_irq_chipdata (irq);
+	u32 mask = 1 << (irq - mqdata->base.irq_base);
+	/* Disable the IRQ */
+	mqdata->base.regs->IC.interrupt_mask &= ~mask;
+	/* Acknowledge the IRQ */
+	mqdata->base.regs->IC.interrupt_status = mask;
+}
+
+static void
+mq_irq_mask (unsigned int irq)
+{
+	struct mq_data *mqdata = get_irq_chipdata (irq);
+	u32 mask = 1 << (irq - mqdata->base.irq_base);
+	mqdata->base.regs->IC.interrupt_mask &= ~mask;
+}
+
+static void
+mq_irq_unmask (unsigned int irq)
+{
+	struct mq_data *mqdata = get_irq_chipdata (irq);
+	u32 mask = 1 << (irq - mqdata->base.irq_base);
+	mqdata->base.regs->IC.interrupt_mask |= mask;
+}
+
+static int
+mq_irq_type (unsigned int irq, unsigned int type)
+{
+	struct mq_data *mqdata = get_irq_chipdata (irq);
+	int mask;
+
+	if ((irq < mqdata->base.irq_base + IRQ_MQ_GPIO_0) ||
+	    (irq > mqdata->base.irq_base + IRQ_MQ_GPIO_2))
+		return 0;
+
+	mask = MQ_INTERRUPT_CONTROL_GPIO_0_INTERRUPT_POLARITY <<
+		(irq - mqdata->base.irq_base - IRQ_MQ_GPIO_0);
+
+	if (type & (__IRQT_HIGHLVL | __IRQT_RISEDGE))
+		mqdata->base.regs->IC.control |= mask;
+	else if (type & (__IRQT_LOWLVL | __IRQT_FALEDGE))
+		mqdata->base.regs->IC.control &= ~mask;
+
+	return 0;
+}
+
+static struct irqchip mq_irq_chip = {
+	.ack		= mq_irq_ack,
+	.mask		= mq_irq_mask,
+	.unmask		= mq_irq_unmask,
+	.type		= mq_irq_type,
+};
+
+static int
+mq_irq_init (struct mq_data *mqdata)
+{
+	int i;
+
+	/* Disable all IRQs */
+	mqdata->base.regs->IC.control = 0;
+	mqdata->base.regs->IC.interrupt_mask = 0;
+	/* Clear IRQ status */
+	mqdata->base.regs->IC.interrupt_status = 0xffffffff;
+
+	mqdata->base.irq_base = alloc_irq_space (MQ11xx_NUMIRQS);
+	if (mqdata->base.irq_base < 0) {
+		printk (KERN_ERR "There is no space for %d IRQs in core IRQ table!\n",
+			MQ11xx_NUMIRQS);
+		return -ENOMEM;
+	}
+
+	debug_func ("base IRQ number is %d\n", mqdata->base.irq_base);
+
+	for (i = 0; i < MQ11xx_NUMIRQS; i++) {
+		int irq = mqdata->base.irq_base + i;
+		set_irq_flags (irq, IRQF_VALID);
+		set_irq_chip (irq, &mq_irq_chip);
+		set_irq_handler (irq, do_level_IRQ);
+		set_irq_chipdata (irq, mqdata);
+	}
+
+	i = (mqdata->base.regs->IC.control & MQ_INTERRUPT_CONTROL_INTERRUPT_POLARITY);
+	set_irq_chained_handler (mqdata->irq_nr, mq_irq_demux);
+	set_irq_type (mqdata->irq_nr, i ? IRQT_RISING : IRQT_FALLING);
+	set_irq_data (mqdata->irq_nr, mqdata);
+
+	/* Globally enable IRQs from MediaQ */
+	mqdata->base.regs->IC.control |= MQ_INTERRUPT_CONTROL_INTERRUPT_ENABLE;
+
+	return 0;
+}
+
+static void
+mq_irq_free (struct mq_data *mqdata)
+{
+	/* Disable all IRQs */
+	mqdata->base.regs->IC.control = 0;
+	mqdata->base.regs->IC.interrupt_mask = 0;
+	/* Clear IRQ status */
+	mqdata->base.regs->IC.interrupt_status = 0xffffffff;
+
+	set_irq_handler (mqdata->irq_nr, do_edge_IRQ);
+
+	free_irq_space (mqdata->base.irq_base, MQ11xx_NUMIRQS);
+}
+#endif
+
+int
+mq_device_enum (struct mediaq11xx_base **list, int list_size)
+{
+	int i, j;
+
+	if (!list_size)
+		return 0;
+
+	spin_lock (&mq_device_list_lock);
+	for (i = j = 0; i < MAX_MQ11XX_DEVICES; i++)
+		if (mq_device_list [i]) {
+			list [j++] = mq_device_list [i];
+			if (j >= list_size)
+				break;
+		}
+	spin_unlock (&mq_device_list_lock);
+
+        return j;
+}
+EXPORT_SYMBOL (mq_device_enum);
+
+int
+mq_driver_get (void)
+{
+	return try_module_get (THIS_MODULE) ? 0 : -ENXIO;
+}
+EXPORT_SYMBOL (mq_driver_get);
+
+void
+mq_driver_put (void)
+{
+	module_put (THIS_MODULE);
+}
+EXPORT_SYMBOL (mq_driver_put);
+
+/*
+ * Resources specified in resource table for this driver are:
+ * 0: Synchronous RAM address (physical base + 0 on ARM arch)
+ * 1: Asynchronous RAM address (physical base + 256K+2K on ARM arch)
+ * 2: Registers address (physical base + 256K on ARM arch)
+ * 3: The MediaQ IRQ number
+ *
+ * Also the platform_data field of the device should contain a pointer to
+ * a mq11xx_platform_data structure, which contains the platform-specific
+ * initialization data for MediaQ chip, the name of framebuffer driver
+ * and the name of LCD driver.
+ */
+static int
+mq_initialize (struct device *dev, int num_resources,
+	       struct resource *resource, int instance)
+{
+	int i, j, k, rc, chipmask;
+	struct mq_data *mqdata;
+	struct mediaq11xx_init_data *init_data =
+		(struct mediaq11xx_init_data *)dev->platform_data;
+
+	if (!init_data || num_resources != 4) {
+		printk (KERN_ERR "mq11xx_base: Incorrect platform resources!\n");
+		return -ENODEV;
+	}
+
+	mqdata = kmalloc (sizeof (struct mq_data), GFP_KERNEL);
+	if (!mqdata)
+		return -ENOMEM;
+	memset (mqdata, 0, sizeof (struct mq_data));
+	dev_set_drvdata (dev, mqdata);
+
+#define IOREMAP(v, n, el) \
+	mqdata->base.v = ioremap (resource[n].start, \
+		resource[n].end - resource[n].start + 1); \
+	if (!mqdata->base.v) goto el; \
+	mqdata->base.paddr_##v = resource[n].start;
+
+	IOREMAP (gfxram, 0, err0);
+	IOREMAP (ram, 1, err1);
+	IOREMAP (regs, 2, err2);
+
+#undef IOREMAP
+
+	/* Check how much RAM is accessible through the unsynced window */
+	mqdata->unsynced_ram_skip =
+		(resource [0].end - resource [0].start) -
+		(resource [1].end - resource [1].start);
+	mqdata->base.ram -= mqdata->unsynced_ram_skip;
+	mqdata->base.paddr_ram -= mqdata->unsynced_ram_skip;
+
+	mqdata->ndevices = MQ_SUBDEVS_REAL_COUNT;
+	mqdata->devices = kmalloc (mqdata->ndevices *
+		(sizeof (struct platform_device)), GFP_KERNEL);
+	if (!mqdata->devices)
+		goto err3;
+
+	mqdata->mq_init = init_data;
+	if (mq11xx_init (mqdata)) {
+		printk (KERN_ERR "MediaQ device initialization failed!\n");
+		return -ENODEV;
+	}
+
+	mqdata->irq_nr = resource[3].start;
+	mqdata->base.set_GPIO = mq_set_GPIO;
+	mqdata->base.get_GPIO = mq_get_GPIO;
+	mqdata->base.set_power = mq_set_power;
+	mqdata->base.get_power = mq_get_power;
+	mqdata->base.alloc = mq_alloc;
+	mqdata->base.free = mq_free;
+
+	/* Initialize memory manager */
+	spin_lock_init (&mqdata->mem_lock);
+	mqdata->nfreeblocks = 1;
+	mqdata->maxfreeblocks = MEMBLOCK_MINCOUNT;
+	mqdata->freelist = kmalloc (MEMBLOCK_MINCOUNT * sizeof (struct mq_freemem_list),
+				    GFP_KERNEL);
+	mqdata->freelist [0].addr = 0;
+	mqdata->freelist [0].size = MQ11xx_FB_SIZE;
+
+#if defined MQ_IRQ_MULTIPLEX
+	if ((mqdata->irq_nr != -1) && mq_irq_init (mqdata))
+		goto err4;
+#endif
+
+	for (i = j = 0; j < MQ_SUBDEVS_COUNT; i++) {
+		struct platform_device *sdev = &mqdata->devices[i];
+		const struct mq_block *blk = &mq_blocks[j];
+		struct resource *res;
+		int old_j, k;
+
+		memset (sdev, 0, sizeof (struct platform_device));
+		sdev->id = blk->id.id; /* placeholder id */
+		sdev->name = blk->name;
+		sdev->dev.parent = dev;
+		sdev->dev.release = mq_release;
+		sdev->dev.platform_data = &mqdata->base;
+
+		/* Count number of resources */
+		sdev->num_resources = 2;
+		old_j = j;
+		while (mq_blocks [++j].id.id == sdev->id)
+			/* One resource for _MEM and one for _PLATFORM_VIRTUAL */
+			sdev->num_resources += 2;
+
+		res = kmalloc (sdev->num_resources * sizeof (struct resource), GFP_KERNEL);
+		sdev->resource = res;
+		memset (res, 0, sdev->num_resources * sizeof (struct resource));
+
+		for (j = old_j, k = 0; mq_blocks [j].id.id == sdev->id; j++) {
+			blk = &mq_blocks[j];
+			res[k].start = resource[2].start + blk->start;
+			res[k].end = resource[2].start + blk->end;
+			res[k].parent = &resource[2];
+			res[k++].flags = IORESOURCE_MEM;
+			res[k].start = (unsigned)mqdata->base.regs + blk->start;
+			res[k].end = (unsigned)mqdata->base.regs + blk->end;
+                }
+
+		mqdata->power_on [i] = 1;;
+	}
+
+	/* Second pass */
+	chipmask = 1 << mqdata->base.chip;
+	for (i = j = k = 0; j < MQ_SUBDEVS_COUNT; i++) {
+		struct platform_device *sdev = &mqdata->devices[i];
+                const struct mq_block *blk = &mq_blocks[j];
+
+		while (mq_blocks [++j].id.id == sdev->id)
+			;
+
+		/* Power off all subdevices */
+		mq_power_off (&mqdata->base, sdev->id);
+
+		if (!(blk->mask & chipmask))
+			continue;
+
+		sdev->id = instance;
+		rc = platform_device_register (sdev);
+		if (rc) {
+			printk (KERN_ERR "Failed to register MediaQ subdevice `%s', code %d\n",
+			        blk->name, rc);
+			goto err5;
+		}
+	}
+
+	printk (KERN_INFO "MediaQ %s chip detected, ", mqdata->base.chipname);
+#ifdef MQ_IRQ_MULTIPLEX
+	if (mqdata->base.irq_base)
+		printk ("base IRQ %d\n", mqdata->base.irq_base);
+	else
+		printk ("\n");
+#endif
+
+	spin_lock (&mq_device_list_lock);
+	for (i = 0; i < MAX_MQ11XX_DEVICES; i++)
+		if (!mq_device_list [i]) {
+			mq_device_list [i] = &mqdata->base;
+			break;
+		}
+	spin_unlock (&mq_device_list_lock);
+
+	return 0;
+
+err5:	while (--i >= 0) {
+		platform_device_unregister (&mqdata->devices[i]);
+		kfree (mqdata->devices[i].resource);
+	}
+
+#if defined MQ_IRQ_MULTIPLEX
+	if (mqdata->irq_nr != -1)
+		mq_irq_free (mqdata);
+#endif
+#ifdef MQ_IRQ_MULTIPLEX
+err4:	kfree (mqdata->devices);
+#endif
+err3:	iounmap ((void *)mqdata->base.regs);
+err2:	iounmap ((void *)mqdata->base.ram);
+err1:	iounmap (mqdata->base.gfxram);
+err0:	kfree (mqdata);
+
+	printk (KERN_ERR "MediaQ base SoC driver initialization failed\n");
+
+	return -ENOMEM;
+}
+
+static int
+mq_finalize (struct device *dev)
+{
+	int i;
+	struct mq_data *mqdata = dev_get_drvdata (dev);
+
+	spin_lock (&mq_device_list_lock);
+	for (i = 0; i < MAX_MQ11XX_DEVICES; i++)
+		if (mq_device_list [i] == &mqdata->base) {
+			mq_device_list [i] = NULL;
+			break;
+		}
+	spin_unlock (&mq_device_list_lock);
+
+	for (i = 0; i < mqdata->ndevices; i++) {
+		platform_device_unregister (&mqdata->devices[i]);
+		kfree (mqdata->devices[i].resource);
+	}
+
+#if defined MQ_IRQ_MULTIPLEX
+	if (mqdata->irq_nr != -1)
+		mq_irq_free (mqdata);
+#endif
+
+	kfree (mqdata->devices);
+
+	iounmap ((void *)mqdata->base.regs);
+	iounmap ((void *)mqdata->base.ram);
+	iounmap (mqdata->base.gfxram);
+
+	kfree (mqdata);
+
+	return 0;
+}
+
+/* This is the platform device handler. If MediaQ is connected to a different
+ * bus type (e.g. PCI) a similar device_driver structure should be registered
+ * for that bus. For now this is not implemented.
+ */
+
+static int
+mq_probe (struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device (dev);
+	return mq_initialize (dev, pdev->num_resources, pdev->resource,
+			      pdev->id);
+}
+
+static int
+mq_remove (struct device *dev)
+{
+	return mq_finalize (dev);
+}
+
+static void
+mq_shutdown (struct device *dev)
+{
+	//struct mq_data *mqdata = dev_get_drvdata (dev);
+}
+
+static int
+mq_suspend (struct device *dev, u32 state, u32 level)
+{
+	//struct mq_data *mqdata = dev_get_drvdata (dev);
+	return 0;
+}
+
+static int
+mq_resume (struct device *dev, u32 level)
+{
+	//struct mq_data *mqdata = dev_get_drvdata (dev);
+	return 0;
+}
+
+static struct device_driver mq_device_driver = {
+	.name		= "mq11xx",
+	.bus		= &platform_bus_type,
+
+	.probe		= mq_probe,
+	.remove		= mq_remove,
+	.suspend	= mq_suspend,
+	.resume		= mq_resume,
+	.shutdown	= mq_shutdown,
+};
+
+static int __init
+mq_base_init (void)
+{
+	return driver_register (&mq_device_driver);
+}
+
+static void __exit
+mq_base_exit (void)
+{
+	driver_unregister (&mq_device_driver);
+}
+
+module_init (mq_base_init)
+module_exit (mq_base_exit)
+
+MODULE_AUTHOR("Andrew Zabolotny <anpaza@mail.ru>");
+MODULE_DESCRIPTION("MediaQ 1100/1132 base SoC support");
+MODULE_LICENSE("GPL");
