Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266292AbTGEHQo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 03:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266294AbTGEHQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 03:16:43 -0400
Received: from [213.39.233.138] ([213.39.233.138]:6374 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S266292AbTGEHQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 03:16:42 -0400
Date: Sat, 5 Jul 2003 09:30:31 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: benh@kernel.crashing.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@lists.linuxppc.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
Message-ID: <20030705073031.GB32363@wohnheim.fh-wedel.de>
References: <20030704201840.GH22152@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0307041725180.1744-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0307041725180.1744-100000@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 July 2003 17:39:01 -0700, Linus Torvalds wrote:
> 
> I think we should just continue to do what we do now - sure, we'll loop on 
> SIGSEGV, but hey, it's a user space bug, it's not the kernels problem. 
> It's better to let people continue to do stupid things than try to force 
> changes.
> 
> So how about something like the appended? Very simple patch,i and in fact 
> it's more logical than the old behaviour (the old behaviour punched 
> through blocked signals, the new ones says "if you block or ignore the 
> signal we will just kill you through the default action").

That seems to be the best solution.  Thanks!

> ---
> --- 1.86/kernel/signal.c	Mon Jun  2 13:37:11 2003
> +++ edited/kernel/signal.c	Fri Jul  4 17:29:43 2003
> @@ -797,10 +797,11 @@
>  	int ret;
>  
>  	spin_lock_irqsave(&t->sighand->siglock, flags);
> -	if (t->sighand->action[sig-1].sa.sa_handler == SIG_IGN)
> +	if (sigismember(&t->blocked, sig) || t->sighand->action[sig-1].sa.sa_handler == SIG_IGN) {
>  		t->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
> -	sigdelset(&t->blocked, sig);
> -	recalc_sigpending_tsk(t);
> +		sigdelset(&t->blocked, sig);
> +		recalc_sigpending_tsk(t);
> +	}
>  	ret = specific_send_sig_info(sig, info, t);
>  	spin_unlock_irqrestore(&t->sighand->siglock, flags);
>  
> 

Jörn

-- 
Simplicity is prerequisite for reliability.
-- Edsger W. Dijkstra
