Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWJASBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWJASBo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 14:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWJASBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 14:01:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35303 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932143AbWJASBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 14:01:43 -0400
Date: Sun, 1 Oct 2006 11:01:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: dwmw2@infradead.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kauditd thread API fixes
Message-Id: <20061001110128.bb98fd96.akpm@osdl.org>
In-Reply-To: <20061001123045.GA29682@havoc.gtf.org>
References: <20061001123045.GA29682@havoc.gtf.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Oct 2006 08:30:45 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> 
> Kill the "function should return a value" warning, and use the standard
> mechanism for deciding when a thread should stop.
> 
> Signed-off-by: Jeff Garzik <jeff@garzik.org>
> 
> ---
> 
> Given the security-sensitive nature of the audit function, _perhaps_ the
> omission of kthread_should_stop() was intentional.  If so, it at least
> deserves a comment.  But I think this is more correct.
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index f9889ee..b9146b1 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -340,7 +340,7 @@ static int kauditd_thread(void *dummy)
>  {
>  	struct sk_buff *skb;
>  
> -	while (1) {
> +	do {
>  		skb = skb_dequeue(&audit_skb_queue);
>  		wake_up(&audit_backlog_wait);
>  		if (skb) {
> @@ -368,7 +368,9 @@ static int kauditd_thread(void *dummy)
>  			__set_current_state(TASK_RUNNING);
>  			remove_wait_queue(&kauditd_wait, &wait);
>  		}
> -	}
> +	} while (!kthread_should_stop());
> +
> +	return 0;
>  }
>  
>  int audit_send_list(void *_dest)

I've had a basically-identical patch in -mm for a few months.  Sent to viro once
or twice, nothing happened, gave up.  I'll re-add it to the
maintainer-spamming-list.
