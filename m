Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264399AbTCYX7o>; Tue, 25 Mar 2003 18:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264424AbTCYX7o>; Tue, 25 Mar 2003 18:59:44 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:25485 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S264399AbTCYX7c>;
	Tue, 25 Mar 2003 18:59:32 -0500
Date: Tue, 25 Mar 2003 19:12:51 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Joe Rayhawk <bung@omgwallhack.org>
Cc: linux-kernel@vger.kernel.org, shaheed <srhaque@iee.org>
Subject: Re: [PROBLEM] SB16 fails to compile: ISA PNP issues
Message-ID: <20030325191251.GA1083@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Joe Rayhawk <bung@omgwallhack.org>, linux-kernel@vger.kernel.org,
	shaheed <srhaque@iee.org>
References: <200303091038.00948.srhaque@iee.org> <200303252221.59910.srhaque@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303252221.59910.srhaque@iee.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 10:21:59PM +0000, shaheed wrote:
> Joe,
> 
> Adam Belay (cc'd) has a compiled-but-not-tested fix for this, and several 
> other cards: sadly the hardware with my SB16 died before I could do the 
> testing.
> 
> Your offer of testing is probably *just* what he needs...
>

Thanks for bringing this to my attention.  Yes, the sb code needs testors.
Below is the latest patch.  Please note that the legacy detection code
could be cleaned up some more.

Thanks,
Adam

--- a/sound/isa/sb/sb16.c	Mon Mar 24 22:01:16 2003
+++ b/sound/isa/sb/sb16.c	Mon Mar 24 20:33:11 2003
@@ -23,11 +23,7 @@
 #include <asm/dma.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#ifndef LINUX_ISAPNP_H
-#include <linux/isapnp.h>
-#define isapnp_card pci_bus
-#define isapnp_dev pci_dev
-#endif
+#include <linux/pnp.h>
 #include <sound/core.h>
 #include <sound/sb.h>
 #include <sound/sb16_csp.h>
@@ -77,7 +73,7 @@
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_ISAPNP; /* Enable this card */
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 static int isapnp[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1};
 #endif
 static long port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* 0x220,0x240,0x260,0x280 */
@@ -106,10 +102,10 @@
 MODULE_PARM(enable, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(enable, "Enable SoundBlaster 16 soundcard.");
 MODULE_PARM_SYNTAX(enable, SNDRV_ENABLE_DESC);
-#ifdef __ISAPNP__
-MODULE_PARM(isapnp, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
-MODULE_PARM_DESC(isapnp, "ISA PnP detection for specified soundcard.");
-MODULE_PARM_SYNTAX(isapnp, SNDRV_ISAPNP_DESC);
+#ifdef CONFIG_PNP
+MODULE_PARM(pnp, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(pnp, "PnP detection for specified soundcard.");
+MODULE_PARM_SYNTAX(pnp, SNDRV_ISAPNP_DESC);
 #endif
 MODULE_PARM(port, "1-" __MODULE_STRING(SNDRV_CARDS) "l");
 MODULE_PARM_DESC(port, "Port # for SB16 driver.");
@@ -148,231 +144,211 @@
 MODULE_PARM_SYNTAX(seq_ports, SNDRV_ENABLED ",allows:{{0,8}},skill:advanced");
 #endif

-struct snd_sb16 {
+struct snd_card_sb16 {
 	struct resource *fm_res;	/* used to block FM i/o region for legacy cards */
-#ifdef __ISAPNP__
-	struct isapnp_dev *dev;
+#ifdef CONFIG_PNP
+	int dev_no;
+	struct pnp_dev *dev;
 #ifdef SNDRV_SBAWE_EMU8000
-	struct isapnp_dev *devwt;
+	struct pnp_dev *devwt;
 #endif
 #endif
 };
 
-static snd_card_t *snd_sb16_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
-
-#ifdef __ISAPNP__
-
-static struct isapnp_card *snd_sb16_isapnp_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
-static const struct isapnp_card_id *snd_sb16_isapnp_id[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
-
-#define ISAPNP_SB16(_va, _vb, _vc, _device, _audio) \
-	{ \
-		ISAPNP_CARD_ID(_va, _vb, _vc, _device), \
-		.devs = { ISAPNP_DEVICE_ID(_va, _vb, _vc, _audio), } \
-	}
-#define ISAPNP_SBAWE(_va, _vb, _vc, _device, _audio, _awe) \
-	{ \
-		ISAPNP_CARD_ID(_va, _vb, _vc, _device), \
-		.devs = { ISAPNP_DEVICE_ID(_va, _vb, _vc, _audio), \
-			 ISAPNP_DEVICE_ID(_va, _vb, _vc, _awe), } \
-	}
+static snd_card_t *snd_sb16_legacy[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
 
-static struct isapnp_card_id snd_sb16_pnpids[] __devinitdata = {
+static struct pnp_card_id snd_sb16_pnpids[] __devinitdata = {
 #ifndef SNDRV_SBAWE
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x0024,0x0031),
+	{ .id = "CTL0024", .devs = { { "CTL0031" } } },
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x0025,0x0031),
+	{ .id = "CTL0025", .devs = { { "CTL0031" } } },
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x0026,0x0031),
+	{ .id = "CTL0026", .devs = { { "CTL0031" } } },
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x0027,0x0031),
+	{ .id = "CTL0027", .devs = { { "CTL0031" } } },
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x0028,0x0031),
+	{ .id = "CTL0028", .devs = { { "CTL0031" } } },
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x0029,0x0031),
+	{ .id = "CTL0029", .devs = { { "CTL0031" } } },
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x002a,0x0031),
+	{ .id = "CTL002a", .devs = { { "CTL0031" } } },
 	/* Sound Blaster 16 PnP */
 	/* Note: This card has also a CTL0051:StereoEnhance device!!! */
-	ISAPNP_SB16('C','T','L',0x002b,0x0031),
+	{ .id = "CTL002b", .devs = { { "CTL0031" } } },
 	/* Sound Blaster 16 PnP */
-	ISAPNP_SB16('C','T','L',0x002c,0x0031),	
+	{ .id = "CTL002c", .devs = { { "CTL0031" } } },
 	/* Sound Blaster Vibra16S */
-	ISAPNP_SB16('C','T','L',0x0051,0x0001),
+	{ .id = "CTL0051", .devs = { { "CTL0001" } } },
 	/* Sound Blaster Vibra16C */
-	ISAPNP_SB16('C','T','L',0x0070,0x0001),
+	{ .id = "CTL0070", .devs = { { "CTL0001" } } },
 	/* Sound Blaster Vibra16CL - added by ctm@ardi.com */
-	ISAPNP_SB16('C','T','L',0x0080,0x0041),
+	{ .id = "CTL0080", .devs = { { "CTL0041" } } },
 	/* Sound Blaster 16 'value' PnP. It says model ct4130 on the pcb, */
 	/* but ct4131 on a sticker on the board.. */
-	ISAPNP_SB16('C','T','L',0x0086,0x0041),
+	{ .id = "CTL0086", .devs = { { "CTL0041" } } },
 	/* Sound Blaster Vibra16X */
-	ISAPNP_SB16('C','T','L',0x00f0,0x0043),
+	{ .id = "CTL00f0", .devs = { { "CTL0043" } } },
 #else  /* SNDRV_SBAWE defined */
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0035,0x0031,0x0021),
+	{ .id = "CTL0035", .devs = { { "CTL0031" }, { "CTL0021" } } },
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0039,0x0031,0x0021),
+	{ .id = "CTL0039", .devs = { { "CTL0031" }, { "CTL0021" } } },
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0042,0x0031,0x0021),
+	{ .id = "CTL0042", .devs = { { "CTL0031" }, { "CTL0021" } } },
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0043,0x0031,0x0021),
+	{ .id = "CTL0043", .devs = { { "CTL0031" }, { "CTL0021" } } },
 	/* Sound Blaster AWE 32 PnP */
 	/* Note: This card has also a CTL0051:StereoEnhance device!!! */
-	ISAPNP_SBAWE('C','T','L',0x0044,0x0031,0x0021),
+	{ .id = "CTL0044", .devs = { { "CTL0031" }, { "CTL0021" } } },
 	/* Sound Blaster AWE 32 PnP */
 	/* Note: This card has also a CTL0051:StereoEnhance device!!! */
-	ISAPNP_SBAWE('C','T','L',0x0045,0x0031,0x0021),
+	{ .id = "CTL0045", .devs = { { "CTL0031" }, { "CTL0021" } } },
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0046,0x0031,0x0021),
+	{ .id = "CTL0046", .devs = { { "CTL0031" }, { "CTL0021" } } },
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0047,0x0031,0x0021),
+	{ .id = "CTL0047", .devs = { { "CTL0031" }, { "CTL0021" } } },
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0048,0x0031,0x0021),
+	{ .id = "CTL0048", .devs = { { "CTL0031" }, { "CTL0021" } } },
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x0054,0x0031,0x0021),
+	{ .id = "CTL0054", .devs = { { "CTL0031" }, { "CTL0021" } } },
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x009a,0x0041,0x0021),
+	{ .id = "CTL009a", .devs = { { "CTL0041" }, { "CTL0021" } } },
 	/* Sound Blaster AWE 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x009c,0x0041,0x0021),
+	{ .id = "CTL009c", .devs = { { "CTL0041" }, { "CTL0021" } } },
 	/* Sound Blaster 32 PnP */
-	ISAPNP_SBAWE('C','T','L',0x009f,0x0041,0x0021),
+	{ .id = "CTL009f", .devs = { { "CTL0041" }, { "CTL0021" } } },
 	/* Sound Blaster AWE 64 PnP */
-	ISAPNP_SBAWE('C','T','L',0x009d,0x0042,0x0022),
+	{ .id = "CTL009d", .devs = { { "CTL0042" }, { "CTL0022" } } },
 	/* Sound Blaster AWE 64 PnP Gold */
-	ISAPNP_SBAWE('C','T','L',0x009e,0x0044,0x0023),
+	{ .id = "CTL009e", .devs = { { "CTL0044" }, { "CTL0023" } } },
 	/* Sound Blaster AWE 64 PnP Gold */
-	ISAPNP_SBAWE('C','T','L',0x00b2,0x0044,0x0023),
+	{ .id = "CTL00b2", .devs = { { "CTL0044" }, { "CTL0023" } } },
 	/* Sound Blaster AWE 64 PnP */
-	ISAPNP_SBAWE('C','T','L',0x00c1,0x0042,0x0022),
+	{ .id = "CTL00c1", .devs = { { "CTL0042" }, { "CTL0022" } } },
 	/* Sound Blaster AWE 64 PnP */
-	ISAPNP_SBAWE('C','T','L',0x00c3,0x0045,0x0022),
+	{ .id = "CTL00c3", .devs = { { "CTL0045" }, { "CTL0022" } } },
 	/* Sound Blaster AWE 64 PnP */
-	ISAPNP_SBAWE('C','T','L',0x00c5,0x0045,0x0022),
+	{ .id = "CTL00c5", .devs = { { "CTL0045" }, { "CTL0022" } } },
 	/* Sound Blaster AWE 64 PnP */
-	ISAPNP_SBAWE('C','T','L',0x00c7,0x0045,0x0022),
+	{ .id = "CTL00c7", .devs = { { "CTL0045" }, { "CTL0022" } } },
 	/* Sound Blaster AWE 64 PnP */
-	ISAPNP_SBAWE('C','T','L',0x00e4,0x0045,0x0022),
+	{ .id = "CTL00e4", .devs = { { "CTL0045" }, { "CTL0022" } } },
 	/* Sound Blaster AWE 64 PnP */
-	ISAPNP_SBAWE('C','T','L',0x00e9,0x0045,0x0022),
+	{ .id = "CTL00e9", .devs = { { "CTL0045" }, { "CTL0022" } } },
 	/* Sound Blaster 16 PnP (AWE) */
-	ISAPNP_SBAWE('C','T','L',0x00ed,0x0041,0x0070),
+	{ .id = "CTL00ed", .devs = { { "CTL0041" }, { "CTL0070" } } },
 	/* Generic entries */
-	ISAPNP_SBAWE('C','T','L',ISAPNP_ANY_ID,0x0031,0x0021),
-	ISAPNP_SBAWE('C','T','L',ISAPNP_ANY_ID,0x0041,0x0021),
-	ISAPNP_SBAWE('C','T','L',ISAPNP_ANY_ID,0x0042,0x0022),
-	ISAPNP_SBAWE('C','T','L',ISAPNP_ANY_ID,0x0044,0x0023),
-	ISAPNP_SBAWE('C','T','L',ISAPNP_ANY_ID,0x0045,0x0022),
+	{ .id = "CTLXXXX" , .devs = { { "CTL0031" }, { "CTL0021" } } },
+	{ .id = "CTLXXXX" , .devs = { { "CTL0041" }, { "CTL0021" } } },
+	{ .id = "CTLXXXX" , .devs = { { "CTL0042" }, { "CTL0022" } } },
+	{ .id = "CTLXXXX" , .devs = { { "CTL0044" }, { "CTL0023" } } },
+	{ .id = "CTLXXXX" , .devs = { { "CTL0045" }, { "CTL0022" } } },
 #endif /* SNDRV_SBAWE */
-	{ ISAPNP_CARD_END, }
+	{ .id = "", }
 };
 
-ISAPNP_CARD_TABLE(snd_sb16_pnpids);
+MODULE_DEVICE_TABLE(pnp_card, snd_sb16_pnpids);
 
-static int __init snd_sb16_isapnp(int dev, struct snd_sb16 *acard)
+#ifdef SNDRV_SBAWE_EMU8000
+#define DRIVER_NAME	"snd-card-sbawe"
+#else
+#define DRIVER_NAME	"snd-card-sb16"
+#endif
+
+static int __devinit snd_card_sb16_pnp(int dev, struct snd_card_sb16 *acard,
+				       struct pnp_card_link *card,
+				       const struct pnp_card_id *id)
 {
-	const struct isapnp_card_id *id = snd_sb16_isapnp_id[dev];
-	struct isapnp_card *card = snd_sb16_isapnp_cards[dev];
-	struct isapnp_dev *pdev;
-
-	acard->dev = isapnp_find_dev(card, id->devs[0].vendor, id->devs[0].function, NULL);
-	if (acard->dev->active) {
-		acard->dev = NULL;
-		return -EBUSY;
-	}
-#ifdef SNDRV_SBAWE_EMU8000
-	acard->devwt = isapnp_find_dev(card, id->devs[1].vendor, id->devs[1].function, NULL);
-	if (acard->devwt->active) {
-		acard->dev = acard->devwt = NULL;
-		return -EBUSY;
-	}
-#endif	
+	struct pnp_dev *pdev;
+	struct pnp_resource_table * cfg = kmalloc(GFP_ATOMIC, sizeof(struct pnp_resource_table));
+	int err;
+
+	if (!cfg) 
+		return -ENOMEM; 
+	acard->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
+	if (acard->dev == NULL) { 
+		kfree(cfg); 
+		return -ENODEV; 
+	} 
+#ifdef SNDRV_SBAWE_EMU8000
+	acard->devwt = pnp_request_card_device(card, id->devs[1].id, acard->dev);
+#endif
 	/* Audio initialization */
 	pdev = acard->dev;
-	if (pdev->prepare(pdev) < 0)
-		return -EAGAIN;
+
+	pnp_init_resource_table(cfg); 
+	 
+	/* override resources */ 
+
 	if (port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[0], port[dev], 16);
+		pnp_resource_change(&cfg->port_resource[0], port[dev], 16);
 	if (mpu_port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[1], mpu_port[dev], 2);
+		pnp_resource_change(&cfg->port_resource[1], mpu_port[dev], 2);
 	if (fm_port[dev] != SNDRV_AUTO_PORT)
-		isapnp_resource_change(&pdev->resource[2], fm_port[dev], 4);
+		pnp_resource_change(&cfg->port_resource[2], fm_port[dev], 4);
 	if (dma8[dev] != SNDRV_AUTO_DMA)
-		isapnp_resource_change(&pdev->dma_resource[0], dma8[dev], 1);
+		pnp_resource_change(&cfg->dma_resource[0], dma8[dev], 1);
 	if (dma16[dev] != SNDRV_AUTO_DMA)
-		isapnp_resource_change(&pdev->dma_resource[1], dma16[dev], 1);
+		pnp_resource_change(&cfg->dma_resource[1], dma16[dev], 1);
 	if (irq[dev] != SNDRV_AUTO_IRQ)
-		isapnp_resource_change(&pdev->irq_resource[0], irq[dev], 1);
-	if (pdev->activate(pdev) < 0) {
-		printk(KERN_ERR PFX "isapnp configure failure (out of resources?)\n");
-		return -EBUSY;
-	}
-	port[dev] = pdev->resource[0].start;
-	mpu_port[dev] = pdev->resource[1].start;
-	fm_port[dev] = pdev->resource[2].start;
-	dma8[dev] = pdev->dma_resource[0].start;
-	dma16[dev] = pdev->dma_resource[1].start;
-	irq[dev] = pdev->irq_resource[0].start;
-	snd_printdd("isapnp SB16: port=0x%lx, mpu port=0x%lx, fm port=0x%lx\n",
+		pnp_resource_change(&cfg->irq_resource[0], irq[dev], 1);
+	if ((pnp_manual_config_dev(pdev, cfg, 0)) < 0) 
+		printk(KERN_ERR PFX "AUDIO the requested resources are invalid, using auto config\n"); 
+	err = pnp_activate_dev(pdev); 
+	if (err < 0) { 
+		printk(KERN_ERR PFX "AUDIO pnp configure failure\n"); 
+		kfree(cfg);
+		return err; 
+	} 
+	port[dev] = pnp_port_start(pdev, 0);
+	mpu_port[dev] = pnp_port_start(pdev, 1);
+	fm_port[dev] = pnp_port_start(pdev, 2);
+	dma8[dev] = pnp_dma(pdev, 0);
+	dma16[dev] = pnp_dma(pdev, 1);
+	irq[dev] = pnp_irq(pdev, 0);
+	snd_printdd("pnp SB16: port=0x%lx, mpu port=0x%lx, fm port=0x%lx\n",
 			port[dev], mpu_port[dev], fm_port[dev]);
-	snd_printdd("isapnp SB16: dma1=%i, dma2=%i, irq=%i\n",
+	snd_printdd("pnp SB16: dma1=%i, dma2=%i, irq=%i\n",
 			dma8[dev], dma16[dev], irq[dev]);
 #ifdef SNDRV_SBAWE_EMU8000
 	/* WaveTable initialization */
 	pdev = acard->devwt;
-	if (pdev->prepare(pdev)<0) {
-		acard->dev->deactivate(acard->dev);
-		return -EAGAIN;
-	}
-	if (awe_port[dev] != SNDRV_AUTO_PORT) {
-		isapnp_resource_change(&pdev->resource[0], awe_port[dev], 4);
-		isapnp_resource_change(&pdev->resource[1], awe_port[dev] + 0x400, 4);
-		isapnp_resource_change(&pdev->resource[2], awe_port[dev] + 0x800, 4);
-	}
-	if (pdev->activate(pdev)<0) {
-		printk(KERN_ERR PFX "WaveTable isapnp configure failure (out of resources?)\n");
-		acard->dev->deactivate(acard->dev);		
-		return -EBUSY;
-	}
-	awe_port[dev] = pdev->resource[0].start;
-	snd_printdd("isapnp SB16: wavetable port=0x%lx\n", pdev->resource[0].start);
-#endif
-	return 0;
-}
-
-static void snd_sb16_deactivate(struct snd_sb16 *acard)
-{
-	if (acard->dev) {
-		acard->dev->deactivate(acard->dev);
-		acard->dev = NULL;
-	}
-#ifdef SNDRV_SBAWE_EMU8000
-	if (acard->devwt) {
-		acard->devwt->deactivate(acard->devwt);
+	if (pdev != NULL) {
+		pnp_init_resource_table(cfg); 
+	 
+		/* override resources */ 
+
+		if (awe_port[dev] != SNDRV_AUTO_PORT) {
+			pnp_resource_change(&cfg->port_resource[0], awe_port[dev], 4);
+			pnp_resource_change(&cfg->port_resource[1], awe_port[dev] + 0x400, 4);
+			pnp_resource_change(&cfg->port_resource[2], awe_port[dev] + 0x800, 4);
+		}
+		if ((pnp_manual_config_dev(pdev, cfg, 0)) < 0) 
+			printk(KERN_ERR PFX "WaveTable the requested resources are invalid, using auto config\n"); 
+		err = pnp_activate_dev(pdev); 
+		if (err < 0) { 
+			goto __wt_error; 
+		} 
+		awe_port[dev] = pnp_port_start(pdev, 0);
+		snd_printdd("pnp SB16: wavetable port=0x%lx\n", pdev->resource[0].start);
+	} else {
+__wt_error:
+		if (pdev) {
+			pnp_release_card_device(pdev);
+			printk(KERN_ERR PFX "WaveTable pnp configure failure\n");
+		}
 		acard->devwt = NULL;
+		awe_port[dev] = -1;
 	}
 #endif
+	kfree(cfg);
+	return 0;
 }
 
-#endif /* __ISAPNP__ */
-
-static void snd_sb16_free(snd_card_t *card)
-{
-	struct snd_sb16 *acard = (struct snd_sb16 *)card->private_data;
-
-	if (acard == NULL)
-		return;
-	if (acard->fm_res) {
-		release_resource(acard->fm_res);
-		kfree_nocheck(acard->fm_res);
-	}
-#ifdef __ISAPNP__
-	snd_sb16_deactivate(acard);
-#endif
-}
-
-static int __init snd_sb16_probe(int dev)
+static int __init snd_sb16_probe(int dev,
+				 struct pnp_card_link *pcard,
+				 const struct pnp_card_id *pid)
 {
 	static int possible_irqs[] = {5, 9, 10, 7, -1};
 	static int possible_dmas8[] = {1, 3, 0, -1};
@@ -380,7 +356,7 @@
 	int xirq, xdma8, xdma16;
 	sb_t *chip;
 	snd_card_t *card;
-	struct snd_sb16 *acard;
+	struct snd_card_sb16 *acard;
 	opl3_t *opl3;
 	snd_hwdep_t *synth = NULL;
 #ifdef CONFIG_SND_SB16_CSP
@@ -390,22 +366,21 @@
 	int err;
 
 	card = snd_card_new(index[dev], id[dev], THIS_MODULE,
-			    sizeof(struct snd_sb16));
+			    sizeof(struct snd_card_sb16));
 	if (card == NULL)
 		return -ENOMEM;
-	acard = (struct snd_sb16 *) card->private_data;
-	card->private_free = snd_sb16_free;
-#ifdef __ISAPNP__
-	if (isapnp[dev] && snd_sb16_isapnp(dev, acard) < 0) {
-		snd_card_free(card);
-		return -EBUSY;
+	acard = (struct snd_card_sb16 *) card->private_data;
+	if (isapnp[dev]) {
+		if ((err = snd_card_sb16_pnp(dev, acard, pcard, pid))) {
+			snd_card_free(card);
+			return err;
+		}
 	}
-#endif
 
 	xirq = irq[dev];
 	xdma8 = dma8[dev];
 	xdma16 = dma16[dev];
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	if (!isapnp[dev]) {
 #endif
 	if (xirq == SNDRV_AUTO_IRQ) {
@@ -437,7 +412,7 @@
 	/* non-PnP AWE port address is hardwired with base port address */
 	awe_port[dev] = port[dev] + 0x400;
 #endif
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	}
 #endif
 
@@ -458,7 +433,7 @@
 		return -ENODEV;
 	}
 	chip->mpu_port = mpu_port[dev];
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	if (!isapnp[dev] && (err = snd_sb16dsp_configure(chip)) < 0) {
 #else
 	if ((err = snd_sb16dsp_configure(chip)) < 0) {
@@ -554,7 +529,10 @@
 		snd_card_free(card);
 		return err;
 	}
-	snd_sb16_cards[dev] = card;
+	if (pcard)
+		pnp_set_card_drvdata(pcard, card);
+	else
+		snd_sb16_legacy[dev] = card;
 	return 0;
 }
 
@@ -566,12 +544,12 @@
 	for ( ; dev < SNDRV_CARDS; dev++) {
 		if (!enable[dev] || port[dev] != SNDRV_AUTO_PORT)
 			continue;
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 		if (isapnp[dev])
 			continue;
 #endif
 		port[dev] = xport;
-		res = snd_sb16_probe(dev);
+		res = snd_sb16_probe(dev, NULL, NULL);
 		if (res < 0)
 			port[dev] = SNDRV_AUTO_PORT;
 		return res;
@@ -579,10 +557,10 @@
 	return -ENODEV;
 }
 
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 
-static int __init snd_sb16_isapnp_detect(struct isapnp_card *card,
-					 const struct isapnp_card_id *id)
+static int __devinit snd_sb16_pnp_detect(struct pnp_card_link *card,
+					 const struct pnp_card_id *id)
 {
 	static int dev;
 	int res;
@@ -590,9 +568,7 @@
 	for ( ; dev < SNDRV_CARDS; dev++) {
 		if (!enable[dev] || !isapnp[dev])
 			continue;
-		snd_sb16_isapnp_cards[dev] = card;
-		snd_sb16_isapnp_id[dev] = id;
-		res = snd_sb16_probe(dev);
+		res = snd_sb16_probe(dev, card, id);
 		if (res < 0)
 			return res;
 		dev++;
@@ -602,7 +578,23 @@
 	return -ENODEV;
 }
 
-#endif /* __ISAPNP__ */
+#endif
+
+static void __devexit snd_sb16_pnp_remove(struct pnp_card_link * pcard)
+{
+	snd_card_t *card = (snd_card_t *) pnp_get_card_drvdata(pcard);
+
+	snd_card_disconnect(card);
+	snd_card_free_in_thread(card);
+}
+
+static struct pnp_card_driver sb16_pnpc_driver = {
+	.flags = PNP_DRIVER_RES_DISABLE,
+	.name = "sb16",
+	.id_table = snd_sb16_pnpids,
+	.probe = snd_sb16_pnp_detect,
+	.remove = __devexit_p(snd_sb16_pnp_remove),
+};
 
 static int __init alsa_card_sb16_init(void)
 {
@@ -613,23 +605,23 @@
 	for (dev = 0; dev < SNDRV_CARDS; dev++) {
 		if (!enable[dev] || port[dev] == SNDRV_AUTO_PORT)
 			continue;
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 		if (isapnp[dev])
 			continue;
 #endif
-		if (!snd_sb16_probe(dev)) {
+		if (!snd_sb16_probe(dev, NULL, NULL)) {
 			cards++;
 			continue;
 		}
 #ifdef MODULE
 		printk(KERN_ERR "Sound Blaster 16+ soundcard #%i not found at 0x%lx or device busy\n", dev, port[dev]);
-#endif			
+#endif
 	}
 	/* legacy auto configured cards */
 	cards += snd_legacy_auto_probe(possible_ports, snd_sb16_probe_legacy_port);
-#ifdef __ISAPNP__
-	/* ISA PnP cards at last */
-	cards += isapnp_probe_cards(snd_sb16_pnpids, snd_sb16_isapnp_detect);
+#ifdef CONFIG_PNP
+	/* PnP cards at last */
+	cards += pnp_register_card_driver(&sb16_pnpc_driver);
 #endif
 
 	if (!cards) {
@@ -650,8 +642,12 @@
 {
 	int dev;
 
+#ifdef CONFIG_PNP
+	/* PnP cards first */
+	pnp_unregister_card_driver(&sb16_pnpc_driver);
+#endif
 	for (dev = 0; dev < SNDRV_CARDS; dev++)
-		snd_card_free(snd_sb16_cards[dev]);
+		snd_card_free(snd_sb16_legacy[dev]);
 }
 
 module_init(alsa_card_sb16_init)
@@ -659,7 +655,7 @@
 
 #ifndef MODULE
 
-/* format is: snd-sb16=enable,index,id,isapnp,
+/* format is: snd-sb16=enable,index,id,pnp,
 		       port,mpu_port,fm_port,
 		       irq,dma8,dma16,
 		       mic_agc,csp,
@@ -694,7 +690,7 @@
 	       get_option(&str,&seq_ports[nr_dev]) == 2
 #endif
 	       );
-#ifdef __ISAPNP__
+#ifdef CONFIG_PNP
 	if (pnp != INT_MAX)
 		isapnp[nr_dev] = pnp;
 #endif
