Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTJMXlr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 19:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbTJMXlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 19:41:46 -0400
Received: from conure.mail.pas.earthlink.net ([207.217.120.54]:20158 "EHLO
	conure.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S262081AbTJMXky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 19:40:54 -0400
Date: Mon, 13 Oct 2003 19:43:32 -0400
To: linux-kernel@vger.kernel.org
Subject: postgresql timeout in 2.6.0-test7 and 2.6.0-test6-mm4
Message-ID: <20031013234332.GA14290@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.0-test7 and 2.6.0-test6-mm4 have gone idle running the OSDB
on postgresql 7.2.  OSDB is the Open Source Database benchmark.
This has not happened on any previously tested kernel.

Filesystem is ext2.
SMP - quad Xeon.

uptime
  4:39pm  up 1 day,  8:41,  1 user,  load average: 0.00, 0.00, 0.00

wchan counts for postgres are:
for p in $(ps -fu postgres|awk '{print $2}'|grep -v PID)
do cat /proc/$p/wchan;echo
done | sort | uniq -c | sort -nr
	 11 schedule_timeout
	 4 sys_semtimedop
	 3 sys_wait4
	 1 pipe_wait

sysrq tasks shows:

SysRq : Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init          S 00000000     0     1      0     2               (NOTLB)
c365fe6c 00000086 00000000 00000000 c343fd20 c01239c5 f7f9f8c0 00000246 
       00000000 c343f3c0 00000ac2 7e2ebac7 00006a37 f7b06ee0 c343f3c0 f7f9f8c0 
       06f2c721 c365fe74 00000000 00000000 c0124492 c3440564 c3440564 06f2c721 
Call Trace:
 [__mod_timer+229/272] __mod_timer+0xe5/0x110
 [schedule_timeout+146/176] schedule_timeout+0x92/0xb0
 [process_timeout+0/16] process_timeout+0x0/0x10
 [do_select+671/736] do_select+0x29f/0x2e0
 [__pollwait+0/160] __pollwait+0x0/0xa0
 [select_bits_alloc+23/32] select_bits_alloc+0x17/0x20
 [<c015a917>] select_bits_alloc+0x17/0x20
 [sys_select+888/1328] sys_select+0x378/0x530
 [<c015aca8>] sys_select+0x378/0x530
 [sys_stat64+34/48] sys_stat64+0x22/0x30
 [<c0152942>] sys_stat64+0x22/0x30
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

migration/0   S F7B8FF10     0     2      1             3       (L-TLB)
f7f97fcc 00000046 c0118f30 f7b8ff10 00000003 00000000 f7f9e040 00000286 
       c3439bc0 c3439bc0 00000d7f 18e1a913 00000000 00000001 c3439bc0 f7f9e040 
       f7b8ff50 c3439bc0 c3439bc0 f7f97fec c011a609 f7f96000 c343a4ec 00000063 
Call Trace:
 [__wake_up_common+64/96] __wake_up_common+0x40/0x60
 [<c0118f30>] __wake_up_common+0x40/0x60
 [migration_thread+185/272] migration_thread+0xb9/0x110
 [<c011a609>] migration_thread+0xb9/0x110
 [migration_thread+0/272] migration_thread+0x0/0x110
 [<c011a550>] migration_thread+0x0/0x110
 [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
 [<c0107139>] kernel_thread_helper+0x5/0xc

ksoftirqd/0   S 00000001     0     3      1             4     2 (L-TLB)
f7f93fe0 00000046 c343b55c 00000001 00000000 f7f92000 f7f958e0 d2e34080 
       d2e340a0 c3439bc0 000001d1 3651f240 000069bf c3439be8 c3439bc0 f7f958e0 
       00000000 f7f92000 00000000 00000000 c0120625 c0120590 00000000 c0107139 
Call Trace:
 [ksoftirqd+149/240] ksoftirqd+0x95/0xf0
 [<c0120625>] ksoftirqd+0x95/0xf0
 [ksoftirqd+0/240] ksoftirqd+0x0/0xf0
 [<c0120590>] ksoftirqd+0x0/0xf0
 [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
 [<c0107139>] kernel_thread_helper+0x5/0xc

migration/1   S 00000086     0     4      1             5     3 (L-TLB)
f7f91fcc 00000046 00000000 00000086 00000063 c0124bb4 f7f952c0 00000246 
       f7f90000 c343c7c0 000061d7 02096359 00000000 f7f90000 c343c7c0 f7f952c0 
       f7f90000 c343c7c0 c343c7c0 f7f91fec c011a609 f7f90000 c343d0ec 00000063 
Call Trace:
 [flush_signals+68/96] flush_signals+0x44/0x60
 [<c0124bb4>] flush_signals+0x44/0x60
 [migration_thread+185/272] migration_thread+0xb9/0x110
 [<c011a609>] migration_thread+0xb9/0x110
 [migration_thread+0/272] migration_thread+0x0/0x110
 [<c011a550>] migration_thread+0x0/0x110
 [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
 [<c0107139>] kernel_thread_helper+0x5/0xc

ksoftirqd/1   S 00000001     0     5      1             6     4 (L-TLB)
f7f8ffe0 00000046 c343e15c 00000001 00000000 f7f8e000 f7f94ca0 d2e346a0 
       d2e346c0 c343c7c0 00000778 949eea33 00000843 c343c7e8 c343c7c0 f7f94ca0 
       00000000 f7f8e000 00000000 00000000 c0120625 c0120590 00000000 c0107139 
Call Trace:
 [ksoftirqd+149/240] ksoftirqd+0x95/0xf0
 [<c0120625>] ksoftirqd+0x95/0xf0
 [ksoftirqd+0/240] ksoftirqd+0x0/0xf0
 [<c0120590>] ksoftirqd+0x0/0xf0
 [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
 [<c0107139>] kernel_thread_helper+0x5/0xc

migration/2   S 00000082     0     6      1             7     5 (L-TLB)
f7f8dfcc 00000046 00000000 00000082 00000063 c0124bb4 f7f94680 00000246 
       f7f8c000 c343f3c0 0000621b 03494c08 00000000 f7f8c000 c343f3c0 f7f94680 
       f7f8c000 c343f3c0 c343f3c0 f7f8dfec c011a609 f7f8c000 c343fcec 00000063 
Call Trace:
 [flush_signals+68/96] flush_signals+0x44/0x60
 [<c0124bb4>] flush_signals+0x44/0x60
 [migration_thread+185/272] migration_thread+0xb9/0x110
 [<c011a609>] migration_thread+0xb9/0x110
 [migration_thread+0/272] migration_thread+0x0/0x110
 [<c011a550>] migration_thread+0x0/0x110
 [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
 [<c0107139>] kernel_thread_helper+0x5/0xc

ksoftirqd/2   S 00000001     0     7      1             8     6 (L-TLB)
f7f8bfe0 00000046 c3440d5c 00000001 00000000 f7f8a000 f7f94060 ddd07960 
       ddd07980 c343f3c0 000005d8 67184311 0000077e c343f860 c343f3c0 f7f94060 
       00000000 f7f8a000 00000000 00000000 c0120625 c0120590 00000000 c0107139 
Call Trace:
 [ksoftirqd+149/240] ksoftirqd+0x95/0xf0
 [<c0120625>] ksoftirqd+0x95/0xf0
 [ksoftirqd+0/240] xe0
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

mingetty      S 00000008     0   791      1           792   779 (NOTLB)
f730de4c 00000082 00000246 00000008 f782a000 c025c643 f785a0a0 f782a000 
       00000000 c3439bc0 0003f54c ad68c3a3 00000019 c024f1ee c3439bc0 f785a0a0 
       00000008 7fffffff f7381440 f782a000 c0124414 00000000 f730de8c f730de94 
Call Trace:
 [con_write+35/48] con_write+0x23/0x30
 [<c025c643>] con_write+0x23/0x30
 [opost_block+478/496] opost_block+0x1de/0x1f0
 [<c024f1ee>] opost_block+0x1de/0x1f0
 [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
 [<c0124414>] schedule_timeout+0x14/0xb0
 [read_chan+1119/2304] read_chan+0x45f/0x900
 [<c0250aaf>] read_chan+0x45f/0x900
 [vgacon_cursor+431/448] vgacon_cursor+0x1af/0x1c0
 [<c029d96f>] vgacon_cursor+0x1af/0x1c0
 [set_cursor+102/128] set_cursor+0x66/0x80
 [<c0258df6>] set_cursor+0x66/0x80
 [write_chan+483/512] write_chan+0x1e3/0x200
 [<c0251133>] write_chan+0x1e3/0x200
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [tty_read+221/320] tty_read+0xdd/0x140
 [<c024be4d>] tty_read+0xdd/0x140
 [vfs_read+170/224] vfs_read+0xaa/0xe0
 [<c0149a2a>] vfs_read+0xaa/0xe0
 [unmap_vma_list+26/48] unmap_vma_list+0x1a/0x30
 [<c014004a>] unmap_vma_list+0x1a/0x30
 [do_munmap+245/256] do_munmap+0xf5/0x100
 [<c01403b5>] do_munmap+0xf5/0x100
 [sys_read+47/80] sys_read+0x2f/0x50
 [<c0149c1f>] sys_read+0x2f/0x50
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

mingetty      S 00000008     0   792      1           793   791 (NOTLB)
f7227e4c 00000086 00000246 00000008 f780f000 c025c643 f72f66e0 f72238c0 
       f72238e0 c343f3c0 00035020 ad63f958 00000019 c343f860 c343f3c0 f72f66e0 
       00000008 7fffffff f7381bc0 f780f000 c0124414 00000000 f7227e8c f7227e94 
Call Trace:
 [con_write+35/48] con_write+0x23/0x30
 [<c025c643>] con_write+0x23/0x30
 [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
 [<c0124414>] schedule_timeout+0x14/0xb0
 [read_chan+1119/2304] read_chan+0x45f/0x900
 [<c0250aaf>] read_chan+0x45f/0x900
 [zap_pmd_range+76/96] zap_pmd_range+0x4c/0x60
 [<c013cb4c>] zap_pmd_range+0x4c/0x60
 [unmap_page_range+64/96] unmap_page_range+0x40/0x60
 [<c013cba0>] unmap_page_range+0x40/0x60
 [write_chan+483/512] write_chan+0x1e3/0x200
 [<c0251133>] write_chan+0x1e3/0x200
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [tty_read+221/320] tty_read+0xdd/0x140
 [<c024be4d>] tty_read+0xdd/0x140
 [vfs_read+170/224] vfs_read+0xaa/0xe0
 [<c0149a2a>] vfs_read+0xaa/0xe0
 [unmap_vma_list+26/48] unmap_vma_list+0x1a/0x30
 [<c014004a>] unmap_vma_list+0x1a/0x30
 [do_munmap+245/256] do_munmap+0xf5/0x100
 [<c01403b5>] do_munmap+0xf5/0x100
 [sys_read+47/80] sys_read+0x2f/0x50
 [<c0149c1f>] sys_read+0x2f/0x50
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

mingetty      S 00000008     0   793      1           794   792 (NOTLB)
f72f5e4c 00000082 00000246 00000008 f728d000 c025c643 f71fe060 f7940080 
       f79400a0 c343c7c0 00038c21 ad64ad12 00000019 c343cc60 c343c7c0 f71fe060 
       00000008 7fffffff f7a0cac0 f728d000 c0124414 00000000 f72f5e8c f72f5e94 
Call Trace:
 [con_write+35/48] con_write+0x23/0x30
 [<c025c643>] con_write+0x23/0x30
 [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
 [<c0124414>] schedule_timeout+0x14/0xb0
 [read_chan+1119/2304] read_chan+0x45f/0x900
 [<c0250aaf>] read_chan+0x45f/0x900
 [zap_pmd_range+76/96] zap_pmd_range+0x4c/0x60
 [<c013cb4c>] zap_pmd_range+0x4c/0x60
 [unmap_page_range+64/96] unmap_page_range+0x40/0x60
 [<c013cba0>] unmap_page_range+0x40/0x60
 [write_chan+483/512] write_chan+0x1e3/0x200
 [<c0251133>] write_chan+0x1e3/0x200
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [tty_read+221/320] tty_read+0xdd/0x140
 [<c024be4d>] tty_read+0xdd/0x140
 [vfs_read+170/224] vfs_read+0xaa/0xe0
 [<c0149a2a>] vfs_read+0xaa/0xe0
 [unmap_vma_list+26/48] unmap_vma_list+0x1a/0x30
 [<c014004a>] unmap_vma_list+0x1a/0x30
 [do_munmap+245/256] do_munmap+0xf5/0x100
 [<c01403b5>] do_munmap+0xf5/0x100
 [sys_read+47/80] sys_read+0x2f/0x50
 [<c0149c1f>] sys_read+0x2f/0x50
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

mingetty      S 00000008     0   794      1           795   793 (NOTLB)
f71cfe4c 00000086 00000246 00000008 f794c000 c025c643 f79412e0 f785a0a0 
       f785a0c0 c3439bc0 0003ef3a ad64ce57 00000019 c343a060 c3439bc0 f79412e0 
       00000008 7fffffff f7b06580 f794c000 c0124414 00000000 f71cfe8c f71cfe94 
Call Trace:
 [con_write+35/48] con_write+0x23/0x30
 [<c025c643>] con_write+0x23/0x30
 [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
 [<c0124414>] schedule_timeout+0x14/0xb0
 [read_chan+1119/2304] read_chan+0x45f/0x900
 [<c0250aaf>] read_chan+0x45f/0x900
 [zap_pmd_range+76/96] zap_pmd_range+0x4c/0x60
 [<c013cb4c>] zap_pmd_range+0x4c/0x60
 [unmap_page_range+64/96] unmap_page_range+0x40/0x60
 [<c013cba0>] unmap_page_range+0x40/0x60
 [write_chan+483/512] write_chan+0x1e3/0x200
 [<c0251133>] write_chan+0x1e3/0x200
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [tty_read+221/320] tty_read+0xdd/0x140
 [<c024be4d>] tty_read+0xdd/0x140
 [vfs_read+170/224] vfs_read+0xaa/0xe0
 [<c0149a2a>] vfs_read+0xaa/0xe0
 [unmap_vma_list+26/48] unmap_vma_list+0x1a/0x30
 [<c014004a>] unmap_vma_list+0x1a/0x30
 [do_munmap+245/256] do_munmap+0xf5/0x100
 [<c01403b5>] do_munmap+0xf5/0x100
 [sys_read+47/80] sys_read+0x2f/0x50
 [<c0149c1f>] sys_read+0x2f/0x50
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

mingetty      S 00000008     0   795      1           796   794 (NOTLB)
f71a9e4c 00000086 00000246 00000008 f6ee7000 c025c643 f7940080 f6ee7000 
       00000000 c343c7c0 00023a5e ad66e770 00000019 c024f1ee c343c7c0 f7940080 
       00000008 7fffffff f78a1960 f6ee7000 c0124414 00000000 f71a9e8c f71a9e94 
Call Trace:
 [con_write+35/48] con_write+0x23/0x30
 [<c025c643>] con_write+0x23/0x30
 [opost_block+478/496] opost_block+0x1de/0x1f0
 [<c024f1ee>] opost_block+0x1de/0x1f0
 [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
 [<c0124414>] schedule_timeout+0x14/0xb0
 [read_chan+1119/2304] read_chan+0x45f/0x900
 [<c0250aaf>] read_chan+0x45f/0x900
 [zap_pmd_range+76/96] zap_pmd_range+0x4c/0x60
 [<c013cb4c>] zap_pmd_range+0x4c/0x60
 [unmap_page_range+64/96] unmap_page_range+0x40/0x60
 [<c013cba0>] unmap_page_range+0x40/0x60
 [write_chan+483/512] write_chan+0x1e3/0x200
 [<c0251133>] write_chan+0x1e3/0x200
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [tty_read+221/320] tty_read+0xdd/0x140
 [<c024be4d>] tty_read+0xdd/0x140
 [vfs_read+170/224] vfs_read+0xaa/0xe0
 [<c0149a2a>] vfs_read+0xaa/0xe0
 [unmap_vma_list+26/48] unmap_vma_list+0x1a/0x30
 [<c014004a>] unmap_vma_list+0x1a/0x30
 [do_munmap+245/256] do_munmap+0xf5/0x100
 [<c01403b5>] do_munmap+0xf5/0x100
 [sys_read+47/80] sys_read+0x2f/0x50
 [<c0149c1f>] sys_read+0x2f/0x50
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

mingetty      S 00000008     0   796      1           797   795 (NOTLB)
f6ec3e4c 00000082 00000246 00000008 f7835000 c025c643 f72238c0 f7835000 
       00000000 c343f3c0 0003edbb ad67e713 00000019 c024f1ee c343f3c0 f72238c0 
       00000008 7fffffff f7b06c60 f7835000 c0124414 00000000 f6ec3e8c f6ec3e94 
Call Trace:
 [con_write+35/48] con_write+0x23/0x30
 [<c025c643>] con_write+0x23/0x30
 [opost_block+478/496] opost_block+0x1de/0x1f0
 [<c024f1ee>] opost_block+0x1de/0x1f0
 [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
 [<c0124414>] schedule_timeout+0x14/0xb0
 [read_chan+1119/2304] read_chan+0x45f/0x900
 [<c0250aaf>] read_chan+0x45f/0x900
 [zap_pmd_range+76/96] zap_pmd_range+0x4c/0x60
 [<c013cb4c>] zap_pmd_range+0x4c/0x60
 [unmap_page_range+64/96] unmap_page_range+0x40/0x60
 [<c013cba0>] unmap_page_range+0x40/0x60
 [write_chan+483/512] write_chan+0x1e3/0x200
 [<c0251133>] write_chan+0x1e3/0x200
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [tty_read+221/320] tty_read+0xdd/0x140
 [<c024be4d>] tty_read+0xdd/0x140
 [vfs_read+170/224] vfs_read+0xaa/0xe0
 [<c0149a2a>] vfs_read+0xaa/0xe0
 [unmap_vma_list+26/48] unmap_vma_list+0x1a/0x30
 [<c014004a>] unmap_vma_list+0x1a/0x30
 [do_munmap+245/256] do_munmap+0xf5/0x100
 [<c01403b5>] do_munmap+0xf5/0x100
 [sys_read+47/80] sys_read+0x2f/0x50
 [<c0149c1f>] sys_read+0x2f/0x50
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

agetty        S C03E5F60     0   797      1           914   796 (NOTLB)
f6ec1e4c 00000082 c02630ea c03e5f60 c03e5f60 00000202 f7222c80 c03e5f60 
       00000001 c3441fc0 0000f589 e8aaf7a2 00000019 00000001 c3441fc0 f7222c80 
       00000008 7fffffff f73d57a0 f782e000 c0124414 00000000 f6ec1e8c f6ec1e94 
Call Trace:
 [serial8250_tx_empty+26/48] serial8250_tx_empty+0x1a/0x30
 [<c02630ea>] serial8250_tx_empty+0x1a/0x30
 [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
 [<c0124414>] schedule_timeout+0x14/0xb0
 [read_chan+1119/2304] read_chan+0x45f/0x900
 [<c0250aaf>] read_chan+0x45f/0x900
 [zap_pmd_range+76/96] zap_pmd_range+0x4c/0x60
 [<c013cb4c>] zap_pmd_range+0x4c/0x60
 [unmap_page_range+64/96] unmap_page_range+0x40/0x60
 [<c013cba0>] unmap_page_range+0x40/0x60
 [write_chan+483/512] write_chan+0x1e3/0x200
 [<c0251133>] write_chan+0x1e3/0x200
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [tty_read+221/320] tty_read+0xdd/0x140
 [<c024be4d>] tty_read+0xdd/0x140
 [vfs_read+170/224] vfs_read+0xaa/0xe0
 [<c0149a2a>] vfs_read+0xaa/0xe0
 [unmap_vma_list+26/48] unmap_vma_list+0x1a/0x30
 [<c014004a>] unmap_vma_list+0x1a/0x30
 [do_munmap+245/256] do_munmap+0xf5/0x100
 [<c01403b5>] do_munmap+0xf5/0x100
 [sys_read+47/80] sys_read+0x2f/0x50
 [<c0149c1f>] sys_read+0x2f/0x50
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

nruntests     S 00000001     0   914      1  1059   14266   797 (NOTLB)
f6ee3f60 00000086 00000001 00000001 080c9f9c 00000000 f72f60c0 00000000 
       00000002 c3441fc0 00034d4b 07851d18 000007ab f6ee3f70 c3441fc0 f72f60c0 
       00000001 fffffe00 f72f60c0 00000000 c011f0d1 f6ee2000 00000001 00000000 
Call Trace:
 [sys_wait4+577/640] sys_wait4+0x241/0x280
 [<c011f0d1>] sys_wait4+0x241/0x280
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

vmstat        S 00000000  6392  1059    914          1060       (NOTLB)
c87adee4 00000086 00000001 00000000 c343a520 c01239c5 cbbee0e0 00000246 
       00000000 c3439bc0 000be3cd c1c304e1 00006a2b 00000000 c3439bc0 cbbee0e0 
       c87adf48 06f2d8fd 00000000 c87ac000 c012e28a c87adf00 c87adf48 c87ac01c 
Call Trace:
 [__mod_timer+229/272] __mod_timer+0xe5/0x110
 [<c01239c5>] __mod_timer+0xe5/0x110
 [do_clock_nanosleep+442/816] do_clock_nanosleep+0x1ba/0x330
 [<c012e28a>] do_clock_nanosleep+0x1ba/0x330
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [pipe_write+723/752] pipe_write+0x2d3/0x2f0
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [sys_rt_sigaction+213/240] sys_rt_sigaction+0xd5/0xf0
 [<c0128425>] sys_rt_sigaction+0xd5/0xf0
 [nanosleep_wake_up+0/16] nanosleep_wake_up+0x0/0x10
 [<c012deb0>] nanosleep_wake_up+0x0/0x10
 [sys_nanosleep+138/224] sys_nanosleep+0x8a/0xe0
 [<c012df6a>] sys_nanosleep+0x8a/0xe0
 [sys_write+47/80] sys_write+0x2f/0x50
 [<c0149c6f>] sys_write+0x2f/0x50
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

tee           S CB5F6E80  6528  1060    914         13523  1059 (NOTLB)
df8d7ec8 00000082 df8d7eb4 cb5f6e80 00000000 00000001 f73699c0 f73d5c00 
       f7240640 c343c7c0 00000c32 c1c350a8 00006a2b f73699c0 c343c7c0 f73699c0 
       cb5f6eec cb5f6e80 df8d7ef0 cb5f6e80 c01549f8 00000000 f73699c0 c011abd0 
Call Trace:
 [pipe_wait+152/192] pipe_wait+0x98/0xc0
 [<c01549f8>] pipe_wait+0x98/0xc0
 [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
 [<c011abd0>] autoremove_wake_function+0x0/0x40
 [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
 [<c011abd0>] autoremove_wake_function+0x0/0x40
 [pipe_read+472/592] pipe_read+0x1d8/0x250
 [<c0154bf8>] pipe_read+0x1d8/0x250
 [vfs_read+170/224] vfs_read+0xaa/0xe0
 [<c0149a2a>] vfs_read+0xaa/0xe0
 [apic_timer_interrupt+26/32] apic_timer_interrupt+0x1a/0x20
 [<c0109a0a>] apic_timer_interrupt+0x1a/0x20
 [sys_read+47/80] sys_read+0x2f/0x50
 [<c0149c1f>] sys_read+0x2f/0x50
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

ping_lat      S 00000001     0 13523    914 13533   13524  1060 (NOTLB)
db87bf60 00000082 00000001 00000001 080c9f9c 00000000 f7368d80 00000000 
       00000002 c3439bc0 0001a4d0 08a679d1 000007ab db87bf70 c3439bc0 f7368d80 
       00000001 fffffe00 f7368d80 00000000 c011f0d1 db87a000 00000001 00000000 
Call Trace:
 [sys_wait4+577/640] sys_wait4+0x241/0x280
 [<c011f0d1>] sys_wait4+0x241/0x280
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

tee           S F578D400  5104 13524    914         13525 13523 (NOTLB)
d55ffec8 00000086 c3439020 f578d400 4019a000 00001000 f7368140 f578d404 
       4019b000 c3439bc0 001770c6 078b546e 000007ab 4019a000 c3439bc0 f7368140 
       f791b12c f791b0c0 d55ffef0 f791b0c0 c01549f8 00000000 f7368140 c011abd0 
Call Trace:
 [pipe_wait+152/192] pipe_wait+0x98/0xc0
 [<c01549f8>] pipe_wait+0x98/0xc0
 [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
 [<c011abd0>] autoremove_wake_function+0x0/0x40
 [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
 [<c011abd0>] autoremove_wake_function+0x0/0x40
 [pipe_read+472/592] pipe_read+0x1d8/0x250
 [<c0154bf8>] pipe_read+0x1d8/0x250
 [vfs_read+170/224] vfs_read+0xaa/0xe0
 [<c0149a2a>] vfs_read+0xaa/0xe0
 [unmap_vma_list+26/48] unmap_vma_list+0x1a/0x30
 [<c014004a>] unmap_vma_list+0x1a/0x30
 [do_munmap+245/256] do_munmap+0xf5/0x100
 [<c01403b5>] do_munmap+0xf5/0x100
 [sys_read+47/80] sys_read+0x2f/0x50
 [<c0149c1f>] sys_read+0x2f/0x50
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

su            S 00000001     0 13525    914 13534         13524 (NOTLB)
c3d29f60 00000086 00000001 00000001 0804cd5c f7946d88 f71ff8e0 00000000 
       0000000f c3439bc0 0001735f 0e5e1bea 000007ab 00000001 c3439bc0 f71ff8e0 
       00000001 fffffe00 f71ff8e0 00000002 c011f0d1 c3d28000 00000001 00000000 
Call Trace:
 [sys_wait4+577/640] sys_wait4+0x241/0x280
 [<c011f0d1>] sys_wait4+0x241/0x280
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

ping          S 00000000     0 13533  13523                     (NOTLB)
c88ebc6c 00000086 c88ebcd4 00000000 0100007f 00000000 c371b320 e64a0bc0 
       e07d8780 c343f3c0 00004176 9bac833c 00006a37 00000040 c343f3c0 c371b320 
       00000000 7fffffff c88ebd00 c88ebd30 c0124414 c02dcc8c 00000206 ee1d1400 
Call Trace:
 [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
 [<c0124414>] schedule_timeout+0x14/0xb0
 [raw_sendmsg+972/1136] raw_sendmsg+0x3cc/0x470
 [<c02dcc8c>] raw_sendmsg+0x3cc/0x470
 [wait_for_packet+258/320] wait_for_packet+0x102/0x140
 [<c02aa762>] wait_for_packet+0x102/0x140
 [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
 [<c011abd0>] autoremove_wake_function+0x0/0x40
 [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
 [<c011abd0>] autoremove_wake_function+0x0/0x40
 [generic_commit_write+95/112] generic_commit_write+0x5f/0x70
 [<c014d50f>] generic_commit_write+0x5f/0x70
 [skb_recv_datagram+208/240] skb_recv_datagram+0xd0/0xf0
 [<c02aa870>] skb_recv_datagram+0xd0/0xf0
 [raw_recvmsg+133/336] raw_recvmsg+0x85/0x150
 [<c02dce95>] raw_recvmsg+0x85/0x150
 [inet_recvmsg+63/96] inet_recvmsg+0x3f/0x60
 [<c02e5e3f>] inet_recvmsg+0x3f/0x60
 [sock_recvmsg+140/176] sock_recvmsg+0x8c/0xb0
 [<c02a547c>] sock_recvmsg+0x8c/0xb0
 [error_code+45/56] error_code+0x2d/0x38
 [<c0109a85>] error_code+0x2d/0x38
 [file_read_actor+100/208] file_read_actor+0x64/0xd0
 [<c0130f74>] file_read_actor+0x64/0xd0
 [file_read_actor+113/208] file_read_actor+0x71/0xd0
 [<c0130f81>] file_read_actor+0x71/0xd0
 [do_generic_mapping_read+333/928] do_generic_mapping_read+0x14d/0x3a0
 [<c0130cbd>] do_generic_mapping_read+0x14d/0x3a0
 [verify_iovec+124/224] verify_iovec+0x7c/0xe0
 [<c02aa03c>] verify_iovec+0x7c/0xe0
 [sys_recvmsg+351/528] sys_recvmsg+0x15f/0x210
 [<c02a6adf>] sys_recvmsg+0x15f/0x210
 [generic_file_write_nolock+111/144] generic_file_write_nolock+0x6f/0x90
 [<c0132a7f>] generic_file_write_nolock+0x6f/0x90
 [unmap_page_range+64/96] unmap_page_range+0x40/0x60
 [<c013cba0>] unmap_page_range+0x40/0x60
 [unmap_vmas+275/672] unmap_vmas+0x113/0x2a0
 [<c013ccd3>] unmap_vmas+0x113/0x2a0
 [free_pages_and_swap_cache+143/176] free_pages_and_swap_cache+0x8f/0xb0
 [<c014589f>] free_pages_and_swap_cache+0x8f/0xb0
 [generic_file_write+71/96] generic_file_write+0x47/0x60
 [<c0132b67>] generic_file_write+0x47/0x60
 [vfs_write+170/224] vfs_write+0xaa/0xe0
 [<c0149bba>] vfs_write+0xaa/0xe0
 [sys_socketcall+573/592] sys_socketcall+0x23d/0x250
 [<c02a6dcd>] sys_socketcall+0x23d/0x250
 [do_munmap+245/256] do_munmap+0xf5/0x100
 [<c01403b5>] do_munmap+0xf5/0x100
 [sys_write+47/80] sys_write+0x2f/0x50
 [<c0149c6f>] sys_write+0x2f/0x50
 [syscall_call+7/11] syscall_call+0x7/0xb

run_osdb      S 00000001    48 13534  13525 14267               (NOTLB)
da89ff60 00000086 00000001 00000001 080c9f9c 00000002 f785b300 00000000 
       00000002 c3441fc0 000340a4 5a755501 000007b6 da89ff70 c3441fc0 f785b300 
       00000001 fffffe00 f785b300 00000000 c011f0d1 da89e000 00000001 00000000 
Call Trace:
 [sys_wait4+577/640] sys_wait4+0x241/0x280
 [<c011f0d1>] sys_wait4+0x241/0x280
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

postmaster    S 00000000   176 14266      1 14274   14969   914 (NOTLB)
e2747e6c 00000082 d0953340 00000000 c343d120 c01239c5 d0953340 00000246 
       00000000 c343c7c0 00001cc7 8e68e3e8 00006a30 c1591a50 c343c7c0 d0953340 
       06f6d305 e2747e74 00000000 00000000 c0124492 c343dc04 c343dc04 06f6d305 
Call Trace:
 [__mod_timer+229/272] __mod_timer+0xe5/0x110
 [<c01239c5>] __mod_timer+0xe5/0x110
 [schedule_timeout+146/176] schedule_timeout+0x92/0xb0
 [<c0124492>] schedule_timeout+0x92/0xb0
 [process_timeout+0/16] process_timeout+0x0/0x10
 [<c01243f0>] process_timeout+0x0/0x10
 [do_select+671/736] do_select+0x29f/0x2e0
 [<c015a8bf>] do_select+0x29f/0x2e0
 [__pollwait+0/160] __pollwait+0x0/0xa0
 [<c015a4a0>] __pollwait+0x0/0xa0
 [select_bits_alloc+23/32] select_bits_alloc+0x17/0x20
 [<c015a917>] select_bits_alloc+0x17/0x20
 [sys_select+888/1328] sys_select+0x378/0x530
 [<c015aca8>] sys_select+0x378/0x530
 [wait_task_zombie+390/416] wait_task_zombie+0x186/0x1a0
 [<c011ed06>] wait_task_zombie+0x186/0x1a0
 [sigprocmask+172/224] sigprocmask+0xac/0xe0
 [<c012738c>] sigprocmask+0xac/0xe0
 [sys_rt_sigprocmask+168/352] sys_rt_sigprocmask+0xa8/0x160
 [<c0127468>] sys_rt_sigprocmask+0xa8/0x160
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

make          S F7F9EC80   112 14267  13534 14268               (NOTLB)
e2dadf60 00000082 c3439bc0 f7f9ec80 e2dac000 e2dadf88 e87260e0 e2dadf80 
       c0119102 c343f3c0 0000e5ae 5adde821 000007b6 00000002 c343f3c0 e87260e0 
       00000001 fffffe00 e87260e0 00000000 c011f0d1 e2dac000 00000001 00000000 
Call Trace:
 [wait_for_completion+162/224] wait_for_completion+0xa2/0xe0
 [<c0119102>] wait_for_completion+0xa2/0xe0
 [sys_wait4+577/640] sys_wait4+0x241/0x280
 [<c011f0d1>] sys_wait4+0x241/0x280
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [sys_vfork+28/32] sys_vfork+0x1c/0x20
 [<c010790c>] sys_vfork+0x1c/0x20
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

sh            S 00000001     4 14268  14267 14271               (NOTLB)
e4c55f60 00000082 00000001 00000001 080c9f9c f0913cc0 f7afcc80 00000000 
       00000002 c343f3c0 0001f72b 5b86ae5e 000007b6 e4c55f70 c343f3c0 f7afcc80 
       00000001 fffffe00 f7afcc80 00000000 c011f0d1 e4c54000 00000001 00000000 
Call Trace:
 [sys_wait4+577/640] sys_wait4+0x241/0x280
 [<c011f0d1>] sys_wait4+0x241/0x280
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

osdb-pg       S C033B200    16 14271  14268 14325   14272       (NOTLB)
f078fe6c 00000086 f7a38680 c033b200 00000010 c033bc00 f7a38680 f7a38ca0 
       f7a38cc0 c343c7c0 00002350 582a90bd 0000088a c343c7e8 c343c7c0 f7a38680 
       00000000 7fffffff 00000000 00000000 c0124414 f7331c80 c6dc3578 f078fee8 
Call Trace:
 [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
 [<c0124414>] schedule_timeout+0x14/0xb0
 [sock_poll+25/32] sock_poll+0x19/0x20
 [<c02a5ad9>] sock_poll+0x19/0x20
 [do_select+671/736] do_select+0x29f/0x2e0
 [<c015a8bf>] do_select+0x29f/0x2e0
 [__pollwait+0/160] __pollwait+0x0/0xa0
 [<c015a4a0>] __pollwait+0x0/0xa0
 [select_bits_alloc+23/32] select_bits_alloc+0x17/0x20
 [<c015a917>] select_bits_alloc+0x17/0x20
 [sys_select+888/1328] sys_select+0x378/0x530
 [<c015aca8>] sys_select+0x378/0x530
 [do_sigaction+433/640] do_sigaction+0x1b1/0x280
 [<c0127f71>] do_sigaction+0x1b1/0x280
 [do_sigaction+527/640] do_sigaction+0x20f/0x280
 [<c0127fcf>] do_sigaction+0x20f/0x280
 [sys_rt_sigaction+213/240] sys_rt_sigaction+0xd5/0xf0
 [<c0128425>] sys_rt_sigaction+0xd5/0xf0
 [sys_send+29/48] sys_send+0x1d/0x30
 [<c02a64cd>] sys_send+0x1d/0x30
 [sys_socketcall+353/592] sys_socketcall+0x161/0x250
 [<c02a6cf1>] sys_socketcall+0x161/0x250
 [sys_times+159/224] sys_times+0x9f/0xe0
 [<c0129acf>] sys_times+0x9f/0xe0
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

tee           S D3D11E8C    80 14272  14268               14271 (NOTLB)
d3d11ec8 00000082 e026eae0 d3d11e8c 00000000 00000001 f7a38060 f71ff2c0 
       f71ff2e0 c3439bc0 00005398 a0e78ff6 000008bc c343a060 c3439bc0 f7a38060 
       f791bd8c f791bd20 d3d11ef0 f791bd20 c01549f8 00000000 f7a38060 c011abd0 
Call Trace:
 [pipe_wait+152/192] pipe_wait+0x98/0xc0
 [<c01549f8>] pipe_wait+0x98/0xc0
 [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
 [<c011abd0>] autoremove_wake_function+0x0/0x40
 [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
 [<c011abd0>] autoremove_wake_function+0x0/0x40
 [pipe_read+472/592] pipe_read+0x1d8/0x250
 [<c0154bf8>] pipe_read+0x1d8/0x250
 [vfs_read+170/224] vfs_read+0xaa/0xe0
 [<c0149a2a>] vfs_read+0xaa/0xe0
 [sys_read+47/80] sys_read+0x2f/0x50
 [<c0149c1f>] sys_read+0x2f/0x50
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

postmaster    S 00000010    16 14274  14266 14276   14326       (NOTLB)
f1df3e6c 00000082 c033b200 00000010 c033bc00 00000000 f7222660 d2e352e0 
       d2e35300 c3441fc0 0000b838 2041cbb7 00000884 c3442460 c3441fc0 f7222660 
       00000000 7fffffff 00000000 00000000 c0124414 cc2e14a0 00000020 c0154ff3 
Call Trace:
 [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
 [<c0124414>] schedule_timeout+0x14/0xb0
 [pipe_poll+35/112] pipe_poll+0x23/0x70
 [<c0154ff3>] pipe_poll+0x23/0x70
 [do_select+671/736] do_select+0x29f/0x2e0
 [<c015a8bf>] do_select+0x29f/0x2e0
 [__pollwait+0/160] __pollwait+0x0/0xa0
 [<c015a4a0>] __pollwait+0x0/0xa0
 [select_bits_alloc+23/32] select_bits_alloc+0x17/0x20
 [<c015a917>] select_bits_alloc+0x17/0x20
 [sys_select+888/1328] sys_select+0x378/0x530
 [<c015aca8>] sys_select+0x378/0x530
 [pipe_write+723/752] pipe_write+0x2d3/0x2f0
 [<c0154f43>] pipe_write+0x2d3/0x2f0
 [vfs_write+170/224] vfs_write+0xaa/0xe0
 [<c0149bba>] vfs_write+0xaa/0xe0
 [vfs_write+209/224] vfs_write+0xd1/0xe0
 [<c0149be1>] vfs_write+0xd1/0xe0
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

postmaster    S F7343490    16 14276  14274                     (NOTLB)
cbac1e6c 00000086 00000000 f7343490 00000000 f785b920 f785b920 00000010 
       c033bc00 c3441fc0 0006fa37 3e0c9429 00000884 e07c8a40 c3441fc0 f785b920 
       00000000 7fffffff 00000000 00000000 c0124414 cc2e14a0 00000020 c0154ff3 
Call Trace:
 [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
 [<c0124414>] schedule_timeout+0x14/0xb0
 [pipe_poll+35/112] pipe_poll+0x23/0x70
 [<c0154ff3>] pipe_poll+0x23/0x70
 [do_select+671/736] do_select+0x29f/0x2e0
 [<c015a8bf>] do_select+0x29f/0x2e0
 [__pollwait+0/160] __pollwait+0x0/0xa0
 [<c015a4a0>] __pollwait+0x0/0xa0
 [select_bits_alloc+23/32] select_bits_alloc+0x17/0x20
 [<c015a917>] select_bits_alloc+0x17/0x20
 [sys_select+888/1328] sys_select+0x378/0x530
 [<c015aca8>] sys_select+0x378/0x530
 [sys_rename+453/480] sys_rename+0x1c5/0x1e0
 [<c0158655>] sys_rename+0x1c5/0x1e0
 [unmap_vma_list+26/48] unmap_vma_list+0x1a/0x30
 [<c014004a>] unmap_vma_list+0x1a/0x30
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

osdb-pg       S C033B200    48 14325  14271         14327       (NOTLB)
ca3ede6c 00000082 e2379360 c033b200 00000010 c033bc00 e2379360 d2e352e0 
       d2e35300 c3441fc0 00000196 47ae85a5 000011cb c3441fe8 c3441fc0 e2379360 
       00000000 7fffffff 00000000 00000000 c0124414 d0135ac0 cf8dc638 ca3edee8 
Call Trace:
 [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
 [<c0124414>] schedule_timeout+0x14/0xb0
 [sock_poll+25/32] sock_poll+0x19/0x20
 [<c02a5ad9>] sock_poll+0x19/0x20
 [do_select+671/736] do_select+0x29f/0x2e0
 [<c015a8bf>] do_select+0x29f/0x2e0
 [__pollwait+0/160] __pollwait+0x0/0xa0
 [<c015a4a0>] __pollwait+0x0/0xa0
 [select_bits_alloc+23/32] select_bits_alloc+0x17/0x20
 [<c015a917>] select_bits_alloc+0x17/0x20
 [sys_select+888/1328] sys_select+0x378/0x530
 [<c015aca8>] sys_select+0x378/0x530
 [do_sigaction+433/640] do_sigaction+0x1b1/0x280
 [<c0127f71>] do_sigaction+0x1b1/0x280
 [do_sigaction+527/640] do_sigaction+0x20f/0x280
 [<c0127fcf>] do_sigaction+0x20f/0x280
 [sys_rt_sigaction+213/240] sys_rt_sigaction+0xd5/0xf0
 [<c0128425>] sys_rt_sigaction+0xd5/0xf0
 [sys_send+29/48] sys_send+0x1d/0x30
 [<c02a64cd>] sys_send+0x1d/0x30
 [sys_socketcall+353/592] sys_socketcall+0x161/0x250
 [<c02a6cf1>] sys_socketcall+0x161/0x250
 [sys_times+159/224] sys_times+0x9f/0xe0
 [<c0129acf>] sys_times+0x9f/0xe0
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

postmaster    S EE479E94    16 14326  14266         14328 14274 (NOTLB)
ee479d58 00000086 00000044 ee479e94 c4fec0b0 c02f4cef d0952d20 f7fa0634 
       00000000 c3439bc0 00000dc7 83511d81 000011cb 00000000 c3439bc0 d0952d20 
       00000001 f7fa05f0 00000000 00000001 c023d598 00000000 00000000 00284000 
Call Trace:
 [unix_stream_recvmsg+671/1184] unix_stream_recvmsg+0x29f/0x4a0
 [<c02f4cef>] unix_stream_recvmsg+0x29f/0x4a0
 [sys_semtimedop+1064/1264] sys_semtimedop+0x428/0x4f0
 [<c023d598>] sys_semtimedop+0x428/0x4f0
 [__copy_to_user_ll+88/112] __copy_to_user_ll+0x58/0x70
 [<c0242a28>] __copy_to_user_ll+0x58/0x70
 [convert_fxsr_to_user+233/320] convert_fxsr_to_user+0xe9/0x140
 [<c010fef9>] convert_fxsr_to_user+0xe9/0x140
 [file_read_actor+0/208] file_read_actor+0x0/0xd0
 [<c0130f10>] file_read_actor+0x0/0xd0
 [save_i387_fxsave+158/192] save_i387_fxsave+0x9e/0xc0
 [<c01100ce>] save_i387_fxsave+0x9e/0xc0
 [save_i387+60/192] save_i387+0x3c/0xc0
 [<c011012c>] save_i387+0x3c/0xc0
 [__dequeue_signal+375/400] __dequeue_signal+0x177/0x190
 [<c0124fb7>] __dequeue_signal+0x177/0x190
 [setup_sigcontext+220/304] setup_sigcontext+0xdc/0x130
 [<c01087bc>] setup_sigcontext+0xdc/0x130
 [setup_frame+244/464] setup_frame+0xf4/0x1d0
 [<c0108904>] setup_frame+0xf4/0x1d0
 [dequeue_signal+56/112] dequeue_signal+0x38/0x70
 [<c0125008>] dequeue_signal+0x38/0x70
 [convert_fxsr_from_user+26/224] convert_fxsr_from_user+0x1a/0xe0
 [<c010ff6a>] convert_fxsr_from_user+0x1a/0xe0
 [handle_signal+250/272] handle_signal+0xfa/0x110
 [<c0108d5a>] handle_signal+0xfa/0x110
 [restore_i387_fxsave+93/112] restore_i387_fxsave+0x5d/0x70
 [<c011020d>] restore_i387_fxsave+0x5d/0x70
 [restore_i387+26/128] restore_i387+0x1a/0x80
 [<c011023a>] restore_i387+0x1a/0x80
 [sys_setitimer+215/240] sys_setitimer+0xd7/0xf0
 [<c011f757>] sys_setitimer+0xd7/0xf0
 [sys_ipc+97/656] sys_ipc+0x61/0x290
 [<c010f6c1>] sys_ipc+0x61/0x290
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

osdb-pg       S C033B200    80 14327  14271         14329 14325 (NOTLB)
e61dbe6c 00000082 f71ff2c0 c033b200 00000010 c033bc00 f71ff2c0 000000d0 
       000000d0 c343c7c0 0000015b 5e6a3d7b 00001487 c1190118 c343c7c0 f71ff2c0 
       00000000 7fffffff 00000000 00000000 c0124414 f73d5b60 cf8dc2f8 e61dbee8 
Call Trace:
 [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
 [<c0124414>] schedule_timeout+0x14/0xb0
 [sock_poll+25/32] sock_poll+0x19/0x20
 [<c02a5ad9>] sock_poll+0x19/0x20
 [do_select+671/736] do_select+0x29f/0x2e0
 [<c015a8bf>] do_select+0x29f/0x2e0
 [__pollwait+0/160] __pollwait+0x0/0xa0
 [<c015a4a0>] __pollwait+0x0/0xa0
 [select_bits_alloc+23/32] select_bits_alloc+0x17/0x20
 [<c015a917>] select_bits_alloc+0x17/0x20
 [sys_select+888/1328] sys_select+0x378/0x530
 [<c015aca8>] sys_select+0x378/0x530
 [do_sigaction+433/640] do_sigaction+0x1b1/0x280
 [<c0127f71>] do_sigaction+0x1b1/0x280
 [do_sigaction+527/640] do_sigaction+0x20f/0x280
 [<c0127fcf>] do_sigaction+0x20f/0x280
 [sys_rt_sigaction+213/240] sys_rt_sigaction+0xd5/0xf0
 [<c0128425>] sys_rt_sigaction+0xd5/0xf0
 [sys_send+29/48] sys_send+0x1d/0x30
 [<c02a64cd>] sys_send+0x1d/0x30
 [sys_socketcall+353/592] sys_socketcall+0x161/0x250
 [<c02a6cf1>] sys_socketcall+0x161/0x250
 [sys_times+159/224] sys_times+0x9f/0xe0
 [<c0129acf>] sys_times+0x9f/0xe0
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

postmaster    S C5BBFE94    16 14328  14266         14330 14326 (NOTLB)
c5bbfd58 00000082 00000044 c5bbfe94 f7926530 c02f4cef d2e352e0 f7fa063c 
       00000001 c3441fc0 00000e71 9a1370af 00001487 00000000 c3441fc0 d2e352e0 
       00000001 f7fa05f0 00000000 00000001 c023d598 c0118f30 c376dfc0 00000003 
Call Trace:
 [unix_stream_recvmsg+671/1184] unix_stream_recvmsg+0x29f/0x4a0
 [<c02f4cef>] unix_stream_recvmsg+0x29f/0x4a0
 [sys_semtimedop+1064/1264] sys_semtimedop+0x428/0x4f0
 [<c023d598>] sys_semtimedop+0x428/0x4f0
 [__wake_up_common+64/96] __wake_up_common+0x40/0x60
 [<c0118f30>] __wake_up_common+0x40/0x60
 [__wake_up+29/48] __wake_up+0x1d/0x30
 [<c0118f6d>] __wake_up+0x1d/0x30
 [convert_fxsr_to_user+233/320] convert_fxsr_to_user+0xe9/0x140
 [<c010fef9>] convert_fxsr_to_user+0xe9/0x140
 [save_i387_fxsave+158/192] save_i387_fxsave+0x9e/0xc0
 [<c01100ce>] save_i387_fxsave+0x9e/0xc0
 [save_i387+60/192] save_i387+0x3c/0xc0
 [<c011012c>] save_i387+0x3c/0xc0
 [__dequeue_signal+375/400] __dequeue_signal+0x177/0x190
 [<c0124fb7>] __dequeue_signal+0x177/0x190
 [setup_sigcontext+220/304] setup_sigcontext+0xdc/0x130
 [<c01087bc>] setup_sigcontext+0xdc/0x130
 [setup_frame+244/464] setup_frame+0xf4/0x1d0
 [<c0108904>] setup_frame+0xf4/0x1d0
 [dequeue_signal+56/112] dequeue_signal+0x38/0x70
 [<c0125008>] dequeue_signal+0x38/0x70
 [convert_fxsr_from_user+26/224] convert_fxsr_from_user+0x1a/0xe0
 [<c010ff6a>] convert_fxsr_from_user+0x1a/0xe0
 [handle_signal+250/272] handle_signal+0xfa/0x110
 [<c0108d5a>] handle_signal+0xfa/0x110
 [restore_i387_fxsave+93/112] restore_i387_fxsave+0x5d/0x70
 [<c011020d>] restore_i387_fxsave+0x5d/0x70
 [__fput+133/176] __fput+0x85/0xb0
 [<c014a875>] __fput+0x85/0xb0
 [restore_i387+26/128] restore_i387+0x1a/0x80
 [<c011023a>] restore_i387+0x1a/0x80
 [sys_setitimer+215/240] sys_setitimer+0xd7/0xf0
 [<c011f757>] sys_setitimer+0xd7/0xf0
 [sys_ipc+97/656] sys_ipc+0x61/0x290
 [<c010f6c1>] sys_ipc+0x61/0x290
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

osdb-pg       S C033B200   144 14329  14271         14331 14327 (NOTLB)
f32bbe6c 00000086 d0952700 c033b200 00000010 c033bc00 d0952700 000000d0 
       000000d0 c343f3c0 0000267b d0fbc0aa 0000118c c17497f8 c343f3c0 d0952700 
       00000000 7fffffff 00000000 00000000 c0124414 f5857260 f78d2258 f32bbee8 
Call Trace:
 [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
 [<c0124414>] schedule_timeout+0x14/0xb0
 [sock_poll+25/32] sock_poll+0x19/0x20
 [<c02a5ad9>] sock_poll+0x19/0x20
 [do_select+671/736] do_select+0x29f/0x2e0
 [<c015a8bf>] do_select+0x29f/0x2e0
 [__pollwait+0/160] __pollwait+0x0/0xa0
 [<c015a4a0>] __pollwait+0x0/0xa0
 [select_bits_alloc+23/32] select_bits_alloc+0x17/0x20
 [<c015a917>] select_bits_alloc+0x17/0x20
 [sys_select+888/1328] sys_select+0x378/0x530
 [<c015aca8>] sys_select+0x378/0x530
 [do_sigaction+433/640] do_sigaction+0x1b1/0x280
 [<c0127f71>] do_sigaction+0x1b1/0x280
 [do_sigaction+527/640] do_sigaction+0x20f/0x280
 [<c0127fcf>] do_sigaction+0x20f/0x280
 [sys_rt_sigaction+213/240] sys_rt_sigaction+0xd5/0xf0
 [<c0128425>] sys_rt_sigaction+0xd5/0xf0
 [sys_send+29/48] sys_send+0x1d/0x30
 [<c02a64cd>] sys_send+0x1d/0x30
 [sys_socketcall+353/592] sys_socketcall+0x161/0x250
 [<c02a6cf1>] sys_socketcall+0x161/0x250
 [do_softirq+107/208] do_softirq+0x6b/0xd0
 [<c01200cb>] do_softirq+0x6b/0xd0
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

postmaster    S C343F3C0     0 14330  14266         14332 14328 (NOTLB)
cc57dc9c 00000082 0000118c c343f3c0 00000001 00000001 f71feca0 d0952d20 
       d0952d40 c343c7c0 000007e9 d0fba28a 0000118c c3441fe8 c343c7c0 f71feca0 
       f792c6c0 7fffffff 7fffffff f792c830 c0124414 f78d2258 00000293 e07d8dc0 
Call Trace:
 [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
 [<c0124414>] schedule_timeout+0x14/0xb0
 [__wake_up+29/48] __wake_up+0x1d/0x30
 [<c0118f6d>] __wake_up+0x1d/0x30
 [unix_stream_data_wait+169/288] unix_stream_data_wait+0xa9/0x120
 [<c02f49d9>] unix_stream_data_wait+0xa9/0x120
 [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
 [<c011abd0>] autoremove_wake_function+0x0/0x40
 [unix_stream_sendmsg+737/1024] unix_stream_sendmsg+0x2e1/0x400
 [<c02f4621>] unix_stream_sendmsg+0x2e1/0x400
 [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
 [<c011abd0>] autoremove_wake_function+0x0/0x40
 [unix_stream_recvmsg+464/1184] unix_stream_recvmsg+0x1d0/0x4a0
 [<c02f4c20>] unix_stream_recvmsg+0x1d0/0x4a0
 [sys_semtimedop+1222/1264] sys_semtimedop+0x4c6/0x4f0
 [<c023d636>] sys_semtimedop+0x4c6/0x4f0
 [sock_recvmsg+140/176] sock_recvmsg+0x8c/0xb0
 [<c02a547c>] sock_recvmsg+0x8c/0xb0
 [del_timer_sync+39/144] del_timer_sync+0x27/0x90
 [<c0123b57>] del_timer_sync+0x27/0x90
 [schedule_timeout+152/176] schedule_timeout+0x98/0xb0
 [<c0124498>] schedule_timeout+0x98/0xb0
 [sys_recvfrom+161/256] sys_recvfrom+0xa1/0x100
 [<c02a6581>] sys_recvfrom+0xa1/0x100
 [schedule+1320/1504] schedule+0x528/0x5e0
 [<c0118e18>] schedule+0x528/0x5e0
 [select_bits_alloc+23/32] select_bits_alloc+0x17/0x20
 [<c015a917>] select_bits_alloc+0x17/0x20
 [__mod_timer+229/272] __mod_timer+0xe5/0x110
 [<c01239c5>] __mod_timer+0xe5/0x110
 [del_timer_sync+39/144] del_timer_sync+0x27/0x90
 [<c0123b57>] del_timer_sync+0x27/0x90
 [do_setitimer+313/512] do_setitimer+0x139/0x200
 [<c011f5b9>] do_setitimer+0x139/0x200
 [sys_recv+29/48] sys_recv+0x1d/0x30
 [<c02a65fd>] sys_recv+0x1d/0x30
 [sys_socketcall+420/592] sys_socketcall+0x1a4/0x250
 [<c02a6d34>] sys_socketcall+0x1a4/0x250
 [generic_file_llseek+0/192] generic_file_llseek+0x0/0xc0
 [<c0149450>] generic_file_llseek+0x0/0xc0
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

osdb-pg       S C033B200     0 14331  14271         14333 14329 (NOTLB)
d159fe6c 00000086 e2378d40 c033b200 00000010 c033bc00 e2378d40 000000d0 
       000000d0 c3439bc0 00000186 b792867c 000013b1 c14d81b8 c3439bc0 e2378d40 
       00000000 7fffffff 00000000 00000000 c0124414 ee96c760 f7286298 d159fee8 
Call Trace:
 [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
 [<c0124414>] schedule_timeout+0x14/0xb0
 [sock_poll+25/32] sock_poll+0x19/0x20
 [<c02a5ad9>] sock_poll+0x19/0x20
 [do_select+671/736] do_select+0x29f/0x2e0
 [<c015a8bf>] do_select+0x29f/0x2e0
 [__pollwait+0/160] __pollwait+0x0/0xa0
 [<c015a4a0>] __pollwait+0x0/0xa0
 [select_bits_alloc+23/32] select_bits_alloc+0x17/0x20
 [<c015a917>] select_bits_alloc+0x17/0x20
 [sys_select+888/1328] sys_select+0x378/0x530
 [<c015aca8>] sys_select+0x378/0x530
 [do_sigaction+433/640] do_sigaction+0x1b1/0x280
 [<c0127f71>] do_sigaction+0x1b1/0x280
 [do_sigaction+527/640] do_sigaction+0x20f/0x280
 [<c0127fcf>] do_sigaction+0x20f/0x280
 [sys_rt_sigaction+213/240] sys_rt_sigaction+0xd5/0xf0
 [<c0128425>] sys_rt_sigaction+0xd5/0xf0
 [sys_send+29/48] sys_send+0x1d/0x30
 [<c02a64cd>] sys_send+0x1d/0x30
 [sys_socketcall+353/592] sys_socketcall+0x161/0x250
 [<c02a6cf1>] sys_socketcall+0x161/0x250
 [sys_times+159/224] sys_times+0x9f/0xe0
 [<c0129acf>] sys_times+0x9f/0xe0
 [syscall_call+7/11] syscall_call+0x7/0xb

postmaster    S DE3B5E94     8 14332  14266         14334 14330 (NOTLB)
de3b5d58 00000082 00000044 de3b5e94 f792c590 c02f4cef f7a38ca0 f7fa064c 
       00000003 c3441fc0 00000d6f f33cf065 000013b1 00000000 c3441fc0 f7a38ca0 
       00000001 f7fa05f0 00000000 00000001 c023d598 c0267602 f7b5c400 d88e5378 
Call Trace:
 [unix_stream_recvmsg+671/1184] unix_stream_recvmsg+0x29f/0x4a0
 [<c02f4cef>] unix_stream_recvmsg+0x29f/0x4a0
 [sys_semtimedop+1064/1264] sys_semtimedop+0x428/0x4f0
 [<c023d598>] sys_semtimedop+0x428/0x4f0
 [__elv_add_request+34/48] __elv_add_request+0x22/0x30
 [<c0267602>] __elv_add_request+0x22/0x30
 [convert_fxsr_to_user+233/320] convert_fxsr_to_user+0xe9/0x140
 [<c010fef9>] convert_fxsr_to_user+0xe9/0x140
 [file_read_actor+0/208] file_read_actor+0x0/0xd0
 [<c0130f10>] file_read_actor+0x0/0xd0
 [save_i387_fxsave+158/192] save_i387_fxsave+0x9e/0xc0
 [<c01100ce>] save_i387_fxsave+0x9e/0xc0
 [save_i387+60/192] save_i387+0x3c/0xc0
 [<c011012c>] save_i387+0x3c/0xc0
 [__dequeue_signal+375/400] __dequeue_signal+0x177/0x190
 [<c0124fb7>] __dequeue_signal+0x177/0x190
 [setup_sigcontext+220/304] setup_sigcontext+0xdc/0x130
 [<c01087bc>] setup_sigcontext+0xdc/0x130
 [setup_frame+244/464] setup_frame+0xf4/0x1d0
 [<c0108904>] setup_frame+0xf4/0x1d0
 [dequeue_signal+56/112] dequeue_signal+0x38/0x70
 [<c0125008>] dequeue_signal+0x38/0x70
 [convert_fxsr_from_user+26/224] convert_fxsr_from_user+0x1a/0xe0
 [<c010ff6a>] convert_fxsr_from_user+0x1a/0xe0
 [handle_signal+250/272] handle_signal+0xfa/0x110
 [<c0108d5a>] handle_signal+0xfa/0x110
 [restore_i387_fxsave+93/112] restore_i387_fxsave+0x5d/0x70
 [<c011020d>] restore_i387_fxsave+0x5d/0x70
 [__fput+133/176] __fput+0x85/0xb0
 [<c014a875>] __fput+0x85/0xb0
 [restore_i387+26/128] restore_i387+0x1a/0x80
 [<c011023a>] restore_i387+0x1a/0x80
 [sys_setitimer+215/240] sys_setitimer+0xd7/0xf0
 [<c011f757>] sys_setitimer+0xd7/0xf0
 [sys_ipc+97/656] sys_ipc+0x61/0x290
 [<c010f6c1>] sys_ipc+0x61/0x290
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

osdb-pg       S C033B200     4 14333  14271               14331 (NOTLB)
eb22de6c 00000086 f7a398e0 c033b200 00000010 c033bc00 f7a398e0 000000d0 
       000000d0 c343f3c0 00000163 480c4188 000011cb c10d8040 c343f3c0 f7a398e0 
       00000000 7fffffff 00000000 00000000 c0124414 c9e57540 c6dc3718 eb22dee8 
Call Trace:
 [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
 [<c0124414>] schedule_timeout+0x14/0xb0
 [sock_poll+25/32] sock_poll+0x19/0x20
 [<c02a5ad9>] sock_poll+0x19/0x20
 [do_select+671/736] do_select+0x29f/0x2e0
 [<c015a8bf>] do_select+0x29f/0x2e0
 [__pollwait+0/160] __pollwait+0x0/0xa0
 [<c015a4a0>] __pollwait+0x0/0xa0
 [select_bits_alloc+23/32] select_bits_alloc+0x17/0x20
 [<c015a917>] select_bits_alloc+0x17/0x20
 [sys_select+888/1328] sys_select+0x378/0x530
 [<c015aca8>] sys_select+0x378/0x530
 [do_sigaction+433/640] do_sigaction+0x1b1/0x280
 [<c0127f71>] do_sigaction+0x1b1/0x280
 [do_sigaction+527/640] do_sigaction+0x20f/0x280
 [<c0127fcf>] do_sigaction+0x20f/0x280
 [sys_rt_sigaction+213/240] sys_rt_sigaction+0xd5/0xf0
 [<c0128425>] sys_rt_sigaction+0xd5/0xf0
 [sys_send+29/48] sys_send+0x1d/0x30
 [<c02a64cd>] sys_send+0x1d/0x30
 [sys_socketcall+353/592] sys_socketcall+0x161/0x250
 [<c02a6cf1>] sys_socketcall+0x161/0x250
 [sys_times+159/224] sys_times+0x9f/0xe0
 [<c0129acf>] sys_times+0x9f/0xe0
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

postmaster    S DB3EDE94     4 14334  14266         14335 14332 (NOTLB)
db3edd58 00000086 00000044 db3ede94 e5ecd6d0 c02f4cef d09520e0 f7fa0654 
       00000004 c343c7c0 000012a6 83acc343 000011cb 00000000 c343c7c0 d09520e0 
       00000001 f7fa05f0 00000000 00000001 c023d598 00000000 00000000 0028a000 
Call Trace:
 [unix_stream_recvmsg+671/1184] unix_stream_recvmsg+0x29f/0x4a0
 [<c02f4cef>] unix_stream_recvmsg+0x29f/0x4a0
 [sys_semtimedop+1064/1264] sys_semtimedop+0x428/0x4f0
 [<c023d598>] sys_semtimedop+0x428/0x4f0
 [convert_fxsr_to_user+233/320] convert_fxsr_to_user+0xe9/0x140
 [<c010fef9>] convert_fxsr_to_user+0xe9/0x140
 [save_i387_fxsave+158/192] save_i387_fxsave+0x9e/0xc0
 [<c01100ce>] save_i387_fxsave+0x9e/0xc0
 [save_i387+60/192] save_i387+0x3c/0xc0
 [<c011012c>] save_i387+0x3c/0xc0
 [__dequeue_signal+375/400] __dequeue_signal+0x177/0x190
 [<c0124fb7>] __dequeue_signal+0x177/0x190
 [setup_sigcontext+220/304] setup_sigcontext+0xdc/0x130
 [<c01087bc>] setup_sigcontext+0xdc/0x130
 [setup_frame+244/464] setup_frame+0xf4/0x1d0
 [<c0108904>] setup_frame+0xf4/0x1d0
 [dequeue_signal+56/112] dequeue_signal+0x38/0x70
 [<c0125008>] dequeue_signal+0x38/0x70
 [convert_fxsr_from_user+26/224] convert_fxsr_from_user+0x1a/0xe0
 [<c010ff6a>] convert_fxsr_from_user+0x1a/0xe0
 [handle_signal+250/272] handle_signal+0xfa/0x110
 [<c0108d5a>] handle_signal+0xfa/0x110
 [restore_i387_fxsave+93/112] restore_i387_fxsave+0x5d/0x70
 [<c011020d>] restore_i387_fxsave+0x5d/0x70
 [__fput+133/176] __fput+0x85/0xb0
 [<c014a875>] __fput+0x85/0xb0
 [restore_i387+26/128] restore_i387+0x1a/0x80
 [<c011023a>] restore_i387+0x1a/0x80
 [sys_setitimer+215/240] sys_setitimer+0xd7/0xf0
 [<c011f757>] sys_setitimer+0xd7/0xf0
 [sys_ipc+97/656] sys_ipc+0x61/0x290
 [<c010f6c1>] sys_ipc+0x61/0x290
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

postmaster    S C343F3C0     4 14335  14266               14334 (NOTLB)
cbcf3c9c 00000082 0000088a c343f3c0 00000001 00000001 cbbef960 d2e352e0 
       d2e35300 c343f3c0 000002ba 582a778a 0000088a c343f3e8 c343f3c0 cbbef960 
       f7926c60 7fffffff 7fffffff f7926dd0 c0124414 c6dc3578 00000216 f73f7800 
Call Trace:
 [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
 [<c0124414>] schedule_timeout+0x14/0xb0
 [__wake_up+29/48] __wake_up+0x1d/0x30
 [<c0118f6d>] __wake_up+0x1d/0x30
 [unix_stream_data_wait+169/288] unix_stream_data_wait+0xa9/0x120
 [<c02f49d9>] unix_stream_data_wait+0xa9/0x120
 [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
 [<c011abd0>] autoremove_wake_function+0x0/0x40
 [unix_stream_sendmsg+737/1024] unix_stream_sendmsg+0x2e1/0x400
 [<c02f4621>] unix_stream_sendmsg+0x2e1/0x400
 [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
 [<c011abd0>] autoremove_wake_function+0x0/0x40
 [unix_stream_recvmsg+464/1184] unix_stream_recvmsg+0x1d0/0x4a0
 [<c02f4c20>] unix_stream_recvmsg+0x1d0/0x4a0
 [sys_semtimedop+1222/1264] sys_semtimedop+0x4c6/0x4f0
 [<c023d636>] sys_semtimedop+0x4c6/0x4f0
 [smp_apic_timer_interrupt+320/336] smp_apic_timer_interrupt+0x140/0x150
 [<c01144a0>] smp_apic_timer_interrupt+0x140/0x150
 [try_to_wake_up+297/544] try_to_wake_up+0x129/0x220
 [<c01179a9>] try_to_wake_up+0x129/0x220
 [sock_recvmsg+140/176] sock_recvmsg+0x8c/0xb0
 [<c02a547c>] sock_recvmsg+0x8c/0xb0
 [mempool_free+85/96] mempool_free+0x55/0x60
 [<c01333d5>] mempool_free+0x55/0x60
 [bio_destructor+67/80] bio_destructor+0x43/0x50
 [<c014e5f3>] bio_destructor+0x43/0x50
 [elv_next_request+169/224] elv_next_request+0xa9/0xe0
 [<c02676f9>] elv_next_request+0xa9/0xe0
 [scsi_request_fn+54/640] scsi_request_fn+0x36/0x280
 [<c02793a6>] scsi_request_fn+0x36/0x280
 [sys_recvfrom+161/256] sys_recvfrom+0xa1/0x100
c02a6581>] sys_recvfrom+0xa1/0x100
 [do_softirq+107/208] do_softirq+0x6b/0xd0
 [<c01200cb>] do_softirq+0x6b/0xd0
 [smp_apic_timer_interrupt+320/336] smp_apic_timer_interrupt+0x140/0x150
 [<c01144a0>] smp_apic_timer_interrupt+0x140/0x150
 [do_softirq+107/208] do_softirq+0x6b/0xd0
 [<c01200cb>] do_softirq+0x6b/0xd0
 [scsi_delete_timer+14/32] scsi_delete_timer+0xe/0x20
 [<c0276f7e>] scsi_delete_timer+0xe/0x20
 [sys_recv+29/48] sys_recv+0x1d/0x30
 [<c02a65fd>] sys_recv+0x1d/0x30
 [sys_socketcall+420/592] sys_socketcall+0x1a4/0x250
 [<c02a6d34>] sys_socketcall+0x1a4/0x250
 [generic_file_llseek+0/192] generic_file_llseek+0x0/0xc0
 [<c0149450>] generic_file_llseek+0x0/0xc0
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

pdflush       S 00000000     4 14969      1         14970 14266 (L-TLB)
d3611fb0 00000046 00000000 00000000 0000007b 0000007b f7941900 cbbef340 
       cbbef360 c3441fc0 00001c08 50c736ae 000014d5 c3441fe8 c3441fc0 f7941900 
       d3611fdc d3611fd0 d3610000 00000001 c0135a3e c0135b50 00000000 00000000 
Call Trace:
 [__pdflush+158/432] __pdflush+0x9e/0x1b0
 [<c0135a3e>] __pdflush+0x9e/0x1b0
 [pdflush+0/16] pdflush+0x0/0x10
 [<c0135b50>] pdflush+0x0/0x10
 [pdflush+11/16] pdflush+0xb/0x10
 [<c0135b5b>] pdflush+0xb/0x10
 [kernel_thread_helper+0/12] kernel_thread_helper+0x0/0xc
 [<c0107134>] kernel_thread_helper+0x0/0xc
 [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
 [<c0107139>] kernel_thread_helper+0x5/0xc

pdflush       S 00000000     4 14970      1               14969 (L-TLB)
ed921fb0 00000046 00000000 00000000 00000000 00000000 f71fe680 00000000 
       00000000 c343f3c0 00000f23 683463b9 00006a37 00000000 c343f3c0 f71fe680 
       ed921fdc ed921fd0 ed920000 00000001 c0135a3e c0135b50 00000000 00000000 
Call Trace:
 [__pdflush+158/432] __pdflush+0x9e/0x1b0
 [<c0135a3e>] __pdflush+0x9e/0x1b0
 [pdflush+0/16] pdflush+0x0/0x10
 [<c0135b50>] pdflush+0x0/0x10
 [pdflush+11/16] pdflush+0xb/0x10
 [<c0135b5b>] pdflush+0xb/0x10
 [kernel_thread_helper+0/12] kernel_thread_helper+0x0/0xc
 [<c0107134>] kernel_thread_helper+0x0/0xc
 [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
 [<c0107139>] kernel_thread_helper+0x5/0xc

sshd          S C5859EE8     0 15285    663 15286               (NOTLB)
c5859e6c 00000086 000000d0 c5859ee8 f78a1320 f7946558 cbbeed20 c1741418 
       00000000 c343f3c0 00001ae8 853694c1 00006a37 ee39d000 c343f3c0 cbbeed20 
       00000000 7fffffff 00000000 00000000 c0124414 f78a18c0 00000080 c0154ff3 
Call Trace:
 [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
 [<c0124414>] schedule_timeout+0x14/0xb0
 [pipe_poll+35/112] pipe_poll+0x23/0x70
 [<c0154ff3>] pipe_poll+0x23/0x70
 [do_select+671/736] do_select+0x29f/0x2e0
 [<c015a8bf>] do_select+0x29f/0x2e0
 [__pollwait+0/160] __pollwait+0x0/0xa0
 [<c015a4a0>] __pollwait+0x0/0xa0
 [select_bits_alloc+23/32] select_bits_alloc+0x17/0x20
 [<c015a917>] select_bits_alloc+0x17/0x20
 [sys_select+888/1328] sys_select+0x378/0x530
 [<c015aca8>] sys_select+0x378/0x530
 [tty_read+284/320] tty_read+0x11c/0x140
 [<c024be8c>] tty_read+0x11c/0x140
 [vfs_write+189/224] vfs_write+0xbd/0xe0
 [<c0149bcd>] vfs_write+0xbd/0xe0
 [vfs_write+209/224] vfs_write+0xd1/0xe0
 [<c0149be1>] vfs_write+0xd1/0xe0
 [sys_ioctl+544/605] sys_ioctl+0x220/0x25d
 [<c0159ef0>] sys_ioctl+0x220/0x25d
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

bash          S 00000001  6260 15286  15285 15335               (NOTLB)
d8b79f60 00000082 00000001 00000001 080c9f9c 00000000 cbbef340 00030002 
       00001000 c3439bc0 0001689a 8565bde0 000069c0 00000000 c3439bc0 cbbef340 
       00000001 fffffe00 cbbef340 00000002 c011f0d1 d8b78000 00000001 00000000 
Call Trace:
 [sys_wait4+577/640] sys_wait4+0x241/0x280
 [<c011f0d1>] sys_wait4+0x241/0x280
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

su            S 00000001     4 15335  15286 15336               (NOTLB)
d338df60 00000086 00000001 00000001 0804cd5c f7946228 e2379980 00000000 
       0000000f c3439bc0 0001192b fe9b69ca 000069c0 00000001 c3439bc0 e2379980 
       00000001 fffffe00 e2379980 00000002 c011f0d1 d338c000 00000001 00000000 
Call Trace:
 [sys_wait4+577/640] sys_wait4+0x241/0x280
 [<c011f0d1>] sys_wait4+0x241/0x280
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [<c0118ed0>] default_wake_function+0x0/0x20
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c010901b>] syscall_call+0x7/0xb

bash          R current      8 15336  15335                     (NOTLB)
00000000 f3c35e30 66336333 c02fd440 2000ffff 35333335 63737931 5f6c6c61 
       6c6c6163 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 c03ccb40 ffffffff f3c35ed0 
Call Trace:
 [call_console_drivers+240/256] call_console_drivers+0xf0/0x100
 [<c011cd80>] call_console_drivers+0xf0/0x100
 [call_console_drivers+240/256] call_console_drivers+0xf0/0x100
 [<c011cd80>] call_console_drivers+0xf0/0x100
 [show_trace+107/144] show_trace+0x6b/0x90
 [<c0109cab>] show_trace+0x6b/0x90
 [show_trace+107/144] show_trace+0x6b/0x90
 [<c0109cab>] show_trace+0x6b/0x90
 [show_stack+131/144] show_stack+0x83/0x90
 [<c0109d73>] show_stack+0x83/0x90
 [show_task+440/448] show_task+0x1b8/0x1c0
 [<c011a188>] show_task+0x1b8/0x1c0
 [show_state+75/128] show_state+0x4b/0x80
 [<c011a1db>] show_state+0x4b/0x80
 [__handle_sysrq_nolock+95/236] __handle_sysrq_nolock+0x5f/0xec
 [<c025d92f>] __handle_sysrq_nolock+0x5f/0xec
 [handle_sysrq+38/64] handle_sysrq+0x26/0x40
 [<c025d8b6>] handle_sysrq+0x26/0x40
 [write_sysrq_trigger+45/64] write_sysrq_trigger+0x2d/0x40
 [<c017447d>] write_sysrq_trigger+0x2d/0x40
 [vfs_write+170/224] vfs_write+0xaa/0xe0
 [<c0149bba>] vfs_write+0xaa/0xe0
 [sys_write+47/80] sys_write+0x2f/0x50
 [<c0149c6f>] sys_write+0x2f/0x50
 [syscall_call+7/11] syscall_call+0x7/0xb


pkill -9 postgres will get by this.

What else would be helpful for tracking this down?

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

