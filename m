Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315536AbSECCQj>; Thu, 2 May 2002 22:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315537AbSECCQi>; Thu, 2 May 2002 22:16:38 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:51867 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315536AbSECCQi>;
	Thu, 2 May 2002 22:16:38 -0400
Date: Thu, 2 May 2002 22:16:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Paul Menage <pmenage@ensim.com>
cc: torvalds@transmeta.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace exec_permission_lite() with inlined vfs_permission()
In-Reply-To: <E173S7J-0004EH-00@pmenage-dt.ensim.com>
Message-ID: <Pine.GSO.4.21.0205022159040.17171-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 May 2002, Paul Menage wrote:

> 
> Since exec_permission_lite() is now basically an inlined and
> constant-propagated duplicate of vfs_permission(), this patch drops
> exec_permission_lite() and makes vfs_permission() inlined (but not
> static) and calls it from link_path_walk() if the inode doesn't have an
> i_op->permission() method.

IMO it's a bad idea.  In many cases we have ->permission() but it's
perfectly OK with being called under dcache_lock - either always or
in (fs-specific) "fast case".

I would prefer ->permission_light() that would always be called
under dcache_lock and besides the usual values could return -EAGAIN.
In that case ->permission() would be called in a normal way.

Corresponding permission_light(9) and permission(9) would be used
in obvious way.

vfs_permission() is just a default value of ->permission() - in effect
you are doing an equivalent of
	if (inode->i_op->permission == vfs_permission)
		/* we know it's OK to call under dcache_lock */
- just that we represent vfs_permission as NULL in i_op.  The reason
why it's Not Nice(tm) should be obvious...

