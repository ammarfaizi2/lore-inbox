Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbUCCXjs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 18:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbUCCXjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 18:39:48 -0500
Received: from mail.convergence.de ([212.84.236.4]:11650 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261261AbUCCXji
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 18:39:38 -0500
Date: Thu, 4 Mar 2004 00:41:04 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Peter Nelson <pnelson@andrew.cmu.edu>
Cc: Hans Reiser <reiser@namesys.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       ext3-users@redhat.com, jfs-discussion@www-124.ibm.com,
       reiserfs-list@namesys.com, linux-xfs@oss.sgi.com
Subject: Re: Desktop Filesystem Benchmarks in 2.6.3
Message-ID: <20040303234104.GD1875@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Peter Nelson <pnelson@andrew.cmu.edu>,
	Hans Reiser <reiser@namesys.com>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	ext3-users@redhat.com, jfs-discussion@oss.software.ibm.com,
	reiserfs-list@namesys.com, linux-xfs@oss.sgi.com
References: <4044119D.6050502@andrew.cmu.edu> <4044366B.3000405@namesys.com> <4044B787.7080301@andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4044B787.7080301@andrew.cmu.edu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Nelson wrote:
> Hans Reiser wrote:
> 
> >Are you sure your benchmark is large enough to not fit into memory, 
> >particularly the first stages of it?  It looks like not.  reiser4 is 
> >much faster on tasks like untarring enough files to not fit into ram, 
> >but (despite your words) your results seem to show us as slower unless 
> >I misread them....
> 
> I'm pretty sure most of the benchmarking I am doing fits into ram, 
> particularly because my system has 1GB of it, but I see this as 
> realistic.  When I download a bunch of debs (or rpms or the kernel) I'm 
> probably going to install them directly with them still in the file 
> cache.  Same with rebuilding the kernel after working on it.

OK, that test is not very interesting for the FS gurus because it
doesn't stress the disk enough.

Anyway, I have some related questions concerning disk/fs performance:

o I see you are using and IDE disk with a large (8MB) write cache.

  My understanding is that enabling write cache is a risky
  thing for journaled file systems, so for a fair comparison you
  would have to enable the write cache for ext2 and disable it
  for all journaled file systems.

It would be nice if someone with more profound knowledge could comment
on this, but my understanding of the problem is:

- journaled filesystems can only work when they can enforce that
  journal data is written to the platters at specifc times wrt
  normal data writes
- IDE write caching makes the disk "lie" to the kernel, i.e. it says
  "I've written the data" when it was only put in the cache
- now if a *power failure* keeps the disk from writing the cache
  contents to the platter, the fs and journal are inconsistent
  (a kernel crash would not cause this problem because the disk can
  still write the cache contents to the platters)
- at next mount time the fs will read the journal from the disk
  and try to use it to bring the fs into a consistent state;
  however, since the journal on disk is not guaranteed to be up to date
  this can *fail*  (I have no idea what various fs implementations do
  to handle this; I suspect they at least refuse to mount and require
  you to manually run fsck. Or they don't notice and let you work
  with a corrupt filesystem until they blow up.)

Right?  Or is this just paranoia?

To me it looks like IDE write barrier support
(http://lwn.net/Articles/65353/) would be a way
to safely enable IDE write caches for journaled filesystems.

Has anyone done any benchmarks concerning write cache and journaling?


o And one totally different :-) question:

Has anyone benchmarked fs performance on PATA IDE disks vs.
otherwise comparable SCSI or SATA disks (I vaguely recall
having read that SATA has working TCQ, i.e. not broken by
design as with PATA)?

I have read a few times that SCSI disks perform much better
than IDE disks. The usual reason given is "SCSI disks are built for
servers, IDE for desktops". Is this all, or is it TCQ that
matters? Or is the Linux SCSI core better than the IDE core?


Johannes
