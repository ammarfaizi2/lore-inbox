Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVDBK4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVDBK4h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 05:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVDBK4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 05:56:37 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:15015 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261358AbVDBK4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 05:56:31 -0500
Message-ID: <424E7BC9.592007E1@tv-sign.ru>
Date: Sat, 02 Apr 2005 15:02:33 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@elte.hu,
       christoph@lameter.com, kenneth.w.chen@intel.com
Subject: Re: [RFC][PATCH] timers fixes/improvements
References: <424D373F.1BCBF2AC@tv-sign.ru> <20050402020700.16221f6f.akpm@osdl.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Oleg Nesterov <oleg@tv-sign.ru> wrote:
> >
> > +void fastcall init_timer(struct timer_list *timer)
> >  +{
> >  +    timer->entry.next = NULL;
> >  +    timer->_base = &per_cpu(tvec_bases,
> >  +                    __smp_processor_id()).t_base;
> >  +    timer->magic = TIMER_MAGIC;
> >  +}
> 
> __smp_processor_id() is not implemented on all architectures.  I'll switch
> this to _smp_processor_id().

Wow, I did not know.

> It's a rather odd thing which you're doing there.  Why does a
> not-yet-scheduled timer need a ->_base?

Because all locking goes through timer_list->base->lock now.
That is why timer_list->lock can be deleted. The timer is
always locked via loc_timer_base().

timer->base == NULL only temporally when __mod_timer() does
while switching timer's base:
	base = lock_timer_base(timer);
	timer->base = NULL;
	unlock(base->lock);
		// Nobody can use this timer, lock_timer_base()
		// will spin waiting for ->base != 0
	lock(new_base->lock);
	timer->base = new_base;
	unlock(new_base);

So ->base == NULL means that timer itself is locked, not it's
base. That is why __mod_timer() do not need to hold 2 spinlocks
at once.

Oleg.
