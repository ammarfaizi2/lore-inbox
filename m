Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317751AbSGKKFs>; Thu, 11 Jul 2002 06:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317808AbSGKKFr>; Thu, 11 Jul 2002 06:05:47 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28631 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317751AbSGKKFq>;
	Thu, 11 Jul 2002 06:05:46 -0400
Date: Thu, 11 Jul 2002 12:08:28 +0200
From: Jens Axboe <axboe@suse.de>
To: Daniel Phillips <phillips@arcor.de>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Sebastian Droege <sebastian.droege@gmx.de>,
       linux-kernel@vger.kernel.org, akpm@zip.com.au, linux-mm@kvack.org
Subject: Re: [PATCH][RFT](2) minimal rmap for 2.5 - akpm tested
Message-ID: <20020711100828.GE808@suse.de>
References: <Pine.LNX.4.44L.0207101741380.14432-100000@imladris.surriel.com> <E17SPS5-00028e-00@starship> <20020711064712.GE1059@suse.de> <E17Sai1-0002T7-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17Sai1-0002T7-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11 2002, Daniel Phillips wrote:
> On Thursday 11 July 2002 08:47, Jens Axboe wrote:
> > On Wed, Jul 10 2002, Daniel Phillips wrote:
> > > ...I'd be testing right
> > > now to see if you're right, if the DAC960 driver compiled successfully.
> > > But it doesn't, and since my test machine won't boot without it... given a
> > > choice between diving into the driver and going back to work on directory
> > > hashing on 2.4...
> > 
> > Leonard has promised me to convert DAC960 to the "new" pci dma api for
> > years (or so it seems, actual date may vary, no purchase necessary). I
> > do have a Mylex controller here myself these days, so it's not
> > completely impossible that I may do it on a rainy day.
> 
> Well, tell me what the new api is and I'll dive in there.  For the record,

Documentation/DMA-mapping.txt. Also, DAC960 initial bio conversion
happened before the interface was finalized, so it may need changes in
that regard as well. Documentation/block/biodoc.txt is your friend there
:-)

a quick make drivers/block/DAC960.o shows the following stuff needs
changing immediately:

1) q->queue_lock is a pointer to a lock, not the lock itself. Probably
add a per-controller spinlock to DAC960_Controller_T, and pass that to
blk_init_queue(). Then change DAC960_AcquireControllerLock and friends
in DAC960.h accordingly.

2) wrt DMA mapping, see DAC960_BA_WriteHardwareMailbox
   (Virtual_to_Bus64, anyone?)...

And probably lots more will unearth once you start tackling it...

> I wouldn't be surprised if some other little things have rotted as well.

Heh, not at all :-)

-- 
Jens Axboe

