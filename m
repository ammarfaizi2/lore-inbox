Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317846AbSFMVue>; Thu, 13 Jun 2002 17:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317847AbSFMVud>; Thu, 13 Jun 2002 17:50:33 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:50334 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S317846AbSFMVuc>;
	Thu, 13 Jun 2002 17:50:32 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200206132150.OAA14200@csl.Stanford.EDU>
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
To: viro@math.psu.edu (Alexander Viro)
Date: Thu, 13 Jun 2002 14:50:28 -0700 (PDT)
Cc: ak@muc.de (Andi Kleen), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0206131420010.20315-100000@weyl.math.psu.edu> from "Alexander Viro" at Jun 13, 2002 02:26:54 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 13 Jun 2002, Andi Kleen wrote:
> 
> > Alexander Viro <viro@math.psu.edu> writes:
> > > 
> > > I mean that due to the loop (link_path_walk->do_follow_link->foofs_follow_link
> > > ->vfs_follow_link->link_path_walk) you will get infinite maximal depth
> > > for everything that can be called by any of these functions.  And that's
> > > a _lot_ of stuff.
> > 
> > Surely an analysis pass can detect recursive function chains and flag them
> > (e.g. the global IPA alias analysis pass in open64 does this)
> 
> Ugh...  OK, let me try again:
> 
> One bit of apriory information needed to get anything interesting from
> this analysis:  there is a set of mutually recursive functions (see above)
> and there is a limit (5) on the depth of recursion in that loop.
> 
> It has to be known to checker.  Explicitly, since
> 	a) automatically deducing it is not realistic
> 	b) cutting off the stuff behind that loop will cut off a _lot_ of
> things - both in filesystems and in VFS (and in block layer, while we are
> at it).

We're all about jamming system specific information into the checking
extensions.  It's usually just a few if statements.  So to be clear: we
can simply assume that the loop 
   link_path_walk
	->do_follow_link
		->foofs_follow_link
			->vfs_follow_link
				->link_path_walk
can happen exactly 5 times?

In general such restrictions are interesting, since they concretely
show how having a way to include system-specific knowlege into checking
is useful.  Are there any other such relationships?  The other example
I know of is the do_page_fault (sp?) routine that can potentially be
invoked at very copy_*_user site that page faults.  You need to know
this to detect certain classes of deadlock, but there's no way to
discern this path from the code without a priori knowlege.
