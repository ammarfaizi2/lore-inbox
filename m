Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130343AbQK3Wsk>; Thu, 30 Nov 2000 17:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130467AbQK3Wsa>; Thu, 30 Nov 2000 17:48:30 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15942 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130343AbQK3WsP>; Thu, 30 Nov 2000 17:48:15 -0500
Date: Thu, 30 Nov 2000 23:17:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>,
        Linus Torvalds <torvalds@transmeta.com>, V Ganesh <ganesh@veritas.com>,
        linux-kernel@vger.kernel.org, linux-LVM@sistina.com, mingo@redhat.com
Subject: Re: [PATCH] Re: [bug] infinite loop in generic_make_request()
Message-ID: <20001130231716.H18804@athlon.random>
In-Reply-To: <20001130214121.D18804@athlon.random> <200011302154.eAULsJZ02315@webber.adilger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200011302154.eAULsJZ02315@webber.adilger.net>; from adilger@turbolinux.com on Thu, Nov 30, 2000 at 02:54:19PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2000 at 02:54:19PM -0700, Andreas Dilger wrote:
> Andrea writes:
> > On Thu, Nov 30, 2000 at 01:05:53PM -0700, Andreas Dilger wrote:
> > > the RAID and LVM make_request functions should be changed to do that
> > > instead (i.e. 0 on success, -ve on error, and maybe "1" if they do their
> > > own recursion to break the loop)?
> > 
> > We preferred to let the lowlevel drivers to handle error themselfs to
> > simplify the interface. The lowlevel driver needs to call buffer_IO_error
> > before returning in case of error.
> 
> Even if the lowlevel driver handles the error case, it would still
> make more sense to stick with the normal kernel practise of -ERROR,
> and 0 for success.  Then, if in the future we can do something with the
> error codes, at least we don't have to change the interface yet again.

You shouldn't see the fact that a storage management driver returns 0 as an
error. It has a different semantic, it only means: "the make_request callback
completed the request, it wasn't a remap". That's all. As said the highlevel
layer doesn't know anything about errors anymore, it only need to know when the
request is completed.

Of course if there's an error during a remap you can't continue so you have to
say "this request is completed" and to tell this you currently have to return
0. But 0 from the point of view of the highlevel layer doesn't mean "error".

I'd suggest to take a third way that is to define only two retvals:

	BLKDEV_IO_REQ_COMPLETED
	BLKDEV_IO_REQ_REMAPPED

Then it doesn't matter anymore what number they're defined to.
generic_make_request simply keeps looping as far as it gets
BLKDEV_IO_REQ_REMAPPED as retval.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
