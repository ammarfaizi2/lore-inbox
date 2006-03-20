Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbWCTPxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbWCTPxp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWCTPxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:53:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54478 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965594AbWCTPxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:53:06 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Hartmut Hackmann <hartmut.hackmann@t-online.de>,
       Hartmut Hackmann <hartmut.hackmann@t-online.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 057/141] V4L/DVB (3303): TDA8290 update
Date: Mon, 20 Mar 2006 12:08:46 -0300
Message-id: <20060320150846.PS484551000057@infradead.org>
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
Date: 1139302149 -0200

This patch
- works around a bug in the I2C bridge that makes the initialization
  of the TDA10046 fail on recent LifeView cards
- puts the AGC output to tristate in sleep mode. This is necessary for
  recent hybrid cards that switch the AGC via tristateing.

Signed-off-by: Hartmut Hackmann<hartmut.hackmann@t-online.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/tda8290.c b/drivers/media/video/tda8290.c
diff --git a/drivers/media/video/tda8290.c b/drivers/media/video/tda8290.c
index 7b4fb28..2b954b3 100644
--- a/drivers/media/video/tda8290.c
+++ b/drivers/media/video/tda8290.c
@@ -281,7 +281,7 @@ static void tda827xa_agcf(struct i2c_cli
 static void tda8290_i2c_bridge(struct i2c_client *c, int close)
 {
 	unsigned char  enable[2] = { 0x21, 0xC0 };
-	unsigned char disable[2] = { 0x21, 0x80 };
+	unsigned char disable[2] = { 0x21, 0x00 };
 	unsigned char *msg;
 	if(close) {
 		msg = enable;
@@ -302,6 +302,7 @@ static int tda8290_tune(struct i2c_clien
 	unsigned char soft_reset[]  = { 0x00, 0x00 };
 	unsigned char easy_mode[]   = { 0x01, t->tda8290_easy_mode };
 	unsigned char expert_mode[] = { 0x01, 0x80 };
+	unsigned char agc_out_on[]  = { 0x02, 0x00 };
 	unsigned char gainset_off[] = { 0x28, 0x14 };
 	unsigned char if_agc_spd[]  = { 0x0f, 0x88 };
 	unsigned char adc_head_6[]  = { 0x05, 0x04 };
@@ -320,6 +321,7 @@ static int tda8290_tune(struct i2c_clien
 		      pll_stat;
 
 	i2c_master_send(c, easy_mode, 2);
+	i2c_master_send(c, agc_out_on, 2);
 	i2c_master_send(c, soft_reset, 2);
 	msleep(1);
 
@@ -470,6 +472,7 @@ static void standby(struct i2c_client *c
 	struct tuner *t = i2c_get_clientdata(c);
 	unsigned char cb1[] = { 0x30, 0xD0 };
 	unsigned char tda8290_standby[] = { 0x00, 0x02 };
+	unsigned char tda8290_agc_tri[] = { 0x02, 0x20 };
 	struct i2c_msg msg = {.addr = t->tda827x_addr, .flags=0, .buf=cb1, .len = 2};
 
 	tda8290_i2c_bridge(c, 1);
@@ -477,6 +480,7 @@ static void standby(struct i2c_client *c
 		cb1[1] = 0x90;
 	i2c_transfer(c->adapter, &msg, 1);
 	tda8290_i2c_bridge(c, 0);
+	i2c_master_send(c, tda8290_agc_tri, 2);
 	i2c_master_send(c, tda8290_standby, 2);
 }
 
@@ -565,7 +569,7 @@ int tda8290_init(struct i2c_client *c)
 		strlcpy(c->name, "tda8290+75a", sizeof(c->name));
 		t->tda827x_ver = 2;
 	}
-	tuner_info("tuner: type set to %s\n", c->name);
+	tuner_info("type set to %s\n", c->name);
 
 	t->set_tv_freq    = set_tv_freq;
 	t->set_radio_freq = set_radio_freq;

