Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266688AbRHWRPb>; Thu, 23 Aug 2001 13:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266797AbRHWRPU>; Thu, 23 Aug 2001 13:15:20 -0400
Received: from hal.astr.lu.lv ([195.13.134.67]:8964 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S266688AbRHWRPO>;
	Thu, 23 Aug 2001 13:15:14 -0400
Message-Id: <200108231715.f7NHFGx00363@hal.astr.lu.lv>
Content-Type: text/plain; charset=US-ASCII
From: Andris Pavenis <pavenis@latnet.lv>
To: Doug Ledford <dledford@redhat.com>
Subject: Re: i810 audio doesn't work with 2.4.9
Date: Thu, 23 Aug 2001 20:15:16 +0300
X-Mailer: KMail [version 1.3]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E15ZGQv-0008Qb-00@the-village.bc.nu> <200108220848.f7M8mVh00441@hal.astr.lu.lv> <3B850C9A.7080002@redhat.com>
In-Reply-To: <3B850C9A.7080002@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 August 2001 17:00, Doug Ledford wrote:
> Andris Pavenis wrote:
> > Got incremental diffs between ac versions since 2.4.5.
> > Applied all diffs to 2.4.5 version of i810_audio.c except one between
> > 2.4.6-ac1 and 2.4.6-ac2 As result i810 audio seems to work
>
> Can you send me that incremental patch you left out.  I would like to
> look at it to see what's going on.
>

i810_audio.c works for me if all patches except following is aplied (it's a part of update
from 2.4.6-ac1 to 2.4.6-ac2)

Andris

--- linux-2.4.6-ac1/drivers/sound/i810_audio.c	Sun Jul  8 20:45:41 2001
+++ linux-2.4.6-ac2/drivers/sound/i810_audio.c	Sun Jul  8 21:37:01 2001
@@ -1209,23 +1211,30 @@
 		if (dmabuf->count < 0) {
 			dmabuf->count = 0;
 		}
-		cnt = dmabuf->dmasize - swptr;
-		if(cnt > (dmabuf->dmasize - dmabuf->count))
-			cnt = dmabuf->dmasize - dmabuf->count;
+		cnt = dmabuf->dmasize - dmabuf->fragsize - dmabuf->count;
+		// this is to make the copy_from_user simpler below
+		if(cnt > (dmabuf->dmasize - swptr))
+			cnt = dmabuf->dmasize - swptr;
 		spin_unlock_irqrestore(&state->card->lock, flags);
 
+#ifdef DEBUG2
+		printk(KERN_INFO "i810_audio: i810_write: %d bytes available space\n", cnt);
+#endif
 		if (cnt > count)
 			cnt = count;
 		if (cnt <= 0) {
 			unsigned long tmo;
 			// There is data waiting to be played
-			i810_update_lvi(state,0);
 			if(!dmabuf->enable && dmabuf->count) {
 				/* force the starting incase SETTRIGGER has been used */
 				/* to stop it, otherwise this is a deadlock situation */
 				dmabuf->trigger |= PCM_ENABLE_OUTPUT;
 				start_dac(state);
 			}
+			// Update the LVI pointer in case we have already
+			// written data in this syscall and are just waiting
+			// on the tail bit of data
+			i810_update_lvi(state,0);
 			if (file->f_flags & O_NONBLOCK) {
 				if (!ret) ret = -EAGAIN;
 				return ret;

