Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267133AbTBNCRd>; Thu, 13 Feb 2003 21:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268157AbTBNCRd>; Thu, 13 Feb 2003 21:17:33 -0500
Received: from ool-4351594a.dyn.optonline.net ([67.81.89.74]:63493 "EHLO
	badula.org") by vger.kernel.org with ESMTP id <S267133AbTBNCRc>;
	Thu, 13 Feb 2003 21:17:32 -0500
Date: Thu, 13 Feb 2003 21:27:14 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [net drvr] starfire driver update for 2.5.60
In-Reply-To: <3E4C3A8A.3030207@pobox.com>
Message-ID: <Pine.LNX.4.44.0302132111050.3318-100000@moisil.badula.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2003, Jeff Garzik wrote:

> I'm curious about the ring-wrapping code... the comments indicate you 
> may not have fully investigated the ring-wrapping semantics?

I think you're misreading the code...

The problem with the starfire is that you can only wrap the ring after the 
_first_ descriptor in a SG skbuff. That's why the code is more complicated 
than it would otherwise be.

> Neither style requires any special handling of "wrap" cases, which your 
> patch adds..  Your patch adds things like arbitrary padding of 4 tx 
> slots, where you might as well add a comment "/* for luck! */".

Again, I think you're misinterpreting the 4 (which is, as I mentioned, 
hardcoded and somewhat arbitrary).

All I'm doing there is making sure there are at least 4 slots available 
before waking up the Tx queue. Why? because otherwise you might end up not 
having enough slots free for all the descriptors needed for a SG skbuff.

Otherwise, the Becker-style cur_tx <-> dirty_tx handling is in effect, and 
works as expected.

> Why not 
> actually nail down the problems the code is obvious working around? 

Because there aren't any? :-)

There were two big problems in the old driver:

- it was still using the Becker-era tx_full flag, which was non-atomic and 
therefore had a race between start_tx and intr_handler.
- it was failing to stop the DMA engines on ifdown, which could end up 
corrupting random memory (also inherited from the Becker driver)

The reason all the Tx handling has changed is due to the 64-bit support. 
The starfire does have a SG descriptor, but it can only handle 32-bit 
buffers. If you want 64-bit, you have to use chained single-buffer 
descriptors. So I just changed the code to always use chained 
single-buffer descriptors, for both 32-bit and 64-bit buffers -- but 
that's again the reason the driver now reserves more than one slot before 
turning Tx back on.

> A minor style point too, "s/struct foodesc/foodesc/" is going the 
> opposite of preferred.

The alternative is a lot of #ifdef's all over the place. Thanks but no 
thanks, I'm no fan of typedef's but ifdef's are worse.

> This is why I have not applied your patch when it was sent to me...

Well, you didn't say much at the time... :-) so I just assumed you were 
mostly happy with it.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

