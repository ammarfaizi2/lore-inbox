Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbVJWKnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbVJWKnH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 06:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbVJWKnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 06:43:07 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:10733 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751446AbVJWKnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 06:43:06 -0400
Message-ID: <435B6C4E.F9215E82@tv-sign.ru>
Date: Sun, 23 Oct 2005 14:56:14 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu,
       dipankar@in.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Remove duplicate code in signal.c
References: <20051023032226.GA6340@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" wrote:
> 
> Hello!
> 
> The following patch combines a bit of redundant code between
> force_sig_info() and force_sig_specific().  Tested on x86 and ppc64.

Some minor nitpicks ...

> +++ linux-2.6.14-rc2-rt7-force_sig/kernel/signal.c      2005-09-29 18:41:07.000000000 -0700
> @@ -920,8 +920,8 @@ force_sig_info(int sig, struct siginfo *
>         if (sigismember(&t->blocked, sig) || t->sighand->action[sig-1].sa.sa_handler == SIG_IGN) {
>                 t->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
>                 sigdelset(&t->blocked, sig);

May be it would be more readable to do:

	if (handler == SIG_IGN)
		handler = SIG_DFL;

	if (sigismember(->blocked, sig)) // probably unneeded at all
		sigdelset(->blocked, sig);

> -               recalc_sigpending_tsk(t);
>         }
> +       recalc_sigpending_tsk(t);

I never understood why can't we just do:

	set_tsk_thread_flag(TIF_SIGPENDING);

If this signal is not pending yet specific_send_siginfo() will
set this flag anyway.

> -       specific_send_sig_info(sig, (void *)2, t);
> -       spin_unlock_irqrestore(&t->sighand->siglock, flags);
> +       force_sig_info(sig, (void *)2, t);

Paul, if you think this patch should go into the -mm tree first,
could you rediff this patch against -mm ?

- 	specific_send_sig_info(sig, SEND_SIG_FORCED, t);
+	force_sig_info(sig, SEND_SIG_FORCED, t);

Oleg.
