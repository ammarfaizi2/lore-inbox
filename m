Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262548AbVA0Kjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbVA0Kjo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 05:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVA0Khi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 05:37:38 -0500
Received: from apachihuilliztli.mtu.ru ([195.34.32.124]:10764 "EHLO
	Apachihuilliztli.mtu.ru") by vger.kernel.org with ESMTP
	id S262564AbVA0KVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 05:21:30 -0500
Subject: Re: [2.6.11-rc2] kernel BUG at fs/reiserfs/prints.c:362
From: Vladimir Saveliev <vs@namesys.com>
To: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Cc: reiserfs-list@namesys.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       admin@list.net.ru
In-Reply-To: <200501271024.13778.rathamahata@ehouse.ru>
References: <200501271024.13778.rathamahata@ehouse.ru>
Content-Type: multipart/mixed; boundary="=-iRcShoAbUlkHVqY0DWmF"
Message-Id: <1106821035.3270.30.camel@tribesman>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 27 Jan 2005 13:17:58 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iRcShoAbUlkHVqY0DWmF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello

On Thu, 2005-01-27 at 10:24, Sergey S. Kostyliov wrote:
> Hello all,
> 
> Here is a BUG() I've just hited on quota enabled reiserfs disk.
> 
> rathamahata@dev rathamahata $ mount | grep /dev/sdb2
> /dev/sdb2 on /var/www type reiserfs (rw,noatime,nodiratime,data=writeback,grpquota,usrquota)
> rathamahata@dev rathamahata $
> 
> REISERFS: panic (device sdb2): journal_begin called without kernel lock held

Would you check whether this patch helps, please?


> ------------[ cut here ]------------
> kernel BUG at fs/reiserfs/prints.c:362!
> invalid operand: 0000 [#1]
> PREEMPT SMP
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c019e9fb>]    Not tainted VLI
> EFLAGS: 00010296   (2.6.11-rc2)
> EIP is at reiserfs_panic+0x4b/0x80
> eax: 00000050   ebx: c02b75b2   ecx: f7fe4270   edx: f1034e38
> esi: f7543600   edi: f7543770   ebp: 000000f2   esp: f1034e34
> ds: 007b   es: 007b   ss: 0068
> Process qmail-local (pid: 10803, threadinfo=f1034000 task=cc440a60)
> Stack: c02bbb00 f7543770 c03b89c0 f7543600 f1034ecc f89af000 c01a8a0e f7543600
>        c02bcf20 c02b7db8 c01ac186 f74b66c0 000000f2 f1034ecc c0167403 f74b6900
>        c02f2740 fffffff4 f74b6960 00295e98 c01679dc 00295e98 f74b6090 f74b66c0
> Call Trace:
>  [<c01a8a0e>] reiserfs_check_lock_depth+0x2e/0x30
>  [<c01ac186>] do_journal_begin_r+0x26/0x2d0
>  [<c0167403>] d_alloc+0x133/0x180
>  [<c01679dc>] __d_lookup+0x11c/0x130
>  [<c01ac641>] journal_begin+0x61/0xf0
>  [<c019d445>] reiserfs_dquot_initialize+0x25/0x60
>  [<c015db2d>] link_path_walk+0x48d/0xd20
>  [<c015d1c6>] permission+0x76/0xa0
>  [<c015ea98>] vfs_create+0xc8/0x110
>  [<c015f2cf>] open_namei+0x57f/0x5d0
>  [<c014fcfd>] filp_open+0x2d/0x60
>  [<c0150014>] get_unused_fd+0x94/0xc0
>  [<c015cff7>] getname+0x67/0xb0
>  [<c015012c>] sys_open+0x3c/0x80
>  [<c01026b1>] sysenter_past_esp+0x52/0x75
> Code: 8d be 70 01 00 00 e8 a5 fd ff ff c7 04 24 00 bb 2b c0 85 f6 89 d8 0f 45 c7 ba c0 893b c0 89 54 24 08 89 44 24 04 e8 25 9d f7 ff <0f> 0b 6a 01 1a 7b 2b c0 c7 04 24 40 bb 2b c0 85 f6 be c0 89 3b
>  <0>REISERFS: panic (device sdb2): journal_begin called without kernel lock held
> ------------[ cut here ]------------

--=-iRcShoAbUlkHVqY0DWmF
Content-Disposition: attachment; filename=reiserfs-quota-add-missing-lock_kernel.patch
Content-Type: text/plain; name=reiserfs-quota-add-missing-lock_kernel.patch; charset=koi8-r
Content-Transfer-Encoding: 7bit

 fs/reiserfs/super.c |   12 ++++++++++++
 1 files changed, 12 insertions(+)

diff -puN fs/reiserfs/super.c~reiserfs-quota-add-missing-lock_kernel fs/reiserfs/super.c
--- linux-2.6.11-rc2/fs/reiserfs/super.c~reiserfs-quota-add-missing-lock_kernel	2005-01-27 13:09:35.101322376 +0300
+++ linux-2.6.11-rc2-root/fs/reiserfs/super.c	2005-01-27 13:15:19.608949256 +0300
@@ -1835,9 +1835,11 @@ static int reiserfs_dquot_initialize(str
     int ret;
 
     /* We may create quota structure so we need to reserve enough blocks */
+    reiserfs_write_lock(inode->i_sb);
     journal_begin(&th, inode->i_sb, 2*REISERFS_QUOTA_INIT_BLOCKS);
     ret = dquot_initialize(inode, type);
     journal_end(&th, inode->i_sb, 2*REISERFS_QUOTA_INIT_BLOCKS);
+    reiserfs_write_unlock(inode->i_sb);
     return ret;
 }
 
@@ -1847,9 +1849,11 @@ static int reiserfs_dquot_drop(struct in
     int ret;
 
     /* We may delete quota structure so we need to reserve enough blocks */
+    reiserfs_write_lock(inode->i_sb);
     journal_begin(&th, inode->i_sb, 2*REISERFS_QUOTA_INIT_BLOCKS);
     ret = dquot_drop(inode);
     journal_end(&th, inode->i_sb, 2*REISERFS_QUOTA_INIT_BLOCKS);
+    reiserfs_write_unlock(inode->i_sb);
     return ret;
 }
 
@@ -1858,9 +1862,11 @@ static int reiserfs_write_dquot(struct d
     struct reiserfs_transaction_handle th;
     int ret;
 
+    reiserfs_write_lock(dquot->dq_sb);
     journal_begin(&th, dquot->dq_sb, REISERFS_QUOTA_TRANS_BLOCKS);
     ret = dquot_commit(dquot);
     journal_end(&th, dquot->dq_sb, REISERFS_QUOTA_TRANS_BLOCKS);
+    reiserfs_write_unlock(dquot->dq_sb);
     return ret;
 }
 
@@ -1869,9 +1875,11 @@ static int reiserfs_acquire_dquot(struct
     struct reiserfs_transaction_handle th;
     int ret;
 
+    reiserfs_write_lock(dquot->dq_sb);
     journal_begin(&th, dquot->dq_sb, REISERFS_QUOTA_INIT_BLOCKS);
     ret = dquot_acquire(dquot);
     journal_end(&th, dquot->dq_sb, REISERFS_QUOTA_INIT_BLOCKS);
+    reiserfs_write_unlock(dquot->dq_sb);
     return ret;
 }
 
@@ -1880,9 +1888,11 @@ static int reiserfs_release_dquot(struct
     struct reiserfs_transaction_handle th;
     int ret;
 
+    reiserfs_write_lock(dquot->dq_sb);
     journal_begin(&th, dquot->dq_sb, REISERFS_QUOTA_INIT_BLOCKS);
     ret = dquot_release(dquot);
     journal_end(&th, dquot->dq_sb, REISERFS_QUOTA_INIT_BLOCKS);
+    reiserfs_write_unlock(dquot->dq_sb);
     return ret;
 }
 
@@ -1904,9 +1914,11 @@ static int reiserfs_write_info(struct su
     int ret;
 
     /* Data block + inode block */
+    reiserfs_write_lock(sb);
     journal_begin(&th, sb, 2);
     ret = dquot_commit_info(sb, type);
     journal_end(&th, sb, 2);
+    reiserfs_write_unlock(sb);
     return ret;
 }
 

_

--=-iRcShoAbUlkHVqY0DWmF--

