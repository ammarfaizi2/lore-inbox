Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753973AbWKMFpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbWKMFpA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 00:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753976AbWKMFpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 00:45:00 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58348 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1753973AbWKMFo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 00:44:59 -0500
Date: Mon, 13 Nov 2006 16:43:40 +1100
From: David Chinner <dgc@sgi.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Chinner <dgc@sgi.com>, Pavel Machek <pavel@ucw.cz>,
       Alasdair G Kergon <agk@redhat.com>, Eric Sandeen <sandeen@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061113054340.GP11034@melbourne.sgi.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <20061110103942.GG3196@elf.ucw.cz> <20061112223012.GH11034@melbourne.sgi.com> <200611122343.06625.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611122343.06625.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2006 at 11:43:05PM +0100, Rafael J. Wysocki wrote:
> On Sunday, 12 November 2006 23:30, David Chinner wrote:
> > On Fri, Nov 10, 2006 at 11:39:42AM +0100, Pavel Machek wrote:
> > > On Fri 2006-11-10 11:57:49, David Chinner wrote:
> > > > On Thu, Nov 09, 2006 at 11:21:46PM +0100, Rafael J. Wysocki wrote:
> > > > > I think we can add a flag to __create_workqueue() that will indicate if
> > > > > this one is to be running with PF_NOFREEZE and a corresponding macro like
> > > > > create_freezable_workqueue() to be used wherever we want the worker thread
> > > > > to freeze (in which case it should be calling try_to_freeze() somewhere).
> > > > > Then, we can teach filesystems to use this macro instead of
> > > > > create_workqueue().
> > > > 
> > > > At what point does the workqueue get frozen? i.e. how does this
> > > > guarantee an unfrozen filesystem will end up in a consistent
> > > > state?
> > > 
> > > Snapshot is atomic; workqueue will be unfrozen with everyone else, but
> > > as there were no writes in the meantime, there should be no problems.
> > 
> > That doesn't answer my question - when in the sequence of freezing
> > do you propose diasbling the workqueues? before the kernel threads,
> > after the kernel threads, before you sync the filesystem?
> 
> After the sync, along with the freezing of kernel threads.

Before or after freezing of the kthreads? Order _could_ be
important, and different filesystems might require different
orders. What then?

> > And how does freezing them at that point in time guarantee consistent
> > filesystem state?
> 
> If the work queues are frozen, there won't be any fs-related activity _after_
> we create the suspend image.

What about if there is still I/O in progress (i.e. kthread wins race and
issues async I/O after the sync but before it's frozen) - freezing the
workqueues does not prevent this activity and memory state will continue to
change as long as there is I/O completing...

> The sync is done after the userland has been
> frozen, so if the resume is unsuccessful, we'll be able to recover the state
> of the fs right before the sync,

Yes, in most cases.

> and if the resume is successful, we'll be
> able to continue (the state of memory will be the same as before the creation
> of the suspend image and the state of the disk will be the same as before the
> creation of the suspend image).

Assuming that you actually suspended an idle filesystem, which sync does not
guarantee you.  Rather than assuming the filesystem is idle, why not guarantee
that it is idle by freezing it?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
