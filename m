Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315096AbSD2LKR>; Mon, 29 Apr 2002 07:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315097AbSD2LKQ>; Mon, 29 Apr 2002 07:10:16 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:48505 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315096AbSD2LKO>; Mon, 29 Apr 2002 07:10:14 -0400
Message-Id: <5.1.0.14.2.20020429115231.00b1d900@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 29 Apr 2002 12:11:07 +0100
To: Nikita Danilov <Nikita@Namesys.COM>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [prepatch] address_space-based writeback
Cc: viro@math.psu.edu, Jan Harkes <jaharkes@cs.cmu.edu>,
        linux-kernel@vger.kernel.org
In-Reply-To: <15565.3189.919319.155049@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am cc:-ing Al Viro, perhaps Al could comment on approach as this would 
affect the future of read_inode2 in VFS?

At 10:03 29/04/02, Nikita Danilov wrote:
>Anton Altaparmakov writes:
>  > At 16:53 27/04/02, Jan Harkes wrote:
>  > >You could have all additional IO streams use the same inode number and
>  > >use iget4. Several inodes can have the same i_ino and the additional
>  > >argument would be a stream identifier that selects the correct 'IO
>  > >identity'.
>  >
>  > Great idea! I quickly looked into the implementation details and using
>  > iget4/read_inode2 perfectly reconciles my ideas of using an address space
>  > mapping for each ntfs attribute with the kernels requirement of using
>  > inodes as the i/o entity by allowing a clean and unique mapping between
>  > multiple inodes with the same inode numbers and their attributes and
>  > address spaces.
>
>Please note that ->read_inode2() is reiserfs-specific hack. Adding more
>users for it would make it permanent. The only reason for ->read_inode2
>existence was that iget() was called by code external to the
>file-system, knfsd used to do this, now it can call ->fh_to_dentry() in
>stead. As iget() is never called outside of file-ssytem, you can set
>ntfs->read_inode to no-op and write your own function ntfs_iget(...) to
>be called from ntfs_lookup() and ntfs_fill_super().
>
>ntfs_iget() calls iget() (->read_inode is no-op, hence iget doesn't
>access disk) and, if new inode were allocated, reads data from the disk
>and initializes inode, etc.
>
>I guess coda_iget() is example of this.

This will not work AFAICS.

coda_iget() -> iget4() -> get_new_inode(), which calls ->read_inode or 
->read_inode2, and then unlocks the inode and wakes up the waiting tasks.

If ->read_inode and ->read_inode2 are NULL as you suggest for NTFS it means 
that as soon as ntfs_iget() has called iget4() there will be an 
uninitialized yet unlocked inode in memory which is guaranteed to cause 
NTFS to oops... (And any other fs using this approach.)

Before the inode is unlocked it MUST be initialized. And the only way to do 
this in the framework of the current VFS is to use ->read_inode or 
->read_inode2.

Al, would you agree with NTFS using ->read_inode2 as well as ReiserFS?

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

