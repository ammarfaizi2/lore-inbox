Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbVHCSld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbVHCSld (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 14:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbVHCSjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 14:39:03 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:32008 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262402AbVHCSgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 14:36:52 -0400
Date: Wed, 3 Aug 2005 14:36:35 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, tv@lio96.de, herbert@gondor.apana.org.au,
       jgarzik@pobox.com, marcelo.tosatti@cyclades.com
Subject: [patch 2.4.32-pre1 (corrected)] i810_audio: offset LVI from CIV to avoid stalled start
Message-ID: <20050803183635.GF20949@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, tv@lio96.de,
	herbert@gondor.apana.org.au, jgarzik@pobox.com,
	marcelo.tosatti@cyclades.com
References: <20050120202258.GA7687@tuxdriver.com> <20050120210739.GC7687@tuxdriver.com> <20050120212346.GD7687@tuxdriver.com> <20050803181814.GD20949@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803181814.GD20949@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Offset LVI past CIV when starting DAC/ADC in order to prevent
stalled start.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Acked-by: Thomas Voegtle <tv@lio96.de>
Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
This fixes a "no sound" problem with Wolfenstein Enemy Territory and
(apparently) other games using the Quake3 engine.  It probably affects
some other OSS applications as well.

This recreates some code that had been removed from the i810_audio
driver around 5/2004.  The euqivalent patch has been in the 2.6 stream
since about 2.6.11.

 drivers/sound/i810_audio.c |   13 +++++++++++++
 1 files changed, 13 insertions(+)

diff --git a/drivers/sound/i810_audio.c b/drivers/sound/i810_audio.c
--- a/drivers/sound/i810_audio.c
+++ b/drivers/sound/i810_audio.c
@@ -1062,10 +1062,23 @@ static void __i810_update_lvi(struct i81
 	if (count < fragsize)
 		return;
 
+	/* if we are currently stopped, then our CIV is actually set to our
+	 * *last* sg segment and we are ready to wrap to the next.  However,
+	 * if we set our LVI to the last sg segment, then it won't wrap to
+	 * the next sg segment, it won't even get a start.  So, instead, when
+	 * we are stopped, we set both the LVI value and also we increment
+	 * the CIV value to the next sg segment to be played so that when
+	 * we call start, things will operate properly.  Since the CIV can't
+	 * be written to directly for this purpose, we set the LVI to CIV + 1
+	 * temporarily.  Once the engine has started we set the LVI to its
+	 * final value.
+	 */
 	if (!dmabuf->enable && dmabuf->ready) {
 		if (!(dmabuf->trigger & trigger))
 			return;
 
+		CIV_TO_LVI(port, 1);
+
 		start(state);
 		while (!(inb(port + OFF_CR) & ((1<<4) | (1<<2))))
 			;
-- 
John W. Linville
linville@tuxdriver.com
