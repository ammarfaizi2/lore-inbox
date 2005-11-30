Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbVK3IoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbVK3IoY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 03:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVK3IoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 03:44:24 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:12227 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751138AbVK3IoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 03:44:24 -0500
Message-ID: <438D77E5.DCAC8804@tv-sign.ru>
Date: Wed, 30 Nov 2005 12:59:01 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] timer locking optimization
References: <438C5057.A54AFA83@tv-sign.ru> <Pine.LNX.4.61.0511300330130.1609@scrub.home>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> @@ -210,6 +203,7 @@ int __mod_timer(struct timer_list *timer
> 
>         BUG_ON(!timer->function);
> 
> +restart:
>         base = lock_timer_base(timer, &flags);
> 
>         if (timer_pending(timer)) {
> @@ -231,11 +225,18 @@ int __mod_timer(struct timer_list *timer
>                         /* The timer remains on a former base */
>                         new_base = container_of(base, tvec_base_t, t_base);
>                 } else {
> -                       /* See the comment in lock_timer_base() */
> -                       timer->base = NULL;
> +                       /*
> +                        * We shortly release the timer and the timer can
> +                        * migrate to another cpu, so recheck the base after
> +                        * getting the lock.
> +                        */
> +                       timer->base = &new_base->t_base;
>                         spin_unlock(&base->lock);
>                         spin_lock(&new_base->t_base.lock);

Still not correct, I beleive.

The problem is that you are changing timer->base = &new_base->t_base
without holding new_base->t_base.lock, this is racy vs timer_del().
Suppose we are calling __mod_timer(pending_timer):

__mod_timer() locks old base, deletes the timer, changes timer's base,
unlocks old base.

Another cpu calls del_timer(). It is possible that this cpu will
see the new value of ->base == new_base before it sees changes in the
timer->entry. It locks new_base, but this is not enough, because the
timer was removed from list under the old base's lock and we don't
have a proper serialization. So it is possible that del_timer() sees
that the timer is still pending, and will try to delete it again.

In other words, in this scenario __mod_timer() and del_timer() will
take 2 different locks trying to serialize access to common data.

You can solve this with memory barriers, but this will be pessimization,
not optimization (you will also need smp_rmb in lock_timer_base()).

Honestly, personally I don'like this patch even if it was correct.
It complicates the code, and the only win is that it removes
'if (likely(base != NULL))' from the fast path, I doubt this is
noticeable.

Also, __mod_timer() becomes "non atomic", but probably this is ok.

Btw, I think you have the same problems in "[PATCH 2/9] ptimer core".

Oleg.
