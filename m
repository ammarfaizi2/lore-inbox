Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbVIWTco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVIWTco (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 15:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVIWTcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 15:32:43 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:63567 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751149AbVIWTcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 15:32:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=PALMsLpCGCrvgfNdFubRez1V6YqpOO6ubuK0LfSzaPdYzhcgPTkgWDJ2yHOQZrqA9ry42tWkGsz4INejmb9sBCMiaMfs4Ml37NvuhaPRn/N+9IXn8rYj/klQgGxnH4Nt+bzN+IdwcyqiqDfNsf9u9k6LGoviKDaeW7D5iAEn1sA=
Date: Fri, 23 Sep 2005 23:42:53 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: tty update speed regression (was: 2.6.14-rc2-mm1)
Message-ID: <20050923194252.GA6460@mipter.zuzino.mipt.ru>
References: <20050921222839.76c53ba1.akpm@osdl.org> <20050922195029.GA6426@mipter.zuzino.mipt.ru> <20050922214926.GA6524@mipter.zuzino.mipt.ru> <20050923000815.GB2973@us.ibm.com> <29495f1d050923101228384a34@mail.gmail.com> <20050923184216.GA6452@mipter.zuzino.mipt.ru> <20050923190749.GO5910@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050923190749.GO5910@us.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 12:07:49PM -0700, Nishanth Aravamudan wrote:
> On 23.09.2005 [22:42:16 +0400], Alexey Dobriyan wrote:
> > poll([{fd=0, events=POLLIN}], 1, 0) = 0

> > I can send full strace log if needed.
> 
> Nope, that helped tremendously! I think I know what the issue is (and
> why it's HZ dependent).
> 
> In the current code, (2.6.13.2, e.g) we allow 0 timeout poll-requests to
> be resolved as 0 jiffy requests. But in my patch, those requests become
> 1 jiffy (which of course depends on HZ and gets quite long if HZ=100)!
> 
> Care to try the following patch?

It works! Now, even with HZ=100, gameplay is smooth.

Andrew, please, apply.

> Description: Modifying sys_poll() to handle large timeouts correctly
> resulted in 0 being treated just like any other millisecond request,
> while the current code treats it as an optimized case. Do the same in
> the new code. Most of the code change is tabbing due to the inserted if.

> diff -urpN 2.6.14-rc2-mm1/fs/select.c 2.6.14-rc2-mm1-dev/fs/select.c
> --- 2.6.14-rc2-mm1/fs/select.c	2005-09-23 11:52:36.000000000 -0700
> +++ 2.6.14-rc2-mm1-dev/fs/select.c	2005-09-23 12:04:03.000000000 -0700
> @@ -485,26 +485,35 @@ asmlinkage long sys_poll(struct pollfd _
>  	if (nfds > max_fdset && nfds > OPEN_MAX)
>  		return -EINVAL;
>  
> -	/*
> -	 * We compare HZ with 1000 to work out which side of the
> -	 * expression needs conversion.  Because we want to avoid
> -	 * converting any value to a numerically higher value, which
> -	 * could overflow.
> -	 */
> +	if (timeout_msecs) {
> +		/*
> +		 * We compare HZ with 1000 to work out which side of the
> +		 * expression needs conversion.  Because we want to
> +		 * avoid converting any value to a numerically higher
> +		 * value, which could overflow.
> +		 */
>  #if HZ > 1000
> -	overflow = timeout_msecs >= jiffies_to_msecs(MAX_SCHEDULE_TIMEOUT);
> +		overflow = timeout_msecs >=
> +				jiffies_to_msecs(MAX_SCHEDULE_TIMEOUT);
>  #else
> -	overflow = msecs_to_jiffies(timeout_msecs) >= MAX_SCHEDULE_TIMEOUT;
> +		overflow = msecs_to_jiffies(timeout_msecs) >=
> +				MAX_SCHEDULE_TIMEOUT;
>  #endif
>  
> -	/*
> -	 * If we would overflow in the conversion or a negative timeout
> -	 * is requested, sleep indefinitely.
> -	 */
> -	if (overflow || timeout_msecs < 0)
> -		timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
> -	else
> -		timeout_jiffies = msecs_to_jiffies(timeout_msecs) + 1;
> +		/*
> +		 * If we would overflow in the conversion or a negative
> +		 * timeout is requested, sleep indefinitely.
> +		 */
> +		if (overflow || timeout_msecs < 0)
> +			timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
> +		else
> +			timeout_jiffies = msecs_to_jiffies(timeout_msecs) + 1;
> +	} else {
> +		/*
> +		 * 0 millisecond requests become 0 jiffy requests
> +		 */
> +		timeout_jiffies = 0;
> +	}
>  
>  	poll_initwait(&table);
>  

