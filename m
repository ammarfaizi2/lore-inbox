Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbUAEN4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 08:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbUAEN4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 08:56:37 -0500
Received: from codepoet.org ([166.70.99.138]:60806 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S264258AbUAEN4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 08:56:32 -0500
Date: Mon, 5 Jan 2004 06:56:33 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix broken 2.4.x rt_sigprocmask error handling
Message-ID: <20040105135632.GA26836@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20031231114501.GA14865@codepoet.org> <Pine.LNX.4.58L.0401051112390.1188@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0401051112390.1188@logos.cnet>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jan 05, 2004 at 11:23:02AM -0200, Marcelo Tosatti wrote:
> Hi Erik,
> 
> For how long the behaviour has been this? It is broken, but its brokenness
> is harmless.

Not sure really.  It is correct in 2.2.x, and 2.6.x, but is
wrong in all 2.4.x kernels starting with 2.4.0, but I havn't
bothered finding exactly which kernel broke things.

> Maybe some app rely on this behaviour? (I understand its wrong, but
> still).
> 
> Is there any major distribution which includes this fix?

I highly doubt anything relies on this.  Glibc checks for this
case before the syscall is made.  I found the bug while running
some the ltp testsuite on uClibc.  I have since added a check to
workaround the bug. but I would prefer to have it fixed properly
in the kernel.

> Anyway, isnt it easier to move the "if (error)" up like this?
> 
> --- signal.c.orig       2004-01-05 11:13:17.000000000 -0200
> +++ signal.c    2004-01-05 11:14:09.000000000 -0200
> @@ -888,11 +888,12 @@
>                         break;
>                 }
> 
> +               if (error)
> +                       goto out;
> +
>                 current->blocked = new_set;
>                 recalc_sigpending(current);
>                 spin_unlock_irq(&current->sigmask_lock);
> -               if (error)
> -                       goto out;
>                 if (oset)
>                         goto set_old;
>         } else if (oset) {

Only if you plan to ignore the locked spinlock.  :-)
The 2.2.x code does this:

	-current->blocked = new_set;
	+if (!error)
	    current->blocked = new_set;

I condiered that, but I thought it better to make the code 
more closely match 2.6, which looked a bit nicer.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
