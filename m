Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267451AbTGLA7z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 20:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267462AbTGLA7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 20:59:54 -0400
Received: from unity.unh.edu ([132.177.137.40]:29381 "EHLO unity.unh.edu")
	by vger.kernel.org with ESMTP id S267451AbTGLA7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 20:59:51 -0400
Date: Fri, 11 Jul 2003 21:14:29 -0400
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
To: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH] [2.5] maestro volume tuning
Message-ID: <20030712011428.GA4694@bouh.unh.edu>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
Mail-Followup-To: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i-nntp
X-MailScanner-Information: http://pubpages.unh.edu/notes/mailfiltering.html
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-8, required 5,
	BAYES_10, PATCH_UNIFIED_DIFF, USER_AGENT_MUTT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a patch which tunes the volume control of maestro sound boards:
The log conversion seems not good for PCM and CD. The volume buttons
incrementing / decrementing the main volume by 10 on 100 is too much, I'd
rather set it to 5.

Regards,
Samuel Thibault

diff -ur linux-2.5.71-orig/sound/oss/maestro.c linux-2.5.71-perso/sound/oss/maestro.c
--- linux-2.5.71-orig/sound/oss/maestro.c	2003-06-14 17:13:46.000000000 -0400
+++ linux-2.5.71-perso/sound/oss/maestro.c	2003-07-06 13:51:23.000000000 -0400
@@ -726,6 +726,12 @@
 			left = (left * mh->scale) / 100;
 			if ((left == 0) && (right == 0))
 				val |= 0x8000;
+		} else if (mixer == SOUND_MIXER_PCM || mixer == SOUND_MIXER_CD) {
+			/* log conversion seems bad for them */
+			if ((left == 0) && (right == 0))
+				val = 0x8000;
+			right = ((100 - right) * mh->scale) / 100;
+			left = ((100 - left) * mh->scale) / 100;
 		} else {
 			/* log conversion for the stereo controls */
 			if((left == 0) && (right == 0))
@@ -1937,12 +1943,12 @@
 		   manner by adjusting the master mixer volume. */
 		volume = c->mix.mixer_state[0] & 0xff;
 		if (vol_evt == UP_EVT) {
-			volume += 10;
+			volume += 5;
 			if (volume > 100)
 				volume = 100;
 		}
 		else if (vol_evt == DOWN_EVT) {
-			volume -= 10;
+			volume -= 5;
 			if (volume < 0)
 				volume = 0;
 		} else {
