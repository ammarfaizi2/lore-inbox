Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269714AbUICOBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269714AbUICOBw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 10:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269701AbUICN71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 09:59:27 -0400
Received: from web50610.mail.yahoo.com ([206.190.38.249]:9375 "HELO
	web50610.mail.yahoo.com") by vger.kernel.org with SMTP
	id S269703AbUICN6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 09:58:35 -0400
Message-ID: <20040903135835.96953.qmail@web50610.mail.yahoo.com>
Date: Fri, 3 Sep 2004 06:58:35 -0700 (PDT)
From: Yoav Zach <yoav_zach@yahoo.com>
Subject: force_sig_info
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, yoav.zach@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The behavior of force_sig_info has changed in kernel 2.6 in
a way that affects very badly our product - in case the user
blocks a signal that must be delivered, the disposition of
the signal is changed to SIG_DFL.
The product that my team is working on is a binary translator
of 32 bit binaries for IPF platforms. We have hard time
juggling between signals that are meant for the translated
process and signals that are meant for the translator, but
till now we managed to let the kernel handle the signal mask.
The new behavior enforces us to handle the signal mask in the
translator, which might have severe implications on performance.
There was a mailing thread about this matter, so apparently,
we're not the only ones who suffer from this change. There
was even a patch that was proposed to make things easier for
existing apps that break because of this change, but somehow,
the thread was cut and I could not see the response to the
proposed patch. Does anyone know the reasons why this patch
did not make it upstream ?

Here is the patch -
=============================================================
--- kernel/signal.c.orig	2004-09-02 00:43:18.751695391 +0800
+++ kernel/signal.c	2004-09-02 00:45:11.815170569 +0800
@@ -822,7 +822,8 @@ force_sig_info(int sig, struct siginfo *
 
 	spin_lock_irqsave(&t->sighand->siglock, flags);
 	if (sigismember(&t->blocked, sig) || t->sighand->action[sig-1].sa.sa_handler == SIG_IGN) {
-		t->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
+		if (t->sighand->action[sig-1].sa.sa_handler == SIG_IGN)
+			t->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 		sigdelset(&t->blocked, sig);
 		recalc_sigpending_tsk(t);
 	}
=============================================================

Thanks,
Yoav.

Yoav Zach
IA-32 Execution Layer
Performance Tools Lab
Intel Corp.



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
