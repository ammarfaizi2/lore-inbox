Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbVAQSqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbVAQSqn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 13:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbVAQSqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 13:46:42 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:35597 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262466AbVAQSqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 13:46:13 -0500
Date: Mon, 17 Jan 2005 13:46:09 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
       jgarzik@pobox.com
Subject: [patch 2.4.29-rc1] i810_audio: offset LVI from CIV to avoid stalled start
Message-ID: <20050117184609.GE4348@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
	jgarzik@pobox.com
References: <20050117183708.GD4348@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117183708.GD4348@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Offset LVI past CIV when starting DAC/ADC in order to prevent
stalled start.
---
Here is the (working) patch I'm using against a later 2.4.  This makes
sound work fine with Enemy Territory.

 drivers/sound/i810_audio.c |   10 ++++++++++
 1 files changed, 10 insertions(+)

--- linux-test/drivers/sound/i810_audio.c.orig	2005-01-14 17:21:20.000000000 -0500
+++ linux-test/drivers/sound/i810_audio.c	2005-01-17 13:11:31.000000000 -0500
@@ -1081,10 +1081,20 @@ static void __i810_update_lvi(struct i81
 	if (count < fragsize)
 		return;
 
+	/* if we are currently stopped, then our CIV is actually set to our
+	 * *last* sg segment and we are ready to wrap to the next.  However,
+	 * if we set our LVI to the last sg segment, then it won't wrap to
+	 * the next sg segment, it won't even get a start.  So, instead, when
+	 * we are stopped, we set both the LVI value and also we increment
+	 * the CIV value to the next sg segment to be played so that when
+	 * we call start, things will operate properly
+	 */
 	if (!dmabuf->enable && dmabuf->ready) {
 		if (!(dmabuf->trigger & trigger))
 			return;
 
+		CIV_TO_LVI(state->card, port, 1);
+
 		start(state);
 		while (!(I810_IOREADB(state->card, port + OFF_CR) & ((1<<4) | (1<<2))))
 			;
