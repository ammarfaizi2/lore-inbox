Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbTAVU4t>; Wed, 22 Jan 2003 15:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263246AbTAVU4t>; Wed, 22 Jan 2003 15:56:49 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:36376 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262824AbTAVU4r>; Wed, 22 Jan 2003 15:56:47 -0500
Date: Wed, 22 Jan 2003 16:05:55 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200301222105.h0ML5t719018@devserv.devel.redhat.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: why isn't quota dependant on ext2?
In-Reply-To: <mailman.1043208901.31378.linux-kernel2news@redhat.com>
References: <20030121185927.3abd9298.akpm@digeo.com>   <Pine.LNX.4.44.0301212259270.5687-100000@innerfire.net> <mailman.1043208901.31378.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > ext3, ufs and udf also use the core quota code.
>> 
>> The documentation says it only works with ext2 where would I find working
>> utilities to get it working on ext3 ?
> 
> ext3 uses the same tools as ext2 - checkquota, quotaon, etc.
> 
> http://quota-tools.sourceforge.net/ (site seems to be broken)

The bad news is that quota on ext3 is virtually guaranteed
to deadlock, so you can do it, but you do not want to do it.
The original memo describes a deadlock in RH 2.4.18-5, which
I assure you, was NOT fixed in Marcelo 2.4.20. A good anti-deadlock
work was done, granted, but this particular one wasn't fixed.

-- Pete

---------------------------------------------------------
Date: Mon, 21 Oct 2002 20:20:19 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Deadlock in jbd

A customer [@ Chicagolinux] had his box hanging
with 2.4.18-5, as described in Issue 4561, Bug 71379.
SysRq-T trace looks like this:

kjournald     D DD99A000     0   197      1           956   196 (L-TLB)
Call Trace: [<c0118ecb>] sleep_on [kernel] 0x4b
[<e084076e>] journal_commit_transaction [jbd] 0x15e
[<c01f0f6d>] ip_rcv [kernel] 0x39d
[<e0843806>] kjournald [jbd] 0x136
[<e08436b0>] commit_timeout [jbd] 0x0
[<c0107286>] kernel_thread [kernel] 0x26
[<e08436d0>] kjournald [jbd] 0x0

popper        D CEED5C00     0  4819   1104          4820  4807 (NOTLB)
Call Trace: [<c0107849>] __down [kernel] 0x69
[<c01079f8>] __down_failed [kernel] 0x8
[<c0160134>] .text.lock.dquot [kernel] 0x2d
[<c015e0bf>] dqget [kernel] 0x15f
[<e083edb8>] do_get_write_access [jbd] 0x568
[<c015eec6>] dquot_initialize [kernel] 0xa6
[<e084fe69>] ext3_new_inode [ext3] 0x8d9
[<e0847d10>] .rodata.str1.1 [jbd] 0x30
[<e08450f7>] __jbd_kmalloc [jbd] 0x27
[<e083e284>] start_this_handle [jbd] 0x124
[<e083e37d>] journal_start_Rsmp_89deb980 [jbd] 0xbd
[<e0854ad1>] ext3_create [ext3] 0x81
[<c014d600>] vfs_create [kernel] 0x130
[<c014d38a>] lookup_hash [kernel] 0x4a
[<c014d7ac>] open_namei [kernel] 0x13c
[<c0124c09>] timer_bh [kernel] 0x39
[<c0140f96>] filp_open [kernel] 0x36
[<c01412e4>] sys_open [kernel] 0x34
[<c0108c6b>] system_call [kernel] 0x33

kswapd        D DC0094A0  4128     7      1             8     6 (L-TLB)
Call Trace: [<c0118ecb>] sleep_on [kernel] 0x4b <--- locked by pid 197
[<e083e225>] start_this_handle [jbd] 0xc5
[<e083e37d>] journal_start_Rsmp_89deb980 [jbd] 0xbd
[<e085397e>] ext3_dirty_inode [ext3] 0x6e
[<c0139af8>] __alloc_pages [kernel] 0xa8        <--- spurious (on stack)
[<c0156f2e>] __mark_inode_dirty [kernel] 0x2e
[<c013225d>] generic_file_write [kernel] 0x34d
[<e084ed02>] ext3_file_write [ext3] 0x22
[<c015d37b>] write_dquot [kernel] 0xbb
[<c015de6c>] dqput [kernel] 0x8c
[<c015efdb>] dquot_drop [kernel] 0x3b
[<c0157b3e>] clear_inode [kernel] 0xce
[<c0156ded>] destroy_inode [kernel] 0x2d
[<c0157c2c>] dispose_list [kernel] 0x5c
[<c0157f73>] prune_icache [kernel] 0x143
[<c0157fb0>] shrink_icache_memory [kernel] 0x20
[<c0138856>] do_try_to_free_pages [kernel] 0x26
[<c0138b41>] kswapd [kernel] 0x101
[<c0105000>] stext [kernel] 0x0
[<c0107286>] kernel_thread [kernel] 0x26
[<c0138a40>] kswapd [kernel] 0x0

I reconstruct the sequence in the following way. The kswapd does its
trick and does the dquot_drop on some inode, taking a quota semaphore,
and manages to sleep somewhere a little (not exactly sure where,
perhaps writing a page out or something...). Next, popper goes
about ext3_create, does journal_start (we can even see a leftover
part of that sequence on its stack, no need to guess!), and
locks trying to grab the quote semaphore. Essentially, it sleeps
with ->t_updates incremented, and this is where the trouble starts.
kjournald is awaken, locks the current transaction with T_LOCKED and
waits for updates to drop (held by popper). To top things off,
the kswapd awakens or otherwise comes around and does journal_start,
which promptly blocks, because current t_state is T_LOCKED.

Now we have three processes, all locked together to form a deadlock,
which is kinda cute.
---------------------------------------------------------
