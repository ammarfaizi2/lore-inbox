Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbVKGDU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbVKGDU7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbVKGDSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:18:00 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:53181 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932432AbVKGDRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:17:48 -0500
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       Hartmut Hackmann <hartmut.hackmann@t.online.de>
Subject: [Patch 01/20] V4L(896) Fixed tda8290 secam l
Date: Mon, 07 Nov 2005 00:58:05 -0200
Message-Id: <1131333341.25215.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hartmut Hackmann <hartmut.hackmann@t.online.de>

- Fixed tda8290 SECAM-L

Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t.online.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

-----------------

 drivers/media/video/tda8290.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

--- hg.orig/drivers/media/video/tda8290.c
+++ hg/drivers/media/video/tda8290.c
@@ -323,6 +323,7 @@ static int tda8290_tune(struct i2c_clien
 	i2c_master_send(c, soft_reset, 2);
 	msleep(1);
 
+	expert_mode[1] = t->tda8290_easy_mode + 0x80;
 	i2c_master_send(c, expert_mode, 2);
 	i2c_master_send(c, gainset_off, 2);
 	i2c_master_send(c, if_agc_spd, 2);
@@ -348,8 +349,9 @@ static int tda8290_tune(struct i2c_clien
 		tuner_dbg("tda8290 is locked, AGC: %d\n", agc_stat);
 	else
 		tuner_dbg("tda8290 not locked, no signal?\n");
-	if ((agc_stat > 115) || (!(pll_stat & 0x80) && (adc_sat <20))) {
-		tuner_dbg("adjust gain, step 1. Agc: %d\n", agc_stat);
+	if ((agc_stat > 115) || (!(pll_stat & 0x80) && (adc_sat < 20))) {
+		tuner_dbg("adjust gain, step 1. Agc: %d, ADC stat: %d, lock: %d\n",
+			   agc_stat, adc_sat, pll_stat & 0x80);
 		i2c_master_send(c, gainset_2, 2);
 		msleep(100);
 		i2c_master_send(c, &addr_agc_stat, 1);
@@ -357,7 +359,8 @@ static int tda8290_tune(struct i2c_clien
 		i2c_master_send(c, &addr_pll_stat, 1);
 		i2c_master_recv(c, &pll_stat, 1);
 		if ((agc_stat > 115) || !(pll_stat & 0x80)) {
-			tuner_dbg("adjust gain, step 2. Agc: %d\n", agc_stat);
+			tuner_dbg("adjust gain, step 2. Agc: %d, lock: %d\n",
+				   agc_stat, pll_stat & 0x80);
 			if (t->tda827x_ver != 0)
 				tda827xa_agcf(c);
 			else
@@ -383,6 +386,7 @@ static int tda8290_tune(struct i2c_clien
 		i2c_master_send(c, &addr_pll_stat, 1);
 		i2c_master_recv(c, &pll_stat, 1);
 		if ((adc_sat > 20) || !(pll_stat & 0x80)) {
+			tuner_dbg("trying to resolve SECAM L deadlock\n");
 			i2c_master_send(c, agc_rst_on, 2);
 			msleep(40);
 			i2c_master_send(c, agc_rst_off, 2);
@@ -404,28 +408,37 @@ static int tda8290_tune(struct i2c_clien
 
 static void set_audio(struct tuner *t)
 {
-	t->tda827x_lpsel = 0;
+	char* mode;
 
+	t->tda827x_lpsel = 0;
+	mode = "xx";
 	if (t->std & V4L2_STD_MN) {
 		t->sgIF = 92;
 		t->tda8290_easy_mode = 0x01;
 		t->tda827x_lpsel = 1;
+		mode = "MN";
 	} else if (t->std & V4L2_STD_B) {
 		t->sgIF = 108;
 		t->tda8290_easy_mode = 0x02;
+		mode = "B";
 	} else if (t->std & V4L2_STD_GH) {
 		t->sgIF = 124;
 		t->tda8290_easy_mode = 0x04;
+		mode = "GH";
 	} else if (t->std & V4L2_STD_PAL_I) {
 		t->sgIF = 124;
 		t->tda8290_easy_mode = 0x08;
+		mode = "I";
 	} else if (t->std & V4L2_STD_DK) {
 		t->sgIF = 124;
 		t->tda8290_easy_mode = 0x10;
+		mode = "DK";
 	} else if (t->std & V4L2_STD_SECAM_L) {
 		t->sgIF = 124;
 		t->tda8290_easy_mode = 0x20;
+		mode = "L";
 	}
+    tuner_dbg("setting tda8290 to system %s\n", mode);
 }
 
 static void set_tv_freq(struct i2c_client *c, unsigned int freq)


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/

