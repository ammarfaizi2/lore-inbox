Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWJ3MCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWJ3MCv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 07:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWJ3MCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 07:02:51 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:26504 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1750735AbWJ3MCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 07:02:49 -0500
From: "Peter Pearse" <peter.pearse@arm.com>
To: <linux-kernel@vger.kernel.org>
Subject: [RFC 4/7][PATCH] AMBA DMA: Add a driver module for the DMA controller. 
Date: Mon, 30 Oct 2006 12:02:44 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: Acb8G0600wEN8njhSm6PsVx+7GkJ9Q==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Message-ID: <CAM-OWA1NTX9gHWdm4j00000005@cam-owa1.Emea.Arm.com>
X-OriginalArrivalTime: 30 Oct 2006 12:02:47.0315 (UTC) FILETIME=[5098DE30:01C6FC1B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM PL080 PrimeCell AMBA DMA controller is used as an example.

In addition to the driver files, an access functions is added 
to kernel/module.c. This allows the driver to increment/decrement 
its usage count since the DMA controller may be used by multiple 
AMBA peripherals.

Signed-off-by: Peter M Pearse <peter.pearse@arm.com> 

---

diff -purN arm_amba_dma/drivers/amba/Kconfig
arm_amba_pl080/drivers/amba/Kconfig
--- arm_amba_dma/drivers/amba/Kconfig	2006-10-17 17:10:15.000000000 +0100
+++ arm_amba_pl080/drivers/amba/Kconfig	2006-10-17 17:14:20.000000000 +0100
@@ -28,8 +28,20 @@ config HAS_ARM_AMBA_PL080
 	 This board has an AMBA PrimeCell PL080 DMA Controller.
 	 There is no driver implemented in this kernel.
 
+config ARM_AMBA_PL080_BUILTIN
+	bool "AMBA PrimeCell DMAC PL080 driver built in" if
(ARCH_VERSATILE_PB || MACH_VERSATILE_AB) && ARM_AMBA_DMA
+	---help---
+	 This board has an AMBA PrimeCell PL080 DMA Controller.
+	 Select whether it's driver should be built into the kernel or as a
module.
+	 Say yes to build it in.
+
 endmenu
 
+config ARM_AMBA_PL080_SUPPORT
+	def_tristate y  if (ARCH_VERSATILE_PB || MACH_VERSATILE_AB) &&
ARM_AMBA_DMA && ARM_AMBA_PL080_BUILTIN
+	def_tristate m  if (ARCH_VERSATILE_PB || MACH_VERSATILE_AB) &&
ARM_AMBA_DMA && !ARM_AMBA_PL080_BUILTIN
+	def_tristate n  
+
 config ARM_AMBA_DMA
 	bool "AMBA DMA support" if(ARCH_VERSATILE_PB || MACH_VERSATILE_AB)
 	depends on ARM_AMBA
diff -purN arm_amba_dma/drivers/amba/Makefile
arm_amba_pl080/drivers/amba/Makefile
--- arm_amba_dma/drivers/amba/Makefile	2006-10-17 17:10:15.000000000 +0100
+++ arm_amba_pl080/drivers/amba/Makefile	2006-10-17
17:14:20.000000000 +0100
@@ -1,4 +1,5 @@
-obj-y				+= bus.o
-obj-$(CONFIG_ARM_AMBA_DMA)	+= dma.o
+obj-y					+= bus.o
+obj-$(CONFIG_ARM_AMBA_DMA)		+= dma.o
+obj-$(CONFIG_ARM_AMBA_PL080_SUPPORT)	+= pl080.o
 
 
diff -purN arm_amba_dma/drivers/amba/pl080.c
arm_amba_pl080/drivers/amba/pl080.c
--- arm_amba_dma/drivers/amba/pl080.c	1970-01-01 01:00:00.000000000 +0100
+++ arm_amba_pl080/drivers/amba/pl080.c	2006-10-17 17:14:20.000000000 +0100
@@ -0,0 +1,567 @@
+/*
+ * drivers/amba/pl080.c - ARM PrimeCell DMA Controller PL080 driver
+ *
+ * Copyright (C) 2006 ARM Ltd, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Documentation: ARM DDI 0196F
+ */
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/err.h>
+#include <linux/amba/bus.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/sizes.h>
+#include <asm/dma.h>
+#include <asm/mach/dma.h>
+#include <linux/amba/dma.h>
+#include <linux/amba/pl080.h>
+
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/ac97_codec.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+
+#define DRIVER_NAME	"dmac-pl080"
+#define MODULE_NAME	"pl080"
+char pl080_type[0x10] = "PL080 DMAC";
+
+/*
+ * Power Management.
+ * PM support is not complete. Turn it off.
+ */
+#undef CONFIG_PM
+
+#ifdef CONFIG_PM
+#else
+# define pl080_do_suspend	NULL
+# define pl080_do_resume 	NULL
+# define pl080_suspend		NULL
+# define pl080_resume		NULL
+#endif
+
+
+static int	pl080_request(dmach_t cnum, dma_t * cdata);
+static void	pl080_free(dmach_t cnum, dma_t * cdata);
+static void 	pl080_enable(dmach_t cnum, dma_t * cdata);
+static void 	pl080_disable(dmach_t cnum, dma_t * cdata);
+static int	pl080_residue(dmach_t cnum, dma_t * cdata);
+static int	pl080_setspeed(dmach_t cnum, dma_t * cdata, int newspeed);
+
+static struct pl080_tag {
+	/* pl080 register base */
+	void __iomem *	base;
+	/*
+	 * - dma_pool for the LLIs
+	 * (can't use dma_alloc_coherent/free because of the requirement for
+	 * free() to have interrupts enabled when it is called)
+	 */
+	struct dma_pool * pool;
+	/* LLI details for each DMA channel */
+	chanlli * chanllis;
+} pl080;
+
+/* Predeclare the driver */
+static struct amba_driver pl080_driver;
+
+/* All int functions below return 0 for success unless detailed */
+
+static int pl080_request(dmach_t cnum, dma_t * cdata){
+	int retval = -EINVAL;
+
+	/* Increase the usage */
+	if(try_module_get(pl080_driver.drv.owner)){
+		retval = 0;
+	}
+
+	return retval;
+}
+
+static void pl080_free(dmach_t chan_num, dma_t * cdata){
+	unsigned int i, active_count = 0;
+
+	/*
+	 * Free any DMA memory in use for the LLIs
+	 */
+	if((pl080.chanllis[chan_num].va_list) &&
(pl080.chanllis[chan_num].bus_list)){
+		dma_pool_free(pl080.pool, pl080.chanllis[chan_num].va_list,
pl080.chanllis[chan_num].bus_list);
+		pl080.chanllis[chan_num].num_entries = 0;
+		pl080.chanllis[chan_num].va_list = NULL;
+		pl080.chanllis[chan_num].bus_list = (dma_addr_t)NULL;
+	}
+
+	/*
+	 * If no DMA channels active then deconfigure the DMAC entirely
+	 */
+	for(i = 0; i < MAX_DMA_CHANNELS; i++)
+		active_count += dma_channel_active((dmach_t)i);
+
+	if(!active_count)
+	{
+		unsigned int r;
+
+		r = readl(pl080.base + PL080_OS_CFG);
+		r &= PL080_MASK_CFG;
+		r &= ~PL080_MASK_EN;
+		writel(r, pl080.base + PL080_OS_CFG);
+	}
+	/* Decrease the usage */
+	module_put(pl080_driver.drv.owner);
+}
+
+/*
+ * Enable the DMA channel & terminal count interrupts on it
+ * TODO:: Currently hard coded for memory to peripheral transfer (DMA in
control)
+ *				- flow control setting should be stored in
cdata
+ */
+inline void pl080_enable(dmach_t cnum, dma_t * cdata){
+	void __iomem * cbase = pl080.base + PL080_OS_CHAN_BASE + (cnum *
PL080_OS_CHAN);
+	volatile unsigned int r = 0;
+
+	/*
+	 * Do not access config register until channel shows as disabled
+	 */
+	while((readl(pl080.base + PL080_OS_ENCHNS) & (1<< cnum)) &
PL080_MASK_ENCHNS){
+		;
+	}
+	mb();
+	r = readl(cbase + PL080_OS_CCFG );
+	mb();
+	writel((r | PL080_MASK_CEN | PL080_MASK_INTTC | PL080_MASK_INTERR |
PL080_FCMASK_M2P_DMA) &~(PL080_MASK_HALT), cbase + PL080_OS_CCFG );
+}
+
+/*
+ * Disable without losing data in the channel's FIFO:
+ * - Set the Halt bit so that subsequent DMA requests are ignored.
+ * - Poll the Active bit until it reaches 0, indicating that there is no
data
+ * 	remaining in the channel's FIFO.
+ * - Clear the Channel Enable bit.
+ *
+ * Currently not implemented correctly in the hardware
+ *
+ */
+/*
+ * TODO:: Currently hard coded for memory to peripheral transfer (DMA in
control)
+ *				- flow control setting should be stored in
cdata
+ */
+inline void pl080_disable(dmach_t cnum, dma_t * cdata){
+	void __iomem * cbase = pl080.base + PL080_OS_CHAN_BASE + (cnum *
PL080_OS_CHAN);
+	volatile unsigned int r = readl(cbase + PL080_OS_CCFG );
+
+#ifdef ERRATUM_FIXED
+	mb();
+	writel(r | PL080_MASK_HALT, cbase + PL080_OS_CCFG );
+	mb();
+	while(readl(cbase + PL080_OS_CCFG ) & PL080_MASK_ACTIVE){
+		;
+	}
+#else
+	// printk("pl080_disable() - check if we can use the active
flag\n");
+	// printk(" - this code doesn't\n");
+#endif
+	r = readl(cbase + PL080_OS_CCFG );
+	mb();
+	writel(r & ~(PL080_MASK_CEN) & ~(PL080_MASK_INTTC) &
~(PL080_MASK_INTERR & ~(PL080_FCMASK_M2P_DMA)), cbase + PL080_OS_CCFG );
+	mb();
+	while(readl(cbase + PL080_OS_CCFG ) & PL080_MASK_CEN){
+		;
+	}
+}
+
+/* 
+ * Disable the channel, read the control register, re-enable the channel
+ * May not be an accurate value - see TRM
+ * ASSUME returns bytes 
+ */
+static int pl080_residue(dmach_t cnum, dma_t * cdata){
+	void __iomem * cbase = pl080.base + PL080_OS_CHAN_BASE + (cnum *
PL080_OS_CHAN) + PL080_OS_CCTL;
+	volatile unsigned int r = 0;
+
+	pl080_disable(cnum, cdata);
+	mb();
+
+	/* The number of source width transfers (AACI == 32 bits) completed
*/
+	r = readl(cbase + PL080_OS_CCTL ) & PL080_MASK_TSFR_SIZE;
+	mb();
+
+	pl080_enable(cnum, cdata);
+
+	return r * 4;
+}
+
+/* Not implemented - should return the new speed */
+static int pl080_setspeed(dmach_t cnum, dma_t * cdata, int newspeed){
+	return 0;
+}
+
+#ifdef PL080_IRQ_REQUIRED
+/* 
+ * Each AMBA device requesting DMA chains its interrupt handler to the DMA
interrupt,
+ * rather than this handler attaching this interrupt....
+ */
+static irqreturn_t pl080_irq(int irq, void *devid, struct pt_regs *regs)
+{
+	u32 mask = 0;
+
+	return mask ? IRQ_HANDLED : IRQ_NONE;
+}
+#endif
+
+/* 
+ * The operations required for the pl080
+ * to control DMA transfers, in addition
+ * to the standard ISA DMA API
+ */
+pl080_extra_ops pl080_ops = {
+	.reset_cycle		= pl080_reset_cycle ,
+	.configure_chan		= pl080_configure_chan ,
+	.make_llis		= pl080_make_llis	 , 
+	.transfer_configure	= pl080_transfer_configure,
+};
+
+/*
+ * Complete the DMA channel initialization
+ * started by the AMBA DMA code
+ * - Set the dma ops for the board to call
+ */
+static int __devinit pl080_probe(struct amba_device *dev, void *id)
+{
+	int ret,i;
+
+	ret = amba_request_regions(dev, NULL);
+	if (ret)
+		return ret;
+
+	pl080.base = ioremap(dev->res.start, SZ_4K);
+	if (!pl080.base) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * Make one struct for each DMA channel
+	 * to hold details of its LLIs
+	 */
+	pl080.chanllis = kmalloc(sizeof(chanlli) * MAX_DMA_CHANNELS,
GFP_KERNEL);
+	if (!pl080.chanllis) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for(i = 0; i < MAX_DMA_CHANNELS; i++){
+		pl080.chanllis[i].num_entries = 0;
+		pl080.chanllis[i].va_list = NULL;
+		pl080.chanllis[i].bus_list = (dma_addr_t)NULL;
+	}
+
+	if(!(pl080.pool = dma_pool_create(pl080_driver.drv.name, (struct
device *)dev,
+			PL080_MAX_LLIS_SIZE, PL080_ALIGN, PL080_ALLOC))){
+
+		kfree(pl080.chanllis);
+		ret = -ENOMEM;
+		goto out;
+	}
+	/* TODO:: Get the parameters from amb_device */
+	pl080_init_dma(dev->chans, dev->dmac_ops);
+	pl080_driver.drv.owner = try_find_module(MODULE_NAME);
+	
+	return ret;
+
+ out:
+	amba_release_regions(dev);
+	return ret;
+}
+
+static struct amba_id pl080_ids[] = {
+	{
+		.id	= 0x00041080,
+		.mask	= 0x000fffff,
+	},
+	{ 0, 0 },
+};
+
+static int __devexit pl080_remove(struct amba_device *dev);
+
+static struct amba_driver pl080_driver = {
+	.drv		= {
+		.name	= DRIVER_NAME,
+	},
+	.probe		= pl080_probe,
+	.remove		= __devexit_p(pl080_remove),
+	.suspend	= pl080_suspend,
+	.resume		= pl080_resume,
+	.id_table	= pl080_ids,
+};
+
+int pl080_init_dma(dma_t * dma_chan, struct dma_ops * ops){
+	int i;
+
+	for(i = 0; i < MAX_DMA_CHANNELS; i++){
+		dma_chan[i].dma_base = (unsigned int)pl080.base;
+	}
+	ops->request 	= pl080_request;
+	ops->free	= pl080_free;
+	ops->enable	= pl080_enable ;
+	ops->disable 	= pl080_disable;
+	ops->residue 	= pl080_residue;
+	ops->setspeed 	= pl080_setspeed;
+	ops->type 	= pl080_type;
+	
+	/* PL080 specific */
+	ops->extra_ops = &pl080_ops;
+
+	pl080_driver.dmac_ops = ops;
+
+	amba_init_dma(dma_chan);
+
+	return 0;
+}
+
+/*
+ * Note that the module usage count ensures that exit code
+ * is not called with a transfer active,,,
+ */
+static void pl080_close_dma(void){
+	unsigned long flags = claim_dma_lock();
+	pl080_driver.dmac_ops->request 	= NULL;
+	release_dma_lock(flags);
+}
+
+static int __devexit pl080_remove(struct amba_device *dev)
+{
+	int retval = -EINVAL;
+	pl080_close_dma();
+	if(pl080.pool){
+		dma_pool_destroy(pl080.pool);
+		pl080.pool = NULL;
+	}
+	amba_release_regions(dev);
+	return retval;
+}
+
+/*
+ * Module initialization
+ */
+static int __init pl080_init(void)
+{
+	pl080.base = NULL;
+	pl080.chanllis = NULL; /* LLI details for each DMA channel */
+	pl080.pool = NULL;
+	
+	return amba_driver_register(&pl080_driver);
+}
+/*
+ * Module destruction
+ */
+static void __exit pl080_exit(void)
+{
+	amba_driver_unregister(&pl080_driver);
+}
+
+/*
+ * Set up a circular linked list of period sized packets
+ * We loop until stopped by another entity
+ *
+ * TODO Abstract this function for use by any device.
+ * It has only been tested with VersatilePB/AACI
+ *
+ * - CAUTION ASSUMES FIXED dest, cword ?? other??
+ *
+ * All addresses stored in the LLI must be bus addresses
+ * Set the lower bit of the bus address to ensure the correct bus is used
+ * dma_chan[chan_num] holds the DMA buffer info
+ *
+ * Return bus address of first LLI
+ */
+dma_addr_t pl080_make_llis(dmach_t chan_num, unsigned int address, unsigned
int length, unsigned int packet_size, pl080_lli * setting){
+
+	int i;
+	unsigned int num_llis = 0;
+	/*
+	 * Whether we increment the lli address to indicate the bus
+	 * for this transfer
+	 */
+	unsigned int bus_increment = setting->next;
+	pl080_lli * llis_bus = NULL;
+	pl080_lli * llis_va = NULL;
+
+	if(NULL != pl080.chanllis[chan_num].va_list){
+		/*
+		 * Repeated call - destroy previous LLIs
+		 */
+		dma_pool_free(pl080.pool, pl080.chanllis[chan_num].va_list,
pl080.chanllis[chan_num].bus_list);
+		pl080.chanllis[chan_num].num_entries = 0;
+		pl080.chanllis[chan_num].va_list = NULL;
+		pl080.chanllis[chan_num].bus_list = (dma_addr_t)NULL;
+	}
+	/*
+ 	 * dma_chan[chan_num] holds the DMA buffer info
+	 */
+	setting->start = address;
+	num_llis = length / packet_size;
+
+	/* Get memory for the LLIs */
+	if(PL080_MAX_LLIS_SIZE < num_llis * sizeof(pl080_lli)){
+		printk(KERN_ERR "pl080.c::make_lli_aaci() - 0x%08x bytes
needed for the LLIs, consider rebuilding with PL080_MAX_LLIS_SIZE (0x%08x)
increased\n", 
+		num_llis * sizeof(pl080_lli), PL080_MAX_LLIS_SIZE);
+	} else {
+		pl080.chanllis[chan_num].va_list =
dma_pool_alloc(pl080.pool, GFP_KERNEL, &pl080.chanllis[chan_num].bus_list);
+	}
+	if(NULL == pl080.chanllis[chan_num].va_list){
+		printk(KERN_ERR "pl080.c::make_lli_aaci() - Failed to get
DMA memory for the LLIs\n");
+		return (dma_addr_t)NULL;
+	}
+
+	pl080.chanllis[chan_num].num_entries = num_llis;
+
+	llis_va	= (pl080_lli *) pl080.chanllis[chan_num].va_list;
+	llis_bus = (pl080_lli *) pl080.chanllis[chan_num].bus_list;
+
+	for(i = 0; i < num_llis - 1; i++){
+		llis_va[i].start = (dma_addr_t)((unsigned int)setting->start
+ (i * packet_size));
+		llis_va[i].dest	 = setting->dest;
+		llis_va[i].cword = setting->cword;
+
+		/*
+		 * Adjust to access the memory on the correct DMA bus
+		 */
+		llis_va[i].next = (dma_addr_t)((unsigned int) &llis_bus[i +
1] + bus_increment);
+	}
+	llis_va[i].start = (dma_addr_t)((unsigned int)setting->start + (i *
packet_size));
+	llis_va[i].dest	= setting->dest;
+	llis_va[i].cword = setting->cword;
+	llis_va[i].next = (dma_addr_t)((unsigned int) &llis_bus[0] +
bus_increment);
+
+	/*
+	 * Initial register setting
+	 */
+	setting->next = llis_va[0].next;
+
+	return pl080.chanllis[chan_num].bus_list;
+}
+
+/*
+ *	Generalized interrupt handling
+ *	i.e. not the terminal count part which will be device specific
+ */
+/* Handle only interrupts on the correct channel */
+static int pl080_ignore_this_irq(dmach_t dma_chan){
+	unsigned int r = readl(pl080.base + PL080_OS_ISR);
+	return !(r & 1 << dma_chan);
+}
+
+/*
+ * TODO:: Report the errors, rather than just clearing them
+ */
+static unsigned int errCtr = 0;
+static void pl080_pre_irq(dmach_t dma_chan){
+
+	unsigned int isr_err = readl(pl080.base + PL080_OS_ISR_ERR);
+	if((1 << dma_chan) & isr_err){
+		errCtr++;
+	}
+}
+/* Clear any interrupts on the correct channel */
+static void pl080_post_irq(dmach_t dma_chan){
+
+	/* Finally clear the interrupt of both kinds */
+	writel((1 << dma_chan), pl080.base + PL080_OS_ICLR_TC);
+	writel((1 << dma_chan), pl080.base + PL080_OS_ICLR_ERR);
+}
+
+/*
+ * Configure the DMAC
+ *
+ * LittleEndian, LittleEndian, disabled
+ */
+void pl080_configure(void){
+	unsigned int reg;
+
+	reg = readl(pl080.base + PL080_OS_CFG);
+	reg &= PL080_MASK_CFG;
+	reg |= PL080_MASK_EN;
+	writel(reg, pl080.base + PL080_OS_CFG);
+}
+
+/*
+ * Configure the DMA channel
+ *
+ * Set up interrupt calls for devices to use
+ * TODO:: Find a neater way.....
+ */
+void pl080_configure_chan(dmach_t chan_num, struct amba_dma_data * data){
+	/*
+	 * Set address of DMA channel registers
+	 */
+	unsigned int chan_base = (unsigned int)pl080.base +
PL080_OS_CHAN_BASE;
+	chan_base += chan_num * PL080_OS_CHAN;
+
+	/*
+	 * The interrupt handlers & destination are known
+	 * Interrupt data
+	 * - DMAC interrupt status register address
+	 * - mask to use
+	 * - DMAC interrupt clear address
+	 * - mask(s) to use
+	 */
+	 data->irq_ignore = pl080_ignore_this_irq;
+	 data->irq_pre = pl080_pre_irq;
+	 data->irq_post = pl080_post_irq;
+
+	/*
+	 * Always configure the pl080 itself,
+	 * in case this is the first channel configuration
+	 */
+	pl080_configure();
+
+}
+
+/*
+ * Restart the LLIs by setting the channel LLI
+ * register to point to the first entry
+ *
+ * Useful where e.g. the data supplier
+ * restarts due to perceived underrun
+ */
+void pl080_reset_cycle(dmach_t cnum){
+	void __iomem * cbase = (void __iomem * )((unsigned int)pl080.base +
(unsigned int)PL080_OS_CHAN_BASE + (unsigned int)(cnum * PL080_OS_CHAN));
+	writel((unsigned int)(((unsigned
int)(pl080.chanllis[cnum].bus_list)) + 1), cbase + PL080_OS_CLLI);
+}
+
+/*
+ * Set up the DMA channel registers for a transfer
+ * whose LLIs are ready
+ */
+void pl080_transfer_configure(dmach_t chan_num, pl080_lli *setting,
unsigned int ccfg){
+
+	unsigned int chan_base = (unsigned int)pl080.base +
PL080_OS_CHAN_BASE;
+	chan_base += chan_num * PL080_OS_CHAN;
+
+	writel(setting->start, chan_base + PL080_OS_CSRC);
+	writel(setting->dest , chan_base + PL080_OS_CDST);
+	writel(setting->next , chan_base + PL080_OS_CLLI);
+	writel(setting->cword, chan_base + PL080_OS_CCTL);
+	writel(ccfg , chan_base + PL080_OS_CCFG);
+}
+
+module_init(pl080_init);
+module_exit(pl080_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ARM PrimeCell PL080 DMA Controller driver");
+
+
diff -purN arm_amba_dma/include/linux/amba/pl080.h
arm_amba_pl080/include/linux/amba/pl080.h
--- arm_amba_dma/include/linux/amba/pl080.h	1970-01-01
01:00:00.000000000 +0100
+++ arm_amba_pl080/include/linux/amba/pl080.h	2006-10-17
17:14:20.000000000 +0100
@@ -0,0 +1,142 @@
+/*
+ *	linux/amba/pl080.h - ARM PrimeCell AACI DMA Controller driver
+ *
+ *	Copyright (C) 2005 ARM Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Please credit ARM.com
+ * Documentation: ARM DDI 0196D
+ */
+
+#ifndef AMBA_PL080_H
+#define AMBA_PL080_H 
+
+
+/*
+ * Memory to peripheral transfer may be visualized as
+ * 	Source burst data from memory to DMAC
+ *	Until no data left
+ *		On burst request from peripheral 
+ *			Destination burst from DMAC to peripheral
+ *			Clear burst request
+ *	Raise terminal count interrupt
+ *
+ * For peripherals with a FIFO:
+ * Source      burst size == half the depth of the peripheral FIFO
+ * Destination burst size == width of the peripheral FIFO
+ *
+ *
+ */
+
+/*
+ * Header for pl080 drivers
+ */
+
+
+/*
+ *  dma_pool defines
+ */
+
+#define PL080_MAX_LLIS_SIZE	0x2000	/* Size (bytes) of each buffer
allocated */
+#define PL080_ALIGN		8	/* Alignment each buffer allocated
*/
+#define PL080_ALLOC		0	/* Boundary not to cross 0 == N/A */
+ 
+#define	PL080_OS_ISR		0x00
+#define	PL080_OS_ISR_TC		0x04
+#define	PL080_OS_ICLR_TC	0x08
+#define	PL080_OS_ISR_ERR	0x0C
+#define	PL080_OS_ICLR_ERR	0x10
+#define	PL080_OS_ENCHNS		0x1C
+#define	PL080_MASK_ENCHNS	0x000000FF
+#define	PL080_OS_CFG		0x30
+#define	PL080_MASK_CFG		0xFFFFFFF1
+#define	PL080_MASK_EN		0x00000001
+#define	PL080_OS_CHAN_BASE	0x100
+#define	PL080_OS_CHAN		0x20
+#define	PL080_OS_CSRC		0x00
+#define	PL080_OS_CDST		0x04
+#define	PL080_OS_CLLI		0x08
+#define	PL080_MASK_CLLI		0x00000002
+#define	PL080_OS_CCTL		0x0C
+/*
+ *	The DMA channel control register entries (see pl080 TRM) have the
following units
+ *	Width 			- bits
+ *	Burst size		- number of transfers
+ *	Transfer (packet) size	- number of (destination width) transfers
+ *	See e.g include/asm-arm/arch-versatile/hardware.h
+ */
+#define	PL080_MASK_TSFR_SIZE	0x00000FFF
+#define	PL080_OS_CCFG		0x10
+#define	PL080_MASK_CEN		0x00000001
+#define	PL080_MASK_INTTC	0x00008000
+#define	PL080_MASK_INTERR	0x00004000
+#define	PL080_MASK_HALT		0x00040000
+#define	PL080_MASK_ACTIVE	0x00020000
+#define	PL080_MASK_CCFG		0x00000000
+/*
+ * Flow control bit masks
+ */
+/*
+ * Bit values for  Transfer type Controller
+ * [13 - 11]
+ */
+#define PL080_FCMASK_M2M_DMA	0x00000000	/* Memory-to-memory DMA */
+#define PL080_FCMASK_M2P_DMA	0x00000800	/* Memory-to-peripheral DMA
*/
+#define PL080_FCMASK_P2M_DMA	0x00001000	/* Peripheral-to-memory DMA
*/
+#define PL080_FCMASK_P2P_DMA	0x00001800	/* Source
peripheral-to-destination peripheral DMA */
+#define PL080_FCMASK_P2P_DST	0x00002000	/* Source
peripheral-to-destination peripheral Destination peripheral */
+#define PL080_FCMASK_M2P_PER	0x00002800	/* Memory-to-peripheral
Peripheral */
+#define PL080_FCMASK_P2P_PER	0x00003000	/* Peripheral-to-memory
Peripheral */
+#define PL080_FCMASK_P2P_SRC	0x00003800	/* Source
peripheral-to-destination peripheral Source peripheral */
+
+typedef struct _chan_lli {
+	dma_addr_t bus_list;	/* the linked lli list bus     address for
use in the LLI */
+	void	*  va_list;	/* the linked lli list virtual address for
use by the driver */
+	unsigned int num_entries; /* number of entries - might not be
circular */
+	unsigned int index_next; /* Index of next lli to load */
+} chanlli;
+
+/*
+ * An LLI struct - see pl080 TRM
+ */
+typedef struct _lli{
+	dma_addr_t start;
+	dma_addr_t dest;
+	dma_addr_t next;
+	unsigned int cword;
+} pl080_lli;
+
+/*
+ *  Channel register settings
+ */
+typedef struct _periph_id_dma_channel_settings {
+	unsigned int periphid;
+	unsigned int ctl;
+	unsigned int cfg;
+} setting;
+
+/*
+ *	One structure for each DMA channel
+ */
+extern chanlli * chanllis;
+
+int		pl080_init_dma		(dma_t * dma_chan, struct dma_ops *
ops);
+void		pl080_reset_cycle	(dmach_t chan_num);
+dma_addr_t	pl080_make_llis		(dmach_t chan_num, unsigned int
address, unsigned int length, unsigned int packet_size, pl080_lli *
setting);
+void		pl080_configure_chan	(dmach_t chan_num, struct
amba_dma_data * data);
+void		pl080_transfer_configure(dmach_t chan_num, pl080_lli *
setting, unsigned int ccfg);
+
+typedef struct _pl080_extra_ops {
+	void 	(*reset_cycle)(dmach_t cnum);
+	void 	(*configure_chan)(dmach_t chan_num, struct amba_dma_data *
data);
+	dma_addr_t (*make_llis)(dmach_t chan_num, unsigned int address,
unsigned int length, unsigned int packet_size, pl080_lli * setting);
+	void 	(*transfer_configure)(dmach_t chan_num, pl080_lli *setting,
unsigned int ccfg);
+} pl080_extra_ops;
+
+
+#endif	/* AMBA_PL080_H */
+
+
diff -purN arm_amba_dma/include/linux/module.h
arm_amba_pl080/include/linux/module.h
--- arm_amba_dma/include/linux/module.h	2006-10-17 13:29:42.000000000 +0100
+++ arm_amba_pl080/include/linux/module.h	2006-10-17
17:14:20.000000000 +0100
@@ -378,6 +378,11 @@ extern void __module_put_and_exit(struct
 	__attribute__((noreturn));
 #define module_put_and_exit(code) __module_put_and_exit(THIS_MODULE, code);
 
+/*
+ *  Allow drivers access to their owners by name
+ */
+extern struct module *try_find_module(const char *name);
+
 #ifdef CONFIG_MODULE_UNLOAD
 unsigned int module_refcount(struct module *mod);
 void __symbol_put(const char *symbol);
diff -purN arm_amba_dma/kernel/module.c arm_amba_pl080/kernel/module.c
--- arm_amba_dma/kernel/module.c	2006-10-17 13:29:46.000000000 +0100
+++ arm_amba_pl080/kernel/module.c	2006-10-17 17:14:20.000000000 +0100
@@ -297,6 +297,20 @@ static struct module *find_module(const 
 	}
 	return NULL;
 }
+/* 
+ * Export wrapped find_module to allow drivers to find their modules
+ * Useful for e.g. controlling the usage count
+ */ 
+struct module *try_find_module(const char *name)
+{
+	struct module *mod;
+	mutex_lock(&module_mutex);
+	mod = find_module(name);
+	mutex_unlock(&module_mutex);
+	return mod;
+}
+EXPORT_SYMBOL(try_find_module);
+
 
 #ifdef CONFIG_SMP
 /* Number of blocks used and allocated. */



