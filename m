Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753472AbWKLXbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbWKLXbj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 18:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753497AbWKLXbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 18:31:39 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:45006 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1753472AbWKLXbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 18:31:38 -0500
Date: Mon, 13 Nov 2006 10:30:54 +1100
From: David Chinner <dgc@sgi.com>
To: Pavel Machek <pavel@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alasdair G Kergon <agk@redhat.com>,
       Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>, David Chinner <dgc@sgi.com>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061112233054.GI11034@melbourne.sgi.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <20061109232438.GS30653@agk.surrey.redhat.com> <20061109233258.GH2616@elf.ucw.cz> <200611101303.33685.rjw@sisk.pl> <20061112184310.GC5081@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061112184310.GC5081@ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2006 at 06:43:10PM +0000, Pavel Machek wrote:
> Hi!
> 
> > > Okay, so you claim that sys_sync can stall, waiting for administator?
> > > 
> > > In such case we can simply do one sys_sync() before we start freezing
> > > userspace... or just more the only sys_sync() there. That way, admin
> > > has chance to unlock his system.
> > 
> > Well, this is a different story.
> > 
> > My point is that if we call sys_sync() _anyway_ before calling
> > freeze_filesystems(), then freeze_filesystems() is _safe_ (either the
> > sys_sync() blocks, or it doesn't in which case freeze_filesystems() won't
> > block either).
> > 
> > This means, however, that we can leave the patch as is (well, with the minor
> > fix I have already posted), for now, because it doesn't make things worse a
> > bit, but:
> > (a) it prevents xfs from being corrupted and
> 
> I'd really prefer it to be fixed by 'freezeable workqueues'.

I'd prefer that you just freeze the filesystem and let the
filesystem do things correctly.

> Can you
> point me into sources -- which xfs workqueues are problematic?

AFAIK, its the I/O completion workqueues that are causing problems.
(fs/xfs/linux-2.6/xfs_buf.c) However, thinking about it, I'm not
sure that the work queues being left unfrozen is the real problem.

i.e. after a sync there's still I/O outstanding (e.g. metadata in
the log but not on disk), and because the kernel threads are frozen
some time after the sync, we could have issued this delayed write
metadata to disk after the sync. With XFS, we can have a of queue of
thousands of metadata buffers for delwri, and they are all issued
async and can take many seconds for the I/O to complete.

The I/O completion workqueues will continue to run until all I/O
stops, and metadata I/O completion will change the state of the
filesystem in memory.

However, even if you stop the workqueue processing, you're still
going to have to wait for all I/O completion to occur before
snapshotting memory because having any I/O complete changes memory
state.  Hence I fail to see how freezing the workqueues really helps
at all here....

Given that the only way to track and block on these delwri metadata
buffers is to issue a sync flush rather than a async flush, suspend
has to do something different to guarantee that we block until all
those I/Os have completed. i.e. freeze the filesystem.

So the problem, IMO, is suspend is not telling the filesystem
to stop doing stuff and so we are getting caught out by doing
stuff that suspend assumes won't happen but does nothing
to prevent.

> > (b) it prevents journaling filesystems in general from replaying journals
> > after a failing resume.

This is incorrect.  Freezing an XFS filesystem _ensures_ that log
replay occurs on thaw or a failed resume.  XFS specifically dirties
the log after a freeze down to a consistent state so that the
unlinked inode lists get processed by recovery on thaw/next mount.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
