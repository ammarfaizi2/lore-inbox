Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261574AbSIZXxD>; Thu, 26 Sep 2002 19:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261579AbSIZXxD>; Thu, 26 Sep 2002 19:53:03 -0400
Received: from thunk.org ([140.239.227.29]:64672 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261574AbSIZXxC>;
	Thu, 26 Sep 2002 19:53:02 -0400
Date: Thu, 26 Sep 2002 19:57:41 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ryan Cumming <ryan@completely.kicks-ass.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Message-ID: <20020926235741.GC10551@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Ryan Cumming <ryan@completely.kicks-ass.org>,
	linux-kernel@vger.kernel.org
References: <E17uINs-0003bG-00@think.thunk.org> <200209261208.59020.ryan@completely.kicks-ass.org> <20020926220432.GB10551@think.thunk.org> <200209261553.07593.ryan@completely.kicks-ass.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209261553.07593.ryan@completely.kicks-ass.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 03:53:02PM -0700, Ryan Cumming wrote:
> The one mildly interesting thing was:
> Sep 26 11:49:06 (none) kernel: EXT3-fs: INFO: recovery required on readonly 
> filesystem.
> Sep 26 11:49:06 (none) kernel: EXT3-fs: write access will be enabled during 
> recovery.
> Sep 26 11:49:06 (none) kernel: EXT3-fs warning (device ide0(3,2)): 
> ext3_clear_journal_err: Filesystem error recorded from previous mount: IO 
> failure
> Sep 26 11:49:06 (none) kernel: EXT3-fs warning (device ide0(3,2)): 
> ext3_clear_journal_err: Marking fs in need of filesystem check.
> Sep 26 11:49:06 (none) kernel: EXT3-fs: ide0(3,2): orphan cleanup on readonly 
> fs
> Sep 26 11:49:06 (none) kernel: EXT3-fs: recovery complete.
> Sep 26 11:49:06 (none) kernel: EXT3-fs: mounted filesystem with ordered data 
> mode.
> Sep 26 11:49:06 (none) kernel: EXT3 FS 2.4-0.9.18, 14 May 2002 on ide0(3,2), 
> internal journal

Wait a second.  These messages would occur only if you had done a
read-only mount at 11:49:06.  Did you do a manual mount at that time?
Do you have one or more filesystems in your /etc/fstab (in particular
/dev/hda2) that are set to be mounted read-only?  That's the only
thing that would explain the "write access enabled during recovery of
readonly filesystem" warning message.  That message means that
/dev/hda2 was readonly because the mount command *requested* that it
be mounted read-only, not because of some error.  

The other strange thing from these syslog messages is that, (a) they
indicate that the filesystem wasn't checked by e2fsck before they were
mounted --- which is what I generally recommend: let e2fsck run the
journal take take care of the recovery, and (b) the reason why the
filesystem was marked as being "in error" is because the previous time
the filesystem was mounted, something reported an IO error.  That
could be a hardware problem, but it's also used as a generic error by
much of the exte filesystem code, so we really need the log entry,
which should have been the previous time this filesystem had been
mounted.

How is your system configured vis-a-vis the /etc/fstab entry for
/dev/hda2?

						- Ted

