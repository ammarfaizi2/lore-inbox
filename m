Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVDDTKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVDDTKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 15:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVDDTKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 15:10:18 -0400
Received: from science.horizon.com ([192.35.100.1]:25927 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261337AbVDDTIp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 15:08:45 -0400
Date: 4 Apr 2005 19:08:22 -0000
Message-ID: <20050404190822.31392.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: mmap tricks and writing to files without reading first
Cc: linux@horizon.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a database-like application that logs transactions to a file.
I mmap() pages of the log file and do "minor commits" as cheap memory
writes, and then I periodically write(O_SYNC) the mmapped copy back to
the file ("on top if itself") to force the data to stable storage for a
"major commit".

(This involves some redundant data copying, but my understanding is that it's
still a better-optimized fast path than msync(MS_SYNC); am I correct?)


Anyway, I just had an interesting experience with my logging server
crashing repeatedly.  It's supposed to be written extremely defensively
and check everything, so I was somewhat alarmed.

After some debugging, it turned out that the underlying disk had developed
a bad sector in the middle of my log file.  Attempting to read it caused
an I/O error, that was reported to my application as SIGBUS.

(Unfortunately, finding the location is quite tricky.  I've even dumped
out the signal handler's ((ucontext_t *)third_arg)->uc_mcontext.gregs
and it's not obvious where the crash is happening.)

However, the only reason it was trying to *read* it was so that it
could populate the mmap() pages I was trying to write to.  But this is
an append log; I don't need the old data on that page.

If I avoided that first read of the data, then
1) Unless I crashed and needed to replay the log at just the wrong time,
   it would have masked the bad-block problem (as overwriting them let
   the drive reallocate the sectors and the problem went away), and
2) My application would be more efficient!

Conveniently, the log structure is defined so all-zeros is an empty page,
so all I need to do is to tell the kernel that the following page should
be filled with all-zero, and don't even bother reading the disk.


This now leads me to the question of how to do that most efficiently.
Obviously, my application performance is mostly limited by the O_SYNC
writes, but there's no sense wasting CPU time or memory that other
applications could use.

The zeros are going to get overwritten with data reasonably soon, so
there's no sense making them shared pages.  But I can't memset() it
from uzer-space, or the first write will page the old data in because
the kernel doesn't know the rest are coming.  That was my problem in
the first place!

I can't read(2) /dev/zero on top of it because that's not optimized...
see read_zero_pagealigned().  If the vma is VM_SHARED, then it doesn't do
MMU tricks and just calls clear_user(), which is basically the same as
a memset() from user space and will fault the data in when it starts.

Probably a write(2), without O_SYNC, would do the right thing.  I've tried
to follow the path of sys_write through to find the logic that avoids
paging in data that's going to be completely overwritten, and it's
a bit confusing... 

	sys_write ->
	vfs_write ->
	file->f_op->write ->
	generic_file_write ->
	__generic_file_write_nolock ->
	__generic_file_aio_write_nolock ->
	generic_file_buffered_write ->	/* Things start to get confusing here */
	a_ops->prepare_write ->
	ext2_prepare_write ->
	block_prepare_write ->
	ll_rw_block

The ext3 chain is a litte different but seems to end up in the same place:
	sys_write ->
	vfs_write ->
	file->f_op->write ->
	do_sync_write ->
	file->f_op->aio_write ->
	ext3_file_write ->
	generic_file_aio_write ->
	__generic_file_aio_write_nolock ->
	generic_file_buffered_write ->	/* Things start to get confusing here */
	a_ops->prepare_write ->
	ext3_prepare_write ->
	block_prepare_write ->
	ll_rw_block

I *think* the logic in block_prepare_write is somehow avoiding the call
to ll_rw_block if the write covers the entire block, but it's been a
while since I read a description of buffer_new() and buffer_uptodate()
and my head is spinning pretty fast at that point.

Or is the I/O done in the passed-in get_block function?


Anyway, perhaps I can just blindly hope that the kernel is smart enough
to Do The Right Thing, and see about where to get the big chunk of zeros
to write to it.

Obviously, I *could* just allocate a page and zero-fill it, but my log
pages are considerably larger than 4K and that seems wasteful.  I'd rather
just map a number of copies of the kernel's master zero page and use
that.


Which leads me to the question... how to do that?  There appear to be
several options:

1) mmap(0, SIZE, PROT_READ, MAP_SHARED|MAP_ANONYMOUS, -1, 0)
2) mmap(0, SIZE, PROT_READ, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
3) mmap(0, SIZE, PROT_READ, MAP_SHARED, open("/dev/zero", O_RDONLY), 0)
4) mmap(0, SIZE, PROT_READ, MAP_PRIVATE, open("/dev/zero", O_RDONLY), 0)

I'm not sure which of those would be "best" in the sense of minimum overhead.

Does anyone have any suggestions?  Or a completely different way to zero
out a chunk of a file without reading it in?  I don't want to actually
make a hole in the log file or I'd fragment it and increase the risk of
ENOSPC problems.  I could create just a single zero page and writev()
multiple copies of it, but then I have to worry about the system page
size (I'm not sure if the kernel will DTRT and not page in half of an
8K page if I writev() two 4K vectors to it), and it prevents me from
using pwrite().

I haven't tracked down the splice() idea that sct mentioned in
http://www.ussg.iu.edu/hypermail/linux/kernel/0002.3/0057.html
It appears that sendfile() can't be used for the purpose.


Finally, is there a standard semantics for the interaction between mmap()
and read()/write()?  I have a dim recollection of seeing Linus rant that
anything other than making writes via one path instantly available to
the other is completely brain-dead, which would make the most sense if
some standard somewhere allows weaker synchronization, but I can't seem
to find that rant again, and it was a long time ago.

I also note that there doesn't seem to be an msync() flag for "make
changes visible to read(2) users (i.e. flush them to the buffer
cache), but DON'T schedule a disk write yet", which I assume a weaker
synchronization model would provide.

I also can't find any mention of the possibility of weaker ordering
in the descriptions of mmap() I've seen at www.opengroup.org.  But it
doesn't come right out and clearly require strong ordering, either, and
I can just imagine some vendor with a virtually-addresed cache getting
creative and saying "show me where it says I can't do that!".

The one phrase that concerns me is the caution in SUSv2 that

# The application must ensure correct synchronisation when using mmap()
# in conjunction with any other file access method, such as read() and
# write(), standard input/output, and shmat().
http://www.opengroup.org/onlinepubs/007908799/xsh/mmap.html

Great, but what's "correct"?


The part of the semantics I particularly need to be clearly defined is
what happens if my application crashes after writing to an mmap buffer
but before msync() or munmap().


Thanks for any enlightenment on this somewhat confusing issue!
