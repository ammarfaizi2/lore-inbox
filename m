Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSHBOLS>; Fri, 2 Aug 2002 10:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314811AbSHBOLS>; Fri, 2 Aug 2002 10:11:18 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:23197 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S314680AbSHBOLR>;
	Fri, 2 Aug 2002 10:11:17 -0400
Subject: Re: BIG files & file systems
From: Steve Lord <lord@sgi.com>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Alexander Viro <viro@math.psu.edu>, "Peter J. Braam" <braam@clusterfs.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020802135620.GA29534@ravel.coda.cs.cmu.edu>
References: <20020731210739.GA15492@ravel.coda.cs.cmu.edu>
	<Pine.GSO.4.21.0207311711540.8505-100000@weyl.math.psu.edu>
	<20020801035119.GA21769@ravel.coda.cs.cmu.edu>
	<1028246981.11223.56.camel@snafu> 
	<20020802135620.GA29534@ravel.coda.cs.cmu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Aug 2002 09:06:34 -0500
Message-Id: <1028297194.30192.25.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-02 at 08:56, Jan Harkes wrote:
> 
> I was simply assuming that any filesystem that is using iget5 and
> doesn't use the simpler iget helper has some reason why it cannot find
> an inode given just the 32-bit ino_t.

In XFS's case (remember, the iget5 code is based on XFS changes) it is
more a matter of the code to read the inode sometimes needing to pass
other info down to the read_inode part of the filesystem, so we want to
do that internally. XFS can have 64 bit inode numbers, but you need more
than 1 Tbyte in an fs to get that big (inode numbers are a disk
address). We also have code which keeps them in the bottom 1 Tbyte
which is turned on by default on Linux.

> 
> This is definitely true for Coda, we have 96-bit file identifiers.
> Actually my development tree currently uses 128-bit, it is aware of
> multiple administrative realms and distinguishes between objects with
> FID 0x7f000001.0x1.0x1 in different administrative domains. There is a
> hash-function that tries to map these large FIDs into the 32-bit ino_t
> space with as few collisions as possible.
> 
> NFS has a >32-bit filehandle. ReiserFS might have unique inodes, but
> seems to need access to the directory to find them. So I don't quickly
> see how it would guarantee uniqueness. NTFS actually doesn't seem to use
> iget5 yet, but it has multiple streams per object which would probably
> end up using the same ino_t.
> 
> Userspace applications should either have an option to ignore hardlinks.
> Very large filesystems either don't care because there is plenty of
> space, don't support them across boundaries that are not visible to the
> application, or could be dealing with them them automatically (COW
> links). Besides, if I really have a trillion files, I don't want 'tar
> and friends' to try to keep track of all those inode numbers (and device
> numbers) in memory.
> 
> The other solution is that applications can actually use more of the
> information from the inode to avoid confusion, like st_nlink and
> st_mtime, which are useful when the filesystem is still mounted rw as
> well. And to make it even better, st_uid, st_gid, st_size, st_blocks and
> st_ctime, and a MD5/SHA checksum. Although this obviously would become
> even worse for the trillion file backup case.

If apps would have to change then I would vote for allowing larger
inodes out of the kernel in an extended version of stat and getdents.
I was going to say 64 bit versions, but if even 64 is not enough for
you, it is getting a little hard to handle.

Steve

> Jan
-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
