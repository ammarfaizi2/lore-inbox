Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314941AbSD2JDx>; Mon, 29 Apr 2002 05:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314954AbSD2JDw>; Mon, 29 Apr 2002 05:03:52 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:25101 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S314941AbSD2JDv>; Mon, 29 Apr 2002 05:03:51 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15565.3189.919319.155049@laputa.namesys.com>
Date: Mon, 29 Apr 2002 13:03:49 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
In-Reply-To: <5.1.0.14.2.20020427191820.04003500@pop.cus.cam.ac.uk>
X-Mailer: VM 7.03 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
X-NSA-Fodder: Monica Lewinsky Craig Livingstone Ft. Bragg Honduras
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov writes:
 > At 16:53 27/04/02, Jan Harkes wrote:
 > >On Fri, Apr 12, 2002 at 08:57:17AM +0100, Anton Altaparmakov wrote:
 > > > Yet, this really begs the question of defining the concept of a file. I am
 > > > quite happy with files being the io entity in ntfs. It is just that each
 > > > file in ntfs can contain loads of different data holding attributes which
 > > > are all worth placing in address spaces. Granted, a dummy inode could be
 > > > setup for each of those which just means a lot of wasted ram but ntfs is
 > > > not that important so I have to take the penalty there. But if I also need
 > > > unique inode numbers in those dummy inodes then the overhead is becoming
 > > > very, very high...
 > >
 > >You could have all additional IO streams use the same inode number and
 > >use iget4. Several inodes can have the same i_ino and the additional
 > >argument would be a stream identifier that selects the correct 'IO
 > >identity'.
 > 
 > Great idea! I quickly looked into the implementation details and using 
 > iget4/read_inode2 perfectly reconciles my ideas of using an address space 
 > mapping for each ntfs attribute with the kernels requirement of using 
 > inodes as the i/o entity by allowing a clean and unique mapping between 
 > multiple inodes with the same inode numbers and their attributes and 
 > address spaces.
 > 

Please note that ->read_inode2() is reiserfs-specific hack. Adding more
users for it would make it permanent. The only reason for ->read_inode2
existence was that iget() was called by code external to the
file-system, knfsd used to do this, now it can call ->fh_to_dentry() in
stead. As iget() is never called outside of file-ssytem, you can set
ntfs->read_inode to no-op and write your own function ntfs_iget(...) to
be called from ntfs_lookup() and ntfs_fill_super().

ntfs_iget() calls iget() (->read_inode is no-op, hence iget doesn't
access disk) and, if new inode were allocated, reads data from the disk
and initializes inode, etc.

I guess coda_iget() is example of this.

 > I need to work out exactly how to do it but I will definitely go that way. 
 > That will make everything nice and clean and get rid of the existing 
 > kludges of passing around other types of objects instead of struct file * 
 > to my various readpage functions. Also I will be able to have fewer 
 > readpage functions... (-:
 > 
 > Thanks for the suggestion!
 > 
 > Best regards,
 > 
 > Anton
 > 

Nikita.
