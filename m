Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965307AbWCTP1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965307AbWCTP1T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965312AbWCTP1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:27:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46520 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965295AbWCTP1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:27:11 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Hartmut Hackmann <hartmut.hackmann@t-online.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 110/141] V4L/DVB (3378): Restore power on defaults of
	tda9887 after tda8290 probe
Date: Mon, 20 Mar 2006 12:08:55 -0300
Message-id: <20060320150855.PS352097000110@infradead.org>
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

From: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Date: 1141009751 -0300

The probing code for tda8290 changes the state of the tda9887 GP ports.
The patch assumes that if probing for tda8290 failed, this must be a 
tda9887 and restores its power on defaults.
This should solve the module load order issue with some pinnacle cards.

Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index ca90a73..eaf32b8 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -2213,7 +2213,7 @@ struct saa7134_board saa7134_boards[] = 
 		.radio_type     = UNSET,
 		.tuner_addr	= 0x61,
 		.radio_addr	= ADDR_UNSET,
-		.tda9887_conf   = TDA9887_PRESENT,
+		.tda9887_conf   = TDA9887_PRESENT | TDA9887_PORT1_ACTIVE,
 		.mpeg           = SAA7134_MPEG_DVB,
 		.inputs = {{
 			.name   = name_tv,
@@ -2237,7 +2237,7 @@ struct saa7134_board saa7134_boards[] = 
 		.radio_type     = UNSET,
 		.tuner_addr	= 0x61,
 		.radio_addr	= ADDR_UNSET,
-		.tda9887_conf   = TDA9887_PRESENT,
+		.tda9887_conf   = TDA9887_PRESENT | TDA9887_PORT1_ACTIVE,
 		.mpeg           = SAA7134_MPEG_DVB,
 		.inputs = {{
 			.name   = name_tv,
diff --git a/drivers/media/video/tda8290.c b/drivers/media/video/tda8290.c
diff --git a/drivers/media/video/tda8290.c b/drivers/media/video/tda8290.c
index 2b954b3..027c8a0 100644
--- a/drivers/media/video/tda8290.c
+++ b/drivers/media/video/tda8290.c
@@ -584,9 +584,10 @@ int tda8290_init(struct i2c_client *c)
 
 int tda8290_probe(struct i2c_client *c)
 {
-	unsigned char soft_reset[]  = { 0x00, 0x00 };
-	unsigned char easy_mode_b[] = { 0x01, 0x02 };
-	unsigned char easy_mode_g[] = { 0x01, 0x04 };
+	unsigned char soft_reset[]   = { 0x00, 0x00 };
+	unsigned char easy_mode_b[]  = { 0x01, 0x02 };
+	unsigned char easy_mode_g[]  = { 0x01, 0x04 };
+	unsigned char restore_9886[] = { 0x00, 0xd6, 0x30 };
 	unsigned char addr_dto_lsb = 0x07;
 	unsigned char data;
 
@@ -603,6 +604,7 @@ int tda8290_probe(struct i2c_client *c)
 			return 0;
 		}
 	}
+	i2c_master_send(c, restore_9886, 3);
 	return -1;
 }
 

