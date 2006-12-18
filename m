Return-Path: <linux-kernel-owner+w=401wt.eu-S1754340AbWLRSvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754340AbWLRSvm (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 13:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754342AbWLRSvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 13:51:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:55752 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754341AbWLRSvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 13:51:41 -0500
X-Authenticated: #704063
Subject: [Patch] BUG in fs/jfs/jfs_xtree.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: shaggy@austin.ibm.com
Content-Type: text/plain
Date: Mon, 18 Dec 2006 19:51:29 +0100
Message-Id: <1166467889.32321.4.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

while playing around with fsfuzzer, i got the following oops with jfs:

[  851.804875] BUG at fs/jfs/jfs_xtree.c:760 assert(!BT_STACK_FULL(btstack))
[  851.805179] ------------[ cut here ]------------
[  851.805238] kernel BUG at fs/jfs/jfs_xtree.c:760!
[  851.805287] invalid opcode: 0000 [#1]
[  851.805327] PREEMPT 
[  851.805391] Modules linked in:
[  851.805469] CPU:    0
[  851.805474] EIP:    0060:[<c028e57a>]    Not tainted VLI
[  851.805482] EFLAGS: 00010286   (2.6.19-git18 #16)
[  851.805620] EIP is at xtSearch+0x2fa/0x6a0
[  851.805669] eax: 00000050   ebx: 00000001   ecx: cc826000   edx: 00000000
[  851.805720] esi: 00030012   edi: cc826b94   ebp: cc826b58   esp: cc826ab8
[  851.805772] ds: 007b   es: 007b   ss: 0068
[  851.805823] Process mount (pid: 4721, ti=cc826000 task=d1faeb10 task.ti=cc826000)
[  851.805872] Stack: c04fec94 c04feccd 000002f8 c04fecb5 0000f000 00000000 d1faeb10 cc826afc 
[  851.806173]        0000f000 00000000 00000000 c063387c d1faeb10 00000000 00000000 00000000 
[  851.807252]        cc053368 cc826b9c cc053088 ffffffff 00000000 00000000 cc0530d8 cc0531e4 
[  851.807513] Call Trace:
[  851.807593]  [<c01045da>] show_trace_log_lvl+0x1a/0x40
[  851.807697]  [<c01046a9>] show_stack_log_lvl+0xa9/0xe0
[  851.807774]  [<c01048c4>] show_registers+0x1e4/0x360
[  851.807852]  [<c0104b3a>] die+0xfa/0x240
[  851.807925]  [<c0104cf3>] do_trap+0x73/0xa0
[  851.808000]  [<c01056b7>] do_invalid_op+0x97/0xc0
[  851.808077]  [<c04734e4>] error_code+0x74/0x80
[  851.808347]  [<c028fb4a>] xtLookup+0xaa/0x240
[  851.808432]  [<c02a3c95>] metapage_get_blocks+0x95/0xe0
[  851.808512]  [<c02a44ea>] metapage_readpage+0xea/0x160
[  851.808593]  [<c014acf3>] read_cache_page+0x93/0x160
[  851.808676]  [<c02a46f4>] __get_metapage+0x114/0x420
[  851.808754]  [<c029a906>] dbMount+0x46/0x160
[  851.808835]  [<c028e024>] jfs_mount+0x84/0x180
[  851.808913]  [<c028a13c>] jfs_fill_super+0x11c/0x2a0
[  851.808994]  [<c016948c>] get_sb_bdev+0xec/0x140
[  851.809077]  [<c0289c21>] jfs_get_sb+0x21/0x40
[  851.809155]  [<c0168f64>] vfs_kern_mount+0xc4/0x140
[  851.809232]  [<c0169029>] do_kern_mount+0x29/0x60
[  851.809306]  [<c017e76b>] do_mount+0x2ab/0x6e0
[  851.809385]  [<c017ec0d>] sys_mount+0x6d/0xc0
[  851.809460]  [<c0102fd0>] syscall_call+0x7/0xb
[  851.809536]  =======================
[  851.809579] Code: c2 0f 85 20 fe ff ff c7 44 24 0c b5 ec 4f c0 c7 44 24 08
f8 02 00 00 c7 44 24 04 cd ec 4f c0 c7 04 24 94 ec 4f c0 e8 a6 c3 e8 ff <0f>
0b eb fe 89 f6 8b 7d bc f6 47 10 02 0f 84 33 01 00 00 8b 45 
[  851.811210] EIP: [<c028e57a>] xtSearch+0x2fa/0x6a0 SS:ESP 0068:cc826ab8
[  851.811572]  

On a damaged filesystem we might have a full stack and should
not progress further, and return instead of calling BUG()

Signed-off-by: Eric Sesterhenn

--- linux-2.6.19/fs/jfs/jfs_xtree.c.orig	2006-12-18 14:37:07.000000000 +0100
+++ linux-2.6.19/fs/jfs/jfs_xtree.c	2006-12-18 14:37:55.000000000 +0100
@@ -757,6 +757,8 @@ static int xtSearch(struct inode *ip, s6
 			nsplit = 0;
 
 		/* push (bn, index) of the parent page/entry */
+		if (BT_STACK_FULL(btstack))
+			return -EINVAL;
 		BT_PUSH(btstack, bn, index);
 
 		/* get the child page block number */


