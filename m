Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264635AbTF0PJd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 11:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264608AbTF0PHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 11:07:10 -0400
Received: from newweb.speedscript.com ([66.139.78.154]:1178 "EHLO
	mail.speedscript.com") by vger.kernel.org with ESMTP
	id S264543AbTF0PGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 11:06:17 -0400
Subject: Process stuck in 'D' "schedule_timeout" state with 2.5.73-mm1
From: Hal Duston <hduston@speedscript.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1056727230.3743.22.camel@ulysseus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 27 Jun 2003 10:20:30 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had problems in 2.5.73-mm1 with processes getting stuck in 'D'
state.  The machine itself will be basically idle at the time, and the
processes will remain stuck indefinitely.  Sometimes I can kill one of
them and any others will begin to progress again.  Other times I can't
kill any of them and can only reboot the system.  I have obtained some
callback traces of a couple of simultaneously hung processes.


rsync         D CF175ADC  2199   2091                     (NOTLB)
cf175ac4 00000082 00000246 cf175adc cf175ac4 00000246 d0dd2080 000498d6 
       cf175adc c03c1ad0 cf175b04 c0123be3 c02d54cc 0000040b c02d722a
c03b04e0 
       d43c7adc c5c27adc 000498d6 4b87ad6e c0123b53 d0dd2080 c031c980
d0dd2080 
Call Trace:
 [<c0123be3>] sleepo_schedule_timeout+0x84/0x111
 [<c0123b53>] process_timeout+0x0/0xc
 [<c011a487>] sleepo_io_schedule_timeout+0x3e/0x5b
 [<c023fa38>] blk_congestion_wait_wq+0xcc/0xe5
 [<c011ab57>] autoremove_wake_function+0x0/0x4b
 [<c011ab57>] autoremove_wake_function+0x0/0x4b
 [<c013a270>] balance_dirty_pages+0x1cc/0x228
 [<c01372ba>] generic_file_aio_write_nolock+0x4c0/0xb02
 [<c01bed6a>] search_for_position_by_key+0x1c2/0x3e4
 [<c01379a0>] generic_file_write_nolock+0xa4/0xbd
 [<c0297ffe>] tcp_recvmsg+0x37c/0x84a
 [<c011ab57>] autoremove_wake_function+0x0/0x4b
 [<c02b61fd>] inet_recvmsg+0x54/0x6c
 [<c0137b82>] generic_file_write+0x9c/0x10e
 [<c01b0ec0>] reiserfs_file_write+0x52/0x604
 [<c011ab57>] autoremove_wake_function+0x0/0x4b
 [<c016032f>] __pollwait+0x0/0xa9
 [<c0224f25>] write_chan+0x0/0x281
 [<c014ece9>] vfs_write+0xaf/0x119
 [<c010f0cd>] do_gettimeofday+0x19/0x90
 [<c014edef>] sys_write+0x3f/0x5d
 [<c010a14b>] syscall_call+0x7/0xb

and

ebuild.sh     D C5C27ADC 14552  14551                     (NOTLB)
c5c27ac4 00000086 00000246 c5c27adc c5c27ac4 00000246 dd64e080 000498d6 
       c5c27adc c03c1ad0 c5c27b04 c0123be3 c02d54cc 0000040b c02d722a
c03b04e0 
       cf175adc c031d038 000498d6 4b87ad6e c0123b53 dd64e080 c031c980
dd64e080 
Call Trace:
 [<c0123be3>] sleepo_schedule_timeout+0x84/0x111
 [<c0123b53>] process_timeout+0x0/0xc
 [<c011a487>] sleepo_io_schedule_timeout+0x3e/0x5b
 [<c023fa38>] blk_congestion_wait_wq+0xcc/0xe5
 [<c011ab57>] autoremove_wake_function+0x0/0x4b
 [<c011ab57>] autoremove_wake_function+0x0/0x4b
 [<c013a270>] balance_dirty_pages+0x1cc/0x228
 [<c01372ba>] generic_file_aio_write_nolock+0x4c0/0xb02
 [<c01be23a>] search_by_key+0x54a/0xeb8
 [<c01ac529>] reiserfs_update_sd+0x1b5/0x21c
 [<c01379a0>] generic_file_write_nolock+0xa4/0xbd
 [<c011ab57>] autoremove_wake_function+0x0/0x4b
 [<c01390ac>] buffered_rmqueue+0xb1/0x134
 [<c011ad2b>] mm_init+0x98/0xd7
 [<c01391b8>] __alloc_pages+0x89/0x321
 [<c0137b82>] generic_file_write+0x9c/0x10e
 [<c01b0ec0>] reiserfs_file_write+0x52/0x604
 [<c0135516>] unlock_page+0x16/0x50
 [<c0141803>] do_wp_page+0x52/0x325
 [<c014276a>] handle_mm_fault+0x140/0x14f
 [<c0117ddd>] do_page_fault+0x18d/0x50b
 [<c015f027>] locate_fd+0xa9/0x121
 [<c014dfcd>] dentry_open+0xd1/0x1be
 [<c014ece9>] vfs_write+0xaf/0x119
 [<c014edef>] sys_write+0x3f/0x5d
 [<c010a14b>] syscall_call+0x7/0xb





