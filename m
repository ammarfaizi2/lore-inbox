Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWJXQh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWJXQh0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 12:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbWJXQh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 12:37:26 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60289 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030225AbWJXQhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 12:37:24 -0400
Date: Wed, 25 Oct 2006 02:33:45 +1000
From: David Chinner <dgc@sgi.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Chinner <dgc@sgi.com>, Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, xfs@oss.sgi.com
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Message-ID: <20061024163345.GG11034@melbourne.sgi.com>
References: <1161576735.3466.7.camel@nigel.suspend2.net> <200610231236.54317.rjw@sisk.pl> <20061024144446.GD11034@melbourne.sgi.com> <200610241730.00488.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610241730.00488.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 05:29:59PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, 24 October 2006 16:44, David Chinner wrote:
> > On Mon, Oct 23, 2006 at 12:36:53PM +0200, Rafael J. Wysocki wrote:
> > > On Monday, 23 October 2006 06:12, Nigel Cunningham wrote:
> > > > XFS can continue to submit I/O from a timer routine, even after
> > > > freezeable kernel and userspace threads are frozen. This doesn't seem to
> > > > be an issue for current swsusp code,
> > > 
> > > So it doesn't look like we need the patch _now_.
> > > 
> > > > but is definitely an issue for Suspend2, where the pages being written could
> > > > be overwritten by Suspend2's atomic copy.
> > > 
> > > And IMO that's a good reason why we shouldn't use RCU pages for storing the
> > > image.  XFS is one known example that breaks things if we do so and
> > > there may be more such things that we don't know of.  The fact that they
> > > haven't appeared in testing so far doesn't mean they don't exist and
> > > moreover some things like that may appear in the future.
> > 
> > Could you please tell us which XFS bits are broken so we can get
> > them fixed?  The XFS daemons should all be checking if they are
> > supposed to freeze (i.e. they call try_to_freeze() after they wake
> > up due to timer expiry) so I thought they were doing the right
> > thing.
> > 
> > However, I have to say that I agree with freezing the filesystems
> > before suspend - at least XFS will be in a consistent state that can
> > be recovered from without corruption if your machine fails to
> > resume....
> 
> Do you mean calling sys_sync() after the userspace has been frozen
> may not be sufficient?

In most cases it probably is, but sys_sync() doesn't provide any
guarantees that the filesystem is not being used or written to after
it completes. Given that every so often I hear about an XFS filesystem
that was corrupted by suspend, I don't think this is sufficient...

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
