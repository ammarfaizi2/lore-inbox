Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263288AbREWWKF>; Wed, 23 May 2001 18:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263289AbREWWJz>; Wed, 23 May 2001 18:09:55 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:7448 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263288AbREWWJq>; Wed, 23 May 2001 18:09:46 -0400
Date: Thu, 24 May 2001 00:09:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: DVD blockdevice buffers
Message-ID: <20010524000933.A764@athlon.random>
In-Reply-To: <20010523205748.L8080@redhat.com> <Pine.LNX.4.31.0105231258420.6642-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0105231258420.6642-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, May 23, 2001 at 01:01:56PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2001 at 01:01:56PM -0700, Linus Torvalds wrote:
> [..] I assume that Andrea basically
> made the block-size be the same as the page size. That's how I would have

exactly (softblocksize is 4k fixed, regardless of the page cache size to
avoid confusing device drivers).

> done it (and then waited for people to find real life cases where we want
> to allow sector writes).

Correct, the partial write logic is kind of disabled on x86 because the
artificial softblocksize of the blkdev pagecache matches the
pagecachesize but it should just work on the other archs.

Now I can try to make the bh more granular for partial writes in a
dynamic manner (so we don't pay the overhead of the 512byte bh in the
common case) but I think this would need its own additional logic and I
prefer to think about it after I solved the coherency issues between
pinned buffer cache and filesystem, so after the showstoppers are solved
and the patch is just usable in real life (possibly with the overhead of
read-modify-write for some workload doing small random write I/O).
An easy short term fix for removing the read-modify-write would be to use the
hardblocksize of the underlying device as the softblocksize but again
that would cause us to pay for the 512byte bhs which I don't like to... ;)

Andrea
