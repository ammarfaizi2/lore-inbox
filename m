Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbVK2MR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbVK2MR3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 07:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbVK2MR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 07:17:29 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:38082 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751200AbVK2MR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 07:17:28 -0500
Date: Tue, 29 Nov 2005 13:17:22 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] timer locking optimization
In-Reply-To: <438C5057.A54AFA83@tv-sign.ru>
Message-ID: <Pine.LNX.4.61.0511291311151.1609@scrub.home>
References: <438C5057.A54AFA83@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 29 Nov 2005, Oleg Nesterov wrote:

> > +	base = timer->base;
> > +	spin_lock_irqsave(&base->lock, *flags);
> > +	while (unlikely(base != timer->base)) {
> > +		/* The timer has migrated to another CPU */
> > +		spin_unlock(&base->lock);
> >  		cpu_relax();
> > +		base = timer->base;
> > +		spin_lock(&base->lock);
> 
> This spins with interrupts disabled, not good, imho.

It's the slow path anyway, so restoring flags should indeed be fine.

> This way you can delete the timer (ret == 1), notice that timer's base
> was changed after re-locking, goto restart, and get ret == 0.

ret is only set, but not reset, so if __mod_timer() deleted the timer it 
will return 1.

> Also, you have wrong value of 'base' after 'goto restart'.

Indeed, thanks for spotting this.

bye, Roman
