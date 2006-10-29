Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbWJ2XwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbWJ2XwA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 18:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbWJ2XwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 18:52:00 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:57310 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1030459AbWJ2Xv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 18:51:59 -0500
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, David Chinner <dgc@sgi.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com, Christoph Hellwig <hch@infradead.org>
In-Reply-To: <200610300029.25555.rjw@sisk.pl>
References: <1161576735.3466.7.camel@nigel.suspend2.net>
	 <20061027013802.GQ8394166@melbourne.sgi.com>
	 <20061029173537.GA3022@elf.ucw.cz>  <200610300029.25555.rjw@sisk.pl>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 10:46:26 +1100
Message-Id: <1162165587.16177.7.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2006-10-30 at 00:29 +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> On Sunday, 29 October 2006 18:35, Pavel Machek wrote:
> > Hi!
> > 
> > > > > > As you have them at the moment, the threads seem to be freezing fine.
> > > > > > The issue I've seen in the past related not to threads but to timer
> > > > > > based activity. Admittedly it was 2.6.14 when I last looked at it, but
> > > > > > there used to be a possibility for XFS to submit I/O from a timer when
> > > > > > the threads are frozen but the bdev isn't frozen. Has that changed?
> > > > > 
> > > > > I didn't think we've ever done that - periodic or delayed operations
> > > > > are passed off to the kernel threads to execute. A stack trace
> > > > > (if you still have it) would be really help here.
> > > > > 
> > > > > Hmmm - we have a couple of per-cpu work queues as well that are
> > > > > used on I/O completion and that can, in some circumstances,
> > > > > trigger new transactions. If we are only flush metadata, then
> > > > > I don't think that any more I/o will be issued, but I could be
> > > > > wrong (maze of twisty passages).
> > > > 
> > > > Well, I think this exactly is the problem, because worker_threads run with
> > > > PF_NOFREEZE set (as I've just said in another message).
> > > 
> > > Ok, so freezing the filesystem is the only way you can prevent
> > > this as the workqueues are flushed as part of quiescing the filesystem.
> > 
> > Well, alternative is to teach XFS to sense that we are being frozen
> > and stop disk writes in such case.
> > 
> > OTOH freeze_bdevs is perhaps not that bad solution... 
> 
> Okay, appended is a patch that implements the freezing of bdevs in a slightly
> different way than the Nigel's patch did it.

> As Christoph suggested, I have put freeze_filesystems() and thaw_filesystems()
> into fs/buffer.c and indroduced the MS_FROZEN flag to mark frozen
> filesystems.
> 
> It seems to work fine, except I get the following trace from lockdep during
> the suspend on a regular basis (not 100% reproducible, though):
> 
> Stopping tasks...
> =============================================
> [ INFO: possible recursive locking detected ]
> 2.6.19-rc2-mm2 #15
> ---------------------------------------------
> s2disk/5564 is trying to acquire lock:
>  (&bdev->bd_mount_mutex){--..}, at: [<ffffffff80475e79>] mutex_lock+0x9/0x10
> 
> but task is already holding lock:
>  (&bdev->bd_mount_mutex){--..}, at: [<ffffffff80475e79>] mutex_lock+0x9/0x10
> 
> other info that might help us debug this:
> 3 locks held by s2disk/5564:
>  #0:  (&bdev->bd_mount_mutex){--..}, at: [<ffffffff80475e79>] mutex_lock+0x9/0x10
>  #1:  (&type->s_umount_key#16){----}, at: [<ffffffff80291647>] get_super+0x67/0xc0
>  #2:  (&journal->j_barrier){--..}, at: [<ffffffff80475e79>] mutex_lock+0x9/0x10
> 
> stack backtrace:
> 
> Call Trace:
>  [<ffffffff8020af79>] dump_trace+0xb9/0x430
>  [<ffffffff8020b333>] show_trace+0x43/0x60
>  [<ffffffff8020b635>] dump_stack+0x15/0x20
>  [<ffffffff8024a1d1>] __lock_acquire+0x881/0xc60
>  [<ffffffff8024a94d>] lock_acquire+0x8d/0xc0
>  [<ffffffff80475cd4>] __mutex_lock_slowpath+0xd4/0x270
>  [<ffffffff80475e79>] mutex_lock+0x9/0x10
>  [<ffffffff802b2bb6>] freeze_bdev+0x16/0x80
>  [<ffffffff802b3105>] freeze_filesystems+0x55/0x80
>  [<ffffffff80255942>] freeze_processes+0x1e2/0x360
>  [<ffffffff802592a3>] snapshot_ioctl+0x163/0x610
>  [<ffffffff8029cf0b>] do_ioctl+0x6b/0xa0
>  [<ffffffff8029d1eb>] vfs_ioctl+0x2ab/0x2d0
>  [<ffffffff8029d27a>] sys_ioctl+0x6a/0xa0
>  [<ffffffff80209c2e>] system_call+0x7e/0x83
>  [<00002afb13a4d8a9>]
> 
> done.
> Shrinking memory... done (19126 pages freed)
> 
> Greetings,
> Rafael
> 
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Heh. I've just prepared almost exactly the same patch (except for
unwinding the process thawing).

I haven't ever seen those mutex warnings - is that due to something new
in -mm or one of those gazillion new warnings you can enable in vanilla?

Apart from that, I'll add:

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

Regards,

Nigel

