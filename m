Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266187AbUHMQen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266187AbUHMQen (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 12:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUHMQen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 12:34:43 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:49027 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266187AbUHMQek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 12:34:40 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH] allocate page caches pages in round robin fasion
Date: Fri, 13 Aug 2004 09:34:20 -0700
User-Agent: KMail/1.6.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, steiner@sgi.com
References: <200408121646.50740.jbarnes@engr.sgi.com> <200408130859.24637.jbarnes@engr.sgi.com> <89760000.1092414010@[10.10.2.4]>
In-Reply-To: <89760000.1092414010@[10.10.2.4]>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408130934.20913.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 13, 2004 9:20 am, Martin J. Bligh wrote:
> >> I really don't think this is a good idea - you're assuming there's
> >> really no locality of reference, which I don't think is at all true in
> >> most cases.
> >
> > No, not at all, just that locality of reference matters more for stack
> > and anonymous pages than it does for page cache pages.  I.e. we don't
> > want a node to be filled up with page cache pages causing all other
> > memory references from the process to be off node.
>
> Does that actually happen though? Looking at the current code makes me
> think it'll keep some pages free on all nodes at all times, and if kswapd
> does it's job, we'll never fall back across nodes. Now ... I think that's
> broken, but I think that's what currently happens - that was what we
> discussed at KS ... I might be misreading it though, I should test it.

Not nearly enough pages for any sizeable app though.  Maybe the behavior could 
be configurable?

> Even if that's not true, allocating all your most recent stuff off-node is
> still crap (so either way, I'd agree the current situation is broken), but
> I don't think the solution is to push ALL your accesses (with n-1/n
> probability) off-node ... we need to be more careful than that ...

Only page cache references...

> Not sure I'd agree with that - it's the same problem as swappiness on a
> global basis for non-NUMA machines. We want the pages we're using MOST to
> be local, the others to be not-local, and that doesn't equate (necessarily)
> to whether it's pagecache or not. Shared pages could indeed be dealt with
> differently, and spread more global ... but I don't agree that pagecache
> pages equate 1-1 with being globally shared - in fact, I think most often
> the opposite is true.

Yeah, that's a good point.  That argues for configurability too.  We should 
behave differently depending on whether the page is shared or not.

> PS. The obvious exceptions to these rules are shmem and shared libs ...
> shmem should probably go round-robin amongst its users nodes by default,
> and shared libs replicate ... I'll look at fixing up shmem at least.

Cool, that would be good.

Jesse
