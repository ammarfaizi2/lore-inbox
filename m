Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbVDGXYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbVDGXYJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 19:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbVDGXVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 19:21:11 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:61661 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262605AbVDGXSS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 19:18:18 -0400
Date: Fri, 8 Apr 2005 01:16:53 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, antonb@au1.ibm.com,
       davej@codemonkey.org.uk, hpa@zytor.com, len.brown@intel.com,
       andmike@us.ibm.com, rth@twiddle.net, rusty@au1.ibm.com,
       schwidefsky@de.ibm.com, manfred@colorfullife.com
Subject: Re: [RFC,PATCH 3/4] Change synchronize_kernel to _rcu and _sched
Message-ID: <20050407231653.GA13563@electric-eye.fr.zoreil.com>
References: <20050403063122.GA1692@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050403063122.GA1692@us.ibm.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney <paulmck@us.ibm.com> :
> This patch changes calls to synchronize_kernel(), deprecated in the
> earlier "Deprecate synchronize_kernel, GPL replacement" patch to
> instead call the new synchronize_rcu() and synchronize_sched() APIs.
[...]
> diff -urpN -X dontdiff linux-2.6.12-rc1/drivers/net/r8169.c linux-2.6.12-rc1-bettersk/drivers/net/r8169.c
> --- linux-2.6.12-rc1/drivers/net/r8169.c	Thu Mar 31 09:53:08 2005
> +++ linux-2.6.12-rc1-bettersk/drivers/net/r8169.c	Fri Apr  1 21:41:38 2005
> @@ -2385,7 +2385,7 @@ core_down:
>  	}
>  
>  	/* Give a racing hard_start_xmit a few cycles to complete. */
> -	synchronize_kernel();
> +	synchronize_sched();  /* FIXME: should this be synchronize_irq()? */
>  
>  	/*
>  	 * And now for the 50k$ question: are IRQ disabled or not ?

(answering the FIXME)

The race with the irq is handled somewhere else. As the comment suggests,
this part is racing with the hard_start_xmit() handler. If I read correctly
net/core/dev.c::dev_queue_xmit, the code above simply needs the new
synchronize_rcu().

--
Ueimor
