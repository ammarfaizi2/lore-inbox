Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317267AbSFMSqd>; Thu, 13 Jun 2002 14:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317794AbSFMSqc>; Thu, 13 Jun 2002 14:46:32 -0400
Received: from dsl-213-023-039-067.arcor-ip.net ([213.23.39.67]:23702 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317267AbSFMSqb>;
	Thu, 13 Jun 2002 14:46:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
Date: Thu, 13 Jun 2002 20:45:01 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Dawson Engler <engler@csl.Stanford.EDU>,
        Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        mc@cs.Stanford.EDU
In-Reply-To: <Pine.GSO.4.21.0206131350180.20315-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17IZag-0000RD-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 June 2002 19:53, Alexander Viro wrote:
> On Thu, 13 Jun 2002, Daniel Phillips wrote:
> 
> > > I mean that due to the loop (link_path_walk->do_follow_link->foofs_follow_link
> > > ->vfs_follow_link->link_path_walk) you will get infinite maximal depth
> > > for everything that can be called by any of these functions.  And that's
> > > a _lot_ of stuff.
> > 
> > Then at the point of recursion a dynamic check for stack space is
> > needed, and [checker]'s role would be to determine the deepest static
> > depth, to plug into the stack check.  If we want to be sure about 
> > stack integrity there isn't any way around this.
> 
> Wrong.  Check for stack _space_ will mean that maximal depth of nested
> symlinks depends on syscall.  Definitely not what you want to see.
> There is a static limit (no more than 5 nested), but it must be
> explicitly known to checker - deducing it from code is easy for a
> human, but hopeless for anything automatic.

It's even hard to deduce the recursion in this case, and even if
checker is smart enough to spot it there's no way to know the
static requirement of out-of-tree filesystems.

Perhaps a BUG here is the right thing, in case the big chain of
assumptions here is inadvertently violated, in which case I'd much
rather have the system go down with a BUG than wig out in one of
the weird and wonderful ways typical of a stack overflow.

By the way:

327 /*
328  * This limits recursive symlink follows to 8, while
329  * limiting consecutive symlinks to 40.

Maybe:

327 /*
328  * This limits recursive symlink follows and consecutive symlinks.

-- 
Daniel
