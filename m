Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVDDIVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVDDIVn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 04:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVDDIVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 04:21:43 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:35343 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261171AbVDDIVk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 04:21:40 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: sud@latinsud.com (SuD Alex)
Subject: Re: Oops in set_spdif_output in i810_audio
Cc: linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <42507F12.6070009@latinsud.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DIMpA-00058I-00@gondolin.me.apana.org.au>
Date: Mon, 04 Apr 2005 18:20:44 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SuD Alex <sud@latinsud.com> wrote:
> 
> * It seems to me that it detects only 1 card with 1 only codec which is 
> the sound card (sound works if i avoid the null pointer oops). So one of 
> the problems is the wrong detection.
> Googling i found that  jgarzik already got a patch for this 
> (ac97_codec.c:158):
> +    {0x43585430, "CXT48",            &default_ops,        
> AC97_DELUDED_MODEM },

Can you please check if this patch works? It's what ALSA does.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
===== sound/oss/ac97_codec.c 1.24 vs edited =====
--- 1.24/sound/oss/ac97_codec.c	2005-03-08 15:41:36 +11:00
+++ edited/sound/oss/ac97_codec.c	2005-04-04 16:07:11 +10:00
@@ -721,14 +721,15 @@
  
 static int ac97_check_modem(struct ac97_codec *codec)
 {
+	unsigned int eid;
+
 	/* Check for an AC97 1.0 soft modem (ID1) */
 	if(codec->codec_read(codec, AC97_RESET) & 2)
 		return 1;
 	/* Check for an AC97 2.x soft modem */
 	codec->codec_write(codec, AC97_EXTENDED_MODEM_ID, 0L);
-	if(codec->codec_read(codec, AC97_EXTENDED_MODEM_ID) & 1)
-		return 1;
-	return 0;
+	eid = codec->codec_read(codec, AC97_EXTENDED_MODEM_ID);
+	return eid != 0xffff && (eid & 1);
 }
 
 
