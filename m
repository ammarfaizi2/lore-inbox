Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262079AbSJVDty>; Mon, 21 Oct 2002 23:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262080AbSJVDty>; Mon, 21 Oct 2002 23:49:54 -0400
Received: from franka.aracnet.com ([216.99.193.44]:33189 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262079AbSJVDtx>; Mon, 21 Oct 2002 23:49:53 -0400
Date: Mon, 21 Oct 2002 20:53:59 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: Rik van Riel <riel@conectiva.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>
Subject: Re: ZONE_NORMAL exhaustion (dcache slab)
Message-ID: <2622146086.1035233637@[10.10.2.3]>
In-Reply-To: <3DB4C87E.7CF128F3@digeo.com>
References: <3DB4C87E.7CF128F3@digeo.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I cannot make it happen here, either.  2.5.43-mm2 or current devel
> stuff.  Heisenbug; maybe something broke dcache-rcu?  Or the math
> overflow (unlikely).

Dipankar is going to give me some debug code once he's slept for
a while ... that should help see if dcache-rcu went wacko.
 
>> So it looks as though it's actually ext2_inode cache that's first against the wall.
> 
> Well that's to be expected.  Each ext2 directory inode has highmem
> pagecache attached to it, which pins the inode.  There's no highmem
> eviction pressure so your normal zone gets stuffed full of inodes.
> 
> There's a fix for this in Andrea's tree, although that's perhaps a
> bit heavy on inode_lock for 2.5 purposes.  It's a matter of running
> invalidate_inode_pages() against the inodes as they come off the
> unused_list.  I haven't got around to it yet.

Thanks; no urgent problem (though we did seem to have a customer hitting
a very similar situation very easily in 2.4 ... we'll see if Andrea's
fixes that, then I'll try to reproduce their problem on current 2.5).
 
>> larry:~# egrep '(dentry|inode)' /proc/slabinfo
>> isofs_inode_cache      0      0    320    0    0    1 :  120   60
>> ext2_inode_cache  667345 809181    416 89909 89909    1 :  120   60
>> shmem_inode_cache      3      9    416    1    1    1 :  120   60
>> sock_inode_cache      16     22    352    2    2    1 :  120   60
>> proc_inode_cache      12     12    320    1    1    1 :  120   60
>> inode_cache          385    396    320   33   33    1 :  120   60
>> dentry_cache      1068289 1131096    160 47129 47129    1 :  248  124
> 
> OK, so there's reasonable dentry shrinkage there, and the inodes
> for regular files whch have no attached pagecache were reaped.
> But all the directory inodes are sitting there pinned.

OK, this all makes a lot of sense ... apart from one thing:
from looking at meminfo:

HighTotal:    15335424 kB
HighFree:     15066160 kB

Even if every highmem page is pagecache, that's only 67316 pages by
my reckoning (is pagecache broken out seperately in meminfo? both
Buffers and Cached seem to large). If I only have 67316 page of 
pagecache, how can I have 667345 inodes with attatched pagecache pages?
Or am I just missing something obvious and fundamental? 
