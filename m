Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVD0OUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVD0OUX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 10:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVD0OUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 10:20:23 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:28372 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261626AbVD0OUI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 10:20:08 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 27 Apr 2005 16:12:36 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>,
       dvb list <linux-dvb@linuxtv.org>
Subject: [patch 2/2] dvb: cx22702 frontend driver update
Message-ID: <20050427141236.GA15034@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

update cx22702 fe driver, add support for using the dvb pll lib,
enable cx22702 support in cx88-dvb.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/dvb/frontends/cx22702.c     |   15 
 drivers/media/dvb/frontends/cx22702.h     |    3 
 drivers/media/video/Kconfig               |    1 
 drivers/media/video/cx88/cx88-dvb.c       |    2 
 5 files changed, 662 insertions(+), 2 deletions(-)

Index: linux-2.6.12-rc3/drivers/media/dvb/frontends/cx22702.h
===================================================================
--- linux-2.6.12-rc3.orig/drivers/media/dvb/frontends/cx22702.h	2005-04-27 15:13:06.000000000 +0200
+++ linux-2.6.12-rc3/drivers/media/dvb/frontends/cx22702.h	2005-04-27 15:13:10.000000000 +0200
@@ -36,6 +36,9 @@ struct cx22702_config
 	u8 demod_address;
 
 	/* PLL maintenance */
+	u8 pll_address;
+	struct dvb_pll_desc *pll_desc;
+
 	int (*pll_init)(struct dvb_frontend* fe);
 	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters* params);
 };
Index: linux-2.6.12-rc3/drivers/media/video/Kconfig
===================================================================
--- linux-2.6.12-rc3.orig/drivers/media/video/Kconfig	2005-04-27 15:13:06.000000000 +0200
+++ linux-2.6.12-rc3/drivers/media/video/Kconfig	2005-04-27 15:13:10.000000000 +0200
@@ -252,6 +252,7 @@ config VIDEO_SAA7134_DVB
 	depends on VIDEO_SAA7134 && DVB_CORE
 	select VIDEO_BUF_DVB
 	select DVB_MT352
+	select DVB_CX22702
 	---help---
 	  This adds support for DVB cards based on the
 	  Philips saa7134 chip.
Index: linux-2.6.12-rc3/drivers/media/video/cx88/cx88-dvb.c
===================================================================
--- linux-2.6.12-rc3.orig/drivers/media/video/cx88/cx88-dvb.c	2005-04-27 15:13:06.000000000 +0200
+++ linux-2.6.12-rc3/drivers/media/video/cx88/cx88-dvb.c	2005-04-27 15:13:10.000000000 +0200
@@ -31,7 +31,7 @@
 #include <linux/suspend.h>
 
 /* those two frontends need merging via linuxtv cvs ... */
-#define HAVE_CX22702 0
+#define HAVE_CX22702 1
 #define HAVE_OR51132 1
 
 #include "cx88.h"
Index: linux-2.6.12-rc3/drivers/media/dvb/frontends/cx22702.c
===================================================================
--- linux-2.6.12-rc3.orig/drivers/media/dvb/frontends/cx22702.c	2005-04-27 15:13:06.000000000 +0200
+++ linux-2.6.12-rc3/drivers/media/dvb/frontends/cx22702.c	2005-04-27 15:14:30.000000000 +0200
@@ -32,6 +32,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include "dvb_frontend.h"
+#include "dvb-pll.h"
 #include "cx22702.h"
 
 
@@ -203,7 +204,19 @@ static int cx22702_set_tps (struct dvb_f
 
 	/* set PLL */
         cx22702_writereg (state, 0x0D, cx22702_readreg(state,0x0D) &0xfe);
-	state->config->pll_set(fe, p);
+	if (state->config->pll_set) {
+		state->config->pll_set(fe, p);
+	} else if (state->config->pll_desc) {
+		u8 pllbuf[4];
+		struct i2c_msg msg = { .addr = state->config->pll_address,
+				       .buf = pllbuf, .len = 4 };
+		dvb_pll_configure(state->config->pll_desc, pllbuf,
+				  p->frequency,
+				  p->u.ofdm.bandwidth);
+		i2c_transfer(state->i2c, &msg, 1);
+	} else {
+		BUG();
+	}
         cx22702_writereg (state, 0x0D, cx22702_readreg(state,0x0D) | 1);
 
 	/* set inversion */

-- 
#define printk(args...) fprintf(stderr, ## args)
