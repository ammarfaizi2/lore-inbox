Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVATUcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVATUcF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 15:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVATU3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 15:29:53 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:52236 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261928AbVATU1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 15:27:35 -0500
Date: Thu, 20 Jan 2005 15:26:00 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: tv@lio96.de, herbert@gondor.apana.org.au, jgarzik@pobox.com, akpm@osdl.org
Subject: [patch 2.6.11-rc1] i810_audio: offset LVI from CIV to avoid stalled start
Message-ID: <20050120202600.GB7687@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, tv@lio96.de,
	herbert@gondor.apana.org.au, jgarzik@pobox.com, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
driver around 5/2004.  (This is the 2.6-based version of this patch.)

 sound/oss/i810_audio.c |   10 ++++++++++
 1 files changed, 10 insertions(+)

--- i810_audio-2.6/sound/oss/i810_audio.c.orig	2005-01-20 14:39:53.108927161 -0500
+++ i810_audio-2.6/sound/oss/i810_audio.c	2005-01-20 14:39:53.146921952 -0500
@@ -1196,10 +1196,20 @@
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
-- 
John W. Linville
linville@tuxdriver.com
