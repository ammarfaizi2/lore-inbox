Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280510AbRKKT3A>; Sun, 11 Nov 2001 14:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280481AbRKKT2v>; Sun, 11 Nov 2001 14:28:51 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:46811 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280467AbRKKT2h>;
	Sun, 11 Nov 2001 14:28:37 -0500
Date: Sun, 11 Nov 2001 14:28:35 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] long-living cache for block devices
In-Reply-To: <Pine.LNX.4.33.0111111106270.31988-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0111111423110.17411-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Nov 2001, Linus Torvalds wrote:

> 
> On Sun, 11 Nov 2001, Alexander Viro wrote:
> >
> > As it is, driver has a right to destroy any internal data structures as
> > soon as the last ->release() is called.  None of them expect requests
> > coming in after that and frankly, that makes sense.
> 
> New requests will not be coming in - not for read-ahead, not for anything
> else.
> 
> There may be old requests that haven't finished, of course. And there may
> be requests on the request queue that the driver hasn't even looked at yet
> (Hmm.. I'm not sure that latter one is right - we must have done the
> device sync anyway, and that will unplug the requests queue etc).

Why would it?  Sync deals with write requests, read requests are left as-is.
Notice that in your tree the thing shuts readahead requests down is
invalidate_bdev() and we don't want to get it called - for very obvious
reasons.
 
> But there cannot be any users that are still adding requests. That would
> be a bug regardless.

Sure.  But there may very well be requests coming into driver from the
queue.

> We might want to make sure that the request queue is truly empty, that's
> for sure. That's a driver-level thing that makes sense, and that should
> probably be part of the logic that does the bdev sync. After all, that
> queue should be a per-driver thing anyway (right now it isn't, but hey,
> that's for all the wrong historical reasons rather than anything else).

Umm... So you want sync to wait for read requests, not just the write ones?
That would certainly be enough, but that's not what everyone expects from
sync... 

