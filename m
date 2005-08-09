Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbVHIDQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbVHIDQy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 23:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVHIDQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 23:16:54 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57800 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932431AbVHIDQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 23:16:53 -0400
X-Sasl-enc: 7O+ISGwPSs+vP3PbX9tAIr/45gRGKgDJaAXQChpuv+5v 1123557407
Message-ID: <080801c59c90$c95bfdc0$0b01a8c0@ROBMHP>
From: "Rob Mueller" <robm@fastmail.fm>
To: <linux-kernel@vger.kernel.org>,
       "Reiserfs developers mail-list" <Reiserfs-Dev@namesys.com>
Cc: "Chris Mason" <mason@suse.com>, "Jeremy Howard" <jhoward@fastmail.fm>,
       "Bron Gondwana" <brong@fastmail.fm>
Subject: Re: 2.6.12.3 lockup with lots of D state processes
Date: Tue, 9 Aug 2005 13:16:39 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just an update to this, I've found some more information. I can now reliably 
reproduce this lock up.

I was trying to remove a large number of files from a reiserfs partition

nohup rm -rf /var/spool/imap3/?/user/.migrated/*&

And just a second or two after I started that command, I got a message on 
the console and the following in the log:

Aug  8 22:37:13 server1 kernel: REISERFS: panic (device sdc3): journal-1413: 
journal_mark_dirty: j_len (1024) is too big
Aug  8 22:37:13 server1 kernel:
Aug  8 22:37:13 server1 kernel: ------------[ cut here ]------------
Aug  8 22:37:13 server1 kernel: kernel BUG at fs/reiserfs/prints.c:362!
Aug  8 22:37:13 server1 kernel: invalid operand: 0000 [#1]
Aug  8 22:37:13 server1 kernel: SMP
Aug  8 22:37:13 server1 kernel: Modules linked in:
Aug  8 22:37:13 server1 kernel: CPU:    3
Aug  8 22:37:13 server1 kernel: EIP:    0060:[<c01a0118>]    Not tainted VLI
Aug  8 22:37:13 server1 kernel: EFLAGS: 00010282   (2.6.12.3-reiserfix-big)
Aug  8 22:37:13 server1 kernel: EIP is at reiserfs_panic+0x38/0x60
Aug  8 22:37:13 server1 kernel: eax: 00000063   ebx: c044a2e0   ecx: 
f4593b10   edx: c0451280
Aug  8 22:37:13 server1 kernel: esi: f6f4f800   edi: f6f4f958   ebp: 
f56ef868   esp: f4593b0c
Aug  8 22:37:13 server1 kernel: ds: 007b   es: 007b   ss: 0068
Aug  8 22:37:13 server1 kernel: Process rm (pid: 4216, threadinfo=f4592000 
task=e3293020)
Aug  8 22:37:13 server1 kernel: Stack: c0451280 f6f4f958 c06cf5a0 c0453860 
f4593b38 f6f4f800 f8fc3000 00000000
Aug  8 22:37:13 server1 kernel:        c01ad8ad f6f4f800 c0453860 00000400 
f56ef868 00000000 f56ef868 f6f4f800
Aug  8 22:37:13 server1 kernel:        000005c5 f8fbc000 c018b052 f4593f0c 
f6f4f800 f56ef868 f585f834 f6e5d000
Aug  8 22:37:13 server1 kernel: Call Trace:
Aug  8 22:37:13 server1 kernel:  [<c01ad8ad>] journal_mark_dirty+0x11d/0x250
Aug  8 22:37:13 server1 kernel:  [<c018b052>] 
_reiserfs_free_block+0xe2/0x150
Aug  8 22:37:13 server1 kernel:  [<c018b0ed>] reiserfs_free_block+0x2d/0x50
Aug  8 22:37:13 server1 kernel:  [<c01a67c4>] 
prepare_for_delete_or_cut+0x604/0x6a0
Aug  8 22:37:13 server1 kernel:  [<c01a767a>] 
reiserfs_cut_from_item+0xda/0x480
Aug  8 22:37:13 server1 kernel:  [<c0156d3e>] __find_get_block+0xee/0x100
Aug  8 22:37:13 server1 kernel:  [<c01ad73e>] journal_begin+0x8e/0xe0
Aug  8 22:37:13 server1 kernel:  [<c01a7de6>] 
reiserfs_do_truncate+0x346/0x4b0
Aug  8 22:37:13 server1 kernel:  [<c01a71b2>] 
reiserfs_delete_object+0x32/0x60
Aug  8 22:37:13 server1 kernel:  [<c0191dd5>] 
reiserfs_delete_inode+0x65/0xc0
Aug  8 22:37:13 server1 kernel:  [<c0223e67>] _atomic_dec_and_lock+0x27/0x50
Aug  8 22:37:13 server1 kernel:  [<c0191d70>] reiserfs_delete_inode+0x0/0xc0
Aug  8 22:37:13 server1 kernel:  [<c016d6dd>] generic_delete_inode+0x7d/0xe0
Aug  8 22:37:13 server1 kernel:  [<c016d8e3>] iput+0x63/0x70
Aug  8 22:37:13 server1 kernel:  [<c016413f>] sys_unlink+0xcf/0x120
Aug  8 22:37:13 server1 kernel:  [<c0102a15>] syscall_call+0x7/0xb
Aug  8 22:37:13 server1 kernel: Code: 74 24 10 50 8b 4c 24 18 8d be 58 01 00 
00 51 e8 8f fd ff ff 68 a0 f5 6c c0 85 f6 89 d8 0f 45 c7 50 68 80 12 45 c0 
e8 58 8e f7 ff <0f> 0b 6a 01 a5 a8 44 c0 68 a0 f5 6c c0
 85 f6 0f 45 df 53 68 c0

After that and as below, processes started locking up in D state all over 
the place and the machine needed to be rebooted. Checking back through the 
log, it appears that the same error appeared in the log just before the same 
problem occured last time, so it seems basically to have been the same 
issue. The partition in question is fullish, but definitely has space and 
has never been totally full:

[root@server1 hm]$ ls -l /var/spool/imap3
lrwxrwxrwx    1 root     root           30 Jul 31  2003 /var/spool/imap3 -> 
/var/spool/backup/spool-imap3/
[root@server1 hm]$ mount | grep /var/spool/backup
/dev/sdc3 on /var/spool/backup type reiserfs 
(rw,noatime,nodiratime,nolargeio=1,notail)

Any idea why running an rm -rf would cause this to happen?

Rob

---

FYI if it's any extra help, the BUG log message that occured just before the 
sysrq-t output at:

http://robm.fastmail.fm/kernel/t8/

Was:

Aug  7 08:49:33 server1 kernel: ------------[ cut here ]------------
Aug  7 08:49:33 server1 kernel: kernel BUG at fs/reiserfs/prints.c:362!
Aug  7 08:49:33 server1 kernel: invalid operand: 0000 [#1]
Aug  7 08:49:33 server1 kernel: SMP
Aug  7 08:49:33 server1 kernel: Modules linked in:
Aug  7 08:49:33 server1 kernel: CPU:    0
Aug  7 08:49:33 server1 kernel: EIP:    0060:[<c01a0118>]    Not tainted VLI
Aug  7 08:49:33 server1 kernel: EFLAGS: 00010282   (2.6.12.3-reiserfix-big)
Aug  7 08:49:33 server1 kernel: EIP is at reiserfs_panic+0x38/0x60
Aug  7 08:49:33 server1 kernel: eax: 00000063   ebx: c044a2e0   ecx: 
f3587b10   edx: c0451280
Aug  7 08:49:33 server1 kernel: esi: f7123600   edi: f7123758   ebp: 
f59947cc   esp: f3587b0c
Aug  7 08:49:33 server1 kernel: ds: 007b   es: 007b   ss: 0068
Aug  7 08:49:33 server1 kernel: Process rm (pid: 13531, threadinfo=f3586000 
task=e21cda40)
Aug  7 08:49:33 server1 kernel: Stack: c0451280 f7123758 c06cf5a0 c0453860 
f3587b38 f7123600 f8fc3000 00000000
Aug  7 08:49:33 server1 kernel:        c01ad8ad f7123600 c0453860 00000400 
f59947cc 00000000 f59947cc f7123600
Aug  7 08:49:33 server1 kernel:        0000060c f8fbc000 c018b052 f3587f0c 
f7123600 f59947cc f62902ec f62cc000
Aug  7 08:49:33 server1 kernel: Call Trace:
Aug  7 08:49:33 server1 kernel:  [<c01ad8ad>] journal_mark_dirty+0x11d/0x250
Aug  7 08:49:33 server1 kernel:  [<c018b052>] 
_reiserfs_free_block+0xe2/0x150
Aug  7 08:49:33 server1 kernel:  [<c018b0ed>] reiserfs_free_block+0x2d/0x50
Aug  7 08:49:33 server1 kernel:  [<c01a67c4>] 
prepare_for_delete_or_cut+0x604/0x6a0
Aug  7 08:49:33 server1 kernel:  [<c01a767a>] 
reiserfs_cut_from_item+0xda/0x480
Aug  7 08:49:33 server1 kernel:  [<c0156d3e>] __find_get_block+0xee/0x100
Aug  7 08:49:33 server1 kernel:  [<c01ad73e>] journal_begin+0x8e/0xe0
Aug  7 08:49:33 server1 kernel:  [<c01a7de6>] 
reiserfs_do_truncate+0x346/0x4b0
Aug  7 08:49:33 server1 kernel:  [<c01a71b2>] 
reiserfs_delete_object+0x32/0x60
Aug  7 08:49:33 server1 kernel:  [<c0191dd5>] 
reiserfs_delete_inode+0x65/0xc0
Aug  7 08:49:33 server1 kernel:  [<c0223e67>] _atomic_dec_and_lock+0x27/0x50
Aug  7 08:49:33 server1 kernel:  [<c0191d70>] reiserfs_delete_inode+0x0/0xc0
Aug  7 08:49:33 server1 kernel:  [<c016d6dd>] generic_delete_inode+0x7d/0xe0
Aug  7 08:49:33 server1 kernel:  [<c016d8e3>] iput+0x63/0x70
Aug  7 08:49:33 server1 kernel:  [<c016413f>] sys_unlink+0xcf/0x120
Aug  7 08:49:33 server1 kernel:  [<c0102a15>] syscall_call+0x7/0xb
Aug  7 08:49:33 server1 kernel: Code: 74 24 10 50 8b 4c 24 18 8d be 58 01 00 
00 51 e8 8f fd ff ff 68 a0 f5 6c c0 85 f6 89 d8 0f 45 c7 50 68 80 12 45 c0 
e8 58 8e f7 ff <0f> 0b 6a 01 a5 a8 44 c0 68 a0 f5 6c c0
 85 f6 0f 45 df 53 68 c0

>I have a feeling this might be related back to this issue...
>
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0507.1/1518.html
>
> As a reminder: we've been running a number of IBM x235 machines with 6G of 
> RAM with a 2.6.12.3 kernel fine for a couple of weeks now. Last night one 
> of the machines started locking up. We could still ssh into the machine, 
> and run some commands (free, uptime, etc), but lots of commands would just 
> lock up and never return (ps, top, etc). The machine mostly runs a cyrus 
> imap server with a number of reiserfs partitions. The partitions are all 
> mounted as below:
>
> /dev/sda4 on /var/spool/imap type reiserfs
> (rw,noatime,nodiratime,nolargeio=1,notail)
>
> A full sysrq-t output (700k+) and kernel config are available here:
>
> http://robm.fastmail.fm/kernel/t8/
>
> This time it definitely is a full one. In times past it's been bigger than 
> our 1M dmesg buffer. The trace seems to show lots of procs like this:
>
> lmtpd         D F27E2A40     0 16479      1         16480 16451 (NOTLB)
> dcb49e98 00000086 00000008 f27e2a40 f7878b1c f7c9fdfc 00000000 c016a9d2
>       f7c9fdfc c0585800 c4293520 00000000 00004448 06aa7882 000227d8
> c4293520
>       c04c0bc0 f27e2a40 f27e2b64 ffffffff 00000002 00000001 f7c9fdfc
> f7f30580
> Call Trace:
> [<c016a9d2>] dput+0x32/0x1b0
> [<c041db88>] __down+0x88/0x100
> [<c0114960>] default_wake_function+0x0/0x20
> [<c041dd33>] __down_failed+0x7/0xc
> [<c01651ec>] .text.lock.namei+0xc4/0x1f8
> [<c0153996>] filp_open+0x36/0x60
> [<c0153d05>] sys_open+0x35/0x70
> [<c0102a15>] syscall_call+0x7/0xb
>
> And a few looking something like this:
>
> pop3d         D E67AA020     0 16368      1         16376 16296 (NOTLB)
> d2c27bac 00000086 00000008 e67aa020 c02b5177 f785a220 00000282 c02b52ab
>       2085a000 00000000 c4293520 00000000 00001a7f 8e0dd38c 000227d7
> c4293520
>       c04c0bc0 e67aa020 e67aa144 c03bffc5 00000002 00000000 80000000
> d2c27ba0
> Call Trace:
> [<c02b5177>] e100_xmit_frame+0x147/0x300
> [<c02b52ab>] e100_xmit_frame+0x27b/0x300
> [<c03bffc5>] qdisc_restart+0x15/0x1f0
> [<c01ad17d>] queue_log_writer+0x5d/0x80
> [<c0114960>] default_wake_function+0x0/0x20
> [<c01ad42a>] do_journal_begin_r+0x1ca/0x2b0
> [<c03ca6d5>] ip_queue_xmit+0x425/0x4c0
> [<c03ca6f7>] ip_queue_xmit+0x447/0x4c0
> [<c01ad73e>] journal_begin+0x8e/0xe0
> [<c019dae8>] reiserfs_dirty_inode+0x48/0x90
> [<c011d690>] current_fs_time+0x50/0x70
> [<c017521d>] __mark_inode_dirty+0x2d/0x170
> [<c016dabf>] inode_update_time+0xaf/0xc0
> [<c01392d4>] __generic_file_aio_write_nolock+0x514/0x5f0
> [<c01625dc>] __link_path_walk+0xadc/0xd40
> [<c03cf43d>] tcp_sendmsg+0x39d/0x1000
> [<c016a9d2>] dput+0x32/0x1b0
> [<c0142ec8>] kmap_high+0x18/0x1e0
> [<c01394ce>] __generic_file_write_nolock+0x9e/0xc0
> [<c016baf9>] __d_lookup+0x109/0x140
> [<c016a9d2>] dput+0x32/0x1b0
> [<c01625dc>] __link_path_walk+0xadc/0xd40
> [<c012c200>] autoremove_wake_function+0x0/0x40
> [<c01396ce>] generic_file_write+0x4e/0xc0
> [<c019949f>] reiserfs_file_write+0x17f/0x190
> [<c01628d7>] link_path_walk+0x97/0xd0
> [<c0224510>] copy_to_user+0x60/0x70
> [<c015de83>] cp_new_stat64+0xf3/0x110
> [<c015423b>] default_llseek+0xbb/0xd0
> [<c015476e>] vfs_write+0x8e/0xf0
> [<c015487d>] sys_write+0x3d/0x70
> [<c0102a15>] syscall_call+0x7/0xb
>
> As an additional, we have applied this patch to the kernel to try and work
> around a previously identified deadlock situation in reiserfs.
>
>>--- file.c~ 2004-10-02 12:29:33.223660850 +0400
>>+++ file.c 2004-10-08 10:03:03.001561661 +0400
>>@@ -1137,6 +1137,8 @@
>> return result;
>>     }
>>
>>+    return generic_file_write(file, buf, count, ppos);
>>+
>>     if ( unlikely((ssize_t) count < 0 ))
>>         return -EINVAL;
>
> Does this new lockup appear to be a remanifestation of the old problem, or
> does it appear to be something new...
>
> Rob
> 

