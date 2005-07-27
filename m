Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVG0OL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVG0OL5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 10:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVG0OL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 10:11:57 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:12931 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262094AbVG0OL4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 10:11:56 -0400
Message-ID: <42E79623.1000309@namesys.com>
Date: Wed, 27 Jul 2005 18:11:47 +0400
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Guillaume Pelat <guillaume.pelat@winch-hebergement.net>
CC: linux-kernel@vger.kernel.org, gp@winch-hebergement.net
Subject: Re: Reiserfs 3.6 + quota enabled, crash on delete
References: <42E7828E.9080903@winch-hebergement.net>
In-Reply-To: <42E7828E.9080903@winch-hebergement.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020000030407090300070404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020000030407090300070404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello

Guillaume Pelat wrote:
> Hi,
> 
> I'm having a crash with reiserfs 3.6 + user quota enabled, on 2.6.11.10 
> kernel (no smp), apparently when deleting files (or maybe during a 
> truncate operation). The problem seems to happen under high load.
> When the error occurs, all the processes accessing the reiserfs 
> partition seems to hang. This problem happened several times on 
> different servers (having the same hardware configuration) during last 
> weeks.
> 
> You can find the error logs below :
> 
> ======================================================================
> ReiserFS: sda3: warning: vs-15011: reiserfs_release_objectid: tried to 
> free free object id (96557091)
> ReiserFS: sda3: warning: PAP-5660: reiserfs_do_truncate: wrong result -1 
> of search for [847141 185744 0xfffffffffffffff DIRECT]
> ReiserFS: sda3: warning: clm-2100: nesting info a different FS

The attached patch should help to get rid of clm-2100 and to avoid crash.

Also, I think you should reiserfsck sda3.

> ReiserFS: sda3: warning: clm-2100: nesting info a different FS
> ReiserFS: sda3: warning: clm-2100: nesting info a different FS
> ReiserFS: sda3: warning: clm-2100: nesting info a different FS
> REISERFS: panic (device sda3): journal-1577: handle trans id 1122409068 
> != current trans id 3947596
> ------------[ cut here ]------------
> kernel BUG at fs/reiserfs/prints.c:362!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c019785f>]    Not tainted VLI
> EFLAGS: 00010282   (2.6.11.6)
> EIP is at reiserfs_panic+0x4f/0x80
> eax: 00000068   ebx: c02be9bf   ecx: c038e8f8   edx: c02eecac
> esi: f7eea000   edi: f7eea140   ebp: f3391944   esp: f339192c
> ds: 007b   es: 007b   ss: 0068
> Process pure-ftpd (pid: 27841, threadinfo=f3390000 task=d3053530)
> Stack: c02c3ee0 f7eea140 c03b3580 f7eea000 00000000 f895d000 f3391984 
> c01a6d01
>        f7eea000 c02c6440 42e69a6c 003c3c4c 00000002 f3391970 cdc49b40 
> 00000002
>        cdc49b40 f3391984 00000000 052f8dee 00000000 f2bbfe60 f3391a08 
> c019ebba
> Call Trace:
>  [<c010282f>] show_stack+0x7f/0xa0
>  [<c01029d1>] show_registers+0x151/0x1c0
>  [<c0102bc8>] die+0xc8/0x150
>  [<c010307c>] do_invalid_op+0xbc/0xd0
>  [<c01024bb>] error_code+0x2b/0x30
>  [<c01a6d01>] journal_mark_dirty+0x271/0x2a0
>  [<c019ebba>] prepare_for_delete_or_cut+0x54a/0x720
>  [<c019fdaa>] reiserfs_cut_from_item+0xca/0x5f0
>  [<c01a0668>] reiserfs_do_truncate+0x2e8/0x610
>  [<c019f7ef>] reiserfs_delete_object+0x3f/0x80
>  [<c018636c>] reiserfs_delete_inode+0x8c/0x110
>  [<c015ed85>] generic_delete_inode+0x95/0x130
>  [<c015efc6>] iput+0x56/0x80
>  [<c018995a>] reiserfs_new_inode+0x13a/0x740
>  [<c01847b7>] reiserfs_create+0x97/0x1b0
>  [<c0153e0f>] vfs_create+0x9f/0x120
>  [<c01546f9>] open_namei+0x5d9/0x630
>  [<c0144bbc>] filp_open+0x3c/0x60
>  [<c0144ed6>] sys_open+0x46/0x90
>  [<c0102313>] syscall_call+0x7/0xb
> Code: 01 00 00 89 04 24 e8 31 fd ff ff c7 04 24 e0 3e 2c c0 85 f6 89 d8 
> 0f 45 c7 ba 80 35 3b c0 89 54 24 08 89 44 24 04 e8 c1 a9 f7ff <0f> 0b 6a 
> 01 02 ef 2b c0 c7 04 24 20 3f 2c c0 85 f6 b9 80 35 3b
> ======================================================================
> 

--------------020000030407090300070404
Content-Type: text/plain;
 name="reiserfs-add-missing-journal_end.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reiserfs-add-missing-journal_end.patch"


This patch adds missing calls to journal_end on error handling code paths.


 fs/reiserfs/inode.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -puN fs/reiserfs/inode.c~reiserfs-add-missing-journal_end fs/reiserfs/inode.c
--- linux-2.6.11.10/fs/reiserfs/inode.c~reiserfs-add-missing-journal_end	2005-07-27 18:03:06.197544430 +0400
+++ linux-2.6.11.10-vs/fs/reiserfs/inode.c	2005-07-27 18:04:07.363047159 +0400
@@ -46,6 +46,7 @@ void reiserfs_delete_inode (struct inode
 	reiserfs_update_inode_transaction(inode) ;
 
 	if (reiserfs_delete_object (&th, inode)) {
+	    journal_end(&th, inode->i_sb, jbegin_count);
 	    up (&inode->i_sem);
 	    goto out;
 	}
@@ -2015,8 +2016,10 @@ int reiserfs_truncate_file(struct inode 
 	       either appears truncated properly or not truncated at all */
 	add_save_link (&th, p_s_inode, 1);
     error = reiserfs_do_truncate (&th, p_s_inode, page, update_timestamps) ;
-    if (error)
+    if (error) {
+	journal_end (&th, p_s_inode->i_sb, JOURNAL_PER_BALANCE_CNT * 2 + 1);
         goto out;
+    }
     error = journal_end (&th, p_s_inode->i_sb, JOURNAL_PER_BALANCE_CNT * 2 + 1);
     if (error)
         goto out;

_

--------------020000030407090300070404--
