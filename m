Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290825AbSARVOv>; Fri, 18 Jan 2002 16:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290828AbSARVOo>; Fri, 18 Jan 2002 16:14:44 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:25351 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S290824AbSARVO3>; Fri, 18 Jan 2002 16:14:29 -0500
Message-ID: <3C488E84.A1453ED2@zip.com.au>
Date: Fri, 18 Jan 2002 13:07:16 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Guillaume Boissiere <boissiere@mediaone.net>, linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  January 18, 2002
In-Reply-To: <3C477B7F.22875.11D4078A@localhost> <Pine.GSO.4.21.0201180546310.296-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Fri, 18 Jan 2002, Guillaume Boissiere wrote:
> 
> > o Merged     New scheduler for improved scalability        (Ingo Molnar, Davide Libenzi)
> > o Merged     Rewrite of the block IO (bio) layer           (Jens Axboe)
> > o Merged     New kernel device structure (kdev_t)          (Linus Torvalds, etc)
> > o Merged     Initial support for USB 2.0                   (David Brownell, Greg Kroah-Hartman,
> 
> Merged: Per-process namespaces, late-boot cleanups.
> Ready: switch to ->get_super() as primary file_system_type method.
> Ready: ->getattr() handling and changes of ->setattr()/->permission()
> prototypes.
> Pending: proper UFS fixes, ext2 cleanups and locking
> changes.
> Pending: per-mountpoint read-only, union-mounts and unionfs.
> Pending: lifting limitations on mount(2)
> In progress: killing kdev_t for block devices (switch to struct block_device *)
> Started: UMSDOS rewrite (the damn thing blocks struct inode trimming)
> Planned: new mount API.

Please can we provide some way for filesystems to know whether
a whole-fs sync() is happening?

At present, ext3_write_super() doesn't know whether it's called
on the kupdate path (where waiting on I/O completion is inappropriate)
or on the sys_sync() path (where it is appropriate).

I think super_operations.sync(struct super_block *sb, int wait)
is an appropriate way to do this.

In fact the whole synchronous-operation thing is a bit of a
twisty mess at present.  There are several places where
ext3 has to use magical intuition to work out which part of
the kernel is calling it in which mode and why.

Note how ext3_file_write() calls mark_inode_dirty() if the
write in synchronous, just to ensure that generic_file_write()
will later call generic_osync_inode().  blech.  This took
some time to sort out, and is fragile.

-
