Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315119AbSD2L7s>; Mon, 29 Apr 2002 07:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315120AbSD2L7r>; Mon, 29 Apr 2002 07:59:47 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:34308 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S315119AbSD2L7q>; Mon, 29 Apr 2002 07:59:46 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15565.13742.140693.146727@laputa.namesys.com>
Date: Mon, 29 Apr 2002 15:59:41 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Anton Altaparmakov <aia21@cantab.net>
Cc: viro@math.psu.edu, Jan Harkes <jaharkes@cs.cmu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
In-Reply-To: <5.1.0.14.2.20020429115231.00b1d900@pop.cus.cam.ac.uk>
X-Mailer: VM 7.03 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
X-Drdoom-Fodder: passwd crypt security drdoom root crash
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov writes:
 > Hi,
 > 
 > I am cc:-ing Al Viro, perhaps Al could comment on approach as this would 
 > affect the future of read_inode2 in VFS?
 > 
 > At 10:03 29/04/02, Nikita Danilov wrote:
 > >Anton Altaparmakov writes:
 > >  > At 16:53 27/04/02, Jan Harkes wrote:
 > >  > >You could have all additional IO streams use the same inode number and
 > >  > >use iget4. Several inodes can have the same i_ino and the additional
 > >  > >argument would be a stream identifier that selects the correct 'IO
 > >  > >identity'.
 > >  >
 > >  > Great idea! I quickly looked into the implementation details and using
 > >  > iget4/read_inode2 perfectly reconciles my ideas of using an address space
 > >  > mapping for each ntfs attribute with the kernels requirement of using
 > >  > inodes as the i/o entity by allowing a clean and unique mapping between
 > >  > multiple inodes with the same inode numbers and their attributes and
 > >  > address spaces.
 > >
 > >Please note that ->read_inode2() is reiserfs-specific hack. Adding more
 > >users for it would make it permanent. The only reason for ->read_inode2
 > >existence was that iget() was called by code external to the
 > >file-system, knfsd used to do this, now it can call ->fh_to_dentry() in
 > >stead. As iget() is never called outside of file-ssytem, you can set
 > >ntfs->read_inode to no-op and write your own function ntfs_iget(...) to
 > >be called from ntfs_lookup() and ntfs_fill_super().
 > >
 > >ntfs_iget() calls iget() (->read_inode is no-op, hence iget doesn't
 > >access disk) and, if new inode were allocated, reads data from the disk
 > >and initializes inode, etc.
 > >
 > >I guess coda_iget() is example of this.
 > 
 > This will not work AFAICS.
 > 
 > coda_iget() -> iget4() -> get_new_inode(), which calls ->read_inode or 
 > ->read_inode2, and then unlocks the inode and wakes up the waiting tasks.
 > 
 > If ->read_inode and ->read_inode2 are NULL as you suggest for NTFS it means 
 > that as soon as ntfs_iget() has called iget4() there will be an 
 > uninitialized yet unlocked inode in memory which is guaranteed to cause 
 > NTFS to oops... (And any other fs using this approach.)

I see. While this can be worked around by adding flag set up after inode
initialization, this would become ugly shortly.

 > 
 > Before the inode is unlocked it MUST be initialized. And the only way
 > to do this in the framework of the current VFS is to use ->read_inode
 > or ->read_inode2.
 > 
 > Al, would you agree with NTFS using ->read_inode2 as well as ReiserFS?
 > 

->read_inode2 is a hack. And especially so is having both ->read_inode
and ->read_inode2. iget() interface was based on the assumption that
inodes can be located (and identified) by inode number. It is not so at
least for the reiserfs and ->read_inode2 works around this by passing
"cookie" with information sufficient for file system to locate inode.

I am concerned that (ab)using this cookie and ->read_inode2 to bypass
rigid iget() is not right way to go. What about VFS exporting function
that checks hash table, creates new inode if not there and returns it
still locked? This way each file system would be able to locate and load
inodes in a way it likes without encoding/decoding information in the
cookie.

 > Best regards,
 > 
 > Anton
 > 

Nikita.

 > 
 > -- 
