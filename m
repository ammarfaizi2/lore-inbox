Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWEGJg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWEGJg5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 05:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWEGJg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 05:36:57 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:30985 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932108AbWEGJg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 05:36:56 -0400
Date: Sun, 7 May 2006 11:36:40 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Stephen Frost <sfrost@snowman.net>,
       laforge@netfilter.org, netfilter-devel@lists.netfilter.org,
       marcelo@kvack.org
Subject: Re: [PATCH] fix mem-leak in netfilter
Message-ID: <20060507093640.GF11191@w.ods.org>
References: <200605070426.10405.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605070426.10405.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2006 at 04:26:10AM +0200, Jesper Juhl wrote:
> The Coverity checker spotted that we may leak 'hold' in 
> net/ipv4/netfilter/ipt_recent.c::checkentry() when the following
> is true : 
>   if (!curr_table->status_proc) {
>     ...
>     if(!curr_table) {
>     ...
>       return 0;  <-- here we leak.
> Simply moving an existing vfree(hold); up a bit avoids the possible leak.
> 
> 
> (please keep me on CC when replying since I'm not subscribed 
>  to netfilter-devel)
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
>  net/ipv4/netfilter/ipt_recent.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.17-rc3-git12-orig/net/ipv4/netfilter/ipt_recent.c	2006-05-07 03:25:38.000000000 +0200
> +++ linux-2.6.17-rc3-git12/net/ipv4/netfilter/ipt_recent.c	2006-05-07 04:16:26.000000000 +0200
> @@ -821,6 +821,7 @@ checkentry(const char *tablename,
>  	/* Create our proc 'status' entry. */
>  	curr_table->status_proc = create_proc_entry(curr_table->name, ip_list_perms, proc_net_ipt_recent);
>  	if (!curr_table->status_proc) {
> +		vfree(hold);
>  		printk(KERN_INFO RECENT_NAME ": checkentry: unable to allocate for /proc entry.\n");
>  		/* Destroy the created table */
>  		spin_lock_bh(&recent_lock);
> @@ -845,7 +846,6 @@ checkentry(const char *tablename,
>  		spin_unlock_bh(&recent_lock);
>  		vfree(curr_table->time_info);
>  		vfree(curr_table->hash_table);
> -		vfree(hold);
>  		vfree(curr_table->table);
>  		vfree(curr_table);
>  		return 0;

Seems valid for 2.4.32 too. I'm queuing it up for Marcelo.

Regards,
Willy

