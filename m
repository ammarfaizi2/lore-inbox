Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVASJ7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVASJ7T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 04:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVASJ7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 04:59:19 -0500
Received: from darwin.snarc.org ([81.56.210.228]:10369 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S261651AbVASJ7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 04:59:15 -0500
Date: Wed, 19 Jan 2005 10:59:13 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] arch/i386/kernel/signal.c: fix err test twice
Message-ID: <20050119095913.GA4155@snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.6+20040907i
From: Vincent Hanquez <tab@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, the following patch:
	- correct the err variable tested twice when _NSIG_WORDS == 1
	  (unlikely to happen, but ..)
	- remove some |= in favor of = because we don't need to 'pack' err

Please apply,

Signed-off-by: Vincent Hanquez <tab@snarc.org>

--- linux-2.6.10/arch/i386/kernel/signal.c.orig	2005-01-14 21:02:13 +0100
+++ linux-2.6.10/arch/i386/kernel/signal.c	2005-01-14 21:05:32 +0100
@@ -369,20 +369,20 @@
 		? current_thread_info()->exec_domain->signal_invmap[sig]
 		: sig;
 
-	err |= __put_user(usig, &frame->sig);
+	err = __put_user(usig, &frame->sig);
 	if (err)
 		goto give_sigsegv;
 
-	err |= setup_sigcontext(&frame->sc, &frame->fpstate, regs, set->sig[0]);
+	err = setup_sigcontext(&frame->sc, &frame->fpstate, regs, set->sig[0]);
 	if (err)
 		goto give_sigsegv;
 
 	if (_NSIG_WORDS > 1) {
-		err |= __copy_to_user(&frame->extramask, &set->sig[1],
+		err = __copy_to_user(&frame->extramask, &set->sig[1],
 				      sizeof(frame->extramask));
+		if (err)
+			goto give_sigsegv;
 	}
-	if (err)
-		goto give_sigsegv;
 
 	restorer = &__kernel_sigreturn;
 	if (ka->sa.sa_flags & SA_RESTORER)
