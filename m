Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbVK2Lnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVK2Lnb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 06:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVK2Lnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 06:43:31 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:29648 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751221AbVK2Lna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 06:43:30 -0500
Message-ID: <438C5057.A54AFA83@tv-sign.ru>
Date: Tue, 29 Nov 2005 15:57:59 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] timer locking optimization
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
>
> +	base = timer->base;
> +	spin_lock_irqsave(&base->lock, *flags);
> +	while (unlikely(base != timer->base)) {
> +		/* The timer has migrated to another CPU */
> +		spin_unlock(&base->lock);
>  		cpu_relax();
> +		base = timer->base;
> +		spin_lock(&base->lock);

This spins with interrupts disabled, not good, imho.

>  int __mod_timer(struct timer_list *timer, unsigned long expires)
> @@ -212,6 +207,7 @@ int __mod_timer(struct timer_list *timer
>  
>  	base = lock_timer_base(timer, &flags);
>  
> +restart:
>  	if (timer_pending(timer)) {
>  		detach_timer(timer, 0);
>  		ret = 1;
> @@ -231,11 +227,16 @@ int __mod_timer(struct timer_list *timer
>  			/* The timer remains on a former base */
>  			new_base = container_of(base, tvec_base_t, t_base);
>  		} else {
> -			/* See the comment in lock_timer_base() */
> -			timer->base = NULL;
> +			/*
> +			 * We shortly release the timer and the timer can
> +			 * migrate to another cpu, so recheck the base after
> +			 * getting the lock.
> +			 */
> +			timer->base = &new_base->t_base;
>  			spin_unlock(&base->lock);
>  			spin_lock(&new_base->t_base.lock);
> -			timer->base = &new_base->t_base;
> +			if (unlikely(timer->base != &new_base->t_base))
> +				goto restart;

This is not right.

This way you can delete the timer (ret == 1), notice that timer's base
was changed after re-locking, goto restart, and get ret == 0.

Also, you have wrong value of 'base' after 'goto restart'.

Oleg.
