Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318842AbSICQyg>; Tue, 3 Sep 2002 12:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318845AbSICQyf>; Tue, 3 Sep 2002 12:54:35 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:64138 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318842AbSICQyL>; Tue, 3 Sep 2002 12:54:11 -0400
Date: Tue, 3 Sep 2002 17:58:39 +0100 (BST)
From: Anton Altaparmakov <aia21@cantab.net>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: Rik van Riel <riel@conectiva.com.br>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mount flag "direct" (fwd)
In-Reply-To: <200209031550.g83FogE03775@oboe.it.uc3m.es>
Message-ID: <Pine.SOL.3.96.1020903170130.14707E-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Peter T. Breuer wrote:
> "A month of sundays ago Rik van Riel wrote:"
> > On Tue, 3 Sep 2002, Peter T. Breuer wrote:
> > 
> > > I assumed that I would need to make several VFS operations atomic
> > > or revertable, or simply forbid things like new file allocations or
> > > extensions (i.e.  the above), depending on what is possible or not.
> > 
> > > No, I don't want ANY FS. Thanks, I know about these, but they're not
> > > it. I want support for /any/ FS at all at the VFS level.
> > 
> > You can't.  Even if each operation is fully atomic on one node,
> > you still don't have synchronisation between the different nodes
> > sharing one disk.
> 
> Yes, I do have synchronization - locks are/can be shared between both
> kernels using a device driver mechanism that I implemented. That is
> to say, I can guarantee that atomic operations by each kernel do not
> overlap "on the device", and remain locally ordered at least (and
> hopefully globally, if I get the time thing right).
> 
> It's not that hard - the locks are held on the remote disk by a
> "guardian" driver, to which the drivers on both of the kernels
> communicate.  A fake "scsi adapter", if you prefer.

You have synchronisation at block layer level which is completely
insufficient.

> > You really need filesystem support.
> 
> I don't think so. I think you're not convinced either! But
> I would really like it if you could put your finger on an
> overriding objection.

You think wrong... (-;

I will give you a few examples of the why you are wrong:

1) Neither the block layer nor the VFS have anything to do with block
allocations and hence you cannot solve this problem at VFS nor block layer
level. The only thing the VFS does is tell the file system driver "write X
number of bytes to the file F at offset Y". Nothing more than that! The
file system then goes off and allocates blocks in its own disk block
bitmap and then writes the data. The only locking used is file system
specific. For example NTFS has a per mounted volume rw_semaphore to
synchronize accesses to the disk block bitmap. But other file systems most
certainly implement this differently...

2) Some file systems cache the metadata. For example in NTFS the
disk block bitmap is stored inside a normal file called $Bitmap. Thus NTFS
uses the page cache to access the block bitmap and this means that when
new blocks are allocated, we take the volume specific rw_semaphore and
then we search the page cache of $Bitmap for zero bits, set the
required number of bits to one, and then we drop the rw_semaphore and
return which blocks were allocated to the calling ntfs function.

Even if you modified the ntfs driver so that the two hosts accessing the
same device would share the same rw_semaphore, it still wouldn't work,
because there is no synchroisation between the disk block bitmap on the
two hosts. When one has gone through the above procedure and has dropped
the lock, the allocate clusters are held in memory only, thus the other
host doesn't see that some blocks have been allocated and goes off and
allocates the same blocks to a different file as Rik and myself described
already.

And this is just the tip of the iceberg. The only way you could get
something like this to work is by modifying each and every file system
driver to use some VFS provided mechanism for all (de-)allocations, both
disk block, and inode ones. Further you would need to provide shared
memory, i.e. the two hosts need to share the same page cache / address
space mappings. So basically, it can only work if the two hosts are
virtually the same host, i.e. if the two hosts are part of a Single System
Image Cluster...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

