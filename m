Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262740AbVDANqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbVDANqK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 08:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVDANqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 08:46:10 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:10634 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262740AbVDANqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 08:46:05 -0500
Message-ID: <424D5207.3E57CBCA@tv-sign.ru>
Date: Fri, 01 Apr 2005 17:52:07 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] timers fixes/improvements
References: <424D373F.1BCBF2AC@tv-sign.ru> <424D37B2.2CE24C67@tv-sign.ru> <20050401130713.GA3802@elte.hu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> * Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
> > struct timer_list {
> > 	...
> > 	timer_base_t *_base;
> > };
>
> namespace cleanliness: i'd suggest s/_base/base.

I deliberately renamed it to '_base' because then it is much more grepable.
But I don't mind doing s/_base/base/ if you prefer.

> > int __mod_timer(struct timer_list *timer, unsigned long expires)
> [...]
> > 		/* Ensure the timer is serialized. */
> > 		if (base != &new_base->t_base
> > 			&& base->running_timer == timer)
> > 			goto unlock;
>
> > unlock:
> > 		spin_unlock_irqrestore(&base->lock, flags);
> > 	} while (ret < 0);
>
> so we keep looping in __mod_timer() when the timer is running? Couldnt
> this be a performance hit?

I hope it is unlikely that __mod_timer() would hit the already running timer,
so hopefully this will not degrade the performance. And I don't see a simple
alternative to ensure the timer's serialization. At least it spins without
interrupts disabling.

Oleg.
