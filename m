Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318855AbSICRVz>; Tue, 3 Sep 2002 13:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318856AbSICRVz>; Tue, 3 Sep 2002 13:21:55 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:29202 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S318855AbSICRVu>;
	Tue, 3 Sep 2002 13:21:50 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209031726.g83HQH915152@oboe.it.uc3m.es>
Subject: Re: [RFC] mount flag "direct" (fwd)
In-Reply-To: <Pine.SOL.3.96.1020903170130.14707E-100000@libra.cus.cam.ac.uk>
 from Anton Altaparmakov at "Sep 3, 2002 05:58:39 pm"
To: Anton Altaparmakov <aia21@cantab.net>
Date: Tue, 3 Sep 2002 19:26:17 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, Rik van Riel <riel@conectiva.com.br>,
       linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Anton Altaparmakov wrote:"
> > It's not that hard - the locks are held on the remote disk by a
> > "guardian" driver, to which the drivers on both of the kernels
> > communicate.  A fake "scsi adapter", if you prefer.
> 
> You have synchronisation at block layer level which is completely
> insufficient.

No, I have syncronization whenever one cares to ask for it (the level
is purely notional), but I suggest that one adds a "tag" request type
to the block layers in order that one may ask for a lock at VFS level
by issuing a "tag block request", which does nothing except stop
anybody else from processing the named notional resource until the
corresponding "untag block request" is issued.

> 1) Neither the block layer nor the VFS have anything to do with block
> allocations and hence you cannot solve this problem at VFS nor block layer

That's OK. We've already agreed that the fs's need to reserve blocks
before they make an allocaton, and that they need to do that by calling
up to VFS to reserve it, and that VFS ought to call back down to let
them reserve it the way they like, but take the opportunity to notice
the reserve call.

> level. The only thing the VFS does is tell the file system driver "write X
> number of bytes to the file F at offset Y". Nothing more than that! The
> file system then goes off and allocates blocks in its own disk block

Well, it needs to be altered to call back up first, telling the VFS not
to allow any allocations for a moment (that's a lock), and then the
VFS calls back down and finds out what it feels like reserving, and
now we get to the tricky bit, because each kernel has its own bitmap
... well you tell me. I can see several generic implementations:

   1) the bitmap is required to be held on disk by a FS and to be reread
   each time any kernel wants to make a new file allocation (that's not
   so expensive - new files are generally rare and we don't care).

   2) the VFS holds the bitmap and we add ops to read and write the
   bitmap in VFS, and intercept those calls and share them (somehow -
   details to be arranged).

   3) .. any or all of this behavior be forced by a MMETADIRECT
   flag that formids metadata to be cached in memory without being
   synced to disk.

> bitmap and then writes the data. The only locking used is file system
> specific. For example NTFS has a per mounted volume rw_semaphore to
> synchronize accesses to the disk block bitmap. But other file systems most
> certainly implement this differently...

Then they will have to be patched to do it generically ..?

> 2) Some file systems cache the metadata. For example in NTFS the

This seems like a pretty valid objection!

> disk block bitmap is stored inside a normal file called $Bitmap. Thus NTFS
> uses the page cache to access the block bitmap and this means that when

This is the same objection as your first objection, I think, except
made particular. My response must therefore be the same - make the
bitmap operations pass through VFS at least, and add a METADIRECT
flag that makes the information be reread when it is needed.

The question is how best to force it, or if the data should be shared
via the VFS's directly (I can handle that - I can make a fake device
that contains the bitmap datam, for example).

> new blocks are allocated, we take the volume specific rw_semaphore and
> then we search the page cache of $Bitmap for zero bits, set the
> required number of bits to one, and then we drop the rw_semaphore and
> return which blocks were allocated to the calling ntfs function.

I'm not sure what relevance the semaphore has. I'm advocating that the
bitmaps ops become generic, which automatically gives the opportunity
for generic locking mechanisms.

> Even if you modified the ntfs driver so that the two hosts accessing the
> same device would share the same rw_semaphore, it still wouldn't work,

I won't modify it except to use new generic ops  instead of fs
particular ones. One could say that only FS's which use the
generic VFS ops are suitable candidates to BE fs's on a shared device.
Then it ceases to be a problem, and becomes a desired goal.

> And this is just the tip of the iceberg. The only way you could get

Well, how much more is there? What you mentioned  didn't worry me
because it wasn't a generic strategic objection.

> something like this to work is by modifying each and every file system
> driver to use some VFS provided mechanism for all (de-)allocations, both

Yes. Precisely. There is nothing wrong with that.

> disk block, and inode ones. Further you would need to provide shared
> memory, i.e. the two hosts need to share the same page cache / address

Well, that I don't know about. Can you elaborate a bit on that? I'm not
at all sure that is the case. Can you provide another of your very
useful concretizations?

> space mappings. So basically, it can only work if the two hosts are
> virtually the same host, i.e. if the two hosts are part of a Single System
> Image Cluster...

Thank you! I find that input very enlightening.

Peter
