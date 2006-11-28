Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756982AbWK1Vv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756982AbWK1Vv2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 16:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756969AbWK1Vv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 16:51:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8582 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1756952AbWK1Vv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 16:51:27 -0500
Message-ID: <456CACF3.7030200@redhat.com>
Date: Tue, 28 Nov 2006 16:41:07 -0500
From: Wendy Cheng <wcheng@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] prune_icache_sb
References: <4564C28B.30604@redhat.com>	<20061122153603.33c2c24d.akpm@osdl.org>	<456B7A5A.1070202@redhat.com> <20061127165239.9616cbc9.akpm@osdl.org>
In-Reply-To: <20061127165239.9616cbc9.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 27 Nov 2006 18:52:58 -0500
> Wendy Cheng <wcheng@redhat.com> wrote:
>
>   
>> Not sure about walking thru sb->s_inodes for several reasons....
>>
>> 1. First, the changes made are mostly for file server setup with large 
>> fs size - the entry count in sb->s_inodes may not be shorter then 
>> inode_unused list.
>>     
>
> umm, that's the best-case.  We also care about worst-case.  Think:
> 1,000,000 inodes on inode_unused, of which a randomly-sprinkled 10,000 are
> from the being-unmounted filesytem.  The code as-proposed will do 100x more
> work that it needs to do.  All under a global spinlock.
>   
By walking thru sb->s_inodes, we also need to take inode_lock and 
iprune_mutex (?), since we're purging the inodes from the system - or 
specifically, removing them from inode_unused list. There is really not 
much difference from the current prune_icache() logic. What's been 
proposed here is simply *exporting* the prune_icache() kernel code to 
allow filesystems to trim (purge a small percentage of ) its 
(potentially will be) unused per-mount inodes for *latency* considerations.

I made a mistake by using the "page dirty ratio" to explain the problem 
(sorry! I was not thinking well in previous write-up) that could mislead 
you to think this is a VM issue. This is not so much about 
low-on-free-pages (and/or memory fragmentation) issue (though 
fragmentation is normally part of the symptoms). What the (external) 
kernel module does is to tie its cluster-wide file lock with in-memory 
inode that is obtained during file look-up time. The lock is removed 
from the machine when

1. the lock is granted to other (cluster) machine; or
2. the in-memory inode is purged from the system.

One of the clusters that has this latency issue is an IP/TV application 
where it "rsync" with main station server (with long geographical 
distance) every 15 minutes. It subsequently (and constantly) generates 
large amount of inode (and locks) hanging around. When other nodes, 
served as FTP servers, within the same cluster are serving the files, 
DLM has to wade through huge amount of locks entries to know whether the 
lock requests can be granted. That's where this latency issue gets 
popped out. Our profiling data shows when the cluster performance is 
dropped into un-acceptable ranges, DLM could hogs 40% of CPU cycle in 
lock searching logic. From VM point of view, the system does not have 
memory shortage so it doesn't have a need to kick off prune_icache() call.

This issue could also be fixed in several different ways - maybe by a 
better DLM hash function, maybe by asking IT people to umount the 
filesystem where *all* per-mount inodes are unconditionally purged (but 
it defeats the purpose of caching inodes and, in our case, the locks) 
after each rsync, ...., etc. But I do think the proposed patch is the 
most sensible way to fix this issue and believe it will be one of these 
functions that if you export it, people will find a good use of it. It 
helps with memory fragmentation and/or shortage *before* it becomes a 
problem as well. I certainly understand and respect a maintainer's 
daunting job on how to take/reject a patch - let me know how you think 
so I can start to work on other solutions if required.

-- Wendy

