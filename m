Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWJNMHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWJNMHK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 08:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWJNMHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 08:07:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61900 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932179AbWJNMHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 08:07:06 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Patrick Boettcher <pb@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 18/18] V4L/DVB (4750): AGC command1/2 is board specific
Date: Sat, 14 Oct 2006 09:00:51 -0300
Message-id: <20061014120051.PS82443500018@infradead.org>
In-Reply-To: <20061014115356.PS36551000000@infradead.org>
References: <20061014115356.PS36551000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Patrick Boettcher <pb@linuxtv.org>

Added config-struct-parameter to take board-specific AGC command 1 and 2 into account.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/dvb-usb/dibusb-common.c |   11 +++++++++--
 drivers/media/dvb/frontends/dib3000mc.c   |    2 +-
 drivers/media/dvb/frontends/dib3000mc.h   |    3 +++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb/dvb-usb/dibusb-common.c b/drivers/media/dvb/dvb-usb/dibusb-common.c
index fd3a990..5143e42 100644
--- a/drivers/media/dvb/dvb-usb/dibusb-common.c
+++ b/drivers/media/dvb/dvb-usb/dibusb-common.c
@@ -169,7 +169,7 @@ EXPORT_SYMBOL(dibusb_read_eeprom_byte);
 // Config Adjacent channels  Perf -cal22
 static struct dibx000_agc_config dib3000p_mt2060_agc_config = {
 	.band_caps = BAND_VHF | BAND_UHF,
-	.setup     = (0 << 15) | (0 << 14) | (1 << 13) | (1 << 12) | (29 << 0),
+	.setup     = (1 << 8) | (5 << 5) | (1 << 4) | (1 << 3) | (0 << 2) | (2 << 0),
 
 	.agc1_max = 48497,
 	.agc1_min = 23593,
@@ -196,10 +196,14 @@ static struct dib3000mc_config stk3000p_
 	.ln_adc_level = 0x1cc7,
 
 	.output_mpeg2_in_188_bytes = 1,
+
+	.agc_command1 = 1,
+	.agc_command2 = 1,
 };
 
 static struct dibx000_agc_config dib3000p_panasonic_agc_config = {
-	.setup    = (0 << 15) | (0 << 14) | (1 << 13) | (1 << 12) | (29 << 0),
+	.band_caps = BAND_VHF | BAND_UHF,
+	.setup     = (1 << 8) | (5 << 5) | (1 << 4) | (1 << 3) | (0 << 2) | (2 << 0),
 
 	.agc1_max = 56361,
 	.agc1_min = 22282,
@@ -226,6 +230,9 @@ static struct dib3000mc_config mod3000p_
 	.ln_adc_level = 0x1cc7,
 
 	.output_mpeg2_in_188_bytes = 1,
+
+	.agc_command1 = 1,
+	.agc_command2 = 1,
 };
 
 int dibusb_dib3000mc_frontend_attach(struct dvb_usb_adapter *adap)
diff --git a/drivers/media/dvb/frontends/dib3000mc.c b/drivers/media/dvb/frontends/dib3000mc.c
index ccc813b..3561a77 100644
--- a/drivers/media/dvb/frontends/dib3000mc.c
+++ b/drivers/media/dvb/frontends/dib3000mc.c
@@ -345,7 +345,7 @@ static int dib3000mc_init(struct dvb_fro
 
 	/* agc */
 	dib3000mc_write_word(state, 36, state->cfg->max_time);
-	dib3000mc_write_word(state, 37, agc->setup);
+	dib3000mc_write_word(state, 37, (state->cfg->agc_command1 << 13) | (state->cfg->agc_command2 << 12) | (0x1d << 0));
 	dib3000mc_write_word(state, 38, state->cfg->pwm3_value);
 	dib3000mc_write_word(state, 39, state->cfg->ln_adc_level);
 
diff --git a/drivers/media/dvb/frontends/dib3000mc.h b/drivers/media/dvb/frontends/dib3000mc.h
index b198cd5..0d6fdef 100644
--- a/drivers/media/dvb/frontends/dib3000mc.h
+++ b/drivers/media/dvb/frontends/dib3000mc.h
@@ -28,6 +28,9 @@ struct dib3000mc_config {
 	u16 max_time;
 	u16 ln_adc_level;
 
+	u8 agc_command1 :1;
+	u8 agc_command2 :1;
+
 	u8 mobile_mode;
 
 	u8 output_mpeg2_in_188_bytes;

