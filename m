Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266478AbUAVXsx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 18:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUAVXsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 18:48:52 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:57094 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S266478AbUAVXsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 18:48:51 -0500
Date: Fri, 23 Jan 2004 00:48:33 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Eduard Roccatello <lilo@roccatello.it>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] net/ipv4/tcp.c little cleanup
Message-ID: <20040122234833.GL545@alpha.home.local>
References: <200401222253.37426.lilo@roccatello.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401222253.37426.lilo@roccatello.it>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On Thu, Jan 22, 2004 at 10:53:37PM +0100, Eduard Roccatello wrote:
> Hello,
> i've done a little cleanup to net/ipv4/tcp.c
> 
> I hope it is ok :-)

I haven't looked at sysctl_max_syn_backlog type, but if it's unsigned, there's
a risk of infinite loop for values above 2^31 on 32 bits machines, or 2^63 on
64 bits machine. This is because many processors leave the result undefined
when you shift more bits that the word size. Often, only the lowest bits are
used for the shift count, resulting in a modulo.

Eg, on ia32, if sysctl_max_syn_backlog is >2^31, the test will never work, and
when max_qlen_log becomes 32, it will give the same result as if it were 0.
Another case is if sysctl_max_syn_backlog is above 2^30, and the shift returns
a signed result, because 1<<31 will be negative, thus validating the test and
maintain the loop.

Note that this potential problem is also present in the code you replaced.

Cheers,
Willy

> --- net/ipv4/tcp.c.orig	2004-01-22 22:49:38.000000000 +0100
> +++ net/ipv4/tcp.c	2004-01-22 22:42:38.000000000 +0100
> @@ -549,9 +549,9 @@ int tcp_listen_start(struct sock *sk)
>  	 	return -ENOMEM;
>  
> 	memset(lopt, 0, sizeof(struct tcp_listen_opt));
> -	for (lopt->max_qlen_log = 6; ; lopt->max_qlen_log++)
> -		if ((1 << lopt->max_qlen_log) >= sysctl_max_syn_backlog)
> -			break;
> +	lopt->max_qlen_log = 6;
> +	while (sysctl_max_syn_backlog > (1 << lopt->max_qlen_log))
> +		lopt->max_qlen_log++;
>  	get_random_bytes(&lopt->hash_rnd, 4);
>  
>  	write_lock_bh(&tp->syn_wait_lock);
> 

