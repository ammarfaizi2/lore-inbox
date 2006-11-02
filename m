Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752810AbWKBKdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810AbWKBKdn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 05:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752811AbWKBKdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 05:33:42 -0500
Received: from postel.suug.ch ([194.88.212.233]:14778 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S1752810AbWKBKdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 05:33:41 -0500
Date: Thu, 2 Nov 2006 11:34:02 +0100
From: Thomas Graf <tgraf@suug.ch>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Jay Lan <jlan@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] taskstats: factor out reply assembling
Message-ID: <20061102103402.GH12964@postel.suug.ch>
References: <20061101182611.GA447@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101182611.GA447@oleg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Oleg Nesterov <oleg@tv-sign.ru> 2006-11-01 21:26
> Introduce mk_reply() helper which does all nla_put()s on reply.
> 
> Saves 453 bytes and a preparation for the next patch.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
>  taskstats.c |   55 ++++++++++++++++++++++++++++---------------------------
>  1 files changed, 28 insertions(+), 27 deletions(-)
> 
> --- STATS/kernel/taskstats.c~5_factor	2006-10-31 16:33:56.000000000 +0300
> +++ STATS/kernel/taskstats.c	2006-11-01 14:00:03.000000000 +0300
> @@ -348,6 +348,25 @@ static int parse(struct nlattr *na, cpum
>  	return ret;
>  }
>  
> +static int mk_reply(struct sk_buff *skb, int type, u32 pid, struct taskstats *stats)
> +{
> +	struct nlattr *na;
> +	int aggr;
> +
> +	aggr = TASKSTATS_TYPE_AGGR_TGID;
> +	if (type == TASKSTATS_TYPE_PID)
> +		aggr = TASKSTATS_TYPE_AGGR_PID;
> +
> +	na = nla_nest_start(skb, aggr);
> +	NLA_PUT_U32(skb, type, pid);
> +	NLA_PUT_TYPE(skb, struct taskstats, TASKSTATS_TYPE_STATS, *stats);
> +	nla_nest_end(skb, na);
> +
> +	return 0;
> +nla_put_failure:
> +	return -1;
> +}

nla_nest_start() may return NULL, either rely on prepare_reply() to be
correct and BUG() on failure or do proper error handling for all
functions.

