Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWJ2Mde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWJ2Mde (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 07:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWJ2Mde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 07:33:34 -0500
Received: from postel.suug.ch ([194.88.212.233]:25059 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S932311AbWJ2Mdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 07:33:33 -0500
Date: Sun, 29 Oct 2006 13:33:52 +0100
From: Thomas Graf <tgraf@suug.ch>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Jay Lan <jlan@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] taskstats: fix? sk_buff leak
Message-ID: <20061029123352.GC12964@postel.suug.ch>
References: <20061029132449.GA1142@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061029132449.GA1142@oleg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Oleg Nesterov <oleg@tv-sign.ru> 2006-10-29 16:24
> Compile tested only, and I know nothing about net/. Needs an ack from
> maintainer.
> 
> 'return genlmsg_cancel()' in taskstats_user_cmd/taskstats_exit_send looks
> wrong to me. Unless we pass 'rep_skb' to the netlink layer we own sk_buff,
> yes? This means we should always do kfree_skb() on failure.

That's right.

> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- STATS/kernel/taskstats.c~1_skb	2006-10-29 15:12:51.000000000 +0300
> +++ STATS/kernel/taskstats.c	2006-10-29 16:16:05.000000000 +0300
> @@ -411,7 +411,7 @@ static int taskstats_user_cmd(struct sk_
>  	return send_reply(rep_skb, info->snd_pid);
>  
>  nla_put_failure:
> -	return genlmsg_cancel(rep_skb, reply);
> +	genlmsg_cancel(rep_skb, reply);

rc = genlmsg_cancel(...) or return value is undefined.

>  err:
>  	nlmsg_free(rep_skb);
>  	return rc;
> @@ -507,7 +507,6 @@ send:
>  
>  nla_put_failure:
>  	genlmsg_cancel(rep_skb, reply);
> -	goto ret;
>  err_skb:
>  	nlmsg_free(rep_skb);
>  ret:
> 
