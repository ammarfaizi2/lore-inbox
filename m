Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278302AbRJMOXg>; Sat, 13 Oct 2001 10:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278303AbRJMOX0>; Sat, 13 Oct 2001 10:23:26 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:39026 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278302AbRJMOXO>; Sat, 13 Oct 2001 10:23:14 -0400
Date: Sat, 13 Oct 2001 16:23:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: duncan.sands@math.u-psud.fr, linux-kernel@vger.kernel.org,
        Al Viro <viro@redhat.com>
Subject: Re: xine pauses with recent (not -ac) kernels
Message-ID: <20011013162330.I714@athlon.random>
In-Reply-To: <01101208552800.00838@baldrick> <20011012161052.R714@athlon.random> <01101300085600.00832@baldrick> <200110130351.f9D3pRp08271@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200110130351.f9D3pRp08271@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Oct 12, 2001 at 08:51:27PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 08:51:27PM -0700, Linus Torvalds wrote:
> Let me guess: xine opens the raw device, and does all the DVD parsing
> from there. 
> 
> Furthermore, maybe it closes and re-opens the device for each VOB file. 

I was assuming it was a vm problem so I wasn't even thinking at the
other changes, but now thinking twice yes, the fact we block dropping
all the cache at the blkdev close could be the culprit. OTOH we were
just invalidating all the buffers cache also previously at the last
blkdev close, so it's not so obvious that it is the problem yet (but the
vmstat trace from Duncan also shows an immediate drop in pagecache
converted in free memory, so it could really be the close of the blkdev
given that xine isn't going to delete any dozen mbyte large file and
that probably doesn't allocate and deallocate some dozen mbyte of memory
in less than one second).

> If it does, then I suspect we should really look into making the raw
> device close just leave the device descriptor around at least for a
> while. Al?

In this case it sounds more like xine shouldn't close the device while
changing file (also with 2.4.9 the buffercache was dropped anyways), but
also allowing the cache to be persistent would make sense. I liked
trusting in the check-media-change logic for devices that are reliable
(for the others we must of course keep to invalidate the cache). I think
we should only make the bdev and bd_inode persistent, and have
check-media-change that tells us at open(2) time if the cache have to be
dropped or if we can trust the "media change" detection of the device
and avoid to drop it. Of course the cache will be reclaimed by the vm
over the time, I'm unsure if it worth to allow the garbage collection of
the bdev and of the bd_inode.

Anyways those changes aren't required for having a functional system so
maybe we can postpone this to 2.5 and instead fix xine not to close the
device (or to keep a dummy additional reference on the device for its
runtime).

Andrea
