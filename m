Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVASJDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVASJDe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 04:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVASJAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 04:00:00 -0500
Received: from er-systems.de ([217.172.180.163]:11242 "EHLO er-systems.de")
	by vger.kernel.org with ESMTP id S261692AbVASI7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 03:59:08 -0500
Date: Wed, 19 Jan 2005 09:59:43 +0100 (CET)
From: Thomas Voegtle <tv@lio96.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [rfc] i810_audio: offset LVI from CIV to avoid stalled start
In-Reply-To: <20050118224248.GA17785@gondor.apana.org.au>
Message-ID: <Pine.LNX.4.58.0501190954590.28787@er-systems.de>
References: <20050117183708.GD4348@tuxdriver.com> <20050117203930.GA9605@gondor.apana.org.au>
 <20050117214420.GH4348@tuxdriver.com> <20050117232323.GA21365@gondor.apana.org.au>
 <20050118180745.GA6883@tuxdriver.com> <20050118224248.GA17785@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2005, Herbert Xu wrote:

> On Tue, Jan 18, 2005 at 01:07:47PM -0500, John W. Linville wrote:
> > 
> > No, that does not fix it. :-(  In fact, it doesn't seem to alter the
> > problem at all...
> 
> OK.  In that case I agree with your patch.  The overruns that I
> attributed to it were probably caused by other bugs that's been
> fixed since.
> 
> Cheers,
> 


Here is the same patch against 2.6.11-rc1-bk6. Works for me.


--- linux-2.6.11-rc1-bk6/sound/oss/i810_audio.c.old	2005-01-19 09:47:20.438345600 +0100
+++ linux-2.6.11-rc1-bk6/sound/oss/i810_audio.c	2005-01-19 09:48:43.618700264 +0100
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
 Thomas Vögtle    email: thomas@voegtle-clan.de
 ----- http://www.voegtle-clan.de/thomas ------
