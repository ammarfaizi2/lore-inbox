Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274964AbTHGACH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 20:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272637AbTHGACH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 20:02:07 -0400
Received: from tpa4.isomedia.com ([207.115.64.115]:22698 "EHLO
	tpa4.isomedia.com") by vger.kernel.org with ESMTP id S274964AbTHGABu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 20:01:50 -0400
From: "Jonathan Campbell" <jmc@tocatta.com>
To: <linux-kernel@vger.kernel.org>
Cc: <alan@redhat.com>, <torvalds@transmeta.com>
Subject: Patch for 2.4.21 kernels to allow Reveal SC400 sound cards to function
Date: Wed, 6 Aug 2003 17:01:48 -0700
Message-ID: <000001c35c77$19565de0$6101a8c0@area51>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2727.1300
X-MailScanner-SpamCheck: LEVEL= 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. This is a patch (more of a hack, really) that allows you to use a
Reveal SC400 sound card using the sb.o driver. The SC400 emulates a SB16
but a) needs a proprietary PnP protocol to tell it DMA and IRQ settings
and b) has an SBPRO mixer chip. It also has something like a Windows
Sound System interface at 0x534 but it doesn't seem to work like one (so
this patch doesn't use it).

The PnP protocol is very simple. The card maintains a "configuration
byte" that is initially set to 0x00 on h/w reset. This byte can be
accessed by sending DSP command 0x58 then reading three bytes. All SC400
cards (at least mine) return the sequence 0x2E 0xC3 [cfg-byte].

CFG-BYTE:    bit 7 6 5 4 3 2 1 0
                 | | | | | | | +----------|__________
                 | | | | | | +------------|__________ DMA select (bits
0-1)
                 | | | | | +------------------------- (don't know)
                 | | | | +----------------|__________
                 | | | +------------------|__________
                 | | +--------------------|__________ IRQ select (bits
3-5)
                 | +--------------------------------- (don't know)
                 +----------------------------------- (don't know)

DMA select can be one of four values:
0: No DMA
1: DMA channel 0
2: DMA channel 1
3: DMA channel 3

IRQ select can be one of eight values:
0: No IRQ
1: IRQ 7
2: IRQ 9
3: IRQ 10
4: IRQ 11
5: IRQ 5
6: No IRQ
7: No IRQ

To set IRQ 5, DMA 1, change the byte to 0x2A = (5<<3)+2.
The byte can be written by sending DSP commands 0x50, [cfg-byte], 0xF2,
0x50, [cfg-byte], 0xE6. At least this is the sequence used by their
TESTSC.EXE DOS utility. The configuration takes effect on DSP software
reset.

This patch was made from the full release of the 2.4.21 kernel.

-------------------------

--- sb.h	2003-08-06 00:55:28.000000000 -0700
+++ sb.old.h	2003-08-06 00:52:26.000000000 -0700
@@ -46,7 +46,6 @@
 #define MDL_ESSPCI	16	/* ESS PCI card */
 #define MDL_YMPCI	17	/* Yamaha PCI sb in emulation */
 
-#define SUBMDL_REVEALSC400 41	/* SC400 needs custom PnP config and
mixer functions like SBPRO */
 #define SUBMDL_ALS007	42	/* ALS-007 differs from SB16 only in
mixer */
 				/* register assignment */
 #define SUBMDL_ALS100	43	/* ALS-100 allows sampling rates of up
*/




--- sb_common.c	2003-08-06 15:59:08.000000000 -0700
+++ sb_common.old.c	2003-08-06 00:34:18.000000000 -0700
@@ -24,27 +24,6 @@
  *
  * 2001/01/26 - replaced CLI/STI with spinlocks
  * Chris Rankin <rankinc@zipworld.com.au>
- *
- * 2003/08/06 - Added code to detect and initialize Reveal SC400 cards.
- *              The SC400 emulates a SB16 but it needs a proprietary
- *              PnP protocol of it's own to tell the card what DMA and
IRQ
- *              resources to use.
- *
- *              The sequence used here is the exact same sequence used
by
- *              their TESTSC.EXE DOS utility.
- *
- *              FIXME: The SC400 also has a WSS interface who's base
address
- *                     is controlled by the configuration that's done
here.
- *                     I don't know which bit controls this though...
only
- *                     their Windows device drivers use it. I haven't
had
- *                     much luck getting it to work though.
- *              FIXME: The SC400 has a mixer that functions like an
SBPRO.
- *                     There are some magic registers in there that
allow
- *                     for other things like controlling the input gain
- *                     or enabling/disabling hardware AGC but I don't
know
- *                     which ones those are. It is mixer-register
incompatible
- *                     with the SB16.
- * Jonathan Campbell <jcampbell@mdjk.com>
  */
 
 #include <linux/config.h>
@@ -79,36 +58,6 @@
 	0, 1, 0, 2, 0, 3, 0, 4
 };
 
-/* conversion table from 3-bit value in configuration reg. */
-/* THIS IS FOR REFERENCE ONLY */
-/*
-static int reveal_sc400_map_to_IRQ[8] = {
-	-1, 7, 9, 10, 11, 5, -1, -1
-};
-*/
-
-/* conversion table from IRQ to 3-bit value */
-static int reveal_sc400_IRQ_to_map[16] = {
-	-1, -1, -1, -1,		/*  0- 3 */
-	-1,  5, -1,  1,		/*  4- 7 */
-	-1,  2,  3,  4,         /*  8-11 */
-	-1, -1, -1, -1,		/* 12-15 */
-};
-
-/* conversion table from 2-bit value in configuration reg. */
-/* THIS IS FOR REFERENCE ONLY */
-/*
-static int reveal_sc400_map_to_DMA[4] = {
-	-1, 0, 1, 3
-};
-*/
-
-/* conversion table from DMA to 2-bit value */
-static int reveal_sc400_DMA_to_map[8] = {
-	 1,  2, -1,  3,	/* 0-3 */
-	-1, -1, -1, -1,	/* 4-7 */
-};
-
 void *smw_free;
 
 /*
@@ -639,59 +588,6 @@
 	if (devc->major == 0 && (devc->type == MDL_ESS || devc->type ==
0))
 		relocate_ess1688(devc);
 
-        /* Detect and configure Reveal SC400 cards here. */
-        if (    devc->major == 3 && devc->minor == 1 &&
-                devc->irq >= 0 && devc->dma8 >= 0) {
-
-                int c[3],fb,f1,f2;
-
-/* send SC400 "get configuration byte" command */
-                if (sb_dsp_command(devc,0x58)) {
-/* read first byte */
-                        c[0] = sb_dsp_get_byte(devc);
-/* throw away extra 0xAA ack from DSP reset, if it happens (which it
does...) */
-                        if (c[0] == 0xAA) c[0] = sb_dsp_get_byte(devc);
-
-/* SC400 cards return 0x2E as first byte */
-                        if (c[0] == 0x2E) {
-/* the next two bytes carry info. we need the second one, which
contains the card's current
-   configuration. the configuration byte is always set to 0x00 on
hardware reset. */
-                                c[1] = sb_dsp_get_byte(devc);
-                                c[2] = sb_dsp_get_byte(devc);
-                                if (c[1] >= 0 && c[2] >= 0) {
-                                        printk(KERN_INFO "Your card is
a Reveal SC400 SB16-compatible (%02X %02X %02X)\n",c[0],c[1],c[2]);
-					devc->model = MDL_SB16;
-					devc->submodel =
SUBMDL_REVEALSC400;
-					devc->dma16 = devc->dma8;
-
-/* now that we've done this, configure the card */
-                                        f1 =
reveal_sc400_IRQ_to_map[devc->irq];
-                                        f2 =
reveal_sc400_DMA_to_map[devc->dma8];
-                                        if (f1 < 0)
-                                                printk(KERN_ERR "SC400
can't use IRQ %d",devc->irq);                                        if
(f2 < 0)
-                                                printk(KERN_ERR "SC400
can't use DMA %d",devc->dma8);
-                                        if (f1 < 0 || f2 < 0)
-                                                return 0;
-
-                                        /* modify the byte to plug in
DMA and IRQ values */
-                                        fb = (f1<<3) | f2;
-                                        /* send configuration */
-                                        sb_dsp_command(devc,0x50);
-                                        sb_dsp_command(devc,fb);
-                                        sb_dsp_command(devc,0xF2);
-                                        /* send configuration again */
-                                        sb_dsp_command(devc,0x50);
-                                        sb_dsp_command(devc,fb);
-                                        sb_dsp_command(devc,0xE6);
-                                        /* configuration takes effect
on DSP reset */
-					sb_dsp_reset(devc);
-					inb(devc->base + 0x0E);
-					inb(devc->base + 0x0A);
-                                }
-                        }
-                }
-        }
-
 	if (!sb_dsp_reset(devc))
 	{
 		DDB(printk("SB reset failed\n"));
@@ -729,7 +625,7 @@
 		printk("YMPCI selected\n");
 		devc->model = MDL_YMPCI;
 	}
-
+		
 	/*
 	 * Save device information for sb_dsp_init()
 	 */




--- sb_mixer.c	2003-08-06 14:53:33.000000000 -0700
+++ sb_mixer.old.c	2003-08-06 03:08:19.000000000 -0700
@@ -14,7 +14,6 @@
  * Thomas Sailer				: ioctl code reworked
(vmalloc/vfree removed)
  * Rolf Fokkens (Dec 20 1998)	: Moved ESS stuff into sb_ess.[ch]
  * Stanislav Voronyi <stas@esc.kharkov.com>	: Support for AWE 3DSE
device (Jun 7 1999)
- * Jonathan Campbell <jcampbell@mdjk.com>       : Proper recognition of
mixer for Reveal SC400
  */
 
 #include "sound_config.h"
@@ -390,18 +389,12 @@
 
 static int set_recmask(sb_devc * devc, int mask)
 {
-	int devmask, i, model_treatment;
+	int devmask, i;
 	unsigned char  regimageL, regimageR;
 
 	devmask = mask & devc->supported_rec_devices;
 
-	model_treatment = devc->model;
-
-/* Reveal's SB16 has an SBPRO style mixer */
-	if (devc->model == MDL_SB16 && devc->submodel ==
SUBMDL_REVEALSC400)
-		model_treatment = MDL_SBPRO;
-
-	switch (model_treatment)
+	switch (devc->model)
 	{
 		case MDL_SBPRO:
 		case MDL_ESS:
@@ -709,13 +702,7 @@
 			devc->mixer_caps = 0;
 			devc->supported_rec_devices =
SB16_RECORDING_DEVICES;
 			devc->supported_out_devices =
SB16_OUTFILTER_DEVICES;
-			if (devc->submodel == SUBMDL_REVEALSC400) {
-				devc->supported_devices =
SBPRO_MIXER_DEVICES;
-				devc->supported_rec_devices =
SBPRO_RECORDING_DEVICES;
-				devc->supported_out_devices = 0;
-				devc->iomap = &sbpro_mix;
-			}
-			else if (devc->submodel != SUBMDL_ALS007)
+			if (devc->submodel != SUBMDL_ALS007)
 			{
 				devc->supported_devices =
SB16_MIXER_DEVICES;
 				devc->iomap = &sb16_mix;


