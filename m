Return-Path: <linux-kernel-owner+w=401wt.eu-S964786AbWLTCWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWLTCWL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 21:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWLTCWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 21:22:11 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:34306 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964781AbWLTCWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 21:22:09 -0500
Message-ID: <45889E4B.7050406@in.ibm.com>
Date: Tue, 19 Dec 2006 18:22:03 -0800
From: Suzuki <suzuki@in.ibm.com>
Organization: IBM Linux Technology Center
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060413 Red Hat/1.7.13-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org,
       cmm@us.ibm.com, amit <amitarora@in.ibm.com>, jack@suse.cz
Subject: Re: [RFC] [PATCH] Fix kmalloc flags used in ext3 with an active	journal
 handle
References: <458898B4.5010805@in.ibm.com> <20061219180358.bfda00f0.akpm@osdl.org>
In-Reply-To: <20061219180358.bfda00f0.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------080403020708000803020002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080403020708000803020002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Andrew Morton wrote:
> On Tue, 19 Dec 2006 17:58:12 -0800
> Suzuki <suzuki@in.ibm.com> wrote:
> 
> 
>>* Fix the kmalloc flags used from within ext3, when we have an active journal handle
>>
>>	If we do a kmalloc with GFP_KERNEL on system running low on memory, with an active journal handle, we might end up in cleaning up the fs cache flushing dirty inodes for some other filesystem. This would cause hitting a J_ASSERT() in :
> 
> 
> The change might be needed (haven't looked at it yet).  But I'd like to see
> the full BUG trace, please.  To see the callchain.

Here is the call trace which was hit by one of our test teams. This was 
from fs/ext3/xattr.c. While looking for similar calls I found the others 
described in the patch.

Assertion failure in journal_start() at fs/jbd/transaction.c:274: "handle-
 >h_transaction->t_journal == journal"
kernel BUG at fs/jbd/transaction.c:274!
illegal operation: 0001 [#1]
CPU:    0    Not tainted (2.6.5-7.282-s390x SLES9_SP3_BRANCH-20061031152356)
Process dbench (pid: 14070, task: 00000000025617f0, ksp: 0000000001057630)
Krnl PSW : 0700000180000000 0000000008837b38 (journal_start+0x90/0x15c 
[jbd])
Krnl GPRS: 0000000000000000 0000000000507fc0 000000000000002b 
0000000001056d80
            0000000008837b36 0000000000002885 0000000008841da6 
0000000000000000
            00000000001bfaa0 0000000003483d08 0000000000000002 
0000000007a8bda0
            0000000008833000 00000000088a7d08 0000000008837b36 
0000000001056e80
Krnl Code: 00 00 58 10 b0 0c a7 1a 00 01 b9 04 00 2b 50 10 b0 0c e3 40
Call Trace:
  [<00000000088a30fc>] ext3_journal_start+0x8c/0xa4 [ext3]
  [<0000000008896822>] ext3_dirty_inode+0x3a/0xe0 [ext3]
  [<00000000001ca362>] __mark_inode_dirty+0x1ae/0x1c8
  [<00000000001bfaa0>] iput+0xbc/0xf0
  [<00000000001bdcca>] prune_dcache+0x29e/0x584
  [<00000000001bdfe4>] shrink_dcache_memory+0x34/0x54
  [<000000000017b100>] shrink_slab+0x15c/0x250
  [<000000000017b6e4>] try_to_free_pages+0x1c0/0x2a4
  [<0000000000170276>] __alloc_pages+0x2ba/0x4e0
  [<000000000017059a>] __get_free_pages+0x4e/0x8c
  [<0000000000174ea2>] cache_alloc_refill+0x2a6/0x868
  [<0000000000175540>] __kmalloc+0xdc/0xe0
  [<00000000088a4e62>] ext3_xattr_set_handle+0x114a/0x174c [ext3]
  [<00000000088a54e4>] ext3_xattr_set+0x80/0xd0 [ext3]
  [<00000000088a6312>] ext3_xattr_user_set+0xce/0xe4 [ext3]
  [<00000000088a5f1e>] ext3_setxattr+0x17e/0x18c [ext3]
  [<00000000001c88e6>] setxattr+0x14a/0x234
  [<00000000001c8a80>] sys_fsetxattr+0xb0/0x110
  [<000000000011fc10>] sysc_noemu+0x10/0x16
> 
> Always include the trace...

Will take care of it from now onwards.
> 
> Thanks.


--------------080403020708000803020002
Content-Type: text/x-patch;
 name="fix-ext3-kmalloc-flags-with-journal-handle.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-ext3-kmalloc-flags-with-journal-handle.diff"

* Fix the kmalloc flags used from within ext3, when we have an active journal handle

	If we do a kmalloc with GFP_KERNEL on system running low on memory, with an active journal handle, we might end up in cleaning up the fs cache flushing dirty inodes for some other filesystem. This would cause hitting a J_ASSERT() in :

handle_t *journal_start(journal_t *journal, int nblocks)
{
	handle_t *handle = journal_current_handle();
	int err;
[...]

	if (handle) {
		J_ASSERT(handle->h_transaction->t_journal == journal);


Here are the places where we do kmalloc or may end up doing kmalloc, with __GFP_FS (through GFP_KERNEL) from ext3, while holding a journal handle. 

1) fs/ext3/xattr.c :: ext3_xattr_block_set() : 2 occurences 

2) fs/ext3/resize.c :: reserve_backup_gdb()
3) fs/ext3/resize.c :: add_new_gdb()


4) fs/ext3/acl.c :: ext3_init_acl() :
    There are quite a few points where we may endup calling the kmalloc() from ext3_init_acl() which is called with a handle() from ext3_new_inode():

 a)   Called direclty within ext3_init_acl() as:
          clone = posix_acl_clone(acl, GFP_KERNEL);
 b) With the following code path:    
    ext3_init_acl()-> ext3_get_acl()-> ext3_acl_from_disk() -> posix_acl_alloc(GFP_KERNEL)

 c) Also  ext3_init_acl()-> ext3_get_acl()-> kmalloc() also might call kmalloc() directly.


5) fs/ext3/acl.c :: ext3_acl_to_disk() which is called from ext3_set_acl().


Among these 4.b & 4.c may be called from a with or without handle case. 

There was a similar issue reported sometime back, early this year.

http://lkml.org/lkml/2006/1/31/54

Attached patch fixes all the above invocatins to make use of GFP_NOFS instead of GFP_KERNEL.


Signed-off-by: Suzuki K P <suzuki@in.ibm.com>

Index: linux-2.6.20-rc1/fs/ext3/xattr.c
===================================================================
--- linux-2.6.20-rc1.orig/fs/ext3/xattr.c	2006-12-13 17:14:23.000000000 -0800
+++ linux-2.6.20-rc1/fs/ext3/xattr.c	2006-12-19 11:41:35.000000000 -0800
@@ -718,7 +718,7 @@
 				ce = NULL;
 			}
 			ea_bdebug(bs->bh, "cloning");
-			s->base = kmalloc(bs->bh->b_size, GFP_KERNEL);
+			s->base = kmalloc(bs->bh->b_size, GFP_NOFS);
 			error = -ENOMEM;
 			if (s->base == NULL)
 				goto cleanup;
@@ -730,7 +730,7 @@
 		}
 	} else {
 		/* Allocate a buffer where we construct the new block. */
-		s->base = kmalloc(sb->s_blocksize, GFP_KERNEL);
+		s->base = kmalloc(sb->s_blocksize, GFP_NOFS);
 		/* assert(header == s->base) */
 		error = -ENOMEM;
 		if (s->base == NULL)
Index: linux-2.6.20-rc1/fs/ext3/resize.c
===================================================================
--- linux-2.6.20-rc1.orig/fs/ext3/resize.c	2006-12-13 17:14:23.000000000 -0800
+++ linux-2.6.20-rc1/fs/ext3/resize.c	2006-12-19 11:42:39.000000000 -0800
@@ -440,7 +440,7 @@
 		goto exit_dindj;
 
 	n_group_desc = kmalloc((gdb_num + 1) * sizeof(struct buffer_head *),
-			GFP_KERNEL);
+			GFP_NOFS);
 	if (!n_group_desc) {
 		err = -ENOMEM;
 		ext3_warning (sb, __FUNCTION__,
@@ -524,7 +524,7 @@
 	int res, i;
 	int err;
 
-	primary = kmalloc(reserved_gdb * sizeof(*primary), GFP_KERNEL);
+	primary = kmalloc(reserved_gdb * sizeof(*primary), GFP_NOFS);
 	if (!primary)
 		return -ENOMEM;
 
Index: linux-2.6.20-rc1/fs/ext3/acl.c
===================================================================
--- linux-2.6.20-rc1.orig/fs/ext3/acl.c	2006-12-13 17:14:23.000000000 -0800
+++ linux-2.6.20-rc1/fs/ext3/acl.c	2006-12-19 11:45:35.000000000 -0800
@@ -37,7 +37,7 @@
 		return ERR_PTR(-EINVAL);
 	if (count == 0)
 		return NULL;
-	acl = posix_acl_alloc(count, GFP_KERNEL);
+	acl = posix_acl_alloc(count, GFP_NOFS);
 	if (!acl)
 		return ERR_PTR(-ENOMEM);
 	for (n=0; n < count; n++) {
@@ -91,7 +91,7 @@
 
 	*size = ext3_acl_size(acl->a_count);
 	ext_acl = kmalloc(sizeof(ext3_acl_header) + acl->a_count *
-			sizeof(ext3_acl_entry), GFP_KERNEL);
+			sizeof(ext3_acl_entry), GFP_NOFS);
 	if (!ext_acl)
 		return ERR_PTR(-ENOMEM);
 	ext_acl->a_version = cpu_to_le32(EXT3_ACL_VERSION);
@@ -187,7 +187,7 @@
 	}
 	retval = ext3_xattr_get(inode, name_index, "", NULL, 0);
 	if (retval > 0) {
-		value = kmalloc(retval, GFP_KERNEL);
+		value = kmalloc(retval, GFP_NOFS);
 		if (!value)
 			return ERR_PTR(-ENOMEM);
 		retval = ext3_xattr_get(inode, name_index, "", value, retval);
@@ -335,7 +335,7 @@
 			if (error)
 				goto cleanup;
 		}
-		clone = posix_acl_clone(acl, GFP_KERNEL);
+		clone = posix_acl_clone(acl, GFP_NOFS);
 		error = -ENOMEM;
 		if (!clone)
 			goto cleanup;

--------------080403020708000803020002--
