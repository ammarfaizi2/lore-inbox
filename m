Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWERG5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWERG5x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 02:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWERG5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 02:57:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65505 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751108AbWERG5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 02:57:53 -0400
Date: Wed, 17 May 2006 23:57:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc subsystem, fix capability checks in kernel
 interface
Message-Id: <20060517235740.757f69a1.akpm@osdl.org>
In-Reply-To: <20060517021156.34cce7c9@inspiron>
References: <20060517021156.34cce7c9@inspiron>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Zummo <alessandro.zummo@towertech.it> wrote:
>
> 
>  Remove CAP_SYS_XXX checks from the in kernel interface. Those
>  functions are meant to be used in-kernel only.
> 
> Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
> ---
>  drivers/rtc/interface.c |   22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
> 
> --- linux-rtc.orig/drivers/rtc/interface.c	2006-05-17 01:18:19.000000000 +0200
> +++ linux-rtc/drivers/rtc/interface.c	2006-05-17 01:41:17.000000000 +0200
> @@ -229,6 +229,9 @@ int rtc_irq_set_state(struct class_devic
>  	unsigned long flags;
>  	struct rtc_device *rtc = to_rtc_device(class_dev);
>  
> +	if (rtc->ops->irq_set_state == NULL)
> +		return -ENXIO;
> +
>  	spin_lock_irqsave(&rtc->irq_task_lock, flags);
>  	if (rtc->irq_task != task)
>  		err = -ENXIO;
> @@ -243,25 +246,12 @@ EXPORT_SYMBOL_GPL(rtc_irq_set_state);
>  
>  int rtc_irq_set_freq(struct class_device *class_dev, struct rtc_task *task, int freq)
>  {
> -	int err = 0, tmp = 0;
> +	int err = 0;
>  	unsigned long flags;
>  	struct rtc_device *rtc = to_rtc_device(class_dev);
>  
> -	/* allowed range is 2-8192 */
> -	if (freq < 2 || freq > 8192)
> -		return -EINVAL;
> -/*
> -	FIXME: this does not belong here, will move where appropriate
> -	at a later stage. It cannot hurt right now, trust me :)
> -	if ((freq > rtc_max_user_freq) && (!capable(CAP_SYS_RESOURCE)))
> -		return -EACCES;
> -*/
> -	/* check if freq is a power of 2 */
> -	while (freq > (1 << tmp))
> -		tmp++;
> -
> -	if (freq != (1 << tmp))
> -		return -EINVAL;
> +	if (rtc->ops->irq_set_freq == NULL)
> +		return -ENXIO;
>  
>  	spin_lock_irqsave(&rtc->irq_task_lock, flags);
>  	if (rtc->irq_task != task)

The changelog and the patch don't have much correlation.

Are you sure this was the right patch?
