Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbVJWPIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVJWPIx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 11:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbVJWPIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 11:08:53 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:55974 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750739AbVJWPIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 11:08:52 -0400
Date: Sun, 23 Oct 2005 08:09:33 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu,
       dipankar@in.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Remove duplicate code in signal.c
Message-ID: <20051023150933.GB7961@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051023032226.GA6340@us.ibm.com> <435B6C4E.F9215E82@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435B6C4E.F9215E82@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2005 at 02:56:14PM +0400, Oleg Nesterov wrote:
> "Paul E. McKenney" wrote:
> > 
> > Hello!
> > 
> > The following patch combines a bit of redundant code between
> > force_sig_info() and force_sig_specific().  Tested on x86 and ppc64.
> 
> Some minor nitpicks ...
> 
> > +++ linux-2.6.14-rc2-rt7-force_sig/kernel/signal.c      2005-09-29 18:41:07.000000000 -0700
> > @@ -920,8 +920,8 @@ force_sig_info(int sig, struct siginfo *
> >         if (sigismember(&t->blocked, sig) || t->sighand->action[sig-1].sa.sa_handler == SIG_IGN) {
> >                 t->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
> >                 sigdelset(&t->blocked, sig);
> 
> May be it would be more readable to do:
> 
> 	if (handler == SIG_IGN)
> 		handler = SIG_DFL;
> 
> 	if (sigismember(->blocked, sig)) // probably unneeded at all
> 		sigdelset(->blocked, sig);

Seems reasonable to me.

> > -               recalc_sigpending_tsk(t);
> >         }
> > +       recalc_sigpending_tsk(t);
> 
> I never understood why can't we just do:
> 
> 	set_tsk_thread_flag(TIF_SIGPENDING);
> 
> If this signal is not pending yet specific_send_siginfo() will
> set this flag anyway.

My guess is that putting the general logic into recalc_sigpending_tsk()
prevents some bugs that might otherwise show up if someone forgets one
of the conditions that can result in a signal being asserted.  But in
this case, it seems pretty safe.  We really do want to force a signal.
But it is a minor optimization, so I left it as is for now.

> > -       specific_send_sig_info(sig, (void *)2, t);
> > -       spin_unlock_irqrestore(&t->sighand->siglock, flags);
> > +       force_sig_info(sig, (void *)2, t);
> 
> Paul, if you think this patch should go into the -mm tree first,
> could you rediff this patch against -mm ?
> 
> - 	specific_send_sig_info(sig, SEND_SIG_FORCED, t);
> +	force_sig_info(sig, SEND_SIG_FORCED, t);

Some time in -mm would certainly not hurt.  The patch below is against
2.6.14-rc4-mm1, though Andrew asks that they be against a recent Linus
tree (see 5c in http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt).
In any case, "SEND_SIG_FORCED" seems much nicer than "(void *)2".  ;-)

						Thanx, Paul

diff -urpNa -X dontdiff linux-2.6.14-rc4-mm1/kernel/signal.c linux-2.6.14-rc4-mm1-force-sig/kernel/signal.c
--- linux-2.6.14-rc4-mm1/kernel/signal.c	2005-10-23 07:47:05.000000000 -0700
+++ linux-2.6.14-rc4-mm1-force-sig/kernel/signal.c	2005-10-23 08:01:16.000000000 -0700
@@ -889,11 +889,13 @@ force_sig_info(int sig, struct siginfo *
 	int ret;
 
 	spin_lock_irqsave(&t->sighand->siglock, flags);
-	if (sigismember(&t->blocked, sig) || t->sighand->action[sig-1].sa.sa_handler == SIG_IGN) {
+	if (t->sighand->action[sig-1].sa.sa_handler == SIG_IGN) {
 		t->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
+	}
+	if (sigismember(&t->blocked, sig)) {
 		sigdelset(&t->blocked, sig);
-		recalc_sigpending_tsk(t);
 	}
+	recalc_sigpending_tsk(t);
 	ret = specific_send_sig_info(sig, info, t);
 	spin_unlock_irqrestore(&t->sighand->siglock, flags);
 
@@ -903,15 +905,7 @@ force_sig_info(int sig, struct siginfo *
 void
 force_sig_specific(int sig, struct task_struct *t)
 {
-	unsigned long int flags;
-
-	spin_lock_irqsave(&t->sighand->siglock, flags);
-	if (t->sighand->action[sig-1].sa.sa_handler == SIG_IGN)
-		t->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
-	sigdelset(&t->blocked, sig);
-	recalc_sigpending_tsk(t);
-	specific_send_sig_info(sig, SEND_SIG_FORCED, t);
-	spin_unlock_irqrestore(&t->sighand->siglock, flags);
+	force_sig_info(sig, SEND_SIG_FORCED, t);
 }
 
 /*
