Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269335AbRHGTKb>; Tue, 7 Aug 2001 15:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269333AbRHGTKS>; Tue, 7 Aug 2001 15:10:18 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:32735 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269332AbRHGTKN>;
	Tue, 7 Aug 2001 15:10:13 -0400
Date: Tue, 7 Aug 2001 15:10:23 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <200108071855.f77Itl207144@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0108071457010.18565-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Aug 2001, Richard Gooch wrote:

> Hm. strace suggests my pwd is walking up the path. But WTF would it
> break? 2.4.7 was fine. What did I break?

Walking the path works so:

open ..
read it, entry by entry
find an entry that would have inode number equal to that of our directory.
We had found the last component of our name. Lather, rinse, repeat.

It relies on numbers from stat() and numbers from readdir() being
in sync.  It's not true on so many filesystems that this algorithm
is laughable.  Anything with synthetic inode numbers breaks it.

IOW, your pwd(1) behaviour is b0rken. Aside of being unable to work on a
lot of filesystems, it's doing a lot of extra work even on the filesystems
where it happens to work.

Check what your getcwd(3) is doing. It should at least try to call
getcwd(2) before reverting to that horror. Notice that you need
to walk the path only on 2.0 - 2.2 and above have a syscall that
works without any IO and regardless of the inumber assignment policy.

