Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVAQXdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVAQXdQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 18:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVAQXag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 18:30:36 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:59912 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261539AbVAQXZY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 18:25:24 -0500
Date: Tue, 18 Jan 2005 10:23:23 +1100
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [rfc] i810_audio: offset LVI from CIV to avoid stalled start
Message-ID: <20050117232323.GA21365@gondor.apana.org.au>
References: <20050117183708.GD4348@tuxdriver.com> <20050117203930.GA9605@gondor.apana.org.au> <20050117214420.GH4348@tuxdriver.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20050117214420.GH4348@tuxdriver.com>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 17, 2005 at 04:44:22PM -0500, John W. Linville wrote:
> 
> Enemy Territory is available for free (as in beer) download from
> www.enemy-territory.com.  Sound plays almost immediately once the
> game is started.
> 
> Is this sufficient?

Sure, I don't mind trying it out :)

In the mean time, does this patch fix your problem as well?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

===== sound/oss/i810_audio.c 1.76 vs edited =====
--- 1.76/sound/oss/i810_audio.c	2005-01-08 16:44:18 +11:00
+++ edited/sound/oss/i810_audio.c	2005-01-18 10:20:42 +11:00
@@ -1196,18 +1196,21 @@
 	if (count < fragsize)
 		return;
 
+	/* MASKP2(swptr, fragsize) - 1 is the tail of our transfer */
+	x = MODULOP2(MASKP2(dmabuf->swptr, fragsize) - 1, dmabuf->dmasize);
+	x >>= dmabuf->fragshift;
+
 	if (!dmabuf->enable && dmabuf->ready) {
 		if (!(dmabuf->trigger & trigger))
 			return;
 
+		I810_IOWRITEB(x, state->card, port + OFF_LVI);
 		start(state);
 		while (!(I810_IOREADB(state->card, port + OFF_CR) & ((1<<4) | (1<<2))))
 			;
+		return;
 	}
 
-	/* MASKP2(swptr, fragsize) - 1 is the tail of our transfer */
-	x = MODULOP2(MASKP2(dmabuf->swptr, fragsize) - 1, dmabuf->dmasize);
-	x >>= dmabuf->fragshift;
 	I810_IOWRITEB(x, state->card, port + OFF_LVI);
 }
 

--huq684BweRXVnRxX--
