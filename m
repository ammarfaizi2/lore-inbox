Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131666AbRCURcf>; Wed, 21 Mar 2001 12:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131713AbRCURc0>; Wed, 21 Mar 2001 12:32:26 -0500
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:7677 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131666AbRCURcN>; Wed, 21 Mar 2001 12:32:13 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103211731.f2LHVEX19566@webber.adilger.int>
Subject: Re: ext2_unlink fun
In-Reply-To: <Pine.LNX.4.32.0103211016570.15278-100000@viper.haque.net> from
 "Mohammad A. Haque" at "Mar 21, 2001 10:24:36 am"
To: "Mohammad A. Haque" <mhaque@haque.net>
Date: Wed, 21 Mar 2001 10:31:14 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mohammad A. Haque writes:
> My machine locked hard last night for an unknown reason under
> 2.4.3-pre4. Rebooted and it did it's fsck thing. Got alot of errors
> about missing '..', fixed alot of things and moved some stuff to
> /lost+found.
> 
> Some files got screwed up so I can't delete them.
> 
> [mhaque@viper html-blah]$ rm -r mac3dfx/
> rm: cannot remove `mac3dfx/news/1999/08/199908231702.txt': Input/output
> error
> rm: cannot remove `mac3dfx/news/1999/08/199908231802.txt': Input/output
> error
> rm: cannot remove directory `mac3dfx/news/1999/08': Directory not empty
> rm: cannot remove directory `mac3dfx/news/1999': Directory not empty
> rm: cannot remove directory `mac3dfx/news': Directory not empty
> rm: cannot remove `mac3dfx/dat': Input/output error
> rm: cannot remove directory `mac3dfx': Directory not empty
> 
> My filesystem is probably really screwed up so I'm going to format. But
> for future reference, how would one get rid of those files? Or does this
> indicate that it's time to reformat and not even consider trying to
> delete those files?

It would be nice to determine _why_ you can't unlink these files.  If
it was just an issue of size > 2GB, you should get EFBIG error or so.
People have been reporting undeletable files several times now...  Before
you reformat, could you do some debugging?

It appears a reasonable spot to get the EIO from is in ext2_delete_entry()
where we are validating the de in ext2_check_dir_entry().  Can you check
your syslog for any error messages, like:

	ext2_delete_entry: bad entry in directory X: 199908231702.txt ...

It would be _nice_ to be able to delete a dir entry even if it is corrupt
(considering we want to delete it, so we don't really care about that dir
entry), but that may cause further corruption of the previous dir entry
(which we DO want to keep).

The only other place I can see we return EIO is in ext2_unlink when
comparing de->inode to inode->i_ino.  However, this could only happen
if a file of the same name was created in the directory, OR the dir entry
was changed after we had done the lookup.  Strange, but unlikely here.

Obviously e2fsck doesn't fix the problem?  Could you run debugfs on this
filesystem, cd to the "mac3dfx/news/1999/08" directory, and "stat" each
of these broken files?  This may help to identify what is wrong with the
files that e2fsck isn't fixing.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
