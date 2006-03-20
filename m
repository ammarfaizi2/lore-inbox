Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751637AbWCTGJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWCTGJn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 01:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbWCTGJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 01:09:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61601 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751637AbWCTGJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 01:09:42 -0500
Date: Sun, 19 Mar 2006 22:06:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, trini@kernel.crashing.org
Subject: Re: [patch 1/2] sys_alarm() unsigned signed conversion fixup
Message-Id: <20060319220628.711690d4.akpm@osdl.org>
In-Reply-To: <20060319102013.581398000@localhost.localdomain>
References: <20060319102009.817820000@localhost.localdomain>
	<20060319102013.581398000@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> wrote:
>
> 
> alarm() calls the kernel with an unsigend int timeout in seconds.
> The value is stored in the tv_sec field of a struct timeval to
> setup the itimer. The tv_sec field of struct timeval is of type long,
> which causes the tv_sec value to be negative on 32 bit machines if
> seconds > INT_MAX.
> 
> Before the hrtimer merge (pre 2.6.16) such a negative value was
> converted to the maximum jiffies timeout by the timeval_to_jiffies
> conversion. It's not clear whether this was intended or just happened
> to be done by the timeval_to_jiffies code.
> 
> hrtimers expect a timeval in canonical form and treat a negative 
> timeout as already expired. This breaks the legitimate usage of
> alarm() with a timeout value > INT_MAX seconds.
> 
> For 32 bit machines it is therefor necessary to limit the internal 
> seconds value to avoid API breakage. Instead of doing this in all
> implementations of sys_alarm the duplicated sys_alarm code is moved
> into a common function in itimer.c
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
>  arch/ia64/ia32/sys_ia32.c   |   14 +-------------
>  arch/mips/kernel/sysirix.c  |   22 +---------------------
>  arch/x86_64/ia32/sys_ia32.c |   16 ++--------------
>  include/linux/time.h        |    1 +
>  kernel/itimer.c             |   37 +++++++++++++++++++++++++++++++++++++
>  kernel/timer.c              |   14 +-------------
>  6 files changed, 43 insertions(+), 61 deletions(-)

It would have been much better if you'd avoided the temptation to make
sweeping cleanups.  We're trying to get a product out here and there are
good reasons for preferring minimal fixes at this stage.

The non-MIPS changes eyeball out OK.  The MIPS changes are quite unobvious.

A patch which applies cleanups like that would have been rejected out of
hand as a post-2.6.16-rc6 candidate, so why on earth go mixing it up with
important bugfixes?

Sigh.

> +unsigned int alarm_setitimer(unsigned int seconds)
> +{
> +	struct itimerval it_new, it_old;
> +
> +#if BITS_PER_LONG < 64
> +	if (seconds > (INT_MAX >> 1))
> +		seconds = (INT_MAX >> 1);
> +#endif

Why clamp it at INT_MAX/2?   INT_MAX is positive.

