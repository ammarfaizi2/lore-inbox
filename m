Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262452AbVA0ELs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbVA0ELs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 23:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVA0ELs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 23:11:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:56216 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262452AbVA0ELn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 23:11:43 -0500
Date: Wed, 26 Jan 2005 20:11:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Attila Body <compi@freemail.hu>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: UDF madness
Message-Id: <20050126201141.59c90e69.akpm@osdl.org>
In-Reply-To: <1106688285.5297.3.camel@smiley>
References: <1106688285.5297.3.camel@smiley>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attila Body <compi@freemail.hu> wrote:
>
> I've spent some time (2 weekwnds) on this issue, while I was able to
>  realize that not the packet-writing but the UDF driver is broken
> 
>  here is the recipie to reproduve the issue:
> 
>  dd if=/dev/zer of=udf.img bs=1024k count=3000
>  mkudffs udf.img
>  mount -o loop udf.img /mnt/tmp
>  cd /mnt/tmp
>  tar xjvf /usr/src/linux-2.6.11-rc2
>  cd /
>  umount /mnt/tmp
> 
>  On the end I get a never ending umount process in D state. sysreq-T
>  tells the following about the umount process:
> 
> 
> 
>  umount        D C03F93E0     0  5848   5655                     (NOTLB)
>  c797dd68 00200082 ca674560 c03f93e0 00000040 00000000 c81e327c 0000000c 
>         000ae62d 925f0dc0 000f43e3 ca674560 ca6746b0 c797c000 cebf184c
>  00200282 
>         ca674560 c02ea6e0 cebf1854 00000001 ca674560 c01170c0 cebf1854
>  cebf1854 
>  Call Trace:
>   [<c02ea6e0>] __down+0x90/0x110
>   [<c01170c0>] default_wake_function+0x0/0x20
>   [<c017c511>] __mark_inode_dirty+0xd1/0x1c0
>   [<c02ea8ab>] __down_failed+0x7/0xc
>   [<e0d1fda0>] .text.lock.balloc+0x8/0x128 [udf]
>   [<e0d25767>] udf_write_aext+0xf7/0x170 [udf]
>   [<e0d1fbac>] udf_free_blocks+0xcc/0x100 [udf]
>   [<e0d2cda4>] extent_trunc+0x124/0x180 [udf]
>   [<e0d2d025>] udf_discard_prealloc+0x225/0x2e0 [udf]
>   [<e0d21301>] udf_clear_inode+0x41/0x50 [udf]
>   [<c017285e>] clear_inode+0xde/0x120
>   [<c01728df>] dispose_list+0x3f/0xb0
>   [<c0172a92>] invalidate_inodes+0x62/0x90
>   [<c015e9ad>] generic_shutdown_super+0x5d/0x140

Yes, me too.  generic_shutdown_super() takes lock_super().  And udf uses
lock_super for protecting its block allocation data strutures.  Trivial
deadlock on unmount.

Filesystems really shouldn't be using lock_super() for internal purposes,
and the main filesystems have been taught to not do that any more, but UDF
is a holdout.

It seems that this deadlock was introduced on Jan 5 by the "udf: fix
reservation discarding" patch which added the udf_discard_prealloc() call
into udf_clear_inode().  The below dopey patch prevents the deadlock, but
perhaps we can think of something more appealing.  Ideally, use a new lock
altogether?

(I had UDF deadlock on me once during the untar.  That was a multi-process
lockup and is probably due to a lock ranking bug.  Will poke at that a bit
further).


--- 25/fs/udf/balloc.c~udf-umount-deadlock-fix	2005-01-26 19:45:38.351735200 -0800
+++ 25-akpm/fs/udf/balloc.c	2005-01-26 19:50:35.951493160 -0800
@@ -155,8 +155,17 @@ static void udf_bitmap_free_blocks(struc
 	unsigned long i;
 	int bitmap_nr;
 	unsigned long overflow;
+	int took_lock_super = 0;
+
+	if (sb->s_flags & MS_ACTIVE) {
+		/*
+		 * On the umount path, generic_shutdown_super() holds
+		 * lock_super for us
+		 */
+		lock_super(sb);
+		took_lock_super = 1;
+	}
 
-	lock_super(sb);
 	if (bloc.logicalBlockNum < 0 ||
 		(bloc.logicalBlockNum + count) > UDF_SB_PARTLEN(sb, bloc.partitionReferenceNum))
 	{
@@ -215,7 +224,8 @@ error_return:
 	sb->s_dirt = 1;
 	if (UDF_SB_LVIDBH(sb))
 		mark_buffer_dirty(UDF_SB_LVIDBH(sb));
-	unlock_super(sb);
+	if (took_lock_super)
+		unlock_super(sb);
 	return;
 }
 
_

