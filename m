Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263173AbSJDSQG>; Fri, 4 Oct 2002 14:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263165AbSJDSQG>; Fri, 4 Oct 2002 14:16:06 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:60115 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263173AbSJDSP3>;
	Fri, 4 Oct 2002 14:15:29 -0400
Date: Fri, 4 Oct 2002 14:20:54 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.40 s390.
In-Reply-To: <200210041624.17373.schwidefsky@de.ibm.com>
Message-ID: <Pine.GSO.4.21.0210041354150.19491-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Oct 2002, Martin Schwidefsky wrote:

> Hi Linus,
> the 27th patch has joint the patch set for s/390. Minimum set for something
> useful is again the first 7 patches. 
> 
> The list of patches and some comments:
> 
> 07: Fixes and more cleanup for the dasd driver. Thanks to Al Viro we
>     got rid of the ugly things in the dasd driver. The only big thing
>     left is big minors. In preparation we removed kdev_t where possible.

	* please switch to use of alloc_disk()/put_disk()
	* don't bother with disk->part allocation - it's done by add_disk()
	* ditto for freeing it (del_gendisk())
	* dasd_partition_to_kdev_t() - please use ->gdp->{major,first_minor}
	* s/bdevname(d_device->bdev)/d_device->gdp->disk_name/
	* lose ->bdev

Note that we are getting bdev->bd_disk and disk->private pretty soon, so
we'll have very easy way to do your devmap by bdev stuff.

Anther thing: tapeblock.c and friends.
<rant>
	In ~ 2.5.16 blksize_size[] had been removed.  Tape-related code
in s390 was using it, but that was fairly easy to get rid of.  Now, in
2.5.21 somebody (presumably architecture maintainers) had submitted a
patch that
	* reverted all compile fixes, etc. that had happened in 2.5
	* reintroduced use of (long-dead) blksize_size[]
^#$^%@!
Folks, if you do something like that, at least check the bloody changelog...
</rant>

