Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135989AbREBVhm>; Wed, 2 May 2001 17:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135992AbREBVhc>; Wed, 2 May 2001 17:37:32 -0400
Received: from mail.valinux.com ([198.186.202.175]:23058 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S135989AbREBVhY>;
	Wed, 2 May 2001 17:37:24 -0400
Date: Wed, 2 May 2001 15:37:01 -0600
From: Don Dugger <n0ano@valinux.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Bug in kernel/fork.c in 2.4.4 kernel
Message-ID: <20010502153701.A6830@tlaloc.n0ano.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In working on thread core dumps I've stumbled across a minor bug in the
generic `fork' code.  The problem code is in routine `copy_mm' in
`kernel/fork.c':

	/* Copy the current MM stuff.. */
        memcpy(mm, oldmm, sizeof(*mm));
	  .
	  .
	  .
        if (retval)
                goto free_pt;

        /*
         * child gets a private LDT (if there was an LDT in the parent)
         */
        copy_segments(tsk, mm);
	  .
	  .
	  .
free_pt:
	mmput(mm);

The new `mm' doesn't get it's own private version of it's `context'
field until after the call to `copy_segments'.  At the `goto' the pointer
`mm' points to a copy of the old `mm_struct', including a copy of the
`context' field.  `mmput' will call `release_segments' which will free
the memory pointed to by the `context' field.  Later, when `oldmm' is
freed, the kernel will try to free the same memory twice - very bad.

Admittedly, this will only occur on an obscure error condition but
it should be fixed.  The attached patch fixes the problem by zeroing
out the `context' field immediately after the `mm' structure is
copied.
-- 
Don Dugger
"Censeo Toto nos in Kansa esse decisse." - D. Gale
n0ano@valinux.com
Ph: 303/938-9838


--- linux-2.4.4-ref/kernel/fork.c	Thu Apr 26 07:11:17 2001
+++ linux/kernel/fork.c	Wed May  2 14:39:38 2001
@@ -311,6 +311,10 @@
 
 	/* Copy the current MM stuff.. */
 	memcpy(mm, oldmm, sizeof(*mm));
+
+	/* Clear new context for now */
+	memset(&mm->context, 0, sizeof(mm->context));
+
 	if (!mm_init(mm))
 		goto fail_nomem;
 
