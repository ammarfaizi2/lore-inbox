Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265478AbRGOBUN>; Sat, 14 Jul 2001 21:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265488AbRGOBUE>; Sat, 14 Jul 2001 21:20:04 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:31196 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S265478AbRGOBT4>; Sat, 14 Jul 2001 21:19:56 -0400
Message-ID: <3B50F000.53EAB651@uow.edu.au>
Date: Sun, 15 Jul 2001 11:21:04 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-lvm@sistina.com
Subject: Re: [PATCH] 64 bit scsi read/write
In-Reply-To: <E15LL3Y-0000yJ-00@the-village.bc.nu> <20010715025001.B6722@weta.f00f.org>,
		<20010715025001.B6722@weta.f00f.org> <0107142211300W.00409@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Saturday 14 July 2001 16:50, Chris Wedgwood wrote:
> > On Sat, Jul 14, 2001 at 09:45:44AM +0100, Alan Cox wrote:
> >
> >     As far as I can tell none of them at least in the IDE world
> >
> > SCSI disk must, or at least some... if not, how to peopel like NetApp
> > get these cool HA certifications?
> 
> Atomic commit.  The superblock, which references the updated version
> of the filesystem, carries a sequence number and a checksum.  It is
> written to one of two alternating locations.  On restart, both
> locations are read and the highest numbered superblock with a correct
> checksum is chosen as the new filesystem root.

But this assumes that it is the most-recently-written sector/block
which gets lost in a power failure.

The disk will be reordering writes - so when it fails it may have
written the commit block but *not* the data which that block is
committing.

You need a barrier or a full synchronous flush prior to writing
the commit block.  A `don't-reorder-past-me' barrier is very much
preferable, of course.

-
