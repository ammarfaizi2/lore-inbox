Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317063AbSFAUxE>; Sat, 1 Jun 2002 16:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317065AbSFAUxD>; Sat, 1 Jun 2002 16:53:03 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:56818 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317063AbSFAUxC>; Sat, 1 Jun 2002 16:53:02 -0400
Date: Sat, 1 Jun 2002 14:51:24 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 9/16] direct-to-BIO writeback for writeback-mode ext3
Message-ID: <20020601205124.GB7905@turbolinux.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CF88903.E253A075@zip.com.au> <20020601191514.GA7905@turbolinux.com> <3CF92B1D.E466B743@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 01, 2002  13:14 -0700, Andrew Morton wrote:
> Andreas Dilger wrote:
> > On Jun 01, 2002  01:42 -0700, Andrew Morton wrote:
> > > Turn on direct-to-BIO writeback for ext3 in data=writeback mode.
> > 
> > A minor note on this (especially minor since I believe data=journal
> > doesn't even work in 2.5), but you should probably also change the
> > address ops in ext3/ioctl.c if you enable/disable per-inode data
> > journaling.
> 
> hrm.  Actually, changing journalling mode against a file while
> modifications are happening against it is almost certain to explode
> if the timing is right.  ISTR that we have seen bug reports against
> this on ext3-users.  This is just waaaay too hard to do.

Actually, if you look at the code in ioctl.c for changing the journaling
mode of a file, it basically stops _all_ I/O to the filesystem and waits
for it to complete before changing the journal data flag, so it should
also be possible to change the aops pointer at the same time.  The "stop
all I/O" is one of the reasons why enabling data journaling on files is
only allowed for root/privileged users.

> But we can fix it by doing the opposite: create three separate
> a_ops instances, one for each journalling mode.  Assign it at
> new_inode/read_inode time.

Sure, as long as this doesn't increase the amount of code duplication.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

