Return-Path: <linux-kernel-owner+w=401wt.eu-S932886AbWLSSqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932886AbWLSSqX (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 13:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932892AbWLSSqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 13:46:23 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:39290 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932886AbWLSSqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 13:46:21 -0500
Subject: Processes stuck on I/O (2.6.20-rc1+git)
From: Dave Hansen <haveblue@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 10:46:15 -0800
Message-Id: <1166553975.7834.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was copying some stuff off of a USB device this morning, and saw the
process freeze.  It was unkillable, but I figured the USB device had
died and done something funny.  A little bit later, I had a git process
do the same thing, but it was confined to dealing with an actual
attached disk.

The processes that hung were git-prune-packed and gtkpod.  You can see
them in the sysrq-t output below.  My kernel is from a git pull, post
2.6.20-rc1:

$ uname -a
Linux spirit 2.6.20-rc1-gd1998ef3 #7 Sat Dec 16 05:46:53 PST 2006 i686 GNU/Linux

Which is this commit:

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=d1998ef38a13c4e74c69df55ccd38b0440c429b2

I didn't see any similar reports on LKML, so this could be a transient
thing from a five-day-old kernel that is now fixed.  But, i feat it
could be something that will show up more when the -rc2 snapshot is
taken.  Perhaps I'll revert to 2.6.20-rc1 plain and see if it reappears.

Partial sysrq-t output is below.

Full log with timestamps here: http://sr71.net/~dave/kern.log

-- Dave
gtkpod        ? F485DE40     0 20544      1         22983 26644 (L-TLB)
       f4109ea4 00200046 f1bb4030 f485de40 00000000 f7de2b4c c033ddb5 c40b3100 
       00000171 00000002 f0072a70 f1bb4030 f1bb413c 00000000 c40b3100 00000171 
       f0072a70 c235faa0 f1bb4030 00000000 00000002 c0115df0 c011b6a9 00000009 
Call Trace:
 [<c033ddb5>] __sched_text_start+0x495/0x4f4
 [<c0115df0>] do_exit+0x31a/0x31e
 [<c011b6a9>] __dequeue_signal+0x5d/0x6e
 [<c0115e67>] sys_exit_group+0x0/0xd
 [<c011ca42>] get_signal_to_deliver+0x213/0x223
 [<c01028d8>] do_signal+0x5c/0x10a
 [<c0126e37>] futex_wait+0x15c/0x193
 [<c0111093>] default_wake_function+0x0/0xc
 [<c02db199>] sock_ioctl+0x19b/0x1b7
 [<c0127919>] do_futex+0x34/0xb3
 [<c0127aa2>] sys_futex+0x10a/0x116
 [<c01029af>] do_notify_resume+0x29/0x36
 [<c0102b7a>] work_notifysig+0x13/0x19
 =======================
gtkpod        D C1B7CA20     0 22983      1               20544 (NOTLB)
       ee303d88 00000082 00001000 c1b7ca20 c0130f2a f3bd3030 00000010 00000000 
       00000000 00000000 c2343550 f3bd3030 f3bd313c 00000000 cd575a00 00000152 
       c2343550 ee303dd4 00000000 c2004cd0 ee303d90 c033e31a c012ee22 c012ee55 
Call Trace:
 [<c0130f2a>] generic_file_buffered_write+0x54c/0x56a
 [<c033e31a>] io_schedule+0xe/0x16
 [<c012ee22>] sync_page+0x0/0x36
 [<c012ee55>] sync_page+0x33/0x36
 [<c033e4ef>] __wait_on_bit_lock+0x2c/0x51
 [<c012f4a3>] __lock_page+0x6b/0x72
 [<c0122878>] wake_bit_function+0x0/0x3c
 [<c0122878>] wake_bit_function+0x0/0x3c
 [<c012f967>] do_generic_mapping_read+0x1b9/0x3e7
 [<c012fdd5>] generic_file_aio_read+0x177/0x19b
 [<c012fb95>] file_read_actor+0x0/0xc9
 [<c0147074>] do_sync_read+0xbf/0xfc
 [<c0132cea>] __alloc_pages+0x4a/0x296
 [<c0122845>] autoremove_wake_function+0x0/0x33
 [<c0102c87>] common_interrupt+0x23/0x28
 [<c014713a>] vfs_read+0x89/0x12e
 [<c014744c>] sys_read+0x41/0x67
 [<c0102a76>] sysenter_past_esp+0x5f/0x85
 =======================
bash          S 00000010     0 20818   7782  6348   23251 20246 (NOTLB)
       ef89ff24 00000086 f0080a70 00000010 00000000 ef8d8030 ffffa000 c32c6400 
       00000385 00000002 c238b030 f0080a70 f0080b7c 00000000 c32c6400 00000385 
       c238b030 fffffe00 f0080a70 f0080b24 0000000e c0116867 bfc2aff8 00000000 
Call Trace:
 [<c0116867>] do_wait+0x278/0x324
 [<c013a552>] __handle_mm_fault+0x172/0x1bb
 [<c0111093>] default_wake_function+0x0/0xc
 [<c024fbb5>] tiocspgrp+0x6b/0x90
 [<c0111093>] default_wake_function+0x0/0xc
 [<c01169be>] sys_wait4+0x30/0x33
 [<c01169e8>] sys_waitpid+0x27/0x2b
 [<c0102a76>] sysenter_past_esp+0x5f/0x85
 =======================
bash          S 00000010     0 23251   7782 27513     556 20818 (NOTLB)
       f45e9f24 00200082 ef90d550 00000010 00000000 efcf9030 ffffa000 f5d49e00 
       000001f4 00000002 f1a8aa70 ef90d550 ef90d65c 00000000 f5d49e00 000001f4 
       f1a8aa70 fffffe00 ef90d550 ef90d604 0000000e c0116867 bff61328 00000000 
Call Trace:
 [<c0116867>] do_wait+0x278/0x324
 [<c013a552>] __handle_mm_fault+0x172/0x1bb
 [<c0111093>] default_wake_function+0x0/0xc
 [<c024fbb5>] tiocspgrp+0x6b/0x90
 [<c0111093>] default_wake_function+0x0/0xc
 [<c01169be>] sys_wait4+0x30/0x33
 [<c01169e8>] sys_waitpid+0x27/0x2b
 [<c0102a76>] sysenter_past_esp+0x5f/0x85
 =======================
su            S F19BA580     0 27513  23251 27531               (NOTLB)
       d751cf24 00200082 bfb98000 f19ba580 f19ba040 f19ba040 d7544080 50923758 
       000001f5 00000002 c238b030 efcf9030 efcf913c 00000000 50e80c00 000001f5 
       c238b030 fffffe00 efcf9030 efcf90e4 00000006 c0116867 f19ba580 d751cf84 
Call Trace:
 [<c0116867>] do_wait+0x278/0x324
 [<c0111093>] default_wake_function+0x0/0xc
 [<c011d482>] sys_rt_sigaction+0x53/0x88
 [<c0111093>] default_wake_function+0x0/0xc
 [<c01169be>] sys_wait4+0x30/0x33
 [<c01169e8>] sys_waitpid+0x27/0x2b
 [<c0102a76>] sysenter_past_esp+0x5f/0x85
 [<c0330033>] pfkey_recvmsg+0xd3/0x10c
 =======================
bash          S FFFF9000     0   556   7782   674   10536 23251 (NOTLB)
       f4bfaf24 00200082 c1a4e7e0 ffff9000 0000007b f19a007b ffffa000 8300af00 
       000002bb 00000002 f7dcc550 f3e7f550 f3e7f65c 00000000 8300af00 000002bb 
       f7dcc550 fffffe00 f3e7f550 f3e7f604 0000000e c0116867 bfb9f768 00000000 
Call Trace:
 [<c0116867>] do_wait+0x278/0x324
 [<c013a552>] __handle_mm_fault+0x172/0x1bb
 [<c0111093>] default_wake_function+0x0/0xc
 [<c024fbb5>] tiocspgrp+0x6b/0x90
 [<c0111093>] default_wake_function+0x0/0xc
 [<c01169be>] sys_wait4+0x30/0x33
 [<c01169e8>] sys_waitpid+0x27/0x2b
 [<c0102a76>] sysenter_past_esp+0x5f/0x85
 =======================
ssh           S D764AB18     0   674    556                     (NOTLB)
       d764ab4c 00000086 c012daf1 d764ab18 0000000b f19af550 00000246 0aec6700 
       000003bc 00000002 f4450030 f19af550 f19af65c 00000000 0aec6700 000003bc 
       f4450030 7fffffff 00000000 00000020 00000000 c033e35a 00000286 efdc500c 
Call Trace:
 [<c012daf1>] handle_level_irq+0x0/0xa0
 [<c033e35a>] schedule_timeout+0x13/0x90
 [<c02524a5>] normal_poll+0x0/0x11f
 [<c024f7a7>] tty_poll+0x52/0x5e
 [<c0150a64>] do_select+0x297/0x2dd
 [<c01506df>] __pollwait+0x0/0x41
 [<c0111093>] default_wake_function+0x0/0xc
 [<c0111093>] default_wake_function+0x0/0xc
 [<c0111093>] default_wake_function+0x0/0xc
 [<c0111093>] default_wake_function+0x0/0xc
 [<c0111093>] default_wake_function+0x0/0xc
 [<c02fa364>] ip_queue_xmit+0x3c1/0x3fb
 [<c0308509>] tcp_transmit_skb+0x39a/0x3b7
 [<c02161f6>] copy_to_user+0x2f/0x37
 [<c02e0b10>] memcpy_toiovec+0x27/0x47
 [<c0110826>] __activate_task+0x1c/0x28
 [<c01110d4>] __wake_up_common+0x35/0x4f
 [<c0150ccb>] core_sys_select+0x221/0x2d4
 [<c02daea3>] sock_aio_read+0x50/0x5c
 [<c0253050>] pty_write+0x2f/0x35
 [<c025248c>] write_chan+0x198/0x1b1
 [<c0111093>] default_wake_function+0x0/0xc
 [<c0150e1b>] sys_select+0x9d/0x14d
 [<c0102a76>] sysenter_past_esp+0x5f/0x85
 [<c0330033>] pfkey_recvmsg+0xd3/0x10c
 =======================
build-cscopes S F7DDEF20     0  6348  20818                     (NOTLB)
       f7ddef24 00000086 f7ddefb8 f7ddef20 f7ddefb8 00000002 ef8d8484 977a7800 
       0000043a 00000002 c2343550 ef8d8030 ef8d813c 00000000 977a7800 0000043a 
       c2343550 fffffe00 ef8d8030 ef8d80e4 00000004 c0116867 00000000 00000000 
Call Trace:
 [<c0116867>] do_wait+0x278/0x324
 [<c0111093>] default_wake_function+0x0/0xc
 [<c011d4a2>] sys_rt_sigaction+0x73/0x88
 [<c0111093>] default_wake_function+0x0/0xc
 [<c01169be>] sys_wait4+0x30/0x33
 [<c01169e8>] sys_waitpid+0x27/0x2b
 [<c0102a76>] sysenter_past_esp+0x5f/0x85
 =======================
git-prune-pac D EF8E0E9C     0  9638  16975                     (NOTLB)
       ef8e0e9c 00200082 0000000e ef8e0e9c ef8e0f30 00000000 c0133e3a 00000000 
       0000000e 00000001 00000001 f07b1a70 f07b1b7c 00000000 e57bad00 00000398 
       c03e0ba0 ef8e0ee8 00000000 c2001260 ef8e0ea4 c033e31a c012ee22 c012ee55 
Call Trace:
 [<c0133e3a>] generic_writepages+0x262/0x2b2
 [<c033e31a>] io_schedule+0xe/0x16
 [<c012ee22>] sync_page+0x0/0x36
 [<c012ee55>] sync_page+0x33/0x36
 [<c033e427>] __wait_on_bit+0x2c/0x51
 [<c012f3d4>] wait_on_page_bit+0x72/0x79
 [<c0122878>] wake_bit_function+0x0/0x3c
 [<c0122878>] wake_bit_function+0x0/0x3c
 [<c012efaf>] wait_on_page_writeback_range+0x5d/0xfa
 [<c012f21f>] filemap_write_and_wait+0x1f/0x29
 [<c015f263>] sync_blockdev+0x14/0x19
 [<c015cc59>] __sync_inodes+0x4d/0x67
 [<c015cc84>] sync_inodes+0x11/0x29
 [<c015eaea>] do_sync+0x12/0x4f
 [<c015eb31>] sys_sync+0xa/0xd
 [<c0102a76>] sysenter_past_esp+0x5f/0x85
 [<c0330033>] pfkey_recvmsg+0xd3/0x10c
 =======================
bash          S 00000010     0 10536   7782 10656   16845   556 (NOTLB)
       f4af6f24 00200086 d707aa70 00000010 00000000 d6bef030 ffffa000 8e2b4200 
       000003ba 00000003 f4b60030 d707aa70 d707ab7c 00000000 8e2b4200 000003ba 
       f4b60030 fffffe00 d707aa70 d707ab24 0000000e c0116867 bfa5b628 00000000 
Call Trace:
 [<c0116867>] do_wait+0x278/0x324
 [<c013a552>] __handle_mm_fault+0x172/0x1bb
 [<c0111093>] default_wake_function+0x0/0xc
 [<c024fbb5>] tiocspgrp+0x6b/0x90
 [<c0111093>] default_wake_function+0x0/0xc
 [<c01169be>] sys_wait4+0x30/0x33
 [<c01169e8>] sys_waitpid+0x27/0x2b
 [<c0102a76>] sysenter_past_esp+0x5f/0x85
 =======================
xvncviewer    S 00000000     0 10656  10536                     (NOTLB)
       f00d8bd0 00200082 c0150a9d 00000000 00000000 00000010 00000000 ae074800 
       00000444 00000000 f4ddd550 d6bef030 d6bef13c 00000000 ae074800 00000444 
       f4ddd550 7fffffff 00000000 d731e4c0 00000000 c033e35a f1a95e18 00200246 
Call Trace:
 [<c0150a9d>] do_select+0x2d0/0x2dd
 [<c033e35a>] schedule_timeout+0x13/0x90
 [<c02ff22c>] tcp_poll+0x26/0x138
 [<c0151288>] do_poll+0x156/0x192
 [<c01513d8>] do_sys_poll+0x114/0x1ba
 [<c02f9f6a>] ip_output+0x1bb/0x1f4
 [<c02eefeb>] __qdisc_run+0x2d/0x123
 [<c02fa364>] ip_queue_xmit+0x3c1/0x3fb
 [<c0132b57>] buffered_rmqueue+0xbf/0xd7
 [<c010436d>] do_IRQ+0xc0/0xd7
 [<c010436d>] do_IRQ+0xc0/0xd7
 [<c0102c87>] common_interrupt+0x23/0x28
 [<c0307ddb>] tcp_cwnd_restart+0x17/0xad
 [<c0308509>] tcp_transmit_skb+0x39a/0x3b7
 [<c01506df>] __pollwait+0x0/0x41
 [<c0111093>] default_wake_function+0x0/0xc
 [<c0111093>] default_wake_function+0x0/0xc
 [<c01110d4>] __wake_up_common+0x35/0x4f
 [<c02dda14>] sock_def_readable+0x25/0x49
 [<c0329263>] unix_stream_sendmsg+0x1ff/0x2aa
 [<c02daf41>] do_sock_write+0x92/0x99
 [<c02daf98>] sock_aio_write+0x50/0x5c
 [<c014729e>] do_sync_write+0xbf/0xfc
 [<c0122845>] autoremove_wake_function+0x0/0x33
 [<c0329ade>] unix_ioctl+0x86/0x95
 [<c02db199>] sock_ioctl+0x19b/0x1b7
 [<c011a2b7>] do_gettimeofday+0x2c/0x10f
 [<c02161f6>] copy_to_user+0x2f/0x37
 [<c01514c0>] sys_poll+0x42/0x45
 [<c0102a76>] sysenter_past_esp+0x5f/0x85
 =======================
bash          S D5588E74     0 16845   7782         16958 10536 (NOTLB)
       f1988eac 00200082 c016eac5 d5588e74 d6c78a94 f1988e8c eff38c54 413d7f00 
       0000043f 00000002 f4b60030 f1a56550 f1a5665c 00000000 413d7f00 0000043f 
       f4b60030 7fffffff eff38c00 f1988f1c bfe3b28f c033e35a 00000013 22222222 
Call Trace:
 [<c016eac5>] proc_delete_inode+0x0/0x41
 [<c033e35a>] schedule_timeout+0x13/0x90
 [<c0252102>] read_chan+0x29a/0x48c
 [<c0111093>] default_wake_function+0x0/0xc
 [<c0111093>] default_wake_function+0x0/0xc
 [<c024e5c5>] tty_read+0x70/0x9f
 [<c014713a>] vfs_read+0x89/0x12e
 [<c014744c>] sys_read+0x41/0x67
 [<c0102a76>] sysenter_past_esp+0x5f/0x85
 =======================
bash          S 00000010     0 16958   7782 16975         16845 (NOTLB)
       f3e92f24 00200086 d6a89030 00000010 00000000 f0056030 ffffa000 0000046c 
       0000046c 00000000 f410aa70 d6a89030 d6a8913c 00000000 75392800 00000443 
       f410aa70 fffffe00 d6a89030 d6a890e4 0000000e c0116867 bff91b58 00000000 
Call Trace:
 [<c0116867>] do_wait+0x278/0x324
 [<c013a552>] __handle_mm_fault+0x172/0x1bb
 [<c0111093>] default_wake_function+0x0/0xc
 [<c024fbb5>] tiocspgrp+0x6b/0x90
 [<c0111093>] default_wake_function+0x0/0xc
 [<c01169be>] sys_wait4+0x30/0x33
 [<c01169e8>] sys_waitpid+0x27/0x2b
 [<c0102a76>] sysenter_past_esp+0x5f/0x85
 =======================
strace        S C011BE2C     0 16975  16958  9638               (NOTLB)
       d7216f38 00200082 d7216f30 c011be2c d720d514 fffffffd f07b1a70 c60c1300 
       00000443 00000002 f4b60030 f0056030 f005613c 00000000 c60c1300 00000443 
       f4b60030 fffffe00 f0056030 f00560e4 40000004 c0116867 000001f4 c011d21c 
Call Trace:
 [<c011be2c>] __group_send_sig_info+0x60/0x69
 [<c0116867>] do_wait+0x278/0x324
 [<c011d21c>] do_sigaction+0xf3/0x114
 [<c0111093>] default_wake_function+0x0/0xc
 [<c0111093>] default_wake_function+0x0/0xc
 [<c01169be>] sys_wait4+0x30/0x33
 [<c0102a76>] sysenter_past_esp+0x5f/0x85
 =======================


