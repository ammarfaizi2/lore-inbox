Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVGPOXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVGPOXR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 10:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVGPOXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 10:23:17 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:14018 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261623AbVGPOXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 10:23:15 -0400
Date: Sat, 16 Jul 2005 16:23:11 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Tarmo =?ISO-8859-1?Q?T=E4nav?= <tarmo@itech.ee>
cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs+acl makes processes hang?
In-Reply-To: <1121503573.9150.3.camel@localhost>
Message-ID: <Pine.LNX.4.61.0507161619380.27363@yvahk01.tjqt.qr>
References: <1121469596.17539.9.camel@localhost> 
 <Pine.LNX.4.61.0507161018020.32709@yvahk01.tjqt.qr> <1121503573.9150.3.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>You made one mistake, the last echo "1" >blah should not be
>to the file you created earlier.. the echo is meant to

Right. Hangs now.

If someone wants a stack trace, below is one. However, I wonder why my traces 
have become so distorted -- e.g. the proc_lookup in the last one should not be 
there at all.

But I think the problem is simple:
Reiserfs implements ACLs/Xattrs using files, and obviously, creating the ACL 
for the file cannot succeed because there's no space left. Don't know what 
reiser does in case _an acl file_ can't be created...


: bash          D C39335D0     0  4252   4195                     (NOTLB)
: c3de3cb8 00000082 00000000 c39335d0 c0128a60 c3de3cbc bf1ff5dc 000000fd
:        c39335d0 cdc01b84 c3de3cc8 c39335d0 c7101208 c02852a5 c3de3cbc cdc01b88
:        c2d17e0c cdc01b88 c39335d0 00000001 c7101208 c71011bc c71011cc c7101208
: Call Trace:
:  [<c0128a60>] autoremove_wake_function+0x0/0x50
:  [<c02852a5>] rwsem_down_read_failed+0x75/0x150
:  [<c01b2268>] .text.lock.xattr+0x55/0x23d
:  [<c018f5b0>] reiserfs_delete_inode+0x70/0x110
:  [<c01b2ec7>] reiserfs_set_acl+0x167/0x1a0
:  [<c018f540>] reiserfs_delete_inode+0x0/0x110
:  [<c016643c>] generic_delete_inode+0x9c/0x140
:  [<c016665c>] iput+0x4c/0x70
:  [<c0192759>] reiserfs_new_inode+0x149/0x700
:  [<c018cfdd>] reiserfs_find_entry+0xad/0x120
:  [<c01aca00>] wake_queued_writers+0x30/0x40
:  [<c018d8b7>] reiserfs_create+0xe7/0x210
:  [<c01b21ef>] reiserfs_permission+0xf/0x20
:  [<c01595e6>] permission+0xb6/0xe0
:  [<c015b166>] vfs_create+0xc6/0x190
:  [<c015ba9a>] open_namei+0x5fa/0x740
:  [<c014c427>] filp_open+0x27/0x50
:  [<c014c650>] get_unused_fd+0x20/0xa0
:  [<c01593c7>] getname+0x67/0xb0
:  [<c014c779>] sys_open+0x49/0xd0
:  [<c0102b89>] syscall_call+0x7/0xb
: ls            D C2D17E60     0 20215  14083                     (NOTLB)
: c2d17dfc 00000086 c01ad123 c2d17e60 c2d17eb0 00000000 b1b8700c 00000134
:        c3933ac0 cdc01b84 c2d17e0c c3933ac0 00000000 c02852a5 c3933ac0 cdc01b88
:        cdc01b88 c3de3cc8 c3933ac0 00000001 c02c7be0 c7c7c4b4 c2d17e58 00000000
: Call Trace:
:  [<c01ad123>] journal_mark_dirty+0x113/0x250
:  [<c02852a5>] rwsem_down_read_failed+0x75/0x150
:  [<c01b22da>] .text.lock.xattr+0xc7/0x23d
:  [<c016c8dc>] getxattr+0xdc/0x170
:  [<c01b21e0>] reiserfs_permission+0x0/0x20
:  [<c01b21ef>] reiserfs_permission+0xf/0x20
:  [<c01595e6>] permission+0xb6/0xe0
:  [<c0159f54>] __link_path_walk+0x4a4/0xed0
:  [<c013fb78>] handle_mm_fault+0x138/0x190
:  [<c015aa2b>] link_path_walk+0xab/0x1a0
:  [<c015af9d>] __user_walk+0x3d/0x60
:  [<c016c9bb>] sys_getxattr+0x4b/0x70
:  [<c0102b89>] syscall_call+0x7/0xb
: ls            D C0180493     0 22554  22493                     (NOTLB)
: ce079dfc 00000082 cffec560 c0180493 ffffffea ced0fb00 08b060f1 00000170
:        c478aa20 cdc01b84 ce079e0c c478aa20 00000000 c02852a5 c0135316 cdc01b88
:        cdc01b88 c2d17e0c c478aa20 00000001 c02c7be0 c82d7f54 ce079e58 00000000
: Call Trace:
:  [<c0180493>] proc_lookup+0xa3/0xb0
:  [<c02852a5>] rwsem_down_read_failed+0x75/0x150
:  [<c0135316>] prep_new_page+0x46/0x60
:  [<c01b22da>] .text.lock.xattr+0xc7/0x23d
:  [<c016c8dc>] getxattr+0xdc/0x170
:  [<c01b21e0>] reiserfs_permission+0x0/0x20
:  [<c01b21ef>] reiserfs_permission+0xf/0x20
:  [<c01595e6>] permission+0xb6/0xe0
:  [<c0159f54>] __link_path_walk+0x4a4/0xed0
:  [<c013fb78>] handle_mm_fault+0x138/0x190
:  [<c015aa2b>] link_path_walk+0xab/0x1a0
:  [<c015af9d>] __user_walk+0x3d/0x60
:  [<c016c9bb>] sys_getxattr+0x4b/0x70
:  [<c0102b89>] syscall_call+0x7/0xb


Jan Engelhardt
-- 
