Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261622AbSI0EJZ>; Fri, 27 Sep 2002 00:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261626AbSI0EJZ>; Fri, 27 Sep 2002 00:09:25 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:54777 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261622AbSI0EJY>; Fri, 27 Sep 2002 00:09:24 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 26 Sep 2002 22:12:34 -0600
To: "Theodore Ts'o" <tytso@mit.edu>,
       Ryan Cumming <ryan@completely.kicks-ass.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Message-ID: <20020927041234.GS22795@clusterfs.com>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Ryan Cumming <ryan@completely.kicks-ass.org>,
	linux-kernel@vger.kernel.org
References: <E17uINs-0003bG-00@think.thunk.org> <200209261208.59020.ryan@completely.kicks-ass.org> <20020926220432.GB10551@think.thunk.org> <200209261553.07593.ryan@completely.kicks-ass.org> <20020926235741.GC10551@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020926235741.GC10551@think.thunk.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 26, 2002  19:57 -0400, Theodore Ts'o wrote:
> On Thu, Sep 26, 2002 at 03:53:02PM -0700, Ryan Cumming wrote:
> > The one mildly interesting thing was:
> > Sep 26 11:49:06 (none) kernel: EXT3-fs: INFO: recovery required on readonly 
> > filesystem.
> > Sep 26 11:49:06 (none) kernel: EXT3-fs: write access will be enabled during 
> > recovery.
> > Sep 26 11:49:06 (none) kernel: EXT3-fs warning (device ide0(3,2)): 
> > ext3_clear_journal_err: Filesystem error recorded from previous mount: IO 
> > failure
> > Sep 26 11:49:06 (none) kernel: EXT3-fs warning (device ide0(3,2)): 
> > ext3_clear_journal_err: Marking fs in need of filesystem check.
> > Sep 26 11:49:06 (none) kernel: EXT3-fs: ide0(3,2): orphan cleanup on readonly 
> > fs
> > Sep 26 11:49:06 (none) kernel: EXT3-fs: recovery complete.
> > Sep 26 11:49:06 (none) kernel: EXT3-fs: mounted filesystem with ordered data 
> > mode.
> > Sep 26 11:49:06 (none) kernel: EXT3 FS 2.4-0.9.18, 14 May 2002 on ide0(3,2), 
> > internal journal
> 
> Wait a second.  These messages would occur only if you had done a
> read-only mount at 11:49:06.  Did you do a manual mount at that time?
> Do you have one or more filesystems in your /etc/fstab (in particular
> /dev/hda2) that are set to be mounted read-only?  That's the only
> thing that would explain the "write access enabled during recovery of
> readonly filesystem" warning message.  That message means that
> /dev/hda2 was readonly because the mount command *requested* that it
> be mounted read-only, not because of some error.  

Ryan Cumming replied:
> /dev/hda2       /               ext3       defaults,errors=remount-ro

Ted, this is Ryan's root filesystem, so it _has_ to be mounted read-only
and have the kernel do journal recovery on it.  That said, there must
have been an error from the previous boot which caused it to have an
error recorded in the journal.

Rather than Ryan running dir-indexing on his root filesystem, I would
suggest that he instead test with a loopback filesystem to see if he
can reproduce the errors without destroying his data.  Ryan - you
should run "tune2fs -O ^dir_index /dev/hda2" to turn off indexing on
your root filesystem, and run a full e2fsck on it (e2fsck -f /dev/hda2).

After that, we'd be happy if you could test with a loopback filesystem:

touch /tmp/foo
mke2fs -j -F /tmp/foo 100000
mkdir /mnt/tmp
mount -o loop /tmp/foo /mnt/tmp

and run tests on /mnt/tmp instead of your root filesystem.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

