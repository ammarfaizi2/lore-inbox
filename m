Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVGLBgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVGLBgo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 21:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVGLBgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 21:36:44 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:34884 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261731AbVGLBgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 21:36:42 -0400
Message-ID: <42D31EC1.9090102@m1k.net>
Date: Mon, 11 Jul 2005 21:37:05 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Johannes Stezenbach <js@linuxtv.org>,
       Mac Michaels <wmichaels1@earthlink.net>,
       LinuxDVB Mailing List <linux-dvb@linuxtv.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] DVB: LGDT3302 QAM256 initialization fix
Content-Type: multipart/mixed;
 boundary="------------080704090901020503070704"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080704090901020503070704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

- Initialize all non mutually exclusive variables
  without regard to the mode selected.
- Do a software reset each time the parameters are
  set, regardless of whether anything changes.
  This may allow an application to recover from a
  hung condition.
- Improved error reporting.
- Removed $Id:$

Signed-off-by: Mac Michaels <wmichaels1@earthlink.net <mailto:wmichaels1@earthlink.net>>
Signed-off-by: Michael Krufky <mkrufky@m1k.net <mailto:mkrufky@m1k.net>>




--------------080704090901020503070704
Content-Type: text/plain;
 name="dvb-lgdt3302-initialization-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dvb-lgdt3302-initialization-fix.patch"

 linux/drivers/media/dvb/frontends/lgdt3302.c |   63 +++++++++----------
 1 files changed, 30 insertions(+), 33 deletions(-)

diff -u linux-2.6.13/drivers/media/dvb/frontends/lgdt3302.c linux/drivers/media/dvb/frontends/lgdt3302.c
--- linux-2.6.13/drivers/media/dvb/frontends/lgdt3302.c	2005-07-07 08:19:00.000000000 +0000
+++ linux/drivers/media/dvb/frontends/lgdt3302.c	2005-07-11 21:25:53.000000000 +0000
@@ -1,6 +1,4 @@
 /*
- * $Id: lgdt3302.c,v 1.5 2005/07/07 03:47:15 mkrufky Exp $
- *
  *    Support for LGDT3302 (DViCO FustionHDTV 3 Gold) - VSB/QAM
  *
  *    Copyright (C) 2005 Wilson Michaels <wilsonmichaels@earthlink.net>
@@ -83,7 +81,10 @@
 
 		if ((err = i2c_transfer(state->i2c, &msg, 1)) != 1) {
 			printk(KERN_WARNING "lgdt3302: %s error (addr %02x <- %02x, err == %i)\n", __FUNCTION__, addr, buf[0], err);
-			return -EREMOTEIO;
+			if (err < 0)
+				return err;
+			else
+				return -EREMOTEIO;
 		}
 	} else {
 		u8 tmp[] = { buf[0], buf[1] };
@@ -96,7 +97,10 @@
 			tmp[1] = buf[i];
 			if ((err = i2c_transfer(state->i2c, &msg, 1)) != 1) {
 				printk(KERN_WARNING "lgdt3302: %s error (addr %02x <- %02x, err == %i)\n", __FUNCTION__, addr, buf[0], err);
-				return -EREMOTEIO;
+				if (err < 0)
+					return err;
+				else
+					return -EREMOTEIO;
 			}
 			tmp[0]++;
 		}
@@ -266,36 +270,30 @@
 		i2c_writebytes(state, state->config->demod_address,
 			       demux_ctrl_cfg, sizeof(demux_ctrl_cfg));
 
-		if (param->u.vsb.modulation == VSB_8) {
-			/* Initialization for VSB modes only */
-			/* Change the value of NCOCTFV[25:0]of carrier
-			   recovery center frequency register for VSB */
-			i2c_writebytes(state, state->config->demod_address,
+		/* Change the value of NCOCTFV[25:0] of carrier
+		   recovery center frequency register */
+		i2c_writebytes(state, state->config->demod_address,
 				       vsb_freq_cfg, sizeof(vsb_freq_cfg));
-		} else {
-			/* Initialization for QAM modes only */
-			/* Set the value of 'INLVTHD' register 0x2a/0x2c
-			   to value from 'IFACC' register 0x39/0x3b -1 */
-			int value;
-			i2c_selectreadbytes(state, AGC_RFIF_ACC0,
-					    &agc_delay_cfg[1], 3);
-			value = ((agc_delay_cfg[1] & 0x0f) << 8) | agc_delay_cfg[3];
-			value = value -1;
-			dprintk("%s IFACC -1 = 0x%03x\n", __FUNCTION__, value);
-			agc_delay_cfg[1] = (value >> 8) & 0x0f;
-			agc_delay_cfg[2] = 0x00;
-			agc_delay_cfg[3] = value & 0xff;
-			i2c_writebytes(state, state->config->demod_address,
-				       agc_delay_cfg, sizeof(agc_delay_cfg));
-
-			/* Change the value of IAGCBW[15:8]
-			   of inner AGC loop filter bandwith */
-			i2c_writebytes(state, state->config->demod_address,
-				       agc_loop_cfg, sizeof(agc_loop_cfg));
-		}
+		/* Set the value of 'INLVTHD' register 0x2a/0x2c
+		   to value from 'IFACC' register 0x39/0x3b -1 */
+		int value;
+		i2c_selectreadbytes(state, AGC_RFIF_ACC0,
+				    &agc_delay_cfg[1], 3);
+		value = ((agc_delay_cfg[1] & 0x0f) << 8) | agc_delay_cfg[3];
+		value = value -1;
+		dprintk("%s IFACC -1 = 0x%03x\n", __FUNCTION__, value);
+		agc_delay_cfg[1] = (value >> 8) & 0x0f;
+		agc_delay_cfg[2] = 0x00;
+		agc_delay_cfg[3] = value & 0xff;
+		i2c_writebytes(state, state->config->demod_address,
+			       agc_delay_cfg, sizeof(agc_delay_cfg));
+
+		/* Change the value of IAGCBW[15:8]
+		   of inner AGC loop filter bandwith */
+		i2c_writebytes(state, state->config->demod_address,
+			       agc_loop_cfg, sizeof(agc_loop_cfg));
 
 		state->config->set_ts_params(fe, 0);
-		lgdt3302_SwReset(state);
 		state->current_modulation = param->u.vsb.modulation;
 	}
 
@@ -311,11 +309,10 @@
 		i2c_readbytes(state, state->config->pll_address, buf, 1);
 		dprintk("%s: tuner status byte = 0x%02x\n", __FUNCTION__, buf[0]);
 
-		lgdt3302_SwReset(state);
-
 		/* Update current frequency */
 		state->current_frequency = param->frequency;
 	}
+	lgdt3302_SwReset(state);
 	return 0;
 }
 

--------------080704090901020503070704--
