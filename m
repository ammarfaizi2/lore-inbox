Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbUC2PHL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 10:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbUC2PHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 10:07:10 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:8835
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262945AbUC2PGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 10:06:48 -0500
Date: Mon, 29 Mar 2004 17:06:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>
Subject: 2.6.5-rc2-aa5
Message-ID: <20040329150646.GA3808@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More fixes. Notably there is a BUG_ON(page->mapping) triggering in
page_remove_rmap in the pagecache case. that could be ex-pagecache being
removed from pagecache before all ptes have been zapped, infact the
page_remove_rmap triggers in the vmtruncate path.

I believe that is an harmless controlled race, that could happen in 2.4
too IIRC, so I turned the BUG_ON into a WARN_ON and I added a further
WARN_ON(page->mapcount) in remove_from_pagecache so that I will see two
WARN_ON instead of just one, and the first WARN_ON will be the new one.
This will give confirmation that it's not a deadly condition but just a
controlled race, and I will see the path that is generating this
controlled race to verify it's not a mistake.

Note that this was triggering even before the anon-vma patch was
applied, at the very least this triggers with just objrmap from Dave
applied, and probably it can trigger with mainline 2.6 too.

Comments from Andrew, Hugh, and others about this race are welcome
thanks.

this is the oops on top of my current code:

ar 29 09:40:47 linux kernel: ------------[ cut here ]------------
Mar 29 09:40:47 linux kernel: kernel BUG at mm/objrmap.c:354!
Mar 29 09:40:47 linux kernel: invalid operand: 0000 [#1]
Mar 29 09:40:47 linux kernel: CPU:    0
Mar 29 09:40:47 linux kernel: EIP:    0060:[page_remove_rmap+117/128]    Not tainted
Mar 29 09:40:47 linux kernel: EIP:    0060:[<c014a1e5>]    Not tainted
Mar 29 09:40:47 linux kernel: EFLAGS: 00010246   (2.6.4-32.4-default) 
Mar 29 09:40:47 linux kernel: EIP is at page_remove_rmap+0x75/0x80
Mar 29 09:40:47 linux kernel: eax: 00000000   ebx: cbcd24e0   ecx: 000013cd   edx: c1093640
Mar 29 09:40:47 linux kernel: esi: 00000000   edi: 00001000   ebp: c1093640   esp: c79d9d8c
Mar 29 09:40:47 linux kernel: ds: 007b   es: 007b   ss: 0068
Mar 29 09:40:47 linux kernel: Process ld-linux.so.2 (pid: 3751, threadinfo=c79d8000 task=c217f830)
Mar 29 09:40:47 linux kernel: Stack: c0145155 049b2025 40538000 c53a6400 40139000 40138000 c53a6400 40139000 
Mar 29 09:40:47 linux kernel:        c03f9b38 00001000 40139000 40139000 40139000 c014539b 40139000 00000000 
Mar 29 09:40:47 linux kernel:        c79d8000 00000001 00000001 ffffffff cbd12200 cc6a0780 c79d9e08 cbd12200 
Mar 29 09:40:47 linux kernel: Call Trace:
Mar 29 09:40:47 linux kernel:  [unmap_page_range+405/688] unmap_page_range+0x195/0x2b0
Mar 29 09:40:47 linux kernel:  [<c0145155>] unmap_page_range+0x195/0x2b0
Mar 29 09:40:47 linux kernel:  [unmap_vmas+299/640] unmap_vmas+0x12b/0x280
Mar 29 09:40:47 linux kernel:  [<c014539b>] unmap_vmas+0x12b/0x280
Mar 29 09:40:47 linux kernel:  [zap_page_range+116/192] zap_page_range+0x74/0xc0
Mar 29 09:40:47 linux kernel:  [<c0145564>] zap_page_range+0x74/0xc0
Mar 29 09:40:47 linux kernel:  [invalidate_mmap_range_list+162/176] invalidate_mmap_range_list+0xa2/0xb0
Mar 29 09:40:47 linux kernel:  [<c0145652>] invalidate_mmap_range_list+0xa2/0xb0
Mar 29 09:40:47 linux kernel:  [invalidate_mmap_range+144/160] invalidate_mmap_range+0x90/0xa0
Mar 29 09:40:47 linux kernel:  [<c01456f0>] invalidate_mmap_range+0x90/0xa0
Mar 29 09:40:47 linux kernel:  [vmtruncate+62/208] vmtruncate+0x3e/0xd0
Mar 29 09:40:47 linux kernel:  [<c014573e>] vmtruncate+0x3e/0xd0
Mar 29 09:40:47 linux kernel:  [__crc_unregister_framebuffer+5198340/6716426] linvfs_setattr+0x191/0x1a0 [xfs]
Mar 29 09:40:47 linux kernel:  [<cfa84841>] linvfs_setattr+0x191/0x1a0 [xfs]
Mar 29 09:40:47 linux kernel:  [notify_change+514/576] notify_change+0x202/0x240
Mar 29 09:40:47 linux kernel:  [<c016a172>] notify_change+0x202/0x240
Mar 29 09:40:47 linux kernel:  [do_truncate+78/128] do_truncate+0x4e/0x80
Mar 29 09:40:47 linux kernel:  [<c0151dde>] do_truncate+0x4e/0x80
Mar 29 09:40:47 linux kernel:  [sys_ftruncate+225/384] sys_ftruncate+0xe1/0x180
Mar 29 09:40:47 linux kernel:  [<c0152731>] sys_ftruncate+0xe1/0x180
Mar 29 09:40:47 linux kernel:  [generic_file_llseek+0/208] generic_file_llseek+0x0/0xd0
Mar 29 09:40:47 linux kernel:  [<c0152ed0>] generic_file_llseek+0x0/0xd0
Mar 29 09:40:47 linux kernel:  [sys_llseek+171/212] sys_llseek+0xab/0xd4
Mar 29 09:40:47 linux kernel:  [<c0153f5b>] sys_llseek+0xab/0xd4
Mar 29 09:40:47 linux kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Mar 29 09:40:47 linux kernel:  [<c0107e27>] syscall_call+0x7/0xb
Mar 29 09:40:47 linux kernel: 
Mar 29 09:40:47 linux kernel: Code: 0f 0b 62 01 1e 3b 30 c0 eb d8 90 55 57 56 53 89 c3 89 cd 8b 

This is the same oops but with a kernel before anon-vma was applied (so with
only the objrmap from Dave, and I think it would trigger with mainline 2.6
regardless of objrmap):

Mar 19 18:33:48 linux kernel: ------------[ cut here ]------------
Mar 19 18:33:48 linux kernel: kernel BUG at mm/rmap.c:393!
Mar 19 18:33:48 linux kernel: invalid operand: 0000 [#1]
Mar 19 18:33:48 linux kernel: CPU:    0
Mar 19 18:33:48 linux kernel: EIP:    0060:[page_remove_rmap+219/384]    Not tainted
Mar 19 18:33:48 linux kernel: EIP:    0060:[<c0148beb>]    Not tainted
Mar 19 18:33:48 linux kernel: EFLAGS: 00010246   (2.6.4-9.19-default) 
Mar 19 18:33:48 linux kernel: EIP is at page_remove_rmap+0xdb/0x180
Mar 19 18:33:48 linux kernel: eax: 00000000   ebx: 000004e0   ecx: 00000001  
edx: c1000000
Mar 19 18:33:48 linux kernel: esi: c115fce0   edi: 00000000   ebp: 0b3d54e0  
esp: c4e79d74
Mar 19 18:33:48 linux kernel: ds: 007b   es: 007b   ss: 0068
Mar 19 18:33:48 linux kernel: Process ld-linux.so.2 (pid: 2899,
threadinfo=c4e78000 task=c66fe780)
Mar 19 18:33:48 linux kernel: Stack: 00000e09 000001d0 c123a800 00000001
40138000 cb3d54e0 00000000 00001000 
Mar 19 18:33:48 linux kernel:        c0142e50 c115fce0 0afe7025 40538000
40139000 c97ac400 c97ac400 40139000 
Mar 19 18:33:48 linux kernel:        c03f5c18 00001000 40139000 40139000
40139000 c014304b 40139000 00000000 
Mar 19 18:33:48 linux kernel: Call Trace:
Mar 19 18:33:48 linux kernel:  [unmap_page_range+464/672]
unmap_page_range+0x1d0/0x2a0
Mar 19 18:33:48 linux kernel:  [<c0142e50>] unmap_page_range+0x1d0/0x2a0
Mar 19 18:33:48 linux kernel:  [unmap_vmas+299/640] unmap_vmas+0x12b/0x280
Mar 19 18:33:48 linux kernel:  [<c014304b>] unmap_vmas+0x12b/0x280
Mar 19 18:33:48 linux kernel:  [zap_page_range+116/192] zap_page_range+0x74/0xc0
Mar 19 18:33:48 linux kernel:  [<c0143214>] zap_page_range+0x74/0xc0
Mar 19 18:33:48 linux kernel:  [invalidate_mmap_range_list+162/176]
invalidate_mmap_range_list+0xa2/0xb0
Mar 19 18:33:48 linux kernel:  [<c0143302>] invalidate_mmap_range_list+0xa2/0xb0
Mar 19 18:33:48 linux kernel:  [invalidate_mmap_range+144/160]
invalidate_mmap_range+0x90/0xa0
Mar 19 18:33:48 linux kernel:  [<c01433a0>] invalidate_mmap_range+0x90/0xa0
Mar 19 18:33:48 linux kernel:  [vmtruncate+62/208] vmtruncate+0x3e/0xd0
Mar 19 18:33:48 linux kernel:  [<c01433ee>] vmtruncate+0x3e/0xd0
Mar 19 18:33:48 linux kernel:  [__crc_cap_capset_set+547932/2369266]
linvfs_setattr+0x191/0x1a0 [xfs]
Mar 19 18:33:48 linux kernel:  [<cfa3a7b1>] linvfs_setattr+0x191/0x1a0 [xfs]
Mar 19 18:33:48 linux kernel:  [notify_change+504/576] notify_change+0x1f8/0x240
Mar 19 18:33:48 linux kernel:  [<c0168708>] notify_change+0x1f8/0x240
Mar 19 18:33:48 linux kernel:  [do_truncate+54/80] do_truncate+0x36/0x50
Mar 19 18:33:48 linux kernel:  [<c0150436>] do_truncate+0x36/0x50
Mar 19 18:33:48 linux kernel:  [sys_fstat64+35/48] sys_fstat64+0x23/0x30
Mar 19 18:33:48 linux kernel:  [<c015a2d3>] sys_fstat64+0x23/0x30
Mar 19 18:33:48 linux kernel:  [sys_ftruncate+225/384] sys_ftruncate+0xe1/0x180
Mar 19 18:33:48 linux kernel:  [<c0150d71>] sys_ftruncate+0xe1/0x180
Mar 19 18:33:48 linux kernel:  [generic_file_llseek+0/208]
generic_file_llseek+0x0/0xd0
Mar 19 18:33:48 linux kernel:  [<c01514f0>] generic_file_llseek+0x0/0xd0
Mar 19 18:33:48 linux kernel:  [sys_llseek+171/212] sys_llseek+0xab/0xd4
Mar 19 18:33:48 linux kernel:  [<c015257b>] sys_llseek+0xab/0xd4
Mar 19 18:33:48 linux kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Mar 19 18:33:48 linux kernel:  [<c0106e27>] syscall_call+0x7/0xb
Mar 19 18:33:48 linux kernel: 
Mar 19 18:33:48 linux kernel: Code: 0f 0b 89 01 d7 f4 2f c0 3d 60 cb 33 c0 74 2d
85 c9 75 08 0f 
Mar 19 18:33:48 linux kernel:  <6>note: ld-linux.so.2[2899] exited with
preempt_count 1


the testcase is a:

	rpm -i glibc-2.3.2-92.src.rpm
	rpmbuild -ba /usr/src/packages/SPECS/glibc.spec

I will wait feedback after my WARN_ON addition, if my theory is right this new
tree will survive the load with just two WARN_ON triggers (one in vmtruncate
like the above, and the other new one in remove_from_page_cache).

Hugh, I didn't look into your nonlinear-more-graceful-swapout algorithm
yet, but my first prio at the moment is to get the nonlinaer in a I/O
bound manner, making it graceful is very low prio, especially if it
makes the code less obvious.

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc2-aa5.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc2-aa5/

Binary files 2.6.5-rc2-aa4/anon-vma.gz and 2.6.5-rc2-aa5/anon-vma.gz differ

	Add bugcheck for page->mapcount == 0 in alloc/free page paths
	(just in case).

	Convert BUG_ON to WARN_ON in page_remove_rmap and added a
	WARN_ON(page->mapcount) in remove_from_page_cache, to try
	to trap the case of pages being removed from pagecache while
	they still had some mapping.

	Fix ppc (patch was superflous apparently, so backed out, only
	ppc64 required fixing).

Binary files 2.6.5-rc2-aa4/prio-tree.gz and 2.6.5-rc2-aa5/prio-tree.gz differ

	Fixup nonlinear swapout from Rajesh Venkatasubramanian.

	Fixed a bugcheck after a split_vma of a MAP_PRIVATE with some anon page
	on it.
