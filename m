Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265732AbUA0SrN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 13:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265740AbUA0SrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 13:47:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:28071 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265732AbUA0SrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 13:47:07 -0500
Date: Tue, 27 Jan 2004 10:46:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: George Anzinger <george@mvista.com>
Cc: eric.piel@tremplin-utc.net, minyard@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Incorrect value for SIGRTMAX, MIPS nonsense removed,
 timer_gettime fix
Message-Id: <20040127104648.1e749f5d.akpm@osdl.org>
In-Reply-To: <40162D2D.3030406@mvista.com>
References: <1074979873.4012e421714b1@mailetu.utc.fr>
	<40162D2D.3030406@mvista.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger <george@mvista.com> wrote:
>
> The attached patch does the following:
> 
> Removes C++ comment in favor of C style.
> 
> Removes the special treatment for MIPS SIGEV values.  We only require (and error 
> if this fails) that the SIGEV_THREAD_ID value not share bits with the other 
> SIGEV values.  Note that mips has yet to define this value so when they do...
> 
> Corrects the check for the signal range to be from 1 to SIGRTMAX inclusive.
> 
> Adds a check to verify that kmem_cache_alloc() actually returned a timer, error 
> if not.
> 
> Fixes a bug in timer_gettime() where the incorrect value was returned if a 
> signal was pending on the timer OR the timer was a SIGEV_NONE timer.

> -	if ((event->sigev_notify & ~SIGEV_NONE & MIPS_SIGEV) &&
> -			event->sigev_signo &&
> -			((unsigned) (event->sigev_signo > SIGRTMAX)))
> +	if (((event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE) &&
> +	    ((unsigned int) (event->sigev_signo - 1) >= SIGRTMAX))
>  		return NULL;

I was wondering if someone would try this one :( Really, this is just over
the top.  Take pity upon your readers, and do:

	if (((event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE) &&
		(event->sigev_signo <= 0 || event->sigev_signo > SIGRTMAX))

> @@ -804,7 +826,7 @@
>  	 * equal to jiffies, so the timer notify function is called directly.
>  	 * We do not even queue SIGEV_NONE timers!
>  	 */
> -	if (!(timr->it_sigev_notify & SIGEV_NONE)) {
> +	if (!((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE)) {
>  		if (timr->it_timer.expires == jiffies)
>  			timer_notify_task(timr);
>  		else

Are you sure this is correct?   If so, using != would be clearer.

