Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbVK0Sd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbVK0Sd4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 13:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVK0Sd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 13:33:56 -0500
Received: from hera.kernel.org ([140.211.167.34]:55686 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751141AbVK0Sdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 13:33:55 -0500
Date: Sun, 27 Nov 2005 10:47:38 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       markus.lidel@shadowconnect.com, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Mark Salyzyn <mark_salyzyn@adaptec.com>
Subject: Re: [patch] drivers/scsi/dpt_i2o.c: fix a NULL pointer dereference
Message-ID: <20051127124738.GC13581@logos.cnet>
References: <20051126233637.GC3988@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051126233637.GC3988@stusta.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2005 at 12:36:37AM +0100, Adrian Bunk wrote:
> The Coverity checker spotted this obvious NULL pointer dereference.

Hi Adrian,

Could you explain why you remove the adpt_post_wait_lock acquision? 

And if it does not belong there, why don't you remove it instead of
commeting out?

> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> Acked-by: Mark Salyzyn <mark_salyzyn@adaptec.com>
> 
> ---
> 
> This patch was already sent on:
> - 23 Nov 2005
> - 21 Nov 2005
> 
>  drivers/scsi/dpt_i2o.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> --- linux-2.6.15-rc1-mm2-full/drivers/scsi/dpt_i2o.c.old	2005-11-20 22:13:37.000000000 +0100
> +++ linux-2.6.15-rc1-mm2-full/drivers/scsi/dpt_i2o.c	2005-11-20 22:16:57.000000000 +0100
> @@ -816,7 +816,7 @@
>  static void adpt_i2o_sys_shutdown(void)
>  {
>  	adpt_hba *pHba, *pNext;
> -	struct adpt_i2o_post_wait_data *p1, *p2;
> +	struct adpt_i2o_post_wait_data *p1, *old;
>  
>  	 printk(KERN_INFO"Shutting down Adaptec I2O controllers.\n");
>  	 printk(KERN_INFO"   This could take a few minutes if there are many devices attached\n");
> @@ -830,13 +830,14 @@
>  	}
>  
>  	/* Remove any timedout entries from the wait queue.  */
> -	p2 = NULL;
>  //	spin_lock_irqsave(&adpt_post_wait_lock, flags);
>  	/* Nothing should be outstanding at this point so just
>  	 * free them 
>  	 */
> -	for(p1 = adpt_post_wait_queue; p1; p2 = p1, p1 = p2->next) {
> -		kfree(p1);
> +	for(p1 = adpt_post_wait_queue; p1;) {
> +		old = p1;
> +		p1 = p1->next;
> +		kfree(old);
>  	}
>  //	spin_unlock_irqrestore(&adpt_post_wait_lock, flags);
>  	adpt_post_wait_queue = NULL;
