Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbTHUSFf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 14:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbTHUSFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 14:05:35 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:31498 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262790AbTHUSFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 14:05:34 -0400
Date: Thu, 21 Aug 2003 19:05:24 +0100
From: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@infradead.org>
To: Linus Torvalds <torvalds@osdl.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH resend #1] Handle SA_NODEFER correctly for i386
Message-ID: <20030821190524.A2214@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

This fixes i386 to only ignore the current signal wir SA_NODEFER set.
All other architectures (except m68k, funny enough) need the same fix,
but I'm lazy today.

Joern

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
