Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280387AbRKKTSH>; Sun, 11 Nov 2001 14:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280467AbRKKTR6>; Sun, 11 Nov 2001 14:17:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53773 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280387AbRKKTRo>; Sun, 11 Nov 2001 14:17:44 -0500
Date: Sun, 11 Nov 2001 11:13:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] long-living cache for block devices
In-Reply-To: <Pine.GSO.4.21.0111111400180.17411-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0111111106270.31988-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 Nov 2001, Alexander Viro wrote:
>
> As it is, driver has a right to destroy any internal data structures as
> soon as the last ->release() is called.  None of them expect requests
> coming in after that and frankly, that makes sense.

New requests will not be coming in - not for read-ahead, not for anything
else.

There may be old requests that haven't finished, of course. And there may
be requests on the request queue that the driver hasn't even looked at yet
(Hmm.. I'm not sure that latter one is right - we must have done the
device sync anyway, and that will unplug the requests queue etc).

But there cannot be any users that are still adding requests. That would
be a bug regardless.

We might want to make sure that the request queue is truly empty, that's
for sure. That's a driver-level thing that makes sense, and that should
probably be part of the logic that does the bdev sync. After all, that
queue should be a per-driver thing anyway (right now it isn't, but hey,
that's for all the wrong historical reasons rather than anything else).

> IOW, if there is any point in _having_ ->release() at all, we'd better
> make sure that nothing will bother the driver between the final ->release()
> and the next ->open().

I think the "no bother" is true regardless of whether we explicitly
destroy buffers or not. And quite frankly, I'd rather _not_ hide bugs by
waiting for requests that shouldn't be there in the first place.

		Linus

