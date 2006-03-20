Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWCTPXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWCTPXU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965275AbWCTPXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:23:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58082 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965278AbWCTPW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:22:58 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 068/141] V4L/DVB (3316): Add initial support for KWorld
	HardwareMpegTV XPert
Date: Mon, 20 Mar 2006 12:08:48 -0300
Message-id: <20060320150848.PS327338000068@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Krufky <mkrufky@linuxtv.org>
Date: 1139302154 -0200

- Add initial support for KWorld HardwareMpegTV XPert.
- uses silicon tuner: tda8290 + tda8275
- standard video using cx88 broadcast decoder is working.
- blackbird mpeg encoder support (cx23416) not yet working.
- FM radio untested.
- audio is only working correctly in television mode,
  all other modes disabled.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/Documentation/video4linux/CARDLIST.cx88 b/Documentation/video4linux/CARDLIST.cx88
diff --git a/Documentation/video4linux/CARDLIST.cx88 b/Documentation/video4linux/CARDLIST.cx88
index 8bea3fb..d852ad4 100644
--- a/Documentation/video4linux/CARDLIST.cx88
+++ b/Documentation/video4linux/CARDLIST.cx88
@@ -43,3 +43,4 @@
  42 -> digitalnow DNTV Live! DVB-T Pro                     [1822:0025]
  43 -> KWorld/VStream XPert DVB-T with cx22702             [17de:08a1]
  44 -> DViCO FusionHDTV DVB-T Dual Digital                 [18ac:db50,18ac:db54]
+ 45 -> KWorld HardwareMpegTV XPert                         [17de:0840]
diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
index 1bc9992..f2ae047 100644
--- a/drivers/media/video/cx88/cx88-cards.c
+++ b/drivers/media/video/cx88/cx88-cards.c
@@ -1048,6 +1048,25 @@ struct cx88_board cx88_boards[] = {
 		}},
 		.dvb            = 1,
 	},
+	[CX88_BOARD_KWORLD_HARDWARE_MPEG_TV_XPERT] = {
+		/* FIXME: This card is shipped without a windows tv app,
+		 * so I haven't been able to use regspy to figure out the GPIO
+		 * settings. Standard video using the cx88 broadcast decoder is
+		 * working, but blackbird isn't working yet, audio is only
+		 * working correctly for television mode. S-Video and Composite
+		 * are working for video-only, so I have them disabled for now.
+		 */
+		.name           = "KWorld HardwareMpegTV XPert",
+		.tuner_type     = TUNER_PHILIPS_TDA8290,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
+		.input          = {{
+			.type   = CX88_VMUX_TELEVISION,
+			.vmux   = 0,
+			.gpio0  = 0x07fa,
+		}},
+	},
 
 };
 const unsigned int cx88_bcount = ARRAY_SIZE(cx88_boards);
@@ -1254,6 +1273,10 @@ struct cx88_subid cx88_subids[] = {
 		.subdevice = 0xdb11,
 		.card      = CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_PLUS,
 		/* Re-branded DViCO: UltraView DVB-T Plus */
+	},{
+		.subvendor = 0x17de,
+		.subdevice = 0x0840,
+		.card      = CX88_BOARD_KWORLD_HARDWARE_MPEG_TV_XPERT,
 	},
 };
 const unsigned int cx88_idcount = ARRAY_SIZE(cx88_subids);
diff --git a/drivers/media/video/cx88/cx88.h b/drivers/media/video/cx88/cx88.h
diff --git a/drivers/media/video/cx88/cx88.h b/drivers/media/video/cx88/cx88.h
index e9fd55b..31a688a 100644
--- a/drivers/media/video/cx88/cx88.h
+++ b/drivers/media/video/cx88/cx88.h
@@ -187,6 +187,7 @@ extern struct sram_channel cx88_sram_cha
 #define CX88_BOARD_DNTV_LIVE_DVB_T_PRO     42
 #define CX88_BOARD_KWORLD_DVB_T_CX22702    43
 #define CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_DUAL 44
+#define CX88_BOARD_KWORLD_HARDWARE_MPEG_TV_XPERT 45
 
 enum cx88_itype {
 	CX88_VMUX_COMPOSITE1 = 1,

