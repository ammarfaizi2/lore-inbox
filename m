Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314085AbSHBNxA>; Fri, 2 Aug 2002 09:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSHBNxA>; Fri, 2 Aug 2002 09:53:00 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:5061 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S314085AbSHBNwz>; Fri, 2 Aug 2002 09:52:55 -0400
Date: Fri, 2 Aug 2002 09:56:20 -0400
To: Stephen Lord <lord@sgi.com>
Cc: Alexander Viro <viro@math.psu.edu>, "Peter J. Braam" <braam@clusterfs.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BIG files & file systems
Message-ID: <20020802135620.GA29534@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Stephen Lord <lord@sgi.com>,
	Alexander Viro <viro@math.psu.edu>,
	"Peter J. Braam" <braam@clusterfs.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20020731210739.GA15492@ravel.coda.cs.cmu.edu> <Pine.GSO.4.21.0207311711540.8505-100000@weyl.math.psu.edu> <20020801035119.GA21769@ravel.coda.cs.cmu.edu> <1028246981.11223.56.camel@snafu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028246981.11223.56.camel@snafu>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 07:09:37PM -0500, Stephen Lord wrote:
> On Wed, 2002-07-31 at 22:51, Jan Harkes wrote:
> > On Wed, Jul 31, 2002 at 05:13:46PM -0400, Alexander Viro wrote:
> > > You _do_ need unique ->st_ino from stat(2), though - otherwise tar(1)
> > > and friends will break in all sorts of amusing ways.  And there's
> > > nothing kernel can do about that - applications expect 32bit st_ino
> > > (compare them as 32bit values, etc.)
> > 
> > Which is why "tar and friends" are to different extents already broken
> > on various filesystems like Coda, NFS, NTFS, ReiserFS, and probably XFS.
> > (i.e. anything that currently uses iget5_locked instead of iget to grab
> > the inode).
> 
> Why are they broken? In the case of XFS at least you still get a unique
> and stable inode number back - and it fits in 32 bits too.

I was simply assuming that any filesystem that is using iget5 and
doesn't use the simpler iget helper has some reason why it cannot find
an inode given just the 32-bit ino_t.

This is definitely true for Coda, we have 96-bit file identifiers.
Actually my development tree currently uses 128-bit, it is aware of
multiple administrative realms and distinguishes between objects with
FID 0x7f000001.0x1.0x1 in different administrative domains. There is a
hash-function that tries to map these large FIDs into the 32-bit ino_t
space with as few collisions as possible.

NFS has a >32-bit filehandle. ReiserFS might have unique inodes, but
seems to need access to the directory to find them. So I don't quickly
see how it would guarantee uniqueness. NTFS actually doesn't seem to use
iget5 yet, but it has multiple streams per object which would probably
end up using the same ino_t.

I haven't looked at XFS, but as all in-tree filesystems that use
iget5_locked have potential ino_t collisions, So I was assuming XFS
would fit in the same category.

Userspace applications should either have an option to ignore hardlinks.
Very large filesystems either don't care because there is plenty of
space, don't support them across boundaries that are not visible to the
application, or could be dealing with them them automatically (COW
links). Besides, if I really have a trillion files, I don't want 'tar
and friends' to try to keep track of all those inode numbers (and device
numbers) in memory.

The other solution is that applications can actually use more of the
information from the inode to avoid confusion, like st_nlink and
st_mtime, which are useful when the filesystem is still mounted rw as
well. And to make it even better, st_uid, st_gid, st_size, st_blocks and
st_ctime, and a MD5/SHA checksum. Although this obviously would become
even worse for the trillion file backup case.

Jan

