Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbUJYVd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbUJYVd3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 17:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbUJYV35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 17:29:57 -0400
Received: from mail.dif.dk ([193.138.115.101]:30651 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261313AbUJYV0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 17:26:46 -0400
Date: Mon, 25 Oct 2004 23:35:01 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] binfmt_elf; check clear_user() return value in load_elf_binary()
Message-ID: <Pine.LNX.4.61.0410252312040.3332@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

Here's yet another small patch for fs/binfmt_elf.c. This one was created 
incrementally to my previous patch that dealt with the clear_user() in 
padzero(). It doesn't depend on that patch, but just so you know why the 
offsets may be a little fuzzy if you apply it to vanilla.

The patch gets rid of this warning:
 fs/binfmt_elf.c: In function `load_elf_binary':
 fs/binfmt_elf.c:758: warning: ignoring return value of `clear_user', declared with attribute warn_unused_result

And makes sure that we check the return value of clear_user() and fail 
appropriately if it fails to do its job.

With this and the two previous patches we are now down to only two 
warnings (and hopefully have a few potential problems less) in 
binfmt_elf.c - patches for the remaining warnings will appear soon.

Patch has been compile tested.
Patch has been boot tested.
Patch needs more eyeballs to make sure sending SIGKILL and returning 
-EFAULT really is appropriate here.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc1-bk2/fs/binfmt_elf.c.juhl1 linux-2.6.10-rc1-bk2/fs/binfmt_elf.c
--- linux-2.6.10-rc1-bk2/fs/binfmt_elf.c.juhl1	2004-10-25 23:01:28.000000000 +0200
+++ linux-2.6.10-rc1-bk2/fs/binfmt_elf.c	2004-10-25 23:15:38.000000000 +0200
@@ -761,7 +761,11 @@ static int load_elf_binary(struct linux_
 				nbyte = ELF_MIN_ALIGN - nbyte;
 				if (nbyte > elf_brk - elf_bss)
 					nbyte = elf_brk - elf_bss;
-				clear_user((void __user *) elf_bss + load_bias, nbyte);
+				if (clear_user((void __user *) elf_bss + load_bias, nbyte)) {
+					send_sig(SIGKILL, current, 0);
+					retval = -EFAULT;
+					goto out_free_dentry;
+				}
 			}
 		}
 

