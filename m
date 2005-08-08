Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbVHHDBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVHHDBJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 23:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbVHHDBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 23:01:09 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:40832 "EHLO
	out5.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750704AbVHHDBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 23:01:08 -0400
X-Sasl-enc: EkQJrBag66OthMCA6CJXc+1wyzBmWj9lEVm1E4Nv/L0B 1123470061
Message-ID: <066601c59bc5$6b565610$0b01a8c0@ROBMHP>
From: "Rob Mueller" <robm@fastmail.fm>
To: <linux-kernel@vger.kernel.org>
Cc: "Chris Mason" <mason@suse.com>
Subject: 2.6.12.3 lockup with lots of D state processes
Date: Mon, 8 Aug 2005 13:00:51 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a feeling this might be related back to this issue...

http://www.uwsg.iu.edu/hypermail/linux/kernel/0507.1/1518.html

As a reminder: we've been running a number of IBM x235 machines with 6G of 
RAM with a 2.6.12.3 kernel fine for a couple of weeks now. Last night one of 
the machines started locking up. We could still ssh into the machine, and 
run some commands (free, uptime, etc), but lots of commands would just lock 
up and never return (ps, top, etc). The machine mostly runs a cyrus imap 
server with a number of reiserfs partitions. The partitions are all mounted 
as below:

/dev/sda4 on /var/spool/imap type reiserfs
(rw,noatime,nodiratime,nolargeio=1,notail)

A full sysrq-t output (700k+) and kernel config are available here:

http://robm.fastmail.fm/kernel/t8/

This time it definitely is a full one. In times past it's been bigger than 
our 1M dmesg buffer. The trace seems to show lots of procs like this:

lmtpd         D F27E2A40     0 16479      1         16480 16451 (NOTLB)
dcb49e98 00000086 00000008 f27e2a40 f7878b1c f7c9fdfc 00000000 c016a9d2
       f7c9fdfc c0585800 c4293520 00000000 00004448 06aa7882 000227d8
c4293520
       c04c0bc0 f27e2a40 f27e2b64 ffffffff 00000002 00000001 f7c9fdfc
f7f30580
Call Trace:
 [<c016a9d2>] dput+0x32/0x1b0
 [<c041db88>] __down+0x88/0x100
 [<c0114960>] default_wake_function+0x0/0x20
 [<c041dd33>] __down_failed+0x7/0xc
 [<c01651ec>] .text.lock.namei+0xc4/0x1f8
 [<c0153996>] filp_open+0x36/0x60
 [<c0153d05>] sys_open+0x35/0x70
 [<c0102a15>] syscall_call+0x7/0xb

And a few looking something like this:

pop3d         D E67AA020     0 16368      1         16376 16296 (NOTLB)
d2c27bac 00000086 00000008 e67aa020 c02b5177 f785a220 00000282 c02b52ab
       2085a000 00000000 c4293520 00000000 00001a7f 8e0dd38c 000227d7
c4293520
       c04c0bc0 e67aa020 e67aa144 c03bffc5 00000002 00000000 80000000
d2c27ba0
Call Trace:
 [<c02b5177>] e100_xmit_frame+0x147/0x300
 [<c02b52ab>] e100_xmit_frame+0x27b/0x300
 [<c03bffc5>] qdisc_restart+0x15/0x1f0
 [<c01ad17d>] queue_log_writer+0x5d/0x80
 [<c0114960>] default_wake_function+0x0/0x20
 [<c01ad42a>] do_journal_begin_r+0x1ca/0x2b0
 [<c03ca6d5>] ip_queue_xmit+0x425/0x4c0
 [<c03ca6f7>] ip_queue_xmit+0x447/0x4c0
 [<c01ad73e>] journal_begin+0x8e/0xe0
 [<c019dae8>] reiserfs_dirty_inode+0x48/0x90
 [<c011d690>] current_fs_time+0x50/0x70
 [<c017521d>] __mark_inode_dirty+0x2d/0x170
 [<c016dabf>] inode_update_time+0xaf/0xc0
 [<c01392d4>] __generic_file_aio_write_nolock+0x514/0x5f0
 [<c01625dc>] __link_path_walk+0xadc/0xd40
 [<c03cf43d>] tcp_sendmsg+0x39d/0x1000
 [<c016a9d2>] dput+0x32/0x1b0
 [<c0142ec8>] kmap_high+0x18/0x1e0
 [<c01394ce>] __generic_file_write_nolock+0x9e/0xc0
 [<c016baf9>] __d_lookup+0x109/0x140
 [<c016a9d2>] dput+0x32/0x1b0
 [<c01625dc>] __link_path_walk+0xadc/0xd40
 [<c012c200>] autoremove_wake_function+0x0/0x40
 [<c01396ce>] generic_file_write+0x4e/0xc0
 [<c019949f>] reiserfs_file_write+0x17f/0x190
 [<c01628d7>] link_path_walk+0x97/0xd0
 [<c0224510>] copy_to_user+0x60/0x70
 [<c015de83>] cp_new_stat64+0xf3/0x110
 [<c015423b>] default_llseek+0xbb/0xd0
 [<c015476e>] vfs_write+0x8e/0xf0
 [<c015487d>] sys_write+0x3d/0x70
 [<c0102a15>] syscall_call+0x7/0xb

As an additional, we have applied this patch to the kernel to try and work
around a previously identified deadlock situation in reiserfs.

>--- file.c~ 2004-10-02 12:29:33.223660850 +0400
>+++ file.c 2004-10-08 10:03:03.001561661 +0400
>@@ -1137,6 +1137,8 @@
> return result;
>     }
>
>+    return generic_file_write(file, buf, count, ppos);
>+
>     if ( unlikely((ssize_t) count < 0 ))
>         return -EINVAL;

Does this new lockup appear to be a remanifestation of the old problem, or
does it appear to be something new...

Rob

