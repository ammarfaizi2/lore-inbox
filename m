Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266648AbUIENgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUIENgF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 09:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbUIENgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 09:36:05 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:54402 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266648AbUIENfs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 09:35:48 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 5 Sep 2004 06:35:44 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: "Zach, Yoav" <yoav.zach@intel.com>
cc: Linus Torvalds <torvalds@osdl.org>, Yoav Zach <yoav_zach@yahoo.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: force_sig_info
In-Reply-To: <2C83850C013A2540861D03054B478C06048FFA9D@hasmsx403.ger.corp.intel.com>
Message-ID: <Pine.LNX.4.58.0409050630280.11784@bigblue.dev.mdolabs.com>
References: <2C83850C013A2540861D03054B478C06048FFA9D@hasmsx403.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Sep 2004, Zach, Yoav wrote:

> >-----Original Message-----
> >From: Linus Torvalds [mailto:torvalds@osdl.org] 
> >Sent: Friday, September 03, 2004 21:12
> >To: Yoav Zach
> >Cc: akpm@osdl.org; linux-kernel@vger.kernel.org; Zach, Yoav
> >Subject: Re: force_sig_info
> >
> >
> >Why are you blocking signals that you want to get? Sounds like 
> >a bug in 
> >your program.
> 
> It's a translator - it emulates the behavior of the translated
> 'process', which is the one that sets the signal mask. On the
> other hand, it has its own logic, which requires handling of
> certain HW exceptions. In 2.4, signals that were raised due to
> HW exceptions could be handled by the translator regardless of
> the mask that was set by the translated process. We lost this
> ability in 2.6. It will be very good for our product, and I
> believe any similar product where a native process emulates 
> behavior of another process, if we could have this ability
> back.

Below is the latest patch I posted (applies on some Jun 2004 2.6.x) to 
bring 2.6 back to the 2.4 behaviour, but then it has been decided to leave 
2.6 as is.



- Davide




--- a/kernel/signal.c	2004-06-28 14:28:51.000000000 -0700
+++ b/kernel/signal.c	2004-06-28 14:29:31.000000000 -0700
@@ -820,8 +820,9 @@
 	int ret;
 
 	spin_lock_irqsave(&t->sighand->siglock, flags);
-	if (sigismember(&t->blocked, sig) || t->sighand->action[sig-1].sa.sa_handler == SIG_IGN) {
+	if (t->sighand->action[sig-1].sa.sa_handler == SIG_IGN)
 		t->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
+	if (sigismember(&t->blocked, sig)) {
 		sigdelset(&t->blocked, sig);
 		recalc_sigpending_tsk(t);
 	}
