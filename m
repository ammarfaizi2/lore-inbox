Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314285AbSEMQ4H>; Mon, 13 May 2002 12:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314289AbSEMQ4G>; Mon, 13 May 2002 12:56:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21383 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314285AbSEMQ4F>;
	Mon, 13 May 2002 12:56:05 -0400
Date: Mon, 13 May 2002 18:55:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.15 IDE 62
Message-ID: <20020513165544.GA30516@suse.de>
In-Reply-To: <3CDFDF8D.1050204@evision-ventures.com> <Pine.LNX.4.44.0205130950350.19524-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13 2002, Linus Torvalds wrote:
> > Well on the channel level they are safe modulo cmd640 and rz1000.
> > We can handle them by serializing them on the global lock
> > in do_ide_request. Like:
> >
> > if (ch->drive[0].serialized|| ch->drive[1].serialized)
> >     then
> >     spin_lock(serialize_lock);
> 
> NO.
> 
> The whole point of having a per-queue lock pointer is that this should be
> initialized at queue creation time. Don't add more crud to the IDE
> locking, we want to get _rid_ of the locking that IDE has thought
> (traditionally incorrectly) that it could do better than the higher
> levels.
> 
> So when you create the queue, you should decide at THAT point whether you
> just want to pass in the same lock or not.
> 
> For a cmd640, you make sure that both queues get created with the same
> lock. And for non-broken chipsets, you use per-queue locks.
> 
> And then you make sure that nobody EVER uses any other lock than the queue
> lock.

Completely agreed. And when we finally use the queue as the
serialization point for "everything", then it all falls into place
nicely.

-- 
Jens Axboe

