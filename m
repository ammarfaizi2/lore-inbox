Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTKVHTy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 02:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbTKVHTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 02:19:53 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:51730 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262108AbTKVHTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 02:19:51 -0500
Date: Sat, 22 Nov 2003 18:19:35 +1100
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [I810_AUDIO] 3/x: Remove bogus CIV_TO_LVI
Message-ID: <20031122071935.GA27371@gondor.apana.org.au>
References: <20031122070931.GA27231@gondor.apana.org.au> <20031122071345.GA27303@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20031122071345.GA27303@gondor.apana.org.au>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch removes a pair of bogus LVI assignments.  The explanation in
the comment is wrong because the value of PCIB tells the hardware that
the DMA buffer can be processed even if LVI == CIV.

Setting LVI to CIV + 1 causes overruns when with short writes
(something that vmware is very fond of).
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p3

Index: kernel-source-2.4/drivers/sound/i810_audio.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/sound/i810_audio.c,v
retrieving revision 1.10
diff -u -r1.10 i810_audio.c
--- kernel-source-2.4/drivers/sound/i810_audio.c	22 Nov 2003 07:14:08 -0000	1.10
+++ kernel-source-2.4/drivers/sound/i810_audio.c	22 Nov 2003 07:16:08 -0000
@@ -1069,25 +1069,15 @@
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

--cWoXeonUoKmBZSoM--
