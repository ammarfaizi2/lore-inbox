Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262721AbVDALyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbVDALyy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 06:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbVDALyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 06:54:46 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:58240 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262721AbVDALxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 06:53:44 -0500
Message-ID: <424D37B2.2CE24C67@tv-sign.ru>
Date: Fri, 01 Apr 2005 15:59:46 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Lameter <christoph@lameter.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] timers fixes/improvements
References: <424D373F.1BCBF2AC@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here it is code snippets for easier review.

typedef struct timer_base_s {
	spinlock_t lock;
	struct timer_list *running_timer;
} timer_base_t;

struct tvec_t_base_s {
	timer_base_t t_base;
	...
} tvec_bases[];

struct timer_list {
	...
	timer_base_t *_base;
};

int timer_pending(struct timer_list * timer)
{
	return timer->entry.next != NULL;
}

void init_timer(struct timer_list *timer)
{
	timer->entry.next = NULL;
	timer->_base = &per_cpu(tvec_bases).t_base;
}

timer_base_t *lock_timer_base(struct timer_list *timer, unsigned long *flags)
{
	for (;;) {
		timer_base_t *base = timer->_base;
		if (base != NULL) {
			spin_lock_irqsave(&base->lock, *flags);
			if (base == timer->_base)
				return base;
			spin_unlock_irqrestore(&base->lock, *flags);
		}
	}
}

int __mod_timer(struct timer_list *timer, unsigned long expires)
{
	timer_base_t *base;
	tvec_base_t *new_base;
	int ret = -1;

	do {
		base = lock_timer_base(timer, &flags);
		new_base = &__get_cpu_var(tvec_bases);

		/* Ensure the timer is serialized. */
		if (base != &new_base->t_base
			&& base->running_timer == timer)
			goto unlock;

		ret = 0;
		if (timer_pending(timer)) {
			__list_del(timer->entry);
			ret = 1;
		}

		if (base != &new_base->t_base) {
			timer->_base = NULL;
			spin_unlock(&base->lock);
			base = &new_base->t_base;
			spin_lock(&base->lock);
			timer->_base = base;
		}

		timer->expires = expires;
		internal_add_timer(new_base, timer);
unlock:
		spin_unlock_irqrestore(&base->lock, flags);
	} while (ret < 0);

	return ret;
}

void detach_timer(struct timer_list *timer)
{
	__list_del(timer->entry);
	entry->next = NULL;
}

int del_timer(struct timer_list *timer)
{
	int ret = 0;

	if (timer_pending(timer)) {
		timer_base_t *base = lock_timer_base(timer);
		if (timer_pending(timer)) {
			detach_timer(timer);
			ret = 1;
		}
		spin_unlock_irqrestore(&base->lock, flags);
	}

	return ret;
}

int del_timer_sync(struct timer_list *timer)
{
	int ret = -1;

	do {
		timer_base_t *base = lock_timer_base(timer);

		if (base->running_timer == timer)
			goto unlock;

		ret = 0;
		if (timer_pending(timer)) {
			detach_timer(timer);
			ret = 1;
		}
unlock:
		spin_unlock_irqrestore(&base->lock, flags);
	} while (ret < 0);

	return ret;
}

void __run_timers(tvec_base_t *base)
{
	spin_lock_irq(&base->t_base.lock);

	for_each_expired_timer(timer) {
		base->t_base.running_timer = timer;
		detach_timer(timer);
		spin_unlock(&base->t_base.lock);
		timer->function(data);
		spin_lock(&base->t_base.lock);
	}
}
