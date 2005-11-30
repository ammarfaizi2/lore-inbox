Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbVK3RCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbVK3RCz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 12:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbVK3RCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 12:02:55 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:3763 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751454AbVK3RCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 12:02:54 -0500
Message-ID: <438DECB9.10E846E0@tv-sign.ru>
Date: Wed, 30 Nov 2005 21:17:29 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] timer locking optimization
References: <438C5057.A54AFA83@tv-sign.ru> <Pine.LNX.4.61.0511300330130.1609@scrub.home>
	 <438D77E5.DCAC8804@tv-sign.ru> <Pine.LNX.4.61.0511301436180.1609@scrub.home>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> Hi,
> 
> On Wed, 30 Nov 2005, Oleg Nesterov wrote:
> 
> > Still not correct, I beleive.
> 
> Here is a new idea, what do you think about using spin_trylock(), e.g.
> something like:
> 
>         if (spin_trylock(&new_base->t_base.lock)) {
>                 timer->base = &new_base->t_base;
>                 spin_unlock(&base->lock);
>         } else
>                 new_base = container_of(base, tvec_base_t, t_base);
> 
> It's not like we must start the timer on the current cpu and this might
> even be faster. If the new base is busy on another cpu, it's possible we
> have to pull dirty cache lines from the other cpu, where we might already
> have the data from the current base already in the cache from the detach.

... and this will simplify the code! I think this is a nice idea.
Something like this:

	if (base != &new_base->t_base) {

		if (unlikely(base->running_timer == timer) ||
		    !spin_trylock(&new_base->t_base.lock)) {
			/* The timer remains on a former base */
			new_base = container_of(base, tvec_base_t, t_base);
		} else {
			timer->base = &new_base->t_base;
			spin_unlock(&base->lock);
		}
	}

But please update comments too, and don't forget to cc Ingo and Andrew
at least. In my opinion this patch should go separately from other ptimer
patches.

Oleg.
