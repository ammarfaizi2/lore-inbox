Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWAPJ1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWAPJ1F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWAPJYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:24:02 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49899 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932287AbWAPJXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:23:46 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Hartmut Hackmann <hartmut.hackmann@t-online.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 11/25] Turn frame locked sound on, basic support for FM
	radio with TDA8275(a)
Date: Mon, 16 Jan 2006 07:11:21 -0200
Message-id: <20060116091121.PS88059600011@infradead.org>
In-Reply-To: <20060116091105.PS83611600000@infradead.org>
References: <20060116091105.PS83611600000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Hartmut Hackmann <hartmut.hackmann@t-online.de>

- Enabled audio PLL. This is mandatory for NICAM sound
- modify FM IF frequency to 5.5MHz for SAA7133/35 if tuner is tda8290

Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/saa7134/saa7134-cards.c   |    6 ++++++
 drivers/media/video/saa7134/saa7134-tvaudio.c |   11 ++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index 275d06a..c64718a 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -2515,6 +2515,7 @@ struct saa7134_board saa7134_boards[] = 
 		.tuner_addr	= ADDR_UNSET,
 		.radio_addr	= ADDR_UNSET,
 		.mpeg           = SAA7134_MPEG_DVB,
+		.gpiomask       = 1 << 21,
 		.inputs = {{
 			.name   = name_tv,
 			.vmux   = 1,
@@ -2529,6 +2530,11 @@ struct saa7134_board saa7134_boards[] = 
 			.vmux   = 8,
 			.amux   = LINE1,
 		}},
+		.radio = {
+			.name   = name_radio,
+			.amux   = TV,
+			.gpio   = 0x0200000,
+		},
 	},
 	[SAA7134_BOARD_MSI_TVATANYWHERE_PLUS] = {
 		.name           = "MSI TV@Anywhere plus",
diff --git a/drivers/media/video/saa7134/saa7134-tvaudio.c b/drivers/media/video/saa7134/saa7134-tvaudio.c
index 9326842..afa4dcb 100644
--- a/drivers/media/video/saa7134/saa7134-tvaudio.c
+++ b/drivers/media/video/saa7134/saa7134-tvaudio.c
@@ -180,8 +180,8 @@ static void tvaudio_init(struct saa7134_
 	saa_writeb(SAA7134_AUDIO_CLOCK0,      clock        & 0xff);
 	saa_writeb(SAA7134_AUDIO_CLOCK1,     (clock >>  8) & 0xff);
 	saa_writeb(SAA7134_AUDIO_CLOCK2,     (clock >> 16) & 0xff);
-	// frame locked audio was reported not to be reliable
-	saa_writeb(SAA7134_AUDIO_PLL_CTRL,   0x02);
+	/* frame locked audio is mandatory for NICAM */
+	saa_writeb(SAA7134_AUDIO_PLL_CTRL,   0x01);
 
 	saa_writeb(SAA7134_NICAM_ERROR_LOW,  0x14);
 	saa_writeb(SAA7134_NICAM_ERROR_HIGH, 0x50);
@@ -809,7 +809,12 @@ static int tvaudio_thread_ddep(void *dat
 			dprintk("ddep override: %s\n",stdres[audio_ddep]);
 		} else if (&card(dev).radio == dev->input) {
 			dprintk("FM Radio\n");
-			norms = (0x0f << 2) | 0x01;
+			if (dev->tuner_type == TUNER_PHILIPS_TDA8290) {
+				norms = (0x11 << 2) | 0x01;
+				saa_dsp_writel(dev, 0x42c >> 2, 0x729555);
+			} else {
+				norms = (0x0f << 2) | 0x01;
+			}
 		} else {
 			/* (let chip) scan for sound carrier */
 			norms = 0;

