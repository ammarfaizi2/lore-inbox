Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030835AbWKOSus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030835AbWKOSus (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030868AbWKOSus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:50:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38583 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030838AbWKOSur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:50:47 -0500
Date: Wed, 15 Nov 2006 19:50:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Chinner <dgc@sgi.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alasdair G Kergon <agk@redhat.com>,
       Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061115185029.GA3722@elf.ucw.cz>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <20061109232438.GS30653@agk.surrey.redhat.com> <20061109233258.GH2616@elf.ucw.cz> <200611101303.33685.rjw@sisk.pl> <20061112184310.GC5081@ucw.cz> <20061112233054.GI11034@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061112233054.GI11034@melbourne.sgi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This means, however, that we can leave the patch as is (well, with the minor
> > > fix I have already posted), for now, because it doesn't make things worse a
> > > bit, but:
> > > (a) it prevents xfs from being corrupted and
> > 
> > I'd really prefer it to be fixed by 'freezeable workqueues'.
> 
> I'd prefer that you just freeze the filesystem and let the
> filesystem do things correctly.

Well, I'd prefer filesystems not to know about suspend, and current
"freeze the filesystem" does not really nest properly.

> > Can you
> > point me into sources -- which xfs workqueues are problematic?
> 
> AFAIK, its the I/O completion workqueues that are causing problems.
> (fs/xfs/linux-2.6/xfs_buf.c) However, thinking about it, I'm not
> sure that the work queues being left unfrozen is the real problem.
> 
> i.e. after a sync there's still I/O outstanding (e.g. metadata in
> the log but not on disk), and because the kernel threads are frozen
> some time after the sync, we could have issued this delayed write
> metadata to disk after the sync. With XFS, we can have a of queue of

That's okay, snapshot is atomic. As long as data are safely in the
journal, we should be okay.

> However, even if you stop the workqueue processing, you're still
> going to have to wait for all I/O completion to occur before
> snapshotting memory because having any I/O complete changes memory
> state.  Hence I fail to see how freezing the workqueues really helps
> at all here....

It is okay to change memory state, just on disk state may not change
after atomic snapshot.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
