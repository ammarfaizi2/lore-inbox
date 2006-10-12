Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422751AbWJLDEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422751AbWJLDEB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 23:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422752AbWJLDEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 23:04:01 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:25015 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422751AbWJLDEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 23:04:00 -0400
Date: Thu, 12 Oct 2006 13:03:44 +1000
From: David Chinner <dgc@sgi.com>
To: NetArt - Grzegorz Nosek <grzegorz.nosek@netart.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 xfs lockdep warning
Message-ID: <20061012030344.GS19345@melbourne.sgi.com>
References: <20061011102838.GA10195@tech.serwery.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011102838.GA10195@tech.serwery.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 12:28:38PM +0200, NetArt - Grzegorz Nosek wrote:
> Hello all,
> 
> (not subscribed, please cc)
> 
> I'd like to report a lockdep warning with 2.6.18 while unmounting a
> xfs filesystem.
> 
> Tested on vanilla 2.6.18, the trace I get is as follows:

Right now, i don't think it is safe to use lockdep with XFS.  We've
just discovered that lockdep can panic the system or cause
use-after-free issues because of the fact that XFS often does not
unlock objects before freeing them. We are working on getting
full lockdep support in XFS, but we are not there yet.

FWIW, this patch might fix the problem you reported.

---
 fs/xfs/xfs_iget.c |    1 +
 1 file changed, 1 insertion(+)

Index: 2.6.x-xfs-new/fs/xfs/xfs_iget.c
===================================================================
--- 2.6.x-xfs-new.orig/fs/xfs/xfs_iget.c	2006-10-11 14:01:46.000000000 +1000
+++ 2.6.x-xfs-new/fs/xfs/xfs_iget.c	2006-10-12 13:00:55.158588110 +1000
@@ -562,6 +562,7 @@ xfs_ireclaim(xfs_inode_t *ip)
 	/*
 	 * Free all memory associated with the inode.
 	 */
+	xfs_iunlock(ip, XFS_ILOCK_EXCL | XFS_IOLOCK_EXCL);
 	xfs_idestroy(ip);
 }


Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
