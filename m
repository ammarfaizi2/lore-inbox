Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266215AbTGKU2A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbTGKU17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:27:59 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:59318 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S265932AbTGKU13
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:27:29 -0400
Subject: BUG at fs/jbd/transaction.c:684 during setxattr on 2.5.75
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andreas Gruenbacher <ag@bestbits.at>, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@intercode.com.au>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1057956115.13738.522.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jul 2003 16:41:56 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've encountered a kernel BUG in jbd during setxattr on 2.5.75, likely
related to the recent xattr locking changes.  Originally encountered
with SELinux enabled, but also occurs with SELinux disabled.  I have not
been able to reproduce it with 2.5.74.

Relevant kernel config is:
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_SECURITY=y
CONFIG_SECURITY_CAPABILITIES=y
# CONFIG_SECURITY_SELINUX is not set

No other kernel patches, and SELinux patch for 2.5.75 only adds the
SELinux module to the security/selinux subdirectory, so there is no
affect when the option is disabled as above.  No modules loaded.  

A command for reproducing the bug is:
find . -exec setfattr -n security.selinux -v system_u:object_r:staff_home_t {} \;

However, you should be able to use security.foo for the -n and any value
for the -v to achieve the same effect.  The only important thing is to
set a value that actually causes a change to any existing value for the
attribute.  This was run in a fairly large directory, and took a few
moments to trigger the bug (but < 5 minutes).

Kernel output was:

journal_commit_transaction: freed 4 reserved buffers
journal_commit_transaction: freed 5 reserved buffers
journal_commit_transaction: freed 6 reserved buffers
journal_commit_transaction: freed 7 reserved buffers
Assertion failure in do_get_write_access() at fs/jbd/transaction.c:684: "handle->h_buffer_credits > 0"
------------[ cut here ]------------
kernel BUG at fs/jbd/transaction.c:684!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c01b69e9>]    Not tainted
EFLAGS: 00010282
EIP is at do_get_write_access+0x7e9/0x870
eax: 0000006a   ebx: dcc247f0   ecx: df4580c0   edx: 00000001
esi: df3b6c64   edi: dfdbcb08   ebp: df3b6c64   esp: dce25c68
ds: 007b   es: 007b   ss: 0068
Process setfattr (pid: 17114, threadinfo=dce24000 task=dd8be0a0)
Stack: c0473880 c0457497 c046fed2 000002ac c046ff8a dfdae168 db03e2c8 00000000 
       00000000 00000000 dfdae084 c01674e1 dcc247f0 004c0517 00001000 00001000 
       004c0517 dfdcc63c 0fd578d4 da4d3000 df3b6c64 dd99c41c 0fd578d4 c01b6cf9 
Call Trace:
 [<c01674e1>] __bread+0x11/0x40
 [<c01b6cf9>] journal_get_create_access+0x229/0x2f0
 [<c01b4c28>] ext3_xattr_rehash+0x78/0xa0
 [<c01b41e5>] ext3_xattr_set_handle2+0x115/0x500
 [<c02da824>] pciserial_init_one+0x2a4/0x2e0
 [<c01b3c29>] ext3_xattr_set_handle+0x299/0x740
 [<c014ad37>] __alloc_percpu+0x87/0xf0
 [<c01b4727>] ext3_xattr_delete_inode+0xc7/0x250
 [<c01b5494>] start_this_handle+0x194/0x650
 [<c01b30a3>] ext3_getxattr+0xd3/0x120
 [<c0189552>] sys_setxattr+0x22/0x70
 [<c01592a4>] shmem_recalc_inode+0xa4/0xc0
 [<c0153c9d>] do_file_page+0x6d/0x130
 [<c017efe0>] dput+0x150/0x3a0
 [<c0174c43>] link_path_walk+0x7c3/0xb40
 [<c017564c>] lock_rename+0xcc/0x160
 [<c017564c>] lock_rename+0xcc/0x160
 [<c018963f>] sys_fsetxattr+0x2f/0x70
 [<c011c520>] do_page_fault+0x20/0x497
 [<c010b54b>] syscall_call+0x7/0xb

Code: 0f 0b ac 02 d2 fe 46 c0 8b 54 24 60 8b 42 04 e9 46 ff ff ff 
 <6>note: setfattr[17114] exited with preempt_count 2
bad: scheduling while atomic!
Call Trace:
 [<c011f0b8>] __wake_up_common+0x38/0x60
 [<c0151edb>] zap_page_range+0xfb/0x1d0
 [<c01520ec>] get_user_pages+0x9c/0x440
 [<c0156b7d>] .text.lock.mmap+0x5d/0xb0
 [<c01223bb>] mm_release+0x4b/0xa0
 [<c01271d1>] do_exit+0x291/0x5d0
 [<c010ca60>] do_invalid_op+0x0/0xe0
 [<c010c6e3>] die+0x153/0x160
 [<c011cf96>] fixup_exception+0x36/0x40
 [<c010cb30>] do_invalid_op+0xd0/0xe0
 [<c01b69e9>] do_get_write_access+0x7e9/0x870
 [<c011f17a>] __wake_up+0x9a/0xc0
 [<c011f226>] __wake_up_sync+0x56/0xe0
 [<c01253a6>] console_unblank+0x36/0x60
 [<c010bfd5>] error_code+0x2d/0x38
 [<c01b69e9>] do_get_write_access+0x7e9/0x870
 [<c01674e1>] __bread+0x11/0x40
 [<c01b6cf9>] journal_get_create_access+0x229/0x2f0
 [<c01b4c28>] ext3_xattr_rehash+0x78/0xa0
 [<c01b41e5>] ext3_xattr_set_handle2+0x115/0x500
 [<c02da824>] pciserial_init_one+0x2a4/0x2e0
 [<c01b3c29>] ext3_xattr_set_handle+0x299/0x740
 [<c014ad37>] __alloc_percpu+0x87/0xf0
 [<c01b4727>] ext3_xattr_delete_inode+0xc7/0x250
 [<c01b5494>] start_this_handle+0x194/0x650
 [<c01b30a3>] ext3_getxattr+0xd3/0x120
 [<c0189552>] sys_setxattr+0x22/0x70
 [<c01592a4>] shmem_recalc_inode+0xa4/0xc0
 [<c0153c9d>] do_file_page+0x6d/0x130
 [<c017efe0>] dput+0x150/0x3a0
 [<c0174c43>] link_path_walk+0x7c3/0xb40
 [<c017564c>] lock_rename+0xcc/0x160
 [<c017564c>] lock_rename+0xcc/0x160
 [<c018963f>] sys_fsetxattr+0x2f/0x70
 [<c011c520>] do_page_fault+0x20/0x497
 [<c010b54b>] syscall_call+0x7/0xb



