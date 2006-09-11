Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965124AbWIKXV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbWIKXV0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965122AbWIKXUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:20:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:44816 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S965047AbWIKXUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:20:14 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,147,1157353200"; 
   d="scan'208"; a="128869936:sNHT1186297406"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 19/19] iop3xx: IOP 32x and 33x support for the iop-adma driver
Date: Mon, 11 Sep 2006 16:19:15 -0700
To: neilb@suse.de, linux-raid@vger.kernel.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, christopher.leech@intel.com
Message-Id: <20060911231915.4737.64633.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Adds the platform device definitions and the architecture specific support
routines (i.e. register initialization and descriptor formats) for the
iop-adma driver.

Changelog:
* add support for > 1k zero sum buffer sizes
* added dma/aau platform devices to iq80321 and iq80332 setup
* fixed the calculation in iop_desc_is_aligned
* support xor buffer sizes larger than 16MB
* fix places where software descriptors are assumed to be contiguous, only
hardware descriptors are contiguous
* iop32x does not support hardware zero sum, add software emulation support
for up to a PAGE_SIZE buffer size
* added raid5 dma driver support functions

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 arch/arm/mach-iop32x/iq80321.c         |  141 +++++
 arch/arm/mach-iop33x/iq80331.c         |    9 
 arch/arm/mach-iop33x/iq80332.c         |    8 
 arch/arm/mach-iop33x/setup.c           |  132 +++++
 include/asm-arm/arch-iop32x/adma.h     |    5 
 include/asm-arm/arch-iop33x/adma.h     |    5 
 include/asm-arm/hardware/iop3xx-adma.h |  901 ++++++++++++++++++++++++++++++++
 7 files changed, 1201 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-iop32x/iq80321.c b/arch/arm/mach-iop32x/iq80321.c
index cdd2265..79d6514 100644
--- a/arch/arm/mach-iop32x/iq80321.c
+++ b/arch/arm/mach-iop32x/iq80321.c
@@ -33,6 +33,9 @@ #include <asm/mach/time.h>
 #include <asm/mach-types.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
+#ifdef CONFIG_DMA_ENGINE
+#include <asm/hardware/iop_adma.h>
+#endif
 
 /*
  * IQ80321 timer tick configuration.
@@ -170,12 +173,150 @@ static struct platform_device iq80321_se
 	.resource	= &iq80321_uart_resource,
 };
 
+#ifdef CONFIG_DMA_ENGINE
+/* AAU and DMA Channels */
+static struct resource iop3xx_dma_0_resources[] = {
+	[0] = {
+		.start = (unsigned long) IOP3XX_DMA_CCR(0),
+		.end = ((unsigned long) IOP3XX_DMA_DCR(0)) + 4,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_IOP32X_DMA0_EOT,
+		.end = IRQ_IOP32X_DMA0_EOT,
+		.flags = IORESOURCE_IRQ
+	},
+	[2] = {
+		.start = IRQ_IOP32X_DMA0_EOC,
+		.end = IRQ_IOP32X_DMA0_EOC,
+		.flags = IORESOURCE_IRQ
+	},
+	[3] = {
+		.start = IRQ_IOP32X_DMA0_ERR,
+		.end = IRQ_IOP32X_DMA0_ERR,
+		.flags = IORESOURCE_IRQ
+	}
+};
+
+static struct resource iop3xx_dma_1_resources[] = {
+	[0] = {
+		.start = (unsigned long) IOP3XX_DMA_CCR(1),
+		.end = ((unsigned long) IOP3XX_DMA_DCR(1)) + 4,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_IOP32X_DMA1_EOT,
+		.end = IRQ_IOP32X_DMA1_EOT,
+		.flags = IORESOURCE_IRQ
+	},
+	[2] = {
+		.start = IRQ_IOP32X_DMA1_EOC,
+		.end = IRQ_IOP32X_DMA1_EOC,
+		.flags = IORESOURCE_IRQ
+	},
+	[3] = {
+		.start = IRQ_IOP32X_DMA1_ERR,
+		.end = IRQ_IOP32X_DMA1_ERR,
+		.flags = IORESOURCE_IRQ
+	}
+};
+
+
+static struct resource iop3xx_aau_resources[] = {
+	[0] = {
+		.start = (unsigned long) IOP3XX_AAU_ACR,
+		.end = (unsigned long) IOP3XX_AAU_SAR_EDCR(32),
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_IOP32X_AA_EOT,
+		.end = IRQ_IOP32X_AA_EOT,
+		.flags = IORESOURCE_IRQ
+	},
+	[2] = {
+		.start = IRQ_IOP32X_AA_EOC,
+		.end = IRQ_IOP32X_AA_EOC,
+		.flags = IORESOURCE_IRQ
+	},
+	[3] = {
+		.start = IRQ_IOP32X_AA_ERR,
+		.end = IRQ_IOP32X_AA_ERR,
+		.flags = IORESOURCE_IRQ
+	}
+};
+
+static u64 iop3xx_adma_dmamask = DMA_32BIT_MASK;
+
+static struct iop_adma_platform_data iop3xx_dma_0_data = {
+	.hw_id = IOP3XX_DMA0_ID,
+	.capabilities =	DMA_MEMCPY | DMA_MEMCPY_CRC32C,
+	.pool_size = PAGE_SIZE,
+};
+
+static struct iop_adma_platform_data iop3xx_dma_1_data = {
+	.hw_id = IOP3XX_DMA1_ID,
+	.capabilities =	DMA_MEMCPY | DMA_MEMCPY_CRC32C,
+	.pool_size = PAGE_SIZE,
+};
+
+static struct iop_adma_platform_data iop3xx_aau_data = {
+	.hw_id = IOP3XX_AAU_ID,
+	.capabilities =	DMA_XOR | DMA_ZERO_SUM | DMA_MEMSET,
+	.pool_size = 3 * PAGE_SIZE,
+};
+
+struct platform_device iop3xx_dma_0_channel = {
+	.name = "IOP-ADMA",
+	.id = 0,
+	.num_resources = 4,
+	.resource = iop3xx_dma_0_resources,
+	.dev = {
+		.dma_mask = &iop3xx_adma_dmamask,
+		.coherent_dma_mask = DMA_64BIT_MASK,
+		.platform_data = (void *) &iop3xx_dma_0_data,
+	},
+};
+
+struct platform_device iop3xx_dma_1_channel = {
+	.name = "IOP-ADMA",
+	.id = 1,
+	.num_resources = 4,
+	.resource = iop3xx_dma_1_resources,
+	.dev = {
+		.dma_mask = &iop3xx_adma_dmamask,
+		.coherent_dma_mask = DMA_64BIT_MASK,
+		.platform_data = (void *) &iop3xx_dma_1_data,
+	},
+};
+
+struct platform_device iop3xx_aau_channel = {
+	.name = "IOP-ADMA",
+	.id = 2,
+	.num_resources = 4,
+	.resource = iop3xx_aau_resources,
+	.dev = {
+		.dma_mask = &iop3xx_adma_dmamask,
+		.coherent_dma_mask = DMA_64BIT_MASK,
+		.platform_data = (void *) &iop3xx_aau_data,
+	},
+};
+#endif /* CONFIG_DMA_ENGINE */
+
+extern struct platform_device iop3xx_dma_0_channel;
+extern struct platform_device iop3xx_dma_1_channel;
+extern struct platform_device iop3xx_aau_channel;
 static void __init iq80321_init_machine(void)
 {
 	platform_device_register(&iop3xx_i2c0_device);
 	platform_device_register(&iop3xx_i2c1_device);
 	platform_device_register(&iq80321_flash_device);
 	platform_device_register(&iq80321_serial_device);
+	#ifdef CONFIG_DMA_ENGINE
+	platform_device_register(&iop3xx_dma_0_channel);
+	platform_device_register(&iop3xx_dma_1_channel);
+	platform_device_register(&iop3xx_aau_channel);
+	#endif
+
 }
 
 MACHINE_START(IQ80321, "Intel IQ80321")
diff --git a/arch/arm/mach-iop33x/iq80331.c b/arch/arm/mach-iop33x/iq80331.c
index 3807000..34bedc6 100644
--- a/arch/arm/mach-iop33x/iq80331.c
+++ b/arch/arm/mach-iop33x/iq80331.c
@@ -122,6 +122,10 @@ static struct platform_device iq80331_fl
 	.resource	= &iq80331_flash_resource,
 };
 
+
+extern struct platform_device iop3xx_dma_0_channel;
+extern struct platform_device iop3xx_dma_1_channel;
+extern struct platform_device iop3xx_aau_channel;
 static void __init iq80331_init_machine(void)
 {
 	platform_device_register(&iop3xx_i2c0_device);
@@ -129,6 +133,11 @@ static void __init iq80331_init_machine(
 	platform_device_register(&iop33x_uart0_device);
 	platform_device_register(&iop33x_uart1_device);
 	platform_device_register(&iq80331_flash_device);
+	#ifdef CONFIG_DMA_ENGINE
+	platform_device_register(&iop3xx_dma_0_channel);
+	platform_device_register(&iop3xx_dma_1_channel);
+	platform_device_register(&iop3xx_aau_channel);
+	#endif
 }
 
 MACHINE_START(IQ80331, "Intel IQ80331")
diff --git a/arch/arm/mach-iop33x/iq80332.c b/arch/arm/mach-iop33x/iq80332.c
index 8780d55..ed36016 100644
--- a/arch/arm/mach-iop33x/iq80332.c
+++ b/arch/arm/mach-iop33x/iq80332.c
@@ -129,6 +129,9 @@ static struct platform_device iq80332_fl
 	.resource	= &iq80332_flash_resource,
 };
 
+extern struct platform_device iop3xx_dma_0_channel;
+extern struct platform_device iop3xx_dma_1_channel;
+extern struct platform_device iop3xx_aau_channel;
 static void __init iq80332_init_machine(void)
 {
 	platform_device_register(&iop3xx_i2c0_device);
@@ -136,6 +139,11 @@ static void __init iq80332_init_machine(
 	platform_device_register(&iop33x_uart0_device);
 	platform_device_register(&iop33x_uart1_device);
 	platform_device_register(&iq80332_flash_device);
+	#ifdef CONFIG_DMA_ENGINE
+	platform_device_register(&iop3xx_dma_0_channel);
+	platform_device_register(&iop3xx_dma_1_channel);
+	platform_device_register(&iop3xx_aau_channel);
+	#endif
 }
 
 MACHINE_START(IQ80332, "Intel IQ80332")
diff --git a/arch/arm/mach-iop33x/setup.c b/arch/arm/mach-iop33x/setup.c
index e72face..fbdb998 100644
--- a/arch/arm/mach-iop33x/setup.c
+++ b/arch/arm/mach-iop33x/setup.c
@@ -28,6 +28,9 @@ #include <asm/hardware.h>
 #include <asm/hardware/iop3xx.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <asm/hardware/iop_adma.h>
 
 #define IOP33X_UART_XTAL 33334000
 
@@ -103,3 +106,132 @@ struct platform_device iop33x_uart1_devi
 	.num_resources	= 2,
 	.resource	= iop33x_uart1_resources,
 };
+
+#ifdef CONFIG_DMA_ENGINE
+/* AAU and DMA Channels */
+static struct resource iop3xx_dma_0_resources[] = {
+	[0] = {
+		.start = (unsigned long) IOP3XX_DMA_CCR(0),
+		.end = ((unsigned long) IOP3XX_DMA_DCR(0)) + 4,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_IOP33X_DMA0_EOT,
+		.end = IRQ_IOP33X_DMA0_EOT,
+		.flags = IORESOURCE_IRQ
+	},
+	[2] = {
+		.start = IRQ_IOP33X_DMA0_EOC,
+		.end = IRQ_IOP33X_DMA0_EOC,
+		.flags = IORESOURCE_IRQ
+	},
+	[3] = {
+		.start = IRQ_IOP33X_DMA0_ERR,
+		.end = IRQ_IOP33X_DMA0_ERR,
+		.flags = IORESOURCE_IRQ
+	}
+};
+
+static struct resource iop3xx_dma_1_resources[] = {
+	[0] = {
+		.start = (unsigned long) IOP3XX_DMA_CCR(1),
+		.end = ((unsigned long) IOP3XX_DMA_DCR(1)) + 4,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_IOP33X_DMA1_EOT,
+		.end = IRQ_IOP33X_DMA1_EOT,
+		.flags = IORESOURCE_IRQ
+	},
+	[2] = {
+		.start = IRQ_IOP33X_DMA1_EOC,
+		.end = IRQ_IOP33X_DMA1_EOC,
+		.flags = IORESOURCE_IRQ
+	},
+	[3] = {
+		.start = IRQ_IOP33X_DMA1_ERR,
+		.end = IRQ_IOP33X_DMA1_ERR,
+		.flags = IORESOURCE_IRQ
+	}
+};
+
+
+static struct resource iop3xx_aau_resources[] = {
+	[0] = {
+		.start = (unsigned long) IOP3XX_AAU_ACR,
+		.end = (unsigned long) IOP3XX_AAU_SAR_EDCR(32),
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_IOP33X_AA_EOT,
+		.end = IRQ_IOP33X_AA_EOT,
+		.flags = IORESOURCE_IRQ
+	},
+	[2] = {
+		.start = IRQ_IOP33X_AA_EOC,
+		.end = IRQ_IOP33X_AA_EOC,
+		.flags = IORESOURCE_IRQ
+	},
+	[3] = {
+		.start = IRQ_IOP33X_AA_ERR,
+		.end = IRQ_IOP33X_AA_ERR,
+		.flags = IORESOURCE_IRQ
+	}
+};
+
+static u64 iop3xx_adma_dmamask = DMA_32BIT_MASK;
+
+static struct iop_adma_platform_data iop3xx_dma_0_data = {
+	.hw_id = IOP3XX_DMA0_ID,
+	.capabilities =	DMA_MEMCPY | DMA_MEMCPY_CRC32C,
+	.pool_size = PAGE_SIZE,
+};
+
+static struct iop_adma_platform_data iop3xx_dma_1_data = {
+	.hw_id = IOP3XX_DMA1_ID,
+	.capabilities =	DMA_MEMCPY | DMA_MEMCPY_CRC32C,
+	.pool_size = PAGE_SIZE,
+};
+
+static struct iop_adma_platform_data iop3xx_aau_data = {
+	.hw_id = IOP3XX_AAU_ID,
+	.capabilities =	DMA_XOR | DMA_ZERO_SUM | DMA_MEMSET,
+	.pool_size = 3 * PAGE_SIZE,
+};
+
+struct platform_device iop3xx_dma_0_channel = {
+	.name = "IOP-ADMA",
+	.id = 0,
+	.num_resources = 4,
+	.resource = iop3xx_dma_0_resources,
+	.dev = {
+		.dma_mask = &iop3xx_adma_dmamask,
+		.coherent_dma_mask = DMA_64BIT_MASK,
+		.platform_data = (void *) &iop3xx_dma_0_data,
+	},
+};
+
+struct platform_device iop3xx_dma_1_channel = {
+	.name = "IOP-ADMA",
+	.id = 1,
+	.num_resources = 4,
+	.resource = iop3xx_dma_1_resources,
+	.dev = {
+		.dma_mask = &iop3xx_adma_dmamask,
+		.coherent_dma_mask = DMA_64BIT_MASK,
+		.platform_data = (void *) &iop3xx_dma_1_data,
+	},
+};
+
+struct platform_device iop3xx_aau_channel = {
+	.name = "IOP-ADMA",
+	.id = 2,
+	.num_resources = 4,
+	.resource = iop3xx_aau_resources,
+	.dev = {
+		.dma_mask = &iop3xx_adma_dmamask,
+		.coherent_dma_mask = DMA_64BIT_MASK,
+		.platform_data = (void *) &iop3xx_aau_data,
+	},
+};
+#endif /* CONFIG_DMA_ENGINE */
diff --git a/include/asm-arm/arch-iop32x/adma.h b/include/asm-arm/arch-iop32x/adma.h
new file mode 100644
index 0000000..5ed9203
--- /dev/null
+++ b/include/asm-arm/arch-iop32x/adma.h
@@ -0,0 +1,5 @@
+#ifndef IOP32X_ADMA_H
+#define IOP32X_ADMA_H
+#include <asm/hardware/iop3xx-adma.h>
+#endif
+
diff --git a/include/asm-arm/arch-iop33x/adma.h b/include/asm-arm/arch-iop33x/adma.h
new file mode 100644
index 0000000..4b92f79
--- /dev/null
+++ b/include/asm-arm/arch-iop33x/adma.h
@@ -0,0 +1,5 @@
+#ifndef IOP33X_ADMA_H
+#define IOP33X_ADMA_H
+#include <asm/hardware/iop3xx-adma.h>
+#endif
+
diff --git a/include/asm-arm/hardware/iop3xx-adma.h b/include/asm-arm/hardware/iop3xx-adma.h
new file mode 100644
index 0000000..34624b6
--- /dev/null
+++ b/include/asm-arm/hardware/iop3xx-adma.h
@@ -0,0 +1,901 @@
+/*
+ * Copyright(c) 2006 Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ * The full GNU General Public License is included in this distribution in the
+ * file called COPYING.
+ */
+#ifndef _IOP3XX_ADMA_H
+#define _IOP3XX_ADMA_H
+#include <linux/types.h>
+#include <asm/hardware.h>
+#include <asm/hardware/iop_adma.h>
+
+struct iop3xx_aau_desc_ctrl {
+	unsigned int int_en:1;
+	unsigned int blk1_cmd_ctrl:3;
+	unsigned int blk2_cmd_ctrl:3;
+	unsigned int blk3_cmd_ctrl:3;
+	unsigned int blk4_cmd_ctrl:3;
+	unsigned int blk5_cmd_ctrl:3;
+	unsigned int blk6_cmd_ctrl:3;
+	unsigned int blk7_cmd_ctrl:3;
+	unsigned int blk8_cmd_ctrl:3;
+	unsigned int blk_ctrl:2;
+	unsigned int dual_xor_en:1;
+	unsigned int tx_complete:1;
+	unsigned int zero_result_err:1;
+	unsigned int zero_result_en:1;
+	unsigned int dest_write_en:1;
+};
+
+struct iop3xx_aau_e_desc_ctrl {
+	unsigned int reserved:1;
+	unsigned int blk1_cmd_ctrl:3;
+	unsigned int blk2_cmd_ctrl:3;
+	unsigned int blk3_cmd_ctrl:3;
+	unsigned int blk4_cmd_ctrl:3;
+	unsigned int blk5_cmd_ctrl:3;
+	unsigned int blk6_cmd_ctrl:3;
+	unsigned int blk7_cmd_ctrl:3;
+	unsigned int blk8_cmd_ctrl:3;
+	unsigned int reserved2:7;
+};
+
+struct iop3xx_dma_desc_ctrl {
+	unsigned int pci_transaction:4;
+	unsigned int int_en:1;
+	unsigned int dac_cycle_en:1;
+	unsigned int mem_to_mem_en:1;
+	unsigned int crc_data_tx_en:1;
+	unsigned int crc_gen_en:1;
+	unsigned int crc_seed_dis:1;
+	unsigned int reserved:21;
+	unsigned int crc_tx_complete:1;
+};
+
+struct iop3xx_desc_dma {
+	u32 next_desc;
+	union {
+		u32 pci_src_addr;
+		u32 pci_dest_addr;
+		u32 src_addr;
+	};
+	union {
+		u32 upper_pci_src_addr;
+		u32 upper_pci_dest_addr;
+	};
+	union {
+		u32 local_pci_src_addr;
+		u32 local_pci_dest_addr;
+		u32 dest_addr;
+	};
+	u32 byte_count;
+	union {
+		u32 desc_ctrl;
+		struct iop3xx_dma_desc_ctrl desc_ctrl_field;
+	};
+	u32 crc_addr;		
+};
+
+struct iop3xx_desc_aau {
+	u32 next_desc;
+	u32 src[4];
+	u32 dest_addr;
+	u32 byte_count;
+	union {
+		u32 desc_ctrl;
+		struct iop3xx_aau_desc_ctrl desc_ctrl_field;
+	};
+	union {
+		u32 src_addr;
+		u32 e_desc_ctrl;
+		struct iop3xx_aau_e_desc_ctrl e_desc_ctrl_field;
+	} src_edc[31];
+};
+
+
+struct iop3xx_aau_gfmr {
+	unsigned int gfmr1:8;
+	unsigned int gfmr2:8;
+	unsigned int gfmr3:8;
+	unsigned int gfmr4:8;
+};
+
+struct iop3xx_desc_pq_xor {
+	u32 next_desc;
+	u32 src[3];
+	union {
+		u32 data_mult1;
+		struct iop3xx_aau_gfmr data_mult1_field;
+	};
+	u32 dest_addr;
+	u32 byte_count;
+	union {
+		u32 desc_ctrl;
+		struct iop3xx_aau_desc_ctrl desc_ctrl_field;
+	};
+	union {
+		u32 src_addr;
+		u32 e_desc_ctrl;
+		struct iop3xx_aau_e_desc_ctrl e_desc_ctrl_field;
+		u32 data_multiplier;
+		struct iop3xx_aau_gfmr data_mult_field;
+		u32 reserved;
+	} src_edc_gfmr[19];
+};
+
+struct iop3xx_desc_dual_xor {
+	u32 next_desc;
+	u32 src0_addr;
+	u32 src1_addr;
+	u32 h_src_addr;
+	u32 d_src_addr;
+	u32 h_dest_addr;
+	u32 byte_count;
+	union {
+		u32 desc_ctrl;
+		struct iop3xx_aau_desc_ctrl desc_ctrl_field;
+	};
+	u32 d_dest_addr;
+};
+
+union iop3xx_desc {
+	struct iop3xx_desc_aau *aau;
+	struct iop3xx_desc_dma *dma;
+	struct iop3xx_desc_pq_xor *pq_xor;
+	struct iop3xx_desc_dual_xor *dual_xor;
+	void *ptr;
+};
+
+static inline u32 iop_chan_get_current_descriptor(struct iop_adma_chan *chan)
+{
+	int id = chan->device->id;
+
+	switch (id) {
+	case IOP3XX_DMA0_ID:
+	case IOP3XX_DMA1_ID:
+		return *IOP3XX_DMA_DAR(id);
+	case IOP3XX_AAU_ID:
+		return *IOP3XX_AAU_ADAR;
+	default:
+		BUG();
+	}
+	return 0;
+}
+
+static inline void iop_chan_set_next_descriptor(struct iop_adma_chan *chan,
+						u32 next_desc_addr)
+{
+	int id = chan->device->id;
+
+	switch (id) {
+	case IOP3XX_DMA0_ID:
+	case IOP3XX_DMA1_ID:
+		*IOP3XX_DMA_NDAR(id) = next_desc_addr;
+		break;
+	case IOP3XX_AAU_ID:
+		*IOP3XX_AAU_ANDAR = next_desc_addr;
+		break;
+	}
+
+}
+
+#define IOP3XX_ADMA_STATUS_BUSY (1 << 10)
+#define IOP_ADMA_ZERO_SUM_MAX_BYTE_COUNT (1024)
+#define IOP_ADMA_XOR_MAX_BYTE_COUNT (16 * 1024 * 1024)
+
+static int iop_chan_is_busy(struct iop_adma_chan *chan)
+{
+	int id = chan->device->id;
+	int busy;
+
+	switch (id) {
+	case IOP3XX_DMA0_ID:
+	case IOP3XX_DMA1_ID:
+		busy = (*IOP3XX_DMA_CSR(id) & IOP3XX_ADMA_STATUS_BUSY) ? 1 : 0;
+		break;
+	case IOP3XX_AAU_ID:
+		busy = (*IOP3XX_AAU_ASR & IOP3XX_ADMA_STATUS_BUSY) ? 1 : 0;
+		break;
+	default:
+		busy = 0;
+		BUG();
+	}
+
+	return busy;
+}
+
+static inline int iop_desc_is_aligned(struct iop_adma_desc_slot *desc,
+					int num_slots)
+{
+	/* num_slots will only ever be 1, 2, 4, or 8 */
+	return (desc->idx & (num_slots - 1)) ? 0 : 1;
+}
+
+/* to do: support large (i.e. > hw max) buffer sizes */
+static inline int iop_chan_memcpy_slot_count(size_t len, int *slots_per_op)
+{
+	*slots_per_op = 1;
+	return 1;
+}
+
+/* to do: support large (i.e. > hw max) buffer sizes */
+static inline int iop_chan_memset_slot_count(size_t len, int *slots_per_op)
+{
+	*slots_per_op = 1;
+	return 1;
+}
+
+static inline int iop3xx_aau_xor_slot_count(size_t len, int src_cnt,
+					int *slots_per_op)
+{
+	const static int slot_count_table[] = { 0,
+					        1, 1, 1, 1, /* 01 - 04 */
+					        2, 2, 2, 2, /* 05 - 08 */
+					        4, 4, 4, 4, /* 09 - 12 */
+					        4, 4, 4, 4, /* 13 - 16 */
+					        8, 8, 8, 8, /* 17 - 20 */
+					        8, 8, 8, 8, /* 21 - 24 */
+					        8, 8, 8, 8, /* 25 - 28 */
+					        8, 8, 8, 8, /* 29 - 32 */
+					      };
+	*slots_per_op = slot_count_table[src_cnt];
+	return *slots_per_op;
+}
+
+static inline int iop_chan_xor_slot_count(size_t len, int src_cnt,
+						int *slots_per_op)
+{
+	int slot_cnt = iop3xx_aau_xor_slot_count(len, src_cnt, slots_per_op);
+
+	if (len <= IOP_ADMA_XOR_MAX_BYTE_COUNT)
+		return slot_cnt;
+
+	len -= IOP_ADMA_XOR_MAX_BYTE_COUNT;
+	while (len > IOP_ADMA_XOR_MAX_BYTE_COUNT) {
+		len -= IOP_ADMA_XOR_MAX_BYTE_COUNT;
+		slot_cnt += *slots_per_op;
+	}
+
+	if (len)
+		slot_cnt += *slots_per_op;
+
+	return slot_cnt;
+}
+
+/* zero sum on iop3xx is limited to 1k at a time so it requires multiple
+ * descriptors
+ */
+static inline int iop_chan_zero_sum_slot_count(size_t len, int src_cnt,
+						int *slots_per_op)
+{
+	int slot_cnt = iop3xx_aau_xor_slot_count(len, src_cnt, slots_per_op);
+
+	if (len <= IOP_ADMA_ZERO_SUM_MAX_BYTE_COUNT)
+		return slot_cnt;
+
+	len -= IOP_ADMA_ZERO_SUM_MAX_BYTE_COUNT;
+	while (len > IOP_ADMA_ZERO_SUM_MAX_BYTE_COUNT) {
+		len -= IOP_ADMA_ZERO_SUM_MAX_BYTE_COUNT;
+		slot_cnt += *slots_per_op;
+	}
+
+	if (len)
+		slot_cnt += *slots_per_op;
+
+	return slot_cnt;
+}
+
+static inline u32 iop_desc_get_dest_addr(struct iop_adma_desc_slot *desc,
+					struct iop_adma_chan *chan)
+{
+	union iop3xx_desc hw_desc = { .ptr = desc->hw_desc, };
+
+	switch (chan->device->id) {
+	case IOP3XX_DMA0_ID:
+	case IOP3XX_DMA1_ID:
+		return hw_desc.dma->dest_addr;
+	case IOP3XX_AAU_ID:
+		return hw_desc.aau->dest_addr;
+	default:
+		BUG();
+	}
+	return 0;
+}
+
+static inline u32 iop_desc_get_byte_count(struct iop_adma_desc_slot *desc,
+					struct iop_adma_chan *chan)
+{
+	union iop3xx_desc hw_desc = { .ptr = desc->hw_desc, };
+
+	switch (chan->device->id) {
+	case IOP3XX_DMA0_ID:
+	case IOP3XX_DMA1_ID:
+		return hw_desc.dma->byte_count;
+	case IOP3XX_AAU_ID:
+		return hw_desc.aau->byte_count;
+	default:
+		BUG();
+	}
+	return 0;
+}
+
+static inline int iop3xx_src_edc_idx(int src_idx)
+{
+	const static int src_edc_idx_table[] = { 0, 0, 0, 0,
+						 0, 1, 2, 3,
+						 5, 6, 7, 8,
+						 9, 10, 11, 12,
+						 14, 15, 16, 17,
+						 18, 19, 20, 21,
+						 23, 24, 25, 26,
+						 27, 28, 29, 30,
+					       };
+
+	return src_edc_idx_table[src_idx];
+}
+
+static inline u32 iop_desc_get_src_addr(struct iop_adma_desc_slot *desc,
+					struct iop_adma_chan *chan,
+					int src_idx)
+{
+	union iop3xx_desc hw_desc = { .ptr = desc->hw_desc, };
+
+	switch (chan->device->id) {
+	case IOP3XX_DMA0_ID:
+	case IOP3XX_DMA1_ID:
+		return hw_desc.dma->src_addr;
+	case IOP3XX_AAU_ID:
+		break;
+	default:
+		BUG();
+	}
+
+	if (src_idx < 4)
+		return hw_desc.aau->src[src_idx];
+	else
+		return hw_desc.aau->src_edc[iop3xx_src_edc_idx(src_idx)].src_addr;
+}
+
+static inline void iop3xx_aau_desc_set_src_addr(struct iop3xx_desc_aau *hw_desc,
+					int src_idx, dma_addr_t addr)
+{
+	if (src_idx < 4)
+		hw_desc->src[src_idx] = addr;
+	else
+		hw_desc->src_edc[iop3xx_src_edc_idx(src_idx)].src_addr = addr;
+}
+
+static inline void iop_desc_init_memcpy(struct iop_adma_desc_slot *desc)
+{
+	struct iop3xx_desc_dma *hw_desc = desc->hw_desc;
+	union {
+		u32 value;
+		struct iop3xx_dma_desc_ctrl field;
+	} u_desc_ctrl;
+
+	desc->src_cnt = 1;
+	u_desc_ctrl.value = 0;
+	u_desc_ctrl.field.mem_to_mem_en = 1;
+	u_desc_ctrl.field.pci_transaction = 0xe; /* memory read block */
+	hw_desc->desc_ctrl = u_desc_ctrl.value;
+	hw_desc->upper_pci_src_addr = 0;
+	hw_desc->crc_addr = 0;
+	hw_desc->next_desc = 0;
+}
+
+static inline void iop_desc_init_memset(struct iop_adma_desc_slot *desc)
+{
+	struct iop3xx_desc_aau *hw_desc = desc->hw_desc;
+	union {
+		u32 value;
+		struct iop3xx_aau_desc_ctrl field;
+	} u_desc_ctrl;
+
+	desc->src_cnt = 1;
+	u_desc_ctrl.value = 0;
+	u_desc_ctrl.field.blk1_cmd_ctrl = 0x2; /* memory block fill */
+	u_desc_ctrl.field.dest_write_en = 1;
+	hw_desc->desc_ctrl = u_desc_ctrl.value;
+	hw_desc->next_desc = 0;
+}
+
+static inline u32 iop3xx_desc_init_xor(struct iop3xx_desc_aau *hw_desc,
+				int src_cnt)
+{
+	int i, shift;
+	u32 edcr;
+	union {
+		u32 value;
+		struct iop3xx_aau_desc_ctrl field;
+	} u_desc_ctrl;
+
+	u_desc_ctrl.value = 0;
+	switch (src_cnt) {
+	case 25 ... 32:
+		u_desc_ctrl.field.blk_ctrl = 0x3; /* use EDCR[2:0] */
+		edcr = 0;
+		shift = 1;
+		for (i = 24; i < src_cnt; i++) {
+			edcr |= (1 << shift);
+			shift += 3;
+		}
+		hw_desc->src_edc[IOP3XX_AAU_EDCR2_IDX].e_desc_ctrl = edcr;
+		src_cnt = 24;
+		/* fall through */
+	case 17 ... 24:
+		if (!u_desc_ctrl.field.blk_ctrl) {
+			hw_desc->src_edc[IOP3XX_AAU_EDCR2_IDX].e_desc_ctrl = 0;
+			u_desc_ctrl.field.blk_ctrl = 0x3; /* use EDCR[2:0] */
+		}
+		edcr = 0;
+		shift = 1;
+		for (i = 16; i < src_cnt; i++) {
+			edcr |= (1 << shift);
+			shift += 3;
+		}
+		hw_desc->src_edc[IOP3XX_AAU_EDCR1_IDX].e_desc_ctrl = edcr;
+		src_cnt = 16;
+		/* fall through */
+	case 9 ... 16:
+		if (!u_desc_ctrl.field.blk_ctrl)
+			u_desc_ctrl.field.blk_ctrl = 0x2; /* use EDCR0 */
+		edcr = 0;
+		shift = 1;
+		for (i = 8; i < src_cnt; i++) {
+			edcr |= (1 << shift);
+			shift += 3;
+		}
+		hw_desc->src_edc[IOP3XX_AAU_EDCR0_IDX].e_desc_ctrl = edcr;
+		src_cnt = 8;
+		/* fall through */
+	case 2 ... 8:
+		shift = 1;
+		for (i = 0; i < src_cnt; i++) {
+			u_desc_ctrl.value |= (1 << shift);
+			shift += 3;
+		}
+
+		if (!u_desc_ctrl.field.blk_ctrl && src_cnt > 4)
+			u_desc_ctrl.field.blk_ctrl = 0x1; /* use mini-desc */
+	}
+
+	u_desc_ctrl.field.dest_write_en = 1;
+	u_desc_ctrl.field.blk1_cmd_ctrl = 0x7; /* direct fill */
+	hw_desc->desc_ctrl = u_desc_ctrl.value;
+	hw_desc->next_desc = 0;
+
+	return u_desc_ctrl.value;
+}
+
+static inline void iop_desc_init_xor(struct iop_adma_desc_slot *desc,
+				int src_cnt)
+{
+	desc->src_cnt = src_cnt;
+	iop3xx_desc_init_xor(desc->hw_desc, src_cnt);
+}
+
+/* return the number of operations */
+static inline int iop_desc_init_zero_sum(struct iop_adma_desc_slot *desc,
+					int src_cnt,
+					int slot_cnt,
+					int slots_per_op)
+{
+	struct iop3xx_desc_aau *hw_desc, *prev_hw_desc, *iter;
+	union {
+		u32 value;
+		struct iop3xx_aau_desc_ctrl field;
+	} u_desc_ctrl;
+	int i = 0, j = 0;
+	hw_desc = desc->hw_desc;
+	desc->src_cnt = src_cnt;
+
+	do {
+		iter = iop_hw_desc_slot_idx(hw_desc, i);
+		u_desc_ctrl.value = iop3xx_desc_init_xor(iter, src_cnt);
+		u_desc_ctrl.field.dest_write_en = 0;
+		u_desc_ctrl.field.zero_result_en = 1;
+		/* for the subsequent descriptors preserve the store queue
+		 * and chain them together
+		 */
+		if (i) {
+			prev_hw_desc = iop_hw_desc_slot_idx(hw_desc, i - slots_per_op);
+			prev_hw_desc->next_desc = (u32) (desc->phys + (i << 5));
+		}
+		iter->desc_ctrl = u_desc_ctrl.value;
+		slot_cnt -= slots_per_op;
+		i += slots_per_op;
+		j++;
+	} while (slot_cnt);
+
+	return j;
+}
+
+static inline void iop_desc_init_null_xor(struct iop_adma_desc_slot *desc,
+				int src_cnt)
+{
+	struct iop3xx_desc_aau *hw_desc = desc->hw_desc;
+	union {
+		u32 value;
+		struct iop3xx_aau_desc_ctrl field;
+	} u_desc_ctrl;
+
+	u_desc_ctrl.value = 0;
+	switch (src_cnt) {
+	case 25 ... 32:
+		u_desc_ctrl.field.blk_ctrl = 0x3; /* use EDCR[2:0] */
+		hw_desc->src_edc[IOP3XX_AAU_EDCR2_IDX].e_desc_ctrl = 0;
+		/* fall through */
+	case 17 ... 24:
+		if (!u_desc_ctrl.field.blk_ctrl) {
+			hw_desc->src_edc[IOP3XX_AAU_EDCR2_IDX].e_desc_ctrl = 0;
+			u_desc_ctrl.field.blk_ctrl = 0x3; /* use EDCR[2:0] */
+		}
+		hw_desc->src_edc[IOP3XX_AAU_EDCR1_IDX].e_desc_ctrl = 0;
+		/* fall through */
+	case 9 ... 16:
+		if (!u_desc_ctrl.field.blk_ctrl)
+			u_desc_ctrl.field.blk_ctrl = 0x2; /* use EDCR0 */
+		hw_desc->src_edc[IOP3XX_AAU_EDCR0_IDX].e_desc_ctrl = 0;
+		/* fall through */
+	case 1 ... 8:
+		if (!u_desc_ctrl.field.blk_ctrl && src_cnt > 4)
+			u_desc_ctrl.field.blk_ctrl = 0x1; /* use mini-desc */
+	}
+
+	desc->src_cnt = src_cnt;
+	u_desc_ctrl.field.dest_write_en = 0;
+	hw_desc->desc_ctrl = u_desc_ctrl.value;
+	hw_desc->next_desc = 0;
+}
+
+static inline void iop_desc_set_byte_count(struct iop_adma_desc_slot *desc,
+					struct iop_adma_chan *chan,
+					u32 byte_count)
+{
+	union iop3xx_desc hw_desc = { .ptr = desc->hw_desc, };
+
+	switch (chan->device->id) {
+	case IOP3XX_DMA0_ID:
+	case IOP3XX_DMA1_ID:
+		hw_desc.dma->byte_count = byte_count;
+		break;
+	case IOP3XX_AAU_ID:
+		hw_desc.aau->byte_count = byte_count;
+		break;
+	default:
+		BUG();
+	}
+}
+
+static inline void iop_desc_set_zero_sum_byte_count(struct iop_adma_desc_slot *desc,
+					u32 len,
+					int slots_per_op)
+{
+	struct iop3xx_desc_aau *hw_desc = desc->hw_desc, *iter;
+	int i = 0;
+
+	if (len <= IOP_ADMA_ZERO_SUM_MAX_BYTE_COUNT) {
+		hw_desc->byte_count = len;
+	} else {
+		do {
+			iter = iop_hw_desc_slot_idx(hw_desc, i);
+			iter->byte_count = IOP_ADMA_ZERO_SUM_MAX_BYTE_COUNT;
+			len -= IOP_ADMA_ZERO_SUM_MAX_BYTE_COUNT;
+			i += slots_per_op;
+		} while (len > IOP_ADMA_ZERO_SUM_MAX_BYTE_COUNT);
+
+		if (len) {
+			iter = iop_hw_desc_slot_idx(hw_desc, i);
+			iter->byte_count = len;
+		}
+	}
+}
+
+static inline void iop_desc_set_dest_addr(struct iop_adma_desc_slot *desc,
+					struct iop_adma_chan *chan,
+					dma_addr_t addr)
+{
+	union iop3xx_desc hw_desc = { .ptr = desc->hw_desc, };
+
+	switch (chan->device->id) {
+	case IOP3XX_DMA0_ID:
+	case IOP3XX_DMA1_ID:
+		hw_desc.dma->dest_addr = addr;
+		break;
+	case IOP3XX_AAU_ID:
+		hw_desc.aau->dest_addr = addr;
+		break;
+	default:
+		BUG();
+	}
+}
+
+static inline void iop_desc_set_memcpy_src_addr(struct iop_adma_desc_slot *desc,
+					dma_addr_t addr, int slot_cnt,
+					int slots_per_op)
+{
+	struct iop3xx_desc_dma *hw_desc = desc->hw_desc;
+	hw_desc->src_addr = addr;
+}
+
+static inline void iop_desc_set_zero_sum_src_addr(struct iop_adma_desc_slot *desc,
+					int src_idx, dma_addr_t addr, int slot_cnt,
+					int slots_per_op)
+{
+
+	struct iop3xx_desc_aau *hw_desc = desc->hw_desc, *iter;
+	int i = 0;
+
+	do {
+		iter = iop_hw_desc_slot_idx(hw_desc, i);
+		iop3xx_aau_desc_set_src_addr(iter, src_idx, addr);
+		slot_cnt -= slots_per_op;
+		i += slots_per_op;
+		addr += IOP_ADMA_ZERO_SUM_MAX_BYTE_COUNT;
+	} while (slot_cnt);
+}
+
+static inline void iop_desc_set_xor_src_addr(struct iop_adma_desc_slot *desc,
+					int src_idx, dma_addr_t addr, int slot_cnt,
+					int slots_per_op)
+{
+
+	struct iop3xx_desc_aau *hw_desc = desc->hw_desc, *iter;
+	int i = 0;
+
+	do {
+		iter = iop_hw_desc_slot_idx(hw_desc, i);
+		iop3xx_aau_desc_set_src_addr(iter, src_idx, addr);
+		slot_cnt -= slots_per_op;
+		i += slots_per_op;
+		addr += IOP_ADMA_XOR_MAX_BYTE_COUNT;
+	} while (slot_cnt);
+}
+
+static inline void iop_desc_set_next_desc(struct iop_adma_desc_slot *desc,
+					struct iop_adma_chan *chan,
+					u32 next_desc_addr)
+{
+	union iop3xx_desc hw_desc = { .ptr = desc->hw_desc, };
+
+	switch (chan->device->id) {
+	case IOP3XX_DMA0_ID:
+	case IOP3XX_DMA1_ID:
+		BUG_ON(hw_desc.dma->next_desc);
+		hw_desc.dma->next_desc = next_desc_addr;
+		break;
+	case IOP3XX_AAU_ID:
+		BUG_ON(hw_desc.aau->next_desc);
+		hw_desc.aau->next_desc = next_desc_addr;
+		break;
+	default:
+		BUG();
+	}
+}
+
+static inline u32 iop_desc_get_next_desc(struct iop_adma_desc_slot *desc,
+					struct iop_adma_chan *chan)
+{
+	union iop3xx_desc hw_desc = { .ptr = desc->hw_desc, };
+
+	switch (chan->device->id) {
+	case IOP3XX_DMA0_ID:
+	case IOP3XX_DMA1_ID:
+		return hw_desc.dma->next_desc;
+	case IOP3XX_AAU_ID:
+		return hw_desc.aau->next_desc;
+	default:
+		BUG();
+	}
+
+	return 0;
+}
+
+static inline void iop_desc_set_block_fill_val(struct iop_adma_desc_slot *desc,
+						u32 val)
+{
+	struct iop3xx_desc_aau *hw_desc = desc->hw_desc;
+	hw_desc->src[0] = val;
+}
+
+#ifndef CONFIG_ARCH_IOP32X
+static inline int iop_desc_get_zero_result(struct iop_adma_desc_slot *desc)
+{
+	struct iop3xx_desc_aau *hw_desc = desc->hw_desc;
+	struct iop3xx_aau_desc_ctrl desc_ctrl = hw_desc->desc_ctrl_field;
+
+	BUG_ON(!(desc_ctrl.tx_complete && desc_ctrl.zero_result_en));
+	return desc_ctrl.zero_result_err;
+}
+#else
+extern char iop32x_zero_result_buffer[PAGE_SIZE];
+static inline int iop_desc_get_zero_result(struct iop_adma_desc_slot *desc)
+{
+	int i;
+
+	consistent_sync(iop32x_zero_result_buffer,
+			sizeof(iop32x_zero_result_buffer),
+			DMA_FROM_DEVICE);
+
+	for (i = 0; i < sizeof(iop32x_zero_result_buffer)/sizeof(u32); i++)
+		if (((u32 *) iop32x_zero_result_buffer)[i])
+			return 1;
+		else if ((i & 0x7) == 0) /* prefetch the next cache line */
+			prefetch(((u32 *) iop32x_zero_result_buffer) + 8);
+
+	return 0;
+}
+#endif
+
+static inline void iop_chan_append(struct iop_adma_chan *chan)
+{
+	int id = chan->device->id;
+	/* drain write buffer so ADMA can see updated descriptor */
+	asm volatile ("mcr p15, 0, r1, c7, c10, 4" : : : "%r1");
+
+	switch (id) {
+	case IOP3XX_DMA0_ID:
+	case IOP3XX_DMA1_ID:
+		*IOP3XX_DMA_CCR(id) |= 0x2;
+		break;
+	case IOP3XX_AAU_ID:
+		*IOP3XX_AAU_ACR |= 0x2;
+		break;
+	default:
+		BUG();
+	}
+}
+
+static inline void iop_chan_clear_status(struct iop_adma_chan *chan)
+{
+	int id = chan->device->id;
+	u32 status;
+
+	switch (id) {
+	case IOP3XX_DMA0_ID:
+	case IOP3XX_DMA1_ID:
+		status = *IOP3XX_DMA_CSR(id);
+		*IOP3XX_DMA_CSR(id) = status;
+		break;
+	case IOP3XX_AAU_ID:
+		status = *IOP3XX_AAU_ASR;
+		*IOP3XX_AAU_ASR = status;
+		break;
+	default:
+		BUG();
+	}
+}
+
+static inline u32 iop_chan_get_status(struct iop_adma_chan *chan)
+{
+	int id = chan->device->id;
+
+	switch (id) {
+	case IOP3XX_DMA0_ID:
+	case IOP3XX_DMA1_ID:
+		return *IOP3XX_DMA_CSR(id);
+	case IOP3XX_AAU_ID:
+		return *IOP3XX_AAU_ASR;
+	default:
+		BUG();
+	}
+}
+
+static inline void iop_chan_disable(struct iop_adma_chan *chan)
+{
+	int id = chan->device->id;
+
+	switch (id) {
+	case IOP3XX_DMA0_ID:
+	case IOP3XX_DMA1_ID:
+		*IOP3XX_DMA_CCR(id) &= ~0x1;
+		break;
+	case IOP3XX_AAU_ID:
+		*IOP3XX_AAU_ACR &= ~0x1;
+		break;
+	default:
+		BUG();
+	}
+}
+
+static inline void iop_chan_enable(struct iop_adma_chan *chan)
+{
+	int id = chan->device->id;
+
+	/* drain write buffer */
+	asm volatile ("mcr p15, 0, r1, c7, c10, 4" : : : "%r1");
+
+	switch (id) {
+	case IOP3XX_DMA0_ID:
+	case IOP3XX_DMA1_ID:
+		*IOP3XX_DMA_CCR(id) |= 0x1;
+		break;
+	case IOP3XX_AAU_ID:
+		*IOP3XX_AAU_ACR |= 0x1;
+		break;
+	default:
+		BUG();
+	}
+}
+
+static inline void iop_raid5_dma_chan_request(struct dma_client *client)
+{
+	dma_async_client_chan_request(client, 2, DMA_MEMCPY);
+	dma_async_client_chan_request(client, 1, DMA_XOR | DMA_ZERO_SUM);
+}
+
+static inline struct dma_chan *iop_raid5_dma_next_channel(struct dma_client *client)
+{
+	static struct dma_chan_client_ref *chan_ref = NULL;
+	static int req_idx = -1;
+	static struct dma_req *req[2];
+	
+	if (unlikely(req_idx < 0)) {
+		req[0] = &client->req[0];
+		req[1] = &client->req[1];
+	} 
+	
+	if (++req_idx > 1)
+		req_idx = 0;
+
+	spin_lock(&client->lock);
+	if (unlikely(list_empty(&req[req_idx]->channels)))
+		chan_ref = NULL;
+	else if (!chan_ref || chan_ref->req_node.next == &req[req_idx]->channels)
+		chan_ref = list_entry(req[req_idx]->channels.next, typeof(*chan_ref),
+					req_node);
+	else
+		chan_ref = list_entry(chan_ref->req_node.next,
+					typeof(*chan_ref), req_node);
+	spin_unlock(&client->lock);
+
+	return chan_ref ? chan_ref->chan : NULL;
+}
+
+static inline struct dma_chan *iop_raid5_dma_check_channel(struct dma_chan *chan,
+						dma_cookie_t cookie,
+						struct dma_client *client,
+						unsigned long capabilities)
+{
+	struct dma_chan_client_ref *chan_ref;
+
+	if ((chan->device->capabilities & capabilities) == capabilities)
+		return chan;
+	else if (dma_async_operation_complete(chan,
+					      cookie,
+					      NULL,
+					      NULL) == DMA_SUCCESS) {
+		/* dma channels on req[0] */
+		if (capabilities & (DMA_MEMCPY | DMA_MEMCPY_CRC32C))
+			chan_ref = list_entry(client->req[0].channels.next,
+						typeof(*chan_ref),
+						req_node);
+		/* aau channel on req[1] */
+		else
+			chan_ref = list_entry(client->req[1].channels.next,
+						typeof(*chan_ref),
+						req_node);
+		/* switch to the new channel */
+		dma_chan_put(chan);
+		dma_chan_get(chan_ref->chan);
+
+		return chan_ref->chan;
+	} else
+		return NULL;
+}
+#endif /* _IOP3XX_ADMA_H */
