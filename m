Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276601AbRJKRWz>; Thu, 11 Oct 2001 13:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276369AbRJKRWp>; Thu, 11 Oct 2001 13:22:45 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:48295 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276594AbRJKRWa>;
	Thu, 11 Oct 2001 13:22:30 -0400
Date: Thu, 11 Oct 2001 13:23:00 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11 loses sda9
In-Reply-To: <Pine.GSO.4.21.0110111248550.22698-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0110111307020.22698-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Oct 2001, Alexander Viro wrote:

> 
> 
> On Thu, 11 Oct 2001, Ignacio Vazquez-Abrams wrote:
> 
> > Ouch. You may have to use partedit from PartitionMagic (or some other
> > low-level partition editor) to manually change the partition type.
> 
> Like, say it, dd(1).  However, partitioning code doesn't give a damn for
> entry type - "empty" means "zero number of sectors" for it.  Something
> very screwy is going on.


Owww...  I think I know what can be happening here.  Combination of very
weird (and apparently old) paritioning corruption with slightly broken
error handling in old extended_partition() code.

Setup that could explain everything we'd seen on that one looks so:

	a) extended partitions' chain ends with empty partition table.
	b) extended_partition() sets a fake device on the tail of
extended partitionbefore going into it.  Normally that fake device is
overwritten by _data_ partition refered from the EPT in the beginning of
the tail.  In this case, though, the fake is left untouched.
	c) it can be opened.  fdisk screams bloody murder seeing the
extended partition with no partitions inside, but it can be opened.
And mkfs'ed.

	IOW, you've got ext2 living on partition with type 5.  Since its
(empty) EPT lives where the boot sector should be, ext2 leaves the thing
untouched.

	That's one very sick puppy - any fdisk-style program will have
a fit on it and it certainly shouldn't create anything like that.  And
no, I don't see a good solution for that one - it's going to be very hard
to turn into valid partitions' chain.

	We can restore the bug in question, but it's still going to be
hell on any fdisk and there's nothing kernel could do about that one.
Notice that even with the old kernel sda9 officially doesn't exist -
it can be opened only because of the lack of proper error-recovery in
old extended_partition().

	All that, unfortunately, doesn't explain another bug-report
on lost partitions, but there we have very different picture - 2.4.10
actually seeing the partition in question and fdisk being OK with it.
Ugh...

