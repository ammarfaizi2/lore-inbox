Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271781AbTGRPGv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271828AbTGRPDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:03:20 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36997
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271781AbTGROQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:16:21 -0400
Date: Fri, 18 Jul 2003 15:30:37 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181430.h6IEUbWq017868@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: Add HAL2 driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Ladislav Michl)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/sound/oss/hal2.c linux-2.6.0-test1-ac2/sound/oss/hal2.c
--- linux-2.6.0-test1/sound/oss/hal2.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test1-ac2/sound/oss/hal2.c	2003-07-11 16:40:47.000000000 +0100
@@ -0,0 +1,1498 @@
+/*
+ *  Driver for HAL2 sound processors
+ *  Copyright (c) 2001, 2002 Ladislav Michl <ladis@psi.cz>
+ *  
+ *  Based on Ulf Carlsson's code.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as 
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *  Supported devices:
+ *  /dev/dsp    standard dsp device, (mostly) OSS compatible
+ *  /dev/mixer	standard mixer device, (mostly) OSS compatible
+ *
+ *  BUGS:
+ *  + Driver currently supports indigo mode only.
+ *  + Recording doesn't work. I guess that it is caused by PBUS channel
+ *    misconfiguration, but until I get relevant info I'm unable to fix it.
+ */
+
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/poll.h>
+#include <linux/sound.h>
+#include <linux/soundcard.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/sgi/sgint23.h>
+
+#include "hal2.h"
+
+#if 0
+#define DEBUG(args...)		printk(args)
+#else
+#define DEBUG(args...)
+#endif
+
+#if 0 
+#define DEBUG_MIX(args...)	printk(args)
+#else
+#define DEBUG_MIX(args...)
+#endif
+
+#define H2_INDIRECT_WAIT(regs)	while (regs->isr & H2_ISR_TSTATUS);
+
+#define H2_READ_ADDR(addr)	(addr | (1<<7))
+#define H2_WRITE_ADDR(addr)	(addr)
+
+static char *hal2str = "HAL2 audio";
+static int ibuffers = 32;
+static int obuffers = 32;
+
+/* I doubt anyone has a machine with two HAL2 cards. It's possible to
+ * have two HPC's, so it is probably possible to have two HAL2 cards.
+ * Try to deal with it, but note that it is not tested.
+ */
+#define MAXCARDS	2
+static hal2_card_t* hal2_card[MAXCARDS];
+
+static const struct {
+	unsigned char idx:4, avail:1;
+} mixtable[SOUND_MIXER_NRDEVICES] = {
+	[SOUND_MIXER_PCM] = { H2_MIX_OUTPUT_ATT, 1 },	/* voice */
+	[SOUND_MIXER_MIC] = { H2_MIX_INPUT_GAIN, 1 },	/* mic */
+};
+
+#define H2_SUPPORTED_FORMATS	(AFMT_S16_LE | AFMT_S16_BE)
+
+static inline void hal2_isr_write(hal2_card_t *hal2, u32 val)
+{
+	hal2->ctl_regs->isr = val;
+}
+
+static inline u32 hal2_isr_look(hal2_card_t *hal2)
+{
+	return hal2->ctl_regs->isr;
+}
+
+static inline u32 hal2_rev_look(hal2_card_t *hal2)
+{
+	return hal2->ctl_regs->rev;
+}
+
+#if 0
+static u16 hal2_i_look16(hal2_card_t *hal2, u32 addr)
+{
+	hal2_ctl_regs_t *regs = hal2->ctl_regs;
+
+	regs->iar = H2_READ_ADDR(addr);
+	H2_INDIRECT_WAIT(regs);
+	return (regs->idr0 & 0xffff);
+}
+#endif
+
+static u32 hal2_i_look32(hal2_card_t *hal2, u32 addr)
+{
+	u32 ret;
+	hal2_ctl_regs_t *regs = hal2->ctl_regs;
+
+	regs->iar = H2_READ_ADDR(addr);
+	H2_INDIRECT_WAIT(regs);
+	ret = regs->idr0 & 0xffff;
+	regs->iar = H2_READ_ADDR(addr | 0x1);
+	H2_INDIRECT_WAIT(regs);
+	ret |= (regs->idr0 & 0xffff) << 16;
+	return ret;
+}
+
+static void hal2_i_write16(hal2_card_t *hal2, u32 addr, u16 val)
+{
+	hal2_ctl_regs_t *regs = hal2->ctl_regs;
+
+	regs->idr0 = val;
+	regs->idr1 = 0;
+	regs->idr2 = 0;
+	regs->idr3 = 0;
+	regs->iar = H2_WRITE_ADDR(addr);
+	H2_INDIRECT_WAIT(regs);
+}
+
+static void hal2_i_write32(hal2_card_t *hal2, u32 addr, u32 val)
+{
+	hal2_ctl_regs_t *regs = hal2->ctl_regs;
+
+	regs->idr0 = val & 0xffff;
+	regs->idr1 = val >> 16;
+	regs->idr2 = 0;
+	regs->idr3 = 0;
+	regs->iar = H2_WRITE_ADDR(addr);
+	H2_INDIRECT_WAIT(regs);
+}
+
+static void hal2_i_setbit16(hal2_card_t *hal2, u32 addr, u16 bit)
+{
+	hal2_ctl_regs_t *regs = hal2->ctl_regs;
+
+	regs->iar = H2_READ_ADDR(addr);
+	H2_INDIRECT_WAIT(regs);
+	regs->idr0 = regs->idr0 | bit;
+	regs->idr1 = 0;
+	regs->idr2 = 0;
+	regs->idr3 = 0;
+	regs->iar = H2_WRITE_ADDR(addr);
+	H2_INDIRECT_WAIT(regs);
+}
+
+static void hal2_i_setbit32(hal2_card_t *hal2, u32 addr, u32 bit)
+{
+	u32 tmp;
+	hal2_ctl_regs_t *regs = hal2->ctl_regs;
+
+	regs->iar = H2_READ_ADDR(addr);
+	H2_INDIRECT_WAIT(regs);
+	tmp = regs->idr0 | (regs->idr1 << 16) | bit;
+	regs->idr0 = tmp & 0xffff;
+	regs->idr1 = tmp >> 16;
+	regs->idr2 = 0;
+	regs->idr3 = 0;
+	regs->iar = H2_WRITE_ADDR(addr);
+	H2_INDIRECT_WAIT(regs);
+}
+
+static void hal2_i_clearbit16(hal2_card_t *hal2, u32 addr, u16 bit)
+{
+	hal2_ctl_regs_t *regs = hal2->ctl_regs;
+
+	regs->iar = H2_READ_ADDR(addr);
+	H2_INDIRECT_WAIT(regs);
+	regs->idr0 = regs->idr0 & ~bit;
+	regs->idr1 = 0;
+	regs->idr2 = 0;
+	regs->idr3 = 0;
+	regs->iar = H2_WRITE_ADDR(addr);
+	H2_INDIRECT_WAIT(regs);
+}
+
+#if 0
+static void hal2_i_clearbit32(hal2_card_t *hal2, u32 addr, u32 bit)
+{
+	u32 tmp;
+	hal2_ctl_regs_t *regs = hal2->ctl_regs;
+
+	regs->iar = H2_READ_ADDR(addr);
+	H2_INDIRECT_WAIT(regs);
+	tmp = (regs->idr0 | (regs->idr1 << 16)) & ~bit;
+	regs->idr0 = tmp & 0xffff;
+	regs->idr1 = tmp >> 16;
+	regs->idr2 = 0;
+	regs->idr3 = 0;
+	regs->iar = H2_WRITE_ADDR(addr);
+	H2_INDIRECT_WAIT(regs);
+}
+#endif
+
+#ifdef HAL2_DEBUG
+static void hal2_dump_regs(hal2_card_t *hal2)
+{
+	printk("isr: %08hx ", hal2_isr_look(hal2));
+	printk("rev: %08hx\n", hal2_rev_look(hal2));
+	printk("relay: %04hx\n", hal2_i_look16(hal2, H2I_RELAY_C));
+	printk("port en: %04hx ", hal2_i_look16(hal2, H2I_DMA_PORT_EN));
+	printk("dma end: %04hx ", hal2_i_look16(hal2, H2I_DMA_END));
+	printk("dma drv: %04hx\n", hal2_i_look16(hal2, H2I_DMA_DRV));
+	printk("syn ctl: %04hx ", hal2_i_look16(hal2, H2I_SYNTH_C));
+	printk("aesrx ctl: %04hx ", hal2_i_look16(hal2, H2I_AESRX_C));
+	printk("aestx ctl: %04hx ", hal2_i_look16(hal2, H2I_AESTX_C));
+	printk("dac ctl1: %04hx ", hal2_i_look16(hal2, H2I_ADC_C1));
+	printk("dac ctl2: %08lx ", hal2_i_look32(hal2, H2I_ADC_C2));
+	printk("adc ctl1: %04hx ", hal2_i_look16(hal2, H2I_DAC_C1));
+	printk("adc ctl2: %08lx ", hal2_i_look32(hal2, H2I_DAC_C2));
+	printk("syn map: %04hx\n", hal2_i_look16(hal2, H2I_SYNTH_MAP_C));
+	printk("bres1 ctl1: %04hx ", hal2_i_look16(hal2, H2I_BRES1_C1));
+	printk("bres1 ctl2: %04lx ", hal2_i_look32(hal2, H2I_BRES1_C2));
+	printk("bres2 ctl1: %04hx ", hal2_i_look16(hal2, H2I_BRES2_C1));
+	printk("bres2 ctl2: %04lx ", hal2_i_look32(hal2, H2I_BRES2_C2));
+	printk("bres3 ctl1: %04hx ", hal2_i_look16(hal2, H2I_BRES3_C1));
+	printk("bres3 ctl2: %04lx\n", hal2_i_look32(hal2, H2I_BRES3_C2));
+}
+#endif
+
+static hal2_card_t* hal2_dsp_find_card(int minor)
+{
+	int i;
+
+	for (i = 0; i < MAXCARDS; i++)
+		if (hal2_card[i] != NULL && hal2_card[i]->dev_dsp == minor)
+			return hal2_card[i];
+	return NULL;
+}
+
+static hal2_card_t* hal2_mixer_find_card(int minor)
+{
+	int i;
+
+	for (i = 0; i < MAXCARDS; i++)
+		if (hal2_card[i] != NULL && hal2_card[i]->dev_mixer == minor)
+			return hal2_card[i];
+	return NULL;
+}
+
+
+static void hal2_dac_interrupt(hal2_codec_t *dac)
+{
+	int running;
+
+	spin_lock(&dac->lock);
+	
+	/* if tail buffer contains zero samples DMA stream was already
+	 * stopped */
+	running = dac->tail->info.cnt;
+	dac->tail->info.cnt = 0;
+	dac->tail->info.desc.cntinfo = HPCDMA_XIE | HPCDMA_EOX;
+	dma_cache_wback_inv((unsigned long) dac->tail,
+			    sizeof(struct hpc_dma_desc));
+	/* we just proccessed empty buffer, don't update tail pointer */
+	if (running)
+		dac->tail = dac->tail->info.next;
+
+	spin_unlock(&dac->lock);
+
+	wake_up(&dac->dma_wait);
+}
+
+static void hal2_adc_interrupt(hal2_codec_t *adc)
+{
+	int running;
+	
+	spin_lock(&adc->lock);
+
+	/* if head buffer contains nonzero samples DMA stream was already
+	 * stopped */
+	running = !adc->head->info.cnt;
+	adc->head->info.cnt = H2_BUFFER_SIZE;
+	adc->head->info.desc.cntinfo = HPCDMA_XIE | HPCDMA_EOX;
+	dma_cache_wback_inv((unsigned long) adc->head,
+			    sizeof(struct hpc_dma_desc));
+	/* we just proccessed empty buffer, don't update head pointer */
+	if (running) {
+		dma_cache_inv((unsigned long) adc->head->data, H2_BUFFER_SIZE);
+		adc->head = adc->head->info.next;
+	}
+
+	spin_unlock(&adc->lock);
+
+	wake_up(&adc->dma_wait);
+}
+
+static irqreturn_t hal2_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	hal2_card_t *hal2 = (hal2_card_t*)dev_id;
+
+	/* decide what caused this interrupt */
+	if (hal2->dac.pbus.pbus->pbdma_ctrl & HPC3_PDMACTRL_INT)
+		hal2_dac_interrupt(&hal2->dac);
+	if (hal2->adc.pbus.pbus->pbdma_ctrl & HPC3_PDMACTRL_INT)
+		hal2_adc_interrupt(&hal2->adc);
+	return IRQ_HANDLED;
+}
+
+static int hal2_compute_rate(hal2_codec_t *codec, unsigned int rate)
+{
+	unsigned short inc;
+	
+	/* We default to 44.1 kHz and if it isn't possible to fall back to
+	 * 48.0 kHz with the needed adjustments of real_rate.
+	 */
+
+	DEBUG("rate: %d\n", rate);
+	
+	/* Refer to CS4216 data sheet */
+	if (rate < 4000)
+		rate = 4000;
+	if (rate > 50000)
+		rate = 50000;
+
+	/* Note: This is NOT the way they set up the bresenham clock generators
+	 * in the specification. I've tried to implement that method but it
+	 * doesn't work. It's probably another silly bug in the spec.
+	 *
+	 * I accidently discovered this method while I was testing and it seems
+	 * to work very well with all frequencies, and thee shall follow rule #1
+	 * of programming :-)
+	 */
+	
+	if (44100 % rate == 0) {
+		inc = 44100 / rate;
+		if (inc < 1) inc = 1;
+		codec->master = 44100;
+	} else {
+		inc = 48000 / rate;
+		if (inc < 1) inc = 1;
+		rate = 48000 / inc;
+		codec->master = 48000;
+	}
+	codec->inc = inc;
+	codec->mod = 1;
+	
+	DEBUG("real_rate: %d\n", rate);
+
+	return rate;
+}
+
+static void hal2_set_dac_rate(hal2_card_t *hal2)
+{
+	unsigned int master = hal2->dac.master;
+	int inc = hal2->dac.inc;
+	int mod = hal2->dac.mod;
+
+	DEBUG("master: %d inc: %d mod: %d\n", master, inc, mod);
+	
+	hal2_i_write16(hal2, H2I_BRES1_C1, (master == 44100) ? 1 : 0);
+	hal2_i_write32(hal2, H2I_BRES1_C2, ((0xffff & (mod - inc - 1)) << 16) | 1);
+}
+
+static void hal2_set_adc_rate(hal2_card_t *hal2)
+{
+	unsigned int master = hal2->adc.master;
+	int inc = hal2->adc.inc;
+	int mod = hal2->adc.mod;
+
+	DEBUG("master: %d inc: %d mod: %d\n", master, inc, mod);
+	
+	hal2_i_write16(hal2, H2I_BRES2_C1, (master == 44100) ? 1 : 0);
+	hal2_i_write32(hal2, H2I_BRES2_C2, ((0xffff & (mod - inc - 1)) << 16) | 1);
+}
+
+static void hal2_setup_dac(hal2_card_t *hal2)
+{
+	unsigned int fifobeg, fifoend, highwater, sample_size;
+	hal2_pbus_t *pbus = &hal2->dac.pbus;
+
+	DEBUG("hal2_setup_dac\n");
+	
+	/* Now we set up some PBUS information. The PBUS needs information about
+	 * what portion of the fifo it will use. If it's receiving or
+	 * transmitting, and finally whether the stream is little endian or big
+	 * endian. The information is written later, on the start call.
+	 */
+	sample_size = 2 * hal2->dac.voices;
+
+	/* Fifo should be set to hold exactly four samples. Highwater mark
+	 * should be set to two samples. */
+	highwater = (sample_size * 2) >> 1;	/* halfwords */
+	fifobeg = 0;				/* playback is first */
+	fifoend = (sample_size * 4) >> 3;	/* doublewords */
+	pbus->ctrl = HPC3_PDMACTRL_RT | HPC3_PDMACTRL_LD |
+		     (highwater << 8) | (fifobeg << 16) | (fifoend << 24);
+	/* We disable everything before we do anything at all */
+	pbus->pbus->pbdma_ctrl = HPC3_PDMACTRL_LD;
+	hal2_i_clearbit16(hal2, H2I_DMA_PORT_EN, H2I_DMA_PORT_EN_CODECTX);
+	hal2_i_clearbit16(hal2, H2I_DMA_DRV, (1 << pbus->pbusnr));
+	/* Setup the HAL2 for playback */
+	hal2_set_dac_rate(hal2);
+	/* We are using 1st Bresenham clock generator for playback */
+	hal2_i_write16(hal2, H2I_DAC_C1, (pbus->pbusnr << H2I_C1_DMA_SHIFT)
+			| (1 << H2I_C1_CLKID_SHIFT)
+			| (hal2->dac.voices << H2I_C1_DATAT_SHIFT));
+}
+
+static void hal2_setup_adc(hal2_card_t *hal2)
+{
+	unsigned int fifobeg, fifoend, highwater, sample_size;
+	hal2_pbus_t *pbus = &hal2->adc.pbus;
+
+	DEBUG("hal2_setup_adc\n");
+	
+	sample_size = 2 * hal2->adc.voices;
+
+	highwater = (sample_size * 2) >> 1;		/* halfwords */
+	fifobeg = (4 * 4) >> 3;				/* record is second */
+	fifoend = (4 * 4 + sample_size * 4) >> 3;	/* doublewords */
+	pbus->ctrl = HPC3_PDMACTRL_RT | HPC3_PDMACTRL_RCV | HPC3_PDMACTRL_LD | 
+		     (highwater << 8) | (fifobeg << 16) | (fifoend << 24);
+	pbus->pbus->pbdma_ctrl = HPC3_PDMACTRL_LD;
+	hal2_i_clearbit16(hal2, H2I_DMA_PORT_EN, H2I_DMA_PORT_EN_CODECR);
+	hal2_i_clearbit16(hal2, H2I_DMA_DRV, (1 << pbus->pbusnr));
+	/* Setup the HAL2 for record */
+	hal2_set_adc_rate(hal2);
+	/* We are using 2nd Bresenham clock generator for record */
+	hal2_i_write16(hal2, H2I_ADC_C1, (pbus->pbusnr << H2I_C1_DMA_SHIFT)
+			| (2 << H2I_C1_CLKID_SHIFT)
+			| (hal2->adc.voices << H2I_C1_DATAT_SHIFT));
+}
+
+static void hal2_start_dac(hal2_card_t *hal2)
+{
+	hal2_pbus_t *pbus = &hal2->dac.pbus;
+
+	DEBUG("hal2_start_dac\n");
+	
+	pbus->pbus->pbdma_dptr = PHYSADDR(hal2->dac.tail);
+	pbus->pbus->pbdma_ctrl = pbus->ctrl | HPC3_PDMACTRL_ACT;
+
+	/* set endianess */
+	if (hal2->dac.format & AFMT_S16_LE)
+		hal2_i_setbit16(hal2, H2I_DMA_END, H2I_DMA_END_CODECTX);
+	else
+		hal2_i_clearbit16(hal2, H2I_DMA_END, H2I_DMA_END_CODECTX);
+	/* set DMA bus */
+	hal2_i_setbit16(hal2, H2I_DMA_DRV, (1 << pbus->pbusnr));
+	/* enable DAC */
+	hal2_i_setbit16(hal2, H2I_DMA_PORT_EN, H2I_DMA_PORT_EN_CODECTX);
+}
+
+static void hal2_start_adc(hal2_card_t *hal2)
+{
+	hal2_pbus_t *pbus = &hal2->adc.pbus;
+
+	DEBUG("hal2_start_adc\n");
+	
+	pbus->pbus->pbdma_dptr = PHYSADDR(hal2->adc.head);
+	pbus->pbus->pbdma_ctrl = pbus->ctrl | HPC3_PDMACTRL_ACT;
+	
+	/* set endianess */
+	if (hal2->adc.format & AFMT_S16_LE)
+		hal2_i_setbit16(hal2, H2I_DMA_END, H2I_DMA_END_CODECR);
+	else
+		hal2_i_clearbit16(hal2, H2I_DMA_END, H2I_DMA_END_CODECR);
+	/* set DMA bus */
+	hal2_i_setbit16(hal2, H2I_DMA_DRV, (1 << pbus->pbusnr));
+	/* enable ADC */
+	hal2_i_setbit16(hal2, H2I_DMA_PORT_EN, H2I_DMA_PORT_EN_CODECR);
+}
+
+static inline void hal2_stop_dac(hal2_card_t *hal2)
+{
+	DEBUG("hal2_stop_dac\n");
+	
+	hal2->dac.pbus.pbus->pbdma_ctrl = HPC3_PDMACTRL_LD;
+	/* The HAL2 itself may remain enabled safely */
+}
+
+static inline void hal2_stop_adc(hal2_card_t *hal2)
+{
+	DEBUG("hal2_stop_adc\n");
+	
+	hal2->adc.pbus.pbus->pbdma_ctrl = HPC3_PDMACTRL_LD;
+}
+
+#define hal2_alloc_dac_dmabuf(hal2)	hal2_alloc_dmabuf(hal2, 1)
+#define hal2_alloc_adc_dmabuf(hal2)	hal2_alloc_dmabuf(hal2, 0)
+static int hal2_alloc_dmabuf(hal2_card_t *hal2, int is_dac)
+{
+	int buffers, cntinfo;
+	hal2_buf_t *buf, *prev;
+	hal2_codec_t *codec;
+
+	if (is_dac) {
+		codec = &hal2->dac;
+		buffers = obuffers;
+		cntinfo = HPCDMA_XIE | HPCDMA_EOX;
+	} else {
+		codec = &hal2->adc;
+		buffers = ibuffers;
+		cntinfo = HPCDMA_XIE | H2_BUFFER_SIZE;
+	}
+	
+	DEBUG("allocating %d DMA buffers.\n", buffers);
+	
+	buf = (hal2_buf_t*) get_zeroed_page(GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	codec->head = buf;
+	codec->tail = buf;
+	
+	while (--buffers) {
+		buf->info.desc.pbuf = PHYSADDR(&buf->data);
+		buf->info.desc.cntinfo = cntinfo;
+		buf->info.cnt = 0;
+		prev = buf;
+		buf = (hal2_buf_t*) get_zeroed_page(GFP_KERNEL);
+		if (!buf) {
+			printk("HAL2: Not enough memory for DMA buffer.\n");
+			buf = codec->head;
+			while (buf) {
+				prev = buf;
+				free_page((unsigned long) buf);
+				buf = prev->info.next;
+			}
+			return -ENOMEM;
+		}
+		prev->info.next = buf;
+		prev->info.desc.pnext = PHYSADDR(buf);
+		/* The PBUS can prolly not read this stuff when it's in
+		 * the cache so we have to flush it back to main memory
+		 */
+		dma_cache_wback_inv((unsigned long) prev, PAGE_SIZE);
+	}
+	buf->info.desc.pbuf = PHYSADDR(&buf->data);
+	buf->info.desc.cntinfo = cntinfo;
+	buf->info.cnt = 0;
+	buf->info.next = codec->head;
+	buf->info.desc.pnext = PHYSADDR(codec->head);
+	dma_cache_wback_inv((unsigned long) buf, PAGE_SIZE);
+	
+	return 0;
+}
+
+#define hal2_free_dac_dmabuf(hal2)	hal2_free_dmabuf(hal2, 1)
+#define hal2_free_adc_dmabuf(hal2)	hal2_free_dmabuf(hal2, 0)
+static void hal2_free_dmabuf(hal2_card_t *hal2, int is_dac)
+{
+	hal2_buf_t *buf, *next;
+	hal2_codec_t *codec = (is_dac) ? &hal2->dac : &hal2->adc;
+
+	if (!codec->head)
+		return;
+	
+	buf = codec->head->info.next;
+	codec->head->info.next = NULL;
+	while (buf) {
+		next = buf->info.next;
+		free_page((unsigned long) buf);
+		buf = next;
+	}
+	codec->head = codec->tail = NULL;
+}
+
+/* 
+ * Add 'count' bytes to 'buffer' from DMA ring buffers. Return number of
+ * bytes added or -EFAULT if copy_from_user failed.
+ */
+static int hal2_get_buffer(hal2_card_t *hal2, char *buffer, int count)
+{
+	unsigned long flags;
+	int size, ret = 0;
+	hal2_codec_t *adc = &hal2->adc;
+	
+	spin_lock_irqsave(&adc->lock, flags);
+	
+	DEBUG("getting %d bytes ", count);
+
+	/* enable DMA stream if there are no data */
+	if (!(adc->pbus.pbus->pbdma_ctrl & HPC3_PDMACTRL_ISACT) &&
+	    adc->tail->info.cnt == 0)
+		hal2_start_adc(hal2);
+
+	DEBUG("... ");
+
+	while (adc->tail->info.cnt > 0 && count > 0) {
+		size = min(adc->tail->info.cnt, count);
+		spin_unlock_irqrestore(&adc->lock, flags);
+
+		if (copy_to_user(buffer, &adc->tail->data[H2_BUFFER_SIZE-size],
+				 size)) {
+			ret = -EFAULT;
+			goto out;
+		}
+
+		spin_lock_irqsave(&adc->lock, flags);
+		
+		adc->tail->info.cnt -= size;
+		/* buffer is empty, update tail pointer */
+		if (adc->tail->info.cnt == 0) {
+			adc->tail->info.desc.cntinfo = HPCDMA_XIE |
+						       H2_BUFFER_SIZE;
+			dma_cache_wback_inv((unsigned long) adc->tail,
+					    sizeof(struct hpc_dma_desc));
+			adc->tail = adc->tail->info.next;
+			/* enable DMA stream again if needed */
+			if (!(adc->pbus.pbus->pbdma_ctrl & HPC3_PDMACTRL_ISACT))
+				hal2_start_adc(hal2);
+
+		}
+		buffer += size;
+		ret += size;
+		count -= size;
+
+		DEBUG("(%d) ", size);
+	}
+	spin_unlock_irqrestore(&adc->lock, flags);
+out:	
+	DEBUG("\n");
+	
+	return ret;
+} 
+
+/* 
+ * Add 'count' bytes from 'buffer' to DMA ring buffers. Return number of
+ * bytes added or -EFAULT if copy_from_user failed.
+ */
+static int hal2_add_buffer(hal2_card_t *hal2, char *buffer, int count)
+{
+	unsigned long flags;
+	int size, ret = 0;
+	hal2_codec_t *dac = &hal2->dac;
+	
+	spin_lock_irqsave(&dac->lock, flags);
+	
+	DEBUG("adding %d bytes ", count);
+
+	while (dac->head->info.cnt == 0 && count > 0) {
+		size = min((int)H2_BUFFER_SIZE, count);
+		spin_unlock_irqrestore(&dac->lock, flags);
+		
+		if (copy_from_user(dac->head->data, buffer, size)) {
+			ret = -EFAULT;
+			goto out;
+		}
+		spin_lock_irqsave(&dac->lock, flags);
+
+		dac->head->info.desc.cntinfo = size | HPCDMA_XIE;
+		dac->head->info.cnt = size;
+		dma_cache_wback_inv((unsigned long) dac->head, 
+				    size + PAGE_SIZE - H2_BUFFER_SIZE);
+		buffer += size;
+		ret += size;
+		count -= size;
+		dac->head = dac->head->info.next;
+
+		DEBUG("(%d) ", size);
+	}
+	if (!(dac->pbus.pbus->pbdma_ctrl & HPC3_PDMACTRL_ISACT) && ret > 0)
+		hal2_start_dac(hal2);
+	
+	spin_unlock_irqrestore(&dac->lock, flags);
+out:	
+	DEBUG("\n");
+	
+	return ret;
+}
+
+#define hal2_reset_dac_pointer(hal2)	hal2_reset_pointer(hal2, 1)
+#define hal2_reset_adc_pointer(hal2)	hal2_reset_pointer(hal2, 0)
+static void hal2_reset_pointer(hal2_card_t *hal2, int is_dac)
+{
+	hal2_codec_t *codec = (is_dac) ? &hal2->dac : &hal2->adc;
+	
+	DEBUG("hal2_reset_pointer\n");
+
+	codec->tail = codec->head;
+	do {
+		codec->tail->info.desc.cntinfo = HPCDMA_XIE | (is_dac) ? 
+						 HPCDMA_EOX : H2_BUFFER_SIZE;
+		codec->tail->info.cnt = 0;
+		dma_cache_wback_inv((unsigned long) codec->tail, 
+				    sizeof(struct hpc_dma_desc));
+		codec->tail = codec->tail->info.next;
+	} while (codec->tail != codec->head);
+}
+
+static int hal2_sync_dac(hal2_card_t *hal2)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	hal2_codec_t *dac = &hal2->dac;
+	int ret = 0;
+	signed long timeout = 1000 * H2_BUFFER_SIZE * 2 * dac->voices *
+			      HZ / dac->sample_rate / 900;
+
+	down(&dac->sem);
+	
+	while (dac->pbus.pbus->pbdma_ctrl & HPC3_PDMACTRL_ISACT) {
+		add_wait_queue(&dac->dma_wait, &wait);
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (!schedule_timeout(timeout))
+			/* We may get bogus timeout when system is 
+			 * heavily loaded */
+			if (dac->tail->info.cnt) {
+				printk("HAL2: timeout...\n");
+				ret = -ETIME;
+			}
+		if (signal_pending(current))
+			ret = -ERESTARTSYS;
+		if (ret) {
+			hal2_stop_dac(hal2);
+			hal2_reset_dac_pointer(hal2);
+		}
+		remove_wait_queue(&dac->dma_wait, &wait);
+	}
+
+	up(&dac->sem);
+	
+	return ret;
+}
+
+static int hal2_write_mixer(hal2_card_t *hal2, int index, int vol)
+{
+	unsigned int l, r;
+
+	DEBUG_MIX("mixer %d write\n", index);
+	
+	if (index >= SOUND_MIXER_NRDEVICES || !mixtable[index].avail)
+		return -EINVAL;
+
+	r = (vol >> 8) & 0xff;
+	if (r > 100)
+		r = 100;
+	l = vol & 0xff;
+	if (l > 100)
+		l = 100;
+	
+	hal2->mixer.volume[mixtable[index].idx] = l | (r << 8);
+
+	switch (mixtable[index].idx) {
+	case H2_MIX_OUTPUT_ATT: {
+
+		DEBUG_MIX("output attenuator %d,%d\n", l, r);
+
+		if (r | l) {
+			unsigned int tmp = hal2_i_look32(hal2, H2I_DAC_C2); 
+		
+			tmp &= ~(H2I_C2_L_ATT_M | H2I_C2_R_ATT_M | H2I_C2_MUTE);
+
+			/* Attenuator has five bits */
+			l = (31 * (100 - l) / 99);
+			r = (31 * (100 - r) / 99);
+			
+			DEBUG_MIX("left: %d, right %d\n", l, r);
+
+			tmp |= (l << H2I_C2_L_ATT_SHIFT) & H2I_C2_L_ATT_M;
+			tmp |= (r << H2I_C2_R_ATT_SHIFT) & H2I_C2_R_ATT_M;
+			hal2_i_write32(hal2, H2I_DAC_C2, tmp);
+		} else 
+			hal2_i_setbit32(hal2, H2I_DAC_C2, H2I_C2_MUTE);
+	}
+	case H2_MIX_INPUT_GAIN: {
+		/* TODO */
+	}
+	}
+	return 0;
+}
+
+static void hal2_init_mixer(hal2_card_t *hal2)
+{
+	int i;
+
+	for (i = 0; i < SOUND_MIXER_NRDEVICES; i++)
+		hal2_write_mixer(hal2, i, 100 | (100 << 8));
+		
+}
+
+static int hal2_mixer_ioctl(hal2_card_t *hal2, unsigned int cmd, 
+			    unsigned long arg)
+{
+	int val;
+
+        if (cmd == SOUND_MIXER_INFO) {
+		mixer_info info;
+		
+		strncpy(info.id, hal2str, sizeof(info.id));
+		strncpy(info.name, hal2str, sizeof(info.name));
+		info.modify_counter = hal2->mixer.modcnt;
+		if (copy_to_user((void *)arg, &info, sizeof(info)))
+			return -EFAULT;
+		return 0;
+	}
+	if (cmd == SOUND_OLD_MIXER_INFO) {
+		_old_mixer_info info;
+		
+		strncpy(info.id, hal2str, sizeof(info.id));
+		strncpy(info.name, hal2str, sizeof(info.name));
+		if (copy_to_user((void *)arg, &info, sizeof(info)))
+			return -EFAULT;
+		return 0;
+	}
+	if (cmd == OSS_GETVERSION)
+		return put_user(SOUND_VERSION, (int *)arg);
+
+	if (_IOC_TYPE(cmd) != 'M' || _IOC_SIZE(cmd) != sizeof(int))
+                return -EINVAL;
+
+        if (_IOC_DIR(cmd) == _IOC_READ) {
+                switch (_IOC_NR(cmd)) {
+		/* Give the current record source */
+		case SOUND_MIXER_RECSRC:
+			val = 0;	/* FIXME */
+			break;
+		/* Give the supported mixers, all of them support stereo */
+                case SOUND_MIXER_DEVMASK:
+                case SOUND_MIXER_STEREODEVS: {
+			int i;
+			
+			for (val = i = 0; i < SOUND_MIXER_NRDEVICES; i++)
+				if (mixtable[i].avail)
+					val |= 1 << i;
+			break;
+			}
+		/* Arg contains a bit for each supported recording source */
+                case SOUND_MIXER_RECMASK:
+			val = 0;
+			break;
+                case SOUND_MIXER_CAPS:
+			val = 0;
+			break;
+		/* Read a specific mixer */
+		default: {
+			int i = _IOC_NR(cmd);
+			
+			if (i >= SOUND_MIXER_NRDEVICES || !mixtable[i].avail)
+				return -EINVAL;
+			val = hal2->mixer.volume[mixtable[i].idx];
+			break;
+			}
+		}
+		return put_user(val, (int *)arg);
+	}
+	
+        if (_IOC_DIR(cmd) != (_IOC_WRITE|_IOC_READ))
+		return -EINVAL;
+	
+	hal2->mixer.modcnt++;
+
+	if (get_user(val, (int *)arg))
+		return -EFAULT;
+
+	switch (_IOC_NR(cmd)) {
+	/* Arg contains a bit for each recording source */
+	case SOUND_MIXER_RECSRC:
+		return 0;	/* FIXME */
+	default:
+		return hal2_write_mixer(hal2, _IOC_NR(cmd), val);
+	}
+
+	return 0;
+}
+
+static int hal2_open_mixdev(struct inode *inode, struct file *file)
+{
+	hal2_card_t *hal2 = hal2_mixer_find_card(MINOR(inode->i_rdev));
+
+	if (hal2) {
+		file->private_data = hal2;
+		return 0;
+	}
+	return -ENODEV;
+}
+
+static int hal2_release_mixdev(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static int hal2_ioctl_mixdev(struct inode *inode, struct file *file,
+			     unsigned int cmd, unsigned long arg)
+{
+	return hal2_mixer_ioctl((hal2_card_t *)file->private_data, cmd, arg);
+}
+
+
+static int hal2_ioctl(struct inode *inode, struct file *file, 
+		      unsigned int cmd, unsigned long arg)
+{
+	int val;
+	hal2_card_t *hal2 = (hal2_card_t *) file->private_data;
+
+	switch (cmd) {
+	case OSS_GETVERSION:
+		return put_user(SOUND_VERSION, (int *)arg);
+		
+	case SNDCTL_DSP_SYNC:
+		if (file->f_mode & FMODE_WRITE)
+			return hal2_sync_dac(hal2);
+		return 0;
+		
+	case SNDCTL_DSP_SETDUPLEX:
+		return 0;
+
+	case SNDCTL_DSP_GETCAPS:
+		return put_user(DSP_CAP_DUPLEX | DSP_CAP_MULTI, (int *)arg);
+		
+	case SNDCTL_DSP_RESET:
+		if (file->f_mode & FMODE_READ) {
+			hal2_stop_adc(hal2);
+			hal2_reset_adc_pointer(hal2);
+		}
+		if (file->f_mode & FMODE_WRITE) {
+			hal2_stop_dac(hal2);
+			hal2_reset_dac_pointer(hal2);
+		}
+		return 0;
+
+ 	case SNDCTL_DSP_SPEED:
+		if (get_user(val, (int *)arg))
+			return -EFAULT;
+		if (file->f_mode & FMODE_READ) {
+			hal2_stop_adc(hal2);
+			val = hal2_compute_rate(&hal2->adc, val);
+			hal2->adc.sample_rate = val;
+			hal2_set_adc_rate(hal2);
+		}
+		if (file->f_mode & FMODE_WRITE) {
+			hal2_stop_dac(hal2);
+			val = hal2_compute_rate(&hal2->dac, val);
+			hal2->dac.sample_rate = val;
+			hal2_set_dac_rate(hal2);
+		}
+		return put_user(val, (int *)arg);
+		
+	case SNDCTL_DSP_STEREO:
+		if (get_user(val, (int *)arg))
+			return -EFAULT;
+		if (file->f_mode & FMODE_READ) {
+			hal2_stop_adc(hal2);
+			hal2->adc.voices = (val) ? 2 : 1;
+			hal2_setup_adc(hal2);
+		}
+		if (file->f_mode & FMODE_WRITE) {
+			hal2_stop_dac(hal2);
+			hal2->dac.voices = (val) ? 2 : 1;
+			hal2_setup_dac(hal2);
+                }
+		return 0;
+
+	case SNDCTL_DSP_CHANNELS:
+		if (get_user(val, (int *)arg))
+			return -EFAULT;
+		if (val != 0) {
+			if (file->f_mode & FMODE_READ) {
+				hal2_stop_adc(hal2);
+				hal2->adc.voices = (val == 1) ? 1 : 2;
+				hal2_setup_adc(hal2);
+			}
+			if (file->f_mode & FMODE_WRITE) {
+				hal2_stop_dac(hal2);
+				hal2->dac.voices = (val == 1) ? 1 : 2;
+				hal2_setup_dac(hal2);
+			}
+		}
+		val = -EINVAL;
+		if (file->f_mode & FMODE_READ)
+			val = hal2->adc.voices;
+		if (file->f_mode & FMODE_WRITE)
+			val = hal2->dac.voices;
+		return put_user(val, (int *)arg);
+		
+	case SNDCTL_DSP_GETFMTS: /* Returns a mask */
+                return put_user(H2_SUPPORTED_FORMATS, (int *)arg);
+		
+	case SNDCTL_DSP_SETFMT: /* Selects ONE fmt*/
+		if (get_user(val, (int *)arg))
+			return -EFAULT;
+		if (val != AFMT_QUERY) {
+			if (!(val & H2_SUPPORTED_FORMATS))
+				return -EINVAL;
+			if (file->f_mode & FMODE_READ) {
+				hal2_stop_adc(hal2);
+				hal2->adc.format = val;
+				hal2_setup_adc(hal2);
+			}
+			if (file->f_mode & FMODE_WRITE) {
+				hal2_stop_dac(hal2);
+				hal2->dac.format = val;
+				hal2_setup_dac(hal2);
+			}
+		} else {
+			val = -EINVAL;
+			if (file->f_mode & FMODE_READ)
+				val = hal2->adc.format;
+			if (file->f_mode & FMODE_WRITE)
+				val = hal2->dac.format;
+		}
+		return put_user(val, (int *)arg);
+		
+	case SNDCTL_DSP_POST:
+		return 0;
+
+	case SNDCTL_DSP_GETOSPACE: {
+		unsigned long flags;
+		audio_buf_info info;
+		hal2_buf_t *buf;
+		hal2_codec_t *dac = &hal2->dac;
+		
+		if (!(file->f_mode & FMODE_WRITE))
+			return -EINVAL;
+		
+		spin_lock_irqsave(&dac->lock, flags);
+		info.fragments = 0;
+		buf = dac->head;
+		while (buf->info.cnt == 0 && buf != dac->tail) {
+			info.fragments++;
+			buf = buf->info.next;
+		}
+		spin_unlock_irqrestore(&dac->lock, flags);
+		
+		info.fragstotal = obuffers;
+		info.fragsize = H2_BUFFER_SIZE;
+                info.bytes = info.fragsize * info.fragments;
+
+		return copy_to_user((void *)arg, &info, sizeof(info)) ? -EFAULT : 0;
+	}
+			   
+	case SNDCTL_DSP_GETISPACE: {
+		unsigned long flags;
+		audio_buf_info info;
+		hal2_buf_t *buf;
+		hal2_codec_t *adc = &hal2->adc;
+			
+		if (!(file->f_mode & FMODE_READ))
+			return -EINVAL;
+		
+		spin_lock_irqsave(&adc->lock, flags);
+		info.fragments = 0;
+		info.bytes = 0;
+		buf = adc->tail;
+		while (buf->info.cnt > 0 && buf != adc->head) {
+			info.fragments++;
+			info.bytes += buf->info.cnt;
+			buf = buf->info.next;
+		}
+		spin_unlock_irqrestore(&adc->lock, flags);
+
+		info.fragstotal = ibuffers;
+		info.fragsize = H2_BUFFER_SIZE;
+		
+		return copy_to_user((void *)arg, &info, sizeof(info)) ? -EFAULT : 0;
+	}
+
+	case SNDCTL_DSP_NONBLOCK:
+		file->f_flags |= O_NONBLOCK;
+		return 0;
+		
+	case SNDCTL_DSP_GETBLKSIZE:
+		return put_user(H2_BUFFER_SIZE, (int *)arg);
+	
+	case SNDCTL_DSP_SETFRAGMENT:
+		return 0;
+
+	case SOUND_PCM_READ_RATE:
+		val = -EINVAL;
+		if (file->f_mode & FMODE_READ)
+			val = hal2->adc.sample_rate;
+		if (file->f_mode & FMODE_WRITE)
+			val = hal2->dac.sample_rate;
+		return put_user(val, (int *)arg);
+
+	case SOUND_PCM_READ_CHANNELS:
+		val = -EINVAL;
+		if (file->f_mode & FMODE_READ)
+			val = hal2->adc.voices;
+		if (file->f_mode & FMODE_WRITE)
+			val = hal2->dac.voices;
+		return put_user(val, (int *)arg);
+
+	case SOUND_PCM_READ_BITS:
+		val = 16;
+		return put_user(val, (int *)arg);
+	}
+	
+	return hal2_mixer_ioctl(hal2, cmd, arg);
+}
+
+static ssize_t hal2_read(struct file *file, char *buffer,
+			 size_t count, loff_t *ppos)
+{
+	ssize_t err;
+	hal2_card_t *hal2 = (hal2_card_t *) file->private_data;
+	hal2_codec_t *adc = &hal2->adc;
+
+	if (count == 0)
+		return 0;
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+	
+	down(&adc->sem);
+	
+	if (file->f_flags & O_NONBLOCK) {
+		err = hal2_get_buffer(hal2, buffer, count);
+		err = err == 0 ? -EAGAIN : err;
+	} else {
+		do {
+			/* ~10% longer */
+			signed long timeout = 1000 * H2_BUFFER_SIZE *
+				2 * adc->voices * HZ / adc->sample_rate / 900;
+			DECLARE_WAITQUEUE(wait, current);
+			ssize_t cnt = 0;
+			
+			err = hal2_get_buffer(hal2, buffer, count);
+			if (err > 0) {
+				count -= err;
+				cnt += err;
+				buffer += err;
+				err = cnt;
+			}
+			if (count > 0 && err >= 0) {
+				add_wait_queue(&adc->dma_wait, &wait);
+				set_current_state(TASK_INTERRUPTIBLE);
+				/* Well, it is possible, that interrupt already
+				 * arrived. Hmm, shit happens, we have one more
+				 * buffer filled ;) */
+				if (!schedule_timeout(timeout))
+					/* We may get bogus timeout when system
+					 * is heavily loaded */
+					if (!adc->tail->info.cnt) {
+						printk("HAL2: timeout...\n");
+						hal2_stop_adc(hal2);
+						hal2_reset_adc_pointer(hal2);
+						err = -EAGAIN;
+					}
+				if (signal_pending(current))
+					err = -ERESTARTSYS;
+				remove_wait_queue(&adc->dma_wait, &wait);
+			}
+		} while (count > 0 && err >= 0);
+	
+	}
+	
+	up(&adc->sem);
+	
+	return err;
+}
+
+static ssize_t hal2_write(struct file *file, const char *buffer,
+			  size_t count, loff_t *ppos)
+{
+	ssize_t err;
+	char *buf = (char*) buffer;
+	hal2_card_t *hal2 = (hal2_card_t *) file->private_data;
+	hal2_codec_t *dac = &hal2->dac;
+
+	if (count == 0)
+		return 0;
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	down(&dac->sem);
+
+	if (file->f_flags & O_NONBLOCK) {
+		err = hal2_add_buffer(hal2, buf, count);
+		err = err == 0 ? -EAGAIN : err;
+	} else {
+		do {
+			/* ~10% longer */
+			signed long timeout = 1000 * H2_BUFFER_SIZE *
+				2 * dac->voices * HZ / dac->sample_rate / 900;
+			DECLARE_WAITQUEUE(wait, current);
+			ssize_t cnt = 0;
+			
+			err = hal2_add_buffer(hal2, buf, count);
+			if (err > 0) {
+				count -= err;
+				cnt += err;
+				buf += err;
+				err = cnt;
+			}
+			if (count > 0 && err >= 0) {
+				add_wait_queue(&dac->dma_wait, &wait);
+				set_current_state(TASK_INTERRUPTIBLE);
+				/* Well, it is possible, that interrupt already
+				 * arrived. Hmm, shit happens, we have one more
+				 * buffer free ;) */
+				if (!schedule_timeout(timeout))
+					/* We may get bogus timeout when system
+					 * is heavily loaded */
+					if (dac->head->info.cnt) {
+						printk("HAL2: timeout...\n");
+						hal2_stop_dac(hal2);
+						hal2_reset_dac_pointer(hal2);
+						err = -EAGAIN;
+					}
+				if (signal_pending(current))
+					err = -ERESTARTSYS;
+				remove_wait_queue(&dac->dma_wait, &wait);
+			}
+		} while (count > 0 && err >= 0);
+	}
+	
+	up(&dac->sem);
+
+	return err;
+}
+
+static unsigned int hal2_poll(struct file *file, struct poll_table_struct *wait)
+{
+	unsigned long flags;
+	unsigned int mask = 0;
+	hal2_card_t *hal2 = (hal2_card_t *) file->private_data;
+
+	if (file->f_mode & FMODE_READ) {
+		hal2_codec_t *adc = &hal2->adc;
+		
+		poll_wait(file, &hal2->adc.dma_wait, wait);
+		spin_lock_irqsave(&adc->lock, flags);
+		if (adc->tail->info.cnt > 0)
+			mask |= POLLIN;
+		spin_unlock_irqrestore(&adc->lock, flags);
+	}
+	
+	if (file->f_mode & FMODE_WRITE) {
+		hal2_codec_t *dac = &hal2->dac;
+		
+		poll_wait(file, &dac->dma_wait, wait);
+		spin_lock_irqsave(&dac->lock, flags);
+		if (dac->head->info.cnt == 0)
+			mask |= POLLOUT;
+		spin_unlock_irqrestore(&dac->lock, flags);
+	}
+	
+	return mask;
+}
+
+static int hal2_open(struct inode *inode, struct file *file)
+{
+	int err;
+	hal2_card_t *hal2 = hal2_dsp_find_card(MINOR(inode->i_rdev));
+
+	DEBUG("opening audio device.\n");
+
+	if (!hal2) {
+		printk("HAL2: Whee?! Open door and go away!\n");
+		return -ENODEV;
+	}
+	file->private_data = hal2;
+
+	if (file->f_mode & FMODE_READ) {
+		if (hal2->adc.usecount)
+			return -EBUSY;
+		
+		/* OSS spec wanted us to use 8 bit, 8 kHz mono by default,
+		 * but HAL2 can't do 8bit audio */
+		hal2->adc.format = AFMT_S16_BE;
+		hal2->adc.voices = 1;
+		hal2->adc.sample_rate = hal2_compute_rate(&hal2->adc, 8000);
+		hal2_set_adc_rate(hal2);
+
+		/* alloc DMA buffers */
+		err = hal2_alloc_adc_dmabuf(hal2);
+		if (err)
+			return err;
+		hal2_setup_adc(hal2);
+
+		hal2->adc.usecount++;
+	}
+
+	if (file->f_mode & FMODE_WRITE) {
+		if (hal2->dac.usecount)
+			return -EBUSY;
+
+		hal2->dac.format = AFMT_S16_BE;
+		hal2->dac.voices = 1;
+		hal2->dac.sample_rate = hal2_compute_rate(&hal2->dac, 8000);
+		hal2_set_dac_rate(hal2);
+
+		/* alloc DMA buffers */
+		err = hal2_alloc_dac_dmabuf(hal2);
+		if (err)
+			return err;
+		hal2_setup_dac(hal2);
+		
+		hal2->dac.usecount++;
+	}
+	
+	return 0;
+}
+
+static int hal2_release(struct inode *inode, struct file *file)
+{
+	hal2_card_t *hal2 = (hal2_card_t *) file->private_data;
+
+	if (file->f_mode & FMODE_READ) {
+		hal2_stop_adc(hal2);
+		hal2_free_adc_dmabuf(hal2);
+		hal2->adc.usecount--;
+	}
+
+	if (file->f_mode & FMODE_WRITE) {
+		hal2_sync_dac(hal2);
+		hal2_free_dac_dmabuf(hal2);
+		hal2->dac.usecount--;
+	}
+
+	return 0;
+}
+
+static struct file_operations hal2_audio_fops = {
+	owner:		THIS_MODULE,
+	llseek:		no_llseek,
+	read:		hal2_read,
+	write:		hal2_write,
+	poll:		hal2_poll,
+	ioctl:		hal2_ioctl,
+	open:		hal2_open,
+	release:	hal2_release,
+};
+
+static struct file_operations hal2_mixer_fops = {
+	owner:		THIS_MODULE,
+	llseek:		no_llseek,
+	ioctl:		hal2_ioctl_mixdev,
+	open:		hal2_open_mixdev,
+	release:	hal2_release_mixdev,
+};
+
+static int hal2_request_irq(hal2_card_t *hal2, int irq)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	save_and_cli(flags);
+	if (request_irq(irq, hal2_interrupt, SA_SHIRQ, hal2str, hal2)) {
+		printk(KERN_ERR "HAL2: Can't get irq %d\n", irq);
+		ret = -EAGAIN;
+	}
+	restore_flags(flags);
+	return ret;
+}
+
+static int hal2_alloc_resources(hal2_card_t *hal2, struct hpc3_regs *hpc3)
+{
+	hal2_pbus_t *pbus;
+
+	pbus = &hal2->dac.pbus;
+	pbus->pbusnr = 0;
+	pbus->pbus = &hpc3->pbdma[pbus->pbusnr];
+	/* The spec says that we should write 0x08248844 but that's WRONG. HAL2
+	 * does 8 bit DMA, not 16 bit even if it generates 16 bit audio. */
+	hpc3->pbus_dmacfgs[pbus->pbusnr][0] = 0x08208844;	/* Magic :-) */
+
+	pbus = &hal2->adc.pbus;
+	pbus->pbusnr = 1;
+	pbus->pbus = &hpc3->pbdma[pbus->pbusnr];
+	hpc3->pbus_dmacfgs[pbus->pbusnr][0] = 0x08208844;	/* Magic :-) */
+
+	return hal2_request_irq(hal2, SGI_HPCDMA_IRQ);
+}
+
+static void hal2_init_codec(hal2_codec_t *codec)
+{
+	init_waitqueue_head(&codec->dma_wait);
+	init_MUTEX(&codec->sem);
+	spin_lock_init(&codec->lock);
+}
+
+static void hal2_free_resources(hal2_card_t *hal2)
+{
+	free_irq(SGI_HPCDMA_IRQ, hal2);
+}
+
+static int hal2_detect(hal2_card_t *hal2)
+{
+	unsigned short board, major, minor;
+	unsigned short rev;
+
+	/* reset HAL2 */
+	hal2_isr_write(hal2, 0);
+
+	/* release reset */
+	hal2_isr_write(hal2, H2_ISR_GLOBAL_RESET_N | H2_ISR_CODEC_RESET_N);
+
+	hal2_i_write16(hal2, H2I_RELAY_C, H2I_RELAY_C_STATE); 
+
+	if ((rev = hal2_rev_look(hal2)) & H2_REV_AUDIO_PRESENT) {
+		DEBUG("HAL2: no device detected, rev: 0x%04hx\n", rev);
+		return -ENODEV;
+	}
+
+	board = (rev & H2_REV_BOARD_M) >> 12;
+	major = (rev & H2_REV_MAJOR_CHIP_M) >> 4;
+	minor = (rev & H2_REV_MINOR_CHIP_M);
+
+	printk("SGI HAL2 Processor revision %i.%i.%i detected\n",
+	       board, major, minor);
+
+	if (board != 4 || major != 1 || minor != 0) 
+		printk( "Other revision than 4.1.0 detected. "
+			"Your card is probably unsupported\n");
+
+	return 0;
+}
+
+static int hal2_init_card(hal2_card_t **phal2, struct hpc3_regs *hpc3,
+			  unsigned long hpc3_base)
+{
+	int ret = 0;
+	hal2_card_t *hal2;
+	
+	hal2 = (hal2_card_t *) kmalloc(sizeof(hal2_card_t), GFP_KERNEL);
+	if (!hal2)
+		return -ENOMEM;
+	memset(hal2, 0, sizeof(hal2_card_t));
+
+	hal2->ctl_regs = (hal2_ctl_regs_t *) KSEG1ADDR(hpc3_base + H2_CTL_PIO);
+	hal2->aes_regs = (hal2_aes_regs_t *) KSEG1ADDR(hpc3_base + H2_AES_PIO);
+	hal2->vol_regs = (hal2_vol_regs_t *) KSEG1ADDR(hpc3_base + H2_VOL_PIO);
+	hal2->syn_regs = (hal2_syn_regs_t *) KSEG1ADDR(hpc3_base + H2_SYN_PIO);
+
+	if (hal2_detect(hal2) < 0) {
+		printk("HAL2 audio processor not found\n");
+		ret = -ENODEV;
+		goto fail1;
+	}
+
+	hal2_init_codec(&hal2->dac);
+	hal2_init_codec(&hal2->adc);
+
+	ret = hal2_alloc_resources(hal2, hpc3);
+	if (ret)
+		goto fail1;
+	
+	hal2_init_mixer(hal2);
+
+	hal2->dev_dsp = register_sound_dsp(&hal2_audio_fops, -1);
+	if (hal2->dev_dsp < 0) {
+		ret = hal2->dev_dsp;
+		goto fail2;
+	}
+
+	hal2->dev_mixer = register_sound_mixer(&hal2_mixer_fops, -1);
+	if (hal2->dev_mixer < 0) {
+		ret = hal2->dev_mixer;
+		goto fail3;
+	}
+	
+	*phal2 = hal2;
+	return 0;
+fail3:
+	unregister_sound_dsp(hal2->dev_dsp);
+fail2:
+	hal2_free_resources(hal2);
+fail1:
+	kfree(hal2);
+	
+	return ret;
+}
+
+/* 
+ * We are assuming only one HAL2 card. If you ever meet machine with more than
+ * one, tell immediately about it to someone. Preferably to me. --ladis
+ */
+static int __init init_hal2(void)
+{
+	int i;
+
+	for (i = 0; i < MAXCARDS; i++)
+		hal2_card[i] = NULL;
+
+	return hal2_init_card(&hal2_card[0], hpc3c0, HPC3_CHIP0_PBASE);
+}
+
+static void __exit exit_hal2(void)
+{
+	int i;
+	
+	for (i = 0; i < MAXCARDS; i++)
+		if (hal2_card[i]) {
+			hal2_free_resources(hal2_card[i]);
+			unregister_sound_dsp(hal2_card[i]->dev_dsp);
+			unregister_sound_mixer(hal2_card[i]->dev_mixer);
+			kfree(hal2_card[i]);
+	}
+}
+
+module_init(init_hal2);
+module_exit(exit_hal2);
+
+MODULE_DESCRIPTION("OSS compatible driver for SGI HAL2 audio");
+MODULE_AUTHOR("Ladislav Michl");
+MODULE_LICENSE("GPL");
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/sound/oss/hal2.h linux-2.6.0-test1-ac2/sound/oss/hal2.h
--- linux-2.6.0-test1/sound/oss/hal2.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test1-ac2/sound/oss/hal2.h	2003-07-11 16:39:51.000000000 +0100
@@ -0,0 +1,328 @@
+#ifndef __HAL2_H
+#define __HAL2_H
+
+/*
+ *  Driver for HAL2 sound processors
+ *  Copyright (c) 1999 Ulf Carlsson <ulfc@bun.falkenberg.se>
+ *  Copyright (c) 2001 Ladislav Michl <ladis@psi.cz>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as 
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <asm/addrspace.h>
+#include <asm/sgi/sgihpc.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#define H2_HAL2_BASE		0x58000
+#define H2_CTL_PIO		(H2_HAL2_BASE + 0 * 0x400)
+#define H2_AES_PIO		(H2_HAL2_BASE + 1 * 0x400)
+#define H2_VOL_PIO		(H2_HAL2_BASE + 2 * 0x400)
+#define H2_SYN_PIO		(H2_HAL2_BASE + 3 * 0x400)
+
+/* Indirect status register */
+
+#define H2_ISR_TSTATUS		0x01	/* RO: transaction status 1=busy */
+#define H2_ISR_USTATUS		0x02	/* RO: utime status bit 1=armed */
+#define H2_ISR_QUAD_MODE	0x04	/* codec mode 0=indigo 1=quad */
+#define H2_ISR_GLOBAL_RESET_N	0x08	/* chip global reset 0=reset */
+#define H2_ISR_CODEC_RESET_N	0x10	/* codec/synth reset 0=reset  */
+
+/* Revision register */
+
+#define H2_REV_AUDIO_PRESENT	0x8000	/* RO: audio present 0=present */
+#define H2_REV_BOARD_M		0x7000	/* RO: bits 14:12, board revision */
+#define H2_REV_MAJOR_CHIP_M	0x00F0	/* RO: bits 7:4, major chip revision */
+#define H2_REV_MINOR_CHIP_M	0x000F	/* RO: bits 3:0, minor chip revision */
+
+/* Indirect address register */
+
+/*
+ * Address of indirect internal register to be accessed. A write to this
+ * register initiates read or write access to the indirect registers in the
+ * HAL2. Note that there af four indirect data registers for write access to
+ * registers larger than 16 byte.
+ */
+
+#define H2_IAR_TYPE_M		0xF000	/* bits 15:12, type of functional */
+					/* block the register resides in */
+					/* 1=DMA Port */
+					/* 9=Global DMA Control */
+					/* 2=Bresenham */
+					/* 3=Unix Timer */
+#define H2_IAR_NUM_M		0x0F00	/* bits 11:8 instance of the */
+					/* blockin which the indirect */
+					/* register resides */
+					/* If IAR_TYPE_M=DMA Port: */
+					/* 1=Synth In */
+					/* 2=AES In */
+					/* 3=AES Out */
+					/* 4=DAC Out */
+					/* 5=ADC Out */
+					/* 6=Synth Control */
+					/* If IAR_TYPE_M=Global DMA Control: */
+					/* 1=Control */
+					/* If IAR_TYPE_M=Bresenham: */
+					/* 1=Bresenham Clock Gen 1 */
+					/* 2=Bresenham Clock Gen 2 */
+					/* 3=Bresenham Clock Gen 3 */
+					/* If IAR_TYPE_M=Unix Timer: */
+					/* 1=Unix Timer */
+#define H2_IAR_ACCESS_SELECT	0x0080	/* 1=read 0=write */
+#define H2_IAR_PARAM		0x000C	/* Parameter Select */
+#define H2_IAR_RB_INDEX_M	0x0003	/* Read Back Index */
+					/* 00:word0 */
+					/* 01:word1 */
+					/* 10:word2 */
+					/* 11:word3 */
+/*
+ * HAL2 internal addressing
+ *
+ * The HAL2 has "indirect registers" (idr) which are accessed by writing to the
+ * Indirect Data registers. Write the address to the Indirect Address register
+ * to transfer the data.
+ *
+ * We define the H2IR_* to the read address and H2IW_* to the write address and
+ * H2I_* to be fields in whatever register is referred to.
+ *
+ * When we write to indirect registers which are larger than one word (16 bit)
+ * we have to fill more than one indirect register before writing. When we read
+ * back however we have to read several times, each time with different Read
+ * Back Indexes (there are defs for doing this easily).
+ */
+
+/*
+ * Relay Control
+ */
+#define H2I_RELAY_C		0x9100
+#define H2I_RELAY_C_STATE	0x01		/* state of RELAY pin signal */
+
+/* DMA port enable */
+
+#define H2I_DMA_PORT_EN		0x9104
+#define H2I_DMA_PORT_EN_SY_IN	0x01		/* Synth_in DMA port */
+#define H2I_DMA_PORT_EN_AESRX	0x02		/* AES receiver DMA port */
+#define H2I_DMA_PORT_EN_AESTX	0x04		/* AES transmitter DMA port */
+#define H2I_DMA_PORT_EN_CODECTX	0x08		/* CODEC transmit DMA port */
+#define H2I_DMA_PORT_EN_CODECR	0x10		/* CODEC receive DMA port */
+
+#define H2I_DMA_END		0x9108 		/* global dma endian select */
+#define H2I_DMA_END_SY_IN	0x01		/* Synth_in DMA port */
+#define H2I_DMA_END_AESRX	0x02		/* AES receiver DMA port */
+#define H2I_DMA_END_AESTX	0x04		/* AES transmitter DMA port */
+#define H2I_DMA_END_CODECTX	0x08		/* CODEC transmit DMA port */
+#define H2I_DMA_END_CODECR	0x10		/* CODEC receive DMA port */
+						/* 0=b_end 1=l_end */
+
+#define H2I_DMA_DRV		0x910C  	/* global PBUS DMA enable */
+
+#define H2I_SYNTH_C		0x1104		/* Synth DMA control */
+
+#define H2I_AESRX_C		0x1204	 	/* AES RX dma control */
+
+#define H2I_C_TS_EN		0x20		/* Timestamp enable */
+#define H2I_C_TS_FRMT		0x40		/* Timestamp format */
+#define H2I_C_NAUDIO		0x80		/* Sign extend */
+
+/* AESRX CTL, 16 bit */
+
+#define H2I_AESTX_C		0x1304		/* AES TX DMA control */
+#define H2I_AESTX_C_CLKID_SHIFT	3		/* Bresenham Clock Gen 1-3 */
+#define H2I_AESTX_C_CLKID_M	0x18
+#define H2I_AESTX_C_DATAT_SHIFT	8		/* 1=mono 2=stereo (3=quad) */
+#define H2I_AESTX_C_DATAT_M	0x300
+
+/* CODEC registers */
+
+#define H2I_DAC_C1		0x1404 		/* DAC DMA control, 16 bit */
+#define H2I_DAC_C2		0x1408		/* DAC DMA control, 32 bit */
+#define H2I_ADC_C1		0x1504 		/* ADC DMA control, 16 bit */
+#define H2I_ADC_C2		0x1508		/* ADC DMA control, 32 bit */
+
+/* Bits in CTL1 register */
+
+#define H2I_C1_DMA_SHIFT	0		/* DMA channel */
+#define H2I_C1_DMA_M		0x7
+#define H2I_C1_CLKID_SHIFT	3		/* Bresenham Clock Gen 1-3 */
+#define H2I_C1_CLKID_M		0x18
+#define H2I_C1_DATAT_SHIFT	8		/* 1=mono 2=stereo (3=quad) */
+#define H2I_C1_DATAT_M		0x300
+
+/* Bits in CTL2 register */
+
+#define H2I_C2_R_GAIN_SHIFT	0		/* right a/d input gain */	
+#define H2I_C2_R_GAIN_M		0xf	
+#define H2I_C2_L_GAIN_SHIFT	4		/* left a/d input gain */
+#define H2I_C2_L_GAIN_M		0xf0
+#define H2I_C2_R_SEL		0x100		/* right input select */
+#define H2I_C2_L_SEL		0x200		/* left input select */
+#define H2I_C2_MUTE		0x400		/* mute */
+#define H2I_C2_DO1		0x00010000	/* digital output port bit 0 */
+#define H2I_C2_DO2		0x00020000	/* digital output port bit 1 */
+#define H2I_C2_R_ATT_SHIFT	18		/* right d/a output - */
+#define H2I_C2_R_ATT_M		0x007c0000	/* attenuation */
+#define H2I_C2_L_ATT_SHIFT	23		/* left d/a output - */
+#define H2I_C2_L_ATT_M		0x0f800000	/* attenuation */
+
+#define H2I_SYNTH_MAP_C		0x1104		/* synth dma handshake ctrl */
+
+/* Clock generator CTL 1, 16 bit */
+
+#define H2I_BRES1_C1		0x2104
+#define H2I_BRES2_C1		0x2204
+#define H2I_BRES3_C1		0x2304
+
+#define H2I_BRES_C1_SHIFT	0		/* 0=48.0 1=44.1 2=aes_rx */
+#define H2I_BRES_C1_M		0x03
+				
+/* Clock generator CTL 2, 32 bit */
+
+#define H2I_BRES1_C2		0x2108
+#define H2I_BRES2_C2		0x2208
+#define H2I_BRES3_C2		0x2308
+
+#define H2I_BRES_C2_INC_SHIFT	0		/* increment value */
+#define H2I_BRES_C2_INC_M	0xffff
+#define H2I_BRES_C2_MOD_SHIFT	16		/* modcontrol value */
+#define H2I_BRES_C2_MOD_M	0xffff0000	/* modctrl=0xffff&(modinc-1) */
+
+/* Unix timer, 64 bit */
+
+#define H2I_UTIME		0x3104
+#define H2I_UTIME_0_LD		0xffff		/* microseconds, LSB's */
+#define H2I_UTIME_1_LD0		0x0f		/* microseconds, MSB's */
+#define H2I_UTIME_1_LD1		0xf0		/* tenths of microseconds */
+#define H2I_UTIME_2_LD		0xffff		/* seconds, LSB's */
+#define H2I_UTIME_3_LD		0xffff		/* seconds, MSB's */
+
+typedef volatile u32 hal2_reg_t;
+
+typedef struct stru_hal2_ctl_regs hal2_ctl_regs_t;
+struct stru_hal2_ctl_regs {
+	hal2_reg_t _unused0[4];
+	hal2_reg_t isr;			/* 0x10 Status Register */
+	hal2_reg_t _unused1[3];
+	hal2_reg_t rev;			/* 0x20 Revision Register */
+	hal2_reg_t _unused2[3];
+	hal2_reg_t iar;			/* 0x30 Indirect Address Register */
+	hal2_reg_t _unused3[3];
+	hal2_reg_t idr0;		/* 0x40 Indirect Data Register 0 */
+	hal2_reg_t _unused4[3];
+	hal2_reg_t idr1;		/* 0x50 Indirect Data Register 1 */
+	hal2_reg_t _unused5[3];
+	hal2_reg_t idr2;		/* 0x60 Indirect Data Register 2 */
+	hal2_reg_t _unused6[3];
+	hal2_reg_t idr3;		/* 0x70 Indirect Data Register 3 */
+};
+
+typedef struct stru_hal2_aes_regs hal2_aes_regs_t;
+struct stru_hal2_aes_regs {
+	hal2_reg_t rx_stat[2];		/* Status registers */
+	hal2_reg_t rx_cr[2];		/* Control registers */
+	hal2_reg_t rx_ud[4];		/* User data window */
+	hal2_reg_t rx_st[24];		/* Channel status data */
+	
+	hal2_reg_t tx_stat[1];		/* Status register */
+	hal2_reg_t tx_cr[3];		/* Control registers */
+	hal2_reg_t tx_ud[4];		/* User data window */
+	hal2_reg_t tx_st[24];		/* Channel status data */
+};
+
+typedef struct stru_hal2_vol_regs hal2_vol_regs_t;
+struct stru_hal2_vol_regs {
+	hal2_reg_t right;		/* 0x00 Right volume */
+	hal2_reg_t left;		/* 0x04 Left volume */
+};
+
+typedef struct stru_hal2_syn_regs hal2_syn_regs_t;
+struct stru_hal2_syn_regs {
+	hal2_reg_t _unused0[2];
+	hal2_reg_t page;		/* DOC Page register */
+	hal2_reg_t regsel;		/* DOC Register selection */
+	hal2_reg_t dlow;		/* DOC Data low */
+	hal2_reg_t dhigh;		/* DOC Data high */
+	hal2_reg_t irq;			/* IRQ Status */
+	hal2_reg_t dram;		/* DRAM Access */
+};
+
+/* HAL2 specific structures */
+
+typedef struct stru_hal2_pbus hal2_pbus_t;
+struct stru_hal2_pbus {
+	struct hpc3_pbus_dmacregs *pbus;
+	int pbusnr;
+	unsigned int ctrl;		/* Current state of pbus->pbdma_ctrl */
+};
+
+typedef struct stru_hal2_binfo hal2_binfo_t;
+typedef struct stru_hal2_buffer hal2_buf_t;
+struct stru_hal2_binfo {
+	volatile struct hpc_dma_desc desc;
+	hal2_buf_t *next;		/* pointer to next buffer */
+	int cnt;			/* bytes in buffer */
+};
+#define H2_BUFFER_SIZE	(PAGE_SIZE - \
+		((sizeof(hal2_binfo_t) - 1) / 8 + 1) * 8)
+struct stru_hal2_buffer {
+	hal2_binfo_t info;
+	char data[H2_BUFFER_SIZE] __attribute__((aligned(8)));
+};
+
+typedef struct stru_hal2_codec hal2_codec_t;
+struct stru_hal2_codec {
+	hal2_buf_t *head;
+	hal2_buf_t *tail; 
+	hal2_pbus_t pbus;
+	unsigned int format;		/* Audio data format */
+	int voices;			/* mono/stereo */
+	unsigned int sample_rate;
+	unsigned int master;		/* Master frequency */
+	unsigned short mod;		/* MOD value */
+	unsigned short inc;		/* INC value */
+
+	wait_queue_head_t dma_wait;
+	spinlock_t lock;
+	struct semaphore sem;
+
+	int usecount;			/* recording and playback are 
+					 * independent */
+};
+
+#define H2_MIX_OUTPUT_ATT	0
+#define H2_MIX_INPUT_GAIN	1
+#define H2_MIXERS		2
+typedef struct stru_hal2_mixer hal2_mixer_t;
+struct stru_hal2_mixer {
+	int modcnt;
+	unsigned int volume[H2_MIXERS];
+};
+
+typedef struct stru_hal2_card hal2_card_t;
+struct stru_hal2_card {
+	int dev_dsp;			/* audio device */
+	int dev_mixer;			/* mixer device */
+	int dev_midi;			/* midi device */
+	
+	hal2_ctl_regs_t *ctl_regs;	/* HAL2 ctl registers */
+	hal2_aes_regs_t *aes_regs;	/* HAL2 vol registers */
+	hal2_vol_regs_t *vol_regs;	/* HAL2 aes registers */
+	hal2_syn_regs_t *syn_regs;	/* HAL2 syn registers */
+
+	hal2_codec_t dac;
+	hal2_codec_t adc;
+	hal2_mixer_t mixer;
+};
+
+#endif				/* __HAL2_H */
