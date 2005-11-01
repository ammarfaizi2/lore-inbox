Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbVKAIOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbVKAIOJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbVKAIN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:13:59 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:42096 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S964960AbVKAINc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:13:32 -0500
Message-ID: <43672381.7040100@m1k.net>
Date: Tue, 01 Nov 2005 03:12:49 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 06/37] dvb: tda1004x: pll communication fixes
Content-Type: multipart/mixed;
 boundary="------------050705070707070703050308"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050705070707070703050308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------050705070707070703050308
Content-Type: text/x-patch;
 name="2367.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2367.patch"

From: Hartmut Hackmann <hartmut.hackmann@t-online.de>

- leave I2C bridge open at pll_sleep to support Philips EUROPA based cards.
- give an error message if the communication with the pll fails.

Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/frontends/tda1004x.c |   21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/frontends/tda1004x.c
+++ linux-2.6.14-git3/drivers/media/dvb/frontends/tda1004x.c
@@ -420,7 +420,7 @@
 	struct tda1004x_state* state = fe->demodulator_priv;
 
 	tda1004x_write_byteI(state, TDA10046H_CONFPLL1, 0xf0);
-	tda1004x_write_byteI(state, TDA10046H_CONFPLL2, 10); // PLL M = 10
+	tda1004x_write_byteI(state, TDA10046H_CONFPLL2, 0x0a); // PLL M = 10
 	if (state->config->xtal_freq == TDA10046_XTAL_4M ) {
 		dprintk("%s: setting up PLLs for a 4 MHz Xtal\n", __FUNCTION__);
 		tda1004x_write_byteI(state, TDA10046H_CONFPLL3, 0); // PLL P = N = 0
@@ -597,7 +597,10 @@
 	// Init the tuner PLL
 	if (state->config->pll_init) {
 		tda1004x_enable_tuner_i2c(state);
-		state->config->pll_init(fe);
+		if (state->config->pll_init(fe)) {
+			printk(KERN_ERR "tda1004x: pll init failed\n");
+			return 	-EIO;
+		}
 		tda1004x_disable_tuner_i2c(state);
 	}
 
@@ -667,7 +670,10 @@
 
 	// set frequency
 	tda1004x_enable_tuner_i2c(state);
-	state->config->pll_set(fe, fe_params);
+	if (state->config->pll_set(fe, fe_params)) {
+		printk(KERN_ERR "tda1004x: pll set failed\n");
+		return 	-EIO;
+	}
 	tda1004x_disable_tuner_i2c(state);
 
 	// Hardcoded to use auto as much as possible on the TDA10045 as it
@@ -832,6 +838,8 @@
 
 	case TDA1004X_DEMOD_TDA10046:
 		tda1004x_write_mask(state, TDA1004X_AUTO, 0x40, 0x40);
+		msleep(1);
+		tda1004x_write_mask(state, TDA10046H_AGC_CONF, 4, 1);
 		break;
 	}
 
@@ -1129,7 +1137,12 @@
 		if (state->config->pll_sleep != NULL) {
 			tda1004x_enable_tuner_i2c(state);
 			state->config->pll_sleep(fe);
-			tda1004x_disable_tuner_i2c(state);
+			if (state->config->if_freq != TDA10046_FREQ_052) {
+				/* special hack for Philips EUROPA Based boards:
+				 * keep the I2c bridge open for tuner access in analog mode
+				 */
+				tda1004x_disable_tuner_i2c(state);
+			}
 		}
 		tda1004x_write_mask(state, TDA1004X_CONFC4, 1, 1);
 		break;


--------------050705070707070703050308--
