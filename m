Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSDHOKj>; Mon, 8 Apr 2002 10:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313629AbSDHOKi>; Mon, 8 Apr 2002 10:10:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30472 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313628AbSDHOKh>;
	Mon, 8 Apr 2002 10:10:37 -0400
Date: Mon, 8 Apr 2002 16:10:40 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][CFT] IDE tagged command queueing support
Message-ID: <20020408141040.GF25984@suse.de>
In-Reply-To: <20020408120713.GB25984@suse.de> <3CB1806F.9090103@evision-ventures.com> <20020408125350.GE25984@suse.de> <3CB187AC.2040604@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08 2002, Martin Dalecki wrote:
> >- Separate scatterlist and dma table out from hwgroup. This is not
> >  really needed for TCQ, but saves doing a blk_rq_map_sg on a request
> >  more than once. If future ATA hardware would support more than one
> >  pending DMA operation per hwgroup, this would be useful even without
> >  TCQ.
> 
> Agreed.

If we do this, we need to make a decision about how many segments to
enable per command. As I stated, current is 32 which gives us (at least)
128kb per request. This is all we need right now, and I'm not too
convinced that doing much larger requests with 48-bit lba will buys us
_anything_ but bigger latency problems :-). This is just my speculation,
I have no numbers to back this up so far. Now, with a 1kb fs we are
limited to 32kb requests if we don't get good clustering. This might be
a small performance hit, but if you are writing big blocks in a 1kb fs
chances are good thaat you _will_ get good clustering (writing out the 4
consecutive buffer_heads stringed to the page) so I'm not convinced that
this will be a problem either.

So I'd just stick with PRD_SEGMENTS at 32 so far. The over head of going
to, eg, 64 would be 8 * 64 == 512 bytes per ata_request instead of the
current 256 right now. Ok, that's not a lot, but still :-)

> >- Use ata_request_t as the main request command. This is where I really
> >  want to go. I'm not saying that we need a complete IDE mid layer, but
> >  a private request type is a nice way to unify the passing of a general
> >  command around. So the taskfile stuff would remain very low level,
> >  ata_request would add the higher level parts. I could expand lots more
> >  on this, but I'm quite sure you know where I'm going :-)
> 
> Well I can assure you that we are not dragging the towell in two different
> directions - please see for example my notes about the ata_taskfile
> function having too much parameters ;-).

ata_taskfile(drive, ar);

or something to that effect should be very possible, it just requires
taking my generalization a bit further.

> >Note that the ata_request_t usage is a bit messy in the current patch,
> 
> I noted it already ;-)

I didn't want ata_request_t changes to pollute the patch too much :-)

> >that's merely because I was more focused on getting TCQ stable than
> >designing this out right now. So I think we should let it mature in the
> >TCQ patch for just a while before making any final commitments. Agreed?
> 
> No problem with me. I will just pull out the generally good stuff
> out of it OK? I hope this will not make the tracking of the
> alpha patches too difficult for you...

Yes that's fine with me, and feel free to extend the ata_request stuff
(and anything else). I'll adapt the tcq stuff and submit when ready.

> >In addition, there are small buglet fixes in the patch that should go to
> >general. I will extract these, I already send you one of these earlier
> >today.
> 
> Yes I have noticed this as well. However let's wait and see
> whatever maybe I'm able to save you the trobule and pull them
> out myself. Your alpha patch is "interresting" enough to have me
> a walk over it line by line anyway :-).

Alright, I'll let you ponder the stuff for a while and pull what you
want.

> I have to catch up with 2.5.8-pre2 anyway, since apparently this
> weekend was more about alcohol consumption for me then hacking...

Ahem, yes that part I know too :)

-- 
Jens Axboe

