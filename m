Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264965AbUFTNFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264965AbUFTNFh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 09:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUFTNFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 09:05:37 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:38013 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264965AbUFTNF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 09:05:28 -0400
Message-ID: <40D58B93.4040304@yahoo.com.au>
Date: Sun, 20 Jun 2004 23:05:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Schniedermeyer <ms@citd.de>
CC: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: Kernel 2.6.6 & 2.6.7 sometime hang after much I/O
References: <Pine.LNX.4.44.0406201123240.26522-100000@korben.citd.de> <40D56700.2030206@yahoo.com.au> <20040620115908.GA27241@citd.de>
In-Reply-To: <20040620115908.GA27241@citd.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer wrote:

> Here we go.
> 
> Addendum: After some time more and more konsole froze. Up to the point
> where i (had to) kill(ed) X(CTRL-ALT-Backspace) and after i couldn't
> even log in at the console anymore i rebooted (into 2.6.5). Then i
> recompiled 2.6.7 with SYSRQ-support and tried to reproduce the hanging
> without X. After 3 runs i "gave up" and started X. Here i had luck and
> the process ('cut-movie.pl') froze at first try. Then i killed X and did
> the above on the console.
> 
> As the system is currently unsuable enough to reboot, i will reboot in
> 2.6.5 after this mail, but i can always reboot into 2.6.7 if you need
> more input.
> 
> 

The attached trace was with 2.6.7, right? Can you reproduce the hang,
then, as root, do:

	echo 1024 > /sys/block/sda/queue/nr_requests

Replace sda with whatever devices your hung processes were
doing IO to. Do things start up again?


Interesting parts of dmesg.gz...

syslogd       D C2828BE0     0  1432      1          1435  1134 (NOTLB)
f7817ce4 00000086 f7242290 c2828be0 00000000 00000000 f78584c0 c16f1780
        c16f2d40 c16f1760 c04fca38 00000000 c0123dc0 f7817cf8 e2083440 c2828be0
        00000cbb ffe58e20 000000a2 f7242440 00063f67 f7817cf8 f7817d54 f7817d28
Call Trace:
  [<c0123dc0>] del_timer_sync+0x40/0x150
  [<c03d756c>] schedule_timeout+0x6c/0xc0
  [<c01247f0>] process_timeout+0x0/0x10
  [<c0119f80>] autoremove_wake_function+0x0/0x60
  [<c03d745b>] io_schedule_timeout+0x2b/0xd0
  [<c029b00f>] blk_congestion_wait+0x7f/0xa0
  [<c0119f80>] autoremove_wake_function+0x0/0x60
  [<c0119f80>] autoremove_wake_function+0x0/0x60
  [<c013a933>] get_dirty_limits+0x13/0xd0
  [<c013aada>] balance_dirty_pages+0xea/0x150
  [<c0199182>] reiserfs_file_write+0x652/0x7e0
  [<c03d6d9e>] schedule+0x2ee/0x5f0
  [<c036eb9c>] sockfd_lookup+0x1c/0x80
  [<c03704e2>] sys_recvfrom+0x102/0x120
  [<c03755ab>] datagram_poll+0x2b/0xca
  [<c0163e14>] poll_freewait+0x44/0x50
  [<c026d9f3>] copy_from_user+0x53/0x80
  [<c0150ffa>] do_readv_writev+0x19a/0x280
  [<c0198b30>] reiserfs_file_write+0x0/0x7e0
  [<c01511a8>] vfs_writev+0x58/0x70
  [<c0151272>] sys_writev+0x42/0x70
  [<c0105edf>] syscall_call+0x7/0xb

...

tee           D C2828BE0     0  2174   2172                     (NOTLB)
e6567d4c 00000086 00000000 c2828be0 c2829540 c04fca38 f727c2c0 c15c007b
        c16b007b ffffff00 c04fca38 00000000 c0123dc0 e6567d60 00000000 c2828be0
        000001b4 ffc6f6e4 000000a2 f725fa60 00063f65 e6567d60 e6567dbc e6567d90
Call Trace:
  [<c0123dc0>] del_timer_sync+0x40/0x150
  [<c03d756c>] schedule_timeout+0x6c/0xc0
  [<c01247f0>] process_timeout+0x0/0x10
  [<c0119f80>] autoremove_wake_function+0x0/0x60
  [<c03d745b>] io_schedule_timeout+0x2b/0xd0
  [<c029b00f>] blk_congestion_wait+0x7f/0xa0
  [<c0119f80>] autoremove_wake_function+0x0/0x60
  [<c0119f80>] autoremove_wake_function+0x0/0x60
  [<c013a933>] get_dirty_limits+0x13/0xd0
  [<c013aada>] balance_dirty_pages+0xea/0x150
  [<c0199182>] reiserfs_file_write+0x652/0x7e0
  [<c015d463>] pipe_wait+0xa3/0xc0
  [<c016b409>] update_atime+0xd9/0xe0
  [<c015d6d3>] pipe_readv+0x253/0x2d0
  [<c015d788>] pipe_read+0x38/0x40
  [<c0150bc8>] vfs_write+0xb8/0x130
  [<c0150cf2>] sys_write+0x42/0x70
  [<c0105edf>] syscall_call+0x7/0xb

login         D C2828BE0     0  2175      1          2238  2172 (NOTLB)
e57a5d4c 00000082 f7217360 c2828be0 c2829540 00000000 f738f980 c16f2b60
        c1054d00 c2830be0 c04fca38 00000000 c0123dc0 e57a5d60 f7242290 c2828be0
        00000ee1 ffe58165 000000a2 f7217510 00063f67 e57a5d60 e57a5dbc e57a5d90
Call Trace:
  [<c0123dc0>] del_timer_sync+0x40/0x150
  [<c03d756c>] schedule_timeout+0x6c/0xc0
  [<c01247f0>] process_timeout+0x0/0x10
  [<c0119f80>] autoremove_wake_function+0x0/0x60
  [<c03d745b>] io_schedule_timeout+0x2b/0xd0
  [<c029b00f>] blk_congestion_wait+0x7f/0xa0
  [<c0119f80>] autoremove_wake_function+0x0/0x60
  [<c0119f80>] autoremove_wake_function+0x0/0x60
  [<c013a933>] get_dirty_limits+0x13/0xd0
  [<c013aada>] balance_dirty_pages+0xea/0x150
  [<c0199182>] reiserfs_file_write+0x652/0x7e0
  [<c01457b0>] handle_mm_fault+0xf0/0x160
  [<c0114c1c>] do_page_fault+0x13c/0x561
  [<c0150bc8>] vfs_write+0xb8/0x130
  [<c0150cf2>] sys_write+0x42/0x70
  [<c0105edf>] syscall_call+0x7/0xb

kdeinit       D C2828BE0     0  2238      1          3266  2175 (NOTLB)
dd999d4c 00200086 00000000 c2828be0 c2829540 00000000 f7858900 c16f1760
        c16f70e0 c15cf260 c04fca38 00000000 c0123dc0 dd999d60 00000000 c2828be0
        000002ec ffa884e8 000000a2 c2b57330 00063f63 dd999d60 dd999dbc dd999d90
Call Trace:
  [<c0123dc0>] del_timer_sync+0x40/0x150
  [<c03d756c>] schedule_timeout+0x6c/0xc0
  [<c01247f0>] process_timeout+0x0/0x10
  [<c0119f80>] autoremove_wake_function+0x0/0x60
  [<c03d745b>] io_schedule_timeout+0x2b/0xd0
  [<c029b00f>] blk_congestion_wait+0x7f/0xa0
  [<c0119f80>] autoremove_wake_function+0x0/0x60
  [<c0119f80>] autoremove_wake_function+0x0/0x60
  [<c013a933>] get_dirty_limits+0x13/0xd0
  [<c013aada>] balance_dirty_pages+0xea/0x150
  [<c0199182>] reiserfs_file_write+0x652/0x7e0
  [<c0145234>] do_anonymous_page+0x154/0x1a0
  [<c01457b0>] handle_mm_fault+0xf0/0x160
  [<c0114c1c>] do_page_fault+0x13c/0x561
  [<c0147297>] do_mmap_pgoff+0x3c7/0x6d0
  [<c0150bc8>] vfs_write+0xb8/0x130
  [<c0150cf2>] sys_write+0x42/0x70
  [<c0105edf>] syscall_call+0x7/0xb

cut-movie.pl  D C2828BE0     0  3266      1                2238 (NOTLB)
ea2c9c20 00200086 00000000 c2828be0 c2829540 c043f42c f02ba6c0 00000000
        c0108289 00000000 c04fca38 00000000 c0123dc0 ea2c9c34 00000000 c2828be0
        00000a95 ffe598b5 000000a2 e20835f0 00063f67 ea2c9c34 ea2c9c90 ea2c9c64
Call Trace:
  [<c0108289>] handle_IRQ_event+0x49/0x80
  [<c0123dc0>] del_timer_sync+0x40/0x150
  [<c03d756c>] schedule_timeout+0x6c/0xc0
  [<c01247f0>] process_timeout+0x0/0x10
  [<c0119f80>] autoremove_wake_function+0x0/0x60
  [<c03d745b>] io_schedule_timeout+0x2b/0xd0
  [<c029b00f>] blk_congestion_wait+0x7f/0xa0
  [<c0119f80>] autoremove_wake_function+0x0/0x60
  [<c0119f80>] autoremove_wake_function+0x0/0x60
  [<c013a933>] get_dirty_limits+0x13/0xd0
  [<c013aada>] balance_dirty_pages+0xea/0x150
  [<c0154d9d>] generic_commit_write+0x7d/0xa0
  [<c01374d1>] generic_file_aio_write_nolock+0x4d1/0xb90
  [<c023a194>] xfs_log_move_tail+0x24/0x180
  [<c024a416>] xfs_trans_unlocked_item+0x56/0x60
  [<c0260067>] xfs_write+0x287/0x8a0
  [<c010c599>] timer_interrupt+0x59/0x120
  [<c025b6fe>] linvfs_write+0xbe/0x130
  [<c0150ad9>] do_sync_write+0x89/0xc0
  [<c01246e0>] do_timer+0xc0/0xd0
  [<c0117efd>] scheduler_tick+0x11d/0x4c0
  [<c0120075>] __do_softirq+0xb5/0xc0
  [<c0117efd>] scheduler_tick+0x11d/0x4c0
  [<c0150bc8>] vfs_write+0xb8/0x130
  [<c0120075>] __do_softirq+0xb5/0xc0
  [<c0150cf2>] sys_write+0x42/0x70
  [<c0105edf>] syscall_call+0x7/0xb

