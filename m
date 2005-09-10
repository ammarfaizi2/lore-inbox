Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030410AbVIJBU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbVIJBU5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 21:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbVIJBU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 21:20:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41962 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030410AbVIJBU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 21:20:57 -0400
Date: Fri, 9 Sep 2005 18:16:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: dwmw2@infradead.org, bunk@stusta.de, johnstul@us.ibm.com,
       drepper@redhat.com, Franz.Fischer@goyellow.de,
       linux-kernel@vger.kernel.org
Subject: Re: [UPDATE PATCH][Bug 5132] fix sys_poll() large timeout handling
Message-Id: <20050909181658.221eb6f9.akpm@osdl.org>
In-Reply-To: <20050910003525.GC24225@us.ibm.com>
References: <20050831200109.GB3017@us.ibm.com>
	<20050906212514.GB3038@us.ibm.com>
	<20050910003525.GC24225@us.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Aravamudan <nacc@us.ibm.com> wrote:
>
> Description: The current sys_poll() implementation does not seem to
>  handle large timeouts correctly. Any value in milliseconds (@timeout)
>  which exceeds the maximum representable jiffy value
>  (MAX_SCHEDULE_TIMEOUT) should result in a MAX_SCHEDULE_TIMEOUT
>  schedule_timeout() request. To achieve this, convert @timeout to jiffies
>  first, then compare to MAX_SCHEDULE_TIMEOUT.

The above doesn't describe the bug very well.

>  Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> 
>  ---
> 
>   fs/select.c |   17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
>  diff -urpN 2.6.13/fs/select.c 2.6.13-dev/fs/select.c
>  --- 2.6.13/fs/select.c	2005-08-28 17:46:14.000000000 -0700
>  +++ 2.6.13-dev/fs/select.c	2005-09-09 17:22:30.000000000 -0700
>  @@ -469,13 +469,16 @@ asmlinkage long sys_poll(struct pollfd _
>   	if (nfds > current->files->max_fdset && nfds > OPEN_MAX)
>   		return -EINVAL;
>   
>  -	if (timeout) {
>  -		/* Careful about overflow in the intermediate values */
>  -		if ((unsigned long) timeout < MAX_SCHEDULE_TIMEOUT / HZ)

This is the problem to which you're referring, yes?

We're comparing milliseconds with jiffies/HZ, yes?

>  -			timeout = (unsigned long)(timeout*HZ+999)/1000+1;
>  -		else /* Negative or overflow */
>  -			timeout = MAX_SCHEDULE_TIMEOUT;
>  -	}
>  +	if (timeout > 0)
>  +		/*
>  +		 * Convert the value from msecs to jiffies - if overflow
>  +		 * occurs we get a negative value, which gets handled by
>  +		 * the next block
>  +		 */
>  +		timeout = msecs_to_jiffies(timeout) + 1;
>  +	if (timeout < 0) /* Negative requests result in infinite timeouts */
>  +		timeout = MAX_SCHEDULE_TIMEOUT;
>  +	/* 0 case falls through */

I don't particularly like the idea of relying on msecs_to_jiffies(too much)
returning a negative value.

Why can't we do

	int too_much;

	/*
	 * We compare HZ with 1000 to work out which side of the expression
	 * needs conversion.  Because we want to avoid converting any value
	 * to a numerically higher value, which could overflow.
	 */
#if HZ > 1000
	too_much = timeout > jiffies_to_msecs(MAX_SCHEDULE_TIMEOUT);
#else
	too_much = msecs_to_jiffies(timeout) > MAX_SCHEDULE_TIMEOUT;
#endif

	if (too_much)
		timeout = MAX_SCHEDULE_TIMEOUT;

And while we're there, let's stop using the same variable for two different
units - it's horrid.  How about we nuke `timeout' and create timeout_msecs
and timeout_jiffies to show what units they're in?

