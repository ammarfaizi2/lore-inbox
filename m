Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267218AbTBILyA>; Sun, 9 Feb 2003 06:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267219AbTBILx7>; Sun, 9 Feb 2003 06:53:59 -0500
Received: from mx1.elte.hu ([157.181.1.137]:2233 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S267218AbTBILx6>;
	Sun, 9 Feb 2003 06:53:58 -0500
Date: Sun, 9 Feb 2003 13:09:26 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@digeo.com>, Arjan van de Ven <arjanv@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: <200302091156.h19BuoH07869@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.44.0302091307510.5085-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Feb 2003, Roland McGrath wrote:

> >  - a read_lock(&tasklist_lock) is missing around the group_send_sig_info()
> >    in send_sig_info().
> 
> Indeed.  I still intend to clean up those entry points and haven't
> gotten to it, so I hadn't bothered with this yet either (though I think
> I sent it to you for the backport).  It certainly does bite in practice,
> e.g. SIGPIPE.

it does bite - here's the correctness fix meanwhile, until the interface 
is cleaned up.

	Ingo

--- linux/kernel/signal.c.orig	
+++ linux/kernel/signal.c	
@@ -1083,17 +1083,19 @@
 int
 send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 {
+	int ret;
+
 	/* XXX should nix these interfaces and update the kernel */
-	if (T(sig, SIG_KERNEL_BROADCAST_MASK))
-		/* XXX do callers really always hold the tasklist_lock?? */
-		return group_send_sig_info(sig, info, p);
-	else {
-		int error;
+	if (T(sig, SIG_KERNEL_BROADCAST_MASK)) {
+		read_lock(&tasklist_lock);
+		ret = group_send_sig_info(sig, info, p);
+		read_unlock(&tasklist_lock);
+	} else {
 		spin_lock_irq(&p->sighand->siglock);
-		error = specific_send_sig_info(sig, info, p);
+		ret = specific_send_sig_info(sig, info, p);
 		spin_unlock_irq(&p->sighand->siglock);
-		return error;
 	}
+	return ret;
 }
 
 int

