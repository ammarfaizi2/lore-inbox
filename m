Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755182AbWKMQZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182AbWKMQZt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755189AbWKMQZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:25:49 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:1236 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1755182AbWKMQZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:25:47 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: David Chinner <dgc@sgi.com>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Date: Mon, 13 Nov 2006 17:22:54 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Alasdair G Kergon <agk@redhat.com>,
       Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <200611122343.06625.rjw@sisk.pl> <20061113054340.GP11034@melbourne.sgi.com>
In-Reply-To: <20061113054340.GP11034@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611131722.55446.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 13 November 2006 06:43, David Chinner wrote:
> On Sun, Nov 12, 2006 at 11:43:05PM +0100, Rafael J. Wysocki wrote:
> > On Sunday, 12 November 2006 23:30, David Chinner wrote:
> > > On Fri, Nov 10, 2006 at 11:39:42AM +0100, Pavel Machek wrote:
> > > > On Fri 2006-11-10 11:57:49, David Chinner wrote:
> > > > > On Thu, Nov 09, 2006 at 11:21:46PM +0100, Rafael J. Wysocki wrote:
> > > > > > I think we can add a flag to __create_workqueue() that will indicate if
> > > > > > this one is to be running with PF_NOFREEZE and a corresponding macro like
> > > > > > create_freezable_workqueue() to be used wherever we want the worker thread
> > > > > > to freeze (in which case it should be calling try_to_freeze() somewhere).
> > > > > > Then, we can teach filesystems to use this macro instead of
> > > > > > create_workqueue().
> > > > > 
> > > > > At what point does the workqueue get frozen? i.e. how does this
> > > > > guarantee an unfrozen filesystem will end up in a consistent
> > > > > state?
> > > > 
> > > > Snapshot is atomic; workqueue will be unfrozen with everyone else, but
> > > > as there were no writes in the meantime, there should be no problems.
> > > 
> > > That doesn't answer my question - when in the sequence of freezing
> > > do you propose diasbling the workqueues? before the kernel threads,
> > > after the kernel threads, before you sync the filesystem?
> > 
> > After the sync, along with the freezing of kernel threads.
> 
> Before or after freezing of the kthreads? Order _could_ be
> important, and different filesystems might require different
> orders. What then?

Well, I don't really think the order is important.  If the freezing of work
queues is done by the freezing of their respective worker threads, the
other threads won't even know they have been frozen.

> > > And how does freezing them at that point in time guarantee consistent
> > > filesystem state?
> > 
> > If the work queues are frozen, there won't be any fs-related activity _after_
> > we create the suspend image.
> 
> What about if there is still I/O in progress (i.e. kthread wins race and
> issues async I/O after the sync but before it's frozen) - freezing the
> workqueues does not prevent this activity and memory state will continue to
> change as long as there is I/O completing...
> 
> > The sync is done after the userland has been
> > frozen, so if the resume is unsuccessful, we'll be able to recover the state
> > of the fs right before the sync,
> 
> Yes, in most cases.
> 
> > and if the resume is successful, we'll be
> > able to continue (the state of memory will be the same as before the creation
> > of the suspend image and the state of the disk will be the same as before the
> > creation of the suspend image).
> 
> Assuming that you actually suspended an idle filesystem, which sync does not
> guarantee you.

Even if it's not idle, we are safe as long as the I/O activity doesn't
continue after the suspend image has been created.

> Rather than assuming the filesystem is idle, why not guarantee 
> that it is idle by freezing it?

Well, _I_ personally think that the freezing of filesystems is the right thing
to do, although it may lead to some complications down the road.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
