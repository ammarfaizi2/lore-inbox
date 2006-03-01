Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWCAPg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWCAPg2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 10:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWCAPg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 10:36:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:5773 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932280AbWCAPg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 10:36:27 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Hartmut Hackmann <hartmut.hackmann@t-online.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 09/13] Restore power on defaults of tda9887 after tda8290
	probe
Date: Wed, 01 Mar 2006 09:05:39 -0300
Message-id: <20060301120539.PS34687000009@infradead.org>
In-Reply-To: <20060301120529.PS80375900000@infradead.org>
References: <20060301120529.PS80375900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Hartmut Hackmann <hartmut.hackmann@t\-online.de>
Date: 1141009751 \-0300

The probing code for tda8290 changes the state of the tda9887 GP ports.
The patch assumes that if probing for tda8290 failed, this must be a 
tda9887 and restores its power on defaults.
This should solve the module load order issue with some pinnacle cards.

Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/saa7134/saa7134-cards.c |    4 ++--
 drivers/media/video/tda8290.c               |    8 +++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index dcffd8c..cd37880 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -2187,7 +2187,7 @@ struct saa7134_board saa7134_boards[] = 
 		.radio_type     = UNSET,
 		.tuner_addr	= 0x61,
 		.radio_addr	= ADDR_UNSET,
-		.tda9887_conf   = TDA9887_PRESENT,
+		.tda9887_conf   = TDA9887_PRESENT | TDA9887_PORT1_ACTIVE,
 		.mpeg           = SAA7134_MPEG_DVB,
 		.inputs = {{
 			.name   = name_tv,
@@ -2211,7 +2211,7 @@ struct saa7134_board saa7134_boards[] = 
 		.radio_type     = UNSET,
 		.tuner_addr	= 0x61,
 		.radio_addr	= ADDR_UNSET,
-		.tda9887_conf   = TDA9887_PRESENT,
+		.tda9887_conf   = TDA9887_PRESENT | TDA9887_PORT1_ACTIVE,
 		.mpeg           = SAA7134_MPEG_DVB,
 		.inputs = {{
 			.name   = name_tv,
diff --git a/drivers/media/video/tda8290.c b/drivers/media/video/tda8290.c
index 7b4fb28..a796a4e 100644
--- a/drivers/media/video/tda8290.c
+++ b/drivers/media/video/tda8290.c
@@ -580,9 +580,10 @@ int tda8290_init(struct i2c_client *c)
 
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
 
@@ -599,6 +600,7 @@ int tda8290_probe(struct i2c_client *c)
 			return 0;
 		}
 	}
+	i2c_master_send(c, restore_9886, 3);
 	return -1;
 }
 

