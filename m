Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133084AbRDLOu4>; Thu, 12 Apr 2001 10:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133107AbRDLOur>; Thu, 12 Apr 2001 10:50:47 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:14722 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S133084AbRDLOu3>;
	Thu, 12 Apr 2001 10:50:29 -0400
Date: Thu, 12 Apr 2001 10:50:24 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Fwd: Re: memory usage - dentry_cacheg
In-Reply-To: <20010412103404.D13778@cs.cmu.edu>
Message-ID: <Pine.GSO.4.21.0104121044020.19944-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Apr 2001, Jan Harkes wrote:

> But the VM pressure on the dcache and icache only comes into play once
> the system still has a free_shortage _after_ other attempts of freeing
> up memory in do_try_to_free_pages.

I don't think that it's necessary bad.

> sync_all_inodes, which is called from shrink_icache_memory is
> counterproductive at this point. Writing dirty inodes to disk,
> especially when there is a lot of them, requires additional page
> allocations.

Agreed, but that's
	a) a separate story
	b) not the case in situation mentioned above (all inodes are
busy).

> I have a patch that avoids unconditionally puts pressure on the dcache
> and icache, and avoids sync_all_inodes in shrink_icache_memory. An
> additional wakeup for the kupdate thread makes sure that inodes are more
> frequently written when there is no more free shortage. Maybe kupdated
> should be always get woken up.

Maybe, but I really doubt that constant pressure on dcache/icache is a
good idea. I'd rather see what will change from fixing that bug in
prune_dcache() before deciding what to do next.

> btw. Alexander, is the following a valid optimization to improve
> write-coalescing when calling sync_one for several inodes?
> 
> inode.c:sync_one
> 
> -    filemap_fdatawait(inode->i_mapping);
> +    if (sync) filemap_fdatawait(inode->i_mapping);

Umm... Probably.

