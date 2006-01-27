Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWA0Nhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWA0Nhb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 08:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWA0Nha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 08:37:30 -0500
Received: from chen.mtu.ru ([195.34.34.232]:14341 "EHLO chen.mtu.ru")
	by vger.kernel.org with ESMTP id S1750907AbWA0Nha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 08:37:30 -0500
Subject: Re: 2.6.15 reiserfs bugs that cause the system to hang and
	increase load sistematically
From: "Vladimir V. Saveliev" <vs@namesys.com>
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <1771840712.20060126211057@dns.toxicfilms.tv>
References: <1771840712.20060126211057@dns.toxicfilms.tv>
Content-Type: multipart/mixed; boundary="=-T42JkIsqI8VvUPhv0wwI"
Date: Fri, 27 Jan 2006 16:26:48 +0300
Message-Id: <1138368408.6238.60.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-T42JkIsqI8VvUPhv0wwI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello

On Thu, 2006-01-26 at 21:10 +0100, Maciej Soltysiak wrote:
> Hello!
> 
> I just hit a problem with reiserfs. While working this popped on the console:
> ReiserFS: sdb2: warning: vs-13060: reiserfs_update_sd: stat data of object [2497 4756 0x0 SD] (nlink == 2) not found (pos 1)
> ReiserFS: sdb2: warning: zam-7002:reiserfs_add_entry: "reiserfs_find_entry" has returned unexpected value (3)
> REISERFS: panic (device sdb2): vs-7050: new entry is found, new inode == 0
> 

rename encountered "hidden" name when it should not be there.
the attached patch should make reiserfs to not panic but return -EIO.

It would be interesting to know how did you manage to create hidden
names.

> And then suddenly some services (webmail, courier-imap) stopped working properly,
> as if they hung upon read/write on /dev/sdb2 (which is /home that contains mail)
> 
> I noticed that load was increasing continuously, 5,7,9,12,...,60.
> 
> I tried remounting in read only to do a reiserfsck but
> mount -o remount,ro /dev/sdb2 only hung and it was not possible to stop it.
> 
> Unfortunatelly I discovered it being remotely logged on, and I can't log in
> now to further investigate. But I managed to look at syslog and copy the
> oops call trace that was just after the 3 messages I wrote above.
> 
> This is vanilla 2.6.15, /dev/sdb2 is a reiserfs on a 0+1 RAID ran by aacraid.
> No 3rd party modules.
> Currently I can not supply any more information due to the server not
> letting me in, ie. hanging just after displaying Last login info.
> 
> Just letting you guys know. I hope the fs is intact :-)
> 
you should reiserfsck /dev/sdb2

> Best regards,
> Maciej Soltysiak
> 
> ------------[ cut here ]------------
> kernel BUG at fs/reiserfs/prints.c:362!
> invalid operand: 0000 [#1]
> SMP 
> CPU:    1
> EIP:    0060:[reiserfs_panic+86/128]    Not tainted VLI
> EIP:    0060:[<c01befc6>]    Not tainted VLI
> EFLAGS: 00010296   (2.6.15) 
> EIP is at reiserfs_panic+0x56/0x80
> eax: 00000055   ebx: c039753f   ecx: 00000000   edx: 00000000
> esi: f1073000   edi: f1073198   ebp: 0000003b   esp: c6bf5c28
> ds: 007b   es: 007b   ss: 0068
> Process imapd (pid: 25961, threadinfo=c6bf5000 task=dbfab030)
> Stack: c039debc f1073198 c04a18c0 c6bf5c50 00000000 d5af89c4 00000000 c01adaa4 
>        f1073000 c039c90c eb526f20 0000002e d5af89c4 00000000 00000002 00000001 
>        0049b6a3 00008000 00000000 c01c5623 dbe44000 00001000 e346f824 e346f824 
> Call Trace:
>  [reiserfs_rename+2500/2880] reiserfs_rename+0x9c4/0xb40
>  [<c01adaa4>] reiserfs_rename+0x9c4/0xb40
>  [is_tree_node+115/128] is_tree_node+0x73/0x80
>  [<c01c5623>] is_tree_node+0x73/0x80
>  [search_by_key+551/3808] search_by_key+0x227/0xee0
>  [<c01c5907>] search_by_key+0x227/0xee0
>  [dput+250/576] dput+0xfa/0x240
>  [<c017dfba>] dput+0xfa/0x240
>  [mntput_no_expire+29/128] mntput_no_expire+0x1d/0x80
>  [<c018344d>] mntput_no_expire+0x1d/0x80
>  [_spin_unlock+11/16] _spin_unlock+0xb/0x10
>  [<c038057b>] _spin_unlock+0xb/0x10
>  [vfs_rename_other+187/256] vfs_rename_other+0xbb/0x100
>  [<c0176ddb>] vfs_rename_other+0xbb/0x100
>  [vfs_rename+1099/1152] vfs_rename+0x44b/0x480
>  [<c017726b>] vfs_rename+0x44b/0x480
>  [sys_rename+461/528] sys_rename+0x1cd/0x210
>  [<c017746d>] sys_rename+0x1cd/0x210
>  [_spin_lock+11/16] _spin_lock+0xb/0x10
>  [<c038055b>] _spin_lock+0xb/0x10
>  [sys_write+75/128] sys_write+0x4b/0x80
>  [<c01643bb>] sys_write+0x4b/0x80
>  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
>  [<c01030eb>] sysenter_past_esp+0x54/0x75
> Code: e8 00 fd ff ff 89 d8 ba c0 18 4a c0 85 f6 8d be 98 01 00 00 0f 45 c7 89 54 24 08 89 44 24 04 c7 04 24 bc de 39 c0 e8 7a 02 f6 ff <0f> 0b 6a 01 e7 78 39 c0 85 f6 b8 c0 18 4a c0 0f 45 df 89 44 24 
>  Badness in do_exit at kernel/exit.c:796
>  [do_exit+862/880] do_exit+0x35e/0x370
>  [<c0121d1e>] do_exit+0x35e/0x370
>  [die+388/400] die+0x184/0x190
>  [<c0104434>] die+0x184/0x190
>  [do_invalid_op+0/208] do_invalid_op+0x0/0xd0
>  [<c01047d0>] do_invalid_op+0x0/0xd0
>  [do_invalid_op+184/208] do_invalid_op+0xb8/0xd0
>  [<c0104888>] do_invalid_op+0xb8/0xd0
>  [reiserfs_panic+86/128] reiserfs_panic+0x56/0x80
>  [<c01befc6>] reiserfs_panic+0x56/0x80
>  [call_console_drivers+344/384] call_console_drivers+0x158/0x180
>  [<c011f0d8>] call_console_drivers+0x158/0x180
>  [release_console_sem+124/192] release_console_sem+0x7c/0xc0
>  [<c011f67c>] release_console_sem+0x7c/0xc0
>  [vprintk+632/768] vprintk+0x278/0x300
>  [<c011f4d8>] vprintk+0x278/0x300
>  [error_code+79/84] error_code+0x4f/0x54
>  [<c0103c47>] error_code+0x4f/0x54
>  [reiserfs_panic+86/128] reiserfs_panic+0x56/0x80
>  [<c01befc6>] reiserfs_panic+0x56/0x80
>  [reiserfs_rename+2500/2880] reiserfs_rename+0x9c4/0xb40
>  [<c01adaa4>] reiserfs_rename+0x9c4/0xb40
>  [is_tree_node+115/128] is_tree_node+0x73/0x80
>  [<c01c5623>] is_tree_node+0x73/0x80
>  [search_by_key+551/3808] search_by_key+0x227/0xee0
>  [<c01c5907>] search_by_key+0x227/0xee0
>  [dput+250/576] dput+0xfa/0x240
>  [<c017dfba>] dput+0xfa/0x240
>  [mntput_no_expire+29/128] mntput_no_expire+0x1d/0x80
>  [<c018344d>] mntput_no_expire+0x1d/0x80
>  [_spin_unlock+11/16] _spin_unlock+0xb/0x10
>  [<c038057b>] _spin_unlock+0xb/0x10
>  [vfs_rename_other+187/256] vfs_rename_other+0xbb/0x100
>  [<c0176ddb>] vfs_rename_other+0xbb/0x100
>  [vfs_rename+1099/1152] vfs_rename+0x44b/0x480
>  [<c017726b>] vfs_rename+0x44b/0x480
>  [sys_rename+461/528] sys_rename+0x1cd/0x210
>  [<c017746d>] sys_rename+0x1cd/0x210
>  [_spin_lock+11/16] _spin_lock+0xb/0x10
>  [<c038055b>] _spin_lock+0xb/0x10
>  [sys_write+75/128] sys_write+0x4b/0x80
>  [<c01643bb>] sys_write+0x4b/0x80
>  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
>  [<c01030eb>] sysenter_past_esp+0x54/0x75
> ReiserFS: sda6: warning: clm-2100: nesting info a different FS
> 
> 

--=-T42JkIsqI8VvUPhv0wwI
Content-Disposition: attachment; filename=reiserfs-handle-hidden-entries.patch
Content-Type: text/x-patch; name=reiserfs-handle-hidden-entries.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

 fs/reiserfs/namei.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN fs/reiserfs/namei.c~reiserfs-handle-hidden-entries fs/reiserfs/namei.c
--- linux-2.6.15-mm4/fs/reiserfs/namei.c~reiserfs-handle-hidden-entries	2006-01-27 13:38:04.000000000 +0300
+++ linux-2.6.15-mm4-vs/fs/reiserfs/namei.c	2006-01-27 13:40:57.000000000 +0300
@@ -502,6 +502,7 @@ static int reiserfs_add_entry(struct rei
 					 "zam-7002:%s: \"reiserfs_find_entry\" "
 					 "has returned unexpected value (%d)",
 					 __FUNCTION__, retval);
+			return -EIO;
 		}
 
 		return -EEXIST;

_

--=-T42JkIsqI8VvUPhv0wwI--

