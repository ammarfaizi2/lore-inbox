Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130830AbRBGBUn>; Tue, 6 Feb 2001 20:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130799AbRBGBUd>; Tue, 6 Feb 2001 20:20:33 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:58631 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130830AbRBGBUU>; Tue, 6 Feb 2001 20:20:20 -0500
Date: Tue, 6 Feb 2001 17:19:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        "Stephen C. Tweedie" <sct@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <20010207020221.B13647@suse.de>
Message-ID: <Pine.LNX.4.10.10102061713160.2193-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Feb 2001, Jens Axboe wrote:
> 
> I don't see anything that would break doing this, in fact you can
> do this as long as the buffers are all at least a multiple of the
> block size. All the drivers I've inspected handle this fine, noone
> assumes that rq->bh->b_size is the same in all the buffers attached
> to the request.

It's really easy to get this wrong when going forward in the request list:
you need to make sure that you update "request->current_nr_sectors" each
time you move on to the next bh.

I would not be surprised if some of them have been seriously buggered. 

On the other hand, I would _also_ not be surprised if we've actually fixed
a lot of them: one of the things that the RAID code and loopback test is
exactly getting these kinds of issues right (not this exact one, but
similar ones).

And let's remember things like the old ultrastor driver that was totally
unable to handle anything but 1kB devices etc. I would not be _totally_
surprised if it turns out that there are still drivers out there that
remember the time when Linux only ever had 1kB buffers. Even if it is 7
years ago or so ;)

(Also, there might be drivers that are "optimized" - they set the IO
length once per request, and just never set it again as they do partial
end_io() calls. None of those kinds of issues would ever be found under
normal load, so I would be _really_ nervous about just turning it on
silently. This is all very much a 2.5.x-kind of thing ;)

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
