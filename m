Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269417AbRHCPmL>; Fri, 3 Aug 2001 11:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269418AbRHCPmB>; Fri, 3 Aug 2001 11:42:01 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:15121 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269417AbRHCPlr>; Fri, 3 Aug 2001 11:41:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: ext3-2.4-0.9.4
Date: Fri, 3 Aug 2001 17:47:17 +0200
X-Mailer: KMail [version 1.2]
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <01080316082001.01827@starship> <20010803111803.B25450@cs.cmu.edu>
In-Reply-To: <20010803111803.B25450@cs.cmu.edu>
MIME-Version: 1.0
Message-Id: <01080317471707.01827@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 August 2001 17:18, Jan Harkes wrote:
> On Fri, Aug 03, 2001 at 04:08:20PM +0200, Daniel Phillips wrote:
> > > fsync forces the data to disk.  There may be one or more pathnames
> > > which the application also relies on, and if the application does
> > > care about those, the application will have to ensure that they are
> > > synced too.
> > >
> > > Look, I agree that your interpretation is useful.  It's just not an
> > > unambiguous requirement of the spec.
> >
> > OK, fine, this damn English language and all that.  Do we agree that
> > "access" means "be able to open by name"?
>
> No, until recently the device/inode number pair used to work very nicely
> for both Coda and knfsd when they wanted to access a file. But it only
> works from within the kernel where you can use iget. It's just that with
> some of the newer filesystems the inode numbers are no longer unique, so
> it became something more like device/inum/opaque handle (i.e. iget4).

We are talking about "after waking up from an unexpected interruption".
So, is this still relevant?

> As far as the fsync semantics are concerned. Yeah, they would be useful,
> but only to avoid one directory fsync call that will tell the kernel
> _exactly_ what the process wants instead of letting it figure it out by
> itself.

No, it's not just that.  It's not enough to fsync just the parent, the
parent's parent may have been relinked and not comitted.  Also, the
kernel has the advantage of the locked chain of dcache entries
available to it.  Finally, there is the saving of multiple syscall
overhead, which I didn't mention first time around because it's not a
lot compared to media access overhead.

> The argument I saw in this thread that fsync(dir) has too much
> overhead because it might sync unrelated data is not very useful,
> because that unrelated data will be synced anyways when it's not a
> journalling fs.

Yes, and I gave a detailed explanation earlier of why such overhead
will not amount to much.

> Name to file object mapping is not part of the metadata associated with
> a file. It is the contents of the directory and can only be modified by
> directory operations, not operations on the file or filehandle.

SUS doesn't just pronounce on the file metadata.  Quoting from earlier
in the thread:

----------
>   "synchronised I/O data integrity completion
>
>   [...]
>
>   * For write, when the operation has been completed or diagnosed if
>   unsuccessful.  The write is complete only when the data specified in
>   the write request is successfully transferred and all file system
>   information required to retrieve the data is successfully transferred.
----------

> open(file, O_CREAT) is really split up into create(parent, file) an
> operation on the parent directory, and an open(file) operation which
> returns the filehandle.
>
> I also don't see why a rename operation, which operates on the source
> and destination parent directories would have to not only look up the
> file object but also somehow register with all open filehandles for that
> object that both olddir and newdir need to be written back to disk
> during the fsync as well.

They don't both have to, either one will be good enough.  However,
"neither" is not good enough, according to SUS.

> Or should that go the other way around, where
> the filehandle has to chase down which directory it was renamed to?
>
> Taken from another part of this thread Alexander and Daniel,
>
> > > That there isn't THE directory in which the file resides. There might
> > > be several, and setting the bit on one of them at random and expect
> > > it to work is a _lot_ of work. For no real use.
> >
> > There is only one chain of directories from the fd's dentry up to the
> > root, that's the one to sync.
>
> Using the dentry chain is not reliable, for instance instead of moving
> dentries around Coda simply unhashes dentries when state on the server
> changes.

Could you be more specific about this, are you saying there are cases
where there is no valid parent link from a dcache entry?

> Another process (perhaps on a different machine) might have
> moved one of the ancestor directories from one location to another, or
> even relinked/unlinked the file that we're working with (ln old new; rm
> old) in which case the dentry path is lost, but ideally you'd expect
> fsync to sync the 'new' name if it supposedly keeps the namespace
> consistent.

I doesn't matter which one it syncs.

> Working on a distributed filesystem with somewhat weaker than UNIX
> semantics might have skewed my vision. In Coda not every client will be
> able to figure out which are all of the possibly paths that can lead to
> a file object. And although we currently try our best to block
> hardlinked directories they could possibly exist, making the problems
> even worse.

We don't need all the paths, and not any specific path, just a path.

--
Daniel
