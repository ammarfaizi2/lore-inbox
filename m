Return-Path: <linux-kernel-owner+w=401wt.eu-S932335AbXAIVMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbXAIVMc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 16:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbXAIVMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 16:12:32 -0500
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:55882 "EHLO
	rwcrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932335AbXAIVMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 16:12:31 -0500
Message-ID: <45A3FF50.4060004@wolfmountaingroup.com>
Date: Tue, 09 Jan 2007 13:47:12 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
CC: Anton Altaparmakov <aia21@cantab.net>,
       linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: NTFS deadlock on 2.6.18.6
References: <20070109205249.GA3802@procyon.home>
In-Reply-To: <20070109205249.GA3802@procyon.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Vlasov wrote:

Yep.  

>Hello!
>
>I have encountered a deadlock in the NTFS filesystem on a
>2.6.18.6-based kernel (x86_64, CONFIG_SMP set, but the machine has
>only one CPU (Athlon64 3200+), no PREEMPT).
>
>The kswapd0 and mklocatedb processes were apparently involved in the
>deadlock:
>
>kswapd0       D ffff810005dea304     0   163      7           164   162 (L-TLB)
> ffff81003fd6bcc8 0000000000000046 0000000000000020 00000000021aaac0
> 000000000000000a ffff81003fe93820 ffff81003fb157a0 0000027894893008
> 00000000000308da ffff81003fe93a20 ffff810000000000 ffff810001641670
>Call Trace:
> [<ffffffff8025e4cf>] __mutex_lock_slowpath+0x5d/0x98
> [<ffffffff8025e50f>] .text.lock.mutex+0x5/0x14
>DWARF2 unwinder stuck at .text.lock.mutex+0x5/0x14
>Leftover inexact backtrace:
> [<ffffffff881b58d2>] :ntfs:ntfs_put_inode+0x38/0x7a
> [<ffffffff80229987>] iput+0x3b/0x84
> [<ffffffff881b5a1b>] :ntfs:ntfs_clear_big_inode+0x107/0x121
> [<ffffffff802215f6>] clear_inode+0xc5/0xf6
> [<ffffffff8023362a>] dispose_list+0x56/0xf6
> [<ffffffff8022c47e>] shrink_icache_memory+0x1d4/0x203
> [<ffffffff8023de38>] shrink_slab+0xdc/0x154
> [<ffffffff802545e8>] kswapd+0x320/0x424
> [<ffffffff802921ca>] autoremove_wake_function+0x0/0x2e
> [<ffffffff80292007>] keventd_create_kthread+0x0/0x61
> [<ffffffff802542c8>] kswapd+0x0/0x424
> [<ffffffff80292007>] keventd_create_kthread+0x0/0x61
> [<ffffffff802312d8>] kthread+0xd4/0x107
> [<ffffffff80259d60>] child_rip+0xa/0x12
> [<ffffffff80292007>] keventd_create_kthread+0x0/0x61
> [<ffffffff80231204>] kthread+0x0/0x107
> [<ffffffff80259d56>] child_rip+0x0/0x12
>
>mklocatedb    D ffff810001e0d400     0  4586   4585                     (NOTLB)
> ffff810021fd5c48 0000000000000082 0000000000000000 0000000000000000
> 000000000000000a ffff81002728f7e0 ffffffff8048b3c0 000002789a2349cf
> 00000000000025c4 ffff81002728f9e0 ffff810000000000 0000000000000000
>Call Trace:
> [<ffffffff8024d781>] __wait_on_freeing_inode+0x82/0xa0
> [<ffffffff8024be5e>] find_inode+0x3d/0x6c
> [<ffffffff80256b8c>] ifind+0x34/0x91
> [<ffffffff802cbe81>] iget5_locked+0x6c/0x1a9
> [<ffffffff881b3aea>] :ntfs:ntfs_attr_iget+0x5a/0x5eb
> [<ffffffff881ae308>] :ntfs:ntfs_readdir+0x3f1/0xce1
> [<ffffffff802339d9>] vfs_readdir+0x77/0xa9
> [<ffffffff80237247>] sys_getdents+0x75/0xbd
> [<ffffffff80258ed6>] system_call+0x7e/0x83
>DWARF2 unwinder stuck at system_call+0x7e/0x83
>Leftover inexact backtrace:
>
>There were some other processes stuck in the D state, but that seems
>to be just a result of the above deadlock:
>
>linuxdcpp     D ffff810001e0d400     0  4912   4910          4914  4911 (NOTLB)
> ffff8100283d1bf0 0000000000000082 ffff81000181cf38 ffff8100283d1b98
> 0000000000000007 ffff81002ca0c0c0 ffffffff8048b3c0 00000279f4c0a091
> 0000000000026b39 ffff81002ca0c2c0 ffffffff00000000 0000000000000000
>Call Trace:
> [<ffffffff8025e4cf>] __mutex_lock_slowpath+0x5d/0x98
> [<ffffffff8025e50f>] .text.lock.mutex+0x5/0x14
>DWARF2 unwinder stuck at .text.lock.mutex+0x5/0x14
>Leftover inexact backtrace:
> [<ffffffff8022c2ea>] shrink_icache_memory+0x40/0x203
> [<ffffffff8023de38>] shrink_slab+0xdc/0x154
> [<ffffffff802b0e1c>] try_to_free_pages+0x179/0x254
> [<ffffffff8020df64>] __alloc_pages+0x1a8/0x2a9
> [<ffffffff80211077>] __do_page_cache_readahead+0x95/0x206
> [<ffffffff802af5a1>] force_page_cache_readahead+0x5f/0x81
> [<ffffffff802b1f06>] sys_madvise+0x2f7/0x3ec
> [<ffffffff80258ed6>] system_call+0x7e/0x83
>
>(apparently waiting for kswapd0 to release iprune_mutex; this path
>does not seem to have any FS-related locking, but sys_madvise() has
>taken ->mm->mmap_sem for write.)
>
>Other linuxdcpp threads and several ps processes then were stuck
>waiting on its ->mm->mmap_sem taken by sys_madvise() above.
>
>So the deadlock seems to be between kswapd0 and mklocatedb.  Note that
>vfs_readdir() invoked by mklocatedb has taken i_mutex for the
>directory, and kswapd0 is waiting on some i_mutex...
>
>I suspect the following scenario:
>
> 1) kswapd0 runs shrink_icache_memory() (and prune_icache(), which
>    apparently was inlined there); prune_icache() notices that some
>    attribute inode (probably the index bitmap) for the directory is
>    unused, marks that attribute inode with I_FREEING and subsequently
>    invokes dispose_list() to free marked inodes.
>
> 2) mklocatedb invokes sys_readdir() on the directory, which grabs
>    i_mutex of the directory and proceeds to call the filesystem
>    readdir method - ntfs_readdir(), which then finds that it needs
>    the bitmap inode and invokes ntfs_attr_iget() to find it.
>    ntfs_attr_iget() proceeds down to find_inode(), which notices that
>    the inode has I_FREEING set and goes to __wait_on_freeing_inode().
>
> 3) kswapd0 proceeds to call clear_inode() on the attribute inode.
>    ntfs_clear_big_inode() calls iput(VFS_I(ni->ext.base_ntfs_ino)) to
>    put the base inode (the directory).
>
> 4) iput() calls ntfs_put_inode() for the directory.  At this point
>    the directory by chance has exactly two references accounted for
>    in ->i_count - one from the file descriptor open by mklocatedb,
>    another from the attribute inode (which that iput() is dropping
>    now), so ntfs_put_inode() goes to the path which releases
>    ni->itype.index.bmp_ino - but it needs to grab ->i_mutex for the
>    directory, and that mutex is held by mklocatedb.
>
> 5) Now kswapd0 is waiting for mklocatedb to release ->i_mutex for the
>    directory, and mklocatedb is waiting for kswapd0 to finish freeing
>    of the attribute inode - deadlock.
>
>Seems that grabbing i_mutex in ntfs_put_inode() is not safe after all
>(and lockdep cannot see this deadlock possibility, because one of
>waits is __wait_on_freeing_inode - not a standard locking primitive).
>
>  
>

