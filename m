Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315718AbSENNba>; Tue, 14 May 2002 09:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315720AbSENNba>; Tue, 14 May 2002 09:31:30 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:48644
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315718AbSENNb2>; Tue, 14 May 2002 09:31:28 -0400
Date: Tue, 14 May 2002 06:27:47 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Neil Conway <nconway.list@ukaea.org.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Russell King <rmk@arm.linux.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <3CE10B2B.822CA194@ukaea.org.uk>
Message-ID: <Pine.LNX.4.10.10205140610570.15295-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Arbitrate your incoming interrupts.  In the classic dual interrupt you are
scott free for the most part, erm interrupt sharing will eat you alive.
HBA's w/ N channels will eat the BLOCK Layer of lunch and purge it for
dinner.  If you notice SCSI originally had queues based on the HBA for a
reason,  one can read all day long form any devices on the chain, but
issue a write and everything grinds to a halt.

The original taskfile driver was to permit set and go calls of a
multi-level queues.  It was also to permit fake local tags with additional
load balancing on the channel w/ mixed devices and/or w/ broken hardware
force a simplex behavior.

hwif[n].drives[m].queue     \
			     --- hwif[n].queue
hwif[n].drives[m+1].queue   /
							hwgroup.queue
hwif[n+1].drives[m].queue   \
			     --- hwif[n+1].queue
hwif[n+1].drives[m+1].queue /

 
In the future:

hwif[0].drives[0].queue   <> hwif[0].queue
hwif[1].drives[0].queue   <> hwif[1].queue
hwif[2].drives[0].queue   <> hwif[2].queue
...
hwif[n-1].drives[0].queue <> hwif[n-1].queue
hwif[n].drives[0].queue   <> hwif[n].queue

Where "n" ranges from 2->20  all on the same hwgroup.queue

Now how is your spinlock going to process all of those in parallel?
I can tell you first hand, it can't.

Cheers,

On Tue, 14 May 2002, Neil Conway wrote:

> Alan Cox wrote:
> > If the queue abstraction is right then the block layer should do all the
> > synchronization work that is required. 
> 
> I think you're wrong Alan.  Take a good IDE chipset as an example: both
> channels can be active at the same time, but you still can't talk to one
> drive while the other drive on the same channel is DMAing.
> 
> I'm not a block layer expert, but it appears to me that the block layer
> only synchronises requests by use of the spinlock.  If I'm right, then
> the block layer has no way of knowing that hda is DMAing when a request
> is initiated for hdb.  This was the whole reason (as I see it) that
> hwgroup->busy existed: to prevent attempts to use the same IDE cable for
> two things at the same time.
> 
> It doesn't matter how you perform the queue abstraction in this case:
> the fact that the device+channel+cable is busy in an asynchronous manner
> makes it impossible for the block layer to deal with this.  [[Or am I
> way off base?!]]
> 
> The right way is the way it is being done at present surely: if the busy
> flag on the hwgroup is set, then ide_do_request() just returns.  (NB:
> When I say "right way", I don't mean to imply that the code is elegant,
> desirable, or even bug-free, just that it correctly handles this busy
> state.)
> 
> >It may cost a few cycles on the odd
> > case you can do overlapped command setup but that versus a nasty locking
> > mess its got to be better to lose those few cycles.
> 
> Well, Jens and others are busy implementing TCQ where things are just so
> much easier to fsck up :-))
> 
> > I don't even Martin here, the ide locking is currently utterly vile
> 
> Agreed, but surely with some concerted effort we can truly fix the IDE
> code.  Can't be beyond us all can it?
> 
> Neil
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

