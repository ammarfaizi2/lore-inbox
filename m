Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271417AbTGXJaa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 05:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271418AbTGXJaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 05:30:30 -0400
Received: from tmi.comex.ru ([217.10.33.92]:1166 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S271417AbTGXJaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 05:30:25 -0400
X-Comment-To: Felipe Alfaro Solana
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1-mm2 ext3-related OOPS while running tar
From: Alex Tomas <bzzz@tmi.comex.ru>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Organization: HOME
Date: Thu, 24 Jul 2003 13:45:01 +0000
In-Reply-To: <1059038117.577.23.camel@teapot.felipe-alfaro.com> (Felipe
 Alfaro Solana's message of "24 Jul 2003 11:15:18 +0200")
Message-ID: <87adb4hwde.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <1059038117.577.23.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


please, try this patch


--- linux-2.5.74/fs/ext3/inode.c~ext3-getblk-race-fix	Wed Jul 16 15:04:33 2003
+++ linux-2.5.74-alexey/fs/ext3/inode.c	Mon Jul 21 14:36:37 2003
@@ -936,14 +936,12 @@ struct buffer_head *ext3_getblk(handle_t
 			   ext3_get_block instead, so it's not a
 			   problem. */
 			lock_buffer(bh);
-			if (!buffer_uptodate(bh)) {
-				BUFFER_TRACE(bh, "call get_create_access");
-				fatal = ext3_journal_get_create_access(handle, bh);
-				if (!fatal) {
-					memset(bh->b_data, 0,
-							inode->i_sb->s_blocksize);
-					set_buffer_uptodate(bh);
-				}
+			BUFFER_TRACE(bh, "call get_create_access");
+			fatal = ext3_journal_get_create_access(handle, bh);
+			if (!fatal && !buffer_uptodate(bh)) {
+				memset(bh->b_data, 0,
+						inode->i_sb->s_blocksize);
+				set_buffer_uptodate(bh);
 			}
 			unlock_buffer(bh);
 			BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");

_

>>>>> Felipe Alfaro Solana (FAS) writes:

 FAS> Hi!
 FAS> I've got the attached oops on 2.6.0-test1-mm2 + o8int.patch when
 FAS> untarring the kernel sources for 2.6.0-test1 on an ext3 filesystem
 FAS> using:

 FAS> tar jxvf /path/to/linux-2.6.0-test1.tar.bz2

 FAS> I've CCed Con Kolivas and Andrew Morton as I've seen a do_divide_error
 FAS> which could be related with scheduler improvements.

 FAS> Unable to handle kernel NULL pointer deference at virtual address 00000014
 FAS>  printing eip:
 FAS> c018e1b7
 FAS> *pde = 00000000
 FAS> Oops: 0000 [#1]
 FAS> PREEMPT
 FAS> CPU:    0
 FAS> EIP:    0060:[<c018e1b7>]    Not tainted VLI
 FAS> EFLAGS: 00010202
 FAS> EIP is at journal_dirty_metadata+0x49/0x243
 FAS> eax: d75e6000   ebx: 00000000   ecx: 00000000   edx: d79ca480
 FAS> esi: d724eb00   edi: d671c424   ebp: d79ca480   esp: d75e7e74
 FAS> ds: 007b   es: 007b   ss: 0068
 FAS> Process tar (pid: 2583, threadinfo=d75e6000 task=d6c39940)
 FAS> Stack: 000d3f82 dfde6880 d6655a10 c014bda6 c014a6b5 dfdb5980 d79ca480 d67fc424
 FAS>        00000001 d6655a10 c017f045 d67fc424 d79ca480 00001000 d75e7ebc 00000001
 FAS>        00000001 00000000 00000030 00000001 00000001 00000cdd 000d3f82 dfde4420
 FAS> Call Trace:
 FAS>  [<c014bda6>] __getblk+0x2b/0x51
 FAS>  [<c014a6b5>] wake_up_buffer+0xf/0x26
 FAS>  [<c017f045>] ext3_getblk+0xdb/0x284
 FAS>  [<c017f221>] ext3_bread+0x33/0xb6
 FAS>  [<c0184cc4>] ext3_mkdir+0xd1/0x2c6
 FAS>  [<c0184bf3>] ext3_mkdir+0x0/0x2c6
 FAS>  [<c0158350>] vfs_mkdir+0x6a/0xbc
 FAS>  [<c0158459>] sys_mkdir+0xb7/0xf6
 FAS>  [<c0108f11>] sysenter_past_esp+0x52/0x71

 FAS> Code: 8b 5d 24 0f 8f e3 01 00 00 f6 47 18 04 0f 85 e0 00 00 00 8b 07 8b 00 f6 00
 FAS>  02 0f 85 d3 00 00 00 b8 00 e0 ff ff 21 e0 83 40 14 01 <8b> 43 14 3b 07 0f 84 66
 FAS>  00 00 00 b8 00 e0 ff ff 21 e0 83 40 14
 FAS>  <6>note: tar[2583] exited with preempt_count 1
 FAS> bad: scheduling while atomic!
 FAS> Call Trace:
 FAS>  [<c011583f>] schedule+0x3f7/0x3fc
 FAS>  [<c013aeb8>] unmag_page_range+0x43/x069
 FAS>  [<c013b08f>] unmap_vmas+0x1b1/0x209
 FAS>  [<c013eba0>] exit_mmap+0x7c/0x190
 FAS>  [<c01171ec>] mmput+0x7b/0xe4
 FAS>  [<c011acdb>] do_exit+0x11d/0x3f2
 FAS>  [<c0113dec>] do_page_fault+0x0/0x456
 FAS>  [<c010977f>] do_divide_error+0x0/0xfa
 FAS>  [<c0113f18>] do_page_fault+0x12c/0x456
 FAS>  [<c0181dc3>] ext3_mark_inode_dirty+0x4f/0x51
 FAS>  [<c017e99b>] ext3_splice_branch+0x161/0x29c
 FAS>  [<c017dcda>] ext3_get_block_handle+0x2f4/0x355
 FAS>  [<c0113dec>] do_page_fault+0x0/0x456
 FAS>  [<c010910d>] journal_dirty_metadata+0x49/0x243
 FAS>  [<c014bda6>] __getblk+0x2b/0x51
 FAS>  [<c014bda6>] __getblk+0x2b/0x51
 FAS>  [<c014a6b5>] wake_up_buffer+0xf/0x26
 FAS>  [<c017f045>] ext3_getblk+0xdb/0x284
 FAS>  [<c017f221>] ext3_bread+0x33/0xb6
 FAS>  [<c0184cc4>] ext3_mkdir+0xd1/0x2c6
 FAS>  [<c0184bf3>] ext3_mkdir+0x0/0x2c6
 FAS>  [<c0158350>] vfs_mkdir+0x6a/0xbc
 FAS>  [<c0158459>] sys_mkdir+0xb7/0xf6
 FAS>  [<c0108f11>] sysenter_past_esp+0x52/0x71

