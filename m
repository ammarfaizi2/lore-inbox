Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269454AbRHCQQu>; Fri, 3 Aug 2001 12:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269456AbRHCQQk>; Fri, 3 Aug 2001 12:16:40 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:25008 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S269454AbRHCQQc>; Fri, 3 Aug 2001 12:16:32 -0400
Date: Fri, 3 Aug 2001 12:16:38 -0400
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: sct@redhat.com, matthias.andree@stud.uni-dortmund.de,
        linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010803121638.A28194@cs.cmu.edu>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>, sct@redhat.com,
	matthias.andree@stud.uni-dortmund.de, linux-kernel@vger.kernel.org
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <01080316082001.01827@starship> <20010803111803.B25450@cs.cmu.edu> <01080317471707.01827@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01080317471707.01827@starship>
User-Agent: Mutt/1.3.20i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 05:47:17PM +0200, Daniel Phillips wrote:
> On Friday 03 August 2001 17:18, Jan Harkes wrote:
> > No, until recently the device/inode number pair used to work very nicely
> > for both Coda and knfsd when they wanted to access a file. But it only
> > works from within the kernel where you can use iget. It's just that with
> > some of the newer filesystems the inode numbers are no longer unique, so
> > it became something more like device/inum/opaque handle (i.e. iget4).
> 
> We are talking about "after waking up from an unexpected interruption".
> So, is this still relevant?

The NFS client hasn't been interrupted, and it's filehandle will still
identifies the file object by device/inode.

> > Name to file object mapping is not part of the metadata associated with
> > a file. It is the contents of the directory and can only be modified by
> > directory operations, not operations on the file or filehandle.
> 
> SUS doesn't just pronounce on the file metadata.  Quoting from earlier
> in the thread:
> 
> ----------
> >   "synchronised I/O data integrity completion
> >
> >   [...]
> >
> >   * For write, when the operation has been completed or diagnosed if
> >   unsuccessful.  The write is complete only when the data specified in
> >   the write request is successfully transferred and all file system
> >   information required to retrieve the data is successfully transferred.
> ----------

So that would be the file data, and it's on-disk inode information,
indirect blocks etc. All the information that the file system needs to
retrieve the data is then available, i.e. what is required for iget()
to succeed.

Ok, iget isn't exported to userspace, but fsck will place the file in a
user reachable location.

> > I also don't see why a rename operation, which operates on the source
> > and destination parent directories would have to not only look up the
> > file object but also somehow register with all open filehandles for that
> > object that both olddir and newdir need to be written back to disk
> > during the fsync as well.
> 
> They don't both have to, either one will be good enough.  However,
> "neither" is not good enough, according to SUS.

Ehh, sync only olddir and you just lost any path leading to the file.
Sync only newdir and the file is reachable from two locations, but it's
linkcount is too low.

> > Using the dentry chain is not reliable, for instance instead of moving
> > dentries around Coda simply unhashes dentries when state on the server
> > changes.
> 
> Could you be more specific about this, are you saying there are cases
> where there is no valid parent link from a dcache entry?

No the dcache entry could have a 'stale' fileobject associated with it
that has been superceded by a different object. This dentry is unhashed,
so that the next lookup will instantiate a new dentry which references
the new object. So syncing the stale object is useless, because it
doesn't really exist anymore, but the kernel (and actually the userspace
daemon on the client) doesn't know what the new object is until it is
accessed.

> > Working on a distributed filesystem with somewhat weaker than UNIX
> > semantics might have skewed my vision. In Coda not every client will be
> > able to figure out which are all of the possibly paths that can lead to
> > a file object. And although we currently try our best to block
> > hardlinked directories they could possibly exist, making the problems
> > even worse.
> 
> We don't need all the paths, and not any specific path, just a path.

Even if that path leads to a name that got removed, thereby forcing the
object into lost+found? I thought the MTA did something like,

fd = open(tmp/file)
write(fd)
fsync(fd)
link(tmp/file, new/file)
fsync(fd)		*1
unlink(tmp/file)

*1 If this fsync only syncs the path leading to tmp/file, and the unlink
tmp/file is written back to disk, which is likely because we're only
creating/syncing stuff in tmp.  Now, until new/file is written there is
no path information leading to the file anymore which makes this as
'safe' as not syncing path name information at all.

Now if the application would use the directory sync, it can actually
tell the kernel that that new/file name is the interesting one to keep
and that tmp doesn't even need to be written to disk at all.

Jan

