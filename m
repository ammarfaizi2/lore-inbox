Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314281AbSEMQyK>; Mon, 13 May 2002 12:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314285AbSEMQyJ>; Mon, 13 May 2002 12:54:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13843 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314281AbSEMQyH>; Mon, 13 May 2002 12:54:07 -0400
Date: Mon, 13 May 2002 09:54:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Jens Axboe <axboe@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.15 IDE 62
In-Reply-To: <3CDFDF8D.1050204@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0205130950350.19524-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Martin - just a heads up that I'm not applying 62, so don't make new IDE
  patches relative to that ]

On Mon, 13 May 2002, Martin Dalecki wrote:
>
> Well on the channel level they are safe modulo cmd640 and rz1000.
> We can handle them by serializing them on the global lock
> in do_ide_request. Like:
>
> if (ch->drive[0].serialized|| ch->drive[1].serialized)
>     then
>     spin_lock(serialize_lock);

NO.

The whole point of having a per-queue lock pointer is that this should be
initialized at queue creation time. Don't add more crud to the IDE
locking, we want to get _rid_ of the locking that IDE has thought
(traditionally incorrectly) that it could do better than the higher
levels.

So when you create the queue, you should decide at THAT point whether you
just want to pass in the same lock or not.

For a cmd640, you make sure that both queues get created with the same
lock. And for non-broken chipsets, you use per-queue locks.

And then you make sure that nobody EVER uses any other lock than the queue
lock.

			Linus

