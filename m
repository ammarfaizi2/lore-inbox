Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263426AbREXI6o>; Thu, 24 May 2001 04:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263429AbREXI6h>; Thu, 24 May 2001 04:58:37 -0400
Received: from zeus.kernel.org ([209.10.41.242]:45209 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S263428AbREXI6Z>;
	Thu, 24 May 2001 04:58:25 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105221853.f4MIroHt011398@webber.adilger.int>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD  w/info-PATCH]device
 arguments from lookup)
In-Reply-To: <3B0717CE.57613D4A@mandrakesoft.com> "from Jeff Garzik at May 19,
 2001 09:03:10 pm"
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Date: Tue, 22 May 2001 12:53:50 -0600 (MDT)
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Edgar Toernig <froese@gmx.de>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff writes:
> Here's a dumb question, and I apologize if I am questioning computer
> science dogma...
> 
> Why are LVM and EVMS(competing LVM project) needed at all?
> 
> Surely the same can be accomplished with
> * md
> * snapshot blkdev (attached in previous e-mail)
> * giving partitions and blkdevs the ability to grow and shrink
> * giving filesystems the ability to grow and shrink
> 
> On-line optimization (defrag, etc) shouldn't be hard once you have the
> ability to move blocks and files around, which would come with the
> ability to grow and shrink blkdevs and fs's.

You're missing virtual->physical block mapping allowing you to move parts
of the device around, freedom from the need for contiguous disk space.

In the end, what you've described above is pretty much what LVM does (and
EVMS does better).  Having the various components inside a single layer
like EVMS gives you a lot move flexibility, IMHO.  You also don't have
the issue of wasted minor numbers for unused partitions, or too few minor
numbers in other cases.

For example, with MD RAID you still need devices of equal size to create
a RAID 1 mirror, or part of one device is wasted.  With EVMS you can (in
the future, or right now with AIX/HPUX LVM) do the RAID 1 mirroring on a
per-logical-extent basis and you get your physical extents from any device.
Because your virtual->physical mapping is already abstract, it also allows
you to add mirroring to any existing LVM device without interruption.

Cheers, Andreas

PS - I used to think shrinking a filesystem online was useful, but there
     are a huge amount of problems with this and very few real-life
     benefits, as long as you can at least do offline shrinking.  With
     proper LVM usage, the need to shrink a filesystem never really
     happens in practise, unlike the partition case where you always
     have to guess in advance how big a filesystem needs to be, and then
     add 10% for a safety margin.  With LVM you just create the minimal
     sized device you need now, and freely grow it in the future.
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
