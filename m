Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbUC3QLI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 11:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUC3QLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 11:11:08 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:61865
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263042AbUC3QK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 11:10:58 -0500
Date: Tue, 30 Mar 2004 18:10:56 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: mapped pages being truncated [was Re: 2.6.5-rc2-aa5]
Message-ID: <20040330161056.GZ3808@dualathlon.random>
References: <20040329150646.GA3808@dualathlon.random> <20040329124803.072bb7c6.akpm@osdl.org> <20040329224526.GL3808@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329224526.GL3808@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 12:45:26AM +0200, Andrea Arcangeli wrote:
> On Mon, Mar 29, 2004 at 12:48:03PM -0800, Andrew Morton wrote:
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > >
> > > Notably there is a BUG_ON(page->mapping) triggering in
> > > page_remove_rmap in the pagecache case. that could be ex-pagecache being
> > > removed from pagecache before all ptes have been zapped, infact the
> > > page_remove_rmap triggers in the vmtruncate path.
> > 
> > Confused.  vmtruncate zaps the ptes before removing pages from pagecache,
> > so I'd expect a non-null ->mapping in page_remove_rmap() is a very common
> 
> the bugcheck was for NULL ->mapping in page_remove_rmap:
> 
> 	BUG_ON(!page->mapping);
> 
> I tend to forget the ! in the pseudocode in emails sorry (today I did it
> twice, luckily I didn't get it wrong in the actual patches ;).
> 
> > thing.  truncate a file which someone has mmapped and it'll happen every
> > time, will it not?
> 
> as you say vmtruncate zaps the pte _first_, so the page->mapcount should
> be down to 0 by the time we set page->mapping = NULL. 
> 
> the thing I was wondering about is the controlled race where some page
> can go out of pagecache despite still being mapped somewhere, that could
> happen in the past IIRC.

here we go, my new debugging WARN_ON in in __remove_from_page_cache
triggered just before the other one in page_remove_rmap, as I expected
it was truncate removing pages from pagecache before all mappings were
dropped:

Mar 30 01:27:56 linux -- MARK --
Mar 30 01:37:18 linux kernel: Badness in __remove_from_page_cache at mm/filemap.c:107
Mar 30 01:37:18 linux kernel: Call Trace:
Mar 30 01:37:18 linux kernel:  [__remove_from_page_cache+138/160] __remove_from_page_cache+0x8a/0xa0
Mar 30 01:37:18 linux kernel:  [<c013bc4a>] __remove_from_page_cache+0x8a/0xa0
Mar 30 01:37:18 linux kernel:  [remove_from_page_cache+27/39] remove_from_page_cache+0x1b/0x27
Mar 30 01:37:18 linux kernel:  [<c013bc7b>] remove_from_page_cache+0x1b/0x27
Mar 30 01:37:18 linux kernel:  [truncate_complete_page+45/192] truncate_complete_page+0x2d/0xc0
Mar 30 01:37:18 linux kernel:  [<c0141d6d>] truncate_complete_page+0x2d/0xc0
Mar 30 01:37:18 linux kernel:  [truncate_inode_pages+163/768] truncate_inode_pages+0xa3/0x300
Mar 30 01:37:18 linux kernel:  [<c0141ea3>] truncate_inode_pages+0xa3/0x300
Mar 30 01:37:18 linux kernel:  [__crc_tty_wait_until_sent+6263840/8120074] xfs_bmap_last_offset+0xed/0x100 [xfs]
Mar 30 01:37:18 linux kernel:  [<cfa31f5d>] xfs_bmap_last_offset+0xed/0x100 [xfs]
Mar 30 01:37:18 linux kernel:  [__crc_tty_wait_until_sent+6459933/8120074] xfs_itruncate_start+0x6a/0x90 [xfs]
Mar 30 01:37:18 linux kernel:  [<cfa61d5a>] xfs_itruncate_start+0x6a/0x90 [xfs]
Mar 30 01:37:18 linux kernel:  [__crc_tty_wait_until_sent+6571075/8120074] xfs_setattr+0xc30/0xe40 [xfs]
Mar 30 01:37:18 linux kernel:  [<cfa7cf80>] xfs_setattr+0xc30/0xe40 [xfs]
Mar 30 01:37:18 linux kernel:  [__crc_tty_wait_until_sent+6601861/8120074] linvfs_setattr+0x112/0x1a0 [xfs]
Mar 30 01:37:18 linux kernel:  [<cfa847c2>] linvfs_setattr+0x112/0x1a0 [xfs]
Mar 30 01:37:18 linux kernel:  [notify_change+514/576] notify_change+0x202/0x240
Mar 30 01:37:18 linux kernel:  [<c016b4d2>] notify_change+0x202/0x240
Mar 30 01:37:18 linux kernel:  [do_truncate+78/128] do_truncate+0x4e/0x80
Mar 30 01:37:18 linux kernel:  [<c01530de>] do_truncate+0x4e/0x80
Mar 30 01:37:18 linux kernel:  [sys_ftruncate+225/384] sys_ftruncate+0xe1/0x180
Mar 30 01:37:18 linux kernel:  [<c0153a31>] sys_ftruncate+0xe1/0x180
Mar 30 01:37:18 linux kernel:  [generic_file_llseek+0/208] generic_file_llseek+0x0/0xd0
Mar 30 01:37:18 linux kernel:  [<c01541d0>] generic_file_llseek+0x0/0xd0
Mar 30 01:37:18 linux kernel:  [sys_llseek+171/212] sys_llseek+0xab/0xd4
Mar 30 01:37:18 linux kernel:  [<c015525b>] sys_llseek+0xab/0xd4
Mar 30 01:37:18 linux kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Mar 30 01:37:18 linux kernel:  [<c0107e27>] syscall_call+0x7/0xb
Mar 30 01:37:18 linux kernel: 
Mar 30 01:37:18 linux kernel: Badness in page_remove_rmap at mm/objrmap.c:379
Mar 30 01:37:18 linux kernel: Call Trace:
Mar 30 01:37:18 linux kernel:  [page_remove_rmap+137/152] page_remove_rmap+0x89/0x98
Mar 30 01:37:18 linux kernel:  [<c014bdb9>] page_remove_rmap+0x89/0x98
Mar 30 01:37:18 linux kernel:  [unmap_page_range+405/688] unmap_page_range+0x195/0x2b0
Mar 30 01:37:18 linux kernel:  [<c0145f55>] unmap_page_range+0x195/0x2b0
Mar 30 01:37:18 linux kernel:  [unmap_vmas+299/640] unmap_vmas+0x12b/0x280
Mar 30 01:37:18 linux kernel:  [<c014619b>] unmap_vmas+0x12b/0x280
Mar 30 01:37:18 linux kernel:  [zap_page_range+116/192] zap_page_range+0x74/0xc0
Mar 30 01:37:18 linux kernel:  [<c0146364>] zap_page_range+0x74/0xc0
Mar 30 01:37:18 linux kernel:  [invalidate_mmap_range_list+163/208] invalidate_mmap_range_list+0xa3/0xd0
Mar 30 01:37:18 linux kernel:  [<c0146453>] invalidate_mmap_range_list+0xa3/0xd0
Mar 30 01:37:18 linux kernel:  [invalidate_mmap_range+148/176] invalidate_mmap_range+0x94/0xb0
Mar 30 01:37:18 linux kernel:  [<c0146514>] invalidate_mmap_range+0x94/0xb0
Mar 30 01:37:18 linux kernel:  [vmtruncate+62/208] vmtruncate+0x3e/0xd0
Mar 30 01:37:18 linux kernel:  [<c014656e>] vmtruncate+0x3e/0xd0
Mar 30 01:37:18 linux kernel:  [__crc_tty_wait_until_sent+6601988/8120074] linvfs_setattr+0x191/0x1a0 [xfs]
Mar 30 01:37:18 linux kernel:  [<cfa84841>] linvfs_setattr+0x191/0x1a0 [xfs]
Mar 30 01:37:18 linux kernel:  [notify_change+514/576] notify_change+0x202/0x240
Mar 30 01:37:18 linux kernel:  [<c016b4d2>] notify_change+0x202/0x240
Mar 30 01:37:18 linux kernel:  [do_truncate+78/128] do_truncate+0x4e/0x80
Mar 30 01:37:18 linux kernel:  [<c01530de>] do_truncate+0x4e/0x80
Mar 30 01:37:18 linux kernel:  [sys_ftruncate+225/384] sys_ftruncate+0xe1/0x180
Mar 30 01:37:18 linux kernel:  [<c0153a31>] sys_ftruncate+0xe1/0x180
Mar 30 01:37:18 linux kernel:  [generic_file_llseek+0/208] generic_file_llseek+0x0/0xd0
Mar 30 01:37:18 linux kernel:  [<c01541d0>] generic_file_llseek+0x0/0xd0
Mar 30 01:37:18 linux kernel:  [sys_llseek+171/212] sys_llseek+0xab/0xd4
Mar 30 01:37:18 linux kernel:  [<c015525b>] sys_llseek+0xab/0xd4
Mar 30 01:37:18 linux kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Mar 30 01:37:18 linux kernel:  [<c0107e27>] syscall_call+0x7/0xb
Mar 30 01:37:18 linux kernel: 

I didn't focused too much on the mremap race yet (that's the primary
reason why I asked Hugh to extract the fix, so I can focus on the fix
without being distracted by the handle_mm_fault and other stuff for
early-cow in mremap that anonmm requires), but are you sure mremap
will lead to removing pages from pagecache with mapping still intact?
(we're not talking about random ptes and random reference counts in
page->count here, we're talking about ptes being actively tracked by
objrmap and pages going away from pagecache! Infact in my tree mremap
never calls page_remove_rmap or page_add_rmap ever, there's no need of
doing so with anon-vma+objrmap in mremap since anon-vma+objrmap is
by design mremap-aware, I dropped both of them).

the funny thing is that it seems to be the same truncate doing
truncate_inode_pages first, and zap_page_range later. It would be better
if WARN_ON would show the pid of the task too, if they were two
different tasks that would be more realistic. Maybe an xfs screwup of
some sort? I could ask the tester to try again with ext2, but then if it
doesn't trigger anymore we still have to wonder about timings.

Anyways now the kernel is solid, it just bugs out those warnings so we
don't forget. I don't think it's a bug in my tree.

Comments welcome.
