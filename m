Return-Path: <linux-kernel-owner+w=401wt.eu-S1751625AbXASQda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbXASQda (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 11:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbXASQda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 11:33:30 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:53951 "EHLO
	extu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619AbXASQd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 11:33:29 -0500
X-AuditID: d80ac21c-a187abb00000330a-9c-45b0f2d8fc2c 
Date: Fri, 19 Jan 2007 16:33:41 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Nadia Derbey <Nadia.Derbey@bull.net>
cc: Franck Bui-Huu <fbuihuu@gmail.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: unable to mmap /dev/kmem
In-Reply-To: <45B08B17.3060807@bull.net>
Message-ID: <Pine.LNX.4.64.0701191539070.4009@blonde.wat.veritas.com>
References: <45AFA490.5000508@bull.net> <Pine.LNX.4.64.0701181743340.25435@blonde.wat.veritas.com>
 <45B08B17.3060807@bull.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Jan 2007 16:33:27.0679 (UTC) FILETIME=[8C1180F0:01C73BE7]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2007, Nadia Derbey wrote:
> Hugh Dickins wrote:
> > 
> > Sigh, you're right, 2.6.19 messed that up completely.
> > No, you never had to subtract PAGE_OFFSET from that address
> > in the past, and you shouldn't have to do so now.

Whoops, I should never have said "never".  Checking further back,
I found that in 2.4, and prior to 2.6.12, mmap_kmem was simply
#defined to mmap_mem, and so you would then have had to subtract
PAGE_OFFSET (well, on i386 at least) from the kernel virtual
address to get it to work.

Andi fixed that in 2.6.12.  I agree with his fix: the same data should
appear at the same offset whether you use mmap or read, which was not
so before his patch (nor after Franck's).  Though I do wonder whether
it was safe to change its behaviour at that stage: more evidence that
few have actually been using mmap of /dev/kmem.

> > I guess it's reassuring to know that not many are actually
> > using mmap of /dev/kmem, so you're the first to notice: thanks.
> > 
> I find this feature very interesting from a testing perspective. Now, since I
> don't like the idea of being the only one that uses a feature (not maintained
> - may be even to be removed?) may be you could advice me on a more broadly
> used way to get the value of a non exported kernel variable from inside a test
> running in user mode? should I use /dev/mem instead? But in that case, I
> should do the virtual to physical conversion myself, right?

That's exactly the way I've used mmap of /dev/kmem in the past myself:
yes, a convenient way to collect stats or patch flags when investigating
something on a private kernel.  There are probably more sophisticated
alternatives now (systemtap, [a-z]probes), but mmap of /dev/kmem is
pretty easy to understand, whatever its limitations.

You're right to question whether you'll be safer in the long term to
use /dev/mem instead, doing the virtual to physical conversion yourself:
I share your doubt.  On the one hand, /dev/kmem is clearly underused,
with an interface which changes without anyone noticing; and Fedora
doesn't even supply the node (they'd like to get rid of /dev/mem also,
I believe - too wide an open door into the kernel - but a few tools
still use it).  On the other hand, if for some reason we make the 
mapping between physical and kernel virtual more complicated in
future, /dev/kmem should in theory save you from having to worry
about that (though in practice none of us has ever got around to
supporting mmap of the vmalloc area through /dev/kmem yet).

I think, if this thread provokes a call to remove support for mmap
of /dev/kmem, I'd find that hard to argue against, and you'd better
switch to /dev/mem.  But personally I'd prefer it to remain.

Hugh
