Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424898AbWKQBmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424898AbWKQBmp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 20:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424897AbWKQBmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 20:42:45 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:41698 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1424898AbWKQBmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 20:42:44 -0500
Date: Fri, 17 Nov 2006 12:40:51 +1100
From: David Chinner <dgc@sgi.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: David Chinner <dgc@sgi.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Alasdair G Kergon <agk@redhat.com>, Eric Sandeen <sandeen@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061117014051.GM11034@melbourne.sgi.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <20061110103942.GG3196@elf.ucw.cz> <20061112223012.GH11034@melbourne.sgi.com> <200611122343.06625.rjw@sisk.pl> <20061116232349.GI11034@melbourne.sgi.com> <20061116234053.GC6757@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061116234053.GC6757@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 12:40:53AM +0100, Pavel Machek wrote:
> On Fri 2006-11-17 10:23:49, David Chinner wrote:
> > On Sun, Nov 12, 2006 at 11:43:05PM +0100, Rafael J. Wysocki wrote:
> > > On Sunday, 12 November 2006 23:30, David Chinner wrote:
> > > > And how does freezing them at that point in time guarantee consistent
> > > > filesystem state?
> > > 
> > > If the work queues are frozen, there won't be any fs-related activity _after_
> > > we create the suspend image. 
> > 
> > fs-related activity before or after the suspend image is captured is
> > not a problem - it's fs-related activity _during_ the suspend that
> > is an issue here. If we have async I/O completing during the suspend
> > image capture, we've got problems....
> 
> fs-related activity _after_ image is captured definitely is a problem
> -- it breaks swsusp invariants.
> 
> During image capture, any fs-related activity is not possible, as we
> are running interrupts disabled, DMA disabled.

Ok, so the I/o that finishes during the image capture won't be reported
until after the capture completes. that means we lose the capability
to even run the I/O completion on those buffers once we get to
resume.

They've already been issued, so will be locked and never issued
again because the suspend image says they've been issued, but they'll
never complete on resume because their completion status was
updated after the capture was taken and will never be recreated
after resume. IOWs, the fileystem will start to hang on the next
reference to any of these locked buffers that the filesystem
thinks is still under I/O....

Freezing the workqueues doesn't fix this.....

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
