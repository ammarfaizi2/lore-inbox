Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265607AbTFXBXX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 21:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265611AbTFXBXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 21:23:23 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:12467 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265607AbTFXBXT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 21:23:19 -0400
Date: Mon, 23 Jun 2003 18:37:01 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, dmccr@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix vmtruncate race and distributed filesystem race
Message-ID: <20030624013701.GA2239@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20030612140014.32b7244d.akpm@digeo.com> <150040000.1055452098@baldur.austin.ibm.com> <20030612144418.49f75066.akpm@digeo.com> <184910000.1055458610@baldur.austin.ibm.com> <20030620001743.GI18317@dualathlon.random> <20030623032842.GA1167@us.ibm.com> <20030622233235.0924364d.akpm@digeo.com> <20030623074353.GE19940@dualathlon.random> <20030623005623.5fe1ab30.akpm@digeo.com> <20030623081016.GI19940@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030623081016.GI19940@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 10:10:16AM +0200, Andrea Arcangeli wrote:
> On Mon, Jun 23, 2003 at 12:56:23AM -0700, Andrew Morton wrote:
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > >
> > > that will finally close the race
> > 
> > Could someone please convince me that we really _need_ to close it?
> > 
> > The VM handles the whacky pages OK (on slowpaths), and when this first came
> > up two years ago it was argued that the application was racy/buggy
> > anyway.  So as long as we're secure and stable, we don't care.  Certainly
> > not to the point of adding more atomic ops on the fastpath.
> > 
> > So...   what bug are we actually fixing here?
> 
> we're fixing userspace data corruption with an app trapping SIGBUS.

This handling of wacky pages apparently does not carry over into some
of the rmap optimizations, but I will let dmccr speak to that.

> > (I'd also like to see a clearer description of the distributed fs problem,
> > and how this fixes it).
> 
> I certainly would like discussions about it too.

The race is as follows:

	Node 0				Node 1

	mmap()s file f1
					writes to f1
					sends msg to Node 0 requesting data
	pgflt on mmap
	do_no_page() invokes ->nopage
	->nopage hands page up
	<some interrupt or other delay>

	receives message from Node 1
	invokes invalidate_mmap_range()
	returns data to Node 1

					receives data from Node 0
					does write

	<return from interrupt or whatever>
	do_no_page() installs now-stale mapping
	return from page fault
	application scribbles on page, violating DFS's consistency!!!

Now Node 0 and Node 1 have inconsistent versions of the page being
written to.  Note that this problem occurs regardless of the mechanism
that Node 1 does to accomplish the write -- mmap(), write(), whatever.

This race is a problem only in distributed filesystems that provide
the same consistency guarantees normally found on local filesystems.
Things like NFS or AFS would not be bothered, since they do not offer
such consistency guarantees.  For example, with AFS, the last guy
to close the file wins.

						Thanx, Paul
