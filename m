Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316928AbSGCGEx>; Wed, 3 Jul 2002 02:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316935AbSGCGEw>; Wed, 3 Jul 2002 02:04:52 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:59279 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316928AbSGCGEv>;
	Wed, 3 Jul 2002 02:04:51 -0400
Date: Wed, 3 Jul 2002 02:07:20 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Matthew Wilcox <willy@debian.org>
cc: Paul Menage <pmenage@ensim.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shift BKL into ->statfs()
In-Reply-To: <20020703035744.K27706@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.GSO.4.21.0207030202040.6472-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Jul 2002, Matthew Wilcox wrote:

> On Tue, Jul 02, 2002 at 06:25:47PM -0700, Paul Menage wrote:
> > This patch removes BKL protection from the invocation of the
> > super_operations ->statfs() method, and shifts it into the filesystems
> > where necessary. Any out-of-tree filesystems may need to take the BKL in
> > their statfs() methods if they were relying on it for synchronisation.
> 
> Sure, makes sense to do.  For real credit though, let's see how much we
> need the BKL.  In ext2's statfs, we reference:

[snip]

> s_mount_opt doesn't actually need to be locked due to how it is
> modified & used.  So it _looks_ like we only need to lock_super(sb); /
> unlock_super(sb); in ext2.  Anyone more familiar with ext2 locking care
> to comment?

We actually don't need even that - the only places that might need
lock_super() (ext2_count_free_blocks()/ext2_count_free_inodes()) are
already taking it.

So BKL can be dropped in ext2_statfs() and no extra locks are needed.

> I bet most other filesystems can handle lock_super / unlock_super
> for themselves.  See if some kerneljanitors are willing to help audit,
> perhaps?

Depending on filesystem, lock_super() might be a bad idea.  Keep in
mind that these days ->s_lock is a private filesystem lock...

