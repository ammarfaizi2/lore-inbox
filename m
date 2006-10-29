Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965164AbWJ2MqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbWJ2MqN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 07:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbWJ2MqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 07:46:13 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:16290 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S965164AbWJ2MqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 07:46:13 -0500
Date: Sun, 29 Oct 2006 16:45:58 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Thomas Graf <tgraf@suug.ch>
Cc: Andrew Morton <akpm@osdl.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Jay Lan <jlan@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] taskstats: fix? sk_buff leak
Message-ID: <20061029134557.GA1500@oleg>
References: <20061029132449.GA1142@oleg> <20061029123352.GC12964@postel.suug.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061029123352.GC12964@postel.suug.ch>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29, Thomas Graf wrote:
>
> * Oleg Nesterov <oleg@tv-sign.ru> 2006-10-29 16:24
> >  nla_put_failure:
> > -	return genlmsg_cancel(rep_skb, reply);
> > +	genlmsg_cancel(rep_skb, reply);
> 
> rc = genlmsg_cancel(...) or return value is undefined.

Thanks!

[PATCH] taskstats: fix sk_buff leak

Compile tested.

'return genlmsg_cancel()' in taskstats_user_cmd/taskstats_exit_send looks
wrong to me. Unless we pass 'rep_skb' to the netlink layer we own sk_buff.
This means we should always do kfree_skb() on failure.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- STATS/kernel/taskstats.c~1_skb	2006-10-29 15:12:51.000000000 +0300
+++ STATS/kernel/taskstats.c	2006-10-29 16:39:10.000000000 +0300
@@ -411,7 +411,7 @@ static int taskstats_user_cmd(struct sk_
 	return send_reply(rep_skb, info->snd_pid);
 
 nla_put_failure:
-	return genlmsg_cancel(rep_skb, reply);
+	rc = genlmsg_cancel(rep_skb, reply);
 err:
 	nlmsg_free(rep_skb);
 	return rc;
@@ -507,7 +507,6 @@ send:
 
 nla_put_failure:
 	genlmsg_cancel(rep_skb, reply);
-	goto ret;
 err_skb:
 	nlmsg_free(rep_skb);
 ret:

