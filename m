Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267693AbTBQXZR>; Mon, 17 Feb 2003 18:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267688AbTBQXY5>; Mon, 17 Feb 2003 18:24:57 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:24993 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267673AbTBQXQb>;
	Mon, 17 Feb 2003 18:16:31 -0500
Date: Mon, 17 Feb 2003 18:26:01 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Paul Laufer <paul@laufernet.com>
Subject: [PATCH] pnp - OSS SB update from Paul Laufer (13/13)
Message-ID: <20030217182601.GA31528@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>,
	Paul Laufer <paul@laufernet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a rewrite of much of the Sound Blaster detection code.  It has
been tested and works well in every case reported to me.  Credit for this 
patch should go to Paul Laufer.

Please apply,

Adam


diff -Nrup linux-2.5.61-vanilla/sound/oss/sb_card.c linux-2.5.61-sbpnp/sound/oss/sb_card.c
--- linux-2.5.61-vanilla/sound/oss/sb_card.c	2003-01-14 00:59:00.000000000 -0500
+++ linux-2.5.61-sbpnp/sound/oss/sb_card.c	2003-02-16 01:01:37.000000000 -0500
@@ -1,1035 +1,329 @@
 /*
- * sound/sb_card.c
+ * sound/oss/sb_card.c
  *
- * Detection routine for the Sound Blaster cards.
+ * Detection routine for the ISA Sound Blaster and compatable sound
+ * cards.
  *
+ * This file is distributed under the GNU GENERAL PUBLIC LICENSE (GPL)
+ * Version 2 (June 1991). See the "COPYING" file distributed with this
+ * software for more info.
+ *
+ * This is a complete rewrite of the detection routines. This was
+ * prompted by the PnP API change during v2.5 and the ugly state the
+ * code was in.
+ *
+ * Copyright (C) by Paul Laufer 2002. Based on code originally by
+ * Hannu Savolainen which was modified by many others over the
+ * years. Authors specifically mentioned in the previous version were:
+ * Daniel Stone, Alessandro Zummo, Jeff Garzik, Arnaldo Carvalho de
+ * Melo, Daniel Church, and myself.
  *
- * Copyright (C) by Hannu Savolainen 1993-1997
- *
- * OSS/Free for Linux is distributed under the GNU GENERAL PUBLIC LICENSE (GPL)
- * Version 2 (June 1991). See the "COPYING" file distributed with this software
- * for more info.
- *
- * 26-11-1999 Patched to compile without ISA PnP support in the
- * kernel - Daniel Stone (tamriel@ductape.net) 
- *
- * 06-01-2000 Refined and bugfixed ISA PnP support, added
- *  CMI 8330 support - Alessandro Zummo <azummo@ita.flashnet.it>
- *
- * 18-01-2000 Separated sb_card and sb_common
- *  Jeff Garzik <jgarzik@pobox.com>
- *
- * 04-02-2000 Added Soundblaster AWE 64 PnP support, isapnpjump
- *  Alessandro Zummo <azummo@ita.flashnet.it>
- *
- * 11-02-2000 Added Soundblaster AWE 32 PnP support, refined PnP code
- *  Alessandro Zummo <azummo@ita.flashnet.it>
- *
- * 13-02-2000 Hopefully fixed awe/sb16 related bugs, code cleanup
- *  Alessandro Zummo <azummo@ita.flashnet.it>
- *
- * 13-03-2000 Added some more cards, thanks to Torsten Werner.
- *  Removed joystick and wavetable code, there are better places for them.
- *  Code cleanup plus some fixes. 
- *  Alessandro Zummo <azummo@ita.flashnet.it>
- * 
- * 26-03-2000 Fixed acer, esstype and sm_games module options.
- *  Alessandro Zummo <azummo@ita.flashnet.it>
- *
- * 12-04-2000 ISAPnP cleanup, reorg, fixes, and multiple card support.
- *  Thanks to Gaël Quéri and Alessandro Zummo for testing and fixes.
- *  Paul E. Laufer <pelaufer@csupomona.edu>
- *
- * 06-05-2000 added another card. Daniel M. Newman <dmnewman@pobox.com>
- *
- * 25-05-2000 Added Creative SB AWE64 Gold (CTL00B2). 
- * 	Pål-Kristian Engstad <engstad@att.net>
- *
- * 12-08-2000 Added Creative SB32 PnP (CTL009F).
- * 	Kasatenko Ivan Alex. <skywriter@rnc.ru>
- *
- * 21-09-2000 Got rid of attach_sbmpu
- * 	Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * 28-10-2000 Added pnplegacy support
- * 	Daniel Church <dchurch@mbhs.edu>
- *
- * 01-10-2001 Added a new flavor of Creative SB AWE64 PnP (CTL00E9).
- *      Jerome Cornet <jcornet@free.fr>
+ * 02-05-2003 Original Release, Paul Laufer <paul@laufernet.com>
+ * 02-07-2003 Bug made it into first release. Take two.
  */
 
 #include <linux/config.h>
-#include <linux/mca.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
-#include <linux/isapnp.h>
-
+#ifdef CONFIG_MCA
+#include <linux/mca.h>
+#endif /* CONFIG_MCA */
 #include "sound_config.h"
-
 #include "sb_mixer.h"
 #include "sb.h"
-
-#ifdef __ISAPNP__
-#define SB_CARDS_MAX 5
-#else
-#define SB_CARDS_MAX 1
+#ifdef CONFIG_PNP_CARD
+#include <linux/pnp.h>
 #endif
+#include "sb_card.h"
 
-static int sbmpu[SB_CARDS_MAX] = {0};
-static int sb_cards_num = 0;
+MODULE_DESCRIPTION("OSS Soundblaster ISA PnP and legacy sound driver");
+MODULE_LICENSE("GPL");
 
 extern void *smw_free;
 
-/*
- *    Note DMA2 of -1 has the right meaning in the SB16 driver as well
- *    as here. It will cause either an error if it is needed or a fallback
- *    to the 8bit channel.
- */
-
 static int __initdata mpu_io	= 0;
 static int __initdata io	= -1;
 static int __initdata irq	= -1;
 static int __initdata dma	= -1;
-static int __initdata dma16	= -1;   /* Set this for modules that need it */
-static int __initdata type	= 0;    /* Can set this to a specific card type */
-static int __initdata esstype   = 0;	/* ESS chip type */
-static int __initdata acer 	= 0;	/* Do acer notebook init? */
-static int __initdata sm_games 	= 0;	/* Logitech soundman games? */
+static int __initdata dma16	= -1;
+static int __initdata type	= 0; /* Can set this to a specific card type */
+static int __initdata esstype   = 0; /* ESS chip type */
+static int __initdata acer 	= 0; /* Do acer notebook init? */
+static int __initdata sm_games 	= 0; /* Logitech soundman games? */
 
-static void __init attach_sb_card(struct address_info *hw_config)
-{
-	if(!sb_dsp_init(hw_config, THIS_MODULE))
-		hw_config->slots[0] = -1;
-}
+struct sb_card_config *legacy = NULL;
 
-static int __init probe_sb(struct address_info *hw_config)
-{
-	struct sb_module_options sbmo;
-
-	if (hw_config->io_base == -1 || hw_config->dma == -1 || hw_config->irq == -1)
-	{
-		printk(KERN_ERR "sb: I/O, IRQ, and DMA are mandatory\n");
-		return -EINVAL;
-	}
-
-#ifdef CONFIG_MCA
-	/* MCA code added by ZP Gu (zpg@castle.net) */
-	if (MCA_bus) {               /* no multiple REPLY card probing */
-		int slot;
-		u8 pos2, pos3, pos4;
-
-		slot = mca_find_adapter( 0x5138, 0 );
-		if( slot == MCA_NOTFOUND ) 
-		{
-			slot = mca_find_adapter( 0x5137, 0 );
-
-			if (slot != MCA_NOTFOUND)
-				mca_set_adapter_name( slot, "REPLY SB16 & SCSI Adapter" );
-		}
-		else
-		{
-			mca_set_adapter_name( slot, "REPLY SB16 Adapter" );
-		}
-
-		if (slot != MCA_NOTFOUND) 
-		{
-			mca_mark_as_used(slot);
-			pos2 = mca_read_stored_pos( slot, 2 );
-			pos3 = mca_read_stored_pos( slot, 3 );
-			pos4 = mca_read_stored_pos( slot, 4 );
-
-			if (pos2 & 0x4) 
-			{
-				/* enabled? */
-				static unsigned short irq[] = { 0, 5, 7, 10 };
-				/*
-				static unsigned short midiaddr[] = {0, 0x330, 0, 0x300 };
-       				*/
-
-				hw_config->io_base = 0x220 + 0x20 * (pos2 >> 6);
-				hw_config->irq = irq[(pos4 >> 5) & 0x3];
-				hw_config->dma = pos3 & 0xf;
-				/* Reply ADF wrong on High DMA, pos[1] should start w/ 00 */
-				hw_config->dma2 = (pos3 >> 4) & 0x3;
-				if (hw_config->dma2 == 0)
-					hw_config->dma2 = hw_config->dma;
-				else
-					hw_config->dma2 += 4;
-				/*
-					hw_config->driver_use_2 = midiaddr[(pos2 >> 3) & 0x3];
-				*/
-	
-				printk(KERN_INFO "sb: Reply MCA SB at slot=%d \
-iobase=0x%x irq=%d lo_dma=%d hi_dma=%d\n",
-						slot+1,
-				        	hw_config->io_base, hw_config->irq,
-	        				hw_config->dma, hw_config->dma2);
-			}
-			else
-			{
-				printk (KERN_INFO "sb: Reply SB Base I/O address disabled\n");
-			}
-		}
-	}
+#ifdef CONFIG_PNP_CARD
+static int __initdata pnp       = 1;
+/*
+static int __initdata uart401	= 0;
+*/
+#else
+static int __initdata pnp       = 0;
 #endif
 
-	/* Setup extra module options */
+module_param(io, int, 000);
+MODULE_PARM_DESC(io,       "Soundblaster i/o base address (0x220,0x240,0x260,0x280)");
+module_param(irq, int, 000);
+MODULE_PARM_DESC(irq,	   "IRQ (5,7,9,10)");
+module_param(dma, int, 000);
+MODULE_PARM_DESC(dma,	   "8-bit DMA channel (0,1,3)");
+module_param(dma16, int, 000);
+MODULE_PARM_DESC(dma16,	   "16-bit DMA channel (5,6,7)");
+module_param(mpu_io, int, 000);
+MODULE_PARM_DESC(mpu_io,   "MPU base address");
+module_param(type, int, 000);
+MODULE_PARM_DESC(type,	   "You can set this to specific card type (doesn't " \
+		 "work with pnp)");
+module_param(sm_games, int, 000);
+MODULE_PARM_DESC(sm_games, "Enable support for Logitech soundman games " \
+		 "(doesn't work with pnp)");
+module_param(esstype, int, 000);
+MODULE_PARM_DESC(esstype,  "ESS chip type (doesn't work with pnp)");
+module_param(acer, int, 000);
+MODULE_PARM_DESC(acer,	   "Set this to detect cards in some ACER notebooks "\
+		 "(doesn't work with pnp)");
+
+#ifdef CONFIG_PNP_CARD
+module_param(pnp, int, 000);
+MODULE_PARM_DESC(pnp,     "Went set to 0 will disable detection using PnP. "\
+		  "Default is 1.\n");
+/* Not done yet.... */
+/*
+module_param(uart401, int, 000);
+MODULE_PARM_DESC(uart401,  "When set to 1, will attempt to detect and enable"\
+		 "the mpu on some clones");
+*/
+#endif /* CONFIG_PNP_CARD */
 
-	sbmo.acer 	= acer;
-	sbmo.sm_games	= sm_games;
-	sbmo.esstype	= esstype;
+/* OSS subsystem card registration shared by PnP and legacy routines */
+static int sb_register_oss(struct sb_card_config *scc, struct sb_module_options *sbmo)
+{
+	if(!sb_dsp_detect(&scc->conf, 0, 0, sbmo)) {
+		printk(KERN_ERR "sb: Failed DSP Detect.\n");
+		kfree(scc);
+		return -ENODEV;
+	}
+	if(!sb_dsp_init(&scc->conf, THIS_MODULE)) {
+		printk(KERN_ERR "sb: Failed DSP init.\n");
+		kfree(scc);
+		return -ENODEV;
+	}
+	if(scc->mpucnf.io_base > 0) {
+		scc->mpu = 1;
+		printk(KERN_INFO "sb: Turning on MPU\n");
+		if(!probe_sbmpu(&scc->mpucnf, THIS_MODULE))
+			scc->mpu = 0;
+	}
 
-	return sb_dsp_detect(hw_config, 0, 0, &sbmo);
+	return 1;
 }
 
-static void __exit unload_sb(struct address_info *hw_config, int card)
+static void sb_unload(struct sb_card_config *scc)
 {
-	if(hw_config->slots[0]!=-1)
-		sb_dsp_unload(hw_config, sbmpu[card]);
+	sb_dsp_unload(&scc->conf, 0);
+	if(scc->mpu)
+		unload_sbmpu(&scc->mpucnf);
+	kfree(scc);
 }
 
-static struct address_info cfg[SB_CARDS_MAX];
-static struct address_info cfg_mpu[SB_CARDS_MAX];
-
-struct pci_dev 	*sb_dev[SB_CARDS_MAX] 	= {NULL}, 
-		*mpu_dev[SB_CARDS_MAX]	= {NULL},
-		*opl_dev[SB_CARDS_MAX]	= {NULL};
-
-
-#ifdef __ISAPNP__
-static int isapnp	= 1;
-static int isapnpjump	= 0;
-static int multiple	= 1;
-static int pnplegacy	= 0;
-static int reverse	= 0;
-static int uart401	= 0;
-
-static int audio_activated[SB_CARDS_MAX] = {0};
-static int mpu_activated[SB_CARDS_MAX]   = {0};
-static int opl_activated[SB_CARDS_MAX]   = {0};
-#else
-static int isapnp	= 0;
-static int multiple	= 0;
-static int pnplegacy	= 0;
-#endif
-
-MODULE_DESCRIPTION("Soundblaster driver");
-MODULE_LICENSE("GPL");
-
-MODULE_PARM(io,		"i");
-MODULE_PARM(irq,	"i");
-MODULE_PARM(dma,	"i");
-MODULE_PARM(dma16,	"i");
-MODULE_PARM(mpu_io,	"i");
-MODULE_PARM(type,	"i");
-MODULE_PARM(sm_games,	"i");
-MODULE_PARM(esstype,	"i");
-MODULE_PARM(acer,	"i");
-
-#ifdef __ISAPNP__
-MODULE_PARM(isapnp,	"i");
-MODULE_PARM(isapnpjump,	"i");
-MODULE_PARM(multiple,	"i");
-MODULE_PARM(pnplegacy,	"i");
-MODULE_PARM(reverse,	"i");
-MODULE_PARM(uart401,	"i");
-MODULE_PARM_DESC(isapnp,	"When set to 0, Plug & Play support will be disabled");
-MODULE_PARM_DESC(isapnpjump,	"Jumps to a specific slot in the driver's PnP table. Use the source, Luke.");
-MODULE_PARM_DESC(multiple,	"When set to 0, will not search for multiple cards");
-MODULE_PARM_DESC(pnplegacy,	"When set to 1, will search for a legacy SB card along with any PnP cards.");
-MODULE_PARM_DESC(reverse,	"When set to 1, will reverse ISAPnP search order");
-MODULE_PARM_DESC(uart401,	"When set to 1, will attempt to detect and enable the mpu on some clones");
-#endif
-
-MODULE_PARM_DESC(io,		"Soundblaster i/o base address (0x220,0x240,0x260,0x280)");
-MODULE_PARM_DESC(irq,		"IRQ (5,7,9,10)");
-MODULE_PARM_DESC(dma,		"8-bit DMA channel (0,1,3)");
-MODULE_PARM_DESC(dma16,		"16-bit DMA channel (5,6,7)");
-MODULE_PARM_DESC(mpu_io,	"Mpu base address");
-MODULE_PARM_DESC(type,		"You can set this to specific card type");
-MODULE_PARM_DESC(sm_games,	"Enable support for Logitech soundman games");
-MODULE_PARM_DESC(esstype,	"ESS chip type");
-MODULE_PARM_DESC(acer,		"Set this to detect cards in some ACER notebooks");
-
-#ifdef __ISAPNP__
-
-/* Please add new entries at the end of the table */
-static struct {
-	char *name; 
-	unsigned short	card_vendor, card_device, 
-			audio_vendor, audio_function,
-			mpu_vendor, mpu_function,
-			opl_vendor, opl_function;
-	short dma, dma2, mpu_io, mpu_irq; /* see sb_init() */
-} sb_isapnp_list[] __initdata = {
-	{"Sound Blaster 16", 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0024),
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster 16",
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0025),
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster 16", 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0026), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster 16", 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0027), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster 16", 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0028), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster 16", 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0029), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster 16",
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x002a),
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster 16", 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x002b), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster 16", 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x002c), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster 16", 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x002c), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster 16", 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00ed), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0041),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster 16", 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0086), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0041),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster 16", 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0086), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0041),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster Vibra16S", 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0051), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0001),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster Vibra16C", 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0070), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0001),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster Vibra16CL", 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0080), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0041),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster Vibra16X", 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00F0), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0043),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster AWE 32", 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0039), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster AWE 32",
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0042), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster AWE 32",
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0043), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster AWE 32",
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0044),
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031),
-		0,0,0,0,
-		0,1,1,-1},
-        {"Sound Blaster AWE 32",
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0045),
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster AWE 32",
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0046),
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster AWE 32",
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0047),
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster AWE 32",
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0048), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster AWE 32",
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0054), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster AWE 32",
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x009C), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0041),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Creative SB32 PnP",
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x009F),
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0041),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster AWE 64",
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x009D), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0042),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster AWE 64 Gold",
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x009E), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0044),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster AWE 64 Gold",
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00B2),
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0044),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster AWE 64",
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00C1), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0042),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster AWE 64",
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00C3), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0045),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster AWE 64",
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00C5), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0045),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster AWE 64",
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00C7), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0045),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster AWE 64",
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00E4), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0045),
-		0,0,0,0,
-		0,1,1,-1},
-	{"Sound Blaster AWE 64",
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00E9), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0045),
-		0,0,0,0,
-		0,1,1,-1},
-	{"ESS 1688",
-		ISAPNP_VENDOR('E','S','S'), ISAPNP_DEVICE(0x0968), 
-		ISAPNP_VENDOR('E','S','S'), ISAPNP_FUNCTION(0x0968),
-		0,0,0,0,
-		0,1,2,-1},
-	{"ESS 1868",
-		ISAPNP_VENDOR('E','S','S'), ISAPNP_DEVICE(0x1868), 
-		ISAPNP_VENDOR('E','S','S'), ISAPNP_FUNCTION(0x1868),
-		0,0,0,0,
-		0,1,2,-1},
-	{"ESS 1868",
-		ISAPNP_VENDOR('E','S','S'), ISAPNP_DEVICE(0x1868), 
-		ISAPNP_VENDOR('E','S','S'), ISAPNP_FUNCTION(0x8611),
-		0,0,0,0,
-		0,1,2,-1},
-	{"ESS 1869 PnP AudioDrive", 
-		ISAPNP_VENDOR('E','S','S'), ISAPNP_DEVICE(0x0003), 
-		ISAPNP_VENDOR('E','S','S'), ISAPNP_FUNCTION(0x1869),
-		0,0,0,0,
-		0,1,2,-1},
-	{"ESS 1869",
-		ISAPNP_VENDOR('E','S','S'), ISAPNP_DEVICE(0x1869), 
-		ISAPNP_VENDOR('E','S','S'), ISAPNP_FUNCTION(0x1869),
-		0,0,0,0,
-		0,1,2,-1},
-	{"ESS 1878",
-		ISAPNP_VENDOR('E','S','S'), ISAPNP_DEVICE(0x1878), 
-		ISAPNP_VENDOR('E','S','S'), ISAPNP_FUNCTION(0x1878),
-		0,0,0,0,
-		0,1,2,-1},
-	{"ESS 1879",
-		ISAPNP_VENDOR('E','S','S'), ISAPNP_DEVICE(0x1879), 
-		ISAPNP_VENDOR('E','S','S'), ISAPNP_FUNCTION(0x1879),
-		0,0,0,0,
-		0,1,2,-1},
-	{"CMI 8330 SoundPRO",
-		ISAPNP_VENDOR('C','M','I'), ISAPNP_DEVICE(0x0001), 
-		ISAPNP_VENDOR('@','X','@'), ISAPNP_FUNCTION(0x0001),
-		ISAPNP_VENDOR('@','H','@'), ISAPNP_FUNCTION(0x0001),
-		ISAPNP_VENDOR('@','@','@'), ISAPNP_FUNCTION(0x0001),
-		0,1,0,-1},
-	{"Diamond DT0197H",
-		ISAPNP_VENDOR('R','W','B'), ISAPNP_DEVICE(0x1688), 
-		ISAPNP_VENDOR('@','@','@'), ISAPNP_FUNCTION(0x0001),
-		ISAPNP_VENDOR('@','X','@'), ISAPNP_FUNCTION(0x0001),
-		ISAPNP_VENDOR('@','H','@'), ISAPNP_FUNCTION(0x0001),
-		0,-1,0,0},
-	{"ALS007",
-		ISAPNP_VENDOR('A','L','S'), ISAPNP_DEVICE(0x0007),
-		ISAPNP_VENDOR('@','@','@'), ISAPNP_FUNCTION(0x0001),
-		ISAPNP_VENDOR('@','X','@'), ISAPNP_FUNCTION(0x0001),
-		ISAPNP_VENDOR('@','H','@'), ISAPNP_FUNCTION(0x0001),
-		0,-1,0,0},
-	{"ALS100",
-		ISAPNP_VENDOR('A','L','S'), ISAPNP_DEVICE(0x0001), 
-		ISAPNP_VENDOR('@','@','@'), ISAPNP_FUNCTION(0x0001),
-		ISAPNP_VENDOR('@','X','@'), ISAPNP_FUNCTION(0x0001),
-		ISAPNP_VENDOR('@','H','@'), ISAPNP_FUNCTION(0x0001),
-		1,0,0,0},
-	{"ALS110",
-		ISAPNP_VENDOR('A','L','S'), ISAPNP_DEVICE(0x0110),
-		ISAPNP_VENDOR('@','@','@'), ISAPNP_FUNCTION(0x1001),
-		ISAPNP_VENDOR('@','X','@'), ISAPNP_FUNCTION(0x1001),
-		ISAPNP_VENDOR('@','H','@'), ISAPNP_FUNCTION(0x0001),
-		1,0,0,0},
-	{"ALS120",
-		ISAPNP_VENDOR('A','L','S'), ISAPNP_DEVICE(0x0120),
-		ISAPNP_VENDOR('@','@','@'), ISAPNP_FUNCTION(0x2001),
-		ISAPNP_VENDOR('@','X','@'), ISAPNP_FUNCTION(0x2001),
-		ISAPNP_VENDOR('@','H','@'), ISAPNP_FUNCTION(0x0001),
-		1,0,0,0},
-	{"ALS200",
-		ISAPNP_VENDOR('A','L','S'), ISAPNP_DEVICE(0x0200),
-		ISAPNP_VENDOR('@','@','@'), ISAPNP_FUNCTION(0x0020),
-		ISAPNP_VENDOR('@','X','@'), ISAPNP_FUNCTION(0x0020),
-		ISAPNP_VENDOR('@','H','@'), ISAPNP_FUNCTION(0x0001),
-		1,0,0,0},
-	{"RTL3000",
-		ISAPNP_VENDOR('R','T','L'), ISAPNP_DEVICE(0x3000),
-		ISAPNP_VENDOR('@','@','@'), ISAPNP_FUNCTION(0x2001),
-		ISAPNP_VENDOR('@','X','@'), ISAPNP_FUNCTION(0x2001),
-		ISAPNP_VENDOR('@','H','@'), ISAPNP_FUNCTION(0x0001),
-		1,0,0,0},
-	{0}
-};
-
-static struct isapnp_device_id id_table[] __devinitdata = {
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0024),
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0025),
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0026), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0027), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0028), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0029), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x002a),
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x002b), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x002c), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x002c), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00ed), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0041), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0086), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0041), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0086), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0041), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0051), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0001), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0070), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0001), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0080), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0041), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00F0), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0043), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0039), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0042), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0043), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0044),
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0045),
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0048), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x0054), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0031), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x009C), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0041), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x009F),
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0041), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x009D), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0042), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x009E), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0044), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00B2),
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0044), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00C1), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0042), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00C3), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0045), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00C5), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0045), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00C7), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0045), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00E4), 
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0045), 0 },
-
-	{	ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x00E9),
-		ISAPNP_VENDOR('C','T','L'), ISAPNP_FUNCTION(0x0045), 0 },
-
-	{	ISAPNP_VENDOR('E','S','S'), ISAPNP_DEVICE(0x0968), 
-		ISAPNP_VENDOR('E','S','S'), ISAPNP_FUNCTION(0x0968), 0 },
-
-	{	ISAPNP_VENDOR('E','S','S'), ISAPNP_DEVICE(0x1868), 
-		ISAPNP_VENDOR('E','S','S'), ISAPNP_FUNCTION(0x1868), 0 },
-
-	{	ISAPNP_VENDOR('E','S','S'), ISAPNP_DEVICE(0x1868), 
-		ISAPNP_VENDOR('E','S','S'), ISAPNP_FUNCTION(0x8611), 0 },
-
-	{	ISAPNP_VENDOR('E','S','S'), ISAPNP_DEVICE(0x0003), 
-		ISAPNP_VENDOR('E','S','S'), ISAPNP_FUNCTION(0x1869), 0 },
-
-	{	ISAPNP_VENDOR('E','S','S'), ISAPNP_DEVICE(0x1869), 
-		ISAPNP_VENDOR('E','S','S'), ISAPNP_FUNCTION(0x1869), 0 },
-
-	{	ISAPNP_VENDOR('E','S','S'), ISAPNP_DEVICE(0x1878), 
-		ISAPNP_VENDOR('E','S','S'), ISAPNP_FUNCTION(0x1878), 0 },
-
-	{	ISAPNP_VENDOR('E','S','S'), ISAPNP_DEVICE(0x1879), 
-		ISAPNP_VENDOR('E','S','S'), ISAPNP_FUNCTION(0x1879), 0 },
-
-	{	ISAPNP_VENDOR('C','M','I'), ISAPNP_DEVICE(0x0001), 
-		ISAPNP_VENDOR('@','X','@'), ISAPNP_FUNCTION(0x0001), 0 },
-
-	{	ISAPNP_VENDOR('C','M','I'), ISAPNP_DEVICE(0x0001), 
-		ISAPNP_VENDOR('@','H','@'), ISAPNP_FUNCTION(0x0001), 0 },
-
-	{	ISAPNP_VENDOR('C','M','I'), ISAPNP_DEVICE(0x0001), 
-		ISAPNP_VENDOR('@','@','@'), ISAPNP_FUNCTION(0x0001), 0 },
-
-	{	ISAPNP_VENDOR('R','W','B'), ISAPNP_DEVICE(0x1688), 
-		ISAPNP_VENDOR('@','@','@'), ISAPNP_FUNCTION(0x0001), 0 },
-
-	{	ISAPNP_VENDOR('R','W','B'), ISAPNP_DEVICE(0x1688), 
-		ISAPNP_VENDOR('@','X','@'), ISAPNP_FUNCTION(0x0001), 0 },
-
-	{	ISAPNP_VENDOR('R','W','B'), ISAPNP_DEVICE(0x1688), 
-		ISAPNP_VENDOR('@','H','@'), ISAPNP_FUNCTION(0x0001), 0 },
-
-	{	ISAPNP_VENDOR('A','L','S'), ISAPNP_DEVICE(0x0007),
-		ISAPNP_VENDOR('@','@','@'), ISAPNP_FUNCTION(0x0001), 0 },
-
-	{	ISAPNP_VENDOR('A','L','S'), ISAPNP_DEVICE(0x0007),
-		ISAPNP_VENDOR('@','X','@'), ISAPNP_FUNCTION(0x0001), 0 },
-
-	{	ISAPNP_VENDOR('A','L','S'), ISAPNP_DEVICE(0x0007),
-		ISAPNP_VENDOR('@','H','@'), ISAPNP_FUNCTION(0x0001), 0 },
-
-	{	ISAPNP_VENDOR('A','L','S'), ISAPNP_DEVICE(0x0001), 
-		ISAPNP_VENDOR('@','@','@'), ISAPNP_FUNCTION(0x0001), 0 },
-
-	{	ISAPNP_VENDOR('A','L','S'), ISAPNP_DEVICE(0x0001), 
-		ISAPNP_VENDOR('@','X','@'), ISAPNP_FUNCTION(0x0001), 0 },
-
-	{	ISAPNP_VENDOR('A','L','S'), ISAPNP_DEVICE(0x0001), 
-		ISAPNP_VENDOR('@','H','@'), ISAPNP_FUNCTION(0x0001), 0 },
-
-	{	ISAPNP_VENDOR('A','L','S'), ISAPNP_DEVICE(0x0110),
-		ISAPNP_VENDOR('@','@','@'), ISAPNP_FUNCTION(0x1001), 0 },
-
-	{	ISAPNP_VENDOR('A','L','S'), ISAPNP_DEVICE(0x0110),
-		ISAPNP_VENDOR('@','X','@'), ISAPNP_FUNCTION(0x1001), 0 },
-
-	{	ISAPNP_VENDOR('A','L','S'), ISAPNP_DEVICE(0x0110),
-		ISAPNP_VENDOR('@','H','@'), ISAPNP_FUNCTION(0x0001), 0 },
-
-	{	ISAPNP_VENDOR('A','L','S'), ISAPNP_DEVICE(0x0120),
-		ISAPNP_VENDOR('@','@','@'), ISAPNP_FUNCTION(0x2001), 0 },
-
-	{	ISAPNP_VENDOR('A','L','S'), ISAPNP_DEVICE(0x0120),
-		ISAPNP_VENDOR('@','X','@'), ISAPNP_FUNCTION(0x2001), 0 },
-
-	{	ISAPNP_VENDOR('A','L','S'), ISAPNP_DEVICE(0x0120),
-		ISAPNP_VENDOR('@','H','@'), ISAPNP_FUNCTION(0x0001), 0 },
-
-	{	ISAPNP_VENDOR('A','L','S'), ISAPNP_DEVICE(0x0200),
-		ISAPNP_VENDOR('@','@','@'), ISAPNP_FUNCTION(0x0020), 0 },
-
-	{	ISAPNP_VENDOR('A','L','S'), ISAPNP_DEVICE(0x0200),
-		ISAPNP_VENDOR('@','X','@'), ISAPNP_FUNCTION(0x0020), 0 },
-
-	{	ISAPNP_VENDOR('A','L','S'), ISAPNP_DEVICE(0x0200),
-		ISAPNP_VENDOR('@','H','@'), ISAPNP_FUNCTION(0x0001), 0 },
-
-	{	ISAPNP_VENDOR('R','T','L'), ISAPNP_DEVICE(0x3000),
-		ISAPNP_VENDOR('@','@','@'), ISAPNP_FUNCTION(0x2001), 0 },
+/* Register legacy card with OSS subsystem */
+static int sb_init_legacy(void)
+{
+	struct sb_module_options sbmo = {0};
 
-	{	ISAPNP_VENDOR('R','T','L'), ISAPNP_DEVICE(0x3000),
-		ISAPNP_VENDOR('@','X','@'), ISAPNP_FUNCTION(0x2001), 0 },
+	if((legacy = kmalloc(sizeof(struct sb_card_config), GFP_KERNEL)) == NULL) {
+		printk(KERN_ERR "sb: Error: Could not allocate memory\n");
+		return -ENOMEM;
+	}
+	memset(legacy, 0, sizeof(struct sb_card_config));
+
+	legacy->conf.io_base      = io;
+	legacy->conf.irq          = irq;
+	legacy->conf.dma          = dma;
+	legacy->conf.dma2         = dma16;
+	legacy->conf.card_subtype = type;
+
+	legacy->mpucnf.io_base = mpu_io;
+	legacy->mpucnf.irq     = -1;
+	legacy->mpucnf.dma     = -1;
+	legacy->mpucnf.dma2    = -1;
+
+	sbmo.esstype  = esstype;
+	sbmo.sm_games = sm_games;
+	sbmo.acer     = acer;
 
-	{	ISAPNP_VENDOR('R','T','L'), ISAPNP_DEVICE(0x3000),
-		ISAPNP_VENDOR('@','H','@'), ISAPNP_FUNCTION(0x0001), 0 },
-	{0}
-};
+	return sb_register_oss(legacy, &sbmo);
+}
 
-MODULE_DEVICE_TABLE(isapnp, id_table);
+#ifdef CONFIG_PNP_CARD
 
-static struct pci_dev *activate_dev(char *devname, char *resname, struct pci_dev *dev)
+/* Populate the OSS subsystem structures with information from PnP */
+static void sb_dev2cfg(struct pnp_dev *dev, struct sb_card_config *scc)
 {
-	int err;
-
-	/* Device already active? Let's use it */
-	if(dev->active)
-		return(dev);
-	
-	if((err = dev->activate(dev)) < 0) {
-		printk(KERN_ERR "sb: %s %s config failed (out of resources?)[%d]\n", devname, resname, err);
-
-		dev->deactivate(dev);
-
-		return(NULL);
+	scc->conf.io_base   = -1;
+	scc->conf.irq       = -1;
+	scc->conf.dma       = -1;
+	scc->conf.dma2      = -1;
+	scc->mpucnf.io_base = -1;
+	scc->mpucnf.irq     = -1;
+	scc->mpucnf.dma     = -1;
+	scc->mpucnf.dma2    = -1;
+
+	/* All clones layout their PnP tables differently and some use
+	   different logical devices for the MPU */
+	if(!strncmp("CTL",scc->card_id,3)) {
+		scc->conf.io_base   = pnp_port_start(dev,0);
+		scc->conf.irq       = pnp_irq(dev,0);
+		scc->conf.dma       = pnp_dma(dev,0);
+		scc->conf.dma2      = pnp_dma(dev,1);
+		scc->mpucnf.io_base = pnp_port_start(dev,1);
+		return;
+	}
+	if(!strncmp("ESS",scc->card_id,3)) {
+		scc->conf.io_base   = pnp_port_start(dev,0);
+		scc->conf.irq       = pnp_irq(dev,0);
+		scc->conf.dma       = pnp_dma(dev,0);
+		scc->conf.dma2      = pnp_dma(dev,1);
+	       	scc->mpucnf.io_base = pnp_port_start(dev,2);
+		return;
+	}
+	if(!strncmp("CMI",scc->card_id,3)) {
+		scc->conf.io_base = pnp_port_start(dev,0);
+		scc->conf.irq     = pnp_irq(dev,0);
+		scc->conf.dma     = pnp_dma(dev,0);
+		scc->conf.dma2    = pnp_dma(dev,1);
+		return;
+	}
+	if(!strncmp("RWB",scc->card_id,3)) {
+		scc->conf.io_base = pnp_port_start(dev,0);
+		scc->conf.irq     = pnp_irq(dev,0);
+		scc->conf.dma     = pnp_dma(dev,0);
+		return;
+	}
+	if(!strncmp("ALS",scc->card_id,3)) {
+		if(!strncmp("ALS0007",scc->card_id,7)) {
+			scc->conf.io_base = pnp_port_start(dev,0);
+			scc->conf.irq     = pnp_irq(dev,0);
+			scc->conf.dma     = pnp_dma(dev,0);
+		} else {
+			scc->conf.io_base = pnp_port_start(dev,0);
+			scc->conf.irq     = pnp_irq(dev,0);
+			scc->conf.dma     = pnp_dma(dev,1);
+			scc->conf.dma2    = pnp_dma(dev,0);
+		}
+		return;
+	}
+	if(!strncmp("RTL",scc->card_id,3)) {
+		scc->conf.io_base = pnp_port_start(dev,0);
+		scc->conf.irq     = pnp_irq(dev,0);
+		scc->conf.dma     = pnp_dma(dev,1);
+		scc->conf.dma2    = pnp_dma(dev,0);
 	}
-	return(dev);
 }
 
-static struct pci_dev *sb_init(struct pci_bus *bus, struct address_info *hw_config, struct address_info *mpu_config, int slot, int card)
+/* Probe callback function for the PnP API */
+static int sb_pnp_probe(struct pnp_card *card, const struct pnp_card_id *card_id)
 {
-
-	/* Configure Audio device */
-	if((sb_dev[card] = isapnp_find_dev(bus, sb_isapnp_list[slot].audio_vendor, sb_isapnp_list[slot].audio_function, NULL)))
-	{
-		int ret;
-		ret = sb_dev[card]->prepare(sb_dev[card]);
-		/* If device is active, assume configured with /proc/isapnp
-		 * and use anyway. Some other way to check this? */
-		if(ret && ret != -EBUSY) {
-			printk(KERN_ERR "sb: ISAPnP found device that could not be autoconfigured.\n");
-			return(NULL);
-		}
-		if(ret == -EBUSY)
-			audio_activated[card] = 1;
-		
-		if((sb_dev[card] = activate_dev(sb_isapnp_list[slot].name, "sb", sb_dev[card])))
-		{
-			hw_config->io_base 	= sb_dev[card]->resource[0].start;
-			hw_config->irq 		= sb_dev[card]->irq_resource[0].start;
-			hw_config->dma 		= sb_dev[card]->dma_resource[sb_isapnp_list[slot].dma].start;
-			if(sb_isapnp_list[slot].dma2 != -1)
-				hw_config->dma2 = sb_dev[card]->dma_resource[sb_isapnp_list[slot].dma2].start;
-			else
-				hw_config->dma2 = -1;
-		} else
-			return(NULL);
-	} else
-		return(NULL);
-
-	/* Cards with separate OPL3 device (ALS, CMI, etc.)
-	 * This is just to activate the device so the OPL module can use it */
-	if(sb_isapnp_list[slot].opl_vendor || sb_isapnp_list[slot].opl_function) {
-		if((opl_dev[card] = isapnp_find_dev(bus, sb_isapnp_list[slot].opl_vendor, sb_isapnp_list[slot].opl_function, NULL))) {
-			int ret = opl_dev[card]->prepare(opl_dev[card]);
-			/* If device is active, assume configured with
-			 * /proc/isapnp and use anyway */
-			if(ret && ret != -EBUSY) {
-				printk(KERN_ERR "sb: OPL device could not be autoconfigured.\n");
-				return(sb_dev[card]);
-			}
-			if(ret == -EBUSY)
-				opl_activated[card] = 1;
-
-			/* Some have irq and dma for opl. the opl3 driver wont
-			 * use 'em so don't configure 'em and hope it works -PEL */
-			opl_dev[card]->irq_resource[0].flags = 0;
-			opl_dev[card]->dma_resource[0].flags = 0;
-
-			opl_dev[card] = activate_dev(sb_isapnp_list[slot].name, "opl3", opl_dev[card]);
-		} else
-			printk(KERN_ERR "sb: %s isapnp panic: opl3 device not found\n", sb_isapnp_list[slot].name);
+	struct sb_card_config *scc;
+	struct sb_module_options sbmo = {0}; /* Default to 0 for PnP */
+	struct pnp_dev *dev = pnp_request_card_device(card, card_id->devs[0].id, NULL);
+	
+	if(!dev){
+		return -EBUSY;
 	}
 
-	/* Cards with MPU as part of Audio device (CTL and ESS) */
-	if(!sb_isapnp_list[slot].mpu_vendor) {
-		mpu_config->io_base	= sb_dev[card]->resource[sb_isapnp_list[slot].mpu_io].start;
-		return(sb_dev[card]);
-	}
-	
-	/* Cards with separate MPU device (ALS, CMI, etc.) */
-	if(!uart401)
-		return(sb_dev[card]);
-	if((mpu_dev[card] = isapnp_find_dev(bus, sb_isapnp_list[slot].mpu_vendor, sb_isapnp_list[slot].mpu_function, NULL)))
-	{
-		int ret = mpu_dev[card]->prepare(mpu_dev[card]);
-		/* If device is active, assume configured with /proc/isapnp
-		 * and use anyway */
-		if(ret && ret != -EBUSY) {
-			printk(KERN_ERR "sb: MPU device could not be autoconfigured.\n");
-			return(sb_dev[card]);
-		}
-		if(ret == -EBUSY)
-			mpu_activated[card] = 1;
-		
-		/* Some cards ask for irq but don't need them - azummo */
-		if(sb_isapnp_list[slot].mpu_irq == -1)
-			mpu_dev[card]->irq_resource[0].flags = 0;
-		
-		if((mpu_dev[card] = activate_dev(sb_isapnp_list[slot].name, "mpu", mpu_dev[card]))) {
-			mpu_config->io_base = mpu_dev[card]->resource[sb_isapnp_list[slot].mpu_io].start;
-			if(sb_isapnp_list[slot].mpu_irq != -1)
-				mpu_config->irq = mpu_dev[card]->irq_resource[sb_isapnp_list[slot].mpu_irq].start;
-		}
+	if((scc = kmalloc(sizeof(struct sb_card_config), GFP_KERNEL)) == NULL) {
+		printk(KERN_ERR "sb: Error: Could not allocate memory\n");
+		return -ENOMEM;
 	}
-	else
-		printk(KERN_ERR "sb: %s isapnp panic: mpu not found\n", sb_isapnp_list[slot].name);
-	
-	return(sb_dev[card]);
-}
+	memset(scc, 0, sizeof(struct sb_card_config));
 
-static int __init sb_isapnp_init(struct address_info *hw_config, struct address_info *mpu_config, struct pci_bus *bus, int slot, int card)
-{
-	char *busname = bus->name[0] ? bus->name : sb_isapnp_list[slot].name;
+	printk(KERN_INFO "sb: PnP: Found Card Named = \"%s\", Card PnP id = " \
+	       "%s, Device PnP id = %s\n", dev->dev.name, card_id->id,
+	       dev->id->id);
 
-	printk(KERN_INFO "sb: %s detected\n", busname); 
+	scc->card_id = card_id->id;
+	scc->dev_id = dev->id->id;
+	sb_dev2cfg(dev, scc);
 
-	/* Initialize this baby. */
+	printk(KERN_INFO "sb: PnP:      Detected at: io=0x%x, irq=%d, " \
+	       "dma=%d, dma16=%d\n", scc->conf.io_base, scc->conf.irq,
+	       scc->conf.dma, scc->conf.dma2);
 
-	if(sb_init(bus, hw_config, mpu_config, slot, card)) {
-		/* We got it. */
-		
-		printk(KERN_NOTICE "sb: ISAPnP reports '%s' at i/o %#x, irq %d, dma %d, %d\n",
-		       busname,
-		       hw_config->io_base, hw_config->irq, hw_config->dma,
-		       hw_config->dma2);
-		return 1;
-	}
-	else
-		printk(KERN_INFO "sb: Failed to initialize %s\n", busname);
+	pnpc_set_drvdata(card, scc);
 
-	return 0;
+	return sb_register_oss(scc, &sbmo);
 }
 
-static int __init sb_isapnp_probe(struct address_info *hw_config, struct address_info *mpu_config, int card)
+static void sb_pnp_remove(struct pnp_card *card)
 {
-	static int first = 1;
-	int i;
+	struct sb_card_config *scc = pnpc_get_drvdata(card);
 
-	/* Count entries in sb_isapnp_list */
-	for (i = 0; sb_isapnp_list[i].card_vendor != 0; i++);
-	i--;
-
-	/* Check and adjust isapnpjump */
-	if( isapnpjump < 0 || isapnpjump > i) {
-		isapnpjump = reverse ? i : 0;
-		printk(KERN_ERR "sb: Valid range for isapnpjump is 0-%d. Adjusted to %d.\n", i, isapnpjump);
-	}
+	if(!scc)
+		return;
 
-	if(!first || !reverse)
-		i = isapnpjump;
-	first = 0;
-	while(sb_isapnp_list[i].card_vendor != 0) {
-		static struct pci_bus *bus = NULL;
-
-		while ((bus = isapnp_find_card(
-				sb_isapnp_list[i].card_vendor,
-				sb_isapnp_list[i].card_device,
-				bus))) {
-	
-			if(sb_isapnp_init(hw_config, mpu_config, bus, i, card)) {
-				isapnpjump = i; /* start next search from here */
-				return 0;
-			}
-		}
-		i += reverse ? -1 : 1;
-	}
+	printk(KERN_INFO "sb: PnP: Removing %s\n", scc->card_id);
 
-	return -ENODEV;
+	sb_unload(scc);
 }
-#endif
 
-static int __init init_sb(void)
+static struct pnpc_driver sb_pnp_driver = {
+	.name          = "OSS SndBlstr", /* 16 character limit */
+	.id_table      = sb_pnp_card_table,
+	.probe         = sb_pnp_probe,
+	.remove        = sb_pnp_remove,
+};
+#endif /* CONFIG_PNP_CARD */
+
+static int __init sb_init(void)
 {
-	int card, max = (multiple && isapnp) ? SB_CARDS_MAX : 1;
+	int lres = 0;
+	int pres = 0;
 
-	printk(KERN_INFO "Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996\n");
-	
-	for(card = 0; card < max; card++, sb_cards_num++) {
-#ifdef __ISAPNP__
-		/* Please remember that even with __ISAPNP__ defined one
-		 * should still be able to disable PNP support for this 
-		 * single driver! */
-		if((!pnplegacy||card>0) && isapnp && (sb_isapnp_probe(&cfg[card], &cfg_mpu[card], card) < 0) ) {
-			if(!sb_cards_num) {
-				/* Found no ISAPnP cards, so check for a non-pnp
-				 * card and set the detection loop for 1 cycle
-				 */
-				printk(KERN_NOTICE "sb: No ISAPnP cards found, trying standard ones...\n");
-				isapnp = 0;
-				max = 1;
-			} else
-				/* found all the ISAPnP cards so exit the
-				 * detection loop. */
-				break;
-		}
-#endif
+	printk(KERN_INFO "sb: Init: Starting Probe...\n");
 
-		if(!isapnp || (pnplegacy&&card==0)) {
-			cfg[card].io_base	= io;
-			cfg[card].irq		= irq;
-			cfg[card].dma		= dma;
-			cfg[card].dma2		= dma16;
-		}
+	if(io != -1 && irq != -1 && dma != -1) {
+		printk(KERN_INFO "sb: Probing legacy card with io=%x, "\
+		       "irq=%d, dma=%d, dma16=%d\n",io, irq, dma, dma16);
+		lres = sb_init_legacy();
+	} else if((io != -1 || irq != -1 || dma != -1) ||
+		  (!pnp && (io == -1 && irq == -1 && dma == -1)))
+		printk(KERN_ERR "sb: Error: At least io, irq, and dma "\
+		       "must be set for legacy cards.\n");
+
+#ifdef CONFIG_PNP_CARD
+	if(pnp) {
+		pres = pnpc_register_driver(&sb_pnp_driver);
+	}
+#endif
+	printk(KERN_INFO "sb: Init: Done\n");
 
-		cfg[card].card_subtype = type;
+	/* If either PnP or Legacy registered a card then return
+	 * success */
+	return (pres > 0 || lres > 0) ? 0 : -ENODEV;
+}
 
-		if (!probe_sb(&cfg[card])) {
-			/* if one or more cards already registered, don't
-			 * return an error but print a warning. Note, this
-			 * should never really happen unless the hardware
-			 * or ISAPnP screwed up. */
-			if (sb_cards_num) {
-				printk(KERN_WARNING "sb.c: There was a " \
-				  "problem probing one of your SoundBlaster " \
-				  "ISAPnP soundcards. Continuing.\n");
-				card--;
-				sb_cards_num--;
-				continue;
-			} else if(pnplegacy && isapnp) {
-				printk(KERN_NOTICE "sb: No legacy SoundBlaster cards " \
-				  "found.  Continuing with PnP detection.\n");
-				pnplegacy=0;
-				card--;
-				continue;
-			} else
-				return -ENODEV;
-		}
-		attach_sb_card(&cfg[card]);
+static void __exit sb_exit(void)
+{
+	printk(KERN_INFO "sb: Unloading...\n");
 
-		if(cfg[card].slots[0]==-1) {
-			if(card==0 && pnplegacy && isapnp) {
-				printk(KERN_NOTICE "sb: No legacy SoundBlaster cards " \
-				  "found.  Continuing with PnP detection.\n");
-				pnplegacy=0;
-				card--;
-				continue;
-			} else
-				return -ENODEV;
-		}
-		
-		if (!isapnp||(pnplegacy&&card==0))
-			cfg_mpu[card].io_base = mpu_io;
-		if (probe_sbmpu(&cfg_mpu[card], THIS_MODULE))
-			sbmpu[card] = 1;
+	/* Unload legacy card */
+	if (legacy) {
+		printk (KERN_INFO "sb: Unloading legacy card\n");
+		sb_unload(legacy);
 	}
 
-	if(isapnp)
-		printk(KERN_NOTICE "sb: %d Soundblaster PnP card(s) found.\n", sb_cards_num);
-
-	return 0;
-}
+#ifdef CONFIG_PNP_CARD
+	pnpc_unregister_driver(&sb_pnp_driver);
+#endif
 
-static void __exit cleanup_sb(void)
-{
-	int i;
-	
 	if (smw_free) {
 		vfree(smw_free);
 		smw_free = NULL;
 	}
-
-	for(i = 0; i < sb_cards_num; i++) {
-		unload_sb(&cfg[i], i);
-		if (sbmpu[i])
-			unload_sbmpu(&cfg_mpu[i]);
-
-#ifdef __ISAPNP__
-		if(!audio_activated[i] && sb_dev[i])
-			sb_dev[i]->deactivate(sb_dev[i]);
-		if(!mpu_activated[i] && mpu_dev[i])
-			mpu_dev[i]->deactivate(mpu_dev[i]);
-		if(!opl_activated[i] && opl_dev[i])
-			opl_dev[i]->deactivate(opl_dev[i]);
-#endif
-	}
 }
 
-module_init(init_sb);
-module_exit(cleanup_sb);
-
-#ifndef MODULE
-static int __init setup_sb(char *str)
-{
-	/* io, irq, dma, dma2 - just the basics */
-	int ints[5];
-	
-	str = get_options(str, ARRAY_SIZE(ints), ints);
-	
-	io	= ints[1];
-	irq	= ints[2];
-	dma	= ints[3];
-	dma16	= ints[4];
-
-	return 1;
-}
-__setup("sb=", setup_sb);
-#endif
+module_init(sb_init);
+module_exit(sb_exit);
diff -Nrup linux-2.5.61-vanilla/sound/oss/sb_card.h linux-2.5.61-sbpnp/sound/oss/sb_card.h
--- linux-2.5.61-vanilla/sound/oss/sb_card.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.5.61-sbpnp/sound/oss/sb_card.h	2003-02-16 01:01:37.000000000 -0500
@@ -0,0 +1,147 @@
+/*
+ * sound/oss/sb_card.h
+ *
+ * This file is distributed under the GNU GENERAL PUBLIC LICENSE (GPL)
+ * Version 2 (June 1991). See the "COPYING" file distributed with this
+ * software for more info.
+ *
+ * 02-05-2002 Original Release, Paul Laufer <paul@laufernet.com>
+ */
+
+struct sb_card_config {
+	struct address_info conf;
+	struct address_info mpucnf;
+	const  char         *card_id;
+	const  char         *dev_id;
+	int                 mpu;
+};
+
+#ifdef CONFIG_PNP_CARD
+
+/*
+ * SoundBlaster PnP tables and structures.
+ */
+
+/* Card PnP ID Table */
+static struct pnp_card_id sb_pnp_card_table[] = {
+	/* Sound Blaster 16 */
+	{.id = "CTL0024", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	/* Sound Blaster 16 */
+	{.id = "CTL0025", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	/* Sound Blaster 16 */
+	{.id = "CTL0026", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	/* Sound Blaster 16 */
+	{.id = "CTL0027", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	/* Sound Blaster 16 */
+	{.id = "CTL0028", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	/* Sound Blaster 16 */
+	{.id = "CTL0029", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	/* Sound Blaster 16 */
+	{.id = "CTL002a", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	/* Sound Blaster 16 */
+	{.id = "CTL002b", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	/* Sound Blaster 16 */
+	{.id = "CTL002c", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	/* Sound Blaster 16 */
+	{.id = "CTL00ed", .driver_data = 0, devs : { {.id="CTL0041"}, } },
+	/* Sound Blaster 16 */
+	{.id = "CTL0086", .driver_data = 0, devs : { {.id="CTL0041"}, } },
+	/* Sound Blaster Vibra16S */
+	{.id = "CTL0051", .driver_data = 0, devs : { {.id="CTL0001"}, } },
+	/* Sound Blaster Vibra16C */
+	{.id = "CTL0070", .driver_data = 0, devs : { {.id="CTL0001"}, } },
+	/* Sound Blaster Vibra16CL */
+	{.id = "CTL0080", .driver_data = 0, devs : { {.id="CTL0041"}, } },
+	/* Sound Blaster Vibra16CL */
+	{.id = "CTL00F0", .driver_data = 0, devs : { {.id="CTL0043"}, } },
+	/* Sound Blaster AWE 32 */
+	{.id = "CTL0039", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	/* Sound Blaster AWE 32 */
+	{.id = "CTL0042", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	/* Sound Blaster AWE 32 */
+	{.id = "CTL0043", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	/* Sound Blaster AWE 32 */
+	{.id = "CTL0044", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	/* Sound Blaster AWE 32 */
+	{.id = "CTL0045", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	/* Sound Blaster AWE 32 */
+	{.id = "CTL0046", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	/* Sound Blaster AWE 32 */
+	{.id = "CTL0047", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	/* Sound Blaster AWE 32 */
+	{.id = "CTL0048", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	/* Sound Blaster AWE 32 */
+	{.id = "CTL0054", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+	/* Sound Blaster AWE 32 */
+	{.id = "CTL009C", .driver_data = 0, devs : { {.id="CTL0041"}, } },
+	/* Createive SB32 PnP */
+	{.id = "CTL009F", .driver_data = 0, devs : { {.id="CTL0041"}, } },
+	/* Sound Blaster AWE 64 */
+	{.id = "CTL009D", .driver_data = 0, devs : { {.id="CTL0042"}, } },
+	/* Sound Blaster AWE 64 Gold */
+	{.id = "CTL009E", .driver_data = 0, devs : { {.id="CTL0044"}, } },
+	/* Sound Blaster AWE 64 Gold */
+	{.id = "CTL00B2", .driver_data = 0, devs : { {.id="CTL0044"}, } },
+	/* Sound Blaster AWE 64 */
+	{.id = "CTL00C1", .driver_data = 0, devs : { {.id="CTL0042"}, } },
+	/* Sound Blaster AWE 64 */
+	{.id = "CTL00C3", .driver_data = 0, devs : { {.id="CTL0045"}, } },
+	/* Sound Blaster AWE 64 */
+	{.id = "CTL00C5", .driver_data = 0, devs : { {.id="CTL0045"}, } },
+	/* Sound Blaster AWE 64 */
+	{.id = "CTL00C7", .driver_data = 0, devs : { {.id="CTL0045"}, } },
+	/* Sound Blaster AWE 64 */
+	{.id = "CTL00E4", .driver_data = 0, devs : { {.id="CTL0045"}, } },
+	/* Sound Blaster AWE 64 */
+	{.id = "CTL00E9", .driver_data = 0, devs : { {.id="CTL0045"}, } },
+	/* ESS 1868 */
+	{.id = "ESS0968", .driver_data = 0, devs : { {.id="ESS0968"}, } },
+	/* ESS 1868 */
+	{.id = "ESS1868", .driver_data = 0, devs : { {.id="ESS1868"}, } },
+	/* ESS 1868 */
+	{.id = "ESS1868", .driver_data = 0, devs : { {.id="ESS8611"}, } },
+	/* ESS 1869 PnP AudioDrive */
+	{.id = "ESS0003", .driver_data = 0, devs : { {.id="ESS1869"}, } },
+	/* ESS 1869 */
+	{.id = "ESS1869", .driver_data = 0, devs : { {.id="ESS1869"}, } },
+	/* ESS 1878 */
+	{.id = "ESS1878", .driver_data = 0, devs : { {.id="ESS1878"}, } },
+	/* ESS 1879 */
+	{.id = "ESS1879", .driver_data = 0, devs : { {.id="ESS1879"}, } },
+	/* CMI 8330 SoundPRO */
+	{.id = "CMI0001", .driver_data = 0, devs : { {.id="@X@0001"},
+						     {.id="@H@0001"},
+						     {.id="@@@0001"}, } },
+	/* Diamond DT0197H */
+	{.id = "RWR1688", .driver_data = 0, devs : { {.id="@@@0001"},
+						     {.id="@X@0001"},
+						     {.id="@H@0001"}, } },
+	/* ALS007 */
+	{.id = "ALS0007", .driver_data = 0, devs : { {.id="@@@0001"},
+						     {.id="@X@0001"},
+						     {.id="@H@0001"}, } },
+	/* ALS100 */
+	{.id = "ALS0001", .driver_data = 0, devs : { {.id="@@@0001"},
+						     {.id="@X@0001"},
+						     {.id="@H@0001"}, } },
+	/* ALS110 */
+	{.id = "ALS0110", .driver_data = 0, devs : { {.id="@@@1001"},
+						     {.id="@X@1001"},
+						     {.id="@H@0001"}, } },
+	/* ALS120 */
+	{.id = "ALS0120", .driver_data = 0, devs : { {.id="@@@2001"},
+						     {.id="@X@2001"},
+						     {.id="@H@0001"}, } },
+	/* ALS200 */
+	{.id = "ALS0200", .driver_data = 0, devs : { {.id="@@@0020"},
+						     {.id="@X@0030"},
+						     {.id="@H@0001"}, } },
+	/* ALS200 */
+	{.id = "RTL3000", .driver_data = 0, devs : { {.id="@@@2001"},
+						     {.id="@X@2001"},
+						     {.id="@H@0001"}, } },
+	/* -end- */
+	{.id = "", }
+};
+
+#endif
