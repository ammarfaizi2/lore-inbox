Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316340AbSEOFum>; Wed, 15 May 2002 01:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316341AbSEOFul>; Wed, 15 May 2002 01:50:41 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:33285
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316340AbSEOFuk>; Wed, 15 May 2002 01:50:40 -0400
Date: Tue, 14 May 2002 22:47:41 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE PIO write Fix #2
In-Reply-To: <abroiv$ifs$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10205142239190.20196-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2002, Linus Torvalds wrote:

> In article <3CE0D6DE.8090407@evision-ventures.com>,
> Martin Dalecki  <dalecki@evision-ventures.com> wrote:
> >> 
> >> --- linux-2.5.15/drivers/ide/ide-taskfile.c.orig	Fri May 10 11:49:35 2002
> >> +++ linux-2.5.15/drivers/ide/ide-taskfile.c	Tue May 14 10:40:43 2002
> >> @@ -606,7 +606,7 @@
> >>  		if (!ide_end_request(drive, rq, 1))
> >>  			return ide_stopped;
> >>  
> >> -	if ((rq->current_nr_sectors==1) ^ (stat & DRQ_STAT)) {
> >> +	if ((rq->nr_sectors == 1) ^ ((stat & DRQ_STAT) != 0)) {
> 
> Well, that's definitely an improvement - the original code makes no
> sense at all, since it's doing a bitwise xor on two bits that are not
> the same, and then uses that as a boolean value.
> 
> Your change at least makes it use the bitwise xor on properly logical
> values, making the bitwise xor work as a _logical_ xor. 
> 
> Although at that point I'd just get rid of the xor, and replace it by
> the "!=" operation - which is equivalent on logical ops.
> 
> >>  		pBuf = ide_map_rq(rq, &flags);
> >>  		DTF("write: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);
> >
> >
> >Hmm. There is something else that smells in the above, since the XOR operator
> >doesn't seem to be proper. Why shouldn't we get DRQ_STAT at all on short
> >request? Could you perhaps just try to replace it with an OR?
> 
> The XOR operation is a valid op, if you just use it on valid values,
> which the patch does seem to make it do.
> 
> I don't know whether the logic is _correct_ after that, but at least
> there is some remote chance that it might make sense.

And here is the key why your solutions pio out was wrong in the past.
You think like a geek and not like the hardware.  But it is your^W the
masses data you continue to screw over.  Again you may be a wiz kid with a
cool OS, but you are still clueless about storage.

Maybe you should learn from your mistakes.

Try removing the HBA hotrodding of the DMA engine.
If the hardware is not designed to run at the latest standard, sane people
do not push it there.  ATA 100 takes 4 clock where ATA 133 takes three
clocks to move the same amount of data.  I hope this is a big enough clue
for you back out most of the experimental crap inserted.  Now to be even
more clear, the dropped data clock (ie data corruption lost) happens in
both directions and at the same location on the trace.  However, who cares
it is a development kernel, lets continues to trash peoples data silently!

Later,


Andre Hedrick
LAD Storage Consulting Group

