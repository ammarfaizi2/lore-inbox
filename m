Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751930AbWFLMmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbWFLMmR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 08:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbWFLMmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 08:42:17 -0400
Received: from 36.53.5646.static.theplanet.com ([70.86.83.54]:25219 "EHLO
	zacbowling.com") by vger.kernel.org with ESMTP id S1751930AbWFLMmR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 08:42:17 -0400
Subject: [PATCH] saa7134 card (LifeView3000 NTSC)
From: Zac Bowling <zac@zacbowling.com>
Reply-To: zac@zacbowling.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 07:42:14 -0500
Message-Id: <1150116134.5538.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a patch to add detection for the LifeView3000 NTSC model (right
now the PAL version is the only one in there, which is sort of annoying
for me living in the US and all.. sigh...)

I wrote it on 2.15.x but it applies on 2.16.x cleanly, but I'm not sure
(nor am in a very well positioned place) to check it against head.
However the only probable difference unless someone rewrote this
entirely is that the ID I assigned for it in "saa7134.h" is already
added for something else, in which case it just needs to be incremented.
Its a fairly trivial patch (mostly a copy and paste from the PAL
version, but changing it to use NTSC instead). 

This is one of those things that I like to classify "as a works for me
so take it or leave it" :-) . Not that worried because its an $18 video
capture card that didn't look it was selling to well in the US, but then
again who knows.

The documentation needs updating too I bet but its behind anyways
usually to what is in the code.

Well there you go. Have fun. I'm back to working on the the Mono Project
to rid evil the world of evil Java. (just poking fun... no flamewars
please :-P )

Signed-off-by: Zac Bowling <zac@zacbowling.com>


diff -upr media.orig/video/saa7134/saa7134-cards.c
media/video/saa7134/saa7134-cards.c
--- media.orig/video/saa7134/saa7134-cards.c    2006-06-12
02:34:46.000000000 -0500
+++ media/video/saa7134/saa7134-cards.c 2006-06-12 02:44:12.000000000
-0500
@@ -2555,6 +2555,55 @@ struct saa7134_board saa7134_boards[] =
                        .amux   = LINE1,
                },
        },
+    [SAA7134_BOARD_FLYVIDEO3000_NTSC] = {
+               /* "Zac Bowling" <zac@zacbowling.com> */
+               .name           = "LifeView FlyVIDEO3000 (NTSC)",
+               .audio_clock    = 0x00200000,
+               .tuner_type     = TUNER_PHILIPS_NTSC,
+               .radio_type     = UNSET,
+               .tuner_addr     = ADDR_UNSET,
+               .radio_addr     = ADDR_UNSET,
+
+               .gpiomask       = 0xe000,
+               .inputs         = {{
+                       .name = name_tv,
+                       .vmux = 1,
+                       .amux = TV,
+                       .gpio = 0x8000,
+                       .tv   = 1,
+               },{
+                       .name = name_tv_mono,
+                       .vmux = 1,
+                       .amux = LINE2,
+                       .gpio = 0x0000,
+                       .tv   = 1,
+               },{
+                       .name = name_comp1,
+                       .vmux = 0,
+                       .amux = LINE2,
+                       .gpio = 0x4000,
+               },{
+                       .name = name_comp2,
+                       .vmux = 3,
+                       .amux = LINE2,
+                       .gpio = 0x4000,
+               },{
+                       .name = name_svideo,
+                       .vmux = 8,
+                       .amux = LINE2,
+                       .gpio = 0x4000,
+               }},
+               .radio = {
+                       .name = name_radio,
+                       .amux = LINE2,
+                       .gpio = 0x2000,
+               },
+               .mute = {
+                       .name = name_mute,
+                       .amux = TV,
+                       .gpio = 0x8000,
+               },
+       },
 };

 const unsigned int saa7134_bcount = ARRAY_SIZE(saa7134_boards);
@@ -2614,6 +2663,12 @@ struct pci_device_id saa7134_pci_tbl[] =
        },{
                .vendor       = PCI_VENDOR_ID_PHILIPS,
                .device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+               .subvendor    = 0x5169,
+               .subdevice    = 0x0138,
+               .driver_data  = SAA7134_BOARD_FLYVIDEO3000_NTSC,
+       },{
+               .vendor       = PCI_VENDOR_ID_PHILIPS,
+               .device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
                .subvendor    = 0x5168,
                .subdevice    = 0x0138,
                .driver_data  = SAA7134_BOARD_FLYVIDEO3000,
@@ -3070,6 +3125,7 @@ int saa7134_board_init1(struct saa7134_d
        switch (dev->board) {
        case SAA7134_BOARD_FLYVIDEO2000:
        case SAA7134_BOARD_FLYVIDEO3000:
+       case SAA7134_BOARD_FLYVIDEO3000_NTSC:
                dev->has_remote = SAA7134_REMOTE_GPIO;
                board_flyvideo(dev);
                break;
diff -upr media.orig/video/saa7134/saa7134.h
media/video/saa7134/saa7134.h
--- media.orig/video/saa7134/saa7134.h  2006-06-12 02:34:46.000000000
-0500
+++ media/video/saa7134/saa7134.h       2006-06-12 02:36:31.000000000
-0500
@@ -209,6 +209,7 @@ struct saa7134_format {
 #define SAA7134_BOARD_ASUSTEK_DIGIMATRIX_TV 80
 #define SAA7134_BOARD_PHILIPS_TIGER  81
 #define SAA7134_BOARD_MSI_TVATANYWHERE_PLUS  82
+#define SAA7134_BOARD_FLYVIDEO3000_NTSC 83

 #define SAA7134_MAXBOARDS 8
 #define SAA7134_INPUT_MAX 8



-- 
Zac Bowling <zac@zacbowling.com>
Mono Project Maintainer
http://zacbowling.com/ 

