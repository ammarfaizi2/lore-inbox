Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266629AbRGOPHl>; Sun, 15 Jul 2001 11:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266641AbRGOPHb>; Sun, 15 Jul 2001 11:07:31 -0400
Received: from geos.coastside.net ([207.213.212.4]:57990 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S266621AbRGOPHX>; Sun, 15 Jul 2001 11:07:23 -0400
Mime-Version: 1.0
Message-Id: <p05100317b7775fc2bd15@[207.213.214.37]>
In-Reply-To: <20010716023911.A10576@weta.f00f.org>
In-Reply-To: <E15LL3Y-0000yJ-00@the-village.bc.nu>
 <0107142211300W.00409@starship> <20010715153607.A7624@weta.f00f.org>
 <01071515442400.05609@starship> <20010716023911.A10576@weta.f00f.org>
Date: Sun, 15 Jul 2001 08:06:39 -0700
To: Chris Wedgwood <cw@f00f.org>, Daniel Phillips <phillips@bonn-fries.net>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [PATCH] 64 bit scsi read/write
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <andrewm@uow.edu.au>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2:39 AM +1200 2001-07-16, Chris Wedgwood wrote:
>On Sun, Jul 15, 2001 at 03:44:14PM +0200, Daniel Phillips wrote:
>
>     The only requirement here is that the checksum be correct.  And
>     sure, that's not a hard guarantee because, on average, you will
>     get a good checksum for bad data once every 4 billion power events
>     that mess up the final superblock transfer.  Let me see, if that
>     happens once a year, your data should still be good when the
>     warrantee on the sun expires.  :-)
>
>the sun will probably last a tad longer than that even contuing to
>burn hydrogen, if you allow for helium burning, you will probably get
>errors to sneak by
>
>     Surely it can't be that *all* IDE disks can fail in that way?  And
>     it seems the jury is still out on SCSI, I'm interested to see
>     where that discussion goes.
>
>Alan said *ALL* disks appear to lie, and I'm not going to argue with
>him :)
>
>I only have SCSI disks to test with, but they are hot-plug, so I guess
>I can write a whole bunch of blocks with different numbers on them,
>all over the disk, if I can figure out how to place SCSI barriers and
>then pull the drive and see what gives?

Consider the possibility (probability, I think) that SCSI drives blow 
away their (unwritten) write cache buffers on a SCSI bus reset, and 
that a SCSI bus reset is a routine, albeit last-resort, error 
recovery technique. (It's also necessary; by the time a driver gets 
to a bus reset, all else has failed. It's also, in my experience, not 
especially rare.)

The fix for that particular problem--disabling write caching--is 
simple enough, though it presumably has a performance consequence. A 
second benefit of disabling write caching is that the drive can't 
reorder writes (though of course the system still might).

At first glance, by the way, the only write barrier I see in the SCSI 
command set is the synchronize-cache command, which completes only 
after all the drive's dirty buffers are written out. Of course, 
without write caching, it's not an issue.
-- 
/Jonathan Lundell.
