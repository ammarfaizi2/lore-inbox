Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291401AbSCIHOi>; Sat, 9 Mar 2002 02:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291701AbSCIHOa>; Sat, 9 Mar 2002 02:14:30 -0500
Received: from zeus.kernel.org ([204.152.189.113]:61645 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S291640AbSCIHOR>;
	Sat, 9 Mar 2002 02:14:17 -0500
Date: Fri, 08 Mar 2002 21:20:31 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
Subject: Re: breaking up the pagemap_lru_lock (was in rmap, now everywhere ;-) )
Message-ID: <81230673.1015622429@[10.10.2.3]>
In-Reply-To: <20020305030204.A20606@dualathlon.random>
In-Reply-To: <20020305030204.A20606@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> but anyways, can you show where do you see this high contenction on the
> pagemap_lru lock? Maybe that's more a sympthom that the rmap is doing
> something silly with the lock acquired, can you measure high contention
> also on my tree on similar workloads? I think we should worry about the
> pagecache_lock, before the pagemap_lru lock.

OK, we've now got some of the other problems on NUMA-Q fixed,
so I can see lock contention better. This is running on a 
16-way NUMA-Q, which now has proper page_local allocation
working, compiling a kernel with a VM that's based on the
standard 2.4.18 (I haven't tried the latest -aa tree stuff
yet - if there's any particular part that might help this,
please let me know)

 20.2% 57.1%  5.4us(  86us)  111us(  16ms)(14.7%)   1014988 42.9% 57.1%    0%  pagemap_lru_lock
 0.06% 17.2%  4.4us(  46us)   73us(2511us)(0.01%)      3751 82.8% 17.2%    0%    activate_page+0xc
 10.4% 55.9%  5.6us(  86us)  123us(  16ms)( 8.1%)    507541 44.1% 55.9%    0%    lru_cache_add+0x1c
  9.6% 58.5%  5.2us(  84us)   98us(  12ms)( 6.7%)    503696 41.5% 58.5%    0%    lru_cache_del+0xc

Contention is bad, max hold time is good, max wait time is bad.
Looks like it's getting bounced around inside one node - I'll
try John Stultz's msclock stuff on this to fix that, but this
lock's still getting hammered, and could do with some medical
aid ;-) I have something to break it up per zone for rmap, but
I think your tree has a global lru, if I'm not mistaken? 
Not sure what we can do about that one.

Pagecache_lock doesn't look good either, but is less of a problem:

 17.5% 31.3%  7.5us(  99us)   52us(4023us)( 2.4%)    631988 68.7% 31.3%    0%  pagecache_lock
 13.5% 33.2%  7.7us(  82us)   53us(3663us)( 1.9%)    475603 66.8% 33.2%    0%    __find_get_page+0x18
 0.12% 14.7%  2.8us(  54us)   43us(1714us)(0.02%)     11570 85.3% 14.7%    0%    __find_lock_page+0x10
 0.10% 10.7%  6.6us(  58us)   43us( 354us)(0.00%)      4270 89.3% 10.7%    0%    add_to_page_cache_unique+0x18
  3.8% 28.1%  8.0us(  99us)   52us(4023us)(0.43%)    127606 71.9% 28.1%    0%    do_generic_file_read+0x1a4
 0.00% 16.9%  8.1us(  34us)   42us( 108us)(0.00%)        65 83.1% 16.9%    0%    do_generic_file_read+0x370
 0.02% 16.1%  0.9us(  20us)   20us( 161us)(0.00%)      5580 83.9% 16.1%    0%    filemap_fdatasync+0x20
 0.02% 16.6%  0.9us(  21us)   20us( 145us)(0.00%)      5580 83.4% 16.6%    0%    filemap_fdatawait+0x14
 0.00%  1.7%  1.0us(  13us)   19us(  26us)(0.00%)       173 98.3%  1.7%    0%    find_or_create_page+0x44
 0.00%  1.7%  3.0us(  45us)   41us(  89us)(0.00%)       173 98.3%  1.7%    0%    find_or_create_page+0x88
 0.00%  2.4%  1.9us(  25us)   47us( 211us)(0.00%)       663 97.6%  2.4%    0%    remove_inode_page+0x18
 0.00% 16.7%  4.0us(  22us)  108us( 306us)(0.00%)        42 83.3% 16.7%    0%    truncate_inode_pages+0x3c
 0.00%  2.6%  0.8us(  30us)   80us( 864us)(0.00%)       663 97.4%  2.6%    0%    truncate_list_pages+0x204

None of the hold times look too bad, but the lock's still getting
hammered. Would be nice to break this up per zone/node.

dcache_lock is also a pain. I'm working with Hanna's stuff on that,
and making good progress. Still some way to go.

BKL is a pain in the rear, as usual ;-)

M.

