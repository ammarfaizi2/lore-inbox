Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbVAQSpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbVAQSpb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 13:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbVAQSna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 13:43:30 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:29453 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262466AbVAQShN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 13:37:13 -0500
Date: Mon, 17 Jan 2005 13:37:08 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: herbert@gondor.apana.org.au, jgarzik@pobox.com
Subject: [rfc] i810_audio: offset LVI from CIV to avoid stalled start
Message-ID: <20050117183708.GD4348@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
	jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Some" OSS applications have trouble with later versions of the
i810_audio driver.  Wolfenstein Enemy Territory from idSoftware is
one such application.

I did a little legwork in BK and tracked-down the exact change which
caused the break.  The changelog comments are dismissive to the
original code.  However, I find that recreating a patch equivalent
to what was removed restores sound to the game.

Anyone have any suggestions for a patch that a) works; and, b)
accounts for the concerns expressed in the changelog?

John

P.S. Here is the problematic patch: (DO NOT TRY TO APPLY THIS)

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/05/11 03:51:54-04:00 herbert@gondor.apana.org.au 
#   [sound i810] remove bogus CIV_TO_LVI
#   
#   This patch removes a pair of bogus LVI assignments.  The explanation in
#   the comment is wrong because the value of PCIB tells the hardware that
#   the DMA buffer can be processed even if LVI == CIV.
#   
#   Setting LVI to CIV + 1 causes overruns when with short writes
#   (something that vmware is very fond of).
# 
# drivers/sound/i810_audio.c
#   2004/05/11 03:51:52-04:00 herbert@gondor.apana.org.au +0 -10
#   [sound i810] remove bogus CIV_TO_LVI
#   
#   This patch removes a pair of bogus LVI assignments.  The explanation in
#   the comment is wrong because the value of PCIB tells the hardware that
#   the DMA buffer can be processed even if LVI == CIV.
#   
#   Setting LVI to CIV + 1 causes overruns when with short writes
#   (something that vmware is very fond of).
# 
diff -Nru a/drivers/sound/i810_audio.c b/drivers/sound/i810_audio.c
--- a/drivers/sound/i810_audio.c	2005-01-14 16:20:27 -05:00
+++ b/drivers/sound/i810_audio.c	2005-01-14 16:20:27 -05:00
@@ -1079,25 +1079,15 @@
 	else
 		port += dmabuf->write_channel->port;
 
-	/* if we are currently stopped, then our CIV is actually set to our
-	 * *last* sg segment and we are ready to wrap to the next.  However,
-	 * if we set our LVI to the last sg segment, then it won't wrap to
-	 * the next sg segment, it won't even get a start.  So, instead, when
-	 * we are stopped, we set both the LVI value and also we increment
-	 * the CIV value to the next sg segment to be played so that when
-	 * we call start_{dac,adc}, things will operate properly
-	 */
 	if (!dmabuf->enable && dmabuf->ready) {
 		if(rec && dmabuf->count < dmabuf->dmasize &&
 		   (dmabuf->trigger & PCM_ENABLE_INPUT))
 		{
-			CIV_TO_LVI(port, 1);
 			__start_adc(state);
 			while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;
 		} else if (!rec && dmabuf->count &&
 			   (dmabuf->trigger & PCM_ENABLE_OUTPUT))
 		{
-			CIV_TO_LVI(port, 1);
 			__start_dac(state);
 			while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;
 		}
-- 
John W. Linville
linville@tuxdriver.com
