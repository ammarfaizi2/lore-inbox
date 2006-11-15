Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161374AbWKOT7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161374AbWKOT7p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161382AbWKOT7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:59:45 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:2950 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161374AbWKOT7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:59:44 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Date: Wed, 15 Nov 2006 20:56:46 +0100
User-Agent: KMail/1.9.1
Cc: David Chinner <dgc@sgi.com>, Alasdair G Kergon <agk@redhat.com>,
       Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <20061112233054.GI11034@melbourne.sgi.com> <20061115185029.GA3722@elf.ucw.cz>
In-Reply-To: <20061115185029.GA3722@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611152056.48218.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 15 November 2006 19:50, Pavel Machek wrote:
> Hi!
> 
> > > > This means, however, that we can leave the patch as is (well, with the minor
> > > > fix I have already posted), for now, because it doesn't make things worse a
> > > > bit, but:
> > > > (a) it prevents xfs from being corrupted and
> > > 
> > > I'd really prefer it to be fixed by 'freezeable workqueues'.
> > 
> > I'd prefer that you just freeze the filesystem and let the
> > filesystem do things correctly.
> 
> Well, I'd prefer filesystems not to know about suspend, and current
> "freeze the filesystem" does not really nest properly.
> 
> > > Can you
> > > point me into sources -- which xfs workqueues are problematic?
> > 
> > AFAIK, its the I/O completion workqueues that are causing problems.
> > (fs/xfs/linux-2.6/xfs_buf.c) However, thinking about it, I'm not
> > sure that the work queues being left unfrozen is the real problem.
> > 
> > i.e. after a sync there's still I/O outstanding (e.g. metadata in
> > the log but not on disk), and because the kernel threads are frozen
> > some time after the sync, we could have issued this delayed write
> > metadata to disk after the sync. With XFS, we can have a of queue of
> 
> That's okay, snapshot is atomic. As long as data are safely in the
> journal, we should be okay.
> 
> > However, even if you stop the workqueue processing, you're still
> > going to have to wait for all I/O completion to occur before
> > snapshotting memory because having any I/O complete changes memory
> > state.  Hence I fail to see how freezing the workqueues really helps
> > at all here....
> 
> It is okay to change memory state, just on disk state may not change
> after atomic snapshot.

There's one more thing, actually.  If the on-disk data and metadata are
changed _after_ the sync we do and _before_ we create the snapshot image,
and the subsequent  resume fails, there may be problems with recovering
the filesystem.  That is, if I correctly understand what David has told us so
far.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
