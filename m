Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbTI3Sjx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 14:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbTI3Sjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 14:39:53 -0400
Received: from newpeace.netnation.com ([204.174.223.7]:52714 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP id S261551AbTI3Sjt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 14:39:49 -0400
Date: Tue, 30 Sep 2003 11:39:48 -0700
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test5-bk13] SIGSTOPping tar extraction process causes other I/O processes to block
Message-ID: <20030930183948.GA31055@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I was extracting a large tarball of 2 MB image files and running and
apt-get remove at the same time, realized the disk was thrashing back
and forth, and decided to suspend the tar process until the apt-get was
finished.  When I suspended the tar, apt-get never finished.  Right-alt
SysRQ (SysRQ-T) dumped the following traces for the processes in
question:

bzip2         T FF76E8E2 4085526852 12770  12572         12798 12771 (NOTLB)
c15c1edc 00000082 ccd6c680 ff76e8e2 0001359c 00000020 ff76e8e2 0001359c 
       ccd6c680 0000b06a ff76ec83 0001359c cdd7e040 cdd7e040 00000014 c15c0000
       ffffe000 c012714a cdd7e040 ccd6c680 c01274b2 ffffffff cdd7e604 c15c1f28
Call Trace:
 [finish_stop+58/112] finish_stop+0x3a/0x70
 [get_signal_to_deliver+498/768] get_signal_to_deliver+0x1f2/0x300
 [do_signal+143/272] do_signal+0x8f/0x110
 [update_wall_time+22/64] update_wall_time+0x16/0x40
 [do_timer+224/240] do_timer+0xe0/0xf0
 [vfs_read+210/304] vfs_read+0xd2/0x130
 [sys_read+66/112] sys_read+0x42/0x70  
 [do_notify_resume+55/60] do_notify_resume+0x37/0x3c
 [work_notifysig+19/21] work_notifysig+0x13/0x15

tar           T FEA3C232 3974507824 12771  12572         12770       (NOTLB)
c4941edc 00000086 ccd6c680 fea3c232 0001359c 00000020 fea3c232 0001359c 
       ccd6c680 00001233 fea3c5da 0001359c d7adcce0 d7adcce0 00000014 c4940000
       ffffe000 c012714a d7adcce0 ccd6c680 c01274b2 ffffffff d7add2a4 c4941f28
Call Trace:
 [finish_stop+58/112] finish_stop+0x3a/0x70
 [get_signal_to_deliver+498/768] get_signal_to_deliver+0x1f2/0x300
 [do_signal+143/272] do_signal+0x8f/0x110
 [update_wall_time+22/64] update_wall_time+0x16/0x40
 [update_wall_time+22/64] update_wall_time+0x16/0x40
 [do_IRQ+197/240] do_IRQ+0xc5/0xf0
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [do_notify_resume+55/60] do_notify_resume+0x37/0x3c
 [work_notifysig+19/21] work_notifysig+0x13/0x15

apt-get       D 486059B9 3973698352 12775  12798                     (NOTLB)  
c44cbedc 00000082 c4fbb9a0 486059b9 0001359c c44cbf3c 486059b9 0001359c 
       c4fbb9a0 00001093 4860a293 0001359c d772c6e0 c44ca000 00140f93 d7d01ea0
       d7d01ee4 c018e84b d28e3eb0 c0119b20 00000286 c1e51d20 d7d01ef4 c44ca000
Call Trace:
 [log_wait_commit+315/384] log_wait_commit+0x13b/0x180
 [schedule+768/1360] schedule+0x300/0x550             
 [default_wake_function+0/48] default_wake_function+0x0/0x30
 [__log_start_commit+128/160] __log_start_commit+0x80/0xa0
 [journal_stop+482/752] journal_stop+0x1e2/0x2f0
 [journal_start+173/224] journal_start+0xad/0xe0
 [journal_force_commit+51/64] journal_force_commit+0x33/0x40
 [ext3_force_commit+41/48] ext3_force_commit+0x29/0x30      
 [msync_interval+227/256] msync_interval+0xe3/0x100
 [sys_msync+287/299] sys_msync+0x11f/0x12b
 [syscall_call+7/11] syscall_call+0x7/0xb                   

I hope this is enough information to be useful.  If not, I can try
reproducing the issue.  The apt-get process finished properly when I
foregrounded (resumed) the tar process.

Possibly useful portions of .config (full .config available on request):

CONFIG_M686=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set

Simon-

[        Simon Kirby        ][        Network Operations        ]
[     sim@netnation.com     ][   NetNation Communications Inc.  ]
[  Opinions expressed are not necessarily those of my employer. ]
