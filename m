Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVCGDtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVCGDtb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 22:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVCGDtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 22:49:31 -0500
Received: from fire.osdl.org ([65.172.181.4]:54661 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261491AbVCGDtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 22:49:25 -0500
Date: Sun, 6 Mar 2005 19:47:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: domen@coderock.org
Cc: linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de,
       domen@coderock.org, nacc@us.ibm.com
Subject: Re: [patch 2/8] isdn/capi: replace interruptible_sleep_on() with
 wait_event_interruptible()
Message-Id: <20050306194756.1d24dd0c.akpm@osdl.org>
In-Reply-To: <20050306223803.77C4F1EC90@trashy.coderock.org>
References: <20050306223803.77C4F1EC90@trashy.coderock.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

domen@coderock.org wrote:
>
> 
> 
> Use wait_event_interruptible() instead of the deprecated
> interruptible_sleep_on(). Patch is straight-forward as current sleep is
> conditionally looped. Patch is compile-tested.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> Signed-off-by: Domen Puncer <domen@coderock.org>
> ---
> 
> 
>  kj-domen/drivers/isdn/capi/capi.c |    9 ++-------
>  1 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff -puN drivers/isdn/capi/capi.c~int_sleep_on-drivers_isdn_capi_capi drivers/isdn/capi/capi.c
> --- kj/drivers/isdn/capi/capi.c~int_sleep_on-drivers_isdn_capi_capi	2005-03-05 16:11:36.000000000 +0100
> +++ kj-domen/drivers/isdn/capi/capi.c	2005-03-05 16:11:36.000000000 +0100
> @@ -675,13 +675,8 @@ capi_read(struct file *file, char __user
>  		if (file->f_flags & O_NONBLOCK)
>  			return -EAGAIN;
>  
> -		for (;;) {
> -			interruptible_sleep_on(&cdev->recvwait);
> -			if ((skb = skb_dequeue(&cdev->recvqueue)) != 0)
> -				break;
> -			if (signal_pending(current))
> -				break;
> -		}
> +		wait_event_interruptible(cdev->recvwait,
> +				((skb = skb_dequeue(&cdev->recvqueue)) == 0));
>  		if (skb == 0)
>  			return -ERESTARTNOHAND;
>  	}

hmm, OK.  Putting an expression with side-effect such as this into a macro
which evaluates the expression multiple times is a bit of a worry, but it
appears that everything will work OK.

That being said, I'd prefer that this come in via the ISDN team, after
having been tested please.
