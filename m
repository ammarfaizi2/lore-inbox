Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266241AbTGEAYo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 20:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266244AbTGEAYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 20:24:43 -0400
Received: from air-2.osdl.org ([65.172.181.6]:1994 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266241AbTGEAYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 20:24:42 -0400
Date: Fri, 4 Jul 2003 17:39:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: benh@kernel.crashing.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linuxppc-dev@lists.linuxppc.org>, <linuxppc64-dev@lists.linuxppc.org>
Subject: Re: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
In-Reply-To: <20030704201840.GH22152@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.44.0307041725180.1744-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Jul 2003, Jörn Engel wrote:
> 
> > Quite frankly, for the recursive SIGSEGV problem, I'd much rather look at
> > the signal mask. If SIGSEGV is blocked, we should probably just kill the
> > program instead of clearing the blocking and trying to handle the SIGSEGV 
> > anyway. That should fix your test case, _without_ any subtle side effects.
> 
> What do we do, if a program also uses SA_NOMASK for the SIGSEGV
> handler?  This is totally stupid, I agree, but it is legal.  Should we
> declare it illegal from this day on, or is that path blocked as well?

I think we should just continue to do what we do now - sure, we'll loop on 
SIGSEGV, but hey, it's a user space bug, it's not the kernels problem. 
It's better to let people continue to do stupid things than try to force 
changes.

So how about something like the appended? Very simple patch,i and in fact 
it's more logical than the old behaviour (the old behaviour punched 
through blocked signals, the new ones says "if you block or ignore the 
signal we will just kill you through the default action").

		Linus

---
--- 1.86/kernel/signal.c	Mon Jun  2 13:37:11 2003
+++ edited/kernel/signal.c	Fri Jul  4 17:29:43 2003
@@ -797,10 +797,11 @@
 	int ret;
 
 	spin_lock_irqsave(&t->sighand->siglock, flags);
-	if (t->sighand->action[sig-1].sa.sa_handler == SIG_IGN)
+	if (sigismember(&t->blocked, sig) || t->sighand->action[sig-1].sa.sa_handler == SIG_IGN) {
 		t->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
-	sigdelset(&t->blocked, sig);
-	recalc_sigpending_tsk(t);
+		sigdelset(&t->blocked, sig);
+		recalc_sigpending_tsk(t);
+	}
 	ret = specific_send_sig_info(sig, info, t);
 	spin_unlock_irqrestore(&t->sighand->siglock, flags);
 


