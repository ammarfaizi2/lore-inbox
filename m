Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVATVZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVATVZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 16:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVATVZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 16:25:29 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:5133 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261993AbVATVZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 16:25:18 -0500
Date: Thu, 20 Jan 2005 16:23:46 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, tv@lio96.de, herbert@gondor.apana.org.au,
       jgarzik@pobox.com, marcelo.tosatti@cyclades.com
Subject: [patch 2.4.29] i810_audio: offset LVI from CIV to avoid stalled start
Message-ID: <20050120212346.GD7687@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, tv@lio96.de,
	herbert@gondor.apana.org.au, jgarzik@pobox.com,
	marcelo.tosatti@cyclades.com
References: <20050120202258.GA7687@tuxdriver.com> <20050120210739.GC7687@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120210739.GC7687@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Offset LVI past CIV when starting DAC/ADC in order to prevent
stalled start.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Acked-by: Thomas Voegtle <tv@lio96.de>
Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
(Use this one...it doesn't depend on a non-existent patch...)

This fixes a "no sound" problem with Wolfenstein Enemy Territory and
(apparently) other games using the Quake3 engine.  It probably affects
some other OSS applications as well.

This recreates some code that had been removed from the i810_audio
driver around 5/2004.

 drivers/sound/i810_audio.c |   10 ++++++++++
 1 files changed, 10 insertions(+)

--- i810_audio-2.4/drivers/sound/i810_audio.c.orig	2005-01-20 14:41:43.914734688 -0500
+++ i810_audio-2.4/drivers/sound/i810_audio.c	2005-01-20 16:20:07.360411333 -0500
@@ -1062,10 +1062,20 @@
 	if (count < fragsize)
 		return;
 
+	/* if we are currently stopped, then our CIV is actually set to our
+	 * *last* sg segment and we are ready to wrap to the next.  However,
+	 * if we set our LVI to the last sg segment, then it won't wrap to
+	 * the next sg segment, it won't even get a start.  So, instead, when
+	 * we are stopped, we increment the CIV value to the next sg segment
+	 * to be played so that when we call start, things will operate
+	 * properly
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
