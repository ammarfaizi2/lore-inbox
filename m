Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313609AbSDHMxt>; Mon, 8 Apr 2002 08:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313610AbSDHMxs>; Mon, 8 Apr 2002 08:53:48 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22532 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313609AbSDHMxs>;
	Mon, 8 Apr 2002 08:53:48 -0400
Date: Mon, 8 Apr 2002 14:53:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][CFT] IDE tagged command queueing support
Message-ID: <20020408125350.GE25984@suse.de>
In-Reply-To: <20020408120713.GB25984@suse.de> <3CB1806F.9090103@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08 2002, Martin Dalecki wrote:
> Jens Axboe wrote:
> >Hi,
> >
> >I've implemented tagged command queueing for ATA disk drives, and it's
> >now ready for people to give it a test spin. As it has had only limited
> >testing so far, please be very careful with it. It has been tested on
> >two drives so far, a GXP75-30gb and a GXP120-40gb, and with a PIIX4
> >controller:
> 
> OK after a cursory look I see that the patch contains quite
> a lot of ideas for the generic code itself. Do you think that it would
> be worth wile to extract them first or should the patch be just included
> in mainline. (I don't intent to interferre too much with your efforts to
> do something similar in 2.4.xx.)....

Good question, I've asked myself that too... Yeah I see some of my ideas
as being nice to have in mainline even without TCQ. The big one being
ata_request_t of course, there are some parts to this:

- Separate scatterlist and dma table out from hwgroup. This is not
  really needed for TCQ, but saves doing a blk_rq_map_sg on a request
  more than once. If future ATA hardware would support more than one
  pending DMA operation per hwgroup, this would be useful even without
  TCQ.

- Use ata_request_t as the main request command. This is where I really
  want to go. I'm not saying that we need a complete IDE mid layer, but
  a private request type is a nice way to unify the passing of a general
  command around. So the taskfile stuff would remain very low level,
  ata_request would add the higher level parts. I could expand lots more
  on this, but I'm quite sure you know where I'm going :-)

Note that the ata_request_t usage is a bit messy in the current patch,
that's merely because I was more focused on getting TCQ stable than
designing this out right now. So I think we should let it mature in the
TCQ patch for just a while before making any final commitments. Agreed?
Of course this will leave me with the pain of merging with your IDE
stuff every time a new -pre comes out (updating this patch from
2.5.1-pre where I last used it was _not_ funny! :-), but I can handle
that.

In addition, there are small buglet fixes in the patch that should go to
general. I will extract these, I already send you one of these earlier
today.

BTW, I just found an SMP race in the current patch. I'll send out a new
version later, for now it's here:

--- ../../linux-2.5.8-pre2/drivers/ide/ide.c	Mon Apr  8 14:53:06 2002
+++ drivers/ide/ide.c	Mon Apr  8 14:40:33 2002
@@ -1373,8 +1373,17 @@
 			break;
 		}
 
-		if (blk_queue_plugged(&drive->queue))
-			BUG();
+		/*
+		 * there's a small window between where the queue could be
+		 * replugged while we are in here when using tcq (in which
+		 * case the queue is probably empty anyways...), so check
+		 * and leave if appropriate. When not using tqc, this is
+		 * still a severe BUG!
+		 */
+		if (blk_queue_plugged(&drive->queue)) {
+			BUG_ON(!drive->using_tcq);
+			break;
+		}
 
 		/*
 		 * just continuing an interrupted request maybe

-- 
Jens Axboe

