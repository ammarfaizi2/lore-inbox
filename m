Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424311AbWKJAep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424311AbWKJAep (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 19:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424312AbWKJAep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 19:34:45 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:55008 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1424311AbWKJAeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 19:34:44 -0500
Date: Fri, 10 Nov 2006 11:33:33 +1100
From: David Chinner <dgc@sgi.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alasdair G Kergon <agk@redhat.com>,
       Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>, David Chinner <dgc@sgi.com>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061110003332.GM8394166@melbourne.sgi.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <200611081310.19100.rjw@sisk.pl> <20061108180921.GA7708@ucw.cz> <200611091652.34649.rjw@sisk.pl> <20061109160003.GA24156@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061109160003.GA24156@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 05:00:03PM +0100, Pavel Machek wrote:
> > > > Well, it looks like the interactions with dm add quite a bit of
> > > > complexity here.
> > > 
> > > What about just fixing xfs (thou shall not write to disk when kernel
> > > threads are frozen), and getting rid of blockdev freezing?
> > 
> > Well, first I must admit you were absolutely right being suspicious with
> > respect to this stuff.
> 
> (OTOH your patch found real bugs in suspend.c, so...)
> 
> > OTOH I have no idea _how_ we can tell xfs that the processes have been
> > frozen.  Should we introduce a global flag for that or something?
> 
> I guess XFS should just do all the writes from process context, and
> refuse any writing when its threads are frozen... I actually still
> believe it is doing the right thing, because you can't really write to
> disk from timer.

As per the recent thread about this, XFS threads suspend correctly
and XFS doesn't issue I/O from timers.

The problem appears to be per-cpu workqueues that don't get
suspended because suspend does not shut down workqueue threads. You
haven't quiesced the filesystem, you haven't shut down work
queues, but you're expecting the filesystem to magically stop
using them when suspend starts up?

You can't lay the blame on any subsystem for using an interface that
suspend doesn't quiesce when you *haven't told the subsystem it
should suspend itself*. This is true regardless of whether the
subsystem is a device driver, part of the network stack or a
filesystem.

e.g. A struct device has suspend and resume callouts so that each
device can be safely suspended and resumed. Suspend uses these and
you sure as hell don't expect a device to work properly after a
resume if you don't use these interfaces.

So why do you think filesystems should be treated differently?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
