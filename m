Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWAZUKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWAZUKq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWAZUKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:10:46 -0500
Received: from dns.toxicfilms.tv ([150.254.220.184]:18637 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S1751424AbWAZUKq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:10:46 -0500
X-Spam-Report: SA TESTS
 -1.7 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -2.3 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                             [score: 0.0000]
  0.4 AWL                    AWL: From: address is in the auto white-list
X-QSS-TOXIC-Mail-From: solt2@dns.toxicfilms.tv via dns
X-QSS-TOXIC: 1.25st (Clear:RC:1(62.21.14.223):SA:0(-3.6/2.5):. Processed in 2.088863 secs Process 13742)
Date: Thu, 26 Jan 2006 21:10:57 +0100
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <1771840712.20060126211057@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
CC: reiserfs-list@namesys.com
Subject: 2.6.15 reiserfs bugs that cause the system to hang and increase load sistematically
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I just hit a problem with reiserfs. While working this popped on the console:
ReiserFS: sdb2: warning: vs-13060: reiserfs_update_sd: stat data of object [2497 4756 0x0 SD] (nlink == 2) not found (pos 1)
ReiserFS: sdb2: warning: zam-7002:reiserfs_add_entry: "reiserfs_find_entry" has returned unexpected value (3)
REISERFS: panic (device sdb2): vs-7050: new entry is found, new inode == 0

And then suddenly some services (webmail, courier-imap) stopped working properly,
as if they hung upon read/write on /dev/sdb2 (which is /home that contains mail)

I noticed that load was increasing continuously, 5,7,9,12,...,60.

I tried remounting in read only to do a reiserfsck but
mount -o remount,ro /dev/sdb2 only hung and it was not possible to stop it.

Unfortunatelly I discovered it being remotely logged on, and I can't log in
now to further investigate. But I managed to look at syslog and copy the
oops call trace that was just after the 3 messages I wrote above.

This is vanilla 2.6.15, /dev/sdb2 is a reiserfs on a 0+1 RAID ran by aacraid.
No 3rd party modules.
Currently I can not supply any more information due to the server not
letting me in, ie. hanging just after displaying Last login info.

Just letting you guys know. I hope the fs is intact :-)

Best regards,
Maciej Soltysiak

------------[ cut here ]------------
kernel BUG at fs/reiserfs/prints.c:362!
invalid operand: 0000 [#1]
SMP 
CPU:    1
EIP:    0060:[reiserfs_panic+86/128]    Not tainted VLI
EIP:    0060:[<c01befc6>]    Not tainted VLI
EFLAGS: 00010296   (2.6.15) 
EIP is at reiserfs_panic+0x56/0x80
eax: 00000055   ebx: c039753f   ecx: 00000000   edx: 00000000
esi: f1073000   edi: f1073198   ebp: 0000003b   esp: c6bf5c28
ds: 007b   es: 007b   ss: 0068
Process imapd (pid: 25961, threadinfo=c6bf5000 task=dbfab030)
Stack: c039debc f1073198 c04a18c0 c6bf5c50 00000000 d5af89c4 00000000 c01adaa4 
       f1073000 c039c90c eb526f20 0000002e d5af89c4 00000000 00000002 00000001 
       0049b6a3 00008000 00000000 c01c5623 dbe44000 00001000 e346f824 e346f824 
Call Trace:
 [reiserfs_rename+2500/2880] reiserfs_rename+0x9c4/0xb40
 [<c01adaa4>] reiserfs_rename+0x9c4/0xb40
 [is_tree_node+115/128] is_tree_node+0x73/0x80
 [<c01c5623>] is_tree_node+0x73/0x80
 [search_by_key+551/3808] search_by_key+0x227/0xee0
 [<c01c5907>] search_by_key+0x227/0xee0
 [dput+250/576] dput+0xfa/0x240
 [<c017dfba>] dput+0xfa/0x240
 [mntput_no_expire+29/128] mntput_no_expire+0x1d/0x80
 [<c018344d>] mntput_no_expire+0x1d/0x80
 [_spin_unlock+11/16] _spin_unlock+0xb/0x10
 [<c038057b>] _spin_unlock+0xb/0x10
 [vfs_rename_other+187/256] vfs_rename_other+0xbb/0x100
 [<c0176ddb>] vfs_rename_other+0xbb/0x100
 [vfs_rename+1099/1152] vfs_rename+0x44b/0x480
 [<c017726b>] vfs_rename+0x44b/0x480
 [sys_rename+461/528] sys_rename+0x1cd/0x210
 [<c017746d>] sys_rename+0x1cd/0x210
 [_spin_lock+11/16] _spin_lock+0xb/0x10
 [<c038055b>] _spin_lock+0xb/0x10
 [sys_write+75/128] sys_write+0x4b/0x80
 [<c01643bb>] sys_write+0x4b/0x80
 [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
 [<c01030eb>] sysenter_past_esp+0x54/0x75
Code: e8 00 fd ff ff 89 d8 ba c0 18 4a c0 85 f6 8d be 98 01 00 00 0f 45 c7 89 54 24 08 89 44 24 04 c7 04 24 bc de 39 c0 e8 7a 02 f6 ff <0f> 0b 6a 01 e7 78 39 c0 85 f6 b8 c0 18 4a c0 0f 45 df 89 44 24 
 Badness in do_exit at kernel/exit.c:796
 [do_exit+862/880] do_exit+0x35e/0x370
 [<c0121d1e>] do_exit+0x35e/0x370
 [die+388/400] die+0x184/0x190
 [<c0104434>] die+0x184/0x190
 [do_invalid_op+0/208] do_invalid_op+0x0/0xd0
 [<c01047d0>] do_invalid_op+0x0/0xd0
 [do_invalid_op+184/208] do_invalid_op+0xb8/0xd0
 [<c0104888>] do_invalid_op+0xb8/0xd0
 [reiserfs_panic+86/128] reiserfs_panic+0x56/0x80
 [<c01befc6>] reiserfs_panic+0x56/0x80
 [call_console_drivers+344/384] call_console_drivers+0x158/0x180
 [<c011f0d8>] call_console_drivers+0x158/0x180
 [release_console_sem+124/192] release_console_sem+0x7c/0xc0
 [<c011f67c>] release_console_sem+0x7c/0xc0
 [vprintk+632/768] vprintk+0x278/0x300
 [<c011f4d8>] vprintk+0x278/0x300
 [error_code+79/84] error_code+0x4f/0x54
 [<c0103c47>] error_code+0x4f/0x54
 [reiserfs_panic+86/128] reiserfs_panic+0x56/0x80
 [<c01befc6>] reiserfs_panic+0x56/0x80
 [reiserfs_rename+2500/2880] reiserfs_rename+0x9c4/0xb40
 [<c01adaa4>] reiserfs_rename+0x9c4/0xb40
 [is_tree_node+115/128] is_tree_node+0x73/0x80
 [<c01c5623>] is_tree_node+0x73/0x80
 [search_by_key+551/3808] search_by_key+0x227/0xee0
 [<c01c5907>] search_by_key+0x227/0xee0
 [dput+250/576] dput+0xfa/0x240
 [<c017dfba>] dput+0xfa/0x240
 [mntput_no_expire+29/128] mntput_no_expire+0x1d/0x80
 [<c018344d>] mntput_no_expire+0x1d/0x80
 [_spin_unlock+11/16] _spin_unlock+0xb/0x10
 [<c038057b>] _spin_unlock+0xb/0x10
 [vfs_rename_other+187/256] vfs_rename_other+0xbb/0x100
 [<c0176ddb>] vfs_rename_other+0xbb/0x100
 [vfs_rename+1099/1152] vfs_rename+0x44b/0x480
 [<c017726b>] vfs_rename+0x44b/0x480
 [sys_rename+461/528] sys_rename+0x1cd/0x210
 [<c017746d>] sys_rename+0x1cd/0x210
 [_spin_lock+11/16] _spin_lock+0xb/0x10
 [<c038055b>] _spin_lock+0xb/0x10
 [sys_write+75/128] sys_write+0x4b/0x80
 [<c01643bb>] sys_write+0x4b/0x80
 [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
 [<c01030eb>] sysenter_past_esp+0x54/0x75
ReiserFS: sda6: warning: clm-2100: nesting info a different FS

