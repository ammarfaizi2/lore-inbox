Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbTLGIej (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 03:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbTLGIej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 03:34:39 -0500
Received: from holomorphy.com ([199.26.172.102]:23768 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263776AbTLGIef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 03:34:35 -0500
Date: Sun, 7 Dec 2003 00:34:32 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: suparna@in.ibm.com, linux-aio@kvack.org
Subject: aio on ramfs
Message-ID: <20031207083432.GP19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, suparna@in.ibm.com,
	linux-aio@kvack.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to run an aio benchmark on pgcl with ramfs in order to
exercise aio codepaths. It didn't have the aio methods, and so was
failing to do so. The following, suggested by Suparna Bhattacharya,
resolved the issue.

The reasoning is as follows:
(1) There's nowhere to write the things to, so nop out write functions.
(2) Since there's nowhere to write the things to, setting it dirty and
	going through writeback logic is also useless. Hence nop out
	->set_page_dirty().

An equivalent patch was successfully tested on pgcl running an aio
benchmark in combination with recently-posted aio fixes for pgcl.

New nop methods are necessary, for without the nop methods, an oops
like the following will occur when the mpage.c writeback code attempts
to invoke NULL method pointers:

Script started on Mon Dec  1 20:15:46 2003
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pdpte = 30050001
*pde = 0
Oops: 0000 [#1]
CPU:    7
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010246
EIP is at 0x0
eax: 00000000   ebx: 00000000   ecx: 00000001   edx: f4ae8188
esi: ec03abe0   edi: f10cba4c   ebp: f10cbc98   esp: f10cb9ec
ds: 007b   es: 007b   ss: 0068
Process OraSim (pid: 2996, threadinfo=f10ca000 task=eec5f100)
Stack: c017bc54 ec03abe0 00000000 00000000 f10cba4c 00000001 f2772ac4 f2773ddc 
       00000000 00000000 00000000 00000000 00000000 00000001 00000000 00000000 
       00000000 00007cdf 00000000 00000001 000a8000 0000000f ec03abe0 ec03ac74 
Call Trace:
 [<c017bc54>] mpage_writepage+0x5a4/0x820
 [<c015d18f>] __getblk+0x2f/0x60
 [<c015d246>] __bread+0x26/0x40
 [<c018fe62>] read_block_bitmap+0x52/0x90
 [<c0190844>] ext2_new_block+0x324/0x570
 [<c0193000>] ext2_alloc_block+0x80/0xc0
 [<c0193395>] ext2_alloc_branch+0x35/0x210
 [<c01935e7>] ext2_get_block+0x77/0x390
 [<c015c08d>] __find_get_block_slow+0x4d/0x160
 [<c014b520>] handle_mm_fault+0x110/0x210
 [<c015c785>] __set_page_dirty_buffers+0xf5/0x120
 [<c015e993>] nobh_prepare_write+0x1b3/0x410
 [<c017c14a>] mpage_writepages+0x27a/0x2ac
 [<c013f607>] do_writepages+0x37/0x40
 [<c017a3a4>] __sync_single_inode+0xc4/0x210
 [<c017aaf6>] write_inode_now+0x46/0x80
 [<c017abe1>] generic_osync_inode+0xb1/0x110
 [<c013bacd>] generic_file_aio_write_nolock+0x5dd/0xbe0
 [<c0150068>] rmap_add_folio+0xd8/0x110
 [<c013c148>] generic_file_write_nolock+0x78/0x90
 [<c0118f36>] do_page_fault+0x176/0xa8f
 [<c011d050>] default_wake_function+0x0/0x20
 [<c011d050>] default_wake_function+0x0/0x20
 [<c013c246>] generic_file_write+0x56/0x70
 [<c015a69a>] vfs_write+0xaa/0x130
 [<c010fcf0>] do_gettimeofday+0x30/0xd0
 [<c015a8b4>] sys_pwrite64+0x54/0x80
 [<c01095e3>] syscall_call+0x7/0xb

Code:  Bad EIP value.
Script done on Mon Dec  1 20:32:13 2003


-- wli

diff -prauN linux-2.6.0-test11/fs/ramfs/inode.c ramfs-2.6.0-test11-1/fs/ramfs/inode.c
--- linux-2.6.0-test11/fs/ramfs/inode.c	2003-11-26 12:43:32.000000000 -0800
+++ ramfs-2.6.0-test11-1/fs/ramfs/inode.c	2003-12-07 00:26:29.000000000 -0800
@@ -31,6 +31,7 @@
 #include <linux/string.h>
 #include <linux/smp_lock.h>
 #include <linux/backing-dev.h>
+#include <linux/writeback.h>
 
 #include <asm/uaccess.h>
 
@@ -140,10 +141,28 @@ static int ramfs_symlink(struct inode * 
 	return error;
 }
 
+static int ramfs_writepage(struct page *page, struct writeback_control *wbc)
+{
+	return 0;
+}
+
+static int ramfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
+{
+	return 0;
+}
+
+static int ramfs_set_page_dirty(struct page *page)
+{
+	return 0;
+}
+
 static struct address_space_operations ramfs_aops = {
 	.readpage	= simple_readpage,
 	.prepare_write	= simple_prepare_write,
-	.commit_write	= simple_commit_write
+	.commit_write	= simple_commit_write,
+	.set_page_dirty	= ramfs_set_page_dirty,
+	.writepage	= ramfs_writepage,
+	.writepages	= ramfs_writepages,
 };
 
 static struct file_operations ramfs_file_operations = {
@@ -153,6 +172,8 @@ static struct file_operations ramfs_file
 	.fsync		= simple_sync_file,
 	.sendfile	= generic_file_sendfile,
 	.llseek		= generic_file_llseek,
+	.aio_read	= generic_file_aio_read,
+	.aio_write	= generic_file_aio_write,
 };
 
 static struct inode_operations ramfs_file_inode_operations = {
