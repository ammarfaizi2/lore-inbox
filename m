Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbUJXWgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbUJXWgW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 18:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUJXWgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 18:36:22 -0400
Received: from mail.dif.dk ([193.138.115.101]:18104 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261600AbUJXWf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 18:35:59 -0400
Date: Mon, 25 Oct 2004 00:44:13 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] binfmt_elf; do proper error handling if clear_user fails in
 padzero
Message-ID: <Pine.LNX.4.61.0410250015350.3252@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

Here's another patch for fs/binfmt_elf.c, this one fixes a real issue in 
addition to killing a warning.

This is the warning we get rid of :

 fs/binfmt_elf.c: In function `padzero':
 fs/binfmt_elf.c:113: warning: ignoring return value of `clear_user', declared with attribute warn_unused_result


The problem is that the padzero function calls clear_user but neglects to 
check if it fails. That means that any caller of padzero() will be working 
on data that is assumed to be cleared, but the caller won't actually know. 
This matters, if it didn't there would be no point in calling padzero in 
the first place. In addition to possibly working on memory that's assumed 
to be zeroed but in fact may not be, something is obviously wrong if 
clear_user() fails to clear the __user * it is told to clear - so we need 
some error handling.


The patch below does the following:

- Changes padzero() to return int instead of void. The return value is now 
the number of bytes that could not be cleared/padded (as returned by 
clear_user()) on error, or 0 on success.

- Changes all callers of padzero() to check for non-zero return and take 
appropriate action.


The patch has seen the following testing:

- Compile tested. My changes compile cleanly and silence the warning.

- Boot tested (and been running for ~15min), but I have no way atm to 
actually hit the relevant code path, so this means little besides proving 
I made no obvious mistake that blows up the kernel instantly.

- And of course I've been reading the code to try and ensure I got 
everything right, but I'd appreciate a few more eyeballs.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc1-bk2/fs/binfmt_elf.c.orig linux-2.6.10-rc1-bk2/fs/binfmt_elf.c
--- linux-2.6.10-rc1-bk2/fs/binfmt_elf.c.orig	2004-10-24 23:46:49.000000000 +0200
+++ linux-2.6.10-rc1-bk2/fs/binfmt_elf.c	2004-10-25 00:13:04.000000000 +0200
@@ -103,15 +103,18 @@ static int set_brk(unsigned long start, 
    be in memory */
 
 
-static void padzero(unsigned long elf_bss)
+static int padzero(unsigned long elf_bss)
 {
 	unsigned long nbyte;
+	int ret = 0;
 
 	nbyte = ELF_PAGEOFFSET(elf_bss);
 	if (nbyte) {
 		nbyte = ELF_MIN_ALIGN - nbyte;
-		clear_user((void __user *) elf_bss, nbyte);
+		ret = clear_user((void __user *) elf_bss, nbyte);
 	}
+	
+	return ret;
 }
 
 /* Let's use some macros to make this stack manipulation a litle clearer */
@@ -400,7 +403,10 @@ static unsigned long load_elf_interp(str
 	 * that there are zero-mapped pages up to and including the 
 	 * last bss page.
 	 */
-	padzero(elf_bss);
+	if (padzero(elf_bss) != 0) {
+		error = -EFAULT;
+		goto out_close;
+	}
 	elf_bss = ELF_PAGESTART(elf_bss + ELF_MIN_ALIGN - 1);	/* What we have mapped so far */
 
 	/* Map the last of the bss segment */
@@ -837,7 +843,11 @@ static int load_elf_binary(struct linux_
 		send_sig(SIGKILL, current, 0);
 		goto out_free_dentry;
 	}
-	padzero(elf_bss);
+	if (padzero(elf_bss) != 0) {
+		send_sig(SIGKILL, current, 0);
+		retval = -EFAULT;
+		goto out_free_dentry;
+	}
 
 	if (elf_interpreter) {
 		if (interpreter_type == INTERPRETER_AOUT)
@@ -1000,7 +1010,10 @@ static int load_elf_library(struct file 
 		goto out_free_ph;
 
 	elf_bss = elf_phdata->p_vaddr + elf_phdata->p_filesz;
-	padzero(elf_bss);
+	if (padzero(elf_bss) != 0) {
+		error = -EFAULT;
+		goto out_free_ph;
+	}
 
 	len = ELF_PAGESTART(elf_phdata->p_filesz + elf_phdata->p_vaddr + ELF_MIN_ALIGN - 1);
 	bss = elf_phdata->p_memsz + elf_phdata->p_vaddr;


