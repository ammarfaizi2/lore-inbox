Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263262AbTKYVHt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 16:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbTKYVHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 16:07:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:5829 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263262AbTKYVHr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 16:07:47 -0500
Date: Tue, 25 Nov 2003 13:07:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jack Steiner <steiner@sgi.com>
Cc: jes@trained-monkey.org, viro@math.psu.edu, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, jbarnes@sgi.com
Subject: Re: hash table sizes
Message-Id: <20031125130741.108bf57c.akpm@osdl.org>
In-Reply-To: <20031125204814.GA19397@sgi.com>
References: <16323.23221.835676.999857@gargle.gargle.HOWL>
	<20031125204814.GA19397@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack Steiner <steiner@sgi.com> wrote:
>
> > +	mempages >>= (23 - (PAGE_SHIFT - 1));
> > +	order = max(2, fls(mempages));
> > +	order = min(12, order);
> >  
> 
> I dont think you want to constrain the allocation to a specific "order". Otherwise,
> when the kernel is built with a 64k pagesize, the size of the caches will increase 4X.
> 
> Some architectures (IA64, for example) dont have severe limitations on usage of vmalloc
> space. Would it make sense to use vmalloc on these architectures. Even if the
> max size of the structures being allocated is limited to an acceptible size, it still
> concentrates the memory on a single node. In general, we should try to
> distribute the memory references across as many nodes as possible - at least in theory. 

I don't think we want to use vmalloc, unless it really can be shown that
the use of an entire memory zone on some machine _still_ provides a
hashtable which is so small that it unacceptably impacts performance.

And that it can be shown that a mega-hashtable is still an appropriate data
structure...

> (In practice, I wonder if we could actually measure the difference.....)

Well yes.  I suspect the inode hashtable could be shrunk; I don't think we
do hash-based inode lookups very much?

Also the inode hashtable perhaps could become per superblock, perhaps with
sizing hints from the fs.  Or not.

This is hard.  We could change the sizing of these tables so that for their
setup arithmetic they use "the size of the zone from which the table is to
be allocated" rather than "the size of all memory".  But we do want to make
the size of these tables dependent upon the number of dentries/inodes/etc
which the system is likely to support.  And that does depend upon the
amount of direct-addressible memory.


So hum.  As a starting point, what happens if we do:

-	vfs_caches_init(num_physpages);
+	vfs_caches_init(min(num_physpages, pages_in_ZONE_NORMAL));

?


It would be very nice to have some confirmation that the size of these
tables is being appropriately chosen, too.  Maybe we should shrink 'em 32x
and see who complains...


