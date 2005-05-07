Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVEGBQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVEGBQq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 21:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVEGBQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 21:16:46 -0400
Received: from [192.171.113.101] ([192.171.113.101]:42370 "EHLO
	fir.nerdvana.com") by vger.kernel.org with ESMTP id S261443AbVEGBNx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 21:13:53 -0400
Subject: PROBLEM: Reiserfs stall 2.6.10-bk7 up through 2.6.12-rc3
From: George Ronkin <gronkin@nerdvana.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 06 May 2005 18:13:25 -0700
Message-Id: <1115428405.2233.65.camel@fir.nerdvana.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	As soon as its exim MTA attempts to deliver the first newly received
message to a cyrus IMAP server via lmtpd, one of my machines now stalls
attempting to access the reiserfs file system used as that server's
spool.  That process consumes all available CPU, maxes out the I/O block
and transaction rates to that disk, and generates a flood of interrupts
to the corresponding IRQ.  The process is not killable, and other
processes needing access to that file system block unkillably as well.
	This problem did not occur before 2.6.10-bk7.  That and all subsequent
kernels I've tried (Debian 2.6.11, stock 2.6.12-rc3, and 2.6.12-rc3-mm3)
cause the problem, consistently and repeatably.  2.6.10-bk6 and prior
kernels, consistently and repeatably, do not display any such problem.
I've also tried turning off CONFIG_PREEMPT, and in a separate
experiment, using a gcc 3.3.5 instead of the 2.95.4 I normally use.
Neither had any effect.  Nor did turning "lapic" on at boot.
	What did have an effect was reverting a reiserfs related changeset as
suggested by Chris Wright on Jan. 5
(http://marc.theaimsgroup.com/?l=linux-kernel&m=110495326131769&w=2).
2.6.10-bk7 had previously displayed this problem, but with this patch
reverted, worked as did 2.6.10-bk6 and prior kernels.
	I'm appending information from 2.6.12-rc3: stack traces, lspci,
interrupts (note IRQ 10, which is normally comparable to ide0/IRQ 14),
mounts and mappings (taken from a normally running 2.6.10 boot - these
are the same for all kernels tried), config, boot log, and the head of
that patch (which doesn't revert cleanly in newer kernels) for
identification.  (Warning - unwrapped long lines!)
	Please let me know if you want more info or want me to try patches.
	Thanks,
-- 
George Ronkin <gronkin@nerdvana.com>

------------------------------ 2.6.12-rc3 ------------------------------

May  4 12:03:52 fir kernel: /0xe0
May  4 12:03:52 fir kernel:  [sys_accept+209/384] sys_accept+0xd1/0x180
May  4 12:03:52 fir kernel:  [destroy_inode+73/112] destroy_inode+0x49/0x70
May  4 12:03:52 fir kernel:  [generic_forget_inode+302/320] generic_forget_inode+0x12e/0x140
May  4 12:03:52 fir kernel:  [generic_drop_inode+26/32] generic_drop_inode+0x1a/0x20
May  4 12:03:52 fir kernel:  [dput+28/560] dput+0x1c/0x230
May  4 12:03:52 fir kernel:  [copy_to_user+59/80] copy_to_user+0x3b/0x50
May  4 12:03:52 fir kernel:  [copy_from_user+65/112] copy_from_user+0x41/0x70
May  4 12:03:52 fir kernel:  [sys_socketcall+179/512] sys_socketcall+0xb3/0x200
May  4 12:03:52 fir kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  4 12:03:52 fir kernel: apache        S 7FFFFFFF     0  1776   1750          1777  1775 (NOTLB)
May  4 12:03:52 fir kernel: f5947e48 00000086 f58f1c00 7fffffff f5947eb4 c0138658 ffff1000 396159d0 
May  4 12:03:52 fir kernel:        0000001d c1709120 00000003 f5947e40 00000000 00014394 39666822 0000001d 
May  4 12:03:52 fir kernel:        c042a034 f6923020 f6923158 396159d0 0000001d 7fffffff c02fc7a4 f58f1c00 
May  4 12:03:52 fir kernel: Call Trace:
May  4 12:03:52 fir kernel:  [buffered_rmqueue+424/480] buffered_rmqueue+0x1a8/0x1e0
May  4 12:03:52 fir kernel:  [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
May  4 12:03:52 fir kernel:  [local_bh_enable+98/128] local_bh_enable+0x62/0x80
May  4 12:03:52 fir kernel:  [release_sock+122/128] release_sock+0x7a/0x80
May  4 12:03:52 fir kernel:  [wait_for_connect+167/224] wait_for_connect+0xa7/0xe0
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [tcp_accept+71/208] tcp_accept+0x47/0xd0
May  4 12:03:52 fir kernel:  [inet_accept+46/224] inet_accept+0x2e/0xe0
May  4 12:03:52 fir kernel:  [sys_accept+209/384] sys_accept+0xd1/0x180
May  4 12:03:52 fir kernel:  [do_page_fault+0/1323] do_page_fault+0x0/0x52b
May  4 12:03:52 fir kernel:  [gcc2_compiled.+42/112] _atomic_dec_and_lock+0x2a/0x70
May  4 12:03:52 fir kernel:  [dput+28/560] dput+0x1c/0x230
May  4 12:03:52 fir kernel:  [copy_to_user+59/80] copy_to_user+0x3b/0x50
May  4 12:03:52 fir kernel:  [copy_from_user+65/112] copy_from_user+0x41/0x70
May  4 12:03:52 fir kernel:  [sys_socketcall+179/512] sys_socketcall+0xb3/0x200
May  4 12:03:52 fir kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  4 12:03:52 fir kernel: apache        S 7FFFFFFF     0  1777   1750          1909  1776 (NOTLB)
May  4 12:03:52 fir kernel: f6a65e48 00000086 f58f1c00 7fffffff f6a65eb4 c0291b19 f59a6e28 39690817 
May  4 12:03:52 fir kernel:        0000001d c18d7560 00000001 f6a65e40 00000000 0001983f 396dd0d4 0000001d 
May  4 12:03:52 fir kernel:        c042a4ac f58ee020 f58ee158 39690817 0000001d 7fffffff c02fc7a4 f58f1c00 
May  4 12:03:52 fir kernel: Call Trace:
May  4 12:03:52 fir kernel:  [init_once+25/32] init_once+0x19/0x20
May  4 12:03:52 fir kernel:  [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
May  4 12:03:52 fir kernel:  [local_bh_enable+98/128] local_bh_enable+0x62/0x80
May  4 12:03:52 fir kernel:  [release_sock+122/128] release_sock+0x7a/0x80
May  4 12:03:52 fir kernel:  [wait_for_connect+167/224] wait_for_connect+0xa7/0xe0
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [tcp_accept+71/208] tcp_accept+0x47/0xd0
May  4 12:03:52 fir kernel:  [inet_accept+46/224] inet_accept+0x2e/0xe0
May  4 12:03:52 fir kernel:  [sys_accept+209/384] sys_accept+0xd1/0x180
May  4 12:03:52 fir kernel:  [do_page_fault+0/1323] do_page_fault+0x0/0x52b
May  4 12:03:52 fir kernel:  [gcc2_compiled.+42/112] _atomic_dec_and_lock+0x2a/0x70
May  4 12:03:52 fir kernel:  [dput+28/560] dput+0x1c/0x230
May  4 12:03:52 fir kernel:  [copy_to_user+59/80] copy_to_user+0x3b/0x50
May  4 12:03:52 fir kernel:  [copy_from_user+65/112] copy_from_user+0x41/0x70
May  4 12:03:52 fir kernel:  [sys_socketcall+179/512] sys_socketcall+0xb3/0x200
May  4 12:03:52 fir kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  4 12:03:52 fir kernel: exim          S F46B7EF8     0  1864      1  1865    1878  1762 (NOTLB)
May  4 12:03:52 fir kernel: f46b7ecc 00000082 f59d35c0 f46b7ef8 f46b7f0c f46b6000 00000031 fb75f428 
May  4 12:03:52 fir kernel:        00000024 00000000 f3b3b6a4 f46b7ec4 00000000 000017a0 fb7681ed 00000024 
May  4 12:03:52 fir kernel:        c042a034 f41faaa0 f41fabd8 fb75f428 00000024 f46b7ef8 c015c6ac f6ba8e00 
May  4 12:03:52 fir kernel: Call Trace:
May  4 12:03:52 fir kernel:  [pipe_wait+108/144] pipe_wait+0x6c/0x90
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [pipe_readv+616/752] pipe_readv+0x268/0x2f0
May  4 12:03:52 fir kernel:  [pipe_read+41/48] pipe_read+0x29/0x30
May  4 12:03:52 fir kernel:  [vfs_read+173/272] vfs_read+0xad/0x110
May  4 12:03:52 fir kernel:  [sys_read+64/112] sys_read+0x40/0x70
May  4 12:03:52 fir kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  4 12:03:52 fir kernel: exim          S F36B4000     0  1865   1864  1866               (NOTLB)
May  4 12:03:52 fir kernel: f36b5f40 00000082 fffffe00 f36b4000 00000000 f421aa00 00000001 fb77c2fc 
May  4 12:03:52 fir kernel:        00000024 f59d3704 c015d0c8 f36b5f38 0000001d 00007c2f fb79b3ba 00000024 
May  4 12:03:52 fir kernel:        c01180ae f41fa040 f41fa178 fb77c2fc 00000024 f36b4000 c0118c37 0000074a 
May  4 12:03:52 fir kernel: Call Trace:
May  4 12:03:52 fir kernel:  [pipe_release+152/176] pipe_release+0x98/0xb0
May  4 12:03:52 fir kernel:  [eligible_child+206/240] eligible_child+0xce/0xf0
May  4 12:03:52 fir kernel:  [do_wait+695/880] do_wait+0x2b7/0x370
May  4 12:03:52 fir kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May  4 12:03:52 fir kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May  4 12:03:52 fir kernel:  [sys_wait4+38/64] sys_wait4+0x26/0x40
May  4 12:03:52 fir kernel:  [sys_waitpid+22/26] sys_waitpid+0x16/0x1a
May  4 12:03:52 fir kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  4 12:03:52 fir kernel: cyrdeliver    S 7FFFFFFF     0  1866   1865          1867       (NOTLB)
May  4 12:03:52 fir kernel: f36c7d90 00000082 f36c6000 7fffffff f36c7de8 f7903e00 f7c74cbc 0a391f6a 
May  4 12:03:52 fir kernel:        00000025 f78da55c f7903e00 f36c7d88 00000000 00000056 0a3922cc 00000025 
May  4 12:03:52 fir kernel:        c042a4ac f3b59a80 f3b59bb8 0a391f6a 00000025 f6995260 c02fc7a4 f36c6000 
May  4 12:03:52 fir kernel: Call Trace:
May  4 12:03:52 fir kernel:  [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
May  4 12:03:52 fir kernel:  [prepare_to_wait+92/128] prepare_to_wait+0x5c/0x80
May  4 12:03:52 fir kernel:  [unix_stream_data_wait+137/288] unix_stream_data_wait+0x89/0x120
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [unix_stream_recvmsg+407/976] unix_stream_recvmsg+0x197/0x3d0
May  4 12:03:52 fir kernel:  [sock_aio_read+283/304] sock_aio_read+0x11b/0x130
May  4 12:03:52 fir kernel:  [kmap_atomic+33/96] kmap_atomic+0x21/0x60
May  4 12:03:52 fir kernel:  [do_sync_read+180/240] do_sync_read+0xb4/0xf0
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [vfs_read+189/272] vfs_read+0xbd/0x110
May  4 12:03:52 fir kernel:  [sys_read+64/112] sys_read+0x40/0x70
May  4 12:03:52 fir kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  4 12:03:52 fir kernel: exim          S F36D9EF8     0  1867   1865                1866 (NOTLB)
May  4 12:03:52 fir kernel: f36d9ecc 00000082 f59d3ad0 f36d9ef8 f36d9f0c 00000202 c0147641 fb768c23 
May  4 12:03:52 fir kernel:        00000024 c1674ba0 c0142194 f36d9ec4 00000000 00004db6 fb77c2fc 00000024 
May  4 12:03:52 fir kernel:        c042a034 f3b59550 f3b59688 fb768c23 00000024 f36d9ef8 c015c6ac f421ac00 
May  4 12:03:52 fir kernel: Call Trace:
May  4 12:03:52 fir kernel:  [page_add_anon_rmap+97/112] page_add_anon_rmap+0x61/0x70
May  4 12:03:52 fir kernel:  [do_wp_page+676/752] do_wp_page+0x2a4/0x2f0
May  4 12:03:52 fir kernel:  [pipe_wait+108/144] pipe_wait+0x6c/0x90
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [pipe_readv+616/752] pipe_readv+0x268/0x2f0
May  4 12:03:52 fir kernel:  [pipe_read+41/48] pipe_read+0x29/0x30
May  4 12:03:52 fir kernel:  [vfs_read+173/272] vfs_read+0xad/0x110
May  4 12:03:52 fir kernel:  [sys_read+64/112] sys_read+0x40/0x70
May  4 12:03:52 fir kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  4 12:03:52 fir kernel: lmtpd         D C1803088     0  1868   1282          1881  1410 (NOTLB)
May  4 12:03:52 fir kernel: f374bccc 00000082 f374bd30 c1803088 00000000 c1bc65a0 ffffffff a907b826 
May  4 12:03:52 fir kernel:        0000009e c1bc802c 00000002 f374bcc4 f79f01e0 0000112b a9083059 0000009e 
May  4 12:03:52 fir kernel:        f89b48d6 f3b59020 f3b59158 a907b826 0000009e f374bcd4 c02fc74e 00000002 
May  4 12:03:52 fir kernel: Call Trace:
May  4 12:03:52 fir kernel:  [pg0+945154262/1069188096] dm_unplug_all+0x26/0x30 [dm_mod]
May  4 12:03:52 fir kernel:  [io_schedule+14/32] io_schedule+0xe/0x20
May  4 12:03:52 fir kernel:  [sync_buffer+51/64] sync_buffer+0x33/0x40
May  4 12:03:52 fir kernel:  [__wait_on_bit+83/128] __wait_on_bit+0x53/0x80
May  4 12:03:52 fir kernel:  [sync_buffer+0/64] sync_buffer+0x0/0x40
May  4 12:03:52 fir kernel:  [sync_buffer+0/64] sync_buffer+0x0/0x40
May  4 12:03:52 fir kernel:  [out_of_line_wait_on_bit+105/128] out_of_line_wait_on_bit+0x69/0x80
May  4 12:03:52 fir kernel:  [wake_bit_function+0/64] wake_bit_function+0x0/0x40
May  4 12:03:52 fir kernel:  [wake_bit_function+0/64] wake_bit_function+0x0/0x40
May  4 12:03:52 fir kernel:  [__wait_on_buffer+30/48] __wait_on_buffer+0x1e/0x30
May  4 12:03:52 fir kernel:  [sync_dirty_buffer+125/192] sync_dirty_buffer+0x7d/0xc0
May  4 12:03:52 fir kernel:  [flush_commit_list+712/1040] flush_commit_list+0x2c8/0x410
May  4 12:03:52 fir kernel:  [get_list_bitmap+108/160] get_list_bitmap+0x6c/0xa0
May  4 12:03:52 fir kernel:  [do_journal_end+2202/2432] do_journal_end+0x89a/0x980
May  4 12:03:52 fir kernel:  [do_journal_begin_r+523/672] do_journal_begin_r+0x20b/0x2a0
May  4 12:03:52 fir kernel:  [journal_begin+143/224] journal_begin+0x8f/0xe0
May  4 12:03:52 fir kernel:  [reiserfs_create+150/496] reiserfs_create+0x96/0x1f0
May  4 12:03:52 fir kernel:  [permission+160/176] permission+0xa0/0xb0
May  4 12:03:52 fir kernel:  [vfs_create+225/304] vfs_create+0xe1/0x130
May  4 12:03:52 fir kernel:  [open_namei+362/1472] open_namei+0x16a/0x5c0
May  4 12:03:52 fir kernel:  [filp_open+59/96] filp_open+0x3b/0x60
May  4 12:03:52 fir kernel:  [get_unused_fd+85/208] get_unused_fd+0x55/0xd0
May  4 12:03:52 fir kernel:  [sys_open+55/128] sys_open+0x37/0x80
May  4 12:03:52 fir kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  4 12:03:52 fir kernel: exim          S F2425EF8     0  1878      1  1879    1912  1864 (NOTLB)
May  4 12:03:52 fir kernel: f2425ecc 00000086 f244092c f2425ef8 f2425f0c f2424000 00000040 44a806a0 
May  4 12:03:52 fir kernel:        00000031 00000000 f2bbf43c f2425ec4 ffffffff 000014ce 44a88375 00000031 
May  4 12:03:52 fir kernel:        c042a4ac f2b5b020 f2b5b158 44a806a0 00000031 f2425ef8 c015c6ac f421a600 
May  4 12:03:52 fir kernel: Call Trace:
May  4 12:03:52 fir kernel:  [pipe_wait+108/144] pipe_wait+0x6c/0x90
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [pipe_readv+616/752] pipe_readv+0x268/0x2f0
May  4 12:03:52 fir kernel:  [pipe_read+41/48] pipe_read+0x29/0x30
May  4 12:03:52 fir kernel:  [vfs_read+173/272] vfs_read+0xad/0x110
May  4 12:03:52 fir kernel:  [sys_read+64/112] sys_read+0x40/0x70
May  4 12:03:52 fir kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  4 12:03:52 fir kernel: exim          S F24C6000     0  1879   1878  1880               (NOTLB)
May  4 12:03:52 fir kernel: f24c7f40 00000086 fffffe00 f24c6000 00000000 f421ae00 00000001 44a50881 
May  4 12:03:52 fir kernel:        00000031 f24407e8 c015d0c8 f24c7f38 00000000 0000bf87 44a806a0 00000031 
May  4 12:03:52 fir kernel:        c042a4ac f2b5b550 f2b5b688 44a50881 00000031 f24c6000 c0118c37 00000758 
May  4 12:03:52 fir kernel: Call Trace:
May  4 12:03:52 fir kernel:  [pipe_release+152/176] pipe_release+0x98/0xb0
May  4 12:03:52 fir kernel:  [do_wait+695/880] do_wait+0x2b7/0x370
May  4 12:03:52 fir kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May  4 12:03:52 fir kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May  4 12:03:52 fir kernel:  [sys_wait4+38/64] sys_wait4+0x26/0x40
May  4 12:03:52 fir kernel:  [sys_waitpid+22/26] sys_waitpid+0x16/0x1a
May  4 12:03:52 fir kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  4 12:03:52 fir kernel: cyrdeliver    S 7FFFFFFF     0  1880   1879          1882       (NOTLB)
May  4 12:03:52 fir kernel: f2459d90 00000082 f2458000 7fffffff f2459de8 00000008 4582bcf6 4585de8d 
May  4 12:03:52 fir kernel:        00000031 c01113ba f24bd570 f2459d88 f24bd570 00000379 4585efee 00000031 
May  4 12:03:52 fir kernel:        f24bd570 f24bdaa0 f24bdbd8 4585de8d 00000031 f39b52c0 c02fc7a4 f2458000 
May  4 12:03:52 fir kernel: Call Trace:
May  4 12:03:52 fir kernel:  [activate_task+90/112] activate_task+0x5a/0x70
May  4 12:03:52 fir kernel:  [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
May  4 12:03:52 fir kernel:  [schedule+1293/1504] schedule+0x50d/0x5e0
May  4 12:03:52 fir kernel:  [prepare_to_wait+92/128] prepare_to_wait+0x5c/0x80
May  4 12:03:52 fir kernel:  [unix_stream_data_wait+137/288] unix_stream_data_wait+0x89/0x120
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [unix_stream_recvmsg+407/976] unix_stream_recvmsg+0x197/0x3d0
May  4 12:03:52 fir kernel:  [sock_aio_read+283/304] sock_aio_read+0x11b/0x130
May  4 12:03:52 fir kernel:  [kmap_atomic+33/96] kmap_atomic+0x21/0x60
May  4 12:03:52 fir kernel:  [do_sync_read+180/240] do_sync_read+0xb4/0xf0
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [vfs_read+189/272] vfs_read+0xbd/0x110
May  4 12:03:52 fir kernel:  [sys_read+64/112] sys_read+0x40/0x70
May  4 12:03:52 fir kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  4 12:03:52 fir kernel: lmtpd         D 00000246     0  1881   1282          1915  1868 (NOTLB)
May  4 12:03:52 fir kernel: f255bedc 00000086 f70e4284 00000246 f255bf00 f255bf5c 00000000 4582bed8 
May  4 12:03:52 fir kernel:        00000031 f7904ad4 f255a000 f255bed4 ffffffff 00004eff 458536d2 00000031 
May  4 12:03:52 fir kernel:        c042a4ac f24bd570 f24bd6a8 4582bed8 00000031 f24bd570 c02fb655 000001b6 
May  4 12:03:52 fir kernel: Call Trace:
May  4 12:03:52 fir kernel:  [__down+149/288] __down+0x95/0x120
May  4 12:03:52 fir kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May  4 12:03:52 fir kernel:  [__down_failed+7/12] __down_failed+0x7/0xc
May  4 12:03:52 fir kernel:  [.text.lock.namei+169/478] .text.lock.namei+0xa9/0x1de
May  4 12:03:52 fir kernel:  [filp_open+59/96] filp_open+0x3b/0x60
May  4 12:03:52 fir kernel:  [get_unused_fd+85/208] get_unused_fd+0x55/0xd0
May  4 12:03:52 fir kernel:  [sys_open+55/128] sys_open+0x37/0x80
May  4 12:03:52 fir kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  4 12:03:52 fir kernel: exim          S F25BDEF8     0  1882   1879                1880 (NOTLB)
May  4 12:03:52 fir kernel: f25bdecc 00000082 f24406a4 f25bdef8 f25bdf0c 00000202 c0147641 44a2e6da 
May  4 12:03:52 fir kernel:        00000031 c16488a0 c0142194 f25bdec4 00000000 00008869 44a50881 00000031 
May  4 12:03:52 fir kernel:        c042a4ac f24bd040 f24bd178 44a2e6da 00000031 f25bdef8 c015c6ac f6ba8200 
May  4 12:03:52 fir kernel: Call Trace:
May  4 12:03:52 fir kernel:  [page_add_anon_rmap+97/112] page_add_anon_rmap+0x61/0x70
May  4 12:03:52 fir kernel:  [do_wp_page+676/752] do_wp_page+0x2a4/0x2f0
May  4 12:03:52 fir kernel:  [pipe_wait+108/144] pipe_wait+0x6c/0x90
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [pipe_readv+616/752] pipe_readv+0x268/0x2f0
May  4 12:03:52 fir kernel:  [pipe_read+41/48] pipe_read+0x29/0x30
May  4 12:03:52 fir kernel:  [vfs_read+173/272] vfs_read+0xad/0x110
May  4 12:03:52 fir kernel:  [sys_read+64/112] sys_read+0x40/0x70
May  4 12:03:52 fir kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  4 12:03:52 fir kernel: apache        S 7FFFFFFF     0  1909   1750                1777 (NOTLB)
May  4 12:03:52 fir kernel: f265fe48 00000086 f58f1c00 7fffffff f265feb4 c0138658 f26a5000 ec167ed1 
May  4 12:03:52 fir kernel:        0000005d c164d4a0 00000003 f265fe40 00000000 000129ef ec1fce4f 0000005d 
May  4 12:03:52 fir kernel:        c042a4ac f2643a80 f2643bb8 ec167ed1 0000005d 7fffffff c02fc7a4 f58f1c00 
May  4 12:03:52 fir kernel: Call Trace:
May  4 12:03:52 fir kernel:  [buffered_rmqueue+424/480] buffered_rmqueue+0x1a8/0x1e0
May  4 12:03:52 fir kernel:  [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
May  4 12:03:52 fir kernel:  [local_bh_enable+98/128] local_bh_enable+0x62/0x80
May  4 12:03:52 fir kernel:  [release_sock+122/128] release_sock+0x7a/0x80
May  4 12:03:52 fir kernel:  [wait_for_connect+167/224] wait_for_connect+0xa7/0xe0
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [tcp_accept+71/208] tcp_accept+0x47/0xd0
May  4 12:03:52 fir kernel:  [inet_accept+46/224] inet_accept+0x2e/0xe0
May  4 12:03:52 fir kernel:  [sys_accept+209/384] sys_accept+0xd1/0x180
May  4 12:03:52 fir kernel:  [do_page_fault+0/1323] do_page_fault+0x0/0x52b
May  4 12:03:52 fir kernel:  [gcc2_compiled.+42/112] _atomic_dec_and_lock+0x2a/0x70
May  4 12:03:52 fir kernel:  [dput+28/560] dput+0x1c/0x230
May  4 12:03:52 fir kernel:  [copy_to_user+59/80] copy_to_user+0x3b/0x50
May  4 12:03:52 fir kernel:  [copy_from_user+65/112] copy_from_user+0x41/0x70
May  4 12:03:52 fir kernel:  [sys_socketcall+179/512] sys_socketcall+0xb3/0x200
May  4 12:03:52 fir kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  4 12:03:52 fir kernel: exim          S F26C3EF8     0  1912      1  1913          1878 (NOTLB)
May  4 12:03:52 fir kernel: f26c3ecc 00000086 f2663090 f26c3ef8 f26c3f0c f26c2000 00000031 14e9109e 
May  4 12:03:52 fir kernel:        00000061 00000000 f2678d2c f26c3ec4 ffffffff 00001448 14e98a50 00000061 
May  4 12:03:52 fir kernel:        c042a4ac f2643550 f2643688 14e9109e 00000061 f26c3ef8 c015c6ac f421a800 
May  4 12:03:52 fir kernel: Call Trace:
May  4 12:03:52 fir kernel:  [pipe_wait+108/144] pipe_wait+0x6c/0x90
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [pipe_readv+616/752] pipe_readv+0x268/0x2f0
May  4 12:03:52 fir kernel:  [pipe_read+41/48] pipe_read+0x29/0x30
May  4 12:03:52 fir kernel:  [vfs_read+173/272] vfs_read+0xad/0x110
May  4 12:03:52 fir kernel:  [sys_read+64/112] sys_read+0x40/0x70
May  4 12:03:52 fir kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  4 12:03:52 fir kernel: exim          S F25EC000     0  1913   1912  1914               (NOTLB)
May  4 12:03:52 fir kernel: f25edf40 00000086 fffffe00 f25ec000 00000000 f6996000 00000001 14e6d016 
May  4 12:03:52 fir kernel:        00000061 f26635a0 c015d0c8 f25edf38 00000000 00009022 14e9109e 00000061 
May  4 12:03:52 fir kernel:        c042a4ac f6a8c040 f6a8c178 14e6d016 00000061 f25ec000 c0118c37 0000077a 
May  4 12:03:52 fir kernel: Call Trace:
May  4 12:03:52 fir kernel:  [pipe_release+152/176] pipe_release+0x98/0xb0
May  4 12:03:52 fir kernel:  [do_wait+695/880] do_wait+0x2b7/0x370
May  4 12:03:52 fir kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May  4 12:03:52 fir kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May  4 12:03:52 fir kernel:  [sys_wait4+38/64] sys_wait4+0x26/0x40
May  4 12:03:52 fir kernel:  [sys_waitpid+22/26] sys_waitpid+0x16/0x1a
May  4 12:03:52 fir kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  4 12:03:52 fir kernel: cyrdeliver    S 7FFFFFFF     0  1914   1913          1916       (NOTLB)
May  4 12:03:52 fir kernel: f2703d90 00000082 f2702000 7fffffff f2703de8 00000008 1625cc21 16279b3d 
May  4 12:03:52 fir kernel:        00000061 c01113ba f257caa0 f2703d88 f257caa0 00000351 1627abd5 00000061 
May  4 12:03:52 fir kernel:        f257caa0 f2643020 f2643158 16279b3d 00000061 f2682da0 c02fc7a4 f2702000 
May  4 12:03:52 fir kernel: Call Trace:
May  4 12:03:52 fir kernel:  [activate_task+90/112] activate_task+0x5a/0x70
May  4 12:03:52 fir kernel:  [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
May  4 12:03:52 fir kernel:  [schedule+1293/1504] schedule+0x50d/0x5e0
May  4 12:03:52 fir kernel:  [prepare_to_wait+92/128] prepare_to_wait+0x5c/0x80
May  4 12:03:52 fir kernel:  [unix_stream_data_wait+137/288] unix_stream_data_wait+0x89/0x120
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [unix_stream_recvmsg+407/976] unix_stream_recvmsg+0x197/0x3d0
May  4 12:03:52 fir kernel:  [sock_aio_read+283/304] sock_aio_read+0x11b/0x130
May  4 12:03:52 fir kernel:  [kmap_atomic+33/96] kmap_atomic+0x21/0x60
May  4 12:03:52 fir kernel:  [do_sync_read+180/240] do_sync_read+0xb4/0xf0
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [vfs_read+189/272] vfs_read+0xbd/0x110
May  4 12:03:52 fir kernel:  [sys_read+64/112] sys_read+0x40/0x70
May  4 12:03:52 fir kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  4 12:03:52 fir kernel: lmtpd         D 00000246     0  1915   1282                1881 (NOTLB)
May  4 12:03:52 fir kernel: f2725edc 00000082 f70e4284 00000246 f2725f00 f2725f5c 00000000 1625ce09 
May  4 12:03:52 fir kernel:        00000061 f7904ad4 f2724000 f2725ed4 00000000 000039a6 16279b3d 00000061 
May  4 12:03:52 fir kernel:        c042a4ac f257caa0 f257cbd8 1625ce09 00000061 f257caa0 c02fb655 000001b6 
May  4 12:03:52 fir kernel: Call Trace:
May  4 12:03:52 fir kernel:  [__down+149/288] __down+0x95/0x120
May  4 12:03:52 fir kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May  4 12:03:52 fir kernel:  [__down_failed+7/12] __down_failed+0x7/0xc
May  4 12:03:52 fir kernel:  [.text.lock.namei+169/478] .text.lock.namei+0xa9/0x1de
May  4 12:03:52 fir kernel:  [filp_open+59/96] filp_open+0x3b/0x60
May  4 12:03:52 fir kernel:  [get_unused_fd+85/208] get_unused_fd+0x55/0xd0
May  4 12:03:52 fir kernel:  [sys_open+55/128] sys_open+0x37/0x80
May  4 12:03:52 fir kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  4 12:03:52 fir kernel: exim          S F2787EF8     0  1916   1913                1914 (NOTLB)
May  4 12:03:52 fir kernel: f2787ecc 00000082 f26636e4 f2787ef8 f2787f0c 00000202 c0147641 14e4c7b4 
May  4 12:03:52 fir kernel:        00000061 c164c1e0 c0142194 f2787ec4 00000000 00008218 14e6d016 00000061 
May  4 12:03:52 fir kernel:        c042a4ac f257c570 f257c6a8 14e4c7b4 00000061 f2787ef8 c015c6ac f421a400 
May  4 12:03:52 fir kernel: Call Trace:
May  4 12:03:52 fir kernel:  [page_add_anon_rmap+97/112] page_add_anon_rmap+0x61/0x70
May  4 12:03:52 fir kernel:  [do_wp_page+676/752] do_wp_page+0x2a4/0x2f0
May  4 12:03:52 fir kernel:  [pipe_wait+108/144] pipe_wait+0x6c/0x90
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
May  4 12:03:52 fir kernel:  [pipe_readv+616/752] pipe_readv+0x268/0x2f0
May  4 12:03:52 fir kernel:  [pipe_read+41/48] pipe_read+0x29/0x30
May  4 12:03:52 fir kernel:  [vfs_read+173/272] vfs_read+0xad/0x110
May  4 12:03:52 fir kernel:  [sys_read+64/112] sys_read+0x40/0x70
May  4 12:03:52 fir kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  4 12:03:52 fir kernel: zsh           S 00000000     0  1939   1757  1941               (NOTLB)
May  4 12:03:52 fir kernel: f59f7f9c 00000086 f59f7fa8 00000000 080cbaa0 c0151a0c 00000000 cadf51c9 
May  4 12:03:52 fir kernel:        00000099 016f8742 00000000 f59f7f94 00000001 00002982 cae09ddd 00000099 
May  4 12:03:52 fir kernel:        c042a034 f59caaa0 f59cabd8 cadf51c9 00000099 f59f6000 c0101ad4 bfafec70 
May  4 12:03:52 fir kernel: Call Trace:
May  4 12:03:52 fir kernel:  [__fput+252/304] __fput+0xfc/0x130
May  4 12:03:52 fir kernel:  [sys_rt_sigsuspend+196/224] sys_rt_sigsuspend+0xc4/0xe0
May  4 12:03:52 fir kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  4 12:03:52 fir kernel: sync          D 00000246     0  1941   1939                     (NOTLB)
May  4 12:03:52 fir kernel: f4af1f54 00000082 f5c59850 00000246 f4af1f78 c18e75ec c016a622 ff294fb7 
May  4 12:03:52 fir kernel:        00000099 c18e75ec c18e6e00 f4af1f4c ffffffff 00009724 ff2e08db 00000099 
May  4 12:03:52 fir kernel:        c042a034 f59ca040 f59ca178 ff294fb7 00000099 f59ca040 c02fb655 f5c59800 
May  4 12:03:52 fir kernel: Call Trace:
May  4 12:03:52 fir kernel:  [iput+66/112] iput+0x42/0x70
May  4 12:03:52 fir kernel:  [__down+149/288] __down+0x95/0x120
May  4 12:03:52 fir kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May  4 12:03:52 fir kernel:  [__down_failed+7/12] __down_failed+0x7/0xc
May  4 12:03:52 fir kernel:  [.text.lock.super+144/427] .text.lock.super+0x90/0x1ab
May  4 12:03:52 fir kernel:  [do_sync+33/96] do_sync+0x21/0x60
May  4 12:03:52 fir kernel:  [sys_sync+7/16] sys_sync+0x7/0x10
May  4 12:03:52 fir kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  4 12:04:05 fir kernel: SysRq : Emergency Sync
May  4 12:04:07 fir kernel: SysRq : Emergency Sync
May  4 12:04:10 fir kernel: SysRq : Emergency Remount R/O

------------------------------ 2.6.12-rc3 ------------------------------

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00006000-00007fff
	Memory behind bridge: dfd00000-dfdfffff
	Prefetchable memory behind bridge: cfb00000-dfbfffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:05.0 SCSI storage controller: Initio Corporation 360P (rev 02)
	Subsystem: Unknown device 9292:0202
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at d800 [size=256]
	Region 1: Memory at dffff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at dffe0000 [disabled] [size=32K]

0000:00:07.0 Unknown mass storage controller: Silicon Image, Inc. (formerly CMD Technology Inc) PCI0680 Ultra ATA-133 Host Controller (rev 02)
	Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) PCI0680 Ultra ATA-133 Host Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x01 (4 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at d400 [size=8]
	Region 1: I/O ports at d000 [size=4]
	Region 2: I/O ports at cc00 [size=8]
	Region 3: I/O ports at c800 [size=4]
	Region 4: I/O ports at c400 [size=16]
	Region 5: Memory at dfffef00 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at dff00000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:00:08.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
	Subsystem: Netgear FA310TX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at c000 [size=256]
	Region 1: Memory at dfffee00 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at dff80000 [disabled] [size=256K]

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Subsystem: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at ff00 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 18) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at b000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 18) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at b400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.4 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 18) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at b800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 10)
	Subsystem: Micro-Star International Co., Ltd. KT266 onboard audio
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at bc00 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE] (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Radeon 7000/Radeon VE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 7800 [size=256]
	Region 2: Memory at dfdf0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at dfdc0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

------------------------------ 2.6.12-rc3 ------------------------------

           CPU0       
  0:     238275          XT-PIC  timer
  1:        559          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  7:          1          XT-PIC  parport0
 10:     543694          XT-PIC  ide2, eth0
 11:       9237          XT-PIC  i91u, radeon@PCI:1:0:0
 12:       3767          XT-PIC  i8042
 14:       5242          XT-PIC  ide0
 15:         24          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

-------------------------------- 2.6.10 --------------------------------

/dev/hda1 on / type ext3 (rw)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw)
/dev/hda3 on /tmp type ext3 (rw)
/dev/mapper/fir_main-lv_usr on /usr type ext3 (rw)
/dev/hda6 on /usr/local type ext3 (rw)
/dev/hda7 on /home type ext3 (rw)
/dev/hda8 on /share type ext3 (rw,noatime)
/dev/mapper/fir_main-lv_cyrus on /var/spool/cyrus type reiserfs (rw,noatime)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)

-------------------------------- 2.6.10 --------------------------------

  --- Physical volume ---
  PV Name               /dev/hde3
  VG Name               fir_main
  PV Size               148.12 GB / not usable 0   
  Allocatable           yes 
  PE Size (KByte)       65536
  Total PE              2370
  Free PE               1602
  Allocated PE          768
  PV UUID               KJVWxS-n31F-A4jL-QHFb-92qp-plRs-bNrDOJ
   
  --- Volume group ---
  VG Name               fir_main
  System ID             
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  3
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                2
  Open LV               2
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               148.12 GB
  PE Size               64.00 MB
  Total PE              2370
  Alloc PE / Size       768 / 48.00 GB
  Free  PE / Size       1602 / 100.12 GB
  VG UUID               7yJCO7-FrYS-RUiS-eqLN-cQQc-xdJo-v0lOVh
   
  --- Logical volume ---
  LV Name                /dev/fir_main/lv_cyrus
  VG Name                fir_main
  LV UUID                9E352G-bCyc-odj9-okWE-ssCF-gEFu-boPBlt
  LV Write Access        read/write
  LV Status              available
  # open                 2
  LV Size                32.00 GB
  Current LE             512
  Segments               1
  Allocation             inherit
  Read ahead sectors     0
  Block device           253:0
   
  --- Logical volume ---
  LV Name                /dev/fir_main/lv_usr
  VG Name                fir_main
  LV UUID                xskwuZ-2QkG-tb9V-rTx3-efC0-sYHI-yDQXVS
  LV Write Access        read/write
  LV Status              available
  # open                 1
  LV Size                16.00 GB
  Current LE             256
  Segments               1
  Allocation             inherit
  Read ahead sectors     0
  Block device           253:1
   
  --- Physical volumes ---
  PV Name               /dev/hde3     
  PV UUID               KJVWxS-n31F-A4jL-QHFb-92qp-plRs-bNrDOJ
  PV Status             allocatable
  Total PE / Free PE    2370 / 1602
   
------------------------------ 2.6.12-rc3 ------------------------------

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.12-rc3-fir.rc3.1
# Wed May  4 10:11:24 2005
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_KALLSYMS=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_HPET_TIMER=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_HIGHPTE=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_SECCOMP=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_BLK_DEV_FD=y
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PCD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PT=m
CONFIG_PARIDE_PG=m
CONFIG_PARIDE_ATEN=m
CONFIG_PARIDE_BPCK=m
CONFIG_PARIDE_BPCK6=m
CONFIG_PARIDE_COMM=m
CONFIG_PARIDE_DSTR=m
CONFIG_PARIDE_FIT2=m
CONFIG_PARIDE_FIT3=m
CONFIG_PARIDE_EPAT=m
CONFIG_PARIDE_EPATC8=y
CONFIG_PARIDE_EPIA=m
CONFIG_PARIDE_FRIQ=m
CONFIG_PARIDE_FRPW=m
CONFIG_PARIDE_KBIC=m
CONFIG_PARIDE_KTTI=m
CONFIG_PARIDE_ON20=m
CONFIG_PARIDE_ON26=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_UB=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=15000
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
CONFIG_SCSI_BUSLOGIC=m
CONFIG_SCSI_OMIT_FLASHPOINT=y
CONFIG_SCSI_INITIO=m
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_SCSI_QLA2XXX=m
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_BLK_DEV_DM=m
CONFIG_DM_CRYPT=m
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_TUNNEL=m
CONFIG_IP_TCPDIAG=y
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_TUNNEL=m
CONFIG_NETFILTER=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_CT_ACCT=y
CONFIG_IP_NF_CONNTRACK_MARK=y
CONFIG_IP_NF_CT_PROTO_SCTP=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_REALM=m
CONFIG_IP_NF_MATCH_SCTP=m
CONFIG_IP_NF_MATCH_COMMENT=m
CONFIG_IP_NF_MATCH_CONNMARK=m
CONFIG_IP_NF_MATCH_HASHLIMIT=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_TARGET_CONNMARK=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_TARGET_NOTRACK=m
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_IP6_NF_RAW=m
CONFIG_XFRM=y
CONFIG_XFRM_USER=y
CONFIG_IP_SCTP=m
CONFIG_SCTP_HMAC_MD5=y
CONFIG_BRIDGE=m
CONFIG_VLAN_8021Q=m
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CLK_CPU=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
CONFIG_NET_TULIP=y
CONFIG_TULIP=y
CONFIG_NET_PCI=y
CONFIG_NET_RADIO=y
CONFIG_AIRO=m
CONFIG_HERMES=m
CONFIG_PLX_HERMES=m
CONFIG_TMD_HERMES=m
CONFIG_PCI_HERMES=m
CONFIG_ATMEL=m
CONFIG_PCI_ATMEL=m
CONFIG_PRISM54=m
CONFIG_NET_WIRELESS=y
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SHAPER=m
CONFIG_NETCONSOLE=m
CONFIG_PHONE=m
CONFIG_PHONE_IXJ=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_A3D=m
CONFIG_JOYSTICK_ADI=m
CONFIG_JOYSTICK_COBRA=m
CONFIG_JOYSTICK_GF2K=m
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=m
CONFIG_JOYSTICK_SIDEWINDER=m
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=m
CONFIG_JOYSTICK_IFORCE_USB=y
CONFIG_JOYSTICK_IFORCE_232=y
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=m
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=m
CONFIG_JOYSTICK_TWIDJOY=m
CONFIG_JOYSTICK_DB9=m
CONFIG_JOYSTICK_GAMECON=m
CONFIG_JOYSTICK_TURBOGRAFX=m
CONFIG_JOYSTICK_JOYDUMP=m
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_INPUT_UINPUT=m
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_LIBPS2=y
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_VORTEX=m
CONFIG_GAMEPORT_FM801=m
CONFIG_GAMEPORT_CS461X=m
CONFIG_SOUND_GAMEPORT=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y
CONFIG_AGP=y
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_RADEON=y
CONFIG_DRM_MGA=m
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_ISA=m
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_W83627HF=m
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_SOUND=m
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_MPU401_UART=m
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_USX2Y=m
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_AUDIO=m
CONFIG_USB_MIDI=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
CONFIG_USB_KBTAB=m
CONFIG_USB_POWERMATE=m
CONFIG_USB_MTOUCH=m
CONFIG_USB_EGALAX=m
CONFIG_USB_XPAD=m
CONFIG_USB_ATI_REMOTE=m
CONFIG_USB_MDC800=m
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_GENESYS=y
CONFIG_USB_NET1080=y
CONFIG_USB_PL2301=y
CONFIG_USB_KC2190=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_ZAURUS=y
CONFIG_USB_CDCETHER=y
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP2101=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_TI=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_EZUSB=y
CONFIG_USB_EMI26=m
CONFIG_USB_RIO500=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_IDMOUSE=m
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
CONFIG_JFS_STATISTICS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=m
CONFIG_XFS_EXPORT=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_SECURITY=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_MINIX_FS=m
CONFIG_ROMFS_FS=m
CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVPTS_FS_XATTR=y
CONFIG_DEVPTS_FS_SECURITY=y
CONFIG_TMPFS=y
CONFIG_TMPFS_XATTR=y
CONFIG_TMPFS_SECURITY=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
CONFIG_CRAMFS=y
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="utf8"
CONFIG_CIFS=m
CONFIG_CIFS_STATS=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CODA_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m
CONFIG_PROFILING=y
CONFIG_OPROFILE=m
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_SCHEDSTATS=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_KEYS=y
CONFIG_KEYS_DEBUG_PROC_KEYS=y
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=y
CONFIG_SECURITY_SECLVL=m
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=0
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=y
CONFIG_CRC_CCITT=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

------------------------------ 2.6.12-rc3 ------------------------------

Linux version 2.6.12-rc3-fir.rc3.1 (root@fir) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Wed May 4 10:20:14 PDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000040000000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
128MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262144
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32768 pages, LIFO batch:8
DMI 2.3 present.
Allocating PCI resources starting at 40000000 (gap: 40000000:bff80000)
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=Linux ro root=301 ide=reverse
ide_setup: ide=reverse : Enabled support for IDE inverse scan order.
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01804000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1338.626 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1033084k/1048576k available (2038k kernel code, 14852k reserved, 1010k data, 148k init, 131072k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2629.63 BogoMIPS (lpj=1314816)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000020 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 1500+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
checking if image is initramfs...it isn't (bad gzip magic numbers); looks like an initrd
Freeing initrd memory: 2356k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb51, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7790
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x6804, dseg 0xf0000
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Via IRQ fixup
Boot video device is 0000:01:00.0
PCI: Using IRQ router default [1106/3074] at 0000:00:11.0
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1115232776.283:0): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA KT266/KY266x/KT333 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized drm 1.0.0 20040925
[drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Linux Tulip driver version 1.1.13 (May 11, 2002)
tulip0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth0: Lite-On 82c168 PNIC rev 32 at 0001c000, 00:02:E3:08:84:62, IRQ 10.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: WDC WD800BB-32BSA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: PLEXTOR CD-R PX-W1610A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
SiI680: IDE controller at PCI slot 0000:00:07.0
SiI680: chipset revision 2
SiI680: BASE CLOCK == 133
SiI680: 100% native mode on irq 10
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: Maxtor 6Y160P0, ATA DISK drive
ide2 at 0xf8832f80-0xf8832f87,0xf8832f8a on irq 10
Probing IDE interface ide3...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
hde: max request size: 64KiB
hde: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)
hde: cache flushes supported
 hde: hde1 hde2 hde3
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: PC Speaker
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 2356KiB [1 disk] into ram disk... << control chars elided - GR>> done.
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 148k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
ReiserFS: hda1: warning: sh-2021: reiserfs_fill_super: can not find reiserfs on hda1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
logips2pp: Detected unknown logitech mouse model 1
input: PS/2 Logitech Mouse on isa0060/serio1
Adding 2096472k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
Generic RTC Driver v1.07
SCSI subsystem initialized
i91u: PCI Base=0xD800, IRQ=11, BIOS=0xFF000, SCSI ID=7
i91u: Reset SCSI Bus ... 
scsi0 : Initio INI-9X00U/UW SCSI device driver; Revision: 1.04a
  Vendor: HP        Model: C1537A            Rev: L005
  Type:   Sequential-Access                  ANSI SCSI revision: 02
st: Version 20050312, fixed bufsize 32768, s/g segs 256
Attached scsi tape st0 at scsi0, channel 0, id 3, lun 0
st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA 1048575
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
ReiserFS: dm-0: using ordered data mode
ReiserFS: dm-0: journal params: device dm-0, size 8125, journal first block 66, max trans len 256, max batch 225, max commit age 30, max trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
ReiserFS: dm-0: Using r5 hash to sort names
cdrom: open failed.
eth0: Setting full-duplex based on MII#1 link partner capability of 45e1.
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03c6040(lo)
IPv6 over IPv4 tunneling driver

----------------------- reverted from 2.6.10-bk7 -----------------------

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/01/03 20:13:18-08:00 jack@suse.cz 
#   [PATCH] Fix of quota deadlock on pagelock: reiserfs
#   
#   Implement quota journaling and quota reading and writing functions for
#   reiserfs.  Solves also several other deadlocks possible for reiserfs due to
#   the lock inversion on journal_begin and quota locks.
#   
#   From: Vladimir Saveliev <vs@namesys.com>
#   
#   When CONFIG_QUOTA is defined reiserfs's finish_unfinished sets and clears
#   MS_ACTIVE bit in s_flags field of super block.  If that bit was set already
#   it should not be set.
#   
#   Signed-off-by: Jan Kara <jack@suse.cz>
#   Signed-off-by: Andrew Morton <akpm@osdl.org>
#   Signed-off-by: Linus Torvalds <torvalds@osdl.org>
# 
# include/linux/reiserfs_fs_sb.h
#   2005/01/03 15:49:13-08:00 jack@suse.cz +4 -0
#   Fix of quota deadlock on pagelock: reiserfs
# 
# include/linux/reiserfs_fs.h
#   2005/01/03 15:49:13-08:00 jack@suse.cz +16 -0
#   Fix of quota deadlock on pagelock: reiserfs
# 
# fs/reiserfs/super.c
#   2005/01/03 15:49:13-08:00 jack@suse.cz +410 -5
#   Fix of quota deadlock on pagelock: reiserfs
# 
# fs/reiserfs/namei.c
#   2005/01/03 15:49:13-08:00 jack@suse.cz +27 -33
#   Fix of quota deadlock on pagelock: reiserfs
# 
# fs/reiserfs/inode.c
#   2005/01/03 15:49:13-08:00 jack@suse.cz +37 -17
#   Fix of quota deadlock on pagelock: reiserfs
# 
# fs/reiserfs/file.c
#   2005/01/03 15:49:13-08:00 jack@suse.cz +3 -3
#   Fix of quota deadlock on pagelock: reiserfs
# 


