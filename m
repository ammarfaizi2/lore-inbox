Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWJ3MGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWJ3MGY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 07:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWJ3MGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 07:06:24 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:12169 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1751153AbWJ3MGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 07:06:23 -0500
From: "Peter Pearse" <peter.pearse@arm.com>
To: <linux-kernel@vger.kernel.org>
Subject: [RFC 7/7][PATCH] AMBA DMA: Patch to implement AMBA DMA for the Versatile AACI. 
Date: Mon, 30 Oct 2006 12:06:18 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: Acb8G85l4tOjvrXeSiqLxl6aGHgNzA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Message-ID: <CAM-OWA1Ms55Xt72XlV00000008@cam-owa1.Emea.Arm.com>
X-OriginalArrivalTime: 30 Oct 2006 12:06:21.0565 (UTC) FILETIME=[D04CD2D0:01C6FC1B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provides an example of use.
This patches completes the implementation of the example -
Audio playback via DMA on the Versatile board, which has an AMBA bus, 
with an AMBA PL080 DMA controller and an AMBA PL041 Advanced Audio 
Codec Interface.

Signed-off-by: Peter M Pearse <peter.pearse@arm.com> 

---

diff -purN arm_amba_aaci/arch/arm/mach-versatile/Makefile
arm_amba_dma_versatile/arch/arm/mach-versatile/Makefile
--- arm_amba_aaci/arch/arm/mach-versatile/Makefile	2006-10-17
13:28:39.000000000 +0100
+++ arm_amba_dma_versatile/arch/arm/mach-versatile/Makefile	2006-10-18
08:41:54.000000000 +0100
@@ -6,3 +6,4 @@ obj-y					:= core.o clock.o
 obj-$(CONFIG_ARCH_VERSATILE_PB)		+= versatile_pb.o
 obj-$(CONFIG_MACH_VERSATILE_AB)		+= versatile_ab.o
 obj-$(CONFIG_PCI)			+= pci.o
+obj-$(CONFIG_ARM_AMBA_DMA)		+= dma.o
diff -purN arm_amba_aaci/arch/arm/mach-versatile/core.c
arm_amba_dma_versatile/arch/arm/mach-versatile/core.c
--- arm_amba_aaci/arch/arm/mach-versatile/core.c	2006-10-17
13:28:39.000000000 +0100
+++ arm_amba_dma_versatile/arch/arm/mach-versatile/core.c	2006-10-18
08:41:54.000000000 +0100
@@ -47,13 +47,17 @@
 #include "core.h"
 #include "clock.h"
 
+#ifdef CONFIG_ARM_AMBA_DMA
+# include "dma.h"
+#endif
+
+
 /*
  * All IO addresses are mapped onto VA 0xFFFx.xxxx, where x.xxxx
  * is the (PA >> 12).
  *
  * Setup a VA for the Versatile Vectored Interrupt Controller.
  */
-#define __io_address(n)		__io(IO_ADDRESS(n))
 #define VA_VIC_BASE		__io_address(VERSATILE_VIC_BASE)
 #define VA_SIC_BASE		__io_address(VERSATILE_SIC_BASE)
 
@@ -704,7 +708,21 @@ AMBA_DEVICE(uart1, "dev:f2",  UART1,    
 AMBA_DEVICE(uart2, "dev:f3",  UART2,    NULL);
 AMBA_DEVICE(ssp0,  "dev:f4",  SSP,      NULL);
 
-static struct amba_device *amba_devs[] __initdata = {
+
+
+/*
+ * These devices are common to Versatile AB && PB 
+ */
+static struct amba_device *amba_devs[] 
+
+#ifdef CONFIG_ARM_AMBA_DMA
+/* 
+ *  Do not discard - used by AMBA DMA code
+ */
+__initdata = 
+#endif
+
+{
 	&dmac_device,
 	&uart0_device,
 	&uart1_device,
@@ -771,6 +789,16 @@ void __init versatile_init(void)
 	platform_device_register(&versatile_flash_device);
 	platform_device_register(&smc91x_device);
 
+#ifdef CONFIG_ARM_AMBA_DMA
+	/* 
+	 *  Register structure with device
+	 *  for later use by DMAC controller
+	 */
+	dmac_device.dmac_ops = &dmac_ops;
+#endif
+
+
+
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
 		amba_device_register(d, &iomem_resource);
diff -purN arm_amba_aaci/arch/arm/mach-versatile/core.h
arm_amba_dma_versatile/arch/arm/mach-versatile/core.h
--- arm_amba_aaci/arch/arm/mach-versatile/core.h	2006-10-17
13:28:39.000000000 +0100
+++ arm_amba_dma_versatile/arch/arm/mach-versatile/core.h	2006-10-18
08:41:54.000000000 +0100
@@ -30,6 +30,12 @@ extern void __init versatile_map_io(void
 extern struct sys_timer versatile_timer;
 extern unsigned int mmc_status(struct device *dev);
 
+/*
+ * All IO addresses are mapped onto VA 0xFFFx.xxxx, where x.xxxx
+ * is the (PA >> 12).
+ */
+#define __io_address(n)		__io(IO_ADDRESS(n))
+
 #define AMBA_DEVICE(name,busid,base,plat)			\
 static struct amba_device name##_device = {			\
 	.dev		= {					\
@@ -44,7 +50,6 @@ static struct amba_device name##_device 
 	},							\
 	.dma_mask	= ~0,					\
 	.irq		= base##_IRQ,				\
-	/* .dma		= base##_DMA,*/				\
 }
 
 #endif
diff -purN arm_amba_aaci/arch/arm/mach-versatile/versatile_ab.c
arm_amba_dma_versatile/arch/arm/mach-versatile/versatile_ab.c
--- arm_amba_aaci/arch/arm/mach-versatile/versatile_ab.c	2006-10-17
13:28:39.000000000 +0100
+++ arm_amba_dma_versatile/arch/arm/mach-versatile/versatile_ab.c
2006-10-18 08:41:54.000000000 +0100
@@ -43,3 +43,138 @@ MACHINE_START(VERSATILE_AB, "ARM-Versati
 	.timer		= &versatile_timer,
 	.init_machine	= versatile_init,
 MACHINE_END
+
+#ifdef CONFIG_ARM_AMBA_DMA
+
+# include "dma.h"
+# include <sound/driver.h>
+# include <sound/core.h>
+# include <sound/initval.h>
+# include <sound/ac97_codec.h>
+# include <sound/pcm.h>
+# include <sound/pcm_params.h>
+# include <linux/amba/pl080.h>
+
+extern setting settings[];
+
+/*
+ * Configure the board && the dma controller channel for the requesting
peripheral
+ * as far as possible when the actual transfer
+ * (source address, size, dest address, etc.) is not known
+ *
+ * Versatile AB :
+ *
+ *	DMA	Peripheral
+ *
+ *	 15 	UART0 Tx
+ *	 14 	UART0 Rx
+ *	 13 	UART1 Tx
+ *	 12 	UART1 Rx
+ *	 11 	UART2 Tx
+ *	 10 	UART2 Rx
+ *	 9 	SSP Tx
+ *	 8 	SSP Rx
+ *	 7 	SCI Tx
+ *	 6 	SCI Rx
+ *
+ *	5-3 	Unused
+ *
+ *	FPGA peripherals using DMA channels 0,1,2
+ *
+ *	 2	MMCI
+ *	 1	AACI	Tx
+ *	 0	AACI	Rx
+ *
+ *	Return 1 for success
+ *
+ */
+int versatileab_dma_configure(dmach_t chan_num, dma_t * chan_data, struct
amba_device * client){
+	int retval = 0;
+
+	/* Switch by client AMBA device part number*/
+	switch(amba_part(client)) {
+	case AMBA_PERIPHID_AACI_97:
+		/*
+		 * Only DMA channel 1 can be used for AACI DMA TX
+		 */
+		switch(chan_num){
+		case 1:
+
((pl080_extra_ops*)dmac_ops.extra_ops)->configure_chan(chan_num,
&client->dma_data);
+			retval = 1;
+			break;
+		default:
+			break;
+		}
+		break;
+
+	default:
+		printk(KERN_ERR
"mach-versatile/dma.c::versatile_dma_configure() Unexpected device %p,
periphid part number 0x%03x\n", client, amba_part(client));
+	}
+	return retval;
+}
+
+/*
+ *  Complete the setup of the transfer now all the data are known
+ */
+int versatileab_dma_transfer_setup(dmach_t chan_num, dma_t * chan_data,
struct amba_device * client){
+	pl080_lli setting;
+
+	unsigned int ccfg = 0;
+	dma_addr_t cllis = 0;
+	int retval = 0;
+	unsigned int periph_index = 0;
+
+	switch(amba_part(client)) {
+	case AMBA_PERIPHID_AACI_97:
+	{
+		// TODO:: RX DMA
+		while(amba_part(client) != settings[periph_index].periphid){
+			periph_index++;
+		}
+		ccfg 		= settings[periph_index].cfg;
+		/* Destination is the FIFO read/write register */
+		setting.dest 	= VERSATILE_AACI_BASE + (unsigned
int)client->dma_data.dmac_data;
+		setting.cword 	= settings[periph_index].ctl;
+
+		/*
+		 * Construct the LLIs
+		 */
+		// TODO:: determine whether the bus address needs the bus
distinguishing bit set
+		// - hard code the 1 for now
+		setting.next = 1;
+		cllis =
((pl080_extra_ops*)dmac_ops.extra_ops)->make_llis(chan_num,
chan_data->buf.dma_address, chan_data->count ,client->dma_data.packet_size,
&setting);
+
+		if(cllis) {
+			retval = 1;
+		} else {
+			printk(KERN_ERR
"mach-versatile/dma.c::versatile_dma_transfer_setup() No memory for
LLIs\n");
+		}
+	}
+		break;
+
+	default:
+		printk(KERN_ERR
"mach-versatile/dma.c::versatile_dma_transfer_setup() - Unexpected device
%p, periphid part number 0x%03x\n", client, amba_part(client));
+		return 0;
+		break;
+	}
+
+	if(retval)
+
((pl080_extra_ops*)dmac_ops.extra_ops)->transfer_configure(chan_num,
&setting, ccfg);
+
+	return retval;
+}
+
+static int __init versatile_ab_init(void)
+{
+	if (machine_is_versatile_ab()) {
+		vops.versatile_dma_configure = versatileab_dma_configure ;
+		vops.versatile_dma_transfer_setup =
versatileab_dma_transfer_setup;
+	}
+	return 0;
+}
+
+arch_initcall(versatile_ab_init);
+
+#endif /* CONFIG_ARM_AMBA_DMA */
+
+
diff -purN arm_amba_aaci/arch/arm/mach-versatile/versatile_pb.c
arm_amba_dma_versatile/arch/arm/mach-versatile/versatile_pb.c
--- arm_amba_aaci/arch/arm/mach-versatile/versatile_pb.c	2006-10-17
13:28:39.000000000 +0100
+++ arm_amba_dma_versatile/arch/arm/mach-versatile/versatile_pb.c
2006-10-18 08:41:54.000000000 +0100
@@ -81,6 +81,159 @@ static struct amba_device *amba_devs[] _
 	&mmc1_device,
 };
 
+#ifdef CONFIG_ARM_AMBA_DMA
+# include "dma.h"
+# include <sound/driver.h>
+# include <sound/core.h>
+# include <sound/initval.h>
+# include <sound/ac97_codec.h>
+# include <sound/pcm.h>
+# include <sound/pcm_params.h>
+# include <linux/amba/pl080.h>
+
+extern setting  settings[];
+
+/*
+ * Configure the board && the dma controller channel for the requesting
peripheral
+ * as far as possible when the actual transfer
+ * (source address, size, dest address, etc.) is not known
+ *
+ * Versatile PB :
+ *
+ *	Other possible assignments:
+ *	DMA	Peripheral
+ *
+ *	 15 	UART0 Tx
+ *	 14 	UART0 Rx
+ *	 13 	UART1 Tx
+ *	 12 	UART1 Rx
+ *	 11 	UART2 Tx
+ *	 10 	UART2 Rx
+ *	  9 	SSP Tx
+ *	  8 	SSP Rx
+ *	  7 	SCI Tx
+ *	  6 	SCI Rx
+ *
+ *	5-3 	I/O device in RealView Logic Tile
+ *
+ *	2-0 	I/O device in RealView Logic Tile or FPGA
+ *
+ *	FPGA peripherals using DMA channels 0,1,2
+ *
+ *	AACI	Tx
+ *	AACI	Rx
+ *	USB	A
+ *	USB	B
+ *	MCI	0
+ *	MCI	1
+ *	UART3	Tx
+ *	UART3	Rx
+ *	SCI0	int A
+ *	SCI0	int B
+ *
+ *	Return 1 for success
+ *
+ */
+int versatilepb_dma_configure(dmach_t chan_num, dma_t * chan_data, struct
amba_device * client){
+	int retval = 0;
+
+	/*
+	 *  Versatile DMA mapping register for assigned DMA channel
+	 */
+	void __iomem **map_base = __io_address(VERSATILE_SYS_BASE) +
VERSATILE_SYS_DMAPSR0_OFFSET + (chan_num * 4);
+
+	struct amba_dma_data * data = &client->dma_data;
+
+	/* Switch by client AMBA device part number*/
+	switch(amba_part(client)) {
+	case AMBA_PERIPHID_AACI_97:
+		/*
+		 * Only DMA channels 0,1,2 can be used for AACI DMA
+		 */
+		switch(chan_num){
+		case 0:
+		case 1:
+		case 2:
+			/*
+			 * Set V/PB DMA mapping register to connect
+			 * AACI Tx DMAC request signals to DMAC peripheral
#0 request lines
+			 *
+			 * ASSUMES Tx
+			 * TODO:: Distinguish Tx/Rx
+			 */
+			writel(
+				// [31:8] 	Reserved
+				(1 << 7) |	// 1 = Enable this mapping
+				// [6:5] 	Reserved
+				(0 << 0)	// 0b00000 = AACI Tx
+				, &map_base[chan_num]);
+
+
((pl080_extra_ops*)dmac_ops.extra_ops)->configure_chan(chan_num, data);
+			retval = 1;
+			break;
+		default:
+			break;
+		}
+		break;
+
+	default:
+		printk(KERN_ERR
"mach-versatile/dma.c::versatile_dma_configure() Unexpected device %p,
periphid part number 0x%03x\n", client, amba_part(client));
+	}
+	return retval;
+}
+
+/*
+ *  Complete the setup of the transfer now all the data are known
+ */
+int versatilepb_dma_transfer_setup(dmach_t chan_num, dma_t * chan_data,
struct amba_device * client){
+	pl080_lli setting;
+
+	unsigned int ccfg = 0;
+	dma_addr_t cllis = 0;
+	int retval = 0;
+	unsigned int periph_index = 0;
+
+	switch(amba_part(client)) {
+	case AMBA_PERIPHID_AACI_97:
+	{
+		while(amba_part(client) != settings[periph_index].periphid){
+			periph_index++;
+		}
+		ccfg 		= settings[periph_index].cfg;
+		/* Destination is the FIFO read/write register */
+		setting.dest 	= VERSATILE_AACI_BASE + (unsigned
int)client->dma_data.dmac_data;
+		setting.cword 	= settings[periph_index].ctl;
+
+		/*
+		 * Construct the LLIs
+		 */
+		// TODO:: determine whether the bus address needs the bus
distinguishing bit set
+		// - hard code the 1 for now
+		setting.next = 1;
+		cllis =
((pl080_extra_ops*)dmac_ops.extra_ops)->make_llis(chan_num,
chan_data->buf.dma_address, chan_data->count ,client->dma_data.packet_size,
&setting);
+
+		if(cllis) {
+			retval = 1;
+		} else {
+			printk(KERN_ERR
"mach-versatile/dma.c::versatile_dma_transfer_setup() No memory for
LLIs\n");
+		}
+	}
+		break;
+
+	default:
+		printk(KERN_ERR
"mach-versatile/dma.c::versatile_dma_transfer_setup() - Unexpected device
%p, periphid part number 0x%03x\n", client, amba_part(client));
+		return 0;
+		break;
+	}
+
+	if(retval)
+
((pl080_extra_ops*)dmac_ops.extra_ops)->transfer_configure(chan_num,
&setting, ccfg);
+
+	return retval;
+}
+
+#endif
+
 static int __init versatile_pb_init(void)
 {
 	int i;
@@ -90,6 +243,29 @@ static int __init versatile_pb_init(void
 			struct amba_device *d = amba_devs[i];
 			amba_device_register(d, &iomem_resource);
 		}
+
+#ifdef CONFIG_ARM_AMBA_DMA
+		{
+		volatile unsigned int r;
+		/*
+		 * Initial disposition of the DMA select signals
+		 * - later a contention mechanism must be implemented to
allow
+		 *   apps/drivers of the 10 FPGA sources to contend for the
3 lines
+		 */
+		/* AACI TX is line 0 */
+		r  = readl(VA_SYS_BASE + VERSATILE_SYS_DMAPSR0_OFFSET);
+		mb();
+		r &= VSYSMASK_DMAPSR;
+		r |= VSYS_VAL_DMAPSR_AACI_TX;
+		r |= VSYS_VAL_DMAPSR_ENABLE;
+		writel(r, VA_SYS_BASE + VERSATILE_SYS_DMAPSR0_OFFSET);
+		mb();
+
+		vops.versatile_dma_configure      =
versatilepb_dma_configure     ;
+		vops.versatile_dma_transfer_setup =
versatilepb_dma_transfer_setup;
+		}
+#endif
+
 	}
 
 	return 0;
diff -purN arm_amba_aaci/drivers/amba/Kconfig
arm_amba_dma_versatile/drivers/amba/Kconfig
--- arm_amba_aaci/drivers/amba/Kconfig	2006-10-17 17:14:20.000000000 +0100
+++ arm_amba_dma_versatile/drivers/amba/Kconfig	2006-10-18
08:41:54.000000000 +0100
@@ -48,4 +48,6 @@ config ARM_AMBA_DMA
 	select ISA_DMA_API
 	---help---
 	 Select to build ARM AMBA DMA support into the kernel.
+	 A suitable AMBA DMA controller driver may need to be selected as
well
+	 e.g. for Versatile the PL080 DMAC driver.
 
diff -purN arm_amba_aaci/drivers/amba/dma.c
arm_amba_dma_versatile/drivers/amba/dma.c
--- arm_amba_aaci/drivers/amba/dma.c	2006-10-18 08:33:41.000000000 +0100
+++ arm_amba_dma_versatile/drivers/amba/dma.c	2006-10-18
08:41:54.000000000 +0100
@@ -36,8 +36,11 @@ void amba_set_ops(struct dma_ops * ops){
 }
 
 /* Allow access to the DMA channel data held in arch/arm/kernel/dma.c */
+extern void board_dma_init(dma_t *dma);
 void __init arch_dma_init(dma_t *dma){
 	chans = dma;
+
+	board_dma_init(dma);
 }
 
 dma_t * amba_get_chans(void){
diff -purN arm_amba_aaci/drivers/amba/pl080.c
arm_amba_dma_versatile/drivers/amba/pl080.c
--- arm_amba_aaci/drivers/amba/pl080.c	2006-10-18 08:33:41.000000000 +0100
+++ arm_amba_dma_versatile/drivers/amba/pl080.c	2006-10-18
08:41:54.000000000 +0100
@@ -337,6 +337,7 @@ int pl080_init_dma(dma_t * dma_chan, str
 		/* PL080 specific */
 		ops->extra_ops = &pl080_ops;
 
+		/* Store a pointer to the structure to allow ops to be
removed at exit */
 		pl080_driver.dmac_ops = ops;
 
 		retval = amba_init_dma(dma_chan);
@@ -360,7 +361,6 @@ static void pl080_close_dma(void){
 static int __devexit pl080_remove(struct amba_device *dev)
 {
 	int retval = -EINVAL;
-	pl080_close_dma();
 	if(pl080.pool){
 		dma_pool_destroy(pl080.pool);
 		pl080.pool = NULL;
@@ -391,7 +391,8 @@ static int __init pl080_init(void)
  */
 static void __exit pl080_exit(void)
 {
-	amba_driver_unregister(&pl080_driver);
+	pl080_close_dma();
+	amba_driver_unregister(&pl080_driver); /* Causes remove() to be
called */
 }
 
 /*
diff -purN arm_amba_aaci/include/asm-arm/arch-versatile/dma.h
arm_amba_dma_versatile/include/asm-arm/arch-versatile/dma.h
--- arm_amba_aaci/include/asm-arm/arch-versatile/dma.h	2006-10-17
17:14:06.000000000 +0100
+++ arm_amba_dma_versatile/include/asm-arm/arch-versatile/dma.h	2006-10-18
08:41:54.000000000 +0100
@@ -18,4 +18,14 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
USA
  */
-#define MAX_DMA_CHANNELS 0
+#ifndef	__ASM_ARCH_DMA_H
+#define	__ASM_ARCH_DMA_H
+ 
+# define	MAX_DMA_ADDRESS		0xffffffff
+# ifdef CONFIG_ARM_AMBA_DMA
+#  define	MAX_DMA_CHANNELS	8	
+# else
+#  define	MAX_DMA_CHANNELS	0
+# endif	
+
+#endif	/* _ASM_ARCH_DMA_H */
diff -purN arm_amba_aaci/include/asm-arm/arch-versatile/hardware.h
arm_amba_dma_versatile/include/asm-arm/arch-versatile/hardware.h
--- arm_amba_aaci/include/asm-arm/arch-versatile/hardware.h	2006-10-17
13:29:29.000000000 +0100
+++ arm_amba_dma_versatile/include/asm-arm/arch-versatile/hardware.h
2006-10-18 08:41:54.000000000 +0100
@@ -49,4 +49,78 @@
 /* macro to get at IO space when running virtually */
 #define IO_ADDRESS(x)		(((x) & 0x0fffffff) + (((x) >> 4) &
0x0f000000) + 0xf0000000)
 
+#ifdef CONFIG_ARM_AMBA_DMA
+
+/* DMA defines for AACI/DMAC transfers 
+ * Packet is the data transferred during the run of one LLI
+ * Memory boundary size means the byte size of the data packet transferred
by one LLI
+ * Burst sizes are in bytes
+ * Transfer size is destination burst sizes in a source burst == run of one
LLI
+ */
+/*
+ * Register settings - see PrimeCell DMA Controller (PL080) TRM && AACI
PL041 TRM 
+ */
+# define	DMABlockSize	0x40 	// 64 transfers @ 32 bit width ==
256(0x100) bytes
+# define	DWidth		2 	// 32 bits  0/1/2
+# define	SWidth		2	// 32 bits  0/1/2
+# define	DBSize		3 	// 16 transfers @ 16 bit width ==
32(0x20) bytes AACI FIFO width /0 == 1/1 == 4/2 == 8/3 == 16/4 == 32/5 ==
64/6 == 128/7 == 256/
+# define	SBSize		5 	// Set to half of the AACI 512 byte
FIFO depth == 64 transfers @ 32 bit width == 256(0x100) bytes Memory
+				// - later check with FIFO status whether we
could use full depth
+/*
+ * TODO::
+ * - some from DMAC == same for all device DMA
+ * - some AACI device specific
+ */
+
+# define VDMA_AACI_CCTL
\
+	((1 << 31) | 		/* ALL  'I'    - Terminal count interrupt
enable 								*/ \
+	 (0 << 28) | 		/* ALL  'Prot' - AHB HPROT information to
destination slave. (Set to Not Cacheable, Not bufferable, User mode). */ \
+	 (0 << 27) | 		/* AACI 'DI'   - Destination address NOT
incremented after each transfer 					*/ \
+	 (1 << 26) | 		/* AACI 'SI'   - Source address incremented
after each transfer 						*/ \
+	 (0 << 25) | 		/* AACI 'D'    - Destination AHB master
select; 0=AHB1, 1=AHB2. (Transferring to AACI on V/PB M2 bus) 		*/ \
+	 (1 << 24) | 		/* AACI 'S'    - Source AHB master select;
0=AHB1, 1=AHB2. (Transferring from memory on V/PB DMA1 bus) 		*/ \
+	 (DWidth << 21) | 	/* AACI 'DWidth' - Destination transfer
width. 									*/ \
+	 (SWidth << 18) | 	/* ALL  'SWidth' - Source transfer width.
*/ \
+	 (DBSize << 15) | 	/* AACI 'DBSize' - Destination burst size.
*/ \
+	 			/*		   The number of bytes
transferred when the peripheral requests a burst of data. 		*/ \
+	                        /*                 AACI requests a burst
when the FIFO has four or less words.  				*/ \
+	 (SBSize << 12) | 	/* AACI 'SBSize' - Source burst size.
(Memory boundary size when transferring from memory). (Set to 256 bytes)
*/ \
+	 DMABlockSize) 		/* AACI Number of 'destination width'
transfers in one DMA 'packet'. (2^12)-1 is the maximum.
*/
+
+# define VDMA_AACI_CCFG
\
+			/* [31:19]          ALL   'Reserved'       - Write
as zero. 								*/ \
+	((0 << 18) | 	/* 'Halt'           ALL    - 0 = Allow DMA requests,
1 = Finish current request and ignore others 			*/ \
+	 (0 << 17) |	/* [17]        	    ALL    'Active'         - Read
only bit. 0 = No data in FIFO. 					*/ \
+	 (0 << 16) | 	/* 'L'              ALL  - Lock. Generates locked
tranfers on the AHB. 							*/ \
+	 (1 << 15) | 	/* 'ITC'            ALL  - Terminal Count Interrupt
mask. Masks TC interrupt when cleared. 				*/ \
+	 (1 << 14) | 	/* 'IE'             ALL  - Interrupt error mask.
Masks error interrupt when cleared. 					*/ \
+	 (1 << 11) | 	/* 'FlowCntrl'      AACI - Flow control method.
We're using Mem -> Peripheral, with the DMAC as the flow controller. 	*/ \
+	 (0 << 10) | 	/* 'Reserved'       ALL  - Write as zero
*/ \
+	 (0 << 6)  | 	/* 'DestPeripheral' AACI - Destination peripheral
number to associate with this channel. 				*/ \
+	 		/*			   Set zero here, OR in the
correct value in the machine initialisation				*/ \
+	                /*                         VPB uses #0, which is
shared with a logic tile DMA line on the V/PB. 			*/ \
+			/*                         AACI Must be selected in
V/PB SYS_DMAPSR0 reg. 						*/ \
+			/*                         VAB uses #1 AACI TX which
is fixed to DMA channel 1						*/ \
+	 (0 << 5)  | 	/* 'Reserved'       ALL  - Write as zero
*/ \
+	 (0 << 1)  | 	/* 'SrcPeripheral'  AACI - Source peripheral number
to associate with this channel. Ignored for 'from memory' transfers.*/ \
+	 (0 << 0))   	/* 'E'              ALL  - Enables this DMA channel.
(Channels automatically disabled when a transfer completes) 	*/
+#endif /* CONFIG_ARM_AMBA_DMA */
+
+#define VDMA_CCFG_PERIPHAL_NUM_0	0x00000000
+#define VDMA_CCFG_PERIPHAL_NUM_1	0x00000040
+#define VDMA_CCFG_PERIPHAL_NUM_2	0x00000080
+#define VDMA_CCFG_PERIPHAL_NUM_3	0x000000C0
+#define VDMA_CCFG_PERIPHAL_NUM_4	0x00000100
+#define VDMA_CCFG_PERIPHAL_NUM_5	0x00000140
+#define VDMA_CCFG_PERIPHAL_NUM_6	0x00000180
+#define VDMA_CCFG_PERIPHAL_NUM_7	0x000001C0
+#define VDMA_CCFG_PERIPHAL_NUM_8	0x00000200
+#define VDMA_CCFG_PERIPHAL_NUM_9	0x00000240
+#define VDMA_CCFG_PERIPHAL_NUM_A	0x00000280
+#define VDMA_CCFG_PERIPHAL_NUM_B	0x000002C0
+#define VDMA_CCFG_PERIPHAL_NUM_C	0x00000300
+#define VDMA_CCFG_PERIPHAL_NUM_D	0x00000340
+#define VDMA_CCFG_PERIPHAL_NUM_E	0x00000380
+#define VDMA_CCFG_PERIPHAL_NUM_F	0x000003C0
+
 #endif
diff -purN arm_amba_aaci/include/asm-arm/arch-versatile/platform.h
arm_amba_dma_versatile/include/asm-arm/arch-versatile/platform.h
--- arm_amba_aaci/include/asm-arm/arch-versatile/platform.h	2006-10-17
13:29:29.000000000 +0100
+++ arm_amba_dma_versatile/include/asm-arm/arch-versatile/platform.h
2006-10-18 08:41:54.000000000 +0100
@@ -86,6 +86,19 @@
 #define VERSATILE_SYS_BOOTCS_OFFSET           0x58
 #define VERSATILE_SYS_24MHz_OFFSET            0x5C
 #define VERSATILE_SYS_MISC_OFFSET             0x60
+
+#if defined(CONFIG_ARCH_VERSATILE_PB)
+# define VERSATILE_SYS_DMAPSR0_OFFSET	0x64
+# define VERSATILE_SYS_DMAPSR1_OFFSET	0x68
+# define VERSATILE_SYS_DMAPSR2_OFFSET	0x6C
+# define VSYSMASK_DMAPSR		0xFFFFFF60
+# define VSYS_VAL_DMAPSR_ENABLE		(1 << 7)
+# define VSYS_VAL_DMAPSR_AACI_TX	0x00000000
+# define VSYS_VAL_DMAPSR_AACI_RX	0x00000001
+# define VSYS_VAL_DMAPSR_USB_A		0x00000002
+# define VSYS_VAL_DMAPSR_USB_B		0x00000003
+#endif
+
 #define VERSATILE_SYS_TEST_OSC0_OFFSET        0x80
 #define VERSATILE_SYS_TEST_OSC1_OFFSET        0x84
 #define VERSATILE_SYS_TEST_OSC2_OFFSET        0x88
diff -purN arm_amba_aaci/sound/arm/aaci.c
arm_amba_dma_versatile/sound/arm/aaci.c
--- arm_amba_aaci/sound/arm/aaci.c	2006-10-18 08:35:36.000000000 +0100
+++ arm_amba_dma_versatile/sound/arm/aaci.c	2006-10-18
08:41:54.000000000 +0100
@@ -173,7 +173,7 @@ static inline void aaci_chan_wait_ready(
  * - called after each DMA packet (half a fifo depth)
  * ASSUMES local interrupts disabled
  */
-static irqreturn_t aaci_dma_irq(int irq, void *devid, struct pt_regs *regs)
+static irqreturn_t aaci_dma_irq(int irq, void *devid)
 {
 
 	struct amba_device *	client	= devid;


