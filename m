Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264320AbUAENXq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 08:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbUAENXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 08:23:46 -0500
Received: from intra.cyclades.com ([64.186.161.6]:46257 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264320AbUAENXk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 08:23:40 -0500
Date: Mon, 5 Jan 2004 11:23:02 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Erik Andersen <andersen@codepoet.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH] fix broken 2.4.x rt_sigprocmask error handling
In-Reply-To: <20031231114501.GA14865@codepoet.org>
Message-ID: <Pine.LNX.4.58L.0401051112390.1188@logos.cnet>
References: <20031231114501.GA14865@codepoet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 Dec 2003, Erik Andersen wrote:

> SuSv3 says:
>
> 	"The argument 'how' indicates the way in which the set is
> 	changed, and the application shall ensure it consists of
> 	one of [SIG_BLOCK, SIG_UNBLOCK, SIG_SETMASK] ... If
> 	sigprocmask() fails, the thread's signal mask shall not
> 	be changed."
>
> The sigprocmask(2) syscall implements this correctly, however the
> rt_sigprocmask(2) syscall in 2.4.x does not comply with SuSv3.
> When this syscall is provided with a valid 'set' value, and a
> bogus value for 'how', the process signal mask is still changed.
>
> The attached test application demonstrates the problem.  This
> patch below fixes it.  Please apply!
>
>
> --- linux/kernel/signal.c.orig	2003-12-31 04:01:59.000000000 -0700
> +++ linux/kernel/signal.c	2003-12-31 04:38:06.000000000 -0700
> @@ -879,16 +879,16 @@
>  			error = -EINVAL;
>  			break;
>  		case SIG_BLOCK:
> -			sigorsets(&new_set, &old_set, &new_set);
> +			sigorsets(&current->blocked, &old_set, &new_set);
>  			break;
>  		case SIG_UNBLOCK:
> -			signandsets(&new_set, &old_set, &new_set);
> +			signandsets(&current->blocked, &old_set, &new_set);
>  			break;
>  		case SIG_SETMASK:
> +			current->blocked = new_set;
>  			break;
>  		}
>
> -		current->blocked = new_set;
>  		recalc_sigpending(current);
>  		spin_unlock_irq(&current->sigmask_lock);
>  		if (error)

Hi Erik,

For how long the behaviour has been this? It is broken, but its brokenness
is harmless.

Maybe some app rely on this behaviour? (I understand its wrong, but
still).

Is there any major distribution which includes this fix?

Anyway, isnt it easier to move the "if (error)" up like this?

--- signal.c.orig       2004-01-05 11:13:17.000000000 -0200
+++ signal.c    2004-01-05 11:14:09.000000000 -0200
@@ -888,11 +888,12 @@
                        break;
                }

+               if (error)
+                       goto out;
+
                current->blocked = new_set;
                recalc_sigpending(current);
                spin_unlock_irq(&current->sigmask_lock);
-               if (error)
-                       goto out;
                if (oset)
                        goto set_old;
        } else if (oset) {

