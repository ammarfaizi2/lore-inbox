Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132904AbRAQP4s>; Wed, 17 Jan 2001 10:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135342AbRAQP4i>; Wed, 17 Jan 2001 10:56:38 -0500
Received: from [64.109.89.110] ([64.109.89.110]:39768 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S132904AbRAQP4Z>; Wed, 17 Jan 2001 10:56:25 -0500
Message-Id: <200101171556.KAA01055@localhost.localdomain>
X-Mailer: exmh version 2.1.1 10/15/1999
To: David Santinoli <u235@libero.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: Partition renumbering under 2.4.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 17 Jan 2001 10:56:14 -0500
From: James Bottomley <J.E.J.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Note that the ext2 logical partition is called "hdb9" by 2.2.16 and
> "hdb5" by 2.4.0. This makes it difficult to manage multi-boot systems
> with 2.2.x and 2.4.x kernels, as it requires updating fstab between
> boots. Switching to other identification strategies such as ext2
> labels - as discussed in other threads - could be a workaround, as far
> as I know.

Your problem is caused by the identification loop in fs/partitions/msdos.c 
having been split into two parts in 2.4.  One part identifies msdos and 
extended partitions in the first pass and then goes on to identify other 
disklabel partitions in the second.  You can restore consistency either by 
combining the two passes (as was the case in 2.2) or by moving the extended 
msdos partition identification into the second pass.

However, the underlying problem remains the same as it was when I first wrote 
the solaris code:  You only have 11 minors for all of the remaining extended 
partitions, that's why the solaris code does the slice renaming.  Under 2.4, 
if you use devfs, the solaris (and other) slice recognition code could be 
enhanced to give the correct names to all the slices.  This would turn out to 
be something like /dev/ide/hdb2s7 (or something even worse---I'm afraid I only 
really know the naming scheme for SCSI devices) but at least you can find the 
exact slice you're looking for in an easy and intuitive way.

So, would you prefer the quick fix, or the more durable solution (which would 
require you to change your fstab)?

James


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
