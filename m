Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266291AbUGJP1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266291AbUGJP1g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 11:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266292AbUGJP1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 11:27:35 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:20287 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266291AbUGJP1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 11:27:21 -0400
Date: Sun, 11 Jul 2004 01:25:49 +1000
From: Greg Banks <gnb@sgi.com>
To: raven@themaw.net
Cc: Thomas Moestl <moestl@ibr.cs.tu-bs.de>,
       autofs mailing list <autofs@linux.kernel.org>,
       nfs@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] Re: umount() and NFS races in 2.4.26
Message-ID: <20040710152549.GD21121@sgi.com>
References: <20040708180709.GA7704@timesink.dyndns.org> <Pine.LNX.4.58.0407101419210.1378@donald.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407101419210.1378@donald.themaw.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 02:57:46PM +0800, raven@themaw.net wrote:
> On Thu, 8 Jul 2004, Thomas Moestl wrote:
> > I believe that I have found two problems:
> > 
> > - The NFS async unlink code (fs/nfs/unlink.c) does keep a dentry for
> >   later asynchronous processing, but the mount point is unbusied via
> >   path_release() once sys_unlink() returns (fs/namei.c). [...]

This used to be a bug.  It was fixed in 2.4.26 with

http://linux.bkbits.net:8080/linux-2.4/diffs/fs/nfs/dir.c@1.13

What happens now is that the dentry and its inode are cleaned up
when the async unlink task is deleted in nfs_put_super() between
the first and second calls to invalidate_inodes() in kill_super().

> > - There is a SMP race between the shrink_dcache_parent() (fs/dcache.c)
> >   called from kill_super() and prune_dache() called via
> >   shrink_dache_memory() (called by kswapd), as follows: [...]

Your scenario sounds plausible and might explain at least some 
of the autofs unmount races we've been seeing.

> >   In the attached patch, I have used a semaphore to serialize purging
> >   accesses to the dentry_unused list. [...]

Can we see the patch please?

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
