Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130017AbRCAVF6>; Thu, 1 Mar 2001 16:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130013AbRCAVFt>; Thu, 1 Mar 2001 16:05:49 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:57358 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130008AbRCAVFd>; Thu, 1 Mar 2001 16:05:33 -0500
Message-ID: <3A9EB984.C1F7E499@transmeta.com>
Date: Thu, 01 Mar 2001 13:05:08 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Pavel Machek <pavel@suse.cz>, Bill Crawford <billc@netcomuk.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@innominate.de>
Subject: Re: Hashing and directories
In-Reply-To: <Pine.GSO.4.21.0103011547200.11577-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> >
> > Yes -- because their workaround kernel slowness.
> 
> Pavel, I'm afraid that you are missing the point. Several, actually:
>         * limits of _human_ capability to deal with large unstructured
> sets of objects

Not an issue if you're a machine.

>         * userland issues (what, you thought that limits on the
> command size will go away?)

Last I checked, the command line size limit wasn't a userland issue, but
rather a limit of the kernel exec().  This might have changed.

>         * portability

> The point being: applications and users _do_ know better what structure
> is there. Kernel can try to second-guess them and be real good at that, but
> inability to second-guess is the last of the reasons why aforementioned
> strategies are used.

However, there are issues where users and applications don't want to
structure their namespace for the convenience of the kernel, for good or
bad reasons.  There are structures which are known to produce vastly
better performance even in the not-very-uncommon cases, although of
course they provide dramatic improvements in the extreme.  I personally
happen to like the hash-indexed B-tree because of their extremely high
fanout and because they don't impose any penalty in the other extreme (if
your directory is small enough to fit in a single block, you skip the
B-tree and have the linear non-hash leaf node only) but there are other
structures which work as well.

I don't see there being any fundamental reason to not do such an
improvement, except the one Alan Cox mentioned -- crash recovery --
(which I think can be dealt with; in my example above as long as the leaf
nodes can get recovered, the tree can be rebuilt.  Consider starting each
leaf node block with a magic and a pointer to its home inode; combined
with a leaf node block count in the home inode, that should be quite
robust.)  It would be particularly nice to implement this more as an
enhancement to ext3 than ext2, even though the issue is orthogonal, since
ext3 should add a layer of inherent integrity protection.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
