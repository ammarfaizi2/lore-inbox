Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVESXIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVESXIY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 19:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVESXEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 19:04:30 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:4740 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261336AbVESXD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 19:03:26 -0400
Message-ID: <428D1B38.9080901@krufky.com>
Date: Thu, 19 May 2005 19:03:20 -0400
From: Michael Krufky <mike@krufky.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Patch for cx88-cards.c for DVICO-FusionHDTV 3 GOLD Q
References: <4283552F.6050003@m1k.net>	<4287DC6B.5010401@m1k.net> <20050515210024.536ea43c.akpm@osdl.org> <42883D03.1040809@m1k.net>
In-Reply-To: <42883D03.1040809@m1k.net>
Content-Type: multipart/mixed;
 boundary="------------050504000609080307060702"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - krufky.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050504000609080307060702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The previous patch that I submitted has been revised, and here is the 
version that has been included in 2.6.12-rc4-mm2: (This patch is against 
2.6.12-rc4).

This patch allows full analog functionality for the DViCO FusionHDTV3 
Gold-Q, 18ac:d820 which has a Conexant cx23882, Thompson7611, and LG 
3302. It does NOT yet support digital decoding or digital audio without 
the internal analog audio jack connected to the sound board, but it 
works perfectly in analog mode.

Signed-off-by: Michael Krufky



--------------050504000609080307060702
Content-Type: text/plain;
 name="cx88-fix-for-dvico-fusionhdtv-3-gold-q.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cx88-fix-for-dvico-fusionhdtv-3-gold-q.patch"

diff -puN a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
--- a/drivers/media/video/cx88/cx88-cards.c	2005-05-16 01:10:54.000000000 +0000
+++ b/drivers/media/video/cx88/cx88-cards.c	2005-05-16 02:01:27.000000000 +0000
@@ -435,6 +435,33 @@ struct cx88_board cx88_boards[] = {
 		 }
 #endif
 	},
+        [CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q] = {
+                .name           = "DViCO - FusionHDTV 3 Gold-Q",
+                .tuner_type     = 52, /* Thomson DDT 7610 ATSC/NTSC - Its actually a 7611 chip, but this works */
+                .input          = {{
+                        .type   = CX88_VMUX_TELEVISION,
+                        .vmux   = 0,
+                        .gpio0  = 0x0f0d,
+                },{
+                        .type   = CX88_VMUX_CABLE,
+                        .vmux   = 0,
+                        .gpio0  = 0x0f05,
+                },{
+                        .type   = CX88_VMUX_COMPOSITE1,
+                        .vmux   = 1,
+                        .gpio0  = 0x0f00,
+                },{
+                        .type   = CX88_VMUX_SVIDEO,
+                        .vmux   = 2,
+                        .gpio0  = 0x0f00,
+                }},
+#if 0
+                .ts             = {
+                         .type   = CX88_TS,
+                         .gpio0  = 0x00000f01,   /* Hooked to tuner reset bit */
+                 }
+#endif
+        },
         [CX88_BOARD_HAUPPAUGE_DVB_T1] = {
                 .name           = "Hauppauge Nova-T DVB-T",
 		.tuner_type     = TUNER_ABSENT,
@@ -673,6 +700,10 @@ struct cx88_subid cx88_subids[] = {
 		.subdevice = 0xd810,
 		.card      = CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD,
 	},{
+		.subvendor = 0x18ac,
+		.subdevice = 0xd820,
+		.card      = CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q,
+	},{
 		.subvendor = 0x18AC,
 		.subdevice = 0xDB00,
 		.card      = CX88_BOARD_DVICO_FUSIONHDTV_DVB_T1,
diff -puN a/drivers/media/video/cx88/cx88.h b/drivers/media/video/cx88/cx88.h
--- a/drivers/media/video/cx88/cx88.h	2005-05-16 01:10:54.000000000 +0000
+++ b/drivers/media/video/cx88/cx88.h	2005-05-16 01:59:06.000000000 +0000
@@ -162,6 +162,7 @@ extern struct sram_channel cx88_sram_cha
 #define CX88_BOARD_HAUPPAUGE_ROSLYN        24
 #define CX88_BOARD_DIGITALLOGIC_MEC	       25
 #define CX88_BOARD_IODATA_GVBCTV7E         26
+#define CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q    27
 
 enum cx88_itype {
 	CX88_VMUX_COMPOSITE1 = 1,

--------------050504000609080307060702--
