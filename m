Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264949AbUELDJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbUELDJy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 23:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbUELDJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 23:09:54 -0400
Received: from thunk.org ([140.239.227.29]:35238 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S264949AbUELDJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 23:09:50 -0400
Date: Tue, 11 May 2004 23:09:15 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Valdis.Kletnieks@vt.edu
Cc: John McGowan <jmcgowan@inch.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Kernel 2.6.6: Removing the last large file does not reset filesystem properties
Message-ID: <20040512030915.GA4245@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Valdis.Kletnieks@vt.edu,
	John McGowan <jmcgowan@inch.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <20040511002008.GA2672@localhost.localdomain> <20040511004956.70f7e17d.akpm@osdl.org> <20040511084510.J33555@shell.inch.com> <200405111532.i4BFWQIs029188@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405111532.i4BFWQIs029188@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 11:32:26AM -0400, Valdis.Kletnieks@vt.edu wrote:
> > I know what's happening and how to patch the initscript to get an
> > automatic reboot on exit code 2. Is that the proper way to handle it?
> 
> NO.
> 

YES.

Well, actially, the initscripts should reboot if the ((status & 2) != 0).
Or more simply, if the exit status is 2 or 3.

> Consider - if you *do* scrog your filesystem, you'll get hung in a loop
> of fsck/reboot/fsck/reboot/fsck/reboot.  You really *do* want the system
> to yell for help from a human at that point....

This is not a problem.  E2fsck only returns an exit status of 2 or 3
when it was able to cleanup the filesystem on its own.  The "reboot
requested" bit just means that the root filesystem was modified, and
there was no guarantees that the kernel might have cached information
which might get flushed to disk when the filesystem is remounted
read-write.  Hence, the need for a reboot.

Yes, this might seem a little Windows-esque, but for people who are
careful to keep their root partitions small (say, around 128 megs or
so), and use separate partitions for /usr and /var, this isn't a
problem.  For people who do use a single massive root filesystem, then
the need to reboot after e2fsck does a "preen" operation becomes more
common (although with ext3, this will rarely come up).  

The need to reboot could be removed if the remount of the read-only
filesystem to be read-write also caused the kernel to flush all state
and force everything to be reread from disk.  But this means flushing
all dentries, including possiblies dentries in use, and this was
ultimately decided to be Too Hard, and the idea was shot down by the
Grand Penguin himself.  

As far as your concern about infinite loops of
fsck/reboot/fsck/reboot, it isn't an issue.  If the filesystem is
actually massively scrod, to the point where human assistance is
necessary, then e2fsck will return an exit code of 4:

            4    - File system errors left uncorrected

Which should cause the initscripts to call for help.  An exit code of
2 or 3 merely means that the fsck is doing just fine, thank you very
much, and just needs a reboot in order to flush the disk caches.

						- Ted

P.S.  The real right answer is that the fsck of the root partition
should take place *before* the root partition is mounted, in the
initial ramdisk.  This gets rid of the whole need to flush the system
caches, since the (real) root filesystem isn't mounted at all during
the time of the initial check.

