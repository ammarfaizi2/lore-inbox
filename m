Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbTJMH6J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 03:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbTJMH6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 03:58:08 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:11137
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261515AbTJMH6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 03:58:05 -0400
Date: Mon, 13 Oct 2003 03:57:43 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6] No swapping on memory backed swapfiles
Message-ID: <Pine.LNX.4.53.0310130354440.28426@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an oops when running LTP on a system with a tmpfs /tmp. The 
oops is from the lack of a readpage a_op. This patch simply disables 
enabling of swap for memory backed swapfiles.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010246
EIP is at 0x0
eax: 00000000   ebx: c1076458   ecx: c1651660   edx: c1076458
esi: 00000000   edi: e2c38f68   ebp: dfd93f24   esp: e202bf4c
ds: 007b   es: 007b   ss: 0068
Process swapon02 (pid: 5718, threadinfo=e202a000 task=d6f769d0)
Stack: c0145c0c e2c38f68 c1076458 dfd93e88 dfd93e88 00000000 00000000 c01658c8
       dfd93f24 00000000 00000000 e2c38f68 e3d7fe58 c07430d0 dfd93e88 dfd93e88
       00000000 00000001 00000000 00000000 ffffffea dfd93f24 e2c38f68 00000000
Call Trace:
 [<c0145c0c>] read_cache_page+0x5c/0x360
 [<c01658c8>] sys_swapon+0x528/0xa30
 [<c01096e9>] sysenter_past_esp+0x52/0x79

Code:  Bad EIP value.

(gdb) list  *read_cache_page+0x5c
0xc0145c0c is in read_cache_page (mm/filemap.c:1393).
1388                            page_cache_release(cached_page);
1389                            return ERR_PTR(err);
1390                    }
1391                    page = cached_page;
1392                    cached_page = NULL;
1393                    err = filler(data, page);
1394                    if (err < 0) {
1395                            page_cache_release(page);
1396                            page = ERR_PTR(err);
1397                    }

Index: linux-2.6.0-test7/mm/swapfile.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test7/mm/swapfile.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 swapfile.c
--- linux-2.6.0-test7/mm/swapfile.c	9 Oct 2003 05:56:12 -0000	1.1.1.1
+++ linux-2.6.0-test7/mm/swapfile.c	13 Oct 2003 07:27:28 -0000
@@ -1233,6 +1233,7 @@ asmlinkage long sys_swapon(const char __
 	struct page *page = NULL;
 	struct inode *inode;
 	struct inode *downed_inode = NULL;
+	struct backing_dev_info *bdi;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -1293,6 +1294,10 @@ asmlinkage long sys_swapon(const char __
 	}
 
 	error = -EINVAL;
+	bdi = mapping->backing_dev_info;
+	if (bdi->memory_backed)
+		goto bad_swap;
+
 	if (S_ISBLK(inode->i_mode)) {
 		bdev = inode->i_bdev;
 		error = bd_claim(bdev, sys_swapon);
