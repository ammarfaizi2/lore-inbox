Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266165AbTGDUhe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 16:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266166AbTGDUhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 16:37:34 -0400
Received: from [213.39.233.138] ([213.39.233.138]:35266 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S266165AbTGDUhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 16:37:33 -0400
Date: Fri, 4 Jul 2003 22:51:26 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org, linuxppc64-dev@lists.linuxppc.org
Subject: [PATCH 2.5.73] Fix sa_mask and SA_NODEFER semantics for i386
Message-ID: <20030704205126.GA8196@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

This patch should be less to argue about.

A trivial case where code and documentation don't match.  This is from
man 3 sigaction:

     sa_mask gives a mask of signals which should be blocked  during execu-
     tion  of  the  signal handler.  In addition, the signal which triggered
     the handler will be blocked, unless the SA_NODEFER or  SA_NOMASK  flags
     are used.

In other words:
- Always block the signals from sa_mask.
- Also block the current signal, if SA_NODEFER is not set.

But without this patch, linux ignores sa_mask, when SA_NODEFER is set,
so either the documentation or our implementation is wrong.  Since the
bsd manpage matches the linux one, I guess the code is wrong.

Jörn

-- 
Everything should be made as simple as possible, but not simpler.
-- Albert Einstein

--- linux-2.5.73/arch/i386/kernel/signal.c~sigmask_i386	2003-07-04 18:59:48.000000000 +0200
+++ linux-2.5.73/arch/i386/kernel/signal.c	2003-07-04 22:39:59.000000000 +0200
@@ -551,13 +551,12 @@
 	if (ka->sa.sa_flags & SA_ONESHOT)
 		ka->sa.sa_handler = SIG_DFL;
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked,sig);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 }
 
 /*
