Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282106AbRKWLVm>; Fri, 23 Nov 2001 06:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282111AbRKWLVc>; Fri, 23 Nov 2001 06:21:32 -0500
Received: from hal.astr.lu.lv ([195.13.134.67]:18048 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S282106AbRKWLVS>;
	Fri, 23 Nov 2001 06:21:18 -0500
Message-Id: <200111231121.fANBLEi00909@hal.astr.lu.lv>
Content-Type: text/plain; charset=US-ASCII
From: Andris Pavenis <pavenis@latnet.lv>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.15: fix for i810_audio problems under KDE
Date: Fri, 23 Nov 2001 13:21:14 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i810_audio doesn't work under KDE for 2.4.15 (realy already for a rather 
long time). I'm only getting garbled sound unless i810_audio.c is patched. 
Perhaps the reason is use of non blocked output by artsd.

Included patch reverts one change between 2.4.6-ac1 and 2.4.6-ac2 and 
also includes patch from Tobias Diedrich 
( http://www.cs.helsinki.fi/linux/linux-kernel/2001-44/1023.html ).
As far as I have tested it fixes all problems I have met with i810_audio.

Andris

--- i810_audio.c~1	Tue Nov 20 11:23:24 2001
+++ i810_audio.c	Tue Nov 20 13:08:05 2001
@@ -1405,10 +1405,9 @@
 		if (dmabuf->count < 0) {
 			dmabuf->count = 0;
 		}
-		cnt = dmabuf->dmasize - dmabuf->fragsize - dmabuf->count;
-		// this is to make the copy_from_user simpler below
-		if(cnt > (dmabuf->dmasize - swptr))
-			cnt = dmabuf->dmasize - swptr;
+		cnt = dmabuf->dmasize - swptr;
+		if(cnt > (dmabuf->dmasize - dmabuf->count))
+			cnt = dmabuf->dmasize - dmabuf->count;
 		spin_unlock_irqrestore(&state->card->lock, flags);
 
 #ifdef DEBUG2
@@ -1419,16 +1418,13 @@
 		if (cnt <= 0) {
 			unsigned long tmo;
 			// There is data waiting to be played
+			i810_update_lvi(state,0);
 			if(!dmabuf->enable && dmabuf->count) {
 				/* force the starting incase SETTRIGGER has been used */
 				/* to stop it, otherwise this is a deadlock situation */
 				dmabuf->trigger |= PCM_ENABLE_OUTPUT;
 				start_dac(state);
 			}
-			// Update the LVI pointer in case we have already
-			// written data in this syscall and are just waiting
-			// on the tail bit of data
-			i810_update_lvi(state,0);
 			if (file->f_flags & O_NONBLOCK) {
 				if (!ret) ret = -EAGAIN;
 				goto ret;
@@ -1860,7 +1856,7 @@
 		if(dmabuf->mapped)
 			abinfo.bytes = dmabuf->count;
 		else
-			abinfo.bytes = dmabuf->dmasize - dmabuf->count;
+			abinfo.bytes = dmabuf->dmasize - dmabuf->fragsize - dmabuf->count;
 		abinfo.fragments = abinfo.bytes / dmabuf->userfragsize;
 		spin_unlock_irqrestore(&state->card->lock, flags);
 #ifdef DEBUG


