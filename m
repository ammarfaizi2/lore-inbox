Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319485AbSIGNcF>; Sat, 7 Sep 2002 09:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319486AbSIGNcF>; Sat, 7 Sep 2002 09:32:05 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:19973 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S319485AbSIGNcA>;
	Sat, 7 Sep 2002 09:32:00 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209071336.g87DaaQ08471@oboe.it.uc3m.es>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <02Sep6.161154edt.62237@gpu.utcc.utoronto.ca> from Chris Siebenmann
 at "Sep 6, 2002 04:11:48 pm"
To: Chris Siebenmann <cks@utcc.utoronto.ca>
Date: Sat, 7 Sep 2002 15:36:36 +0200 (MET DST)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chris Siebenmann wrote:"
> You write:
> | but I'd like to know if we expect a file of fixed size which is being
> | overwritten without O_TRUNC to have any metadata changes apart from in
> | its inode (and there trivially) ...?
> 
>  It depends on the filesystem. A 'traditional' Unix filesystem (original
> V7 or Berkeley FFS derived) will not. A journaling filesystem that is
> journaling the data will write to the log. Something like Reiserfs may

OK.

>  I think I have an alternative paper design for what you want, though.

Let's go ...

>  Hack up your chosen underlying filesystems to understand two additional
> mount flags: REWRITEO and EXTENDO. A filesystem mounted REWRITEO allows
> all read operations and only write operations to already allocated file
> blocks (and it does not update inode mtime when such writes happen). A

OK. RWO means "overwrite allowed".

> filesystem mounted EXTENDO allows REWRITEO operations and files to be
> extended, but no other write operations; writes under EXTENDO update
> inode metadata as they normally would.

Hmm.

>  Define two new internal errnos, returned by the filesystem to mean
> 'operation requires EXTENDO mount' or 'operation requires full write
> mount'.
> 
>  Create an overlay pseudo-filesystem type (you could hack this into
> the VFS, but it's simpler to make it a new filesystem), and a user
> level helper for lock management. This pseudo-filesystem forwards
> VFS operations to an actual underlying filesystem, traps and handles
> operations that require changing the underlying filesystem's mount
> options, returns the results to the user with any editing they need, and
> handles lock state transitions.

Well, not a bad idea anyway to try an overlay first. That seems to
counter most objections I've heard on its own!

>  IO to the underlying filesystem is done O_DIRECT, to bypass caching
> both ways. Because the overlay filesystem does the actual opens, it can
> transparently add O_DIRECT to the open flags. The overlay filesystem

Well, that was easy to do anyway. I hacked the VFS mount calls to
support a MNT_DIRECT flag and hacked sys_open to notice that flag on
the mount when it was called, and do an O_DIRECT open.

> needs to trap opens (and closes) in order to keep track of what files
> are open on the underlying filesystem; I suspect it needs to dummy up
> file objects and do some forwarding there in order to keep track of
> everything.

All we will do at the end of the day is close the file!
I don't see what needs tracking until then ...

>  The underlying filesystem is normally mounted REWRITEO on all nodes.
> A single instance may be mounted EXTENDO while the others continue to

Oh, OK.

> be in REWRITEO. Full write is only allowed when no one else is using
> the filesystem at al. This is all managed by a lock manager server
> for the disk store, which talks to clients on each node using the
> particular store.
> 
>  When a node requests EXTENDO, the lock manager verifies that everyone
> else is in REWRITEO or tells the node to stall on that until everyone
> else is. When a node requests full write, the lock manager asks

Hmm. This can starve.

> all other nodes to temporarily unmount the filesystem and stall IO


That's because you don't have access to the dcache entries for the
underlying fs? I think one can get them in a finer grained way. One can
certainly vamoosh them all at once - there's a call for that already.
It walks the dcache and kills anything pointing to the right system.

> operations on it; when full write is released, the lock manager tells
> everyone they can go to REWRITEO and start IO again. When a node joins
> the lock manager, it asks for REWRITEO and the lock manager verifies
> that no one is in write mode at the moment before saying 'go ahead'.

Yes.

>  On transitions between states, the kernel overlay filesystem closes
> down all references held (open files, etc) to the underlying filesystem,
> unmounts it (optimization: some transitions can be done by remount, for

This is because you can't get at the underlying dcache easily.

> example EXTENDO -> REWRITEO), and then when the user level lock manager
> says it's okay remounts the filesystem with the new mount. It must then
> re-obtain all the underlying filesystem inodes and file references it
> was using. There are two ways:

Really? Why? Can't we just lose our own dcace as well?

> - you can steal code from the NFS server, which only works on some
>   filesystems because it assumes constant inode numbers over the
>   lifetime of the filesystem. (For example, for a while it didn't
>   work on Reiserfs.)

Well, I feel bound to comment that the fact that NFS didn't work
universally for a while didn't seem to stop people wanting to use it!

I'd be quite happy to make that assumption, and let RFS worry about it!

> - you pull the filenames of open files from the dentry reference
>   you're holding, and reopen them. If it fails, mark the file as

Oh, I see, that's why you wanted them.

>   errored-out and return ESTALE for all further IO against it.
>   [Somewhat hazardous, since the filename may now point to a
>    different file.]

Well, dunno.

>  When an EXTENDO client drops down to REWRITEO, the disk store lock
> manager must kick all clients to revalidate the filesystem by executing
> a null state transition (REWRITEO to REWRITEO). This insures that they
> immediately see the full size of the newly extended file.

Hmm. OK. They might want to wait until they need to know, but that's
OK.

>  When an operation fails because it needs EXTENDO or full write, the
> pseudo filesystem layer stalls the request and notifies the user level
> process that it needs a lock at the relevant level. The user level
> process goes off to negociate this with the server, which will call back
> to other clients as necessary and then notify this client that it can
> go ahead. When the mount is upgraded to the needed level, the operation
> goes forward.
> 
>  Unmounting the underlying filesystem on lock state changes means that
> you flush all metadata automatically. By having REWRITEO, we know that
> we can safely cache metadata -- no one is going to be changing it by the
> rules of the game. 

I might try this.

>  EXTENDO is a wart, and it may be worth eliminating it; as it is,
> some clients may see the newly allocated space even before EXTENDO is
> dropped, but some may not. This design assumes that it's okay to not
> necessarily let other people at the data until the extending client
> drops the lock.
> 
>  This design is inefficient if there are many full write operations;

Well, of course. The point i sthat it allows aordinary caching
normally, and then causes all caches to be dropped whenever anyone
anywhere does anything that might cause some metadatachange somwhere.

I think one can be more exact than that, but it's OK as a tryout.

> that would be creating files, creating directories, renaming files,
> removing files, etc. But if it is mostly reading and rewriting (the
> assumptions I've seen) it should go very nicely.
> 
>  The design does assume that the inode access and modification times

They are unimportant.

> are unimportant. I don't think you can get good performance without
> this assumption.

Correct.

>  Hopefully this is clear enough.

It is. Thank you.

Peter
