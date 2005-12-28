Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbVL1T74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbVL1T74 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 14:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbVL1T74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 14:59:56 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:50439 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S964895AbVL1T7z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 14:59:55 -0500
Date: Wed, 28 Dec 2005 21:02:57 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Linus Torvalds <torvalds@osdl.org>
Cc: Ricardo Cerqueira <v4l@cerqueira.org>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Recursive dependency for SAA7134 in 2.6.15-rc7
Message-Id: <20051228210257.16c7a647.khali@linux-fr.org>
In-Reply-To: <1135726855.6709.4.camel@localhost>
References: <20051227215351.3d581b13.khali@linux-fr.org>
	<1135726855.6709.4.camel@localhost>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro, Linus,

> > I gave a try to 2.6.15-rc7 and "make menuconfig" tells me:
> > Warning! Found recursive dependency: VIDEO_SAA7134_ALSA VIDEO_SAA7134_OSS VIDEO_SAA7134_ALSA
> > 
> > This seems to be the consequence of this patch:
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=7bb9529602f8bb41a92275825b808a42ed33e5be
> > 
> > How do we fix that? menuconfig is indeed really confused by the current
> > setup. I have the following patch which makes it happier:
> 
> Please test this patch. It seems that provides the same behavior with a
> non-recursive logic.

Looks good to me, except for the coding style. Also, depending on both
SND and SOUND doesn't make much sense, as SND itself already depends on
SOUND, so we can simplify the SAA7134_ALSA dependency list.

Linus, can you please apply this patch before releasing 2.6.15?

Thanks.

Fix the cyclic dependency issue between CONFIG_SAA7134_ALSA and
CONFIG_SAA7134_OSS (credits to Mauro Carvalho Chehab.)

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/media/video/saa7134/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc7.orig/drivers/media/video/saa7134/Kconfig	2005-12-28 19:13:38.000000000 +0100
+++ linux-2.6.15-rc7/drivers/media/video/saa7134/Kconfig	2005-12-28 20:50:37.000000000 +0100
@@ -14,7 +14,7 @@
 
 config VIDEO_SAA7134_ALSA
 	tristate "Philips SAA7134 DMA audio support"
-	depends on VIDEO_SAA7134 && SOUND && SND && (!VIDEO_SAA7134_OSS || VIDEO_SAA7134_OSS = m)
+	depends on VIDEO_SAA7134 && SND
 	select SND_PCM_OSS
 	---help---
 	  This is a video4linux driver for direct (DMA) audio in
@@ -25,7 +25,7 @@
 
 config VIDEO_SAA7134_OSS
 	tristate "Philips SAA7134 DMA audio support (OSS, DEPRECATED)"
-	depends on VIDEO_SAA7134 && SOUND_PRIME && (!VIDEO_SAA7134_ALSA || VIDEO_SAA7134_ALSA = m)
+	depends on VIDEO_SAA7134 && SOUND_PRIME && (!VIDEO_SAA7134_ALSA || (VIDEO_SAA7134_ALSA=m && m))
 	---help---
 	  This is a video4linux driver for direct (DMA) audio in
 	  Philips SAA713x based TV cards using OSS


-- 
Jean Delvare
