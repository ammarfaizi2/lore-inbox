Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVGUEVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVGUEVx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 00:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVGUEVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 00:21:53 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:51591 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261606AbVGUEVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 00:21:04 -0400
Message-ID: <42DF22AD.9090601@m1k.net>
Date: Thu, 21 Jul 2005 00:21:01 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: mkrufky@m1k.net, linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Mac Michaels <wmichaels1@earthlink.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: [2.6.13 PATCH 2/4] 02-lgdt3302-rf-input.patch
References: <42DF2196.5040503@m1k.net>
In-Reply-To: <42DF2196.5040503@m1k.net>
Content-Type: multipart/mixed;
 boundary="------------020008000705080900060301"
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
--------------020008000705080900060301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Michael Krufky wrote:

> This patch series spans both video4linux and linux-dvb trees.
> Remove the dvb_pll_desc from the lgdt3302 frontend and replace with a 
> pll_set-callback to isolate the tuner programming from the frontend.
>
> Select the RF input connector based upon the type of demodulation 
> selected. ANT RF connector is selected for 8-VSB and CABLE RF 
> connector is selected for QAM64/QAM256. Implement this along the lines 
> posted to linux-dvb list (subscribers only) by Patrick Boettcher. ( 
> http://linuxtv.org/pipermail/linux-dvb/2005-July/003557.html ) This 
> only affects the cards that use the Microtune 4042 tuner. This is not 
> ideal, but there is no current specification for selecting RF inputs. 
> It makes the card work the same way as the Windows driver thus it may 
> reduce user confusion.
>



--------------020008000705080900060301
Content-Type: text/plain;
 name="02-lgdt3302-rf-input.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02-lgdt3302-rf-input.patch"

Select the RF input connector based upon the type of
demodulation selected. ANT RF connector is selected for
8-VSB and CABLE RF connector is selected for QAM64/QAM256.
This only affects the cards that use the Microtune 4042 tuner.

Signed-off-by: Mac Michaels <wmichaels1@earthlink.net>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 linux/drivers/media/dvb/frontends/lgdt3302.c |   12 +++++++++++
 linux/drivers/media/dvb/frontends/lgdt3302.h |    1 
 linux/drivers/media/video/cx88/cx88-dvb.c    |   20 +++++++++++++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff -u linux-2.6.13/drivers/media/dvb/frontends/lgdt3302.c linux/drivers/media/dvb/frontends/lgdt3302.c
--- linux-2.6.13/drivers/media/dvb/frontends/lgdt3302.c	2005-07-20 22:50:39.000000000 +0000
+++ linux/drivers/media/dvb/frontends/lgdt3302.c	2005-07-20 22:53:29.000000000 +0000
@@ -214,6 +214,10 @@
 
 			/* Select VSB mode and serial MPEG interface */
 			top_ctrl_cfg[1] = 0x07;
+
+			/* Select ANT connector if supported by card */
+			if (state->config->pll_rf_set)
+				state->config->pll_rf_set(fe, 1);
 			break;
 
 		case QAM_64:
@@ -221,6 +225,10 @@
 
 			/* Select QAM_64 mode and serial MPEG interface */
 			top_ctrl_cfg[1] = 0x04;
+
+			/* Select CABLE connector if supported by card */
+			if (state->config->pll_rf_set)
+				state->config->pll_rf_set(fe, 0);
 			break;
 
 		case QAM_256:
@@ -228,6 +236,10 @@
 
 			/* Select QAM_256 mode and serial MPEG interface */
 			top_ctrl_cfg[1] = 0x05;
+
+			/* Select CABLE connector if supported by card */
+			if (state->config->pll_rf_set)
+				state->config->pll_rf_set(fe, 0);
 			break;
 		default:
 			printk(KERN_WARNING "lgdt3302: %s: Modulation type(%d) UNSUPPORTED\n", __FUNCTION__, param->u.vsb.modulation);
diff -u linux-2.6.13/drivers/media/dvb/frontends/lgdt3302.h linux/drivers/media/dvb/frontends/lgdt3302.h
--- linux-2.6.13/drivers/media/dvb/frontends/lgdt3302.h	2005-07-20 22:50:39.000000000 +0000
+++ linux/drivers/media/dvb/frontends/lgdt3302.h	2005-07-20 22:53:29.000000000 +0000
@@ -30,6 +30,7 @@
 	u8 demod_address;
 
 	/* PLL interface */
+	int (*pll_rf_set) (struct dvb_frontend* fe, int index);
 	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters* params, u8* pll_address);
 
 	/* Need to set device param for start_dma */
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c linux/drivers/media/video/cx88/cx88-dvb.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c	2005-07-20 22:50:39.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-dvb.c	2005-07-20 22:53:29.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-dvb.c,v 1.47 2005/07/20 05:20:37 mkrufky Exp $
+ * $Id: cx88-dvb.c,v 1.48 2005/07/20 05:33:33 mkrufky Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * MPEG Transport Stream (DVB) routines
@@ -223,6 +223,19 @@
 	return 0;
 }
 
+static int lgdt3302_pll_rf_set(struct dvb_frontend* fe, int index)
+{
+	struct cx8802_dev *dev= fe->dvb->priv;
+	struct cx88_core *core = dev->core;
+
+	dprintk(1, "%s: index = %d\n", __FUNCTION__, index);
+	if (index == 0)
+		cx_clear(MO_GP0_IO, 8);
+	else
+		cx_set(MO_GP0_IO, 8);
+	return 0;
+}
+
 static int lgdt3302_set_ts_param(struct dvb_frontend* fe, int is_punctured)
 {
 	struct cx8802_dev *dev= fe->dvb->priv;
@@ -296,8 +309,11 @@
 
 		cx_clear(MO_GP0_IO, 1);
 		mdelay(100);
-		cx_set(MO_GP0_IO, 9); // ANT connector too FIXME
+		cx_set(MO_GP0_IO, 1);
 		mdelay(200);
+
+		/* Select RF connector callback */
+		fusionhdtv_3_gold.pll_rf_set = lgdt3302_pll_rf_set;
 		dev->core->pll_addr = 0x61;
 		dev->core->pll_desc = &dvb_pll_microtune_4042;
 		dev->dvb.frontend = lgdt3302_attach(&fusionhdtv_3_gold,

--------------020008000705080900060301--
