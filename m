Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbUKPQb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbUKPQb3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 11:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUKPQb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 11:31:28 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:49605 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262039AbUKPQ37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 11:29:59 -0500
Date: Tue, 16 Nov 2004 10:28:59 -0600
From: Robin Holt <holt@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org, dev@sw.ru,
       wli@holomorphy.com, steiner@sgi.com, sandeen@sgi.com
Subject: Re: 21 million inodes is causing severe pauses.
Message-ID: <20041116162859.GA5594@lnx-holt.americas.sgi.com>
References: <20041115195551.GA15380@lnx-holt.americas.sgi.com> <20041115145714.3f757012.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041115145714.3f757012.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 02:57:14PM -0800, Andrew Morton wrote:
> Robin Holt <holt@sgi.com> wrote:
> >
> > One significant problem we are running into is autofs trying to umount the
> > file systems.  This results in the umount grabbing the BKL and inode_lock,
> > holding it while it scans through the inode_list and others looking for
> > inodes used by this super block and attempting to free them.
> 
> You'll need invalidate_inodes-speedup.patch and
> break-latency-in-invalidate_list.patch (or an equivalent).
> 

I added the break-latency-in-invalidate_list.patch to the SLES9 kernel.
I am running the test again, but do not see how that change can do anything
to eliminate the race condition which appears to leave me with a NULL
pointer.  I will dig into that more today if other obligations allow it.

> That'll get you most of the way, but the BKL will still be a problem.
> 
> Removing lock_kernel() in the umount path is probably a major project so
> for now, you can just drop and reacquire it by doing
> release_kernel_lock()/reacquire_kernel_lock() around invalidate_inodes().

I guess I am very concerned at this point.  If I can do a
release/reacquire, why not just change generic_shutdown_super() so the
lock_kernel() does not happen until the first pass has occurred.  ie:

--- super.c.orig        2004-11-16 10:22:17 -06:00
+++ super.c     2004-11-16 10:22:41 -06:00
@@ -232,10 +232,10 @@
                dput(root);
                fsync_super(sb);
                lock_super(sb);
-               lock_kernel();
                sb->s_flags &= ~MS_ACTIVE;
                /* bad name - it should be evict_inodes() */
                invalidate_inodes(sb);
+               lock_kernel();

                if (sop->write_super && sb->s_dirt)
                        sop->write_super(sb);

This at least makes the lock_kernel time much smaller than it is right
now.  It also does not affect any callers that may really need the BKL.


I guess I am really asking for an indication of what the BKL is supposed
to be protecting.  I have not dug for the intent down the VFS code paths
at all.
