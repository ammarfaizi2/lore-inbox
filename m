Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265766AbUF2OjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265766AbUF2OjY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 10:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265774AbUF2OjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 10:39:24 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:15037 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S265766AbUF2OjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 10:39:18 -0400
X-Sasl-enc: Wx5dlqASAMf+r7z8+V3Qbw 1088519957
Message-ID: <006a01c45de6$e4442930$62afc742@ROBMHP>
From: "Rob Mueller" <robm@fastmail.fm>
To: <linux-kernel@vger.kernel.org>
Subject: Processes stuck in unkillable D state (2.4 and 2.6)
Date: Tue, 29 Jun 2004 07:39:31 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2149
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2149
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Over the past several years, we've observed a problem on our email servers 
(cyrus, postfix, mod_perl) where processes get stuck in an unkillable D 
state. This has happened to more or less a degree in every kernel we've 
tried from 2.4.18 up and all the 2.6 series.

The actual frequency of this occuring has varied, from extremely rarely, to
almost every day, but there have been some constants:
1. It always occurs with the more IO related processes (eg almost always
cyrus imapd procs, though it has been mysqld and postfix procs rarely)
2. It tends to occur when our system is using less CPU, and is more IO bound

Recently we did some optimising of our web-interface, and the machines have 
again become more IO bound, and so the problem is occuring more frequently 
again. This time however, we we have been able to use the sys-req interface 
to try and gather some more information.

Basic system details:
* 2.6.4-mm2 (but the problem has been seen with just above everything 
between 2.4.18 -> 2.6.4-mm2, which is the latest we've tried)
* deadline scheduler (again, only a recent change)
* PAE, high-pte (but pretty sure I've seen on a non-PAE kernel as well)
* IBM x235 dual Xeon. 6G RAM. ServeRAID 5i controller. reiserfs. UMEM 
non-volatile RAM drive for reiserfs journals + other stuff.

In this case, we observed two processes stuck in D state (totally 
unkillable). The 2 most interesting things were:
1. The processes got stuck at completely different times (about 2 days 
apart)
2. They had exactly the same sys-req trace output (see below), which seems 
suspicious given they got stuck so far apart, it suggests something 
particular about that code path...

I'm not sure if this is a hardware problem, a driver problem or some 
specific sequence of events that results in a deadlock. I guess I'm hoping 
these back traces will provide some insight.

Jun 29 08:01:52 server2 kernel: imapd         D 0000001E     0  5873      1
15071  2338 (NOTLB)
Jun 29 08:01:52 server2 kernel: eaad5bc4 00000082 00000e1a 0000001e eaad5ba4
eaad5ba0 ef64a640 c49138e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 e9f3a6a0 eaad5000
c04acd80 c4913ce0 00000328 0780a0cd
Jun 29 08:01:52 server2 kernel:        000173d1 c4913ce0 c03f11a0 d2464620
d24647d8 c4b21000 00000002 c4b21000
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c011a878>] io_schedule+0x28/0x40
Jun 29 08:01:52 server2 kernel:  [<c0132feb>] __lock_page+0xbb/0xe0
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c0133f6f>] filemap_nopage+0x21f/0x350
Jun 29 08:01:52 server2 kernel:  [<c0141dd4>] do_no_page+0xb4/0x390
Jun 29 08:01:52 server2 kernel:  [<c013fb57>] pte_alloc_map+0xf7/0x120
Jun 29 08:01:52 server2 kernel:  [<c0142277>] handle_mm_fault+0xc7/0x1e0
Jun 29 08:01:52 server2 kernel:  [<c0115a9d>] do_page_fault+0x13d/0x52a
Jun 29 08:01:52 server2 kernel:  [<c0150b80>] __wait_on_buffer+0xf0/0x100
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c013f3c5>] set_page_address+0x25/0x191
Jun 29 08:01:52 server2 kernel:  [<c013ecf4>] kmap_high+0x184/0x1c0
Jun 29 08:01:52 server2 kernel:  [<c0115960>] do_page_fault+0x0/0x52a
Jun 29 08:01:52 server2 kernel:  [<c0393a13>] error_code+0x2f/0x38
Jun 29 08:01:52 server2 kernel:  [<c019073f>]
reiserfs_copy_from_user_to_file_region+0x8f/0x100
Jun 29 08:01:52 server2 kernel:  [<c0191a07>]
reiserfs_file_write+0x617/0x730
Jun 29 08:01:52 server2 kernel:  [<c01a5f56>] journal_end+0x16/0x20
Jun 29 08:01:52 server2 kernel:  [<c0189b51>] reiserfs_link+0x171/0x1a0
Jun 29 08:01:52 server2 kernel:  [<c016522c>] dput+0x1c/0x1b0
Jun 29 08:01:52 server2 kernel:  [<c016522c>] dput+0x1c/0x1b0
Jun 29 08:01:52 server2 kernel:  [<c015c270>] path_release+0x10/0x30
Jun 29 08:01:52 server2 kernel:  [<c015e916>] sys_link+0xc6/0xe0
Jun 29 08:01:52 server2 kernel:  [<c014fa5a>] vfs_write+0xaa/0xe0
Jun 29 08:01:52 server2 kernel:  [<c014f4e0>] default_llseek+0x0/0x110
Jun 29 08:01:52 server2 kernel:  [<c014fb0f>] sys_write+0x2f/0x50
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:  [<c039007b>] svcauth_gss_accept+0x8b/0x720


Jun 29 08:01:52 server2 kernel: imapd         D 0000001D     0 15071      1
5873 (NOTLB)
Jun 29 08:01:52 server2 kernel: c9a3cbc4 00000082 c4b3d800 0000001d c9a3cba4
f4366e40 00000293 f4366e40
Jun 29 08:01:52 server2 kernel:        c4b0fc00 c4b3d800 c4b17800 c9a3c000
c04acd80 c491c6e0 0000044a cc1b4998
Jun 29 08:01:52 server2 kernel:        000173bb c491c6e0 c494c5e0 c80bc0f0
c80bc2a8 c4b17800 00000004 c4b17800
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c011a878>] io_schedule+0x28/0x40
Jun 29 08:01:52 server2 kernel:  [<c0132feb>] __lock_page+0xbb/0xe0
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c0133f6f>] filemap_nopage+0x21f/0x350
Jun 29 08:01:52 server2 kernel:  [<c0141dd4>] do_no_page+0xb4/0x390
Jun 29 08:01:52 server2 kernel:  [<c013fb57>] pte_alloc_map+0xf7/0x120
Jun 29 08:01:52 server2 kernel:  [<c0142277>] handle_mm_fault+0xc7/0x1e0
Jun 29 08:01:52 server2 kernel:  [<c0115a9d>] do_page_fault+0x13d/0x52a
Jun 29 08:01:52 server2 kernel:  [<c0150b80>] __wait_on_buffer+0xf0/0x100
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c013f3c5>] set_page_address+0x25/0x191
Jun 29 08:01:52 server2 kernel:  [<c013ecf4>] kmap_high+0x184/0x1c0
Jun 29 08:01:52 server2 kernel:  [<c0115960>] do_page_fault+0x0/0x52a
Jun 29 08:01:52 server2 kernel:  [<c0393a13>] error_code+0x2f/0x38
Jun 29 08:01:52 server2 kernel:  [<c019073f>]
reiserfs_copy_from_user_to_file_region+0x8f/0x100
Jun 29 08:01:52 server2 kernel:  [<c0191a07>]
reiserfs_file_write+0x617/0x730
Jun 29 08:01:52 server2 kernel:  [<c01a5f56>] journal_end+0x16/0x20
Jun 29 08:01:52 server2 kernel:  [<c0189b51>] reiserfs_link+0x171/0x1a0
Jun 29 08:01:52 server2 kernel:  [<c016522c>] dput+0x1c/0x1b0
Jun 29 08:01:52 server2 kernel:  [<c016522c>] dput+0x1c/0x1b0
Jun 29 08:01:52 server2 kernel:  [<c015c270>] path_release+0x10/0x30
Jun 29 08:01:52 server2 kernel:  [<c015e916>] sys_link+0xc6/0xe0
Jun 29 08:01:52 server2 kernel:  [<c014fa5a>] vfs_write+0xaa/0xe0
Jun 29 08:01:52 server2 kernel:  [<c014f4e0>] default_llseek+0x0/0x110
Jun 29 08:01:52 server2 kernel:  [<c014fb0f>] sys_write+0x2f/0x50
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:  [<c039007b>] svcauth_gss_accept+0x8b/0x720
Jun 29 08:01:52 server2 kernel:

I can post the machines dmesg boot log and kernel config if it will help.

Since it takes anwhere from 1 day to 2 weeks for one of these stuck procs to 
appear, testing changes is not going  to be a quick process though...

Rob

