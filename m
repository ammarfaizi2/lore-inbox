Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbVCVELO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbVCVELO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 23:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbVCVCUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:20:39 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:53386 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262309AbVCVBef
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:34:35 -0500
Message-Id: <20050322013455.793831000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:44 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-frontend-nxt2002-qam.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 11/48] nxt2002: QAM64/256 support
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch by Taylor Jacob: Add QAM64/256 Support

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 Kconfig   |    1 +
 nxt2002.c |   43 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/nxt2002.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/nxt2002.c	2005-03-22 00:14:18.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/nxt2002.c	2005-03-22 00:15:13.000000000 +0100
@@ -343,8 +343,21 @@ static int nxt2002_setup_frontend_parame
 	/* reset the agc now that tuning has been completed */
 	nxt2002_agc_reset(state);
 
+
+
 	/* set target power level */
+	switch (p->u.vsb.modulation) {
+		case QAM_64:
+		case QAM_256:
+				buf[0] = 0x74;
+				break;
+		case VSB_8:
 				buf[0] = 0x70;
+				break;
+		default:
+				return -EINVAL;
+				break;
+	}
 	i2c_writebytes(state,0x42,buf,1);
 
 	/* configure sdm */
@@ -357,7 +370,20 @@ static int nxt2002_setup_frontend_parame
 	nxt2002_writereg_multibyte(state,0x58,buf,2);
 
 	/* write sdmx input */
+	switch (p->u.vsb.modulation) {
+		case QAM_64:
+				buf[0] = 0x68;
+				break;
+		case QAM_256:
+				buf[0] = 0x64;
+				break;
+		case VSB_8:
 				buf[0] = 0x60;
+				break;
+		default:
+				return -EINVAL;
+				break;
+	}
 	buf[1] = 0x00;
 	nxt2002_writereg_multibyte(state,0x5C,buf,2);
 
@@ -387,7 +413,20 @@ static int nxt2002_setup_frontend_parame
 	i2c_writebytes(state,0x41,buf,1);
 
 	/* write agc ucgp0 */
+	switch (p->u.vsb.modulation) {
+		case QAM_64:
+				buf[0] = 0x02;
+				break;
+		case QAM_256:
+				buf[0] = 0x03;
+				break;
+		case VSB_8:
 				buf[0] = 0x00;
+				break;
+		default:
+				return -EINVAL;
+				break;
+	}
 	i2c_writebytes(state,0x30,buf,1);
 
 	/* write agc control reg */
@@ -632,12 +671,12 @@ static struct dvb_frontend_ops nxt2002_o
 		.name = "Nextwave nxt2002 VSB/QAM frontend",
 		.type = FE_ATSC,
 		.frequency_min =  54000000,
-		.frequency_max = 803000000,
+		.frequency_max = 806000000,
                 /* stepsize is just a guess */
 		.frequency_stepsize = 166666,
 		.caps = FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
 			FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
-			FE_CAN_8VSB
+			FE_CAN_8VSB | FE_CAN_QAM_64 | FE_CAN_QAM_256
 	},
 
 	.release = nxt2002_release,
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/Kconfig
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/Kconfig	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/Kconfig	2005-03-22 00:15:13.000000000 +0100
@@ -154,6 +154,7 @@ comment "ATSC (North American/Korean Ter
 config DVB_NXT2002
 	tristate "Nxt2002 based"
 	depends on DVB_CORE
+	select FW_LOADER
 	help
 	  An ATSC 8VSB tuner module. Say Y when you want to support this frontend.
 

--

