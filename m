Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbVBKOpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVBKOpj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 09:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262250AbVBKOpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 09:45:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7043 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262236AbVBKOpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 09:45:25 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV: Fix sigaltstack handling for RT signals
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Fri, 11 Feb 2005 14:45:19 +0000
Message-ID: <10374.1108133119@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch fixes sigaltstack handling for RT signal return. It was
reading a userspace struct into kernel space and then passing the kernel copy
to a generic signalling routine which then assumed it had been passed a
userspace pointer...

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-Off-By: Alexander Viro <aviro@redhat.com>
---
warthog>diffstat frv-sigaltstk-2611rc3.diff 
 signal.c |   11 +----------
 1 files changed, 1 insertion(+), 10 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.11-rc3/arch/frv/kernel/signal.c linux-2.6.11-rc3-frv/arch/frv/kernel/signal.c
--- /warthog/kernels/linux-2.6.11-rc3/arch/frv/kernel/signal.c	2005-02-04 11:49:30.000000000 +0000
+++ linux-2.6.11-rc3-frv/arch/frv/kernel/signal.c	2005-02-11 12:46:40.369651032 +0000
@@ -242,18 +242,9 @@ asmlinkage int sys_rt_sigreturn(void)
 	if (restore_sigcontext(&frame->uc.uc_mcontext, &gr8))
 		goto badframe;
 
-	if (__copy_from_user(&st, &frame->uc.uc_stack, sizeof(st)))
+	if (do_sigaltstack(&frame->uc.uc_stack, NULL, __frame->sp) == -EFAULT)
 		goto badframe;
 
-	/* It is more difficult to avoid calling this function than to
-	 * call it and ignore errors.  */
-	/*
-	 * THIS CANNOT WORK! "&st" is a kernel address, and "do_sigaltstack()"
-	 * takes a user address (and verifies that it is a user address). End
-	 * result: it does exactly _nothing_.
-	 */
-	do_sigaltstack(&st, NULL, __frame->sp);
-
 	return gr8;
 
 badframe:
