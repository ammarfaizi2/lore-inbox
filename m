Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263434AbRFSB1k>; Mon, 18 Jun 2001 21:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263432AbRFSB1V>; Mon, 18 Jun 2001 21:27:21 -0400
Received: from mo.optusnet.com.au ([203.10.68.101]:12181 "EHLO
	mo.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S263093AbRFSB1T>; Mon, 18 Jun 2001 21:27:19 -0400
To: "Delio Brignoli" <nordkyn@tin.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i810 audio problem
In-Reply-To: <20010618141715.A534@argo.tin.it>
From: Michael <public@dgmo.org>
Date: 19 Jun 2001 11:27:08 +1000
In-Reply-To: "Delio Brignoli"'s message of "Mon, 18 Jun 2001 14:17:15 +0200"
Message-ID: <m1wv6945ub.fsf@mo.optusnet.com.au>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Delio Brignoli" <nordkyn@tin.it> writes:
> Switching from 2.4.2 to 2.4.5 breaks i810_audio on my intel MX440 based notebook:
> 
> After some (in fact a few) seconds of playback it gets stuck until the app closes and reopens /dev/dsp. (I do NOT use esd)
[..] 
> It goes on until I kill the app, then it says:
> 
> Jun 18 13:59:42 argo kernel: i810_audio: drain_dac, dma timeout?
> 
> Any idea(s), suggestions ...

What a co-incidence. I just hit this problem a few days ago.

The problem here is that:
1.	the dma buffer drains to zero.
2.	interrupt handler set LVI to CIV.
3.	app write more than a buffer size of data to dma buffer.
4.	LVI is un-changed!

There's a kludgey work-around I used, (never use more than
31 segments of the DMA buffer). (I.e. never use the last
dmabuf->fragsize of the dma buffer). This cures the hang
but it isn't an optimal solutions.

--- i810_audio.c.old	Tue Jun 19 11:22:56 2001
+++ i810_audio.c	Tue Jun 19 11:24:02 2001
@@ -1194,6 +1194,10 @@
		cnt = dmabuf->dmasize - swptr;
		if(cnt > (dmabuf->dmasize - dmabuf->count))
			cnt = dmabuf->dmasize - dmabuf->count;
+	
+		if (cnt >= dmabuf->fragsize && (dmabuf->count + cnt) >= dmabuf->dmasize)
+			cnt -= dmabuf->fragsize; 
+	
		spin_unlock_irqrestore(&state->card->lock, flags);

		if (cnt > count)


A better fix _may_ be to set CIV to LVI instead of the other way
around. (This assumes CIV is writeable). No testing at all;
may not be a fix. 

Something like:

diff -u i810_audio.c.old i810_audio.c
--- i810_audio.c.old	Tue Jun 19 11:22:56 2001
+++ i810_audio.c	Tue Jun 19 11:26:14 2001
@@ -807,11 +807,11 @@
	 * means no data on read, handle appropriately
	 */
	if(!rec && dmabuf->count == 0) {
-		outb(inb(port+OFF_CIV),port+OFF_LVI);
+		outb(inb(port+OFF_LVI),port+OFF_CIV);
		return;
	}
	if(rec && dmabuf->count == dmabuf->dmasize) {
-		outb(inb(port+OFF_CIV),port+OFF_LVI);
+		outb(inb(port+OFF_LVI),port+OFF_CIV);
		return;
	}
	/* swptr - 1 is the tail of our transfer */

but with testing and a glance at the docs. :)


Michael.



