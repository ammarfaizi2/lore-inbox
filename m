Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276891AbRJCHFH>; Wed, 3 Oct 2001 03:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276892AbRJCHE6>; Wed, 3 Oct 2001 03:04:58 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:27837 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276891AbRJCHEy>;
	Wed, 3 Oct 2001 03:04:54 -0400
Date: Wed, 3 Oct 2001 03:05:17 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Andreas Dilger <adilger@turbolabs.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.4.11-pre2 fs/buffer.c: invalidate: busy buffer
In-Reply-To: <15290.46612.877715.135811@notabene.cse.unsw.edu.au>
Message-ID: <Pine.GSO.4.21.0110030259530.21861-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Oct 2001, Neil Brown wrote:

> On Wednesday October 3, adilger@turbolabs.com wrote:

> > 3) Rewrite to do I/O directly via pagecache?
> 
> 4) Rewrite to do I/O directly via generic_make_request just like it
>    does for all other I/O to underlying devices.
>    It is on my (mental) todo list, but doesn't have a high priority.
>    At the same time, it would be good to get write_disk_sb to notice
>    if the write failed.....

Folks, there's a problem aside of set_blocksize().  You are doing memset
and memcpy on unlocked buffer returned by getblk().  That's a race -
if that buffer is currently being read into, we will get a random crap.
And write it to disk afterwards.

General rule: don't modify buffer you've got from getblk() unless you've
locked it and mark it uptodate before you unlock.  We had the same
bug in ext2, BTW.

