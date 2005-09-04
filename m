Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVIDXdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVIDXdF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVIDXcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:32:39 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:59265 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932152AbVIDXbL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:31:11 -0400
Message-Id: <20050904232324.408246000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:21 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Mac Michaels <wmichaels1@earthlink.net>,
       Michael Krufky <mkrufky@m1k.net>
Content-Disposition: inline; filename=dvb-frontend-or51132-fix-retuning.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 22/54] frontend: or51132: remove bogus optimization attempt
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mac Michaels <wmichaels1@earthlink.net>

This fix has also been applied to lgdt330x. There is
an optimization that keeps track of the frequency tuned by
the digital decoder. The digital driver does not set the
frequency if it has not changed since it was tuned. The
analog tuner driver knows nothing about the frequency saved
by the digital driver. When the frequency is set using the
video4linux code with tvtime, the hardware get changed but
the digital driver's state does not get updated. Switch
back to the same digital channel and the driver finds no
change in frequency so the tuner is not reset to the
digital frequency. The work around is to remove the check
and always set the tuner to the specified frequency.

Signed-off-by: Mac Michaels <wmichaels1@earthlink.net>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/frontends/or51132.c |   25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/frontends/or51132.c	2005-09-04 22:24:24.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/frontends/or51132.c	2005-09-04 22:28:14.000000000 +0200
@@ -370,22 +370,19 @@ static int or51132_set_parameters(struct
 		or51132_setmode(fe);
 	}
 
-	/* Change only if we are actually changing the channel */
-	if (state->current_frequency != param->frequency) {
-		dvb_pll_configure(state->config->pll_desc, buf,
-				  param->frequency, 0);
-		dprintk("set_parameters tuner bytes: 0x%02x 0x%02x "
-			"0x%02x 0x%02x\n",buf[0],buf[1],buf[2],buf[3]);
-		if (i2c_writebytes(state, state->config->pll_address ,buf, 4))
-			printk(KERN_WARNING "or51132: set_parameters error "
-			       "writing to tuner\n");
+	dvb_pll_configure(state->config->pll_desc, buf,
+			  param->frequency, 0);
+	dprintk("set_parameters tuner bytes: 0x%02x 0x%02x "
+		"0x%02x 0x%02x\n",buf[0],buf[1],buf[2],buf[3]);
+	if (i2c_writebytes(state, state->config->pll_address ,buf, 4))
+		printk(KERN_WARNING "or51132: set_parameters error "
+		       "writing to tuner\n");
 
-		/* Set to current mode */
-		or51132_setmode(fe);
+	/* Set to current mode */
+	or51132_setmode(fe);
 
-		/* Update current frequency */
-		state->current_frequency = param->frequency;
-	}
+	/* Update current frequency */
+	state->current_frequency = param->frequency;
 	return 0;
 }
 

--

