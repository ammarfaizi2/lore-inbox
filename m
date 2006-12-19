Return-Path: <linux-kernel-owner+w=401wt.eu-S1751912AbWLSCwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbWLSCwq (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 21:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752263AbWLSCwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 21:52:46 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:40296 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751912AbWLSCwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 21:52:45 -0500
Date: Tue, 19 Dec 2006 13:52:29 +1100
From: David Chinner <dgc@sgi.com>
To: Haar =?iso-8859-1?Q?J=E1nos?= <djani22@netcenter.hu>
Cc: David Chinner <dgc@sgi.com>, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: xfslogd-spinlock bug?
Message-ID: <20061219025229.GT33919298@melbourne.sgi.com>
References: <003701c71d78$33ed28d0$0400a8c0@dcccs> <Pine.LNX.4.64.0612120932220.19050@p34.internal.lan> <00ab01c71e53$942af2f0$0400a8c0@dcccs> <000d01c72127$3d7509b0$0400a8c0@dcccs> <20061217224457.GN33919298@melbourne.sgi.com> <026501c72237$0464f7a0$0400a8c0@dcccs> <20061218062444.GH44411608@melbourne.sgi.com> <027b01c7227d$0e26d1f0$0400a8c0@dcccs> <20061218223637.GP44411608@melbourne.sgi.com> <001a01c722fd$df5ca710$0400a8c0@dcccs>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <001a01c722fd$df5ca710$0400a8c0@dcccs>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 12:39:46AM +0100, Haar János wrote:
> From: "David Chinner" <dgc@sgi.com>
> > On Mon, Dec 18, 2006 at 09:17:50AM +0100, Haar János wrote:
> > > From: "David Chinner" <dgc@sgi.com>
> > > > Ok, I've never heard of a problem like this before and you are doing
> > > > something that very few ppl are doing (i.e. XFS on NBD). I'd start
> > > > Hence  I'd start by suspecting a bug in the NBD driver.
> > >
> > > Ok, if you have right, this also can be in context with the following
> issue:
> > >
> > > http://download.netcenter.hu/bughunt/20061217/messages.txt   (10KB)
> >
> > Which appears to be a crash in wake_up_process() when doing memory
> > reclaim (waking the xfsbufd).
> 
> Sorry, can you translate it to "poor mans language"? :-)
> This is a different bug?

Don't know - it's a different crash, but once again one that I've
never heard of occurring before.

> > Ok, I've found this pattern:
> >
> > #define POISON_FREE 0x6b
> >
> > Can you confirm that you are running with CONFIG_DEBUG_SLAB=y?
> 
> Yes, i build with this option enabled.
> Is this wrong?

No, but it does slow your machine down.

> > If so, we have a use after free occurring here and it would also
> > explain why no-one has reported it before.
> >
> > FWIW, can you turn on CONFIG_XFS_DEBUG=y and see if that triggers
> > a different bug check prior to the above dump?
> 
> [root@X64 linux-2.6.19]# make bzImage
> scripts/kconfig/conf -s arch/x86_64/Kconfig
> .config:7:warning: trying to assign nonexistent symbol XFS_DEBUG
> 
> I have missed something?

No - I forgot that config option doesn't exist in mainline XFS - it's
only in the dev tree.

FWIW, I've run XFSQA twice now on a scsi disk with slab debuggin turned
on and I haven't seen this problem. I'm not sure how to track down
the source of the problem without a test case, but as a quick test, can
you try the following patch?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group


---
 fs/xfs/linux-2.6/xfs_buf.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: 2.6.x-xfs-new/fs/xfs/linux-2.6/xfs_buf.c
===================================================================
--- 2.6.x-xfs-new.orig/fs/xfs/linux-2.6/xfs_buf.c	2006-12-19 12:22:54.000000000 +1100
+++ 2.6.x-xfs-new/fs/xfs/linux-2.6/xfs_buf.c	2006-12-19 13:48:36.937118569 +1100
@@ -942,11 +942,14 @@ xfs_buf_unlock(
 /*
  *	Pinning Buffer Storage in Memory
  *	Ensure that no attempt to force a buffer to disk will succeed.
+ *	Hold the buffer so we don't attempt to free it while it
+ *	is pinned.
  */
 void
 xfs_buf_pin(
 	xfs_buf_t		*bp)
 {
+	xfs_buf_hold(bp);
 	atomic_inc(&bp->b_pin_count);
 	XB_TRACE(bp, "pin", (long)bp->b_pin_count.counter);
 }
@@ -958,6 +961,7 @@ xfs_buf_unpin(
 	if (atomic_dec_and_test(&bp->b_pin_count))
 		wake_up_all(&bp->b_waiters);
 	XB_TRACE(bp, "unpin", (long)bp->b_pin_count.counter);
+	xfs_buf_rele(bp);
 }
 
 int
