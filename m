Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262963AbREWDEr>; Tue, 22 May 2001 23:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262964AbREWDEh>; Tue, 22 May 2001 23:04:37 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:24484 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262963AbREWDEV>;
	Tue, 22 May 2001 23:04:21 -0400
Message-ID: <3B0B28A9.7556908D@mandrakesoft.com>
Date: Tue, 22 May 2001 23:04:09 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct char_device
In-Reply-To: <Pine.LNX.4.21.0105221936030.4713-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 22 May 2001, Jeff Garzik wrote:
> >
> > Alan recently straightened me out with "EVMS/LVM is partitions done
> > right"
> >
> > so... why not implement partitions as simply doing block remaps to the
> > lower level device?  That's what EVMS/LVM/md are doing already.
> 
> Because we still need the partitioning code for backwards
> compatibility. There's no way I'm going to use initrd to do partition
> setup with lvmtools etc.
> 
> Also, lvm and friends are _heavyweight_. The partitioning stuff should be
> _one_ add (and perhaps a range check) at bh submit time. None of this
> remapping crap. We don't need no steenking overhead for something we need
> to do anyway.

no no no.  Not -that- heavyweight.

Partition support becomes a -peer- of LVM.

Imagine a tiny blkdev driver that understood MS-DOS (and other) hardware
partitions, and exported N block devices, representing the underlying
device (whatever it is).  In fact, that might be even a -unifying-
factor:  this tiny blkdev module -is- your /dev/disk.  For example,

/dev/sda <-> partition_blkdev <-> /dev/disk{0,1,2,3,4}
/dev/hda <-> partition_blkdev <-> /dev/disk{5,6,7}

A nice side effect:  modular partition support, since its a normal
blkdev just like anything yes.

YES there is overhead, but if partitions are just another remapping
blkdev, you get all this stuff for free.

I do grant you that an offset at bh submit time is faster, but IMHO
partitions -not- as a remapping blkdev are an ugly special case.

Remapping to an unchanging offset in the make_request_fn can be fast,
too...

-- 
Jeff Garzik      | "Are you the police?"
Building 1024    | "No, ma'am.  We're musicians."
MandrakeSoft     |
