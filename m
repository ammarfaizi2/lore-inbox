Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264524AbUF0Wv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbUF0Wv4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 18:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbUF0Wv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 18:51:56 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:61645 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264524AbUF0Wvy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 18:51:54 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 27 Jun 2004 15:51:52 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Andries Brouwer <aebr@win.tue.nl>
cc: Steve G <linux_4ever@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.x signal handler bug
In-Reply-To: <Pine.LNX.4.58.0406271539340.19865@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0406271551000.19865@bigblue.dev.mdolabs.com>
References: <20040626143326.50865.qmail@web50607.mail.yahoo.com>
 <Pine.LNX.4.58.0406260839460.10038@bigblue.dev.mdolabs.com>
 <20040627221612.GA16664@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0406271539340.19865@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2004, Davide Libenzi wrote:

> On Mon, 28 Jun 2004, Andries Brouwer wrote:
> 
> > On Sat, Jun 26, 2004 at 09:05:34AM -0700, Davide Libenzi wrote:
> > 
> > > You're receiving a SIGSEGV while SIGSEGV is blocked (force_sig_info). The 
> > > force_sig_info call wants to send a signal that the task can't refuse 
> > > (kinda The GodFather offers ;). The kernel will noticed this and will 
> > > restore the handler to SIG_DFL.
> > 
> > Yes.
> > 
> > So checking whether this is POSIX conforming:
> > 
> > - Blocking a signal in its signal handler is explicitly allowed.
> >   (signal(3p))
> > - It is unspecified what longjmp() does with the signal mask.
> >   (longjmp(3p))
> > - The SIGSEGV that occurs during a stack overflow is of the GodFather kind.
> >   (getrlimit(3p))
> > - If SIGSEGV is generated while blocked, the result is undefined
> >   (sigprocmask(3p))
> > 
> > So, maybe the restoring to SIG_DFL was not required, but it doesnt seem
> > incorrect either. It may be a bit surprising.
> 
> I think so. Maybe the attached patch?

No, the SIG_IGN check should be there ...



- Davide




--- a/kernel/signal.c	2004-06-27 15:48:47.000000000 -0700
+++ b/kernel/signal.c	2004-06-27 15:49:14.000000000 -0700
@@ -821,7 +821,8 @@
 
 	spin_lock_irqsave(&t->sighand->siglock, flags);
 	if (sigismember(&t->blocked, sig) || t->sighand->action[sig-1].sa.sa_handler == SIG_IGN) {
-		t->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
+		if (t->sighand->action[sig-1].sa.sa_handler == SIG_IGN)
+			t->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 		sigdelset(&t->blocked, sig);
 		recalc_sigpending_tsk(t);
 	}
