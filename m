Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVDBAcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVDBAcQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262978AbVDBA3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:29:08 -0500
Received: from freelists-180.iquest.net ([206.53.239.180]:22457 "EHLO
	turing.freelists.org") by vger.kernel.org with ESMTP
	id S262955AbVDBA1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 19:27:20 -0500
From: John Madden <weez@freelists.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11, nfsd, log_do_checkpoint()
Date: Fri, 1 Apr 2005 19:27:19 -0500
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504011927.19030.weez@freelists.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I woke up to a mostly-dead PE1850 this morning: 

Message from syslogd@storage at Fri Apr  1 06:19:14 2005 ...
storage kernel: Assertion failure in log_do_checkpoint() at 
fs/jbd/checkpoint.c:365: "drop_count != 0 || cleanup_ret != 0"

Message from syslogd@storage at Fri Apr  1 06:19:14 2005 ...
storage kernel: invalid operand: 0000 [1] SMP 

Full error:

Assertion failure in log_do_checkpoint() at fs/jbd/checkpoint.c:365: 
"drop_count != 0 || cleanup_ret != 0"
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at checkpoint:365
invalid operand: 0000 [1] SMP
CPU 1
Modules linked in:
Pid: 212, comm: nfsd Not tainted 2.6.11-rc5
RIP: 0010:[<ffffffff801eb9b5>] <ffffffff801eb9b5>{log_do_checkpoint+357}
RSP: 0000:ffff81003e6e99a8  EFLAGS: 00010296
RAX: 000000000000006e RBX: 0000000000000000 RCX: ffffffff803bbdc8
RDX: ffffffff803bbdc8 RSI: 0000000000000246 RDI: ffffffff803bbdc0
RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000003c8
R10: ffff81003f0ca4c0 R11: 0000000000000000 R12: 0000000000000000
R13: ffff81003eef5e00 R14: ffff81002fee1f50 R15: ffff81003eef5f5c
FS:  0000000000000000(0000) GS:ffffffff8044d600(0000) knlGS:0000000000000000
CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
CR2: 00000000556b29e0 CR3: 000000003e263000 CR4: 00000000000006e0
Process nfsd (pid: 212, threadinfo ffff81003e6e8000, task ffff81003e6e77f0)
Stack: 0000000000000246 2f3260b0802e1b50 ffff81001e1c09c0 0000000000000000
       00000000ffffffe0 0000000000000000 000000000000003b ffffffff802e0d99
       ffff81003e6e9a8c 0000000000000000
Call Trace:<ffffffff802e0d99>{sock_alloc_send_pskb+121} 
<ffffffff802ff0d7>{ip_append_data+871}
       <ffffffff801d797c>{ext3_get_block_handle+220} 
<ffffffff80170fe3>{bh_lru_install+275}
       <ffffffff801710d9>{__find_get_block+217} 
<ffffffff80171101>{__getblk+17}
       <ffffffff801d7e18>{ext3_getblk+200} 
<ffffffff801eb3f6>{__log_wait_for_space+166}
       <ffffffff801e732f>{start_this_handle+879} 
<ffffffff801e745e>{journal_start+158}
       <ffffffff801dd811>{ext3_create+49} <ffffffff8017d83c>{vfs_create+140}
       <ffffffff802113d5>{nfsd_create_v3+869} 
<ffffffff80217c9c>{nfsd3_proc_create+332}
       <ffffffff8020cda0>{nfsd_dispatch+272} 
<ffffffff8033aa7e>{svc_process+958}
       <ffffffff8020c930>{nfsd+0} <ffffffff8020cb10>{nfsd+480}
       <ffffffff8012afeb>{schedule_tail+11} <ffffffff8010ddab>{child_rip+8}
       <ffffffff8020c930>{nfsd+0} <ffffffff8020c930>{nfsd+0}
       <ffffffff8010dda3>{child_rip+0}

Code: 0f 0b 0c 69 36 80 ff ff ff ff 6d 01 49 8b 75 60 48 3b 74 24
RIP <ffffffff801eb9b5>{log_do_checkpoint+357} RSP <ffff81003e6e99a8>

nfsd was serving out a pretty heavily-used (2.5-million page web site) ext3 
partition on the 1850's built-in LSI/MPT controller.  I'm able to duplicate 
this somewhat consistently by putting nfsd under heavy load (say, by deleting 
20,000 files from a directory).

(Please Cc me on replies, I'm not subscribed.)

Thanks,
  John



-- 
# John Madden  weez@freelists.org: http://www.nerdarium.com
# FreeLists: Free mailing lists for all: http://www.freelists.org
# Linux, Apache, Perl and C: All the best things in life are free!
