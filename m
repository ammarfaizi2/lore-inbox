Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280911AbRKGTCR>; Wed, 7 Nov 2001 14:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280909AbRKGTCG>; Wed, 7 Nov 2001 14:02:06 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:11167 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S280911AbRKGTBr>; Wed, 7 Nov 2001 14:01:47 -0500
Date: Wed, 7 Nov 2001 19:40:01 +0100
From: Tobias Diedrich <ranma@gmx.at>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make i810_audio GETOSPACE consistent with i810_write()
Message-ID: <20011107194001.A5318@router.ranmachan.dyndns.org>
Mail-Followup-To: Tobias Diedrich <ranma@gmx.at>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This fixes a bug in i810_ioctl(), which made the GETOSPACE ioctl return
a different value than that checked against in i810_write.

>From i810_write():
|                cnt = dmabuf->dmasize - dmabuf->fragsize - dmabuf->count;
|                // this is to make the copy_from_user simpler below
|                if(cnt > (dmabuf->dmasize - swptr))
|                        cnt = dmabuf->dmasize - swptr;
|                spin_unlock_irqrestore(&state->card->lock, flags);
|
|#ifdef DEBUG2
|                printk(KERN_INFO "i810_audio: i810_write: %d bytes available spa
|ce\n", cnt);
|#endif

where cnt is the space available.

Please apply


--- linux-2.4.10-ac12/drivers/sound/i810_audio.c	Wed Nov  7 19:15:31 2001
+++ linux-2.4.10-ifia/drivers/sound/i810_audio.c	Wed Nov  7 19:02:10 2001
@@ -1860,7 +1860,7 @@
 		if(dmabuf->mapped)
 			abinfo.bytes = dmabuf->count;
 		else
-			abinfo.bytes = dmabuf->dmasize - dmabuf->count;
+			abinfo.bytes = dmabuf->dmasize - dmabuf->fragsize - dmabuf->count;
 		abinfo.fragments = abinfo.bytes / dmabuf->userfragsize;
 		spin_unlock_irqrestore(&state->card->lock, flags);
 #ifdef DEBUG

-- 
Tobias								PGP: 0x9AC7E0BC
Hannover Fantreffen ML: mailto:fantreffen-request@mantrha.de?subject=subscribe
Manga & Anime Treff Hannover: http://www.mantrha.de/
