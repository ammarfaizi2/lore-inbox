Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030557AbWJKQHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030557AbWJKQHp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030583AbWJKQHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:07:45 -0400
Received: from dingu.igconcepts.com ([208.23.225.7]:49055 "EHLO
	dingu.igconcepts.com") by vger.kernel.org with ESMTP
	id S1030557AbWJKQHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:07:44 -0400
Date: Wed, 11 Oct 2006 11:07:40 -0500
From: Michael Harris <googlegroups@mgharris.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18: Kernel BUG at mm/rmap.c:522
Message-ID: <20061011160740.GA6868@dingu.igconcepts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, I can readily reproduce this with 2.6.18 doing 4 simultanous kernel compiles on two disks to load test a P4 3.2 HT with 2GB. I have SMP and SMT scheduling enabled, and the 4GB memory option. Here is output with CONFIG_DEBUG_VM enabled followed by another crash before CONFIG_DEBUG_VM was enabled.

[*ROOT* hen /usr/src/linux-2.6.18 14 ] uname -a
Linux hen.igconcepts.com 2.6.18 #2 SMP Tue Oct 10 11:46:01 CDT 2006 i686 i686 i386 GNU/Linux
[*ROOT* hen /usr/src/linux-2.6.18 15 ] gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/3.2.2/specs
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --enable-threads=posix --disable-checking --with-system-zlib --enable-__cxa_atexit --host=i386-redhat-linux
Thread model: posix
gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)


----------------
Oct 11 04:53:35 hen kernel: VM: killing process cc1
Oct 11 04:53:35 hen kernel: swap_free: Unused swap offset entry 00004000
Oct 11 04:53:35 hen kernel: Eeek! page_mapcount(page) went negative! (-1)
Oct 11 04:53:35 hen kernel:   page->flags = c0080014
Oct 11 04:53:35 hen kernel:   page->count = 0
Oct 11 04:53:35 hen kernel:   page->mapping = 00000000
Oct 11 04:53:35 hen kernel: ------------[ cut here ]------------
Oct 11 04:53:35 hen kernel: kernel BUG at mm/rmap.c:522!
Oct 11 04:53:35 hen kernel: invalid opcode: 0000 [#1]
Oct 11 04:53:35 hen kernel: SMP DEBUG_PAGEALLOC
Oct 11 04:53:35 hen kernel: CPU:    1
Oct 11 04:53:35 hen kernel: EIP:    0060:[<c01494c2>]    Not tainted VLI
Oct 11 04:53:35 hen kernel: EFLAGS: 00210286   (2.6.18 #2)
Oct 11 04:53:35 hen kernel: EIP is at page_remove_rmap+0x44/0xb9
Oct 11 04:53:35 hen kernel: eax: ffffffff   ebx: c1b5cd80   ecx: ffffffff   edx: 00200046
Oct 11 04:53:35 hen kernel: esi: 403fc000   edi: c1b5cd80   ebp: c20108a0   esp: d85e1ea8
Oct 11 04:53:35 hen kernel: ds: 007b   es: 007b   ss: 0068
Oct 11 04:53:35 hen kernel: Process cc1 (pid: 23624, ti=d85e0000 task=e817c030 task.ti=d85e0000)
Oct 11 04:53:35 hen kernel: Stack: c0390116 00000000 d80adff0 c0143249 5ae6c067 c13015ac ffffff14 ffffffff
Oct 11 04:53:35 hen kernel:        eceade40 f3c50b00 40400000 d8929400 40400000 40310000 c014347e 40310000
Oct 11 04:53:35 hen kernel:        40400000 d85e1f3c 00000000 4046ffff d8929400 d8929400 f3c50b00 c20108a0
Oct 11 04:53:35 hen kernel: Call Trace:
Oct 11 04:53:35 hen kernel:  [<c0143249>] zap_pte_range+0x15b/0x273
Oct 11 04:53:35 hen kernel:  [<c014347e>] unmap_page_range+0x11d/0x13f
Oct 11 04:53:35 hen kernel:  [<c0143569>] unmap_vmas+0xc9/0x1bf
Oct 11 04:53:35 hen kernel:  [<c014797c>] exit_mmap+0x79/0xf3
Oct 11 04:53:35 hen kernel:  [<c0117d41>] mmput+0x33/0x91
Oct 11 04:53:35 hen kernel:  [<c011c9e8>] do_exit+0x110/0x3c8
Oct 11 04:53:35 hen kernel:  [<c0111a65>] do_page_fault+0x13b/0x54c
Oct 11 04:53:35 hen kernel:  [<c0147626>] do_munmap+0xea/0x113
Oct 11 04:53:35 hen kernel:  [<c011cd47>] do_group_exit+0x87/0xa7
Oct 11 04:53:35 hen kernel:  [<c0102ca7>] syscall_call+0x7/0xb
Oct 11 04:53:35 hen kernel: Code: 94 00 00 00 8b 43 08 83 c0 01 78 29 8b 43 08 83 c0 01 78 17 31 d2 89 d8 f6 43 10 01 0f 94 c2 8b 5c 24 08 83 c4 0c e9 92 7b ff ff <0f> 0b 0a 02 d4 00 39 c0 eb df 8b 43 08 c7 04 24 e0 0c 39 c0 83
Oct 11 04:53:35 hen kernel: EIP: [<c01494c2>] page_remove_rmap+0x44/0xb9 SS:ESP 0068:d85e1ea8
Oct 11 04:53:35 hen kernel:  <1>Fixing recursive fault but reboot is needed!
Oct 11 04:54:31 hen kernel: Bad page state in process 'tripwire'
Oct 11 04:54:31 hen kernel: page:c1b5cd80 flags:0xc0000014 mapping:00000000 mapcount:-1 count:0
Oct 11 04:54:31 hen kernel: Trying to fix it up, but a reboot is needed
Oct 11 04:54:31 hen kernel: Backtrace:
Oct 11 04:54:31 hen kernel:  [<c013afe4>] bad_page+0x60/0x8f
Oct 11 04:54:31 hen kernel:  [<c013b5bd>] prep_new_page+0x197/0x1a4
Oct 11 04:54:31 hen kernel:  [<c013bb7a>] buffered_rmqueue+0xda/0x152
Oct 11 04:54:31 hen kernel:  [<c013bcfc>] get_page_from_freelist+0x6d/0x98
Oct 11 04:54:31 hen kernel:  [<c013bd71>] __alloc_pages+0x4a/0x2b0
Oct 11 04:54:31 hen kernel:  [<c03664bb>] __wait_on_bit_lock+0x41/0x5e
Oct 11 04:54:31 hen kernel:  [<c0136e2c>] sync_page+0x0/0x4c
Oct 11 04:54:31 hen kernel:  [<c013db15>] __do_page_cache_readahead+0x110/0x14f
Oct 11 04:54:31 hen kernel:  [<c0138861>] filemap_nopage+0x312/0x368
Oct 11 04:54:31 hen kernel:  [<c0144cb4>] do_no_page+0x6f/0x295
Oct 11 04:54:31 hen kernel:  [<c0145049>] __handle_mm_fault+0xec/0x1f9
Oct 11 04:54:31 hen kernel:  [<c0111a65>] do_page_fault+0x13b/0x54c
Oct 11 04:54:32 hen kernel:  [<c011192a>] do_page_fault+0x0/0x54c
Oct 11 04:54:32 hen kernel:  [<c010374d>] error_code+0x39/0x40

----------------
Another crash from a day earlier before enabling DEBUG_VM

Oct 10 05:19:43 hen kernel: VM: killing process cc1
Oct 10 05:19:43 hen kernel: swap_free: Unused swap offset entry 00002000
Oct 10 05:19:56 hen kernel: swap_free: Unused swap offset entry 00000400
Oct 10 05:20:13 hen kernel: ------------[ cut here ]------------
Oct 10 05:20:13 hen kernel: kernel BUG at mm/rmap.c:522!
Oct 10 05:20:13 hen kernel: invalid opcode: 0000 [#1]
Oct 10 05:20:13 hen kernel: SMP
Oct 10 05:20:13 hen kernel: CPU:    0
Oct 10 05:20:13 hen kernel: EIP:    0060:[<c0148ffc>]    Not tainted VLI
Oct 10 05:20:13 hen kernel: EFLAGS: 00210286   (2.6.18 #1)
Oct 10 05:20:13 hen kernel: EIP is at page_remove_rmap+0x2a/0x35
Oct 10 05:20:13 hen kernel: eax: ffffffff   ebx: d80df18c   ecx: c1ffc800   edx: 0007fe40
Oct 10 05:20:13 hen kernel: esi: 08063000   edi: c1ffc800   ebp: c200be20   esp: d8e35dd8
Oct 10 05:20:13 hen kernel: ds: 007b   es: 007b   ss: 0068
Oct 10 05:20:13 hen kernel: Process sh (pid: 23162, ti=d8e34000 task=db85a030 task.ti=d8e34000)
Oct 10 05:20:13 hen kernel: Stack: c0142f1d 7fe40025 c1301bec 00000000 ffffffe4 f264d200 f7a975c0 080dc000
Oct 10 05:20:13 hen kernel:        d8b33080 080dc000 08048000 c0143152 08048000 080dc000 d8e35e60 00000000
Oct 10 05:20:13 hen kernel:        080dbfff d8b33080 d8b33080 f7a975c0 c200be20 d8e35e84 f7a975c0 08048000
Oct 10 05:20:13 hen kernel: Call Trace:
Oct 10 05:20:13 hen kernel:  [<c0142f1d>] zap_pte_range+0x15b/0x273
Oct 10 05:20:13 hen kernel:  [<c0143152>] unmap_page_range+0x11d/0x13f
Oct 10 05:20:13 hen kernel:  [<c014323d>] unmap_vmas+0xc9/0x1bf
Oct 10 05:20:13 hen kernel:  [<c0147605>] exit_mmap+0x79/0xf3
Oct 10 05:20:13 hen kernel:  [<c0117c29>] mmput+0x33/0x91
Oct 10 05:20:13 hen kernel:  [<c011c8c8>] do_exit+0x110/0x3c8
Oct 10 05:20:13 hen kernel:  [<c011cc27>] do_group_exit+0x87/0xa7
Oct 10 05:20:13 hen kernel:  [<c0125e6f>] get_signal_to_deliver+0x200/0x2e5
Oct 10 05:20:13 hen kernel:  [<c0102a2f>] do_signal+0x6a/0x180
Oct 10 05:20:13 hen kernel:  [<c0124490>] signal_wake_up+0x28/0x36
Oct 10 05:20:13 hen kernel:  [<c012498b>] specific_send_sig_info+0xaa/0xc3
Oct 10 05:20:13 hen kernel:  [<c0124a15>] force_sig_info+0x71/0x8b
Oct 10 05:20:13 hen kernel:  [<c010471b>] do_general_protection+0xa7/0x188
Oct 10 05:20:13 hen kernel:  [<c0104674>] do_general_protection+0x0/0x188
Oct 10 05:20:13 hen kernel:  [<c0102b8a>] do_notify_resume+0x45/0x47
Oct 10 05:20:13 hen kernel:  [<c0102d32>] work_notifysig+0x13/0x19
Oct 10 05:20:13 hen kernel: Code: ff 89 c1 b8 ff ff ff ff f0 01 41 08 0f 98 c0 84 c0 74 22 8b 41 08 83 c0 01 78 10 31 d2 89 c8 f6 41 10 01 0f 94 c2 e9 34 7d ff ff <0f> 0b 0a 02 94 ff 38 c0 eb e6 c3 55 57 56 89 d6 53 89 cb 31 c9
Oct 10 05:20:13 hen kernel: EIP: [<c0148ffc>] page_remove_rmap+0x2a/0x35 SS:ESP 0068:d8e35dd8
Oct 10 05:20:13 hen kernel:  <1>Fixing recursive fault but reboot is needed!



