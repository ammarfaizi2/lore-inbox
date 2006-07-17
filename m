Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWGQQkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWGQQkL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWGQQdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:33:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:17084 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750986AbWGQQdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:33:22 -0400
Date: Mon, 17 Jul 2006 09:27:35 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Chris Pascoe <c.pascoe@itee.uq.edu.au>, Manu Abraham <manu@linuxtv.org>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 21/45] dvb-bt8xx: fix frontend detection for DViCO FusionHDTV DVB-T Lite rev 1.2
Message-ID: <20060717162735.GV4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dvb-bt8xx-fix-frontend-detection-for-dvico-fusionhdtv-dvb-t-lite-rev-1.2.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Michael Krufky <mkrufky@linuxtv.org>

This patch adds support for the new revision of the DViCO
FusionHDTV DVB-T Lite, based on the zl10353 demod instead
of mt352.

Both mt352 and zl10353 revisions of this card have the
same PCI subsystem ID.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Acked-by: Chris Pascoe <c.pascoe@itee.uq.edu.au>
Acked-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/media/dvb/bt8xx/dvb-bt8xx.c |   10 ++++++++++
 drivers/media/dvb/bt8xx/dvb-bt8xx.h |    1 +
 2 files changed, 11 insertions(+)

--- linux-2.6.17.3.orig/drivers/media/dvb/bt8xx/dvb-bt8xx.c
+++ linux-2.6.17.3/drivers/media/dvb/bt8xx/dvb-bt8xx.c
@@ -184,6 +184,11 @@ static struct mt352_config thomson_dtt75
 	.pll_set = thomson_dtt7579_pll_set,
 };
 
+static struct zl10353_config thomson_dtt7579_zl10353_config = {
+	.demod_address = 0x0f,
+	.pll_set = thomson_dtt7579_pll_set,
+};
+
 static int cx24108_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
 {
 	u32 freq = params->frequency;
@@ -617,6 +622,11 @@ static void frontend_init(struct dvb_bt8
 	switch(type) {
 	case BTTV_BOARD_DVICO_DVBT_LITE:
 		card->fe = mt352_attach(&thomson_dtt7579_config, card->i2c_adapter);
+
+		if (card->fe == NULL)
+			card->fe = zl10353_attach(&thomson_dtt7579_zl10353_config,
+						  card->i2c_adapter);
+
 		if (card->fe != NULL) {
 			card->fe->ops->info.frequency_min = 174000000;
 			card->fe->ops->info.frequency_max = 862000000;
--- linux-2.6.17.3.orig/drivers/media/dvb/bt8xx/dvb-bt8xx.h
+++ linux-2.6.17.3/drivers/media/dvb/bt8xx/dvb-bt8xx.h
@@ -37,6 +37,7 @@
 #include "cx24110.h"
 #include "or51211.h"
 #include "lgdt330x.h"
+#include "zl10353.h"
 
 struct dvb_bt8xx_card {
 	struct mutex lock;

--
