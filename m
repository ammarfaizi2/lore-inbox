Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262852AbVGNCuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262852AbVGNCuJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 22:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbVGNCuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 22:50:09 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:47779 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S262852AbVGNCuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 22:50:07 -0400
Message-ID: <42D5D2D7.9050707@m1k.net>
Date: Wed, 13 Jul 2005 22:49:59 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-dvb-maintainer@linuxtv.org, Mac Michaels <wmichaels1@earthlink.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [2.6.13 PATCH] DVB: LGDT3302 QAM lock bug fix
Content-Type: multipart/mixed;
 boundary="------------000009030907010704010008"
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
--------------000009030907010704010008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

QAM working great now :-) ...




--------------000009030907010704010008
Content-Type: text/plain;
 name="dvb-lgdt3302-qam-lock-bug-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dvb-lgdt3302-qam-lock-bug-fix.patch"

Fix QAM lock bug. Previously, it was necessary to first
scan in VSB before attempting to get a QAM lock.

Signed-off-by: Mac Michaels <wmichaels1@earthlink.net>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 linux/drivers/media/dvb/frontends/lgdt3302.c |   16 +++-------------
 1 files changed, 3 insertions(+), 13 deletions(-)

diff -u linux-2.6.13/drivers/media/dvb/frontends/lgdt3302.c linux/drivers/media/dvb/frontends/lgdt3302.c
--- linux-2.6.13/drivers/media/dvb/frontends/lgdt3302.c	2005-07-13 07:43:59.000000000 +0000
+++ linux/drivers/media/dvb/frontends/lgdt3302.c	2005-07-13 22:13:55.000000000 +0000
@@ -217,13 +217,11 @@
 	static u8 demux_ctrl_cfg[] = { DEMUX_CONTROL, 0xfb };
 	static u8 agc_rf_cfg[]     = { AGC_RF_BANDWIDTH0, 0x40, 0x93, 0x00 };
 	static u8 agc_ctrl_cfg[]   = { AGC_FUNC_CTRL2, 0xc6, 0x40 };
-	static u8 agc_delay_cfg[]  = { AGC_DELAY0, 0x00, 0x00, 0x00 };
+	static u8 agc_delay_cfg[]  = { AGC_DELAY0, 0x07, 0x00, 0xfe };
 	static u8 agc_loop_cfg[]   = { AGC_LOOP_BANDWIDTH0, 0x08, 0x9a };
 
 	/* Change only if we are actually changing the modulation */
 	if (state->current_modulation != param->u.vsb.modulation) {
-		int value;
-
 		switch(param->u.vsb.modulation) {
 		case VSB_8:
 			dprintk("%s: VSB_8 MODE\n", __FUNCTION__);
@@ -276,16 +274,8 @@
 		   recovery center frequency register */
 		i2c_writebytes(state, state->config->demod_address,
 				       vsb_freq_cfg, sizeof(vsb_freq_cfg));
-		/* Set the value of 'INLVTHD' register 0x2a/0x2c
-		   to value from 'IFACC' register 0x39/0x3b -1 */
-		i2c_selectreadbytes(state, AGC_RFIF_ACC0,
-				    &agc_delay_cfg[1], 3);
-		value = ((agc_delay_cfg[1] & 0x0f) << 8) | agc_delay_cfg[3];
-		value = value -1;
-		dprintk("%s IFACC -1 = 0x%03x\n", __FUNCTION__, value);
-		agc_delay_cfg[1] = (value >> 8) & 0x0f;
-		agc_delay_cfg[2] = 0x00;
-		agc_delay_cfg[3] = value & 0xff;
+
+		/* Set the value of 'INLVTHD' register 0x2a/0x2c to 0x7fe */
 		i2c_writebytes(state, state->config->demod_address,
 			       agc_delay_cfg, sizeof(agc_delay_cfg));
 

--------------000009030907010704010008--
