Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131777AbRCUVaQ>; Wed, 21 Mar 2001 16:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131778AbRCUVaG>; Wed, 21 Mar 2001 16:30:06 -0500
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:29693 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131777AbRCUVaB>; Wed, 21 Mar 2001 16:30:01 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103212128.f2LLSRx20724@webber.adilger.int>
Subject: Re: ext2_unlink fun
In-Reply-To: <Pine.LNX.4.32.0103211414540.19449-100000@viper.haque.net> from
 "Mohammad A. Haque" at "Mar 21, 2001 02:22:15 pm"
To: "Mohammad A. Haque" <mhaque@haque.net>
Date: Wed, 21 Mar 2001 14:28:24 -0700 (MST)
CC: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mohammad A. Haque writes:
> On Wed, 21 Mar 2001, Andreas Dilger wrote:
> > It appears a reasonable spot to get the EIO from is in ext2_delete_entry()
> > where we are validating the de in ext2_check_dir_entry().  Can you check
> > your syslog for any error messages, like:
> >
> > 	ext2_delete_entry: bad entry in directory X: 199908231702.txt ...
> 
> Only message I have is EXT2-fs warning (device ide0(3,3)): ext2_unlink:
> Deleting nonexistent file (1343506), 0

OK, this is consistent with the debugfs output - the inode was overwritten
with zeros.  However, I'm not sure how this would lead to EIO.  In my tree
(2.4.2) for ext2_unlink() we get EIO if ext2_delete_entry() has a problem
with ext2_check_dir_entry(), but that would have put another message into
the logs.  The other EIO (de->inode != inode->i_ino) happens before this
message is printed, so it isn't possible either.

> Correct, this was after running e2fsck. I'll try running it again when I
> get home. Here is debugfs stat output for one of the broken files.
> Again, I havent run e2fsck a second time yet.
> 
> debugfs:  stat 199908231702.txt
> Inode: 1343489   Type: bad type    Mode:  0000   Flags: 0x0
> Version/Generation: 0
> User:     0   Group:     0   Size: 0
> File ACL: 0    Directory ACL: 0
> Links: 0   Blockcount: 0
> Fragment:  Address: 0    Number: 0    Size: 0
> ctime: 0x00000000 -- Wed Dec 31 19:00:00 1969
> atime: 0x00000000 -- Wed Dec 31 19:00:00 1969
> mtime: 0x00000000 -- Wed Dec 31 19:00:00 1969
> BLOCKS:

Maybe you really _are_ having I/O errors?  That would explain the zero'd
inode table and the I/O error messages.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
