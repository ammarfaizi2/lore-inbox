Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271598AbRIJTGN>; Mon, 10 Sep 2001 15:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271612AbRIJTGE>; Mon, 10 Sep 2001 15:06:04 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:6858 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S271598AbRIJTFu>; Mon, 10 Sep 2001 15:05:50 -0400
Date: Mon, 10 Sep 2001 15:06:08 -0400
From: Chris Mason <mason@suse.com>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Andreas Dilger <adilger@turbolabs.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
Message-ID: <1494520000.1000148768@tiny>
In-Reply-To: <20010910032901Z16134-26183+710@humbolt.nl.linux.org>
In-Reply-To: <20010910001556Z16150-26183+680@humbolt.nl.linux.org>
 <20010910023312Z16066-26183+700@humbolt.nl.linux.org>
 <1381380000.1000090938@tiny>
 <20010910032901Z16134-26183+710@humbolt.nl.linux.org>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, September 10, 2001 05:36:07 AM +0200 Daniel Phillips
<phillips@bonn-fries.net> wrote:

> Well, I really wonder if buffers are the right transport medium for
> variable,  large blocks, aka extents.  Personally, I think buffers will
> have disappeared  or mutated unrecognizably by the time we get around to
> adding extents to ext2  or its descendents.  Note that XFS already
> implements extents on Linux, by  mapping them onto the pagecache I
> believe.

Yes, JFS as well, but this is somewhat unrelated to using buffers as io
handles.

> 
>> If we relax the rules to allow multiple buffer heads for
>> the same physical spot on disk, things get easier, and the FS is
>> responsible for not doing something stupid with it.  
>> 
>> The data is still consistent either way, there are just multiple io
>> handles.
> 
> Were you thinking of one mapping for all buffers on a given partition?

one mapping for all buffers accessed through getblk, get_hash_table, bread,
and the block device.

> If  so, how did you plan to handle different buffer sizes?  Were you
> planning to  keep the existing buffer hash chain or use the page cache
> hash chain, as I  did for ext2_getblk?

It would be through page->buffers.  Of course, this part is entirely
uncoded, but the nice thing about an address space on top of the physical
device is that bh->b_blocknr and bh->b_size directly compute to the offset
in the device.  This means the order of the buffers on page->buffers does
not have to be related to the location of the data they point to.

So, along the lines of what Andrea suggested, buffer heads can be allocated
as needed, regardless of the blocksizes already in use in the page.  The
current blkdev page cache code would need to be updated to use this idea,
but it should work.

-chris

