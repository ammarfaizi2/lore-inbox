Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316712AbSFDURH>; Tue, 4 Jun 2002 16:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316715AbSFDURG>; Tue, 4 Jun 2002 16:17:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58374 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316712AbSFDURE>;
	Tue, 4 Jun 2002 16:17:04 -0400
Message-ID: <3CFD1FF0.4A02CE96@zip.com.au>
Date: Tue, 04 Jun 2002 13:15:44 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Chris Mason <mason@suse.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 12/16] fix race between writeback and unlink
In-Reply-To: <3CFBEDEE.EE74C5B1@zip.com.au> <Pine.LNX.4.44.0206041142390.954-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 3 Jun 2002, Andrew Morton wrote:
> >
> > But why does ext2_put_inode() even exist?  We're already throwing
> > away the prealloc window in ext2_release_file?  I guess for
> > shared mappings over spares files: if all file handles have
> > closed off, we still need to make allocations against that
> > inode, yes?
> 
> Shared mappings still hold the "struct file" open (you have
> "vma->vm_file->f_dentry->d_inode"), so you still have the file handle
> while the mapping is open.

But after the vma has been destroyed (the application did exit()),
the dirty pagecache data against the sparse mapped file still
hasn't been written, and still doesn't have a disk mapping.

So in this case, we have an inode which still has pending block
allocations which has no struct file's pointing at it.  Or
am I wrong?

> I assume that the reason is that _any_ block allocation will trigegr
> pre-alloc, which means that we have preallocation for things like
> directories etc too - which really do not have a "struct file" associated
> with them.
> 
> Whether that is really worth it is unclear, but it also means that ext2
> doesn't have to pass down the "struct file" to the lower levels at all, as
> it keeps all pre-alloc stuff in the inode.

The current preallocation will screw up is when there's a
large-and-sparse file which has blocks being allocated against it
at two or more offsets.  And those allocations are for a large number
of blocks, and they are proceeding slowly.  Something like:

	for (i = 0; i < 16; i++) {
		pwrite(fd, buf, 4096, offset1 + i * 4096);
		pwrite(fd, buf, 4096, offset2 + i * 4096);
	}

this would cause preallocation thrashing, and those blocks
would be laid out as ABABABAB.   The same would happen if
the prealloc information is per-file as well, of course.
The app would have to be using different file descriptors
to avoid it.

So from a file-layout point of view, I don't see a lot of
benefit in moving the preallocation info into struct file.

(Delayed allocation plus writeback-time sorting would fix it
all up.  With delayed allocate, the prealloc code can visit
the bitbucket).
 
-
