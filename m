Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWAKJeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWAKJeO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 04:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWAKJeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 04:34:14 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:23432 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751400AbWAKJeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 04:34:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Zlv9OqsHpinrjyLyFmb2QpaYjyoTd8rG7U521/HmT2SukrHXAh4Qll9UrveId6/a39TH8xArST7gSyKNwwk8bS7cYZzBLfmuZziK/CezzLEUlk81d9LcPG2PGos5vMRMPfQ+EuPqWKVQVqzRqZ6dFrItpeJqEgkisdzoLaFzyTY=  ;
Message-ID: <43C4D113.4060705@yahoo.com.au>
Date: Wed, 11 Jan 2006 20:34:11 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       hugh@veritas.com
Subject: Re: smp race fix between invalidate_inode_pages* and do_no_page
References: <20051213193735.GE3092@opteron.random> <20051213130227.2efac51e.akpm@osdl.org> <20051213211441.GH3092@opteron.random> <20051216135147.GV5270@opteron.random> <20060110062425.GA15897@opteron.random> <43C484BF.2030602@yahoo.com.au> <20060111082359.GV15897@opteron.random>
In-Reply-To: <20060111082359.GV15897@opteron.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Wed, Jan 11, 2006 at 03:08:31PM +1100, Nick Piggin wrote:
> 
>>I'd be inclined to think a lock_page is not a big SMP scalability
>>problem because the struct page's cacheline(s) will be written to
>>several times in the process of refcounting anyway. Such a workload
>>would also be running into tree_lock as well.
> 
> 
> I seem to recall you wanted to make the tree_lock a readonly lock for
> readers for the exact same scalability reason? do_no_page is quite a

I think Bill Irwin or Peter Chubb made the tree_lock a reader-writer
lock back in the day.

I have some patches (ref:lockless pagecache) that completely removes
the tree_lock from read-side operations like find_get_page and
find_lock_page, and turns the write side back into a regular spinlock.
You must be thinking of that?

> fast path for the tree lock too. But I totally agree the unavoidable is
> the atomic_inc though, good point, so it worth more to remove the
> tree_lock than to remove the page lock, the tree_lock can be avoided the
> atomic_inc on page->_count not.
> 

Yep, my thinking as well.

> The other bonus that makes this attractive is that then we can drop the
> *whole* vm_truncate_count mess... vm_truncate_count and
> inode->trunate_count exists for the only single reason that do_no_page
> must not map into the pte a page that is under truncation. We can
> provide the same guarantee with the page lock doing like
> invalidate_inode_pages2_range (that is to check page_mapping under the
> page_lock and executing unmap_mapping_range with the page lock held if
> needed). That will free 4 bytes per vma (without even counting the
> truncate_count on every inode out there! that could be an even larger
> gain), on my system I have 9191 vmas in use, that's 36K saved of ram in
> my system, and that's 36K saved on x86, on x86-64 it's 72K saved of
> physical ram since it's an unsigned long after a pointer, and vma must
> not be hw aligned (and infact it isn't so the saving is real). On the
> indoes side it saves 4 bytes
> * 1384 on my current system, on a busy nfs server it can save a lot
> more. The inode also most not be hw aligned and correctly it isn't. On a
> server with lot more of vmas and lot more of inodes it'll save more ram.
> 
> So if I make this change this could give me a grant for lifetime
> guarantee of seccomp in the kernel that takes less than 1kbyte on a x86,
> right? (on a normal desktop I'll save at minimum 30 times more than what
> I cost to the kernel users ;) Just kidding of course...
> 

Sounds like a good idea (and your proposed implementation -
lock_page and recheck mapping in do_no_page sounds sane).

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
