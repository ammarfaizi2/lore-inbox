Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315149AbSD2Mfa>; Mon, 29 Apr 2002 08:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315150AbSD2Mf3>; Mon, 29 Apr 2002 08:35:29 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:45951 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315149AbSD2Mf1>; Mon, 29 Apr 2002 08:35:27 -0400
Message-Id: <5.1.0.14.2.20020429131258.04913ab0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 29 Apr 2002 13:34:02 +0100
To: Nikita Danilov <Nikita@Namesys.COM>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [prepatch] address_space-based writeback
Cc: viro@math.psu.edu, Jan Harkes <jaharkes@cs.cmu.edu>,
        linux-kernel@vger.kernel.org
In-Reply-To: <15565.13742.140693.146727@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:59 29/04/02, Nikita Danilov wrote:
>[snip]
>  > >Please note that ->read_inode2() is reiserfs-specific hack. Adding more
>  > >users for it would make it permanent. The only reason for ->read_inode2
>  > >existence was that iget() was called by code external to the
>  > >file-system, knfsd used to do this, now it can call ->fh_to_dentry() in
>  > >stead. As iget() is never called outside of file-ssytem, you can set
>  > >ntfs->read_inode to no-op and write your own function ntfs_iget(...) to
>  > >be called from ntfs_lookup() and ntfs_fill_super().
>  > >
>  > >ntfs_iget() calls iget() (->read_inode is no-op, hence iget doesn't
>  > >access disk) and, if new inode were allocated, reads data from the disk
>  > >and initializes inode, etc.
>  > >
>  > >I guess coda_iget() is example of this.
>  >
>  > This will not work AFAICS.
>  >
>  > coda_iget() -> iget4() -> get_new_inode(), which calls ->read_inode or
>  > ->read_inode2, and then unlocks the inode and wakes up the waiting tasks.
>  >
>  > If ->read_inode and ->read_inode2 are NULL as you suggest for NTFS it 
> means
>  > that as soon as ntfs_iget() has called iget4() there will be an
>  > uninitialized yet unlocked inode in memory which is guaranteed to cause
>  > NTFS to oops... (And any other fs using this approach.)
>
>I see. While this can be worked around by adding flag set up after inode
>initialization, this would become ugly shortly.
>
>  > Before the inode is unlocked it MUST be initialized. And the only way
>  > to do this in the framework of the current VFS is to use ->read_inode
>  > or ->read_inode2.
>  >
>  > Al, would you agree with NTFS using ->read_inode2 as well as ReiserFS?
>
>->read_inode2 is a hack.
>
>And especially so is having both ->read_inode and ->read_inode2. iget() 
>interface was based on the assumption that inodes can be located (and 
>identified) by inode number. It is not so at least for the reiserfs and 
>->read_inode2 works around this by passing "cookie" with information 
>sufficient for file system to locate inode.
>
>I am concerned that (ab)using this cookie and ->read_inode2 to bypass
>rigid iget() is not right way to go.

Perhaps. But it works now and can easily be modified later if better 
approach comes along.

>What about VFS exporting function that checks hash table, creates new 
>inode if not there and returns it still locked? This way each file system 
>would be able to locate and load
>inodes in a way it likes without encoding/decoding information in the cookie.

Yes that would work fine. But it would still need the iget4 like find actor 
and opaque pointer to do the "checks hash table" part...

Basically one could just change iget4 into two functions: iget calling 
fs->read_inode (with read_inode2 removed) and iget4 without the 
->read_inode and ->read_inode2 and returning a locked inode instead.

That would make it fs specific.

If we wanted to make it generic we do need a special method in the 
operations, but wait, we already have read_inode2! So perhaps it isn't as 
much of a hack after all...

If you wanted to get rid of the hackish nature of the beast, one could just 
remove ->read_inode and rename ->read_inode2 to ->read_inode. Then change 
all fs to accept two dummy parameters in their ->read_inode declaration...

If that would be an acceptable approach I would be happy to do a patch to 
convert all in kernel file systems in 2.5.x.

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

