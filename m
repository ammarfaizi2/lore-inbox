Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263560AbTHZJ0k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 05:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263557AbTHZJ0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 05:26:40 -0400
Received: from us02smtp1.synopsys.com ([198.182.60.75]:22445 "EHLO
	vaxjo.synopsys.com") by vger.kernel.org with ESMTP id S263560AbTHZJ0j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 05:26:39 -0400
Date: Tue, 26 Aug 2003 11:26:31 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@zip.com.au, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Futex minor fixes
Message-ID: <20030826092631.GN16080@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	akpm@zip.com.au, mingo@redhat.com, linux-kernel@vger.kernel.org
References: <20030826031939.F1D762C0FA@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826031939.F1D762C0FA@lists.samba.org>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell, Tue, Aug 26, 2003 05:05:56 +0200:
> Hi Andrew, Ingo,
> 
> 	This was posted before, but dropped.
> 
> Name: Minor futex comment tweaks and cleanups
> Author: Rusty Russell
> Status: Tested on 2.6.0-test4-bk2
> 
> D: Changes:
> D: 
> D: (1) don't return 0 from futex_wait if we are somehow
> D: spuriously woken up, return -EINTR on any such case,

But the code below does not mean there actually was a signal,
unless I'm missing something.

> -	if (time == 0) {
> -		ret = -ETIMEDOUT;
> -		goto out;
> -	}
> -	if (signal_pending(current))
> -		ret = -EINTR;
> -out:
> -	/* Were we woken up anyway? */
> +
> +	/* Were we woken up (and removed from queue)?  Always return
> +	 * success when this happens. */
>  	if (!unqueue_me(&q))
>  		ret = 0;
> +	else if (time == 0)
> +		ret = -ETIMEDOUT;
> +	else
> +		ret = -EINTR;
> +

Here. EINTR is often (if not always) assumed to be caused by a signal.
And someone may rightfully depend on it being that way.

-alex

